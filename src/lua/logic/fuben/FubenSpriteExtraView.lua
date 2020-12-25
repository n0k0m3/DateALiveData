local FubenSpriteExtraView = class("FubenSpriteExtraView",BaseLayer)

function FubenSpriteExtraView:initData(chapterCid,herocfg)
	self.chapterCid_ = chapterCid
	self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)
    self.curPageNum = 0
    if herocfg then
    	self.herocfg_ = herocfg
    	self.curPageNum = herocfg.group - 1
    end
    self.curLevelIdx = 1
end

function FubenSpriteExtraView:getClosingStateParams()
    return {self.chapterCid_, self.herocfg_}
end

function FubenSpriteExtraView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.fuben.fubenSpriteExtraView")
end

function FubenSpriteExtraView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = ui:getChildByName("Panel_root")
	self.page_view = TFDirector:getChildByPath(self.root_panel,"PageView_levelgroup")
	self.page_prev_btn = TFDirector:getChildByPath(self.root_panel,"Button_page_prev")
	self.page_next_btn = TFDirector:getChildByPath(self.root_panel,"Button_page_next")
	self.page_model = TFDirector:getChildByPath(self.root_panel,"Panel_page")
	local detail_panel = TFDirector:getChildByPath(self.root_panel,"Panel_leveldetail")
	self.txt_desc_title = TFDirector:getChildByPath(detail_panel,"Label_desc_title")
	self.txt_story_title = TFDirector:getChildByPath(detail_panel,"Label_story_title")
	self.txt_desc = TFDirector:getChildByPath(detail_panel,"TextArea_sprite_desc")
	self.txt_limit = TFDirector:getChildByPath(detail_panel,"Label_limit")
	self.txt_limit_val = TFDirector:getChildByPath(detail_panel,"Label_limit_val")
	self.txt_reward = TFDirector:getChildByPath(detail_panel,"Label_reward")
	local scroll_reward = TFDirector:getChildByPath(detail_panel,"ScrollView_reward")
	self.listview_reward = UIListView:create(scroll_reward)
	self.ready_btn = TFDirector:getChildByPath(detail_panel,"Button_ready")
	self.Button_newPlayer = TFDirector:getChildByPath(self.root_panel, "Button_newPlayer")
end

function FubenSpriteExtraView:onShow()
	self.super.onShow(self)
	self:refreshUI()
	local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
	local newbleCfg = TabDataMgr:getData("NewbleAdd")
    local number = newbleCfg[311].number
	local isShow = #activitys >= 1 and #number > 0;
    self.Button_newPlayer:setVisible(isShow);
    
    if self.Button_newPlayer:isVisible() then
    	self.Button_newPlayer:setVisible(true)
    	self.Button_newPlayer:setTouchEnabled(false)
    	self.Label_newPlayerNumExp = TFDirector:getChildByPath(self.root_panel, "Label_newPlayerNumExp")
    	self.Label_newPlayerNumCoin = TFDirector:getChildByPath(self.root_panel, "Label_newPlayerNumCoin")
        local newbleCfg = TabDataMgr:getData("NewbleAdd")
        local number = newbleCfg[311].number
        if number[1] then
            self.Label_newPlayerNumExp:setText(number[1] .. "%")
        end
        if number[2] then
            self.Label_newPlayerNumCoin:setText(number[2] .. "%")
        end
        self.Image_newPlayerEXP = TFDirector:getChildByPath(self.root_panel, "Image_newPlayerEXP")
        self.Image_newPlayerCoin = TFDirector:getChildByPath(self.root_panel, "Image_newPlayerCoin")

        self.Image_newPlayerEXP:setVisible(number[1])
        self.Image_newPlayerCoin:setVisible(number[2])
        self.Label_newPlayerNumExp:setVisible(number[1])
        self.Label_newPlayerNumCoin:setVisible(number[2])
    end
end

function FubenSpriteExtraView:refreshUI()
	self.active_group = FubenDataMgr:getSpriteExtraActiveGroups()
	local pageNum = #self.active_group.orderedkey
	if pageNum < 2 then
		self.page_prev_btn:setVisible(false)
		self.page_next_btn:setVisible(false)
	else
		self.page_prev_btn:setVisible(true)
		self.page_next_btn:setVisible(true)
	end
	local curpageCount = self.page_view:getPageCount()
	local diffnum = pageNum - curpageCount
	if diffnum > 0 then
		for i = 1,diffnum do
			self.page_view:addPage(self.page_model:clone())
		end
	end
	if diffnum < 0 then
		for i = 1, math.abs(diffnum) do
			self.page_view:removePageAtIndex(curpageCount - i)
		end
	end
	self:updatePageView()
    local curPageCount = self.page_view:getPageCount()
    for i = curPageCount,1,-1 do
        local page = self.page_view:getPage(i-1)
        for i = 3,1,-1 do
            local levelitem = page:getChildByName("Panel_level_"..i)
		    if levelitem.isUnlock == true then
			    self:onSelectLevel(levelitem,levelitem.levelCfg,levelitem.levelInfo,levelitem.passed)
			    return
		    end
	    end
    end

end

