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

local TouzhirenTip = class("TouzhirenTip",BaseLayer)

function TouzhirenTip:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.scoreInfo = data
	self:init("lua.uiconfig.activity.touzhirenTip")

	      
end

function TouzhirenTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local label_content = TFDirector:getChildByPath(ui,"label_content")
	local Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")

	Button_sure:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	local activeScore = self.scoreInfo.activeScore or 0
	local totalScore = math.floor(self.scoreInfo.onlineScore/1000) + math.floor(self.scoreInfo.rechargeScore/1000) + math.floor(activeScore/1000)
	if totalScore > 0 then
		label_content:setTextById(14300288,totalScore)
	else
		label_content:setTextById(14300300)
	end

end

return TouzhirenTip