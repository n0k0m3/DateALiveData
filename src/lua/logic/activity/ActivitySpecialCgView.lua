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
* -- 特殊CG收集活动
]]

local ActivitySpecialCgView = class("ActivitySpecialCgView",BaseLayer)
function ActivitySpecialCgView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(data)
	self.cgListType = string.split(self.activityInfo.extendData.cgListType,",")
	self:init("lua.uiconfig.activity.activityCgView")
end

function ActivitySpecialCgView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.panel_cg = TFDirector:getChildByPath(ui,"panel_cg")
	self.bg_Cg = TFDirector:getChildByPath(self.panel_cg,"bg_Cg")
	self.cgName = TFDirector:getChildByPath(self.panel_cg,"label_name")
	self.pingtuNodes = {}

	local panel_pingtu = TFDirector:getChildByPath(self.panel_cg,"panel_pingtu")
	for i = 1,#self.cgListType do
		self.pingtuNodes[i] = TFDirector:getChildByPath(panel_pingtu,"shuipian_"..i)
	end

	self.panel_collectting = TFDirector:getChildByPath(self.panel_cg,"panel_collectting")
	self.label_progress = TFDirector:getChildByPath(self.panel_collectting,"label_progress")
	self.panel_dating = TFDirector:getChildByPath(self.panel_cg,"panel_dating")
	self.button_dating = TFDirector:getChildByPath(self.panel_dating,"button_dating")
	self.panel_review = TFDirector:getChildByPath(self.panel_cg,"panel_review")
	self.button_review = TFDirector:getChildByPath(self.panel_review,"button_review")

	self.panel_task = TFDirector:getChildByPath(ui,"panel_task")
	self.time_num = TFDirector:getChildByPath(ui,"time_num")
	self.button_flush = TFDirector:getChildByPath(ui,"button_flush")
	self.button_gemflush = TFDirector:getChildByPath(ui,"button_gemflush")
	self.Label_cost_num = TFDirector:getChildByPath(ui,"Label_cost_num")
	self.Image_cost_icon = TFDirector:getChildByPath(ui,"Image_cost_icon")
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item")

	self:flushUI()
	self:addCountDownTimer()
	self:flushTaskList()
	self:flushCgPingtu()

end

function ActivitySpecialCgView:registerEvents(  )
	self.super.registerEvents()
  	EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.onRefreshEntrustEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
		self:flushTaskList()
	end)

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
		self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId )
		self.cgListType = string.split(self.activityInfo.extendData.cgListType,",")
		self:flushTaskList()
		self:flushCgPingtu()
	end)

	self.button_dating:onClick(function ( ... )
		-- body
		FunctionDataMgr:jStartDating(self.activityInfo.extendData.datingId)
	end)

	self.button_review:onClick(function ( ... )
		-- body
		FunctionDataMgr:jStartDating(self.activityInfo.extendData.datingId)
	end)

	local  function refreshRsp ( ... )
        self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
	    local remainTime = math.max(0, math.ceil(self.activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
	    if remainTime > 0 then
	    	Utils:openView("activity.EntrustGemFlushView", self.activityInfo)
	    else
			TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityId ,1})
		end
	end

	self.button_flush:onClick(function ( ... )
		-- body
		if self:hasEntrustCanGet() then
			local args = {
	            tittle = 2107025,
	            reType =  nil,
	            content = TextDataMgr:getText(12100089),
	            confirmCall = function ( ... )
	            	-- body
	            end,
	        }
	        Utils:showReConfirm(args)
	        return 
	    end
		refreshRsp()
	end)

	self.button_gemflush:onClick(function ( ... )
	   	if self:hasEntrustCanGet() then
			local args = {
	            tittle = 2107025,
	            reType = nil,
	            content = TextDataMgr:getText(12100089),
	            confirmCall = function ( ... )
	            	-- body
	            end,
	        }
	        Utils:showReConfirm(args)
	        return 
	    end
		refreshRsp()
	end)

end


function ActivitySpecialCgView:hasEntrustCanGet(  )
	local items = ActivityDataMgr2:getItems(self.activityId )
	for k,v in pairs(items) do
		local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v)
		if progressInfo.status == EC_TaskStatus.GET then
			return true
		end
	end
	return false
end

function ActivitySpecialCgView:onRefreshEntrustEvent()
    Utils:showTips(12100079)
end

function ActivitySpecialCgView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId  == activitId then
    	Utils:showReward(reward)
    end
end

