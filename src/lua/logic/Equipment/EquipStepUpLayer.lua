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
*  质点突破界面
* 
]]

local EquipStepUpLayer = class("EquipStepUpLayer", BaseLayer)

function EquipStepUpLayer:ctor(data)
    self.super.ctor(self, data)
    self:initData(data)
    self:init("lua.uiconfig.Equip.EquipStepUpLayer")
end

function EquipStepUpLayer:initData(data)
	self.loadedIndex_ = 1
	self.equipId = data.equipmentId
	self.equips = {}
	if data.equips then
		--去掉经验质点
		for i = 1, #data.equips do
			if EquipmentDataMgr:getEquipSubType(data.equips[i]) ~= EC_EquipSubType.Daat then
				self.equips[#self.equips + 1] = data.equips[i]
			end
		end
	end

    self.fromBag = data.fromBag
    --todo by beck 暂时屏蔽切换质点
    -- self.fromBag = false
    local idx = table.indexOf(self.equips, self.equipId)
    self.equipPageIdx = idx > 0 and idx or 1

    self.allList = EquipmentDataMgr:getStepUpEquipList(self.equipId)
    self.selectTab = 1
    self:updateListByTab()
end

function EquipStepUpLayer:grouping(list)
	local showList = {}
	local num = 0
	local idx = 0
	for i, v in ipairs(list) do
        if EquipmentDataMgr:getEquipStarLevel(v) <= 0 then   --如果星级不为0 那么排除显示
            num = num + 1
            if num % 4 == 1 then
                idx = idx + 1
            end
            showList[idx] = showList[idx] or {}
            table.insert(showList[idx], v)
        end
	end
	return showList, num
end

function EquipStepUpLayer:initUI(ui)
	self.super.initUI(self, ui)
    self:showTopBar()

    self.Label_name = TFDirector:getChildByPath(self.ui, "Label_name")
    self.Image_Equip = TFDirector:getChildByPath(self.ui, "Image_Equip")

    for i = 1, 5 do
        TFDirector:getChildByPath(self.ui, "Image_star" .. i):hide()
    end

    local ScrollView_Right = TFDirector:getChildByPath(ui, "ScrollView_right")
    self.ListView_right = UIListView:create(ScrollView_Right)
    self.ListView_right:setItemsMargin(15)
    self.rightItem = TFDirector:getChildByPath(ui, "Panel_item"):hide()

    self.label_tip = TFDirector:getChildByPath(ui, "label_tip"):hide()

    self.changeBtn = TFDirector:getChildByPath(ui, "Button_change")
    self.Button_open = TFDirector:getChildByPath(ui, "Button_open")
    self.Image_buttons = TFDirector:getChildByPath(ui, "Image_buttons")
    self.Button_all = TFDirector:getChildByPath(ui, "Button_all")
    self.Button_unEquip = TFDirector:getChildByPath(ui, "Button_unEquip")
    self.Button_UnStepUp = TFDirector:getChildByPath(ui, "Button_UnStepUp")
    self.Label_title = TFDirector:getChildByName(self.Button_open, "Label_title")
    self.Label_title:setTextById(111000087)

    local Panel_attr = TFDirector:getChildByPath(ui, "Panel_attr")
    self.old_lv = TFDirector:getChildByPath(Panel_attr, "old_lv")
    self.old_hp = TFDirector:getChildByPath(Panel_attr, "old_hp")
    self.old_atk = TFDirector:getChildByPath(Panel_attr, "old_atk")
    self.old_def = TFDirector:getChildByPath(Panel_attr, "old_def")

    self.cur_lv = TFDirector:getChildByPath(Panel_attr, "cur_lv"):hide()
    self.cur_atk = TFDirector:getChildByPath(Panel_attr, "cur_atk"):hide()
    self.cur_def = TFDirector:getChildByPath(Panel_attr, "cur_def"):hide()
    self.cur_hp = TFDirector:getChildByPath(Panel_attr, "cur_hp"):hide()

    self.lv_arrow = TFDirector:getChildByPath(Panel_attr, "lv_arrow"):hide()
    self.atk_arrow = TFDirector:getChildByPath(Panel_attr, "atk_arrow"):hide()
    self.def_arrow = TFDirector:getChildByPath(Panel_attr, "def_arrow"):hide()
    self.hp_arrow = TFDirector:getChildByPath(Panel_attr, "hp_arrow"):hide()

    self.old_lv:setText("0")
    self.old_hp:setText("0")
    self.old_atk:setText("0")
    self.old_def:setText("0")

    self:updateEquipIcon()
    self:updateEquipInfo()
    self:loadEquipMent()
end

function EquipStepUpLayer:updateEquipIcon()
	local equipCid = EquipmentDataMgr:getEquipCid(self.equipId)
	local itemCfg = GoodsDataMgr:getItemCfg(equipCid)
    local paintPath = EquipmentDataMgr:getEquipPaint(self.equipId)
    self.Image_Equip:setTexture(paintPath)
    local pos = EquipmentDataMgr:getEquipPaintPosition(self.equipId)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.equipId)
    self.Image_Equip:setScale(scale)
    self.Image_Equip:setPosition(pos)

    if self.fromBag and self.equips then
        local idx = table.indexOf(self.equips, self.equipId)
        self.equipPageIdx = idx > 0 and idx or 1
        self.equipPos_ = pos
    end
