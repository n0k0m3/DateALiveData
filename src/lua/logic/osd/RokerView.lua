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
*
* 摇杆
* 
]]

local MapUtils = import(".MapUtils")
local OSDConfig = import(".OSDConfig")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local BattleUtils = require("lua.logic.battle.BattleUtils")
local KeyStateMgr = import(".OSDKeyStateMgr")
local enum = require("lua.logic.battle.enum")
local eVKeyCode = enum.eVKeyCode
local ePKeyCode = enum.ePKeyCode

local RokerView = class("RokerView")

local Radius = 50
local FixDir = BattleConfig.ROKE_DIR_NUM/4
local FixValue = 1/FixDir 

local VKeyBind = {}
VKeyBind[eVKeyCode.LEFT]     = {bindPKeyCodes={ePKeyCode.LEFT,ePKeyCode.A}  }
VKeyBind[eVKeyCode.RIGHT]    = {bindPKeyCodes={ePKeyCode.RIGHT,ePKeyCode.D} }
VKeyBind[eVKeyCode.UP]       = {bindPKeyCodes={ePKeyCode.UP,ePKeyCode.W}    }
VKeyBind[eVKeyCode.DOWN]     = {bindPKeyCodes={ePKeyCode.DOWN,ePKeyCode.S}  }

function RokerView:ctor(ui)
	self.ui = ui
	self:initUI()
end

function RokerView:initUI()
	self.ui:setTouchEnabled(true)
    --开启多点触摸
    KeyStateMgr.setEnable(true)
    KeyStateMgr.setAgent(self)
    TFDirector:setTouchSingled(false)

	self.rokerBg = TFDirector:getChildByPath(self.ui, "img_roker_bg")
	self.lightImg = TFDirector:getChildByPath(self.ui, "img_light")
	self.rokerImg = TFDirector:getChildByPath(self.ui, "img_roker")
	self.lightImg:hide()
	self.rokerImg:setTouchEnabled(false)

	self.initPos = self.rokerBg:getPosition()
end

function RokerView:setRokerEnable(value)
    KeyStateMgr.setEnable(value)
end

function RokerView:setDelegate(delegate)
    self.delegate = delegate
end

function RokerView:onTouch(event)
	local name   = event.name
    local target = event.target

    if name == "began" then
        self:calcuCenterPos(target)
        self.rokerBg:setOpacity(255)
        self.rokerImg:stopAllActions()
        self.rokerImg:setPosition(me.p(0, 0))
        self.rokerImg:setHighLightEnabled(true)
    elseif name == "moved" then
        local touchPos = me.p(target:getTouchMovePos())
        touchPos = self:convertPosition(target, touchPos)
        local pos = self.rokerBg:getPosition()
        touchPos = me.pSub(touchPos, pos)
        local length = me.pGetLength(touchPos)
        if length < 20 then
            --更新小点点的位置
            self.rokerImg:setPosition(touchPos)
            self:setRokeViewVector(0, 0)
            self.lightImg:hide()
        else
            self:calcuRokerState(touchPos)
            self.rokerImg:setPosition(touchPos)
            self.lightImg:show()
        end
    elseif name == "ended" then
         --归位
        self.rokerBg:setOpacity(150)
        self.rokerBg:setPosition(self.initPos)
        self.rokerImg:setHighLightEnabled(false)
        self.rokerImg:stopAllActions()
        self.rokerImg:runAction(MoveTo:create(0.1, me.p(0, 0)))
        self.lightImg:hide()
        KeyStateMgr.clearKeyState()
        self:setRokeViewVector(0, 0)
    end
end

function RokerView:setRokeViewVector(vx, vy) 
    local _vx = BattleUtils.round(vx * 100 / FixDir) * FixDir * 0.01
    local _vy = BattleUtils.round(vy * 100 / FixDir) * FixDir * 0.01
    if vx > - FixValue and vx < FixValue then
        _vx = 0
    end

    --交由KeyStateMgr管理，再由KeyStateMgr驱动RokerView
    KeyStateMgr.setRokeVector(_vx, _vy)
end

--KeyStateMgr代理RokerView，驱动RokerView的setRokeVector
function RokerView:setRokeVector(vx, vy) 
    if self.delegate then
        self.delegate:setRokeVector(vx, vy)
    end
end

function RokerView:update(dt)
    if self.isSinglePlayer then
        return
    end

    local configTime = self.configTime or OSDConfig.SYN_POS_TIME
    if not self.sendDelta or self.sendDelta >= configTime then
        --第一次 OR 每个一秒发一次
        if self.delegate then
            if self.prePos ~= self.delegate:getPosition() or self.preVec ~= self.delegate:getRokeVector() then
                self.preVec = clone(self.delegate:getRokeVector())
                self.prePos = self.delegate:getPosition()
                self:sendPosRqst()
            end
        end
        self.sendDelta = 0
    else
        self.sendDelta = self.sendDelta + dt
    end 
end

function RokerView:changeSynicTime( dt )
    -- body
    self.configTime = dt or OSDConfig.SYN_POS_TIME
end

function RokerView:setIsSinglePlayer( isSingle )
    -- body
    self.isSinglePlayer = isSingle
end

function RokerView:getConfigTime( ... )
    -- body
    return self.configTime or OSDConfig.SYN_POS_TIME
end

