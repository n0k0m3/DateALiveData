

require("lua.character_set.utf8")
--url编码
require("lua.character_set.urlCodec")
local loadInfo = import(".FileLoader")
local dataMgr = loadInfo.dataMgr
local MainPlayer = class("MainPlayer")
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()

function MainPlayer:ctor(...)
    self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
    self:init()

    if DEBUG == 1 then
        --模拟安卓返回键
        if me.platform == "win32" then
           TFDirector:registerKeyDown(119, {nGap = 500}, function() -- 'F8'
                Utils:onKeyBack()
            end)
        end
    end
end

function MainPlayer:init()
    TFDirector:addProto(s2c.LOGIN_PONG, self, self.recvHeartBeatEvent)
    TFDirector:addProto(s2c.PLAYER_PLAYER_INFO, self, self.onRecvPlayerInfo)
    TFDirector:addProto(s2c.LOGIN_GIFT_CODE_RPS, self, self.exchangeGiftHandle)
    TFDirector:addProto(s2c.PLAYERSET_PLAYER_INFO, self, self.modifyDecHandle)
    TFDirector:addProto(s2c.PLAYER_HELP_FIGHT_HERO, self, self.assistHandle)
    TFDirector:addProto(s2c.ADD_FRIENTS, self, self.onAddFriends)
    TFDirector:addProto(s2c.DELETE_FRIENTS, self, self.onDeleteFriends)
    TFDirector:addProto(s2c.PLAYER_RESP_TARGET_PLAYER_INFO, self, self.onPlayerInfo)
    TFDirector:addProto(s2c.PLAYER_RES_ANTI_ADDICTION_INFO, self, self.resAntiAddictionInfo)
    TFDirector:addProto(s2c.PLAYER_RES_CHANGE_ANTI_ADDICTION, self, self.resDoAntiAddiction)
    TFDirector:addProto(s2c.PLAYER_RES_REPORT_AD, self, self.onReportPlayer)
    TFDirector:addProto(s2c.PLAYER_UPDATE_REFRESH_TIME, self, self.onRecvRefreshTime)
    TFDirector:addProto(s2c.PLAYER_RESP_INVESTOR_SCORE_INFO, self, self.onRecvInvestorScoreInfo)
    TFDirector:addProto(s2c.PLAYER_RESP_RED_POINT, self, self.onRecvRedPointStatusByServer)
    TFDirector:addProto(s2c.ACTIVITY_RESP_SWITCH_LIST, self, self.onRespSwitchList)
    TFDirector:addProto(s2c.ACTIVITY_RESP_CHANGE_SWITCH, self, self.onRespChangeSwitch)

    local enterBackgroundFunc = function()
        EventMgr:dispatchEvent(EV_APP_ENTERBACKGROUND)
    end
    TFDirector:addMEGlobalListener("applicationDidEnterBackground", enterBackgroundFunc)

    local enterForegroundFunc = function()
        EventMgr:dispatchEvent(EV_APP_ENTERFOREGROUND)
    end
    TFDirector:addMEGlobalListener("applicationWillEnterForeground", enterForegroundFunc)

    self.antiAddication = 0;

    --防沉迷查询结果
    if HeitaoSdk then
        HeitaoSdk.setAntiAddicationQueryCallback(handler(self.doAntiAddicationQueryCallback,self))
    else
        setAntiAddicationQueryCallback(handler(self.doAntiAddicationQueryCallback,self));
    end

    --分享结果
    if HeitaoSdk then
        HeitaoSdk.setShareCallback(handler(self.shareCallback,self));
    else
        setShareCallback(handler(self.shareCallback,self));
    end

    -- dataMgr
    self.dataMgr_ = {}

    for k, v in ipairs(loadInfo.dataMgr) do
        self.dataMgr_[k] = require(v.fileName)
    end

    --单次登陆保存状态
    self.onLoginStatusFlag = {}
    --自己邀请码
    self.selfInviteCode = ""

    self.sdkAccountStatus = "0"
    self.sdkAccountTime = ServerDataMgr:getServerTime()

    --服务器保存的开关列表
    self.switchList = {}
end

function MainPlayer:getServerTimeBeforeLoginFuc()
    HttpHelper:get(URL_LOGIN_QUERYDATE,function(data)
        data = json.decode(data)
        if data then
            self.localtime = os.time();
            self.serverTime = data.datetime;
            self.serverDiff = data.datagmtdelta;
        end
    end)
end

