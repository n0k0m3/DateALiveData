local TFProtocolManager = TFDirector:getTFProtocolManager()
local __waitLoginMsg = {}
local loginMsgCode = {}     -- 登录时各模块消息code集合
local sendLoginMsg = false; --是否在发送登录时各模块获取数据消息
local NetWork = {}
local sendTable = {}

function NetWork:reset()
    __waitLoginMsg = {}
    loginMsgCode = {}
    sendTable = {}
    sendLoginMsg = false;
end

function NetWork:waitLoginS2CMsg(msgId)
    sendLoginMsg = true;
    local index = table.indexOf(__waitLoginMsg, msgId)
    if index ~= -1 then return end
    table.insert(__waitLoginMsg, msgId)
end

function NetWork:getWaitLoginS2CMsg()
    return __waitLoginMsg
end

function NetWork:handleLoginMsg(msgId)
    local index = table.indexOf(__waitLoginMsg, msgId)
    if index == -1 then return end
    table.remove(__waitLoginMsg, index)
    if #__waitLoginMsg == 0 then
        dump("#__waitLoginMsg == 0")
        hideAllLoading();
        --TFDirector:dispatchGlobalEventWith("LoginLayer.LoginComplete")
        local scene = Public:currentScene();
        if scene.__cname ~= "LoginScene" then --重连成功派发事件
            print("EventMgr:dispatchEvent(EV_RECONECT_EVENT)")
            EventMgr:dispatchEvent(EV_RECONECT_EVENT)
        else
            EventMgr:dispatchEvent("LoginLayer.LoginComplete")--登录成功切到主场景
        end
        return true;
    end

    return false
end

function NetWork:collectLoginMsgCode(nCode)
    if sendLoginMsg then
        loginMsgCode = loginMsgCode or {}
        table.insert(loginMsgCode,nCode);
    end
end

function NetWork:checkLoginMsgOver()
    if not loginMsgCode then
        return false;
    end

    local ret = false
    for k,v in pairs(loginMsgCode) do
        ret = NetWork:handleLoginMsg(v);
        if ret then
            break;
        end
    end

    return ret;
end

function NetWork:ForceLogout()
    --登出
    TimeOut(function()
            if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
                HeitaoSdk.loginOut();
                return
            end
            CommonManager:closeConnection2(); 
            end,0.5) 

    TFDirector:closeSocket()
end

function NetWork:restartGame(tips)
    showMessageBox(tips , EC_MessageBoxType.okAndCancel,function()
                       restartLuaEngine("")
    end)
end

--异常处理
function NetWork:exceptionHandling(errorCode)
    local currentScene = Public:currentScene();
    if errorCode == 100024 then         --被挤下线
        NetWork:ForceLogout();
    elseif errorCode == 100018 then     --token失效
        CommonManager:closeConnection();
    elseif errorCode == 100042 then     
        NetWork:ForceLogout();--被踢下线
    elseif errorCode == 100044 then     
        NetWork:ForceLogout();--防沉迷
    elseif errorCode == 100017 then--需要热更     
        -- NetWork:restartGame("客户端版本号过低，请重启游戏") 
        NetWork:restartGame(TextDataMgr:getText(100000084)) 
    elseif currentScene.__cname == "LoginScene" then
        CommonManager:closeConnection2();
    end
end

----------------------------------------------------------------------
--不添加loading的协议码
local NoLoadingCodes =
    {
        c2s.LOGIN_ENTER_GAME ,  
        s2c.LOGIN_PONG , 
        c2s.PLAYER_RECORD_CLIENT_ERR ,  
        c2s.DUNGEON_SCENE_SYNCHRONIZE ,  
        c2s.TASK_REQ_TOUCH_TASK ,
        c2s.DUNGEON_REQ_VERIFY_HURT ,
        c2s.DUNGEON_REQ_VERIFY_FIGHT_RESULT ,
        c2s.TEAM_REQ_APPRECIATE,
        c2s.TEAM_REQ_CHASM_REPORT,
        c2s.NEW_WORLD_REQ_NEW_WORLD_CHAT,
        c2s.DATING_REQ_AITRAINING_AUDIT,
        c2s.DATING_REQ_AITRAINING_QUESTIONS,
        c2s.DATING_REQ_AITRAINING_INFO,
        c2s.DATING_REQ_AITRAINING_SUBMIT
    }
--是否需要添加loading
local function _isShowLoading(code)
    return table.indexOf(NoLoadingCodes, code) == -1 and not sendLoginMsg 
end