function RokerView:sendPosRqst()
    local angle = MapUtils:getAngleByVec(self.delegate:getRokeVector())
    local pos = self.delegate:getPosition()
    pos.x = math.floor(pos.x)
    pos.y = math.floor(pos.y)
    angle = math.floor(angle)
    -- printBeck("fuck ============= ", pos, angle, self.delegate:getRokeVector())
    WorldRoomDataMgr:sendPositionChange(pos, angle)
end

--检查是否是有效输入 适配KeystateMgr
function RokerView:isValidKey(keyCode)
    return true
end

--将输入放入操作中 适配KeystateMgr
function RokerView:createAndPush(keyCode, eventType)
    if self:isValidKey(keyCode) then
        -- self.operate:createAndPush(keyCode, eventType)
    end
end

--计算摇杆位置
function RokerView:calcuCenterPos(target)
    local defaultPos = self.initPos
    if BattleConfig.ROKER_FIX_POSTION then
        self.rokerBg:setPosition(self.initPos)
    else
        local _touchPos = me.p(target:getTouchStartPos())
        _touchPos = self:convertPosition(target, _touchPos)
        local touchPos  = me.pSub(_touchPos, self.initPos)
        local _R  = BattleConfig.ROKER_R --活动范围半径
        local _SR = me.pGetLength(touchPos)
        if _SR < _R then
            self.rokerBg:setPosition(_touchPos)
        else
            _touchPos.x  = _R / _SR * touchPos.x
            _touchPos.y  = _R / _SR * touchPos.y
            self.rokerBg:setPosition(me.pAdd(_touchPos, self.initPos))
        end
    end
end

function RokerView:calcuRokerState(touchPos)
    --计算摇杆位置
    local distance = me.pGetDistance(touchPos, me.p(0, 0))
    self:setRokeViewVector(touchPos.x / distance, touchPos.y / distance)

    touchPos.x = Radius/distance * touchPos.x
    touchPos.y = Radius/distance * touchPos.y
    --计算角度
    local angle = MapUtils:pGetAngle(ccp(0, 0), touchPos)
    local angle = -angle * 180/math.pi + 90
    self.lightImg:setRotation(angle)
end

function RokerView:convertPosition(node, position)
    position = node:convertToNodeSpace(position)
    local size  = node:getSize()
    position.x = position.x - size.width/2
    position.y = position.y - size.height/2
    return position
end

function RokerView:registerEvents()
    self.ui:onTouch(function(event)
        if self.rokerBg:isVisible() then
            self:onTouch(event)
        end
    end)

    --注册键盘事件
    for vKeyCode, bindInfo in pairs(VKeyBind) do
        local pKeyCodes = bindInfo.bindPKeyCodes
        local widgetName = bindInfo.bindWidgetName
        for _ , pKeyCode in ipairs(pKeyCodes) do
            self:registerPKeyEvent(pKeyCode, vKeyCode)
        end
    end
end

function RokerView:registerPKeyEvent(pKeyCode, vKeyNode)
    if me.platform == "win32" then
        -- printBeck("[RokerView]registerPKeyEvent ", pKeyCode, vKeyNode)
        self.pKeyPressedHandles = self.pKeyPressedHandles or {}
        self.pKeyReleasedHandles = self.pKeyReleasedHandles or {}
        local pressedHandle = handler(self.doPKeyPressed, self)
        local releaseHandle = handler(self.doPKeyReleased, self)
        self.pKeyPressedHandles[pKeyCode] = pressedHandle
        self.pKeyReleasedHandles[pKeyCode] = releaseHandle
        if TFDirector.registerKeyDown then
            TFDirector:registerKeyDown(pKeyCode, {nGap = 0}, pressedHandle, vKeyNode)
        end
        if TFDirector.registerKeyUp then
            TFDirector:registerKeyUp(pKeyCode, {nGap = 0}, releaseHandle, vKeyNode)
        end
    end
end

function RokerView:doPKeyPressed(keyCode)
    KeyStateMgr.doKeyPressed(keyCode)
    self:startTimer(keyCode)
end

function RokerView:doPKeyReleased(keyCode)
    KeyStateMgr.doKeyReleased(keyCode)
    self:stopTimer()
end

--按键长按
function RokerView:doKeyDoing(keyCode)
    KeyStateMgr.doKeyDoing(keyCode)
end

--长按检查
function RokerView:startTimer(keyCode)
    self:stopTimer()
    local timerID
    timerID = TFDirector:addTimer(200, 1, function ()
        if self.stopTimer == nil then
            TFDirector:removeTimer(timerID)
        else
            self:stopTimer()
            self:doKeyDoing(keyCode)
        end
    end)
    self.timerID = timerID
end

function RokerView:stopTimer()
    if self.timerID then
        TFDirector:removeTimer(self.timerID)
    end
    self.timerID = nil
end

function RokerView:removePKeyEvent()
    if me.platform == "win32" then
        if self.pKeyPressedHandles then
            for pKeyCode, pKeyHandle in pairs(self.pKeyPressedHandles) do
                TFDirector:unRegisterKeyDown(pKeyCode, pKeyHandle)
            end
            self.pKeyPressedHandles = nil
        end
        if self.pKeyReleasedHandles then
            for pKeyCode, pKeyHandle in pairs(self.pKeyReleasedHandles) do
                TFDirector:unRegisterKeyUp(pKeyCode, pKeyHandle)
            end
            self.pKeyReleasedHandles = nil
        end
    end
end

function RokerView:removeEvents()
    self:stopTimer()
    self:removePKeyEvent()
    KeyStateMgr.clear()
    KeyStateMgr.setEnable(false)
    --关闭多点触摸
    TFDirector:setTouchSingled(true)
end

return RokerView
