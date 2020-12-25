local JoinTipView = class("JoinTipView",BaseLayer)

function JoinTipView:initData()

end

function JoinTipView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.iphone.joinTipView")
end

function JoinTipView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Label_joinTip1 = TFDirector:getChildByPath(ui,"Label_joinTip1")
    self.Label_joinTip2 = TFDirector:getChildByPath(ui,"Label_joinTip2")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self.Label_joinTip1:setTextById(63061)
    self.Label_joinTip2:setTextById(63062)


    self:initUILogic()
end

function JoinTipView:initUILogic()

    local isWebSite = self:isOfficialWebsite()

    local posY = isWebSite and 31 or 0
    self.Label_joinTip1:setPositionY(posY)

    self.Label_joinTip2:setVisible(isWebSite)
end

function JoinTipView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function JoinTipView:isOfficialWebsite()

    local platformId = 0
    if HeitaoSdk then
        platformId = HeitaoSdk.getplatformId() % 10000
    end

    return platformId == 101 or platformId == 173 or platformId == 682
end


return JoinTipView