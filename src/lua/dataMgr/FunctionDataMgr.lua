local BaseDataMgr = import(".BaseDataMgr")
local FunctionDataMgr = class("FunctionDataMgr", BaseDataMgr)

function FunctionDataMgr:initFuncList()
    self.funcList_ = {
        [1] = self.jPay,    -- 充值
        [6] = self.jActivity,    -- 活动
        [19] = self.jStore,    -- 商店
        [20] = self.jSummonMain,    -- 召唤·抽卡选择界面
        [23] = self.jTask,    -- 任务
        [25] = self.jOnlineStore,    -- 联机商店
        [26] = self.jPlotFuben,    -- 剧情副本
        [27] = self.jDailyFuben,    -- 日常副本
        [28] = self.jFriend,    -- 好友
        [29] = self.jJieJing,    -- 精灵结晶
        [30] = self.jHero,    -- 精灵属性
        [31] = self.jAngel,    -- 天使
        [32] = self.jEquipment,    -- 灵装
        [33] = self.jCity,    -- 城市
        [34] = self.jSummon,    -- 召唤
        [35] = self.jCompose,    -- 合成
        [37] = self.jFubenReady,    -- 副本准备界面
        [38] = self.jSignInTask,    -- 7日签到
        [39] = self.jActivityFuben,    -- 活动副本
        [40] = self.jEndlessStore,    -- 无尽商店
        [41] = self.jKabalaStore,    -- 卡巴拉商店
        [42] = self.jChat,    -- 聊天
        [43] = self.jPokedex,    -- 图鉴
        [44] = self.jGiftStore,    -- 礼物商店
        [45] = self.jBag,    -- 背包
        [46] = self.jEmail,    -- 邮件
        [47] = self.jFragmentStore,    -- 碎片商店
        [48] = self.jMedal,    -- 勋章管
        [60] = self.jPayGift,    -- 充值·礼包
        [61] = self.jClothStore,    -- 服装商店
        [64] = self.jSupportActivity,    -- 应援活动
        [66] = self.jPayWelfare,    -- 充值·福利
        [67] = self.jHolidayFuben,    -- 节日活动副本
        [68] = self.jHalloweenStore,    -- 节日活动副本
        [73] = self.jTheaterFuben,    -- 万由里副本
        [75] = self.jActivityFubenEndless,    -- 活动副本:无尽
        [76] = self.jActivityFubenTeam,    -- 活动副本:组队
        [77] = self.jActivityFubenSprite,    -- 活动副本:精灵试炼
        [78] = self.jActivityFubenKabala,    -- 活动副本:卡巴拉
        [80] = self.jNewEquipMent,    -- 精灵装备羁绊
        [81] = self.jTheaterLevel,    -- 万由里副本(指定关卡id)
        [82] = self.jTheaterHardLevel,    -- 万由里副本困难(指定关卡id)
        [83] = self.jChristmasAgora,    -- 圣诞集会所
        [84] = self.jStartDating,    -- 开始约会
        [85] = self.jChristmasStore,    -- 圣诞商店
        [86] = self.jDatingPhone,    -- 圣诞商店
        [87] = self.jTheaterBossView,    -- 万由里雷霆圣堂
        [88] = self.jTheaterLevelView,    -- 万由里剧场
        [89] = self.jWelfare,    -- 福利
        [90] = self.jMonthCard,    -- 福利.月卡
        [92] = self.jUnionHall,        -- 社团大厅
        [93] = self.jUnionMember,      -- 社团成员
        [94] = self.jUnionBuilding,    -- 社团建筑研发
        [95] = self.jUnionSupply,      -- 社团补给
        [96] = self.jUnionStor,        -- 社团商店
        [97] = self.jUnionInvade,      -- 次元入侵
        [98] = self.jUnionHunt,        -- 追猎计划
        [99] = self.jUnionMatrix,        -- 特训矩阵
        [100] = self.jDlsStore,    -- 大凉山商店
        [101] = self.jUnion,        -- 社团
        [103] = self.jSpring,    -- 春季特训
        [106] = self.jUseItem,    -- 使用道具
        [107] = self.jStone,    -- 宝石
        [110] = self.jElfContract,    --精灵契约
        [111] = self.jSkyLadder,    --天梯
        [112] = self.jActivityFubenBigWorld,    -- 大世界
        [113] = self.jActivityFubenSimulationTrial,    --模拟试炼
        [114] = self.jActivityFubenSimulationTrial2,    --模拟试炼
        [121] = self.jPlayerInfo,    -- 玩家信息页面
        [125] = self.jHeroQiyue,    --精灵契约
        [126] = self.jPayMonthCard,    --充值·月卡
        [127] = self.jActivity2,    --充值·月卡
        [128] = self.jDispatch,    --指挥作战
        [140] = self.jLinkAgeMain,    --海王星联动
        [141] = self.jWarOrderBuy,    --战令许可购买
        [142] = self.jKsanFuben,      --狂三
        [143] = self.jKsanGift,       --狂三
        [144] = self.jGiftPacks,       --礼包合集
        [151] = self.jGMSkill,         --主角光环
        [999] = self.jSpecialFuben,    --特殊活动副本
        [199] = self.jAssistanceCode,
        [200] = self.jRechargeArray,
        [305] = self.jNewGuyGiftBag,    --萌新礼包弹窗
        [306] = self.jHundredLoginView  ---百日活动礼包
    }
    local tempFunc = {}
    for k, v in pairs(self.funcList_) do
        tempFunc[v] = k
    end
    table.merge(self.funcList_, tempFunc)

    self.accessType_ = {
        FUBEN_PLOT_PRECISE = 1,    -- 副本·剧情(指定关卡Id)
        FUBEN_DAILY_PRECISE = 2,    -- 副本·日常(指定关卡Id)
        STORE = 3,    -- 商店
        SUMMON = 4,    -- 召唤·抽卡
        SUMMON_COMPOSE = 5,    -- 召唤·合成
        CITY_WORK = 6,    -- 城建·打工
        FUBEN_PLOT = 7,    -- 副本·剧情
        FUBEN_DAILY = 8,    -- 副本·日常
        TASK_SIGNIN = 9,    -- 任务·签到
        FUBEN_ACTIVITY = 10,    -- 副本·活动
        TASK = 11,    -- 任务
        CITY_BUILD = 12,    -- 城建（指定建筑）
        THEATER = 16,    -- 万由里(指定关卡id)
        THEATER_HARD = 17,    -- 万由里困难(指定关卡id)
        THEATER_BOSS = 45,    -- 万由里雷霆圣堂
        ACTIVITY = 51,    -- 活动
        ACTIVITYBYID = 52,    -- 活动
        USEITEM = 54,    -- 使用道具
    }

    -- 记录开放的功能
    self.openFuncList_ = {}

    -- 记录未开发的功能
    self.notOpenFunction_ = {}

    -- 公告是否开启
    self.askSwitch_ = false

    -- 公告地址
    self.askUrl_ = ""

    -- 主界面功能按钮信息
    self.mainFuncInfo_ = {}
