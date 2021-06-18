if LockStep then
    return LockStep
end
local BattleConfig      = import(".BattleConfig")
local BattleUtils       = import(".BattleUtils")
local NetWait           = import(".TeamFightNetWait")
local enum              = import(".enum")
local eEvent            = enum.eEvent
local eKeyEventType     = enum.eKeyEventType
local eVKeyCode         = enum.eVKeyCode
local eAttrType         = enum.eAttrType
local eRoleType         = enum.eRoleType
local eAState           = enum.eAState

local eErrorCode =
{
ALREADY_START   = 241003,    --战斗已开始
NOT_IN_FIGHT    = 241004,    --你不属于该战斗
NOT_FOUNT_FIGHT = 241002,    --战斗不存在
}
--TODO 屏蔽日志
local _print = print
local print = function( ... )
    -- body
end


local trans_table1 =
{
    [eKeyEventType.DOWN]  = 1,
    [eKeyEventType.DOING] = 2,
    [eKeyEventType.UP]    = 3
}

local trans_table2 =
{
    [1]=eKeyEventType.DOWN ,
    [2]=eKeyEventType.DOING,
    [3]=eKeyEventType.UP
}

local eRunState = 
{
   READY     = 0 ,--准备(未开始)
   RUNING    = 1 ,--战斗进行中
   ENDED     = 2 ,--战斗结束
}


LockStep = {}
local this = LockStep

--网络连接超时时间
local TIMEOUT_TIME = 3000

--重连次数
local MAX_RECONNECT_TIMES = 3
--组队战斗的连接类型
local eConnectType  = 
{
    TCP = 2 ,
    UDP = 1  --kcp
}
LockStep.ConnectType = eConnectType.UDP
-- LockStep.DEFAULF_FRAME_INTERVAL = 1/50  --本地帧刷新频率
-- LockStep.SPEED_FRAME_INTERVAL   = 1/15  --服务端刷新频率
-- LockStep.SPEED_SCALE            = 3.0  --服务端刷新频率

-- LockStep.DRAW_FRAME_TO_OPERATE          = 4
-- LockStep.SPEED_JUMP_FRAME_VAL           = 7 * LockStep.DRAW_FRAME_TO_OPERATE
-- LockStep.SPEED_INTERVAL_FRAME_VAL       = 4--1 * LockStep.DRAW_FRAME_TO_OPERATE
-- LockStep.SPEED_INTERVAL_FRAME           = 10            --补帧加速单次加速帧数
-- LockStep.DRAW_FRAME_PER_Dt              = 0.016         --单帧间隔时间
-- LockStep.MAX_NET_DELAY                  = 300           --最大服务器延迟
-- LockStep.MIN_NET_DELAY                  = 66         --最小服务里延迟


LockStep.SPEED_INTERVAL_FRAME_VAL       = 2--1 * LockStep.DRAW_FRAME_TO_OPERATE
LockStep.SPEED_INTERVAL_FRAME           = 8            --补帧加速单次加速帧数
LockStep.MAX_NET_DELAY                  = 66*4       --最大服务器延迟
LockStep.MIN_NET_DELAY                  = 66         --最小服务里延迟
LockStep.MIN_JUMP_COUNT                 = 2          --最小补帧数

LockStep.FPS                            = 45         --组队战斗的FPS
if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
    LockStep.FPS                        = 60  
end

LockStep.isLock = false

local function print__(...)
    local n = select('#', ...)

    local tb = {}

    table.insert(tb, '[' .. os.date() .. ']')
    for i = 1, n do
        local v = select(i, ...)
        local str = serialize(v)
        table.insert(tb, str)
    end

    local ret = table.concat(tb, '  ')

    print_(ret)

    return ret
end

function LockStep.trans2Value(text)
    return trans_table1[text]
end

function LockStep.trans2String(value)
    return trans_table2[value]
end

function LockStep.setConnectType(connectType)
    LockStep.ConnectType = connectType
end
--当前时间(毫秒数)
function LockStep.gettime()
    return math.floor(TFTime:clock() *1000)
end

function LockStep.setFPS(fps)
    if this.fps ~= fps then
        SettingDataMgr:setFPS(fps)
        this.fps = fps
    end
end

function LockStep.initlize()
    this.nDtVal = 0
    this.bFirstUpdate    = true
    --逻辑帧
    this.nOperateFrameIdx = 0
    --操作帧列表
    this.frameEvents = {}
    --每几个渲染帧一个操作帧
    this.nDrawFrameToOperate      = math.floor(LockStep.FPS /15)
    --需要直接跳转加速的帧误差
    this.nSpeedJumpFrameVal       = 10  --大于10帧开始跳帧   5-10 为理想区间  小于       --5 * this.nDrawFrameToOperate
    --每帧渲染时长
    this.DRAW_FRAME_PER_Dt        = math.ceil(10000/ LockStep.FPS )*0.0001         --单帧间隔时间

-- Box("this.DRAW_FRAME_PER_Dt:"..tostring(this.DRAW_FRAME_PER_Dt))
    -- Box("this.DRAW_FRAME_PER_Dt:"..this.DRAW_FRAME_PER_Dt)
    --帧同步开始标识
    this.nRunState = eRunState.READY -- 未开始
    ---ppp----
    this.nSpeedInterval = 0
    this.bSpeedIntervaled = false
    this.nTotalFrameNum = 0
    this.nSpeedIntervalFrameVal = this.SPEED_INTERVAL_FRAME_VAL

    this.nMaxJumpTime = 1000/LockStep.FPS*1.2
    --所有玩家网络延迟
    this.netDelayTimes = {}
    --战斗结束返回的数据
    this.endData  = nil
    -- CCDirector:sharedDirector():setDisplayStats(true)

    this.synchronBossStateTime = 0
    this.ipArray = TFArray:new()
    this.connectedIpArray = TFArray:new()
    this.AIHostCheckTime = 0
    this.syncAIHostPid = nil
