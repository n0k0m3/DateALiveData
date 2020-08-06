
local PauseView = class("PauseView", BaseLayer)
CREATE_SCENE_FUN(PauseView)
function PauseView:ctor(...)
    self.super.ctor(self, ...)
    self:init("lua.uiconfig.battle.pauseView")
    -- self:timeOut(function(  )
    --         TFDirector:pause()
    -- end,0.5)

end

function PauseView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root    = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_resume = TFDirector:getChildByPath(self.Panel_root, "Button_resume")
    self.Button_exit   = TFDirector:getChildByPath(self.Panel_root, "Button_exit")
    --章节名称
    self.Label_title   = TFDirector:getChildByPath(self.Panel_root, "Label_title")

end

function PauseView:registerEvents()
    self.Button_resume:addMEListener(TFWIDGET_CLICK, function()
        -- AlertManager:close()
        -- TFDirector:resume()
        TFDirector:popScene()
    end)

    self.Button_exit:addMEListener(TFWIDGET_CLICK, function()
       -- EventMgr:dispatchEvent(BattleConfig.EVENT_EXIT)
       -- TFDirector:resume()
    end)
end
-- function PauseView:scene()
--     local scene = CCScene:create()
--     return scene
-- end

return PauseView
