
local ValentineTaskView = class("ValentineTaskView", BaseLayer)

function ValentineTaskView:initData(roleCid)
    self.roleCid_ = roleCid
    self.roleCfg_ = ValentineDataMgr:getValentineRoleCfg(self.roleCid_)
    self.roleModelCfg_ = TabDataMgr:getData("CityRoleModel", self.roleCfg_.cityRole)

    self.activityInfo_ = ValentineDataMgr:getActivityInfo()

    self.condData_ = {}
    for i, v in ipairs(self.roleCfg_.dating) do
        local datingRuleCfg = TabDataMgr:getData("DatingRule", v)
        local _, num = next(datingRuleCfg.enter_condition.item)
        self.condData_[i] = num
    end

    self.taskItems_ = {}
    self.tacitItems_ = {}
    self.maxTacit_ = math.max(unpack(self.condData_))

end

function ValentineTaskView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.valentine.valentineTaskView")
end

function ValentineTaskView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_taskItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_taskItem")
    self.Panel_tacitItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tacitItem")

    local Image_gift = TFDirector:getChildByPath(self.Panel_root, "Image_gift")
    self.Button_gift = TFDirector:getChildByPath(Image_gift, "Button_gift")
    self.Label_gift = TFDirector:getChildByPath(self.Button_gift, "Label_gift")
    self.Panel_role = TFDirector:getChildByPath(Image_gift, "Panel_role")
    self.img_labDi  = TFDirector:getChildByPath(Image_gift, "img_labDi")
    self.lab_role   =  TFDirector:getChildByPath(self.img_labDi, "lab_role")
    self.Panel_role:setBackGroundColorType(0)
    local Image_tacit_task = TFDirector:getChildByPath(self.Panel_root, "Image_tacit_task")
    self.Image_tacit_icon = TFDirector:getChildByPath(Image_tacit_task, "Image_tacit_icon")
    self.Label_tacit_name = TFDirector:getChildByPath(Image_tacit_task, "Label_tacit_name")
    self.Label_tacit_count = TFDirector:getChildByPath(Image_tacit_task, "Image_tacit_count.Label_tacit_count")
    self.Image_progress = TFDirector:getChildByPath(Image_tacit_task, "Image_progress")
    self.LoadingBar_progress = TFDirector:getChildByPath(self.Image_progress, "LoadingBar_progress")
    local Image_scrollBar = TFDirector:getChildByPath(self.Panel_root, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_task = TFDirector:getChildByPath(self.Panel_root, "ScrollView_task")
    self.ListView_task = UIListView:create(ScrollView_task)
    self.ListView_task:setScrollBar(scrollBar)

    self:refreshView()
end

function ValentineTaskView:refreshView()
    self.Label_gift:setTextById(1710008)

    self.Spine_role = SkeletonAnimation:create(self.roleModelCfg_.rolePath)
    -- self.Spine_role:setScale(0.8)
    self.Panel_role:addChild(self.Spine_role)
    self.Spine_role:play(self.roleCfg_.action, true)

    self:initTacitTask()
    self:showTask()
    self:addRoleShowLab()
end

function ValentineTaskView:showTask()
    self.taskData_ = ValentineDataMgr:getTask(self.roleCid_)

    local items = self.ListView_task:getItems()
    local gap = #self.taskData_ - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addTaskItem()
        else
            self.ListView_task:removeItem(1)
        end
    end

    for i, v in ipairs(self.taskData_) do
        self:updateTaskItem(i)
    end

    self:updateTacitTask()
end

function ValentineTaskView:addRoleShowLab()
    local count = table.count(self.roleCfg_.word)
    self.lab_role:setTextById(self.roleCfg_.word[math.random(1,count)])
    if not self.timer then
        self.timer = TFDirector:addTimer(5000,-1, nil,function()
            local action = Sequence:create({
                ScaleTo:create(0.3,0),
                CallFunc:create(function()
                    self.lab_role:setTextById(self.roleCfg_.word[math.random(1,count)])
                end),
                ScaleTo:create(0.3,1)
            })
            self.img_labDi:stopAllActions()
            self.img_labDi:runAction(action)
        end)
    end
end

function ValentineTaskView:updateTaskItem(index)
    local item = self.ListView_task:getItem(index)
    local foo = self.taskItems_[item]
    local itemId = self.taskData_[index]
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemId)

    foo.Image_icon:setTexture(itemInfo.extendData.icon)
    foo.Label_desc:setText(itemInfo.extendData.des2)
    foo.Label_reward:setTextById(1890003)

    local goodsId, goodsNum
    for i, v in ipairs(foo.Panel_goodsItem) do
        local id, num = next(itemInfo.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end
        v:setVisible(tobool(id))
        if v:isVisible() then
            PrefabDataMgr:setInfo(v, goodsId, goodsNum)
        end
    end

    foo.Button_receive:setVisible(progressInfo.status == EC_TaskStatus.GET)
    foo.Label_already_received:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    foo.Image_ing:setVisible(progressInfo.status == EC_TaskStatus.ING)

    foo.Button_receive:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, itemId)
    end)
end

