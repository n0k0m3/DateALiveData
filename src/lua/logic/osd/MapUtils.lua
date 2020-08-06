--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
* 工具类
* 
]]
local BaseMapParse = import(".BaseMapParse")
local BattleUtils = require("lua.logic.battle.BattleUtils")
local enum = require("lua.logic.battle.enum")
local eDir = enum.eDir

local MapUtils = MapUtils or {}

function MapUtils:getMapParse()
	if not self.mapParse then
		self.mapParse = BaseMapParse:new()
	end
	return self.mapParse
end

function MapUtils:cleanMapParse()
    if self.mapParse then
        self.mapParse:initData()
    end
end

--计算角度
function MapUtils:pGetAngle(origin, other)
    local a2 = me.pNormalize(origin)
    local b2 = me.pNormalize(other)
    local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2) )
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end

--通过方向向量获得角度，注：(0, 0)特殊处理，角度为520
function MapUtils:getAngleByVec(vec)
    if vec.x == 0 and vec.y == 0 then
        return 520
    end

    local angle = 90 - math.atan2(vec.x, vec.y)* 180 / math.pi
    --角度为0-360
    angle = angle + 180
    return angle
end

--通过角度获得方向向量，注：(0, 0)特殊处理，角度为520
function MapUtils:getVecByAngel(angle)
    if angle == 520 then
        return ccp(0, 0)
    end

    --角度为0-360
    angle = angle - 180
    if angle == 0 then
        return ccp(1, 0)
    elseif angle == 90 then
        return ccp(0, 1)
    elseif angle == 180 then
        return ccp(-1, 0)
    elseif angle == -90 then
        return ccp(0, -1)
    else
        local vx = math.cos(angle * math.pi / 180)
        local vy = math.sin(angle * math.pi / 180)
        vx = BattleUtils.round(vx * 100) * 0.01
        vy = BattleUtils.round(vy * 100) * 0.01
        return ccp(vx, vy)
    end
end

function MapUtils:addChild(parent, child, index)
	if parent == nil or parent.addObject == nil  or type(parent.addObject) ~= "function" then
		return 
	end

	if child:getParent() then
        child:retain()
        child:removeFromParent()
        parent:addObject(child, index)
        child:release()
    else
        parent:addObject(child, index)
    end
end

function MapUtils:fadeOut(node)
    if node:numberOfRunningActions() > 0 and node.state == "fadeOut" then
        return
    end

    if node:getOpacity() > 0 then
        node:stopAllActions()
        node:fadeTo(0.2,100)
        node.state = "fadeOut"
    end
end

function MapUtils:fadeIn(node)
    if node:numberOfRunningActions() > 0 and node.state == "fadeIn" then
        return
    end

    if node:getOpacity() < 255 then
        node:stopAllActions()
        node:fadeTo(0.2,255)
        node.state = "fadeIn"
    end
end

function MapUtils:setSkeletonNodeDir(skeletonNode, dir)
    local scaleX = math.abs(skeletonNode:getScaleX())
    if dir == eDir.LEFT then
        skeletonNode:setScaleX(-scaleX)
    else
        skeletonNode:setScaleX(scaleX)
    end
end

return MapUtils
