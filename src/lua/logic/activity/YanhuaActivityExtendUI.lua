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
* -- 烟花活动在城建界面的扩展UI
* 
]]

local YanhuaActivityExtendUI = class("YanhuaActivityExtendUI",BaseLayer)

function YanhuaActivityExtendUI:ctor( data )
	self.super.ctor(self,data)
	self.hideYanhua = data
	self:init("lua.uiconfig.activity.NewYearActivityExtendUI")
end

function YanhuaActivityExtendUI:initUI( ui )
	self.super.initUI(self,ui)
	self.btn_yanhua = TFDirector:getChildByPath(ui,"btn_yanhua")
	self.btn_nianshou = TFDirector:getChildByPath(ui,"btn_nianshou"):hide()
	self.txt_refreshTime = TFDirector:getChildByPath(ui,"txt_refreshTime"):hide()
	self.spine_ani = TFDirector:getChildByPath(ui,"spine_ani"):hide()
	self.bg_image = TFDirector:getChildByPath(ui,"bg_image"):hide()
	self.label_tip = TFDirector:getChildByPath(ui,"label_tip"):hide()

	self.btn_yanhua:onClick(function (  )
    	if NewCityDataMgr:getCityDay() == EC_NewCityDayType.SpringFestival_Night then
			Utils:openView("activity.YanHuaSelectView")
		else
			Utils:showTips(13100066)
		end
	end)
end

function YanhuaActivityExtendUI:dispose()
	self.super.dispose(self)
	
end


return YanhuaActivityExtendUI