end

function FunctionDataMgr:init()
    TFDirector:addProto(s2c.LOGIN_RESP_FUNCTION_SWITCH, self, self.onRecvFunctionSwitch)
    TFDirector:addProto(s2c.PLAYER_RES_ASK_SWITCH, self, self.onRecvAskSwitch)
    TFDirector:addProto(s2c.PLAYER_RES_WELFARE_INFO, self, self.onRecvMainFuncInfo)
    TFDirector:addProto(s2c.PLAYER_RES_OPEN_WELFARE_INFO, self, self.onRecvUpdateMainFuncInfo)
    TFDirector:addProto(s2c.ITEM_RESP_TIME_OUT_ITEM_CONVERT, self, self.onRecyclingItems)

    self:initFuncList()
    self.accessMap_ = TabDataMgr:getData("Access")
    self.functionMap_ = TabDataMgr:getData("Function")
    self.fubenDropMap_ = TabDataMgr:getData("FubenDrop")
    self.switchs_ = {}
end

function FunctionDataMgr:reset()
    self.switchs_ = {}
    self.openFuncList_ = {}
    self.notOpenFunction_ = {}
end

function FunctionDataMgr:onLogin()
    TFDirector:send(c2s.LOGIN_REQ_FUNCTION_SWITCH, {})
    TFDirector:send(c2s.PLAYER_REQ_ASK_SWITCH, {})
    TFDirector:send(c2s.PLAYER_REQ_WELFARE_INFO, {})
    return {s2c.LOGIN_RESP_FUNCTION_SWITCH, s2c.PLAYER_RES_ASK_SWITCH, s2c.PLAYER_RES_WELFARE_INFO}
end

function FunctionDataMgr:onEnterMain()
    self:updateNotOpenFuncList()
end

function FunctionDataMgr:updateNotOpenFuncList()
    self.notOpenFunction_ = {}
    for k, v in pairs(self.functionMap_) do
        if v.serverId == 2 or v.serverId == 3 then
            if not self:isOpenByClient(v.id) and v.showIcon then
                table.insert(self.notOpenFunction_, v.id)
            end
        end
    end
    table.sort(self.notOpenFunction_, function(a, b)
                   local cfgA = self.functionMap_[a]
                   local cfgB = self.functionMap_[b]
                   return cfgA.openLevel < cfgB.openLevel
    end)
end

function FunctionDataMgr:updateOpenFuncList()
    self.notOpenFunction_ = self.notOpenFunction_ or {}
    for i, v in ipairs(self.notOpenFunction_) do
        if self:isOpenByClient(v) then
            table.insert(self.openFuncList_, v)
        end
    end
    self:updateNotOpenFuncList()
end

function FunctionDataMgr:getOpenFuncList()
    return self.openFuncList_
end

function FunctionDataMgr:__makeAccessItem(desc, open, jumpId, args)
    return {
        desc = desc,
        open = open,
        jumpId = jumpId,
        args = args,
    }
end

function FunctionDataMgr:enterByFuncId(id, ...)
    if self.funcList_[id] then
        self.funcList_[id](self, ...)
    else
        Utils:showTips(100000076, id)
    end
end

