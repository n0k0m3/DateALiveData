
local CatchDollUIView = class("CatchDollUIView", BaseLayer)

function CatchDollUIView:ctor(scene)
    self.super.ctor(self)
    self:init("lua.uiconfig.miniGame.catchDollUIView")

    self:setBackBtnCallback(function ()
        CatchDollDataMgr:endGame()

        scene:saveToyPos()
    end)
end

return CatchDollUIView
