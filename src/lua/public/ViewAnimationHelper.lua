ViewAnimationHelper = {}

--[[
	闪烁动画
]]
function ViewAnimationHelper.doflashAction(node, duration, opacity)
	if node == nil then return end
    local aniTime = duration or 0.3
    opacity = opacity or 0
    local act1 = CCFadeTo:create(aniTime, opacity)
    local act2 = CCFadeTo:create(aniTime, 255)

    node:runAction(CCRepeatForever:create(CCSequence:create({EaseSineInOut:create(act1), EaseSineInOut:create(act2)})))
end

--[[
	闪烁同时放大
]]
function ViewAnimationHelper.doFlashAndScaleAction(node, duration, scale)
	if node == nil then return end
    local act1 =  CCScaleBy:create(duration, scale)
    local act2 = act1:reverse()
    local temp1 = CCSequence:create({EaseSineIn:create(act1), EaseSineOut:create(act2)})

    local act3 = CCFadeTo:create(duration, 0)
    local act4 = CCFadeTo:create(duration, 255)
    local temp2 = CCSequence:create({EaseSineIn:create(act3), EaseSineOut:create(act4)})
    local spawn = CCSpawn:create({temp1, temp2})

    node:runAction(CCRepeatForever:create(spawn))
end	

--[[
    翻转动画
]]
function ViewAnimationHelper.doCameraAction(inNode, outNode, duration, callback)
    if inNode == nil or outNode == nil then return end
    local time = duration * 0.5
    
    local carema1 = CCOrbitCamera:create(time, 1, 0, 0, 90, 0, 0)
    local actions = {carema1, CCHide:create(), CCDelayTime:create(time)}

    local carema2 = CCOrbitCamera:create(time, 1, 0, 270, 90, 0, 0)
    local actions1 = {CCDelayTime:create(time), CCShow:create(), carema2}

    if callback then
        local callFun = CCCallFuncN:create(callback)
        --actions1:addObject(callFun)
        table.insert(actions1,callFun)
    end
    inNode:runAction(CCSequence:create(actions1))
    outNode:runAction(CCSequence:create(actions))
end

--[[
    放大缩小动画
]]
function ViewAnimationHelper.doScaleAction(node, duration, scale)
    if node == nil then return end
    local act1 =  CCScaleBy:create(duration, scale)
    local act2 = act1:reverse()
    node:runAction(CCSequence:create({EaseSineIn:create(act1), EaseSineOut:create(act2)}))
end

--[[
   缩放的同时移动
]]
function ViewAnimationHelper.doScaleAndMoveAction(node, scale, to, duration, callback)
    if node == nil then return end
    duration = duration or 0.15
    
    local act1 =  CCScaleTo:create(duration, scale)
    local act2 = CCMoveTo:create(duration, to)
    
    local arr = {}
    table.insert(arr, CCSpawn:create({act1, act2}))
    if callback then
        local act3 = CCCallFuncN:create(callback)
        table.insert(arr, act3)
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    移动时渐隐
]]
function ViewAnimationHelper.doFadeMoveAndCallFunAction(node, fadeTo, moveTo, duration, delay, callback)
    if node == nil then return end
    duration = duration or 0.15
    callBack = callBack or function() end
    local act1 =  CCFadeTo:create(duration, fadeTo)
    local act2 = CCMoveTo:create(duration, moveTo)
    
    local arr = {}
    if delay and delay > 0 then
        local delayAct = CCDelayTime:create(delay)
        table.insert(arr, delayAct)
    end
    local temp = CCSpawn:create({act1, act2})
    table.insert(arr, CCEaseOut:create(temp, duration))
    if callback then
        local act3 = CCCallFuncN:create(callback)
        table.insert(arr, act3)
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    上下移动
]]
function ViewAnimationHelper.doMoveUpAndDown(node, time, distance)
    if node == nil then return end
    local distance = distance or 20
    local times = time or 2
    local arr = {
        CCMoveBy:create(times, ccp(0, distance)),
        CCMoveBy:create(times, ccp(0, -distance)),
    }

    local actionAll = CCRepeatForever:create(CCSequence:create(arr))
    node:runAction(actionAll)
end

--[[
    渐隐消失之后 移除
]]
function ViewAnimationHelper.fadeOutAndRemove(node, duration)
    local fdOut = CCFadeTo:create(duration, 0)
    local callFun = CCCallFunc:create(function ()
        node:removeFromParent(true)
    end)
    local action = CCSequence:create({fdOut, callFun})
    node:runAction(action)
end

----------------------------------
-- 弹窗弹出效果
---------------------------------  
--[[
    淡入放大收紧
]]

