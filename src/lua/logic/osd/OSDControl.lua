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
* 同屏管理器
* 
]]

local OSDResUtils = import(".OSDResUtils")
local OSDEnum = import(".OSDEnum")
local HeroType = OSDEnum.HeroType
local FuncType = OSDEnum.FuncType
local OSDConfig= import(".OSDConfig")
local OSDControl = class("OSDControl")

function OSDControl:ctor()
	
end

function OSDControl:initData()
	--地图信息
	self.mapInfo = nil

	--主角
	self.mainHero = nil
	
	--等待添加到舞台上的角色信息
	if not self.heroDataQueue then
		self.heroDataQueue = MEMapArray:new()
	end
	self.heroDataQueue:clear()

	--同屏玩家角色列表
	if not self.heroList then
		self.heroList = MEMapArray:new()
	end
	self.heroList:clear()

	--npc列表
	if not self.npcList then
		self.npcList = MEMapArray:new()
	end
	self.npcList:clear()

	--触发的NPC ID
	self.triggerNpcId = 0

	--界面对象
	self.baseView = nil
	self.baseMap = nil
end

function OSDControl:clear()
	self:initData()
end

function OSDControl:registerEvents()
	-- EventMgr:addEventListener(self, EV_OSD.EV_CLICK_HERO_EVENT, handler(self.onClickHero, self))
end

function OSDControl:removeEvents()
	EventMgr:removeEventListenerByTarget(self)
end

function OSDControl:enterOSD(heroList)
	self:initData()
	self:registerEvents()
	--清楚临时数据避免loading 条显示错误
    BattleDataMgr:clearTempData()
	OSDResUtils:loadAllRes(self:getMapInfo(), heroList, function()
     --    TFAudio.stopAllEffects()
    	-- TFAudio.stopMusic()
    	-- SafeAudioExchangePlay().stopAllBgm()
     --    TFAudio.playMusic(OSDConfig.BGM, true)
        --播放大世界背景音乐
        AlertManager:changeScene(SceneType.OSD)
    end)
end

function OSDControl:exitOSD()
	self:clear()
	self:removeEvents()
	OSDResUtils:clean()
end

function OSDControl:setView(view)
	self.baseView = view
end

function OSDControl:setMap(map)
	self.baseMap = map
end


function OSDControl:updateData(data,newData)
	for k ,v in pairs(newData) do
		data[k] = v
	end
end

--[[-
	加入数据队列，用于创建同屏玩家
	isServerData: 是否为服务器数据
-]]
function OSDControl:addHeroData(heroData)
	local tmpData = self.heroDataQueue:objectByID(heroData.pid)
	if not tmpData then
		-- dump(heroData)
		-- print("addHeroData")
		self.heroDataQueue:pushbyid(heroData.pid, heroData)
	else
		dump(heroData)
		-- print("updateData")
		self:updateData(tmpData , heroData) --更新数据
	end
end

--更新同屏玩家数据
function OSDControl:updateHeroData(heroData)
	local hero = self:getHeroByPid(heroData.pid)
	if hero then
		hero:updateData(heroData)
	else
		self:addHeroData(heroData, true)
	end
end
	-- {
 --       ├┄┄skinCid=1103011,
 --       ├┄┄heroCid=110301,
 --       ├┄┄pid=539556324
 --       ├┄┄}
local function _changeSkinData(data , newData)
	if data then
		data.skinCid      = newData.skinCid
		data.id           = newData.heroCid
		local skinData    = TabDataMgr:getData("HeroSkin", data.skinCid)
	    local formData    = TabDataMgr:getData("HeroForm", skinData.beginForm)
	    data.actionIndex  = formData.actionIndex
		data.model        = formData.model
		data.scale        = 0.6 * formData.modelSize
	end
end


function OSDControl:changeSkin(newData)
	local hero = self:getHeroByPid(newData.pid)
	if hero then
		local data = hero:getData()
		_changeSkinData(data,newData)
		hero:changeSkin()
		return 
	end
	data = self.heroDataQueue:objectByID(newData.pid)
	_changeSkinData(data,newData)
end



function OSDControl:doFunc(funcType) 
	-- Utils:showTips("doFunc:"..tostring(funcType))   
	--暂时屏蔽不开启部分功能
	if funcType == FuncType.Task     then  --任务
		Utils:openView("common.FunctionTipsView", {270420}, nil, nil)
		--Utils:openView("osd.TaskLayer")
	elseif funcType == FuncType.WarStore  then  --商店
		FunctionDataMgr:jWarStore()
	elseif funcType == FuncType.LuckDraw then --抽奖
		Utils:openView("common.FunctionTipsView", {270420}, nil, nil)
		--Utils:openView("osd.LuckdrawLayer")
	elseif funcType == FuncType.Bounty   then --悬赏
		OSDDataMgr:sendEnterHuntingInvitation()
	elseif funcType == FuncType.FUN_BEN  then  --副本
		Utils:openView("common.FunctionTipsView", {270420}, nil, nil)
		--Utils:openView("osd.OSDLevelEntranceView")
	elseif funcType == FuncType.Seq_War then --序列战争
		FunctionDataMgr:jSkyLadder()
	end

end
function OSDControl:doFocusFunc() 
	local hero = self:getFocus()
	if hero then
		self:doFunc(hero:getFuncType())
	else
		print("Npc 不存在")
	end
end


--
function OSDControl:setFocus(npc)
	local temp = self.focusHero
    self.focusHero = npc 
    
    if temp ~= self.focusHero then
    	EventMgr:dispatchEvent(EV_OSD.FOCUS_CHANGE)
	end
end

function OSDControl:getFocus()   
    return self.focusHero
end
--获取自己
function OSDControl:getMainHero()
	return self.mainHero
