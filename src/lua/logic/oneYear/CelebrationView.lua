
--[[
    @desc：CelebrationView
]]

local CelebrationView = class("CelebrationView",BaseLayer)

function CelebrationView:initData(activityId)
    self.activityId_ = activityId
end

function CelebrationView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.celebrationView1")
end

function CelebrationView:initUI(ui)
    self.super.initUI(self,ui)

    OneYearDataMgr:Send_GetLuckyList()
    TFDirector:send(c2s.YEAR_LOTTO_REQ_YEAR_LOTTO_INFO, {})
    self:refreshUI()
end

function CelebrationView:refreshUI()
    local activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if activityInfo_ then
        OneYearDataMgr:setStageTimeGroup(activityInfo_.extendData.alternately)
        OneYearDataMgr:setCelebrationRewarsInfo(activityInfo_.extendData.reward)
        self.joinPrize = activityInfo_.extendData.prize
        self.targetValue = activityInfo_.extendData.liveness
        self.livenessId = activityInfo_.extendData.livenessId
        self.robe = activityInfo_.extendData.robe
        self.spreadQq = activityInfo_.extendData.spreadQq
        self._ui.Label_time:setText(Utils:getActivityDateString(activityInfo_.startTime, activityInfo_.endTime))
    end
    self:updateUI()
end

function CelebrationView:updateUI()
    self.count = GoodsDataMgr:getItemCount(self.livenessId)
    self._ui.lab_active:setText(self.count)

    if OneYearDataMgr:isFinishAllApply() then
        self._ui.Label_goto:setTextById(267019)
        self._ui.Button_sign:setTouchEnabled(false)
        self._ui.Button_sign:setGrayEnabled(true)
        if OneYearDataMgr:isOverAllDraw() then
            self._ui.Label_goto:setTextById(14110403)
        end
    else
        if self.count < self.targetValue then
            self._ui.Label_goto:setTextById(267012)
        else
            if OneYearDataMgr:isSign() then
                self._ui.Label_goto:setTextById(267014)
            else
                self._ui.Label_goto:setTextById(267013)
            end
        end
    end
    
    local curIndex = OneYearDataMgr:getCurTurnIndex()
    local curTime = ServerDataMgr:getServerTime()
    local _data = OneYearDataMgr:getStageInfoByIndex(curIndex)
    local alterData = OneYearDataMgr:getalternately()
    local sumIndex = table.count(alterData)
    local beginTime = _data.drawInfo[1].drawTime
    local endTime = _data.drawInfo[#_data.drawInfo].closingTime

    local year, month, day = Utils:getDate(endTime)
    self._ui.lab_desc:setTextById(267016, curIndex, month, day)

    -- 上一轮开奖
    local lastAlterData = alterData[sumIndex]
    local lastTime = lastAlterData.drawInfo[1].drawTime
    if curTime < lastTime then
        curIndex = curIndex - 1
    end
    local _data1 = OneYearDataMgr:getStageInfoByIndex(curIndex)
    if _data1  then 
        beginTime = _data1.drawInfo[1].drawTime
        endTime = _data1.drawInfo[#_data1.drawInfo].closingTime
        if curTime >= beginTime and curTime <= endTime then
            self._ui.lab_desc:setTextById(267017, curIndex)
        end
    end

    if OneYearDataMgr:isOverAllDraw() then
        self._ui.lab_desc:setTextById(267018)
        self._ui.lab_descTime:hide()
    end
end

function CelebrationView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateUI, self))
    EventMgr:addEventListener(self,"applicationWillEnterForeground",handler(self.updateUI, self))
    EventMgr:addEventListener(self, EV_UPDATE_BASE_ONFO, handler(self.updateUI, self))

    self._ui.btn_rule:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {63601})
    end)

    self._ui.Button_rule:onClick(function()
        Utils:openView("oneYear.CelebrationRuleView",self.activityId_)
    end)

    self._ui.Button_lucky_list:onClick(function()
        OneYearDataMgr:setOpenAwardRedHide()
        Utils:openView("oneYear.LuckyListView",self.robe)
    end)

    self._ui.Button_address:onClick(function()
        local prizeId,turnNo = OneYearDataMgr:getPrizeId()
        local award,prizeType,luckyTurnIndex = OneYearDataMgr:getRewardsByPrizeId(prizeId)
        if prizeId == 0 or prizeId == self.joinPrize or prizeType > 3 then
            Utils:showTips(63603)
            return
        end
        Utils:openView("oneYear.AddressView",self.spreadQq)
    end)

    self._ui.Button_sign:onClick(function()
        if OneYearDataMgr:isOverAllDraw() then
            self._ui.Button_sign:setTouchEnabled(false)
            self._ui.Button_sign:setGrayEnabled(true)
            return
        end

        if self.count < self.targetValue then
            FunctionDataMgr:jTask(EC_TaskPage.DAILY)
            return
        end

        local isSign = OneYearDataMgr:isSign()
        if not isSign then
            OneYearDataMgr:Send_sign()
        else
            Utils:showTips(267015)
        end
    end)
end

function CelebrationView:onShow()
    self.super.onShow(self)
    self._ui.Image_red:setVisible(OneYearDataMgr:isOpenAwardRedShow())
end

return CelebrationView