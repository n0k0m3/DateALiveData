local DispatchDetailLayer = class("DispatchDetailLayer", BaseLayer)


function DispatchDetailLayer:ctor(data)
    self.super.ctor(self,data)
    self.selectCell = nil
    self.paramData_ = data

	self.curSelectTab = nil
	self.chooseTabIdx = data.tabIdx
	self.selectChapterIdxs = {}
	self.curSelectChapter = nil
	self.hidePanelInfoState = false
	self.maxTimes = 0
	self.selectTimes = 0
	self.addedHeros = {}
	local hangupMap = TabDataMgr:getData("Hangup")
	self.tabBtnInfo = {
	{name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.DATING].prompt1)),ptype = EC_DISPATCHType.DATING, normalIcon = "ui/dispatch/ui_025.png",selectIcon = "ui/dispatch/ui_035.png"},
	{name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.DAILY].prompt1)), ptype = EC_DISPATCHType.DAILY,normalIcon = "ui/dispatch/ui_023.png",selectIcon = "ui/dispatch/ui_033.png"},
	{name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.TEAM].prompt1)), ptype = EC_DISPATCHType.TEAM,normalIcon = "ui/dispatch/ui_024.png",selectIcon = "ui/dispatch/ui_034.png"},
	{name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.SPRITE].prompt1)), ptype = EC_DISPATCHType.SPRITE,normalIcon = "ui/dispatch/ui_022.png",selectIcon = "ui/dispatch/ui_032.png"},
	{name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.THEATER].prompt1)), ptype = EC_DISPATCHType.THEATER,normalIcon = "ui/dispatch/ui_021.png",selectIcon = "ui/dispatch/ui_031.png"},
	}

    self:init("lua.uiconfig.dispatch.dispatchDetailLayer")
end

function DispatchDetailLayer:getClosingStateParams()
    return {self.paramData_}
end

function DispatchDetailLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self:addLockLayer()

	self.tabButtons = {}
	local Panel_content = TFDirector:getChildByPath(ui, "Panel_content")
	self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
	self.Button_tab_item = TFDirector:getChildByPath(ui, "Button_tab_item")
	self.Panel_chapter_item = TFDirector:getChildByPath(ui, "Panel_chapter_item")

	self.ScrollView_tab = TFDirector:getChildByPath(Panel_content, "ScrollView_tab")
	self.ListView_tab = UIListView:create(self.ScrollView_tab)
	self.ListView_tab:setItemsMargin(25)
	local ScrollView_chapter = TFDirector:getChildByPath(Panel_content, "ScrollView_chapter")
	self.ListView_chapter = UIListView:create(ScrollView_chapter)
	ScrollView_chapter:setSwallowTouch(false)
	self.ListView_chapter:setItemsMargin(5)

	self.Image_bg_hero = TFDirector:getChildByPath(Panel_content, "Image_bg_hero")
	self.Panel_info = TFDirector:getChildByPath(Panel_content, "Panel_info")
	self.Image_arrow = TFDirector:getChildByPath(self.Panel_info, "Image_arrow")
	self.Image_bg1 = TFDirector:getChildByPath(Panel_content, "Image_bg1")
	local Panel_dispatch_info = TFDirector:getChildByPath(Panel_content, "Panel_dispatch_info")
	self.Label_title1 = TFDirector:getChildByPath(self.Panel_info, "Label_title1")
	self.Label_title2 = TFDirector:getChildByPath(self.Panel_info, "Label_title2")
	self.Label_desc1 = TFDirector:getChildByPath(self.Panel_info, "Label_desc1")
	self.Label_desc2 = TFDirector:getChildByPath(self.Panel_info, "Label_desc2")
	self.Label_stars = TFDirector:getChildByPath(self.Panel_info, "Label_stars")
	self.Panel_info_star = TFDirector:getChildByPath(self.Panel_info, "Panel_info_star")
	self.infoStarPosy = self.Panel_info_star:getPositionY()
	for i = 1, 5 do
		self["Image_info_star"..i] = TFDirector:getChildByPath(self.Panel_info, "Image_info_star"..i)
	end
	self.ScrollView_reward = UIGridView:create(TFDirector:getChildByPath(self.Panel_info, "ScrollView_reward"))
	self.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	self.Panel_goodsItem:setScale(0.6)
	self.ScrollView_reward:setItemModel(self.Panel_goodsItem)
    self.ScrollView_reward:setColumn(4)
    self.ScrollView_reward:setColumnMargin(8)
    self.ScrollView_reward:setRowMargin(8)
	self.Label_title1:setTextById(213040)
	self.Label_title2:setTextById(213041)

	self.Panel_goto = TFDirector:getChildByPath(Panel_content, "Panel_goto"):hide()
	self.Label_tips = TFDirector:getChildByPath(Panel_content, "Label_tips")
	self.Button_goto = TFDirector:getChildByPath(Panel_content, "Button_goto")

	self.panel_heros = {}
	for i = 1, 3 do
		local foo = {}
		foo.Panel_hero = TFDirector:getChildByPath(Panel_dispatch_info, "Panel_hero"..i)
		foo.Panel_info = TFDirector:getChildByPath(foo.Panel_hero, "Panel_info")
		foo.Image_add = TFDirector:getChildByPath(foo.Panel_hero, "Image_add")
		foo.Image_hero_icon = TFDirector:getChildByPath(foo.Panel_hero, "Image_hero_icon")
		foo.LoadingBar_progress = TFDirector:getChildByPath(foo.Panel_hero, "LoadingBar_progress")
		foo.Label_percent = TFDirector:getChildByPath(foo.Panel_hero, "Label_percent")
		foo.Panel_star = TFDirector:getChildByPath(foo.Panel_hero, "Panel_star")
		for j = 1, 5 do
			foo["Image_star"..j] = TFDirector:getChildByPath(foo.Panel_star, "Image_star"..j)
		end
		for k=1,2 do
			foo["Image_suit_"..k] = TFDirector:getChildByPath(foo.Panel_info, "Image_suit_"..k)
		end
		self.panel_heros[i] = foo
	end
	self.Image_buff_bg1 = TFDirector:getChildByPath(Panel_dispatch_info, "Image_buff_bg1")
	self.Image_buff_bg2 = TFDirector:getChildByPath(Panel_dispatch_info, "Image_buff_bg2")
	self.Image_buff_bg3 = TFDirector:getChildByPath(Panel_dispatch_info, "Image_buff_bg3")
	self.Label_time_min = TFDirector:getChildByPath(Panel_dispatch_info, "Label_time_min")
	self.Label_extra_reward = TFDirector:getChildByPath(Panel_dispatch_info, "Label_extra_reward")

	self.Button_dispatch = TFDirector:getChildByPath(Panel_dispatch_info, "Button_dispatch")
	self.Label_dispatch = TFDirector:getChildByPath(self.Button_dispatch, "Label_dispatch")

	self.Panel_select_times = TFDirector:getChildByPath(Panel_content, "Panel_select_times")
	self.Label_times_name = TFDirector:getChildByPath(self.Panel_select_times, "Label_times_name")
	self.Button_times_down = TFDirector:getChildByPath(self.Panel_select_times, "Button_times_down")
	self.Button_times_up = TFDirector:getChildByPath(self.Panel_select_times, "Button_times_up")
	self.Label_times_num = TFDirector:getChildByPath(self.Panel_select_times, "Label_times_num")
	self.Label_cost1_title = TFDirector:getChildByPath(self.Panel_select_times, "Label_cost1_title")
	self.Label_cost1_num = TFDirector:getChildByPath(self.Panel_select_times, "Label_cost1_num")
	self.Label_cost2_title = TFDirector:getChildByPath(self.Panel_select_times, "Label_cost2_title")
	self.Label_cost2_num = TFDirector:getChildByPath(self.Panel_select_times, "Label_cost2_num")


	for i=1,#self.tabBtnInfo do
		local info = self.tabBtnInfo[i]
		local btnItem = self.Button_tab_item:clone()
		self.tabButtons[i] = {id = info.ptype, tabBtn = btnItem}
		self.ListView_tab:pushBackCustomItem(btnItem)
	end

    if self.chooseTabIdx then
		self:onTabBtnTouch(self.chooseTabIdx)
	else
		self:onTabBtnTouch(EC_DISPATCHType.DATING)
	end
end

function DispatchDetailLayer:onTabBtnTouch(idx)
	if self.curSelectTab == idx then
		return
	end
	self.Panel_info:hide()
	self.Panel_goto:hide()
	self.curSelectTab = idx
	for i,v in ipairs(self.tabButtons) do
		local info = self.tabBtnInfo[i]
		local btn = TFDirector:getChildByPath(v.tabBtn, "Button_tab")
		local Image_tab_icon = TFDirector:getChildByPath(v.tabBtn, "Image_tab_icon")
		local label_name = TFDirector:getChildByPath(v.tabBtn, "Label_label_name")
		label_name:setText(info.name)
		if v.id == idx then
			Image_tab_icon:setTexture(info.selectIcon)
			v.tabBtn:setTextureNormal("ui/fairy/new_ui/tab_btn_select.png")
		else
			Image_tab_icon:setTexture(info.normalIcon)
			v.tabBtn:setTextureNormal("")
		end
	end
	self.selectChapterIdxs = {}
	self:refreshContentUI()
end

