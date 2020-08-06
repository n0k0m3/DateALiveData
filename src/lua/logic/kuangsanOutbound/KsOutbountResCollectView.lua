local KsOutbountResCollectView = class("KsOutbountResCollectView",BaseLayer)

function KsOutbountResCollectView:initData()
    -- config
    self.cfgs = {}
    for i, v in ipairs(TabDataMgr:getData("KurumiCity")) do
        if v.isCollect then
            v.serverData = {resCount = 0} -- 保存对应城市的服务器数据
            table.insert(self.cfgs, v)
        end
    end

    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId).historyInfo
    -- dump(activityInfo)
    -- Box("activityInfo")
    for i,data in ipairs(activityInfo.cities) do
        if data.resOpen then
            for _, v in ipairs(self.cfgs) do
                if v.id == data.id then
                    v.serverData = data
                end
            end
        end
    end
    
    table.sort(self.cfgs, function(a,b)
        local isLockA = a.serverData.resCount > 0
        local isLockB = b.serverData.resCount > 0
        local isFullA = a.serverData.resCount >= a.collectLimit
        local isFullB = b.serverData.resCount >= b.collectLimit

        if isFullA == isFullB then
            if isLockA == isLockB then
                return a.id < b.id
            elseif isLockA then
                return true
            elseif isLockB then
                return false
            end
        elseif isFullA then
            return true
        elseif isFullB then
            return false
        end

        return false
    end)
end

function KsOutbountResCollectView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.ksOutBountResCollectView")
end

function KsOutbountResCollectView:initUI(ui)
    self.super.initUI(self, ui)

    self.collectView = UIListView:create(self._ui.collectView)
    self.collectView:setItemsMargin(5)

    self.collectItems = {}
    self:refreshView()
end

function KsOutbountResCollectView:registerEvents()
    self._ui.btnClose:onClick(function()
        self:removeTimer()
        AlertManager:closeLayer(self)
    end)

    self._ui.btnCollectAll:onClick(function()
        if self.isCanGetAward then
            ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_CITY_RESOURCE(0,0,1)
            self.isCanGetAward = false
        else
            Utils:showTips(12032040)
        end
    end)

    EventMgr:addEventListener(self, EV_KUANGSAN_FUBEN_CITYRSP, function()
        self:initData()
        self:refreshView()
    end)
end

function KsOutbountResCollectView:addCollectItem()
    
    local collectItem = self._ui.item:clone()
    local tab = {}
    tab.allGoods = {}
    tab.root = collectItem
    tab.bg = TFDirector:getChildByPath(collectItem,"bg")
    tab.bgLock = TFDirector:getChildByPath(collectItem,"bgLock")
    tab.labResName = TFDirector:getChildByPath(collectItem,"labResName")
    tab.imgResIcon = TFDirector:getChildByPath(collectItem,"imgResIcon")
    tab.disLock = TFDirector:getChildByPath(collectItem,"disLock")
    tab.locing = TFDirector:getChildByPath(collectItem,"locing")
    tab.goods = TFDirector:getChildByPath(collectItem,"goods")

    for i = 1, 3 do
        local foo = {}
        foo.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.goodsItem:setScale(0.5)
        foo.goodsItem:AddTo(tab.goods:getChildByName(string.format("pos%d",i))):Pos(0,0):ZO(1)
        tab.allGoods[i] = foo
    end
    self.collectItems[tab.root] = tab
    return collectItem
end

function KsOutbountResCollectView:refreshView()
    self:removeTimer()
    local items = self.collectView:getItems()
    local gap = #self.cfgs - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local collectItem = self:addCollectItem()
            collectItem:setName("collectItem"..i)
            self.collectView:pushBackCustomItem(collectItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.collectView:removeItem(1)
        end
    end

    for i, v in ipairs(self.collectView:getItems()) do
        local cfg = self.cfgs[i]
        local item = self.collectItems[v]
        local btnUp = TFDirector:getChildByPath(item.disLock,"pannelBtns.btnUp")
        local collectBtn = TFDirector:getChildByPath(item.disLock,"pannelBtns.btnCollect")
        local imgTimeDi = TFDirector:getChildByPath(item.disLock,"pannelDesc.imgTimeDi")
        local time = TFDirector:getChildByPath(imgTimeDi,"labLastTime")
        local labLockDesc = TFDirector:getChildByPath(item.locing,"pannelLock.labLockDesc")
        local labCollectNum = TFDirector:getChildByPath(item.disLock,"pannelDesc.labCollectNum")

        item.labResName:setTextById(cfg.name)
        labLockDesc:setTextById(12032019)
        item.imgResIcon:setTexture(cfg.cityIcon)
        
        local function updateTime()
            local remainTime = math.max(0, cfg.serverData.resUpTime - ServerDataMgr:getServerTime())
            if remainTime == 0 then
                if item.timer then
                    TFDirector:removeTimer(item.timer)
                    item.timer = nil
                    time:setText("00:00:00")
                    -- self:initData()
                    -- self:refreshView()
                end
            end
            local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
            time:setTextById(800026,hour, min, sec)
        end

        local function isCanCollectUI(_bool)
            item.bg:setTexture("ui/activity/kuangsan_fuben/pop/027.png")
            item.disLock:show()
            item.locing:hide()
            collectBtn:setTouchEnabled(_bool)
            btnUp:setTouchEnabled(_bool)
            -- imgTimeDi:setVisible(not _bool)
            btnUp:setVisible(_bool)
            collectBtn:setVisible(_bool)
            labCollectNum:setText(cfg.serverData.resCount.."/"..cfg.collectLimit)
            if not item.timer and cfg.serverData.resUpTime > 0 then
                item.timer = TFDirector:addTimer(1000, -1, nil, handler(updateTime, self))
            end
        end
        
        if cfg.serverData.resOpen and  cfg.serverData.resCount > 0 then -- 可收集倒计时中
            isCanCollectUI(true)
            self.isCanGetAward = true
        elseif cfg.serverData.resOpen and cfg.serverData.resCount == 0 then -- 不可收集倒计时中
            isCanCollectUI(false)
        else -- 未解锁
            item.bg:setTexture("ui/activity/kuangsan_fuben/pop/026.png")
            item.disLock:hide()
            item.locing:show()
        end

        item.bgLock:setVisible(item.locing:isVisible())

        collectBtn:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_REQ_KURUMI_CITY_RESOURCE(cfg.id,cfg.serverData.resCount,1)
        end)
        btnUp:onClick(function()
            Utils:openView("kuangsanOutbound.KsResCollectPopView",cfg)
        end)

        local _cfg = {}
        for _id, _value in pairs(cfg.resourceCount) do
            table.insert(_cfg, {id = _id,value = _value})
        end
        for i, award in ipairs(item.allGoods) do
            if _cfg[i] then
                PrefabDataMgr:setInfo(award.goodsItem, _cfg[i].id, _cfg[i].value)
                award.goodsItem:show()
            else
                award.goodsItem:hide()
            end
        end 
    end
end

function KsOutbountResCollectView:removeTimer()
    for i, v in pairs(self.collectItems) do
        if v.timer then
            TFDirector:removeTimer(v.timer)
            v.timer = nil
        end
    end
end

function KsOutbountResCollectView:removeEvents()
    self:removeTimer()
end

return KsOutbountResCollectView