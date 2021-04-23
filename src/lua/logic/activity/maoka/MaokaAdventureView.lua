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

local MaokaAdventureView = class("MaokaAdventureView",BaseLayer)

function MaokaAdventureView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:init("lua.uiconfig.activity.adventure")
end

function MaokaAdventureView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Label_time = TFDirector:getChildByPath(ui,"Label_time")
	self.Button_go = TFDirector:getChildByPath(ui,"Button_go")
	self.Button_get = TFDirector:getChildByPath(ui,"Button_get")


	self.Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
	self:updateLeftPanel()
	self:updateRightPanel()
end

function MaokaAdventureView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_go:onClick(function ( ... )
		-- body
		local taskInfo, progressInfo = MaokaActivityMgr:getActivityItemInfo(self.curTaskId)

		if progressInfo.status ~= EC_TaskStatus.ING then
			return
		end

		local catList = MaokaActivityMgr:getPaiQianCatList(taskInfo)
		if #catList < taskInfo.extendData.catCount then
			Utils:showTips(13316871) 
			return
		end
		Utils:openView("activity.maoka.MaokaPaiqianTip",self.curTaskId)
	end)

	self.Button_get:onClick(function ( ... )
		-- body
		local taskInfo, progressInfo = MaokaActivityMgr:getActivityItemInfo(self.curTaskId)
		MaokaActivityMgr:submitItemInfo(self.curTaskId)
		if progressInfo.status == EC_TaskStatus.GET then
			if taskInfo.extendData.datingId then
				FunctionDataMgr:jStartDating(taskInfo.extendData.datingId)
			end
			return
		end
	end)
  	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateContent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateContent, self))

	self.updateTimer = TFDirector:addTimer(1000,-1,nil,function ( ... )
		-- body
		self:updateCountPer()
	end)

	EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( )
        -- body
        self:updateLeftPanel()
        self:updateRightPanel()
    end)

end

function MaokaAdventureView:onSubmitSuccessEvent( activitId, itemId, reward)
	-- body
	if not  MaokaActivityMgr:isMaokaActivity(activitId) then
		return
	end
	if reward then
		Utils:showReward(reward)
	end

end

function MaokaAdventureView:updateContent( ... )
	-- body
    self:updateLeftPanel()
    self:updateRightPanel()
end

function MaokaAdventureView:updateCountPer( ... )
	-- body
	if not self.curTaskId then return end
	local _,progressInfo = MaokaActivityMgr:getActivityItemInfo(self.curTaskId)
	if not _ then return end
	local catTaskInfo = MaokaActivityMgr:getCatTaskInfo(self.curTaskId)
	local curTime = 0
	if catTaskInfo then
		curTime = catTaskInfo.etime - ServerDataMgr:getServerTime()
	end
	if curTime <= 0 or progressInfo.status ~= EC_TaskStatus.ING then
		self.Label_time:hide()
		return
	end
	self.Label_time:show()
	self.Label_time:setText(Utils:getTimeCountDownString(catTaskInfo.etime, 2))
end

function MaokaAdventureView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeAiTimer()
	if self.updateTimer then
		TFDirector:stopTimer(self.updateTimer)
		TFDirector:removeTimer(self.updateTimer)
		self.updateTimer = nil
	end
end

