local LogoutView = class("LogoutView", BaseLayer)

local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function LogoutView:ctor(data)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.logoutView")
end

function LogoutView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(self.ui,"Button_ok")
    self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")

end

function LogoutView:registerEvents()

    self.Button_ok:onClick(function()
        --登出
        -- if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
        --     HeitaoSdk.loginOut();
        --     return
        -- end
        CommonManager:closeConnection2();
    end,
    EC_BTN.CLOSE)

    self.Button_close:onClick(function()
        AlertManager:close()
    end,
    EC_BTN.CLOSE)
end

return LogoutView