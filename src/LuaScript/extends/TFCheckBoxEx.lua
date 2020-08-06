
local TFCheckBoxEx = {}

function TFCheckBoxEx:onEvent(callback)
    self:addMEListener(TFCHECKBOX_SELECTED, function(sender)
                           local event = {}
                           event.name = "selected"
                           event.target = sender
                           callback(event)
    end)

    self:addMEListener(TFCHECKBOX_UNSELECTED, function(sender)
                           local event = {}
                           event.name = "unselected"
                           event.target = sender
                           callback(event)
    end)
    return self
end

----------------------------------------------------

for k, v in pairs(TFCheckBoxEx) do
    if not rawget(TFCheckBox, k) and type(v) == "function" then
        rawset(TFCheckBox, k, v)
    end
end
