
local CelebrationLuckyTipView = class("CelebrationLuckyTipView", BaseLayer)

function CelebrationLuckyTipView:initData()

end

function CelebrationLuckyTipView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.celebrationLuckyTipView")
end

function CelebrationLuckyTipView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Label_hero_name = TFDirector:getChildByPath(self.Panel_root, "Label_hero_name")
    self.Image_head = TFDirector:getChildByPath(self.Panel_root, "Image_head")
    self.Label_message = TFDirector:getChildByPath(self.Panel_root, "Label_message")

    self:refreshView()
end

function CelebrationLuckyTipView:refreshView()

    OneYearDataMgr:setLuckyTipFlag()

    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(101)
    self.Image_head:setTexture(roleInfo.icon)
    self.Label_hero_name:setTextById(roleInfo.nameId)

    local prizeId,turnNo = OneYearDataMgr:getPrizeId()
    local award,prizeType,luckyTurnIndex = OneYearDataMgr:getRewardsByPrizeId(prizeId)
    local str
    if prizeType == 1 then
        str = TextDataMgr:getText(63593)
    elseif prizeType == 2 then
        str = TextDataMgr:getText(63594)
    else
        str = TextDataMgr:getText(267009)
    end
    self.Label_message:setTextById(63604,str)
end

function CelebrationLuckyTipView:registerEvents()
    self.Panel_root:onClick(function()
        AlertManager:close()
    end)
end

return CelebrationLuckyTipView
