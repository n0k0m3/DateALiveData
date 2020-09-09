local EquipSuitMainLayer = class("EquipSuitMainLayer", BaseLayer)

local attrName = {
    TextDataMgr:getText(100000040), 
    TextDataMgr:getText(100000108), 
    TextDataMgr:getText(100000109)
}
function EquipSuitMainLayer:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self:initData()
    self:init("lua.uiconfig.fairyNew.equipSuitMainLayer")
end

function EquipSuitMainLayer:initData()
    self.heroId = self.paramData_.heroId
    self.equipData = {}
    self.selectIdx = nil
    self.bagSelectIdx = nil
    self.bagSortType = 1
    self.notAction = self.paramData_.notAction
    self.isSkyladder = self.paramData_.isSkyladder
end

function EquipSuitMainLayer:getClosingStateParams()
    self.paramData_.pos = self.selectIdx
    return {self.paramData_}
end

function EquipSuitMainLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    EquipSuitMainLayer.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Image_Equip        = TFDirector:getChildByPath(ui,"Image_Equip")
    self.Panel_info        = TFDirector:getChildByPath(ui,"Panel_info")
    self.Panel_bag        = TFDirector:getChildByPath(ui,"Panel_bag")
    self.Panel_di        = TFDirector:getChildByPath(ui,"Panel_di")
    self.Panel_equip_item        = TFDirector:getChildByPath(ui,"Panel_equip_item")

    self.suit_pos = {}
    self.suit_attr = {}
    self.panel_info_attr = {}
    self.panel_bag_attr = {}
    self.equip_stars = {}
    for i = 1, 6 do
        local foo = {}
        local foo = {}
        local stars = {}
        foo.root = TFDirector:getChildByPath(self.Panel_left,"Panel_pos"..i)
        foo.Image_quality   = TFDirector:getChildByPath(foo.root,"Image_quality")
        foo.Image_icon  = TFDirector:getChildByPath(foo.root,"Image_icon")
        foo.Image_unlock    = TFDirector:getChildByPath(foo.root,"Image_unlock")
        foo.Image_lock  = TFDirector:getChildByPath(foo.root,"Image_lock")
        foo.Image_select    = TFDirector:getChildByPath(foo.root,"Image_select")
        foo.Label_level = TFDirector:getChildByPath(foo.root,"Label_level")
        foo.Panel_info  = TFDirector:getChildByPath(foo.root,"Panel_info")
        foo.skyladderLock = TFDirector:getChildByPath(foo.root,"Image_skysuit_lock")
        for i=1,5 do
            stars[i] = TFDirector:getChildByPath(foo.root,"Image_star"..i)
        end
        foo.stars = stars
        self.suit_pos[i] = foo
    end


    self.Panel_hp = TFDirector:getChildByPath(self.Panel_left,"Panel_hp")
    self.Panel_atk = TFDirector:getChildByPath(self.Panel_left,"Panel_atk")
    self.Panel_def = TFDirector:getChildByPath(self.Panel_left,"Panel_def")
    self.Label_atk_value = TFDirector:getChildByPath(self.Panel_left,"Label_atk_value")
    self.Label_def_value = TFDirector:getChildByPath(self.Panel_left,"Label_def_value")
    self.Label_hp_value = TFDirector:getChildByPath(self.Panel_left,"Label_hp_value")
    self.Label_new_hp_value = TFDirector:getChildByPath(self.Panel_left,"Label_new_hp_value")
    self.Label_new_atk_value = TFDirector:getChildByPath(self.Panel_left,"Label_new_atk_value")
    self.Label_new_def_value = TFDirector:getChildByPath(self.Panel_left,"Label_new_def_value")
    self.hp_arrow = TFDirector:getChildByPath(self.Panel_left,"hp_arrow")
    self.atk_arrow = TFDirector:getChildByPath(self.Panel_left,"atk_arrow")
    self.def_arrow = TFDirector:getChildByPath(self.Panel_left,"def_arrow")

    self.Button_suit = TFDirector:getChildByPath(self.Panel_left,"Button_suit")
    self.Image_suits = {}
    for i = 1, 3 do
        self.Image_suits[i] = TFDirector:getChildByPath(self.Panel_left,"Image_suit"..i)
    end
    self.Image_suit_effect = TFDirector:getChildByPath(self.Panel_left,"Image_suit_effect")
    self.Label_cost = TFDirector:getChildByPath(self.Panel_left,"Label_cost")
    self.Label_cost_max = TFDirector:getChildByPath(self.Panel_left,"Label_cost_max")
    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_left,"Image_cost_bg")
    self.Label_cost_title = TFDirector:getChildByPath(self.Panel_left,"Label_cost_title")


    self.Image_icon_bg = TFDirector:getChildByPath(self.Panel_info,"Image_icon_bg")
    self.Image_icon = TFDirector:getChildByPath(self.Panel_info,"Image_icon")
    self.Label_name = TFDirector:getChildByPath(self.Panel_info,"Label_name")
    self.Label_level = TFDirector:getChildByPath(self.Panel_info,"Label_level")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_info,"Label_desc")
    self.Label_info_skill_desc = TFDirector:getChildByPath(self.Panel_info,"Label_info_skill_desc")
    for i = 1, 5 do
        self.equip_stars[i] = TFDirector:getChildByPath(self.Panel_info,"Image_star"..i)
    end

    self.Panel_info_hp = TFDirector:getChildByPath(self.Panel_info,"Panel_info_hp")
    self.Panel_info_atk = TFDirector:getChildByPath(self.Panel_info,"Panel_info_atk")
    self.Panel_info_def = TFDirector:getChildByPath(self.Panel_info,"Panel_info_def")
    self.Label_info_atk_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_atk_value")
    self.Label_info_def_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_def_value")
    self.Label_info_hp_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_hp_value")
    self.Label_info_cost = TFDirector:getChildByPath(self.Panel_info,"Label_info_cost")
    self.Image_title_bg = TFDirector:getChildByPath(self.Panel_info,"Image_title_bg")
    self.Image_title_flag = TFDirector:getChildByPath(self.Image_title_bg,"Image_flag")

    self.Label_top_title = TFDirector:getChildByPath(self.Panel_bag,"Label_top_title")
    self.ScrollView_right = TFDirector:getChildByPath(self.Panel_bag,"ScrollView_right")
    self.Label_attr_title = TFDirector:getChildByPath(self.Panel_bag,"Label_attr_title")
    self.Label_bag_skill_desc = TFDirector:getChildByPath(self.Panel_bag,"Label_bag_skill_desc")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_bag,"Image_flag")
    self.Image_title_effect = TFDirector:getChildByPath(self.Panel_bag,"Image_title_effect")
    self.Panel_bag_attr = TFDirector:getChildByPath(self.Panel_bag,"Panel_attr")

    self.GridView_equip = UIGridView:create(self.ScrollView_right)
    self.GridView_equip:setItemModel(self.Panel_equip_item)
    self.GridView_equip:setColumn(4)
    self.GridView_equip:setColumnMargin(10)
    self.GridView_equip:setRowMargin(10)

    local Panel_buttons = TFDirector:getChildByPath(self.Panel_bag,"Panel_buttons")
    self.Button_all     = TFDirector:getChildByPath(Panel_buttons,"Button_all")
    self.Button_free    = TFDirector:getChildByPath(Panel_buttons,"Button_free")
    self.Button_open    = TFDirector:getChildByPath(Panel_buttons,"Button_open")
    self.Image_buttons  = TFDirector:getChildByPath(Panel_buttons,"Image_buttons")
    self.Label_title    = TFDirector:getChildByName(self.Button_open,"Label_title")
    self.Label_title:setTextById(490022)
    self.Image_arrow = TFDirector:getChildByName(self.Button_open,"Image_arrow")


    self.Button_qianghua    = TFDirector:getChildByPath(self.Panel_di,"Button_qianghua")
    self.Image_redTip = TFDirector:getChildByPath(self.Button_qianghua,"Image_redTip"):hide()
    self.Button_wear    = TFDirector:getChildByPath(self.Panel_di,"Button_wear")
    self.Button_drop    = TFDirector:getChildByPath(self.Panel_di,"Button_drop")
    self.Label_wear = TFDirector:getChildByPath(self.Button_wear,"Label_wear")

    self:selectPosIdx(self.paramData_.pos or 1)
