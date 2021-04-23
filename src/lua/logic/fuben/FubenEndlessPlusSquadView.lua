
local FubenEndlessPlusSquadView = class("FubenEndlessPlusSquadView", BaseLayer)

local enum_ruleId = {
    power_up = 1,
    power_down = 2,
    level_up = 3,
    level_down = 4,
    default = 5
}

function FubenEndlessPlusSquadView:initData(selectFloorCid)

    self.sortRule = {{lable = 14300313,ruleId = enum_ruleId.power_up,isUp = true},
                     {lable = 14300314,ruleId = enum_ruleId.power_down,isUp = false},
                     {lable = 14300315,ruleId = enum_ruleId.level_up,isUp = true},
                     {lable = 14300316,ruleId = enum_ruleId.level_down,isUp = false},
                     {lable = 14300317,ruleId = enum_ruleId.default,isUp = true}}

    self.selectFloorCid = selectFloorCid
    self.dungeonIds = {}
    self.buffIds = {}
    local floorCfg = FubenEndlessPlusDataMgr:getFloorDungeonCfg(selectFloorCid)
    if floorCfg then
        self.dungeonIds = floorCfg.dungeonId or {}
        self.buffIds = floorCfg.buffId or {}
        self.dungeonNameId = floorCfg.name
        self.dungeonDescId = floorCfg.describe
    end

    self.ownHero = {}
    local heros = HeroDataMgr:getHero()
    for k, v in pairs(heros) do
        if HeroDataMgr:getIsHave(k) then
            table.insert(self.ownHero, k)
        end
    end

    self.floorBuffCfg = TabDataMgr:getData("FloorBuff")

end

function FubenEndlessPlusSquadView:ctor(selectFloorCid)
    self.super.ctor(self)
    self:initData(selectFloorCid)
    self:init("lua.uiconfig.fuben.fubenEndlessPlusSquadView")
end

function FubenEndlessPlusSquadView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Panel_hero_item = TFDirector:getChildByPath(ui, "Panel_hero_item")
    local ScrollView_hero = TFDirector:getChildByPath(ui, "ScrollView_hero")
    self.GridView_hero = UIGridView:create(ScrollView_hero)
    self.GridView_hero:setColumn(5)

    self.GridView_hero:setColumnMargin(0)
    self.GridView_hero:setItemModel(self.Panel_hero_item)

    local ScrollView_level = TFDirector:getChildByPath(ui, "ScrollView_level")
    self.UIListView_level = UIListView:create(ScrollView_level)

    local ScrollView_buff = TFDirector:getChildByPath(ui, "ScrollView_buff")
    self.UIListView_buff = UIListView:create(ScrollView_buff)

    self.Label_level_desc = TFDirector:getChildByPath(ui, "Label_level_desc")
    self.Button_fight = TFDirector:getChildByPath(ui, "Button_fight")
    self.Button_check = TFDirector:getChildByPath(ui, "Button_check")

    self.Button_sort_order = TFDirector:getChildByPath(ui, "Button_sort_order")
    self.Label_order_name = TFDirector:getChildByPath(self.Button_sort_order, "Label_order_name")
    self.Image_order_icon = TFDirector:getChildByPath(self.Button_sort_order, "Image_order_icon")

    local ScrollView_rule = TFDirector:getChildByPath(ui, "ScrollView_rule"):hide()
    self.ListView_rule = UIListView:create(ScrollView_rule)
    self.Button_rule = TFDirector:getChildByPath(ui, "Button_rule")
    self.Panel_level_item = TFDirector:getChildByPath(ui, "Panel_level_item")
    self.Panel_buff = TFDirector:getChildByPath(ui, "Panel_buff")

    self:initUILogic()
end

function FubenEndlessPlusSquadView:initUILogic()

    local passTime = FubenEndlessPlusDataMgr:getPassRecordByFloor(self.selectFloorCid)
    if passTime then
        local timestamp = passTime / 1000
        local hour, min, sec = Utils:getTime(timestamp, true)
        self.Label_level_desc:setTextById(800014, min, sec)
    else
        self.Label_level_desc:setText("")
    end

    self:initLevelFormation()
    ---后面加定位关卡
    ---local locationCid = 1
    ---local index = table.indexOf(self.dungeonIds,locationCid)
    self:selectLevelItem(1)

    self:updateRuleList()
    self:selectSortRule(self.defaultInfo)

    self:updateBuffList()
end

function FubenEndlessPlusSquadView:updateBuffList()

    self.UIListView_buff:removeAllItems()
    for k,v in ipairs(self.buffIds) do

        local buffCfg = self.floorBuffCfg[v]
        if buffCfg then
            local item = self.Panel_buff:clone()
            self.UIListView_buff:pushBackCustomItem(item)
            local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
            Label_desc:setTextById(buffCfg.buffDescribe)

            item:onClick(function()

                self:selectBuff(k)
            end)
        end
    end
    self:selectBuff(1)
end

