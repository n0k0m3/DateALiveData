--[[
    @descï¼šTurnTabletBoxView
]]

local TurnTabletBoxView = class("TurnTabletBoxView",BaseLayer)

function TurnTabletBoxView:initData()

end

function TurnTabletBoxView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.twoYearTurnTablet.turnTabletBoxView")
end

function TurnTabletBoxView:initUI(ui)
    self.super.initUI(self,ui)
    self:showPopAnim(true)
end

function TurnTabletBoxView:registerEvents()
    self._ui.btn_cancel:onClick(function(sender)
        sender:setTouchEnabled(false)
        AlertManager:close(self)
    end)

    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.btn_ok:onClick(function(sender)
        sender:setTouchEnabled(false)
        TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_MOVE_NEXT()
        AlertManager:close(self)
    end)
end

return TurnTabletBoxView
