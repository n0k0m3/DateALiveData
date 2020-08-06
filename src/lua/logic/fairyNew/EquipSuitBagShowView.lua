local EquipSuitBagShowView = class("EquipSuitBagShowView", BaseLayer)

local attrName = {TextDataMgr:getText(490205), TextDataMgr:getText(490206), TextDataMgr:getText(490207)}
function EquipSuitBagShowView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self:initData()
    self:init("lua.uiconfig.fairyNew.equipSuitBagShowView")
end

function EquipSuitBagShowView:initData()
    self.equipCfgData = EquipmentDataMgr:getNewEquipsCfgDataArray()
    self.suitCfgData = EquipmentDataMgr:getNewEquipsSuitCfgArray()
    local cid = self.paramData_ and self.paramData_.cid
    if cid then
        for i, v in ipairs(self.equipCfgData) do
            if tonumber(v.id) == tonumber(cid) then
                self.defaultTabIdx = 1
                self.selectEquipCid = cid
                break
            end
        end
        if not self.defaultTabIdx then
            for i, suit in ipairs(self.suitCfgData) do
                for j, id in ipairs(suit.suitarmsID) do
                    if tonumber(id) == cid then
                        self.defaultTabIdx = 2
                        self.selectSuitCid = cid
                        self.scrollToFlag = true
                        break
                    end
                end
            end
        end
    end
    self.defaultTabIdx = self.defaultTabIdx or 1
    self.selectTabIdx = nil
    self.equipItems = {}
    self.suit_panels = {}
    self.suitItems = {}
end

function EquipSuitBagShowView:getClosingStateParams()
    self.paramData_ = self.paramData_ or {}
    if self.selectTabIdx == 1 then
        self.paramData_.cid = self.selectEquipCid
    else
        self.paramData_.cid = self.selectSuitCid
    end
    return {self.paramData_}
end

function EquipSuitBagShowView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    EquipSuitBagShowView.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_info        = TFDirector:getChildByPath(self.Panel_right,"Panel_info")
    self.Panel_di        = TFDirector:getChildByPath(self.Panel_right,"Panel_di")
    self.Panel_equip_item        = TFDirector:getChildByPath(ui,"Panel_equip_item")
    self.Panel_suit_item = TFDirector:getChildByPath(ui,"Panel_suit_item")


    self.Button_equip = TFDirector:getChildByPath(self.Panel_left,"Button_equip")
    self.Button_suit = TFDirector:getChildByPath(self.Panel_left,"Button_suit")
    self.Panel_equip = TFDirector:getChildByPath(self.Panel_left,"Panel_equip")
    self.Panel_suit = TFDirector:getChildByPath(self.Panel_left,"Panel_suit")

    self.Label_collect_num = TFDirector:getChildByPath(self.Panel_equip,"Label_collect_num")
    local ScrollView_equip = TFDirector:getChildByPath(self.Panel_equip,"ScrollView_equip")
    self.ScrollView_equip = UIGridView:create(ScrollView_equip)
    self.ScrollView_equip:setItemModel(self.Panel_equip_item)
    self.ScrollView_equip:setColumn(4)
    self.ScrollView_equip:setColumnMargin(-5)
    self.ScrollView_equip:setRowMargin(0)
    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_equip,"Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ScrollView_equip:setScrollBar(scrollBar)

    self.Label_collect_suit_num = TFDirector:getChildByPath(self.Panel_suit,"Label_collect_suit_num")
    local ScrollView_suit = TFDirector:getChildByPath(self.Panel_suit,"ScrollView_suit")
    self.ScrollView_suit = UIListView:create(ScrollView_suit)
    self.ScrollView_suit:setItemsMargin(10)
    local Image_scrollBarModel1 = TFDirector:getChildByPath(self.Panel_suit,"Image_scrollBarModel")
    local Image_scrollBarInner1 = TFDirector:getChildByPath(Image_scrollBarModel1, "Image_scrollBarInner")
    local scrollBar1 = UIScrollBar:create(Image_scrollBarModel1, Image_scrollBarInner1)
    self.ScrollView_suit:setScrollBar(scrollBar1)

    self.Label_cost = TFDirector:getChildByPath(self.Panel_info,"Label_cost")
    self.Image_icon_bg = TFDirector:getChildByPath(self.Panel_info,"Image_icon_bg")
    self.Image_icon = TFDirector:getChildByPath(self.Panel_info,"Image_icon")
    self.Image_icon_level = TFDirector:getChildByPath(self.Panel_info,"Image_icon_level")
    self.Label_level_title = TFDirector:getChildByPath(self.Image_icon_level,"Label_level_title")
    self.Label_icon_level = TFDirector:getChildByPath(self.Image_icon_level,"Label_icon_level")
    self.Label_level_title:setString("Lv.")
    self.Image_title_bg = TFDirector:getChildByPath(self.Panel_info,"Image_title_bg")

    self.Label_name = TFDirector:getChildByPath(self.Panel_info,"Label_name")
    self.Label_level = TFDirector:getChildByPath(self.Panel_info,"Label_level")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_info,"Label_desc")
    self.Label_info_skill_desc = TFDirector:getChildByPath(self.Panel_info,"Label_info_skill_desc")
    self.equip_stars = {}
    for i = 1, 5 do
        self.equip_stars[i] = TFDirector:getChildByPath(self.Panel_info,"Image_star"..i)
    end

    self.Panel_info_hp = TFDirector:getChildByPath(self.Panel_info,"Panel_info_hp")
    self.Panel_info_atk = TFDirector:getChildByPath(self.Panel_info,"Panel_info_atk")
    self.Panel_info_def = TFDirector:getChildByPath(self.Panel_info,"Panel_info_def")
    self.Label_info_atk_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_atk_value")
    self.Label_info_def_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_def_value")
    self.Label_info_hp_value = TFDirector:getChildByPath(self.Panel_info,"Label_info_hp_value")

    self.Button_get  = TFDirector:getChildByPath(self.Panel_di,"Button_get")

    self:selectTabIndex(self.defaultTabIdx)
