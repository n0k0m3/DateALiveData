local BackPlayerTipsView = class("BackPlayerTipsView", BaseLayer)

function BackPlayerTipsView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.BackPlayerTipsView")
end

function BackPlayerTipsView:initData(day)
    if day then
        self.day = day
    else
        self.day = 1
    end
end

function BackPlayerTipsView:initUI(ui)
    self.super.initUI(self,ui)


    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")

    self.Label_desc:setTextById(263200, self.day)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_GetRewards = TFDirector:getChildByPath(ui, "Button_GetRewards")

    self.Button_GetRewards:onClick(function()
        Utils:openView("activity.BackPlayerView")
        AlertManager:closeLayer(self)
    end)

    self.Label_playerName = TFDirector:getChildByPath(ui, "Label_playerName")
    self.Label_playerName:setText(MainPlayer:getPlayerName())
   

end

return BackPlayerTipsView
