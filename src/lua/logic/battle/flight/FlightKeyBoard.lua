local KeyStateMgr  = import("..KeyStateMgr")
local BattleUtils  = import("..BattleUtils")
local BattleConfig = import("..BattleConfig")
local enum         = import("..enum")

local eVKeyCode = enum.eVKeyCode
local ePKeyCode = enum.ePKeyCode
local eEvent    = enum.eEvent

local VKeyBind  = {}

VKeyBind[eVKeyCode.LEFT]    = { bindPKeyCodes = { ePKeyCode.LEFT, ePKeyCode.A } }
VKeyBind[eVKeyCode.RIGHT]   = { bindPKeyCodes = { ePKeyCode.RIGHT, ePKeyCode.D } }
VKeyBind[eVKeyCode.UP]      = { bindPKeyCodes = { ePKeyCode.UP, ePKeyCode.W } }
VKeyBind[eVKeyCode.DOWN]    = { bindPKeyCodes = { ePKeyCode.DOWN, ePKeyCode.S } }
VKeyBind[eVKeyCode.SKILL_A] = { bindPKeyCodes = { ePKeyCode.J }, bindWidgetName = "A" }
VKeyBind[eVKeyCode.SKILL_B] = { bindPKeyCodes = { ePKeyCode.H }, bindWidgetName = "B" }


local Radius         = 70
--local pos_center     = me.p(180, 180)

local ROCKER_SCALE_X = 1
local ROCKER_SCALE_Y = 1
local ROKER_FIX_POSTION = true
local FixDir   = BattleConfig.ROKE_DIR_NUM/2
local FixValue = 1/FixDir

local function pGetAngle(self, other)
    local a2    = me.pNormalize(self)
    local b2    = me.pNormalize(other)
    local angle = math.atan2(me.pCross(a2, b2), me.pDot(a2, b2))
    if math.abs(angle) < 1.192092896e-7 then
        return 0.0
    end
    return angle
end

local FlightKeyBoard      = class("FlightKeyBoard", BaseLayer)

function FlightKeyBoard:ctor()
    self.vKeyNodes = {}
    self.super.ctor(self)
    ROKER_FIX_POSTION =  SettingDataMgr:getBattleRokeVal()
    local levelCfg = BattleDataMgr:getLevelCfg()
    if levelCfg and levelCfg.fightingMode == 2 then
        ROCKER_SCALE_X = 1.2
        ROCKER_SCALE_Y = 1.1
    elseif levelCfg and levelCfg.fightingMode == 3 then
        ROCKER_SCALE_X = 1.14
        ROCKER_SCALE_Y = 0.74
    end
    self:init("lua.uiconfig.battle.flightCtrlView")
    me.Director:getEventDispatcher():setSingleEnabled(false)
end

function FlightKeyBoard:initUI(ui)
    self.super.initUI(self, ui)
    self.panel_root       = TFDirector:getChildByPath(ui, "Panel")
    self.panel_ctrlpad = TFDirector:getChildByPath(self.panel_root, "Panel_base")
    self.image_background = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_roker"):hide()
    self.image_ctrl       = TFDirector:getChildByPath(self.panel_ctrlpad, "Image_ctrl")
    self.button_ctrl      = TFDirector:getChildByPath(self.panel_ctrlpad, "Button_ctrl")
    self.panel_roke_touch = TFDirector:getChildByPath(self.panel_ctrlpad, "Panel_roke_touch")
    self.image_ctrl:hide()
    self.button_ctrl:setTouchEnabled(false)
    self.image_background.initPos = self.image_background:getPosition()

    self.pause_btn  = TFDirector:getChildByPath(self.panel_root, "Button_pause")
    self.pause_btn:onClick(function()
        Utils:openView("battle.BattlePauseView")
        EventMgr:dispatchEvent(eEvent.EVENT_PAUSE)
    end)
    --self:testSpd()

    EventMgr:addEventListener(self, eEvent.EVENT_CAPTAIN_CHANGE, handler(self.onCaptainChange, self))
    EventMgr:addEventListener(self, eEvent.EVENT_VKSTATE_CHANGE, handler(self.onVKStateChange, self))
