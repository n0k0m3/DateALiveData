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
local BasicControl = import("lua.logic.mmoBasicClass.BasicControl")
local enum = require("lua.logic.battle.enum")
local eDir = enum.eDir
local eResType  =  enum.eResType

local AmusementPackControl = class("AmusementPackControl",BasicControl)

function AmusementPackControl:ctor( ... )
	-- body
	self.super.ctor(self)
end

function AmusementPackControl:initData( ... )
	-- body
	self.super.initData(self)
    self.autoTriggerActionIds = {}
end

function AmusementPackControl:createNewEmptyData( cfgId )
    -- body
    return {
                pid = cfgId,
                decorateId = cfgId,
                moveSpeed = 0,
                dir = 2,
            }
end

function AmusementPackControl:createActor( actorData )
	-- body
    local isHero = actorData.skinCid

    if not isHero and actorData.pos and actorData.pos.x > 0 and actorData.pos.y == 0 then -- npc 坐标为配置地图点位
        local nodeData = self:getNodeDataByRenderId(actorData.pos.x)
        if nodeData then
            actorData.pos =  me.p(nodeData.Position.X, nodeData.Position.Y)
            actorData.areaRect = me.rect(0,0,nodeData.Size.W, nodeData.Size.H)
        end
    end

	local actor = requireNew("lua.logic.2020ZNQ.AmusementPackActor"):new(actorData)
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

function AmusementPackControl:checkBuildFuncIsEnable( funType )
    -- body
    if not self.mainHero then return false end
    local actorData = self:getActorDataByPid(self.mainHero:getPid())
    if not actorData.buildId then
        return true
    end
    local buildActor = self:getActorDataByPid(actorData.buildId)

    if not buildActor.decorateId then
        return true
    end

    local npcCfg = TabDataMgr:getData("WorldObjectMgr",buildActor.decorateId)
    if not npcCfg.ableFunctionOnBuild or not table.count(npcCfg.ableFunctionOnBuild) == 0 or table.find(npcCfg.ableFunctionOnBuild,funType)  ~= -1 then
        return true
    end

    return false
end

function AmusementPackControl:update( dt )
	-- body
	self.super.update(self, dt)
end

function AmusementPackControl:lateUpdate( dt )
    -- body
    self:checkActorInBuilding()
end

function AmusementPackControl:updateInFrame9( dt )
    -- body
    self.super.updateInFrame9(self,dt)
    
    if self.setViewOffset then
        self.baseMap:setViewOffset(800,800)
    end
    self.setViewOffset = true
    self:updateNpcEffectSound()
end

function AmusementPackControl:getNodeDataByRenderId( id )
    -- body
    if not self.baseMap then return end
    local npcLists = self.baseMap.mapParse:getNpcList()
    for k,v in ipairs(npcLists) do
        if v.ID == id then
            return v
        end
    end
    return nil
end

function AmusementPackControl:updateNpcEffectSound( ... )
    -- body
    local mainHero = self:getMainHero()
    for npc in self:getNPCList():iterator() do
        local npcPos = npc:getPosition()
        if not mainHero then
            npc:pauseAudio()
        else
            local npcData = self:getActorDataByPid(npc:getPid())
            if npcData then
                local npcCfg = TabDataMgr:getData("WorldObjectMgr",npcData.decorateId)
                local pos  = mainHero:getPosition3D()
                local distance = me.pGetDistance(pos,npcPos)
                if distance <= npcCfg.audioRange then
                    npcCfg.audioRate = npcCfg.audioRate or 100
                    local valume = math.min(1,(npcCfg.audioRange - distance)/(npcCfg.audioRange*npcCfg.audioRate/100))
                    npc:resumeAudio(valume)
                else
                    npc:pauseAudio()
                end
            end
        end
    end
end

function AmusementPackControl:getDistanceFromMainHero( actor )
    -- body
    local mainHero = self:getMainHero()
    if not mainHero then return nil end
    if actor == self.mainHero then return 0 end
    local pos = actor:getPosition()
    local mainPos = self.mainHero:getPosition()
    return me.pGetDistance(pos,mainPos)
end

