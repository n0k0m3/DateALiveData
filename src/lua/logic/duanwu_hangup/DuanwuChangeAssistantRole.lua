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

local DuanwuChangeAssistantRole = class("DuanwuChangeAssistantRole",BaseLayer)

function DuanwuChangeAssistantRole:ctor( role1, role2, callBack )
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self.role1 = role1
	self.role2 = role2
	self.activityId,self.activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo()
	self.callBack = callBack
	self:init("lua.uiconfig.activity.duanwuPop1")
end

function DuanwuChangeAssistantRole:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")
	self.Panel_role1 = TFDirector:getChildByPath(ui,"Panel_role1")

	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	self.Label_number = TFDirector:getChildByPath(ui,"Label_number")
	self:updateRoleItem(self.Panel_role,self.role1)
	self:updateRoleItem(self.Panel_role1,self.role2)


	local supportRole = DuanwuHangUpDataMgr:getCurSupportRole()[1]
	local remandTime = ServerDataMgr:getServerTime() - supportRole.startTime
	local id, count = next(self.activityInfo.extendData.supAwardPerMin)
	self.Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(id)).icon)
	self.Label_number:setText(count*math.floor(remandTime/60))
end

function DuanwuChangeAssistantRole:registerEvents( ... )
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

function DuanwuChangeAssistantRole:updateRoleItem( item ,role )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local roleCfg = TabDataMgr:getData("HangupEvtRole",role)
	Image_icon:setTexture(roleCfg.icon)
end

return DuanwuChangeAssistantRole

