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

local DetectiveVoteInfo = class("DetectiveVoteInfo",BaseLayer)

function DetectiveVoteInfo:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self:initData()
	self:init("lua.uiconfig.activity.detectiveVoteInfo")
end

function DetectiveVoteInfo:initData(  )
	-- body
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function DetectiveVoteInfo:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")

	self.Panel_baseVote = TFDirector:getChildByPath(ui,"Panel_baseVote")
	self.Panel_voteContent = TFDirector:getChildByPath(self.Panel_baseVote,"Panel_voteContent")
	self.Panel_specialVote = TFDirector:getChildByPath(ui,"Panel_specialVote")

	self.Button_action = TFDirector:getChildByPath(self.Panel_baseVote,"Button_action")
	self.Image_costIcon = TFDirector:getChildByPath(self.Panel_baseVote,"Image_costIcon")
	self.Label_costNum = TFDirector:getChildByPath(self.Panel_baseVote,"Label_costNum")
	self.Image_chapterTitle = TFDirector:getChildByPath(self.Panel_baseVote,"Image_chapterTitle")
	self.Label_date = TFDirector:getChildByPath(self.Panel_baseVote,"Label_date")

	self.scrollView_base_reward = TFDirector:getChildByPath(self.Panel_baseVote,"ScrollView_reward")

	local ScrollView_titles = TFDirector:getChildByPath(self.Panel_baseVote,"ScrollView_titles")
	self.uiList_titles = UIListView:create(ScrollView_titles)

	self.Label_title = TFDirector:getChildByPath(self.Panel_specialVote,"Label_title")
	self.Label_title1 = TFDirector:getChildByPath(self.Panel_specialVote,"Label_title1")
	self.spButton_left = TFDirector:getChildByPath(self.Panel_specialVote,"Button_left")
	self.spButton_right = TFDirector:getChildByPath(self.Panel_specialVote,"Button_right")
	local ScrollView_histroy = TFDirector:getChildByPath(self.Panel_specialVote,"ScrollView_histroy")
	self.uiList_histroy = UIListView:create(ScrollView_histroy)

	self.Label_sp_date = TFDirector:getChildByPath(self.Panel_specialVote,"Label_date")
	self.Label_timing = TFDirector:getChildByPath(self.Panel_specialVote,"Label_timing")
	self.Button_specialAction = TFDirector:getChildByPath(self.Panel_specialVote,"Button_specialAction")

	self.scrollView_sp_reward1 = TFDirector:getChildByPath(self.Panel_specialVote,"ScrollView_reward1")
	self.scrollView_sp_reward2 = TFDirector:getChildByPath(self.Panel_specialVote,"ScrollView_reward2")

	self.specialVoteItems = {}

	for i = 1,7 do
		self.specialVoteItems[i] = TFDirector:getChildByPath(self.Panel_specialVote,"Panel_specialVoteItem"..i)
	end
	
	self.Panel_voteItem = TFDirector:getChildByPath(ui,"Panel_voteItem")
	self.Panel_historyVoteItem = TFDirector:getChildByPath(ui,"Panel_historyVoteItem")
	self.Panel_titleItem = TFDirector:getChildByPath(ui,"Panel_titleItem")

	self.Label_date:setText(self.activityInfo.extendData.normalTime)
	self.Label_sp_date:setText(self.activityInfo.extendData.specialTime)
	self:updateView()

	DetectiveDataMgr:Req_DetectiveVoteResult()
end

function DetectiveVoteInfo:updateView( ... )
	-- body
	local serverTime = ServerDataMgr:getServerTime()*1000

	self.showSpecialPanel = self.showSpecialPanel or false
	if not self.curDay then
		for k,v in ipairs(self.activityInfo.extendData.voteIds) do
			local voteCfg = TabDataMgr:getData("DetectiveVote",v)
			local checkCodition = true
			if voteCfg.condition ~= 0 then
				local chapterInfo = DetectiveDataMgr:getChapterInfo(voteCfg.condition)
				if not chapterInfo or not chapterInfo.first then
					-- 条件未达成
					checkCodition = false
				end
			end

			if k == 1 or checkCodition then
				self.voteCfg = voteCfg
				self.curDay = k
			end
		end
		local spcialVoteCfg = TabDataMgr:getData("DetectiveVote",self.activityInfo.extendData.specialVoteId)

		if spcialVoteCfg.beginTime <= serverTime then
			self.voteCfg = spcialVoteCfg
			self.showSpecialPanel = true

			self.curDay = #self.activityInfo.extendData.voteIds + 1
			self.curSpDay = self.curSpDay or 1
		end
	end

	self.Panel_baseVote:setVisible(not self.showSpecialPanel)
	self.Panel_specialVote:setVisible(self.showSpecialPanel)

	if self.showSpecialPanel then
		self:updateSpecialVote()
		self:updateHistroyList()
	else
		self:updateBaseVote()
		self:updateTitlesList()
	end