function FubenEndlessPlusSquadView:selectBuff(index)

    local items = self.UIListView_buff:getItems()
    for k,v in ipairs(items) do
        local Image_buff = TFDirector:getChildByPath(v, "Image_buff")
        local Image_select = TFDirector:getChildByPath(v, "Image_select")
        Image_select:setVisible(k == index)
        Image_buff:setVisible(k ~= index)
    end
 
    FubenEndlessPlusDataMgr:setSelectBuffCid(self.buffIds[index])

    --local config = {}
    --config.icon = buffCfg.buffIcon
    --Utils:openView("fuben.FubenMonsterTrialBuffDetail", config,buffCfg.buffDescribe,1)
end

function FubenEndlessPlusSquadView:updateRuleList()

    self.defaultInfo = self.sortRule[5]
    self.ruleId = FubenEndlessPlusDataMgr:getFormationSortRuleId()
    if not self.ruleId then
        self.ruleId = self.defaultInfo.ruleId
        FubenEndlessPlusDataMgr:setFormationSortRuleId(self.ruleId)
    end

    for k,v in ipairs(self.sortRule) do
        local ruleItem = self.Button_rule:clone()
        local Label_btn_name = TFDirector:getChildByPath(ruleItem,"Label_btn_name")
        local Image_btn_icon = TFDirector:getChildByPath(ruleItem,"Image_btn_icon")
        Label_btn_name:setTextById(v.lable)
        local scaleY = v.isUp and 1 or -1
        Image_btn_icon:setScaleY(scaleY)
        self.ListView_rule:pushBackCustomItem(ruleItem)

        if v.ruleId == self.ruleId then
            self.defaultInfo = v
        end
        ruleItem:onClick(function()
            self:selectSortRule(v)
        end)
    end

    self.Label_order_name:setTextById(self.defaultInfo.lable)
    local scaleY = self.defaultInfo.isUp and 1 or -1
    self.Image_order_icon:setScaleY(scaleY)
end

function FubenEndlessPlusSquadView:selectSortRule(ruleInfo)
    self.ruleId = ruleInfo.ruleId
    FubenEndlessPlusDataMgr:setFormationSortRuleId(self.ruleId)
    self.Label_order_name:setTextById(ruleInfo.lable)
    local scaleY = ruleInfo.isUp and 1 or -1
    self.Image_order_icon:setScaleY(scaleY)
    self.ListView_rule:s():hide()
    self:sortHeroShowId()

    self:updateHero()
end

function FubenEndlessPlusSquadView:sortHeroShowId()

    local function sortFunc(a,b)

        local heroInfoA = HeroDataMgr:getHero(a)
        local heroInfoB = HeroDataMgr:getHero(b)
        if self.ruleId == enum_ruleId.power_up then
            return heroInfoA.fightPower < heroInfoB.fightPower
        elseif self.ruleId == enum_ruleId.power_down then
            return heroInfoA.fightPower > heroInfoB.fightPower
        elseif self.ruleId == enum_ruleId.level_up then
            return heroInfoA.lvl < heroInfoB.lvl
        elseif self.ruleId == enum_ruleId.level_down then
            return heroInfoA.lvl > heroInfoB.lvl
        end
    end
    table.sort(self.ownHero,sortFunc)

end

function FubenEndlessPlusSquadView:updateHero()


    local items = self.GridView_hero:getItems()
    local gap = #self.ownHero - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.GridView_hero:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.GridView_hero:removeItem(1)
        end
    end


    local items = self.GridView_hero:getItems()
    for i, item in ipairs(items) do
        local heroid = self.ownHero[i]
        local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
        Image_icon:setTexture(HeroDataMgr:getIconPathById(heroid))

        local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
        local inLevelCid = FubenEndlessPlusDataMgr:getHeroFormationLevelCid(self.selectFloorCid,heroid)

        if inLevelCid then
            Image_select:setVisible(true)
        end


        item:onClick(function()
            self:selectHero(heroid)
        end)
    end
end

function FubenEndlessPlusSquadView:selectHero(heroId)

    local inLevelCid = FubenEndlessPlusDataMgr:getHeroFormationLevelCid(self.selectFloorCid,heroId)
    if not inLevelCid then
        self:equipHero(heroId)
    else

        if inLevelCid == self.selectLevelCid then
            --FubenEndlessPlusDataMgr:downHeroFormation(self.selectFloorCid,self.selectLevelCid,heroId)
        else
           Utils:showTips(15010236)
        end
    end

end

function FubenEndlessPlusSquadView:equipHero(heroId)

    local formation = FubenEndlessPlusDataMgr:getHeroFormation(self.selectFloorCid,self.selectLevelCid) or {}

    local cnt = 0
    for k,v in pairs(formation) do

        cnt = cnt + 1

        local equipRoleid = HeroDataMgr:getHeroRoleId(heroId)
        local formationRoleid = HeroDataMgr:getHeroRoleId(v)
        if equipRoleid == formationRoleid then
            Utils:showTips(15010237)
            return
        end

    end

    if cnt >= 3 then
        Utils:showTips(15010238)
        return
    end

    FubenEndlessPlusDataMgr:upHeroFormation(self.selectFloorCid,self.selectLevelCid,heroId)

