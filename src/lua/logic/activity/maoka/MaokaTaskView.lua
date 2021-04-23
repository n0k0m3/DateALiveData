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

local MaokaTaskView = class("MaokaTaskView",BaseLayer)

function MaokaTaskView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:init("lua.uiconfig.activity.taskView")
end

function MaokaTaskView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Panel_yinye = TFDirector:getChildByPath(ui,"Panel_yinye")
	self.Panel_yinye.Image_normal = TFDirector:getChildByPath(self.Panel_yinye,"Image_normal")
	self.Panel_yinye.Image_select = TFDirector:getChildByPath(self.Panel_yinye,"Image_select")
	self.Panel_daily = TFDirector:getChildByPath(ui,"Panel_daily")
	self.Panel_daily.Image_normal = TFDirector:getChildByPath(self.Panel_daily,"Image_normal")
	self.Panel_daily.Image_select = TFDirector:getChildByPath(self.Panel_daily,"Image_select")

	self.Panel_content_yinye= TFDirector:getChildByPath(ui,"Panel_content_yinye")
	self.Panel_content = TFDirector:getChildByPath(ui,"Panel_content")

	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Panel_jiacheng = TFDirector:getChildByPath(ui,"Panel_jiacheng")
	self.Panel_activeItem = TFDirector:getChildByPath(ui,"Panel_activeItem")

	self:updateContent()
	self:updateContentYinye()

	self.Panel_yinye.Image_select:show()
	self.Panel_yinye.Image_normal:hide()
	self.Panel_daily.Image_normal:show()
	self.Panel_daily.Image_select:hide()
	self.Panel_content_yinye:show()
	self.Panel_content:hide()
end

function MaokaTaskView:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Panel_yinye:onClick(function ( ... )
		-- body
		self.Panel_yinye.Image_select:show()
		self.Panel_yinye.Image_normal:hide()
		self.Panel_daily.Image_normal:show()
		self.Panel_daily.Image_select:hide()
		self.Panel_content_yinye:show()
		self.Panel_content:hide()
	end)

	self.Panel_daily:onClick(function ( ... )
		-- body
		self.Panel_daily.Image_select:show()
		self.Panel_daily.Image_normal:hide()
		self.Panel_yinye.Image_normal:show()
		self.Panel_yinye.Image_select:hide()
		self.Panel_content_yinye:hide()
		self.Panel_content:show()
	end)

	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.updateTimer = TFDirector:addTimer(1000,-1,nil,function ( ... )
		-- body
		self.Label_timing:setText(Utils:getTimeCountDownString(MaokaActivityMgr:getTriggerTime(),1))
	end)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateRightContent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateRightContent, self))
    EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, handler(self.updateRightContent, self))

    EventMgr:addEventListener(self, EV_MAOKA_START_MAKE_RSP, function ( data )
    	-- bod
    	Utils:openView("activity.maoka.MaokaFormulaMakeView",data.formulaId,data.etime)
    end)

end

function MaokaTaskView:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	if self.updateTimer then
		TFDirector:stopTimer(self.updateTimer)
		TFDirector:removeTimer(self.updateTimer)
		self.updateTimer = nil
	end
end

function MaokaTaskView:updateRightContent( ... )
	-- body
	self:updateContent()
	self:updateContentYinye()
end

function MaokaTaskView:onSubmitSuccessEvent( activitId, itemId, reward)
	-- body
	if not  MaokaActivityMgr:isMaokaActivity(activitId) then
		return
	end

	if reward then
		Utils:showReward(reward)
	end

end

