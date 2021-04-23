--[[
    @desc：GuessWordMainView
    @date: 2021-01-13 15:25:32
]]

local GuessWordMainView = class("GuessWordMainView",BaseLayer)

function GuessWordMainView:initData(data)
    self.data = data
    self.giddlesCfg = TabDataMgr:getData("Riddles")
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.GUESS_WORD)
    if #activity <= 0 then
        return
    end
    
    self.activityId = activity[1]
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.sumQuesNum = self.activityInfo_.extendData.question

    self.isNeedRefresh = true
    dump(self.activityInfo_)
end

function GuessWordMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self.block = AlertManager.BLOCK_CLOSE
    self:init("lua.uiconfig.activity.guessWordMainView")
end

function GuessWordMainView:initUI(ui)
    self.super.initUI(self,ui)

    self.contentList = UIListView:create(self._ui.ScrollView_content)

    self.awardList = UIListView:create(self._ui.ScrollView_award)
    self.awardList:setItemsMargin(15)

    local st_year, st_month, st_day = Utils:getDate(self.activityInfo_.startTime)
    local en_year, en_month, en_day = Utils:getDate(self.activityInfo_.showEndTime)
    self._ui.Label_act_time:setTextById(63887, st_month, st_day, en_month, en_day)

    self._ui.Panel_content:hide()
    self._ui.lab_finshAllQues:hide()
    self:refrehUIView(self.data)
end

function GuessWordMainView:registerEvents()
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)
    self._ui.btn_rule:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {17100000})
    end)

    EventMgr:addEventListener(self,EV_RIDDLE_GET_QUESDATA,handler(self.refrehUIView, self))
    EventMgr:addEventListener(self,EV_RIDDLE_ANSAWE_AWARD,handler(self.onRecvGetAward, self))
    
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId == activityId then
            AlertManager:closeLayer(self)
        end
    end)
end

function GuessWordMainView:refrehUIView(data)
    self.keepData = data

    self._ui.lab_lastCanGetAward:setTextById(800005, ActivityDataMgr2:getGuessWorldLeftRewardCountKeep(), self.activityInfo_.extendData.reward)
    if data.type == 1 then
        -- 用于最后收到数据没有题目不再刷新界面 
        if self.lastData and self.lastData.id == self.keepData.id then
            self._ui.Panel_award:hide()
            self._ui.lab_finshAllQues:show()
            return
        end

        if not self.isNeedRefresh then
            return
        end
        
        self.isNeedRefresh = false
        self._ui.Panel_content:setVisible(data.id ~= 0)

        if data.id == 0 then
            return
        end
    else
        self._ui.lab_finshAllQues:hide()
    end

    local cfg = self.giddlesCfg[data.id]
    self.contentList:removeAllItems()
    self.curRightAnswer = tonumber(cfg.correctResult)
    for i, v in ipairs(cfg.options) do
        local item = self._ui.PanelOptionItem:clone()
        TFDirector:getChildByPath(item, "lab_desc"):setTextById(v)
        item.btn_select = TFDirector:getChildByPath(item, "btn_select")
        item.img_default = TFDirector:getChildByPath(item, "img_default")
        item.img_selectError = TFDirector:getChildByPath(item, "img_selectError")
        item.img_correct = TFDirector:getChildByPath(item, "img_correct")
        item.img_default:hide()
        item.img_selectError:hide()
        item.img_correct:hide()
        item.btn_select:show()
        item.btn_select:setTouchEnabled(true)
        item.btn_select:onClick(function()
            ActivityDataMgr2:SEND_ACTIVITY2_REQ_RIDDLE_ONCE(i)
        end)

        self.contentList:pushBackCustomItem(item)
    end

    if data.leftRewardCount > 0 then
        self.awardList:removeAllItems()
        for id, value in pairs(cfg.awards) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.8)
            PrefabDataMgr:setInfo(goods, id, value)
            self.awardList:pushBackCustomItem(goods)
        end
    end

    self._ui.lab_answerSum:setText(data.leftRiddleCount)
    self._ui.lab_titleDesc:setTextById(cfg.name)
    self._ui.lab_titleDesc:setLineHeight(45)
    self._ui.Panel_award:setVisible(data.leftRewardCount > 0)

    self.lastData = data
end

function GuessWordMainView:onRecvGetAward(data)
    if self.curRightAnswer == data.answer then
        for i, item in ipairs(self.contentList:getItems()) do
            item.btn_select:setTouchEnabled(false)
            item.img_default:setVisible(i == data.answer)
            item.img_correct:setVisible(data.answer == i)
            if item.img_correct:isVisible() then
                Utils:playSound(9004, false)
                ViewAnimationHelper.doScaleFadeInAction(item.img_correct, {upscale = 1.2, uptime = 0.1, downtime = 0.05, delay = 0.1})
            end
        end
        self:timeOut(function()
            self.isNeedRefresh = true
            self:refrehUIView(self.keepData)
            if data.rewardsMsg and table.count(data.rewardsMsg) > 0 then
                Utils:showReward(data.rewardsMsg)
            end
        end, 0.5)
    else
        for i, item in ipairs(self.contentList:getItems()) do
            item.btn_select:setTouchEnabled(false)
            item.img_default:setVisible(data.answer == i)
            item.img_selectError:setVisible(data.answer == i)
            item.img_correct:setVisible(false)
            if item.img_selectError:isVisible() then
                Utils:playSound(9005, false)
                ViewAnimationHelper.doScaleFadeInAction(item.img_selectError, {upscale = 1.2, uptime = 0.1, downtime = 0.05, delay = 0.1})
            end

            if i == self.curRightAnswer then
                item.img_correct:runAction(Sequence:create({
                    DelayTime:create(1.0),
                    CallFunc:create(function()
                        item.img_correct:setVisible(true)
                        ViewAnimationHelper.doScaleFadeInAction(item.img_correct, {upscale = 1.2, uptime = 0.1, downtime = 0.05, delay = 0.3})
                    end)
                }))
            end
        end
        self:timeOut(function()
            self.isNeedRefresh = true
            self:refrehUIView(self.keepData)
        end, 2.0)
    end
end

function GuessWordMainView:onShow()
    self.super.onShow(self)
    DatingDataMgr:triggerDating(self.__cname, "onShow")
end

return GuessWordMainView