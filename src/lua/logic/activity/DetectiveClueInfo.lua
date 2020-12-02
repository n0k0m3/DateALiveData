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

local DetectiveClueInfo = class("DetectiveClueInfo",BaseLayer)


function DetectiveClueInfo:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self:initData()
	self:init("lua.uiconfig.activity.detectiveClueInfo")
end

function DetectiveClueInfo:initData(  )
	-- body
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    if not self.curDay then
		for k,v in ipairs(self.activityInfo.extendData.clueIds) do
			local voteCfg = TabDataMgr:getData("DetectiveClue",v)
			local checkCodition = true
			if voteCfg.condition ~= 0 then
				local chapterInfo = DetectiveDataMgr:getChapterInfo(voteCfg.condition)
				if not chapterInfo or not chapterInfo.first then
					-- 条件未达成
					checkCodition = false
				end
			end

			if k == 1 or checkCodition then
				self.curDay = k
			end
		end
	end
end

function DetectiveClueInfo:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Label_date = TFDirector:getChildByPath(ui,"Label_date")
	self.Image_chapterTitle = TFDirector:getChildByPath(ui,"Image_chapterTitle")

	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Panel_clueList = TFDirector:getChildByPath(ui,"Panel_clueList")
	self.Panel_detail = TFDirector:getChildByPath(ui,"Panel_detail")

	self.Button_action = TFDirector:getChildByPath(self.Panel_clueList,"Button_action")
	self.Image_costIcon = TFDirector:getChildByPath(self.Panel_clueList,"Image_costIcon")
	self.Label_costNum = TFDirector:getChildByPath(self.Panel_clueList,"Label_costNum")
	local ScrollView_clue = TFDirector:getChildByPath(self.Panel_clueList,"ScrollView_clue")
	self.uiList_clue = UIListView:create(ScrollView_clue)


	local ScrollView_titles = TFDirector:getChildByPath(ui,"ScrollView_titles")
	self.uiList_titles = UIListView:create(ScrollView_titles)

	self.Panel_selectItem = TFDirector:getChildByPath(self.Panel_detail,"Panel_selectItem")
	self.Image_icon = TFDirector:getChildByPath(self.Panel_detail,"Image_icon1")
	self.Label_clueDetails = TFDirector:getChildByPath(self.Panel_detail,"Label_clueDetails")
	self.Button_close = TFDirector:getChildByPath(self.Panel_detail,"Button_close")

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_titleItem = TFDirector:getChildByPath(ui,"Panel_titleItem")
	self:updateTitlesList()
	self:updateDayInfo(true)

	self.Label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime , self.activityInfo.endTime))
end

function DetectiveClueInfo:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_VOTE_RECORD, function ( ... )
		-- body
		self:updateDayInfo(true)
	end)
	self.Button_close:onClick(function ( ... )
		-- body
		self.Panel_detail:hide()
		self.Panel_clueList:show()
	end)

	self.Button_action:onClick(function ( ... )
		-- body
		if not self.selectIndex then
			Utils:showTips(13316008)
			return 
		end

		if GoodsDataMgr:getItemCount(self.activityInfo.extendData.costId) < 1 then
			Utils:showTips(13316009)
			return
		end

		DetectiveDataMgr:Req_DetectiveVoteClue(self.curDay,self.selectIndex)
	end)
end

function DetectiveClueInfo:updateTitlesList(  )
	-- body
	for i = 1,#self.activityInfo.extendData.chapterId do
		local item = self.uiList_titles:getItem(i)
		if not item then
			item = self.Panel_titleItem:clone()
			self.uiList_titles:pushBackCustomItem(item)
		end
		self:updateTitleItem(item, i)
	end
end

function DetectiveClueInfo:updateTitleItem( item , index )
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
		-- body
		local clueCfg = TabDataMgr:getData("DetectiveClue",self.activityInfo.extendData.clueIds[index])
		if clueCfg.condition ~= 0 then
			local chapterInfo = DetectiveDataMgr:getChapterInfo(clueCfg.condition)
			if not chapterInfo or not chapterInfo.first then
				-- 条件未达成
				Utils:showTips(13316016)
				return
			end
		end

		if self.curDay == index then return end
		self.curDay = index
		self:updateTitlesList()
		self:updateDayInfo()
	end)