function AmusementPackControl:checkActorInBuilding( ... )
    -- body
    for hero in self:getHeroList():iterator() do
        local actorData = self:getActorDataByPid(hero:getPid())
        if actorData.buildId then
            local _actorData = self:getActorDataByPid(actorData.buildId)
            if _actorData then
                if hero:isMainHero() then
                    WorldRoomDataMgr:setColdingState(true)
                end
                local _actor = self:getActorNodeByPid(_actorData.pid)
                hero:inBuildAction(dt,_actor)
            end
        else
            if hero:isMainHero() then
                WorldRoomDataMgr:setColdingState(false)
            end
            hero:notInBuilding()
        end
    end
end

function AmusementPackControl:enterScene( ... )
    AlertManager:changeScene(SceneType.AmusementPack)
end

function AmusementPackControl:checkCondition( cond, ... )
	-- body
	-- todo 后续完成逻辑
    local isFix = true
	for k,v in pairs(cond) do
		if k == "clubLv" then
            local clubLv = PrivilegeDataMgr:getCurClubWishLv()
			if clubLv < v.min or clubLv > v.max then
                isFix = false
            end
        elseif k == "roomType" then
            if WorldRoomDataMgr.roomType ~= v then
                isFix = false
            end
        elseif k == "flag" and not Utils:checkFlagIsEnable(v, ...) then
            isFix = false
        elseif k == "notflag" and Utils:checkFlagIsEnable(v, ...) then
            isFix = false
        elseif k == "flags" then
            for _k,_v in pairs(v) do
                if not Utils:checkFlagIsEnable(_v, ...) then
                    isFix = false
                    break
                end
            end
        elseif k == "orFlags" then
            local re = false
            for _k,_v in pairs(v) do
                if Utils:checkFlagIsEnable(_v, ...) then
                    re = true
                    break
                end
            end
            if not re then
                isFix = false
            end
        elseif k == "notflags" then
            for _k,_v in pairs(v) do
                if Utils:checkFlagIsEnable(_v, ...) then
                    isFix = false
                    break
                end
            end
		end
	end
	return isFix
end

function AmusementPackControl:getNpcCfg( cfgID )
	-- body
	local tabs = TabDataMgr:getData("WorldObjectMgr")
    local fixTab = {}
	for k,v in pairs(tabs) do
		if v.editorPrefabId == cfgID then
            if not self:checkCondition(v.creatCond) then 
                self:removeActorDataByPid(v.id)
            else
                table.insert(fixTab,v)
            end
		end
	end

    table.sort(fixTab,function ( v1, v2 )
        -- body
        return v1.id < v2.id
    end)
    
    for i ,v in ipairs(fixTab) do
        local resCfg = TabDataMgr:getData("WorldObjectResource",v.resourceId)
        return v,resCfg
    end
end

function AmusementPackControl:getResList(resUtils)
	local resList = {}

	--地图资源
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

    --角色资源
    -- 主角
    -- local tmpSkinList = self:getAllShowRoleList()
    -- local tmpEffectList = self:getAllShowEffectList()
   	local tmpSkinList = {}
    local tmpEffectList = {}
    for actorData in self.actorDataQueue:iterator() do
        if actorData.skinCid and table.find(tmpSkinList, actorData.skinCid) == -1 then
            table.insert(tmpSkinList,actorData.skinCid)
        end

        if actorData.effectId and table.find(tmpSkinList, actorData.effectId) == -1 then
            table.insert(tmpEffectList,actorData.effectId)
        end
    end

    for k, v in ipairs(tmpSkinList) do
        local skinCfg = TabDataMgr:getData("CityRoleModel", v)
        if skinCfg then
            local actorModel  = skinCfg.rolePath
            resPath = actorModel
            table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
            table.insert(resList, resUtils:createResInfo(eResType.RT_SPINE, resPath))
        end
    end

    for k, v in ipairs(tmpEffectList) do
        local effectCfg = TabDataMgr:getData("CityRoleModelEffect", v)
        if effectCfg then
            local actionCfg = TabDataMgr:getData("WorldObjectAction",effectCfg.actionId)
            if actionCfg and actionCfg.motionRecourse_1 ~= "" then
                resPath = actionCfg.motionRecourse_1
                table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
                table.insert(resList, resUtils:createResInfo(eResType.RT_SPINE, resPath))
            end
        end
    end

    --UI资源
    local mapView = require(TFGlobalUtils:loadUIConfigFilePath("lua.uiconfig.activity.znq_yly_maplayer"))
    for k, texture in pairs(mapView.respaths.textures) do
        table.insert(resList, resUtils:createResInfo(eResType.RT_IMAGE, texture))
    end

    table.sort(resList, function(a, b)
        return a.resType > b.resType
    end)
    dump(resList)
    return resList
