EC_GameAlertType = {
    comfirm = 1,
    comfirmAndCancel = 2
}

EC_GameAlertParams = {
	["msg"] = 2100089,
    ["title"] = 800011,
    ["confirm_title"] = 800010,
    ["comfirmCallback"] = nil,
    ["cancel_title"] = 800029,
    ["cancelCallback"] = nil,
    ["showtype"] = EC_GameAlertType.comfirmAndCancel,
    ["outsideClose"] = true,
}

function showGameAlert(params)
    local layer = require("lua.logic.common.GameAlertView"):new(params)
    local currentScene = Public:currentScene()
    if currentScene.__cname == "LoginScene" then
        layer:setAnchorPoint(me.p(0.5,0.5))
        currentScene:addCustomLayer(layer)
    else
        AlertManager:addLayer(layer,nil,AlertManager.TWEEN_1)
        AlertManager:show()
        layer.isCanNotClose = true
    end
end

local GameAlertView = class("GameAlertView",BaseLayer)

CREATE_PANEL_FUN(GameAlertView)

function GameAlertView:ctor(data)
    self.super.ctor(self)
    self.params = data
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.gameAlertView")
end

function GameAlertView:initUI(ui)
    self.super.initUI(self,ui)
    self.root_panel = TFDirector:getChildByPath(ui,"Panel_root")
    local page_panel = self.root_panel:getChildByName("Panel_page")
    self.msg_label = page_panel:getChildByName("TextArea_alert_info")
    self.alert_title = page_panel:getChildByName("Label_pad_title")
    self.cancel_btn = page_panel:getChildByName("Button_cancel")
    self.confirm_btn = page_panel:getChildByName("Button_confirm")
    local comfirm_title = self.confirm_btn:getChildByName("Label_title")
    local cancel_title = self.cancel_btn:getChildByName("Label_title")
    comfirm_title:setString(self:transText(self.params.confirm_title))
    cancel_title:setString(self:transText(self.params.cancel_title))
    self.alert_title:setString(Utils:MultiLanguageStringDeal(self:transText(self.params.title)))
    self.close_btn = page_panel:getChildByName("Button_close")
    if self.params.msg then
        self.msg_label:setString(Utils:MultiLanguageStringDeal(self.params.msg))
    end


    if self.params.showtype == EC_GameAlertType.comfirm then
    	self.cancel_btn:setVisible(false)
    	self.confirm_btn:setPosition(ccp(0,-110))
    	self.close_btn:setVisible(false)
    end

end

function GameAlertView:transText(txt)
    if type(txt) == "number" then
        local textAttr = TextDataMgr:getTextAttr(txt)
        if textAttr then
            return textAttr.text
        end
    end
    return tostring(txt)
end

function GameAlertView:registerEvents()
    self.cancel_btn:onClick(function ()
        if self.params.cancelCallback then
            self.params.cancelCallback()
        end
        local currentScene = Public:currentScene()
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent()
        else
            AlertManager:closeLayer(self)
        end
    end)

    self.close_btn:onClick(function()
    	if self.params.cancelCallback then
            self.params.cancelCallback()
        end
        local currentScene = Public:currentScene()
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent()
        else
            AlertManager:closeLayer(self)
        end
    end)
    
    self.root_panel:setTouchEnabled(true)
    self.root_panel:onClick(function()
        if self.params.outsideClose == true then
    	   if self.params.showtype == EC_GameAlertType.comfirmAndCancel then
    		    if self.params.cancelCallback then
	               self.params.cancelCallback()
	            end
	            local currentScene = Public:currentScene()
                if currentScene.__cname == "LoginScene" then
                    self:removeFromParent()
                else
                    AlertManager:closeLayer(self)
                end
            end
    	end
    end)


    self.confirm_btn:onClick(function()
        if self.params.comfirmCallback then
            self.params.comfirmCallback()
        end
        local currentScene = Public:currentScene()
        if currentScene.__cname == "LoginScene" then
            self:removeFromParent()
        else
            AlertManager:closeLayer(self)
        end
    end)
end

function GameAlertView:removeUI()
    self.super.removeUI(self)
end

return GameAlertView
