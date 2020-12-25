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
local DuanwuTaskTip = class("DuanwuTaskTip",BaseLayer)

local PageIndex = {
					dating = 4,
					task = 5
				}

function DuanwuTaskTip:ctor()
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData()
	self:init("lua.uiconfig.activity.duanwuTaskTip")
end

function DuanwuTaskTip:initData()
	-- body
	self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_HANGUP)[1]
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.curSelectedPage = self.curSelectedPage or PageIndex.dating
end

function DuanwuTaskTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Image_role = TFDirector:getChildByPath(ui,"Image_role")

	self.Panel_story = TFDirector:getChildByPath(ui,"Panel_story")
	self.Panel_task = TFDirector:getChildByPath(ui,"Panel_task")
	self.panel_cg = TFDirector:getChildByPath(ui,"panel_cg")
	self.Button_task = TFDirector:getChildByPath(self.Panel_task,"Button_normal")
	self.Button_task_sel = TFDirector:getChildByPath(self.Panel_task,"Button_sel")
	self.Button_story = TFDirector:getChildByPath(self.Panel_story,"Button_normal")
	self.Button_story_sel = TFDirector:getChildByPath(self.Panel_story,"Button_sel")

	self.Image_refresh = TFDirector:getChildByPath(ui,"Image_refresh")
	self.Button_refresh = TFDirector:getChildByPath(self.Image_refresh,"Button_refresh")
	self.Label_timing = TFDirector:getChildByPath(self.Image_refresh,"Label_timing")
	self.goldnum = TFDirector:getChildByPath(self.Image_refresh,"goldnum")
	self.goldIcon = TFDirector:getChildByPath(self.Image_refresh,"goldIcon")



	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")
	self.uiList_task = UIListView:create(ScrollView_task)

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	local cg_cfg = TabDataMgr:getData("Cg",self.activityInfo.extendData.taskUIcg)
    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           -- self.panel_cg.cg:playEffect()
        end)
    layer:setAnchorPoint(ccp(0.5,0.5))
    self.panel_cg:addChild(layer)
    self.panel_cg.cg = layer

	self:updateBtnState()
	self:updateTaskList()
	self:onCountDownPer()
end

function DuanwuTaskTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_task:onClick(function ( ... )
		-- body
		self.curSelectedPage = PageIndex.task
		self:updateBtnState()
		self:updateTaskList()
	end)

	self.Button_story:onClick(function ( ... )
		-- body
		self.curSelectedPage = PageIndex.dating
		self:updateBtnState()
		self:updateTaskList()
	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
	
	self.Button_refresh:onClick(function ( ... )
		-- body 
		self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
	    local remainTime = math.max(0, math.ceil(self.activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
	    if remainTime > 0 then
	    	Utils:openView("activity.EntrustGemFlushView", self.activityInfo)
	    else
	    	local  args = {
	            tittle = 2107025,
	            reType = "duanwuTaskRefresh",
	            content = TextDataMgr:getText(13200923),
	            confirmCall = function ( ... )
	            	-- body
					TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityInfo.id,1})
	            end,
	        }
	        Utils:showReConfirm(args)
	end
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, function(activitId, itemId,reward)
		if self.activityInfo.id == activitId then
			Utils:showReward(reward)
		end
	end)
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateTaskList, self))
	self:addCountDownTimer()
end

function DuanwuTaskTip:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
    me.Director:setSingleEnabled(true)
    self:removeCountDownTimer()
end

function DuanwuTaskTip:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function DuanwuTaskTip:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function DuanwuTaskTip:onCountDownPer( ... )
	self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
	self.Label_timing:setText(Utils:getTimeCountDownString(math.ceil(self.activityInfo.extendData.refreshTime/1000),1))
end

function DuanwuTaskTip:updateBtnState( ... )
	-- body
	self.Button_task_sel:setVisible(self.curSelectedPage == PageIndex.task)
	self.Button_story_sel:setVisible(self.curSelectedPage == PageIndex.dating)

	self.Button_task:setVisible(self.curSelectedPage == PageIndex.dating)
	self.Button_story:setVisible(self.curSelectedPage == PageIndex.task)
	self.Image_refresh:setVisible(self.curSelectedPage == PageIndex.task)
end

function DuanwuTaskTip:getTaskList()
	-- body
	local items = ActivityDataMgr2:getItems(self.activityId)
	local showLists ={}
	for k,v in ipairs(items) do
		local taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,v)
		if math.floor(taskInfo.extendData.group/100) == self.curSelectedPage then
			table.insert( showLists, v )
		end
	end
	return showLists