function ValentineTaskView:addTaskItem()
    local Panel_taskItem = self.Panel_taskItem:clone()
    local foo = {}
    foo.root = Panel_taskItem
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_title = TFDirector:getChildByPath(foo.root, "Label_title")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Label_reward = TFDirector:getChildByPath(foo.root, "Label_reward")
    foo.Panel_goodsItem = {}
    for i = 1, 3 do
        local Image_reward = TFDirector:getChildByPath(foo.root, "Image_reward_" .. i)
        foo.Panel_goodsItem[i] = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem[i]:Pos(0, 0):Scale(0.55):AddTo(Image_reward)
    end
    foo.Button_receive = TFDirector:getChildByPath(foo.root, "Button_receive")
    foo.Label_receive = TFDirector:getChildByPath(foo.Button_receive, "Label_receive")
    foo.Label_already_received = TFDirector:getChildByPath(foo.root, "Label_already_received")
    foo.Image_ing = TFDirector:getChildByPath(foo.root, "Image_ing")
    self.ListView_task:pushBackCustomItem(foo.root)

    self.taskItems_[foo.root] = foo
end

function ValentineTaskView:initTacitTask()
    local size = self.Image_progress:Size()

    for i, v in ipairs(self.roleCfg_.dating) do
        local foo = {}
        foo.root = self.Panel_tacitItem:clone()
        foo.Button_geted = TFDirector:getChildByPath(foo.root, "Button_geted")
        foo.Label_geted = TFDirector:getChildByPath(foo.Button_geted, "Label_geted")
        foo.Button_canGet = TFDirector:getChildByPath(foo.root, "Button_canGet")
        foo.Label_canGet = TFDirector:getChildByPath(foo.Button_canGet, "Label_canGet")
        foo.Button_notGet = TFDirector:getChildByPath(foo.root, "Button_notGet")
        foo.Label_notGet = TFDirector:getChildByPath(foo.Button_notGet, "Label_notGet")
        foo.Label_getValue = TFDirector:getChildByPath(foo.root, "Label_getValue")
        self.tacitItems_[i] = foo

        foo.Label_getValue:setText(self.condData_[i])
        local percent = self.condData_[i] / self.maxTacit_
        foo.root:Pos(size.width * percent - 25, -15):AddTo(self.Image_progress, 15)

        local chineseNum = Utils:getChineseNumber(i)
        local name = TextDataMgr:getText(1702084, chineseNum)
        foo.Label_geted:setText(name)
        foo.Label_canGet:setText(name)
        foo.Label_notGet:setText(name)

        -- 最后一个改为cg图标
        if i == table.count(self.roleCfg_.dating) then
            local iconRes = ValentineDataMgr:getValentineRoleCfg(self.roleCid_).showReward
            foo.Button_canGet:setTextureNormal(iconRes)
            foo.Button_geted:setTextureNormal(iconRes)
            foo.Button_notGet:setTextureNormal(iconRes)
            foo.Label_geted:setVisible(false)
            foo.Label_canGet:setVisible(false)
            foo.Label_notGet:setVisible(false)
        end
    end
end

function ValentineTaskView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_GIFT, handler(self.onGiftEvent, self))
    EventMgr:addEventListener(self, EV_VALENTINE_COMPLETE_DATING, handler(self.onDatingCompleteEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_VALENTINE_RANK_UPDATE, handler(self.updateTacitTask, self))
    
    self.Button_gift:onClick(function()
            Utils:openView("valentine.ValentineGiftView", self.roleCid_)
            -- ValentineDataMgr:getTask(self.roleCid_)
    end)

    self.Spine_role:addMEListener(
        TFARMATURE_COMPLETE,
        function(_, aniName)
            if aniName == self.keepActionName then
                self.Spine_role:play(self.roleCfg_.action, true)
            end
        end
    )

    for i, v in ipairs(self.tacitItems_) do
        local datingCid = self.roleCfg_.dating[i]
        v.Button_geted:onClick(function()
                FunctionDataMgr:jStartDating(datingCid)
        end)

        v.Button_notGet:onClick(function()
                Utils:showTips(1702082)
        end)

        v.Button_canGet:onClick(function()
                FunctionDataMgr:jStartDating(datingCid)
        end)
    end
end

function ValentineTaskView:updateTacitTask()
    local tacit = ValentineDataMgr:getFullServerTacit(self.roleCid_)
    self.Label_tacit_count:setText(tacit)

    local percent = math.min(tacit / self.maxTacit_ * 100, 100)
    self.LoadingBar_progress:setPercent(percent)

    for i , v in ipairs(self.tacitItems_) do
        local cond = self.condData_[i]
        local datingCid = self.roleCfg_.dating[i]
        local isReach = tacit >= cond
        local isComplete = ValentineDataMgr:getDatingIsComplete(datingCid)
        v.Button_geted:hide()
        v.Button_canGet:hide()
        v.Button_notGet:hide()
        if isComplete then
            v.Button_geted:show()
        else
            v.Button_canGet:setVisible(isReach)
            v.Button_notGet:setVisible(not isReach)
        end
    end
end

function ValentineTaskView:onGiftEvent()
    ValentineDataMgr:send_VALENTINE_VALENTINE_RANK()
    local tmpRand = self.roleCfg_.happyIdle[math.random(1, table.count(self.roleCfg_.happyIdle))]
    self.keepActionName = tmpRand
    self.Spine_role:play(tmpRand, false)
end

function ValentineTaskView:onDatingCompleteEvent()
    self:updateTacitTask()
end

function ValentineTaskView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityInfo_.id ~= activitId then return end
    Utils:showReward(reward)
end

function ValentineTaskView:onUpdateProgressEvent()
    self:showTask()
end

function ValentineTaskView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

return ValentineTaskView
