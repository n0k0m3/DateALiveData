
local FunctionTipsView = class("FunctionTipsView", BaseLayer)

function FunctionTipsView:initData(talkData, finishCallBack, sound)
    self.talkData_ = talkData or {}
    self.finishCallBack = finishCallBack
    self.showIndex_ = 1
    self.touchEnabled_ = false
    self.sound_ = sound or {}
end

function FunctionTipsView:ctor(talkData, finishCallBack, sound)
    self.super.ctor(self)
    self:initData(talkData, finishCallBack, sound)
    self:init("lua.uiconfig.common.functionTipsView")

end

function FunctionTipsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Spine_phone = TFDirector:getChildByPath(self.Panel_root, "Spine_phone")
    self.Panel_talk = TFDirector:getChildByPath(self.Panel_root, "Panel_talk"):hide()
    self.Label_talk = TFDirector:getChildByPath(self.Panel_talk, "Label_talk")

    self:refreshView()
end

function FunctionTipsView:refreshView()
    self.Spine_phone:play("dianhua", false)
    self.Spine_phone:addMEListener(TFARMATURE_COMPLETE, function()
                                       self.Panel_talk:show()
    end)
    self:updateTalk()
end

function FunctionTipsView:updateTalk()
    if self.sound_[self.showIndex_] then
        TFAudio.playSound(self.sound_[self.showIndex_])
    end
    self.touchEnabled_ = false
    self.Label_talk:setTextById(self.talkData_[self.showIndex_])
    self.Label_talk:printer(self.talkData_[self.showIndex_] ,
                            function()
                                return 0.02
                            end,
                            function()
                                self.touchEnabled_ = true
                            end
    )
end

function FunctionTipsView:registerEvents()
    self.Panel_root:onClick(function()
            if self.touchEnabled_ then
                local index = self.showIndex_ + 1
                if index > #self.talkData_ then
                    if self.finishCallBack then
                        self.finishCallBack()
                    end
                    AlertManager:closeLayer(self)
                else
                    self.showIndex_ = index
                    self:updateTalk()
                end
            end
    end)
end

function FunctionTipsView:specialKeyBackLogic( )
    return true
end

return FunctionTipsView
