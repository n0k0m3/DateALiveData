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

local SkillInfoView = class("SkillInfoView",BaseLayer)

function SkillInfoView:ctor( skillId ,isLock)
	-- body
	self.super.ctor(self,data)
	self.isLock = isLock
	self.skillCfg = TabDataMgr:getData("AfkEffect",skillId)
	self:showPopAnim(true)
	self:init("lua.uiconfig.explore.skillInfoView")
end

function SkillInfoView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	local Label_tip = TFDirector:getChildByPath(ui,"Label_tip")
	local Label_name = TFDirector:getChildByPath(ui,"Label_name")
	local Label_des = TFDirector:getChildByPath(ui,"Label_des")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local Image_lock = TFDirector:getChildByPath(ui,"Image_lock")
	Image_lock:setVisible(self.isLock)
	local res = self.isLock and string.sub(self.skillCfg.icon,0,-5).."_1.png" or self.skillCfg.icon
	Image_icon:setTexture(res)
	Label_tip:setText(self.skillCfg.describe)
	Label_name:setText(self.skillCfg.name)
	Label_des:setText(self.skillCfg.des2)
	
	Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return SkillInfoView