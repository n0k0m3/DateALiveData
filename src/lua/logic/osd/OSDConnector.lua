local ServerEvent = require("lua.logic.osd.OSDEnum").ServerEvent

local OSDConnector = {}


OSDConnector.InitialKeys = {0xac, 0x12, 0x19, 0xcd, 0x95, 0x34, 0xcb, 0xf1}
OSDConnector.EncodeKeys   = {1,2,3,4,5,6,7,8}

local MAX_RECONNECT_TIMES = 1

function OSDConnector:init()
	self.bConnected      = false
    self.nReconnectTimes = 0
end

function OSDConnector:close()
	self.bConnected      = false
    self.nReconnectTimes = 0
    self:stopHeartBeatTimer()
    if self.client then 
        self.client:CloseSocket(true)
        self.client = nil
    end
end


function OSDConnector:isConnected()
    return self.bConnected
end
--重连
function OSDConnector:reconnect()
    if self.nReconnectTimes < MAX_RECONNECT_TIMES then
        self.nReconnectTimes = self.nReconnectTimes + 1
        print("重连第"..tostring(self.nReconnectTimes).."次")
        self:connect()
        return true
    else
        printError("已超过最大重连次数")
        return false
    end
end


local function __setUDPParams(client)
	local keys = OSDConnector.InitialKeys
    client:SetEncodeKeys(keys)
    client.recvHeadFunc = function()
            local errorCode = client:UnpackHeadInt()
            return {
                errorCode = errorCode
            }
        end
end

--启动心跳定时器
function OSDConnector:startHeartBeatTimer()
    if self.heartbeatTimer == nil then
        self.heartbeatTimer = TFDirector:addTimer(3000,-1,nil,function()
            OSDConnector:sendHeartbeat()
        end)
    end
end

--停止心跳计时器
function OSDConnector:stopHeartBeatTimer()
	if self.heartbeatTimer then 
		TFDirector:removeTimer(self.heartbeatTimer)
		self.heartbeatTimer = nil
	end
end

function OSDConnector:setEncodeKeys(keys)
    if self.client then 
        self.client:SetEncodeKeys(keys)
    end
end

--连接成功
local function onConnected(nResult)
	local self =  OSDConnector
    print("OSDServer onConnected:",nResult)
    if nResult == 1 then
        self.bConnected      = true
        self.nReconnectTimes = 0
        -- local session = MainPlayer:getPlayerId()
        -- __setUDPParams(self.client)
        --请求进入(这个必须在这发)
        self.client.recvHeadFunc = function()
            local errorCode = self.client:UnpackHeadInt()
            return {errorCode = errorCode}
        end

        self:setEncodeKeys(OSDConnector.InitialKeys)
         print("OSDServer onConnected ")
        OSDDataMgr:onConnected()
        self:startHeartBeatTimer()

    elseif nResult == -1 or nResult == -2 then
        self.bConnected      = false
        if not self:reconnect() then
            print("OSDServer onConnectError 22")
            OSDDataMgr:onConnectError()
            OSDConnector.showTips(240037)
        end
    end
end

--连接错误
local function onConnectError()
	local self = OSDConnector
    self:stopHeartBeatTimer()
    print("OSDServer onConnectError 11")
    self.bConnected = false
    OSDDataMgr:onConnectError()
    OSDConnector.showTips(240037) --TODO 这个提示可能需要更换
end

function OSDConnector.showTips(idOrText) 
    local timer 
    timer = TFDirector:addTimer(800,1,nil,function()
        TFDirector:removeTimer(timer)
                    Utils:showTips(idOrText)
                end)

end
--连接服务器
function OSDConnector:connect(serverInfo)
    self.serverInfo = serverInfo or self.serverInfo
    print("connect OSDServer host:",self.serverInfo.host,"port:",self.serverInfo.port)
    if self:isConnected() then
        return
    end
    --没有的情况是重连 不需要重置连接次数
    if serverInfo then 
        self.nReconnectTimes = 0
    end
    self.bConnected      = false
    --创建连接
    if not self.client then
        self.client = TFClientNet:create(0,true)
    end
    self.client:Connect(self.serverInfo.host , self.serverInfo.port ,onConnected, nil,onConnectError)
end

--心跳要不要
function OSDConnector:sendHeartbeat()
    -- print("-------------------发送心跳-------------------")
    OSDConnector:send(c2s.FIGHT_REQ_FIGHT_HEARTBEAT,{})
end

--发送消息
function OSDConnector:send(nCode,tMsg,rsa)
    if self.bConnected then
        -- print("OSDConnector send::::::::::::",nCode,tMsg)
        return self.client:Send(nCode,tMsg,rsa)
    else
        print("OSDConnector not connect")
    end
end

OSDConnector:init()
return OSDConnector