function MaokaTaskView:updateContentYinye( ... )
	-- body
	if not self.initContentYinye then
		self.initContentYinye = true

	    self.ScrollView_progress = TFDirector:getChildByPath(self.Panel_content_yinye,"ScrollView_progress")
	    self.ScrollView_progress:setContentOffset(ccp(-50,0))
	    self.Image_active_progress = TFDirector:getChildByPath(self.Panel_content_yinye,"Image_progress_di")
	    self.LoadingBar_progress = TFDirector:getChildByPath(self.Panel_content_yinye,"LoadingBar_progress")


	    self.Label_value = TFDirector:getChildByPath(self.Panel_content_yinye,"Label_value")
	    self.Label_timing = TFDirector:getChildByPath(self.Panel_content_yinye,"Label_timing")

	    local ScrollView_list = TFDirector:getChildByPath(self.Panel_content_yinye,"ScrollView_list")

	    self.uiList_yinye = UIListView:create(ScrollView_list)
		self.uiList_yinye:setItemsMargin(2)
		self:initProgressTask()
	end

	self:updateProgressTask()

	local addList = MaokaActivityMgr:getAddValueList()
	for k,v in ipairs(addList) do
		local item = self.uiList_yinye:getItem(k)
		if not item then
			item = self.Panel_jiacheng:clone()
			self.uiList_yinye:pushBackCustomItem(item)
		end
		self:updateJiachengItem(item,v)
	end

	self.Label_value:setText(MaokaActivityMgr:getTotal())
	self.Label_timing:setText(Utils:getTimeCountDownString(MaokaActivityMgr:getTriggerTime(),2))
end

function MaokaTaskView:updateContent( ... )
	-- body
	if not self.initContent then
		self.initContent = true
	    local ScrollView_task = TFDirector:getChildByPath(self.Panel_content, "ScrollView_task")
	    self.Button_refresh = TFDirector:getChildByPath(self.Panel_content,"Button_refresh")
	    self.Image_costIcon = TFDirector:getChildByPath(self.Panel_content,"Image_costIcon")
	    self.Label_costNum = TFDirector:getChildByPath(self.Panel_content,"Label_costValue")


	    self.Button_refresh:onClick(function ( ... )
	    	-- body
	    	local cost = MaokaActivityMgr:getDailyTaskRefreshCost()
	    	local costId, costNum = next(cost)
	    	if GoodsDataMgr:getItemCount(costId) < costNum then
	    		Utils:showTips(13316796)
	    		return
	    	end
	    	MaokaActivityMgr:SEND_ACTIVITY_REQ_REFRESH_DAILY_TASK()
	    end)
	    self.uiList_task = UIListView:create(ScrollView_task)
		self.uiList_task:setItemsMargin(5)
	end

	local taskList = MaokaActivityMgr:getDailyTaskList()

	local num = #taskList - #self.uiList_task:getItems()

	if num < 0 then
		for i = 1,math.abs(num) do
			self.uiList_task:removeItem(1)
		end
	end

	for k,v in ipairs(taskList) do
		local item = self.uiList_task:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uiList_task:pushBackCustomItem(item)
		end
		self:updateTaskItem(item, v)
	end

	local cost = MaokaActivityMgr:getDailyTaskRefreshCost()
	self.Button_refresh:setVisible(cost)
	if cost then
		local id,num = next(cost)
		self.Image_costIcon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
		self.Label_costNum:setText(num)
	end
end

function MaokaTaskView:initProgressTask()
    self.activeTask_ = MaokaActivityMgr:getYinyeTaskList()
    self.activeItem_ = {}
    local size = self.Image_active_progress:Size()
    for i = #self.activeTask_, 1, -1 do
        local taskCfg = MaokaActivityMgr:getActivityItemInfo(self.activeTask_[i])

        if not self.maxActive_ then
            self.maxActive_ = taskCfg.target
        end

        local percent = taskCfg.target / self.maxActive_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Button_geted = TFDirector:getChildByPath(item.Panel_geted, "Button_geted")
        item.Button_geted:setOpacity(255 * 0.3)
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Spine_receive = TFDirector:getChildByPath(item.Panel_canGet, "Spine_receive")
        item.Spine_receive:play("animation", true)
        item.Button_canGet = TFDirector:getChildByPath(item.Panel_canGet, "Button_canGet")
        item.Button_canGet:setOpacity(255 * 0.3)
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Button_notGet = TFDirector:getChildByPath(item.Panel_notGet, "Button_notGet")
        item.Button_notGet:setOpacity(255 * 0.3)
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(Utils:format_number_w(taskCfg.target))
        self.activeItem_[i] = item
        Panel_activeItem:Pos(size.width * percent, 0):AddTo(self.Image_active_progress,15)

        item.Button_canGet:onClick(function ( ... )
            -- body
            MaokaActivityMgr:submitItemInfo(self.activeTask_[i])
        end)  

        item.Button_geted:onClick(function ( ... )
            -- body
            self:showPreview(i)
        end) 

        item.Button_notGet:onClick(function ( ... )
            -- body
            self:showPreview(i)
        end)
    end
