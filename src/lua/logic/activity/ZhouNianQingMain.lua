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
* -- 周年庆回忆活动主界面
* -- 关键方法 bottomAniAction 自动动作流程逻辑
]]

local ZhouNianQingMain = class("ZhouNianQingMain",BaseLayer)
local AnniversaryMonthBgTab = TabDataMgr:getData("AnniversarymonthBg")
local speedTime = 0.5

function ZhouNianQingMain:ctor( data )
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.activity.znqMainView")
end

function ZhouNianQingMain:initData( data )
	self.pramaData = data
	self.activityId = data.activityId
	self.isHuiGu = data.isHuiGu
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.cfgData = ActivityDataMgr2:getCfgDataByType(self.activityInfo.activityType) or {}
	self.detailData = {month = self.activityInfo.extendData.yearMonth}
	self.curMonth = data.month or self.detailData.month
	local hasFinish, curDay = ActivityDataMgr2:checkYearActivityCurMonthStatus(self.activityId, self.curMonth)
	self.curDay = self.curDay or data.day or curDay
	self.monthBgData = AnniversaryMonthBgTab[self.curMonth] -- 活动底部事件组配置信息
	self.monthCfgData = self.cfgData[self.curMonth] -- 活动条目组结构配置
	self.eventItem = self.monthBgData.eventList
	self.eventKeys = table.keys(self.eventItem)
	table.sort(self.eventKeys,function ( a , b )
		return a < b
	end)
end

function ZhouNianQingMain:getClosingStateParams()
	self.pramaData.month = self.curMonth
	self.pramaData.day = self.curDay
    return {self.pramaData}
end

function ZhouNianQingMain:onShow( )
	-- body
	self.super.onShow(self)
end

