
local ChronoCrossDating = class("ChronoCrossDating", BaseLayer)

function ChronoCrossDating:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.chronoCross.chronoCrossDating")
end

function ChronoCrossDating:initData()

    local cgCfg = Utils:getKVP(46018)
    self.firstDialog = cgCfg.guideDialog
    self.guideDatingId = cgCfg.guideDatingId
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local freshItem = json.decode(self.activityInfo_.extendData.reversalFcost)
        for k,v in pairs(freshItem) do
            self.freshNeedCnt = v
            self.refreshItemId = tonumber(k)
            break
        end
        self.reversalFrame = self.activityInfo_.extendData.reversalFrame
        self.reversalTitle = self.activityInfo_.extendData.reversalTitle
    else
        Box("活动未开启")
        return
    end

    ---动画参数
    self.animateTab = {up = 1,down = 0.1,waite = 1.1,toblack = 0.75,stay = 1.2,tonormal = 1,scaleTime = 0.55,scaleNum = 1.2}

    ---锁定，可进入，次数耗尽
    self.datingBtnRes = {"s1.png","s2.png","s3.png"}

    self.bgResIndex = 1
    self.bgRes = {"a1.png","a2.png","a3.png","a4.png","a5.png","a6.png"}
    --ui/ChronoCros/dating/bg/
    self.posInfo = {}
    self.posInfo[1] = {ccp(-434,42),ccp(186,109),ccp(381,-17),ccp(11,-194),ccp(-134,36)}
    self.posInfo[2] = {ccp(-115,147),ccp(379,111),ccp(58,-40),ccp(217,-144),ccp(-224,-65)}
    self.posInfo[3] = {ccp(-283,-68),ccp(-177,148),ccp(270,122),ccp(391,-160),ccp(42,-33)}
    self.posInfo[4] = {ccp(26,86),ccp(-258,45),ccp(-109,-88),ccp(116,-174),ccp(284,-1)}
end


