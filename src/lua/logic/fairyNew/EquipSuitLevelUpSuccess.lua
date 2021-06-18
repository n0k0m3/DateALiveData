
local EquipSuitLevelUpSuccess = class("EquipSuitLevelUpSuccess", BaseLayer)

function EquipSuitLevelUpSuccess:initData(cid)
    self.equipCid = cid
end

function EquipSuitLevelUpSuccess:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fairyNew.equipSuitLevelUpSuccess")
end

function EquipSuitLevelUpSuccess:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Spine_Level_Up = TFDirector:getChildByPath(self.Panel_root, "Spine_Level_Up")

    self.Panel_info = TFDirector:getChildByPath(self.Panel_content, "Panel_info")
    self.Label_name = TFDirector:getChildByPath(self.Panel_info, "Label_name")
    self.Image_icon1 = TFDirector:getChildByPath(self.Panel_info, "Image_icon1")
    self.Image_icon2 = TFDirector:getChildByPath(self.Panel_info, "Image_icon2")
    self.Label_level_now = TFDirector:getChildByPath(self.Panel_info, "Label_level_now")
    self.Label_level_next = TFDirector:getChildByPath(self.Panel_info, "Label_level_next")
    self.Panel_attr = TFDirector:getChildByPath(self.Panel_info, "Panel_attr")
    self.old_atk = TFDirector:getChildByPath(self.Panel_attr, "old_atk")
    self.old_def = TFDirector:getChildByPath(self.Panel_attr, "old_def")
    self.old_hp = TFDirector:getChildByPath(self.Panel_attr, "old_hp")
    self.new_atk = TFDirector:getChildByPath(self.Panel_attr, "new_atk")
    self.new_def = TFDirector:getChildByPath(self.Panel_attr, "new_def")
    self.new_hp = TFDirector:getChildByPath(self.Panel_attr, "new_hp")

    self.Panel_hp = TFDirector:getChildByPath(self.Panel_attr,"Panel_hp")
    self.Panel_atk = TFDirector:getChildByPath(self.Panel_attr,"Panel_atk")
    self.Panel_def = TFDirector:getChildByPath(self.Panel_attr,"Panel_def")

    self.equip_stars = {}
    for i = 1, 10 do
        self.equip_stars[i] = TFDirector:getChildByPath(self.Panel_content,"Image_star"..i)
    end

    self.Spine_Level_Up:play("chuxian",false)
    self.Spine_Level_Up:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_Level_Up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_Level_Up:play("xunhuan",true)
        end, 0)
    end) 

    self:refreshView()
end

function EquipSuitLevelUpSuccess:refreshView()
    local equipInfo = EquipmentDataMgr:getNewEquipInfoByCid(self.equipCid)
    local equipCfg = EquipmentDataMgr:getNewEquipCfg(self.equipCid)
    local maxLevel = EquipmentDataMgr:getNewEquipMaxLevel(self.equipCid)
    self.Label_name:setTextById(equipCfg.nameTextId)
    self.Image_icon1:setTexture(equipCfg.icon)
    self.Image_icon2:setTexture(equipCfg.icon)
    self.Label_level_now:setString(tostring(equipInfo.level - 1).."/"..maxLevel)
    self.Label_level_next:setString(tostring(equipInfo.level).."/"..maxLevel)

    local maxStar = equipCfg.endStar
    for i,v in ipairs(self.equip_stars) do
        if i < 6 then
            if i <= maxStar then
                v:setVisible(true)
                v:setPositionX(118 + (5 - maxStar) * 12 + i * 24)
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
                v:setPositionX(338 + (5 - maxStar) * 12 + (i - 5) * 24)
                if (i - 5) <= equipInfo.stage then
                    v:setTexture("ui/common/star.png")
                else
                    v:setTexture("ui/common/starBack.png")
                end
            else
                v:setVisible(false)
            end
        end
    end

    local attrValues1 = EquipmentDataMgr:getNewEquipCurAttribute(self.equipMent.id, self.equipCid, nil, equipInfo.level - 1)
    local attrValues2 = EquipmentDataMgr:getNewEquipCurAttribute(self.equipMent.id, self.equipCid, nil, equipInfo.level)

    self.old_atk:setText(tostring(attrValues1[EC_Attr.ATK] or 0))
    self.old_def:setText(tostring(attrValues1[EC_Attr.DEF] or 0))
    self.old_hp:setText(tostring(attrValues1[EC_Attr.HP] or 0))
    self.new_atk:setText(tostring(attrValues2[EC_Attr.ATK] or 0))
    self.new_def:setText(tostring(attrValues2[EC_Attr.DEF] or 0))
    self.new_hp:setText(tostring(attrValues2[EC_Attr.HP] or 0))

    local position = {ccp(17, 80), ccp(17, 50), ccp(17,20)}
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
end

function EquipSuitLevelUpSuccess:registerEvents()
    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return EquipSuitLevelUpSuccess
