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
* 资源工具
* 
]]
local MapUtils = import(".MapUtils")
local ResLoader = require("lua.logic.battle.ResLoader")
local enum = require("lua.logic.battle.enum")
local eResType  =  enum.eResType
local eEffectType = enum.eEffectType

local OSDResUtils = OSDResUtils or {}

--[[-
    --进入同屏场景需要预加载的资源列表
    mapInfo: 地图数据
    heroList: 进入同屏返回的角色列表
-]]
function OSDResUtils:getResList(mapInfo, heroList)
	local resList = {}

	--地图资源
	MapUtils:cleanMapParse()
	MapUtils:getMapParse():loadJson(mapInfo) --加载json
	local mapResList = MapUtils:getMapParse():getRespaths()
    for k, texture in pairs(mapResList.textures) do
        table.insert(resList, self:createResInfo(eResType.RT_IMAGE, texture))
    end
    for k, effecName in pairs(mapResList.effects) do
        table.insert(resList, self:createResInfo(eResType.RT_IMAGE, effecName .. ".png"))
        table.insert(resList, self:createResInfo(eResType.RT_SPINE, effecName))
    end

    --npc资源
    local npcList = MapUtils:getMapParse():getNpcResList()
    local resPath = ""
    for k, v in pairs(npcList) do
        local npcCfg = OSDDataMgr:getNpcCfg(tonumber(v.CfgID))
        if npcCfg then
            resPath = string.format("effect/%s/%s", npcCfg.model, npcCfg.model)
            table.insert(resList, self:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
            table.insert(resList, self:createResInfo(eResType.RT_SPINE, resPath))
        end
    end

    --角色资源
    --主角
    local tmpSkinList = {}
    local mainSkin = HeroDataMgr:getCurSkin(MainPlayer:getAssistId())
    tmpSkinList[#tmpSkinList + 1] = mainSkin
    for k, v in ipairs(heroList or {}) do
        tmpSkinList[#tmpSkinList + 1] = v.portraitCid
    end

    for k, v in ipairs(tmpSkinList) do
        local skinCfg = TabDataMgr:getData("HeroSkin", v)
        if skinCfg then
            local formData    = TabDataMgr:getData("HeroForm", skinCfg.beginForm)
            local actorModel  = formData.model
            resPath = string.format("effect/%s/%s", actorModel, actorModel)
            table.insert(resList, self:createResInfo(eResType.RT_IMAGE, resPath .. ".png"))
            table.insert(resList, self:createResInfo(eResType.RT_SPINE, resPath))
        end
    end

  --加载所有角色的模型
    -- local heroDatas = TabDataMgr:getData("Hero")
    -- for k,heroData in pairs(heroDatas) do
    --     local skinData    = TabDataMgr:getData("HeroSkin", heroData.defaultSkin)
    --     local formData    = TabDataMgr:getData("HeroForm", skinData.beginForm)
    --     local actorModel  = formData.model
    --     actorModel = string.format("effect/%s/%s",actorModel,actorModel)
    --     table.insert(resList,self:createResInfo(eResType.RT_IMAGE,actorModel..".png"))
    --     table.insert(resList,self:createResInfo(eResType.RT_SPINE,actorModel))
    -- end

    --UI资源
    local mapView = require("lua.uiconfig.osd.MapLayer")
    for k, texture in pairs(mapView.respaths.textures) do
        table.insert(resList, self:createResInfo(eResType.RT_IMAGE, texture))
    end

    table.sort(resList, function(a, b)
        return a.resType > b.resType
    end)
    dump(resList)
    return resList
end

function OSDResUtils:createResInfo(resType, resName)
    return {resType = resType, resName = resName}
end

function OSDResUtils:loadAllRes(mapInfo, heroList, callFunc)
	AlertManager:changeScene(SceneType.Load)
    ResLoader.stopTimer()
    ResLoader.timer = TFDirector:addTimer(100, 1, nil, function ()
        ResLoader.stopTimer()
        local resList = self:getResList(mapInfo, heroList)
        ResLoader.startLoad(resList, callFunc)
    end) 
end

function OSDResUtils:clean()
	MapUtils:cleanMapParse()
	ResLoader.clean()
end




function OSDResUtils:getObject()
    self.nodeList = self.nodeList or {}
    for i, node in ipairs(self.nodeList) do
        if node:retainCount() == 1 then 
            return node
        end
    end
    local BaseHero = require("lua.logic.osd.BaseHero")
    local hero = BaseHero:new()
    hero:retain()
    self.nodeList[#self.nodeList + 1] = hero
end


function OSDResUtils:cleanCache()
    if self.nodeList then 
        for i, node in ipairs(self.nodeList) do
            node:release()
        end
    end
    self.nodeList = nil
end







return OSDResUtils