function ZhouNianQingMain:initUI( ui )
	self.super.initUI(self,ui)
	self.bg = TFDirector:getChildByPath(ui,"bg")
	self.Label_month = TFDirector:getChildByPath(ui,"Label_month")
	self.Label_day = TFDirector:getChildByPath(ui,"Label_day"):hide()
	self.Panel_cg = TFDirector:getChildByPath(ui,"Panel_cg")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Image_get = TFDirector:getChildByPath(ui,"Image_get")
	self.Button_nextStage = TFDirector:getChildByPath(ui,"Button_nextStage")
	self.Button_lastStage = TFDirector:getChildByPath(ui,"Button_lastStage")
	self.loadingBar_timeLine = TFDirector:getChildByPath(ui,"loadingBar_timeLine")
	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_point = TFDirector:getChildByPath(ui,"Panel_point")
	self.Panel_triggerEvent = TFDirector:getChildByPath(ui,"Panel_triggerEvent")
	self.Image_6 = TFDirector:getChildByPath(ui,"Image_6")
	self.label_title = TFDirector:getChildByPath(self.Image_6,"label_title")
	self.Label_Dot = TFDirector:getChildByPath(self.Image_6,"Label_Dot")
	self.label_Desc = TFDirector:getChildByPath(self.Image_6,"label_Desc")

	self.Panel_border = TFDirector:getChildByPath(ui,"Panel_border"):hide()
	self.Panel_effect = TFDirector:getChildByPath(ui,"Panel_effect"):hide()
	self.Panel_start = TFDirector:getChildByPath(ui,"Panel_start"):hide()
	self.Panel_end = TFDirector:getChildByPath(ui,"Panel_end"):hide()
	self.effect_start1 = TFDirector:getChildByPath(self.Panel_effect,"effect_start1"):hide()
	self.effect_start2 = TFDirector:getChildByPath(self.Panel_effect,"effect_start2"):hide()
	self.effect_shop = TFDirector:getChildByPath(self.Panel_effect,"effect_shop"):hide()
	self.effect_summon = TFDirector:getChildByPath(self.Panel_effect,"effect_summon"):hide()
	self.effect_trigger = TFDirector:getChildByPath(self.Panel_effect,"effect_trigger"):hide()
	self.effect_start = TFDirector:getChildByPath(self.Panel_effect,"effect_start"):hide()
	self.effect_end = TFDirector:getChildByPath(self.Panel_effect,"effect_end"):hide()
	self.effect_nextStage = TFDirector:getChildByPath(self.Button_nextStage,"effect_nextStage"):hide()

	self.effect_start1:setupPoseWhenPlay(false)
	self.effect_shop:setupPoseWhenPlay(false)
	self.effect_summon:setupPoseWhenPlay(false)
	self.effect_trigger:setupPoseWhenPlay(false)
	self.effect_start:setupPoseWhenPlay(false)
	self.effect_end:setupPoseWhenPlay(false)
	self.Panel_eventTrigger = TFDirector:getChildByPath(ui,"Panel_eventTrigger"):hide()

	-- self.bg:setTexture(self.monthBgData.backGround)
	if self.monthBgData.backgroundEffect ~= "" then
		local SkeletonAnimation = SkeletonAnimation:create(self.monthBgData.backgroundEffect)
		SkeletonAnimation:playByIndex(0,-1,-1,1)
		self.bg:addChild(SkeletonAnimation,2)
	end
	self.Panel_role:setPositionX(0)

	self.cgIds = self.monthBgData.cgPlay
	self.cgIndex = 1

	local function circlePlayCg( )
		-- body
		if self.cgView then self.cgView:removeFromParent(true) end

		local cg_cfg = TabDataMgr:getData("Cg")[self.cgIds[self.cgIndex]]
		local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           circlePlayCg( )
        end)

	    local parentSize = self.Panel_cg:Size()
	    local scaleX = parentSize.width/layer:Size().width
	    local scaleY = parentSize.height/layer:Size().height
	    layer:setScale(math.max(scaleX,scaleY) + 0.2)
	    self.Panel_cg:addChild(layer)
	    self.cgView = layer
		self.cgIndex = self.cgIndex%#self.cgIds + 1
	end

	if #self.cgIds > 1 then
		circlePlayCg( )
	end

	local ScrollView_itemList = TFDirector:getChildByPath(ui,"ScrollView_itemList")
	self.itemList = UIListView:create(ScrollView_itemList);

	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.rewardList = UIListView:create(ScrollView_reward);

	self.Button_lastStage:setVisible(self.isHuiGu)


	local percent = self.curDay/self.monthBgData.maxDay
	self.loadingBar_timeLine:setPercent(percent*100)
	self.bottomItems = {}
	self:updateDetail()
	self:updateItemList()
	self:updateBottomBar()
	self:updatePanelStart()
	self:updatePanelEnd({})

	self.label_title:setTextById(self.monthBgData.title)
	self.label_Desc:setTextById(self.monthBgData.titleDesc)
	self.Label_Dot:setTextById(14210172)
	
	local items = self.monthCfgData.eventGroup[self.curDay]
	if items then -- 当前阶段是开始阶段或者当前阶段没有事件自动开始选择阶段
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,items[1])
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,items[1])
		if itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.START then
			self.curDay = 0
			self:gotoNext()
		end
	else
		self:gotoNext()
	end
end

function ZhouNianQingMain:registerEvents( )
	-- body
	self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateContent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateActivity, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.closeSriptView, handler(self.datingScriptViewClose, self))

	self.Button_nextStage:onClick(function ( ... )
		-- body
		if ActivityDataMgr2:checkYearActivityCurDayStatus(self.activityId,self.curMonth,self.curDay) then
			if not self.hasRunning then
				self:gotoNext()
			end
		else
			local events = self.monthCfgData.eventGroup[self.curDay]
			if events then
				local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,events[1])
				if itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.START
					or itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.END then
					self:bottomAniAction()
					return
				end
			end
			Utils:showTips(14210042)
		end
	end)

	self.Button_lastStage:onClick(function ( ... )
		-- body
		if not self.hasRunning then
			self:gotoLast()
		end
	end)
end

function ZhouNianQingMain:updateDetail( )
	-- body
	local key = self.eventKeys[#self.eventKeys]
	local lastItemId = self.monthCfgData.eventGroup[key][1]
	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,lastItemId)
	self.Label_des:setText(itemInfo.details)

	self.rewardList:removeAllItems()
	local award = itemInfo.reward
	for k,v in pairs(award) do  
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem,k,v)
		Panel_goodsItem:setScale(0.5)
		self.rewardList:pushBackCustomItem(Panel_goodsItem)
	end
	local text = TextDataMgr:getText(14210002)

	local arry = string.split(text,",")

	self.Label_month:setText(arry[self.curMonth])
	self.Label_day:setText(self.curDay)

end