function MaokaAdventureView:updateLeftPanel( ... )
	-- body
	if not self.initLeftPanel then
		self.initLeftPanel = true
		self.Panel_pos = {}
		for i = 1,10 do
			self.Panel_pos[i] = TFDirector:getChildByPath(self.Panel_left,"Panel_pos"..i)
			self.Panel_pos[i].Image_icon = TFDirector:getChildByPath(self.Panel_pos[i],"Image_icon")
			self.Panel_pos[i].Image_redPoint = TFDirector:getChildByPath(self.Panel_pos[i],"Image_redPoint")
			self.Panel_pos[i].Image_ing = TFDirector:getChildByPath(self.Panel_pos[i],"Image_ing")
		end
	end

	for k,v in ipairs(self.Panel_pos) do
		v.Image_icon:hide()
		v.Image_redPoint:hide()
		v.Image_ing:hide()
	end
	local curTime = ServerDataMgr:getServerTime()
	local taskList = MaokaActivityMgr:getCatTask()
	self.curTaskId = self.curTaskId or taskList[1]

	if table.find(taskList,self.curTaskId) == -1 then
		self.curTaskId = taskList[1]
	end

	for k,v in ipairs(taskList) do
		local taskInfo ,progressInfo = MaokaActivityMgr:getActivityItemInfo(v)
		local pos = taskInfo.extendData.taskPoint

		self.Panel_pos[pos].Image_icon:show()
		local icon = taskInfo.extendData.icon
		if v == self.curTaskId then
			icon = string.sub(icon, 0, -5).."1.png"
		end
		self.Panel_pos[pos].Image_icon:setTexture(icon)
		local catTaskInfo = MaokaActivityMgr:getCatTaskInfo(v)
		local etime = catTaskInfo and catTaskInfo.etime or 0
		self.Panel_pos[pos].Image_redPoint:setVisible(progressInfo.status == EC_TaskStatus.GET or  (etime > 0 and etime <= curTime) )
		self.Panel_pos[pos].Image_ing:setVisible(progressInfo.status == EC_TaskStatus.ING and  (etime > curTime))

		self.Panel_pos[pos]:setTouchEnabled(true)
		self.Panel_pos[pos]:onClick(function ( ... )
			-- body
			if self.curTaskId == v then return end
			self:removeAiTimer()
			self.curTaskId = v
			self:updateLeftPanel()
			self:updateRightPanel()
		end)
	end
end

function MaokaAdventureView:updateRightPanel( ... )
	-- body
	if not self.initRightPanel then
		self.initRightPanel = true
		self.Label_name = TFDirector:getChildByPath(self.Panel_right,"Label_name")
		self.Label_taskDes = TFDirector:getChildByPath(self.Panel_right,"Label_taskDes")
		self.ScrollView_reward = TFDirector:getChildByPath(self.Panel_right,"ScrollView_reward")
		self.Image_zhong = TFDirector:getChildByPath(self.Panel_right,"Image_zhong")
		self.Image_jin = TFDirector:getChildByPath(self.Panel_right,"Image_jin")
		self.Image_zhong1 = TFDirector:getChildByPath(self.Panel_right,"Image_zhong1")
		self.Image_jin1 = TFDirector:getChildByPath(self.Panel_right,"Image_jin1")
		self.Spine_cat = TFDirector:getChildByPath(self.Panel_right,"Spine_cat")
	end
	if not self.curTaskId then return end
	local taskInfo ,progressInfo = MaokaActivityMgr:getActivityItemInfo(self.curTaskId)

	self.Label_name:setText(taskInfo.details)
	self.Label_taskDes:setText(taskInfo.extendData.des2)
	Utils:createRewardListHor(self.ScrollView_reward, taskInfo.reward)

	
	self.Image_jin:setTexture(taskInfo.extendData.exploreMap1)
	self.Image_jin1:setTexture(taskInfo.extendData.exploreMap1)
	self.Image_zhong:setTexture(taskInfo.extendData.exploreMap2)
	self.Image_zhong1:setTexture(taskInfo.extendData.exploreMap2)
	self.Image_jin1:visit()
	self.Image_zhong1:visit()

	local catId = MaokaActivityMgr:getCatListByTaskId(self.curTaskId)[1]

	self.Spine_cat:setVisible(catId)
	if catId  then
		if not self.isPlaying then
			self.isPlaying = true
			self.Spine_cat:show()
			local catCfg = TabDataMgr:getData("CatList",catId)
			self.Spine_cat:setFile(catCfg.rolePath)
			self.Spine_cat:play("idle2",true)
			self.ui:timeOut(function ( ... )
				self:beginCatModel()
			end,0)
		end
	else
		self.Spine_cat:hide()
		self:removeAiTimer()
	end
	self.Button_go:setVisible(not catId and progressInfo.status == EC_TaskStatus.ING)
	self.Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)

	self:updateCountPer()
