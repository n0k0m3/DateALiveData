local KsResCollectPopView = class("KsResCollectPopView",BaseLayer)

function KsResCollectPopView:initData(data)
    self.data = data
    self.maxCount = self.data.serverData.resCount
    for mulriple, costData in pairs(data.multipleCost) do
        self.mulriple = mulriple
        for costId ,costNum in pairs(costData) do
            self.costId = costId
            self.costNum = costNum
        end
    end

    self.selectNum = 1
end

function KsResCollectPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.ksResCollectPopView")
end

function KsResCollectPopView:initUI(ui)
    self.super.initUI(self, ui)

    self.itemView = UIListView:create(self._ui.itemView)
    self.itemView:setItemsMargin(25)

    self:initView()
    self:reFreshLabTxt()
    self._ui.labLastNum:setText(self.maxCount)
    local exchangeCfg =  GoodsDataMgr:getItemCfg(self.costId)
    self._ui.imgIcon:setTexture(exchangeCfg.icon)
    self._ui.imgIcon:setSize(CCSizeMake(45,45))
end

function KsResCollectPopView:registerEvents()
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
        ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_CITY_RESOURCE(self.data.id,self.selectNum,self.mulriple)
        AlertManager:closeLayer(self)
    end)
end

function KsResCollectPopView:holdDownAction(isAddOp)
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

function KsResCollectPopView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function KsResCollectPopView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function KsResCollectPopView:updateBatchPanel(num)

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

function KsResCollectPopView:reFreshLabTxt()
    self._ui.Label_num:setText(self.selectNum)
    self._ui.labIconNum:setText(self.selectNum * self.costNum)
end

function KsResCollectPopView:initView()
    self.itemView:removeAllItems()
    self._cfg = {}
    for key, value in pairs(self.data.resourceCount) do
        table.insert(self._cfg, {key,value})
    end
    for i = 1, #self._cfg do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:setScale(0.7)
        PrefabDataMgr:setInfo(goods, self._cfg[i][1], self._cfg[i][2] * self.mulriple)
        self.itemView:pushBackCustomItem(goods)
    end
    if #self._cfg < 4 then
        Utils:setAliginCenterByListView(self.itemView,true)
    end
end

function KsResCollectPopView:refreshItemNums()
    for i, item in ipairs(self.itemView:getItems()) do
        local cfg = self._cfg[i]
        if cfg then
            PrefabDataMgr:setInfo(item,cfg[1], cfg[2] * self.mulriple * self.selectNum)
        end
    end
end

return KsResCollectPopView