function ChronoCrossDating:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bottom = TFDirector:getChildByPath(self.Panel_root, "Image_bottom")
    self.Button_jump = TFDirector:getChildByPath(Image_bottom, "Button_jump")
    self.LoadingBar = TFDirector:getChildByPath(Image_bottom, "LoadingBar")

    self.Spine_jump = TFDirector:getChildByPath(Image_bottom, "Spine_jump")
    self.Spine_up = TFDirector:getChildByPath(Image_bottom, "Spine_up")
    self.Panel_spineBg = TFDirector:getChildByPath(Image_bottom, "Panel_spineBg")
    self.Spine_bar = TFDirector:getChildByPath(Image_bottom, "Spine_bar")
    self.originalSize = self.Panel_spineBg:getContentSize()
    self.Image_redtip = TFDirector:getChildByPath(Image_bottom, "Image_redtip")

    self.Label_fresh = TFDirector:getChildByPath(Image_bottom, "Label_fresh")
    self.Label_tips_single = TFDirector:getChildByPath(Image_bottom, "Label_tips_single")
    self.Label_tips_total = TFDirector:getChildByPath(Image_bottom, "Label_tips_total")
    self.Label_barnum = TFDirector:getChildByPath(Image_bottom, "Label_barnum")
    self.Image_barnum = TFDirector:getChildByPath(Image_bottom, "Image_barnum")
    self.Image_tips_bg = TFDirector:getChildByPath(Image_bottom, "Image_tips_bg"):hide()

    self.Label_btn = TFDirector:getChildByPath(Image_bottom, "Label_btn")
    self.Label_btn:setSkewX(15)
    self.Label_tip = TFDirector:getChildByPath(Image_bottom, "Label_tip"):hide()
    self.Label_chargetiem = TFDirector:getChildByPath(Image_bottom, "Label_chargetiem")
    self.Label_chargetiem:setText("")
    self.Button_record = TFDirector:getChildByPath(Image_bottom, "Button_record")
    self.Button_charge = TFDirector:getChildByPath(Image_bottom, "Button_charge")
    self.Label_charge = TFDirector:getChildByPath(self.Button_charge, "Label_charge")

    self.Label_title_cn = TFDirector:getChildByPath(self.Panel_root, "Label_title_cn")
    self.Label_title_en = TFDirector:getChildByPath(self.Panel_root, "Label_title_en")
    self.Label_title_en:setTextById(13310344)
    self.Panel_screen = TFDirector:getChildByPath(self.Panel_root, "Panel_screen")
    self.Panel_screen:setSize(GameConfig.WS)
    self.Panel_screen:setOpacity(0)
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)

    self.Panel_bg = TFDirector:getChildByPath(self.Panel_root, "Panel_bg")
    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Image_bg2 = TFDirector:getChildByPath(self.Panel_root, "Image_bg2")
    self.Image_bg2:setTexture("ui/ChronoCros/dating/bg/"..self.bgRes[self.bgResIndex])

    self.Panel_layout = TFDirector:getChildByPath(self.Panel_root, "Panel_layout")
    self.Panel_button = TFDirector:getChildByPath(self.Panel_root, "Panel_button")
    self.Button_date = TFDirector:getChildByPath(self.Panel_layout, "Button_date")
    self.Spine_finish = TFDirector:getChildByPath(self.Panel_button, "Spine_finish"):hide()
    self.Spine_dating = TFDirector:getChildByPath(self.Panel_layout, "Spine_dating"):hide()

    self.Image_state = TFDirector:getChildByPath(self.Panel_layout, "Image_state")
    self.Label_datingName = TFDirector:getChildByPath(self.Image_state, "Label_datingName")

    self.tabTask = {}
    for i=1,4 do
        local Panel_task = TFDirector:getChildByPath(self.Panel_layout, "Panel_task"..i)
        local Button_canget = TFDirector:getChildByPath(Panel_task, "Button_canget")
        local Button_geted = TFDirector:getChildByPath(Panel_task, "Button_geted")
        local Button_notfinish = TFDirector:getChildByPath(Panel_task, "Button_notfinish")
        local Spine_ing = TFDirector:getChildByPath(Panel_task, "Spine_ing"):hide()
        local Panel_canget = TFDirector:getChildByPath(Panel_task, "Panel_canget")
        table.insert(self.tabTask,{pl = Panel_task, cangetBtn = Button_canget,getedBtn = Button_geted,
                                   nofinishBtn = Button_notfinish,Panel_canget =Panel_canget,Spine_ing = Spine_ing,taskId = 0})
    end

    TFDirector:send(c2s.ACTIVITY_REQ_RECOVER_TIME,{})

    self:timeOut(function()
        self:checkTaskState()
        local isGuidPlay = ChronoCrossDataMgr:isPlayed(self.guideDatingId)
        local isPlay = ChronoCrossDataMgr:isPlayed(self.firstDialog)
        if isGuidPlay and isPlay then
            local count = GoodsDataMgr:getItemCount(self.refreshItemId)
            if count >= self.freshNeedCnt and (not next(self.notFinishTask)) then
                ChronoCrossDataMgr:setDialogPlayState(true)
                local function callback()
                    self:refreshTask()
                end
                Utils:openView("chronoCross.ChronoTaskConfirmView",1,callback)
            end
        end
    end)

    self:playBg()
    self:updateBottom()
    self:updateMainView(self.reversalFrame)
end

function ChronoCrossDating:playBg()

    local act = CCSequence:create({
        CCDelayTime:create(20),
        CCFadeOut:create(3),
        CCCallFunc:create(function()
            self.bgResIndex = self.bgResIndex + 1
            if self.bgResIndex > #self.bgRes then
                self.bgResIndex = 1
            end
            self.Image_bg2:setTexture("ui/ChronoCros/dating/bg/"..self.bgRes[self.bgResIndex])
        end),
        CCFadeIn:create(3),
    })

    self.Image_bg2:runAction(CCRepeatForever:create(act))