function FunctionDataMgr:getAccess(itemId)
    local rets = {}
    local itemCfg = GoodsDataMgr:getItemCfg(itemId) or {}
    local accessId = itemCfg.accessId or {}
    for i, v in ipairs(accessId) do
        local accessCfg = self.accessMap_[v]
        local accessType = accessCfg.accessType
        if accessType == self.accessType_.FUBEN_PLOT_PRECISE then
            if self.fubenDropMap_[itemId] then
                local drop = self.fubenDropMap_[itemId][EC_FBType.PLOT] or {}
                for _, levelId in ipairs(drop) do
                    local levelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)

                    local chapterName = FubenDataMgr:getChapterOrderName(levelGroupCfg.dungeonChapterId)
                    local diffName = TextDataMgr:getText(EC_FBDiffName[levelCfg.difficulty])
                    local levelName = FubenDataMgr:getLevelName(levelId)
                    local title = TextDataMgr:getText(accessCfg.name)
                    local info = TextDataMgr:getText(accessCfg.name2, chapterName, diffName, levelName)
                    local desc = TextDataMgr:getText(1420002, title, info)
                    local open = FubenDataMgr:checkPlotLevelEnabled(levelId)
                    local jumpId = accessCfg.jumpInterface
                    local args = {levelId}
                    local foo = self:__makeAccessItem(desc, open, jumpId, args)
                    table.insert(rets, foo)
                end
            end
        elseif accessType == self.accessType_.FUBEN_DAILY_PRECISE then
            if self.fubenDropMap_[itemId] then
                local drop = self.fubenDropMap_[itemId][EC_FBType.DAILY] or {}
                local levelGroupMap = {}
                for _, levelId in ipairs(drop) do
                    local levelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
                    if not levelGroupMap[levelCfg.levelGroupId] then
                        levelGroupMap[levelCfg.levelGroupId] = true
                        local levelGroupName = TextDataMgr:getText(levelGroupCfg.name)
                        local title = TextDataMgr:getText(accessCfg.name)
                        local desc = TextDataMgr:getText(1420002, title, levelGroupName)
                        local info = TextDataMgr:getText(levelCfg.name)
                        local open = FubenDataMgr:checkPlotLevelEnabled(levelId)
                        local jumpId = accessCfg.jumpInterface
                        local args = {levelId}
                        local foo = self:__makeAccessItem(desc, open, jumpId, args)
                        table.insert(rets, foo)
                    end
                end
            end
        elseif accessType == self.accessType_.THEATER then
            if self.fubenDropMap_[itemId] then
                local drop = self.fubenDropMap_[itemId][EC_FBType.THEATER] or {}
                for _, levelId in ipairs(drop) do
                    local theaterLevelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local levelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local theaterLevelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelId)
                    local chapterCfg = FubenDataMgr:getChapterCfg(theaterLevelCfg.chapter)
                    local extraChapterCid = FubenDataMgr:getTheaterExtraChapter(chapterCfg.id)
                    local levelName = FubenDataMgr:getLevelName(levelId)
                    local title = TextDataMgr:getText(accessCfg.name)
                    local desc = TextDataMgr:getText(1420002, title, levelName)
                    local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelId)
                    local locked = FubenDataMgr:checkTheaterLevelLocked(levelId)
                    local levelEnabeld = MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel
                    local open = enabled and not locked
                    local jumpId = accessCfg.jumpInterface
                    local args = {extraChapterCid,levelId}
                    local foo = self:__makeAccessItem(desc, open, jumpId, args)
                    table.insert(rets, foo)
                end
            end
        elseif accessType == self.accessType_.THEATER_HARD then
            if self.fubenDropMap_[itemId] then
                local drop = self.fubenDropMap_[itemId][EC_FBType.THEATER_HARD] or {}
                for _, levelId in ipairs(drop) do
                    local theaterLevelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local levelCfg = FubenDataMgr:getLevelCfg(levelId)
                    local theaterLevelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelId)
                    local chapterCfg = FubenDataMgr:getChapterCfg(theaterLevelCfg.chapter)


                    local chapter = FubenDataMgr:getTheaterChapter(accessCfg.parameter[1])
                    local enabled, condEnabled = FubenDataMgr:checkTheaterChapterEnabled(chapter[1])

                    local levelName = FubenDataMgr:getLevelName(levelId)
                    local title = TextDataMgr:getText(accessCfg.name)
                    local desc = TextDataMgr:getText(1420002, title, levelName)
                    local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelId)
                    local locked = FubenDataMgr:checkTheaterLevelLocked(levelId)
                    local open = enabled and not locked and condEnabled
                    local jumpId = accessCfg.jumpInterface
                    local args = {accessCfg.parameter[1],levelId}
                    local foo = self:__makeAccessItem(desc, open, jumpId, args)
                    table.insert(rets, foo)
                end
            end
        elseif accessType == self.accessType_.THEATER_BOSS then
            local chapter = FubenDataMgr:getChapter(EC_FBType.THEATER_HARD)
            local chapterCid = chapter[1]
            local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
            local levelEnable = MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel

            local title = TextDataMgr:getText(accessCfg.name)
            local info = TextDataMgr:getText(accessCfg.name2)
            local desc = TextDataMgr:getText(1420002, title, info)
            local jumpCid = accessCfg.jumpInterface
            local open = levelEnable
            local args = accessCfg.parameter
            local foo = self:__makeAccessItem(desc, open, jumpCid, args)
            table.insert(rets, foo)
         elseif accessType == self.accessType_.ACTIVITY then -- 途径是活动界面的 需要检测是否有对应类型活动
            local addAccess = true
            local parameter = {}
            if accessCfg.accessparam ~= "" then
                addAccess = false
                local typeList = string.split(accessCfg.accessparam,",")
                for k,v in pairs(typeList) do
                    local activityInfos = ActivityDataMgr2:getActivityInfoByType(tonumber(v))
                    if #activityInfos > 0 then
                        addAccess = true
                        parameter = {activityInfos[1]}
                        break;
                    end
                end
            else
                parameter = accessCfg.parameter
            end
            if addAccess then
                local title = TextDataMgr:getText(accessCfg.name)
                local info = TextDataMgr:getText(accessCfg.name2)
                local desc = TextDataMgr:getText(1420002, title, info)
                local jumpCid = accessCfg.jumpInterface
                local open = self:isOpenByClient(jumpCid)
                local args = parameter
                local foo = self:__makeAccessItem(desc, open, jumpCid, args)
                table.insert(rets, foo)
            end
        elseif accessType == self.accessType_.ACTIVITYBYID then -- 途径是活动界面的 需要检测是否有对应类型活动
            local addAccess = true
            local parameter = {}
            if accessCfg.parameter and #accessCfg.parameter > 0 then
                addAccess = false
                for k,v in pairs(accessCfg.parameter) do
                    local activityInfo = ActivityDataMgr2:getActivityInfo(v)
                    if activityInfo then
                        addAccess = true
                        parameter = {v}
                        break;
                    end
                end
            end

            if addAccess then
                local title = TextDataMgr:getText(accessCfg.name)
                local info = TextDataMgr:getText(accessCfg.name2)
                local desc = TextDataMgr:getText(1420002, title, info)
                local jumpCid = accessCfg.jumpInterface
                local open = self:isOpenByClient(jumpCid)
                local args = parameter
                local foo = self:__makeAccessItem(desc, open, jumpCid, args)
                table.insert(rets, foo)
            end
        elseif accessType == self.accessType_.USEITEM then
            local args = accessCfg.parameter
            local count = GoodsDataMgr:getItemCount(args[1])
            local itemCfg = GoodsDataMgr:getItemCfg(args[1])
            local itemName = TextDataMgr:getText(itemCfg.nameTextId)
            local title = TextDataMgr:getText(accessCfg.name)
            local info = TextDataMgr:getText(accessCfg.name2, itemName)
            local desc = TextDataMgr:getText(1420002, title, info)
            local jumpCid = accessCfg.jumpInterface
            local open = count > 0
            local foo = self:__makeAccessItem(desc, open, jumpCid, args)
            table.insert(rets, foo)
        else
            local title = TextDataMgr:getText(accessCfg.name)
            local info = TextDataMgr:getText(accessCfg.name2)
            local desc = TextDataMgr:getText(1420002, title, info)
            local jumpCid = accessCfg.jumpInterface
            local open = self:isOpenByClient(jumpCid)
            local args = accessCfg.parameter
            local foo = self:__makeAccessItem(desc, open, jumpCid, args)
            table.insert(rets, foo)
        end
    end
    return rets