end

function DetectiveVoteInfo:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_VOTE_RESULT, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_VOTE_RECORD, handler(self.updateView, self))

	self.spButton_right:onClick(function ( ... )
		-- body
		self.curSpDay = math.min(self.curSpDay + 1, #self.activityInfo.extendData.voteIds)
		self:updateHistroyList()
	end)

	self.spButton_left:onClick(function ( ... )
		-- body
		self.curSpDay = math.max(self.curSpDay - 1, 1)
		self:updateHistroyList()
	end)

	self.Button_action:onClick(function ( ... )
		-- body
		if not self.selectRole then 
			Utils:showTips(13316010)
			return 
		end
		
		local costId = next(self.voteCfg.cost)
		if costId and GoodsDataMgr:getItemCount(costId) < 1 then
			Utils:showTips(13316009)
			return
		end

		DetectiveDataMgr:Req_DetectiveSuspectVote(self.voteCfg.id, self.selectRole)
		self.selectRole = nil
	end)

	self.Button_specialAction:onClick(function ( ... )
		
		if ServerDataMgr:getServerTime()*1000 > self.voteCfg.endTime then
			Utils:showTips(13316012)
			return
		end

		if not self.selectRole then 
			Utils:showTips(13316010)
			return 
		end
		local costId = next(self.voteCfg.cost)
		if costId and GoodsDataMgr:getItemCount(costId) < 1 then
			Utils:showTips(13316009)
			return
		end

		DetectiveDataMgr:Req_DetectiveSuspectVote(self.voteCfg.id,self.selectRole)
		self.selectRole = nil
	end)
end


function DetectiveVoteInfo:updateTitlesList(  )
	-- body
	for i = 1,#self.activityInfo.extendData.voteIds do
		local item = self.uiList_titles:getItem(i)
		if not item then
			item = self.Panel_titleItem:clone()
			self.uiList_titles:pushBackCustomItem(item)
		end
		self:updateTitleItem(item, i)
	end
end

function DetectiveVoteInfo:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function DetectiveVoteInfo:updateCountDonw( ... )
	-- body
	if ServerDataMgr:getServerTime()*1000 > self.voteCfg.endTime then
		self.Label_title:setTextById(13316024)
		local curDayRecord = DetectiveDataMgr:getVoteRecord(self.curDay,false)
		if curDayRecord then
			local roleCfg = TabDataMgr:getData("DetectiveArchives",curDayRecord)
			self.Label_timing:setTextById(13316025,roleCfg.name)
		else
			self.Label_timing:setTextById(13316026)
		end
		return
	end
	self.Label_title:setTextById(13316022)
	self.Label_timing:setTextById(13316023,Utils:getTimeCountDownString(self.voteCfg.endTime/1000,2))
end

function DetectiveVoteInfo:updateTitleItem( item , index )
	-- body
	local Button_normal = TFDirector:getChildByPath(item,"Button_normal")
	local Imange_sel = TFDirector:getChildByPath(item,"Imange_sel")

	local Label_title = TFDirector:getChildByPath(Button_normal,"Label_title")
	Label_title:setText(index)
	
	Label_title = TFDirector:getChildByPath(Imange_sel,"Label_title")
	Label_title:setText(index)

	Button_normal:setVisible(index ~= self.curDay)
	Imange_sel:setVisible(index == self.curDay)

	Button_normal:onClick(function ( ... )
		local voteCfg = TabDataMgr:getData("DetectiveVote",self.activityInfo.extendData.voteIds[index])

		if voteCfg.condition ~= 0 then
			local chapterInfo = DetectiveDataMgr:getChapterInfo(voteCfg.condition)
			if chapterInfo and not chapterInfo.first then
				-- 条件未达成
				Utils:showTips(13316017)
				return
			end
		end

		if self.curDay == index then return end
		self.curDay = index
		self.selectRole = nil
		self.voteCfg = voteCfg
		self:updateTitlesList()
		self:updateBaseVote()
	end)

end

function DetectiveVoteInfo:updateBaseVote( ... )
	-- body
	self.baseVoteItems = self.baseVoteItems or {}
	local roleIds = self.activityInfo.extendData.roleIds
	local offset = self.Panel_voteContent:getContentSize().width/#roleIds

	for k,v in ipairs(roleIds) do
		if not self.baseVoteItems[k] then
			self.baseVoteItems[k] = self.Panel_voteItem:clone()
			self.baseVoteItems[k]:setPosition(ccp((k-1)*offset, 0))
			self.Panel_voteContent:addChild(self.baseVoteItems[k])
		end

		self:updateBaseVoteItem(self.baseVoteItems[k], v)
	end

	local costId, costNum = next(self.voteCfg.cost)

	-- self.Image_costIcon:setVisible(costId)
	self.Label_costNum:setVisible(costId)
	if costId then
		self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(tonumber(costId)).icon)
		self.Label_costNum:setText(GoodsDataMgr:getItemCount(tonumber(costId)))
	end
	Utils:createRewardListHor(self.scrollView_base_reward,self.voteCfg.voteRward)

	local chapterCfg = TabDataMgr:getData("DetectiveMgr",self.activityInfo.extendData.chapterId[self.curDay])
	self.Image_chapterTitle:setTexture(chapterCfg.picture)
	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.voteCfg.id, false)
	self.Button_action:setVisible(not curDayRecord)