end

function EquipStepUpLayer:updateEquipInfo()
	local equipCid = EquipmentDataMgr:getEquipCid(self.equipId)
	local itemCfg = GoodsDataMgr:getItemCfg(equipCid)
    local name = EquipmentDataMgr:getEquipName(self.equipId)   
    self.Label_name:setString(name ..EquipmentDataMgr:getStepText(self.equipId)) 
    self.Label_name:setColor(EC_EQUIP_STEP_COLOR[EquipmentDataMgr:getEquipQuality(self.equipId)])

    local equipStep = EquipmentDataMgr:getEquipStep(self.equipId)
	self.old_lv:setText(equipStep)

    self.old_hp:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.HP))
    self.old_atk:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.ATK))
    self.old_def:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.DEF))

    if itemCfg.maxAdvanced and equipStep >= itemCfg.maxAdvanced then
    	self.old_lv:setText("MAX")
    else
    	if self.currentId == nil then
    		return
    	end

    	self.cur_lv:show()
    	self.cur_atk:show()
    	self.cur_def:show()
    	self.cur_hp:show()
    	self.lv_arrow:show()
    	self.atk_arrow:show()
    	self.def_arrow:show()
    	self.hp_arrow:show()

    	local nextStep = equipStep + 1
    	if itemCfg.maxAdvanced and nextStep >= itemCfg.maxAdvanced then
    		self.cur_lv:setText("MAX")
            self.cur_hp:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.HP, nextStep))
            self.cur_atk:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.ATK, nextStep))
            self.cur_def:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.DEF, nextStep))
    	else
    		self.cur_lv:setText(nextStep)

            self.cur_hp:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.HP, nextStep))
            self.cur_atk:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.ATK, nextStep))
            self.cur_def:setText(EquipmentDataMgr:getEquipmentAttrById(self.equipId, EC_Attr.DEF, nextStep))
    	end
    end
end

function EquipStepUpLayer:loadEquipMent()
	self.label_tip:hide()
	if #self.showList <= 0 then
		self.label_tip:show()
	end

    local loadedIndex = self.loadedIndex_
    if loadedIndex <= 1 then
        self.ListView_right:removeAllItems()
    end
    if loadedIndex > #self.showList then
        return 
    end
    local count  = self.equipCnt - ((loadedIndex - 1) * 4)

    local item = self.ListView_right:getItem(loadedIndex)
    if not item then
        item = self.rightItem:clone()
        item:show()
        self.ListView_right:pushBackCustomItem(item)
        item:Alpha(0)
    end
    local idx = 1
    for i = 1, 4 do
        local subItem = TFDirector:getChildByPath(item, "item" .. i)
        if idx <= count then
            local id = self.showList[loadedIndex][i]
            subItem.id = id
            self:updateOneEquipment(id, subItem)
        else
            subItem:setVisible(false)
        end
        idx = idx + 1
    end

    local delayDuration = 0.06
    item:fadeIn(0.2)
    local action = Sequence:create({
        DelayTime:create(delayDuration),
        CallFunc:create(function()
            self.loadedIndex_ = loadedIndex + 1
            self:loadEquipMent()
        end)
    })
    item:runAction(action)
end