function MainPlayer:getServerDateBeforeLogin()
    local function getTimezone()
        local now = os.time()
        return os.difftime(now, os.time(os.date("!*t", now)))
    end
    self.currentTime = os.time()
    if self.serverDiff and self.serverTime then
        local timeZoneDiff = self.serverDiff - getTimezone();
        self.currentTime = self.serverTime + (os.time() - self.localtime) + timeZoneDiff;
    end
    return os.date("*t",self.currentTime);
end

function MainPlayer:shareCallback()
    dump("MainPlayer:shareCallback()")
    local msg = {
        210011,
    }
    TFDirector:send(c2s.TASK_REQ_TOUCH_TASK,msg);
end

function MainPlayer:resAntiAddictionInfo(event)
    dump(event.data.status);
    if event.data.status == 2 then
        return;
    end

    local maxHour = TabDataMgr:getData("DiscreteData", 20003).data["hours"];

    if event.data.status == 1 then
        local okhandle = function()
                if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
                    HeitaoSdk.loginOut();
                    return
                end
                CommonManager:closeConnection2();
        end

        local tips = TextDataMgr:getText(1550007,event.data.time)

        if event.data.time < maxHour then
            tips = TextDataMgr:getText(1550002,event.data.time);
            okhandle = nil;
        end

        showMessageBox(tips,EC_MessageBoxType.ok,okhandle);
    end

    if event.data.status == 0 then
        --合理游戏时间
        local tips = TextDataMgr:getText(1550002,event.data.time)
        --未认证游戏时间到
        if event.data.time >= maxHour then
            tips = TextDataMgr:getText(1550007,event.data.time)
        end

        local okhandle = function()

                if event.data.time >= maxHour then
                    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
                        HeitaoSdk.loginOut();
                        return
                    end
                    CommonManager:closeConnection2();
                    return;
                end

                AlertManager:close();

                if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
                    doAntiAddicationQuery()
                    return;
                end

                if HeitaoSdk then
                    HeitaoSdk.doAntiAddicationQuery();
                end               
        end

        local cancelhandle = function()
                if event.data.time < maxHour then
                    AlertManager:close();
                    return;
                end

                if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
                    HeitaoSdk.loginOut();
                    return
                end
                CommonManager:closeConnection2();
        end

        showMessageBox(tips,EC_MessageBoxType.okAndCancel,okhandle,cancelhandle);
    end
end

function MainPlayer:resDoAntiAddiction(event)
    dump(event.data)
end

function MainPlayer:doAntiAddicationQueryCallback(result)
    -- if result == 2 or result == 1 then
    --     CommonManager:loginServer();
    -- else

    -- end
    self.antiAddication = tonumber(result);
    dump(self.antiAddication)
    local currentScene = Public:currentScene();
    if currentScene.__cname == "LoginScene" then
        Utils:sendHttpLog("server_connect_M")
        CommonManager:loginServer();
    else
        local msg = {
            self.antiAddication,
        }
        TFDirector:send(c2s.PLAYER_REQ_CHANGE_ANTI_ADDICTION, msg)
    end

    EventMgr:dispatchEvent(EV_PLAYER_INFO_CHANGE)
end

function MainPlayer:getAntiAddcationStatus()
    return self.antiAddication;
end

