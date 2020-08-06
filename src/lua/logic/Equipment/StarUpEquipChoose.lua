local StarUpEquipChoose = class("StarUpEquipChoose", BaseLayer)

function StarUpEquipChoose:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.Equip.StarUpEquipChoose")
end

function StarUpEquipChoose:initData(data)
    self.equipId = data.id 
    self.equipCid = data.cid
    self.equipType = data.sType
    self.starNum = data.star
    self.limitNum = data.limit
    self.choosedData = data.choosed
    self:initEquipData()
    self.equip_items = {}
end

function StarUpEquipChoose:initEquipData()
    self.equipData = EquipmentDataMgr:getStarUpEquipsByCidAndStar(self.equipCid, self.equipType, self.starNum)
    local tmpData = {}
    for i,v in ipairs(self.equipData) do
        local vCfg = TabDataMgr:getData("Equipment",v.cid)
        if v.id ~= self.equipId and vCfg.showType ~= 1 then
            table.insert(tmpData, v)
        end
    end
    self.equipData = tmpData
end

function StarUpEquipChoose:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    
    self.Panel_teshu_item = TFDirector:getChildByPath(ui, "Panel_teshu_item")
    self.Panel_equip_item = TFDirector:getChildByPath(ui, "Panel_equip_item")
    self.Panel_equip_item:setScale(0.8)

    local ScrollView_item    = TFDirector:getChildByPath(ui,"ScrollView_item")
    self.GridView_item = UIGridView:create(ScrollView_item)
    self.GridView_item:setItemModel(self.Panel_equip_item)
    self.GridView_item:setColumn(7)
    self.GridView_item:setColumnMargin(13)
    self.GridView_item:setRowMargin(8)

    local Equip_item = TFDirector:getChildByPath(ui, "Equip_item")
    self.Label_name = TFDirector:getChildByPath(Equip_item, "Label_name")
    self.Label_num = TFDirector:getChildByPath(Equip_item, "Label_num")
    self.Image_equip_bg = TFDirector:getChildByPath(Equip_item, "Image_equip_bg")
    self.Image_equip_icon = TFDirector:getChildByPath(Equip_item, "Image_equip_icon")
    self.Label_equip_level = TFDirector:getChildByPath(Equip_item, "Label_equip_level")

    for i=1,5 do
        self["Image_star"..i] = TFDirector:getChildByPath(Equip_item,"Image_star"..i)
    end
    
    local ScrollView_attrs    = TFDirector:getChildByPath(ui,"ScrollView_attrs")
    self.ScrollView_attrs = UIListView:create(ScrollView_attrs)
    
    self:refreshUI()
end

function StarUpEquipChoose:refreshUI()
    if self.choosedData then
        self.curSelectEquip = self.choosedData
    end
    self:updateEquipUI()
    self:updateAttrUI()
    self.loadIndex = 1
    local items = self.GridView_item:getItems()
    local gap = #items - #self.equipData
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.GridView_item:removeItem(1)
        end
    end

    local function loadEquipItem()
        if self.loadIndex > #self.equipData then
            return
        end
        local item = self.GridView_item:getItem(self.loadIndex)
        if not item then
            item = self.Panel_equip_item:clone()
            self.GridView_item:pushBackCustomItem(item)
            table.insert(self.equip_items, item)
        end
        self:updateEquipItem(self.loadIndex, item)
        local seq = Sequence:create({
                DelayTime:create(0.02),
                CallFunc:create(function()
                        self.loadIndex = self.loadIndex + 1
                        loadEquipItem()
                end)
        })
        self.ui:stopAllActions()
        self.ui:runAction(seq)
    end
    loadEquipItem()
end

function StarUpEquipChoose:updateEquipItem(idx,item)
    local info = self.equipData[idx]
    local id = info.id
    local starLv = EquipmentDataMgr:getEquipStarLv(id)
    local quality = EquipmentDataMgr:getEquipQuality(id)

    local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item,"Label_lv")
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id))

    local stepLabel = TFDirector:getChildByPath(item,"label_level_step")
    stepLabel:setText(EquipmentDataMgr:getStepText(id))

    --星级
    for i=1,5 do
        if i > starLv then
            TFDirector:getChildByPath(item,"Image_star"..i):setVisible(false)
        end    
    end

    local Image_back    = TFDirector:getChildByPath(item,"Image_back")
    Image_back:setTexture(EC_ItemIcon[quality])

    --是否使用中
    local isuse         = EquipmentDataMgr:isUesing(id)
    local useIcon       = TFDirector:getChildByPath(item,"Image_use")
    useIcon:setVisible(isuse)

    local iconpath      = EquipmentDataMgr:getEquipIcon(id)
    local icon          = TFDirector:getChildByPath(item,"Image_equip")
    icon:setTexture(iconpath)
    icon:Size(CCSizeMake(100,100))    

    local typeIcon      = TFDirector:getChildByPath(item,"Image_type")
    local subType       = EquipmentDataMgr:getEquipSubType(id)
    typeIcon:setTexture(EC_EquipSubTypeIcon2[subType])
    typeIcon:Size(CCSizeMake(24,24))
    local Image_lock  = TFDirector:getChildByPath(item,"Image_lock")
    Image_lock:setVisible(EquipmentDataMgr:getEquipIsLock(id))

    local selectImg     = TFDirector:getChildByPath(item,"Image_select")
    selectImg:setVisible(false)
    if self.curSelectEquip and self.curSelectEquip.id == info.id then
        selectImg:setVisible(true)
        self.selectImage = selectImg
    end

    item:setTouchEnabled(true)
    item:onClick(function()
        if EquipmentDataMgr:getEquipIsLock(id) then
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                EquipmentDataMgr:changeEquipLockStatus(id)
            end)
            view:setContent(TextDataMgr:getText(1200056))
            return
        elseif EquipmentDataMgr:isUesing(id) then
            local herosid = tonumber(EquipmentDataMgr:getHeroSid(info.id))
            local heroconf = TabDataMgr:getData("Hero", herosid)
            if heroconf then
                local view = Utils:openView("common.ConfirmBoxView")
                view:setCallback(function()
                    EquipmentDataMgr:takeOffEquipment(herosid, info.id, EquipmentDataMgr:getPosition(info.id))
                end)
                view:setRContent("r130001", TextDataMgr:getText(heroconf.nameTextId))
            end
            return
        end
        if self.selectImage then
            self.selectImage:setVisible(false)
        end
        selectImg:setVisible(true)
        self.selectImage = selectImg
        self.curSelectEquip = info
        self:updateEquipUI()
        self:updateAttrUI()
    end)