function EquipStepUpLayer:updateOneEquipment(id, item)
    local starLv = EquipmentDataMgr:getEquipStarLv(id);
    local quality = EquipmentDataMgr:getEquipQuality(id)
    local Image_level_bg = TFDirector:getChildByPath(item, "Image_level_bg")
    local Label_lv_title = TFDirector:getChildByPath(item, "Label_lv_title")
    local LvLabel = TFDirector:getChildByPath(item, "Label_lv")
    Image_level_bg:setTexture(EC_ItemLevelIcon[quality])
    Label_lv_title:setString("Lv.")
    LvLabel:setString(EquipmentDataMgr:getEquipLv(id))

    local stepLabel = TFDirector:getChildByPath(item, "label_level_step")
    stepLabel:setText(EquipmentDataMgr:getStepText(id))
    
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

    --是否使用中
    local isuse = EquipmentDataMgr:isUesing(id)
    local useIcon = TFDirector:getChildByPath(item, "Image_use")
    useIcon:setVisible(isuse)

    local iconpath = EquipmentDataMgr:getEquipIcon(id);
    local icon = TFDirector:getChildByPath(item, "Image_equip")
    icon:setTexture(iconpath)
    icon:Size(CCSizeMake(100, 100))

    local selectImg = TFDirector:getChildByPath(item, "Image_select")
    item.selectImg = selectImg
    selectImg:setVisible(false)

    if id == self.currentId then
        self.selectItem = item
        selectImg:setVisible(true)
    end

    local typeIcon = TFDirector:getChildByPath(item, "Image_type")
    local subType = EquipmentDataMgr:getEquipSubType(id)
    typeIcon:setTexture(EC_EquipSubTypeIcon2[subType])
    typeIcon:Size(CCSizeMake(24, 24))

    local backImg = TFDirector:getChildByPath(item, "Image_back")
    backImg:setTouchEnabled(true)
    backImg:onClick(function()
        self:onTouchOneEquip(item)
    end)
end

function EquipStepUpLayer:onTouchOneEquip(item)
    if self.selectItem then
        self.selectItem.selectImg:setVisible(false)
    end
    
    item.selectImg:setVisible(true)
    self.selectItem = item
    self.currentId = item.id
end

function EquipStepUpLayer:updateEquipAttrBySelect()

end

function EquipStepUpLayer:onTouchButtonOpen()
    if self.isOpen then
        self.isOpen = false
        self.Image_buttons:runAction(CCMoveTo:create(0.1, ccp(60, 345)))
    else
        self.isOpen = true
        self.Image_buttons:runAction(CCMoveTo:create(0.1, ccp(60, 115)))
    end
end

function EquipStepUpLayer:changeEquipPage(isUp)
    self.equipId = self.equips[self.equipPageIdx]
    self.allList = EquipmentDataMgr:getStepUpEquipList(self.equipId)
    self:updateListByTab()
    self.loadedIndex_ = 1
    self.selectItem = nil
    self:loadEquipMent()

    self.Image_Equip:stopAllActions()
    if EquipmentDataMgr:isUesing(self.equipId) then
        self.pos = EquipmentDataMgr:getPosition(self.equipId)
    end
    local paintPath = EquipmentDataMgr:getEquipPaint(self.equipId)
    self.Image_Equip:setTexture(paintPath)
    local pos = EquipmentDataMgr:getEquipPaintPosition(self.equipId)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.equipId)
    self.Image_Equip:setScale(scale)
    self.Image_Equip:setOpacity(255)
    self.equipPos_ = pos
    self.Image_Equip:setPositionY(self.equipPos_.y)
    local function callBack()
        self.Image_Equip:setTouchEnabled(true)
        self:updateEquipInfo()
    end
    local delay = isUp and 0.2 or 0.15
    local act1 = CCMoveTo:create(delay, self.equipPos_)
    act1 = EaseSineOut:create(act1)
    local act2 = CCCallFuncN:create(callBack)
    self.Image_Equip:runAction(CCSequence:create({act1, act2}))
end

function EquipStepUpLayer:updateListByTab()
	self.showList, self.equipCnt = self:grouping(self.allList[self.selectTab])
    if #self.showList > 0 then
    	self.currentId = self.showList[1][1]
    else
    	self.currentId = nil
    end
end

function EquipStepUpLayer:onRspStepEquip(data)
	for k, v in ipairs(self.equips) do
		if v == data.costEquipId then
			table.remove(self.equips, k)
		end
	end
	self:updateEquipInfo()
    self.allList = EquipmentDataMgr:getStepUpEquipList(self.equipId)
    self:updateListByTab()
	self.loadedIndex_ = 1
    self.selectItem = nil
    self:loadEquipMent()
end

