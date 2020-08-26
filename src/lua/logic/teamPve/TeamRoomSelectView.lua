--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local TeamRoomSelectView = class("TeamRoomSelectView", BaseLayer)

local Stat = {
	ING = 1,	--正在匹配
	SUCESS = 2,	--匹配成功
	NONE = 3	--未匹配
}

local DurationRefreshRank = 10

function TeamRoomSelectView:ctor()
	self.super.ctor(self)
	self:initData()
	self:init("lua.uiconfig.teamFight.teamRoomSelectView")
--	self:showPopAnim(true)
	TFDirector:send(c2s.NEW_WORLD_REQ_REWARD_MISSION_RECORD,{})
end

function TeamRoomSelectView:initData()
	self.matchingStat = Stat.NONE 

	self.maxWaitingTime = Utils:getKVP(17001,"time")
	self.iconRes = {"D.png","C.png","B.png","A.png","S.png","blackwhite.png"}
	self.difficultyItems = {}
	self.curChoice = nil

	self.stayTime = 0

	local roomTypeCfg = TeamFightDataMgr:getRoomTypeCfg()
	self.matchType = roomTypeCfg[3][1]
end

function TeamRoomSelectView:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

	self.Panel_timer = TFDirector:getChildByPath(self.Panel_root, "Panel_timer")

	self.Panel_level = TFDirector:getChildByPath(self.Panel_root, "Panel_level")

	self.Panel_touch_shield = TFDirector:getChildByPath(self.Panel_root, "Panel_touch_shield"):hide()
	self.Panel_touch_shield:setTouchEnabled(true)
	self.Panel_touch_shield:setSwallowTouch(true)

	self.Label_desc = TFDirector:getChildByPath(self.Panel_root, "Label_desc"):hide()
	self.Label_desc:setTextById(15010105,0)

	self.TextButton_single_match = TFDirector:getChildByPath(self.Panel_level, "TextButton_single_match")
	self.TextButton_stop_match = TFDirector:getChildByPath(self.Panel_level, "TextButton_stop_match"):hide()
	
	local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(101)
	for k,v in ipairs(self.iconRes) do
        local node = TFDirector:getChildByPath(self.Panel_root, "Button_"..k)
		node.Image_select = TFDirector:getChildByPath(node, "Image_select")
        node.Image_select:setVisible(false)
		node.Image_icon = TFDirector:getChildByPath(node, "Image_icon")
		node.Image_sign = TFDirector:getChildByPath(node, "Image_sign"):hide()
		node.Label_times = TFDirector:getChildByPath(node, "Label_times")

        node.Image_icon:setTexture("ui/teampve/huntingInvitation/"..v)
        self.difficultyItems[k] = node

		node:onClick(function(widget)
			self:selectLvl(widget)
		end)

		node.difficulty = k
    end
	self:refresh()
end

function TeamRoomSelectView:selectLvl(widget)

	if widget == self.curChoice then
		return;
	end

	if self.curChoice then
		self.curChoice.Image_select:hide()
		self.curChoice.Image_sign:hide()
	end

	widget.Image_select:show()
	widget.Image_sign:show()

	self.curChoice = widget
end


function TeamRoomSelectView:refreshView()
	
end

function TeamRoomSelectView:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_AUTO_JOIN, handler(self.onSingleMatching, self))
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onSingleMatchComplete, self))
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_CANCEL_FAIL, handler(self.onSingleMatchCancelFail, self))
	EventMgr:addEventListener(self, EV_OSD.HUNTING_INVITATION_RECORD, handler(self.refresh, self))
	EventMgr:addEventListener(self, EV_TEAM_MATCH_RANK, handler(self.refreshRank, self))


	self.Button_close:onClick(function()
		if self.matchingStat == Stat.ING then
			local alertparams = clone(EC_GameAlertParams)
			alertparams.msg = 2100057
			alertparams.comfirmCallback = function()
				self:stopSingleMatching()
				AlertManager:closeLayer(self)
			end
			showGameAlert(alertparams)
		elseif self.matchingStat == Stat.SUCESS then
			TeamFightDataMgr:requestExitTeam()
			AlertManager:closeLayer(self)
		else
			AlertManager:closeLayer(self)
		end
		
	end)

	self.TextButton_single_match:onClick(function()
		if self.curChoice ==nil then
			Utils:showTips(15010106)
			return
		end
		if self.matchingStat == Stat.NONE then
			self:runSingleMatching()
		elseif self.matchingStat == Stat.ING then
			 Utils:showTips(240008)
		end
	end)

	self.TextButton_stop_match:onClick(function()
		self:stopSingleMatching()
	end)
