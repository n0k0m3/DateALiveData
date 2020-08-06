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

local AssistanceHelpLayer = class("AssistanceHelpLayer", BaseLayer)

function AssistanceHelpLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig."..data.uiName)
end

function AssistanceHelpLayer:initData( data )

end

function AssistanceHelpLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.uiPanel = TFDirector:getChildByPath(self.rootPanel, "panel_ui")
    self.closeBtn = TFDirector:getChildByPath(self.uiPanel, "btn_close")
end

function AssistanceHelpLayer:onShow( )
    self.super.onShow(self)
  
end

function AssistanceHelpLayer:registerEvents( )
	self.super.registerEvents(self)

    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)
end

function AssistanceHelpLayer:removeEvents( )
    self.super.removeEvents(self)
end

return AssistanceHelpLayer