end

function DuanwuTaskTip:updateTaskList( ... )
	-- body
	local taskIds = self:getTaskList()
	if #self.uiList_task:getItems() > #taskIds then
		for i = #self.uiList_task:getItems(),#taskIds,-1 do
			self.uiList_task:removeItem(i)
		end
	end

	for k,v in ipairs(taskIds) do
		local item = self.uiList_task:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_task:pushBackCustomItem(item)
		end
		self:updateItem(item,v)
	end

	local itemCfg_ = GoodsDataMgr:getItemCfg(self.activityInfo.extendData.refreshItemId)
   	local itemRecoverCfg = TabDataMgr:getData("ItemRecover",itemCfg_.buyItemRecover)
    local usedCount = self.activityInfo.extendData.refreshCount or 0
   	local remainCount = #itemRecoverCfg.price - usedCount
    if remainCount <= 0 then
        usedCount = #itemRecoverCfg.price - 1 
    end
   	local cost = itemRecoverCfg.price[usedCount + 1][1][1]

   	self.goldIcon:setTexture(GoodsDataMgr:getItemCfg(cost.id).icon)
   	self.goldnum:setText(cost.num)
end

function DuanwuTaskTip:updateItem( item, taskId )
	-- body
	local Panel_storyItem = TFDirector:getChildByPath(item,"Panel_storyItem"):hide()
	local Panel_taskItem = TFDirector:getChildByPath(item,"Panel_taskItem"):hide()

	local taskInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,taskId)

	if taskInfo.extendData.type == 3 then
		Panel_storyItem:show()
		self:updateStoreItem(Panel_storyItem,taskInfo)
	else
		Panel_taskItem:show()
		self:updateTaskItem(Panel_taskItem,taskInfo)
	end
end

function DuanwuTaskTip:updateTaskItem( item, data )
	local Panel_reward = TFDirector:getChildByPath(item, "Panel_reward")
	local Label_name = TFDirector:getChildByPath(item, "Label_name")
	local Label_des = TFDirector:getChildByPath(item, "Label_des")
	local Button_action = TFDirector:getChildByPath(item, "Button_action")
	local Button_get = TFDirector:getChildByPath(item, "Button_get")
	local Label_num1 = TFDirector:getChildByPath(item,"Panel_batch.Label_num1")

	local Label_finish = TFDirector:getChildByPath(item, "Label_finish")
	local Panel_batch = TFDirector:getChildByPath(item, "Panel_batch")
	local Image_day = TFDirector:getChildByPath(item, "Image_day")
	local Label_progress = TFDirector:getChildByPath(item, "Label_progress")

	local isLock = false
	if data.extendData.preCondition and data.extendData.preCondition ~= 0 then
		local preProgress = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.extendData.preCondition)
		if preProgress.status ~= EC_TaskStatus.GETED then
			isLock = true
		end
	end

	local taskProgress = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	Label_des:setText(data.details)
	Label_name:setText(data.extendData.des)
	Label_finish:setVisible(taskProgress.status == EC_TaskStatus.GETED)
	Button_action:setVisible(taskProgress.status == EC_TaskStatus.ING and data.extendData.type == 2)
	Button_get:setVisible(taskProgress.status == EC_TaskStatus.GET)
	Panel_batch:setVisible(data.extendData.type == 2 and taskProgress.status == EC_TaskStatus.ING)
	Label_des:setVisible(not (data.extendData.type == 2 and taskProgress.status == EC_TaskStatus.ING))

	Label_progress:setText(taskProgress.progress.."/"..data.target)
	Label_progress:setVisible(taskProgress.status ~= EC_TaskStatus.GETED)
	Image_day:setVisible(data.extendData.resetType == 4)
	if isLock then
		Label_des:show()
		Panel_batch:hide()
		Label_des:setTextById(13200910)
		Button_action:hide()
		Label_progress:hide()
		Button_get:hide()
		Label_finish:hide()
	end

	if not Panel_reward.award then
		Panel_reward.award = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		Panel_reward.award:setScale(0.6)
		Panel_reward.award:AddTo(Panel_reward):Pos(ccp(0, 0))
	end
	local id, value = next(data.reward)
	PrefabDataMgr:setInfo(Panel_reward.award, id, value)

	if data.extendData.type == 2 then
		self:updateBatch(Panel_batch,data)
	end

	Button_get:onClick(function ( ... )
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id)
	end)

	Button_action:onClick(function ( ... )
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
		local num = tonumber(Label_num1:getString())
		if num <= 0 then
			Utils:showTips(13200916)
			return
		end
		DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SUBMIT_TASK(data.id, data.extendData.finishParams.itemId , num, self.activityId)
	end)