end

function FlightKeyBoard:onVKStateChange(skill, captain)
    local keyNode = self.vKeyNodes[skill.keyCode]
    if keyNode then
        local percent = 100 - skill.percent
        keyNode:setTouchEnabled(percent == 100)
        if  keyNode.labelCd then
            keyNode.labelCd:setVisible(percent ~= 100)
            keyNode.labelCd:setText(skill.cd)
        end
        if keyNode.mask then
            keyNode.mask:setVisible(percent ~= 100)
        end
        if keyNode.widgetName == "A" then
            --keyNode:setTouchEnabled(captain:getAnger() >= skill.cfg.angerCost)
            --keyNode:setGrayEnabled(captain:getAnger() < skill.cfg.angerCost)
            --local percent = captain:getAngerPercent()*0.01
            ---- print("xxxxx",percent)
            ---- Box("percent:"..tostring(percent))
            --if keyNode.progress then
            --    keyNode.progress:setVisible(true)
            --    keyNode.progress:setPercent(percent)
            --end
        else
            --local percent = 100 - skill:getCDPercent()
            --if keyNode.progress then
            --    keyNode.progress:setVisible(true)
            --    keyNode.progress:setPercent(percent*0.8)
            --end
            --
            --local cacheTimes = skill:getCacheTimes()
            --local maxTimes   = skill:getMaxCacheTimes()
            --if cacheTimes > 0 then
            --    keyNode:setTouchEnabled(skill:_isEnoughEnergy())
            --else
            --    keyNode:setTouchEnabled(false)
            --end
            ----能量不够图标才置灰
            --keyNode:setGrayEnabled(not skill:_isEnoughEnergy())
        end
    end
end

function FlightKeyBoard:onCaptainChange(hero)
    if hero then
        KeyStateMgr.setAgent(hero)
        if self.image_background then
            self.image_background:show()
        end
        self.panel_roke_touch:show()
        for keyCode , keyNode in pairs(self.vKeyNodes) do
            if  keyNode.labelCd then
                keyNode.labelCd:setVisible(false)
            end
            if keyNode.mask then
                keyNode.mask:setVisible(false)
            end
            local skill = hero:getSkill(keyCode)
            if not skill then
                keyNode:setTouchEnabled(false)
                keyNode:setVisible(false)
            else
                keyNode.icon:setTexture(skill:getIcon())
                keyNode:setTouchEnabled(true)
                keyNode:setVisible(true)
                self:onVKStateChange(skill, hero)
            end
        end
    end
end

local function _convertPosition(node,position)
    position = node:convertToNodeSpace(position)
    local size  = node:getSize()
    position.x = position.x - size.width/2
    position.y = position.y - size.height/2
    -- dump(position)
    return position
end

----计算摇杆位置
function FlightKeyBoard:calcuCenterPos(target)
    local defaultPos = self.image_background.initPos
    if ROKER_FIX_POSTION then
        self.image_background:setPosition(defaultPos)
    else
        local _touchPos = me.p(target:getTouchStartPos())
        _touchPos = _convertPosition(target,_touchPos)
        local touchPos  = me.pSub(_touchPos,defaultPos)
        -- dump({_touchPos , defaultPos})
        local _R  = BattleConfig.ROKER_R --活动范围半径
        local _SR = me.pGetLength(touchPos)
        if _SR < _R then
            self.image_background:setPosition(_touchPos)
        else
            _touchPos.x  = _R/_SR*touchPos.x
            _touchPos.y  = _R/_SR*touchPos.y
            self.image_background:setPosition(me.pAdd(_touchPos,defaultPos))
        end
    end
end

