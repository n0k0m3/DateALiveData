--[[--
	spine动画:

	--By: tony.bo
	--2013/7/12
]]

if not TFSkeleton then return end

local function _Done(sender, callback) 
	if callback then
		sender:addMEListener(TFSKELETON_COMPLETE, callback)
	end
end
rawset(TFSkeleton, "OnDone", _Done)

local _bcreate = TFSkeleton.create
function TFSkeleton:create(armaturePath)
	local obj = _bcreate(TFSkeleton, armaturePath)
	if  not obj then return end
	TFUIBase:extends(obj)
	return obj
end

return TFSkeleton