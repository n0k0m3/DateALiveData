local EquipSuitShowView = class("EquipSuitShowView", BaseLayer)


function EquipSuitShowView:ctor(equipCid)
    self.super.ctor(self)
    self.equipCid = equipCid
    self:init("lua.uiconfig.fairyNew.equipSuitShowView")
end

function EquipSuitShowView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
   
    self.Label_left_name = TFDirector:getChildByPath(self.Panel_left,"Label_name")
    self.Label_right_name = TFDirector:getChildByPath(self.Panel_right,"Label_name")
    self.Panel_info = TFDirector:getChildByPath(self.Panel_right,"Panel_info")

    self.Panel_attr = TFDirector:getChildByPath(self.Panel_right,"Panel_attr")
    self.Label_skill_desc = TFDirector:getChildByPath(self.Panel_right,"Label_skill_desc")
    self.Image_flag = TFDirector:getChildByPath(self.Panel_right,"Image_flag")
    self.Image_line12 = TFDirector:getChildByPath(self.Panel_right,"Image_line12")
    self.Image_line13 = TFDirector:getChildByPath(self.Panel_right,"Image_line13")
    self.Image_line23 = TFDirector:getChildByPath(self.Panel_right,"Image_line23")
    
    self.Panel_hp = TFDirector:getChildByPath(self.Panel_attr,"Panel_hp")
    self.Panel_atk = TFDirector:getChildByPath(self.Panel_attr,"Panel_atk")
    self.Panel_def = TFDirector:getChildByPath(self.Panel_attr,"Panel_def")
    self.Label_atk_value = TFDirector:getChildByPath(self.Panel_attr,"Label_atk_value")
    self.Label_def_value = TFDirector:getChildByPath(self.Panel_attr,"Label_def_value")
    self.Label_hp_value = TFDirector:getChildByPath(self.Panel_attr,"Label_hp_value")

    self.suit_pos = {}
    for i = 1, 3 do
        local foo = {}
        local foo = {}
        local stars = {}
        foo.root = TFDirector:getChildByPath(self.Panel_info,"Panel_pos"..i)
        foo.Image_bg   = TFDirector:getChildByPath(foo.root,"Image_bg")
        foo.Image_icon  = TFDirector:getChildByPath(foo.root,"Image_icon")
        foo.Image_unlock    = TFDirector:getChildByPath(foo.root,"Image_unlock")
        foo.Image_lock  = TFDirector:getChildByPath(foo.root,"Image_lock")
        foo.Image_select    = TFDirector:getChildByPath(foo.root,"Image_select")
        foo.Label_level = TFDirector:getChildByPath(foo.root,"Label_level")
        foo.Image_lock = TFDirector:getChildByPath(foo.root,"Image_lock")
        foo.Panel_info  = TFDirector:getChildByPath(foo.root,"Panel_info")
        for i=1,5 do
            stars[i] = TFDirector:getChildByPath(foo.root,"Image_star"..i)
        end
        foo.stars = stars
        self.suit_pos[i] = foo
    end

    local ScrollView_list = TFDirector:getChildByPath(self.Panel_left,"ScrollView_list")
    self.ScrollView_list = UIListView:create(ScrollView_list)
    self.ScrollView_list:setItemsMargin(-5)

    self.selectIdx = 1
    self.selectPos = 1
    self:refreshView()
end

function EquipSuitShowView:refreshView()
    self.ScrollView_list:removeAllItems()
    local suitMap = TabDataMgr:getData("NewEquipSuit")
    self.suitData = {}
    for k, v in pairs(suitMap) do
        table.insert(self.suitData,v)
    end
    table.sort(self.suitData, function(a, b)
        return a.id < b.id
    end)
    if self.equipCid then
        for i, suit in ipairs(self.suitData) do
            for j, cid in ipairs(suit.suitarmsID) do
                if cid == self.equipCid then
                    self.selectIdx = i
                    self.selectPos = j
                end
            end
        end
    end
    for i,v in ipairs(self.suitData) do
        local item = self.Panel_item:clone()
        self:updateSuitItem(item, self.suitData[i])
        self.ScrollView_list:pushBackCustomItem(item)
        item:setTouchEnabled(true)
        item:onClick(function()
            if i == self.selectIdx then
                return
            end
            self.selectIdx = i
            self.selectPos = 1
            self:refreshRightUI()
        end)
    end
    self:refreshRightUI()
end

function EquipSuitShowView:updateSuitItem(item, data)
    local Image_select = TFDirector:getChildByPath(item,"Image_select")
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    local Label_num = TFDirector:getChildByPath(item,"Label_num") 
    local Label_condition = TFDirector:getChildByPath(item,"Label_condition")
    Image_select:setVisible(false)
    Image_bg:setTexture("ui/new_equip/022.png")
    Label_name:setTextById(data.NameId)
    Label_desc:setTextById(data.desTextId)
    Label_condition:setTextById(data.herosequip)
    local ownNum = EquipmentDataMgr:getNewEquipOwnNumBySuitId(data.id)
    Label_num:setText(ownNum.."/"..data.suitnum)
    Image_icon:setTexture(data.icon)
end