function MainPlayer:loadLocalFile()
    -- 登錄前獲取時間
    self:getServerTimeBeforeLoginFuc();

    self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")

    --移除playmore搜索路径
    local sdPath = TFDeviceInfo.getSDPath()
    if sdPath and #sdPath >1 then   
        local sPackName = TFDeviceInfo.getPackageName()
        local playmorePath = sdPath .."playmore/" .. sPackName .. "/TFDebug/" 
        print_("playmorePath:"..tostring(playmorePath))
        if not RELEASE_TEST then
            CCFileUtils:sharedFileUtils():removeSearchPath(playmorePath)
        end
    end

    local function _loadLocalFile(curIndex)
        local MPRequireFile = loadInfo.managerFile
        local MPFunctions = loadInfo.managers
        local MPFuncId = 1
        local bar_load      = nil
        local txt_update    = nil
        local currLoad      = curIndex
        MPSize = #MPFunctions
        print("MPSize == "..MPSize)
        TFDirector:addTimer(10, MPSize,
            function ()
                if (bar_load) then
                    bar_load:setPercent(100)
                end
                if (txt_update) then
                    txt_update:setText(self.strCfg[800060].text)
                end
                _G["MainPlayer"] = MainPlayer:new()

                --TFDirector:addTimer(0,1,function()
                TFDirector:dispatchGlobalEventWith("MainPlayer.LoadOver", {})
                -- end)
            end,
            function()
                --TFLuaTime:begin()
                local moduleName = MPFunctions[MPFuncId]
                local filename = MPRequireFile[MPFuncId]
                if #moduleName > 0 then
                    _G[moduleName] = require(filename)
                else
                    require(filename)
                end
                MPFuncId = MPFuncId + 1
                --print("functionid-------"..functionId)
                --TFLuaTime:endToLua(name)


                if (txt_update == nil or bar_load == nil) then
                    local currentScene = TFDirector:currentScene()
                    local childrenArr = currentScene:getChildren()
                    for i=0,childrenArr:count()-1 do
                        local child = childrenArr:objectAtIndex(i)
                        local updateLayer = child:getChildByName("UpdateLayer_new")
                        if (updateLayer) then
                            local ui = updateLayer:getChildByName("ui")
                            if (ui) then
                                bar_load    = ui:getChildByName("bar_load")
                                txt_update  = ui:getChildByName("txt_update")
                            end
                        end
                    end
                end
                local maxSize       =  MPSize + curIndex

                if (bar_load) then
                    if (currLoad == 0) then
                        currLoad        = math.ceil(bar_load:getPercent() / 100 * maxSize) + 1
                        currLoad        = currLoad + 1
                    end
                    currLoad = currLoad or 0
                    currLoad = currLoad + 1
                    bar_load:setPercent((currLoad / maxSize) * 100)
                end

                if (txt_update) then
                    if (bar_load:getPercent() >= 100) then
                        txt_update:setText(self.strCfg[800060].text)
                    else
                        txt_update:setText(self.strCfg[800061].text)
                    end
                end
            end
            )
    end

    FileCheckMgr = require("lua.dataMgr.MerryChristmas")
    FileCheckMgr:start(_loadLocalFile);

    FileLoadMgr = require("lua.dataMgr.FileLoadMgr")
end

function MainPlayer:enterGame()
    self.isEnterGame = true

    --self:startHeartBeat()

    for k, v in pairs(self.dataMgr_) do
        if type(v.onEnterMain) == "function" then
            v:onEnterMain()
        end
    end

    if HeitaoSdk then
        HeitaoSdk.enterGame();
    end
    MedalDataMgr:sendReqActivateMedals()
    GuideDataMgr:checkBattleGuideEnd()
end

function MainPlayer:initPlayerInfo(info)
  self.playerInfo           = info
  self:updateShortcut()
end

function MainPlayer:getPlayerInfo()
    return self.playerInfo
end

function MainPlayer:updateShortcut()
    if self.playername and self.playername ~= self.playerInfo.name and HeitaoSdk then
        HeitaoSdk.roleNameChanged(self.playerInfo.name);
    end
    self.playername           = self.playerInfo.name or self.playername
    self.exp                  = self.playerInfo.exp  or self.exp
    self.lvl                  = self.playerInfo.lvl  or self.lvl
    self.playerId             = self.playerInfo.pid or self.playerId
    self.vip_exp              = self.playerInfo.vip_exp or self.vip_exp
    self.vip_lvl              = self.playerInfo.vip_lvl or self.vip_lvl
    self.dungeon_progress     = self.playerInfo.dungeon_progress or self.dungeon_progress
    self.declaration          = self.playerInfo.remark or self.declaration --玩家宣言
    self.as                   = self.playerInfo.as or self.as --所在社团
    self.assistId             = self.playerInfo.helpFightHeroCid or self.assistId --助战精灵Cid
    self.friends              = self.playerInfo.friends or self.friends --好友
    self.isNewRole            = self.playerInfo.isFirstLogin or self.isNewRole
    self.playerAttr           = self.playerInfo.attr or self.playerAttr
    self.element              = self.playerInfo.element or self.element
    self.createTime           = self.playerInfo.createTime or self.createTime       --建号时间

    print("建号时间：", self.createTime)
    if self.playerInfo.clientDiscreteData and self.playerInfo.clientDiscreteData ~= "" then
        self.clientDiscreteData = json.decode(self.playerInfo.clientDiscreteData);
    end

    self:updateStringByServer()

    EventMgr:dispatchEvent(EV_UPDATE_PLAYERINFO)
    initItemCoolDownTimes(self.playerInfo.recoverTimeList)
end

function MainPlayer:updateStringByServer()
    if not self.clientDiscreteData then return end

    local warnTime = self.clientDiscreteData.warnTime
    if warnTime then
        self.warnTimeKeep = warnTime
    end
    self:startWarnTimer()


    local clientString = self.clientDiscreteData.clientString
    for k, v in pairs(clientString or {}) do
        TabDataMgr:updateString(k, v)
    end
