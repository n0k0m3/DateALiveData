
local FavorUpView =  class("FavorUpView", BaseLayer)

function FavorUpView:initData(data)
    self.favorValue = data.favorValue or 1
    self.pos = data.pos
end

function FavorUpView:ctor(data)
    self.super.ctor(self)

    self:initData(data)
    self:init("lua.uiconfig.common.favorUpView")
end

function FavorUpView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_fUp = TFDirector:getChildByPath(ui, "Panel_fUp")
    self.Panel_fUp:Pos(self.pos)
    self.Label_goodFeelingTitle = TFDirector:getChildByPath(self.Panel_fUp, "Label_goodFeelingTitle")
    self.Label_goodFeelingValue = TFDirector:getChildByPath(self.Panel_fUp, "Label_goodFeelingValue")

    self.Label_goodFeelingValue:setText("+" .. self.favorValue)

    self:playAction()
end

function FavorUpView:playAction()
    local favorSpwanAc = {
        MoveBy:create(.5,ccp(0,100)),
        FadeOut:create(1.5)
    }
    local function funAc()
        -- AlertManager:closeLayer(self)
        self:removeFromParent()
    end
    local favorAc = {
        Spawn:create(favorSpwanAc),
        CCCallFunc:create(funAc)
    }
    self.Panel_fUp:runAction(CCSequence:create(favorAc))
end

return FavorUpView
