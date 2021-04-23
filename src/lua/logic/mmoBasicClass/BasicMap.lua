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
local OSDEnum    = require("lua.logic.osd.OSDEnum")
local StateEvent = OSDEnum.StateEvent
local HeroState  = OSDEnum.HeroState
local HeroType   = OSDEnum.HeroType
local MapLayerType = OSDEnum.MapLayerType
local enum = require("lua.logic.battle.enum")
local BaseCamera = import("lua.logic.osd.BaseCamera")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local eCameraFlag = enum.eCameraFlag

local MapUtils = require("lua.logic.osd.MapUtils")
local BasicActor = import(".BasicActor")
local OSDConfig = require("lua.logic.osd.OSDConfig")

local BasicMap = class("BasicMap", function(...)
    return CCNode:create()
end)

function BasicMap:ctor(control)
	self.nCount = 0
	self.nSortCount = 0
	--所有添加到地图上的元素
    self.sortChilds = {}
    self.control = control or require("lua.logic.mmoBasicClass.BasicControl"):new()
    self:buildMap()
end

function BasicMap:buildMap()
    local mapInfo = self.control:getMapInfo()
	self.mapParse = MapUtils:getMapParse()
	self.mapParse:loadJson(mapInfo)
	self.mapParse:parse()

	self.mapNode = self.mapParse:getMapNode()
	self.mapNode:setCameraMask(eCameraFlag.CF_MAP)
	self:addChild(self.mapNode)
    --角色上层
    self.rolePanel = self.mapParse:getMapLayer(MapLayerType.Role)
    self.rolePanel:setOpacity(255)
    --boss下层
    self.bossPanel = self.mapParse:getMapLayer(MapLayerType.Boss)

	self:createLayers()
    self.rolePanel:setCameraMask(eCameraFlag.CF_MAP)
    local bornPos = MapUtils:getMapParse():getBornPos(1)
    self.camera = BaseCamera:new(bornPos)
    self.camera:setFixZ(self.control.cameraFixZ or 150)
    self.camera:setSlowMoveDel(self.control.nSlowDel or 0.001)
    self.camera:init()
    self.control:setMap(self)
    self:initMapElement()

    local mainHero = self.control:getMainHero()
    self.mainHero = mainHero
    -- self:resetMainHeroPos()
    self.camera:setFocusNode(mainHero)
end

function BasicMap:createLayers(  )

	--创建三层
    self.layer1 = CCNode:create()
    self.layer2 = CCNode:create()
    self.layer3 = CCNode:create()
    self.rolePanel:addChild(self.layer1)
    self.rolePanel:addChild(self.layer2)
    self.rolePanel:addChild(self.layer3)

end

function BasicMap:addObject(child,index)
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

function BasicMap:addObject0(child)
    child:setCameraMask(self.bossPanel:getCameraMask())
    self.bossPanel:addChild(child)
end

function BasicMap:addObject1(child)
    child:setCameraMask(self.layer1:getCameraMask())
    self.layer1:addChild(child)
end

function BasicMap:addObject2(child)
    self.layer2:addChild(child)
    child:setCameraMask(self.layer2:getCameraMask())
    --添加到管理器
    if not child.getSortY then
        child.getSortY = child.getPositionY
    end
    self.nSortCount = self.nSortCount + 1
    child._sortIndex = self.nSortCount
    table.insert(self.sortChilds, child)
end

function BasicMap:addObject3(child)
    child:setCameraMask(self.layer3:getCameraMask())
    self.layer3:addChild(child)
end

function BasicMap:removeActor( actor )
    -- body
    local index = table.find(self.sortChilds,actor)
    if index ~= -1 then
        table.remove(self.sortChilds,index)
    end
end

function BasicMap:updateMapNpcList( ... )
    -- body
end