end

function EquipSuitBagShowView:selectTabIndex(idx)
    if self.selectTabIdx == idx then 
        return 
    end
    self.selectTabIdx = idx
    if idx == 1 then
        self.Button_equip:setTextureNormal("ui/new_equip/new_001.png")
        self.Button_suit:setTextureNormal("ui/new_equip/new_02.png")
        self:refreshPanelEquip()
    else
        self.Button_equip:setTextureNormal("ui/new_equip/new_02.png")
        self.Button_suit:setTextureNormal("ui/new_equip/new_001.png")
        self:refreshPanelSuit()
    end
end

function EquipSuitBagShowView:refreshPanelEquip()
    self.Panel_equip:setVisible(true)
    self.Panel_suit:setVisible(false)
    if #self.equipItems > 0 then
        self:updateSelectItemState(self.selectEquipCid)
    else
        for i,cfg in ipairs(self.equipCfgData) do
            local item = self.ScrollView_equip:pushBackDefaultItem()
            self:updateEquipItem(item, cfg)
            item:setTouchEnabled(true)
            item:onClick(function()
                self:updateSelectItemState(cfg.id)
            end)
            self.equipItems[#self.equipItems + 1] = item
        end
        local euipCid = self.equipCfgData[1].id
        self:updateSelectItemState(self.selectEquipCid or euipCid)
    end
    local ownNum = EquipmentDataMgr:getSingleNewEquipsCount()
    self.Label_collect_num:setString(ownNum.."/"..#self.equipCfgData)
end

function EquipSuitBagShowView:updateEquipItem(item, cfg)
    local Panel_info = TFDirector:getChildByPath(item,"Panel_info")
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Label_level = TFDirector:getChildByPath(item,"Label_level")
    local Image_cover = TFDirector:getChildByPath(item,"Image_cover")
    local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
    local Image_select = TFDirector:getChildByPath(item,"Image_select")
    Image_select:setVisible(false)
    Image_bg:setTexture(EC_ItemIcon[cfg.quality])
    Image_level_bg:setTexture(EC_ItemLevelIcon[cfg.quality])
    Image_icon:setTexture(cfg.icon)

    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cfg.id)
    local maxStar = cfg.endStar
    for i = 1, 5 do
        local Image_star = TFDirector:getChildByPath(item,"Image_star"..i)
        if i <= maxStar then
            Image_star:setVisible(true)
            Image_star:setPositionX(-55 + (5 - maxStar) * 10 + i * 18)
            if equipInfo then
                if i <= equipInfo.stage then
                    Image_star:setTexture("ui/common/star.png")
                else
                    Image_star:setTexture("ui/common/starBack.png")
                end
            else
                if i <= cfg.star then
                    Image_star:setTexture("ui/common/star.png")
                else
                    Image_star:setTexture("ui/common/starBack.png")
                end
            end
        else
            Image_star:setVisible(false)
        end
    end

    if equipInfo then
        Image_level_bg:setVisible(true)
        Image_cover:setVisible(false)
        Image_lock:setVisible(false)
        Label_level:setString(tostring(equipInfo.level))
        Panel_info:setOpacity(255)
    else
        Image_level_bg:setVisible(false)
        Image_cover:setVisible(true)
        Image_lock:setVisible(false)
        Label_level:setString("1")
        Panel_info:setOpacity(200)
    end
end

function EquipSuitBagShowView:updateSelectItemState(cid)
    self.selectEquipCid = cid
    local idx = 1
    for i, v in ipairs(self.equipCfgData) do
        if tonumber(v.id) == tonumber(cid) then
            idx = i
            break
        end
    end
    local item = self.equipItems[idx]
    if self.image_equip_select then
        self.image_equip_select:setVisible(false)
    end
    if item then
        self.Panel_info:setVisible(true)
        local Image_select = TFDirector:getChildByPath(item,"Image_select")
        Image_select:setVisible(true)
        self.image_equip_select = Image_select
        local cfg = EquipmentDataMgr:getNewEquipCfg(cid)
        self:updatePanelInfo(cfg)
    else
        self.Panel_info:setVisible(false)
    end
end

function EquipSuitBagShowView:refreshPanelSuit()
    self.Panel_equip:setVisible(false)
    self.Panel_suit:setVisible(true)
    if #self.suitItems > 0 then
        self:updateSelectSuitState(self.selectSuitCid)
    else
        local effectNum = 0
        for i,cfg in ipairs(self.suitCfgData) do
            local item = self.Panel_suit_item:clone()
            effectNum = effectNum + self:updateSuitItem(item, cfg)
            self.ScrollView_suit:pushBackCustomItem(item)
            self.suit_panels[#self.suit_panels + 1] = item
        end
        local firstCid
        for i, v in ipairs(self.suitCfgData) do
            firstCid = v.suitarmsID[1]
            if firstCid then
                break
            end
        end
        self.Label_collect_suit_num:setString(effectNum.."/"..#self.suitCfgData)
        self:updateSelectSuitState(self.selectSuitCid or firstCid)
    end
end

function EquipSuitBagShowView:updateSuitItem(item, cfg)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    local Image_suit_icon = TFDirector:getChildByPath(item,"Image_suit_icon")
    local Label_num = TFDirector:getChildByPath(item,"Label_num")
    local Panel_item = TFDirector:getChildByPath(item,"Panel_item")
    Image_bg:setTexture("ui/new_equip/TZ_tiaomu_1.png")
    Label_name:setTextById(cfg.NameId)
    Label_desc:setTextById(cfg.herosequip)
    Image_suit_icon:setTexture(cfg.icon)
    local ownNum = EquipmentDataMgr:getOwnEquipNumInSuit(cfg.id)
    Label_num:setString(ownNum.."/"..#cfg.suitarmsID)
    if ownNum == 0 then
        Label_num:setColor(ccc3(239,95,125))
    else
        Label_num:setColor(ccc3(73,87,143))
    end

    for i,cid in ipairs(cfg.suitarmsID) do
        local equipItem = self.Panel_equip_item:clone()
        local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
        self:updateEquipItem(equipItem, equipCfg)
        Panel_item:addChild(equipItem, 1)
        equipItem:setScale(0.7)
        equipItem:setPosition(ccp(40 + (i - 1) * 85, Panel_item:getContentSize().height / 2))
        equipItem.cid = cid
        self.suitItems[#self.suitItems + 1] = equipItem
        equipItem:setTouchEnabled(true)
        equipItem:onClick(function()
            self:updateSelectSuitState(cid)
        end)
    end
    if ownNum == #cfg.suitarmsID then
        Image_bg:setTexture("ui/new_equip/TZ_tiaomu_2.png")
        return 1
    end
    return 0
end

function EquipSuitBagShowView:updateSelectSuitState(cid)
    self.selectSuitCid = cid

    local item 
    for i,v in ipairs(self.suitItems) do
        if tonumber(v.cid) == tonumber(cid) then
            item = v
            break
        end
    end
    if self.image_suit_select then
        self.image_suit_select:setVisible(false)
    end
    if item then
        self.Panel_info:setVisible(true)
        local Image_select = TFDirector:getChildByPath(item,"Image_select")
        Image_select:setVisible(true)
        self.image_suit_select = Image_select
        local cfg = EquipmentDataMgr:getNewEquipCfg(cid)
        self:updatePanelInfo(cfg)
    else
        self.Panel_info:setVisible(false)
    end

    local itemIdx = 1
    for i,cfg in ipairs(self.suitCfgData) do
        for j,suitCid in ipairs(cfg.suitarmsID) do
            if tonumber(suitCid) == tonumber(cid) then
                itemIdx = i
                break
            end
        end
    end
    if self.scrollToFlag then
        self.scrollToFlag = false
        self.ScrollView_suit:scrollToItem(itemIdx, 0)
    end
end

function EquipSuitBagShowView:updatePanelInfo(cfg)
    if self.selectTabIdx == 1 then
        self.Image_title_bg:setVisible(false)
        self.Label_info_skill_desc:setVisible(false)
    else
        self.Image_title_bg:setVisible(true)
        self.Label_info_skill_desc:setVisible(true)
    end
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cfg.id)
    self.Label_cost:setString(tostring(cfg.cost))
    self.Image_icon:setTexture(cfg.icon)
    self.Label_name:setTextById(cfg.nameTextId)
    self.Image_icon_bg:setTexture(EC_ItemIcon[cfg.quality])
    self.Image_icon_level:setTexture(EC_ItemLevelIcon[cfg.quality])
    self.Label_icon_level:setString(tostring(equipInfo and equipInfo.level or 1))
    self.Label_level:setString(tostring(equipInfo and equipInfo.level or 1))
    self.Label_desc:setTextById(cfg.desTextId)
    self.Image_icon_level:setVisible(false)

    if string.len(cfg.suitId) > 1 then
        local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(cfg.suitId)
        self.Label_info_skill_desc:setTextById(skillCfg.des)
    else
        self.Label_info_skill_desc:setString("")
    end

    local maxStar = cfg.endStar
    for i,v in ipairs(self.equip_stars) do
        if i <= maxStar then
            v:setVisible(true)
            v:setPositionX(145 + i * 20)
            if equipInfo then
                if i <= equipInfo.stage then
                    v:setTexture("ui/common/star.png")
                else
                    v:setTexture("ui/common/starBack.png")
                end
            else
                if i <= cfg.star then
                    v:setTexture("ui/common/star.png")
                else
                    v:setTexture("ui/common/starBack.png")
                end
            end
        else
            v:setVisible(false)
        end
    end

    local attrValues = EquipmentDataMgr:getNewEquipCurAttribute(cfg.id)
    self.Label_info_atk_value:setText(attrValues[EC_Attr.ATK] or 0)
    self.Label_info_def_value:setText(attrValues[EC_Attr.DEF] or 0)
    self.Label_info_hp_value:setText(attrValues[EC_Attr.HP] or 0)

    local position = {ccp(33, 200), ccp(33, 160), ccp(33,120)}
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
end

function EquipSuitBagShowView:registerEvents()

    self.Button_equip:onClick(function()
        self:selectTabIndex(1)
    end)

    self.Button_suit:onClick(function()
        self:selectTabIndex(2)
    end)

    self.Button_get:onClick(function()
        local itemCid
        if self.selectTabIdx == 1 then
            itemCid = self.selectEquipCid
        else
            itemCid = self.selectSuitCid
        end
        if itemCid then
            Utils:showAccess(itemCid)
        end
    end)
end

return EquipSuitBagShowView