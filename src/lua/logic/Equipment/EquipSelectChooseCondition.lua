local EquipSelectChooseCondition = class("EquipSelectChooseCondition", BaseLayer)


function EquipSelectChooseCondition:ctor(chooseConditionData)
    self.super.ctor(self,data)
    self.suitModels = {}
    self.selectState = chooseConditionData.selectState
    self.isSingle = chooseConditionData.isSingle
    self:init("lua.uiconfig.Equip.EquipSelectChooseCondition")
end

function EquipSelectChooseCondition:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
    self:showTopBar()

    self.Panel_suit_model = TFDirector:getChildByPath(ui, "Panel_suit_model")
    self.ScrollView_suit = TFDirector:getChildByPath(ui, "ScrollView_suit")
    self.Panel_batch = TFDirector:getChildByPath(ui, "Panel_batch")

    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_reset = TFDirector:getChildByPath(ui, "Button_reset")
    self.CheckBox_single = TFDirector:getChildByPath(self.ui, "CheckBox_single")
    self.CheckBox_single:setSelectedState(self.isSingle)

    self.GridView_suit = UIGridView:create(self.ScrollView_suit)
    self.GridView_suit:setItemModel(self.Panel_suit_model)
    self.GridView_suit:setColumn(3)
    self.GridView_suit:setColumnMargin(10)
    self.GridView_suit:setRowMargin(10)
    self:initGridView()
end

function EquipSelectChooseCondition:initGridView()
    self.suitCfgs = EquipmentDataMgr:getAllEquipSuitCfgs()
    for i, v in ipairs(self.suitCfgs) do
        local model = self.Panel_suit_model:clone()
        self.GridView_suit:pushBackCustomItem(model)
        self.suitModels[i] = model
    end
    self:updateSuitModelItems()
end

function EquipSelectChooseCondition:updateSuitModelItems()
    for i, model in ipairs(self.suitModels) do
        local suitCfg = TabDataMgr:getData("EquipmentSuit",self.suitCfgs[i].suitId)
        local cids = self.suitCfgs[i].equipCids
        model:getChildByName("Label_suit_title"):setTextById(suitCfg.suitNewPokedex)
        local Image_model_bg = model:getChildByName("Image_model_bg")
        local Image_select = model:getChildByName("Image_select")
        if self.selectState[i] then
            Image_select:setVisible(true)
        else
            Image_select:setVisible(false)
        end
        Image_model_bg:setTouchEnabled(true)
        Image_model_bg:onClick(function()
            if self.selectState[i] then
                self.selectState[i] = nil
            else
                self.selectState[i] = true
            end
            self:updateSuitModelItems()
        end)
        for j=1,3 do
            local item = model:getChildByName("item"..j)
            if cids[j] then
                item:show()
                local starLv = EquipmentDataMgr:getEquipStarLv(cids[j])
                local quality = EquipmentDataMgr:getEquipQuality(cids[j])

                local Image_level_bg = TFDirector:getChildByPath(item,"Image_level_bg")
                local Label_lv_title = TFDirector:getChildByPath(item,"Label_lv_title")
                local LvLabel = TFDirector:getChildByPath(item,"Label_lv")
                Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
                Label_lv_title:setString("Lv.")
                LvLabel:setString(EquipmentDataMgr:getEquipLv(cids[j]))

                for k=1,5 do
                    if k > starLv then
                        TFDirector:getChildByPath(item,"Image_star"..k):setVisible(false)
                    end    
                end

                local Image_back    = TFDirector:getChildByPath(item,"Image_back")
                Image_back:setTexture(EC_ItemIcon[quality])

                local iconpath      = EquipmentDataMgr:getEquipIcon(cids[j])
                local icon          = TFDirector:getChildByPath(item,"Image_equip")
                icon:setTexture(iconpath)
                icon:Size(CCSizeMake(100,100))

                local typeIcon      = TFDirector:getChildByPath(item,"Image_type")
                local subType       = EquipmentDataMgr:getEquipSubType(cids[j])
                typeIcon:setTexture(EC_EquipSubTypeIcon2[subType])
                typeIcon:Size(CCSizeMake(24,24))

                Image_back:setTouchEnabled(true)
                Image_back:onClick(function()
                    Utils:showInfo(cids[j])
                end)
            else
                item:hide()
            end
        end

    end
end

function EquipSelectChooseCondition:updateBtnState()
    self.Button_rename:setTouchEnabled(false)
    self.Button_rename:setGrayEnabled(true)
    local info = self.backUpInfos[self.selectIdx]
    if self.isSave then
        if info then
            self.Button_save:getChildByName("Label_save"):setText("替 换")
        else
            self.Button_save:getChildByName("Label_save"):setText("保 存")
        end
    else
        self.Button_use:setTouchEnabled(false)
        self.Button_use:setGrayEnabled(true)
        if info then
            self.Button_use:setTouchEnabled(true)
            self.Button_use:setGrayEnabled(false)
        end
    end
    if info then
        self.Button_rename:setTouchEnabled(true)
        self.Button_rename:setGrayEnabled(false)
    end
end

function EquipSelectChooseCondition:registerEvents()
	self.Button_ok:onClick(function ()
        local equipCids = {}
        for k, v in pairs(self.selectState) do
            local info = self.suitCfgs[tonumber(k)]
            if info then 
                for i, cid in ipairs(info.equipCids) do
                    equipCids[#equipCids + 1] = cid
                end
            end
        end
        EventMgr:dispatchEvent(EQUIPMENT_SELECT_CHOOSE_CONDITION,{selectState = clone(self.selectState),cids = equipCids, isSingle = self.isSingle})
        AlertManager:close(self)
    end)

    self.Button_reset:onClick(function()
        self.selectState = {}
        self:updateSuitModelItems()
    end)

    self.CheckBox_single:onEvent(function(event)
        if event.name == "selected" then
            self.isSingle = true
        else
            self.isSingle = false
        end
    end)
end

function EquipSelectChooseCondition:onHide()
	self.super.onHide(self)
end

function EquipSelectChooseCondition:onShow()
    self.super.onShow(self)
end

return EquipSelectChooseCondition
