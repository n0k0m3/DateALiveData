
TFClippingNode = CCClippingNode

local _pcreate = CCClippingNode.create
function CCClippingNode:create(stencil)
	local obj = nil
	if stencil then 
		obj = _pcreate(TFClippingNode, stencil)
	else 
		obj = _pcreate(TFClippingNode)
	end
	if  not obj then return end
	TFUIBase:extends(obj)
	return obj
end

local function new(val, parent)
	local obj
	obj = CCClippingNode:create()
	if parent then
		parent:addChild(obj) 
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	if obj then
		obj:initTFClippingNode(val, parent)
	end
	return true, obj
end
rawset(CCClippingNode, "initControl", initControl)

return CCClippingNode