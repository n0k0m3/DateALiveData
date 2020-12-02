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

local DetectiveChapterInfoActivity = class("DetectiveChapterInfoActivity",BaseLayer)

function DetectiveChapterInfoActivity:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
	self:initData()
	self:init("lua.uiconfig.activity.detectiveChapterInfoActivity")
end

function DetectiveChapterInfoActivity:initData(  )
	-- body
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    if not self.curIndex then
    	for k,v in ipairs(self.activityInfo.extendData.chapterId) do
    		local chapterInfo = DetectiveDataMgr:getChapterInfo(v)
    		if chapterInfo and chapterInfo.status == 3 then
    			self.curIndex = k
    			break
    		end

    		if chapterInfo and chapterInfo.status == 2 then
    			self.curIndex = k
    		end
    	end
    end
end

function DetectiveChapterInfoActivity:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.chapterItems = {}

	self.Label_date = TFDirector:getChildByPath(ui,"Label_date")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Label_chapterName = TFDirector:getChildByPath(ui,"Label_chapterName")
	self.Image_chapter = TFDirector:getChildByPath(ui,"Image_chapter")

	self.LoadingBar_process = TFDirector:getChildByPath(ui,"LoadingBar_process")
	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")
	self.uiList_task = UIListView:create(ScrollView_task)

	self.Button_action = TFDirector:getChildByPath(ui,"Button_action")
	self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")
	self.Label_costNum = TFDirector:getChildByPath(ui,"Label_costNum")
	self.Label_process = TFDirector:getChildByPath(ui,"Label_process")
	self.Button_add = TFDirector:getChildByPath(ui,"Button_add")

	self.Image_specialTip = TFDirector:getChildByPath(ui,"Image_specialTip")
	self.Label_specialTip = TFDirector:getChildByPath(self.Image_specialTip,"Label_tips")

	local arr = {
		FadeOut:create(1.0),
		FadeIn:create(0.2),
	}
	self.Image_specialTip:runAction(CCRepeatForever:create(CCSequence:create(arr)))

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	for i = 1,7 do
		self.chapterItems[i] = TFDirector:getChildByPath(ui,"chapterItem"..i)
	end
	self:updateChapterList()
	self:updateCurChapterInfo()
	self:updateCurTaskList()
	self:updateCountDonw()



	self.Label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime , self.activityInfo.endTime))
end

function DetectiveChapterInfoActivity:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( ... )
		-- body
		self:updateChapterList()
		self:updateCurChapterInfo()
	end)
	
	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_CHAPTER_UPDATE, function ( ... )
		-- body
		self:updateChapterList()
		self:updateCurChapterInfo()
	end)
	self.Button_action:onClick(function ( ... )
		
		local chapterId = self.activityInfo.extendData.chapterId[self.curIndex]
		local chapterCfg = TabDataMgr:getData("DetectiveMgr",chapterId)
		local chapterInfo = DetectiveDataMgr:getChapterInfo(chapterId)
		-- body
		local enterChapter = function ( ... )
			-- body

			if DetectiveDataMgr:getCurentChapterInfo() and DetectiveDataMgr:getCurentChapterInfo().status == 3 and chapterId ~= DetectiveDataMgr:getCurentChapterInfo().chapterId then
				Utils:showTips(13316007)
				return
			end 

			if ServerDataMgr:getServerTime()*1000 < chapterCfg.beginTime then
				Utils:showTips(13316004)
				return
			end

			if not chapterInfo or chapterInfo.status == 1 then
				Utils:showTips(13316005)
				return
			end

			if chapterInfo.status ~= 3 and GoodsDataMgr:getItemCount(self.activityInfo.extendData.ticketId) < 1 then
				Utils:showTips(13316006)
				return
			end


			FunctionDataMgr:jDetectiveMain(chapterId)

		end

		if chapterInfo.status == 4 then
    		local args = {
	            tittle = 2107025,
	            reType = "detectiveEnter",
	            content = TextDataMgr:getText(13316018),
	            confirmCall = function ( ... )
	            	-- body
	            	enterChapter()
	            end,
	        }
	        Utils:showReConfirm(args)
	        return
		end

		enterChapter()
	end)

	self.Button_add:onClick(function ( ... )
		-- body
		local itemCfg = GoodsDataMgr:getItemCfg(self.activityInfo.extendData.ticketId)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("common.BuyResourceView", self.activityInfo.extendData.ticketId)
        else
            Utils:showTips(800021)
        end
	end)
