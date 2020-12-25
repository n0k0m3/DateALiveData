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
* -- 追猎计划boss关卡预览界面
]]

local LeagueHunterPreviewView = class("LeagueHunterPreviewView",BaseLayer)

function LeagueHunterPreviewView:ctor( data )
	self.super.ctor(self,data)
   	self:showPopAnim(true)
   	self:initData(data)
	self:init("lua.uiconfig.league.leagueHunterPreviewView")
end

function LeagueHunterPreviewView:initData(data)
	self.maxWaitingTime = Utils:getKVP(17001,"time")
	self.createTeamWaitTime = Utils:getKVP(21005,"time")
	self.matchingStat = 0 --0未匹配，1匹配中,2开房中
	self.requireClose = false --是否点了关闭界面按钮
   	self.bossCfg = TabDataMgr:getData("HuntingLevel",data)
end

function LeagueHunterPreviewView:initUI( ui )
	self.super.initUI(self,ui)
	self.levelPreviewPanel = ui
	self.stageName = TFDirector:getChildByPath(ui,"Label_title")
  	self.Panel_prefabe = TFDirector:getChildByPath(ui,"Panel_prefabe"):hide()
  	self.Panel_prefabe1 = TFDirector:getChildByPath(ui,"Panel_prefabe1"):hide()
  	self.Label_test   = TFDirector:getChildByPath(ui,"Label_test")
    local ScrollView_team_buff = TFDirector:getChildByPath(ui,"ScrollView_team_buff")
    local ScrollView_keyword   = TFDirector:getChildByPath(ui,"ScrollView_keyword")


	self.ListView_team_buff    = UIListView:create(ScrollView_team_buff)
	self.ListView_team_keyword = UIListView:create(ScrollView_keyword)

  

	self.Button_auto_match = TFDirector:getChildByPath(ui,"Button_auto_match")
	self.Button_open_house = TFDirector:getChildByPath(ui,"Button_open_house")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.LoadingBar_boss_hp = TFDirector:getChildByPath(ui,"LoadingBar_boss_hp")
	self.Label_hp_num = TFDirector:getChildByPath(ui,"Label_hp_num")
	self.label_member_num = TFDirector:getChildByPath(ui,"label_member_num")
	self.label_level = TFDirector:getChildByPath(ui,"label_level")
	self.Image_head = TFDirector:getChildByPath(ui,"Image_head")
	self:refreshView()
end
--根据字符串来计算Label 的size 来去确定使用哪个控件
function LeagueHunterPreviewView:getPrefabe(content)
	--显示宽度
	self.Label_test:setTextAreaSize(me.size(442,0))
    self.Label_test:setText(content)
    local size = self.Label_test:getSize()
    if size.height > 30 then 
    	return self.Panel_prefabe1
    else
    	return self.Panel_prefabe
    end
end


function LeagueHunterPreviewView:_getText(id)
	id = tonumber(id)
	local data = TabDataMgr:getData("String")[id]
	if data then 
		return data.text
	else
		return string.format("not string id %s",tostring(id))
	end
end
function LeagueHunterPreviewView:refreshView( )
	-- body
	self.stageName:setTextById(self.bossCfg.levelName)
	self.label_level:setText("Lv."..self.bossCfg.bossLevel)
	self.label_member_num:setText(self.bossCfg.countLimit)
	
	--词缀显示
	self.ListView_team_keyword:removeAllItems()
	local affixIDs  = self.bossCfg.affixIDs

	for i,affixID in ipairs(affixIDs) do
		local affixData = TabDataMgr:getData("MonsterAffix", affixID)
		for index, name in ipairs(affixData.affixName) do
			local textName = self:_getText(affixData.affixName[index])
		    local textDesc = self:_getText(affixData.affixDesc[index])
		    textDesc = "["..textName.."]"..textDesc
			local node = self:getPrefabe(textDesc):clone()
			node:show()
			local  Label_desc = TFDirector:getChildByPath(node,"Label_desc")
			Label_desc:setText(textDesc)
			self.ListView_team_keyword:pushBackCustomItem(node)
		end
	end

	--boss 头像显示
	local data              = FubenDataMgr:getLevelCfg(self.bossCfg.id)
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


    --组队增益
    local buffInfos = {}
    for k , v in pairs(self.bossCfg.teamBuff) do
    	table.insert(buffInfos,{k= k,v = v})
    end
    table.sort(buffInfos,function(a,b)
    	return a.k  < b.k
    end)
    self.ListView_team_buff:removeAllItems()
	for _ , buffInfo in ipairs(buffInfos) do
		local buffData = TabDataMgr:getData("HuntingBuff",buffInfo.v)
		local textDesc = self:_getText(buffData.buffDescribe)
		local node     = self:getPrefabe(textDesc):clone() 
		node:show()
		local  Label_desc = TFDirector:getChildByPath(node,"Label_desc")
		Label_desc:setText(textDesc)
		self.ListView_team_buff:pushBackCustomItem(node)
	end
	local percent = LeagueDataMgr:getHuntingDungeonInfo().curBoss.dungeonHp
	percent = 100 - math.floor(percent*0.01)
	self.LoadingBar_boss_hp:setPercent(percent)
	self.Label_hp_num:setText(percent.."%")
