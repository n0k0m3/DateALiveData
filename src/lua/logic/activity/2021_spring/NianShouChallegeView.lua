
local NianShouChallegeView = class("NianShouChallegeView",BaseLayer)

function NianShouChallegeView:ctor( data )
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.activity.nianshouChallegeView")
end

function NianShouChallegeView:initData(data)
	self.maxWaitingTime = Utils:getKVP(17001,"time")
	self.createTeamWaitTime = Utils:getKVP(21005,"time")
	self.matchingStat = 0 --0未匹配，1匹配中,2开房中
	self.requireClose = false --是否点了关闭界面按钮

	self.levelCfg = TabDataMgr:getData("NewYearBeast2021",291135)
	self.nianshou_tips = {16000649,16000650,16000651}
end

function NianShouChallegeView:initUI( ui )
	self.super.initUI(self,ui)
	self.levelPreviewPanel = ui

	self.Panel_touch  = TFDirector:getChildByPath(ui,"Panel_touch")
	local Image_open_time = TFDirector:getChildByPath(ui,"Image_open_time")
	self.stageTimeLabel   = TFDirector:getChildByPath(Image_open_time,"Label_open_time")
	self.Button_task  = TFDirector:getChildByPath(ui,"Button_task")
	self.Image_red = TFDirector:getChildByPath(self.Button_task,"Image_red")
	local Panel_nianshou = TFDirector:getChildByPath(ui,"Panel_nianshou")
	self.Label_buff = TFDirector:getChildByPath(Panel_nianshou,"Label_buff")

	self.Panel_nianshou = {}
	self.spin_nianshou = {}
	self.Spine_line = {}
	for i=1,3 do
		self.Panel_nianshou[i] = TFDirector:getChildByPath(Panel_nianshou,"Panel_nianshou"..i)
		self.spin_nianshou[i] = TFDirector:getChildByPath(Panel_nianshou,"Spine_nianshou"..i)
		self.Spine_line[i] = TFDirector:getChildByPath(Panel_nianshou,"Spine_line"..i)
	end

	self.Panel_level_info = TFDirector:getChildByPath(ui,"Panel_level_info")
	
	local ScrollView_flags     = TFDirector:getChildByPath(self.Panel_level_info,"ScrollView_flags")
	self.ListViewFlags = UIListView:create(ScrollView_flags)
	local ScrollView_rewards     = TFDirector:getChildByPath(self.Panel_level_info,"ScrollView_rewards")
	self.ListViewRewards = UIListView:create(ScrollView_rewards)
	self.ListViewRewards:setItemsMargin(2)

	self.Button_auto_match     = TFDirector:getChildByPath(ui,"Button_auto_match")
	self.Button_open_house 	   = TFDirector:getChildByPath(ui,"Button_open_house")

	self.Button_auto_match:getChildByName("Label_title"):setTextById(2100052)
	self.Button_open_house:getChildByName("Label_title"):setTextById(2100051)
	self.Button_auto_match:setVisible(not self.levelCfg.disableMatch)

	self.Button_cost = TFDirector:getChildByPath(ui, "Button_cost")
    self.Label_costNum = TFDirector:getChildByPath(self.Button_cost, "Label_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(self.Button_cost, "Image_costIcon")
    self.Label_cost = TFDirector:getChildByPath(self.Button_cost, "Label_cost")

    self.Button_reward_tip = TFDirector:getChildByPath(self.Panel_level_info, "Button_reward_tip")
    self.Image_tips_show = TFDirector:getChildByPath(self.Panel_level_info, "Image_tips_show")
    self.Image_tips_show:getChildByName("Label_tips_show"):setTextById(16000655)

	self.Panel_prefabe    = TFDirector:getChildByPath(ui,"Panel_prefabe")
	self.Panel_flag_item  = TFDirector:getChildByPath(self.Panel_prefabe,"Panel_flag_item")

	self:initPanelInfos()
	self:addCountDownTimer()
	self:updateTimeFunc()
	self:refreshTaskUI()
end

function NianShouChallegeView:initPanelInfos()
	self:initNianshouInfo()
	self:initLevelInfo()
end

function NianShouChallegeView:initNianshouInfo()
	self.selectNianshouIdx = 1
	self:updateNianshouInfo()
end

function NianShouChallegeView:initLevelInfo()
	for i,v in ipairs(self.levelCfg.BeastDes) do
		local item = self.Panel_flag_item:clone()
		item:getChildByName("Label_flag"):setTextById(v)
		self.ListViewFlags:pushBackCustomItem(item)
	end
	for k,v in pairs(self.levelCfg.rewardShow) do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.75)
        PrefabDataMgr:setInfo(Panel_goodsItem, tonumber(k), v)
        self.ListViewRewards:pushBackCustomItem(Panel_goodsItem)
	end

	self.Button_cost:hide()
    local itemId,num = next(self.levelCfg.fightCost)
    if itemId then
        local costItemCfg = GoodsDataMgr:getItemCfg(itemId)
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_costNum:setText(num)
        self.Button_cost:show()
        self.Button_cost:onClick(function ()
			Utils:showInfo(itemId)
		end)
    end
    self.Label_cost:setTextById(300020)