end

function DetectiveChapterInfoActivity:updateChapterList( ... )
	-- body
	for k,v in ipairs(self.chapterItems) do
		self:updateChapterItem(v,k)
	end
end

function DetectiveChapterInfoActivity:updateChapterItem( item, index )
	-- body
	local chapterId = self.activityInfo.extendData.chapterId[index]
	local chapterInfo = DetectiveDataMgr:getChapterInfo(chapterId)
	local chapterCfg = TabDataMgr:getData("DetectiveMgr",chapterId)

	local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
	local Panel_lock = TFDirector:getChildByPath(item,"Panel_lock")
	local Panel_finish = TFDirector:getChildByPath(item,"Panel_finish")
	local Label_progress = TFDirector:getChildByPath(item,"Label_finish")
	local Panel_ing = TFDirector:getChildByPath(item,"Panel_ing")
	local Label_timing = TFDirector:getChildByPath(Panel_lock,"Label_timing")
	local Image_select = TFDirector:getChildByPath(item,"Image_select")

	Image_bg:setVisible(ServerDataMgr:getServerTime()*1000 >= chapterCfg.beginTime)
	Panel_lock:setVisible(ServerDataMgr:getServerTime()*1000 < chapterCfg.beginTime)
	Panel_finish:setVisible(chapterInfo.status == 2 or chapterInfo.status == 4)
	Panel_ing:setVisible(chapterInfo.status == 3)

	Image_select:setVisible(self.curIndex == index)

	local itemCfg = GoodsDataMgr:getItemCfg(chapterCfg.progressItem)
	local count = GoodsDataMgr:getItemCount(chapterCfg.progressItem)
	local percent = count*100/itemCfg.totalMax

	if percent >= 100 then
		Label_progress:setTextById(13316020)
	else
		Label_progress:setTextById(13316019,percent)
	end

	item:setTouchEnabled(true)

	item:onClick(function ( ... )
		-- body
		local arr = {
			CCMoveBy:create(0.1,ccp(0,-5)),
			CCMoveBy:create(0.1,ccp(0,5)),
		}
		item:runAction(CCSequence:create(arr))
		if self.curIndex == index then return end
		self.curIndex = index
		self:updateChapterList()
		self:updateCurChapterInfo()
		self:updateCurTaskList()
	end)

end

function DetectiveChapterInfoActivity:updateCurChapterInfo( ... )
	-- body
	self.curIndex = self.curIndex or 1
	local chapterId = self.activityInfo.extendData.chapterId[self.curIndex]
	local chapterInfo = DetectiveDataMgr:getChapterInfo(chapterId)
	local chapterCfg = TabDataMgr:getData("DetectiveMgr",chapterId)

	self.Label_chapterName:setText(chapterCfg.name)
	self.Image_chapter:setTexture(chapterCfg.picture)

	local itemCfg = GoodsDataMgr:getItemCfg(chapterCfg.progressItem)
	local count = GoodsDataMgr:getItemCount(chapterCfg.progressItem)
	local percent = count*100/itemCfg.totalMax
	self.LoadingBar_process:setPercent(percent)
	self.Label_process:setText(percent.."%")

	local des = self.activityInfo.extendData.firstDes
	for k,v in ipairs(self.activityInfo.extendData.chapterId) do -- 遍历查找最近解锁文本逻辑
		local _chapterInfo = DetectiveDataMgr:getChapterInfo(v)
		local _chapterCfg = TabDataMgr:getData("DetectiveMgr",v)
		if _chapterInfo and _chapterInfo.first then
			des = _chapterCfg.des2
		end
	end
	self.Label_des:setText(Utils:MultiLanguageStringDeal(des))
	local  costId = self.activityInfo.extendData.ticketId
	self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(tonumber(costId)).icon)
	self.Label_costNum:setText(GoodsDataMgr:getItemCount(tonumber(costId)))
