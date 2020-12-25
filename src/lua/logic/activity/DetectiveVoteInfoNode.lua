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

local DetectiveVoteInfoNode = class("DetectiveVoteInfoNode",BaseLayer)

function DetectiveVoteInfoNode:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:initData()
	self:init("lua.uiconfig.activity.detectiveVoteInfoNode")
end

function DetectiveVoteInfoNode:initData(  )
	-- body
	self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DETECTIVE_VOTE)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function DetectiveVoteInfoNode:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Panel_baseVote = TFDirector:getChildByPath(ui,"Panel_baseVote")
	self.Panel_voteContent = TFDirector:getChildByPath(self.Panel_baseVote,"Panel_voteContent")
	self.Panel_specialVote = TFDirector:getChildByPath(ui,"Panel_specialVote")


	self.specialVoteItems = {}

	for i = 1,7 do
		self.specialVoteItems[i] = TFDirector:getChildByPath(self.Panel_specialVote,"Panel_specialVoteItem"..i)
	end
	
	self.Panel_voteItem = TFDirector:getChildByPath(ui,"Panel_voteItem")
	self:updateView()
	self:setContentSize(self.ui:getContentSize())
	DetectiveDataMgr:Req_DetectiveVoteResult()
end

function DetectiveVoteInfoNode:updateView( ... )
	-- body
	local serverTime = ServerDataMgr:getServerTime()*1000
	for k,v in ipairs(self.activityInfo.extendData.voteIds) do
		local voteCfg = TabDataMgr:getData("DetectiveVote",v)
		if voteCfg.beginTime <= serverTime and voteCfg.endTime > serverTime then
			self.voteCfg = voteCfg
			self.curDay = k
		end
	end
	local showSpecialPanel = false
	local spcialVoteCfg = TabDataMgr:getData("DetectiveVote",self.activityInfo.extendData.specialVoteId)
	if spcialVoteCfg.beginTime <= serverTime then
		self.voteCfg = spcialVoteCfg
		showSpecialPanel = true

		self.curDay = #self.activityInfo.extendData.voteIds + 1
		self.curSpDay = self.curSpDay or 1
	end


	self.Panel_baseVote:setVisible(not showSpecialPanel)
	self.Panel_specialVote:setVisible(showSpecialPanel)

	if showSpecialPanel then
		self.Label_title = TFDirector:getChildByPath(self.Panel_specialVote,"Label_title")
		self.Label_title:setTextById(13316320 + self.curDay)
		self:updateSpecialVote()
	else
		self.Label_title = TFDirector:getChildByPath(self.Panel_baseVote,"Label_title")
		self.Label_title:setTextById(13316320 + self.curDay)
		self:updateBaseVote()
	end
end

function DetectiveVoteInfoNode:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	
	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_VOTE_RESULT, handler(self.updateView, self))
	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_VOTE_RECORD, handler(self.updateView, self))

	self.ui:setTouchEnabled(true)
	self.ui:onClick(function ( ... )
		FunctionDataMgr:jActivity(self.activityId)
	end)
end

function DetectiveVoteInfoNode:updateBaseVote( ... )
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

end

function DetectiveVoteInfoNode:updateBaseVoteItem( item, roleId )
	-- body
	local Panel_sel = TFDirector:getChildByPath(item, "Panel_sel")
	local Panel_nor = TFDirector:getChildByPath(item, "Panel_nor")

	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.curDay, false)
	local isSelected = curDayRecord == roleId or self.selectRole == roleId

	Panel_sel:setVisible(isSelected)
	Panel_nor:setVisible(not isSelected)
	local showNode = isSelected and Panel_sel or Panel_nor

	local poll = DetectiveDataMgr:getPoll(self.curDay, roleId)
	local maxPoll = DetectiveDataMgr:getMaxPoll(self.curDay)

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
		Button_select:setTouchEnabled(false)
		Button_select:setVisible(table.find(self.voteCfg.spirit,roleId) ~= -1)
	end

	if Image_death then
		Image_death:setVisible(table.find(self.voteCfg.spirit,roleId) == -1)
	end
end

function DetectiveVoteInfoNode:updateSpecialVote( ... )
	-- body
	for k,v in ipairs(self.voteCfg.spirit) do
		self:updateSpecialVoteItem(self.specialVoteItems[k],v)
	end
end

function DetectiveVoteInfoNode:updateSpecialVoteItem( item, roleId )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")
	local Image_real = TFDirector:getChildByPath(item,"Image_real")
	local Label_suc = TFDirector:getChildByPath(item,"Label_suc")
	local Image_gou = TFDirector:getChildByPath(item,"Image_gou")
	local Panel_qiPao = TFDirector:getChildByPath(item,"Panel_qiPao")
	local Label_text = TFDirector:getChildByPath(Panel_qiPao,"Label_text")

	local curDayRecord = DetectiveDataMgr:getVoteRecord(self.curDay, false)
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

end

return DetectiveVoteInfoNode