end

function AmusementPackControl:getFocusInterActionList( ... )
    -- body
    local interAction = {}
    for heroPid,focusNpcs in pairs(self.focusNpcs) do
        for k,v in ipairs(focusNpcs) do
            local npcData = self:getActorDataByPid(v)
            local npcCfg = TabDataMgr:getData("WorldObjectMgr", npcData.decorateId)
            for _k,_v in ipairs(npcCfg.actionButtonId) do
                table.insert(interAction,{interActionId = _v, actorPid = npcData.pid, triggerPid = heroPid})
            end
        end
    end

    for heroPid,focusHeros in pairs(self.focusHeros) do
        for k,v in ipairs(focusHeros) do
            local heroActionButtonIds = self.playerInterActions
            local actorData = self:getActorDataByPid(v)
            if actorData.decorateId then
                 local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId)
                for _k,_v in ipairs(npcCfg.actionButtonId) do
                    table.insert(interAction,{interActionId = _v, actorPid = actorData.pid, triggerPid = heroPid})
                end
            else
                for _k,_v in ipairs(heroActionButtonIds) do
                    table.insert(interAction,{interActionId = _v, actorPid = v, triggerPid = heroPid})
                end
            end
        end
    end

    for k,v in ipairs(self.alwayTriggers) do -- 强制每回合触发的action 
        local npcData = self:getActorDataByPid(v)
        local npcCfg = TabDataMgr:getData("WorldObjectMgr", npcData.decorateId)
        for _k,_v in ipairs(npcCfg.alwayTriggerActionButtonId) do
            table.insert(interAction,{interActionId = _v, actorPid = v})
        end
    end
    local overActionIds = {}
    for i = #interAction,1,-1 do -- 排除不符合当前显示条件的action
        local actionCfg = TabDataMgr:getData("WorldActionButton",interAction[i].interActionId)
        if not self:checkCondition(actionCfg.aprCondition or {}) then
            table.remove(interAction,i)
        end

        if actionCfg.overlayButton then -- 互斥列表整理
            for k,v in ipairs(actionCfg.overlayButton) do
                table.insert(overActionIds,v)
            end
        end
    end

    for k,v in ipairs(overActionIds) do -- 移除互斥actionButton
        for _k,_v in ipairs(interAction) do
            if _v.interActionId == v then
                table.remove(interAction,_k)
            end
        end
    end

    for i = #interAction,1,-1 do -- 自动触发action 
        if self:triggerNpcFunc(interAction[i], true) then
            table.remove(interAction,i)
        end
    end
    return interAction
end