end

function DetectiveChapterInfoActivity:updateCurTaskList( ... )
	-- body
	local taskList = self.activityInfo.extendData.taskMap[self.curIndex]

	local num = #self.uiList_task:getItems() - #taskList

	if num > 0 then
		for i = 1,num do
			self.uiList_task:removeItem(1)
		end
	end

	for k,v in ipairs(taskList) do
		local item = self.uiList_task:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_task:pushBackCustomItem(item)
		end
		self:updateTaskItem(item,v)
	end
end

function DetectiveChapterInfoActivity:updateTaskItem( item, data )
	-- body
	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,data)
	local processInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,data)

	local Panel_reward = TFDirector:getChildByPath(item,"Panel_reward")
	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Label_taskDes = TFDirector:getChildByPath(item,"Label_taskDes")
	local Label_geted = TFDirector:getChildByPath(item,"Label_geted")

	if not Panel_reward.goodsItem then
		local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		panel_goodsItem:setAnchorPoint(ccp(0.5,0.5))
		panel_goodsItem:AddTo(Panel_reward):Pos(0, 0)
		panel_goodsItem:setScale(0.75)
		Panel_reward.goodsItem = panel_goodsItem
	end

	local id,num = next(itemInfo.reward)
	PrefabDataMgr:setInfo(Panel_reward.goodsItem,tonumber(id),num)
	Label_taskDes:setText(Utils:MultiLanguageStringDeal(itemInfo.extendData.des2))
	Button_get:setVisible(processInfo.status == EC_TaskStatus.GET)
	Label_geted:setVisible(processInfo.status == EC_TaskStatus.GETED)
	Button_get:onClick(function ( ... )
		-- body
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, data)
	end)
end

function DetectiveChapterInfoActivity:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function DetectiveChapterInfoActivity:onUpdateProgressEvent()
	self:updateCurTaskList()
end

function DetectiveChapterInfoActivity:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function DetectiveChapterInfoActivity:updateCountDonw( ... )
	-- body
	self:updateTimingStatus()
	local showSpecialTips = ServerDataMgr:getServerTime() >= self.activityInfo.extendData.specialTime[1] and ServerDataMgr:getServerTime() < self.activityInfo.extendData.specialTime[2]

	self.Image_specialTip:setVisible(showSpecialTips)

	if showSpecialTips then
		self.Label_specialTip:setTextById(13316021,Utils:getTimeCountDownString(self.activityInfo.extendData.specialTime[2],2))
	end
end

function DetectiveChapterInfoActivity:updateTimingStatus( ... )
	-- body
	for k,v in ipairs(self.chapterItems) do
		local chapterId = self.activityInfo.extendData.chapterId[k]
		local chapterCfg = TabDataMgr:getData("DetectiveMgr",chapterId)
		local chapterInfo = DetectiveDataMgr:getChapterInfo(chapterId)
		local Label_timing = TFDirector:getChildByPath(v,"Label_timing")

		if math.ceil(chapterCfg.beginTime/1000) - ServerDataMgr:getServerTime() < 24*3600 then 
			Label_timing:setText(Utils:getTimeCountDownString(math.ceil(chapterCfg.beginTime/1000),2)) 
		else
			Label_timing:setText(Utils:getDateString(math.ceil(chapterCfg.beginTime/1000))) 
		end
	end
end


return DetectiveChapterInfoActivity