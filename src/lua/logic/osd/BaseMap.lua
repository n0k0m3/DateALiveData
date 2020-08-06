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
* 地图
* 
]]
local OSDEnum    = import(".OSDEnum")
local StateEvent = OSDEnum.StateEvent
local HeroState  = OSDEnum.HeroState
local HeroType   = OSDEnum.HeroType
local MapLayerType = OSDEnum.MapLayerType
local enum = require("lua.logic.battle.enum")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local eCameraFlag = enum.eCameraFlag

local MapUtils = import(".MapUtils")
local OSDControl = import(".OSDControl")
local BaseHero = import(".BaseHero")
local OSDConfig = import(".OSDConfig")

local BaseMap = class("BaseMap", function(...)
    return CCNode:create()
end)

function BaseMap:ctor()
	self.nCount = 0
	self.nSortCount = 0
	--所有添加到地图上的元素
    self.sortChilds = {}

    self:buildMap()
end

function BaseMap:buildMap()
    local mapInfo = OSDControl:getMapInfo()
	self.mapParse = MapUtils:getMapParse()
	self.mapParse:loadJson(mapInfo)
	self.mapParse:parse()

	self.mapNode = self.mapParse:getMapNode()
	self.mapNode:setCameraMask(eCameraFlag.CF_MAP)
	self:addChild(self.mapNode)

	--角色上层
	self.rolePanel = self.mapParse:getMapLayer(MapLayerType.Role)
	--boss下层
	self.bossPanel = self.mapParse:getMapLayer(MapLayerType.Boss)

	--创建三层
    self.layer1 = CCNode:create()
    self.layer2 = CCNode:create()
    self.layer3 = CCNode:create()
    self.rolePanel:addChild(self.layer1)
    self.rolePanel:addChild(self.layer2)
    self.rolePanel:addChild(self.layer3)

    self.rolePanel:setCameraMask(eCameraFlag.CF_MAP)
end

function BaseMap:addObject(child,index)
    index = index or 2
    if index < 1 then --地表层下面
        self:addObject0(child)
    elseif index == 1 then
        self:addObject1(child)
    elseif index == 2 then
        self:addObject2(child)
    elseif index == 3 then
        self:addObject3(child)
    end
end

function BaseMap:addObject0(child)
    child:setCameraMask(self.bossPanel:getCameraMask())
    self.bossPanel:addChild(child)
end

function BaseMap:addObject1(child)
    child:setCameraMask(self.layer1:getCameraMask())
    self.layer1:addChild(child)
end

function BaseMap:addObject2(child)
    self.layer2:addChild(child)
    child:setCameraMask(self.layer2:getCameraMask())
    --添加到管理器
    if not child.getSortY then
        child.getSortY = child.getPositionY
    end
    self.nSortCount = self.nSortCount + 1
    child._sortIndex = self.nSortCount
    table.insert(self.sortChilds, child)
    child:addMEListener(TFWIDGET_CLEANUP, function (...)
        table.removeItem(self.sortChilds, child)
    end)
end

function BaseMap:addObject3(child)
    child:setCameraMask(self.layer3:getCameraMask())
    self.layer3:addChild(child)
end

function BaseMap:update(dt)
    self:updateRoles(dt)

	--10帧更新一次
	if self.nCount < 10 then
        self.nCount = self.nCount + 1
    else
        self.nCount = 0
        self:handlOcclusion()
        self:updateRoleToScene(dt)
    end

    local rect = self.mapParse:getMoveRect()
    local height = rect.size.height
    local posY = rect.origin.y
    for index, child in ipairs(self.sortChilds) do
        local sortY = child:getSortY()
        if sortY ~= child._sortY then --在位置没有改变的情况下避免每贞去更新zOrder 和 scale
            child._sortY = sortY
            if sortY == 0 then   -- 0 和 640 特殊处理分别在嘴上层和最下层
                child:setZOrder(math.floor(height) + 1)
                child:setScale(1)
                -- print("scale:1")
            elseif sortY == 640 then
                child:setZOrder(-1)
                child:setScale(BattleConfig.MMO_MODAL_SCALE)
                -- print("scale:0.9")
            else
                local offset = sortY - posY
                local zorder = math.floor(height - offset)
                local scale  = 1 - offset / height * (1- BattleConfig.MMO_MODAL_SCALE)
                child:setZOrder(zorder)
                child:setScale(scale)
                -- print("scale:"..scale)
            end
        end
    end
