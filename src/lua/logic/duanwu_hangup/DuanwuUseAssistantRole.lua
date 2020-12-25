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

local DuanwuUseAssistantRole = class("DuanwuUseAssistantRole",BaseLayer)

function DuanwuUseAssistantRole:ctor( roleData, callBack)
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self.roleData = roleData
	self.activityId,self.activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo()
	self.callBack = callBack
	self:init("lua.uiconfig.activity.duanwuPop3")
end

function DuanwuUseAssistantRole:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel")
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")

	self.Label_player = TFDirector:getChildByPath(ui,"Label_player")
	self.Label_count = TFDirector:getChildByPath(ui,"Label_count")

	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	self.Label_number = TFDirector:getChildByPath(ui,"Label_number")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")
	self:updateRoleItem(self.Panel_role,self.roleData.role.roleId)

	self.Label_player:setText(string.format("【%s】",self.roleData.playerName))
	local useSupportCount = DuanwuHangUpDataMgr.useSupTimes or 0
	useSupportCount = self.activityInfo.extendData.supUseLimit - useSupportCount
	self.Label_count:setText(useSupportCount.."/"..self.activityInfo.extendData.supUseLimit)

	local id,num = next(self.activityInfo.extendData.supChrCost)
	self.Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(id)).icon)
	self.Label_number:setText(num)
end

function DuanwuUseAssistantRole:registerEvents( ... )
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

function DuanwuUseAssistantRole:updateRoleItem( item ,role )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local roleCfg = TabDataMgr:getData("HangupEvtRole",role)
	Image_icon:setTexture(roleCfg.icon)

end

return DuanwuUseAssistantRole

