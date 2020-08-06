
local TFTableViewEx  = {}

function TFTableViewEx:onNumberOfCells(callback)
    self:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, function(...)
                           return callback(...)
    end)
end

function TFTableViewEx:onCellSize(callback)
    self:addMEListener(TFTABLEVIEW_SIZEFORINDEX, function(...)
                           return callback(...)
    end)
end

function TFTableViewEx:onCellAtIndex(callback)
    self:addMEListener(TFTABLEVIEW_SIZEATINDEX, function(...)
                           return callback(...)
    end)
end

----------------------------------------------------

for k, v in pairs(TFTableViewEx) do
    if not rawget(TFTableView, k) and type(v) == "function" then
        rawset(TFTableView, k, v)
    end
end