function FlightKeyBoard.setRokeVector(vx,vy)
    local _vx = BattleUtils.round(vx * 100 / FixDir) * FixDir * 0.01 * ROCKER_SCALE_X
    local _vy = BattleUtils.round(vy * 100 / FixDir) * FixDir * 0.01 * ROCKER_SCALE_Y
    if vx > - FixValue and vx < FixValue then
        _vx = 0
    end
    print_(string.format("%s-%s",_vx,_vy))
    KeyStateMgr.setRokeVector(_vx ,_vy)
end


function FlightKeyBoard:onTouch(event, what)
    -- print("Roker touch event:",event.name)
    local name   = event.name
    local target = event.target
    if name == "began" then
        self:calcuCenterPos(target)
        self.image_background:setOpacity(255)
        self.button_ctrl:stopAllActions()
        self.button_ctrl:setPosition(me.p(0,0))
        -- self.button_ctrl:setTexture(PRESSED_TEXTURE)
        self.button_ctrl:setHighLightEnabled(true)
    elseif name == "moved" then
        local touchPos = me.p(target:getTouchMovePos())
        touchPos = _convertPosition(target,touchPos)
        local pos = self.image_background:getPosition()
        touchPos = me.pSub(touchPos,pos)
        local length = me.pGetLength(touchPos)
        if length < 10 then
            --更新小点点的位置
            self.button_ctrl:setPosition(touchPos)
            --FlightKeyBoard.setRokeVector(0,0)
            self.image_ctrl:hide()
            return
        elseif length < Radius then
            self.button_ctrl:setPosition(touchPos)
            self:calcuRokerState(touchPos)
        else
            self:calcuRokerState(touchPos)
            self.button_ctrl:setPosition(touchPos)
        end
        self.image_ctrl:show()
    elseif name == "ended" then
        --归位
        self.image_background:setOpacity(150)
        local defaultPos = self.image_background.initPos -- me.p(150,140)
        self.image_background:setPosition(defaultPos)
        -- self.button_ctrl:setTexture(NORMAL_TEXTURE)
        self.button_ctrl:setHighLightEnabled(false)
        self.button_ctrl:stopAllActions()
        self.button_ctrl:runAction(MoveTo:create(0.1,me.p(0,0)))
        self.image_ctrl:hide()
        KeyStateMgr.clearKeyState()
        FlightKeyBoard.setRokeVector(0,0)
    end
end

function FlightKeyBoard:transPos(pos)
    local defaultPos = self.image_background.initPos
    pos.x = pos.x - defaultPos.x
    pos.y = pos.y - defaultPos.y
    return pos
end

function FlightKeyBoard:calcuRokerState(touchPos)
    --计算摇杆位置
    local distance = me.pGetDistance(touchPos,me.p(0,0))
    FlightKeyBoard.setRokeVector(touchPos.x/distance,touchPos.y/distance)
    touchPos.x = Radius/distance * touchPos.x
    touchPos.y = Radius/distance * touchPos.y
    --TODO 可以适当优化
    --计算角度
    local angle    = pGetAngle(ccp(0,0),touchPos)
    local angle = -angle*180/math.pi + 90
    self.image_ctrl:setRotation(angle)
end

local function bindFunc(node)
    node.setGrayEnabled  = function(self, enabled)
        self.icon:setGrayEnabled(enabled)
    end

    node.setTouchEnabled = function(node, enabled)
        node:setHighLightEnabled(false, true)
        CCNode.setTouchEnabled(node, enabled)
        if node.active then
            node.active:setVisible(enabled)
        end
        if node.effect then
            node.effect:setVisible(enabled)
            if enabled and node._bTouchEnabled ~= enabled then
                node.effect:playByIndex(0, 1)
            end
        end
        node._bTouchEnabled = enabled
    end
end

