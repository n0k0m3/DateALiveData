
local BossChallegePreview = class("BossChallegePreview",BaseLayer)

function BossChallegePreview:ctor( data )
	self.super.ctor(self,data)
   	self:showPopAnim(true)
   	self:initData(data)
	self:init("lua.uiconfig.fuben.bossChallegePreview")
end

function BossChallegePreview:initData(data)
	self.maxWaitingTime = Utils:getKVP(17001,"time")
	self.createTeamWaitTime = Utils:getKVP(21005,"time")
	self.matchingStat = 0 --0未匹配，1匹配中,2开房中
	self.requireClose = false --是否点了关闭界面按钮
   	self.bossCfg = FubenDataMgr:getBossChallengeCurLevel()
   	self.medalItems = {500128,500129,500130}
end

function BossChallegePreview:initUI( ui )
	self.super.initUI(self,ui)
	self.levelPreviewPanel = ui
	self.stageName = TFDirector:getChildByPath(ui,"Label_title")
  	self.Panel_prefabe = TFDirector:getChildByPath(ui,"Panel_prefabe"):hide()
    local ScrollView_flag   = TFDirector:getChildByPath(ui,"ScrollView_flag")
	self.ListView_flag = UIListView:create(ScrollView_flag)
	self.Panel_flag_item = TFDirector:getChildByPath(self.Panel_prefabe,"Panel_flag_item")

	self.Button_auto_match = TFDirector:getChildByPath(ui,"Button_auto_match")
	self.Button_open_house = TFDirector:getChildByPath(ui,"Button_open_house")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.label_member_num = TFDirector:getChildByPath(ui,"label_member_num")
	self.Image_head = TFDirector:getChildByPath(ui,"Image_head")
	self.label_round = TFDirector:getChildByPath(ui,"label_round")
	TFDirector:getChildByPath(ui,"label_tip2"):setTextById(12035009)
	self:refreshView()
end

function BossChallegePreview:refreshView( )
	self.stageName:setTextById(self.bossCfg.levelName)
	self.label_member_num:setText(self.bossCfg.capacity)
	local openTime,closeTime,readyTime,endTime,curRound,maxRound = FubenDataMgr:getBossChallengeTimes()
	self.label_round:setText(curRound.."/"..maxRound)
	--boss 头像显示
	local data              = FubenDataMgr:getLevelCfg(self.bossCfg.dungeonID)
    local monsterId         = data.monsterGroupId[1]
    local monsterSectionCfg = TabDataMgr:getData("MonsterSection")[monsterId]
    if monsterSectionCfg then
       local fixedMonster =  monsterSectionCfg.fixedMonster
        if fixedMonster[1] then
            monsterId = fixedMonster[1]
        end
    end
    local monserCfg = TabDataMgr:getData("Monster",monsterId)
    self.Image_head:setTexture(monserCfg.fightIcon)

    local goalDescribe = self.bossCfg.goalDescribe
    for i,desc in ipairs(goalDescribe) do
		local item = self.Panel_flag_item:clone()
		local itemCfg = GoodsDataMgr:getItemCfg(self.medalItems[i])
		TFDirector:getChildByPath(item,"Image_tips"):setTexture(itemCfg.icon)
		local Label_flag = TFDirector:getChildByPath(item,"Label_flag")
		Label_flag:setText(desc)
		local isReach = FubenDataMgr:judgeStarIsActive(self.bossCfg.dungeonID, i)
		TFDirector:getChildByPath(item,"Image_reach"):setVisible(isReach)
		if isReach then
			Label_flag:setColor(ccc3(37,55,89))
		else
			Label_flag:setColor(ccc3(255,255,255))
		end

		local ListViewItems = UIListView:create(TFDirector:getChildByPath(item,"ScrollView_items"))
		local rewards = {}
		if i == 1 then
			rewards = self.bossCfg.firstReward.reward
		elseif i == 2 then
			rewards = self.bossCfg.secondReward.reward
		else
			rewards = self.bossCfg.thirdReward.reward
		end
		for k,v in pairs(rewards) do
	        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	        Panel_goodsItem:Scale(0.65)
	        PrefabDataMgr:setInfo(Panel_goodsItem, tonumber(k), v)
	        ListViewItems:pushBackCustomItem(Panel_goodsItem)
	    end
		self.ListView_flag:pushBackCustomItem(item)
	end