end

function BaseMap:updateRoles(dt)
    for hero in OSDControl:getHeroList():iterator() do
        hero:update(dt)
    end

    for npc in OSDControl:getNPCList():iterator() do
        npc:update(dt)
    end

    self:checkIsTriggerNpcFuc()
end

--判断是否触发npc功能
function BaseMap:checkIsTriggerNpcFuc()
    local mainHero = OSDControl:getMainHero()
    if not mainHero then return end
    local focus 
    for npc in OSDControl:getNPCList():iterator() do
        local rect = npc:getNpcRect()
        local pos  = mainHero:getPosition3D()
        if me.rectContainsPoint(rect, pos) then
            focus = npc
            break
        end
    end
    OSDControl:setFocus(focus)
end

--根据是否还有角色数据缓存，添加角色到同屏
function BaseMap:updateRoleToScene(dt)
    -- print("updateRoleToScene"..OSDControl:getHeroList():length().." fuck:"..tostring(OSDConfig.SHOW_OTHER_PLAYER_NUM))
    --设置不显示同屏玩家 OR 玩家数量超过最大显示数量
    if OSDControl:getHeroList():length() >= OSDConfig.SHOW_OTHER_PLAYER_NUM then 
        return
    end

    local newData = OSDControl:getNewHeroData()
    if not newData then return end

    local newHero = BaseHero:new(newData)
    self:addHero(newHero)
end