function ActivitySpecialCgView:flushCgPingtu( )
	self.bg_Cg:setTexture(self.activityInfo.extendData.cgAddress)
	self.cgName:setText(self.activityInfo.extendData.cgName)
	local activityNum = 0
	for k,v in pairs(self.pingtuNodes) do
		--self.cgListType[k] = 1
		if tonumber(self.cgListType[k]) == 1 then
			v:hide()
			activityNum = activityNum + 1
		else
			v:show()
		end
	end

	self.panel_dating:setVisible(self.activityInfo.extendData.cgState == 1)
	self.panel_collectting:setVisible(self.activityInfo.extendData.cgState == 0)
	self.panel_review:setVisible(self.activityInfo.extendData.cgState == 2)
	self.label_progress:setText(activityNum .. "/" .. #self.cgListType)
end

function ActivitySpecialCgView:flushTaskList( )
	-- body
	local items = ActivityDataMgr2:getItems(self.activityId )
	for i = 1, #items do
		local pos = TFDirector:getChildByPath(self.panel_task,"pos"..i)
		if pos then
			if not pos.item then
				pos.item = self.panel_item:clone():Pos(0,0)
				pos:addChild(pos.item)
			end

			local itemData = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, items[i])
			self:updateTaskItem(pos.item,itemData)
		end
	end
    self.itemCfg_ = GoodsDataMgr:getItemCfg(self.activityInfo.extendData.refreshItemId)
   	self.itemRecoverCfg = TabDataMgr:getData("ItemRecover",self.itemCfg_.buyItemRecover)
    local usedCount = self.activityInfo.extendData.refreshCount or 0
    usedCount = math.min(#self.itemRecoverCfg.price-1 ,usedCount)
   	local cost = self.itemRecoverCfg.price[usedCount + 1][1][1]
	self.Image_cost_icon:setTexture(GoodsDataMgr:getItemCfg(cost.id).icon)
	self.Label_cost_num:setText(cost.num)
end

function ActivitySpecialCgView:updateTaskItem( node, itemData )
	-- body
	local task_bg = TFDirector:getChildByPath(node,"task_bg")
	local panel_base = TFDirector:getChildByPath(node,"panel_base")
	local panel_geted = TFDirector:getChildByPath(node,"panel_geted")
	local panel_ing = TFDirector:getChildByPath(node,"panel_ing")
	local panel_get = TFDirector:getChildByPath(node,"panel_get")
	local task_title = TFDirector:getChildByPath(node,"task_title")
	local task_des = TFDirector:getChildByPath(node,"task_des")
	local task_progress = TFDirector:getChildByPath(node,"task_progress")
	local scroll_reward = TFDirector:getChildByPath(node,"scroll_reward")
	local uilist_reward = UIListView:create(scroll_reward)
   	uilist_reward:setItemsMargin(5)
   	uilist_reward:setGravity(UIListView.Gravity.LEFT)

	local button_go = TFDirector:getChildByPath(panel_ing,"button_go")
	local button_get = TFDirector:getChildByPath(panel_get,"button_get")

	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,itemData.id)
	panel_base:setVisible(progressInfo.status ~=  EC_TaskStatus.GETED)
	panel_ing:setVisible(progressInfo.status ==  EC_TaskStatus.ING)
	panel_geted:setVisible(progressInfo.status ==  EC_TaskStatus.GETED)
	panel_get:setVisible(progressInfo.status ==  EC_TaskStatus.GET)

	local pic = progressInfo.status ==  EC_TaskStatus.GET and "ui/activity/activity_cg/013.png" or "ui/activity/activity_cg/016.png"
	task_bg:setTexture(pic)

	local color = progressInfo.status ==  EC_TaskStatus.GET and ccc3(239,95,125) or ccc3(89,121,193)
	task_title:setColor(color)
	task_des:setColor(color)
	task_title:setText(itemData.extendData.des or "")
	task_des:setText(itemData.extendData.des2 or "")
	if itemData.extendData.target then
		task_progress:show()
		task_progress:setText(progressInfo.progress .. "/" .. itemData.extendData.target)
	else
		task_progress:hide()
	end
	uilist_reward:removeAllItems()
	for id,num in pairs(itemData.reward) do
        local itemCfg = GoodsDataMgr:getItemCfg(id)
        local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        panel_goodsItem:Scale(60/panel_goodsItem:getContentSize().height)
        PrefabDataMgr:setInfo(panel_goodsItem, id, num)
       	uilist_reward:pushBackCustomItem(panel_goodsItem)
	end

	button_get:onClick(function ( ... )
		-- body
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId , itemData.id)
	end)

	button_go:onClick(function ( ... )
		-- body
		FunctionDataMgr:enterByFuncId(itemData.extendData.jumpInterface,itemData.extendData.datingScriptId)
	end)

end

function ActivitySpecialCgView:dispose( ... )
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function ActivitySpecialCgView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.flushUI, self))
    end
end

function ActivitySpecialCgView:flushUI()
	self.activityInfo.extendData.refreshTime = self.activityInfo.extendData.refreshTime or 0
    local remainTime = math.max(0, math.ceil(self.activityInfo.extendData.refreshTime/1000) - ServerDataMgr:getServerTime())
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)
    
    self.time_num:setText(string.format("%02d:%02d:%02d", hour, min, sec))

    self.button_flush:setVisible(remainTime <= 0)
    self.button_gemflush:setVisible(remainTime > 0)
end

return ActivitySpecialCgView