end

function MaokaTaskView:updateProgressTask(  )
    -- body
     for i, v in ipairs(self.activeItem_ or {}) do
		local itemInfo ,progressInfo = MaokaActivityMgr:getActivityItemInfo(self.activeTask_[i])
        v.Panel_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        v.Panel_canGet:setVisible(progressInfo.status == EC_TaskStatus.GET)
        v.Panel_notGet:setVisible(progressInfo.status == EC_TaskStatus.ING)

        if i == #self.activeItem_ then
            self.LoadingBar_progress:setPercent(progressInfo.progress*100/self.maxActive_)
        end
    end
end

function MaokaTaskView:showPreview(index)
    local item = self.activeItem_[index]
    local wp = item.root:getParent():convertToWorldSpace(item.root:Pos())
    -- local np = self.Image_preview:getParent():convertToNodeSpaceAR(wp)

    local taskCfg = MaokaActivityMgr:getActivityItemInfo(self.activeTask_[index])
    local reward = {}
    for k,v in pairs(taskCfg.reward) do
        table.insert(reward,{id = k, num = v})
    end
    Utils:previewReward(self.Image_preview, reward)

    -- self.Image_preview:Pos(np)
end

function MaokaTaskView:updateTaskItem( item, data )
	-- body
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Button_make = TFDirector:getChildByPath(item,"Button_make")
	local Button_tijiao = TFDirector:getChildByPath(item,"Button_tijiao")
	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Image_geted = TFDirector:getChildByPath(item,"Image_geted")

	local itemInfo ,progressInfo = MaokaActivityMgr:getActivityItemInfo(data)

    local goodsId, goodsNum
	for i = 1,4 do
		local pos = TFDirector:getChildByPath(item,"Image_pos"..i)
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end

        if not pos.Panel_goodsItem then
        	pos.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        	pos.Panel_goodsItem:AddTo(pos):Pos(0, 0):Scale(0.7)
        end

        pos.Panel_goodsItem:setVisible(tobool(id))
        if pos.Panel_goodsItem:isVisible() then
            PrefabDataMgr:setInfo(pos.Panel_goodsItem, goodsId, goodsNum)
        end
	end

	Label_des:setText(itemInfo.extendData.des2)
	Label_name:setText(itemInfo.details)
	Button_make:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.formulaId)
	Button_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
	Image_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)

	Button_tijiao:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.submit)
	Button_get:onClick(function ( ... )
		-- body
		MaokaActivityMgr:submitItemInfo(data)
	end)
	
	Button_make:onClick(function ( ... )
		-- body
		MaokaActivityMgr:SEND_ACTIVITY_REQ_START_SPECIAL_MAKE_FORMULA()
	end)

	Button_tijiao:onClick(function ( ... )
		-- body
		MaokaActivityMgr:submitItemInfo(data)
	end)
end

function MaokaTaskView:updateJiachengItem( item, data )
	-- body
	local Panel_remai = TFDirector:getChildByPath(item,"Panel_remai")
	local Panel_maomi = TFDirector:getChildByPath(item,"Panel_maomi")

	Panel_remai:setVisible(data.type == 1)
	Panel_maomi:setVisible(data.type == 2)
	local _Type = data.type
	if _Type == 1 then
		local Label_value = TFDirector:getChildByPath(Panel_remai,"Label_value")
		Label_value:setTextById(13316714,data.value)
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			-- body
    		Utils:openView("activity.maoka.MaokaMaidListView")
		end)
	elseif _Type == 2 then
		local Label_value = TFDirector:getChildByPath(Panel_maomi,"Label_value")
		Label_value:setTextById(13316714,data.value)
	end
end


return MaokaTaskView