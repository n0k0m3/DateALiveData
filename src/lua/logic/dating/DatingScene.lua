local DatingScene = class("DatingScene",BaseScene)
DatingConfig = require("lua.logic.dating.DatingConfig")

function DatingScene:ctor(isMiniGameOver)
	self.super.ctor(self,isMiniGameOver)

    self.isMiniGameOver = isMiniGameOver


    SpineCache:getInstance():clearUnused();
    me.FrameCache:removeUnusedSpriteFrames()
    -- EventMgr:addEventListener(self, EV_CATCHDOLL_END, handler(self.onMiniGameEnd, self))
end


function DatingScene:onEnter()
	AlertManager:closeAll();

    if self.isMiniGameOver then
        self:onMiniGameEnd()
    else
        RoleDataMgr:selectRole(RoleDataMgr:getUseId())
        local layer = require("lua.logic.dating.RoleInfoLayer"):new()
        AlertManager:addLayer(layer)
        AlertManager:show()
        self.___mainLayer = layer
    end
end

function DatingScene:onMiniGameEnd()
    print("onMiniGameEnd")
    DatingDataMgr:showDatingLayer()
end

function DatingScene:onShow()
    self.super.onShow(self)
end

function DatingScene:onClose()
    RoleDataMgr:selectRole()
end

return DatingScene;