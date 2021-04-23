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
* 
]]
local AssistPopView = class("AssistPopView",BaseLayer)

function AssistPopView:ctor( num, onlineTime )
	-- body
	self.super.ctor(self)
	self.num = num
	self.onlineTime = onlineTime
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.assistPopView")
end

function AssistPopView:initUI(ui)
	self.super.initUI(self,ui)

	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_value = TFDirector:getChildByPath(ui,"Label_value")
	self.Button_get = TFDirector:getChildByPath(ui,"Button_get")
	self.Label_content = TFDirector:getChildByPath(ui,"Label_content")

	self.Label_content:setTextById("r14220014",self.onlineTime)
	self.Label_value:setText(self.num)

end

function AssistPopView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_get:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return AssistPopView
