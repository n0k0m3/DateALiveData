--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* -- 游乐园控制器
]]

local MapUtils = import("lua.logic.osd.MapUtils")
local enum = require("lua.logic.battle.enum")
local eDir = enum.eDir
local eResType  =  enum.eResType
local SingleWorldSceneControl = requireNew("lua.logic.2020ZNQ.AmusementPackControl")

local function createNewEmptyData( self, cfgId, isHero)
    -- body
    if isHero then
        return {
                pid = cfgId,
                skinCid = cfgId,
                moveSpeed = 0,
                dir = 2,
            }
    end

    return {
                pid = cfgId,
                decorateId = cfgId,
                moveSpeed = 0,
                dir = 2,
                pos = {x = 300,y = 300}
            }
end
rawset(SingleWorldSceneControl, "createNewEmptyData", createNewEmptyData)

local function createActor( self, actorData )
	-- body
    local isHero = actorData.skinCid

    if not isHero and actorData.pos and actorData.pos.x > 0 and actorData.pos.y == 0 then -- npc 坐标为配置地图点位
        local nodeData = self:getNodeDataByRenderId(actorData.pos.x)
        if nodeData then
            actorData.pos =  me.p(nodeData.Position.X, nodeData.Position.Y)
            actorData.areaRect = me.rect(0,0,nodeData.Size.W, nodeData.Size.H)
        end
    end

	local actor = requireNew("lua.logic.singleWorldScene.SingleWorldSceneActor"):new(actorData)
	if actor.isAction then	
		self:addHero(actor)
	else
		self:addNPC(actor)
	end

    if actor:isMainHero() then
        self.baseMap:resetToBornPos(actor)
    end
	return actor
end
rawset(SingleWorldSceneControl, "createActor", createActor)

local function enterScene( self, ... )
    AlertManager:changeScene(SceneType.AmusementPack)
end
rawset(SingleWorldSceneControl, "enterScene", enterScene)


local function createMainHeroData(self, heroCfgId )
    -- body
    local actorData = self:createNewEmptyData(0)
    actorData.pid = MainPlayer:getPlayerId()
    actorData.decorateId = heroCfgId
    self:updateActorData(actorData)
end
rawset(SingleWorldSceneControl, "createMainHeroData", createMainHeroData)

local function getResList( self,resUtils)
	local resList = {}
    MapUtils:cleanMapParse()
    MapUtils:getMapParse():loadJson(self:getMapInfo()) --加载json
    local mapResList = MapUtils:getMapParse():getRespaths()
    for k, texture in pairs(mapResList.textures) do
        table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, texture))
    end
    for k, effecName in pairs(mapResList.effects) do
        table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, effecName .. ".png"))
        table.insert(resList, resUtils:createResInfo(eResType.RT_SPINE, effecName))
    end

    --npc资源
    local npcList = MapUtils:getMapParse():getNpcResList()
    local resPath = ""
    for k, v in pairs(npcList) do
        local npcCfg, resCfg = self:getNpcCfg(tonumber(v.CfgID))
        if resCfg then
            resPath = resCfg.path
            if resCfg.resourceType == 1 then
                table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, resPath))
            else
                table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
                table.insert(resList, resUtils:createResInfo(eResType.RT_SPINE, resPath))
            end
        end
    end

    local catList = TabDataMgr:getData("CatList")

    for k,v in pairs(catList) do
        resPath = v.rolePath
        table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
        table.insert(resList, resUtils:createResInfo(eResType.RT_SPINE, resPath))
    end

    table.sort(resList, function(a, b)
        return a.resType > b.resType
    end)
    return resList
end
rawset(SingleWorldSceneControl, "getResList", getResList)