end

function ChronoCrossDating:checkRecordState()

    self.handAccount_ = DfwDataMgr:getHandAccount(EC_HadleAccountType.ChronoCross)
    self.handAccountCfg  = DfwDataMgr:getHandAccountCfg(self.handAccount_[1])

    local isFinishDating = DatingDataMgr:checkScriptIdIsFinish(self.handAccountCfg.dating)
    local isFinish= true
    for k,v in ipairs(self.handAccountCfg.piece) do
        local num = GoodsDataMgr:getItemCount(v)
        if num <= 0 then
            isFinish = false
            break
        end
    end
    self.Image_redtip:setVisible((not isFinishDating) and isFinish)
end

function ChronoCrossDating:checkTaskState()

    self.notFinishTask = {}
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
    for k,taskId in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, taskId)
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.Special then
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, taskId)
            if progressInfo.status ~= EC_TaskStatus.GETED then
                table.insert(self.notFinishTask,taskId)
            end
        elseif itemInfo.extendData.type == EC_ChronoCrossTaskType.Date or itemInfo.extendData.type == EC_ChronoCrossTaskType.Extra_Date then
            if itemInfo.extendData.state ~= EC_ChronoCrossDatingStatus.Finish then
                table.insert(self.notFinishTask,taskId)
            end
        end
    end

end

function ChronoCrossDating:onShow()
    self.super.onShow(self)
    self:playCg()
end

function ChronoCrossDating:playCg()

    local state = ChronoCrossDataMgr:getDialogPlayState()
    if state then
        return
    end
    self:checkTaskState()
    local isPlay = ChronoCrossDataMgr:isPlayed(self.guideDatingId)
    if not isPlay then
        DatingDataMgr:startDating(self.guideDatingId)
        ChronoCrossDataMgr:saveDialogId(self.guideDatingId)
    else
        self:onFinishFirstDialog()
    end

end

function ChronoCrossDating:updateBottom(isUpdate,addValue)

    addValue = addValue or 0
    local itemCfg = GoodsDataMgr:getItemCfg(self.refreshItemId)
    local num = GoodsDataMgr:getItemCount(self.refreshItemId)
    local percent = math.floor(num/itemCfg.totalMax*100)
    local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemCfg.buyItemRecover)
    local recoverCnt = itemRecoverCfg.recover_count
    self.Label_barnum:setText("充能："..num.."/"..itemCfg.totalMax)
    if not isUpdate then
        self.LoadingBar:setPercent(percent)
        self.num = num
        self.Label_fresh:setText("时间跳跃消耗:"..self.freshNeedCnt.."点")
        local count = GoodsDataMgr:getItemCount(self.refreshItemId)
        self.Button_jump:setTouchEnabled(count >= self.freshNeedCnt)
        self.Button_jump:setGrayEnabled(count < self.freshNeedCnt)
        self.Button_charge:setVisible(count < self.freshNeedCnt)
        self:checkRecordState()
    else
        if num - self.num > recoverCnt then
            Utils:playSound(5021)
        end
        self.Button_jump:setTouchEnabled(false)
        Utils:progressToEx(self.LoadingBar, self.animateTab.up, percent, function()
            self.num = num
            self.Label_fresh:setText("时间跳跃消耗:"..self.freshNeedCnt.."点")
            local count = GoodsDataMgr:getItemCount(self.refreshItemId)
            self.Button_jump:setTouchEnabled(count >= self.freshNeedCnt)
            self.Button_jump:setGrayEnabled(count < self.freshNeedCnt)
            self.Button_charge:setVisible(count < self.freshNeedCnt)
            self:checkRecordState()
        end)
    end

end

