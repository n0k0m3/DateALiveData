local table = table
local type = type


local tActionFunction = {}
function tActionFunction:getPosAction(target, tween)
	local nDuration = tween.duration
	local actions = {}
	-- Position
	local pos
	if not target then 
		pos = ccp(0, 0)
	else
		pos = target:getPosition()
	end
	local x = tween.x or pos.x
	local y = tween.y or pos.y
	if tween.x or tween.y then
		local act = MoveTo:create(nDuration, ccp(x, y))
		if tween.ease then
			act = tActionFunction:generatEase(tween.ease, act)
		end
		table.insert(actions, act)
	end

	-- 百分比位置
	if tween.px or tween.py then
		local x, y = pos.x, pos.y
		if target and target:getParent() then 
			local pSize = target:getParent():getSize()
			if tween.px then 
				x = pSize.width * tween.px
			end
			if tween.py then 
				y = pSize.height * tween.py
			end
		end
		local act = MoveTo:create(nDuration, ccp(x, y))
		if tween.ease then
			act = tActionFunction:generatEase(tween.ease, act)
		end
		table.insert(actions, act)
	end

	-- by actions

	-- Position
	local x = tween.xBy or pos.x
	local y = tween.yBy or pos.y
	local act
	if tween.xBy or tween.yBy then
		act = MoveBy:create(nDuration, ccp(x, y))
		if tween.ease then
			act = tActionFunction:generatEase(tween.ease, act)
		end
		table.insert(actions, act)
	end

	-- 百分比位置
	if tween.pxBy or tween.pyBy then
		local x, y = pos.x, pos.y
		if target and target:getParent() then 
			local pSize = target:getParent():getSize()
			if tween.pxBy then 
				x = pSize.width * tween.pxBy
			end
			if tween.pyBy then 
				y = pSize.height * tween.pyBy
			end
		end
		act = MoveBy:create(nDuration, ccp(x, y))
		if tween.ease then
			act = tActionFunction:generatEase(tween.ease, act)
		end
		table.insert(actions, act)
	end

	return actions
end

function tActionFunction:getScaleAction(target, tween)
	local nDuration = tween.duration
	local actions = {}
	-- Scale
	if tween.scale and type(tween.scale) == 'number' then
		table.insert(actions, ScaleTo:create(nDuration, tween.scale))
	end
	if tween.scaleX or tween.scaleY then
		local sx, sy = 0, 0
		if target then 
			sx = target:getScaleX()
			sy = target:getScaleY()
		end
		sx = tween.scaleX or sx
		sy = tween.scaleY or sy
		table.insert(actions, ScaleTo:create(nDuration, sx, sy))
	end
	-- by Action
	if tween.scaleBy and type(tween.scaleBy) == 'number' then
		table.insert(actions, ScaleBy:create(nDuration, tween.scaleBy))
	end
	if tween.scaleXBy or tween.scaleYBy then
		local sx, sy = 0, 0
		if target then 
			sx = target:getScaleX()
			sy = target:getScaleY()
		end
		sx = tween.scaleXBy or sx
		sy = tween.scaleYBy or sy
		table.insert(actions, ScaleBy:create(nDuration, sx, sy))
	end
	
	return actions
end

function tActionFunction:getRotateAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.rotate then
		table.insert(actions, RotateTo:create(nDuration, tween.rotate))
	end
	
	-- RotateX
	if tween.rotateX then
		table.insert(actions, RotateTo:create(nDuration, tween.rotateX, 0))
	end
	
	-- RotateY
	if tween.rotateY then
		table.insert(actions, RotateTo:create(nDuration, 0, tween.rotateY))
	
	end
	-- by Action
	if tween.rotateBy then
		table.insert(actions, RotateBy:create(nDuration, tween.rotateBy))
		
	end
	
	-- RotateX
	if tween.rotateXBy then
		table.insert(actions, RotateBy:create(nDuration, tween.rotateXBy, 0))
		
	end
	
	-- RotateY
	if tween.rotateYBy then
		table.insert(actions, RotateBy:create(nDuration, 0, tween.rotateYBy))
		
	end

	return actions