local function triggerNpcFunc( self, actionData, isAuto)
    -- body
    local curTime = ServerDataMgr:getServerTime() 
    local actionCfg = TabDataMgr:getData("WorldActionButton",actionData.interActionId)

    if isAuto and not actionCfg.isAuto then return end -- 自动触发的操作只有isAuto对象才能出理
    actionCfg.autoDelayTime = actionCfg.autoDelayTime or 0
    self.autoTriggerActionIds = self.autoTriggerActionIds or {}
    if isAuto then
        if actionData.triggerPid then
            if self.autoTriggerActionIds[actionData.triggerPid] and self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] and self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] > curTime then
                return
            else
                self.autoTriggerActionIds[actionData.triggerPid] = self.autoTriggerActionIds[actionData.triggerPid] or {}
                self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] = curTime + actionCfg.autoDelayTime 
            end
        else
            if self.autoTriggerActionIds[actionData.actorPid] and self.autoTriggerActionIds[actionData.actorPid][actionData.interActionId] and self.autoTriggerActionIds[actionData.actorPid][actionData.interActionId] > curTime then
                return
            else
                self.autoTriggerActionIds[actionData.actorPid] = self.autoTriggerActionIds[actionData.actorPid] or {}
                self.autoTriggerActionIds[actionData.actorPid][actionData.interActionId] = curTime + actionCfg.autoDelayTime 
            end
        end
    end

    local function callBack( ... )
        if self.actorDataQueue:length() == 0 then return end
        local interActionType = actionCfg.interType
        if interActionType == 1 then -- 打开对应功能
            FunctionDataMgr:enterByFuncId(actionCfg.interTypeParma.jumpInterface,unpack(actionCfg.interTypeParma.parameter))
        elseif interActionType == 2 then -- 通知服务器交互建筑
            local actorData = self:getActorDataByPid(actionData.triggerPid)
            local _actorData1 = self:getActorDataByPid(actionData.actorPid)
            if actorData.buildId ~= _actorData1.decorateId then
                actorData.buildId = _actorData1.decorateId
            else
                actorData.buildId = -1
            end
            self:deriveData()
        elseif interActionType == 5 then -- 建筑上播放表情
            local actions = {}
            table.insert    (actions,{actionId = actionCfg.interTypeParma.actionId, pid = actionData.triggerPid})
            self:operateAction({actions = actions})
        elseif interActionType == 7 then -- 添加ai
            if self:checkCondition(actionCfg.interTypeParma.cond) then -- 检测触发条件
                for i = 1,10 do -- 固定10次内随机
                    local willCreateActor = actionCfg.interTypeParma.actorCfgId[math.random(1,#actionCfg.interTypeParma.actorCfgId)]
                    if not self:getActorDataByPid(willCreateActor) then
                        if not actionCfg.interTypeParma.isHero then
                            local npcCfg = TabDataMgr:getData("WorldObjectMgr",willCreateActor)
                            if npcCfg and self:checkCondition(npcCfg.creatCond) then
                                local actorData = self:createNewEmptyData(willCreateActor, actionCfg.interTypeParma.isHero)
                                actorData.childType = actionCfg.interTypeParma.childType
                                local actorNode = self:getActorNodeByPid(actionData.actorPid)
                                actorData.pos = actorNode:getPosition()
                                self:updateActorData(actorData)
                                break
                            end
                        else
                            local actorData = self:createNewEmptyData(willCreateActor, actionCfg.interTypeParma.isHero)
                            actorData.childType = actionCfg.interTypeParma.childType
                            local actorNode = self:getActorNodeByPid(actionData.actorPid)
                            actorData.pos = actorNode:getPosition()
                            self:updateActorData(actorData)
                            break
                        end
                    end
                end
            end
        elseif interActionType == 8 then -- 移除碰撞的非静态对象
            local actorNode = self:getActorNodeByPid(actionData.triggerPid)
            if not actorNode then  return true end
            if actorNode.childType and table.find(actionCfg.interTypeParma.removeChildType, actorNode.childType) ~= -1 then
                self.autoTriggerActionIds[actionData.triggerPid] = {}
               self:removeActorNode(actorNode)
            end
        elseif interActionType == 9 then -- 移动到指定位置
            local actorNode = self:getActorNodeByPid(actionData.triggerPid)
            if not actorNode then  return true end
            actorNode:moveTo(ccp(actionCfg.interTypeParma.pos[1],actionCfg.interTypeParma.pos[2]),function ( ... )
                -- body
                actorNode:delayAIAction( 1000 )
            end)
        end
    end

    if actionData.actorPid then -- 统一播对象交互逻辑
        local actor = self:getActorNodeByPid(actionData.actorPid)
        local actorData = self:getActorDataByPid(actionData.actorPid)

        if not actorData then return end -- 对象触发移除 不在执行触发动作
        
        if actorData.decorateId then
            local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId) 
            if actionCfg.asyn then -- 异步同时执行
                actor:actionByCfgId(npcCfg.objectAni_inter)
                callBack()
            else
                actor:actionByCfgId(npcCfg.objectAni_inter, nil ,callBack)
            end
        else
            callBack()
        end
    else
        callBack()
    end
    return true
end
rawset(SingleWorldSceneControl, "triggerNpcFunc", triggerNpcFunc)

local function operateAction( self, operateData )
    -- body
    if not operateData then return end
    if operateData.actions then
        for k,v in ipairs(operateData.actions) do
            local actor = self:getActorNodeByPid(v.pid)
            if actor then
                actor:actionByCfgId(v.actionId)
            end
        end
    end

    if operateData.auto then
        local actor = self:getActorNodeByPid(operateData.auto.pid)
        if not actor then return end
        actor:serverToMove(ccp(operateData.auto.lx,operateData.auto.ly))
    end
end
rawset(SingleWorldSceneControl, "operateAction", operateAction)

local function changeCameraFixZ( self, fixZ )
    -- body
    fixZ = fixZ or 150
    if self:getBaseMap() and fixZ then
        self:getBaseMap().camera:setFixZ(fixZ)
    end
end
rawset(SingleWorldSceneControl, "changeCameraFixZ", changeCameraFixZ)


function operateLeaveBuild(self, actorPid )
    -- body
end
rawset(SingleWorldSceneControl, "operateLeaveBuild", operateLeaveBuild)


return SingleWorldSceneControl