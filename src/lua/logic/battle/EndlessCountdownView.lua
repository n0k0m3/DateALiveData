local enum        = import(".enum")
local eEvent      = enum.eEvent
local BattleTimerManager = import(".BattleTimerManager")
local EndlessCountdownView = class("EndlessCountdownView", BaseLayer)

function EndlessCountdownView:initData(callback)
    self.callback_ = callback
    self.endlessInfo_ = FubenDataMgr:getEndlessInfo()
    self.endlessCfg_ = FubenDataMgr:getEndlessCloisterLevelCfg(self.endlessInfo_.curStage)
end

function EndlessCountdownView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.endlessCountdownnView")
end

function EndlessCountdownView:initUI(ui)
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

function EndlessCountdownView:refreshView()
    self.Label_goto:setTextById("r83001", self.endlessCfg_.order)

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

function EndlessCountdownView:registerEvents()
    self.Button_continue:onClick(function()
            self.callback_()
    end)

    self.Button_exit:onClick(function()
            EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            AlertManager:closeLayer(self)
    end)
end

function EndlessCountdownView:removeEvents()
    if self.countdownTimer_ then
        BattleTimerManager:removeTimer(self.countdownTimer_)
        self.countdownTimer_ = nil
    end
end

return EndlessCountdownView