end

function FunctionDataMgr:isOpenByClient(functionCid)
    local functionCfg = self.functionMap_[functionCid]
    if not functionCfg then
        Box("functionCid:"..tostring(functionCid).." 未配置")
        return true
    end
    local isOpen = true
    if functionCfg.openLevel > 0 then
        local foo 
        if functionCfg.levelType == 1 then --玩家等级
           foo = MainPlayer:getPlayerLv() >= functionCfg.openLevel
        elseif functionCfg.levelType == 2 then  --社团等级
            foo = LeagueDataMgr:getUnionLevel() >= functionCfg.openLevel
        else
            foo = MainPlayer:getPlayerLv() >= functionCfg.openLevel
        end
        isOpen = isOpen and foo
    end
    if functionCfg.openDun > 0 then
        local foo = FubenDataMgr:isPassPlotLevel(functionCfg.openDun)
        isOpen = isOpen and foo
    end
    return isOpen
end

function FunctionDataMgr:isOpenByServer(functionCid)
    local isOpen = true
    if self.switchs_[functionCid] then
        isOpen = self.switchs_[functionCid].open
    end
    return isOpen
end

function FunctionDataMgr:isOpen(functionCid)
    local clientIsOpen = self:isOpenByClient(functionCid)
    local serverIsOpen = self:isOpenByServer(functionCid)
    return clientIsOpen and serverIsOpen
end

function FunctionDataMgr:checkFuncOpen(functionCid)
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FunctionDataMgr:checkFuncOpen")
    if not functionCid then
        local info = debug.getinfo(2)
		dump(info)
        functionCid = self.funcList_[info.func]
    end
	print("functionCid=" .. functionCid)
    local functionCfg = self.functionMap_[functionCid]
    local clientIsOpen = self:isOpenByClient(functionCid)
    local serverIsOpen = self:isOpenByServer(functionCid)
    if clientIsOpen then
        if not serverIsOpen then
            Utils:showTips(1453004, TextDataMgr:getText(functionCfg.name))
        end
    else
        local param = functionCfg.unlockExplain
        local type_ = param[1]
        if type_ == 2 then
            local talkData = {param[2]}
            local sound = {param[3]}
            Utils:openView("common.FunctionTipsView", talkData, nil, sound)
        elseif type_ == 1 then
            if functionCfg.openLevel > 0 and functionCfg.openDun > 0 then
                local levelCfg = FubenDataMgr:getLevelCfg(functionCfg.openDun)
                local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
                local chapterName = FubenDataMgr:getChapterOrderName(levelGroupCfg.dungeonChapterId)
                local diffName = TextDataMgr:getText(EC_FBDiffName[levelCfg.difficulty])
                local levelName = FubenDataMgr:getLevelName(functionCfg.openDun)
                Utils:showTips(1453003,  functionCfg.openLevel, chapterName, diffName, levelName)
            else
                if functionCfg.openLevel > 0 then
                    Utils:showTips(1453001, functionCfg.openLevel)
                end
                if functionCfg.openDun > 0 then
                    local levelCfg = FubenDataMgr:getLevelCfg(functionCfg.openDun)
                    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
                    local chapterName = FubenDataMgr:getChapterOrderName(levelGroupCfg.dungeonChapterId)
                    local diffName = TextDataMgr:getText(EC_FBDiffName[levelCfg.difficulty])
                    local levelName = FubenDataMgr:getLevelName(functionCfg.openDun)
                    Utils:showTips(1453002, chapterName, diffName, levelName)
                end
            end
        else
            Utils:showTips(100000077)
        end

    end
    return clientIsOpen and serverIsOpen
end

function FunctionDataMgr:getFunctionCfg(functionCid)
    return self.functionMap_[functionCid]
end

function FunctionDataMgr:showOpenFunc()
    if #self.openFuncList_ > 0 then
        local view = requireNew("lua.logic.common.FunctionOpenView"):new(self.openFuncList_)
        AlertManager:addLayer(view)
        AlertManager:show()
        self.openFuncList_ = {}
    end
end

function FunctionDataMgr:getWenJuanInfo()
    return self.wenJuanInfo_
end

function FunctionDataMgr:getMainFuncInfo(type_)
    if type_ then
        return self.mainFuncInfo_[type_]
    end
    return self.mainFuncInfo_
end

---------------------------------------------------------------------

function FunctionDataMgr:send_PLAYER_REQ_OPEN_WELFARE_INFO(type_)
    TFDirector:send(c2s.PLAYER_REQ_OPEN_WELFARE_INFO, {type_})
end

function FunctionDataMgr:onRecvFunctionSwitch(event)
    local data = event.data
    if not data then return end
    for i, v in ipairs(data.switchs) do
        self.switchs_[v.switchType] = v
        EventMgr:dispatchEvent(EV_FUNC_STATE_CHANGE, v)
    end
end

function FunctionDataMgr:onRecvAskSwitch(event)
    local data = event.data
    if not data then return end
    self.wenJuanInfo_ = data
    EventMgr:dispatchEvent(EV_MAIN_WENJUAN_UPDATE)
end

function FunctionDataMgr:onRecvMainFuncInfo(event)
    local data = event.data
    if not data then return end
    if not data.buttonShowInfos then return end
    for i, v in ipairs(data.buttonShowInfos) do
        self.mainFuncInfo_[v.type] = v
    end
end

function FunctionDataMgr:onRecvUpdateMainFuncInfo(event)
    local data = event.data
    if not data then return end
    if not data.buttonShowInfos then return end

    for i, v in ipairs(data.buttonShowInfos) do
        self.mainFuncInfo_[v.type] = v
        EventMgr:dispatchEvent(EV_MAIN_FOCUS_UPDATE, v.type)
    end
end

---------------------------------------------------------------------

function FunctionDataMgr:jPay(index)
    if not self:checkFuncOpen() then return end
    index = index or 1
    RechargeDataMgr:showRechageLayer(index)
end

function FunctionDataMgr:jActivityByType( activityType )
    local activityId = ActivityDataMgr2:getActivityInfoByType(activityType)[1]
    if activityId then
        self:jActivity(activityId)
    end
