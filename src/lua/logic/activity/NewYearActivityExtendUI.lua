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
* -- 年兽活动在城建界面的扩展UI
* 
]]

local NewYearActivityExtendUI = class("NewYearActivityExtendUI",BaseLayer)

function NewYearActivityExtendUI:ctor( data )
	self.super.ctor(self,data)
	self.hideYanhua = data
	self:init("lua.uiconfig.activity.NewYearActivityExtendUI")
end

function NewYearActivityExtendUI:initUI( ui )
	self.super.initUI(self,ui)
	self.btn_yanhua = TFDirector:getChildByPath(ui,"btn_yanhua")
	self.btn_nianshou = TFDirector:getChildByPath(ui,"btn_nianshou")
	self.txt_refreshTime = TFDirector:getChildByPath(ui,"txt_refreshTime")
	self.spine_ani = TFDirector:getChildByPath(ui,"spine_ani")
	self.bg_image = TFDirector:getChildByPath(ui,"bg_image")
	self.label_tip = TFDirector:getChildByPath(ui,"label_tip")

	self.btn_yanhua:onClick(function (  )
    	-- if NewCityDataMgr:getCityDay() == EC_NewCityDayType.SpringFestival_Night then
			Utils:openView("activity.YanHuaSelectView")
		-- else
		-- 	Utils:showTips(13100066)
		-- end
	end)
	self.spine_ani:setVisible(false)
	self.btn_nianshou:onClick(function (  )
		local nianshouData = ActivityDataMgr2:getNianShouData( )
		Utils:openView("activity.NianShouCallSuccessTip",nianshouData,true)
	end)

	if self.hideYanhua then
		self.btn_yanhua:hide()
	end

    self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.flushTime, self))
	self:flushTime( 0 )
end

function NewYearActivityExtendUI:dispose()
	self.super.dispose(self)
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function NewYearActivityExtendUI:flushState(  )
	local hasNianBeast,unArrest = ActivityDataMgr2:getNianShouState()
	self.bg_image:setVisible(hasNianBeast and unArrest)
	self.label_tip:setVisible(hasNianBeast and unArrest)
	self.btn_nianshou:setVisible(hasNianBeast)
	local nianshouData = ActivityDataMgr2:getNianShouData( )
	local nianCfg = TabDataMgr:getData("NianBeast",nianshouData.id)
	self.btn_nianshou:setTextureNormal(nianCfg.headIcon)
	local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)[1]
	local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self.btn_yanhua:setVisible(activityInfo.extendData.stage~=1 and not self.hideYanhua)
end

function NewYearActivityExtendUI:setInBuildVisible( show )
	local hasNianBeast,unArrest = ActivityDataMgr2:getNianShouState()
	self.spine_ani:setVisible(hasNianBeast and show)
end

function NewYearActivityExtendUI:flushTime( dt )
	local activityInfos = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEARDATING)
	if #activityInfos == 0 then
		self:dispose()
		self:removeFromParent(true)
		return
	end
	local remainTime = ActivityDataMgr2:getNianShouEscapeTime( )
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)

    
    if hour ~="00" then
        self.txt_refreshTime:setTextById(13100055, hour, min)
    else
        self.txt_refreshTime:setTextById(13100056, min, sec)
    end
    self:flushState(  )
end


return NewYearActivityExtendUI