function BasicMap:update(dt)
    self.control:update(dt)

	--10帧更新一次
	if self.nCount < 10 then
        self.nCount = self.nCount + 1
    else
        self.nCount = 0
        self:updateMapNpcList()
        self:handlOcclusion()
    end

    local rect = self.mapParse:getMoveRect()
    local height = rect.size.height
    local posY = rect.origin.y
    for index, child in ipairs(self.sortChilds) do
        local sortY = child:getSortY()
        
        if sortY ~= child._sortY then --在位置没有改变的情况下避免每贞去更新zOrder 和 scale
            child._sortY = sortY
            if sortY == 0 then   -- 0 和 640 特殊处理分别在嘴上层和最下层
                if not child.inBuilding then 
                    child:setZOrder(math.floor(height) + 1)
                end
                child:setScale(1)
                -- print("scale:1")
            elseif sortY == self.mapParse:getSceneHeight() then
                if not child.inBuilding then 
                    child:setZOrder(-1)
                end
                child:setScale(BattleConfig.MMO_MODAL_SCALE)
                -- print("scale:0.9")
            else
                local offset = sortY - posY
                local zorder = math.floor(height - offset)

                local scale  = 1 - offset / height * (1- BattleConfig.MMO_MODAL_SCALE)

                if not child.inBuilding then 
                    child:setZOrder(zorder)
                end

                if child:getIsCameraScale() then
                    child:setScale(scale)
                end
                -- print("scale:"..scale)
            end
        end
    end

    self.control:lateUpdate(dt)
    self.camera:update(dt)
end

--重置主角位置
function BasicMap:resetToBornPos(actor,index)
    if not actor then return end
    index = index or 1
    local bornPos = MapUtils:getMapParse():getBornPos(index)

    if not bornPos then
        print("=========找不到======"..index.."==的出生点默认为第1个出生点")
        bornPos = MapUtils:getMapParse():getBornPos(1)
    end

    actor:setPosition3D(bornPos.x, bornPos.y, bornPos.y)
end

--重置主角位置
function BasicMap:getBornPos(index)
    index = index or 1
    local bornPos = MapUtils:getMapParse():getBornPos(index)

    if not bornPos then
        print("=========找不到======"..index.."==的出生点默认为第1个出生点")
        bornPos = MapUtils:getMapParse():getBornPos(1)
    end

    return bornPos
end

--改变同屏显示数量
function BasicMap:changeShowPlayersNum()
    local curNum = self.control:getHeroList():length()
    if curNum > OSDConfig.SHOW_OTHER_PLAYER_NUM then
        local tmpNum = curNum - OSDConfig.SHOW_OTHER_PLAYER_NUM
        local heroList = self.control:getSortHeroList()
        if tmpNum > heroList:length() then
            tmpNum = heroList:length()
        end
        local hero = nil
        for i = 1, tmpNum do
            hero = heroList:popBack()
            if hero then
                self.control:addHeroData(hero:getData(), false)
                self.control:removeHero(hero:getPid(), true)
            end
        end
    end
end

--初始化地图的元素(主角、NPC)
function BasicMap:initMapElement()
end

-- --移动到任务NPC
-- function BasicMap:moveToTaskNpc(callback)
--     self:moveToNpcByFunc(1002, callback)
-- end

-- --移动到对应功能的npc
-- function BasicMap:moveToNpcByFunc(fucnctionId, callback)
--     local targetNpc = nil
--     for npc in self.control:getNPCList():iterator() do
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
function BasicMap:moveToNpc(npc, callback)
    if not self.mainHero then return end

    local npcPos = npc:getPosition3D()
    local posX = npcPos.x + 30 - math.random(0, 60)
    local posY = npcPos.y + 30 - math.random(0, 60)
    self.mainHero:moveTo(ccp(posX, posY), callback)
end

function BasicMap:handlOcclusion()
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

function BasicMap:addTestNpc( ... )
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
        local npc = BasicActor:new(npcData)
        self:addNPC(npc)

        print("index:"..tostring(index).."::"..tostring(actorModel) .."--"..tostring(posY[index%2+1]))
    end



end

function BasicMap:checkInViewByPos( pos )
    -- body
    return true
end

return BasicMap