end

function EquipSuitMainLayer:selectPosIdx(idx)
    if self.selectIdx == idx then 
        return 
    end

    if not HeroDataMgr:getNewEquipInfoByPos(self.heroId, idx) and self.notAction then
        self.selectIdx = self.selectIdx or 1
    else
        self.selectIdx = idx
    end
    self:refreshLeft()
    self:refreshRight()
end

function EquipSuitMainLayer:refreshLeft()
    local iconPath = HeroDataMgr:getEquipShowHeroIconPath(self.heroId)
    self.Image_Equip:setTexture(iconPath)
    local openNum = TabDataMgr:getData("DiscreteData",51001).data.openNum
    local suiIds = EquipmentDataMgr:getNewEquipSuitEffectByHeroId(self.heroId)
    for i,foo in ipairs(self.suit_pos) do
        foo.Image_unlock:setVisible(i <= openNum)
        foo.Panel_info:setVisible(i <= openNum)
        foo.Image_lock:setVisible(i > openNum)
        foo.Image_select:setVisible(i == self.selectIdx)
        foo.Image_unlock:removeAllChildren()
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, i)
        if euipMent then
            for m,suitId in pairs(suiIds) do
                local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suitId)
                for n,cid in ipairs(suitCfg.suitarmsID) do
                    if tonumber(euipMent.cid) == tonumber(cid) then
                        local imageEffect = CCSprite:create("ui/new_equip/TZ_bg_7.png")
                        foo.Image_unlock:addChild(imageEffect, 5)
                    end
                end
            end
            local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
            local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
            if not equipInfo then
                equipInfo = {}
                equipInfo.level = equipCfg.level
                equipInfo.stage = equipCfg.star
            end

            foo.Panel_info:setVisible(true)
            foo.Image_icon:setScale(0.7)
            foo.Image_icon:setTexture(equipCfg.icon)
            foo.Image_quality:setTexture(EquipmentDataMgr:getNewEquipQualityIcon(equipCfg.quality))
            foo.Label_level:setText(tostring(equipInfo.level))
            local maxStar = EquipmentDataMgr:getNewEquipMaxStar(euipMent.cid)
            local posArrar = EquipmentDataMgr:getNewEquipStarPosArrar(maxStar)
            for j,v in ipairs(foo.stars) do
                if j <= maxStar then
                    v:setVisible(true)
                    v:setPosition(posArrar[j])
                    if j <= equipInfo.stage then
                        v:setTexture("ui/common/star.png")
                    else
                        v:setTexture("ui/common/starBack.png")
                    end
                else
                    v:setVisible(false)
                end
            end
            local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind(euipMent.id)
            foo.skyladderLock:setVisible(self.isSkyladder and bindHero == self.heroId)
        else
            foo.Panel_info:setVisible(false)
        end
    end

    for i, v in ipairs(self.Image_suits) do
        v:removeAllChildren()
        if suiIds[i] then
            local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suiIds[i])
            v:setTexture(suitCfg.icon)
            local spineEffect = SkeletonAnimation:create("effect/effect_ui25/effect_ui25")
            spineEffect:play("down",true)
            v:addChild(spineEffect, -1)
        else
            v:setTexture("ui/new_equip/029.png")
        end
    end
    self:updateChangeAttrs()