end

function StarUpEquipChoose:updateEquipUI()
    self.Label_equip_level:setText("")
    if self.curSelectEquip then
        self.Label_name:setString(EquipmentDataMgr:getEquipName(self.curSelectEquip.cid)..EquipmentDataMgr:getStepText(self.curSelectEquip.cid))
        self.Image_equip_bg:setTexture(EC_ItemIcon[EquipmentDataMgr:getEquipQuality(self.curSelectEquip.cid)])
        self.Image_equip_icon:setTexture(EquipmentDataMgr:getEquipIcon(self.curSelectEquip.cid))
        self.Label_equip_level:setText("Lv."..EquipmentDataMgr:getEquipLv(self.curSelectEquip.id))
    elseif self.equipCid then
        self.Label_name:setString(EquipmentDataMgr:getEquipName(self.equipCid))
        self.Image_equip_bg:setTexture(EC_ItemIcon[EquipmentDataMgr:getEquipQuality(self.equipCid)])
        self.Image_equip_icon:setTexture(EquipmentDataMgr:getEquipIcon(self.equipCid))
    else
        self.Image_equip_bg:setTexture(EC_ItemIcon[4])
        self.Image_equip_icon:setTexture("ui/Equipment/new_ui/random_icon.png")
        if self.equipType > 0 then
            local nameId = 402000 + self.equipType
            local typeName = TextDataMgr:getText(nameId)
            self.Label_name:setTextById(490302, tostring(self.starNum), typeName,tostring(self.limitNum))
        else
            self.Label_name:setTextById(100000311 ,tostring(self.starNum))
        end
    end
    
    self.Label_num:setString("x"..self.limitNum)

    for i=1,5 do
        self["Image_star"..i]:setVisible(self.starNum >= i)
    end
end

function StarUpEquipChoose:addEquipToSelect(data)
    
end

function StarUpEquipChoose:updateAttrUI()
    self.ScrollView_attrs:removeAllItems()
    if not self.curSelectEquip then
        return 
    end
    if EquipmentDataMgr:getIsHaveSpecialAttr(self.curSelectEquip.id) then
        local specialAttrs = EquipmentDataMgr:getEquipSpecialAttrs(self.curSelectEquip.id)
        for k,v in ipairs(specialAttrs) do
            local Panel_teshu_item = self.Panel_teshu_item:clone()
            local desc = TFDirector:getChildByPath(Panel_teshu_item,"Label_title")
            desc:setString(v.desc)
            local Image_zhuangshi = TFDirector:getChildByPath(Panel_teshu_item,"Image_zhuangshi")
            Image_zhuangshi:setTexture(EC_equip_Special_icon[v.level])
            self.ScrollView_attrs:pushBackCustomItem(Panel_teshu_item)
        end
    end
end

function StarUpEquipChoose:changeLockStateBack()
    self:initEquipData()
    if self.curSelectEquip then
        self.choosedData = clone(self.curSelectEquip)
    end
    self:refreshUI()
end

function StarUpEquipChoose:changeEquipStateBack()
    self:initEquipData()
    if self.curSelectEquip then
        self.choosedData = clone(self.curSelectEquip)
    end
    self:refreshUI()
end

function StarUpEquipChoose:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_LOCK_RESULT,handler(self.changeLockStateBack, self))
    EventMgr:addEventListener(self,EV_EQUIPMENT_OPERATION,handler(self.changeEquipStateBack, self))
    
    self.Button_ok:onClick(function()
        if self.curSelectEquip and self.curSelectEquip.level > 1 then
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                EventMgr:dispatchEvent(EQUIPMENT_STAR_UP_EQUIP_CHOOSE, self.curSelectEquip)
                AlertManager:closeLayer(self)
            end)
            view:setContent(TextDataMgr:getText(490408))
        else
            EventMgr:dispatchEvent(EQUIPMENT_STAR_UP_EQUIP_CHOOSE, self.curSelectEquip)
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return StarUpEquipChoose