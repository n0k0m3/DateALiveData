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

local DuanwuHangUpMainMapView = class("DuanwuHangUpMainMapView",BaseLayer)

function DuanwuHangUpMainMapView:ctor(  )
	-- body
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.activity.duanwuHangupMainMapView")
end

function DuanwuHangUpMainMapView:initData(  )
	-- body
	self.activityId,self.activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo()
	self.fortItems = self.fortItems or {}
    DuanwuHangUpDataMgr:checkAllRoleBuff()
end

function DuanwuHangUpMainMapView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	local Panel_map = TFDirector:getChildByPath(ui,"Panel_map")
	self.mapBg = createUIByLuaNew("lua.uiconfig.activity.mapContent")

	
	self.mapBg:setAnchorPoint(ccp(0,0))
	self.mapView = require("lua.public.ScrollAndZoomView"):new(Panel_map:getContentSize(),self.mapBg:getContentSize())
	self.mapView:addChild(self.mapBg)
	self.mapView:setMinScale(0.5)
	self.mapView:setMaxScale(1)
    me.Director:setSingleEnabled(false)
    Panel_map:addChild(self.mapView)

    self.Button_sprite = TFDirector:getChildByPath(ui,"Button_sprite")
    self.Button_task = TFDirector:getChildByPath(ui,"Button_task")
    self.Button_huiyi = TFDirector:getChildByPath(ui,"Button_huiyi")
    self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
    self.Button_refresh = TFDirector:getChildByPath(ui,"Button_refresh")
    self.Panel_fortItem = TFDirector:getChildByPath(ui,"Panel_fortItem")
    self.task_Image_redTip = TFDirector:getChildByPath(self.Button_task,"Image_redTip")

    self:updateUI()
    self:updateMapContent()
    self:onCountDownPer()
end

function DuanwuHangUpMainMapView:onShow( ... )
	-- body
	self.super.onShow(self)
	if self.activityInfo.extendData.eventEndingTimeStamp > ServerDataMgr:getServerTime() then
		DatingDataMgr:triggerDating(self.__cname, "onShow")
		self:onShowCheckDating()
	end

	if not self.isInit then
		self.isInit = true
		local key = next(self.fortItems)
    	self.mapView:focus(self.fortItems[key]:getPosition())
	end
end

function DuanwuHangUpMainMapView:updateUI( ... )
	-- body
	local refreshCount = TFDirector:getChildByPath(self.Button_refresh,"Label_count")
	local curRefreshTime,curRefreshTimes = DuanwuHangUpDataMgr:getFortRefreshTime()
	curRefreshTimes = self.activityInfo.extendData.fortResetTimes - curRefreshTimes
	refreshCount:setText(curRefreshTimes.."/"..self.activityInfo.extendData.fortResetTimes)
	self.task_Image_redTip:setVisible(ActivityDataMgr2:isShowRedPoint(self.activityId))
end

function DuanwuHangUpMainMapView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_FORT, function ( ... )
		-- body
		self:updateUI()
		self:updateMapContent()
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
		-- body
		self:updateUI()
	end)
	
	self.Button_sprite:onClick(function ( ... )
		-- body
		Utils:openView("duanwu_hangup.SpriteInfoTip")
	end)

	self.Button_task:onClick(function ( ... )
		-- body
		Utils:openView("duanwu_hangup.DuanwuTaskTip")
	end)

	self.Button_huiyi:onClick(function ( ... )
		-- body
		Utils:openView("duanwu_hangup.HuiyiTip")
	end)

	self.Button_shop:onClick(function ( ... )
		-- body
		FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
	end)
	
	self.Button_refresh:onClick(function ( ... )
		-- body
		if self.activityInfo.extendData.eventEndingTimeStamp <= ServerDataMgr:getServerTime() then
			Utils:showTips(13200922)
			return
		end

		local canRefresh = false
		for k,v in ipairs(DuanwuHangUpDataMgr:getFortList()) do
			if v.state == 0 then
				canRefresh = true
				break;
			end
		end

		if not canRefresh then 
			Utils:showTips(13200920)
			return 
		end

		local curRefreshTime,curRefreshTimes = DuanwuHangUpDataMgr:getFortRefreshTime()
		if ServerDataMgr:getServerTime() < curRefreshTime + self.activityInfo.extendData.refreshCD then
			Utils:showTips(13200906)
		elseif curRefreshTimes >= self.activityInfo.extendData.fortResetTimes then
			Utils:showTips(13200907)
		else
			local args = {
	            tittle = 2107025,
	            content = TextDataMgr:getText(13200914),
                showCancle = true,
	            confirmCall = function ( ... )
					DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_REFRESH_STRONGHOLD()
	            end,
	        }
	        Utils:showReConfirm(args)
		end
	end)
	self:addCountDownTimer()