end

-- function OSDControl:sortHeroData(aData, bData)
-- 	if aData.isFriend then
-- 		if bData.isFriend then
-- 			return aData.pid > bData.pid
-- 		else
-- 			return false
-- 		end
-- 	else
-- 		if bData.isFriend then
-- 			return false
-- 		else
-- 			return aData.pid > bData.pid
-- 		end
-- 	end
-- end

--切线清除当前屏幕显示玩家
function OSDControl:clearOtherPlayers()
    local tmpRemoveArr = {}
    for hero in self:getHeroList():iterator() do
        if not hero:isMainHero() then
            tmpRemoveArr[#tmpRemoveArr + 1] = hero:getPid()
        end
    end

    for k, v in ipairs(tmpRemoveArr) do
        self:removeHero(v)
    end
end


--获取需要加入同屏的角色信息
function OSDControl:getNewHeroData()
	if self.heroDataQueue:length() <= 0 then return nil end

	local heroData = self.heroDataQueue:front()
	self.heroDataQueue:removeById(heroData.pid)

	--已在同屏角色中
	if self.heroList:objectByID(heroData.pid) then
		return nil
	end

	return heroData
end

function OSDControl:clearHeroQueue()
	if not self.heroDataQueue then
		self.heroDataQueue = MEMapArray:new()
	end
	self.heroDataQueue:clear()
end

function OSDControl:addHero(hero)
	local pid = hero:getPid()
	local tmpHero = self.heroList:objectByID(pid)
	if tmpHero then
		print("fuck hero, the map has wrong hero")
		tmpHero:removeHero()
		self.heroList:removeById(pid)
	end
	self.heroList:pushbyid(pid, hero)

	if hero:isMainHero() then
		self.mainHero = hero
	end
end

function OSDControl:sortHero(aHero, bHero)
	local aData = aHero:getData()
	local bData = bHero:getData()
	return aData.pid > bData.pid
end

function OSDControl:getHeroByPid(pid)
	if not self.heroList then return nil end

	return self.heroList:objectByID(pid)
end

--[[-
	pid
	keeyData: 是否保留数据
-]]
function OSDControl:removeHero(pid, keeyData)
	if not keeyData and self.heroDataQueue:objectByID(pid) then
		self.heroDataQueue:removeById(pid)
	end

	local hero = self.heroList:objectByID(pid)
	if hero then
		self.heroList:removeById(pid)
		hero:removeHero()
	end
end

function OSDControl:addNPC(npc)
	local pid = npc:getPid()
	local tmpNpc = self.npcList:objectByID(pid)
	if tmpNpc then
		print("fuck npc, the map has wrong npc")
		self.npcList:removeById(pid)
		tmpNpc:removeHero()
	end
	self.npcList:pushbyid(pid, npc)
end

function OSDControl:removeNPC(pid)
	local tmpNpc = self.npcList:objectByID(pid)
	if tmpNpc then
		self.npcList:removeById(pid)
		tmpNpc:removeHero()
	end
end

--根据返回同步位置
function OSDControl:syncHeroPos(playerInfo)
	if playerInfo.pid ~= MainPlayer:getPlayerId() then
		local hero = self:getHeroByPid(playerInfo.pid)
		if hero then
			local pos = playerInfo.pos
			hero:moveTo(ccp(pos.x , pos.y))
			return 
		end
		--更新数据
		local heroData = self.heroDataQueue:objectByID(playerInfo.pid)
		if heroData then 
			local pos = playerInfo.pos
			heroData.pos.x = pos.x
			heroData.pos.y = pos.y
			-- print("不显示的玩家位置更新：",heroData.pos)
		end
	end
	
end

function OSDControl:getMapInfo()
	-- return self.mapInfo
	return "tongpinceshi001"
end

function OSDControl:getMainHero()
	return self.mainHero
end

function OSDControl:getHeroList()
	return self.heroList
end

--获取除去主角的其他玩家列表
function OSDControl:getSortHeroList()
	local tmpHeroList = MEMapArray:new()
	for hero in self.heroList:iterator() do
        if not hero:isMainHero() then
        	tmpHeroList:pushbyid(hero:getPid(), hero)
        end
    end
	tmpHeroList:sort(handler(self.sortHero, self))
	return tmpHeroList
end

function OSDControl:getNPCList()
	return self.npcList
end

-- function OSDControl:getTriggerNpcId()
-- 	return self.triggerNpcId
-- end

-- --触发功能id
-- function OSDControl:setTriggerNpcId(value)
-- 	if self.triggerNpcId == value then return end
-- 	self.triggerNpcId = value
-- end

-- function OSDControl:onClickHero(pid)
-- 	if self.triggerNpcId ~= pid then return end
-- 	local npcCfg = OSDDataMgr:getNpcCfg(pid)
-- 	if not npcCfg then
-- 		return 
-- 	end
-- 	-- NPC 交互响应
-- 	-- FunctionDataMgr:enterByFuncId(npcCfg.functionid)
-- end


-- function OSDControl:createHeroNode(data)
--     self.nodeList = self.nodeList or {}
--     for i, node in ipairs(self.nodeList) do
--         if node:retainCount() == 1 then 
--         	node:updateData(data)
--             return node
--         end
--     end
--     local BaseHero = require("lua.logic.osd.BaseHero")
--     local hero = BaseHero:new(data)
--     hero:retain()
--     self.nodeList[#self.nodeList + 1] = hero
-- end

-- --清理所有缓存节点
-- function OSDControl:cleanCache()
--     if self.nodeList then 
--         for i, node in ipairs(self.nodeList) do
--             node:release()
--         end
--     end
--     self.nodeList = nil
-- end


OSDControl:initData()
return OSDControl