end

function EquipSuitMainLayer:updateChangeAttrs()
    local allValus = EquipmentDataMgr:getHeroNewEquipAttribute(self.heroId)
    local position = {ccp(-5, 37), ccp(280, 37), ccp(-5,6)}
    local hpValue = allValus[EC_Attr.HP] or 0 
    local atkValue = allValus[EC_Attr.ATK] or 0
    local defValue = allValus[EC_Attr.DEF] or 0
    self.Label_hp_value:setText(hpValue)
    self.Label_atk_value:setText(atkValue)
    self.Label_def_value:setText(defValue)
    self.Panel_hp:setVisible(true)
    self.Panel_atk:setVisible(true)
    self.Panel_def:setVisible(true)
    self.Panel_hp:setPosition(position[1])
    self.Panel_atk:setPosition(position[2])
    self.Panel_def:setPosition(position[3])

    local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.selectIdx)
    if euipMent then
        self.Label_new_hp_value:setVisible(false)
        self.Label_new_atk_value:setVisible(false)
        self.Label_new_def_value:setVisible(false)
        self.hp_arrow:setVisible(false)
        self.atk_arrow:setVisible(false)
        self.def_arrow:setVisible(false)
        if hpValue <= 0 then
            self.Panel_def:setPosition(self.Panel_atk:getPosition())
            self.Panel_atk:setPosition(self.Panel_hp:getPosition())
            self.Panel_hp:setVisible(false)
        end
        if atkValue <= 0 then
            self.Panel_def:setPosition(self.Panel_atk:getPosition())
            self.Panel_atk:setVisible(false)
        end
        if defValue <= 0 then
            self.Panel_def:setVisible(false)
        end
    else
        local data = self.equipData[self.bagSelectIdx]
        if data then
            local addValues = EquipmentDataMgr:getNewEquipCurAttribute(data.cid)
            local addhp = addValues[EC_Attr.HP] or 0 
            local addatk = addValues[EC_Attr.ATK] or 0
            local adddef = addValues[EC_Attr.DEF] or 0
            self.Label_new_hp_value:setText(hpValue + addhp)
            self.Label_new_atk_value:setText(atkValue + addatk)
            self.Label_new_def_value:setText(defValue + adddef)
            self.Label_new_hp_value:setVisible(true)
            self.Label_new_atk_value:setVisible(true)
            self.Label_new_def_value:setVisible(true)
            self.hp_arrow:setVisible(addhp > 0)
            self.atk_arrow:setVisible(addatk > 0)
            self.def_arrow:setVisible(adddef > 0)
            if hpValue <= 0 and addhp <= 0 then
                self.Panel_def:setPosition(self.Panel_atk:getPosition())
                self.Panel_atk:setPosition(self.Panel_hp:getPosition())
                self.Panel_hp:setVisible(false)
            end
            if atkValue <= 0 and addatk <= 0 then
                self.Panel_def:setPosition(self.Panel_atk:getPosition())
                self.Panel_atk:setVisible(false)
            end
            if defValue <= 0 and adddef <= 0 then
                self.Panel_def:setVisible(false)
            end
        else
            self.Label_new_hp_value:setVisible(false)
            self.Label_new_atk_value:setVisible(false)
            self.Label_new_def_value:setVisible(false)
            self.hp_arrow:setVisible(false)
            self.atk_arrow:setVisible(false)
            self.def_arrow:setVisible(false)
            if hpValue <= 0 then
                self.Panel_def:setPosition(self.Panel_atk:getPosition())
                self.Panel_atk:setPosition(self.Panel_hp:getPosition())
                self.Panel_hp:setVisible(false)
            end
            if atkValue <= 0 then
                self.Panel_def:setPosition(self.Panel_atk:getPosition())
                self.Panel_atk:setVisible(false)
            end
            if defValue <= 0 then
                self.Panel_def:setVisible(false)
            end
        end
    end