end

function TeamRoomSelectView:onSingleMatchTimeout()
	self.matchingStat = Stat.NONE
	self:refreshView()
	local alertparams = clone(EC_GameAlertParams)
	alertparams.msg = 2100058
	alertparams.confirm_title = 2100059
	alertparams.cancel_title = 2100060
	alertparams.comfirmCallback = function()
		self:runSingleMatching()
	end
	showGameAlert(alertparams)

	self:stopMatchingAction()
	self:stopSingleMatching()
end

function TeamRoomSelectView:stopSingleMatching()
	TeamFightDataMgr:requestCancelMatchTeam()
end

function TeamRoomSelectView:runSingleMatching()
	self.Panel_touch_shield:show()
	TeamFightDataMgr:requestMatchTeam(self.matchType, self.curChoice.difficulty)
end

function TeamRoomSelectView:onSingleMatchCancelFail()
	Utils:showError(TextDataMgr:getText(240015))
end

function TeamRoomSelectView:onSingleMatchCancel()
	self.matchingStat = Stat.NONE
	self:refreshView()
	self.TextButton_stop_match:hide()
	self.Panel_touch_shield:hide()
	self:stopMatchingAction()

	self:removeTimer()
end

function TeamRoomSelectView:onSingleMatching()
	self.matchingStat = Stat.ING
	self:refreshView()
	if self.waitingLayer == nil then
		self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.maxWaitingTime,callback = handler(self.onSingleMatchTimeout,self)})
		self.Panel_timer:addChild(self.waitingLayer,999)
	end
	self:runAction(Sequence:create({DelayTime:create(1), CallFunc:create(function()
		self.TextButton_stop_match:show()
	end)}))	
	print("进入匹配")
	self:addTimer()
	self:reqMatchRank()
end

function TeamRoomSelectView:onSingleMatchComplete()
	self.matchingStat = Stat.SUCESS
	self:refreshView()	

	self:removeTimer()
	AlertManager:closeLayer(self)
end

function TeamRoomSelectView:stopMatchingAction()
	if self.waitingLayer ~= nil then
		self.waitingLayer:removeFromParent()
		self.waitingLayer = nil
	end
end


function TeamRoomSelectView:refresh()
	local isHavePrivilege, cfg = RechargeDataMgr:getIsHavePrivilegeByType(101)
	for k,v in ipairs(self.difficultyItems) do
		local count = OSDDataMgr:getHuntingInvitationCount(k,true)
        local maxCount = TabDataMgr:getData("DiscreteData",81011).data.dayTime[k]
        local textId = 2100168
        if k >= 5 then
            count = OSDDataMgr:getHuntingInvitationCount(k,false)
            maxCount = TabDataMgr:getData("DiscreteData",81012).data.weekTime[k]
            textId = 2100169
        end

        if isHavePrivilege then
            maxCount = maxCount + cfg.privilege.chance
        end

		if count > maxCount then
			count = maxCount
		end

        v.Label_times:setTextById(textId,count,maxCount)

--		v.enable = count < maxCount
	end
end


function TeamRoomSelectView:addTimer()
	if self.timer == nil then
		self.timer = TFDirector:addTimer(1000, -1, nil, function(delta)		
			if self.curChoice == nil then
				return
			end	

			self.stayTime = self.stayTime + 1
			if self.stayTime > DurationRefreshRank then
				self.stayTime = 0
				self:reqMatchRank()
			end 
		end)
	end
	
end

function TeamRoomSelectView:refreshRank(data)
	if data.rank == -1 then
		return
	end
	self.Label_desc:setTextById(15010105, data.rank)
	self.Label_desc:show()
end

function TeamRoomSelectView:removeTimer()
	if self.timer then
		TFDirector.removeTimer(self.timer)
		self.timer = nil
	end
	self.stayTime = 0
	self.Label_desc:setTextById(15010105, 0)
	self.Label_desc:hide()
end

function TeamRoomSelectView:removeEvents()
	self.super.removeEvents(self)
	self:removeTimer()
end

function TeamRoomSelectView:reqMatchRank()
	if self.matchingStat == Stat.ING then
		print("请求排位")
		TFDirector:send(c2s.TEAM_REQ_MATCH_RANK,{self.matchType, self.curChoice.difficulty})
	end
end

return TeamRoomSelectView


--endregion
