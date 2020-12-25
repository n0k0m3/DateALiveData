
local json = require("LuaScript.extends.json")
local DuanwuSubmitView = class("DuanwuSubmitView", BaseLayer)

function DuanwuSubmitView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_1)
    if #activity > 0 then
        self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        self.submitData_ = self:getSubmitData()
    else
        Utils:showTips("未配置活动类型为%s的活动", EC_ActivityType2.DUANWU_1)
    end

    self.submitNum_ = {1, 1, 1}
end

function DuanwuSubmitView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)

    if ActivityDataMgr2:getActivityUIType() == 1 then
        self:init("lua.uiconfig.activity.midAutumnSubmitView")
    elseif ActivityDataMgr2:getActivityUIType() == 2 then
        self:init("lua.uiconfig.activity.lanternFestivalSubmitView")
    else
        self:init("lua.uiconfig.activity.duanwuSubmitView")
    end
end

function DuanwuSubmitView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    local Image_dating = TFDirector:getChildByPath(Image_content, "Image_dating")
    self.Label_tips = TFDirector:getChildByPath(Image_dating, "Image_tips.Label_tips")
    self.Button_dating = TFDirector:getChildByPath(Image_content, "Button_dating")
    self.img_clickGet = TFDirector:getChildByPath(Image_content, "img_clickGet")
    self.Label_dating = TFDirector:getChildByPath(self.Button_dating, "Label_dating")
    local ScrollView_reward = TFDirector:getChildByPath(Image_dating, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.Image_task = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_content, "Image_task_" .. i)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:AddTo(foo.Panel_reward):Pos(0, 0):Scale(0.85)
        foo.Image_progress = TFDirector:getChildByPath(foo.root, "Image_progress")
        foo.LoadingBar_progress = TFDirector:getChildByPath(foo.Image_progress, "LoadingBar_progress")
        foo.Label_progress = TFDirector:getChildByPath(foo.root, "Label_progress")
        foo.Image_select_num = TFDirector:getChildByPath(foo.root, "Image_select_num")
        foo.Button_down = TFDirector:getChildByPath(foo.Image_select_num, "Button_down")
        foo.Button_up = TFDirector:getChildByPath(foo.Image_select_num, "Button_up")
        foo.Label_num = TFDirector:getChildByPath(foo.Image_select_num, "Label_num")
        foo.Button_submit = TFDirector:getChildByPath(foo.root, "Button_submit")
        foo.Label_submit = TFDirector:getChildByPath(foo.Button_submit, "Label_submit")
        foo.img_resNoEnough = TFDirector:getChildByPath(foo.root, "img_resNoEnough")
        foo.Image_complete = TFDirector:getChildByPath(foo.root, "Image_complete")
        self.Image_task[i] = foo
    end

    self:refreshView()
end

function DuanwuSubmitView:refreshView()
    self.Label_name:setTextById(100000135)
    self.Label_tips:setTextById(100000136)
    self:updateSubmit()
    self:updateDating()
end

function DuanwuSubmitView:getSubmitData()
    local data = {}
    if self.activityId_ then
        data = ActivityDataMgr2:getItems(self.activityId_)
    end
    local submitData = {}
    for i, v in ipairs(data) do
        local itemInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.DUANWU_1, v)
        if itemInfo.extendData.specialTask then
            table.insert(submitData, v)
        end
    end
    return submitData
end

function DuanwuSubmitView:updateSubmit()
    self.submitData_ = self:getSubmitData()
    for i, _ in ipairs(self.Image_task) do
        self:updateSubmitItem(i)
    end
end

