local BaseDataMgr = import(".BaseDataMgr")
local GlobalFuncDataMgr = class("GlobalFuncDataMgr", BaseDataMgr)

function GlobalFuncDataMgr:init()
   self.functionMap = TabDataMgr:getData("GlobalFunction")
end

function GlobalFuncDataMgr:reset()
    
end

function GlobalFuncDataMgr:onLogin()
    return {}
end

function GlobalFuncDataMgr:isOpen( id )
    local cfg = self.functionMap[id]
    if cfg == nil then return false end
    return cfg.isopen > 0
end

return GlobalFuncDataMgr:new()