end

function MainPlayer:startWarnTimer()
    if not self.warnTimeKeep then  return  end
    if  self.warnTimer == nil then
        self.warnTimer = TFDirector:addTimer(1000, -1, nil,
        function()
            if self.warnTimeKeep then
                self.warnTimeKeep = self.warnTimeKeep - 1
                if self.warnTimeKeep > 0 then
                    if self.warnTipFlag then
                        self.limitMinTime = 300
                        local _data = Utils:getKVP(20003, "antiwarn")
                        if _data then
                            self.limitMinTime = _data[#_data] * 60 
                        end
                        if self.warnTimeKeep <= self.limitMinTime then
                            Utils:showAnitAddictionLayer()
                        end
                    else
                        Utils:showAnitAddictionLayer()
                    end
                else
                    self:stopWarnTimer()
                    Utils:closeAnitAddictionLayer()
                end
            end
        end)
    end
end

function MainPlayer:setWarnTipFlag(flag)
    self.warnTipFlag = flag
end

function MainPlayer:stopWarnTimer()
    self:setWarnTipFlag(false)
    if self.warnTimer then
        TFDirector:removeTimer(self.warnTimer)
        self.warnTimer = nil
    end
end



function MainPlayer:getFreeTimesUse(eType)
    for k,v in pairs(self.playerAttr) do
        if v.attrKey == eType then
            return v.attrVal;
        end
    end

    return 0;
end

function MainPlayer:getGuideStep()
    return self.clientDiscreteData
end

function MainPlayer:getIsNewRoleFlag()
    if self.isNewRole then
        return 1;
    else
        return 0;
    end
end

function MainPlayer:onPlayerInfo(event)
    self.queryPlayerInfo = event.data
    local playerInfo = event.data.playerInfo
    -- local heros = event.data.heros
    -- for i,v in ipairs(heros) do
    --     if v.helpFight == true then
    --         playerInfo.helpFightId = v.cid
    --     end
    -- end
    print("send updatePlayer")
    EventMgr:dispatchEvent(EV_RECV_PLAYERINFO,playerInfo)
end

function MainPlayer:getQueryPlayerInfo()
    return self.queryPlayerInfo
end

function MainPlayer:onRecvPlayerInfo(event)
    local data = event.data
    if not data then return end
    local oldPlayerInfo = clone(self.playerInfo)
    for k, v in pairs(data) do
        self.playerInfo[k] = data[k]
    end

    self:updateShortcut()
    for k, v in pairs(self.playerInfo) do
        if oldPlayerInfo[k] ~= v then
            EventMgr:dispatchEvent(EV_PLAYINFO_CHANGE, k, oldPlayerInfo[k], v)
            if k == "lvl" then
                if not GuideDataMgr:isInNewGuide() then
                    local view = requireNew("lua.logic.common.LevelUpView"):new(oldPlayerInfo[k], v)
                    if self:needToDelayShowUpView() then
                        AlertManager:addStashView(view, "lua.logic.common.LevelUpView")
                    else
                        AlertManager:addLayer(view)
                        AlertManager:show()
                    end
                end

                if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 and HeitaoSdk then
                    HeitaoSdk.GameLevelChanged(v)
                end
            end
        end
    end
    FunctionDataMgr:updateOpenFuncList()
end

function MainPlayer:onRecvRefreshTime(event)
    local data = event.data
    dump(data)
    if not data then return end

    if data.recoverTimeList then
        self.playerInfo.recoverTimeList = data.recoverTimeList
        initItemCoolDownTimes(self.playerInfo.recoverTimeList)
    end
end

--获取对应的回复时间
function MainPlayer:getRecoverTime(index)
    if not self.playerInfo or not self.playerInfo.recoverTimeList then
        return 0
    end

    local recoverTimeList = self.playerInfo.recoverTimeList or {}
    if index > #recoverTimeList then
        return 0
    else
        return recoverTimeList[index]
    end
end

function MainPlayer:onReportPlayer(event)
    local data = event.data
    if not data then return end

    Utils:showTips(100000082)
end

function MainPlayer:needToDelayShowUpView()
    local currentScene = Public:currentScene()
    if not currentScene then
        return false
    end
    if currentScene.__cname == "BattleScene" then
        return true
    end
    local topName = nil
    if currentScene:getTopLayer() then
        topName = currentScene:getTopLayer().__cname
    end
    if topName and (topName == "DatingCompleteView" or topName == "DatingScriptView" or topName == "DatingChangeBgView") then
        return true
    end
    return false
end

function MainPlayer:getDeclaration()
    return self.declaration
end

function MainPlayer:modifyDecHandle(event)
    if event.data then
        EventMgr:dispatchEvent(EV_MODIFY_DEC)
        EventMgr:dispatchEvent(EV_CHANGE_NAME_OK)
    end
end

function MainPlayer:reportPlayer(pid,_type)
    TFDirector:send(c2s.PLAYER_REQ_REPORT_AD, {pid,_type})
end

function MainPlayer:setDeclaration(dec)
    if Utils:isStringContainSpecialChars(dec) ~= nil then
        return false
    end
    local msg = {self.playername,dec}
    TFDirector:send(c2s.PLAYER_SET_PLAYER_INFO, msg)
    return true
end

function MainPlayer:setPlayerName(playerName)
    if Utils:isStringContainSpecialChars(playerName) ~= nil then
        return false
    end
    local msg = {playerName,self.declaration}
    TFDirector:send(c2s.PLAYER_SET_PLAYER_INFO, msg)
    return true
end

function MainPlayer:setAssist(heroId)
    self.assistId = heroId
    local sid = HeroDataMgr:getHeroSid(heroId)
    local msg = {tostring(sid)}
    TFDirector:send(c2s.PLAYER_CHANGE_HELP_FIGHT_HERO, msg)
end

function MainPlayer:sendReqInvestorScoreInfo()
   TFDirector:send(c2s.PLAYER_REQ_INVESTOR_SCORE_INFO, {}) 
end

function MainPlayer:onRecvInvestorScoreInfo(event)
    local data = event.data
    print("投资人积分返回：", data)
    self.scoreInfo = data
   
end

function MainPlayer:onRecvRedPointStatusByServer(event)
    -- body
    local data = event.data
    if not data then return end
    self.serverRedPointStatus = self.serverRedPointStatus or {}
    self.serverRedPointStatus[data.id] = data.isShow
    EventMgr:dispatchEvent(EV_RED_POINT_UPDATE_BY_SERVER)
end

function MainPlayer:getRedPointStatusByServer( redFunctionId )
    -- body
    self.serverRedPointStatus = self.serverRedPointStatus or {}
    return self.serverRedPointStatus[redFunctionId]
end

--登录请求开关列表
function MainPlayer:sendReqSwitchList()
    TFDirector:send(c2s.ACTIVITY_REQ_SWITCH_LIST, {}) 
end

--请求改变的开关
function MainPlayer:sendReqChangeSwitch(switch)
    TFDirector:send(c2s.ACTIVITY_REQ_CHANGE_SWITCH, {switch}) 
end

function MainPlayer:onRespSwitchList(event)
    local data = event.data
    if not data then return end

    for k, v in ipairs(data.switch or {}) do
        self.switchList[v.type] = v.value
    end
end

function MainPlayer:onRespChangeSwitch(event)
    local data = event.data
    if not data then return end

    for k, v in ipairs(data.switch or {}) do
        self.switchList[v.type] = v.value
        EventMgr:dispatchEvent(EV_PLAYER_SWITCH_UPDATE)
    end
end

function MainPlayer:getSwitchByType(type)
    return self.switchList[type] or 0
end

function MainPlayer:checkScoreInfo()
    --TODO CLOSE
    -- if self.scoreInfo and not self.scoreInfo.asked then
    --     self.scoreInfo.asked = true
    --    Utils:openView("activity.Activity_touzhirenTip",self.scoreInfo)
    -- end
end

function MainPlayer:getAssistId()
    return self.assistId
end

function MainPlayer:getFriends()
    return self.friends
end

function MainPlayer:isFriends(PlayerId)
    if self.friends == nil then
        return false
    end
    for i,v in ipairs(self.friends) do
        if playerId == v then
            return true
        end
    end
    return false
end

function MainPlayer:sendAddFriends(playerId)
    -- TFDirector:send(c2s.ADD_FRIENDS, playerId)
end

function MainPlayer:sendDeleteFriends(friendId)
    -- TFDirector:send(c2s.DELETE_FRIENDS, friendId)
end
function MainPlayer:sendPlayerId(playerId)
    local msg = {playerId}
    print("sendPlayerId msg")
    print(msg)
    TFDirector:send(c2s.PLAYER_REQ_TARGET_PLAYER_INFO,msg)
end

function MainPlayer:onAddFriends(event)
    EventMgr:dispatchEvent(EV_ADD_FRIENDS)
end

function MainPlayer:onDeleteFriends(event)
    EventMgr:dispatchEvent(EV_DELETE_FRIENDS)
end

function MainPlayer:assistHandle(event)
    if event.data then
        EventMgr:dispatchEvent(EV_CHANGE_ASSIST)
    end
end

function MainPlayer:getAs()
    return self.as
end

function MainPlayer:exchangeGiftHandle(event)
    if event.data then
        EventMgr:dispatchEvent(EV_EXCHANGE_GIFT_CODE,event.data.rewards)
    end
end

function MainPlayer:sendExchangeGift(redeemCode)
    local msg = {redeemCode}
    TFDirector:send(c2s.LOGIN_GIFT_CODE, msg)
end

function MainPlayer:getDungeonProgress()
  return self.dungeon_progress
end

function MainPlayer:getExpProgress()
    if self.lvl >= self:getMaxPlayerLevel() then
        return 0;
    end
    local max = TabDataMgr:getData("LevelUp",self.lvl).playerExp;
    return self.exp / max * 100;
end

function MainPlayer:getLastLvAndExpByAddExp(addExp)
    if self.exp >= addExp then
        return self.lvl, self.exp - addExp
    else
        local function getFrontLvlAndExp(subExp, frontLvl)
            local max = TabDataMgr:getData("LevelUp",frontLvl).playerExp
            if subExp > max then
                if frontLvl == 1 then
                    return frontLvl, 0
                end
                return getFrontLvlAndExp(subExp - max, frontLvl - 1)
            end
            return frontLvl, max - subExp
        end
        return getFrontLvlAndExp(addExp - self.exp, self.lvl - 1)
    end
end

function MainPlayer:getCreateTime()
    if self.createTime then
        return self.createTime
    else
        return 0
    end
end

function MainPlayer:getPlayerName()
  return self.playername
end

function MainPlayer:getPlayerLv()
  return self.lvl
end

function MainPlayer:getPlayerExp()
    return self.exp
end

function MainPlayer:getPlayerId()
    return self.playerId
end

function MainPlayer:getNowtime()
    self.timeDifference = self.timeDifference or 0
    return os.time() + self.timeDifference
end

function MainPlayer:startHeartBeat()
    -- print("------------------开启心跳包发送")
    if self.sendHeartBeatTime == nil  and self.recvHeartBeatTime == nil then
        self.sendHeartBeatTime = MainPlayer:getNowtime()
        self.recvHeartBeatTime = MainPlayer:getNowtime()
    end

    if  self.HeartBeatTimer == nil then

        self.HeartBeatTimer = TFDirector:addTimer(1000 * 20, -1, nil,
        function()
            print("------------------心跳包发送。。。。。")
            TFDirector:send(c2s.LOGIN_PING, {})
            self.sendHeartBeatTime = MainPlayer:getNowtime()
            self.recvHeartBeatTime = -1;
        end)
    end

    if  self.CheckHeartBeatTimer == nil then
        self.CheckHeartBeatTimer = TFDirector:addTimer(0, -1, nil,
         function()
            if not self.sendHeartBeatTime or not self.recvHeartBeatTime then
                TFDirector:removeTimer(self.CheckHeartBeatTimer)
                self.CheckHeartBeatTimer = nil
                return;
            end

            if self.recvHeartBeatTime == -1 then
                local timeGap     = MainPlayer:getNowtime() - self.sendHeartBeatTime
                if timeGap >= 20 then
                    -- 超过20s没有收到心跳消息，按断线处理
                    print("超过20s没有收到心跳消息，按断线处理")
                    CommonManager:heartBeatcloseConnection()
                    CommonManager:loginServer(true)
                    self.recvHeartBeatTime = MainPlayer:getNowtime();
                end
            else
                
            end
        end)
    end

end

function MainPlayer:stopHeartBeat()
    -- print("------------------关闭心跳包发送轮询")
    if self.HeartBeatTimer then
        TFDirector:removeTimer(self.HeartBeatTimer)
        self.HeartBeatTimer = nil
    end

    if self.CheckHeartBeatTimer then
        -- print("------------------关闭心跳包检查轮询")
        TFDirector:removeTimer(self.CheckHeartBeatTimer)
        self.CheckHeartBeatTimer = nil
    end

    self.sendHeartBeatTime = nil
    self.recvHeartBeatTime = nil
end

function MainPlayer:recvHeartBeatEvent(event)
    print("------------------收到心跳包")
    self.recvHeartBeatTime = MainPlayer:getNowtime()
end

function MainPlayer:onLogin(event)
    local timer = nil;
    local index = 0;
    local isOver = false;
    dump(table.count(self.dataMgr_));
    local function step(dt)
        if not self.loadDataTimer then
            return
        end
        index = index + 1;
        if index > table.count(self.dataMgr_) then
            isOver = NetWork:checkLoginMsgOver()
        end

        if isOver or not CommonManager:getConnectionStatus() then
            NetWork:reset()
            TFDirector:removeTimer(timer);
            self.loadDataTimer = nil
        end

        local value = self.dataMgr_[index];
        if value and CommonManager:getConnectionStatus() then
            if type(value.onLogin) == "function" then
                local waitMsg = value:onLogin() or {}
                if type(waitMsg) == "number" then
                    waitMsg = {waitMsg}
                elseif type(waitMsg) ~= "table" then
                    waitMsg = {}
                end
                table.walk(waitMsg, function(msgId)
                               NetWork:waitLoginS2CMsg(msgId)
                end)
            end
        end
    end
    self:sendReqInvestorScoreInfo()
    self:sendReqSwitchList()
    timer = TFDirector:addTimer(0, -1, nil,step);
    self.loadDataTimer = timer
end

function MainPlayer:stopLoadTimer()
    if self.loadDataTimer then
        TFDirector:removeTimer(self.loadDataTimer)
        self.loadDataTimer = nil
    end
end

function MainPlayer:onLoginOut()
    if not self.dataMgr_ then
        return;
    end

    Utils:closeAnitAddictionLayer()

    for i, v in ipairs(self.dataMgr_) do
        if type(v.onLoginOut) == "function" then
            v:reset();
            v:onLoginOut()
        end
    end

    self.onLoginStatusFlag = {}
end

--登陆游侠前的数据重置
function MainPlayer:resteBeforeLogin()
    if not self.dataMgr_ then
        return
    end

    for i, v in ipairs(self.dataMgr_) do
        if type(v.onLoginOut) == "function" then
            v:reset()
            v:onLoginOut()
        end
    end
end

function MainPlayer:reset()
    self.isEnterGame = false;
    self.isNewRole = nil
    self.phoneNum = nil;
    self.antiAddication = 0;
    self.switchList = {}
    self.playername = nil
    self:stopHeartBeat()
    self:stopWarnTimer()
    self:onLoginOut();

    self.sdkAccountStatus = "0"
    self.sdkAccountTime = ServerDataMgr:getServerTime()
end

function MainPlayer:getIsEnterGame()
    return self.isEnterGame;
end

function MainPlayer:getIsTouchWJ()
    local ret = CCUserDefault:sharedUserDefault():getBoolForKey(self:getPlayerId().."isTouchWJ");
    return ret;
end

function MainPlayer:checkVersion()

    if CC_PLATFORM_WIN32 == CC_TARGET_PLATFORM then
        return;
    end

    if self.CheckingUpdates then
        return
    end

    self.CheckingUpdates = true;
    dump("-------------------------------------\n".."------MainPlayer:checkVersion()------\n".."-------------------------------------")
    local function checkNewVersionCallBack()
        self.CheckingUpdates = false;
        local version       =  TFClientUpdate:getCurVersion()
        local LatestVersion =  TFClientUpdate:getLatestVersion()
        local Content       =  TFClientUpdate:GetUpdateContent(TFLanguageMgr:getUsingLanguage())
        local totalSize     =  TFClientUpdate:GetTotalDownloadFileSize()

        print("===========find new version===========")
        print("version          = ", version)
        print("LatestVersion    = ", LatestVersion)
        print("Content          = ", Content)
        print("totalSize        = ", totalSize)
        print("=============== end ==================")
        local nTotalSize  = totalSize
        nTotalSize = nTotalSize/1000000
        local desc = "";
        if nTotalSize >= 0.1 then
            desc = string.format(" %0.1fM", nTotalSize);
        else
            desc = string.format(" %0.1fK", nTotalSize * 1000);
        end
        dump(desc)
        dump(string.format("检测到有新的更新内容，共%s",desc));

        -- showMessageBox( "数据已更新，请重启游戏!" , EC_MessageBoxType.ok,function()
        showMessageBox(self.strCfg[800062].text , EC_MessageBoxType.ok,function()
            TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})


            if CC_PLATFORM_IOS == CC_TARGET_PLATFORM then
                TFDirector:send(1539,{})
            end

            restartLuaEngine("")
        end , cancelhandle)
    end

    local function StatusUpdateHandle(ret)
        self.CheckingUpdates    = false;
        if ret == 0 then
            local version       =  TFClientUpdate:getCurVersion()
            local LatestVersion =  TFClientUpdate:getLatestVersion()
            print("version          = ", version)
            print("LatestVersion    = ", LatestVersion)
            print("---------------检查更新完成")
            return
        elseif ret < 0 then
            print("---------------更新出错 ret = "..ret)
            UPDATE_RETRY_TIME = (UPDATE_RETRY_TIME or 0) + 1

            if UPDATE_RETRY_TIME % 2 == 0 then
                CDN_INDEX = CDN_INDEX + 1;
                if CDN_INDEX > #URL_CDN_VERSION then
                    CDN_INDEX = 1
                end
            end
            self:checkVersion();
        end
    end
    if CDN_INDEX == 0 then
        CDN_INDEX = 1;
    end
    dump({CDN_INDEX,URL_CDN_VERSION[CDN_INDEX],URL_CDN_FILE[CDN_INDEX]});
    TFClientUpdate:CheckUpdate(URL_CDN_VERSION[CDN_INDEX], URL_CDN_FILE[CDN_INDEX], checkNewVersionCallBack, StatusUpdateHandle)