function FlightKeyBoard:registerEvents()
    -- printError("KeyBoard:registerEvents")
    self.panel_roke_touch:setTouchEnabled(true)
    self.panel_roke_touch:onTouch(function(event)
        if self.image_background:isVisible() then
            self:onTouch(event)
        end
    end)

    for vKeyCode, bindInfo in pairs(VKeyBind) do
        local pKeyCodes  = bindInfo.bindPKeyCodes
        local widgetName = bindInfo.bindWidgetName
        for _, pKeyCode in ipairs(pKeyCodes) do
            self:registerPKeyEvent(pKeyCode, vKeyCode)
        end

        if widgetName then
            print("widgetName:", "Button_ctrl" .. widgetName)
            local vKeyNode      = TFDirector:getChildByPath(self.panel_root, "Button_ctrl" .. widgetName)
            vKeyNode.widgetName = widgetName
            --vKeyNode.effect     = vKeyNode:getChildByName("effect")--特效
            --if vKeyNode.effect then
            --    vKeyNode.effect:hide()
            --end
            vKeyNode.labelCd = vKeyNode:getChildByName("Label_cdTime")
            vKeyNode.icon    = vKeyNode:getChildByName("Image_icon")
            vKeyNode.mask    = vKeyNode:getChildByName("Image_mask")
            bindFunc(vKeyNode)
            vKeyNode:setTouchEnabled(false)
            vKeyNode:setGrayEnabled(false)
            vKeyNode:setVisible(false)

            self:registerVKeyEvent(vKeyNode, vKeyCode)
        end
    end

end

function FlightKeyBoard:registerVKeyEvent(vKeyNode, vKeyCode)
    vKeyNode:onTouch(function(event)
        local name   = event.name
        local target = event.target
        if name == "began" then
            vKeyNode:setHighLightEnabled(true, true)
            self:doKeyPressed(vKeyCode)
        elseif name == "ended" then
            vKeyNode:setHighLightEnabled(false, true)
            self:doKeyReleased(vKeyCode)
        end
    end)
    self.vKeyNodes[vKeyCode] = vKeyNode
end

function FlightKeyBoard:removeEvents()
    self:stopTimer()
    self:unRegisterPKeyEvent()
    KeyStateMgr.clear()
    EventMgr:removeEventListenerByTarget(self)
    me.Director:getEventDispatcher():setSingleEnabled(true)
end

function FlightKeyBoard:doKeyPressed(keyCode)
    KeyStateMgr.doKeyPressed(keyCode)
    self:startTimer(keyCode)
end

function FlightKeyBoard:doKeyReleased(keyCode)
    KeyStateMgr.doKeyReleased(keyCode)
    self:stopTimer()
end

--按键长按
function FlightKeyBoard:doKeyDoing(keyCode)
    KeyStateMgr.doKeyDoing(keyCode)
end

--长按检查
function FlightKeyBoard:startTimer(keyCode)
    self:stopTimer()
    self.timerID = TFDirector:addTimer(200, 1, function()
        if self and not tolua.isnull(self) then
            self:stopTimer()
            self:doKeyDoing(keyCode)
        end
    end)

end

function FlightKeyBoard:stopTimer()
    if self.timerID then
        TFDirector:removeTimer(self.timerID)
    end
    self.timerID = nil
end

function FlightKeyBoard:doPKeyPressed(keyCode)
    if self.preKeyCode ~= keyCode then
        self:doKeyPressed(keyCode)
        self.preKeyCode = keyCode
    end
end

function FlightKeyBoard:doPKeyReleased(keyCode)
    self:doKeyReleased(keyCode)
    self.preKeyCode = -1
end

