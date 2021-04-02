--按键管理
local KeyQueue  = import(".KeyQueue")
local enum      = import(".enum")
local eVKeyCode = enum.eVKeyCode
local eEvent    = enum.eEvent
local eKeyEventType = enum.eKeyEventType


local KeyStateMgr = {}
local this = KeyStateMgr

--互斥按键
local MutexKeyCodeMap = {}
MutexKeyCodeMap[eVKeyCode.LEFT]  = eVKeyCode.RIGHT
MutexKeyCodeMap[eVKeyCode.RIGHT] = eVKeyCode.LEFT
MutexKeyCodeMap[eVKeyCode.UP]    = eVKeyCode.DOWN
MutexKeyCodeMap[eVKeyCode.DOWN]  = eVKeyCode.UP

--PC映射按键互斥处理(摇杆)
function KeyStateMgr.mutex(keyCode)
    local keyCode = MutexKeyCodeMap[keyCode]
    if keyCode then
        this.keyState = bit_and(this.keyState,bit_not(keyCode))
    end
end


function KeyStateMgr.initlize()
    --摇杆操作
    this.keyState = 0

    this.bEnable  = true

    this.agent    = nil
end

function KeyStateMgr.setAgent(agent)
    this.agent = agent
end

local PI2 = 2 * math.pi
--摇杆角度优化
function KeyStateMgr.filteAngle(angle)
    -- body
    -- angle = angle * 0.001
    if angle < 0 then
        angle = angle + PI2
    end
    if angle > PI2 then
        angle = angle - PI2
    end
    local angleCut      = 16
    local halfRef       = (PI2 / ( angleCut * 2 ) )
    local angleRef      = (PI2 / angleCut)
    local angleValidRef = math.ceil(angle/halfRef)
    local angleFinalRef = math.floor(angleValidRef/2) * angleRef
    angleFinalRef = math.floor(angleFinalRef * 1000)
    return angleFinalRef
end
--四舍五入去小数点后2位
local function keepTwoDecimalPlaces(decimal)
    decimal = math.floor((decimal * 100) + 0.5) * 0.01
    return  decimal
end

function KeyStateMgr.setRokeVector(vx,vy)
    if not this.isEnable() then  return end
    xv = keepTwoDecimalPlaces(vx)
    yv = keepTwoDecimalPlaces(vy)
    -- print("vector:",xv,yv)
    if this.agent then
        this.agent:setRokeVector(xv,yv)
    end
end

function KeyStateMgr.isEnable()
    return this.bEnable
end

function KeyStateMgr.setEnable(enable)
    this.bEnable = enable
    this.clearKeyState()
    if this.agent then
        this.agent:setRokeVector(0,0)
    end

end

local function isKeyPressed(keyCode)
    return bit_and(this.keyState ,keyCode)~=0
end

function KeyStateMgr.getKeyState()
    return this.keyState
end

function KeyStateMgr.doKeyPressed(keyCode,skillSubId)
    -- print("Pressed :",keyCode , this.isEnable(),this.isValidKey(keyCode))
    if not this.isEnable() then
        return
    end
    if keyCode <= eVKeyCode.DOWN then  --摇杆
        this.mutex(keyCode)
        this.keyState  = bit_or(this.keyState,keyCode)
        KeyStateMgr.keyCodeToAngle()
    else
        if this.isValidKey(keyCode) then
            this.createAndPush(keyCode,eKeyEventType.DOWN,skillSubId)
        end
    end
end

function KeyStateMgr.doKeyReleased(keyCode,skillSubId)
    -- print("Released :",keyCode)
    if not this.isEnable() then
        return
    end
    if keyCode <= eVKeyCode.DOWN then --摇杆
        this.keyState = bit_and(this.keyState,bit_not(keyCode))
        KeyStateMgr.keyCodeToAngle()
    else
        if this.isValidKey(keyCode) then
            this.createAndPush(keyCode,eKeyEventType.UP)
        end
    end
end

--按键长按(从按键按下开始即时超过一定的时间)
function KeyStateMgr.doKeyDoing(keyCode,skillSubId)
    if not this.isEnable() then
        return
    end
    if keyCode > eVKeyCode.DOWN then --摇杆
        this.createAndPush(keyCode,eKeyEventType.DOING)
    end
end


--检查是否是有效输入
function KeyStateMgr.isValidKey(keyCode)
    if this.agent then
        return this.agent:isValidKey(keyCode)
    end
    return false
end
--清空摇杆状态
function KeyStateMgr.clearKeyState()
    this.keyState = 0
end

--[[
按下以后开始记时
超过一定时时间为长按
弹起后取消/新按键输入也取消

]]

function KeyStateMgr.clear()
    this.clearKeyState()
    this.agent = nil
end

function KeyStateMgr.createAndPush(keyCode,eventType,skillSubId)
    if not this.isEnable() then  return end
    if this.agent then
        this.agent:createAndPush(keyCode,eventType,skillSubId)
    end
end

--按键转换为摇杆弧度
function KeyStateMgr.keyCodeToAngle()
    local l = isKeyPressed(eVKeyCode.LEFT)
    local r = isKeyPressed(eVKeyCode.RIGHT)
    local u = isKeyPressed(eVKeyCode.UP)
    local d = isKeyPressed(eVKeyCode.DOWN)
    local vx = 0
    local vy = 0
    if l and u then
        vx = -0.71
        vy = 0.71
    elseif l and d then
        vx = -0.71
        vy = -0.71
    elseif r and u  then
        vx = 0.71
        vy = 0.71
    elseif r and d then
        vx = 0.71
        vy = -0.71
    elseif l then
        vx = -1
    elseif r then
        vx = 1
    elseif u then
        vy = 1
    elseif d then
        vy = -1
    end
    KeyStateMgr.setRokeVector(vx,vy)
end

KeyStateMgr.initlize()
return KeyStateMgr

--[[
按键管理分2部分
摇杆管理
技能按键

#按键优先级处理

a.优先级高的可以打断低的
如何打断？

清空按键队列
新输入的按键放入队列

b.优先级低的输入处理
阻止输入
对原有输入不影响


--]]