end

function DuanwuHangUpMainMapView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
    me.Director:setSingleEnabled(true)
    self:removeCountDownTimer()
end

function DuanwuHangUpMainMapView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function DuanwuHangUpMainMapView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function DuanwuHangUpMainMapView:onShowCheckDating( ... )
	-- body
	local fortDatas = DuanwuHangUpDataMgr:getFortList()
	for k,data in ipairs(fortDatas) do
		if data.event and data.event[1].startTime >= ServerDataMgr:getServerTime() then
  			DatingDataMgr:triggerDating(self.__cname,"onDataRefresh",{stateNow = "event", eventId = data.event[1].id, fortId = data.id })
		end	


		local isFinish = data.state == 2 or (data.state == 1 and ServerDataMgr:getServerTime() >= data.endTime)
		if data.event and data.event[1].state ~= 2 and data.event[1].state ~= 5 then
			isFinish = false
		end

  		if isFinish then
  			DatingDataMgr:triggerDating(self.__cname,"onDataRefresh",{stateNow = "finish", fortId = data.id })
		end	
	end
end

function DuanwuHangUpMainMapView:onCountDownPer()
	local needUpdateMap = false
  	for k,v in pairs(self.fortItems) do
		local Label_timing = TFDirector:getChildByPath(v,"Label_timing")
  		local data = DuanwuHangUpDataMgr:getFortList()[v.index]
  		local fortCfg = TabDataMgr:getData("HangupEvtFort",data.id)

  		if data.state == 1 then
	  		Label_timing:setText(Utils:getTimeCountDownString(data.endTime,2))
	  	else
  			Label_timing:setText(string.format("%d%%",data.progress*100/fortCfg.finishProg))

  		end

  		if (data.event and data.event[1].startTime <= ServerDataMgr:getServerTime()) or data.endTime <= ServerDataMgr:getServerTime() then
  			needUpdateMap = true
  		end

  		if data.event and data.event[1].startTime == ServerDataMgr:getServerTime() then
  			DatingDataMgr:triggerDating(self.__cname,"onDataRefresh",{stateNow = "event", eventId = data.event[1].id, fortId = data.id })
		end	


		local isFinish = data.state == 2 or (data.state == 1 and ServerDataMgr:getServerTime() == data.endTime)
		if data.event and data.event[1].state ~= 2 and data.event[1].state ~= 5 then
			isFinish = false
		end

  		if isFinish then
  			DatingDataMgr:triggerDating(self.__cname,"onDataRefresh",{stateNow = "finish", fortId = data.id })
		end	
  	end
  	if needUpdateMap then
  		self:updateMapContent()
  	end
end

