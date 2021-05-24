--[[
    @desc：PicWallTaskView
    @date: 2021-03-08 17:07:05
]]

local PicWallTaskView = class("PicWallTaskView",BaseLayer)

function PicWallTaskView:initData(activityId)
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.cfgTaskIds = self.activityInfo.items
    dump(self.activityInfo)

    self.newProgeressIdx = table.count(self.cfgTaskIds)   -- 最新进度位置
    for i, id  in ipairs(self.cfgTaskIds) do
        local taskInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.PIC_TASK_ACTIVITY, id)
        local isTimeIn = self:isCurTimeInSection(taskInfo.extendData.stime, taskInfo.extendData.etime)
        if not isTimeIn then
            self.newProgeressIdx = i
            break
        end
    end

    self.scrollViewItems = {}
    
    self.isPassedData = {state = nil, idx = nil}
end

function PicWallTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.picWallTaskView")
end

function PicWallTaskView:initUI(ui)
    self.super.initUI(self,ui)

    local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
    self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)
    self._ui.act_timeStart:setSkewX(self.activityInfo.extendData.skewX)
    self._ui.act_timeEnd:setSkewX(self.activityInfo.extendData.skewX)
    self._ui.act_time:setSkewX(10)

    self:initScrollView()
    self:scrollByPanelIdx(self.newProgeressIdx)
end

function PicWallTaskView:initScrollView()
    self._ui.scrollView_pic:removeAllChildren()
    self.panel_picWall = self._ui.panel_picWall:clone()
    self._ui.scrollView_pic:setInnerContainerSize(self.panel_picWall:getContentSize())
    self._ui.scrollView_pic:addChild(self.panel_picWall)
    self.panel_picWall:setPosition(ccp(0,0))
    for i = 1, table.count(self.panel_picWall:getChildren()) do
        local foo = {}
        local panelWall = self.panel_picWall:getChildByName("panelWall_"..i)
        foo.root = panelWall
        foo.img_bg = TFDirector:getChildByPath(foo.root, "img_bg")
        foo.btn_receiveTask = TFDirector:getChildByPath(foo.img_bg, "btn_receiveTask")
        foo.lab_taskIng = TFDirector:getChildByPath(foo.img_bg, "lab_taskIng")
        foo.img_lock = TFDirector:getChildByPath(foo.root, "img_lock")
        foo.lab_lockDesc = TFDirector:getChildByPath(foo.img_lock, "lab_lockDesc")
        foo.img_cg = TFDirector:getChildByPath(foo.root, "img_cg")
        foo.img_complete = TFDirector:getChildByPath(foo.img_cg, "img_complete")
        foo.img_blink = TFDirector:getChildByPath(foo.root, "img_blink")

        foo.img_blink:hide()
        self.scrollViewItems[i] = foo
    end 

    self:updateScrollViewItems()
end

function PicWallTaskView:isCurTimeInSection(stime, etime)
    local isTimeIn = true
    if stime and etime then
        local beginTime = stime / 1000
        local endTime = etime / 1000
        local curTime = ServerDataMgr:getServerTime()
        if curTime < beginTime or curTime > endTime then
            isTimeIn = false
        end
    end
    return isTimeIn
end

function PicWallTaskView:updateScrollViewItems()
    for i, item in ipairs(self.scrollViewItems) do
        local curStatus = EC_TASK_STATUS.Lock
        local taskId = self.cfgTaskIds[i]
        local taskInfo = ActivityDataMgr2:getItemInfo(EC_ActivityType2.PIC_TASK_ACTIVITY, taskId)
        item.root:setVisible(nil ~= taskId)
        if taskInfo then
            local taskStatus = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.PIC_TASK_ACTIVITY, taskId).status
            
            -- 本来是服务器不下发操作，后面改成前端判断
            local isTimeIn = self:isCurTimeInSection(taskInfo.extendData.stime, taskInfo.extendData.etime)
            
            
            item.lab_lockDesc:setText(taskInfo.details)
            if taskId then
                if isTimeIn then
                    local isFinshDating = true
                    if taskInfo.extendData.dating1 then
                        isFinshDating = DatingDataMgr:checkScriptIdIsFinish(taskInfo.extendData.dating1)
                    end
                    if not isFinshDating then
                        curStatus = EC_TASK_STATUS.UnAccept
                    end

                    if isFinshDating and taskStatus == EC_TaskStatus.ING then
                        curStatus = EC_TASK_STATUS.Ing
                    end

                    if taskStatus == EC_TaskStatus.GET then
                        curStatus = EC_TASK_STATUS.NotReceve
                    end

                    if taskStatus == EC_TaskStatus.GETED then
                        curStatus = EC_TASK_STATUS.Complete
                    end
                end

                item.img_lock:setVisible(curStatus == EC_TASK_STATUS.Lock)
                
                item.img_bg:setVisible(curStatus == EC_TASK_STATUS.UnAccept or curStatus == EC_TASK_STATUS.Ing)
                item.btn_receiveTask:setVisible(curStatus == EC_TASK_STATUS.UnAccept)
                if item.btn_receiveTask:isVisible() then
                    item.btn_receiveTask:setSwallowTouch(false)
                end
                
                item.lab_taskIng:setVisible(curStatus == EC_TASK_STATUS.Ing)
                item.lab_taskIng:setText(taskInfo.extendData.des2)
                item.img_cg:setVisible(curStatus == EC_TASK_STATUS.NotReceve or curStatus == EC_TASK_STATUS.Complete)
                if item.img_cg:isVisible() then
                    item.img_cg:setTexture(taskInfo.extendData.icon)
                end

                item.img_complete:setVisible(curStatus == EC_TASK_STATUS.NotReceve)

                item.img_blink:setVisible(curStatus == EC_TASK_STATUS.UnAccept or curStatus == EC_TASK_STATUS.NotReceve)
                self:setRunBlinkAction(item, curStatus)

                item.root:setTouchEnabled(true)
                item.root:setSwallowTouch(true)
                item.root:onClick(function()
                    self:picWallPanelClickFunc(curStatus, taskInfo, i)
                end)

                -- 约会成功 自动弹窗
                if self.isPassedData.idx and self.isPassedData.idx == i and self.isPassedData.state ~= curStatus then
                    self:picWallPanelClickFunc(curStatus, taskInfo , i)
                    self.isPassedData = {state = nil, idx = nil}
                end
            end
        end
    end
    self._ui.scrollView_pic:doLayout()
