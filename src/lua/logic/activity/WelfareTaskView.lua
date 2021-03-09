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
*-- 福利任务活动界面 
]]

local WelfareTaskView = class("WelfareTaskView",BaseLayer)

local activeTipColor = {ccc3(40,56,76),ccc3(107,38,53),ccc3(43,49,81),ccc3(40,56,76)}
local taskDesColor = {ccc3(185,207,234),ccc3(246,187,195),ccc3(184,187,235),ccc3(176,217,224)}

function WelfareTaskView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
    self.selectIndex_ = 1
    self.activeItem_ = {}
    self.taskList = {}
    self.tabItem_ = {}
    self.TaskItem_ = {}
    self:init("lua.uiconfig.activity.welfareTaskView")
end

function WelfareTaskView:getClosingStateParams()
    return {self.activityId}
end

function WelfareTaskView:initUI( ui )
	self.super.initUI(self,ui)

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_base")
    local Panel_tabPos = TFDirector:getChildByPath(self.Panel_root, "Panel_tabPos")
    self.tabPos = {}

    for i = 1,4 do
        self.tabPos[i] = TFDirector:getChildByPath(Panel_tabPos,"pos"..i)
    end

	self.Panel_prefab = TFDirector:getChildByPath(ui,"Panel_prefab")
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")
    self.Panel_activeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activeItem")

	self.Panel_content = TFDirector:getChildByPath(ui,"Panel_content")
    self.Image_active = TFDirector:getChildByPath(self.Panel_content, "Image_active")
    self.Label_activeTitle = TFDirector:getChildByPath(self.Panel_content, "Label_activeTitle")
	self.Image_active_progress = TFDirector:getChildByPath(self.Panel_content, "Image_active_progress")
    self.LoadingBar_activeProgress = TFDirector:getChildByPath(self.Image_active_progress, "LoadingBar_activeProgress")
    self.Label_activeValue = TFDirector:getChildByPath(self.Panel_content, "Label_activeValue")
    
    local Image_Bar = TFDirector:getChildByPath(self.Panel_content, "Image_dailyBar")
    local Image_ScrollBar = TFDirector:getChildByPath(Image_Bar, "Image_dailyScrollBar")
    local scrollBar = UIScrollBar:create(Image_Bar, Image_ScrollBar)
    local ScrollView = TFDirector:getChildByPath(self.Panel_content, "ScrollView_daily")
    self.ListView_task = UIListView:create(ScrollView)
    self.ListView_task:setScrollBar(scrollBar)
    self:updateActivity()
    self:selectTab(1)
end

function WelfareTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateContent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateActivity, self))
end

function WelfareTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function WelfareTaskView:updateActivity()
	-- body
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.tabData_ = {}
	local tabData_ = table.keys(self.activityInfo.extendData.content)
    for i,k in pairs(tabData_) do
        local tabData = {}
        tabData.name = k
        tabData.showType = self.activityInfo.extendData.content[k].showType or i
        table.insert(self.tabData_,tabData)
    end

    for i,k in pairs(self.tabItem_) do
        k.root:removeFromParent(true)
    end

    self.tabItem_ = {}
	self:initTabBtn()
    self.showType = self.tabData_[self.selectIndex_].showType
    self:updateContent()
end

