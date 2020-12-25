--[[--
	spineć§äťś:

	--By: yun.bo
	--2013/8/20
]]


TFSpine = SkeletonAnimation

local _create = TFSpine.create
function TFSpine:create(path, ...)
	local obj
	if path then 
		local acts = ...
		if acts then 
			obj = _create(TFSpine, path, ...) 
		else 
			obj = _create(TFSpine, path) 
		end
	else
		obj = _create(TFSpine) 
	end
	if  not obj then return end
	TFUIBase:extends(obj)
	return obj
end

local function new(val, parent)
	local obj
	if val.spineModel and val.spineModel.SpinePath ~= '' then
		val.spineModel.SpinePath = string.gsub( val.spineModel.SpinePath, ".atlas", "" )
		obj = TFSpine:create(val.spineModel.SpinePath)
	elseif val.path then
		obj = TFSpine:create(val.path)
	elseif val.tSpineProperty and val.tSpineProperty.szFileName ~= "" then
		obj = TFSpine:create(val.tSpineProperty.szFileName)
	end
	if parent and obj then
		parent:addChild(obj)
	end
	return obj
end

local function initControl(_, val, parent)
	local obj = new(val, parent)
	if not obj then return false end
	obj:initMESpine(val, parent)
	return true, obj
end
rawset(TFSpine, "initControl", initControl)

local _animationPlay = TFSpine.play
rawset(TFSpine, "play", function ( self ,name, loop )
	local aniName = TFGlobalUtils:transAniNameByLanguage(self, name)
	_animationPlay(self, aniName, loop)
end)


return TFSpine