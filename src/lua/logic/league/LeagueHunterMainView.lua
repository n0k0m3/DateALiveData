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
* -- 狩猎计划主界面
]]

local LeagueHunterMainView = class("LeagueHunterMainView",BaseLayer)

local dBuffIcon = {
	[1] = "ui/league/zljh/006.png",
	[2] = "ui/league/zljh/007.png",
	[3] = "ui/league/zljh/022.png",
}

local _levelName = {
	[1] = 3300001,
	[2] = 3300002,
	[3] = 3300003,
}

function LeagueHunterMainView:ctor( data )
	self.super.ctor(self,data)
	self:initData()
	self:init("lua.uiconfig.league.leagueHunterMainView")
end

function LeagueHunterMainView:initData( )
	local bossId = LeagueDataMgr:getHuntingDungeonInfo().curBoss.curDungeon
	self.bossCfg = TabDataMgr:getData("HuntingLevel",bossId)
	self.curLevelIndex = 1
	for i,v in ipairs(self.bossCfg.weaknessLevel) do
		if LeagueDataMgr.selectDungeon == v then 
			self.curLevelIndex = i
		end
	end
end

function LeagueHunterMainView:initUI( ui )
	self.super.initUI(self,ui)
	local Image_open_time = TFDirector:getChildByPath(ui,"Image_open_time")
	self.stageLabel       = TFDirector:getChildByPath(Image_open_time,"Label_title")
	self.stageTimeLabel   = TFDirector:getChildByPath(Image_open_time,"Label_open_time")
	self.Panel_level_info = TFDirector:getChildByPath(ui,"Panel_level_info")
	self.Panel_boss_info  = TFDirector:getChildByPath(ui,"Panel_boss_info")
	self.Panel_buff       = TFDirector:getChildByPath(ui,"Panel_buff")
	self.Panel_levels     = TFDirector:getChildByPath(ui,"Panel_levels")
	self.Image_hero       = TFDirector:getChildByPath(ui,"Image_hero")

	self.Button_rewards   = TFDirector:getChildByPath(ui,"Button_rewards")
	self.Button_ranking   = TFDirector:getChildByPath(ui,"Button_ranking")
	self.Button_honer     = TFDirector:getChildByPath(ui,"Button_honer")
	self.Button_enter     = TFDirector:getChildByPath(ui,"Button_enter")
	self.challengeTime    = TFDirector:getChildByPath(ui,"Label_times_value")

	self.Panel_prefabe    = TFDirector:getChildByPath(ui,"Panel_prefabe")
----------------
	self.levelItems = {}
	for i = 1,3 do
		local item  = {}
		local Panel_level_model = TFDirector:getChildByPath(self.Panel_levels,"Panel_level_model"..i)
		item.Panel_level_model = Panel_level_model
		item.Image_icon        = TFDirector:getChildByPath(Panel_level_model,"Image_icon")
		item.label_lv          = TFDirector:getChildByPath(Panel_level_model,"label_lv")
		item.label_name        = TFDirector:getChildByPath(Panel_level_model,"label_name")
		item.image_bufIcon     = TFDirector:getChildByPath(Panel_level_model,"image_bufIcon")
		item.Image_bottom_sel  = TFDirector:getChildByPath(Panel_level_model,"Image_bottom_sel")
		item.index             = i
		self.levelItems[i] = item
	end

----buff
	self.panelBuffs = {}
	for i = 1,3 do
		local Panel_buff     = TFDirector:getChildByPath(self.Panel_buff,"Panel_buff"..i)
		self.panelBuffs[i]   = Panel_buff
		Panel_buff.buff_icon      = TFDirector:getChildByPath(Panel_buff,"buff_icon")
		Panel_buff.label_buff_des = TFDirector:getChildByPath(Panel_buff,"label_buff_des")
		Panel_buff.label_buff_lv  = TFDirector:getChildByPath(Panel_buff,"label_buff_lv")
	end

	self:refreshView()
	self:addCountDownTimer()
end

