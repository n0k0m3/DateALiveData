local EquipSuitUpView = class("EquipSuitUpView", BaseLayer)


function EquipSuitUpView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.heroId = data.heroId
    self.pos = data.pos
    self:init("lua.uiconfig.fairyNew.equipSuitUpView")
end

function EquipSuitUpView:getClosingStateParams()
    return {self.paramData_}
end

function EquipSuitUpView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_bottom        = TFDirector:getChildByPath(ui,"Panel_bottom")
    self.Panel_item        = TFDirector:getChildByPath(ui,"Panel_item")

    self.Label_name        = TFDirector:getChildByPath(self.Panel_left,"Label_name")
    self.Label_desc        = TFDirector:getChildByPath(self.Panel_left,"Label_desc")
    self.Label_skill_desc  = TFDirector:getChildByPath(self.Panel_left,"Label_skill_desc")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_left,"Image_flag")

    self.Panel_item1        = TFDirector:getChildByPath(self.Panel_left,"Panel_item1")
    self.Panel_item2        = TFDirector:getChildByPath(self.Panel_left,"Panel_item2")
    self.Image_icon1        = TFDirector:getChildByPath(self.Panel_left,"Image_icon1")
    self.Image_icon2        = TFDirector:getChildByPath(self.Panel_left,"Image_icon2")
    self.equip_stars = {}
    for i = 1, 10 do
        self.equip_stars[i] = TFDirector:getChildByPath(self.Panel_left,"Image_star"..i)
    end

    self.Label_level_now = TFDirector:getChildByPath(self.Panel_right,"Label_level_now")
    self.Label_level_next = TFDirector:getChildByPath(self.Panel_right,"Label_level_next")
    self.Label_attr_title = TFDirector:getChildByPath(self.Panel_right,"Label_attr_title")
    self.Panel_hp = TFDirector:getChildByPath(self.Panel_right,"Panel_hp")
    self.Panel_atk = TFDirector:getChildByPath(self.Panel_right,"Panel_atk")
    self.Panel_def = TFDirector:getChildByPath(self.Panel_right,"Panel_def")
    self.Spine_up_success = TFDirector:getChildByPath(self.Panel_right,"Spine_up_success"):hide()
    self.Spine_hp = TFDirector:getChildByPath(self.Panel_right,"Spine_hp"):hide()
    self.Spine_atk = TFDirector:getChildByPath(self.Panel_right,"Spine_atk"):hide()
    self.Spine_def = TFDirector:getChildByPath(self.Panel_right,"Spine_def"):hide()

    self.old_atk = TFDirector:getChildByPath(self.Panel_right,"old_atk")
    self.old_def = TFDirector:getChildByPath(self.Panel_right,"old_def")
    self.old_hp = TFDirector:getChildByPath(self.Panel_right,"old_hp")
    self.new_atk = TFDirector:getChildByPath(self.Panel_right,"new_atk")
    self.new_def = TFDirector:getChildByPath(self.Panel_right,"new_def")
    self.new_hp = TFDirector:getChildByPath(self.Panel_right,"new_hp")

    local ScrollView_items = TFDirector:getChildByPath(self.Panel_right,"ScrollView_items")
    self.ScrollView_items = UIListView:create(ScrollView_items)
    self.ScrollView_items:setItemsMargin(2)

    self.Button_UP = TFDirector:getChildByPath(self.Panel_bottom,"Button_UP")
    self.Label_up = TFDirector:getChildByPath(self.Button_UP,"Label_up")
    self.Panel_gold = TFDirector:getChildByPath(self.Panel_bottom,"Panel_gold")
    self.button_title = TFDirector:getChildByPath(self.Button_UP,"Label_up")
    self.Label_gold = TFDirector:getChildByPath(self.Panel_bottom,"Label_gold")

    self:refreshView()
end