function FlightKeyBoard:registerPKeyEvent(pKeyCode, vKeyNode)
    if me.platform == "win32" or DEBUG == 1 then
        print("registerPKeyEvent ", pKeyCode, vKeyNode)
        self.pKeyPressedHandles            = self.pKeyPressedHandles or {}
        self.pKeyReleasedHandles           = self.pKeyReleasedHandles or {}
        local pressedHandle                = handler(self.doPKeyPressed, self)
        local releaseHandle                = handler(self.doPKeyReleased, self)
        self.pKeyPressedHandles[pKeyCode]  = pressedHandle
        self.pKeyReleasedHandles[pKeyCode] = releaseHandle
        if TFDirector.registerKeyDown then
            TFDirector:registerKeyDown(pKeyCode, { nGap = 0 }, pressedHandle, vKeyNode)
        end
        if TFDirector.registerKeyUp then
            TFDirector:registerKeyUp(pKeyCode, { nGap = 0 }, releaseHandle, vKeyNode)
        end
    end
end

function FlightKeyBoard:unRegisterPKeyEvent()
    if me.platform == "win32" or DEBUG == 1 then
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

function FlightKeyBoard:testSpd()
    local size       = me.size(me.EGLView:getDesignResolutionSize())
    local textScaleX = TFLabel:create()
    textScaleX:setText(tostring(ROCKER_SCALE_X))
    textScaleX:setFontSize(30)
    textScaleX:Pos(size.width/2, size.height -50)
    textScaleX:setAnchorPoint(ccp(0.5,0.5))
    self.panel_root:addChild(textScaleX)

    local textADDX = TFLabel:create()
    textADDX:setAnchorPoint(ccp(0.5,0.5))
    textADDX:setText("ADD_X")
    textADDX:setFontSize(30)
    textADDX:setTouchEnabled(true)
    textADDX:Pos(size.width/2 -100 , size.height -50)
    self.panel_root:addChild(textADDX)
    textADDX:onClick(function()
        ROCKER_SCALE_X = ROCKER_SCALE_X + 0.01
        textScaleX:setText(tostring(ROCKER_SCALE_X))
    end)


    local textDELX = TFLabel:create()
    textDELX:setText("RED_X")
    textDELX:setFontSize(30)
    textDELX:setTouchEnabled(true)
    textDELX:Pos(size.width/2 +100 , size.height -50)
    textDELX:onClick(function()
        ROCKER_SCALE_X = ROCKER_SCALE_X - 0.01
        ROCKER_SCALE_Xs = math.max(ROCKER_SCALE_X,0)
        textScaleX:setText(tostring(ROCKER_SCALE_X))
    end)
    textDELX:setAnchorPoint(ccp(0.5,0.5))
    self.panel_root:addChild(textDELX)

    --
    local textScaleY = TFLabel:create()
    textScaleY:setText(tostring(ROCKER_SCALE_Y))
    textScaleY:setFontSize(30)
    textScaleY:Pos(size.width/2, size.height -100)
    textScaleY:setAnchorPoint(ccp(0.5,0.5))
    self.panel_root:addChild(textScaleY)

    local textADDY = TFLabel:create()
    textADDY:setAnchorPoint(ccp(0.5,0.5))
    textADDY:setText("ADD_Y")
    textADDY:setFontSize(30)
    textADDY:setTouchEnabled(true)
    textADDY:Pos(size.width/2 -100 , size.height -100)
    self.panel_root:addChild(textADDY)
    textADDY:onClick(function()
        ROCKER_SCALE_Y = ROCKER_SCALE_Y + 0.01
        textScaleY:setText(tostring(ROCKER_SCALE_Y))
    end)


    local textDELY = TFLabel:create()
    textDELY:setText("RED_Y")
    textDELY:setFontSize(30)
    textDELY:setTouchEnabled(true)
    textDELY:Pos(size.width/2 +100 , size.height -100)
    textDELY:onClick(function()
        ROCKER_SCALE_Y = ROCKER_SCALE_Y - 0.01
        ROCKER_SCALE_Y = math.max(ROCKER_SCALE_Y,0)
        textScaleY:setText(tostring(ROCKER_SCALE_Y))
    end)
    textDELY:setAnchorPoint(ccp(0.5,0.5))
    self.panel_root:addChild(textDELY)
end

return FlightKeyBoard