end

function DetectiveVoteInfo:updateBaseVoteItem( item, roleId )
	-- body
	local Panel_sel = TFDirector:getChildByPath(item, "Panel_sel")
	local Panel_nor = TFDirector:getChildByPath(item, "Panel_nor")

	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.voteCfg.id, false)
	local isSelected = curDayRecord == roleId or self.selectRole == roleId

	Panel_sel:setVisible(isSelected)
	Panel_nor:setVisible(not isSelected)
	local showNode = isSelected and Panel_sel or Panel_nor

	local poll = DetectiveDataMgr:getPoll(self.voteCfg.id, roleId)
	local maxPoll = DetectiveDataMgr:getMaxPoll(self.voteCfg.id)

	local Image_icon = TFDirector:getChildByPath(showNode, "Image_icon")
	local Label_poll = TFDirector:getChildByPath(showNode, "Label_poll")
	local Button_select = TFDirector:getChildByPath(showNode, "Button_select")
	local Label_name = TFDirector:getChildByPath(showNode, "Label_name")
	local Image_death = TFDirector:getChildByPath(showNode, "Image_death")

	local LoadingBar_poll = TFDirector:getChildByPath(item, "LoadingBar_poll")
	local roleCfg = TabDataMgr:getData("DetectiveArchives",roleId)

	Label_name:setText(roleCfg.name)
	Image_icon:setTexture(roleCfg.longIcon)
	Label_poll:setTextById(13316003,poll)
	LoadingBar_poll:setPercent(poll*100/maxPoll)

	if Button_select then
		Button_select:setTouchEnabled(not curDayRecord)
		Button_select:setVisible(table.find(self.voteCfg.spirit,roleId) ~= -1)

		Button_select:onClick(function ( ... )
			-- body
			if self.selectRole == roleId then
				self.selectRole = nil
			else
				self.selectRole = roleId
			end
			self:updateBaseVote()
		end)
	end

	if Image_death then
		Image_death:setVisible(table.find(self.voteCfg.spirit,roleId) == -1)
	end
	
	Image_icon:setGrayEnabled(table.find(self.voteCfg.spirit,roleId) == -1)
end

function DetectiveVoteInfo:updateSpecialVote( ... )
	-- body
	for k,v in ipairs(self.voteCfg.spirit) do
		self:updateSpecialVoteItem(self.specialVoteItems[k],v)
	end

	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.voteCfg.id, false)
	self.Button_specialAction:setVisible(not curDayRecord)
	Utils:createRewardListHor(self.scrollView_sp_reward2,self.activityInfo.extendData.rightReward)
	Utils:createRewardListHor(self.scrollView_sp_reward1,self.activityInfo.extendData.serverReward)