end
function LockStep.setRunState(state)
    this.nRunState = state
end

function LockStep.info()
    local msg1 = "每 " ..this.nDrawFrameToOperate .. " 帧一个操作帧"
    print(msg1)
end


function LockStep.reset()
    this.initlize()
    this.setFPS(LockStep.FPS)
    this.closeUDP()
end


function LockStep.start()
    this.nDtVal = 0
    this.setRunState(eRunState.RUNING)
end


--缓存操作事件
function LockStep.addOperateFrame(data)
    local index = data.index
    if this.nOperateFrameIdx < index then
        this.nOperateFrameIdx = index
    end
    if data.operateFrame or data.dataFrame or data.bossFrame or data.aiFrame then
        this.frameEvents[index] = data
    end
end


--显示网络等待
function LockStep.showNetWait()
    NetWait.show()
end

--关闭网络等待
function LockStep.closeNetWait()
     NetWait.hide()
end

--同步boss信息(每3秒同步一次血量)
function LockStep.synchronBossState(markID)
    if markID then
        local pid = MainPlayer:getPlayerId()
        local hero_pid = this.getAISyncHostPid()
        if pid == hero_pid then
            local enemys = battleController.getEnemyMember()
            for i, enemy in ipairs(enemys) do
                if enemy and markID == enemy:getData().markID then
                    if enemy:isFlag(1) then
                        local pos3D = enemy:getPosition3D()
                        local dir   = enemy:getDir()
                        local hp    = enemy:getHp()
                        local sp    = enemy:getResist()
                        local data = {}
                        data[1] = enemy:getData().markID
                        data[2] = math.floor(pos3D.x)
                        data[3] = math.floor(pos3D.y)
                        data[4] = dir
                        data[5] = hp
                        data[6] = pid
                        data[7] = sp
                        this.sendBossState(data)
                    end
                    break
                end 
            end
        end
    else
        local time = LockStep.gettime()
        local limitTime = BattleConfig.BOSS_STATE_SYNCHRON_TIME
        if battleController.useCustomAttrModle() then
            limitTime = BattleConfig.BOSS_STATE_SYNCHRON_TIME * 4
        end
        if time - this.synchronBossStateTime > limitTime then
            this.synchronBossStateTime =  time
            local enemys = battleController.getEnemyMember()
            for i, enemy in ipairs(enemys) do
                if enemy and enemy:isFlag(1) then
                    local hp    = enemy:getHp()
                    local data = {}
                    data[1] = enemy:getData().markID
                    data[2] = 0
                    data[3] = 0
                    data[4] = 0
                    data[5] = hp
                    data[6] = MainPlayer:getPlayerId()
                    data[7] = enemy:getResist()
                    this.sendBossState(data)
                end 
            end
        end
    end
end
--同步角色伤害
function LockStep.syncHeroHurtValue(hero)
    -- if this.isMe(hero) then
        local roleType = hero:getRoleType()
        if roleType == eRoleType.Team then 
            if this.isMe(hero) then --只同步自己的伤害
                local message = {-3,0,0,0,0,hero.data.pid,math.floor(hero:getHurtValue()),0}
                this.sendOperate(message)
            end 
        end
    -- end
end


--同步角色血量(血量变更的时候同步)
function LockStep.synchronHp(hero)
    local roleType = hero:getRoleType()
    if roleType == eRoleType.Team then
        if this.isMe(hero) then
            local state = 0
            if hero:isAState(eAState.E_RELIVE) then 
                state = eAState.E_RELIVE
            end
            local message = {-2,0,0,0,0,state,hero:getHp(),hero:getResist()}
            this.sendOperate(message)
        end        
    elseif roleType == eRoleType.Monster then
        -- --只同步怪血量    
        if hero:isFlag(1) then
            local hp    = hero:getHp()
            local data = {}
            data[1] = hero:getData().markID
            data[2] = 0
            data[3] = 0
            data[4] = 0
            data[5] = hp
            data[6] = MainPlayer:getPlayerId()
            data[7] = hero:getResist()
            this.sendBossState(data)
        end
    end
end

function LockStep.syncAIStepData(markID, lastIdx, cruIdx, params)
    local playerId = MainPlayer:getPlayerId()
    local hero_pid = this.getAISyncHostPid()
    if playerId ~= hero_pid then
        return
    end
    if lastIdx > 0 then
        if battleController.useCustomAttrModle() then

        else
            this.synchronBossState(markID)
        end
    end
    local data = {}
    data[1] = markID
    data[2] = playerId
    data[3] = lastIdx
    data[4] = cruIdx
    data[5] = params[1] or -1
    data[6] = params[2] or -1
    data[7] = params[3] or -1
    data[8] = params[4] or -1
    this.sendAIStepData(data)
end

--丢弃无效帧数据
function LockStep.discardingUselessframes()
    -- dump({this.nTotalFrameNum , this.nOperateFrameIdx ,this.nDrawFrameToOperate})
    -- dump(this.frameEvents)
    this.nTotalFrameNum = this.nOperateFrameIdx * this.nDrawFrameToOperate
    -- dump({this.nTotalFrameNum , this.nOperateFrameIdx ,this.nDrawFrameToOperate})
end

