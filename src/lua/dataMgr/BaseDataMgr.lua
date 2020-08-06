
local BaseDataMgr = class("BaseDataMgr")

function BaseDataMgr:ctor(...)
    self:init(...)
end

function BaseDataMgr:init()

end

function BaseDataMgr:reset()

end

function BaseDataMgr:onLogin()
    return {}
end

function BaseDataMgr:onLoginOut()
    self:reset()
end

function BaseDataMgr:onEnterMain()

end

return BaseDataMgr