end

function DetectiveClueInfo:updateClueList( ... )
	-- body

	local num = #self.uiList_clue:getItems() - #self.clueCfg.icon

	if num > 0 then
		for i = 1,num do
			self.uiList_clue:removeItem(1)
		end
	end

	for i = 1,#self.clueCfg.icon do
		local item = self.uiList_clue:getItem(i)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_clue:pushBackCustomItem(item)
		end
		self:updateClueItem(item,i)
	end

end

function DetectiveClueInfo:updateClueItem( item, index )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_taskDes = TFDirector:getChildByPath(item,"Label_taskDes")
	local Button_select = TFDirector:getChildByPath(item,"Button_select")
	local Panel_mask = TFDirector:getChildByPath(item,"Panel_mask")
	local Label_title = TFDirector:getChildByPath(item,"Label_title")

	Label_title:setText(index)
	Image_icon:setTexture(self.clueCfg.icon[index])
	Label_taskDes:setTextById(self.clueCfg.desc1[index])
	local voteRecord = DetectiveDataMgr:getVoteRecord(self.clueCfg.id,true)
	local texture = "ui/activity/detective/clue/001-1.png"
	if voteRecord == index or self.selectIndex == index then
		texture = "ui/activity/detective/clue/001.png"
	end
	Button_select:setTextureNormal(texture)

	Button_select:setTouchEnabled(not voteRecord) -- 已有记录屏蔽选中点击

	if Panel_mask then
		Panel_mask:hide()
		if voteRecord and voteRecord ~= index then
			-- todo ，已有记录，但不是选中条目出来
			Panel_mask:show()
		end
	end

	item:setTouchEnabled(voteRecord and voteRecord == index)
	item:onClick(function ( ... )
		-- body
		self.Panel_detail:show()
		self.Panel_detail:setOpacity(0)
		self.Panel_detail:runAction(FadeIn:create(0.5))
		self.Panel_clueList:hide()
	end)

	Button_select:onClick(function ( ... )
		-- body
		if self.selectIndex ~= index then
			self.selectIndex = index
			self:updateClueList()
		end
	end)
end

function DetectiveClueInfo:updateSelectedClueDetails( isInit )
	-- body
	local voteRecord = DetectiveDataMgr:getVoteRecord(self.clueCfg.id,true)
	if not voteRecord then return end
	if isInit then
		self.Panel_detail:show()
		self.Panel_clueList:hide()
	end
	self:updateClueItem(self.Panel_selectItem, voteRecord)
	self.Panel_selectItem:setTouchEnabled(false)
	self.Image_icon:setTexture(self.clueCfg.icon[voteRecord])
	self.Label_clueDetails:setTextById(self.clueCfg.desc2[voteRecord])
end

function DetectiveClueInfo:updateDayInfo( isInit )
	-- body
	self.selectIndex = nil
	local clueId = self.activityInfo.extendData.clueIds[self.curDay]
	self.clueCfg = TabDataMgr:getData("DetectiveClue",clueId)
	self.Panel_detail:hide()
	self.Panel_clueList:show()
	self:updateClueList()
	self:updateSelectedClueDetails(isInit)

	local chapterId = self.activityInfo.extendData.chapterId[self.curDay]
	local chapterCfg = TabDataMgr:getData("DetectiveMgr",chapterId)
	self.Label_des:setText(chapterCfg.des2)

	local voteRecord = DetectiveDataMgr:getVoteRecord(self.clueCfg.id,true)
	self.Button_action:setVisible(not voteRecord)
	self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(self.activityInfo.extendData.costId).icon)
	self.Label_costNum:setText(GoodsDataMgr:getItemCount(self.activityInfo.extendData.costId))

	self.Label_title:setText(chapterCfg.name)
	self.Image_chapterTitle:setTexture(chapterCfg.picture)
end


return DetectiveClueInfo