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
* 委托活动类型界面
]]

local ActivityEntrustView = class("ActivityEntrustView",BaseLayer)

ActivityEntrustView.maxEntrustNum = 20 -- 预留最多支持 20 个委托任务
ActivityEntrustView.maxBoxNum = 20 -- 预留最多支持 20 个礼物盒

ActivityEntrustView.uiPath = {
	[EC_ActivityType2.ENTRUST] = "lua.uiconfig.activity.ActivityEntrustView",
}

function ActivityEntrustView:ctor( data )
	self.super.ctor(self,data)
	self.activityInfo = ActivityDataMgr2:getActivityInfo(data)
	self:init(ActivityEntrustView.uiPath[self.activityInfo.activityType])
end

function ActivityEntrustView:initUI( ui )
	self.super.initUI(self,ui)
	self.entrustItem = TFDirector:getChildByPath(ui,"panel_EntrustItem")
	self.boxItem = TFDirector:getChildByPath(ui,"panel_boxItem")
	self.btn_refresh = TFDirector:getChildByPath(ui,"btn_refresh")
	self.label_refreshTime = TFDirector:getChildByPath(ui,"label_refreshTime")
	self:flushEntrustItems()
	self:flushBoxItems()
	self:flushUI()
	self:addCountDownTimer()
end

function ActivityEntrustView:onShow(  )
	self.super.onShow(self)

	if self.activityInfo.extendData.interDating then
		local value = Utils:getLocalSettingValue("playChrisDating"..self.activityInfo.extendData.interDating)
		if value == "" then
			FunctionDataMgr:jStartDating(self.activityInfo.extendData.interDating)
			Utils:setLocalSettingValue("playChrisDating"..self.activityInfo.extendData.interDating,"true")
		end
	end
end

function ActivityEntrustView:registerEvents( ... )
	self.super.registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.onRefreshEntrustEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
		self:flushEntrustItems()
		self:flushBoxItems()
	end)
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
		self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityInfo.id)
		self:flushEntrustItems()
		self:flushBoxItems()
	end)
	local  function refreshRsp ( ... )
        self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
	    local remainTime = math.max(0, math.ceil(self.activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
	    if remainTime > 0 then
	    	Utils:openView("activity.EntrustGemFlushView", self.activityInfo)
	    else
			TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityInfo.id,1})
		end
	end
	self.btn_refresh:onClick(function ( )
		if self:hasEntrustCanGet() then
			local args = {
	            tittle = 2107025,
	            reType = "hulvjianglipin",
	            content = TextDataMgr:getText(12100089),
	            confirmCall = refreshRsp,
	        }
	        Utils:showReConfirm(args)
	        return 
	    end
		refreshRsp()
	end)
end

function ActivityEntrustView:hasEntrustCanGet(  )
	local items = self:getItemsByType(EC_ActivityEntrustSubType.ENTRUST)
	for k,v in pairs(items) do
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v.id)
		if progressInfo.status == EC_TaskStatus.GET then
			return true
		end
	end
	return false
end

function ActivityEntrustView:onRefreshEntrustEvent()
	self.ui:runAnimation("refreshAction",1)
    Utils:showTips(12100079)
end

function ActivityEntrustView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityInfo.id == activitId then
    	Utils:showReward(reward)
    end
end
	
function ActivityEntrustView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.flushUI, self))
    end
end

function ActivityEntrustView:dispose( ... )
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function ActivityEntrustView:getItemsByType( subType )
	local list = {}
	local items = ActivityDataMgr2:getItems(self.activityInfo.id)
	for k,v in pairs(items) do
		local info = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
		if info.subType == subType then
			table.insert(list,info)
		end 
	end
	return list
end

function ActivityEntrustView:flushEntrustItems(  )
	local items = self:getItemsByType(EC_ActivityEntrustSubType.ENTRUST)
	local number = math.max(#items,ActivityEntrustView.maxEntrustNum)
	for i = 1,number do
		local parent = TFDirector:getChildByPath(self.ui,"parent_Entrust"..i)
		if parent then
			parent:setVisible(true)
			if not parent.item then
				local entrustItem = self.entrustItem:clone()
				entrustItem:Pos(me.p(0,0))
				parent:addChild(entrustItem)
				parent.item = entrustItem
			end

			local itemData = items[i]
			if not itemData then
				parent:setVisible(false)
			else
				self:flushEntrustItem(parent.item,itemData)
			end

		end
	end
end

function ActivityEntrustView:flushBoxItems(  )
	local items = self:getItemsByType(EC_ActivityEntrustSubType.BOX)
	for j = 1,ActivityEntrustView.maxBoxNum do
		local node = TFDirector:getChildByPath(self.ui,"parent_Box"..j)
		if node then node:setVisible(false) end
	end

	for i = 1,#items do
		local itemData = items[i]
		local parent = TFDirector:getChildByPath(self.ui,itemData.extendData.giftUi)
		if parent then
			parent:setVisible(true)
			if not parent.item then
				local boxItem = self.boxItem:clone()
				boxItem:Pos(me.p(0,0))
				parent:addChild(boxItem)
				parent.item = boxItem
			end

			self:flushBoxItem(parent.item,itemData)
		end
	end
end

function ActivityEntrustView:flushBoxItem(node, data)
	local btn_icon = TFDirector:getChildByPath(node,"btn_icon")
	local progressBar = TFDirector:getChildByPath(node,"progressBar")
	local txt_progress = TFDirector:getChildByPath(node,"txt_progress")
	local RedTip = TFDirector:getChildByPath(node,"RedTip")
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	RedTip:setVisible(progressInfo.progress == 10000 and progressInfo.status ~= EC_TaskStatus.GETED)
	btn_icon:setTextureNormal(data.extendData.show)

	progressBar:setPercent(math.floor(progressInfo.progress/100))
	txt_progress:setText(math.floor(progressInfo.progress/100).."%")

	btn_icon:onClick(function ( ... )
		Utils:openView("activity.BoxDetailView",self.activityInfo.id,data)
	end)
end

function ActivityEntrustView:flushEntrustItem(node, data)
	local img_ydc = TFDirector:getChildByPath(node,"img_ydc")
	local panel_wdc = TFDirector:getChildByPath(node,"panel_wdc")
	local btn_bg = TFDirector:getChildByPath(node,"btn_bg")
	local icon = TFDirector:getChildByPath(node,"icon")
	local name = TFDirector:getChildByPath(node,"name")
	local RedTip = TFDirector:getChildByPath(node,"RedTip")
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	RedTip:setVisible(progressInfo.status == EC_TaskStatus.GET)
	img_ydc:setVisible(progressInfo.status == EC_TaskStatus.GETED)
	panel_wdc:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
	icon:setTexture(data.extendData.iconShow)
	btn_bg:setTextureNormal(data.extendData.bgShow)
	name:setText(data.extendData.des)
	
	btn_bg:onClick(function ( ... )
		if data.extendData.type == 3 or data.extendData.type == 4 then
			ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, data.id)
		else
			Utils:openView("activity.EntrustDetailView",self.activityInfo.id,data)
		end
	end)
end

function ActivityEntrustView:flushUI()
	self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
    local remainTime = math.max(0, math.ceil(self.activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)
    
    if hour ~="00" then
        self.label_refreshTime:setTextById("r301003", hour, min)
    else
        self.label_refreshTime:setTextById("r301004", min, sec)
    end
end

return ActivityEntrustView