function LeagueHunterMainView:initPanelLevels()
	local weaknessLevel = self.bossCfg.weaknessLevel
	if not weaknessLevel then 
		dump(self.bossCfg)
		Box("weaknessLevel is nill")
	end
	local buffList = LeagueDataMgr:getHuntingDungeonInfo().buffList
	for i = 1,3 do
		local item = self.levelItems[i]
		local dungeonCfg = TabDataMgr:getData("DungeonLevel",weaknessLevel[i])
		item.Image_icon:setTexture(dungeonCfg.icon)
		item.image_bufIcon:setTexture(dBuffIcon[i])
		if buffList[i] then
			item.label_lv:setText("Lv."..buffList[i].level)
		else
			item.label_lv:setText("Lv.1")
		end
		item.label_name:setTextById(_levelName[i])
		item.cfg = dungeonCfg
		item.Panel_level_model:setTouchEnabled(true)
		item.Panel_level_model:onClick(function ()
			print("onClick..."..tostring(i))
			self.curLevelIndex = i
			self:onSelectLevel()
		end)
	end
	self:onSelectLevel()
end

function LeagueHunterMainView:onSelectLevel()
	LeagueDataMgr.selectDungeon = self.bossCfg.weaknessLevel[self.curLevelIndex]
	--刷新当前选中的关卡
	for i = 1,3 do
		local item = self.levelItems[i]
		item.Image_bottom_sel:setVisible(self.curLevelIndex == i)
	end
	--刷新右侧信息
	self:updatePanelLevelInfo()






end

function LeagueHunterMainView:onHunterInfoUpdate()
	if not LeagueDataMgr:checkHunterOpen() then 
		AlertManager:closeLayer(self)
		return
	end
	local huntingDungeonInfo = LeagueDataMgr:getHuntingDungeonInfo()
	local bossId = huntingDungeonInfo.curBoss.curDungeon
	self.bossCfg = TabDataMgr:getData("HuntingLevel",bossId)
	self:refreshView()
end

function LeagueHunterMainView:updatePanelLevelInfo( )

	local dungeonCfg = TabDataMgr:getData("DungeonLevel",self.bossCfg.weaknessLevel[self.curLevelIndex])
	local Label_level_name = TFDirector:getChildByPath(self.Panel_level_info,"Label_level_name")
	local image_bufIcon = TFDirector:getChildByPath(self.Panel_level_info,"image_bufIcon")
	local label_cur_passCount = TFDirector:getChildByPath(self.Panel_level_info,"label_cur_passCount")
	local LoadingBar_levels = TFDirector:getChildByPath(self.Panel_level_info,"LoadingBar_levels")
	local Label_cur_buff = TFDirector:getChildByPath(self.Panel_level_info,"Label_cur_buff")
	local Label_tips = TFDirector:getChildByPath(self.Panel_level_info,"Label_tips")
	local Label_boss_debuff = TFDirector:getChildByPath(self.Panel_level_info,"Label_boss_debuff")
	local Label_pass_levels = TFDirector:getChildByPath(self.Panel_level_info,"Label_pass_levels")

	Label_tips:setTextById(3300005)
	Label_boss_debuff:setTextById(3300024)
	Label_pass_levels:setTextById(3300025)
	image_bufIcon:setPositionX(Label_boss_debuff:getPositionX() + Label_boss_debuff:getContentSize().width + 33)
	label_cur_passCount:setPositionX(Label_pass_levels:getPositionX() + Label_pass_levels:getContentSize().width + 13)

	local ScrollView_rewards = TFDirector:getChildByPath(self.Panel_level_info,"ScrollView_rewards")

	if not ScrollView_rewards.uiList then
		ScrollView_rewards.uiList = UIListView:create(ScrollView_rewards)
	end

	Label_level_name:setTextById(_levelName[self.curLevelIndex])
	image_bufIcon:setTexture(dBuffIcon[self.curLevelIndex])
	local buffInfo = LeagueDataMgr:getHuntingDungeonInfo().buffList[self.curLevelIndex]
	-- dump(buffInfo)
	local buffData = TabDataMgr:getData("HuntingBuff",buffInfo.buffId)
	local tab = self.bossCfg.weaknessBuff[dungeonCfg.id]
	-- dump({dungeonCfg.id ,tab})
	local maxChallengeCount = tab[#tab][1]
	LoadingBar_levels:setPercent(math.min(100,buffInfo.count*100/maxChallengeCount))
	label_cur_passCount:setText(buffInfo.count)
	if buffInfo.level > 0 then
		Label_cur_buff:setTextById(buffData.buffDescribe)
		Label_cur_buff:setColor(ccc3(255,223,113))
	else
		local text1 = TextDataMgr:getTextAttr(buffData.buffDescribe).text
		local text2 = TextDataMgr:getTextAttr(3300029).text
		Label_cur_buff:setText(text1..text2)
		Label_cur_buff:setColor(ccc3(255,255,255))
	end
	local basePosX = LoadingBar_levels:getParent():getPositionX() - LoadingBar_levels:getContentSize().width/2
	for i = 1,7 do
		local Panel_level_item = TFDirector:getChildByPath(self.Panel_level_info,"Panel_level_item"..i)
		local Label_pass_level = TFDirector:getChildByPath(Panel_level_item,"Label_pass_level")
		local panel_normal = TFDirector:getChildByPath(Panel_level_item,"panel_normal"):hide()
		local panel_cur = TFDirector:getChildByPath(Panel_level_item,"panel_cur"):hide()
		local buff_ = self.bossCfg.weaknessBuff[dungeonCfg.id][i]
		if buff_ then
			local curNode = panel_normal
			if buff_[2] == buffInfo.buffId and buffInfo.level ~= 0 then
				curNode = panel_cur
			end
			curNode:show()
			local Label_level = TFDirector:getChildByPath(curNode,"Label_level")
			Panel_level_item:setVisible(true)
			Label_pass_level:setText(buff_[1])
			Label_level:setText(i)
			Panel_level_item:setPositionX(basePosX + (LoadingBar_levels:getContentSize().width*buff_[1]/maxChallengeCount))
		else
			Panel_level_item:setVisible(false)
		end
	end
	ScrollView_rewards.uiList:removeAllItems()

    for i, v in ipairs(dungeonCfg.dropShow) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.65)
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
        ScrollView_rewards.uiList:pushBackCustomItem(Panel_goodsItem)
    end

