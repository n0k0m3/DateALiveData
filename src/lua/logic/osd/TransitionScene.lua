--[[同屏基础场景]]

local TransitionScene = class("TransitionScene", BaseScene)

function TransitionScene:ctor(...)
    self.super.ctor(self, ...)
end

function TransitionScene:onEnter()
	self.super.onEnter(self)
	self:addView()
end

function TransitionScene:addView()
	local size       = me.size(me.EGLView:getDesignResolutionSize())
    local textScaleX = TFLabel:create()
    -- textScaleX:setText("正在进入下一个场景")
    textScaleX:setText("")
    textScaleX:setFontSize(30)
    textScaleX:Pos(size.width/2, size.height/2)
    textScaleX:setAnchorPoint(ccp(0.5,0.5))
	self:addChild(textScaleX)

end

function TransitionScene:onExit()
    self.super.onExit(self)
end
return TransitionScene