function EquipSuitUpView:refreshView()
    local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
    local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
    local maxLevel = EquipmentDataMgr:getNewEquipMaxLevel(euipMent.cid)
    local maxStar = equipCfg.endStar
    self.isStarUp = false
    if equipInfo.stage < equipCfg.endStar and equipInfo.level >= acvanceCfg.limitLevel then
        self.isStarUp = true
    end
    self.Label_name:setTextById(equipCfg.nameTextId)
    self.Label_desc:setTextById(equipCfg.desTextId)
    if self.isStarUp then
        self.Panel_item1:show()
        self.Panel_item2:show()
        self.Panel_gold:hide()
        self.Panel_item1:setPositionX(164)
        self.Image_icon1:setTexture(equipCfg.icon)
        self.Image_icon2:setTexture(equipCfg.icon)
        self.Label_level_now:setText(tostring(equipInfo.level).."/"..maxLevel)
        self.Label_level_next:setText(tostring(equipInfo.level).."/"..maxLevel)
        self.button_title:setTextById(800071)
    else
        self.Panel_item1:show()
        self.Panel_item2:hide()
        self.Panel_gold:show()
        self.Panel_item1:setPositionX(281)
        self.Image_icon1:setTexture(equipCfg.icon)
        self.Label_level_now:setText(tostring(equipInfo.level).."/"..maxLevel)
        self.Label_level_next:setText(tostring(math.min(equipInfo.level + 1, maxLevel)).."/"..maxLevel)
        self.button_title:setTextById(11311097)
    end

    for i,v in ipairs(self.equip_stars) do
        if i < 6 then
            if i <= maxStar then
                v:setVisible(true)
                v:setPositionX(-60 + (5 - maxStar) * 11 + i * 22)
                if i <= equipInfo.stage then
                    v:setTexture("ui/common/star.png")
                else
                    v:setTexture("ui/common/starBack.png")
                end
            else
                v:setVisible(false)
            end
        else
            if (i - 5) <= maxStar then
                v:setVisible(true)
                v:setPositionX(-60 + (5 - maxStar) * 11 + (i - 5) * 22)
                if (i - 5) <= math.min(equipInfo.stage + 1, maxStar) then
                    v:setTexture("ui/common/star.png")
                else
                    v:setTexture("ui/common/starBack.png")
                end
            else
                v:setVisible(false)
            end
        end
    end
    self.Label_attr_title:setText("所需材料")

    --[[ 不显示套装属性
        if string.len(equipCfg.suitId) > 1 then
            self.Image_flag:setVisible(false)
            local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
            self.Image_flag:setTexture(suitCfg.icon)
            local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(equipCfg.suitId)
            self.Label_skill_desc:setTextById(skillCfg.des)
        else
            self.Image_flag:setVisible(false)
            self.Label_skill_desc:setString("")
        end
    ]]

    local attrValues1 = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.cid, equipInfo.stage, equipInfo.level)
    local attrValues2
    if self.isStarUp then
        attrValues2 = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.cid, math.min((equipInfo.stage + 1), maxStar), equipInfo.level)
    else
        attrValues2 = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.cid, equipInfo.stage, math.min(maxLevel,equipInfo.level + 1))
    end
    self.old_atk:setText(tostring(attrValues1[EC_Attr.ATK] or 0))
    self.old_def:setText(tostring(attrValues1[EC_Attr.DEF] or 0))
    self.old_hp:setText(tostring(attrValues1[EC_Attr.HP] or 0))
    self.new_atk:setText(tostring(attrValues2[EC_Attr.ATK] or 0))
    self.new_def:setText(tostring(attrValues2[EC_Attr.DEF] or 0))
    self.new_hp:setText(tostring(attrValues2[EC_Attr.HP] or 0))

    local position = {ccp(17, 104), ccp(17, 64), ccp(17,24)}
    local hpValue = attrValues2[EC_Attr.HP] or 0 
    local atkValue = attrValues2[EC_Attr.ATK] or 0
    local defValue = attrValues2[EC_Attr.DEF] or 0
    self.Panel_hp:setVisible(true)
    self.Panel_atk:setVisible(true)
    self.Panel_def:setVisible(true)
    self.Panel_hp:setPosition(position[1])
    self.Panel_atk:setPosition(position[2])
    self.Panel_def:setPosition(position[3])

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

    
    self.Button_UP:setGrayEnabled(false)
    self.Button_UP:setTouchEnabled(true)
    if (not self.isStarUp and equipInfo.level >= maxLevel) or (self.isStarUp and equipInfo.stage >= maxStar) then
        self.ScrollView_items:removeAllItems()
        self.gold_cost = 0
    else
        local consume
        if self.isStarUp then
            consume = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid, math.min(equipInfo.stage, maxStar)).consume
        else
            consume = EquipmentDataMgr:getNewEquipStrengthenCfg(equipInfo.level).consume
        end
        self:refreshCostItems(consume)
    end
    self.Label_gold:setString(self.gold_cost)
    if GoodsDataMgr:getItemCount(EC_SItemType.GOLD) < self.gold_cost then
        self.Label_gold:setColor(ccc3(219,50,50))
    else
        self.Label_gold:setFontColor(ccc3(255,255,255))
    end