function DispatchDetailLayer:refreshContentUI()
	self.dispatchData = nil
	self.hangUpCfgs = DispatchDataMgr:getDispatchHangUpCfgs(self.curSelectTab)
	self.dispatchData = DispatchDataMgr:getDispatchs(self.curSelectTab)
	self.addedHeros = DispatchDataMgr:getDispathedHeros(self.curSelectTab)
	self.Panel_goto:hide()
	self.ListView_chapter:removeAllItems()
	self:removeUpdateTimer()
	self.chapter_items = {}
	local panel_charpter = TFPanel:create()
	panel_charpter:setAnchorPoint(ccp(0,0.5))
	for i,v in ipairs(self.hangUpCfgs) do
		local item = self.Panel_chapter_item:clone()
		local foo = {}
		foo.root = item
		foo.Panel_item_ui = TFDirector:getChildByPath(item, "Panel_item_ui")
		foo.Panel_item_info = TFDirector:getChildByPath(item, "Panel_item_info")
		foo.Label_name = TFDirector:getChildByPath(item, "Label_name")
		foo.Image_icon = TFDirector:getChildByPath(item, "Image_icon")
		foo.Button_speedup = TFDirector:getChildByPath(item, "Button_speedup"):hide()
		foo.Label_state = TFDirector:getChildByPath(item, "Label_state")
		foo.Image_state = TFDirector:getChildByPath(item, "Image_state")
		foo.Panel_state_touch = TFDirector:getChildByPath(item, "Panel_state_touch")
		foo.Label_time = TFDirector:getChildByPath(item, "Label_time")
		foo.Image_time_bg = TFDirector:getChildByPath(item, "Image_time_bg")
		foo.LoadingBar_time = TFDirector:getChildByPath(item, "LoadingBar_time")
		foo.Panel_spine = TFDirector:getChildByPath(item, "Panel_spine")
		foo.Image_select = TFDirector:getChildByPath(item, "Image_select")
		local config = self.hangUpCfgs[i]
		foo.Label_name:setTextById(config.name)
		self.chapter_items[i] = foo
		item:setPosition(ccp(100 + (i - 1) * 160, 0))
		foo.Panel_item_ui:setPositionY((i%2 == 0) and 92 or -102)
		foo.Panel_item_info:setPositionY((i%2 == 0) and 127 or -77)
		if #self.hangUpCfgs <= 1 then
			item:setPosition(ccp(350, 0))
			foo.Panel_item_ui:setScale(1.5)
			foo.Button_speedup:setScale(0.8)
			foo.Panel_item_ui:setPosition(ccp(0,0))
			foo.Panel_item_info:setPosition(ccp(124,37))
		end
		panel_charpter:addChild(item)
		foo.Panel_item_ui:setTouchEnabled(true)
		foo.Panel_item_ui:onClick(function()
	        self:selectChapter(i)
	        GameGuide:checkGuideEnd(self.guideFuncId)
	    end)
	    foo.Panel_state_touch:setTouchEnabled(true)
		foo.Panel_state_touch:onClick(function()
	        self:chooseChapter(i)
	        GameGuide:checkGuideEnd(self.guideFuncId)
	    end)

	    foo.Button_speedup:onClick(function()
	    	local info = DispatchDataMgr:getDispatchsDungeonInfo(self.curSelectTab, v.id)
	    	local day, hour, min, sec = Utils:getDHMS(info.eTime - ServerDataMgr:getServerTime(), false)
	    	local cost = (hour * 60 + min + (sec > 0 and 1 or 0)) * v.renovate
	    	local function speedUp()
                if GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND) < cost then
	        		Utils:showTips(800048)
	        	else
	        		DispatchDataMgr:reqSpeedUpDispatchInfo(self.curSelectTab, v.id)
	        	end
            end
	        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_DispatchSpeed) then
                speedUp()
            else
		        local rstr = TextDataMgr:getTextAttr(213187)
	            local formatStr = rstr and rstr.text or ""
	            local content = string.format(formatStr, cost, TabDataMgr:getData("Item", EC_SItemType.DIAMOND).icon)
	            Utils:openView("common.ReConfirmTipsView", {tittle = 213189, content = content, reType = EC_OneLoginStatusType.ReConfirm_DispatchSpeed, confirmCall = speedUp})
	    	end
	    end)
	end
	panel_charpter:setSize(CCSizeMake(#self.hangUpCfgs * 170 + 200,380))
	self.ListView_chapter:pushBackCustomItem(panel_charpter)
	self.Button_dispatch:setTextureNormal("ui/common/button09.png")
	self.Label_dispatch:setTextById(213171)
	if self.dispatchData then
		self.selectChapterIdxs = {}
		-- self.Button_dispatch:setTextureNormal("ui/common/button_blue_s.png")
		-- self.Label_dispatch:setTextById(213172)
	else
		for i,v in ipairs(self.hangUpCfgs) do
			if DispatchDataMgr:checkEnableDiapatch(self.curSelectTab, v.relatedDungeonLevel) then
				self.selectChapterIdxs[i] = 1
			end
		end
	end
	self:updateDispatchTimesData()
	self:refreshDispatchInfo()
	if #self.chapter_items > 0 then
		self:selectChapter(1)
		self:refreshChaptetItems()
		self:addUpdateTimer()
		self:refreshChapterSelectState()
	else
		self.Panel_goto:show()
		if self.curSelectTab == EC_DISPATCHType.DAILY then
			self.Label_tips:setTextById(213043)
		elseif self.curSelectTab == EC_DISPATCHType.SPRITE then
			self.Label_tips:setTextById(213044)
		elseif self.curSelectTab == EC_DISPATCHType.THEATER then
			if FubenDataMgr:checkTheaterBossOpened() then
				self.Label_tips:setTextById(213045)
			else
				self.Label_tips:setTextById(213029)
			end
		elseif self.curSelectTab == EC_DISPATCHType.TEAM then
			self.Label_tips:setTextById(213042)
		end
		self.Button_goto:setPositionX(self.Label_tips:getPositionX() + self.Label_tips:getSize().width + 40)
	end
end

function DispatchDetailLayer:updateDispatchTimesData()
	self.Panel_select_times:hide()
	self.DispatchTimes = {}
	self.maxTimes = 0
	self.selectTimes = 0		
	if not self.dispatchData and #self.addedHeros > 0 and table.count(self.selectChapterIdxs) > 0 then
		local levelIds = {}
		for i, v in ipairs(self.hangUpCfgs) do
			if self.selectChapterIdxs[i] then
				table.insert(levelIds, v.relatedDungeonLevel)
			end
		end
		self.DispatchTimes = DispatchDataMgr:getEnableDisPatchTimes(self.curSelectTab, levelIds)
		for k, v in pairs(self.DispatchTimes) do
			self.maxTimes = self.maxTimes + v
		end
		self.selectTimes = self.maxTimes
		if self.maxTimes > 0 then
			self.Panel_select_times:show()
			self:updateDispatchTimesUI()
		end
	end
end

function DispatchDetailLayer:updateDispatchTimesUI()
	self.realTimes = {}
	local excutionCost = 0
	local subTimes = self.selectTimes
	for i, v in ipairs(self.hangUpCfgs) do
		excutionCost = v.consumptionFatigue
		if self.selectChapterIdxs[i] then
			self.realTimes[i] = math.min(subTimes, self.DispatchTimes[v.relatedDungeonLevel])
			subTimes = subTimes - self.realTimes[i]
		end
	end

	local effecSuitIds = DispatchDataMgr:getEffectSuitIds(self.curSelectTab)
    for i,buffId in ipairs(effecSuitIds) do
        local buffCfg = TabDataMgr:getData("HangupBuff",buffId)
        for j,effectId in ipairs(buffCfg.fetterEffect) do
            local effectCfg = TabDataMgr:getData("HangupResult",effectId)
            if effectCfg.valid == 1 and effectCfg.typesFetters == 2 then
                excutionCost = (1 - effectCfg.fetterParameter * 0.0001) * excutionCost
                break
            end
        end
        
    end

	local config = self.hangUpCfgs[1]
	local cost = 0
	if self.curSelectTab == EC_DISPATCHType.DAILY then
		local levelCfg = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel)
        local groupId = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel).levelGroupId
		cost = levelCfg.cost[1][2]
	elseif self.curSelectTab == EC_DISPATCHType.SPRITE then
        local levelCfg = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel)
		cost = levelCfg.cost[1][2]
	elseif self.curSelectTab == EC_DISPATCHType.THEATER then
		
	elseif self.curSelectTab == EC_DISPATCHType.TEAM then
		local levelCfg = TeamFightDataMgr:getTeamLevelCfg(0,config.relatedDungeonLevel)
        cost = 0
        for k,v in pairs(levelCfg.fightCost) do
            cost = v
        end
	elseif self.curSelectTab == EC_DISPATCHType.DATING then
		cost = 20
	end

	self.Label_times_num:setText(tostring(self.selectTimes))
	local titleStr = "派遣次数："
	for i=1,#self.tabBtnInfo do
		local info = self.tabBtnInfo[i]
		if self.curSelectTab == info.ptype then
			titleStr = info.name..titleStr
			break
		end
	end
	self.Label_times_name:setText(titleStr)
	if self.curSelectTab == EC_DISPATCHType.DATING then
		self.Label_cost1_title:setTextById(213036)
	else
		self.Label_cost1_title:setTextById(213035)
	end
	if cost > 0 then
		self.Label_cost1_title:show()
		self.Label_cost1_num:show()
		self.Label_cost1_num:setText((self.selectTimes*cost).."点")
	else
		self.Label_cost1_title:hide()
		self.Label_cost1_num:hide()
	end
	
	self.Label_cost2_title:setTextById(213037)
	self.Label_cost2_num:setText(tostring(excutionCost*self.selectTimes).."点")
