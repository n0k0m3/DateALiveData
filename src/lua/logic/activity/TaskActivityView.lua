
local TaskActivityView = class("TaskActivityView", BaseLayer)

function TaskActivityView:initData(activityId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.taskItems_ = {}
end

function TaskActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    local uiName = self.activityInfo_.extendData.uiName or "taskActivityView"
    if self.activityInfo_.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
        uiName = "taskActivityViewFanshi"
    end
    print(self.activityInfo_.extendData , "666666666666666")
    self:init("lua.uiconfig.activity."..uiName)
end

function TaskActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")

    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    self.Label_date = TFDirector:getChildByPath(self.Image_ad, "Label_date")
    self.Label_timing = TFDirector:getChildByPath(self.Image_ad, "Label_timing")
    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)

    self:refreshView()
end

function TaskActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.taskData_ = ActivityDataMgr2:getItems(self.activityId_)

    local items = self.ListView_task:getItems()
    local gap = #items - #self.taskData_

    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.ListView_task:getItem(1)
            self.taskItems_[item] = nil
            self.ListView_task:removeItem(1)
        else
            local item = self:addTaskItem()
            self.ListView_task:pushBackCustomItem(item)
        end
    end
    for i, v in ipairs(self.ListView_task:getItems()) do
        self:updateTaskItem(i)
    end

    self.Label_date:setText(Utils:getActivityDateString(self.activityInfo_.startTime, self.activityInfo_.endTime, self.activityInfo_.extendData.dateStyle))

    self.Image_ad:setTexture(self.activityInfo_.showIcon)
end


function TaskActivityView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_progress_title = TFDirector:getChildByPath(foo.root, "Label_progress_title")
    foo.Label_progress_title:setTextById(1890002)
    if self.isBackPlayer then
        foo.Label_progress_title:setTextById(100000002)
    end
    foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
    foo.Image_reward = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_reward_" .. i)
        bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        bar.Panel_goodsItem:AddTo(bar.root):Pos(0, 0):Scale(0.75)
        foo.Image_reward[i] = bar
    end
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.root, "Label_receive")
    foo.Label_receive:setTextById(1300008)
    foo.Button_goto = TFDirector:getChildByPath(foo.root, "Button_goto")
    foo.Label_goto = TFDirector:getChildByPath(foo.Button_goto, "Label_goto")
    foo.Label_goto:setTextById(1300009)
    foo.Label_geted_bg = TFDirector:getChildByPath(foo.root, "Label_geted_bg")
    foo.Label_geted = TFDirector:getChildByPath(foo.root, "Label_geted")
    foo.Label_geted:setTextById(1300015)
    foo.Label_reward = TFDirector:getChildByPath(foo.root, "Label_reward")
    foo.Label_reward:setTextById(1890003)
    foo.Image_reset = TFDirector:getChildByPath(foo.root, "Image_reset"):hide()
    foo.Image_get = TFDirector:getChildByPath(foo.root, "Image_get")
    foo.Image_getted = TFDirector:getChildByPath(foo.root, "Image_getted")
    foo.Image_getted_mask = TFDirector:getChildByPath(foo.root, "Image_getted_mask")
    self.taskItems_[foo.root] = foo

    return Panel_taskItem
end

function TaskActivityView:updateTaskItem(index)
    local activityInfo = self.activityInfo_
    local itemId = self.taskData_[index]
    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progress = ActivityDataMgr2:getProgress(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

    local item = self.ListView_task:getItem(index)
    local foo = self.taskItems_[item]

    foo.Image_icon:setTexture(itemInfo.extendData.icon)
  
  local strIndex = 0
   for i in  string.gmatch(TextDataMgr:getText(tonumber(itemInfo.extendData.des2)) , '%%%a') do
       strIndex = strIndex + 1
   end
   if strIndex == 2 then
       foo.Label_desc:setTextById(tonumber(itemInfo.extendData.des2) ,tonumber(itemInfo.target) ,itemInfo.extendData.maidList )
   elseif strIndex == 1 then
       foo.Label_desc:setTextById(tonumber(itemInfo.extendData.des2) ,tonumber(itemInfo.target))
        print(strIndex , itemInfo,itemInfo.target)

   else
        foo.Label_desc:setTextById(tonumber(itemInfo.extendData.des2))
   end
    
   
    foo.Label_progress:setTextById(800005, progress, itemInfo.target)
    if progress > tonumber(itemInfo.target)  then
        foo.Label_progress:setTextById(800005, itemInfo.target, itemInfo.target)
    end

    local goodsId, goodsNum
    for i, v in ipairs(foo.Image_reward) do
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end
        v.Panel_goodsItem:setVisible(tobool(id))
        if v.Panel_goodsItem:isVisible() then
            PrefabDataMgr:setInfo(v.Panel_goodsItem, goodsId, goodsNum)
        end
    end

    foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Label_geted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    if foo.Label_geted_bg then 
        foo.Label_geted_bg:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    end
    foo.Button_goto:setVisible(progressInfo.status == EC_TaskStatus.ING and itemInfo.extendData.jumpInterface)
    foo.Image_reset:setVisible(itemInfo.extendData.resetType == 2)
    if foo.Image_get then
        foo.Image_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    end
    if foo.Image_get then
        foo.Image_getted:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    end
    if foo.Image_getted_mask then 
        foo.Image_getted_mask:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    end
    foo.Button_receive:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityInfo.id, itemId)
    end)
    foo.Button_goto:onClick(function()
            local param = itemInfo.extendData.parameter or {}
            FunctionDataMgr:enterByFuncId(itemInfo.extendData.jumpInterface,unpack(param))
    end)

    self:updateCountDonw()
end

function TaskActivityView:refreshView()

end

function TaskActivityView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r42006", hour, min)
        else
            self.Label_timing:setTextById("r42005", day, hour)
        end
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day == "00" then
            self.Label_timing:setTextById("r42008", hour, min)
        else
            self.Label_timing:setTextById("r42007", day, hour)
        end
    end
end

function TaskActivityView:registerEvents()

end

function TaskActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
end

function TaskActivityView:onUpdateProgressEvent()
    self:updateActivity()
end

function TaskActivityView:setBackPlayer()
    self.isBackPlayer = true
end

function TaskActivityView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return TaskActivityView
