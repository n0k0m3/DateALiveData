
local UnlockMedalView = class("UnlockMedalView", BaseLayer)

function UnlockMedalView:initData(medalId)
    self.medalId = medalId
end

function UnlockMedalView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.playerInfo.unlockMedalView")
end

function UnlockMedalView:initUI(ui)
    self.super.initUI(self, ui)
    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Panel_content = TFDirector:getChildByPath(Panel_root, "Panel_content")
    local Image_medal_icon = TFDirector:getChildByPath(Panel_content, "Image_medal_icon")
    local Label_unlock_medal = TFDirector:getChildByPath(Panel_content, "Label_unlock_medal")
    local Label_unlock_medal_name = TFDirector:getChildByPath(Panel_content, "Label_unlock_medal_name")
    local medalCfg = MedalDataMgr:getMedalCfgById(self.medalId)
    Image_medal_icon:setTexture(medalCfg.showicon)
    Label_unlock_medal:setTextById(2480000)
    Label_unlock_medal_name:setTextById(4007010, TextDataMgr:getText(medalCfg.name))
end

function UnlockMedalView:registerEvents()

end

return UnlockMedalView
