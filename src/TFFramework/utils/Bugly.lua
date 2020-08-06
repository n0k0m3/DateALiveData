Bugly = {
    cachedError = {}
}

local NullFunc = function () end

buglyReportLuaException = buglyReportLuaException or NullFunc
buglySetUserId = buglySetUserId or NullFunc
buglySetTag = buglySetTag or NullFunc
buglyAddUserValue = buglyAddUserValue or NullFunc
buglyRemoveUserValue = buglyRemoveUserValue or NullFunc
buglyLog = buglyLog or NullFunc

--[[
    设置用户id，您在页面的异常详情会显示具体用户的id
    在用户登陆时时设置, 用于确认出错的用户
]]
function Bugly:SetUserId(id)
    buglySetUserId(id or "None")
end

--[[
    设置当前场景的“TAG”，int类型（bugly页面可备注该值含义）。

    一次运行过程中只有一个TAG，以上报异常时最后TAG为准。例如登录时设置tag=1，进入副本设置tag=2    
]]
function Bugly:SetTag(tag)
    buglySetTag(tag or -1)
end

--[[
    上报Lua异常
    msg : lua出错时的msg信息
]]
function Bugly:ReportLuaException(msg)
    if self.cachedError[msg] then return end
    self.cachedError[msg] = true
    
    buglyReportLuaException(msg or "Null", debug.traceback())
end

--[[
    上报一些自定义的Key-Value键值对：

    1）最多10对，超出的会被忽略

    2）每个key限长50字节，value限长200字节

    3）key限制为字母 + 数字
]]
function Bugly:AddUserValue(key, val)
    buglyAddUserValue(key or "k", val or "v")
end

--[[
    移除键值对
]]
function Bugly:RemoveUserValue(key)
    buglyRemoveUserValue(key or "k")
end

--[[
    记录开发者自定义的关键信息日志。该日志会随异常信息一起上报。

    Lv:
        Off=0, Error=1,Warning=2,Info=3,Debug=4,Verbose=5

    注：Log最大长度约10K，超长会保留最近内容。建议每条Log长度控制在200字节以内。
]]
function Bugly:Log(lv, tag, msg)
    buglyLog(lv or 0, tag or "Normal", msg or "Null")
end