function LockStep.update(dt,game)
    this.gameView = game
    if this.nRunState == eRunState.READY then
        this.gameView:gameRun(0)
        this.checkEnd()
    elseif this.nRunState == eRunState.RUNING then
        this.synchronBossState()
        this.synchronBattleTime()
        this.stepUpdate(dt)
        this.checkEnd()
    elseif this.nRunState == eRunState.ENDED then
        this.gameView:gameRun(dt)
    end
    -- _print("this.nRunState:",this.nRunState)
end

function LockStep.doFrame( frameDt )
    if this.canPlayFrameNum() < 1 then
        if not LockStep.isLock then
            this.gameView:gameRun(frameDt)
        end
        return false
    end
    this.nTotalFrameNum = this.nTotalFrameNum + 1
    if this.nTotalFrameNum % this.nDrawFrameToOperate == 0 then
        local operaterameIdx  =  this.nTotalFrameNum/this.nDrawFrameToOperate
        -- print_("this.nTotalFrameNum:"..tostring(this.nTotalFrameNum).." operaterameIdx:"..tostring(operaterameIdx))
        local frameData = this.frameEvents[operaterameIdx]
        if frameData ~= nil then
            this.frameEvents[operaterameIdx] = nil
            this.excuteFrameData(frameData.operateFrame)
            this.excuteHeroAction(frameData.dataFrame)
            this.excuteBossAction(frameData.bossFrame)
            this.excuteAIStepFrame(frameData.aiFrame)
        end
    end
    this.gameView:gameRun(frameDt)
    return true
end

function LockStep.countDownSpeedJump()
    -- print("this.nSpeedInterval ",this.nSpeedInterval )
    -- local time  = LockStep.gettime()
    local count = 0
    this.JumpFrame = true
    while this.nSpeedInterval == -1 do
        -- dump("this.nSpeedInterval == -1")
        this.doFrame( this.DRAW_FRAME_PER_Dt )
        this.validSpeedInterval()
        count = count + 1
        if count > 6 then 
            break
        end
    end
    this.JumpFrame = false
    -- dump("this.nSpeedInterval == cao")
end

function LockStep.validSpeedInterval()
    local nFrameVal = this.canPlayFrameNum()
    if nFrameVal > this.nSpeedJumpFrameVal then --this.nSpeedJumpFrameVal then --> 跳帧
        this.nSpeedInterval = -1 
    elseif nFrameVal > (this.nSpeedJumpFrameVal -5 ) then     --this.getSpeedIntervalFrameVal() then --加速
        this.nSpeedInterval =  2  --this.SPEED_INTERVAL_FRAME
    else  --正常播放
        this.nSpeedInterval = 0
    end
end

function LockStep.getSpeedIntervalFrameVal()
    return this.nSpeedIntervalFrameVal
end

function LockStep.setNetWorkDelay( timeDelay )
    if timeDelay > this.MAX_NET_DELAY then
        timeDelay = this.MAX_NET_DELAY
    end
    if timeDelay < this.MIN_NET_DELAY then
        timeDelay = this.MIN_NET_DELAY
    end
    local nF = this.SPEED_INTERVAL_FRAME_VAL * timeDelay/this.MIN_NET_DELAY
    nF = math.ceil(nF)
    nF = nF + this.SPEED_INTERVAL_FRAME_VAL  --- 避免临界值误差，缓冲
    -- print("this.nSpeedIntervalFrameVal:",nF)
    this.nSpeedIntervalFrameVal = nF
end