end

function NianShouChallegeView:updateNianshouInfo()
	for i=1,3 do
		self.Spine_line[i]:setVisible(self.selectNianshouIdx == i)
	end
	self.Label_buff:setTextById(self.nianshou_tips[self.selectNianshouIdx])
end

function NianShouChallegeView:updateTimeFunc()
	local closeTime = Utils:getTimeByDate(self.levelCfg.closeTime)
	local serverTime = ServerDataMgr:getServerTime()
	local remainTime = math.max(0, closeTime - serverTime)
	if remainTime <= 0 then
		AlertManager:closeLayer(self)
		return
	end
    local day, hour, min = Utils:getFuzzyDHMS(remainTime)
    self.stageTimeLabel:setTextById(16000652, day, hour, min)
end

function NianShouChallegeView:refreshTaskUI()
	self.Image_red:hide()
	local task_ = TaskDataMgr:getTask(EC_TaskType.NIANSHOU)
	for i, v in ipairs(task_) do
        local taskCid = task_[i]
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
        if taskInfo.status == EC_TaskStatus.GET then
           self.Image_red:show()
        end
    end
end

function NianShouChallegeView:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_AUTO_JOIN, handler(self.onSingleMatching, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onUpdateOpenHouse, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CREAT_TEAM, handler(self.onCreatingTeam, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_CANCEL_FAIL, handler(self.onSingleMatchCancelFail, self))
    EventMgr:addEventListener(self, EV_FUNC_STATE_CHANGE,handler(self.funcCloseNotice,self))
    EventMgr:addEventListener(self, EV_TEAM_BUY_CHANLENGE_COUNT, handler(self.onUpdateLevelStat, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_OPEN_TEAM, handler(self.onOpenTeam, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.refreshTaskUI, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.refreshTaskUI, self))

	for i,v in ipairs(self.Panel_nianshou) do
		v:setTouchEnabled(true)
		v:onClick(function ()
			self.selectNianshouIdx = i
			self:updateNianshouInfo()
		end)
	end

	self.Button_open_house:onClick(function ( ... )
		local itemId,num = next(self.levelCfg.fightCost)
	    if itemId then
	        if itemId and GoodsDataMgr:getItemCount(itemId) < num then
	        	local itemCfg = GoodsDataMgr:getItemCfg(tonumber(itemId))
                local text = TextDataMgr:getText(63847,TextDataMgr:getText(itemCfg.nameTextId))
                Utils:showTips(text)
				return
			end
	    end

		if self.matchingStat == 0 then
			local callback = function(visibleType,limitLv,isAutoMatch)
				self.matchingStat = 2
				local selLevelCfg = self.levelCfg
				selLevelCfg.type = selLevelCfg.type or 1
				TeamFightDataMgr:requestCreateTeam(selLevelCfg.type, selLevelCfg.id,visibleType,limitLv,isAutoMatch)
			end
			Utils:openView("teamFight.TeamRoomSettingView",true,self.levelCfg.type,callback,self.levelCfg.lvlLimit)
		end
	end)

	self.Button_auto_match:onClick(function ( ... )
		local itemId,num = next(self.levelCfg.fightCost)
	    if itemId then
	        if itemId and GoodsDataMgr:getItemCount(itemId) < num then
	        	local itemCfg = GoodsDataMgr:getItemCfg(tonumber(itemId))
                local text = TextDataMgr:getText(63847,TextDataMgr:getText(itemCfg.nameTextId))
                Utils:showTips(text)
				return
			end
	    end
		if self.matchingStat == 0 then
			self:runSingleMatching()
		elseif self.matchingStat == 1 then

			local alertparams = clone(EC_GameAlertParams)
			alertparams.msg = 2100057
			alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
			showGameAlert(alertparams)
		else

		end
	end)

	self:setBackBtnCallback(function()
        if self.matchingStat == 1 then
			local alertparams = clone(EC_GameAlertParams)
			alertparams.msg = 2100057
			alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
			alertparams.cancelCallback = function( ... )
				self.requireClose = false
			end
			showGameAlert(alertparams)
			self.requireClose = true
		else
			--关闭界面
			AlertManager:closeLayer(self)
		end
    end)

	self:setMainBtnCallback(function ()
        if self.matchingStat == 1 then
			local alertparams = clone(EC_GameAlertParams)
			alertparams.msg = 2100057
			alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
			alertparams.cancelCallback = function( ... )
				self.requireClose = false
			end
			showGameAlert(alertparams)
			self.requireClose = true
			return true
		end
		return false
    end)

    self.Button_reward_tip:onClick(function ()
		if self.tipsShow then
			self.tipsShow = false
			self.Image_tips_show:setVisible(false)
		else
			self.tipsShow = true
			self.Image_tips_show:setVisible(true)
		end
	end)

	self.Button_task:onClick(function ()
		Utils:openView("activity.2021_spring.NianshowTaskView")
	end)

	self.Panel_touch:setTouchEnabled(true)
	self.Panel_touch:onClick(function ()
		if self.tipsShow then
			self.tipsShow = false
			self.Image_tips_show:setVisible(false)
		end
	end)
end

function NianShouChallegeView:refreshLevelPreviewUI()
	if self.matchingStat == 0 then
		self.Button_auto_match:getChildByName("Label_title"):setTextById(2100052)
		self.Button_auto_match:setTouchEnabled(true)
		self.Button_auto_match:setGrayEnabled(false)
		self.Button_open_house:setTouchEnabled(true)
		self.Button_open_house:setGrayEnabled(false)
		self:stopMatchingAction()
	elseif self.matchingStat == 1 then
		self.Button_auto_match:getChildByName("Label_title"):setTextById(2100053)
		self.Button_auto_match:setTouchEnabled(true)
		self.Button_auto_match:setGrayEnabled(false)
		self.Button_open_house:setTouchEnabled(false)
		self.Button_open_house:setGrayEnabled(true)
		self:runMatchingAction()

	elseif self.matchingStat == 2 then
		self.Button_auto_match:setTouchEnabled(false)
		self.Button_auto_match:setGrayEnabled(true)
		self.Button_open_house:setTouchEnabled(false)
		self.Button_open_house:setGrayEnabled(true)

		self:runMatchingAction()
	else
		self.Button_auto_match:setTouchEnabled(false)
		self.Button_auto_match:setGrayEnabled(true)
		self.Button_open_house:setTouchEnabled(false)
		self.Button_open_house:setGrayEnabled(true)
		self:runMatchingAction()
	end
end

function NianShouChallegeView:onOpenTeam()
	--AlertManager:closeLayer(self)
end


function NianShouChallegeView:runMatchingAction()
	if self.waitingLayer == nil then
		if self.matchingStat == 2 then
			self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.createTeamWaitTime,callback = handler(self.onCreateTeamFail,self)})
			self.levelPreviewPanel:addChild(self.waitingLayer,999)
		else
			self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.maxWaitingTime,callback = handler(self.onSingleMatchTimeout,self)})
			self.levelPreviewPanel:addChild(self.waitingLayer,999)
		end
	end
