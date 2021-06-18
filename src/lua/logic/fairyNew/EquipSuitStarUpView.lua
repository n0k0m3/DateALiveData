local EquipSuitStarUpView = class("EquipSuitStarUpView", BaseLayer)


function EquipSuitStarUpView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.heroId = data.heroId
    self.pos = data.pos
    self:init("lua.uiconfig.fairyNew.equipSuitStarUpView")
end

function EquipSuitStarUpView:getClosingStateParams()
    return {self.paramData_}
end

function EquipSuitStarUpView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left   = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right  = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_bottom = TFDirector:getChildByPath(ui,"Panel_bottom")
    self.Panel_item   = TFDirector:getChildByPath(ui,"Panel_item")

    self.Label_name   = TFDirector:getChildByPath(self.Panel_left,"Label_name")
    self.Image_icon1 = TFDirector:getChildByPath(self.Panel_left,"Image_icon1")
    self.Image_icon2 = TFDirector:getChildByPath(self.Panel_left,"Image_icon2")

    self.Label_desc   = TFDirector:getChildByPath(self.Panel_left,"Label_desc")
    self.Label_skill_desc   = TFDirector:getChildByPath(self.Panel_left,"Label_skill_desc")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_left,"Image_flag")
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
    self.Panel_gold = TFDirector:getChildByPath(self.Panel_bottom,"Panel_gold")
    self.Label_up = TFDirector:getChildByPath(self.Button_UP,"Label_up")
    self.Label_tips = TFDirector:getChildByPath(self.Panel_bottom,"Label_tips")
    self.Label_gold = TFDirector:getChildByPath(self.Panel_bottom,"Label_gold")

    self:refreshView()
end

function EquipSuitStarUpView:refreshView()
    local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
    local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.id, euipMent.cid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
    local maxLevel = EquipmentDataMgr:getNewEquipMaxLevel(euipMent.cid)
    self.Button_UP:setGrayEnabled(false)
    self.Button_UP:setTouchEnabled(true)

    local maxStar = equipCfg.endStar
    for i,v in ipairs(self.equip_stars) do
        if i < 6 then
            if i <= maxStar then
                v:setVisible(true)
                v:setPositionX(85 + (5 - maxStar) * 11 + i * 22)
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
                v:setPositionX(345 + (5 - maxStar) * 11 + (i - 5) * 22)
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

    self.Label_name:setTextById(equipCfg.nameTextId)
    self.Image_icon1:setTexture(equipCfg.icon)
    self.Image_icon2:setTexture(equipCfg.icon)
    self.Label_level_now:setText(tostring(equipInfo.level).."/"..maxLevel)
    self.Label_level_next:setText(tostring(equipInfo.level).."/"..maxLevel)
    self.Label_attr_title:setTextById(100000050)
    self.Label_desc:setTextById(equipCfg.desTextId)
    
    --[[不显示套装属性
        if string.len(equipCfg.suitId) > 1 then
            self.Image_flag:setVisible(true)
            local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
            self.Image_flag:setTexture(suitCfg.icon)
            local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(equipCfg.suitId)
            self.Label_skill_desc:setTextById(skillCfg.des)
        else
            self.Image_flag:setVisible(false)
            self.Label_skill_desc:setString("")
        end
    ]]

    local attrValues1 = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.id, euipMent.cid, equipInfo.stage)
    local attrValues2 = EquipmentDataMgr:getNewEquipCurAttribute(euipMent.id, euipMent.cid, math.min((equipInfo.stage + 1), maxStar))

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
    
    if equipInfo.stage >= maxStar then
        self.ScrollView_items:removeAllItems()
        self.gold_cost = 0
    else
        local consume = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.id, euipMent.cid, math.min(equipInfo.stage, maxStar)).consume
        self:refreshCostItems(consume)
    end
    self.Label_gold:setString(self.gold_cost)
    if GoodsDataMgr:getItemCount(EC_SItemType.GOLD) < self.gold_cost then
        self.Label_gold:setColor(ccc3(219,50,50))
    else
        self.Label_gold:setFontColor(ccc3(255,255,255))
    end
    self.Panel_gold:setVisible(self.gold_cost > 0)
end

function EquipSuitStarUpView:refreshCostItems(consume)
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

function EquipSuitStarUpView:updateCostItem(item, data)
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

function EquipSuitStarUpView:onAdvanceOver(data)
    if data.isSuccess then
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
        Utils:openView("fairyNew.EquipSuitStarUpSuccess", euipMent)
        self:refreshView()
    end
end

function EquipSuitStarUpView:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_ADVANCE_NEW_EQUIP,handler(self.onAdvanceOver, self))

    self.Button_UP:onClick(function()
        local euipMent = HeroDataMgr:getNewEquipInfoByPos(self.heroId, self.pos)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(euipMent.cid)
        local acvanceCfg = EquipmentDataMgr:getNewEquipAdvanceCfg(euipMent.id, euipMent.cid)
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(euipMent.cid)
        if equipInfo.stage >= equipCfg.endStar then
            Utils:showTips(100000047)
            return
        end
        if equipInfo.level < acvanceCfg.limitLevel then
            Utils:showTips(100000048)
            return
        end
        Utils:playSound(4002, false)
        EquipmentDataMgr:sendReqEquipAdvance(self.heroId, self.pos)
    end)
end

return EquipSuitStarUpView