function FubenSpriteExtraView:updatePageView()
	local tmmaxPassGroup = 0
	local tmmaxPassLevelIdx = 0
	for i,v in ipairs(self.active_group.orderedkey) do
		local groupinfo = self.active_group.groupData[v]
		local tmpage = self.page_view:getPage(tonumber(i)-1)
		tmpage:setVisible(true)
		tmpage:getChildByName("Button_fairyStrategy"):onClick(function()
			for showid,q in pairs(EC_ExperientialHeros) do
				if q.group == v then
					Utils:openView("fairyNew.FairyStrategyView",showid)
					break
				end
			end
			
		end)
		for s,t in ipairs(groupinfo.levels) do
			local levelInfo = FubenDataMgr:getSpriteExtraLevelInfo(t.id)
			if levelInfo.win == true then
				tmmaxPassLevelIdx = s
				if s == #groupinfo then
					tmmaxPassGroup = i
				end
			end
			local levelitem = tmpage:getChildByName("Panel_level_"..s)
			levelitem.levelCfg = t
			levelitem.passed = levelInfo.win or false
			levelitem.levelInfo = levelInfo
			local isUnlock = ((i == tmmaxPassGroup + 1 and s == tmmaxPassLevelIdx + 1) or  levelInfo.win == true)
			levelitem:getChildByName("Image_unlock"):setVisible(isUnlock)
			levelitem.isUnlock = isUnlock
			levelitem:getChildByName("Image_lock"):setVisible(not isUnlock)
			levelitem:getChildByName("Image_logo"):setTexture(string.format("ui/fuben/experience/level%d_%d.png",v,s))
			levelitem:getChildByName("Image_sel"):getChildByName("Label_level_num"):setString(string.format("%d-%d",v,s))
			levelitem:getChildByName("Image_sel"):setVisible(false)
			levelitem:getChildByName("Image_logo"):onClick(function()
				self:onSelectLevel(levelitem,levelitem.levelCfg,levelitem.levelInfo,levelitem.passed)
			end)
			levelitem:getChildByName("Image_logo"):setTouchEnabled(levelitem.isUnlock)
			levelitem:setVisible(true)
		end
	end
	self.maxPassGroup = tmmaxPassGroup
	self.maxPassLevelIdx = tmmaxPassLevelIdx
end


function FubenSpriteExtraView:updateLevelDetail()
    self.txt_desc_title:setTextById(self.curSelLevelCfg.title)
    self.txt_desc:setTextById(self.curSelLevelCfg.desc)
    local dungeonlevelCfg = FubenDataMgr:getLevelCfg(self.curSelLevelCfg.id)

    local dropCid, showReward, isFirstPass
    if self.curSelLevelPassed == true then
        dropCid = dungeonlevelCfg.reward
        showReward = dungeonlevelCfg.dropShow
        isFirstPass = false
    else
        dropCid = dungeonlevelCfg.firstReward
        showReward = dungeonlevelCfg.firstDropShow
        isFirstPass = true
    end
    self.listview_reward:removeAllItems()
    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(dropCid)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    -- 基础掉落
    for i, v in ipairs(showReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
        local flag = 0
        local arg = {}
        local multiple = multipleReward[v]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if allMultiple > 0 then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = allMultiple
        end
        if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        end

        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
        self.listview_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end


    local usedCount = self.curSelLevelInfo.fightCount or 0
    local hasFightCount = dungeonlevelCfg.fightCount - usedCount
    self.txt_limit_val:setString(tostring(hasFightCount))
    self.curHasFightCount = hasFightCount
end

function FubenSpriteExtraView:registerEvents()
	EventMgr:addEventListener(self, EV_FUBEN_SPRITE_EXTRA_UPDATE_INFO, handler(self.refreshUI, self))
	self.ready_btn:onClick(function( ... )
		if self.curHasFightCount > 0 then
			FubenDataMgr:setSpriteExtraSelLevel(self.curSelLevelCfg.id)
            Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_)
		else
			Utils:showError(100000061)
		end
	end)

	self.page_next_btn:onClick(function( ... )
		local curPageCount = self.page_view:getPageCount()
		local tmpageNum = self.curPageNum + 1
		if tmpageNum >= curPageCount then
			return
		end
		local page = self.page_view:getPage(tmpageNum)
		for i = 3,1,-1 do
			if page:getChildByName("Panel_level_"..i).isUnlock == true then
				self.page_view:scrollToPage(tmpageNum)
				return
			end
		end

	end)

	self.page_prev_btn:onClick(function( ... )
		local curPageCount = self.page_view:getPageCount()
		local tmpageNum = self.curPageNum - 1
		if tmpageNum < 0 then
			return
		end
		local page = self.page_view:getPage(tmpageNum)
		for i = 3,1,-1 do
			if page:getChildByName("Panel_level_"..i).isUnlock == true then
				self.page_view:scrollToPage(tmpageNum)
				return
			end
		end
	end)
	self.page_view:addMEListener(TFPAGEVIEW_CHANGED,function()
        self.curPageNum = self.page_view:getCurPageIndex()
        local page = self.page_view:getPage(self.curPageNum)
        for i = 3,1,-1 do
        	local levelitem = page:getChildByName("Panel_level_"..i)
			if levelitem.isUnlock == true then
				self:onSelectLevel(levelitem,levelitem.levelCfg,levelitem.levelInfo,levelitem.passed)
				return
			end
		end
    end)
end

function FubenSpriteExtraView:onSelectLevel(levelitem,levelCfg,levelInfo,isPass)
	if self.curSelLevelItem then
		self.curSelLevelItem:getChildByName("Image_sel"):setVisible(false)
	end
	self.curSelLevelItem = levelitem
	self.curSelLevelItem:getChildByName("Image_sel"):setVisible(true)
	if levelCfg == self.curSelLevelCfg and isPass == self.curSelLevelPassed and levelInfo == self.curSelLevelInfo then
		return
	end
	self.curSelLevelCfg = levelCfg
	self.curSelLevelPassed = isPass
	self.curSelLevelInfo = levelInfo
	self:updateLevelDetail()
end



return FubenSpriteExtraView
