local enum        = import(".enum")
local eEvent      = enum.eEvent
local BattleTimerManager = import(".BattleTimerManager")
local EndlessPlusCountdownView = class("EndlessPlusCountdownView", BaseLayer)

function EndlessPlusCountdownView:initData(callback)
    self.callback_ = callback
end

function EndlessPlusCountdownView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.endlessCountdownnView")
end

function EndlessPlusCountdownView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.LoadingBar_time = TFDirector:getChildByPath(Image_content, "Image_progress.LoadingBar_time")
    self.Label_goto = TFDirector:getChildByPath(Image_content, "Label_goto")
    self.Label_countDown = TFDirector:getChildByPath(Image_content, "Label_countDown")
    self.Button_continue = TFDirector:getChildByPath(Image_content, "Button_continue")
    self.Button_exit = TFDirector:getChildByPath(Image_content, "Button_exit")

    self:refreshView()
end

function EndlessPlusCountdownView:refreshView()
    --self.Label_goto:setTextById("r83001", self.endlessCfg_.order)

    local time = 3000
    local count = 100
    local delay = time / count
    local percent = 0
    self.countdownTimer_ = BattleTimerManager:addTimer(
            delay, count,
            self.callback_,
            function()
                percent = percent + 1
                time = math.max(0, time - delay)
                self.LoadingBar_time:setPercent(percent)
                local timeStr = string.format("%.1f", time / 1000)
                self.Label_countDown:setTextById(800040, timeStr)
            end
    )
    self.LoadingBar_time:setPercent(percent)
    self.Label_countDown:setTextById(800040, time)
end

function EndlessPlusCountdownView:exit()

    if self.countdownTimer_ then
        BattleTimerManager:stopTimer(self.countdownTimer_)
    end

    local confirmCall= function()
        FubenEndlessPlusDataMgr:Send_ExitChallenge()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        AlertManager:closeLayer(self)
    end

    local cancleCall = function()
        if self.countdownTimer_ then
            BattleTimerManager:startTimer(self.countdownTimer_)
        end
    end

    local rstr = TextDataMgr:getTextAttr(15010266)
    local formatStr = rstr and rstr.text or ""
    local showData = {}
    showData.tittle = 13311184
    showData.content = formatStr
    showData.confirmCall = confirmCall
    showData.cancleCall = cancleCall
    showData.showCancle = true
    showData.showClose = false
    showData.showPopAnim = false
    Utils:openView("common.ReConfirmTipsView", showData)

end

function EndlessPlusCountdownView:registerEvents()
    self.Button_continue:onClick(function()
        self.callback_()
    end)

    self.Button_exit:onClick(function()
        self:exit()
    end)
end

function EndlessPlusCountdownView:removeEvents()
    if self.countdownTimer_ then
        BattleTimerManager:removeTimer(self.countdownTimer_)
        self.countdownTimer_ = nil
    end
end

return EndlessPlusCountdownView