end

function DetectiveVoteInfo:updateSpecialVoteItem( item, roleId )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Image_real = TFDirector:getChildByPath(item,"Image_real")
	local Label_suc = TFDirector:getChildByPath(item,"Label_suc")
	local Image_gou = TFDirector:getChildByPath(item,"Image_gou")
	local Panel_qiPao = TFDirector:getChildByPath(item,"Panel_qiPao")
	local Label_text = TFDirector:getChildByPath(Panel_qiPao,"Label_text")

	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.voteCfg.id, false)
	local poll = DetectiveDataMgr:getPoll(self.curDay, roleId)
	local maxPoll = DetectiveDataMgr:getMaxPoll(self.curDay)

	local roleCfg = TabDataMgr:getData("DetectiveArchives",roleId)
	Image_icon:setTexture(string.sub(roleCfg.icon,0,-5).."_1.png")
	Image_select:setVisible(curDayRecord == roleId or self.selectRole == roleId)
	Label_suc:setVisible(curDayRecord == roleId)

	local isAnswer =false

	local chapterInfo = DetectiveDataMgr:getChapterInfo(self.activityInfo.extendData.showChapterID)
	if self.activityInfo.extendData.answer == roleId and chapterInfo and chapterInfo.first then
		isAnswer = true
	end
	Image_real:setVisible(isAnswer)

	Image_gou:setVisible(not Image_select:isVisible())

	Label_text:setTextById(roleCfg.word)
	Image_icon:setTouchEnabled(not curDayRecord)
	Image_icon:onClick(function ( ... )
		-- body
		if self.selectRole == roleId then
			self.selectRole = nil
		else
			self:playQiPaoAni(Panel_qiPao)
			self.selectRole = roleId
		end
		self:updateSpecialVote()
	end)

	if self.selectRole ~= roleId and Panel_qiPao:isVisible() then
		Panel_qiPao:hide()
	end
end

function DetectiveVoteInfo:playQiPaoAni( qiPao )
	-- body
	if not qiPao then return end
	qiPao:stopAllActions()
	qiPao:show()
	local arr ={
        CCDelayTime:create(2),
        FadeOut:create(0.3),
        CallFunc:create(function ( ... )
        	-- body
        	qiPao:hide()
        	qiPao:setOpacity(255)
        end)
	}
	qiPao:runAction(CCSequence:create(arr))
end

function DetectiveVoteInfo:updateHistroyList( ... )
	-- body
	local roleIds = self.activityInfo.extendData.roleIds

	table.sort(roleIds,function ( role1, role2)
		-- body
		local poll1 = DetectiveDataMgr:getPoll(self.activityInfo.extendData.voteIds[self.curSpDay],role1)
		local poll2 = DetectiveDataMgr:getPoll(self.activityInfo.extendData.voteIds[self.curSpDay],role2)

		if poll1 == poll2 then 
			return role1 < role2 
		else
			return poll1 > poll2
		end
	end)

	for k,v in ipairs(roleIds) do
		local item = self.uiList_histroy:getItem(k)
		if not item then
			item = self.Panel_historyVoteItem:clone()
			self.uiList_histroy:pushBackCustomItem(item)
		end
		self:updateHistroyVoteItem(item,v)
	end
	local dayID = 13316100 + self.curSpDay
	self.Label_title1:setTextById(dayID)
end

function DetectiveVoteInfo:updateHistroyVoteItem( item, roleId )
	-- body
	local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
	local Label_poll = TFDirector:getChildByPath(item, "Label_poll")
	local LoadingBar_poll = TFDirector:getChildByPath(item, "LoadingBar_poll")

	local roleCfg = TabDataMgr:getData("DetectiveArchives",roleId)
	local voteId = self.activityInfo.extendData.voteIds[self.curSpDay]
	local poll = DetectiveDataMgr:getPoll(voteId, roleId)
	local maxPoll = DetectiveDataMgr:getMaxPoll(voteId)

	local curDayRecord = DetectiveDataMgr:getVoteRecord(voteId, false)

	Image_icon:setTexture(roleCfg.icon)
	Label_poll:setTextById(13316003,poll)
	LoadingBar_poll:setPercent(poll*100/maxPoll)

end

return DetectiveVoteInfo