function ChronoCrossDating:afterRefresh()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    local freshItem = json.decode(self.activityInfo_.extendData.reversalFcost)
    local itemId,needCnt
    for k,v in pairs(freshItem) do
        self.freshNeedCnt = v
        self.refreshItemId = tonumber(k)
        break
    end
    self.reversalFrame = self.activityInfo_.extendData.reversalFrame
    self.reversalTitle = self.activityInfo_.extendData.reversalTitle
    self:updateMainView(self.reversalFrame)
    self:onUpdateLastFreshTime()
end

function ChronoCrossDating:updateMainView(layoutId)

    if layoutId < 1 or layoutId > 4 then
        layoutId = 1
    end

    self.lastLayOutId = layoutId

    self.Label_title_cn:setTextById(self.reversalTitle)

    local itemCfg = GoodsDataMgr:getItemCfg(self.refreshItemId)
    local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemCfg.buyItemRecover)
    local buyCount = StoreDataMgr:getItemRecoverBuyCount(itemCfg.buyItemRecover)
    local remainCount = math.max(0, #itemRecoverCfg.price - buyCount)
    local str = remainCount <= 0 and "次数用尽" or "补充能量"
    self.Label_charge:setText(str)
    self.Button_charge:setTouchEnabled(remainCount > 0)
    self.Button_charge:setGrayEnabled(remainCount <= 0)

    self:updateAllTaskItem()
end

function ChronoCrossDating:updateAllTaskItem()

    self.taskData = {}
    self.datingTask = {}
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
    for k,v in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.Special then
            table.insert(self.taskData,v)
        elseif itemInfo.extendData.type == EC_ChronoCrossTaskType.Date or itemInfo.extendData.type == EC_ChronoCrossTaskType.Extra_Date then
            table.insert(self.datingTask,v)
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self.datingState = itemInfo.extendData.state
            local res = "CG_1_2.png"
            if self.datingState == EC_ChronoCrossDatingStatus.Ing then
                res = "CG_1_3.png"
            elseif self.datingState == EC_ChronoCrossDatingStatus.Finish then
                res = "CG_1_1.png"
            end
            self.Spine_finish:setVisible(self.datingState == EC_ChronoCrossDatingStatus.Finish)
            self.Spine_dating:setVisible(self.datingState == EC_ChronoCrossDatingStatus.Ing)
            self.Button_date:setTextureNormal("ui/ChronoCros/dating/"..res)
            self.Panel_button:setPosition(self.posInfo[self.lastLayOutId][5])

            self.Image_state:setTexture("ui/ChronoCros/dating/s"..(self.datingState+1)..".png")
            self.Label_datingName:setText(itemInfo.extendData.des)
            local color = self.datingState == EC_ChronoCrossDatingStatus.Finish and ccc3(172,185,221) or ccc3(255,255,255)
            self.Label_datingName:setColor(color)
        end
    end
    self:updateSpecialTask()
end

function ChronoCrossDating:updateSpecialTask()

    local tab = {}
    for k,v in ipairs(self.tabTask) do
        v.pl:setVisible(false)
        local taskId = self.taskData[k]
        if taskId then
            v.taskId = taskId
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, taskId)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, taskId)
            if itemInfo and progressInfo then
                v.pl:setVisible(true)
                v.pl:setPosition(self.posInfo[self.lastLayOutId][k])
                v.Panel_canget:setVisible(progressInfo.status == EC_TaskStatus.GET)
                v.getedBtn:setVisible(progressInfo.status == EC_TaskStatus.GETED)
                v.nofinishBtn:setVisible(progressInfo.status == EC_TaskStatus.ING)
                local Label_btntip = v.nofinishBtn:getChildByName("Label_btntip")
                Label_btntip:setText(itemInfo.extendData.des)
                v.Spine_ing:setVisible(false)
                for i=1,4 do
                    local line = TFDirector:getChildByPath(v.pl, "Image_line"..i)
                    line:setVisible(i==self.lastLayOutId)
                end
                if progressInfo.status == EC_TaskStatus.ING then
                    table.insert(tab,v.Spine_ing)
                end
            end
        end
    end

    if next(tab) then
        local index= math.random(1,#tab)
        tab[index]:setVisible(true)
    end
end

function ChronoCrossDating:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId_ ~= activitId then return end
    Utils:showReward(reward)
    self:updateAllTaskItem()
end

function ChronoCrossDating:onUpdateProgressEvent()
    self:updateAllTaskItem()
end

function ChronoCrossDating:playFreshAnimat()

    self.Panel_layout:setScale(1)
    local delayAct = CCDelayTime:create(self.animateTab.waite)
    local act = CCSpawn:create({
        CCScaleTo:create(self.animateTab.toblack,2),
        CCCallFunc:create(function()
            self.Panel_screen:runAction(CCFadeIn:create(self.animateTab.toblack))
        end)
    })
    local callfunc = CCCallFunc:create(function()
        self:afterRefresh()
    end)
    local delayAct1 = CCDelayTime:create(self.animateTab.stay)
    local act2 = CCSpawn:create({
        CCScaleTo:create(self.animateTab.tonormal,1),
        CCCallFunc:create(function()
            self.Panel_screen:runAction(CCFadeOut:create(self.animateTab.tonormal))
            self.Panel_touch:setVisible(false)
            self.Panel_layout:runAction(CCFadeIn:create(self.animateTab.tonormal))
        end)
    })
    self.Panel_root:runAction(CCSequence:create({delayAct,act,callfunc,delayAct1,act2}))
end

---刷新任务
function ChronoCrossDating:onRefreshEntrustEvent()

    self.Panel_touch:setVisible(true)
    local itemCfg = GoodsDataMgr:getItemCfg(self.refreshItemId)
    local num = GoodsDataMgr:getItemCount(self.refreshItemId)
    local percent = math.floor(num/itemCfg.totalMax*100)
    self.Label_barnum:setText("充能："..num.."/"..itemCfg.totalMax)
    local w = self.originalSize.width*num/itemCfg.totalMax
    local barX = 425 * num/itemCfg.totalMax
    self.Spine_bar:setPositionX(barX)
    self.Panel_spineBg:setContentSize(CCSizeMake(w, self.originalSize.height))
    self.Spine_up:play("evt_effect_chDatingJump_1",false)
    self.Spine_bar:play("evt_effect_chDatingJump_2",false)
    self.Spine_jump:play("evt_effect_chDatingJump_3",false)

    local count = GoodsDataMgr:getItemCount(self.refreshItemId)
    self.Button_jump:setTouchEnabled(count >= self.freshNeedCnt)
    self.Button_jump:setGrayEnabled(count < self.freshNeedCnt)
    self.Button_charge:setVisible(count < self.freshNeedCnt)

    TFDirector:send(c2s.ACTIVITY_REQ_RECOVER_TIME,{})

    Utils:playSound(5020)
    self:progressDown(self.LoadingBar, self.animateTab.down, percent, function()
        self:playFreshAnimat()
    end)
end


function ChronoCrossDating:progressDown(bar, duration, endValue, callback)
    local shadowBar = bar.shadowBar
    if not shadowBar then
        shadowBar = bar:clone()
        shadowBar:setTexture("ui/common/progress_05.png")
        local position = bar:getPosition()
        position.y = position.y
        shadowBar:setPosition(position)
        local originSize = bar:getSize()
        local size = CCSizeMake(originSize.width + 10, 26)
        shadowBar:setSize(size)
        shadowBar:setZOrder(0)
        bar:getParent():addChild(shadowBar)
        bar.shadowBar = shadowBar
    end
    bar.callback = callback
    shadowBar:setPercent(bar:getPercent())
    shadowBar:setVisible(true)
    shadowBar:setOpacity(255)
    --shadowBar:runAction(FadeIn:create(duration + 0.3))
    bar:setPercent(endValue)
    self:timeOut(function()
        Utils:progressTo(
                shadowBar, duration, endValue,
                function()
                    shadowBar:runAction(FadeOut:create(duration + 0.3))
                    if bar.callback then
                        bar.callback()
                    end
                end
        )
    end,0.3)
end

function ChronoCrossDating:onUpdateLastFreshTime()

    local lastFreeTime = ChronoCrossDataMgr:getLastRefreshTime()
    if not lastFreeTime then
        return
    end
    
    self.Label_tip:setVisible(true)
    local itemCfg = GoodsDataMgr:getItemCfg(self.refreshItemId)
    if not itemCfg then
        return
    end
    local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemCfg.buyItemRecover)
    local coolTime = itemRecoverCfg.cooldown
    local recoverCnt = itemRecoverCfg.recover_count
    local num = GoodsDataMgr:getItemCount(self.refreshItemId)
    local needTime = (itemCfg.totalMax - num)/recoverCnt*coolTime
    self.endTime = lastFreeTime + needTime

    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, self.endTime - serverTime)
    if remainTime <= 0 then
        self.Label_tips_total:setText("")
    end

    --self.Label_tips_single:setText("每"..coolTime.."秒恢复"..recoverCnt.."点")
    self.Label_tips_single:setTextById(13310345)

    --local perRemainTime = math.max(0,lastFreeTime + coolTime - serverTime)
    --if perRemainTime <= 0 then
    --    self.Label_tips_single:setText("")
    --    TFDirector:send(c2s.ACTIVITY_REQ_RECOVER_TIME,{})
    --end

    local act = CCSequence:create({
        CCCallFunc:create(function()
            local serverTime = ServerDataMgr:getServerTime()
            local remainTime = math.max(0, self.endTime - serverTime)
            local day, hour, min,sec = Utils:getDHMS(remainTime, true)
            self.Label_tips_total:setTextById(800051, hour, min,sec)
            if remainTime <= 0 then
                self.Label_tips_total:setText("")
            end
            --local perRemainTime = math.max(0,lastFreeTime + coolTime - serverTime)
            --local day, hour, min, sec = Utils:getDHMS(perRemainTime, true)
            --self.Label_tips_single:setTextById(800050, min, sec)
            --if perRemainTime <= 0 then
            --    self.Label_tips_single:setText("")
            --end
        end),
        CCDelayTime:create(1),
    })
    self.Image_barnum:runAction(CCRepeatForever:create(act))
