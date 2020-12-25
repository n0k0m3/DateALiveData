local AngelTabLayer = class("AngelTabLayer", BaseLayer)


function AngelTabLayer:ctor(data)
    self.super.ctor(self,data)

    self.heroId = data.heroId

    self.angleTabItems = {}

    self:init("lua.uiconfig.angelNew.angle_tab")
end

function AngelTabLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	AngelTabLayer.ui = ui

	self.Panel_tab_row_item		= TFDirector:getChildByPath(ui, "Panel_tab_row_item")
	self.Panel_tab_row_item:setVisible(false)

	local ScrollView_tab		= TFDirector:getChildByPath(ui, "ScrollView_tab")
	self.ListView_tab 			= UIListView:create(ScrollView_tab)
    self.ListView_tab:setItemsMargin(7)

    self.TextField_name     = TFDirector:getChildByPath(ui, "TextField_name")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

	self:initAllTabs()

    self:initNativeLanguage()

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);
    self.inputLayer:setPositionX(-(GameConfig.WS.width - 1136) / 2);

    local Panel_base = TFDirector:getChildByPath(ui, "Panel_base")
    Panel_base:setTouchEnabled(true)

    me.Director:setSingleEnabled(true)
end

function AngelTabLayer:registerEvents()
    EventMgr:addEventListener(self, EV_HERO_ANGLE_CHANGE_TAB_NAME, handler(self.onChangeTabName, self))
	self.ui:onClick(function()
		AlertManager:close()
	end)
    self.Button_close:onClick(function()
        AlertManager:close()
    end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
        -- EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

    self.TextField_name:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_name:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_name:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
end

function AngelTabLayer:initAllTabs()
	self.ListView_tab:removeAllItems()
    local pageConfig = TabDataMgr:getData("AngelSkillPage")
    local itemCount = table.count(pageConfig) / 2;
	for i=1, itemCount do
		local rowItem = self.Panel_tab_row_item:clone()
		rowItem:setVisible(true)
		for i2=1, 2 do
			local idx  = (i-1)*2 + i2
			local item = TFDirector:getChildByPath(rowItem, "Panel_tab_"..i2)
			local data = AngelDataMgr:getHeroSkillStrategyData(self.heroId, idx)
            dump(data)
			self:initOneTabItem(item, data, idx)
			self.angleTabItems[idx] = item
		end
		self.ListView_tab:pushBackCustomItem(rowItem)
	end
end

function AngelTabLayer:initOneTabItem(item, data, idx)
	if not data then
		data = {
			id = idx,
			name = "Page_"..idx,
		}
	end
	item.data = data
	item.id   = idx

    local curLoadTabId = HeroDataMgr:getUseSkillStrategy(self.heroId)

    local imgBg = TFDirector:getChildByPath(item, "Image_angle_tab__bg")
    local Label_name  = TFDirector:getChildByPath(item, "Label_name")
    local Image_angle_tab__bg1  = TFDirector:getChildByPath(item, "Image_angle_tab__bg1")
    local Button_change_name  = TFDirector:getChildByPath(item, "Button_change_name")
    local Button_reset  = TFDirector:getChildByPath(item, "Button_reset")
    Label_name:setString(data.name)
    if curLoadTabId == data.id then
        imgBg:setTexture("ui/fairy_angle/new_51.png")
        Image_angle_tab__bg1:setTexture("ui/fairy_angle/new_53.png")
        Button_change_name:setTextureNormal("ui/fairy_angle/new_56.png")
        Label_name:setFontColor(ccc3(16,17,23))
        Button_reset:setVisible(true)
    else
        imgBg:setTexture("ui/fairy_angle/new_50.png")
        Image_angle_tab__bg1:setTexture("ui/fairy_angle/new_52.png")
        Button_change_name:setTextureNormal("ui/fairy_angle/new_55.png")
        Label_name:setFontColor(ccc3(255,255,255))
        Button_reset:setVisible(true)
    end

	local totalLevel = 0
	if data.angeSkillInfos then
		for i, v in ipairs(data.angeSkillInfos) do
			totalLevel = totalLevel + v.lvl
		end
	end
	local Label_level = TFDirector:getChildByPath(item, "Label_level")
	Label_level:setString(totalLevel)

    local Button_change_name = TFDirector:getChildByPath(item, "Button_change_name")
    Button_change_name:onClick(function()
        self.TextField_name:openIME()
        self.tabId = data.id
    end)

    item:setTouchEnabled(true)
	item:onClick(function()		
        dump(data)
        if data.id ~= curLoadTabId then
            showMessageBox(TextDataMgr:getText(450029) , EC_MessageBoxType.okAndCancel,function()
        		--发送请求，装备该天使页
        		AngelDataMgr:doReqUseSkillStrategy(self.heroId, data.id)
            	AlertManager:close()
                AlertManager:close()
            end)
        end
	end)

    local Button_reset = TFDirector:getChildByPath(item, "Button_reset")
    Button_reset:onClick(function()
        showMessageBox(TextDataMgr:getText(450030) , EC_MessageBoxType.okAndCancel,function()
            --发送请求，重置该天使页技能
            AngelDataMgr:doReqResetSkill(self.heroId, data.id)
            AlertManager:close()
            AlertManager:close()
        end)
    end)
    TFDirector:getChildByPath(Button_reset, "Label_angle_tab_1"):setTextById(450014)
end

function AngelTabLayer:onTouchSendBtn()
    print("onTouchSendBtn")
    local content = self.TextField_name:getText()
    if content and #content > 0 then
        if not AngelDataMgr:doReqModifyStrategyName(self.heroId,self.tabId,content) then
            Utils:showTips(200006)
        end
        self.TextField_name:setText("")
    else
        Utils:showTips(450031)
    end
end

function AngelTabLayer:onCloseInputLayer()
    -- EventMgr:dispatchEvent(PlayerInfoConfig.EV_OUTPUT)
    self.TextField_name:closeIME()
    self.TextField_name:setText("")
end

function AngelTabLayer:onChangeTabName(data)
	local item = self.angleTabItems[data.skillStrategyId]
	if item then
		local strategyData = AngelDataMgr:getHeroSkillStrategyData(self.heroId, data.skillStrategyId)
		self:initOneTabItem(item, strategyData, data.skillStrategyId)
	end
end

function AngelTabLayer:onHide()
	self.super.onHide(self)
end

function AngelTabLayer:removeUI()
	self.super.removeUI(self)
end

function AngelTabLayer:onShow()
    self.super.onShow(self)
end

function AngelTabLayer:initNativeLanguage()
    local stringIds = {450013, 450013}
    local labels    = {
        TFDirector:getChildByPath(self.ui, "Label_angle_tab_1"),
        TFDirector:getChildByPath(self.ui, "Label_angle_title")
    }
    for i, lab in ipairs(labels) do
        if lab then
            lab:setTextById(stringIds[i])
        end
    end
end


return AngelTabLayer;