function ViewAnimationHelper.showPopOpenAnim(node, callback)
    if not node then return end
    node:setOpacity(150)
    local act1 = CCScaleTo:create(0.1, 1.02)
    local act2 = CCFadeTo:create(0.1, 255)
    local act3 = CCScaleTo:create(0.1, 1.0)
    
    local arr = {}
    table.insert(arr, CCSpawn:create({act1, act2}))
    table.insert(arr, act3)
    if callback then
        local act4 = CCCallFuncN:create(callback)
        table.insert(arr, act4)
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    淡出缩小关闭
]]
function ViewAnimationHelper.showPopCloseAnim(node, callback)
    if not node then return end
    local act1 = CCScaleTo:create(0.1, 1.03)
    local act2 = CCFadeTo:create(0.1, 150)
    local act3 = CCScaleTo:create(0.1, 0.97)
    
    local arr = {}
    table.insert(arr, act1)
    table.insert(arr, CCSpawn:create({act2, act3}))
    
    if callback then
        table.insert(arr, CCCallFuncN:create(callback))
    else
        table.insert(arr, CCCallFuncN:create(function()
            AlertManager:close()
        end))
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    淡入放大收紧
    @params:
    opacity 初始透明度
    scale 初始大小比例
    upscale 放大比例
    downscale 缩小比例
    uptime 放大时间
    downtime 缩小时间
    delay 延迟执行时间
    callback 回调
]]
function ViewAnimationHelper.doScaleFadeInAction(node, params)
    if not node then return end
    local opacity = params.opacity or 0
    local scale = params.scale or 1.0
    local upscale = params.upscale or 1.1
    local downscale = params.downscale or 1.0
    local uptime = params.uptime or 0.2
    local downtime = params.downtime or 0.1
    local delay = params.delay or 0
    node:setOpacity(opacity)
    node:setScale(scale)

    local arr = {}
    local act1 = CCScaleTo:create(uptime, upscale)
    local act2 = CCFadeIn:create(uptime)
    if params.delay then
        table.insert(arr, CCDelayTime:create(params.delay))
    end
    table.insert(arr, CCSpawn:create({act1, act2}))
    table.insert(arr, CCScaleTo:create(downtime, downscale))
    if params.callback then
        table.insert(arr, CCCallFuncN:create(params.callback))
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    移动中淡入
    @params:
    direction 移动方向（1 从左往右，2 从右往左， 3 从上往下， 4 从下往上）
    opacity 初始透明度
    distance 移动距离
    time 移动时间
    adjust 回弹的距离
    delay 延迟执行时间
    ease （1 由快变慢，2 由慢变快） 
    callback 回调
]]
function ViewAnimationHelper.doMoveFadeInAction(node, params)
    if not node then return end
    local rdistance = params.distance or 40
    local ropacity = params.opacity or 0
    local rtime = params.time or 0.3
    local radjust = params.adjust or 0
    local movePos
    local adjustPos
    if params.direction == 1 then
        movePos = ccp(rdistance, 0)
        adjustPos = ccp(-radjust, 0)
    elseif params.direction == 2 then
        movePos = ccp(-rdistance, 0)
        adjustPos = ccp(radjust, 0)
    elseif params.direction == 3 then
        movePos = ccp(0, -rdistance)
        adjustPos = ccp(0, radjust)
    elseif params.direction == 4 then
        movePos = ccp(0, rdistance)
        adjustPos = ccp(0, -radjust)
    else
        movePos = ccp(0, 0)
    end
    node:setOpacity(ropacity)
    local position = node:getPosition()
    node:setPosition(ccp(position.x - movePos.x - adjustPos.x, position.y - movePos.y - adjustPos.y))
    local arr = {}
    local act1 = CCMoveBy:create(rtime, movePos)
    local act2 = CCFadeIn:create(rtime)
    if params.ease then
        if params.ease == 1 then
            act1 = EaseSineIn:create(act1)
            act2 = EaseSineIn:create(act2)
        elseif params.ease == 2 then
            act1 = EaseSineOut:create(act1)
            act2 = EaseSineOut:create(act2)
        end
    end
    if params.delay then
        table.insert(arr, CCDelayTime:create(params.delay))
    end
    table.insert(arr, CCSpawn:create({act1, act2}))
    table.insert(arr, CCMoveBy:create(0.02, adjustPos))
    if params.callback then
        table.insert(arr, CCCallFuncN:create(params.callback))
    end
    node:runAction(CCSequence:create(arr))
end

--[[
    依次展示一组节点（滑动出现）
    @params:
    direction 展示方向（1 从左往右，2 从右往左， 3 从上往下， 4 从下往上）
    distance 滑动的距离
    time 滑动时间
    wait 延迟执行时间
    delay 各节点间的间隔时间
    adjust 回弹的距离
    callback 回调
]]
function ViewAnimationHelper.displayMoveNodes(nodes, params)
    if not nodes or not params or not params.direction then
        return
    end
    local rdistance = params.distance or 100
    local rtime = params.time or 0.2
    local rdelay = params.delay or 0.08
    local wait_time = params.wait or 0.01
    local radjust = params.adjust or 0
    local movePos
    local adjustPos
    if params.direction == 1 then
        movePos = ccp(rdistance, 0)
        adjustPos = ccp(-radjust, 0)
    elseif params.direction == 2 then
        movePos = ccp(-rdistance, 0)
        adjustPos = ccp(radjust, 0)
    elseif params.direction == 3 then
        movePos = ccp(0, -rdistance)
        adjustPos = ccp(0, radjust)
    elseif params.direction == 4 then
        movePos = ccp(0, rdistance)
        adjustPos = ccp(0, -radjust)
    end
    for i,node in ipairs(nodes) do
        node:setOpacity(0)
        local arr = {
            CCDelayTime:create(wait_time),
            CCCallFuncN:create(function()
                local position = node:getPosition()
                node:setPosition(ccp(position.x - movePos.x - adjustPos.x, position.y - movePos.y - adjustPos.y))
            end),
            CCSpawn:create({CCMoveBy:create(rtime, movePos), CCFadeIn:create(rtime)}),
            CCMoveBy:create(0.02, adjustPos),
        }
        if params.callback then
            table.insert(arr, CCCallFuncN:create(params.callback))
        end

        node:runAction(CCSequence:create(arr))
        wait_time = wait_time + rdelay
    end
end

return ViewAnimationHelper