end


-- 掉落UI展示类型
-- EC_DropShowType = {
--     GETED = 1,    -- 已获得
--     ACTIVITY_EXTRA = 2,    -- 活动额外掉落
--     ACTIVITY_MULTIPLE = 4,    -- 活动翻倍
--     FIRST_PASS = 8,    -- 首通
--     TEAM_MASS = 16,     --集结奖励
--     DATING_GETED = 32,    -- 约会已获得
-- }

function LeagueHunterMainView:getText(id)
	id = tonumber(id)
	local data = TabDataMgr:getData("String")[id]
	if data then 
		return data.text
	else
		return string.format("not string id %s",tostring(id))
	end
end


function LeagueHunterMainView:updatePanelBossInfo( )
	local Label_boss_name         = TFDirector:getChildByPath(self.Panel_boss_info,"Label_boss_name")
	local Label_buff_desc         = TFDirector:getChildByPath(self.Panel_boss_info,"Label_buff_desc")
	local Label_hp_num            = TFDirector:getChildByPath(self.Panel_boss_info,"Label_hp_num")
	local LoadingBar_boss_hp      = TFDirector:getChildByPath(self.Panel_boss_info,"LoadingBar_boss_hp")
	local label_curLv             = TFDirector:getChildByPath(self.Panel_boss_info,"label_curLv")
	local label_limitNum          = TFDirector:getChildByPath(self.Panel_boss_info,"label_limitNum")
	local label_honerNum          = TFDirector:getChildByPath(self.Panel_boss_info,"label_honerNum")
    local label_honer             = TFDirector:getChildByPath(self.Panel_boss_info,"Label_honer")
    local Label_reward_title             = TFDirector:getChildByPath(self.Panel_boss_info,"Label_reward_title")

	label_honer:setTextById(3300032)
	label_honerNum:setPositionX(label_honer:getPositionX() + label_honer:getContentSize().width + 13)
	
	local ScrollView_rewards      = TFDirector:getChildByPath(self.Panel_boss_info,"ScrollView_rewards")
	if not ScrollView_rewards.uiList then
		ScrollView_rewards.uiList = UIListView:create(ScrollView_rewards)
	end
	local ScrollView_buff      = TFDirector:getChildByPath(self.Panel_boss_info,"ScrollView_buff")
	if not ScrollView_buff.uiList then
		ScrollView_buff.uiList = UIListView:create(ScrollView_buff)
	end



	label_curLv:setText(self.bossCfg.bossLevel)
	label_limitNum:setText(self.bossCfg.countLimit)

   --组队增益
   	Label_buff_desc:hide()
    local buffInfos = {}
    for k , v in pairs(self.bossCfg.teamBuff) do
    	table.insert(buffInfos,{k= k,v = v})
    end
    table.sort(buffInfos,function(a,b)
    	return a.k  < b.k
    end)
    ScrollView_buff.uiList:removeAllItems()
	for _ , buffInfo in ipairs(buffInfos) do
		local buffData = TabDataMgr:getData("HuntingBuff",buffInfo.v)
		local textDesc = self:getText(buffData.buffDescribe)
		local node = self.Panel_prefabe:clone()
		node:show()
		local oldSize = node:getContentSize()
		local  Label_desc = TFDirector:getChildByPath(node,"Label_desc")
		local  Image_icon = TFDirector:getChildByPath(node,"Image_icon")
		Label_desc:setText(textDesc)
		local newHeight = Label_desc:getContentSize().height + 5
		local offsetH = newHeight - oldSize.height
		node:setContentSize(CCSizeMake(oldSize.width,newHeight))
		Label_desc:setPositionY(Label_desc:getPositionY() + offsetH)
		Image_icon:setPositionY(Image_icon:getPositionY() + offsetH)
		ScrollView_buff.uiList:pushBackCustomItem(node)
	end

	Label_boss_name:setTextById(self.bossCfg.levelName)
	label_honerNum:setText(LeagueDataMgr:getHuntingDungeonInfo().curBoss.honor)
	local percent = LeagueDataMgr:getHuntingDungeonInfo().curBoss.dungeonHp
	percent = 100 - math.floor(percent*0.01)
	LoadingBar_boss_hp:setPercent(percent)
	Label_hp_num:setText(percent.."%")

	---Boss 奖励 显示
	ScrollView_rewards.uiList:removeAllItems()
    local first = not LeagueDataMgr:isReceivedFdReward()
    local dropShow = self.bossCfg.firstDropShow
    Label_reward_title:setTextById(3300035)
    if not first then 
    	dropShow   = self.bossCfg.dropShow
    	Label_reward_title:setTextById(3300036)
	end
    for i, v in pairs(dropShow) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_goodsItem:show()
        Panel_goodsItem:Scale(0.65)
        local flag = 0
        if first then
	  		flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
	  	end
        PrefabDataMgr:setInfo(Panel_goodsItem, {i,v},flag)
        ScrollView_rewards.uiList:pushBackCustomItem(Panel_goodsItem)
    end