function EquipStepUpLayer:registerEvents()
	EventMgr:addEventListener(self, EV_EQUIP_STEP_UP, handler(self.onRspStepEquip, self))

    self.Button_open:onClick(function()
        self:onTouchButtonOpen()
    end)

    self.Button_all:onClick(function()
    	self.selectTab = 1
        self:updateListByTab()
        self.loadedIndex_ = 1
        self.selectItem = nil
        self:loadEquipMent()
        self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_unEquip:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_UnStepUp:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(252, 225, 64))
        self.Button_unEquip:getChildByName("Label_unEquip"):setFontColor(ccc3(255, 255, 255))
        self.Button_UnStepUp:getChildByName("Label_UnStepUp"):setFontColor(ccc3(255, 255, 255))
        self.Label_title:setTextById(111000087)
        self:onTouchButtonOpen()
    end)

    self.Button_unEquip:onClick(function()
    	self.selectTab = 2
        self:updateListByTab()
        self.loadedIndex_ = 1
        self.selectItem = nil
        self:loadEquipMent()
        self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_unEquip:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_UnStepUp:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(255, 255, 255))
        self.Button_unEquip:getChildByName("Label_unEquip"):setFontColor(ccc3(252, 225, 64))
        self.Button_UnStepUp:getChildByName("Label_UnStepUp"):setFontColor(ccc3(255, 255, 255))
        self.Label_title:setTextById(111000088)
        self:onTouchButtonOpen()
    end)

    self.Button_UnStepUp:onClick(function()
    	self.selectTab = 3
        self:updateListByTab()
        self.loadedIndex_ = 1
        self.selectItem = nil
        self:loadEquipMent()
        self.Button_all:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_unEquip:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_UnStepUp:setTextureNormal("ui/Equipment/new_ui/new_07.png")
        self.Button_all:getChildByName("Label_all"):setFontColor(ccc3(255, 255, 255))
        self.Button_unEquip:getChildByName("Label_unEquip"):setFontColor(ccc3(255, 255, 255))
        self.Button_UnStepUp:getChildByName("Label_UnStepUp"):setFontColor(ccc3(252, 225, 64))
        self.Label_title:setTextById(111000089)
        self:onTouchButtonOpen()
    end)

    if self.fromBag and self.equips then
        local function pageUp()
            if self.equipPageIdx < #self.equips then
                self.equipPageIdx = self.equipPageIdx + 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(1500)
                    self:changeEquipPage(true)
                end
                local act1 = CCMoveTo:create(0.2, ccp(-400, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function pageDown()
            if self.equipPageIdx > 1 then
                self.equipPageIdx = self.equipPageIdx - 1
                local function callBack()
                    self.Image_Equip:setOpacity(0)
                    self.Image_Equip:setPositionX(-400)
                    self:changeEquipPage(false)
                end
                local act1 = CCMoveTo:create(0.2, ccp(1500, self.equipPos_.y))
                local act2 = CCCallFuncN:create(callBack)
                self.Image_Equip:runAction(CCSequence:create({act1, act2}))
            else
                self.Image_Equip:setTouchEnabled(true)
                self.Image_Equip:runAction(CCMoveTo:create(0.2, self.equipPos_))
            end
        end

        local function onTouchBegan(touch, location)
            touch.startPos = location
            return true
        end

        local function onTouchMoved(touch, location)
            touch.isMoved = true
            local offsetx = location.x - touch.startPos.x
            local offsety = location.y - touch.startPos.y
            self.Image_Equip:setPosition(ccp(self.equipPos_.x + offsetx, self.equipPos_.y))
        end

        local function onTouchUp(touch, location)
            local offsetx = location.x - touch.startPos.x
            if touch.isMoved then
                if math.abs(offsetx) > 100 then
                    self.Image_Equip:setTouchEnabled(false)
                    if offsetx < 0 then
                        pageUp()
                    else
                        pageDown()
                    end
                else
                    self.Image_Equip:runAction(CCMoveTo:create(0.04, self.equipPos_))
                end
            end
        end

        self.Image_Equip:setTouchEnabled(true)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved)
        self.Image_Equip:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)
    end

    self.changeBtn:onClick(function()
    	local equipCid = EquipmentDataMgr:getEquipCid(self.equipId)
		local itemCfg = GoodsDataMgr:getItemCfg(equipCid)
		local equipStep = EquipmentDataMgr:getEquipStep(self.equipId)

		--最大突破等级
		if itemCfg.maxAdvanced and equipStep >= itemCfg.maxAdvanced then
    		Utils:showTips(111000086)
    		return
    	end

    	--未选择质点
    	if self.currentId == nil then
    		Utils:showTips(111000082)
    		return
    	end

    	local stepUpFunc = function(show)
    		if not show then
                AlertManager:close(self)
            end
    		EquipmentDataMgr:sendReqStepEquipPreview(self.equipId, self.currentId)
    	end

    	--已经装备在其他英雄上
    	if EquipmentDataMgr:isUesing(self.currentId) then
            local name = HeroDataMgr:getNameById(tonumber(EquipmentDataMgr:getHeroSid(self.currentId)))
            Utils:openView("common.ChangeEquipConfirmView", {tips = "r1001003", heroName = name, callback = stepUpFunc})
            return
        end

        stepUpFunc(true)
    end)
end

return EquipStepUpLayer