end

function LeagueHunterPreviewView:runSingleMatching()
	-- self.matchingStat = 1
	-- self:refreshView()
	--发送匹配请求
	local selLevelCfg = self.bossCfg
	TeamFightDataMgr:requestMatchTeam( selLevelCfg.type, selLevelCfg.id)
end

function LeagueHunterPreviewView:registerEvents()
	self.super.registerEvents(self)
	self.Button_open_house:onClick(function ( ... )
		if self.matchingStat == 0 then
			self.matchingStat = 2
			self:refreshView()
			local selLevelCfg = self.bossCfg
			--local callback = function(visibleType,limitLv,isAutoMatch)
			--	TeamFightDataMgr:requestCreateTeam( selLevelCfg.type,selLevelCfg.id,visibleType,limitLv,isAutoMatch)
			--end
			--Utils:openView("teamFight.TeamRoomSettingView",true,selLevelCfg.type,callback
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
end


function LeagueHunterPreviewView:runMatchingAction()
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

function LeagueHunterPreviewView:stopMatchingAction()
	if self.waitingLayer ~= nil then
		self.waitingLayer:removeFromParent()
		self.waitingLayer = nil
	end
end

function LeagueHunterPreviewView:refreshLevelPreviewUI()
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

function LeagueHunterPreviewView:onUpdateLevelStat()
	self.teamLevelStat = TeamFightDataMgr:getTeamLevelStat()[self.curLevelCfg.id]
	self:refreshLevelPreviewUI()
end

function LeagueHunterPreviewView:funcCloseNotice(data)
    if data.switchType == EC_FunctionEnum.TEAM_FIGHT and data.open == false then
    	if self.matchingStat == 1 then
    		TeamFightDataMgr:requestCancelMatchTeam()
    	end
        AlertManager:closeLayer(self)
    end
end
function LeagueHunterPreviewView:runSingleMatching()
	-- self.matchingStat = 1
	-- self:refreshView()
	--发送匹配请求
	local selLevelCfg = self.bossCfg
	TeamFightDataMgr:requestMatchTeam( selLevelCfg.type, selLevelCfg.id)
end

function LeagueHunterPreviewView:stopSingleMatching()
	TeamFightDataMgr:requestCancelMatchTeam()
end

function LeagueHunterPreviewView:onCreatingTeam()
	self.matchingStat = 2
	self:refreshLevelPreviewUI()
end

function LeagueHunterPreviewView:onSingleMatchTimeout()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	local alertparams = clone(EC_GameAlertParams)
	alertparams.msg = 2100058
	alertparams.confirm_title = 2100059
	alertparams.cancel_title = 2100060
	alertparams.comfirmCallback = handler(self.runSingleMatching,self)
	showGameAlert(alertparams)
end

function LeagueHunterPreviewView:onCreateTeamFail()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	-- Utils:showError("创建队伍失败")
	Utils:showError(TextDataMgr:getText(240014))
end

function LeagueHunterPreviewView:onSingleMatchCancelFail()
	-- Utils:showError("无法取消匹配")
	Utils:showError(TextDataMgr:getText(240015))
end

function LeagueHunterPreviewView:onSingleMatchCancel()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
	if self.requireClose == true then
		AlertManager:closeLayer(self)
	end
end

function LeagueHunterPreviewView:onSingleMatching()
	self.matchingStat = 1
	self:refreshLevelPreviewUI()
end

function LeagueHunterPreviewView:onUpdateOpenHouse()
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end
function LeagueHunterPreviewView:onSingleMatchComplete()
	-- AlertManager:closeLayer(self)
	self.matchingStat = 0
	self:refreshLevelPreviewUI()
end

return LeagueHunterPreviewView