end

function ChronoCrossDating:refreshTask()
    self.animateTab = {up = 0.75,down = 1,waite = 0.8,toblack = 0.75,stay = 1.2,tonormal = 1,scaleTime = 0.75,scaleNum = 1.3}
    local count = GoodsDataMgr:getItemCount(self.refreshItemId)
    if count < self.freshNeedCnt then
        Utils:showTips(13210018)
        return
    end
    local act = CCSequence:create({
        CCSpawn:create({
            CCScaleTo:create(self.animateTab.scaleTime,self.animateTab.scaleNum),
            CCFadeOut:create(self.animateTab.scaleTime)
        }),
        CCCallFunc:create(function()
            TFDirector:send(c2s.ACTIVITY_REQ_REFRESH_ENTRUST_ACTIVITY_TASK,{self.activityId_ ,3})
        end)
    })
    self.Panel_layout:runAction(act)

end

function ChronoCrossDating:onFinishFirstDialog()

    local isPlay = ChronoCrossDataMgr:isPlayed(self.firstDialog)
    if not isPlay then
        ChronoCrossDataMgr:playCg(self.firstDialog,function()
            local count = GoodsDataMgr:getItemCount(self.refreshItemId)
            if count >= self.freshNeedCnt and (not next(self.notFinishTask)) then
                ChronoCrossDataMgr:setDialogPlayState(true)
                local function callback()
                    self:refreshTask()
                end
                Utils:openView("chronoCross.ChronoTaskConfirmView",1,callback)
            end
        end)
    end