function ZhouNianQingMain:updateItemList( )
	self.itemList:removeAllItems()

	local events = self.monthCfgData.eventGroup[self.curDay]
	if events then -- 当前阶段是开始阶段或者当前阶段没有事件自动开始选择阶段
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,events[1])
		if itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.START or
			itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.END then
			self.Image_6:show()
			return
		end
	end

	self.Image_6:hide()
	for k,v in pairs(events) do
		local item = self.Panel_item:clone()
		self:updateItem(item,v)
		self.itemList:pushBackCustomItem(item)
	end
	self.effect_nextStage:setVisible(not self.isHuiGu and ActivityDataMgr2:checkYearActivityCurDayStatus(self.activityId,self.curMonth,self.curDay))
end

function ZhouNianQingMain:updateBottomBar( )
	-- body
	local maxDay = self.monthBgData.maxDay
	local percent = self.curDay/maxDay
	Utils:loadingBarChangeActionInTime(self.loadingBar_timeLine,percent*100,speedTime)
	local posX = self.loadingBar_timeLine:getContentSize().width*percent - 10

	if not self.roleModel then
		self.roleModel = SkeletonAnimation:create(self.monthBgData.model)
		self.roleModel:setScale(self.monthBgData.modelSize)
		self.Panel_role:addChild(self.roleModel)
		self.Panel_role:setPositionX(posX)
		self.roleModel:play("idle",1)
	end

	self.Panel_role:setScaleX(self.isBack and -1 or 1)
	self.Panel_role:runAction(CCMoveTo:create(speedTime,ccp(posX,self.Panel_role:Pos().y)))
	for k,v in ipairs(self.eventKeys) do
		local pointPercent = v/maxDay
		local bottomEventInfo = self.eventItem[v]
		if bottomEventInfo.hide ~= 1 then
			if not self.bottomItems[v] then
				local item = self.Panel_point:clone()
				local posX = pointPercent*self.loadingBar_timeLine:getContentSize().width - self.loadingBar_timeLine:getContentSize().width/2 + self.loadingBar_timeLine:Pos().x
				item:setPosition(ccp(posX,self.loadingBar_timeLine:getPositionY()))
				item:setZOrder(2)
				self.loadingBar_timeLine:getParent():addChild(item)
				self.bottomItems[v] = item
			end
			self:updatePoint(self.bottomItems[v],bottomEventInfo,k)
			self.bottomItems[v]:setVisible(self.isHuiGu or percent >= pointPercent)

		end
	end
end

function ZhouNianQingMain:updatePoint( item, data, idx)
	-- body
	local Panel_normal = TFDirector:getChildByPath(item,"Panel_normal"):hide()
	local Panel_cur = TFDirector:getChildByPath(item,"Panel_cur"):hide()
	local Panel_start = TFDirector:getChildByPath(item,"Panel_start"):hide()
	local Panel_end = TFDirector:getChildByPath(item,"Panel_end"):hide()
	local parent = Panel_normal

	if idx == 1 then
		parent = Panel_start
	elseif idx == #self.eventKeys then
		parent = Panel_end
	elseif self.eventKeys[idx] == self.curDay then
		parent = Panel_cur
	end
	parent:show()

	local Label_date = TFDirector:getChildByPath(parent,"Label_date")
	if Label_date then
		local bottomEventInfo = self.eventItem[self.eventKeys[idx]]
		Label_date:setText(data.text)
	end
end

function ZhouNianQingMain:updateItem( item, itemId )
	-- body
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId)
	local Image_mask = TFDirector:getChildByPath(item,"Image_mask")
	local Image_mask1 = TFDirector:getChildByPath(item,"Image_mask1")
	local border = TFDirector:getChildByPath(item,"border")
	local icon = TFDirector:getChildByPath(item,"icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_type = TFDirector:getChildByPath(item,"Label_type")
	local type_ = itemInfo.extendData.showType or itemInfo.extendData.yearBirthEvent
	border:setTexture("icon/zhounianqing/banner_"..type_..".png")
	icon:setTexture("icon/zhounianqing/icon_"..type_..".png")
	Label_name:setText(itemInfo.extendData.des2)
	Label_type:setText(itemInfo.details)

	Image_mask:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
	Image_mask1:setVisible(progressInfo.status == EC_TaskStatus.GETED)
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		self:actionFunc(itemInfo)
	end)

