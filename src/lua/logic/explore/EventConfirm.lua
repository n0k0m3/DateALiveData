local EventConfirm = class("EventConfirm", BaseLayer)
---1-多次触发事件,2-战斗事件,3-展示事件,4-奖励事件
local EC_eventType = {
    mulTrigger = 1,
    fight = 2,
    show = 3,
    award = 4
}

function EventConfirm:ctor(cityCid,eventCid)
    self.super.ctor(self)
    self:initData(cityCid,eventCid)
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.eventConfirm")
end

function EventConfirm:initData(cityCid,eventCid)
    self.eventCid = eventCid
    self.cityCid = cityCid

    dump({
        cityCid = cityCid,
        eventCid = eventCid,
    })
    local cfg = ExploreDataMgr:getAfkEventCfg(eventCid)
    if cfg then
        self.eventType = cfg.eventType
        if self.eventType == EC_eventType.mulTrigger then
            local nationId = ExploreDataMgr:getCurNation()
            ExploreDataMgr:Send_AddEventProgress(EC_AfkActivityID.Main,nationId,cityCid,eventCid)
        end
    end
end

function EventConfirm:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")

    self.Label_title = TFDirector:getChildByPath(self.Panel_root,"Label_title")
    self.Label_name = TFDirector:getChildByPath(self.Panel_root,"Label_name")
    self.Image_event_icon = TFDirector:getChildByPath(self.Panel_root,"Image_event_icon")
    self.Image_target_icon = TFDirector:getChildByPath(self.Panel_root,"Image_target_icon")
    self.Image_info_bg = TFDirector:getChildByPath(self.Panel_root,"Image_info_bg")
    self.Label_event_desc = TFDirector:getChildByPath(self.Panel_root,"Label_event_desc")
    self.Label_condition = TFDirector:getChildByPath(self.Panel_root,"Label_condition")
    self.Button_treasure = TFDirector:getChildByPath(self.Panel_root,"Button_treasure")
    self.treasure_icon = TFDirector:getChildByPath(self.Button_treasure,"treasure_icon")
    self.Image_title2 = TFDirector:getChildByPath(self.Panel_root,"Image_title2")
    self.Label_type_tip  = TFDirector:getChildByPath(self.Panel_root,"Label_type_tip")
    self.Label_type_tip:setTextById(13322028)
    self.Label_type_tip:setVisible(self.eventType == EC_eventType.mulTrigger)
    
    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root,"ScrollView_award")

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setScale(0.7)
    self.GridView_award = UIGridView:create(ScrollView_award)
    self.GridView_award:setItemModel(Panel_goodsItem)
    self.GridView_award:setColumn(2)
    self.GridView_award:setColumnMargin(20)
    self.GridView_award:setRowMargin(10)

    self.Button_ok = TFDirector:getChildByPath(self.Panel_root,"Button_ok")

    self:updateLogic()
end

function EventConfirm:onShow()
    self.super.onShow(self)
    GameGuide:checkGuide(self)
end

function EventConfirm:updateLogic()

    local eventCfg = ExploreDataMgr:getAfkEventCfg(self.eventCid)
    if not eventCfg then
        return
    end
    self.Label_name:setTextById(eventCfg.name)
    self.Image_event_icon:setTexture(eventCfg.icon2)
    self.Image_target_icon:setTexture(ExploreDataMgr:getShipCfg().icon)
    self.Label_event_desc:setTextById(eventCfg.describe)
    self.Image_info_bg:setTexture(eventCfg.banner)

    local award = eventCfg.award
    self.GridView_award:removeAllItems()
    for k,v in pairs(award) do
        local Panel_goodsItem = self.GridView_award:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
    end

    ---标题
    local titleStrId = eventCfg.eventType == EC_eventType.fight and 3004037 or 13322016
    self.Label_title:setTextById(titleStrId)

    ---宝物
    self.Button_treasure:setVisible(eventCfg.eventType == EC_eventType.show)
    if eventCfg.eventType == EC_eventType.show then
       self:updateShowItem()
    end

    self:updateConditionState(eventCfg.eventType,eventCfg.condition,eventCfg.conditionDes)
end

function EventConfirm:updateConditionState(eventType,condition,conditionDes)

    local canGetEventAward = false
    local eventInfo = ExploreDataMgr:getFoundEventData(self.eventCid)
    if eventInfo and eventInfo.state == 1 then
        canGetEventAward = true
    end

    if eventType == EC_eventType.show then
        canGetEventAward = self.treasureCid == condition.showItemId
    end

    local typeStr = TextDataMgr:getText(13322015)
    if eventType ~= EC_eventType.mulTrigger then
        self.Label_condition:setText(typeStr..conditionDes)
    else
        local progress = eventInfo and eventInfo.progress or 0
        local str = string.format(conditionDes,progress,condition.times)
        self.Label_condition:setText(typeStr..str)
    end

    self.Image_title2:setVisible(conditionDes ~= "")

    local color = canGetEventAward and me.WHITE or me.RED
    self.Label_condition:setColor(color)
    self.Button_ok:setTouchEnabled(canGetEventAward)
    self.Button_ok:setGrayEnabled( not canGetEventAward)

end

function EventConfirm:startEvent()
    local eventCfg = ExploreDataMgr:getAfkEventCfg(self.eventCid)
    if not eventCfg then
        Box("事件ID找不到")
        return
    end

    local function callBack()
        AlertManager:closeLayer(self)
    end
    if eventCfg.eventType == EC_eventType.fight then
        Utils:openView("explore.BossFightConfirm",eventCfg,self.cityCid,callBack)
    else
        local localNation = ExploreDataMgr:getCurNation()
        ExploreDataMgr:Send_GetEventReward(EC_AfkActivityID.Main,localNation,self.cityCid,self.eventCid,self.treasureId)
        AlertManager:closeLayer(self)
    end
end

function EventConfirm:updateShowItem()
    if self.treasureId then
        self.treasure_icon:show()
        local Panel_goodsItem = self.treasure_icon:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setPosition(ccp(0,0))
            Panel_goodsItem:setName("Panel_goodsItem")
            self.treasure_icon:addChild(Panel_goodsItem)
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, self.treasureCid)
    else
        self.treasure_icon:hide()
    end
end

function EventConfirm:registerEvents()
    EventMgr:addEventListener(self, EV_EXPLORE_UPDATE_EVENT, handler(self.updateLogic, self))
    self.Button_ok:onClick(function()
        self:startEvent()
    end)

    self.Button_treasure:onClick(function()
        local function callBack(treasureId,treasureCid)
            self.treasureId = treasureId
            self.treasureCid = treasureCid
            self:updateLogic()
        end
        Utils:openView("explore.TreasureConfirm",self.eventCid,callBack)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return EventConfirm