-- --切线清除当前屏幕显示玩家
-- function BaseMap:clearOtherPlayers()
--     local tmpRemoveArr = {}
--     for hero in OSDControl:getHeroList():iterator() do
--         if not hero:isMainHero() then
--             tmpRemoveArr[#tmpRemoveArr + 1] = hero:getPid()
--         end
--     end

--     for k, v in ipairs(tmpRemoveArr) do
--         OSDControl:removeHero(v)
--     end
-- end

--重置主角位置
function BaseMap:resetMainHeroPos()
    if not self.mainHero then return end
    local bornPos = MapUtils:getMapParse():getBornPos(1)
    self.mainHero:setPosition3D(bornPos.x, bornPos.y, bornPos.y)
end


--改变同屏显示数量
function BaseMap:changeShowPlayersNum()
    local curNum = OSDControl:getHeroList():length()
    if curNum > OSDConfig.SHOW_OTHER_PLAYER_NUM then
        local tmpNum = curNum - OSDConfig.SHOW_OTHER_PLAYER_NUM
        local heroList = OSDControl:getSortHeroList()
        if tmpNum > heroList:length() then
            tmpNum = heroList:length()
        end
        local hero = nil
        for i = 1, tmpNum do
            hero = heroList:popBack()
            if hero then
                OSDControl:addHeroData(hero:getData(), false)
                OSDControl:removeHero(hero:getPid(), true)
            end
        end
    end
end

--初始化地图的元素(主角、NPC)
function BaseMap:initMapElement()
    self:addMainHero()

    --添加NPC
    local npcList = self.mapParse:getNpcList()
    for k, v in ipairs(npcList) do
        local npcId = tonumber(v.CfgID)
        local pos = me.p(v.Position.X, v.Position.Y)
        local npcData = OSDDataMgr:getNpcCfg(npcId)
        npcData = OSDDataMgr:transData(npcData,HeroType.NPC)
        npcData.pos =  me.p(v.Position.X, v.Position.Y)
        local npc = BaseHero:new(npcData)
        self:addNPC(npc)
    end
end

--加入同屏主角
function BaseMap:addMainHero()
    local heroData = {}
    heroData.pid     = MainPlayer:getPlayerId()
    heroData.pname    = MainPlayer:getPlayerName()
    heroData.level   = MainPlayer:getPlayerLv()
    heroData.heroCid = MainPlayer:getAssistId()
    heroData.skinCid = HeroDataMgr:getCurSkin(MainPlayer:getAssistId())
    local unionData  = LeagueDataMgr:getMyUnionInfo()
    if unionData then 
        heroData.unionName = unionData.name or ""
    else
        heroData.unionName = ""
    end
    heroData.titleId     = TitleDataMgr:getEquipedTitleId() or 0
    heroData = OSDDataMgr:transData(heroData,HeroType.MainHero)
    heroData.pos  = MapUtils:getMapParse():randomBornPos()
    self.mainHero = BaseHero:new(heroData)
    self:addHero(self.mainHero)
end

function BaseMap:addHero(hero)
    hero:addTo(self)
    OSDControl:addHero(hero)
end

function BaseMap:addNPC(npc)
    npc:addTo(self)
    OSDControl:addNPC(npc)
end

-- --移动到任务NPC
-- function BaseMap:moveToTaskNpc(callback)
--     self:moveToNpcByFunc(1002, callback)
-- end

-- --移动到对应功能的npc
-- function BaseMap:moveToNpcByFunc(fucnctionId, callback)
--     local targetNpc = nil
--     for npc in OSDControl:getNPCList():iterator() do
--         local npcCfg = OSDDataMgr:getNpcCfg(npc:getData().pid)
--         if npcCfg.type == HeroType.NPC and npcCfg.functionid == fucnctionId then
--             targetNpc = npc
--             break
--         end
--     end

--     if not targetNpc then
--         Box("没有找到对应功能的NPC，functionid = " .. fucnctionId)
--         return
--     end

--     self:moveToNpc(targetNpc, callback)
-- end


--移动到npc位置
function BaseMap:moveToNpc(npc, callback)
    if not self.mainHero then return end

    local npcPos = npc:getPosition3D()
    local posX = npcPos.x + 30 - math.random(0, 60)
    local posY = npcPos.y + 30 - math.random(0, 60)
    self.mainHero:moveTo(ccp(posX, posY), callback)
end

--玩家聊天气泡
function BaseMap:heroTalk(chatInfo)
    --自己的聊天气泡
    if chatInfo.pid == MainPlayer:getPlayerId() then
        self.mainHero:playTalk(chatInfo.content)
        return 
    end
    --其他玩家的聊天气泡
    local hero = OSDControl:getHeroByPid(chatInfo.pid)
    if hero then 
        hero:playTalk(chatInfo.content)
    end
end

function BaseMap:handlOcclusion()
    --处理前景遮挡透明效果
    local isInRect = false
    for index, node in ipairs(self.mapParse:getOcclusionNodes()) do
        isInRect = false
        if self.mainHero and self.mainHero:isInsertRect(node.rect) then
            isInRect = true
        end

        if isInRect then
            MapUtils:fadeOut(node)
        else
            MapUtils:fadeIn(node)
        end
    end
end

function BaseMap:addTestNpc( ... )
    if not self.models then
        local heroDatas = TabDataMgr:getData("Hero")
        self.models = {}
        for k,heroData in pairs(heroDatas) do
            for _,skin in ipairs(heroData.optionalSkin) do
                local skinData    = TabDataMgr:getData("HeroSkin", skin)
                for _,form in ipairs(skinData.allForm) do
                    local formData    = TabDataMgr:getData("HeroForm", form)
                    local actorModel  = formData.model
                    -- actorModel = string.format("effect/%s/%s",actorModel,actorModel)
                    self.models[actorModel] = actorModel
                end
            end
        end
        self.models =   table.keys(self.models)
        self.allSize = #self.models
    end


    local posY = {150,230,320 }
    if #self.models > 0 then 
        local index = #self.models
        local actorModel = self.models[index] 
            print("xxxxxxxxxxindex:"..tostring(index).."::"..tostring(actorModel))
        table.remove(self.models,index)
        index = self.allSize - index + 1
        local npcData = {}
        npcData.pid        = 0
        npcData.name       = "T"..index
        data.model         = actorModel
        data.modelSize     = 1
        npcData.initPos = ccp(130 + index*40 ,posY[(index-1)%3+1])
        npcData = OSDDataMgr:transData(npcData,HeroType.NPC)
        local npc = BaseHero:new(npcData)
        self:addNPC(npc)

        print("index:"..tostring(index).."::"..tostring(actorModel) .."--"..tostring(posY[index%2+1]))
    end



end

return BaseMap