function TFDirector:send(nCode, tMsg, rsa)
    if not nCode then
        Box("nCode is null !")
        return
    end   
    TFDirector.nSendCount = TFDirector.nSendCount + 1
    print(string.format("==================== send ============= 0x%04x 发送第%d条, 接收了%d条", nCode, TFDirector.nSendCount, TFDirector.nReciveCount))
    if _isShowLoading(nCode) then
        table.insert(sendTable,nCode);
        showLoading()
    end

    return TFDirector:getNetWork():Send(nCode,tMsg,rsa)
end


local NetOP = TFDirector:getNetWork()
-- 重写NetOP:RecvData方法，处理状态码
function NetOP:recvHeadFunc(nProtoType)
    local errorCode = self:UnpackHeadInt()
    return {
        errorCode = errorCode
    }
end

local NetHelper = require("TFFramework.net.NetHelper")
-- 重写NetHelper:receive方法，处理登录等待消息
function NetHelper.receive(nType, tTemp)
    if nCode ~= c2s.LOGIN_ENTER_GAME and nType ~= s2c.LOGIN_PONG and nCode ~= 279 then
        table.removeItem(sendTable,nType);
    end

    if table.count(sendTable) == 0 and not sendLoginMsg then
        hideAllLoading()
    end

    -- 不显示心跳消息提示
    if nType ~= s2c.LOGIN_PONG and nType ~= s2c.FIGHT_NOTIFY_NET_FRAME then
        SetConcoleTextColor(ConsoleColor.forg.buff, ConsoleColor.forg.buff, ConsoleColor.forg.buff)
        print(string.format("receive message id -> %s", nType))
        SetConcoleTextColor()
    end
    -- dump(nType)
    NetWork:collectLoginMsgCode(nType)
    local errorCode = tTemp.__headInfo__.errorCode
    if errorCode ~= 0 then
        SetConcoleTextColor(ConsoleColor.forg.lavender, ConsoleColor.forg.lavender, ConsoleColor.forg.lavender)
        print(string.format("errorCode -> %s", errorCode))
        SetConcoleTextColor()
        if errorCode ~= 100017 and errorCode ~= 203015 then
            Utils:showTips(errorCode)
        end
        NetWork:exceptionHandling(errorCode);
        -- return
    end
    -- 删除状态码数据，避免扰乱游戏数据
    -- tTemp.__headInfo__ = nil

    TFDirector.nReciveCount = TFDirector.nReciveCount + 1
    -- print("###############receive success#############", string.format("%d, 发送了%d条，接收第%d条",nType, TFDirector.nSendCount, TFDirector.nReciveCount));

    TFDirector:dispatchProtocolWith(nType, tTemp)

    -- 处理登录等待消息
    --NetWork:handleLoginMsg(nType)
end

function TFDirector:addProto(nProtoType, objTarget, func, swallow)
    TFProtocolManager:addProtocolListener(nProtoType, objTarget, func, swallow)
end

local function nilCheck(obj, szName)
    if not obj then
        print("TFProtocolManager:[" .. szName .. "] can not be nil")
        return true
    end
    return false
end

local TFProtocolManagerEx = {}

function TFProtocolManagerEx:addProtocolListener(nProtoType, objTarget, func, swallow)
    if swallow == nil then swallow = true end
    if nilCheck(objTarget, "objTarget") or nilCheck(nProtoType, "nProtoType") or nilCheck(func, "func") then
        return
    end
    local tEvents = self:list()
    tEvents[nProtoType] = tEvents[nProtoType] or {}
    tEvents[nProtoType][objTarget] = tEvents[nProtoType][objTarget] or {}

    local tFuncs = tEvents[nProtoType][objTarget]
    for k, v in pairs(tFuncs) do
        if v.func and v.func == func then return end
    end
    tFuncs[#tFuncs + 1] = {func = func, swallow = swallow}
end

function TFProtocolManagerEx:dispatchWith(nProtoType, tData)
    if  nilCheck(nProtoType, 'nProtoType') then
        return
    end
    local tEvents = self:list()
    if tEvents[nProtoType] then
        local tCloneEvents = table.clone(tEvents[nProtoType])
        for objTarget, tFuncs in pairs(tCloneEvents) do
            if tEvents[nProtoType][objTarget] == nil then return end
            for k, v in pairs(tFuncs) do
                local errorCode = tData.__headInfo__.errorCode
                tData.__headInfo__ = nil
                if errorCode == 0 then
                    self:execute(v.func, {name = nProtoType, target = objTarget, data = tData, errorCode = errorCode})
                else
                    if not v.swallow then
                        self:execute(v.func, {name = nProtoType, target = objTarget, data = tData, errorCode = errorCode})
                    end
                end
            end
        end
    end
end

for k, v in pairs(TFProtocolManagerEx) do
    rawset(TFProtocolManager, k, v)
end

----------------------------------------------------------------------

return NetWork
