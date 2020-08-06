--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  质点突破成功界面
* 
]]

local EquipStepUpSucessLayer = class("EquipStepUpSucessLayer", BaseLayer)

function EquipStepUpSucessLayer:ctor(data)
    self.super.ctor(self)
    self.data = data
    self:init("lua.uiconfig.Equip.EquipStepUpSucessLayer")
    Utils:playSound(4001, false)
end

function EquipStepUpSucessLayer:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Spine_star_Up = TFDirector:getChildByPath(self.Panel_root, "Spine_star_Up")

    self.Panel_attr = TFDirector:getChildByPath(self.Panel_root, "Panel_attr")
    self.Panel_hp = TFDirector:getChildByPath(self.Panel_attr, "Panel_hp")
    self.Panel_atk = TFDirector:getChildByPath(self.Panel_attr, "Panel_atk")
    self.Panel_def = TFDirector:getChildByPath(self.Panel_attr, "Panel_def")

    self.old_hp = TFDirector:getChildByPath(self.Panel_hp, "old_hp")
    self.new_hp = TFDirector:getChildByPath(self.Panel_hp, "new_hp")

    self.old_atk = TFDirector:getChildByPath(self.Panel_atk, "old_atk")
    self.new_atk = TFDirector:getChildByPath(self.Panel_atk, "new_atk")

    self.old_def = TFDirector:getChildByPath(self.Panel_def, "old_def")
    self.new_def = TFDirector:getChildByPath(self.Panel_def, "new_def")

    self.item1 = TFDirector:getChildByPath(self.Panel_root, "item1")
    self.item2 = TFDirector:getChildByPath(self.Panel_root, "item2")

    self.Spine_star_Up:play("ALL",false)
    self.Spine_star_Up:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_star_Up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_star_Up:play("xunhuan",true)
        end, 0)
    end) 

    self:updateUI()
end

function EquipStepUpSucessLayer:updateUI()
	local equipId = self.data.equipId
	local nowStep = EquipmentDataMgr:getEquipStep(equipId)
	local preStep = nowStep - 1
	if preStep < 0 then preStep = 0 end

    self.old_hp:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.HP, preStep))
    self.old_atk:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.ATK, preStep))
    self.old_def:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.DEF, preStep))

    self.new_hp:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.HP))
    self.new_atk:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.ATK))
    self.new_def:setText(EquipmentDataMgr:getEquipmentAttrById(equipId, EC_Attr.DEF))

    self:updateOneEquipment(equipId, preStep, self.item1)
    self:updateOneEquipment(equipId, nowStep, self.item2)
end

function EquipStepUpSucessLayer:updateOneEquipment(id, step, item)
    local starLv = EquipmentDataMgr:getEquipStarLv(id)
	local equipCid = EquipmentDataMgr:getEquipCid(id)
	local itemCfg = GoodsDataMgr:getItemCfg(equipCid)
    local quality = EquipmentDataMgr:getEquipQuality(id)
    local Image_level_bg = TFDirector:getChildByPath(item, "Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item, "Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item, "Label_lv")
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id))

    local stepLabel = TFDirector:getChildByPath(item, "label_level_step")
    local stepStr = "+" .. step
    if itemCfg.maxAdvanced and step >= itemCfg.maxAdvanced then
        stepStr = "+MAX"
    end
    if step <= 0 then
    	stepStr = ""
    end
    stepLabel:setText(stepStr)
    
    --星级
    for i=1,5 do
        if i > starLv then
            TFDirector:getChildByPath(item,"Image_star"..i):setVisible(false);
        end    
    end
    local Panel_star = TFDirector:getChildByPath(item,"Panel_star")
    local starLevel = EquipmentDataMgr:getEquipStarLevel(id)
    if starLevel >= 1 and starLevel < 2 then
        Panel_star:setScale(0.88)
    elseif starLevel >= 2 then
        Panel_star:setScale(0.8)
    else
        Panel_star:setScale(1.0)
    end
    local Image_stage1 = TFDirector:getChildByPath(Panel_star,"Image_stage1")
    local Image_stage2 = TFDirector:getChildByPath(Panel_star,"Image_stage2")
    local Image_stage3 = TFDirector:getChildByPath(Panel_star,"Image_stage3")
    Image_stage1:setVisible(starLevel >= 1 and starLevel <= 2)
    Image_stage2:setVisible(starLevel == 2)
    Image_stage3:setVisible(starLevel == 3)
    local Image_back = TFDirector:getChildByPath(item, "Image_back")
    Image_back:setTexture(EC_ItemIcon[quality])

    local iconpath = EquipmentDataMgr:getEquipIcon(id);
    local icon = TFDirector:getChildByPath(item, "Image_equip")
    icon:setTexture(iconpath)
    icon:Size(CCSizeMake(100, 100))

    local typeIcon = TFDirector:getChildByPath(item, "Image_type")
    local subType = EquipmentDataMgr:getEquipSubType(id)
    typeIcon:setTexture(EC_EquipSubTypeIcon2[subType])
    typeIcon:Size(CCSizeMake(24, 24))
end

function EquipStepUpSucessLayer:registerEvents()
    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return EquipStepUpSucessLayer