end

function EquipSuitMainLayer:updateCost(flag)
    local data = self.equipData[self.bagSelectIdx]
    local costMax = HeroDataMgr:getCostMax(self.heroId)
    if type(costMax) == "table" then
        costMax = costMax.val
    end
    self.Label_cost_max:setString("/"..costMax)
    local curCost = HeroDataMgr:getCost(self.heroId) + HeroDataMgr:getNewEquipCost(self.heroId)
    if flag and data then
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
        curCost = curCost + equipCfg.cost
    end
    self.Label_cost:setString(tostring(curCost))
    self.Label_cost:setPositionX(self.Label_cost_max:getPositionX() - self.Label_cost_max:getContentSize().width - 2)
    
    if curCost > costMax then
        self.Label_cost:setColor(ccc3(253,56,112))
    else
        self.Label_cost:setColor(ccc3(255,255,255))
    end
end

function EquipSuitMainLayer:refreshRight()
    local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.selectIdx)
    if euipMent then
        self.Panel_bag:hide()
        self.Panel_info:show()
        self.Button_drop:show()
        self.Button_wear:hide()
        self.Button_qianghua:show()
        self:updatePanelInfo()
        self:updateCost(false)
    else
        self.Panel_bag:show()
        self.Panel_info:hide()
        self.Button_drop:hide()
        self.Button_wear:show()
        self.Button_qianghua:hide()
        self:updatePanelBag()
        self:updateCost(true)
    end

    if self.notAction then -- 按钮不能操作
        self.Button_wear:hide()
        self.Button_qianghua:hide()
        self.Button_drop:hide()
        self.Button_suit:setTouchEnabled(false)
        self.Label_cost_max:hide()
        self.Label_cost:hide()
        self.Image_cost_bg:hide()
        self.Label_cost_title:hide()
    end
