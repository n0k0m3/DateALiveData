
local FubenEndlessJumpView = class("FubenEndlessJumpView", BaseLayer)

function FubenEndlessJumpView:initData()
    self.endlessInfo_ = FubenDataMgr:getEndlessInfo()
end

function FubenEndlessJumpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    ViewAnimationHelper.showPopOpenAnim(self)
    self:init("lua.uiconfig.fuben.fubenEndlessJumpView")
end

function FubenEndlessJumpView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_content = TFDirector:getChildByPath(Image_content, "Label_content")
    self.Button_head = TFDirector:getChildByPath(Image_content, "Button_head")
    self.Label_head = TFDirector:getChildByPath(self.Button_head, "Label_head")
    self.Button_pass = TFDirector:getChildByPath(Image_content, "Button_pass")
    self.Label_pass = TFDirector:getChildByPath(self.Button_pass, "Label_pass")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Label_notice = TFDirector:getChildByPath(Image_content, "Label_notice")

    self:refreshView()
end

function FubenEndlessJumpView:refreshView()
    self.Label_title:setTextById(310019)
    self.Label_head:setTextById(310020)
    self.Label_pass:setTextById(310021)
    self.Label_content:setTextById(310022, self.endlessInfo_.nonStopStage)
    self.Label_tips:setTextById(310023)
    self.Label_notice:setTextById(310024)
end

function FubenEndlessJumpView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_ENDLESS_JUMPLEVEL, handler(self.onJumpLevelEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATEENDLESSINFO, handler(self.onUpdateEndlessInfoEvent, self))

    self.Button_head:onClick(function()
            FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_STAGE(false)
    end)

    self.Button_pass:onClick(function()
            FubenDataMgr:send_ENDLESS_CLOISTER_REQ_START_STAGE(true)
    end)
end

function FubenEndlessJumpView:onJumpLevelEvent(isJump, reward)
    if isJump then
        Utils:showReward(reward)
    end
    AlertManager:closeLayer(self)
end

function FubenEndlessJumpView:onUpdateEndlessInfoEvent()
    local endlessInfo = FubenDataMgr:getEndlessInfo()
    if endlessInfo.step ~= EC_EndlessState.ING then
        AlertManager:closeAllToLayer(self)
    end
end

return FubenEndlessJumpView