end

function FunctionDataMgr:jActivity(activitId)
    if not self:checkFuncOpen(6) then return end
    local activityInfo = ActivityDataMgr2:getActivityInfo(activitId)
    local activityShowType = nil
    if activityInfo and activityInfo.extendData and activityInfo.extendData.activityShowType then 
        activityShowType = activityInfo.extendData.activityShowType
        if self["jActivity"..activityShowType] then
            self["jActivity"..activityShowType](self, activitId, activityShowType)
            return
        end
    end
    Utils:openView("activity.ActivityMainView", activitId, activityShowType)
end

function FunctionDataMgr:jActivity3(activitId, activityShowType)
    activityShowType = activityShowType or 3
    Utils:openView("activity.ActivityMainView3", activitId, activityShowType)
end

function FunctionDataMgr:jActivity4(activitId, activityShowType)
    activityShowType = activityShowType or 4
    Utils:openView("activity.ActivityMainView4", activitId, activityShowType)
end

function FunctionDataMgr:jActivity5(activitId, activityShowType)
    activityShowType = activityShowType or 5
    Utils:openView("activity.ActivityMainView5", activitId, activityShowType)
end

function FunctionDataMgr:jActivity6(activitId, activityShowType)
    activityShowType = activityShowType or 6
    Utils:openView("activity.ActivityMainView6", activitId, activityShowType)
end

function FunctionDataMgr:jActivity1001(activitId, activityShowType)
    activityShowType = activityShowType or 1001
    Utils:openView("activity.ActivityMainView1001", activitId, activityShowType)
end

function FunctionDataMgr:jActivity2(activitId, activityShowType)
    if not self:checkFuncOpen() then return end
    self:closeChronoCrossOpenedView(activitId)
    activityShowType = activityShowType or 2
    Utils:openView("activity.ActivityMainView2", activitId, activityShowType)
end

function FunctionDataMgr:jActivity7(activitId, activityShowType)
    activityShowType = activityShowType or 7
    Utils:openView("activity.ActivityMainView2", activitId, activityShowType)
end

function FunctionDataMgr:closeChronoCrossOpenedView(activitId)
    local activityInfo = ActivityDataMgr2:getActivityInfo(activitId)
    if activityInfo and activityInfo.activityType == EC_ActivityType2.CHRONO_CROSS then
        local layerName = {"ActivityMainView2","ChronoCrossMainView","ChronoCrossDating","ChronoPuzzleView","ItemAccessView","ItemInfoView"}
        for k,v in ipairs(layerName) do
            local isLayerInQueue,layer = AlertManager:isLayerInQueue(v)
            if isLayerInQueue then
                AlertManager:closeLayer(layer)
            end
        end
    end
end

function FunctionDataMgr:jStore(storeCid,storeType)
    if not self:checkFuncOpen() then return end
    Utils:openView("store.StoreMainView", {storeCid,storeType})
end

function FunctionDataMgr:jSummonMain()
    if not self:checkFuncOpen() then return end
    Utils:openView("summon.SummonMainView")
end

function FunctionDataMgr:jTask(taskType)
    if not self:checkFuncOpen() then return end
    Utils:openView("task.TaskMainView", taskType)
end

function FunctionDataMgr:jOnlineStore()
    self:jStore(120000)
end

function FunctionDataMgr:jPlotFuben()
    if not self:checkFuncOpen() then return end
    Utils:openView("fuben.FubenChapterView", EC_FBType.PLOT)
end

function FunctionDataMgr:jDailyFuben()
    if not self:checkFuncOpen() then return end
    Utils:openView("fuben.FubenChapterView", EC_FBType.DAILY)
end

function FunctionDataMgr:jFriend( index, jumpInvite )
    if not self:checkFuncOpen() then return end
    Utils:openView("friend.FriendView", index, jumpInvite)
end

function FunctionDataMgr:jHero()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false})
end

function FunctionDataMgr:jHeroQiyue()
    self:jPlayerInfo(4)
end

function FunctionDataMgr:jJieJing()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false, gotoWhichTab = 2})
end

function FunctionDataMgr:jAngel()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false, gotoWhichTab = 4})
end

function FunctionDataMgr:jEquipment()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false, gotoWhichTab = 3})
end

function FunctionDataMgr:jNewEquipMent()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false, gotoWhichTab = 5})
end

function FunctionDataMgr:jCity(...)
    if not self:checkFuncOpen() then return end
    local param = {...}
    if param[2] then
        if HeroDataMgr:getIsHave(param[2]) then
            NewCityDataMgr:setPreOpenParam(param)
        else
            Utils:showTips(TextDataMgr:getText(800076))
            return
        end
    end
    TFAssetsManager:downloadHeroAssets(function()
        NewCityDataMgr:enterNewCity(EC_NewCityType.NewCity_Normal)
    end,true)
end

function FunctionDataMgr:jSummon(jumpIndex)
    if not self:checkFuncOpen() then return end
    Utils:openView("summon.SummonView",jumpIndex)
end

function FunctionDataMgr:jCompose()
    if not self:checkFuncOpen() then return end
    Utils:openView("summon.SummonComposeView")
end

function FunctionDataMgr:jInfoStation( )
    if not InfoStationDataMgr:getEnterState() then return end
    Utils:openView("infoStation.InfoStationLayer")
end

function FunctionDataMgr:jFubenReady(levelCid)
    levelCid = levelCid or 101101
    local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelCfg.levelGroupId)
    local chapterCfg = FubenDataMgr:getChapterCfg(levelGroupCfg.dungeonChapterId)
    if FubenDataMgr:checkPlotLevelEnabled(levelCid) then
        local function toOpenReady()
            local levelView = requireNew("lua.logic.fuben.FubenLevelView"):new(levelGroupCfg.dungeonChapterId, levelCid)
            local readyView = requireNew("lua.logic.fuben.FubenReadyView"):new(levelCid)
            AlertManager:addLayer(readyView)
            AlertManager:show()
        end
        local fubenCheckCfg = {[1] = {1,levelGroupCfg.dungeonChapterId},[2] = {2,2},[4] = {3,levelGroupCfg.dungeonChapterId},[5] = {6,levelGroupCfg.dungeonChapterId}}
        local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
        if fubenCheckParam then
            local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
            if checkExtId then
                TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                    toOpenReady()
                end,true)
                return
            else
                TFAssetsManager:downloadHeroAssets(function()
                    toOpenReady()
                end,true)
            end
        end
    else
        if MainPlayer:getPlayerLv() >= levelCfg.playerLv then
            Utils:showTips(202001)
        else
            Utils:showTips(300828, levelCfg.playerLv)
        end
    end