end

function EquipSuitMainLayer:updatePanelInfo()
    self.Image_suit_effect:setVisible(false)
    self.Image_title_effect:setVisible(false)
    local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.selectIdx)
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
    local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)

    if not equipInfo then
        equipInfo = {}
        equipInfo.level = equipCfg.level
        equipInfo.stage = equipCfg.star
    end
    
    self.Image_icon:setTexture(equipCfg.icon)
    self.Label_name:setTextById(equipCfg.nameTextId)
    self.Image_icon_bg:setTexture(EC_ItemIcon[equipCfg.quality])
    self.Label_level:setString(tostring(equipInfo.level))
    self.Label_desc:setTextById(equipCfg.desTextId)
    self.Label_info_cost:setString(tostring(equipCfg.cost))

    if string.len(equipCfg.suitId) > 1 then
        self.Image_title_bg:setVisible(true)
        local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
        self.Image_title_flag:setTexture(suitCfg.icon)
        local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(equipCfg.suitId)
        self.Label_info_skill_desc:setTextById(skillCfg.des)
    else
        self.Image_title_bg:setVisible(false)
        self.Label_info_skill_desc:setString("")
    end

    local maxStar = EquipmentDataMgr:getNewEquipMaxStar(euipMent.cid)
    for i,v in ipairs(self.equip_stars) do
        if i <= maxStar then
            v:setVisible(true)
            v:setPositionX(145 + i * 20)
            if i <= equipInfo.stage then
                v:setTexture("ui/common/star.png")
            else
                v:setTexture("ui/common/starBack.png")
            end
        else
            v:setVisible(false)
        end
    end

    local attrValues = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.cid)
    self.Label_info_atk_value:setText(attrValues[EC_Attr.ATK] or 0)
    self.Label_info_def_value:setText(attrValues[EC_Attr.DEF] or 0)
    self.Label_info_hp_value:setText(attrValues[EC_Attr.HP] or 0)

    local position = {ccp(35, 210), ccp(35, 170), ccp(35,130)}
    local hpValue = attrValues[EC_Attr.HP] or 0 
    local atkValue = attrValues[EC_Attr.ATK] or 0
    local defValue = attrValues[EC_Attr.DEF] or 0
    self.Panel_info_hp:setVisible(true)
    self.Panel_info_atk:setVisible(true)
    self.Panel_info_def:setVisible(true)
    self.Panel_info_hp:setPosition(position[1])
    self.Panel_info_atk:setPosition(position[2])
    self.Panel_info_def:setPosition(position[3])

    if hpValue <= 0 then
        self.Panel_info_def:setPosition(self.Panel_info_atk:getPosition())
        self.Panel_info_atk:setPosition(self.Panel_info_hp:getPosition())
        self.Panel_info_hp:setVisible(false)
    end
    if atkValue <= 0 then
        self.Panel_info_def:setPosition(self.Panel_info_atk:getPosition())
        self.Panel_info_atk:setVisible(false)
    end
    if defValue <= 0 then
        self.Panel_info_def:setVisible(false)
    end

    local canStrengthen = EquipmentDataMgr:newEquipCouldStrengthen(euipMent.cid)
    local canUpStage = EquipmentDataMgr:newEquipCouldUpStage(euipMent.cid)
    self.Image_redTip:setVisible(canStrengthen or canUpStage)