end


function LeagueHunterMainView:updatePanelBuff()
	local huntingDungeonInfo = LeagueDataMgr:getHuntingDungeonInfo()
	local buffList = huntingDungeonInfo.buffList
	for index, item in ipairs(self.panelBuffs) do
		local data  = buffList[index]
		if data and data.level > 0 then 
			local buffData = TabDataMgr:getData("HuntingBuff",data.buffId) 
			item:show()
			item.buff_icon:setTexture(dBuffIcon[index])
			item.label_buff_des:setTextById(buffData.buffDescribe2)
			item.label_buff_lv:setText("Lv."..tostring(data.level))
		else
			item:hide()
		end
	end
-- {buffId = defBuffId, level = deflevel, count = count,id = v}
		


	-- 	local Panel_buff     = TFDirector:getChildByPath(self.Panel_buff,"Panel_buff"..i)
	-- 	local buff_icon      = TFDirector:getChildByPath(Panel_buff,"buff_icon")
	-- 	local label_buff_des = TFDirector:getChildByPath(Panel_buff,"label_buff_des")
	-- 	local label_buff_lv  = TFDirector:getChildByPath(Panel_buff,"label_buff_lv")
	-- end
end

function LeagueHunterMainView:registerEvents()
	self.super.registerEvents(self)
	self.Button_rewards:onClick(function ( ... )
		-- LeagueDataMgr:ReqHuntingBossAward(self.bossCfg.id)
		Utils:openView("league.LeagueHunterRewardView") --排行列表
	end)
	self.Button_ranking:onClick(function ( ... )
		TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_RANK,{})
	end)
	self.Button_honer:onClick(function ( ... )
		Utils:openView("league.LeagueHunterHonorView") --荣誉
	end)
	self.Button_enter:onClick(function ( ... )
		local step = self:getStep()
		if step < EC_HunterStep.FORMAL_OPEN then --准备期
			local item       =  self.levelItems[self.curLevelIndex]
			local dungeonCfg =  item.cfg
			local view = requireNew("lua.logic.fuben.FubenSquadView"):new(dungeonCfg.dungeonType, dungeonCfg.id)
			AlertManager:addLayer(view)
			AlertManager:show()
		else
			local view = requireNew("lua.logic.league.LeagueHunterPreviewView"):new(self.bossCfg.id)
			AlertManager:addLayer(view)
			AlertManager:show()
		end
	end)

	EventMgr:addEventListener(self, EV_HUNTER_RANKLIST_GET, function ( ... )
		Utils:openView("league.LeagueHunterRankView") --排行列表
	end)

	-- EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_GET, function()
	-- 	Utils:openView("league.LeagueHunterRewardView")  --奖励列表
	-- end)
	--
	EventMgr:addEventListener(self, EV_HUNTER_INFO_UPDATE, handler(self.onHunterInfoUpdate,self))
	--刷新挑战期boss奖励
	EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_GET,    handler(self.onUpdateReward,self))
	EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_UPDATE, handler(self.onUpdateReward,self))