end

function NianShouChallegeView:stopMatchingAction()
	if self.waitingLayer ~= nil then
		self.waitingLayer:removeFromParent()
		self.waitingLayer = nil
	end
end

function NianShouChallegeView:runSingleMatching()
	local selLevelCfg = self.levelCfg
	TeamFightDataMgr:requestMatchTeam( selLevelCfg.type, selLevelCfg.id)
end

function NianShouChallegeView:stopSingleMatching()
	TeamFightDataMgr:requestCancelMatchTeam()
end

function NianShouChallegeView:onCreatingTeam()
	self.matchingStat = 2
	self:refreshLevelPreviewUI()
end

function NianShouChallegeView:onSingleMatchTimeout()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	local alertparams = clone(EC_GameAlertParams)
	alertparams.msg = 2100058
	alertparams.confirm_title = 2100059
	alertparams.cancel_title = 2100060
	alertparams.comfirmCallback = handler(self.runSingleMatching,self)
	showGameAlert(alertparams)
end

function NianShouChallegeView:onCreateTeamFail()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	-- Utils:showError("创建队伍失败")
	Utils:showError(TextDataMgr:getText(240014))
end

function NianShouChallegeView:onSingleMatchCancelFail()
	-- Utils:showError("无法取消匹配")
	Utils:showError(TextDataMgr:getText(240015))
end

function NianShouChallegeView:onSingleMatchCancel()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	if self.requireClose == true then
		AlertManager:closeLayer(self)
	end
end

function NianShouChallegeView:funcCloseNotice(data)
    if data.switchType == EC_FunctionEnum.TEAM_FIGHT and data.open == false then
    	if self.matchingStat == 1 then
    		TeamFightDataMgr:requestCancelMatchTeam()
    	end
        AlertManager:closeLayer(self)
    end
end

function NianShouChallegeView:onSingleMatching()
	self.matchingStat = 1
	self:refreshLevelPreviewUI()
end

function NianShouChallegeView:onUpdateOpenHouse()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end
function NianShouChallegeView:onSingleMatchComplete()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end


function NianShouChallegeView:removeCountDownTimer()
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function NianShouChallegeView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(5000, -1, nil, handler(self.updateTimeFunc, self))
    end
end

function NianShouChallegeView:removeEvents()
    self:removeCountDownTimer()
end

function NianShouChallegeView:onShow()
    self.super.onShow(self)

    DatingDataMgr:triggerDating(self.__cname, "onShow")
    FubenDataMgr.enterNianshouChanllenge = true
end


return NianShouChallegeView