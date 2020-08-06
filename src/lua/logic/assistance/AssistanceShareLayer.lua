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
*  ∫√”—÷˙¡¶
* 
]]

local AssistanceShareLayer = class("AssistanceShareLayer", BaseLayer)

function AssistanceShareLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceShareLayer")
end

function AssistanceShareLayer:initData( data )

end

function AssistanceShareLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.uiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui")
    self.closeBtn = TFDirector:getChildByPath(self.uiPanel, "btn_close")
    self.linkLabel = TFDirector:getChildByPath(self.uiPanel, "label_code")
    self.linkLabel:setText("http://kr.datealive.com/dal/tf/1")
    self.copyBtn = TFDirector:getChildByPath(self.uiPanel, "btn_copy")
end

function AssistanceShareLayer:onShow( )
    self.super.onShow(self)
  
end

function AssistanceShareLayer:registerEvents( )
	self.super.registerEvents(self)

    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)

    self.copyBtn:onClick(function(sender)
        local content = self.linkLabel:getString()
        TFDeviceInfo:copyToPasteBord(content)
        Utils:showTips(600010)
    end)
end

function AssistanceShareLayer:removeEvents( )
    self.super.removeEvents(self)
end

return AssistanceShareLayer