end

function ZhouNianQingMain:actionFunc( itemInfo )
	-- body
	if self.hasRunning then return end
	self.waitActionItemInfo = itemInfo
	if itemInfo.extendData.datingId then
		FunctionDataMgr:jStartDating(itemInfo.extendData.datingId)
     	return
	elseif itemInfo.extendData.dialogId then
		local param = {
            groupid = itemInfo.extendData.dialogId,
            isHideSkip = false,
            callback = function ()
            	if not tolua.isnull(self) then
	            	self:datingScriptViewClose()
	            end
            end,
        }
        self.talkView = requireNew("lua.logic.talk.TalkMainLayer"):new(param)
        AlertManager:addLayer(self.talkView,AlertManager.BLOCK)
        AlertManager:show()
     	return
	end
	self:datingScriptViewClose()
end

function ZhouNianQingMain:playStartAni( ... )
	-- body
	local function _playStartAni( ... )
		Utils:playSound(204)
		self.Panel_effect:show()
		self.Panel_border:show()
		self.effect_start:show()
		self.effect_start:play("ALL",0)
		self.effect_start:addMEListener(TFARMATURE_COMPLETE,function()
			self.effect_start:removeMEListener(TFARMATURE_COMPLETE)
			self.effect_start:play("xunhuan",1)
			self.Panel_start:show()

			self.ui:timeOut(function ( ... )
				self.effect_start:hide()
				self.Panel_start:hide()
				self.Panel_effect:hide()
				self.Panel_border:hide()
			end,2)
        end)
	end
	self.Panel_effect:show()
	self.Panel_border:show()
	self.effect_start1:show()
	self.effect_start1:play("animation",0)
	self.effect_start1:addMEListener(TFARMATURE_COMPLETE,function()
			self.effect_start1:removeMEListener(TFARMATURE_COMPLETE)
			local actArr = {
				CCFadeOut:create(0.5),
				CallFunc:create(function()
					self.effect_start1:setOpacity(0xff)
					self.effect_start1:hide()
					self.Panel_effect:hide()
					self.Panel_border:hide()
					_playStartAni()
				end),
         	}
			self.effect_start1:runAction(Sequence:create(actArr))
        end)
end

function ZhouNianQingMain:playEndAni( ... )
	Utils:playSound(204)
	self.Panel_effect:show()
	self.Panel_border:show()
	self.effect_end:show()
	self.effect_end:play("ALL",0)
	self.effect_end:addMEListener(TFARMATURE_COMPLETE,function()
		self.effect_end:removeMEListener(TFARMATURE_COMPLETE)
		self.effect_end:play("xunhuan",1)
		self.Panel_end:show()
		local items = self.endRewardList:getItems()
		local delay	 = 0.1
		for k,v in ipairs(items) do
            v:Alpha(0)
			local arry = {
					DelayTime:create(delay*(k-1)),
                    Spawn:create({
                            --CallFunc:create(function()
                            --        item:show()
                            --end),
                            CCFadeIn:create(0.15),
                            --MoveBy:create(0.2, ccp(offsetX, 0)),
                            CCScaleTo:create(0.15,v:getScale() + 0.2),
                            --Sequence:create({
                            --        ScaleTo:create(0.05, 1.5),
                            --        DelayTime:create(0.1),
                            --        ScaleTo:create(0.05, 1.0),
                            --}),
                    }),
                    CallFunc:create(function()
                        Utils:playSound(6002)
                    end),
                    CCScaleTo:create(0.15,v:getScale()),
				}
			v:runAction(Sequence:create(arry))			
		end
    end)
end

function ZhouNianQingMain:playTriggerEventAni( ... )
	Utils:playSound(204)
	self.Panel_effect:show()
	self.Panel_border:show()
	self.effect_trigger:show()
	self.effect_trigger:play("ALL",0)
	self.effect_trigger:addMEListener(TFARMATURE_COMPLETE,function()
		self.effect_trigger:removeMEListener(TFARMATURE_COMPLETE)
		self.effect_trigger:play("xunhuan",1)
		self.Panel_eventTrigger:show()
		local items = self.uiList_trigger:getItems()
		local delay	 = 0.1
		for k,v in ipairs(items) do
            v:Alpha(0)
			local arry = {
					DelayTime:create(delay*(k-1)),
                    Spawn:create({
                            --CallFunc:create(function()
                            --        item:show()
                            --end),
                            CCFadeIn:create(0.15),
                            --MoveBy:create(0.2, ccp(offsetX, 0)),
                            CCScaleTo:create(0.15,v:getScale() + 0.2),
                            --Sequence:create({
                            --        ScaleTo:create(0.05, 1.5),
                            --        DelayTime:create(0.1),
                            --        ScaleTo:create(0.05, 1.0),
                            --}),
                    }),
                    CallFunc:create(function()
                        Utils:playSound(6002)
                    end),
                    CCScaleTo:create(0.15,v:getScale()),
				}
			v:runAction(Sequence:create(arry))			
		end
    end)
