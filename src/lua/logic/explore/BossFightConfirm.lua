local BossFightConfirm = class("BossFightConfirm", BaseLayer)


function BossFightConfirm:ctor(afkEventCfg,cityId,callBack,isDetailsPage)
    self.super.ctor(self)
    
    self:initData(afkEventCfg,cityId,callBack,isDetailsPage)
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.bossFightConfirm")
end

function BossFightConfirm:initData(afkEventCfg,cityId,callBack,isDetailsPage)
    self.monsterCid = afkEventCfg.eventPrams.monsterId
    self.award = afkEventCfg.award
    self.callBack = callBack
    self.cityId = cityId
    self.eventId = afkEventCfg.id
    self.isDetailsPage = isDetailsPage
    self.monsterLevelCfg = TabDataMgr:getData("AfkMonsterLevel")
    self.shipAttTable  = TabDataMgr:getData("ShipAttribute");

    self.attrIds = {101,111,121}
end

function BossFightConfirm:onShow()
    self.super.onShow(self)
    GameGuide:checkGuide(self)
end

function BossFightConfirm:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Label_name = TFDirector:getChildByPath(self.Panel_root,"Label_name")
    self.Image_bossIcon = TFDirector:getChildByPath(self.Panel_root,"Image_bossIcon")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")
    self.Spine_boss = TFDirector:getChildByPath(ui,"Spine_boss")

    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root,"ScrollView_award")

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setScale(0.7)
    self.GridView_award = UIGridView:create(ScrollView_award)
    self.GridView_award:setItemModel(Panel_goodsItem)
    self.GridView_award:setColumn(2)
    self.GridView_award:setColumnMargin(20)
    self.GridView_award:setRowMargin(10)
    self.attr = {}
    for i=1,4 do
        local name = TFDirector:getChildByPath(self.Panel_root,"Label_arrt_name"..i)
        local value = TFDirector:getChildByPath(self.Panel_root,"Label_arrt_value"..i)
        table.insert(self.attr,{name = name,value = value})
    end

    self.Button_ok = TFDirector:getChildByPath(self.Panel_root,"Button_ok")

    self:initUILogic()
end

function BossFightConfirm:initUILogic()

    local monsterCfg = ExploreDataMgr:getAfkMonsterCfg(self.monsterCid)
    if not monsterCfg then
        return
    end

    self.Label_name:setTextById(monsterCfg.name)
    self.Image_bossIcon:setTexture(monsterCfg.targetIcon)


    self.Spine_boss:setFile(string.format("effect/%s/%s",monsterCfg.model,monsterCfg.model))
    self.Spine_boss:play("stand",true)
    self.Spine_boss:setScale(monsterCfg.modelSize2)
    self.Spine_boss:setPosition(ccp(29+monsterCfg.offset1.x,24+monsterCfg.offset1.y))

    self.GridView_award:removeAllItems()
    for k,v in pairs(self.award) do
        local Panel_goodsItem = self.GridView_award:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_goodsItem, k,v)
    end

    local attributesType = monsterCfg.attributesType
    dump(attributesType)
    local monsterLevelCfg = self.monsterLevelCfg[attributesType]
    if not monsterLevelCfg then
        return
    end

    local baseAttr = monsterLevelCfg.baseAttr
    local upAttr = monsterLevelCfg.upAttr
    for i=1,4 do
        local attrId = self.attrIds[i]
        if not attrId then
            self.attr[i].name:setText("")
            self.attr[i].value:setText("")
        else
            local attrData = self:getAttributeConfig(attrId)
            local nameStr = TextDataMgr:getText(attrData.name)
            self.attr[i].name:setText(nameStr..":")
            local baseValue = baseAttr[attrId] or 0
            local upValue = upAttr[attrId] or 0
            local level = monsterCfg.level
            local value = baseValue + upValue*level
            self.attr[i].value:setText(value)
        end
    end
end

function BossFightConfirm:getAttributeConfig(attId)
    for i, v in ipairs(self.shipAttTable) do
        if v.attributeId == attId then
            return v
        end
    end
    return nil
end

function BossFightConfirm:registerEvents()

    self.Button_ok:onClick(function()
        if self.callBack then
            self.callBack()
        end
        ExploreDataMgr:setCurFightBoss(self.monsterCid)
        local nationCid = ExploreDataMgr:getCurNation()
        ExploreDataMgr:Send_StartBossFight(EC_AfkActivityID.Main,nationCid,self.cityId,self.eventId)

        if self.isDetailsPage then
            local curCityId = ExploreDataMgr:getCurExploreCity()
            if self.cityId ~= curCityId then
                EventMgr:dispatchEvent(EV_EXPLORE_JUMPCITY,0,nil,self.cityId,true)
            end
        end
    end)

    self.Button_close:onClick(function ()
        AlertManager:closeLayer(self)
    end)
end

return BossFightConfirm