end

function MainPlayer:setOneLoginStatus(statusType, status)
    statusType = statusType or EC_OneLoginStatusType.ReConfirm_MailDelete
    status = tonumber(status) or 0
    self.onLoginStatusFlag[statusType] = status
end

function MainPlayer:getOneLoginStatus(statusType)
    statusType = statusType or EC_OneLoginStatusType.ReConfirm_MailDelete
    local flag = self.onLoginStatusFlag[statusType] or 0
    return (flag == 1)
end

function MainPlayer:getMaxPlayerLevel()
    return Utils:getKVP(9002, "pmaxlvl")
end

--手机绑定
function MainPlayer:setPhoneNum(phoneNum)
    self.phoneNum = phoneNum;
    EventMgr:dispatchEvent(EV_PLAYER_INFO_CHANGE)
end

function MainPlayer:getPhoneNum()
    return self.phoneNum;
end

function MainPlayer:setSelfInviteCode(code)
    self.selfInviteCode = code

    if string.len(self.selfInviteCode) <= 1 then
        return;
    end

    local t = {
        code = self.selfInviteCode
    }

    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
        HeitaoSdk.luaToClient("InvitationCode",json.encode(t))
        end
end

--设置分享状态 （1：启用，0：禁用）
function MainPlayer:setShareSdkState(state)

    local t = {
        enabled = state
    }

    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
        HeitaoSdk.luaToClient("setScreenshotShareEnabled",json.encode(t))
    end