end

function BossChallegePreview:runSingleMatching()
	local selLevelCfg = self.bossCfg
	TeamFightDataMgr:requestMatchTeam( selLevelCfg.type, selLevelCfg.id)
end

function BossChallegePreview:registerEvents()
	self.super.registerEvents(self)
	self.Button_open_house:onClick(function ( ... )
		if self.matchingStat == 0 then
			self.matchingStat = 2
			self:refreshView()
			local selLevelCfg = self.bossCfg
			TeamFightDataMgr:requestCreateTeam( selLevelCfg.type,selLevelCfg.id,0,1,false)
		end
	end)

	self.Button_auto_match:onClick(function ( ... )
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

	self.Button_close:onClick(function ( ... )
		if self.matchingStat == 1 then
			local alertparams = clone(EC_GameAlertParams)
			alertparams.msg = 2100057
			alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
			showGameAlert(alertparams)
			self.requireClose = true
		else
			--关闭界面
			AlertManager:closeLayer(self)
		end

	end)

	EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_AUTO_JOIN, handler(self.onSingleMatching, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onUpdateOpenHouse, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CREAT_TEAM, handler(self.onCreatingTeam, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_CANCEL_FAIL, handler(self.onSingleMatchCancelFail, self))
    EventMgr:addEventListener(self, EV_FUNC_STATE_CHANGE,handler(self.funcCloseNotice,self))
    EventMgr:addEventListener(self, EV_TEAM_BUY_CHANLENGE_COUNT, handler(self.onUpdateLevelStat, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_OPEN_TEAM, handler(self.onOpenTeam, self))
end

function BossChallegePreview:onOpenTeam()
	AlertManager:closeLayer(self)
end


function BossChallegePreview:runMatchingAction()
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

function BossChallegePreview:stopMatchingAction()
	if self.waitingLayer ~= nil then
		self.waitingLayer:removeFromParent()
		self.waitingLayer = nil
	end
end

function BossChallegePreview:refreshLevelPreviewUI()
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

function BossChallegePreview:onUpdateLevelStat()
	self.teamLevelStat = TeamFightDataMgr:getTeamLevelStat()[self.curLevelCfg.id]
	self:refreshLevelPreviewUI()
end

function BossChallegePreview:funcCloseNotice(data)
    if data.switchType == EC_FunctionEnum.TEAM_FIGHT and data.open == false then
    	if self.matchingStat == 1 then
    		TeamFightDataMgr:requestCancelMatchTeam()
    	end
        AlertManager:closeLayer(self)
    end
end
function BossChallegePreview:runSingleMatching()
	-- self.matchingStat = 1
	-- self:refreshView()
	--发送匹配请求
	local selLevelCfg = self.bossCfg
	TeamFightDataMgr:requestMatchTeam( selLevelCfg.type, selLevelCfg.id)
end

function BossChallegePreview:stopSingleMatching()
	TeamFightDataMgr:requestCancelMatchTeam()
end

function BossChallegePreview:onCreatingTeam()
	self.matchingStat = 2
	self:refreshLevelPreviewUI()
end

function BossChallegePreview:onSingleMatchTimeout()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	local alertparams = clone(EC_GameAlertParams)
	alertparams.msg = 2100058
	alertparams.confirm_title = 2100059
	alertparams.cancel_title = 2100060
	alertparams.comfirmCallback = handler(self.runSingleMatching,self)
	showGameAlert(alertparams)
end

function BossChallegePreview:onCreateTeamFail()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	-- Utils:showError("创建队伍失败")
	Utils:showError(TextDataMgr:getText(240014))
end

function BossChallegePreview:onSingleMatchCancelFail()
	-- Utils:showError("无法取消匹配")
	Utils:showError(TextDataMgr:getText(240015))
end

function BossChallegePreview:onSingleMatchCancel()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	if self.requireClose == true then
		AlertManager:closeLayer(self)
	end
end

function BossChallegePreview:onSingleMatching()
	self.matchingStat = 1
	self:refreshLevelPreviewUI()
end

function BossChallegePreview:onUpdateOpenHouse()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end
function BossChallegePreview:onSingleMatchComplete()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end

return BossChallegePreview