end

function EquipSuitUpView:refreshCostItems(consume)
    self.ScrollView_items:removeAllItems()
    self.gold_cost = 0
    consume = consume or {}
    for k, v in pairs(consume) do
        if v[1] == EC_SItemType.GOLD then
            self.gold_cost = v[2]
        else
            local item = self.Panel_item:clone()
            self:updateCostItem(item, v)
            self.ScrollView_items:pushBackCustomItem(item)
            item:setScale(0.8)
            item:setTouchEnabled(true)
            item:onClick(function()
                Utils:showInfo(v[1], nil, true)
            end)
        end
    end
end

function EquipSuitUpView:updateCostItem(item, data)
    local itemCfg = GoodsDataMgr:getItemCfg(data[1])
    local Image_back = TFDirector:getChildByPath(item,"Image_back")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Label_own_count = TFDirector:getChildByPath(item,"Label_own_count")
    Image_back:setTexture(EC_ItemIcon[itemCfg.quality])
    Image_icon:setTexture(itemCfg.icon)
    local haveNum = GoodsDataMgr:getItemCount(data[1])
    Label_own_count:setString(tostring(haveNum).."/"..data[2])
    if haveNum < data[2] then
        self.Button_UP:setGrayEnabled(true)
        self.Button_UP:setTouchEnabled(false)
        Label_own_count:setFontColor(ccc3(219,50,50))
    else
        Label_own_count:setFontColor(ccc3(255,255,255))
    end
end

function EquipSuitUpView:onStrengthenOver(data)
    if data.isSuccess then
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
        local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid)
        self.Spine_up_success:show()
        self.Spine_hp:show()
        self.Spine_atk:show()
        self.Spine_def:show()
        self.Spine_up_success:playByIndex(0, -1, -1, 0)
        self.Spine_hp:playByIndex(0, -1, -1, 0)
        self.Spine_atk:playByIndex(0, -1, -1, 0)
        self.Spine_def:playByIndex(0, -1, -1, 0)
        self.Spine_up_success:addMEListener(TFARMATURE_COMPLETE,function()
            self.Spine_up_success:hide()
            self.Spine_hp:hide()
            self.Spine_atk:hide()
            self.Spine_def:hide()
        end)
        self:refreshView()
    end
end

function EquipSuitUpView:onAdvanceOver(data)
    if data.isSuccess then
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
        Utils:openView("fairyNew.EquipSuitStarUpSuccess", euipMent.cid)
        self:refreshView()
    end
end

function EquipSuitUpView:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_STRENGTHEN_NEW_EQUIP,handler(self.onStrengthenOver, self))
    EventMgr:addEventListener(self,EQUIPMENT_ADVANCE_NEW_EQUIP,handler(self.onAdvanceOver, self))
    self.Button_UP:onClick(function()
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
        local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.cid)
        local maxLevel = EquipmentDataMgr:getNewEquipMaxLevel(euipMent.cid)
        if not self.isStarUp and equipInfo.level >= maxLevel then
            Utils:showTips(100000045)
            return
        end
        if self.isStarUp and equipInfo.stage >= equipCfg.endStar then
            Utils:showTips(100000047)
            return
        end
        Utils:playSound(4001, false)
        if self.isStarUp then
            EquipmentDataMgr:sendReqEquipAdvance(self.heroId, self.pos)
        else
            EquipmentDataMgr:sendReqEquipStrengthen(self.heroId, self.pos)
        end
    end)
end

return EquipSuitUpView