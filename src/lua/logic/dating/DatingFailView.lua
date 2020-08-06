local DatingFailView = class("DatingFailView",BaseLayer)

function DatingFailView:initData(closeCallBack)
    self.closeCallBack = closeCallBack
end

function DatingFailView:ctor(closeCallBack)
    self.super.ctor(self,closeCallBack)

    self:initData(closeCallBack)
    self:init("lua.uiconfig.dating.datingFailView")
end

function DatingFailView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    VoiceDataMgr:playVoice("dating_lose",RoleDataMgr:getCurId())

    self:enterAction()
end

function DatingFailView:registerEvents()
    self.super.registerEvents(self)

end

function DatingFailView:onClose()
    self.super.onClose(self)
end

function DatingFailView:enterAction()
    self.ui:timeOut(function()
            if self.closeCallBack then
                self.closeCallBack()
            end
        end,2)
end

return DatingFailView;