end

function DispatchDetailLayer:selectChapter(idx, force)
	self.curSelectChapter = idx
	self:refreshPanelInfo()
	self:refreshChaptetItems()
	local arr = {}
    if self.hidePanelInfoState then
    	self.hidePanelInfoState = false
    	table.insert(arr, CCMoveTo:create(0.3, ccp(0,0)))
	    table.insert(arr,CCCallFuncN:create(function()
	    	self.Image_arrow:setRotation(0)
	    end))
	    self.Panel_info:runAction(CCSequence:create(arr))
    end
end

function DispatchDetailLayer:chooseChapter(idx)
	local config = self.hangUpCfgs[idx]
	if not self.dispatchData then
		if self.selectChapterIdxs[idx] then
			self.selectChapterIdxs[idx] = nil
		else
			self.selectChapterIdxs[idx] = 1
		end
	end
	self:updateDispatchTimesData()
	self:refreshChapterSelectState()
	self:updateDispatchBtnState()
	self:refreshDispatchInfo()
end

function DispatchDetailLayer:updateDispatchBtnState()
	self.Button_dispatch:setGrayEnabled(false)
	self.Button_dispatch:setTouchEnabled(true)
	if self.dispatchData then
		self.Button_dispatch:setGrayEnabled(true)
		self.Button_dispatch:setTouchEnabled(false)
	elseif #self.addedHeros <= 0 then
		self.Button_dispatch:setGrayEnabled(true)
		self.Button_dispatch:setTouchEnabled(false)
	elseif table.count(self.selectChapterIdxs) <= 0 then
		self.Button_dispatch:setGrayEnabled(true)
		self.Button_dispatch:setTouchEnabled(false)
	elseif self.maxTimes <= 0 then
		self.Button_dispatch:setGrayEnabled(true)
		self.Button_dispatch:setTouchEnabled(false)
	else
		for k, v in pairs(self.selectChapterIdxs) do
			local cfg = self.hangUpCfgs[tonumber(k)]
			if not DispatchDataMgr:checkEnableDiapatch(self.curSelectTab, cfg.relatedDungeonLevel) then
				self.Button_dispatch:setGrayEnabled(true)
				self.Button_dispatch:setTouchEnabled(false)
				break
			end
		end
	end