end

function tActionFunction:getJumpAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	local pos
	if not target then 
		pos = ccp(0, 0)
	else
		pos = target:getPosition()
	end
	if tween.jump and type(tween.jump) == 'table' then
		local jx = tween.jump.x or pos.x
		local jy = tween.jump.y or pos.y
		table.insert(actions, JumpTo:create(nDuration, ccp(jx, jy), tween.jump.height, tween.jump.count))
	end

	
	-- by Action
	if tween.jumpBy and type(tween.jumpBy) == 'table' then
		local jx = tween.jumpBy.x or pos.x
		local jy = tween.jumpBy.y or pos.y
		table.insert(actions, JumpBy:create(nDuration, ccp(jx, jy), tween.jumpBy.height, tween.jumpBy.count))
		
	end
	
	return actions
end

function tActionFunction:getProgressAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if target and tween.progress and type(tween.progress) == 'table' then
		--TFProgressFromTo
		if tween.progress.from and tween.progress.to then
			target:setProgressEnabled(true)
			table.insert(actions, TFProgressFromTo:create(nDuration, tween.progress.from, tween.progress.to))
		end

		--TFProgressTo
		if tween.progress.to and tween.progress.from == nil then
			target:setProgressEnabled(true)
			table.insert(actions, TFProgressTo:create(nDuration, tween.progress.to))
		end

		--progress attribute
		if tween.progress.type and target.setType then
			target:setType(tween.progress.type)
		end
		if tween.progress.midPoint and target.setMidPoint then
			target:setMidPoint(tween.progress.midPoint)
		end
		if tween.progress.rate and target.setBarChangeRatePoint then
			target:setBarChangeRatePoint(tween.progress.rate)
		end
		if tween.progress.reverse and target.setReverseProgress then
			target:setReverseProgress(tween.progress.reverse)
		end
	end

	
	-- by Action
	return actions
end

function tActionFunction:getSizeAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if target and (tween.width or tween.height) then
		local width = tween.width or target:getSize().width
		local height =  tween.height or target:getSize().height
		table.insert(actions, SizeTo:create(nDuration, width, height))
	end
	-- size percent
	if target and tween.pwidth and tween.pheight then
		local width, height = target:getSize().width, target:getSize().height
		if target and target:getParent() then 
			local pSize = target:getParent():getSize()
			if tween.pwidth then
				width = pSize.width * tween.pwidth
			end
			if tween.pheight then
				height = pSize.height * tween.pheight
			end
		end
		table.insert(actions, SizeTo:create(nDuration, width, height))
	end

	
	-- by Action
	if target and (tween.widthBy or tween.heightBy) then
		local width = tween.widthBy or target:getSize().width
		local height =  tween.heightBy or target:getSize().height
		table.insert(actions, SizeBy:create(nDuration, width, height))
		
	end
	-- size percent
	if target and (tween.pwidthBy or tween.pheightBy) then
		local width, height = target:getSize().width, target:getSize().height
		if target and target:getParent() then 
			local pSize = target:getParent():getSize()
			if tween.pwidthBy then
				width = pSize.width * tween.pwidthBy
			end
			if tween.pheightBy then
				height = pSize.height * tween.pheightBy
			end
		end
		table.insert(actions, SizeBy:create(nDuration, width, height))
		
	end
	return actions
end

