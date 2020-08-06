local DeleteFrientsView = class("DeleteFrientsView", BaseLayer)

local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function DeleteFrientsView:ctor(data)
    self.super.ctor(self)

    self:init("lua.uiconfig.playerInfo.DeleteFrientsView")
end

function DeleteFrientsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_cancle = TFDirector:getChildByPath(self.ui,"Button_cancle")
    self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
    self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")

end

function DeleteFrientsView:registerEvents()
    self.Button_cancle:onClick(function()
        AlertManager:close()
    end,
    EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
        MainPlayer:sendDeleteFriends(self.id)
        AlertManager:close()
    end,
    EC_BTN.CLOSE)

    self.Button_close:onClick(function()

        AlertManager:close()
    end,
    EC_BTN.CLOSE)
end

return DeleteFrientsView