function WelfareTaskView:initTabBtn()
    for i, v in pairs(self.tabData_) do
        local Panel_tabItem = self.Panel_tabItem:clone()
        local item = {}
        item.root = Panel_tabItem
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.effect = TFDirector:getChildByPath(item.Image_select, "effect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
        item.Image_redPoint = TFDirector:getChildByPath(item.root, "Image_redPoint")
        item.Label_name:setText(Utils:MultiLanguageStringDeal(v.name))
        item.Image_icon:setTexture("ui/activity/welfareActivity/btn_icon"..v.showType..".png")
        item.Image_select:setTexture("ui/activity/welfareActivity/tab_"..v.showType..".png")
        item.effect:play("huodong_AN_"..v.showType,true)

        item.Image_select:setVisible(self.selectIndex_ == i)
        self.tabItem_[i] = item
        if self.tabPos[i] then
            item.root:setPosition(ccp(0,0))
            self.tabPos[i]:addChild(item.root)
        end
        item.root:setTouchEnabled(true)
        item.root:onClick(function ( ... )
            self:selectTab(i)
        end)
    end
end

function WelfareTaskView:selectTab(index)
    if self.selectIndex_ == index then return end
    -- self.Image_preview:hide()
    self.selectIndex_ = index
    for i, v in pairs(self.tabItem_) do
        v.Image_select:setVisible(index == i)
        if index == i then
            self.showType = self.tabData_[i].showType
            v.Image_icon:setTexture("ui/activity/welfareActivity/btn_icon"..self.tabData_[i].showType.."_1.png")
        else
            v.Image_icon:setTexture("ui/activity/welfareActivity/btn_icon"..self.tabData_[i].showType..".png")
        end
    end

    self:updateContent()
end

function WelfareTaskView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local item = {}
    item.root = Panel_taskItem
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_diban = TFDirector:getChildByPath(item.root, "Image_diban")
    item.Label_active_num = TFDirector:getChildByPath(item.root, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item.root, "Image_reward_" .. i)
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Scale(0.65)
        foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        item.Panel_reward[i] = foo
    end
    item.Button_goto = TFDirector:getChildByPath(item.root, "Button_goto")
    item.Button_goto:setOpacity(165)
    item.Label_goto = TFDirector:getChildByPath(item.root, "Label_goto")
    item.Button_receive = TFDirector:getChildByPath(item.root, "Button_receive")
    item.Label_receive = TFDirector:getChildByPath(item.Button_receive, "Label_receive")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    item.Image_get = TFDirector:getChildByPath(item.root, "Image_get")
    item.effect = TFDirector:getChildByPath(item.Image_get, "effect")
    self.TaskItem_[item.root] = item
    return Panel_taskItem
end

function WelfareTaskView:getActiveTask(index)
	local activityInfo = self.activityInfo
	local itemInfo = activityInfo.extendData.content[self.tabData_[index].name]
    local activeTask_ = itemInfo.huoyue or {}
    return activeTask_
end

function WelfareTaskView:getTaskList(index)
    local activityInfo = self.activityInfo
    local key = self.tabData_[index].name
	local itemInfo = activityInfo.extendData.content[key]
    local task_ = itemInfo.task or {}
	local taskList = {}
	for k,v in pairs(task_) do
		for i,_v in pairs(v) do
    		local _vProgressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, _v)
    		if _vProgressInfo.status ~=  EC_TaskStatus.GETED then
    			taskList[k] = _v
    			break;
    		end
		end
        
        if not taskList[k] then
            taskList[k] = v[#v]
        end
	end
    table.sort(taskList, function ( a , b)
        local infoA = ActivityDataMgr2:getItemInfo(activityInfo.activityType, a)
        local infoB = ActivityDataMgr2:getItemInfo(activityInfo.activityType, b)
        local progressA = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, a) or {}
        local progressB = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, b) or {}
        progressA.status = progressA.status or EC_TaskStatus.ING
        progressB.status = progressB.status or EC_TaskStatus.ING
        if progressA.status == progressB.status then
            return a > b
        elseif progressA.status == EC_TaskStatus.GET then
            return true
        elseif progressB.status == EC_TaskStatus.GET then
            return false
        elseif progressB.status == EC_TaskStatus.GETED then
            return true
        elseif progressA.status == EC_TaskStatus.GETED then
            return false
        end
    end)
	return taskList
end

function WelfareTaskView:checkTaskCanGet( index )
    local taskList_ = self:getTaskList(index)
    local activeTask_ = self:getActiveTask(index)
    
    for k,v in pairs(taskList_) do
        local progressInfo= ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
        if progressInfo.status == EC_TaskStatus.GET then
            return true
        end
    end

    for k,v in pairs(activeTask_) do
        local progressInfo= ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
        if progressInfo.status == EC_TaskStatus.GET then
            return true
        end
    end
end