function tActionFunction:getEffectAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.effect then
		local tEffect = tween.effect
		if tEffect.type == "waves" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.waves = tEffect.waves or 5
			tEffect.amplitude = tEffect.amplitude or 40
			local bIsVertical = false
			local bIsHorizontal = false
			if tEffect.isVertical then bIsVertical = true end
			if tEffect.isHorizontal then bIsHorizontal = true end
			table.insert(actions, Waves:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), tEffect.waves, tEffect.amplitude, bIsHorizontal, bIsVertical)	)
		elseif tEffect.type == "waves3d" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.waves = tEffect.waves or 5
			tEffect.amplitude = tEffect.amplitude or 40
			table.insert(actions, Waves3D:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), tEffect.waves, tEffect.amplitude)	)
		elseif tEffect.type == "shaky3d" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.waves = tEffect.range or 5
			if tEffect.shakeZ == nil then tEffect.shakeZ = false end
			table.insert(actions, Shaky3D:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), tEffect.range, tEffect.shakeZ)	)
		elseif tEffect.type == "flipX3d" then
			if tEffect.reverse then 
				table.insert(actions, FlipX3D:create(nDuration):reverse())
			else
				table.insert(actions, FlipX3D:create(nDuration)	)
			end
		elseif tEffect.type == "flipY3d" then
			if tEffect.reverse then 
				table.insert(actions, FlipY3D:create(nDuration):reverse())
			else
				table.insert(actions, FlipY3D:create(nDuration)	)
			end
		elseif tEffect.type == "lens3d" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.position = tEffect.position or {0, 0}
			tEffect.radius = tEffect.radius or 5
			table.insert(actions, Lens3D:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), 
				ccp(tEffect.position[1], tEffect.position[2]), tEffect.radius) )
		elseif tEffect.type == "ripple3D" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.position = tEffect.position or {0, 0}
			tEffect.radius = tEffect.radius or 5
			tEffect.waves = tEffect.waves or 5
			tEffect.amplitude = tEffect.amplitude or 40
			table.insert(actions, Ripple3D:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), 
				ccp(tEffect.position[1], tEffect.position[2]), tEffect.radius, tEffect.waves, tEffect.amplitude)	)
		elseif tEffect.type == "liquid" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.waves = tEffect.waves or 5
			tEffect.amplitude = tEffect.amplitude or 40
			table.insert(actions, Liquid:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), tEffect.waves, tEffect.amplitude))
		elseif tEffect.type == "twirl" then
			tEffect.size = tEffect.size or {1, 1}
			tEffect.position = tEffect.position or {0, 0}
			tEffect.twirls = tEffect.twirls or 5
			tEffect.amplitude = tEffect.amplitude or 40
			table.insert(actions, Twirl:create(nDuration, ccs(tEffect.size[1], tEffect.size[2]), 
				ccp(tEffect.position[1], tEffect.position[2]), tEffect.twirls, tEffect.amplitude) )	
		end
	end

	
	-- by Action
	return actions
end

function tActionFunction:getAlphaAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.alpha then
		tween.alpha = tween.alpha > 1 and 1 or tween.alpha
		tween.alpha = tween.alpha < 0 and 0 or tween.alpha
		local nOpacity = tween.alpha * 255
		table.insert(actions, FadeTo:create(nDuration, nOpacity))
	end

	
	-- by Action
	return actions
end

function tActionFunction:getBezierAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.bezier then
		local config = {}
		local positions = tween.bezier
		config[1] = ccp(positions[1].x, positions[1].y)
		config[2] = ccp(positions[2].x, positions[2].y)
		config[3] = ccp(positions[3].x, positions[3].y)
		table.insert(actions, BezierTo:create(nDuration, config))
	end

	
	-- by Action
	if tween.bezierBy then
		local config = {}
		local positions = tween.bezierBy
		config[1] = ccp(positions[1].x, positions[1].y)
		config[2] = ccp(positions[2].x, positions[2].y)
		config[3] = ccp(positions[3].x, positions[3].y)
		table.insert(actions, BezierBy:create(nDuration, config))
	end
	
	return actions
end

function tActionFunction:getColorAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.color then
		local R, G, B, color = 0, 0, 0, tween.color
		local sign = tween.color / math.abs(tween.color)
		color = tween.color * sign
		R = bit_and(color, 0x00FF0000)
		R = bit_rshift(R, 16) * sign
		G = bit_and(color, 0x0000FF00)
		G = bit_rshift(G, 8) * sign
		B = bit_and(color, 0x000000FF) * sign
		table.insert(actions, TintTo:create(nDuration, R, G, B))
	end

	
	-- by Action
	if tween.colorBy then
		local R, G, B, color = 0, 0, 0, tween.colorBy
		local sign = tween.colorBy / math.abs(tween.colorBy)
		color = tween.colorBy * sign
		R = bit_and(color, 0x00FF0000)
		R = bit_rshift(R, 16) * sign
		G = bit_and(color, 0x0000FF00)
		G = bit_rshift(G, 8) * sign
		B = bit_and(color, 0x000000FF) * sign
		table.insert(actions, TintBy:create(nDuration, R, G, B))
		
	end

	return actions