function DuanwuSubmitView:updateSubmitItem(index)
    local foo = self.Image_task[index]
    local itemId = self.submitData_[index]
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
    foo.Label_name:setText(itemInfo.extendData.des)
    local rewardCid, rewardNum = next(itemInfo.reward)
    local count = GoodsDataMgr:getItemCount(rewardCid)
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, rewardCid, rewardNum)
    foo.Label_progress:setTextById(800005, progressInfo.progress, itemInfo.target)
    local percent = clamp(progressInfo.progress / itemInfo.target * 100, 0, 100)
    foo.LoadingBar_progress:setPercent(percent)
    local isEnabled = count > 0
    foo.Button_submit:setVisible(progressInfo.status ~= EC_TaskStatus.GETED and isEnabled)
    foo.Button_submit:setTouchEnabled(isEnabled)
    foo.img_resNoEnough:setVisible(not isEnabled)
    foo.Button_down:setTouchEnabled(isEnabled)
    foo.Button_down:setGrayEnabled(not isEnabled)
    foo.Button_up:setTouchEnabled(isEnabled)
    foo.Button_up:setGrayEnabled(not isEnabled)
    foo.Image_progress:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
    foo.Image_select_num:setVisible(progressInfo.status ~= EC_TaskStatus.GETED)
    foo.Image_complete:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    foo.Label_num:setTextById(800005, self.submitNum_[index], GoodsDataMgr:getItemCount(rewardCid))

    if ActivityDataMgr2:getActivityUIType() == 2 then
        if foo.Image_complete:isVisible() then
            foo.root:setTexture("ui/activity/lanternFestival/achievement/001.png")
        else
            foo.root:setTexture("ui/activity/lanternFestival/achievement/006.png")
        end
    end

    foo.Button_submit:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, itemId, self.submitNum_[index])
    end)

    foo.Button_down:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001, "ui_clickSound"))
                self:onTouchButtonDown(index)
                self:continueReduceAction(index)
            end
    end)

    foo.Button_up:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:onTouchButtonUp(index)
                self:continueAddAction(index)
            end
    end)
end

function DuanwuSubmitView:onTouchButtonDown(index)
    local itemId = self.submitData_[index]
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
    local rewardCid, rewardNum = next(itemInfo.reward)
    local count = math.min(itemInfo.target - progressInfo.progress, GoodsDataMgr:getItemCount(rewardCid))

    local num = self.submitNum_[index]
    num = num - 1
    self.submitNum_[index] = clamp(num, 1, count)
    self:updateSubmitItem(index)
end

function DuanwuSubmitView:onTouchButtonUp(index)
    local itemId = self.submitData_[index]
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
    local rewardCid, rewardNum = next(itemInfo.reward)
    local count = math.min(itemInfo.target - progressInfo.progress, GoodsDataMgr:getItemCount(rewardCid))

    local num = self.submitNum_[index]
    num = num + 1
    self.submitNum_[index] = clamp(num, 1, count)
    self:updateSubmitItem(index)
end

function DuanwuSubmitView:continueAddAction(index)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonUp(index)
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function DuanwuSubmitView:continueReduceAction(index)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonDown(index)
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function DuanwuSubmitView:updateDating()
    local extendData = self.activityInfo_.extendData
    local reward = json.decode(extendData.datingAward)

    self.ListView_reward:removeAllItems()
    local flag = extendData.state or 0

    for cid, num in pairs(reward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.6)
        -- 显示状态交换
        if flag == EC_TaskStatus.GET then
            flag = EC_TaskStatus.GETED
            if GoodsDataMgr:getItem(cid) then
                flag = EC_TaskStatus.GET
            end
        elseif flag == EC_TaskStatus.GETED then
            flag = EC_TaskStatus.GET
        end
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {cid, num}, flag)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    Utils:setAliginCenterByListView(self.ListView_reward, true)

    self.Label_dating:setTextById(extendData.state == EC_TaskStatus.GETED and 304006 or 100000137)

    self.Button_dating:setTouchEnabled(extendData.state ~= EC_TaskStatus.ING)
    self.Button_dating:setGrayEnabled(extendData.state == EC_TaskStatus.ING)
    self.img_clickGet:setVisible(extendData.state ~= EC_TaskStatus.ING)
end

function DuanwuSubmitView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_dating:onClick(function()
            FunctionDataMgr:jStartDating(self.activityInfo_.extendData.datingId)
    end)
end

function DuanwuSubmitView:onSubmitSuccessEvent()
    Utils:showTips(100000145)
    self.submitNum_ = {1, 1, 1}
    self:updateSubmit()
end

function DuanwuSubmitView:onUpdateProgressEvent()
    self:updateSubmit()
end

function DuanwuSubmitView:onItemUpdateEvent()
    self:updateSubmit()
end

function DuanwuSubmitView:onUpdateActivityEvent()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self:updateDating()
end

return DuanwuSubmitView
