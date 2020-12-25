local LinkageHwxCollectView = class("LinkageHwxCollectView",BaseLayer)

function LinkageHwxCollectView:initData(data,cfgCity)
    self.data = data
    self.cfgCity = cfgCity
    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HWX_FUBEN)
    if activityIds and activityIds[1] then
        self.activityNewYear = ActivityDataMgr2:getActivityInfo(activityIds[1])
    end
    self.maxCount = self.data.resCount or 0

    for mulriple, costData in pairs(self.activityNewYear.extendData.collectDouble) do
        self.mulriple = tonumber(mulriple)
        for costId ,costNum in pairs(costData) do
            self.costId = tonumber(costId)
            self.costNum = tonumber(costNum)
        end
    end
    self.ownNum = GoodsDataMgr:getItemCount(self.costId)

    self.selectNum = self.maxCount ~= 0 and 1 or 0

end

function LinkageHwxCollectView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.linkageHwx.linkageHwxResCollectView")
end

function LinkageHwxCollectView:initUI(ui)
    self.super.initUI(self, ui)

    self.itemView = UIListView:create(self._ui.itemView)
    self.itemView:setItemsMargin(40)

    self:initView()
    if self.maxCount < 1 then
        self.selectNum = 0
        self._ui.btnUse:setTouchEnabled(false)
        self._ui.btnUse:setGrayEnabled(true)
        self._ui.btn_double:setTouchEnabled(false)
        self._ui.btn_double:setGrayEnabled(true)
    end
    self:reFreshLabTxt()
    self._ui.labLastNum:setText(self.maxCount)
    local exchangeCfg =  GoodsDataMgr:getItemCfg(self.costId)
    self._ui.imgIcon:setTexture(exchangeCfg.icon)
    self._ui.imgIcon:setSize(CCSizeMake(45,45))
end

function LinkageHwxCollectView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function LinkageHwxCollectView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function LinkageHwxCollectView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function LinkageHwxCollectView:updateBatchPanel(num)

    self.selectNum = self.selectNum + num;
    if self.selectNum <= 1 then
        self.selectNum = 1
    end
    if self.selectNum >= self.maxCount then
        self.selectNum = self.maxCount
    end
    self:reFreshLabTxt()
    self:refreshItemNums()
end

function LinkageHwxCollectView:reFreshLabTxt()
    self._ui.Label_num:setText(self.selectNum)
    self._ui.labIconNum:setText(self.selectNum * self.costNum.."/"..self.ownNum)
    if self.selectNum * self.costNum > self.ownNum then
        self._ui.labIconNum:setColor(ccc3(255, 0, 0))
        self._ui.btn_double:setTouchEnabled(false)
        self._ui.btn_double:setGrayEnabled(true)
    else
        self._ui.labIconNum:setColor(ccc3(255, 255, 255))
        self._ui.btn_double:setTouchEnabled(true)
        self._ui.btn_double:setGrayEnabled(false)
    end
end

function LinkageHwxCollectView:initView()
    self.itemView:removeAllItems()
    self._itemCfgs = {}
    for key, value in pairs(self.activityNewYear.extendData.collectItem) do
        table.insert(self._itemCfgs, {tonumber(key),value})
    end
    for i = 1, #self._itemCfgs do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        --goods:setScale(0.7)
        PrefabDataMgr:setInfo(goods, self._itemCfgs[i][1], self._itemCfgs[i][2]*self.selectNum)
        self.itemView:pushBackCustomItem(goods)
    end
    if #self._itemCfgs < 4 then
        Utils:setAliginCenterByListView(self.itemView,true)
    end
end

function LinkageHwxCollectView:refreshItemNums()
    for i, item in ipairs(self.itemView:getItems()) do
        local cfg = self._itemCfgs[i]
        if cfg then
            PrefabDataMgr:setInfo(item,cfg[1], cfg[2] * self.selectNum)
        end
    end
end

function LinkageHwxCollectView:registerEvents()
    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self._ui.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self._ui.Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self._ui.Button_max:onClick(function()
        self:updateBatchPanel(self.maxCount)
    end)

    self._ui.btnUse:onClick(function()
        LinkageHwxDataMgr:Send_getResource(self.cfgCity.id,self.selectNum,1)
        AlertManager:closeLayer(self)
    end)

    self._ui.btn_double:onClick(function()
        if self.maxCount < 1 then
            Utils:showTips("累计领取次数不足")
            return
        end
        LinkageHwxDataMgr:Send_getResource(self.cfgCity.id,self.selectNum,self.mulriple)
        AlertManager:closeLayer(self)
    end)
end


return LinkageHwxCollectView