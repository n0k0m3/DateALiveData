local GongMingMainView = class("GongMingMainView", BaseLayer)

function GongMingMainView:ctor()
    self.super.ctor(self)
    self:initData()
    --self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.gongmingMainView")
end

function GongMingMainView:initData()

    self.checkBoxName = {14221175,14221176,14221177}
    self.oldSelectItem = nil
    self.skillItems_ = {}
end

function GongMingMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_checklist = TFDirector:getChildByPath(ui, "Button_checklist")

    self.Image_name_bg = TFDirector:getChildByPath(ui, "Image_name_bg")
    self.Label_name = TFDirector:getChildByPath(self.Image_name_bg, "Label_name")
    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")

    self.checkBox_ = {}
    for i=1,3 do
        local btn = TFDirector:getChildByPath(ui, "Button_checkbox_"..i)
        local select = TFDirector:getChildByPath(btn, "Image_select")
        local Label_name = TFDirector:getChildByPath(btn, "Label_name")
        Label_name:setTextById(self.checkBoxName[i])
        table.insert(self.checkBox_,{btn = btn,select = select, name = Label_name})
    end

    self.Spine_light_loop = TFDirector:getChildByPath(ui,"Spine_light_loop")
    self.Spine_light_loop:hide()

    local Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
    self.Image_slot_select = TFDirector:getChildByPath(Panel_left,"Image_select")
    self.slot_ = {}
    for i=1,4 do
        local slotImg = TFDirector:getChildByPath(Panel_left,"Image_slot_"..i)
        local Panel_spine = TFDirector:getChildByPath(slotImg,"Panel_spine")
        local icon = TFDirector:getChildByPath(slotImg,"Image_icon")
        table.insert(self.slot_,{slot = slotImg, icon = icon, Panel_spine = Panel_spine})
    end

    self.Label_gongmingMainView_tip  = TFDirector:getChildByPath(ui, "Label_gongmingMainView_tip")
    self.Label_gongmingMainView_tip:setTextById(14220108)

    self.Panel_item = TFDirector:getChildByPath(ui, "Panel_item")
    local ScrollView_list = TFDirector:getChildByPath(ui, "ScrollView_list")
    self.GridView_item = UIGridView:create(ScrollView_list)
    self.GridView_item:setItemModel(self.Panel_item)
    self.GridView_item:setColumn(4)

    self.Button_equip = TFDirector:getChildByPath(ui, "Button_equip")
    self.Button_unequip = TFDirector:getChildByPath(ui, "Button_unequip")
    self.Button_change = TFDirector:getChildByPath(ui, "Button_change")

    self:initLogic()
end

function GongMingMainView:initLogic()
    self:chooseType(1)
    self:updateSlotSkills()
    self:chooseSlot(1)
end

