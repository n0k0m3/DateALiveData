--[[
    -- 防沉迷layer 
]]

local AntiAddictionlayer = class("AntiAddictionlayer",BaseLayer)

function AntiAddictionlayer:initData(scale)
    self.curScale = scale or 1
    self.curScale = 1 / self.curScale
    local _tmpStr = Utils:getLocalSettingValue("AntiAddictionImg_Pos")
    if "" ~= _tmpStr then
        local _pos = string.split(_tmpStr, ",")
        self.imgPoskeep = ccp(tonumber(_pos[1]), tonumber(_pos[2]))
    end

    self.limitMinTime = 300
    local _data = Utils:getKVP(20003, "antiwarn")
    if _data then
        self.limitMinTime = _data[#_data] * 60 
    end
end

function AntiAddictionlayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.common.antiAddictionLayer")
end

function AntiAddictionlayer:initUI(ui)
    self.super.initUI(self,ui)
    if self.imgPoskeep then
        self._ui.img_diS:setPosition(self:getRectSafePoint(self._ui.img_diS, self.imgPoskeep))
        self._ui.img_diB:setPosition(self:getRectSafePoint(self._ui.img_diB, self.imgPoskeep))
    end
    self._ui.img_diS:setScale(self.curScale)
    self._ui.img_diB:setScale(self.curScale)
end

function AntiAddictionlayer:timeShowFunc()
    local time = MainPlayer.warnTimeKeep
    if time > 0 then
        local min = math.floor(time / 60)
        local sec = time - min*60
        self._ui.img_diS:setVisible(time <= self.limitMinTime)
        self._ui.img_diB:setVisible(not self._ui.img_diS:isVisible())
        self._ui.lab_TimeS:setText(time)
        self._ui.lab_TImeB:setTextById(14300301,min,sec)
    else
        Utils:closeAnitAddictionLayer()
    end
end

function AntiAddictionlayer:registerEvents()
    self._ui.btn_close:onClick(function()
        MainPlayer:setWarnTipFlag(true)
        Utils:closeAnitAddictionLayer()
    end)

    self._ui.img_diB:setTouchEnabled(true)
    self._ui.img_diB:onTouch(handler(self.onTouchFunc, self))
    self._ui.img_diS:setTouchEnabled(true)
    self._ui.img_diS:onTouch(handler(self.onTouchFunc, self))
end

function AntiAddictionlayer:onTouchFunc(event)
    local name   = event.name
    local target = event.target
    if name == "began" then
        self.touchPosBegin = target:getTouchStartPos()
        self._pos          = target:getPosition()
    elseif name == "moved" then 
        local touchMovePos = target:getTouchMovePos()
        local _x = touchMovePos.x -  self.touchPosBegin.x + self._pos.x
        local _y = touchMovePos.y -  self.touchPosBegin.y + self._pos.y
        target:setPosition(self:getRectSafePoint(target, ccp(_x, _y)))
    elseif name == "ended" then
        local pos   = target:getPosition()
        local value = pos.x..","..pos.y
        Utils:setLocalSettingValue("AntiAddictionImg_Pos",value)
    end
end

-- 边界判断
function AntiAddictionlayer:getRectSafePoint(target, point)
    local targetSize = target:getSize()
    local _x = point.x
    local _y = point.y
    local rectSize = CCSizeMake(1136, 640)
    rectSize.width = rectSize.width * self.curScale
    rectSize.height = rectSize.height * self.curScale
    _x = math.min(rectSize.width - targetSize.width * self.curScale, _x)
    _x = math.max(0, _x)
    _y = math.min(rectSize.height - targetSize.height/2, _y)
    _y = math.max(targetSize.height * self.curScale/2, _y)
    return ccp(_x, _y)
end

function AntiAddictionlayer:setLayerVisilbe(isVisilbe)
    self.ui:setVisible(isVisilbe)
end

return AntiAddictionlayer