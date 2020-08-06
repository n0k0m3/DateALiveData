
local UnlockAvatarFrame = class("UnlockAvatarFrame", BaseLayer)

function UnlockAvatarFrame:initData(avatarId)
    self.avatarId = avatarId
end

function UnlockAvatarFrame:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.playerInfo.unlockMedalView")
end

function UnlockAvatarFrame:initUI(ui)
    self.super.initUI(self, ui)
    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Panel_content = TFDirector:getChildByPath(Panel_root, "Panel_content")
    local Image_medal_icon = TFDirector:getChildByPath(Panel_content, "Image_medal_icon")
    local Label_unlock_medal = TFDirector:getChildByPath(Panel_content, "Label_unlock_medal")
    local Label_unlock_medal_name = TFDirector:getChildByPath(Panel_content, "Label_unlock_medal_name")
    local cfg = AvatarDataMgr:getAvatarCfgById(self.avatarId)
    Image_medal_icon:setTexture(cfg.icon)
    Label_unlock_medal:setTextById(270300)
    Label_unlock_medal_name:setTextById(270302, TextDataMgr:getText(cfg.name))
end

function UnlockAvatarFrame:registerEvents()

end

return UnlockAvatarFrame