end

function EquipSuitMainLayer:updatePanelBag()
    self.equipData = EquipmentDataMgr:getNewEquipsBySortType(self.heroId, self.bagSortType, self.isSkyladder)
    self.Label_title:setText(self.bagSortType == 1 and TextDataMgr:getText(100000041) or TextDataMgr:getText(100000110))

    self.GridView_equip:removeAllItems()
    self.selectFlag = nil
    for i,v in ipairs(self.equipData) do
        local item = self.GridView_equip:pushBackDefaultItem()
        self:updateEquipItem(item, v)
        item:setTouchEnabled(true)
        item:onClick(function()
            self:updateBagItemSelect(i)
        end)
    end
    self.bagSelectIdx = nil
    self:updateBagItemSelect(1)
end

function EquipSuitMainLayer:updateBagItemSelect(idx)
    if self.bagSelectIdx == idx then
        return
    end
    self.bagSelectIdx = idx
    local item = self.GridView_equip:getItem(idx)
    if self.selectFlag then
        self.selectFlag:setVisible(false)
    end
    if item then
        self.selectFlag = TFDirector:getChildByPath(item,"Image_select")
        self.selectFlag:setVisible(true)
    end
    local data = self.equipData[idx]
    self.Label_wear:setTextById(100000042)
    if data then
        self.Panel_bag_attr:setVisible(true)
        self.Button_wear:setGrayEnabled(false)
        self.Button_wear:setTouchEnabled(true)
        local attrValues = EquipmentDataMgr:getNewEquipCurAttribute(data.cid)
        for i,v in ipairs(self.panel_bag_attr) do
            local value = attrValues[i] or 0
            v:setString(attrName[i]..tostring(value))
        end
       
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
        if string.len(equipCfg.suitId) > 1 then
            self.Image_flag:setVisible(true)
            local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
            self.Image_flag:setTexture(suitCfg.icon)
            local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(equipCfg.suitId)
            self.Label_bag_skill_desc:setTextById(skillCfg.des)
        else
            self.Panel_bag_attr:setVisible(false)
            self.Image_flag:setVisible(false)
            self.Label_bag_skill_desc:setString("")
        end
    else
        self.Panel_bag_attr:setVisible(false)
        self.Button_wear:setGrayEnabled(true)
        self.Button_wear:setTouchEnabled(false)
        self.Image_flag:setVisible(false)
        self.Label_bag_skill_desc:setString("")
    end
    self:updateCost(true)
    self:updateEffectFlag()
    self:updateChangeAttrs()
end

