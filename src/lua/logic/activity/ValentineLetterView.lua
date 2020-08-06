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
* -- 情人节信件
]]

local ValentineLetterView = class("ValentineLetterView",BaseLayer)

function ValentineLetterView:ctor( data )
	self.super.ctor(self,data)
	self.data = data
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.valentineLetterView")
end

function ValentineLetterView:initUI( ui )
	self.super.initUI(self,ui)
	local button_close = TFDirector:getChildByPath(ui,"Button_close")
	local label_name = TFDirector:getChildByPath(ui,"label_name")
	local label_content = TFDirector:getChildByPath(ui,"label_content")
	label_name:setTextById(self.data)
	button_close:onClick(function (  )
		AlertManager:closeLayer(self)
	end)
end

return ValentineLetterView