function WelfareTaskView:updateContent(  )

    for i,v in pairs(self.tabItem_) do
        v.Image_redPoint:setVisible(self:checkTaskCanGet(i))
    end

    self.Image_active:setTexture("ui/activity/welfareActivity/bg_active_"..self.showType..".png")
    self.LoadingBar_activeProgress:setTexture("ui/activity/welfareActivity/progress_"..self.showType..".png")
    self.Label_activeTitle:setColor(activeTipColor[self.showType])
	local taskList_ = self:getTaskList(self.selectIndex_)
    local activeTask_ = self:getActiveTask(self.selectIndex_)

	local activityInfo = self.activityInfo

    local lastItemId = activeTask_[#activeTask_]
    local lastItemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, lastItemId)
    local lastProgressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, lastItemId)
    lastProgressInfo.progress = lastProgressInfo.progress or 0
    local maxActive_ = lastItemInfo.target*1.03 or 0

    local percent = me.clampf(lastProgressInfo.progress / maxActive_, 0, 1)

    if lastProgressInfo.progress == lastItemInfo.target then
        percent = 1
    end

    self.LoadingBar_activeProgress:setPercent(percent * 100)
    self.Label_activeValue:setText(lastProgressInfo.progress)

    for k,v in pairs(self.activeItem_) do
    	v.root:removeFromParent(true)
    end

    self.activeItem_ = {}
    local size = self.Image_active_progress:Size()
    for i = #activeTask_, 1, -1 do -- 活跃度奖励
        local itemId = activeTask_[i] 

        local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
	    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
       	
       	local percent = itemInfo.target / maxActive_
        local Panel_activeItem = self.Panel_activeItem:clone()
        local item = {}
        item.root = Panel_activeItem
        item.Panel_geted = TFDirector:getChildByPath(item.root, "Panel_geted")
        item.Button_geted = TFDirector:getChildByPath(item.Panel_geted, "Button_geted")
        item.Panel_canGet = TFDirector:getChildByPath(item.root, "Panel_canGet")
        item.Button_canGet = TFDirector:getChildByPath(item.Panel_canGet, "Button_canGet")
        item.effect = TFDirector:getChildByPath(item.Panel_canGet, "effect")
        item.effect:playByIndex(0,-1,-1,1)
        item.Panel_notGet = TFDirector:getChildByPath(item.root, "Panel_notGet")
        item.Label_getValue = TFDirector:getChildByPath(item.root, "Label_getValue")
        item.Label_getValue:setText(itemInfo.target)
        
        item.Panel_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        item.Panel_canGet:setVisible(progressInfo.status == EC_TaskStatus.GET)
        item.Panel_notGet:setVisible(progressInfo.status == EC_TaskStatus.ING)
        Panel_activeItem:Pos(size.width * percent, 0):AddTo(self.Image_active_progress,15)
        item.root:setTouchEnabled(progressInfo.status ~= EC_TaskStatus.GETED)
        item.root:onClick(function ( ... )
            if progressInfo.status == EC_TaskStatus.GET then
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId,itemId)
            else
                local showReward = {}
                for i, v in pairs(itemInfo.reward) do
                    table.insert(showReward, {i,v})
                end
                Utils:previewReward(nil,showReward)
            end
        end)
        self.activeItem_[i] = item
    end


    local items = self.ListView_task:getItems()
    local gap = #taskList_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_taskItem = self:addTaskItem()
            self.ListView_task:pushBackCustomItem(Panel_taskItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_task:removeItem(1)
        end
    end

    local items = self.ListView_task:getItems()
    for i, v in ipairs(items) do
        local item = self.TaskItem_[v]
        local itemId = taskList_[i]
	    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
	    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
        item.Image_diban:setTexture("ui/activity/welfareActivity/item_bg_"..self.showType..".png")
        item.Button_goto:setTextureNormal("ui/activity/welfareActivity/btn_type_"..self.showType..".png")
        item.Button_receive:setTextureNormal("ui/activity/welfareActivity/btn_type_"..self.showType..".png")
        item.Image_get:setTexture("ui/activity/welfareActivity/light_"..self.showType..".png")
        item.effect:play("huodong_RWK_"..self.showType,true)
        local str = Utils:MultiLanguageStringDeal(itemInfo.extendData.des2..",("..progressInfo.progress.."/"..itemInfo.target..")")
        item.Label_desc:setText(str)
        item.Label_name:setText(Utils:MultiLanguageStringDeal(itemInfo.details))
        -- local size=  item.Label_name:Size()
        -- item.Image_active:PosX(size.width + 10)
        item.Label_desc:setColor(taskDesColor[self.showType])
        local showReward = {}
        local activeReward
        for i, v in pairs(itemInfo.reward) do
            table.insert(showReward, {i,v})
        end
        
        if itemInfo.extendData.addActive and itemInfo.extendData.addActive > 0 then
            item.Label_active_num:setTextById(13200335, itemInfo.extendData.addActive)
             item.Label_active_num:setVisible(true)
        else
             item.Label_active_num:setVisible(false)
        end

        for j, Panel_reward in ipairs(item.Panel_reward) do
            local reward = showReward[j]
            if reward then
                Panel_reward.Panel_goodsItem:show()
                if isDoubleCardItem then
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
                    local doubleCardId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DOUBLE_CARD)
                    local activityInfo = ActivityDataMgr2:getActivityInfo(doubleCardId[1])
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2] * activityInfo.extendData)
                else
                    PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
                end
            else
                Panel_reward.Panel_goodsItem:hide()
            end
        end

        if not item.Panel_reward[3].Panel_goodsItem:isVisible() then -- 上面一排没有物品
            item.Panel_reward[1].root:setPositionY(-24)
            item.Panel_reward[2].root:setPositionY(-24)
            if not item.Panel_reward[2].Panel_goodsItem:isVisible() then
                item.Panel_reward[1].root:setPositionX(0)
            end
        elseif not item.Panel_reward[4].Panel_goodsItem:isVisible() then
            item.Panel_reward[3].root:setPositionX(0)
            item.Panel_reward[1].root:setPositionY(-62)
            item.Panel_reward[2].root:setPositionY(-62)
        end


        item.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
        item.Image_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
        item.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
        item.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING )
        item.Label_goto:setVisible(progressInfo.status == EC_TaskStatus.ING )
        item.Button_goto:setGrayEnabled(not itemInfo.extendData.jumpInterface or itemInfo.extendData.jumpInterface == 0)
        item.Button_goto:setTouchEnabled(itemInfo.extendData.jumpInterface and itemInfo.extendData.jumpInterface ~= 0)
        item.Button_goto:onClick(function()
            FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface, itemInfo.extendData.jumpParamters)
        end)

        item.Button_receive:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemId)
        end)
    end
end


return WelfareTaskView