function EquipSuitShowView:refreshRightUI()
    local suitCfg = self.suitData[self.selectIdx]
    if not suitCfg then
        self.Panel_right:setVisible(false)
        return
    end
    local item = self.ScrollView_list:getItem(self.selectIdx)
    if self.selectItem then
        TFDirector:getChildByPath(self.selectItem,"Image_select"):setVisible(false)
        TFDirector:getChildByPath(self.selectItem,"Image_bg"):setTexture("ui/new_equip/022.png") 
    end
    self.selectItem = item
    TFDirector:getChildByPath(item,"Image_select"):setVisible(true)
    TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/new_equip/021.png")

    if suitCfg.suitnum == 2 then
        self.suit_pos[3].root:setVisible(false)
        for i=1,2 do
            local foo = self.suit_pos[i]
            foo.root:setPositionY(390)
            local cid = suitCfg.suitarmsID[i]
            local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
            local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
            local stage = equipInfo and equipInfo.stage or equipCfg.star
            local level = equipInfo and equipInfo.level or 1
            foo.Image_bg:setTexture(EquipmentDataMgr:getNewEquipQualityIcon(equipCfg.quality))
            foo.Image_icon:setTexture(equipCfg.icon)
            foo.Label_level:setText(tostring(level))
            if equipInfo then
                foo.Image_lock:setVisible(false)
                foo.Panel_info:setVisible(true)
            else
                foo.Image_lock:setVisible(true)
                foo.Panel_info:setVisible(false)
            end
            local maxStar = EquipmentDataMgr:getNewEquipMaxStar(cid)
            for j,v in ipairs(foo.stars) do
                if j <= maxStar then
                    v:setVisible(true)
                    if j <= stage then
                        v:setTexture("ui/common/star.png")
                    else
                        v:setTexture("ui/common/starBack.png")
                    end
                else
                    v:setVisible(false)
                end
            end
        end
        self.Image_line12:setPositionY(390)
    else
        self.suit_pos[3].root:setVisible(true)
        for i=1,2 do
            local foo = self.suit_pos[i]
            foo.root:setPositionY(370)
        end
        self.Image_line12:setPositionY(370)

        for i, foo in ipairs(self.suit_pos) do
            local cid = suitCfg.suitarmsID[i]
            local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
            local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
            local stage = equipInfo and equipInfo.stage or equipCfg.star
            local level = equipInfo and equipInfo.level or 1
            foo.Image_bg:setTexture(EquipmentDataMgr:getNewEquipQualityIcon(equipCfg.quality))
            foo.Image_icon:setTexture(equipCfg.icon)
            foo.Label_level:setText(tostring(level))
            if equipInfo then
                foo.Image_lock:setVisible(false)
                foo.Panel_info:setVisible(true)
            else
                foo.Image_lock:setVisible(true)
                foo.Panel_info:setVisible(false)
            end
            local maxStar = EquipmentDataMgr:getNewEquipMaxStar(cid)
            for j,v in ipairs(foo.stars) do
                if j <= maxStar then
                    v:setVisible(true)
                    if j <= stage then
                        v:setTexture("ui/common/star.png")
                    else
                        v:setTexture("ui/common/starBack.png")
                    end
                else
                    v:setVisible(false)
                end
            end
        end
    end
    local flags = {false, false, false}
    for i,cid in ipairs(suitCfg.suitarmsID) do
        local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(cid)
        if equipInfo then
            flags[i] = true
        end
    end
    self.Image_line12:setVisible(flags[1] and flags[2])
    self.Image_line13:setVisible(flags[1] and flags[3])
    self.Image_line23:setVisible(flags[2] and flags[3])

    self:updatePosState()
end

function EquipSuitShowView:updatePosState()
    for i,foo in ipairs(self.suit_pos) do
        foo.Image_select:setVisible(self.selectPos == i)
    end
    local suitCfg = self.suitData[self.selectIdx]
    local cid = suitCfg.suitarmsID[self.selectPos]
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
    if string.len(equipCfg.suitId) > 1 then
        self.Image_flag:setVisible(true)
        self.Image_flag:setVisible(true)
        local suitCfg = EquipmentDataMgr:getNewEquipSuitCfg(equipCfg.suitId)
        self.Image_flag:setTexture(suitCfg.icon)
        local skillCfg = EquipmentDataMgr:getNewEquipSkillCfgBySuitId(equipCfg.suitId)
        self.Label_skill_desc:setTextById(skillCfg.des)
    else
        self.Image_flag:setVisible(false)
        self.Label_skill_desc:setString("")
    end
    local values = EquipmentDataMgr:getNewEquipCurAttribute(cid)
    local position = {ccp(17, 37), ccp(243, 37), ccp(17,6)}
    local hpValue = values[EC_Attr.HP] or 0 
    local atkValue = values[EC_Attr.ATK] or 0
    local defValue = values[EC_Attr.DEF] or 0
    self.Label_hp_value:setText(hpValue)
    self.Label_atk_value:setText(atkValue)
    self.Label_def_value:setText(defValue)
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
end

function EquipSuitShowView:registerEvents()
    for i,foo in ipairs(self.suit_pos) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self.selectPos = i
            self:updatePosState()
        end)
    end
end

return EquipSuitShowView