end

function ZhouNianQingMain:updateTriggerEvent( ... )
	-- body
	local label_tip = TFDirector:getChildByPath(self.Panel_eventTrigger,"label_tip")
	local ScrollView_triggerEvent = TFDirector:getChildByPath(self.Panel_eventTrigger,"ScrollView_triggerEvent")
	local panel_touch = TFDirector:getChildByPath(self.Panel_eventTrigger,"Panel_touch")
	self.uiList_trigger = self.uiList_trigger or UIListView:create(ScrollView_triggerEvent)
	label_tip:setTextById(self.monthBgData.beginText)

	local events = self.monthCfgData.eventGroup[self.curDay]

	self.uiList_trigger:removeAllItems()
	for k,v in pairs(events) do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,v)
		local item = self.Panel_triggerEvent:clone()
		local icon = TFDirector:getChildByPath(item,"icon")
		local name = TFDirector:getChildByPath(item,"name")
		local type_ = itemInfo.extendData.showType or itemInfo.extendData.yearBirthEvent
		icon:setTexture("icon/zhounianqing/icon_"..type_..".png")
		name:setText(itemInfo.extendData.des2)
		self.uiList_trigger:pushBackCustomItem(item)
	end

	self.uiList_trigger:setCenterArrange()
	panel_touch:onClick(function ( ... )
		self.Panel_eventTrigger:hide()
		self.Panel_effect:hide()
		self.Panel_border:hide()
		self.effect_trigger:hide()
	end)

end

function ZhouNianQingMain:bottomAniAction( )
	-- body
	self:updateBottomBar()
	local bottomEventInfo = self.eventItem[self.curDay]
	local needStop = false
	self.hasRunning = true
	if bottomEventInfo then
		local events = self.monthCfgData.eventGroup[self.curDay]
		if events then
			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,events[1])
			self.waitActionItemInfo_ = itemInfo
			self.waitCallBack = function ( ... )
				local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,self.waitActionItemInfo_.id)
				if self.waitActionItemInfo_.extendData.yearBirthEvent == EC_YearActivityEventType.START then
					if progressInfo.status ~= EC_TaskStatus.GETED then
						ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.waitActionItemInfo_.id)
					end
					self:playStartAni()
				elseif self.waitActionItemInfo_.extendData.yearBirthEvent == EC_YearActivityEventType.END then
					if progressInfo.status ~= EC_TaskStatus.GETED then
						ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.waitActionItemInfo_.id)
					else
						self.Panel_effect:show()
						self.Panel_border:show()
						self.effect_start2:show()
						self.effect_start2:play("animation2",0)

						self.effect_start2:addMEListener(TFARMATURE_COMPLETE,function()
								self.effect_start2:removeMEListener(TFARMATURE_COMPLETE)
								AlertManager:closeLayer(self)
					        end)
					end
				else
					self:updateItemList()
					if not self.isHuiGu then
						self:updateTriggerEvent()
						self:playTriggerEventAni()
					end
				end
				self.waitActionItemInfo_ = nil
				self.waitCallBack = nil
			end
			needStop = true
		end
		local hasOtherAction = false
		if not self.isBack and bottomEventInfo.datingId then
			self.actionTimer =  TFDirector:addTimer(0,1,nil,function ( ... )  -- 错开界面刷新冲突界面混乱
			 	FunctionDataMgr:jStartDating(bottomEventInfo.datingId)
				self.actionTimer = nil
			end)
			needStop = true
			hasOtherAction = true
		end

		if not self.isBack and bottomEventInfo.dialogId then
            local param = {
                groupid = bottomEventInfo.dialogId,
                isHideSkip = false,
                callback = function ()
                   self:datingScriptViewClose()
                end,
            }
            self.talkView = requireNew("lua.logic.talk.TalkMainLayer"):new(param)
            AlertManager:addLayer(self.talkView,AlertManager.BLOCK)
            AlertManager:show()
			needStop = true
			hasOtherAction = true
		end

		if not hasOtherAction and self.waitCallBack then
			self.waitCallBack()
			self.waitCallBack = nil
		end
	end


	local curIndex = 0
	for k,v in ipairs(self.eventKeys) do
		if self.curDay > v then
			curIndex = k
		else
			break;
		end
	end

	local dir = 1
	if self.isBack then
		dir = -1
		curIndex = curIndex + 1
	end

	-- local lastDay = self.eventKeys[curIndex] or 1
	-- local nextDay = self.eventKeys[curIndex + dir] or 1
	-- local texture1 = self.eventItem[lastDay].bg
	-- local texture2 = self.eventItem[nextDay].bg or texture1
	-- texture1 = texture1 or texture2
	-- if texture1 then
	-- 	self.Image_cg:setTexture(texture1)
	-- 	self.Image_cg1:setTexture(texture2)

	-- 	local changeOpacity = math.min(math.abs(self.curDay - nextDay),3)/3*255
	-- 	self.Image_cg:setOpacity(changeOpacity)
	-- 	self.Image_cg1:setOpacity(255 - changeOpacity)
	-- end

	if not needStop then
		if self.roleModel.newAction ~= "move" then
			self.roleModel:play("move",1)
			self.roleModel.newAction = "move"
		end
		self.actionTimer = TFDirector:addTimer(speedTime*1000,1,nil,function ( ... )
			self.actionTimer = nil
			if not self.isBack then
				self:gotoNext()
			else
				self:gotoLast()
			end
		end )
	else
		self.roleModel.newAction = nil
		self.ui:timeOut(function ( ... )
			self.roleModel:play("idle",1)
			self.hasRunning = false
		end,speedTime)
	end