end

--更新奖励
function LeagueHunterMainView:onUpdateReward()
	local step = self:getStep()
	if step >= EC_HunterStep.FORMAL_OPEN then --挑战期刷新boss奖励
	local ScrollView_rewards = TFDirector:getChildByPath(self.Panel_boss_info,"ScrollView_rewards")
		if not ScrollView_rewards.uiList then
			---Boss 奖励 显示
			ScrollView_rewards.uiList:removeAllItems()
		    local first    = not LeagueDataMgr:isReceivedFdReward()
		    local dropShow = self.bossCfg.firstDropShow
		    if not first then 
		    	dropShow   = self.bossCfg.dropShow
			end
		    for i, v in pairs(dropShow) do
		    	print(i,v)
		        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		        Panel_goodsItem:show()
		        Panel_goodsItem:Scale(0.65)
		        Panel_goodsItem:getChildByName("Image_firstpass"):setVisible(first)
		        PrefabDataMgr:setInfo(Panel_goodsItem, i, v)
		        ScrollView_rewards.uiList:pushBackCustomItem(Panel_goodsItem)
		    end
		end
	end

	local redPoint = TFDirector:getChildByPath(self.Button_rewards,"Image_redPoint")
	redPoint:setVisible(LeagueDataMgr:getHasHuntingFDAwardCanGet())
end

function LeagueHunterMainView:removeCountDownTimer()
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end
-- --追猎计划阶段
-- EC_HunterStep = { 
--     FUN_NOT_OPEN     =0 ,  --功能未开放, 
--     READY_OPEN       =1 , --准备期开放, 
--     READY_Settlement =2 , --准备期结算, 
--     READY_END        =3 , --准备期结束, 
--     FORMAL_OPEN      =11,--正式挑战开放, 
--     FORMAL_SETTLEMENT=12, --正式挑战结算, 
--     FORMAL_END       =13, --正式挑战结束
-- }


function LeagueHunterMainView:getStep()
	return LeagueDataMgr:getHuntingDungeonInfo().step.step
end