end

function MaokaAdventureView:beginCatModel( ... )
	-- body
	self:removeAiTimer()
	self:randomAiAction()
end

function MaokaAdventureView:catPlayRandomAni( ... )
	-- body
	local randomActions = {"siyaohaozi", "pujincaocong","special1", "zhamao"}
	local action = randomActions[math.random(1,#randomActions)]
	self.Spine_cat:play(action, false)
	self.Spine_cat:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
				self.Spine_cat:removeMEListener(TFARMATURE_COMPLETE)
				self.moveWeight = 10000
				self:randomAiAction()
			end)
end

function MaokaAdventureView:randomAiAction(  )
	-- body
	local randomFunc = {"catPlayRandomAni", "catMove"}
	local weight = math.random(1,10000)
	self.moveWeight = self.moveWeight or 10000
	local index = weight < self.moveWeight and 2 or 1
	self[randomFunc[index]](self)
end

function MaokaAdventureView:removeAiTimer( ... )
	-- body
	self.isPlaying = false
	self.Image_jin:stopAllActions()
	self.Image_jin1:stopAllActions()
	self.Image_zhong:stopAllActions()
	self.Image_zhong1:stopAllActions()
	if self.aiDelayTimer then 
		TFDirector:stopTimer(self.aiDelayTimer)
		TFDirector:removeTimer(self.aiDelayTimer)
		self.aiDelayTimer = nil
	end
	self.Spine_cat:removeMEListener(TFARMATURE_COMPLETE)
end

function MaokaAdventureView:addDelayCallAi( delayTime )
	-- body
	if not self.aiDelayTimer then
		self.aiDelayTimer = TFDirector:addTimer(delayTime,1,nil,function ( ... )
			-- body
			self.aiDelayTimer = nil
			self:randomAiAction()
		end)
	end
end

function MaokaAdventureView:catMove( ... )
	-- body
	self.Spine_cat:play("move", true)
	self:mapMove(-150,2)
	self:addDelayCallAi(2000)
	self.moveWeight = 0
end

function MaokaAdventureView:mapMove( offset, time )
	-- body
	self.Image_jin:runAction(CCMoveBy:create(time,ccp(offset,0)))
	self.Image_jin1:runAction(CCMoveBy:create(time,ccp(offset,0)))
	self.Image_zhong:runAction(CCMoveBy:create(time,ccp(offset*0.8,0)))
	self.Image_zhong1:runAction(CCMoveBy:create(time,ccp(offset*0.8,0)))
	if math.abs(self.Image_jin:getPositionX()) > self.Image_jin1:getContentSize().width then
		local setPos = self.Image_jin1:getContentSize().width
		if offset > 0 then
			setPos = -setPos
		end
		self.Image_jin:setPositionX(setPos + self.Image_jin1:getPositionX())
	end

	if math.abs(self.Image_jin1:getPositionX()) > self.Image_jin:getContentSize().width then
		local setPos = self.Image_jin:getContentSize().width
		if offset > 0 then
			setPos = -setPos
		end
		self.Image_jin1:setPositionX(setPos + self.Image_jin:getPositionX())
	end

	if math.abs(self.Image_zhong:getPositionX()) > self.Image_zhong1:getContentSize().width then
		local setPos = self.Image_zhong1:getContentSize().width
		if offset > 0 then
			setPos = -setPos
		end
		self.Image_zhong:setPositionX(setPos + self.Image_zhong1:getPositionX())
	end

	if math.abs(self.Image_zhong1:getPositionX()) > self.Image_zhong:getContentSize().width then
		local setPos = self.Image_zhong:getContentSize().width
		if offset > 0 then
			setPos = -setPos
		end
		self.Image_zhong1:setPositionX(setPos + self.Image_zhong:getPositionX())
	end

end

return MaokaAdventureView