end

function DispatchDetailLayer:refreshChapterSelectState()
	for i,foo in ipairs(self.chapter_items) do
		local config = self.hangUpCfgs[i]
		local info = DispatchDataMgr:getDispatchsDungeonInfo(self.curSelectTab, config.id)
		if self.selectChapterIdxs[i] or info then
			foo.Image_state:setTexture("ui/dispatch/ui_073.png")
		else
			foo.Image_state:setTexture("ui/dispatch/ui_074.png")
		end
	end
end


function DispatchDetailLayer:refreshChaptetItems()
	local serverTime = ServerDataMgr:getServerTime()
	local state = false
	for i,foo in ipairs(self.chapter_items) do
		foo.Label_time:hide()
		foo.Image_time_bg:show()
		foo.Button_speedup:hide()
		local config = self.hangUpCfgs[i]
		foo.Image_icon:setTexture(config.functionsIcon)
		foo.Image_select:setVisible(self.curSelectChapter == i)
		local info = DispatchDataMgr:getDispatchsDungeonInfo(self.curSelectTab, config.id)
		if info then
			foo.Label_state:setTextById(213121)
			if state then
				foo.Label_time:show()
				foo.Label_time:setText(config.hangupTime..TextDataMgr:getText(213173))
				foo.LoadingBar_time:setPercent(100)
			else
				if not foo.Spine_effect then
		            foo.Spine_effect = SkeletonAnimation:create("effect/effect_ZHguanka/effect_ZHguanka")
		            foo.Panel_spine:addChild(foo.Spine_effect, 0)
		            foo.Spine_effect:play("effect_ZHguanka1",true)
		        end
				if info.eTime < serverTime then
					foo.Image_time_bg:hide()
				else
					foo.Button_speedup:show()
					state = true
					
					foo.Label_time:show()
					local suplusTime = info.eTime - serverTime
					local day, hour, min, sec = Utils:getDHMS(suplusTime, false)
					foo.Label_time:setTextById(112000213, min, sec)
					local percent = (suplusTime / (config.hangupTime * 60)) * 100
					foo.LoadingBar_time:setPercent(percent)
					local iconPath = "ui/dispatch/ui_057.png"
			        if percent >= 75 then
			            iconPath = "ui/dispatch/ui_054.png"
			        elseif percent >= 50 then
			            iconPath = "ui/dispatch/ui_056.png"
			        elseif percent >= 25 then
			            iconPath = "ui/dispatch/ui_055.png"
			        end
			        foo.LoadingBar_time:setTexture(iconPath)
				end
			end
			if info.awardCount > 0 then
				self:checkDiapatchReward()
			end
		else
			foo.Label_time:show()
			foo.Label_time:setText(config.hangupTime..TextDataMgr:getText(213173))
			foo.LoadingBar_time:setPercent(100)
			if DispatchDataMgr:checkEnableDiapatch(self.curSelectTab, config.relatedDungeonLevel) then
				foo.Label_state:setTextById(213120)
			else
				foo.Label_state:setTextById(213122)
			end
		end
	end
end

function DispatchDetailLayer:checkDiapatchReward()
	if DispatchDataMgr:checkHasRewards() then
		if not self.isGetingReward then
			self.isGetingReward = true
			DispatchDataMgr:reqFinishHeroDispatch()
		end
	end
end

function DispatchDetailLayer:addUpdateTimer()
    if not self.updateTimer_ then
        self.updateTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.refreshChaptetItems, self))
    end
end