end

function ChronoCrossDating:showOrHideRecoverTime()
    local isVisible = self.Image_tips_bg:isVisible()
    self.Image_tips_bg:setVisible(not isVisible)
    if isVisible == false then
        local act = CCSequence:create({
            CCDelayTime:create(5),
            CCFadeOut:create(0.6),
            CCCallFunc:create(function ()
                self.Image_tips_bg:stopAllActions()
                self.Image_tips_bg:setVisible(false)
                self.Image_tips_bg:setOpacity(255)
            end)
        })
        self.Image_tips_bg:runAction(act)
    end
end

function ChronoCrossDating:registerEvents()

    --EventMgr:addEventListener(self, EV_DATING_EVENT.cityDatingTips, handler(self.onFinishFirstDialog, self))
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onUpdateLastFreshTime, self))
    EventMgr:addEventListener(self, EV_UPDATE_LASTTIME, handler(self.onUpdateLastFreshTime, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.onRefreshEntrustEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateBottom, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_jump:onClick(function()
        self:checkTaskState()
        if next(self.notFinishTask) then
            local function callback()
                self:refreshTask()
            end
            Utils:openView("chronoCross.ChronoTaskConfirmView",2,callback)
        else
            self:refreshTask()
        end
    end)

    self.Button_record:onClick(function()
        Utils:openView("chronoCross.ChronoPuzzleView")
    end)

    self.Button_charge:onClick(function()

        local count = GoodsDataMgr:getItemCount(self.refreshItemId)
        local itemCfg = GoodsDataMgr:getItemCfg(self.refreshItemId)
        if count >= itemCfg.totalMax then
            Utils:showTips(800024)
            return
        end

        local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemCfg.buyItemRecover)
        local buyCount = StoreDataMgr:getItemRecoverBuyCount(itemCfg.buyItemRecover)
        local remainCount = math.max(0, #itemRecoverCfg.price - buyCount)
        if remainCount <= 0 then
            Utils:showTips(303041)
            return
        end
        self.cost = itemRecoverCfg.price[buyCount + 1][1]
        local costCfg = GoodsDataMgr:getItemCfg(self.cost[1].id)
        local count = GoodsDataMgr:getItemCount(self.cost[1].id)
        if count < self.cost[1].num then
            Utils:showAccess(self.cost[1].id)
            return
        end
        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_ChronoCross) then
            StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(itemCfg.buyItemRecover)
        else
            local rstr = TextDataMgr:getTextAttr(13310336)
            local formatStr = rstr and rstr.text or ""
            local content = string.format(formatStr, self.cost[1].num, costCfg.icon)
            local args = {
                tittle = 13310335,
                content = content,
                reType = EC_OneLoginStatusType.ReConfirm_ChronoCross,
                confirmCall = function()
                    StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(itemCfg.buyItemRecover)
                end,
            }
            Utils:showReConfirm(args)
        end
    end)

    self.Button_date:onClick(function()
        Utils:openView("chronoCross.ChronoCrossConfirmView",self.datingTask[1])
    end)

    for _,taskInfo in ipairs(self.tabTask) do
        taskInfo.cangetBtn:onClick(function()
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_,taskInfo.taskId)
        end)
        taskInfo.getedBtn:onClick(function()
            Utils:openView("chronoCross.ChronoCrossConfirmView",taskInfo.taskId)
        end)
        taskInfo.nofinishBtn:onClick(function()
            Utils:openView("chronoCross.ChronoCrossConfirmView",taskInfo.taskId)
        end)
    end
    self:setBackBtnCallback(function()
        ChronoCrossDataMgr:setDialogPlayState(false)
        AlertManager:closeLayer(self)
    end)
    self:setMainBtnCallback(function()
        ChronoCrossDataMgr:setDialogPlayState(false)
        AlertManager:closeLayer(self)
    end)

    self.Image_barnum:onClick(function()
        self.Image_tips_bg:stopAllActions()
        self:showOrHideRecoverTime()
    end)
end

return ChronoCrossDating