end

function MainPlayer:getTouzirenLevel()
    -- body
    local investorcfg = TabDataMgr:getData("Investor",1)
    local investorLevelCfg = TabDataMgr:getData("InvestorLevel")

    local curCount = GoodsDataMgr:getItemCount(investorcfg.itemId)
    local level = 0
    local maxCount = 0

    for k,v in ipairs(investorLevelCfg) do
        if curCount*1000 < v.experiences then
            maxCount = v.experiences
            break;
        end

        if k == #investorLevelCfg then
            maxCount = v.experiences
        end
        level = v.lv
    end

    return level, curCount, math.floor(maxCount/1000), investorLevelCfg[#investorLevelCfg].lv
end

function MainPlayer:checkTzrTypeInfo()
    local investorcfg = TabDataMgr:getData("Investor",1)
    local typeId = investorcfg.battenId
    local info = FunctionDataMgr:getMainFuncInfo(typeId);
    if info and info.openWelfare then
        FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(info.type)
    else
        return
    end
    local playerid                      = self:getPlayerId()

    local groupId = 0
    local pfid = 0
    if HeitaoSdk then
        groupId = math.floor(HeitaoSdk.getplatformId() / 10000)
        pfid = HeitaoSdk.getplatformId() % 10000
    end
    local createTime = self:getCreateTime()
    local playerLv = self:getPlayerLv()
    local point = GoodsDataMgr:getItemCount(investorcfg.itemId)

    local timestamp = ServerDataMgr:getServerTime()
    local key = "8ec346ff4c80635f667d1592ae"
    local token = md5.sumhexa(groupId..pfid..playerid..point..timestamp..key)
    local attach = "&sid=" .. groupId .. "&role_id=" .. playerid .. "&person_points=" .. point
    attach = attach .. "&create_time=" .. createTime .. "&timestamp=" .. timestamp .. "&sign=" .. token

    Utils:showWebView(info.welfareUrl, nil, nil, attach) 
end

return MainPlayer