function DispatchDetailLayer:removeUpdateTimer()
    if self.updateTimer_ then
        TFDirector:removeTimer(self.updateTimer_)
        self.updateTimer_ = nil
    end
end


function DispatchDetailLayer:refreshPanelInfo()
	if not self.curSelectChapter then
		self.Panel_info:hide()
		return
	end
	self.Panel_info:show()
	local config = self.hangUpCfgs[self.curSelectChapter]
	local limitStar = 0
	for k, v in pairs(config.fightingCapacity) do
		if v == 10000 then
			limitStar = tonumber(k)
			break
		end
	end
	for i = 1, 5 do
		self["Image_info_star"..i]:setVisible(i <= limitStar)
	end

	self.Label_desc2:show()
	self.Label_stars:setPositionY(self.infoStarPosy)
	self.Panel_info_star:setPositionY(self.infoStarPosy)
	if self.curSelectTab == EC_DISPATCHType.DAILY then
		local levelCfg = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel)
        local groupId = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel).levelGroupId
		local remainCount = FubenDataMgr:getDailyRemainFightCount(groupId)
		local cost = levelCfg.cost[1]
		self.Label_desc1:setText(TextDataMgr:getText(3004031).."："..remainCount)
		self.Label_desc2:setText(TextDataMgr:getText(213174)..cost[2])
	elseif self.curSelectTab == EC_DISPATCHType.SPRITE then
		local remainCount = FubenDataMgr:getSpriteChallengeRemainCount()
        local levelCfg = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel)
		local cost = levelCfg.cost[1]
		self.Label_desc1:setText(TextDataMgr:getText(3004031).."："..remainCount)
		self.Label_desc2:setText(TextDataMgr:getText(213174)..cost[2])
	elseif self.curSelectTab == EC_DISPATCHType.THEATER then
		local levelCfg = FubenDataMgr:getLevelCfg(config.relatedDungeonLevel)
		local remainCount = GoodsDataMgr:getItemCount(EC_SItemType.THEATER_COUNT)
		local cost = levelCfg.cost[1]
		self.Label_desc1:setText(TextDataMgr:getText(3004031).."："..remainCount)
		self.Label_desc2:hide()
		self.Label_stars:setPositionY(self.Label_desc2:getPositionY())
		self.Panel_info_star:setPositionY(self.Label_desc2:getPositionY())
	elseif self.curSelectTab == EC_DISPATCHType.TEAM then
		local levelCfg = TeamFightDataMgr:getTeamLevelCfg(0,config.relatedDungeonLevel)
		local remainCount = TeamFightDataMgr:getTeamLevelStat()[levelCfg.id].remainCount
        local costNum = 0
        for k,v in pairs(levelCfg.fightCost) do
            costNum = v
        end
		self.Label_desc1:setText(TextDataMgr:getText(2100046).."："..remainCount)
		self.Label_desc2:setText(TextDataMgr:getText(213174)..costNum)
	elseif self.curSelectTab == EC_DISPATCHType.DATING then
		local remainCount = DatingDataMgr:getDayDatingTimes()
		self.Label_desc1:setText(TextDataMgr:getText(3004031).."："..remainCount)
		self.Label_desc2:setText(TextDataMgr:getText(213175).."20")
	end
	self.ScrollView_reward:removeAllItems()
	for i,v in ipairs(config.dropShow) do
		local Panel_goodsItem = self.Panel_goodsItem:clone()
	    PrefabDataMgr:setInfo(Panel_goodsItem, v, -1)
	    self.ScrollView_reward:pushBackCustomItem(Panel_goodsItem)
	end
end