end

function FunctionDataMgr:jSignInTask()
    if not self:checkFuncOpen() then return end
    Utils:openView("task.TaskSignInView")
end

function FunctionDataMgr:jActivityFuben(selectChapter)
    if not self:checkFuncOpen() then return end
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FubenChapterView")
    if not isLayerInQueue then
        Utils:openView("fuben.FubenChapterView", EC_FBType.ACTIVITY, selectChapter)
    else
        AlertManager:closeAllBeforLayer(layer)
    end
end

function FunctionDataMgr:jEndlessStore()
    self:jStore(130000)
end

function FunctionDataMgr:jKabalaStore()
    self:jStore(140000)
end

function FunctionDataMgr:jChat()
    if not self:checkFuncOpen() then return end
    local ChatView = requireNew("lua.logic.chat.ChatView")
    ChatView.show()
end

function FunctionDataMgr:jPokedex(playerInfo)
    if playerInfo then
        CollectDataMgr:readyOtherCollect(playerInfo)
        Utils:openView("collect.CollectMainView")
        return
    end
    if not self:checkFuncOpen() then return end
    CollectDataMgr:readyOwnCollect()
    Utils:openView("collect.CollectMainView")
end

function FunctionDataMgr:jGiftStore()
    self:jStore(150000)
end

function FunctionDataMgr:jBag()
    if not self:checkFuncOpen() then return end
    Utils:openView("bag.BagView")
end

function FunctionDataMgr:jEmail()
    if not self:checkFuncOpen() then return end
    Utils:openView("mail.MailMain")
end

function FunctionDataMgr:jDispatch()
    if not self:checkFuncOpen() then return end
    Utils:openView("dispatch.DispatchMainLayer")
end

function FunctionDataMgr:jFragmentStore()
    self:jStore(110000)
end

function FunctionDataMgr:jMedal()
    if not self:checkFuncOpen() then return end
    Utils:openView("playerInfo.MedalIndexView")
end

function FunctionDataMgr:jPayGift()
    self:jPay(2)
end

function FunctionDataMgr:jPayWelfare()
    self:jPay(3)
end

function FunctionDataMgr:jPayMonthCard()
    self:jPay(4)
end


function FunctionDataMgr:jClothStore()
    self:jStore(160000)
end

function FunctionDataMgr:jSupportActivity()
    Utils:openView("activity.AssistMainView")
end

function FunctionDataMgr:jHolidayFuben()
    if not self:checkFuncOpen() then return end
    Utils:openView("fuben.FubenChapterView", EC_FBType.HOLIDAY)
end

function FunctionDataMgr:jHalloweenStore()    
    self:jStore(170000)
end

function FunctionDataMgr:jActivityFubenEndless()
    self:jActivityFuben(EC_ActivityFubenType.ENDLESS)
end

function FunctionDataMgr:jActivityFubenTeam()
    self:jActivityFuben(EC_ActivityFubenType.TEAM)
end

function FunctionDataMgr:jActivityFubenSprite()
    self:jActivityFuben(EC_ActivityFubenType.SPRITE)
end

function FunctionDataMgr:jActivityFubenKabala()
    self:jActivityFuben(EC_ActivityFubenType.KABALA)
end

function FunctionDataMgr:jActivityFubenBigWorld()
    self:jActivityFuben(EC_ActivityFubenType.BIG_WORLD)
end

function FunctionDataMgr:jActivityFubenSimulationTrial()
    self:jActivityFuben(EC_ActivityFubenType.SIMULATION_TRIAL)
end

function FunctionDataMgr:jActivityFubenSimulationTrial2()
    self:jActivityFuben(EC_ActivityFubenType.SIMULATION_TRIAL_2)
end

function FunctionDataMgr:jTheaterFuben()
    if not self:checkFuncOpen() then return end
    Utils:openView("fuben.FubenChapterView", EC_FBType.THEATER)
end

function FunctionDataMgr:jTheaterBossView()
    if not self:checkFuncOpen() then return end
    local chapter = FubenDataMgr:getChapter(EC_FBType.THEATER_HARD)
    local chapterCid = chapter[1]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    if MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel then
        local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
        if theaterBossInfo.status ~= EC_TheaterStatus.CLOSING then
            Utils:openView("fuben.FubenTheaterBossView")
        else
            Utils:openView("fuben.FubenChapterView", EC_FBType.THEATER)
        end
    else
        Utils:showTips(12010142, chapterCfg.unlockLevel)
    end
end

function FunctionDataMgr:jTheaterLevelView(theaterId)
    if not self:checkFuncOpen() then return end
    Utils:openView("fuben.FubenChapterView", EC_FBType.THEATER, nil,theaterId)
end

function FunctionDataMgr:jTheaterLevel(extraChapterId,levelCid)
    local theaterLevelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local chapterCfg = FubenDataMgr:getChapterCfg(theaterLevelCfg.chapter)
    local _, condEnabled, timeEnabled, levelEnabeld = FubenDataMgr:checkTheaterChapterEnabled(chapterCfg.id)

    if not timeEnabled then
        if chapterCfg.order == 2 then
            Utils:showTips(12010139)
        elseif chapterCfg.order == 3 then
            Utils:showTips(12010140)
        elseif chapterCfg.order == 4 then
            Utils:showTips(12010141)
        end
        return
    end

    if not levelEnabeld then
        Utils:showTips(12010142, chapterCfg.unlockLevel)
        return
    end

    if not condEnabled then
        Utils:showTips(12010143, chapterCfg.order - 1)
        return
    end

    local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
    if enabled then
        local function toOpenReady()
            Utils:openView("fuben.FubenTheaterLevelView", chapterCfg.id, levelCid, extraChapterId)
            Utils:openView("fuben.FubenReadyView", levelCid)
        end

        local fubenCheckCfg = {[3] = {7,chapterCfg.id},[6] = {8,chapterCfg.id},[7] = {9,chapterCfg.id}}
        local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
        if fubenCheckParam then
            local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
            if checkExtId then
                TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                    toOpenReady()
                end,true)
                return
            else
                TFAssetsManager:downloadHeroAssets(function()
                    toOpenReady()
                end,true)
            end
        end
    else
        Utils:showTips(202001)
    end