end

function DuanwuTaskTip:updateBatch( batch, data )
	-- body
	local Button_down = TFDirector:getChildByPath(batch,"Button_down")
	local Button_up = TFDirector:getChildByPath(batch,"Button_up")
	local Label_num = TFDirector:getChildByPath(batch,"Label_num")
	local Label_num1 = TFDirector:getChildByPath(batch,"Label_num1"):hide()

	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	Label_num:setTextById("r3058",progressInfo.progress, data.target)
	Label_num1:setText(0)

	local function updateBatchPanel(num)
		local maxNum = data.target - progressInfo.progress
		maxNum = math.min(maxNum, GoodsDataMgr:getItemCount(data.extendData.finishParams.itemId))
		local curNum = tonumber(Label_num1:getString())
	   	curNum = num + curNum 
		curNum = math.max(0,curNum)
		curNum = math.min(maxNum, curNum)
		Label_num1:setText(curNum)
		local rStr = "r3058"
		if curNum > 0 then
			rStr = "r3059"
		end
		curNum = progressInfo.progress + curNum
		Label_num:setTextById(rStr,curNum,data.target)
	end

	local function onTouchButtonDown()
	    updateBatchPanel(-1)
	end

	local function onTouchButtonUp()
	    updateBatchPanel(1)
	end

	local function holdDownAction(isAddOp)
	    local speedTiming = 0
	    local timing = 0
	    local needTime = 0
	    local entryFalg = false

	    local function action(dt)
	        timing = timing + dt
	        speedTiming = speedTiming + dt
	        if speedTiming >= 3.0 then
	            entryFalg = true
	            needTime = 0.01
	        elseif speedTiming > 0.5 then
	            entryFalg = true
	            needTime = 0.05
	        end
	        if entryFalg and timing >= needTime then
	            if isAddOp then
	                onTouchButtonUp()
	            else
	                onTouchButtonDown()
	            end
	            timing = 0
	        end
	    end

	    self.timer = TFDirector:addTimer(0, -1, nil, action)
	end

	Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end

        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            onTouchButtonDown();
            holdDownAction(false)
        end
    end)

	Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            onTouchButtonUp();
            holdDownAction(true)
        end
    end)

end

function DuanwuTaskTip:updateStoreItem(item, data )
	-- body
	local Panel_reward = TFDirector:getChildByPath(item, "Panel_reward")
	local Label_name = TFDirector:getChildByPath(item, "Label_name")
	local Label_des = TFDirector:getChildByPath(item, "Label_des")
	local Button_read = TFDirector:getChildByPath(item, "Button_read")
	local Label_finish = TFDirector:getChildByPath(item, "Label_finish")
	local Button_get = TFDirector:getChildByPath(item, "Button_get")

	local isLock = false
	if data.extendData.preCondition and data.extendData.preCondition ~= 0 then
		local preProgress = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.extendData.preCondition)
		if preProgress.status ~= EC_TaskStatus.GETED then
			isLock = true
		end
	end

	local taskProgress = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data.id)
	Label_des:setText(data.details)
	Label_name:setText(data.extendData.des)
	Label_finish:setVisible(taskProgress.status == EC_TaskStatus.GETED)
	Button_read:setVisible(taskProgress.status == EC_TaskStatus.ING)
	Button_get:setVisible(taskProgress.status == EC_TaskStatus.GET)

	if isLock then
		Label_des:setTextById(13200910)
		Button_read:hide()
		Label_finish:hide()
		Button_get:hide()
	end

	if not Panel_reward.award then
		Panel_reward.award = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		Panel_reward.award:setScale(0.6)
		Panel_reward.award:AddTo(Panel_reward):Pos(ccp(0, 0))
	end
	local id, value = next(data.reward)
	PrefabDataMgr:setInfo(Panel_reward.award, id, value)

	Button_read:onClick(function ( ... )
		-- body
		FunctionDataMgr:jStartDating(data.extendData.datingScriptId)
	end)
	
	Button_get:onClick(function ( ... )
		-- body
		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id)
	end)
end

return DuanwuTaskTip