function AmusementPackControl:triggerNpcFunc( actionData, isAuto )
    -- body
    local curTime = ServerDataMgr:getServerTime() 
    local actionCfg = TabDataMgr:getData("WorldActionButton",actionData.interActionId)

    if not self:checkCondition(actionCfg.actionCondition or {}) then -- 不满足操作条件返回
        return actionCfg.isAuto
    end

    if actionCfg.isSingle then  
        self:triggerNpcFuncSingle(actionData,isAuto)
        return actionCfg.isAuto
    end

    if isAuto and not actionCfg.isAuto then return end -- 自动触发的操作只有isAuto对象才能出理
    actionCfg.autoDelayTime = actionCfg.autoDelayTime or 0
    self.autoTriggerActionIds = self.autoTriggerActionIds or {}
    if isAuto then
        if actionData.triggerPid then
            if self.autoTriggerActionIds[actionData.triggerPid] and self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] and self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] > curTime then
                return true
            else
                self.autoTriggerActionIds[actionData.triggerPid] = self.autoTriggerActionIds[actionData.triggerPid] or {}
                self.autoTriggerActionIds[actionData.triggerPid][actionData.interActionId] = curTime + actionCfg.autoDelayTime 
            end
        else
            if self.autoTriggerActionIds[actionData.actorPid] and self.autoTriggerActionIds[actionData.actorPid][actionData.interActionId] and self.autoTriggerActionIds[actionData.actorPid][actionData.interActionId] > curTime then
                return true
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
            self:operateEnterBuild(actionData.actorPid)
        elseif interActionType == 3 then -- 通知打开礼物盒
            self:operateOpenGift(actionData.actorPid)
        elseif interActionType == 4 then -- 离开
            local pid = actionData.actorPid or actionData.triggerPid
            if self:getActorDataByPid(self:getMainHero():getPid()).buildId == pid then -- 判断控制对象在建筑上
                self:operateLeaveBuild(pid)
            end
        elseif interActionType == 5 or interActionType == 10 then -- 建筑上播放表情
            local actionId = actionCfg.interTypeParma.actionId
            if not actionId then
                if actionCfg.interTypeParma.actionRandom then
                    actionId = actionCfg.interTypeParma.actionRandom[math.random(1,#actionCfg.interTypeParma.actionRandom)]
                else
                    return  true
                end
            end
            self:operatePlayAction(actionId)
        elseif interActionType == 7 then -- 添加ai
            
        elseif interActionType == 8 then -- 移除碰撞的非静态对象
            
        elseif interActionType == 9 then -- 移动到指定位置
            self:operateChangePos(ccp(actionCfg.interTypeParma.pos[1],actionCfg.interTypeParma.pos[2]))
        end
    end

    if actionData.actorPid then -- 统一播对象交互逻辑
        local actor = self:getActorNodeByPid(actionData.actorPid)
        local actorData = self:getActorDataByPid(actionData.actorPid)

        if actorData and actorData.decorateId then
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

function AmusementPackControl:triggerNpcFuncSingle( actionData, isAuto )
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
        elseif interActionType == 4 then -- 离开
            local actorData = self:getActorDataByPid(actionData.triggerPid)
            if actorData.inRoomPid then
                for k,v in pairs(actorData.inRoomPid) do
                    local _actorData = self:getActorDataByPid(v)
                    _actorData.buildId = -1
                end
            else
                actorData.buildId = -1
            end
            self:deriveData()
        elseif interActionType == 5 then -- 建筑上播放表情
            local actions = {}
            local pid = actionData.triggerPid or actionData.actorPid
            if actionCfg.interTypeParma.target == 1 then
                pid = actionData.actorPid or actionData.triggerPid
            end
            local actionId = actionCfg.interTypeParma.actionId
            if not actionId then
                if actionCfg.interTypeParma.actionRandom then
                    actionId = actionCfg.interTypeParma.actionRandom[math.random(1,#actionCfg.interTypeParma.actionRandom)]
                else
                    return  true
                end
            end
            table.insert(actions,{actionId = actionId, pid = pid})
            self:operateAction({actions = actions})
        elseif interActionType == 10 then -- 强制为主角执行actionId
            local actions = {}
            table.insert(actions,{actionId = actionCfg.interTypeParma.actionId, pid = self:getMainHero():getPid()})
            self:operateAction({actions = actions})
        elseif interActionType == 7 then -- 添加ai
            if self:checkCondition(actionCfg.interTypeParma.cond or {}) then -- 检测触发条件
                for i = 1,10 do -- 固定10次内随机
                    local willCreateActor = actionCfg.interTypeParma.actorCfgId[math.random(1,#actionCfg.interTypeParma.actorCfgId)]
                    local npcCfg = TabDataMgr:getData("WorldObjectMgr",willCreateActor)
                    if not self:getActorDataByPid(willCreateActor) or actionCfg.interTypeParma.allowRepeat then
                        if not actionCfg.interTypeParma.isHero then
                            if npcCfg and self:checkCondition(npcCfg.creatCond) then
                                local actorData = self:createNewEmptyData(willCreateActor, actionCfg.interTypeParma.isHero)
                                actorData.childType = actionCfg.interTypeParma.childType
                                local dir = eDir.LEFT
                                if actionData.actorPid then
                                    local actorNode = self:getActorNodeByPid(actionData.actorPid)
                                    actorData.pos = actorNode:getPosition()
                                    dir = actorNode:getDir()
                                end

                                if actionData.triggerPid then
                                    local actorNode = self:getActorNodeByPid(actionData.triggerPid)
                                    actorData.pos = actorNode:getPosition()
                                    dir = actorNode:getDir()
                                end

                                if actionCfg.interTypeParma.pos then
                                    actorData.pos = ccp(actionCfg.interTypeParma.pos[1],actionCfg.interTypeParma.pos[2])
                                end

                                if actionCfg.interTypeParma.isFollowMainHero then
                                    actorData.pos = self:getMainHero():getPosition()
                                    dir = self:getMainHero():getDir()
                                end

                                if actionCfg.interTypeParma.parmaFlag then -- 通过标记获取数据
                                    local flagData = Utils:getFlagData(actionCfg.interTypeParma.parmaFlag)
                                    if flagData and flagData.worldRiddlesData then
                                        actorData.pos = ccp(flagData.worldRiddlesData.lox,flagData.worldRiddlesData.loy)
                                    end 
                                end
                                
                                if actionCfg.interTypeParma.offset then
                                    actorData.pos = actorData.pos + ccp(actionCfg.interTypeParma.offset[1],actionCfg.interTypeParma.offset[2])
                                elseif actionCfg.interTypeParma.offsetWithDir then
                                    local flipX = dir == eDir.LEFT and -1 or 1
                                    actorData.pos = actorData.pos + ccp(flipX*actionCfg.interTypeParma.offsetWithDir[1],actionCfg.interTypeParma.offsetWithDir[2])
                                end

                                if actionCfg.interTypeParma.allowRepeat then
                                    for i = 1,100 do
                                        local id = actorData.pid*1000 + i
                                        if not self:getActorDataByPid(id) then
                                            actorData.pid = id
                                            break
                                        end
                                    end
                                end
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
            if actionCfg.interTypeParma.removeChildType then
                local actorNode = self:getActorNodeByPid(actionData.triggerPid) -- 移除碰撞者
                if actionCfg.interTypeParma.target == 1 then -- 移除被碰撞对象
                    actorNode = self:getActorNodeByPid(actionData.actorPid)
                end
                if not actorNode then  return true end
                if actorNode.childType and table.find(actionCfg.interTypeParma.removeChildType, actorNode.childType) ~= -1 then
                    self.autoTriggerActionIds[actorNode:getPid()] = {}
                    self:removeActorNode(actorNode)
                end
            elseif actionCfg.interTypeParma.npcId then
                local actorNode = self:getActorNodeByPid(actionCfg.interTypeParma.npcId) -- 移除特定对象
                self.autoTriggerActionIds[actorNode:getPid()] = {}
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

function AmusementPackControl:mainHeroIsInBuilding( ... )
    -- body
    return self:getMainHero() and self:getMainHero().inBuilding or false
end

function AmusementPackControl:getMainHeroIsInBuildingInterActionList( ... )
    -- body
    local mainActor = self:getActorDataByPid(self:getMainHero():getPid())
    if not mainActor.buildId then return nil end
    local buildActor = self:getActorDataByPid(mainActor.buildId)
    local npcCfg = TabDataMgr:getData("WorldObjectMgr", buildActor.decorateId)
    local interAction = {}
    for k,v in ipairs(npcCfg.ableActionOnBuild) do
        local actionCfg = TabDataMgr:getData("WorldActionButton",v)
        if self:checkCondition(actionCfg.condition or {}) then
            table.insert(interAction,{interActionId = v, actorPid = buildActor.pid})
        end
    end
    return interAction
end

function AmusementPackControl:getAllShowRoleList( ... )
    local showList = {}
    local roles = TabDataMgr:getData("CityRoleModel")
    for k,v in pairs(roles) do
        if v.isPlyaerControlled then
            table.insert(showList,v.id)
        end
    end
    local function getCheckLock(id)
        local cfg = roles[id]
        local isUnlock = false
        for k,v in ipairs(cfg.sameModelId) do
            if GoodsDataMgr:getDress(v) then
                isUnlock = true
                break
            end
        end
        return isUnlock
    end

    table.sort(showList,function ( a,b )
        -- body

        local isUnLock1 = getCheckLock(a)
        local isUnLock2 = getCheckLock(b)
        if isUnLock2 == isUnLock1 then
            return a < b
        else
            return isUnLock1
        end
    end)
    return showList
end

function AmusementPackControl:getAllShowEffectList( ... )
    -- body
    local showList = {}
    local effects = TabDataMgr:getData("CityRoleModelEffect")
    for k,v in pairs(effects) do
        table.insert(showList,v.id)
    end
    
    table.sort(showList,function ( a,b )
        -- body 
        local isUnLock1 = GoodsDataMgr:getItem(a) and true
        local isUnLock2 = GoodsDataMgr:getItem(b) and true
        if isUnLock2 == isUnLock1 then
            return a < b
        else
            return isUnLock1
        end
    end)
    return showList
end

function AmusementPackControl:playActionButton( actionButtonId, actorPid, triggerPid  )
    -- body
    self:triggerNpcFunc({interActionId = actionButtonId, actorPid = actorPid, triggerPid = triggerPid},true)
end

function AmusementPackControl:operateAction( operateData )
    -- body
    if not operateData then return end
    if operateData.actions then
        for k,v in ipairs(operateData.actions) do
            WorldRoomDataMgr:getCurExtDataControl():parseActionCfg(v.actionId, v.pid)
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


--根据返回同步位置
function AmusementPackControl:syncHeroPos(playerInfo)
    -- if playerInfo.pid ~= MainPlayer:getPlayerId() then
    self.super.syncHeroPos(self,playerInfo)
    local actorData = self.actorDataQueue:objectByID(playerInfo.pid)
    if actorData then 
        actorData.buildId = playerInfo.buildId
        self:deriveData()
    end
    
end

function AmusementPackControl:changeMainHeroToBornPos( index )
    -- body
    index = math.min(index,#self.bornPos)
    local  pos = self.bornPos[index]
    self:operateChangePos(ccp(pos[1],pos[2]))
end

function AmusementPackControl:updateActorHideNode()
    -- body
    for hero in self:getHeroList():iterator() do
        hero:updateHideNode()
    end

    for npc in self:getNPCList():iterator() do
        npc:updateHideNode()
    end
end

function AmusementPackControl:operateChangeSkin( skinId )
    -- body
    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.CHANGE_SKIN,{skinId = skinId })
end

function AmusementPackControl:operateChangeEffect( effectId )
    -- body
    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.CHANGE_EFFECT,{effectId = effectId })
end

function AmusementPackControl:operateEnterBuild( actorPid )
    -- body
    local actorData = self:getActorDataByPid(actorPid)
    if not actorData then return end

    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.ACTION_BUILD, {pid = actorPid, decorateId = actorData.decorateId, type = 1})
end

function AmusementPackControl:operateLeaveBuild( actorPid )
    -- body
    local actorData = self:getActorDataByPid(actorPid)
    if not actorData then return end

    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.ACTION_BUILD, {pid = actorPid, decorateId = actorData.decorateId, type = 2 })
end

function AmusementPackControl:operateOpenGift( actorPid )
    -- body
    local actorData = self:getActorDataByPid(actorPid)
    if not actorData then return end

    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.ACTION_BUILD, {pid = actorPid, decorateId = actorData.decorateId})
end

function AmusementPackControl:operatePlayAction( actionId )
    -- body
    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.PLAY_ACTION, {actionId = actionId })
end

function AmusementPackControl:operateChangePos( pos )
    -- body
    if self:mainHeroIsInBuilding() then
        -- local mainHero = self:getMainHero()
        -- local mainActorData = self:getActorDataByPid(mainHero:getPid())
        -- if mainActorData.buildId then
        --     self:operateLeaveBuild(mainActorData.buildId)
        -- end
        Utils:showTips(13202010)
        return
    end
    WorldRoomDataMgr:worldRoomOperateByType(WorldRoomOperateType.CHANGE_POS, {auto = {lx = math.floor(pos.x), ly = math.floor(pos.y)}})
    
end

function AmusementPackControl:changeCameraFixZ( fixZ )
    -- body
    fixZ = fixZ or 150
    if self:getBaseMap() and fixZ then
        self:getBaseMap().camera:setFixZ(fixZ)
    end
end

function AmusementPackControl:setFocusNode( actorPid )
    -- body
    local actorNode = self:getActorNodeByPid(actorPid)
    if self:getBaseMap() and actorNode then
        self:getBaseMap().camera:setFocusNode(actorNode)
    end
end

return AmusementPackControl