end

function ZhouNianQingMain:gotoLast(  )
	-- body
	self.curDay = math.max(self.curDay - 1,1)
	self.isBack = true
	self:bottomAniAction()
end

function ZhouNianQingMain:gotoNext(  )
	-- body
	self.isBack = false
	self.curDay = math.min(self.curDay + 1,self.monthBgData.maxDay)
	self:bottomAniAction()
end

function ZhouNianQingMain:removeEvents( )
	self.super.removeEvents(self)
	TFDirector:stopTimer(self.actionTimer)
	TFDirector:removeTimer(self.actionTimer)
	self.actionTimer = nil

	local key = self.eventKeys[#self.eventKeys]
	local lastItemId = self.monthCfgData.eventGroup[key][1]
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,lastItemId)

	if not self.isHuiGu and self.curMonth < table.count(AnniversaryMonthBgTab) and progressInfo.status == EC_TaskStatus.GETED then
	    local monthCfgData = self.cfgData[self.curMonth + 1]
        if tonumber(monthCfgData.openTime) <= ServerDataMgr:getServerTime() then
		ActivityDataMgr2:pushNewYearActivityToNextMonth(self.activityId)
        end
	end
end

function ZhouNianQingMain:updatePanelStart( )
	-- body
	self.label_startDate = TFDirector:getChildByPath(self.Panel_start,"label_startDate")
	self.label_endDate = TFDirector:getChildByPath(self.Panel_start,"label_endDate")
	self.label_tip = TFDirector:getChildByPath(self.Panel_start,"label_tip")
	self.label_startDate:setTextById(self.monthBgData.beginText1)
	self.label_endDate:setTextById(self.monthBgData.beginText2)
	self.label_tip:setTextById(self.monthBgData.beginText)
end