function EquipSuitMainLayer:updateEffectFlag()
    self.Image_suit_effect:setVisible(false)
    self.Image_title_effect:setVisible(false)
    local data = self.equipData[self.bagSelectIdx]
    local flag = true
    local suitCfg
    if data then
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
        if string.len(equipCfg.suitId) > 1 then
            suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
            for i,id in ipairs(suitCfg.suitarmsID) do
                if data.cid ~= id then
                    if not HeroDataMgr:checkNewEquipOnHero(self.heroId, id) then
                        flag = false
                    end
                end
                if not EquipmentDataMgr:checkNewEquipSuitEnableEffect(self.heroId, suitCfg.id) then
                    flag = false
                end
            end
            if flag then
                self.Image_suit_effect:setVisible(true)
                self.Image_title_effect:setVisible(true)
                local suiIds = EquipmentDataMgr:getNewEquipSuitEffectByHeroId(self.heroId)
                for i, v in ipairs(self.Image_suits) do
                    if not suiIds[i] then
                        self.Image_suit_effect:setPosition(v:getPosition())
                        break
                    end
                end
            end
        end
    end
    for i,foo in ipairs(self.suit_pos) do
        foo.Image_unlock:removeChildByTag(99, true)
        if flag and suitCfg then
            local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, i)
            if euipMent then
                if table.indexOf(suitCfg.suitarmsID, euipMent.cid) ~= -1 then
                    local spineEffect = SkeletonAnimation:create("effect/effect_ui24/effect_ui24")
                    spineEffect:play("animation",true)
                    foo.Image_unlock:addChild(spineEffect, -1, 99)
                end
            end
        end
    end
end

function EquipSuitMainLayer:updateEquipItem(item, data)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_select = TFDirector:getChildByPath(item,"Image_select")
    local Label_level_title = TFDirector:getChildByPath(item,"Label_level_title")
    local Label_level = TFDirector:getChildByPath(item,"Label_level")
    local Image_use = TFDirector:getChildByPath(item,"Image_use")
    Label_level_title:setString("Lv.")
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(data.cid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
    local maxStar = equipCfg.endStar

    local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
    Image_icon:setTexture(equipCfg.icon)
    Image_bg:setTexture(EquipmentDataMgr:getNewEquipQualityIcon(equipCfg.quality))
    for i=1,5 do
        local Image_star = TFDirector:getChildByPath(item,"Image_star"..i)
        if i <= maxStar then
            Image_star:setVisible(true)
            Image_star:setPositionX(-55 + (5 - maxStar) * 10 + i * 18)
            if i <= equipInfo.stage then
                Image_star:setTexture("ui/common/star.png")
            else
                Image_star:setTexture("ui/common/starBack.png")
            end
        else
            Image_star:setVisible(false)
        end
    end
    
    Image_bg:setTexture(EC_ItemIcon[equipCfg.quality])
    Image_level_bg:setTexture(EC_ItemLevelIcon[equipCfg.quality])
    Label_level:setString(tostring(equipInfo.level))
    Image_select:setVisible(false)
    Image_use:setVisible(string.len(equipInfo.heroId) > 1)
end

function EquipSuitMainLayer:onTouchButtonOpen()
    if self.isOpen then
        self.isOpen = false
        self.Image_arrow:setRotation(0)
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,345)))
    else
        self.isOpen = true
        self.Image_arrow:setRotation(180)
        self.Image_buttons:runAction(CCMoveTo:create(0.1,ccp(60,115)))
    end
end

function EquipSuitMainLayer:onDressEquipOrDrop(data)
    self:refreshLeft()
    self:refreshRight()
end

function EquipSuitMainLayer:onStrengthenEquip(data)
    if data.isSuccess then
        self:refreshLeft()
        self:refreshRight()
    end
end

function EquipSuitMainLayer:onAdvanceEquip(data)
    if data.isSuccess then
        self:refreshLeft()
        self:refreshRight()
    end
end

