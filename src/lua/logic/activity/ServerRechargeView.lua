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
*  -- 全服返利活动
]]

local ServerRechargeView = class("ServerRechargeView",BaseLayer)

function ServerRechargeView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId_ = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SERVER_GIFT)[1]
	-- self.activityId_ = data
	self:init("lua.uiconfig.activity.serverRechargeView")
end

function ServerRechargeView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.label_time = TFDirector:getChildByPath(ui,"label_time")
	self.label_des = TFDirector:getChildByPath(ui,"label_des")

	self.label_time:setSkewX(10)
	self.label_des:setSkewX(10)
	self.label_number = TFDirector:getChildByPath(ui,"label_number")
	self.panel_ItemParent = TFDirector:getChildByPath(ui,"panel_ItemParent")
	self.Button_goShop = TFDirector:getChildByPath(ui,"Button_goShop")

	self.Panel_Item = TFDirector:getChildByPath(ui,"Panel_Item")

	self:refreshView( )
	self:updateCountDonw()
	self.Button_goShop:onClick(function ( ... )
		Utils:openView("activity.GiftStoreView",self.activityId_)
	end)
end

function ServerRechargeView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
    self:addCountDownTimer()
end

function ServerRechargeView:refreshView( ... )
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId_)
	local items = ActivityDataMgr2:getItems(self.activityId_)


	self.label_des:setText(self.activityInfo.extendData.des)
	self.curMaxProgress = 0
	for k,v in ipairs(items) do
		self.itemNodes = self.itemNodes or {}
		local item = self.itemNodes[v]
		if not item then
			item = self.Panel_Item:clone()
			self.panel_ItemParent:addChild(item)
			local pos = self.activityInfo.extendData.itemPos and self.activityInfo.extendData.itemPos[k] or ccp(100,100)
			local scale = self.activityInfo.extendData.scale or 1
			
			item:setPosition(pos)
			item:setScale(scale)
			self.itemNodes[v] = item
		end
		self:updateItem(item,v)
	end
	
	self.label_number:setText(self.activityInfo.extendData.buyCount or 0)
	
end

function ServerRechargeView:updateItem( item, id)
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, id)
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, id)

		local Panel_geted = TFDirector:getChildByPath(item,"Panel_geted"):hide()
		local Panel_get = TFDirector:getChildByPath(item,"Panel_get"):hide()
		local Panel_ing = TFDirector:getChildByPath(item,"Panel_ing"):hide()

		local node
		if progressInfo.status == EC_TaskStatus.ING then
			node = Panel_ing
		elseif progressInfo.status == EC_TaskStatus.GET then
			node = Panel_get
		elseif progressInfo.status == EC_TaskStatus.GETED then
			node = Panel_geted
		end
		node:show()

		local Label_num = TFDirector:getChildByPath(node,"Label_num")
		local Image_bg = TFDirector:getChildByPath(node,"Image_bg")
		local Image_buyFlag = TFDirector:getChildByPath(node,"Image_buyFlag")
		local Spine_effect = TFDirector:getChildByPath(node,"Spine_effect")

		if Spine_effect then
			Spine_effect:playByIndex(0,-1,-1,1)
		end

		Label_num:setText(itemInfo.target)

		if Image_buyFlag then
			Image_buyFlag:setVisible(itemInfo.extendData.spread == 1)
		end

		Image_bg:setTouchEnabled(true)
		Image_bg:onClick(function ( ... )
			if progressInfo.status == EC_TaskStatus.GET then
			 	ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, id)
			else
				self:showRewardPreview(item, itemInfo.reward)
			end
	end)

end

function ServerRechargeView:showRewardPreview(item, reward)
    -- self.Image_preview:AnchorPoint(ccp(0.5, 0))
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end

    local wp = item:convertToWorldSpaceAR(me.p(0, 0))
    local np = self.ui:convertToNodeSpaceAR(wp)
    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
end

function ServerRechargeView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onUpdateCountDownEvent, self))
    end
end

function ServerRechargeView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function ServerRechargeView:removeEvents( ... )
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end


function ServerRechargeView:updateCountDonw()
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.activityInfo.showEndTime - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.label_time:setTextById(self.activityInfo.extendData.hourRstring, hour, min)
    else
        self.label_time:setTextById(self.activityInfo.extendData.dayRstring, day, hour)
    end
end

function ServerRechargeView:onUpdateProgressEvent()
     self:refreshView()
end

function ServerRechargeView:onUpdateActivityEvent()
    self:refreshView()
end

function ServerRechargeView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function ServerRechargeView:onUpdateCountDownEvent()
    self:updateCountDonw()
end


return ServerRechargeView