function ZhouNianQingMain:updatePanelEnd( rewards )
	-- body
	self.label_startDate = TFDirector:getChildByPath(self.Panel_end,"label_startDate")
	self.label_endDate = TFDirector:getChildByPath(self.Panel_end,"label_endDate")
	self.label_tip = TFDirector:getChildByPath(self.Panel_end,"label_tip")
	self.label_startDate:setTextById(self.monthBgData.beginText1)
	self.label_endDate:setTextById(self.monthBgData.beginText2)
	self.label_tip:setTextById(self.monthBgData.beginText)
	local panel_touch = TFDirector:getChildByPath(self.Panel_end,"Panel_touch")

	local ScrollView_EndReward = TFDirector:getChildByPath(self.Panel_end,"ScrollView_EndReward")
	self.endRewardList = self.endRewardList or UIListView:create(ScrollView_EndReward)
	self.endRewardList:removeAllItems()
	for k,v in pairs(rewards) do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem,v.id,v.num)
		Panel_goodsItem:setScale(0.8)
		self.endRewardList:pushBackCustomItem(Panel_goodsItem)
	end

	self.endRewardList:setCenterArrange()
	panel_touch:onClick(function ( ... )
		self.Panel_end:hide()
		self.Panel_effect:show()
		self.Panel_border:show()
		self.effect_end:hide()
		self.effect_start2:show()
		self.effect_start2:play("animation2",0)

		self.effect_start2:addMEListener(TFARMATURE_COMPLETE,function()
				self.effect_start2:removeMEListener(TFARMATURE_COMPLETE)
				AlertManager:closeLayer(self)
	        end)
	end)
end

function ZhouNianQingMain:datingScriptViewClose()
	-- body
	if self.waitCallBack then
		self.waitCallBack()
	end

	if self.waitActionItemInfo then
		self:itemRealAction(self.waitActionItemInfo)
	end
	self.waitActionItemInfo = nil
end

function ZhouNianQingMain:itemRealAction( itemInfo )
	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemInfo.id)
	if itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.LEVEL then
    	Utils:openView("activity.ZhouNianQingGuanQia",self.activityId, itemInfo)
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.DATING then

	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.AWARD then
    	Utils:openView("activity.ZhouNianQingJiangLi",self.activityId,itemInfo)
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.SHOP then
		if progressInfo.status ~= EC_TaskStatus.GETED then
			ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.waitActionItemInfo.id)
		else
			Utils:openView("activity.ZhouNianQingPopView",self.activityId,itemInfo)
		end
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.SUMMON then
		if progressInfo.status ~= EC_TaskStatus.GETED then
			ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.waitActionItemInfo.id)
		else
			Utils:openView("activity.ZhouNianQingPopView",self.activityId,itemInfo)
		end
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.LETTER then
    	Utils:openView("activity.ZhouNianQingXinJian",self.activityId ,itemInfo)
	end
end

function ZhouNianQingMain:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,itemId)

    if itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.SHOP then
		Utils:playSound(204)
    	self.Panel_effect:show()
		self.Panel_border:show()
    	self.effect_shop:show()
    	self.effect_shop:play("ALL",0)
		self.effect_shop:addMEListener(TFARMATURE_COMPLETE,function()
			self.effect_shop:removeMEListener(TFARMATURE_COMPLETE)
			self.effect_shop:play("xunhuan",1)
			self.ui:timeOut(function ( ... )
    			Utils:openView("activity.ZhouNianQingPopView",self.activityId,itemInfo)
		    	self.Panel_effect:hide()
				self.Panel_border:hide()
		    	self.effect_shop:hide()
			end,1)
        end)
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.SUMMON then
		Utils:playSound(204)
		self.Panel_effect:show()
		self.Panel_border:show()
    	self.effect_summon:show()
    	self.effect_summon:play("ALL",0)
		self.effect_summon:addMEListener(TFARMATURE_COMPLETE,function()
			self.effect_summon:removeMEListener(TFARMATURE_COMPLETE)
			self.effect_summon:play("xunhuan",1)
			self.ui:timeOut(function ( ... )
    			Utils:openView("activity.ZhouNianQingPopView",self.activityId,itemInfo)
		    	self.Panel_effect:hide()
				self.Panel_border:hide()
		    	self.effect_summon:hide()
			end,1)
        end)
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.END then
		self:updatePanelEnd(reward)
		self:playEndAni()
	elseif itemInfo.extendData.yearBirthEvent == EC_YearActivityEventType.START then

	else
	    Utils:showReward(reward)
	end
end

function ZhouNianQingMain:updateActivity() -- 现在逻辑不需要刷新活动数据， 只需要刷新条目数据刷新
	-- body
	-- self:initData(self.pramaData)
	-- self:updateDetail()
	-- self:updateBottomBar()
end

function ZhouNianQingMain:updateContent()
	-- body
	self:updateItemList()
end

return ZhouNianQingMain