end

function tActionFunction:getSkewAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.skew and type(tween.skew) == 'number' then
		table.insert(actions, SkewTo:create(nDuration, tween.skew, tween.skew))
	end
	if tween.skewX or tween.skewY then
		local sx, sy = 0, 0
		if target then 
			sx = target:getSkewX()
			sy = target:getSkewY()
		end
		sx = tween.skewX or sx
		sy = tween.skewY or sy
		table.insert(actions, SkewTo:create(nDuration, sx, sy))
	end

	
	-- by Action
	if tween.skewBy and type(tween.skewBy) == 'number' then
		table.insert(actions, SkewBy:create(nDuration, tween.skewBy, tween.skewBy))
		
	end
	if tween.skewXBy or tween.skewYBy then
		local sx, sy = 0, 0
		if target then 
			sx = target:getSkewX()
			sy = target:getSkewY()
		end
		sx = tween.skewXBy or sx
		sy = tween.skewYBy or sy
		table.insert(actions, SkewBy:create(nDuration, sx, sy))
		
	end

	return actions
end

function tActionFunction:getBlinkAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.blink then
		tween.blink = tonum(tween.blink) or 2
		table.insert(actions, Blink:create(nDuration, tween.blink))
	end
	
	-- by Action
	return actions
end

function tActionFunction:getShowAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.show then
		table.insert(actions, Show:create())
	end

	return actions
end

function tActionFunction:getHideAction(target, tween)
	local nDuration = tween.duration
	local actions = {}

	if tween.hide then
		table.insert(actions, Hide:create())
	end

	return actions
end

-- local function getAction(target, tween)
-- 	local nDuration = tween.duration
-- 	local actions = {}


-- 	return actions
-- end

function tActionFunction:generatEase(ease, moveAct)
	local act
	local TFEaseType = require('TFFramework.client.entity.TFEaseType')
	if ease.type == TFEaseType.EASE_IN then
		ease.rate = ease.rate or 1
		act = EaseIn:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_OUT then
		ease.rate = ease.rate or 1
		act = EaseOut:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_IN_OUT then
		ease.rate = ease.rate or 1
		act = EaseInOut:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_EXPONENTIAL_IN then
		act = EaseExponentialIn:create(moveAct)
	elseif ease.type == TFEaseType.EASE_EXPONENTIAL_OUT then
		act = EaseExponentialOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_EXPONENTIAL_IN_OUT then
		act = EaseExponentialInOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_SINE_IN then
		act = EaseSineIn:create(moveAct)
	elseif ease.type == TFEaseType.EASE_SINE_OUT then
		act = EaseSineOut:create(moveAct)	
	elseif ease.type == TFEaseType.EASE_SINE_IN_OUT then
		act = EaseSineInOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_ELASTIC_IN then
		ease.rate = ease.rate or 0.3
		act = EaseElasticIn:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_ELASTIC_OUT then
		ease.rate = ease.rate or 0.3
		act = EaseElasticOut:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_ELASTIC_IN_OUT then
		ease.rate = ease.rate or 0.3
		act = EaseElasticInOut:create(moveAct, ease.rate)
	elseif ease.type == TFEaseType.EASE_BOUNCE_IN then
		act = EaseBounceIn:create(moveAct)
	elseif ease.type == TFEaseType.EASE_BOUNCE_OUT then
		act = EaseBounceOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_BOUNCE_IN_OUT then
		act = EaseBounceInOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_BACK_IN then
		act = EaseBackIn:create(moveAct)
	elseif ease.type == TFEaseType.EASE_BACK_OUT then
		act = EaseBackOut:create(moveAct)
	elseif ease.type == TFEaseType.EASE_BACK_IN_OUT then
		act = EaseBackInOut:create(moveAct)
	end
	return act
end

return tActionFunction