end

function FubenEndlessPlusSquadView:initLevelFormation()

    self.UIListView_level:removeAllItems()
    self.levelItem_ = {}
    for k,v in ipairs(self.dungeonIds) do
        local item = self.Panel_level_item:clone()
        self.UIListView_level:pushBackCustomItem(item)

        local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()

        self.levelItem_[k] = item
        self:updateLevelItem(k,v)

        item:onClick(function()
            self:selectLevelItem(k)
        end)

        for pos=1,3 do
            local Image_player = TFDirector:getChildByPath(item,"Image_frame_"..pos)
            Image_player:onClick(function()
                self:unLoadHero(k,pos)
            end)
        end
    end
end

function FubenEndlessPlusSquadView:unLoadHero(index,pos)

    local levelCid = self.dungeonIds[index]
    if not levelCid then
        return
    end

    self:selectLevelItem(index)

    local heroId = FubenEndlessPlusDataMgr:getHeroFormation(self.selectFloorCid,levelCid,pos)
    if not heroId then
        return
    end
    FubenEndlessPlusDataMgr:downHeroFormation(self.selectFloorCid,levelCid,heroId)

end

function FubenEndlessPlusSquadView:updateLevelItem(index)

    local levelCid = self.dungeonIds[index]
    local item = self.levelItem_[index]

    if not levelCid or not item then
        return
    end

    local Label_level_name = TFDirector:getChildByPath(item,"Label_level_name")
    local levelCfg = FubenEndlessPlusDataMgr:getFloorDungeonLevelCfg(levelCid)
    if levelCfg then
        Label_level_name:setTextById(levelCfg.dungeonName)
    end


    for pos=1,3 do
        local Image_player = TFDirector:getChildByPath(item,"Image_frame_"..pos)
        local Image_icon = TFDirector:getChildByPath(Image_player,"Image_icon")
        local Image_add = TFDirector:getChildByPath(Image_player,"Image_add")
        local heroId = FubenEndlessPlusDataMgr:getHeroFormation(self.selectFloorCid,levelCid,pos)
        if heroId then
            Image_icon:show()
            Image_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
            Image_add:hide()
        else
            Image_icon:hide()
            Image_add:show()
        end
    end

    local Button_check = TFDirector:getChildByPath(item,"Button_check")
    Button_check:onClick(function()
        Utils:openView("fuben.FubenEndlessPlussBossView",levelCid)
    end)
end

function FubenEndlessPlusSquadView:selectLevelItem(index)

    if not self.dungeonIds[index] then
        return
    end

    for k,v in ipairs(self.levelItem_) do
        local Image_select = TFDirector:getChildByPath(v,"Image_select")
        Image_select:setVisible(k == index)

        local color = k == index and ccc3(144,83,18) or ccc3(67,82,123)
        local Label_level_name = TFDirector:getChildByPath(v,"Label_level_name")
        Label_level_name:setColor(color)
    end

    self.selectLevelCid = self.dungeonIds[index]
end

function FubenEndlessPlusSquadView:updateFormation()

    self:updateHero()
    if not self.selectLevelCid then
        return
    end
    local index = table.indexOf(self.dungeonIds,self.selectLevelCid)
    self:updateLevelItem(index)

end

function FubenEndlessPlusSquadView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_ENDLESSPLUS_FORMATION, handler(self.updateFormation, self))

    self.Button_fight:onClick(function()

        local passTime = FubenEndlessPlusDataMgr:getPassRecordByFloor(self.selectFloorCid)
        if passTime then
            Utils:showTips(15011148)
            return
        end

        local haveEmptyFormation = false
        for k,v in ipairs(self.dungeonIds) do

            local heroIds = FubenEndlessPlusDataMgr:getHeroFormation(self.selectFloorCid,v) or {}
            local cnt = 0
            for k,v in pairs(heroIds) do
                cnt = cnt + 1
            end
            if cnt <= 0 then
                haveEmptyFormation = true
                break
            end
             
        end


        if haveEmptyFormation then
            Utils:showTips(15010240)
            return
        end


        local formation = {}
        local heroIds = FubenEndlessPlusDataMgr:getHeroFormation(self.selectFloorCid,self.dungeonIds[1])
        for k,v in pairs(heroIds) do
            table.insert(formation, {1, v})
        end

        local battleController = require("lua.logic.battle.BattleController")
        battleController.requestFightStart(self.dungeonIds[1],0, 0, formation)
        AlertManager:closeLayer(self)
    end)

    self.Button_sort_order:onClick(function()
        local visible = self.ListView_rule:s():isVisible()
        self.ListView_rule:s():setVisible(not visible)
    end)

    self.Button_check:onClick(function()
        FunctionDataMgr:jHeroMain( )
    end)
end

return FubenEndlessPlusSquadView