function DispatchDetailLayer:refreshDispatchInfo()
	local effectSuit = DispatchDataMgr:getEffectSuitIds(self.curSelectTab)
	local totalCost = 0
    for k, v in pairs(self.selectChapterIdxs) do
		local cfg = self.hangUpCfgs[tonumber(k)]
		totalCost = totalCost + cfg.consumptionFatigue
	end
	for i,foo in ipairs(self.panel_heros) do
		local heroId = self.addedHeros[i]
		foo.Image_add:stopAllActions()
		foo.Image_add:setScale(1.0)
		if heroId then
			foo.Panel_info:show()
			foo.Image_hero_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
			local stars = DispatchDataMgr:getHeroStars(heroId)
            for j=1,5 do
                local Image_star = TFDirector:getChildByPath(Panel_stars, "Image_star"..i)
                foo["Image_star"..j]:setVisible(j <= stars)
                foo["Image_star"..j]:setPositionX((-58 + (5 - stars) * 9 + j * 18))
            end

            local exhaustion = DispatchDataMgr:getHeroExhaustion(heroId)
            local cfg = TabDataMgr:getData("HeroDispatch",heroId)
            foo.Label_percent:setText(exhaustion.."/"..cfg.restorationCap)
            foo.LoadingBar_progress:setPercent(exhaustion / cfg.restorationCap * 100)
            if exhaustion < totalCost then
	            foo.Label_percent:setColor(ccc3(219,50,50))
	        else
	            foo.Label_percent:setColor(ccc3(255,255,255))
	        end

            local fetterList = DispatchDataMgr:getHeroFetterList(heroId)
            for j = 1, 2 do
            	if fetterList[j] then
            		foo["Image_suit_"..j]:setVisible(true)
            		foo["Image_suit_"..j]:setGrayEnabled(true)
            		for k,suitId in ipairs(effectSuit) do
            			if fetterList[j] == suitId then
            				foo["Image_suit_"..j]:setGrayEnabled(false)
            			end
            		end
            	else
            		foo["Image_suit_"..j]:setVisible(false)
            	end
            end
		else
			foo.Panel_info:hide()
			if #self.hangUpCfgs > 0 then
				local act1 =  CCScaleTo:create(0.8, 1.3)
			    local act2 = CCScaleTo:create(0.8, 1.0)
			    foo.Image_add:runAction(CCRepeatForever:create(CCSequence:create({act1,act2})))
			end
		end
	end

	self:updateDispatchBtnState()
	if #self.hangUpCfgs > 0 then
		local cfg = self.hangUpCfgs[1]
		local addbuff = DispatchDataMgr:getHeroAddBuff(cfg.id, self.addedHeros)
		local buffCount = #effectSuit + (addbuff > 0 and 1 or 0)
		for i = 1, 3 do
			self["Image_buff_bg"..i]:setVisible(i ==2 and addbuff > 0)
			local Label_buff_add = TFDirector:getChildByPath(self["Image_buff_bg"..i], "Label_buff_add")
			if i == 2 then
				Label_buff_add:setText(TextDataMgr:getText(213176)..addbuff.."%")
			end
			-- self["Image_buff_bg"..i]:setPositionY((135 - (3 - buffCount) * 18 - i * 36))
			-- if i == 1 and addbuff > 0 then
			-- 	Label_buff_add:setText("出战收益："..addbuff.."%")
			-- else
			-- 	local suitId = effectSuit[i - 1]
			-- 	local buffCfg = TabDataMgr:getData("HangupBuff",suitId)
			-- 	Label_buff_add:setText("激活羁绊："..TextDataMgr:getText(buffCfg.name))
			-- end
		end
	else
		for i = 1, 3 do
			self["Image_buff_bg"..i]:setVisible(false)
		end
	end
end

function DispatchDetailLayer:onAddDispatchBack()
	self.selectChapterIdxs = {}
	self:refreshContentUI()
end

function DispatchDetailLayer:onCancelDispatchBack()
	self:refreshContentUI()
end

function DispatchDetailLayer:onGetDispatchReward(data)
	self.isGetingReward = false
	self:refreshContentUI()
end

function DispatchDetailLayer:onAddHerosBack()
	self.addedHeros = DispatchDataMgr:getDispathedHeros(self.curSelectTab)
	self:updateDispatchTimesData()
	self:refreshDispatchInfo()
end

function DispatchDetailLayer:removeEvents()
    self:removeUpdateTimer()
end

function DispatchDetailLayer:onShow()
    self.super.onShow(self)
    self:checkDiapatchReward()
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self)
    end,0.05)
end