end

function FunctionDataMgr:jTheaterHardLevel(extraChapterId,levelCid)
    local chapter = FubenDataMgr:getTheaterHardChapter(extraChapterId)
    local chapterCfg = FubenDataMgr:getChapterCfg(chapter[1])
    local _, condEnabled, timeEnabled, levelEnabeld = FubenDataMgr:checkTheaterChapterEnabled(chapterCfg.id)
    if not condEnabled then
        return
    end
    if not levelEnabeld then
        Utils:showTips(12010142, chapterCfg.unlockLevel)
        return
    end
    local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
    if enabled then
        local function toOpenReady()
            Utils:openView("fuben.NewFubenTheaterHardLevelView",nil, levelCid, extraChapterId,true)
            Utils:openView("fuben.FubenReadyView", levelCid)
        end
        local fubenCheckCfg = {[3] = {7,chapterCfg.id},[6] = {8,chapterCfg.id},[7] = {9,chapterCfg.id}}
        local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
        if fubenCheckParam then
            local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
            if checkExtId then
                TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                    toOpenReady()
                end,true)
                return
            else
                TFAssetsManager:downloadHeroAssets(function()
                    toOpenReady()
                end,true)
            end
        end
    else
        Utils:showTips(202001)
    end
end

function FunctionDataMgr:jChristmasAgora()
    if not self:checkFuncOpen() then return end
    local checkExtId = TFAssetsManager:getCheckInfo(6,EC_ActivityFubenType.CHRISTMAS)
    if checkExtId then
        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
            AgoraDataMgr:openAgoraMain()
        end,true)
        return
    else
        TFAssetsManager:downloadHeroAssets(function()
            AgoraDataMgr:openAgoraMain()
        end,true)
    end
end

function FunctionDataMgr:jStartDating(datingRuleId)
    DatingDataMgr:startDating(datingRuleId)
end

function FunctionDataMgr:jChristmasStore()
    self:jStore(180000)
end

function FunctionDataMgr:openPhoneAi()
    local data = {
        ruleId = nil,
        timeFrame = nil,
    }

    if CC_TARGET_PLATFORM ~= CC_PLATFORM_ANDROID then
        EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)
        Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
        AlertManager:changeScene(SceneType.Phone,data);
    else
        Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
        AlertManager:changeScene(SceneType.Phone,data);
    end
end

function FunctionDataMgr:jDatingPhone()

    if not self:checkFuncOpen() then return end

    --if CC_TARGET_PLATFORM == CC_PLATFORM_IOS then
        --Utils:openView("datingPhone.PhoneMainView")
    --else
    --    Utils:setScreenOrientation(SCREEN_ORIENTATION_PORTRAIT)
    --    AlertManager:changeScene(SceneType.Phone,data);
    --end
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 or RELEASE_TEST then
        self:openPhoneAi()
    else
        if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS --[[and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50]]) or
                (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID --[[and tonumber(TFDeviceInfo:getCurAppVersion()) < 3.50]]) then
            Utils:openView("datingPhone.PhoneMainView")
        else
            self:openPhoneAi()
        end
    end
end

function FunctionDataMgr:jWelfare(welfareType)
    if not self:checkFuncOpen() then return end
    if welfareType and welfareType == EC_ActivityType.SUPPORT_STORE then
        self:jGiftPacks(3)
    else
        Utils:openView("activity.ActivityMain", welfareType)
    end
end

function FunctionDataMgr:jMonthCard()
    self:jGiftPacks(2)
end

function FunctionDataMgr:jGiftPacks(panelId)
    Utils:openView("store.GiftPackMainView",panelId)
end

function FunctionDataMgr:jGMSkill()
    if not self:checkFuncOpen() then return end
    self:jPlayerInfo(5)
end

function FunctionDataMgr:jUnionHall(tabIdx)
    if not self:checkFuncOpen() then return end
    Utils:openView("league.LeagueHallView", {selectIdx = tabIdx})
end

function FunctionDataMgr:jUnionMember()
    if not self:checkFuncOpen() then return end
    Utils:openView("league.LeagueHallView", {selectIdx = 2})
end

function FunctionDataMgr:jUnionSupply()
    if not self:checkFuncOpen() then return end
    Utils:openView("league.LeagueSupplyDropView")
end

function FunctionDataMgr:jUnionBuilding(buildingType)
    if not self:checkFuncOpen() then return end
    Utils:openView("league.LeagueBuildingMainView", buildingType)
end

function FunctionDataMgr:jUnionStor()
    if not self:checkFuncOpen() then return end
    self:jStore(190000)
end

function FunctionDataMgr:jUnionInvade()
    if not self:checkFuncOpen() then return end

end

function FunctionDataMgr:jUnionHunt()
    if not self:checkFuncOpen() then return end
    LeagueDataMgr:checkAndOpenHunterView()
end

function FunctionDataMgr:jUnionMatrix()
    if not self:checkFuncOpen() then return end
    Utils:openView("league.LeagueTrainingView")
end

function FunctionDataMgr:jUnion()
    if not self:checkFuncOpen() then return end
    if LeagueDataMgr:checkSelfInUnion() then
        Utils:openView("league.LeagueMainLayer")
    else
        Utils:openView("league.NoLeagueLayer")
    end
end

function FunctionDataMgr:jSpring()
    self:jActivityFuben(EC_ActivityFubenType.TEAM_PVE)
end

function FunctionDataMgr:jDlsStore()
    self:jStore(201000)
end

--战争商店
function FunctionDataMgr:jWarStore()
    self:jStore(401000 )
end

