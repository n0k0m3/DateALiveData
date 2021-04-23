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
* 社团修改名字
* 
]]

local LeagueModifyName = class("LeagueModifyName", BaseLayer)

function LeagueModifyName:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.LeagueModifyName")
end

function LeagueModifyName:initData(data)
    local costItem = Utils:getKVP(90020, "cost")
    for k, v in pairs(costItem) do
        self.costItemId = k
        self.costItemIdCnt = v
        break
    end
end

function LeagueModifyName:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.TextField_modifyName = TFDirector:getChildByPath(self.ui, "TextField_modifyName")
    self.Label_modifyName = TFDirector:getChildByPath(self.ui, "Label_modifyName")

    self.Image_cost_bg = TFDirector:getChildByPath(self.ui, "Image_cost_bg")
    self.Image_cost_icon = TFDirector:getChildByPath(self.ui, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.ui, "Label_cost_num")

	local iconPath = TabDataMgr:getData("Item", self.costItemId).icon
	self.Image_cost_icon:setTouchEnabled(true)
	self.Image_cost_icon:setTexture(iconPath)
	self.Image_cost_icon:setContentSize(CCSizeMake(64, 64))

	self:updateCostNum()

    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer, 1000)
end

function LeagueModifyName:updateCostNum()
	local ownCnt = GoodsDataMgr:getItemCount(self.costItemId)
	self.Label_cost_num:setString(ownCnt .. "/" .. self.costItemIdCnt)
	if ownCnt < self.costItemIdCnt then
        self.Label_cost_num:setColor(ccc3(220, 20, 60))
    else
        self.Label_cost_num:setColor(ccc3(255, 255, 255))
    end
end

function LeagueModifyName:onTouchSendBtn()
    self.TextField_modifyName:setText(self.Label_modifyName:getText())
end

function LeagueModifyName:onCloseInputLayer()
    self.TextField_modifyName:closeIME()
end

function LeagueModifyName:onChangeNameOk()
	Utils:showTips(800025)
    AlertManager:closeLayer(self)
end

function LeagueModifyName:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_MODIFY_NAME, handler(self.onChangeNameOk, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateCostNum, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 8 then
            local new_text = string.gsub(text, "·", "")
            input:setText(new_text)
            self.Label_modifyName:setText(input:getText())
            self.inputLayer:listener(input:getText())
            print("onTextFieldChangedHandleAcc")
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        local new_text = string.gsub(text, "·", "")
        input:setText(new_text)
        self.inputLayer:show();
        self.inputLayer:listener(input:getText())
    end

    self.TextField_modifyName:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_modifyName:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_ok:onClick(function()
    	local ownCnt = GoodsDataMgr:getItemCount(self.costItemId)
    	if ownCnt < self.costItemIdCnt then
    		Utils:showAccess(self.costItemId)
    		return
    	end

        local text = self.Label_modifyName:getText()
        if #text == 0 or not self.Label_modifyName.isSet then
            Utils:showTips(800104)
        elseif Utils:isStringContainSpecialChars(text, "%s") ~= nil then
        	Utils:showTips(200006)
        else
        	LeagueDataMgr:UpdateUnionInfo(EC_UNION_EDIT_Type.MODIFY_NAME, text)
        end
    end, EC_BTN.CLOSE)

    self.Label_modifyName:onClick(function()
        self.Label_modifyName:setText("")
        self.Label_modifyName.isSet = true
        self.TextField_modifyName:openIME()
    end)

    self.Image_cost_icon:onClick(function()
        Utils:showInfo(self.costItemId)
    end)
end

return LeagueModifyName