end

function PicWallTaskView:setRunBlinkAction(target, status)
    target.img_blink:stopAllActions()
    if not target.img_blink:isVisible() then
        return
    end

    local size
    local pos = ccp(0, 0)
    if status == EC_TASK_STATUS.UnAccept then
        size = target.img_bg:getSize()
        if size.width > size.height then
            size = ccs(size.width + 30, size.height + 20)
        else
            size = ccs(size.width + 35, size.height + 15)
            pos = ccp(6, 0)
        end
    elseif status == EC_TASK_STATUS.NotReceve then
        size = target.img_cg:getSize()
        size = ccs(size.width + 25, size.height + 10)
    end

    target.img_blink:setSize(size)
    target.img_blink:setPosition(pos)
    local actions = {
        FadeOut:create(1.0),
        FadeIn:create(1.0)
    }
    target.img_blink:runAction(RepeatForever:create(Sequence:create(actions)))
end

function PicWallTaskView:registerEvents()
    self._ui.btn_left:onClick(function(sender)
        self._ui.scrollView_pic:scrollToLeft(0.5)
    end)

    self._ui.btn_right:onClick(function(sender)
        self._ui.scrollView_pic:scrollToRight(0.5)
    end)

    self._ui.scrollView_pic:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.scrollingFun, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.closeSriptView, handler(self.updateScrollViewItems, self))
end

function PicWallTaskView:scrollingFun(sender)
    if not self.panel_picWall then
        return
    end

    if not self.maxScrollXOffset then
        self.maxScrollXOffset =  sender:getContentSize().width - self.panel_picWall:getContentSize().width
    end
    local offsetX = self._ui.scrollView_pic:getContentOffset().x
    -- 允许20像素的容错
    self._ui.btn_left:setVisible(offsetX < -20)
    self._ui.btn_right:setVisible(offsetX > (self.maxScrollXOffset + 20))
end

function PicWallTaskView:scrollByPanelIdx(idx)
    local item = self.scrollViewItems[idx]
    if not item then
        return
    end
    local posX = item.root:getPosition().x
    local sumWidth = self.panel_picWall:getContentSize().width

    -- 第一个和最后一个特殊处理跳转
    if idx == 1 then
        posX = 0
        self._ui.btn_left:hide()
    elseif idx == table.count(self.scrollViewItems) then
        posX = sumWidth
        self._ui.btn_right:hide()
    end
    
    local per = posX/sumWidth * 100 
    self._ui.scrollView_pic:jumpToPercentHorizontal(-per)
end

function PicWallTaskView:picWallPanelClickFunc(status, taskInfo, idx)
    if status == EC_TASK_STATUS.UnAccept then
        self.isPassedData = {state = status, idx = idx}
        DatingDataMgr:startDating(taskInfo.extendData.dating1)
        return
    elseif status == EC_TASK_STATUS.NotReceve then
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, taskInfo.id)
        if taskInfo.extendData.dating2 then
            DatingDataMgr:startDating(taskInfo.extendData.dating2)
        end
        return
    end

    Utils:openView("activity.PicWallTaskPopView",status, taskInfo)
end

function PicWallTaskView:onUpdateProgressEvent()
    self:updateScrollViewItems()
end

function PicWallTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
end

return PicWallTaskView