function FunctionDataMgr:jUseItem(goodsCid)
    local count = GoodsDataMgr:getItemCount(goodsCid)
    if count > 0 then
        local _, item = next(GoodsDataMgr:getItem(goodsCid))
        Utils:showInfo(item.cid, item.id)
    else
        Utils:showTips(1430001)
    end
end

function FunctionDataMgr:jElfContract()
    self:jGiftPacks(4)
end

function FunctionDataMgr:jSkyLadder()

    if not self:checkFuncOpen() then return end
    local isOpen = SkyLadderDataMgr:isOpen()
    if isOpen then
        Utils:openView("skyLadder.SkyLadderMainView")
    else
        Utils:showTips(1890001)
    end
end

function FunctionDataMgr:jPlayerInfo(tabIdx)
    Utils:openView("playerInfo.PlayerSetting",{selectIdx = tabIdx})
end

function FunctionDataMgr:jStone()
    if not self:checkFuncOpen() then return end
    HeroDataMgr.showid = HeroDataMgr:getHeroId(1, 1);
    Utils:openView("fairyNew.FairyDetailsLayer", {showid=HeroDataMgr:getHeroId(1, 1), friend=false, gotoWhichTab = 6})
end

-- 是否为周年庆ui
function FunctionDataMgr:isMainLayerOneYearUI(str)
    if not str then
        str = "mainLayerUi"
    end
    local servertime = ServerDataMgr:getServerTime()
    local oneYearTime = Utils:getKVP(60002, str)
    if not oneYearTime then
        return false
    end
    local opentime = tonumber(oneYearTime.opentime) / 1000
    local endtime = tonumber(oneYearTime.endtime) / 1000
    if opentime <= servertime and endtime >= servertime then
        return true
    end
    return false
end

function FunctionDataMgr:jNewGuyGiftBag( ... )
    Utils:openView("store.NewGuyGiftBag")
end

function FunctionDataMgr:jHundredLoginView( ... )
    Utils:openView("activity.HundredLoginView")
end

function FunctionDataMgr:isOneYearLoginUI()
    local servertime = MainPlayer:getServerDateBeforeLogin()
    local oneYearTime = Utils:getKVP(60002, "loginLayerUI")

    local opentime = Utils:changStrToDate(oneYearTime.opentime) 
    local endtime   = Utils:changStrToDate(oneYearTime.endtime)

    local exp1 = Utils:compareDate(servertime, opentime)
    local exp2 = Utils:compareDate(servertime, endtime)
    if exp1 and not exp2 then
        return true
    end
    return false
end

function FunctionDataMgr:jLinkAgeMain()
    if not self:checkFuncOpen() then return end
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FubenChapterView")
    if not isLayerInQueue then
        Utils:openView("fuben.FubenChapterView", EC_FBType.LINKAGE)
    else
        AlertManager:closeAllBeforLayer(layer)
    end
end

function FunctionDataMgr:jLinkAge(chapterCid)
    if not self:checkFuncOpen(140) then return end
    Utils:openView("linkage.LinkageView",chapterCid) 
end

---狂三副本跳转
function FunctionDataMgr:jKsanFuben()

    local servertime    = ServerDataMgr:getServerTime()
    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)
    if not activityIds or not activityIds[1] then
        return
    end

    local activityKsanInfo = ActivityDataMgr2:getActivityInfo(activityIds[1])
    if not activityKsanInfo then
        return
    end

    if servertime < activityKsanInfo.startTime then
        local startDate = Utils:getLocalDate(activityKsanInfo.startTime)
        local startDateStr = startDate:fmt("%m月%d日 %H时%M分")
        Utils:showTips(startDateStr.."开启")
        return
    end

    if servertime >= activityKsanInfo.startTime and  servertime < activityKsanInfo.endTime then
        Utils:openView("kuangsanOutbound.MainMapLayer")
    end
end

---狂三副本跳转
function FunctionDataMgr:jKsanGift()
    self:jActivity6(10109)
end

function FunctionDataMgr:jWarOrderBuy()
    if not self:checkFuncOpen() then return end
    if ActivityDataMgr2:isWarOrderActivityOpen() then
        Utils:openView("task.TaskTrainingChargeView")
    else
        Utils:showTips(219007)
    end
end

function FunctionDataMgr:saveType206AdvertisementState(noTipsToday)
    local playerid      = MainPlayer:getPlayerId()
    local servertime    = os.time();--ServerDataMgr:getServerTime()
    if noTipsToday == 0 then
        CCUserDefault:sharedUserDefault():setStringForKey("206RecordTime_"..playerid, "")
        CCUserDefault:sharedUserDefault():flush()
    elseif noTipsToday == 1 then
        CCUserDefault:sharedUserDefault():setStringForKey("206RecordTime_"..playerid, servertime)
        CCUserDefault:sharedUserDefault():flush()
    end
end

function FunctionDataMgr:getType206AdvertisementState()
    local playerid          = MainPlayer:getPlayerId()
    local recordTime        = CCUserDefault:sharedUserDefault():getStringForKey("206RecordTime_"..playerid);
    local servertime        = os.time();--ServerDataMgr:getServerTime()
    dump(recordTime)
    if recordTime ~= "" then
        local recordDay                     = (os.date("*t",tonumber(recordTime))).day;
        local day                           = (os.date("*t",tonumber(servertime))).day;
        dump(recordDay,day)
        if recordDay ~= day then
            recordTime = ""
            CCUserDefault:sharedUserDefault():setStringForKey("206RecordTime_"..playerid, "");
        end
    end
    dump(recordTime)
    return recordTime ~= "",recordTime;
end

--好友助力邀请码
function FunctionDataMgr:jAssistanceCode( )
    if not self:checkFuncOpen() then return end
    Utils:openView("assistance.AssistanceCodeLayer")
end
--请求过期物品回收
function FunctionDataMgr:request_ITEM_REQ_TIME_OUT_ITEM_CONVERT()
    print("请求过期物品回收")
    TFDirector:send(c2s.ITEM_REQ_TIME_OUT_ITEM_CONVERT, {})
end

function FunctionDataMgr:onRecyclingItems(event)
    local data = event.data
    print("收到物品回收")
    dump(data)
    if not data then return end

    EventMgr:dispatchEvent(EV_ITEM_RECYCLING_RESULT, data)
end

return FunctionDataMgr:new()
