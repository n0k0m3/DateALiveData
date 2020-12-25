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

local DuanwuSetAssistantRole = class("DuanwuSetAssistantRole",BaseLayer)

function DuanwuSetAssistantRole:ctor( role, callBack )
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self.role = role
	self.callBack = callBack
	self:init("lua.uiconfig.activity.duanwuPop2")
end

function DuanwuSetAssistantRole:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")
	self:updateRoleItem(self.Panel_role,self.role)
end

function DuanwuSetAssistantRole:registerEvents( ... )
	-- body
	self.Button_sure:onClick(function ( ... )
		-- body
		if self.callBack then
			self.callBack()
			AlertManager:closeLayer(self)
		end
	end)

	self.Button_cancel:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
	
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

function DuanwuSetAssistantRole:updateRoleItem( item ,role )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local roleCfg = TabDataMgr:getData("HangupEvtRole",role)
	Image_icon:setTexture(roleCfg.icon)
end

return DuanwuSetAssistantRole

