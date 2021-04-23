local EquipReviewLayer = class("EquipReviewLayer", BaseLayer)


function EquipReviewLayer:ctor(data)
    self.super.ctor(self,data)
    self.showHeroId = data.heroId
    self.isSave = data.isSave
    self.suitModels = {}
    self.selectIdx = 1
    self:init("lua.uiconfig.Equip.EquipReviewLayer")
end

function EquipReviewLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
    self:showTopBar()

    self.Panel_suit_model = TFDirector:getChildByPath(ui, "Panel_suit_model")
    self.Panel_equip_model = TFDirector:getChildByPath(ui, "Panel_equip_model")
    self.ScrollView_suit = TFDirector:getChildByPath(ui, "ScrollView_suit")

    self.Button_save = TFDirector:getChildByPath(ui, "Button_save")
    self.Button_use = TFDirector:getChildByPath(ui, "Button_use")
    self.Button_rename = TFDirector:getChildByPath(ui, "Button_rename")

    self.GridView_suit = UIGridView:create(self.ScrollView_suit)
    self.GridView_suit:setItemModel(self.Panel_suit_model)
    self.GridView_suit:setColumn(3)
    self.GridView_suit:setColumnMargin(-10)
    self.GridView_suit:setRowMargin(0)
    self.Button_save:setVisible(self.isSave)
    self.Button_use:setVisible(not self.isSave)

    self:initGridView()
end

function EquipReviewLayer:initGridView()
    local count = TabDataMgr:getData("DiscreteData",52001).data.max
    for i = 1, count do
        local model = self.Panel_suit_model:clone()
        self.GridView_suit:pushBackCustomItem(model)
        model:hide()
        self.suitModels[i] = model
    end
end

function EquipReviewLayer:updateGridUI(isForce)
    self.backUpInfos = EquipmentDataMgr:getSortEquipBackUpInfo()
    for i, model in ipairs(self.suitModels) do
        model:show()
        local Image_model_bg = TFDirector:getChildByPath(model, "Image_model_bg")
        local Label_tips = TFDirector:getChildByPath(model, "Label_tips")
        local Panel_info = TFDirector:getChildByPath(model, "Panel_info")
        local info = self.backUpInfos[i]
        if info then
            Label_tips:hide()
            Panel_info:show()
            if isForce then
                local Label_suit_name = TFDirector:getChildByPath(Panel_info, "Label_suit_name")
                Label_suit_name:setText(info.desc)
                for pos = 1, 3 do
                    local Image_pos = TFDirector:getChildByPath(Panel_info, "Image_pos"..pos)
                    Image_pos:removeAllChildren()
                    if info.detail then
                        for k, v in pairs(info.detail) do
                            if v.position == pos then
                                local equipItem = self.Panel_equip_model:clone()
                                equipItem:show()
                                equipItem:setPosition(ccp(0,0))
                                Image_pos:addChild(equipItem)
                                self:updateEquipItem(equipItem, v.equipId)
                            end
                         end 
                     end
                end
            end
            if self.selectIdx == i then
                Image_model_bg:setTexture("ui/Equipment/new_ui/shaixuan/ui_005.png")
            else
                Image_model_bg:setTexture("ui/Equipment/new_ui/shaixuan/ui_004.png")
            end
        else
            Panel_info:hide()
            Label_tips:show()
            if self.selectIdx == i then
                Image_model_bg:setTexture("ui/Equipment/new_ui/shaixuan/ui_003.png")
            else
                Image_model_bg:setTexture("ui/Equipment/new_ui/shaixuan/ui_002.png")
            end
        end
        if isForce then
            Image_model_bg:setTouchEnabled(true)
            Image_model_bg:onClick(function()
                self.selectIdx = i
                self:updateGridUI(false)
            end)
        end
    end

    self:updateBtnState()
end