function DispatchDetailLayer:registerEvents()
    EventMgr:addEventListener(self,EV_FUBEN_ADD_DISPATCH_DANGUP,handler(self.onAddDispatchBack, self))
    EventMgr:addEventListener(self,EV_FUBEN_CANCEL_DISPATCH_DANGUP,handler(self.onCancelDispatchBack, self))
    EventMgr:addEventListener(self,EV_FUBEN_GET_DISPATCH_DANGUP_REWARD,handler(self.onGetDispatchReward, self))
    EventMgr:addEventListener(self,EV_FUBEN_ADD_DISPATCH_HEROS,handler(self.onAddHerosBack, self))
    EventMgr:addEventListener(self,EV_FUBEN_SPEEDUP_DISPATCH,handler(self.onCancelDispatchBack, self))
    

    self.Image_arrow:setTouchEnabled(true)
    self.Image_arrow:onClick(function()
    	local arr = {}
        if self.hidePanelInfoState then
        	self.hidePanelInfoState = false
		    table.insert(arr, CCMoveTo:create(0.3, ccp(0,0)))
		    table.insert(arr,CCCallFuncN:create(function()
		    	self.Image_arrow:setRotation(0)
		    end))
		    self.Panel_info:runAction(CCSequence:create(arr))
        else
        	self.hidePanelInfoState = true
        	table.insert(arr, CCMoveTo:create(0.3, ccp(310,0)))
		    table.insert(arr,CCCallFuncN:create(function()
		    	self.Image_arrow:setRotation(180)
		    end))
		    self.Panel_info:runAction(CCSequence:create(arr))
        end
    end)

    local function onTouchBegan(sender)
        local startPoint = sender:getTouchStartPos()
        local rect = self.Panel_info:boundingBox()
        if me.rectContainsPoint(rect,startPoint) then 
            return false
        end
        return true
    end
    local function onTouchUp(sender)
        local arr = {}
        if not self.hidePanelInfoState then
        	self.hidePanelInfoState = true
        	table.insert(arr, CCMoveTo:create(0.3, ccp(310,0)))
		    table.insert(arr,CCCallFuncN:create(function()
		    	self.Image_arrow:setRotation(180)
		    end))
		    self.Panel_info:runAction(CCSequence:create(arr))
        end
    end
    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)
    self.Panel_touch:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp)

  	for i,v in ipairs(self.tabButtons) do
	    v.tabBtn:onClick(function()
	        self:onTabBtnTouch(v.id)
	    end)
    end

    for i,foo in ipairs(self.panel_heros) do
    	foo.Panel_hero:setTouchEnabled(true)
    	foo.Panel_hero:onClick(function()
	        if #self.hangUpCfgs > 0 then
	        	local cid
	        	local cost = 100000
	        	for k, v in pairs(self.hangUpCfgs) do
	        		local cfg = self.hangUpCfgs[tonumber(k)]
	        		if cfg.consumptionFatigue < cost then
	        			cost = cfg.consumptionFatigue
	        			cid = cfg.id
	        		end
	        	end
	        	Utils:openView("dispatch.DispatchAddHeroLayer",{dungeonType = self.curSelectTab, dungeonCid = cid, heros = self.addedHeros})
	        else
	        	if self.curSelectTab == EC_DISPATCHType.DAILY then
					FunctionDataMgr:jDailyFuben()
				elseif self.curSelectTab == EC_DISPATCHType.SPRITE then
					FunctionDataMgr:jActivityFuben(EC_ActivityFubenType.SPRITE)
				elseif self.curSelectTab == EC_DISPATCHType.THEATER then
					if #self.addedHeros > 0 then
						Utils:openView("dispatch.DispatchAddHeroLayer",{dungeonType = self.curSelectTab, dungeonCid = 391, heros = self.addedHeros})
					else
						FunctionDataMgr:jTheaterBossView()
					end
				elseif self.curSelectTab == EC_DISPATCHType.TEAM then
					FunctionDataMgr:jActivityFuben(EC_ActivityFubenType.TEAM)
				end
	        end
	    end)
    end

    self.Button_goto:onClick(function()
    	if self.curSelectTab == EC_DISPATCHType.DAILY then
			FunctionDataMgr:jDailyFuben()
		elseif self.curSelectTab == EC_DISPATCHType.SPRITE then
			FunctionDataMgr:jActivityFuben(EC_ActivityFubenType.SPRITE)
		elseif self.curSelectTab == EC_DISPATCHType.THEATER then
			FunctionDataMgr:jTheaterBossView()
		elseif self.curSelectTab == EC_DISPATCHType.TEAM then
			FunctionDataMgr:jActivityFuben(EC_ActivityFubenType.TEAM)
		end
    end)

    self.Button_dispatch:onClick(function()
    	if self.dispatchData then
    		-- local function callback()
	    	-- 	DispatchDataMgr:reqCancelHeroDispatch(self.curSelectTab)
	    	-- end
	    	-- if MainPlayer:getOneLoginStatus("GUAJIQUXIAO") then
	    	-- 	callback()
	    	-- else
	    	-- 	local content = TextDataMgr:getText(213188)
	    	-- 	Utils:openView("common.ReConfirmTipsView", {tittle = 213190, content = content, reType = "GUAJIQUXIAO", confirmCall = callback})
	    	-- end
    		
    		return
    	end
    	if self.curSelectTab == EC_DISPATCHType.DAILY and table.count(self.selectChapterIdxs) < 1 then
    		return
    	end
    	local cids = {}
    	local times = {}
    	for k, v in pairs(self.selectChapterIdxs) do
    		if self.realTimes[tonumber(k)] > 0 then
    			local cfg = self.hangUpCfgs[tonumber(k)]
    			table.insert(cids, cfg.id)
    			table.insert(times, self.realTimes[tonumber(k)])
    		end
    	end
    	DispatchDataMgr:reqAddHeroDispatch(self.curSelectTab, cids, times)
    end)

    self.Button_times_down:onClick(function()
    	self.selectTimes = math.max(1, (self.selectTimes - 1))
    	self:updateDispatchTimesUI()
    end)

    self.Button_times_up:onClick(function()
    	local times = self.selectTimes + 1
    	if times > self.maxTimes then
    		Utils:showTips(63697)
    		return
    	end
    	self.selectTimes = math.min(self.maxTimes, (times))
    	self:updateDispatchTimesUI()
    end)
end


--引导点击左边栏
function DispatchDetailLayer:excuteGuideFunc20004(guideFuncId)
    local targetNode = self.ScrollView_tab
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 0))
end

--引导点击关卡
function DispatchDetailLayer:excuteGuideFunc20002(guideFuncId)
    local targetNode = self.chapter_items[1].Panel_item_ui
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 0))
end

--引导点击精灵位置
function DispatchDetailLayer:excuteGuideFunc20003(guideFuncId)
    local targetNode = self.panel_heros[1].Panel_hero
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 0))
end

return DispatchDetailLayer
