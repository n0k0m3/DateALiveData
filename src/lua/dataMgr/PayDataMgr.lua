local BaseDataMgr = import(".BaseDataMgr")
local RechargeDataMgr = class("RechargeDataMgr", BaseDataMgr)


function RechargeDataMgr:ctor()
    self:init()
end

function RechargeDataMgr:init()
	
end

function RechargeDataMgr:showRechargeLayer()
	Utils:openView("store.RechargeMain")
	-- local recharge = requireNew("lua.logic.store.RechargeMain"):new()
 --    AlertManager:addLayer(recharge)
 --    AlertManager:show()
end

return RechargeDataMgr:new();
