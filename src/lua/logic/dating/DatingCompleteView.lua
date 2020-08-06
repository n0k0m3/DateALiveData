local DatingCompleteView = class("DatingCompleteView",BaseLayer)

function DatingCompleteView:initData(closeCallBack)
    self.closeCallBack = closeCallBack
end

function DatingCompleteView:ctor(closeCallBack)
    self.super.ctor(self,closeCallBack)

    self:initData(closeCallBack)
    self:init("lua.uiconfig.dating.datingCompleteView")
end

function DatingCompleteView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui
    self:enterAction()
    self.panelTouchFunc = function()
        if self.closeCallBack then
            self.closeCallBack()
        end
        AlertManager:closeLayer(self)
    end
    self.ui:timeOut(self.panelTouchFunc,1)
end

function DatingCompleteView:enterAction()
    self.ui:runAnimation("Action0",1)
end

function DatingCompleteView:specialKeyBackLogic( )
    GuideDataMgr:setPlotLvlBackState(false)
    self:panelTouchFunc()
    return true
end

return DatingCompleteView;
