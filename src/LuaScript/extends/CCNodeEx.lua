
local CCNodeEx = {}

function CCNodeEx:onTouch(callback)
    self:addMEListener(TFWIDGET_TOUCHBEGAN, function(sender)
                           local event = {}
                           event.target = sender
                           event.name = "began"
                           callback(event)
    end)

    self:addMEListener(TFWIDGET_TOUCHMOVED, function(sender)
                           local event = {}
                           event.target = sender
                           event.name = "moved"
                           callback(event)
    end)

    self:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
                           local event = {}
                           event.target = sender
                           event.name = "ended"
                           callback(event)
    end)
    self:addMEListener(TFWIDGET_TOUCHCANCELLED, function(sender)
                           local event = {}
                           event.target = sender
                           event.name = "cancelled"
                           callback(event)
    end)
    return self
end

function CCNodeEx:onClick(callback, btnType)
    self:addMEListener(TFWIDGET_CLICK, function(sender)
                           local flag = callback(sender)
                           if not flag then
                               if btnType == EC_BTN.CLOSE then
                                   --弹窗关闭音效
                                   TFAudio.playSound(Utils:getKVP(1002,"ui_closeSound"))
                               elseif btnType == EC_BTN.BACK then
                                   --返回上级界面音效
                                   TFAudio.playSound(Utils:getKVP(1004,"ui_returnSound"))
                               else
                                   --普通按钮音效
                                   TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                               end
                           end
    end)
    return self
end

function CCNodeEx:onScaleClick(callback, btnType)
    self:OnBegan(function(sender, pos)
            self:Scale(self:getScale() * 1.1)
    end)

    self:OnEnded(function(sender, pos)
            self:onClick(callback,btnType)
            self:Scale(1.0)
    end)
end

----------------------------------------------------

for k, v in pairs(CCNodeEx) do
    if not rawget(CCNode, k) and type(v) == "function" then
        rawset(CCNode, k, v)
    end
end