function DuanwuHangUpMainMapView:updateMapContent( ... )
	-- body
	local fortDatas = DuanwuHangUpDataMgr:getFortList()

	local tmpFortData = {}

	for k,v in ipairs(fortDatas) do
		local fortCfg = TabDataMgr:getData("HangupEvtFort",v.id)
		tmpFortData[fortCfg.pos] = true
		if not self.fortItems[fortCfg.pos] then
			self.fortItems[fortCfg.pos] = self.Panel_fortItem:clone()
			local Spine_hintEvent = TFDirector:getChildByPath(self.fortItems[fortCfg.pos],"Spine_hintEvent")
			local Spine_finish = TFDirector:getChildByPath(self.fortItems[fortCfg.pos],"Spine_finish")
			local Spine_finish1 = TFDirector:getChildByPath(self.fortItems[fortCfg.pos],"Spine_finish1")
			Spine_hintEvent:play("fort_hintEvent",true)
			Spine_finish:play("fort_hintFinish2",true)
			Spine_finish1:play("fort_hintFinish1",true)
			self.mapBg:addChild(self.fortItems[fortCfg.pos])
		end
		self.fortItems[fortCfg.pos].index = k
		self:updateFortItem(self.fortItems[fortCfg.pos],v)
	end

	for k,v in pairs(self.fortItems) do
		if not tmpFortData[k] then
			local Spine_disapear = TFDirector:getChildByPath(v,"Spine_disapear")
			local panel_content = TFDirector:getChildByPath(v,"Panel_content")
			Spine_disapear:addMEListener(TFARMATURE_COMPLETE,
		            function()
		            		Spine_disapear:removeMEListener(TFARMATURE_COMPLETE)
							v:removeFromParent(true)
		            	end)
			Spine_disapear:play("fort_disapear",false)
			panel_content:runAction(FadeOut:create(0.5))
			self.fortItems[k] = nil
		end
	end
end

-- data.state (0- 未开始，1,进行中，2 已完成, 3 已结束)

function DuanwuHangUpMainMapView:updateFortItem( item, data )
	-- body
	local Image_border = TFDirector:getChildByPath(item,"Image_border")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_1 = TFDirector:getChildByPath(item,"Image_1")
	local LoadingBar_progress = TFDirector:getChildByPath(item,"LoadingBar_progress")
	local Label_timing = TFDirector:getChildByPath(item,"Label_timing")
	local Image_finish = TFDirector:getChildByPath(item,"Image_finish")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_role = TFDirector:getChildByPath(item,"Image_role")
	local Image_role_head = TFDirector:getChildByPath(item,"Image_role_head")
	local Image_eventTip = TFDirector:getChildByPath(item,"Image_eventTip"):hide()

	Image_border:setTouchEnabled(true)
	Image_border:onClick(function ( ... )
		if data.state == 0 then
			Utils:openView("duanwu_hangup.FortReadyTip",data)
		else
			Utils:openView("duanwu_hangup.FortInfoTip",data)
		end
	end)

	local fortCfg = TabDataMgr:getData("HangupEvtFort",data.id)
	local posItem = TFDirector:getChildByPath(self.mapBg,"pos"..fortCfg.pos)
	item:setPosition(posItem:getPosition())

	Image_icon:setTexture(fortCfg.icon)

	if data.state == 1 then
		Label_timing:setText(Utils:getTimeCountDownString(data.endTime,2))
	else
		Label_timing:setText(string.format("%d%%",data.progress*100/fortCfg.finishProg))
	end
	
	local isFinish = data.state == 2 or (data.state == 1 and ServerDataMgr:getServerTime() >= data.endTime)

	if data.event and data.event[1].state ~= 2 and data.event[1].state ~= 5 then
		isFinish = false
	end
	Image_1:setVisible(not (data.state == 2 or isFinish))
	Image_finish:setVisible(data.state == 2 or isFinish)
	Label_name:setTextById(fortCfg.name)
	LoadingBar_progress:setVisible(data.state == 0)
	LoadingBar_progress:setPercent(data.progress*100/fortCfg.finishProg)

	Image_role:setVisible(data.state == 1)

	if data.state == 4 then
		Image_border:setTouchEnabled(false)
		item:setGrayEnabled(true)
		LoadingBar_progress:setVisible(true)
	end


	local roles = {}

	if data.role then
		for k,v in ipairs(data.role) do
			table.insert(roles,v)
		end
	end

	if data.supportRole then
		for k,v in ipairs(data.supportRole) do
			table.insert(roles,v.role)
		end
	end

	if roles and #roles > 0 then
		local role = roles[1]
		local roleCfg = TabDataMgr:getData("HangupEvtRole",role.roleId)
		Image_role_head:setTexture(roleCfg.moodPath.."3.png")
	end

	if data.event and data.event[1].state == 0 and ServerDataMgr:getServerTime() > data.event[1].startTime then
		Image_eventTip:show()
		Image_role:hide()
	end

end

return DuanwuHangUpMainMapView