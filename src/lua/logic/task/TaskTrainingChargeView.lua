local TaskTrainingChargeView = class("TaskTrainingChargeView", BaseLayer)

function TaskTrainingChargeView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.task.taskTrainingChargeView")
end

function TaskTrainingChargeView:initData()
    
end

function TaskTrainingChargeView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_up = TFDirector:getChildByPath(self.ui, "Panel_up")
    self.Panel_down = TFDirector:getChildByPath(self.ui, "Panel_down")
    self.Button_buy1 = TFDirector:getChildByPath(self.ui, "Button_buy1")
    self.Label_buy1 = TFDirector:getChildByPath(self.Button_buy1, "Label_buy1")
    self.Label_price1 = TFDirector:getChildByPath(self.Button_buy1, "Label_price1")
    self.Label_desc1 = TFDirector:getChildByPath(self.ui, "Label_desc1")
    self.Panel_goodsItem = TFDirector:getChildByPath(self.ui, "Panel_goodsItem")
    
    self.Button_buy2 = TFDirector:getChildByPath(self.ui, "Button_buy2")
    self.Label_buy2 = TFDirector:getChildByPath(self.Button_buy2, "Label_buy2")
    self.Label_price2 = TFDirector:getChildByPath(self.Button_buy2, "Label_price2")
    self.Label_desc2 = TFDirector:getChildByPath(self.ui, "Label_desc2")

    self.ListView_left = UIListView:create(TFDirector:getChildByPath(self.ui, "ScrollView_left"))
    self.ListView_left:setItemsMargin(20)
    self.ListView_right = UIListView:create(TFDirector:getChildByPath(self.ui, "ScrollView_right"))
    self.ListView_right:setItemsMargin(20)

    self:refreshUI()
end

function TaskTrainingChargeView:refreshUI()
    

    local state = ActivityDataMgr2:getWarOrderChargeState()
    self.Button_buy1:setVisible(true)
    self.Button_buy2:setVisible(true)
    self.Label_buy1:setTextById(111000115)
    self.Label_buy2:setTextById(111000115)
    self.Button_buy1:setTouchEnabled(true)
    self.Button_buy2:setTouchEnabled(true)
    self.Button_buy1:setGrayEnabled(false)
    self.Button_buy2:setGrayEnabled(false)
    local rechargeList = ActivityDataMgr2:getWarOrderChargeList()
    local chargeCfg1 = RechargeDataMgr:getOneRechargeCfg(rechargeList[1])
    self.Label_price1:setText("¥"..chargeCfg1.rechargeCfg.price)
    local chargeCfg2 = RechargeDataMgr:getOneRechargeCfg(rechargeList[2])
    self.Label_price2:setText("¥"..chargeCfg2.rechargeCfg.price)
    local chargeCfg3 = RechargeDataMgr:getOneRechargeCfg(rechargeList[3])
    local extraItems1 = chargeCfg1.item
    local extraItems2 = chargeCfg2.item
    if state == 2 then
        self.Label_price2:setText("¥"..chargeCfg3.rechargeCfg.price)
        extraItems2 = chargeCfg3.item
        self.Label_buy2:setTextById(111000116)
        self.Button_buy2:setTouchEnabled(false)
        self.Button_buy2:setGrayEnabled(true)
    elseif state == 3 then
        extraItems2 = chargeCfg3.item
        self.Label_buy2:setTextById(111000116)
        self.Label_price2:hide()
        self.Button_buy2:setTouchEnabled(false)
        self.Button_buy2:setGrayEnabled(true)
    elseif state == 1 then
        self.Label_buy2:setTextById(111000117)
        self.Label_price2:setText(chargeCfg3.rechargeCfg.price ..TextDataMgr:getText(111000105))
    end
    if state ~= 0 then
        self.Label_buy1:setTextById(111000116)
        self.Button_buy1:setTouchEnabled(false)
        self.Button_buy1:setGrayEnabled(true)
    end
    
    self.ListView_left:removeAllItems()
    self.ListView_right:removeAllItems()

    if extraItems1 then
        for i, v in ipairs(extraItems1) do
            local panel_goodsItem = self.Panel_goodsItem:clone()
            TFDirector:getChildByPath(panel_goodsItem, "Image_extra"):show()
            panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(panel_goodsItem, v.id,v.num)
            self.ListView_left:pushBackCustomItem(panel_goodsItem)
        end
    end

    if extraItems2 then
        for i, v in ipairs(extraItems2) do
            local panel_goodsItem = self.Panel_goodsItem:clone()
            TFDirector:getChildByPath(panel_goodsItem, "Image_extra"):show()
            panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(panel_goodsItem, v.id,v.num)
            self.ListView_right:pushBackCustomItem(panel_goodsItem)
        end
    end
    local rewards = TaskDataMgr:getTraningSpecialRewards(2)
    if state == 0 then
        for i,reward in ipairs(rewards) do
            local panel_goodsItem = self.Panel_goodsItem:clone()
            TFDirector:getChildByPath(panel_goodsItem, "Image_extra"):hide()
            panel_goodsItem:setScale(0.8)
            PrefabDataMgr:setInfo(panel_goodsItem, reward[1], reward[2])
            self.ListView_left:pushBackCustomItem(panel_goodsItem)
            local panel_goodsItem1 = self.Panel_goodsItem:clone()
            TFDirector:getChildByPath(panel_goodsItem1, "Image_extra"):hide()
            panel_goodsItem1:setScale(0.8)
            PrefabDataMgr:setInfo(panel_goodsItem1, reward[1], reward[2])
            self.ListView_right:pushBackCustomItem(panel_goodsItem1)
        end
    end       
    self.ListView_left:update()
    self.ListView_right:update()
end

function TaskTrainingChargeView:registerEvents()
    EventMgr:addEventListener(self, EV_RECHARGE_UPDATE, handler(self.refreshUI, self))

    self.Button_buy1:onClick(function()
        local rechargeList = ActivityDataMgr2:getWarOrderChargeList()
        local chargeCfg = RechargeDataMgr:getOneRechargeCfg(rechargeList[1])
        RechargeDataMgr:getOrderNO(chargeCfg.rechargeCfg.id)
    end)

    self.Button_buy2:onClick(function()
        local rechargeList = ActivityDataMgr2:getWarOrderChargeList()
        local state = ActivityDataMgr2:getWarOrderChargeState()
        if state == 1 then
            local chargeCfg = RechargeDataMgr:getOneRechargeCfg(rechargeList[3])
            RechargeDataMgr:getOrderNO(chargeCfg.rechargeCfg.id)
        else
            local chargeCfg = RechargeDataMgr:getOneRechargeCfg(rechargeList[2])
            RechargeDataMgr:getOrderNO(chargeCfg.rechargeCfg.id)
        end
    end)
end

return TaskTrainingChargeView