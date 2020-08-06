local SkyLadderTipView = class("SkyLadderTipView", BaseLayer)

function SkyLadderTipView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.skyladder.skyladderTipView")
end

function SkyLadderTipView:initData()

end

function SkyLadderTipView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Button_ok = TFDirector:getChildByPath(self.Panel_root, "Button_ok")

    self.Label_content = TFDirector:getChildByPath(self.Panel_root, "Label_content")
    self.Label_content:setTextById(3203010)

    self.Label_tips = TFDirector:getChildByPath(self.Panel_root, "Label_tips")
    self.Label_tips:setTextById(3203011)

    SkyLadderDataMgr:clearLastCircleRankList()
end

function SkyLadderTipView:registerEvents()

    self.Button_ok:onClick(function()
        Utils:openView("skyLadder.SkyLadderZonesView")
        AlertManager:closeLayer(self)
    end)
end

return SkyLadderTipView