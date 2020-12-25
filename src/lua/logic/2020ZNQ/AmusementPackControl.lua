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
local AmusementPackActor = import(".AmusementPackActor")
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

	local actor = AmusementPackActor:new(actorData)
	if isHero then	
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

function AmusementPackControl:checkCondition( cond )
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
		end
	end
	return isFix
end

function AmusementPackControl:getNpcCfg( cfgID )
	-- body
	local tabs = TabDataMgr:getData("WorldObjectMgr")

	for k,v in pairs(tabs) do
		if v.editorPrefabId == cfgID then
			if self:checkCondition(v.creatCond) then
				local resCfg = TabDataMgr:getData("WorldObjectResource",v.resourceId)
				return v,resCfg
			end
		end
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
    for k,v in ipairs(self.focusNpcs) do
        local npcData = self:getActorDataByPid(v)
        local npcCfg = TabDataMgr:getData("WorldObjectMgr", npcData.decorateId)
        for _k,_v in ipairs(npcCfg.actionButtonId) do
            table.insert(interAction,{interActionId = _v, actorPid = npcData.pid})
        end
    end

    for k,v in ipairs(self.focusHeros) do
        local heroActionButtonIds = self.playerInterActions
        for _k,_v in ipairs(heroActionButtonIds) do
            table.insert(interAction,{interActionId = _v, actorPid = v})
        end
    end
    return interAction
end

function AmusementPackControl:triggerNpcFunc( actionData )
    -- body
    local actionCfg = TabDataMgr:getData("WorldActionButton",actionData.interActionId)

    function callBack( ... )
        if self.actorDataQueue:length() == 0 then return end
        local interActionType = actionCfg.interType
        if interActionType == 1 then -- 打开对应功能
            FunctionDataMgr:enterByFuncId(actionCfg.interTypeParma.jumpInterface,unpack(actionCfg.interTypeParma.parameter))
        elseif interActionType == 2 then -- 通知服务器交互建筑
            self:operateEnterBuild(actionData.actorPid)
        elseif interActionType == 3 then -- 通知打开礼物盒
            self:operateOpenGift(actionData.actorPid)
        elseif interActionType == 4 then -- 离开
            self:operateLeaveBuild(actionData.actorPid)
        elseif interActionType == 5 then -- 建筑上播放表情
            self:operatePlayAction(actionCfg.interTypeParma.actionId)
        end
    end

    if actionData.actorPid then -- 统一播对象交互逻辑
        local actor = self:getActorNodeByPid(actionData.actorPid)
        local actorData = self:getActorDataByPid(actionData.actorPid)
        if actorData.decorateId then
            local npcCfg = TabDataMgr:getData("WorldObjectMgr", actorData.decorateId)
            actor:actionByCfgId(npcCfg.objectAni_inter, nil ,callBack)
        else
            callBack()
        end
    else
        callBack()
    end
    
end

function AmusementPackControl:mainHeroIsInBuilding( ... )
    -- body
    return self:getMainHero().inBuilding
end

function AmusementPackControl:getMainHeroIsInBuildingInterActionList( ... )
    -- body
    local mainActor = self:getActorDataByPid(self:getMainHero():getPid())
    if not mainActor.buildId then return nil end
    local buildActor = self:getActorDataByPid(mainActor.buildId)
    local npcCfg = TabDataMgr:getData("WorldObjectMgr", buildActor.decorateId)
    local interAction = {}
    for k,v in ipairs(npcCfg.ableActionOnBuild) do        table.insert(interAction,{interActionId = v, actorPid = buildActor.pid})
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

function AmusementPackControl:operateAction( operateData )
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


return AmusementPackControl