function GongMingMainView:updateSlotSkills()

    local infos = ResonanceDataMgr:getEquipedSkills()
    if not infos then
        return
    end

    local equipCnt = 0
    for k,v in ipairs(self.slot_) do
        local equipedCid = infos[k]
        local cfg = ResonanceDataMgr:getManaResonanceCfg(equipedCid)
        if cfg then
            self.slot_[k].icon:setTexture(cfg.icon)
            --local spineEffect = self.slot_[k].Panel_spine:getChildByName("spine")
            --if not spineEffect then
            --    spineEffect = SkeletonAnimation:create(cfg.spine)
            --    spineEffect:setName("spine")
            --    self.slot_[k].Panel_spine:addChild(spineEffect, -1)
            --    spineEffect:play("animation",true)
            --else
            --    spineEffect:setFile(cfg.spine)
            --end
            equipCnt = equipCnt + 1
        else
            self.slot_[k].icon:setTexture("")
            self.slot_[k].Panel_spine:removeAllChildren()
        end
    end

    self.Spine_light_loop:setVisible(equipCnt == #self.slot_)
end

function GongMingMainView:chooseType(id)
    for k,v in ipairs(self.checkBox_) do
        v.select:setVisible(k == id)
    end
    self.skillType = id
    self.selectCid = nil

    self.Image_name_bg:setVisible(false)
    self.Label_desc:setText("")

    self.Button_equip:setVisible(false)
    self.Button_change:setVisible(false)
    self.Button_unequip:setVisible(false)

    if self.oldSelectItem then
        local Image_select = TFDirector:getChildByPath(self.oldSelectItem, "Image_select")
        Image_select:setVisible(false)
    end
    self.oldSelectItem = nil

    self:updateSkillArrayByType()
end

function GongMingMainView:updateSkillArrayByType()
    self:updateSkillItems()
end

function GongMingMainView:updateSkillItems()

    local skillArrayData = ResonanceDataMgr:getUnLockArrayDataByType(self.skillType)
    skillArrayData = skillArrayData or {}
    table.sort(skillArrayData,function (a,b)
        local cfgA = ResonanceDataMgr:getManaResonanceCfg(a)
        local cfgB = ResonanceDataMgr:getManaResonanceCfg(b)
        if cfgA.quality == cfgB.quality then
            return cfgA.id < cfgB.id
        end
        return cfgA.quality > cfgB.quality
    end)
    self.Label_gongmingMainView_tip:setVisible(#skillArrayData == 0)
    local oldItem = self.GridView_item:getItems()
    local gap = #skillArrayData - #oldItem
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.GridView_item:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.GridView_item:removeItem(1)
        end
    end

    self.skillItem = {}
    local selectItem,selectData
    local items = self.GridView_item:getItems()
    for k,v in ipairs(items) do
        local data = skillArrayData[k]
        self.skillItem[data] = v
        self:updateGoodsItem(v, data)
        if not self.oldSelectItem then
            self:selectSkillItem(v,data)
        end
    end
end


function GongMingMainView:updateGoodsItem(item, cid)

    local cfg = ResonanceDataMgr:getManaResonanceCfg(cid)
    if not cfg then
        return
    end

    local Image_nomal = TFDirector:getChildByPath(item, "Image_nomal")
    local Image_equiped = TFDirector:getChildByPath(item, "Image_equiped")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Label_lv = TFDirector:getChildByPath(item, "Label_lv")
    local Image_lv_bg = TFDirector:getChildByPath(item, "Image_lv_bg")

    local quality = cfg.quality
    if EC_ItemIcon[quality+1] then
        Image_nomal:setTexture(EC_ItemIcon[quality+1])
    end

    Image_lv_bg:show()
    Image_icon:setTexture(cfg.icon)

    local equipedSlot = ResonanceDataMgr:getEquipedSlotId(cid)
    Image_equiped:setVisible(equipedSlot ~= 0)

    local level = ResonanceDataMgr:getSkillLv(cid)
    Label_lv:setText("Lv."..level)

    Image_nomal:onClick(function()
        self:selectSkillItem(item, cid)
    end)
end

function GongMingMainView:selectSkillItem(item,cid)

    self.selectCid = cid
    self:updateHandleBtn()

    local cfg = ResonanceDataMgr:getManaResonanceCfg(cid)
    if cfg then
        self.Label_name:setTextById(cfg.name)
        self.Image_name_bg:show()
        local lv = ResonanceDataMgr:getSkillLv(cid)
        lv = lv or 0
        self.Label_desc:setText("")
        local curpassiveSkillId = ResonanceDataMgr:getPassiveSkillId(cid,lv)
        if curpassiveSkillId then
            local curCfg = ResonanceDataMgr:getPassiveSkillCfg(curpassiveSkillId)
            if curCfg then
                self.Label_desc:setTextById(curCfg.des)
            end
        end

    else
        self.Label_name:setText("")
        self.Label_desc:setText("")
    end

    if not item or not cid then
        return
    end

    if self.oldSelectItem then
        local Image_select = TFDirector:getChildByPath(self.oldSelectItem, "Image_select")
        Image_select:setVisible(false)
    end

    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    Image_select:setVisible(true)
    self.oldSelectItem = item
end

function GongMingMainView:chooseSlot(slotId)
    local pos = self.slot_[slotId].slot:getPosition()
    self.Image_slot_select:setPosition(pos)
    self.selectSlotId = slotId
    self:updateHandleBtn()

    local equipedCid = ResonanceDataMgr:getEquipedSkills(slotId)
    if equipedCid == 0 then
        return
    end
    print(equipedCid)
    self:selectSkillItem(self.skillItem[equipedCid],equipedCid)
end

function GongMingMainView:updateHandleBtn()

    self.Button_equip:setVisible(false)
    self.Button_change:setVisible(false)
    self.Button_unequip:setVisible(false)

    ---没有可选中装备
    if not self.selectCid then
        return
    end
    local equipedCid = ResonanceDataMgr:getEquipedSkills(self.selectSlotId)
    local slot = ResonanceDataMgr:getEquipedSlotId(self.selectCid)
    print(equipedCid,slot)
    if equipedCid == 0 then
        if slot == 0 then
            self.Button_equip:setVisible(true)
        end
    else
        if slot == self.selectSlotId then
            self.Button_unequip:setVisible(true)
        else
            self.Button_change:setVisible(slot == 0)
        end
    end

end

function GongMingMainView:onRecvAfterEquipSkill(slotId,cid)
    self:updateSlotSkills()
    self:updateSkillItems()
    self:selectSkillItem(self.oldSelectItem,self.selectCid)
    self:updateHandleBtn()

end

function GongMingMainView:onRecvUpgrade()
    self:updateSkillItems()
    self:selectSkillItem(self.skillItem[self.selectCid],self.selectCid)
end

function GongMingMainView:registerEvents()

    EventMgr:addEventListener(self, EV_AFTER_UPGRADE_GM_SKILL, handler(self.onRecvUpgrade, self))
    EventMgr:addEventListener(self, EV_AFTER_HANDLE_GM_SKILL, handler(self.onRecvAfterEquipSkill, self))

    for k,v in ipairs(self.checkBox_) do
        v.btn:onClick(function()
            self:chooseType(k)
        end)
    end

    self.Button_checklist:onClick(function()
        Utils:openView("fairyNew.GongMingMenuView")
    end)

    for k,v in ipairs(self.slot_) do
        v.slot:onClick(function()
            self:chooseSlot(k)
        end)
    end

    self.Button_equip:onClick(function()
        if not self.selectSlotId or not self.selectCid then
            return
        end
        ResonanceDataMgr:Send_EquipSkill(self.selectSlotId,self.selectCid)
    end)

    self.Button_change:onClick(function()
        if not self.selectSlotId or not self.selectCid then
            return
        end
        ResonanceDataMgr:Send_EquipSkill(self.selectSlotId,self.selectCid)
    end)

    self.Button_unequip:onClick(function()
        if not self.selectSlotId or not self.selectCid then
            return
        end
        ResonanceDataMgr:Send_EquipSkill(self.selectSlotId,0)
    end)
end

return GongMingMainView