function LeagueHunterMainView:refreshView(  )
	local stage = self:getStep()
	self.Panel_levels:setVisible(false)
	self.Panel_level_info:setVisible(false)
	self.Panel_buff:setVisible(false)
	self.Panel_boss_info:setVisible(false)
	local posOffset = ccp(0,0)
	if stage < EC_HunterStep.FORMAL_OPEN then -- 准备期
		self.stageLabel:setTextById(3300017)
		-- self.stageLabel:setText("准备期")
		self.Panel_levels:setVisible(true)
		self.Panel_level_info:setVisible(true)
		self:initPanelLevels()
		posOffset = self.bossCfg.pictureOffset

	else -- 挑战期
		self.stageLabel:setTextById(3300018)
		-- self.stageLabel:setText("挑战期")
		self.Panel_buff:setVisible(true)
		self.Panel_boss_info:setVisible(true)
		self:updatePanelBuff()
		self:updatePanelBossInfo()
		posOffset = self.bossCfg.pictureOffset2 or self.bossCfg.pictureOffset		
	end
	self.Image_hero:setTexture(self.bossCfg.bossPicture)
	self.Image_hero:setScale(self.bossCfg.roleSize or 0.6 )
	local pos = ccp(373 + posOffset.x,312 + posOffset.y)
	self.Image_hero:setPosition(pos)
	self.Image_hero:show()
	-- TODO self.Button_enter 按钮的禁用逻辑 self.challengeTime 数值的设置
	local times = self:getChallengeTimes()
	print("tmes"..tostring(times))
	self.challengeTime:setText(tostring(times))
	local step = self:getStep()
	local hp  = LeagueDataMgr:getHuntingDungeonInfo().curBoss.dungeonHp
	if times > 0 then 
		if step == EC_HunterStep.READY_OPEN 
			or step == EC_HunterStep.FORMAL_OPEN then 
			if hp < 10000 then 
				self.Button_enter:setTouchEnabled(true)
				self.Button_enter:setGrayEnabled(false)
			else
				self.Button_enter:setTouchEnabled(false)
				self.Button_enter:setGrayEnabled(true)
			end
		else
			self.Button_enter:setTouchEnabled(false)
			self.Button_enter:setGrayEnabled(true)
		end
	else
		self.Button_enter:setTouchEnabled(false)
		self.Button_enter:setGrayEnabled(true)
	end

	local redPoint = TFDirector:getChildByPath(self.Button_rewards,"Image_redPoint")
	redPoint:setVisible(LeagueDataMgr:getHasHuntingFDAwardCanGet())
	self:updateTimeFunc()	
end
--获取剩余挑战次数
function LeagueHunterMainView:getChallengeTimes()
	local huntingDungeonInfo = LeagueDataMgr:getHuntingDungeonInfo()
	dump(huntingDungeonInfo)
	local step = huntingDungeonInfo.step.step
	if step == EC_HunterStep.FUN_NOT_OPEN then 
		return 0
	elseif step < EC_HunterStep.FORMAL_OPEN then --准备期
		return huntingDungeonInfo.playerWeakness.leftCount
	else --挑战期间
		return huntingDungeonInfo.curBoss.leftCount
	end
end

function LeagueHunterMainView:updateTimeFunc()
	local huntingDungeonInfo = LeagueDataMgr:getHuntingDungeonInfo()
	if not huntingDungeonInfo then
		return
	end
	local stepInfo   = huntingDungeonInfo.step
	if not stepInfo then
		return
	end
	local nextTime   = stepInfo.nextTime
    local remainTime = math.max(0,nextTime - ServerDataMgr:getServerTime())
    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime, true)
	if stepInfo.step == EC_HunterStep.READY_OPEN 
	or stepInfo.step == EC_HunterStep.FORMAL_OPEN then
	  self.stageTimeLabel:setTextById("r304001", day, hour)
	else
	  self.stageTimeLabel:setTextById("r304002", day, hour)
	end  
end

function LeagueHunterMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(60000, -1, nil, handler(self.updateTimeFunc, self))
    end
end

function LeagueHunterMainView:removeEvents()
    print("LeagueHunterMainView:removeEvents___")
    self:removeCountDownTimer()
end


return LeagueHunterMainView