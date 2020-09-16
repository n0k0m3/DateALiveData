local PackBranchScene = class("PackBranchScene", BaseScene)

function PackBranchScene:ctor(data)
    self.super.ctor(self,data)
	--local layer = require("lua.logic.packbranch.PackBranchLayer"):new(data)
    --self:addChild(layer)
   -- self:retain()
    --DelayCall(function()
    --    me.Director:setTopScene(self)
    --    self:release()
    --end)

    --self.layer = layer
end

function PackBranchScene:onEnter()
	self.super.onEnter(self)

    if not self.___mainLayer then
        local layer = requireNew("lua.logic.packbranch.PackBranchLayer"):new()
        self:addLayer(layer)
        self.___mainLayer = layer;
        --self.___mainLayer:onShow()
    end
end

function PackBranchScene:dispose()
    self.layer:dispose()
end

return PackBranchScene