function EquipSuitMainLayer:registerEvents()
    --EventMgr:addEventListener(self,EV_BAG_NEW_EQUIPMENT_UPDATE,handler(self.onDressEquipOrDrop, self))
    EventMgr:addEventListener(self,EQUIPMENT_DRESS_NEW_EQUIP,handler(self.onDressEquipOrDrop, self))
    EventMgr:addEventListener(self,EQUIPMENT_STRENGTHEN_NEW_EQUIP,handler(self.onStrengthenEquip, self))
    EventMgr:addEventListener(self,EQUIPMENT_ADVANCE_NEW_EQUIP,handler(self.onAdvanceEquip, self))

    for i = 1, 6 do
        local foo = self.suit_pos[i]
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            local openNum = TabDataMgr:getData("DiscreteData",51001).data.openNum
            if i > openNum then
                Utils:showTips(100000043)
                return
            end
            self:selectPosIdx(i)
        end)
    end

    self.Button_suit:onClick(function()
        Utils:openView("fairyNew.EquipSuitBagShowView")
    end)

    for i, v in ipairs(self.Image_suits) do
        v:setTouchEnabled(true)
        v:onClick(function()
            local suiIds = EquipmentDataMgr:getNewEquipSuitEffectByHeroId(self.heroId)
            if suiIds[i] then
                local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(suiIds[i])
                local str = TextDataMgr:getTextAttr(suitCfg.desTextId).text
                toastMessage(str)
            else
                Utils:showTips(100000044)
            end
        end)
    end

    self.Button_qianghua:onClick(function()
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.selectIdx)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
        local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid)
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
        if EquipmentDataMgr:checkNewEquipReachMaxLv(euipMent.cid) then
            Utils:showTips(100000045)
            return
        end
        -- if equipInfo.level >= acvanceCfg.limitLevel then
        --     Utils:showTips(100000046)
        --     return
        -- end
        Utils:openView("fairyNew.EquipSuitUpView", {heroId = self.heroId, pos = self.selectIdx})
    end)
    
    self.Button_wear:onClick(function()
        local data = self.equipData[self.bagSelectIdx]
        local function confirmCall(show)
            if not show then
                AlertManager:close(self)
            end
            if not self.isSkyladder then
                EquipmentDataMgr:sendReqEquipDressOrDrop(1, self.heroId, data.id, self.selectIdx - 1)
            else
                SkyLadderDataMgr:sendReqEquipDressOrDrop(1, self.heroId, data.id, self.selectIdx - 1)
            end
        end

        local data = self.equipData[self.bagSelectIdx]
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(data.cid)
        local costMax = HeroDataMgr:getCostMax(self.heroId)
        if type(costMax) == "table" then
            costMax = costMax.val
        end
        if HeroDataMgr:getNewEquipCost(self.heroId) + equipCfg.cost > costMax then
            Utils:showTips(225008)
            return
        end

        if string.len(data.heroId) > 1 then
            local name = HeroDataMgr:getNameById(tonumber(data.heroId))

            Utils:openView("common.ChangeEquipConfirmView", { heroName = name, title = TextDataMgr:getText(100000049),tips = "r30003",callback = confirmCall})
        else
            confirmCall(true)
        end
        
    end)
    self.Button_open:onClick(function()
        self:onTouchButtonOpen()
    end)

    self.Button_drop:onClick(function()
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.selectIdx)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
        if not self.isSkyladder then
            EquipmentDataMgr:sendReqEquipDressOrDrop(2, self.heroId, equipInfo.id, self.selectIdx - 1)
        else
            SkyLadderDataMgr:sendReqEquipDressOrDrop(2, self.heroId, equipInfo.id, self.selectIdx - 1)
        end
    end)

    self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(252,225,64))
    self.Button_all:onClick(function()
        self.bagSelectIdx = nil
        self.bagSortType = 1
        self:refreshRight()
        self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_free:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(252,225,64))
        self.Button_free:getChildByName("Label_free"):setFontColor(ccc3(255,255,255))
        self:onTouchButtonOpen()
    end)

    self.Button_free:onClick(function()
        self.bagSelectIdx = nil
        self.bagSortType = 2
        self:refreshRight()
        self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_free:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(255,255,255))
        self.Button_free:getChildByName("Label_free"):setFontColor(ccc3(252,225,64))
        self:onTouchButtonOpen()
    end)
end

return EquipSuitMainLayer