-- local xxxxxxx = {}
--     xxxxxxx[#xxxxxxx + 1] = (totalFrameNum - this.nTotalFrameNum)
--     if #xxxxxxx > 45 then
--         print__(xxxxxxx)
--         xxxxxxx = {}
--     end


function LockStep.canPlayFrameNum()
    return this.nOperateFrameIdx * this.nDrawFrameToOperate  + this.nDrawFrameToOperate - 1   - this.nTotalFrameNum 
end



--检查战斗是否可以结束
function LockStep.checkEnd()
    if this.endData then --已经接受刅战斗的结束的数据
        if this.canPlayFrameNum() < 1 then  --没有网络贞可以播 才可以结束
            -- Box("消耗时间"..tostring(this.nOperateFrameIdx*1000/15).."::"..tostring(this.nOperateFrameIdx * this.nDrawFrameToOperate*this.DRAW_FRAME_PER_Dt ))
            this.setRunState(eRunState.ENDED)
            TeamFightDataMgr:onRecvOverFight(this.endData)
        end
    end
end


function LockStep.excuteFrameData(data)
    if data == nil then
        return
    end
    print("每贞执行包的数量",#data)
    for i, operate in ipairs(data) do
        local id         = operate.pid
        if id ~= MainPlayer:getPlayerId() then

                -- print("-----------------LockStep excuteFrameData ",keyCode , keyEvent)
            local keyCode    = operate.keyCode
            print("xxx",keyCode)
            local keyEvent   = operate.keyEvent
            local keyEventEx = operate.keyEventEx

            if keyCode == -4 then --时间同步处理
                -- print_("rev time:"..tostring(operate.hp))
                battleController.fixTime(operate.hp)
            elseif keyCode == -3 then --伤害同步
                local pid = operate.dir
                hero = battleController.getPlayer(pid)
                if hero then
                    hero:fixHurtValue(operate.hp)
                end
            elseif keyCode == -2 then --血量同步
                local hero = battleController.getPlayer(id)
                if hero then
                    hero:fix(nil, nil,nil, operate.hp,operate.dir)
                end
            elseif keyCode == eVKeyCode.ROKE then  --摇杆
                local hero = battleController.getPlayer(id)
                if hero then
                    local vx ,vy = LockStep.decode(keyEvent,keyEventEx)
                    hero:fix(operate.posX , operate.posY ,nil, operate.hp)
                    hero:setRokeVector(vx,vy)
                end
            else
                local hero = battleController.getPlayer(id)
                if hero then
                    hero:fix(operate.posX, operate.posY ,operate.dir, operate.hp)
                    hero:createAndPush(keyCode, LockStep.trans2String(keyEvent),keyEventEx)
                end
            end
        end
    
    end
end

function LockStep.isMe(hero)
    return battleController.getCaptain() == hero
end


-- function LockStep.isLeader()
--     local hero = battleController.getCaptain()
--     if hero and hero:isLeader() then
--         return true
--     end
-- end


function LockStep.excuteBossAction( data )
    if data == nil then
        return
    end
    for i, dataframe in ipairs(data) do
        local enemy  = battleController.getEnemyWithMaskID(dataframe.id)
        if enemy then
            local pid = MainPlayer:getPlayerId()
            local hero_pid = this.getAISyncHostPid()
            if pid ~= dataframe.operate then
                if hero_pid == dataframe.operate then
                    if dataframe.posX ~= 0 or dataframe.posY ~= 0 then
                        enemy:revStateInfoData(clone(dataframe))  
                    end
                end
                enemy:fix_boss(dataframe.operate,nil,nil,nil,dataframe.hp,dataframe.sp)
            end
        end
    end
end

function LockStep.excuteAIStepFrame( data )
    if data == nil then
        return
    end
    for i, dataframe in ipairs(data) do
        local enemy  = battleController.getAllEnemyWithMaskID(dataframe.id)
        if enemy then
            local pid = MainPlayer:getPlayerId()
            local hero_pid = this.getAISyncHostPid()
            if pid ~= dataframe.pid and hero_pid == dataframe.pid then
                local lastStep = dataframe.lastStep
                local curStep = dataframe.curStep
                local params = {}
                params[1] = dataframe.funcID
                params[2] = dataframe.param1
                params[3] = dataframe.param2
                params[4] = dataframe.param3
                enemy:revAIStepData(lastStep , curStep, params)
            end
        end
    end
end

function LockStep.excuteHeroAction( data )
    if data == nil then
        return
    end
    for i, dataframe in ipairs(data) do
        local hero  = battleController.getPlayer(dataframe.pid)
        if hero then
            hero:excuteAction(dataframe.action)
        else
            print("无法找到玩家"..tostring(dataframe.pid))
        end
    end
end

function LockStep.stepUpdate(dt)
    -- this.nDtVal = this.nDtVal + dt
    this.validSpeedInterval()
    this.bSpeedIntervaled = false
    if this.nSpeedInterval == -1 then --跳帧
        -- print_("LockStep jump :"..tostring(this.canPlayFrameNum()))
        this.bSpeedIntervaled = true
        this.countDownSpeedJump()
    elseif this.nSpeedInterval > 0 then --加速
        -- print_("LockStep fast :"..tostring(this.canPlayFrameNum()))
        this.bSpeedIntervaled = true
        this.doFrame( this.DRAW_FRAME_PER_Dt ) 
        this.doFrame( this.DRAW_FRAME_PER_Dt ) 
    else
        -- print_("LockStep normat :"..tostring(this.canPlayFrameNum()))
        this.doFrame(this.DRAW_FRAME_PER_Dt) 
    end
    -- this.doFrame( dt ) 
end
----------------------------------------------------------
--Tip提示
function LockStep.showTips(idOrText, ...)
    local timer 
    timer = TFDirector:addTimer(800,1,nil,function()
        TFDirector:removeTimer(timer)
                    Utils:showTips(idOrText)
                end)

end

--设置参数(在connect调用之后调用才有效)
function LockStep.setUDPParams(client,session)
    if LockStep.ConnectType == eConnectType.UDP then
        local session = MainPlayer:getPlayerId()
        client:setHeadToken(0x712b)
        client:setUseShortPackLen(false)
        client:SetUseDKeys(false)
        client:setKCPWndSize(128, 128)
        client:setKCPMTU(470)
        client:setKCPSession(session)
        client:setKCPMinRTO(30)
        client:setKCPParams(1, 10, 2, 1)
    end

    local keys = {0xac, 0x12, 0x19, 0xcd, 0x95, 0x34, 0xcb, 0xf1}
    client:SetEncodeKeys(keys)
    client.recvHeadFunc = function()
            local errorCode = client:UnpackHeadInt()
            return {
                errorCode = errorCode
            }
        end
end



--关闭连接
function LockStep.closeUDP()
    if this.tb_heartbeat_timer then
        TFDirector:removeTimer(this.tb_heartbeat_timer)
        this.tb_heartbeat_timer = nil
    end
    if this.kcpnet then
        this.kcpnet:CloseSocket(true)
        this.kcpnet = nil
    end
    this.bConnected = false
    this.connectedIpArray:clear()
    this.ipArray:clear()
end

function LockStep.setUDPCfg(host,port)
    this.connectedIpArray:clear()
    this.ipArray:clear()

    local split = string.split(tostring(host), ",")
    for _,_ip in ipairs(split) do
        this.ipArray:push(_ip)
    end

    this.host   = tostring(host)
    this.port   = tonumber(port)
end
--检查是否超时
function LockStep.isTimeOut(dt)
    this.nTimeoutTime = this.nTimeoutTime + dt
    if this.nTimeoutTime > 0 then
        this.onTimeOut()
    end
end

--超时如何处理
function LockStep.onTimeOut()

end

function LockStep:onRevPong(event)
    local data  = event.data
    local time  = data.time --服务器时间
    if tonumber(time) then
        LockStep.sendFightPing(time)
    else
        LockStep.sendFightPing(tostring(ServerDataMgr:getServerTime()))
    end
    -- dump(data)
    if data.data then
        this.netDelayTimes = {}
        for i, info in ipairs(data.data) do
            -- dump({info.pid,info.delayTime})
            -- local delayTime = tonumber(info.pid) % 100
            -- local lastTime = this.netDelayTimes[info.pid]
            -- if lastTime then
            --     delayTime = lastTime + 2
            -- end
            -- if delayTime > 100 then
            --     delayTime = tonumber(info.pid) % 100
            -- end
            this.netDelayTimes[info.pid] = info.delayTime
        end
    end
    if this.syncAIHostPid and this.syncAIHostPid ~= data.hostPlayerId then
        -- local enemys = battleController.getEnemyMember()
        -- for i, enemy in ipairs(enemys) do
        --     if enemy then
        --         enemy:act_delay("id",1.0)
        --     end 
        -- end
    end
    this.syncAIHostPid =  data.hostPlayerId or battleController.getLeaderPid()
    -- _print("网络延迟:",this.netDelayTimes)
    -- local delayTime = this.getNetDelayTime(MainPlayer:getPlayerId())
    -- local  frameNums = delayTime / (this.DRAW_FRAME_PER_Dt*1000)
    -- this.nSpeedJumpFrameVal = math.floor(frameNums)
    -- print_("delayTime:"..delayTime.."-"..this.nSpeedJumpFrameVal)
    -- this.nSpeedJumpFrameVal = math.min(math.max(math.floor(frameNums),8),25)
end

function LockStep.checkSyncAIHost(force)
    local time = LockStep.gettime()
    if force or (time - this.AIHostCheckTime) > 3000 then
        local newPid
        local pid
        local ping = 99999
        local curDelayTime
        for k,v in pairs(this.netDelayTimes) do
            if v > 0 and v < ping then
                ping = v
                pid = tonumber(k)
            end
            if this.syncAIHostPid and this.syncAIHostPid == tonumber(k) then
                curDelayTime = v
            end
        end
        local lastPid = this.syncAIHostPid
        if this.syncAIHostPid then
            if curDelayTime then
                if (curDelayTime - ping) > 100 then
                    newPid = pid
                else
                    newPid = this.syncAIHostPid
                end
            else
                newPid = pid
            end
        else
            newPid = pid
        end
        newPid = newPid or battleController.getLeaderPid()
        if lastPid and lastPid ~= newPid and newPid == MainPlayer:getPlayerId() then
            local enemys = battleController.getEnemyMember()
            for i, enemy in ipairs(enemys) do
                if enemy then
                    enemy:resetAIStepDatas()
                    enemy:endToAI()
                end 
            end
        end
        this.syncAIHostPid = newPid
        this.AIHostCheckTime = time
    end
end

function LockStep.getAISyncHostPid()
    pid = this.syncAIHostPid or battleController.getLeaderPid()
    return pid
end

--战斗结束
function LockStep:onRevEndFight(event)
    -- required bool win = 1;                          // 是否胜利
    -- repeated FightResultdetails results = 2;        // 战斗结果
    -- repeated RewardsMsg rewards = 3;                // 奖励信息
    -- required int32 fightTime = 4;                   // 战斗时间
    -- enum MsgID{eMsgID = 25605;}; //注意：消息id放最后,以免客户端解析异常
    --处理战斗结束消息
    _print("onRev Team Fight end")
    dump(data)
    this.endData = event  --保存战斗结束的数据        
    EventMgr:dispatchEvent(eEvent.EVENT_TEAM_FIGHT_END)
end

--网路帧返回
function LockStep:onRevNetFrame(event)
    --收到战斗结束的数据 ,不再处理网络贞
    if this.endData then
        return
    end
    local errorCode = event.errorCode
    local data      = event.data
    -- print("onRevNetFrame",data)
    -- dump(data)
    -- Box("")
    LockStep.closeNetWait()
    if errorCode == 0 then
        if data.netFrames then
            for i,netFrame in ipairs(data.netFrames) do
                LockStep.addOperateFrame(netFrame)
            end
        end
        LockStep.start()
    elseif errorCode ==  eErrorCode.NOT_IN_FIGHT then --不属于该战斗
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_FOUNT_FIGHT then --战斗不存在
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    end
end
function LockStep:onRevOperate(event)
    -- print("onRevOperate",this.nRenderFrameIdx,event.data)
    local time = LockStep.gettime()
    local passTime = time - this.nRevOperateTime
    -- if this.nRevOperateTime ~= 0 then
    --     LockStep.setNetWorkDelay(passTime)
    -- end
    -- Box("LockStep:onRevOperate")
    this.nRevOperateTime = time
    local netFrame =  event.data.netFrame
    LockStep.addOperateFrame(netFrame)
end


function LockStep:onRevStartFight(event)
    _print("___onRevStartFight:")
    local data = event.data
    dump(data)
    -- Box("___onRevStartFight")
    local heroDatas = battleController.getHeroData()
    local temp = {}
    for i, heroData in ipairs(heroDatas) do
        for i , pid in ipairs(data.pids) do
            if pid == heroData.pid then
                table.insert(temp,heroData)
            end
        end  
    end
    table.sort(temp,function(a ,b)
        return a.pid > b.pid
    end)
    if #data.pids > #temp then
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        return
    end
    battleController:getBattleData().heros = temp
    LockStep.closeNetWait()
    --切换到战斗场景
    battleController.changeToBattleScene()

    -- battleController.herosEnter() --创建角色
    -- LockStep.start()
end

function LockStep:onResOperate(event)
    local errorCode = event.errorCode
    print("onResOperate:"..tostring(errorCode))
    if errorCode == eErrorCode.NOT_FOUNT_FIGHT then
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    end
end

function LockStep:onResEnterFight(event)
    local errorCode = event.errorCode
    local data  = event.data
    local excessTime = data.excessTime
    _print("onResEnterFight:"..tostring(errorCode))
    if errorCode ==  eErrorCode.ALREADY_START then --战斗已经开始
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_IN_FIGHT then --不属于该战斗
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_FOUNT_FIGHT then --战斗不存在
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ~= 0 then
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    end
end

--角色加载进度同步
function LockStep:onRevLoadPercent(event)
    local errorCode = event.errorCode
    local data  = event.data
    _print("onRevLoadPercent:"..tostring(errorCode))
    if errorCode == 0 then --正常
        EventMgr:dispatchEvent(eEvent.EVENT_TEAM_PLAYER_LOAD_STATUS,data.progressList)
    elseif errorCode ==  eErrorCode.ALREADY_START then --战斗已经开始
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_IN_FIGHT then --不属于该战斗
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_FOUNT_FIGHT then --战斗不存在
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    end
end

--关卡切换
function LockStep:onRevChangeDungeon(event)
    local errorCode = event.errorCode
    local data  = event.data
    if errorCode == 0 then --切换关卡
        -- EventMgr:dispatchEvent(eEvent.EVENT_CHANGE_GUNGEON ,data.index)
        battleController.changeDungeon(data.index,data.restTime)
    elseif errorCode ==  eErrorCode.ALREADY_START then --战斗已经开始
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_IN_FIGHT then --不属于该战斗
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    elseif errorCode ==  eErrorCode.NOT_FOUNT_FIGHT then --战斗不存在
        LockStep.closeUDP()
        EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        LockStep.showTips(errorCode)
    end
end

--队长切换
function LockStep:onRevChangeLeader(event)
    local errorCode = event.errorCode
    local data      = event.data
    if errorCode == 0 then 
        print("队长变更:"..tostring(data.newLeaderId))
        battleController.setLeaderPid(data.newLeaderId)
    else
        LockStep.showTips(errorCode)
    end
end



function LockStep.addProto()



    --请求响应
    --进入战斗
    TFDirector:addProto(s2c.FIGHT_RESP_ENTER_FIGHT, this, this.onResEnterFight,false)
    -- 推送开始战斗
    TFDirector:addProto(s2c.FIGHT_NOTIFY_START_FIGHT, this, this.onRevStartFight)
    --战斗操作响应
    TFDirector:addProto(s2c.FIGHT_RESP_OPERATE_FIGHT, this, this.onResOperate,false)
    -- 战斗贞数据
    TFDirector:addProto(s2c.FIGHT_NOTIFY_NET_FRAME, this, this.onRevOperate)
    -- 战斗结束
    TFDirector:addProto(s2c.FIGHT_RESP_END_FIGHT, this, this.onRevEndFight)
    -- 拉取网络贞数据
    TFDirector:addProto(s2c.FIGHT_RESP_PULL_NET_FRAME, this, this.onRevNetFrame,false)
    -- 网络延迟测试
    TFDirector:addProto(s2c.FIGHT_RESP_FIGHT_PONG, this, this.onRevPong,false)
    -- 队友加载进度同步
    TFDirector:addProto(s2c.FIGHT_RESP_LOAD_PROGRESS, this, this.onRevLoadPercent,false)
-- s2c.FIGHT_RESP_ENTER_FIGHT 25601
-- s2c.FIGHT_NOTIFY_START_FIGHT = 25602
-- s2c.FIGHT_RESP_OPERATE_FIGHT 25603
-- s2c.FIGHT_NOTIFY_NET_FRAME = 25604
-- s2c.FIGHT_RESP_END_FIGHT = 25605
-- s2c.FIGHT_RESP_PULL_NET_FRAME = 25606
    --切换关卡
    TFDirector:addProto(s2c.NEW_WORLD_RES_NEW_WORLD_CHANGE_DUNGEON, this, this.onRevChangeDungeon,false)
    --队长切换
    TFDirector:addProto(s2c.NEW_WORLD_UPDATE_TEAM_LEADER, this, this.onRevChangeLeader,false)

end


-- function LockStep.onRev(event)
--     if event.name == s2c.FIGHT_NOTIFY_NET_FRAME then
--     elseif event.name == s2c.FIGHT_NOTIFY_START_FIGHT then
--     end
-- end


-- function LockStep.removeProto()
--     TFDirector:removeProto(s2c.FIGHT_NOTIFY_NET_FRAME, this, this.onRevOperate)
--     TFDirector:removeProto(s2c.FIGHT_NOTIFY_START_FIGHT, this, this.onRevStartFight)
-- end

function LockStep.isConnected()
    return this.bConnected
end


--重连
function LockStep:reconnect()
    if this.nReconnectTimes < MAX_RECONNECT_TIMES*this.ipArray:length() then
        this.nReconnectTimes = this.nReconnectTimes + 1
        this.connect(true)
        return true
    else
        print_("已超过最大重连次数")
        return false
    end
end

--连接服务器
function LockStep.connect(isReconnect)
    print("host:",this.host,"port:",this.port)
    if this.isConnected() then
        return
    end
    time = 0
    if not isReconnect then 
        this.nReconnectTimes = 0
    end
    this.nSendCount      = 0
    this.bConnected      = false

    this.xv  = nil
    this.yv  = nil
    --超时计时
    this.nTimeoutTime  = 0
    --接收逻辑帧时间
    this.nRevOperateTime = 0

    --创建UDP连接
    if not this.kcpnet then
        if LockStep.ConnectType == eConnectType.UDP then
            this.kcpnet = TFClientNet:create(3,true)
        else
            this.kcpnet = TFClientNet:create(0,true)
        end
    end
    --连接成功
    local function onConnected(nResult)
         print("onConnected:",nResult)
        if nResult == 1 then
            this.bConnected      = true
            this.nReconnectTimes = 0
            local session = MainPlayer:getPlayerId()
            this.setUDPParams(this.kcpnet,session)
            --请求开始战斗
            this.sendEnterFight()
            if LockStep.ConnectType == eConnectType.TCP then
                this.kcpnet:SetEncodeKeys({1,2,3,4,5,6,7,8})
                -- this.kcpnet:SetDecodeKeys({1,2,3,4,5,6,7,8})
            end
            if this.tb_heartbeat_timer == nil then
                this.tb_heartbeat_timer = TFDirector:addTimer(3000,-1,nil,function()
                    this.sendHeartbeat()
                end)
            end
            this.connectedIpArray:clear()
        elseif nResult == -1 or nResult == -2 then
            this.bConnected      = false
            if not this.reconnect() then
                Utils:showError(100000016)
                EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            end
        end
    end
    --连接错误
    local function onConnectError()
        print("连接失败")
        this.bConnected = false
        if not this.reconnect() then
            Utils:showError(100000016)
            EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
        end
    end

    local connectIp = ""
    if this.connectedIpArray:length() <= 0 then
        connectIp = this.ipArray:front()
    else
        local connectedIp = this.connectedIpArray:back()
        local index = this.ipArray:indexOf(connectedIp)
        connectIp = this.ipArray:getObjectAt((((index + 1) - 1)%this.ipArray:length()) + 1)
    end
    this.connectedIpArray:push(connectIp)

    this.kcpnet:SetConnTOT(5)
    this.kcpnet:Connect(connectIp , this.port ,onConnected, nil, onConnectError)

    -- local time = 0
    -- for _ip in this.connectedIpArray:iterator() do
    --     if _ip == connectIp then
    --         time = time + 1
    --     end
    -- end
    -- if HeitaoSdk and time <= 1 then
    --     HeitaoSdk.reportNetworkData(connectIp)
    -- end
end

function LockStep.sendHeartbeat()
    LockStep.send(c2s.FIGHT_REQ_FIGHT_HEARTBEAT,{})
end

function LockStep.send(nCode,tMsg,rsa)
    if this.bConnected then
        this.nSendCount = this.nSendCount + 1
        -- print(string.format("KcpNetMgr send  0x%04x 发送第%d条", nCode, this.nSendCount))
        print(string.format("KcpNetMgr send  %s 发送第%d条", nCode, this.nSendCount))
        -- print(nCode,tMsg,rsa)
        return this.kcpnet:Send(nCode,tMsg,rsa)
    end
    print("kcpnet not connected!")
end


---------------------按键代理------------------------------
function LockStep.encode(vx,vy)
    vx = vx * 100
    vy = vy * 100
    return vx ,vy
end

function LockStep.decode(vx, vy)
    vx = vx * 0.01
    vy = vy * 0.01
    -- _print("decode",vx ,vy)
    return vx, vy
end



function LockStep:setRokeVector(vx,vy)
    -- dump({vx,vy,this})
    local _vx = vx
    local _vy = vy
    vx , vy = LockStep.encode(vx,vy)
    if this.vx == vx and this.vy == vy  then
        return
    end
    if this.isAllowInput() then
        this.vx = vx
        this.vy = vy
        -- _print(this.xyv)
        local posX =  0
        local posY =  0
        local dir  =  0
        local hp   =  0
        local sp   =  0
        local playId = MainPlayer:getPlayerId()
        local hero   = battleController.getPlayer(playId)
        if hero then
            hero:setRokeVector(_vx,_vy)
            local pos3D  = hero:getPosition3D()
            posX =  math.floor(pos3D.x)
            posY =  math.floor(pos3D.y)
            dir  =  hero:getDir()
            hp   =  hero:getHp()
            sp   =  hero:getResist()
        end
        if battleController.isZLJH() then --追猎计划不同步操作
            return
        end

        local message = {-1,vx,vy,posX,posY,dir,hp,sp}
        this.sendOperate(message)

        
    end
end


function LockStep:isValidKey(keyCode)
    return true
end

function LockStep:createAndPush(keyCode,eventType,skillSubId)
    -- print("Input key:", keyCode," event:",eventType)
    if this.isAllowInput() then
        local posX =  0
        local posY =  0
        local dir  =  0
        local hp   =  0
        local sp   =  0
        local playId = MainPlayer:getPlayerId()
        local hero   = battleController.getPlayer(playId)


        if hero then
            hero:createAndPush(keyCode, eventType,skillSubId)
            local pos3D  = hero:getPosition3D()
            posX =  math.abs(pos3D.x)
            posY =  math.abs(pos3D.y)
            dir  =  hero:getDir()
            hp   =  hero:getHp()
            sp   =  hero:getResist()
        end

        if battleController.isZLJH() then --追猎计划不同步操作
            return
        end
        local message = { keyCode , LockStep.trans2Value(eventType),0 ,posX,posY,dir,hp,sp}
        -- dump(message)
        this.sendOperate(message)


    end
end
---------------------按键代理结束------------------------------
--获取网路延迟
function LockStep.getNetDelayTime(pid)
    local delayTime = this.netDelayTimes[pid] 
    if delayTime == -1 or not delayTime then
        delayTime = 60
    end
    return delayTime
end
-----------------------------TODO------------------------
--网络延迟测试
function LockStep.sendFightPing(time)
    LockStep.send(c2s.FIGHT_REQ_FIGHT_PING,{time})
end


--请求开始战斗
function LockStep.sendEnterFight()
    --战斗已经结束不需要发送
    if this.endData then
        return
    end
    -- Box("发送组队战斗结束？？")
    -- printError(">>>>>")
    local data    = BattleDataMgr:getBattleData()
    local fightId = data.fightId
    local session = MainPlayer:getPlayerId()
    LockStep.send(c2s.FIGHT_REQ_ENTER_FIGHT,{fightId,session})
    -- LockStep.showNetWait()
end


--发送战斗操作
function LockStep.sendOperate(message)
    --战斗已经结束不需要发送
    if this.endData then
        return
    end
    this.send(c2s.FIGHT_REQ_OPERATE_FIGHT, message)
end

--请求帧数据
function LockStep.sendPullFrame(startIdx)
    --战斗已经结束不需要发送
    if this.endData then
        return
    end
    startIdx = startIdx or 0
    local data    = BattleDataMgr:getBattleData()
    local fightId = data.fightId
    local pid     = MainPlayer:getPlayerId()
    LockStep.send(c2s.FIGHT_REQ_PULL_NET_FRAME,{startIdx,pid,fightId})
    LockStep.showNetWait()
end

-- required int32 randomSeed = 1;          // 最终随机种子
-- required bool isWin = 2;                // 是否胜利
-- repeated MemberData memberData = 3; // 战斗结果
-- required int32 fightTime = 4;           // 战斗时间
--通知战斗结束
function LockStep.sendEndFight(message)
    --战斗已经结束不需要发送
    if this.endData then
        return
    end
    LockStep.send(c2s.FIGHT_REQ_END_FIGHT,message)
end

--发送复活(游戏服确认可以复活的情况下发送复活)
function LockStep.sendRelive()
   --战斗已经结束不需要发送
    if this.endData then 
        return
    end
    LockStep.send(c2s.FIGHT_REQ_REVIVE_FIGHT,{true})
end

--请求退出战斗
function LockStep.sendExitFight(hurtValue)
   --战斗已经结束不需要发送
    if this.endData then 
        return
    end
    hurtValue = hurtValue or 0
    LockStep.send(c2s.FIGHT_REQ_EXIT_FIGHT,{true,hurtValue})
end 

local synchronTime = 0
--同步组队 
function LockStep.synchronBattleTime()
    if this.endData then 
        return
    end
    local _time = LockStep.gettime()
    if _time - synchronTime > 3000 then  --3秒同步一次
        synchronTime =  _time
        local time = battleController.getTime()
        time = math.ceil(time)
        if time > 0 then
            local pid  = MainPlayer:getPlayerId()
            local message = {-4,0,0,0,0,pid,time,0}
            -- print_("sendTime"..tostring(time))
            this.sendOperate(message) 
        end
    end
end 

--请求同步AI信息
function LockStep.sendAIStepData(data)
    if this.endData then 
        return
    end
    LockStep.send(c2s.FIGHT_REQ_AISTEP_FRAME, data)
end


--请求同步boss信息
function LockStep.sendBossState(data)
   --战斗已经结束不需要发送
    if this.endData then 
        return
    end
    -- print_("sendBossState")
    -- dump(data)
    LockStep.send(c2s.FIGHT_REQ_BOSS_STATE, data)
end

--加载进度同步
function LockStep.sendLoadPercent(percent)
   --战斗已经结束不需要发送
    if this.endData then 
        return
    end
    print_("sendLoadPercent:"..tostring(percent))
    local data = {math.floor(percent)}
    LockStep.send(c2s.FIGHT_REQ_LOAD_PROGRESS , data)
end

--[[
    [1] = {--ReqBossState
        [1] = 'int32':id    [Boss ID]
        [2] = 'int32':posX  [位置X]
        [3] = 'int32':posY  [位置Y]
        [4] = 'int32':dir   [角色朝向]
        [5] = 'int32':hp    [角色血量]
        [6] = 'int32':operate   [操作]
    }
--]]

--请求切换场景
function LockStep.sendChangeDungeon(index,resTime)
    --战斗已经结束不需要发送
    if this.endData then
        return
    end
    dump({index,resTime})
    LockStep.send(c2s.NEW_WORLD_REQ_NEW_WORLD_CHANGE_DUNGEON, {index,resTime})
end



--------------------TODO END----------------------------
--清理数据
function LockStep.clean()
    --清理UDP数据和对象
    --清理帧数据和对象
    --防止在非正常情况下推出战斗,强制关闭战斗服连接
    LockStep.closeUDP()
end
--是否允许输入
function LockStep.isAllowInput()
    --TODO 快进模式不能输入
    --TODO 录像模式不能输入
    --TODO 断线不能输入
    --TODO 死亡不能输入
    --TODO 战斗结束不能输入
    if this.endData then  --战斗已经结束
        return false
    end
    local captain = battleController.getCaptain()
    if not captain or captain:isDead() then
        return false
    end

    if battleController.isClearing then
        return false
    end
    return true
end

-- showMessageBox(TextDataMgr:getText(2100110) , EC_MessageBoxType.ok,function()
--     AlertManager:close()
-- end)

this.initlize()
this.addProto()
return LockStep