function EquipReviewLayer:updateBtnState()
    self.Button_rename:setTouchEnabled(false)
    self.Button_rename:setGrayEnabled(true)
    local info = self.backUpInfos[self.selectIdx]
    if self.isSave then
        if info then
            self.Button_save:getChildByName("Label_save"):setTextById(900251)
        else
            self.Button_save:getChildByName("Label_save"):setTextById(2107022)
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

function EquipReviewLayer:updateEquipItem(item,equipId)
    local equipCfg = EquipmentDataMgr:getEquipCfg(EquipmentDataMgr:getEquipCid(equipId))
    item:getChildByName("Image_equip_back"):setTexture(EC_EquipBoard[equipCfg.quality])
    item:getChildByName("Image_frame"):setTexture(EC_EquipFrame[equipCfg.quality])
    for t = 1, 5 do
        item:getChildByName("Image_star_"..t):setVisible(t <= equipCfg.star)
    end
    item:getChildByName("Label_levelTitle"):setTextById(800006, "")
    item:getChildByName("Label_level"):setText(EquipmentDataMgr:getEquipLv(equipId))
    item:getChildByName("Image_type"):setTexture(EC_EquipSubTypeIconBag[equipCfg.subType])
    item:getChildByName("Label_cost"):setText(equipCfg.cost)
    item:getChildByName("Image_icon"):setTexture(equipCfg.halfPaint)
end

function EquipReviewLayer:onRecvBackUpInfo(data)
    self:updateGridUI(true)
end

function EquipReviewLayer:onRecvUseBackUpInfo(data)
    AlertManager:closeLayer(self)
end

function EquipReviewLayer:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_BACKUP_INFO,handler(self.onRecvBackUpInfo, self))
    EventMgr:addEventListener(self,EQUIPMENT_USE_BACKUP_INFO,handler(self.onRecvUseBackUpInfo, self))


	self.Button_save:onClick(function ()
        local function saveSuit()
            local equipInfos = {}
            for i=1,3 do
                local ishave = HeroDataMgr:getIsHaveEquip(self.showHeroId ,i)
                if ishave then
                    local equipmentId = HeroDataMgr:getEquipIdByPos(self.showHeroId,i)
                    table.insert(equipInfos,{i, equipmentId})
                end
            end
            EquipmentDataMgr:ReqSaveEquipBackupPos(self.selectIdx, equipInfos)
        end
        local info = self.backUpInfos[self.selectIdx]
        if info then
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(saveSuit)
            view:setContent(100000127)
        else
            saveSuit()
        end
    end)

    self.Button_use:onClick(function()
        local info = self.backUpInfos[self.selectIdx]
        local useEquipBackup = function(show)
            EquipmentDataMgr:ReqUseEquipBackup(self.selectIdx,self.showHeroId)
            AlertManager:close(self)
        end
        local nameStr = ""
        local state = false
        for k, v in pairs(info.detail) do
            if EquipmentDataMgr:isUesing(v.equipId) then
                local heroCid = tonumber(EquipmentDataMgr:getHeroSid(v.equipId))
                if self.showHeroId ~= heroCid then
                    state = true
                    nameStr = nameStr..HeroDataMgr:getNameById(heroCid).."  "
                end
            end
        end
        if state then
            Utils:openView("common.ChangeEquipConfirmView", { heroName = nameStr, callback = useEquipBackup})
        else
            useEquipBackup()
        end
    end)

    self.Button_rename:onClick(function()
        local function modifyName(txt)
            EquipmentDataMgr:ReqSaveEquipBackupDecr(self.selectIdx, txt)
        end
        Utils:openView("Equipment.ModifySuitNameView", {okClickReqCallback = modifyName})
    end)
end

function EquipReviewLayer:onHide()
	self.super.onHide(self)
end

function EquipReviewLayer:onShow()
    self.super.onShow(self)
    EquipmentDataMgr:ReqEquipBackupInfo()
end

return EquipReviewLayer
