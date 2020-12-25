local BaseDataMgr = import(".BaseDataMgr")
local CollectDataMgr = class("CollectDataMgr",BaseDataMgr)

function CollectDataMgr:init()
	TFDirector:addProto(s2c.ELEMENT_COLLECT_ADD_NEW_ELEMENT, self, self.onRecvNewCollect)
    TFDirector:addProto(s2c.ELEMENT_COLLECT_UPDATE_ELEMENT, self, self.onRecvUpdateCollect)
    TFDirector:addProto(s2c.ELEMENT_COLLECT_GET_ALL_ELEMENT, self, self.onRecvAllCollect)
    TFDirector:addProto(s2c.ELEMENT_COLLECT_RESP_ELEMENT_RANK, self, self.onRecvCollectRank)
    TFDirector:addProto(s2c.ELEMENT_COLLECT_RESP_ELEMENT_TYPE, self, self.onRecvCollectSetting)

    --相关收集项目配置
    --精灵、模型、皮肤、时装
    self.heroSkinCfg = TabDataMgr:getData("HeroSkin")
    self.heroDressCfg = TabDataMgr:getData("Dress")
    --质点
    self.equipCfg = TabDataMgr:getData("Equipment")
    self.equipSuitCfg = TabDataMgr:getData("EquipmentSuit")
    --CG
    self.cgCfg = {}
    local tmCgCfg = TabDataMgr:getData("Cg")
    for k,v in pairs(tmCgCfg) do
    	self.cgCfg[v.cgId] = v
    end
    self.activityCGCfg = {}
    local tmActivityCGCfg = TabDataMgr:getData("PokedexActivity")
    for k,v in pairs(tmActivityCGCfg) do
    	self.activityCGCfg[v.cgId] = v
    end
    self.itemCfg = TabDataMgr:getData("Item")
    --头像和相框
    self.portraitCfg = TabDataMgr:getData("Portrait")

    --信物
    self.tokenCfg = TabDataMgr:getData("NewEquip")
	self.tokenSuitCfg = TabDataMgr:getData("NewEquipSuit")

    --徽章
    self.medalCfg = TabDataMgr:getData("Medal")

    --约会
    self.datingProcessCfg = TabDataMgr:getData("DatingProcess")

    --BGM
    self.bgmCfg = TabDataMgr:getData("Sound")

	--场景
	self.sceneCfg = {}
	local tempSceneCfg = TabDataMgr:getData("MainSceneChange")
	for k,v in pairs(tempSceneCfg) do
		self.sceneCfg[v.id] = v
	end

    --图鉴配置
    self.collectCfg = TabDataMgr:getData("NewPokedex")
    self.collectPageCfg = TabDataMgr:getData("NewPokedexPage")
    self.collectFiltCfg = TabDataMgr:getData("NewPokedexType")
    self.collectorCfg = TabDataMgr:getData("NewPokedexTitle")

    --收集项
    self.collectSeriesCfg = {}
    self.collectSubTypeCfg = {}

    --图鉴页面结构
    self.collectShowSetting = {remote = {},pageinfo = {}}
    self.pageEnterData = {remote = {},pageinfo = {}}
    self.collectUICfg = {}
    for k,v in pairs(self.collectFiltCfg) do
    	if self.collectUICfg[v.type1] == nil then
    		self.collectUICfg[v.type1] = {}
    	end
    	if v.isOpen == true then
    		local tmFiltCfg = self.collectPageCfg[v.type2]
    		local tmTabCfg = {
    							title = tmFiltCfg.name,
    							icon = tmFiltCfg.icon,
    							quantity = tmFiltCfg.quantity,
    							bartype = tmFiltCfg.type2,
    							extCfg = tmFiltCfg,
    							order = v.sort,
    							filt = {list = {},default = v.default},
    						}
    		for s,t in ipairs(v.type3) do
    			local tmFiltBtnCfg = self.collectPageCfg[t]
    			tmTabCfg.filt.list[t] = {itemlist = {},title = tmFiltBtnCfg.name}
    		end
    		self.collectUICfg[v.type1][v.type2] = tmTabCfg
    	end
    end

    for k,v in pairs(self.collectCfg) do
    	if self.collectShowSetting.pageinfo[v.type1] == nil then
    		self.collectShowSetting.pageinfo[v.type1] = {showType = 3,innerType = {}}
    	end
    	if self.pageEnterData.pageinfo[v.type1] == nil then
    		self.pageEnterData.pageinfo[v.type1] = {showType = true,innerType = {}}
    	end
    	self.collectShowSetting.pageinfo[v.type1].innerType[v.subType] = 3
    	self.collectShowSetting.remote[v.subType] = 3
    	self.pageEnterData.pageinfo[v.type1].innerType[v.subType] = true
    	self.pageEnterData.remote[v.subType] = true
    	if v.isOpen == true then
    		self.collectSubTypeCfg[v.subType] = self.collectSubTypeCfg[v.subType] or {}
    		table.insert(self.collectSubTypeCfg[v.subType], v)

    		if self.collectSeriesCfg[v.type1] == nil then
    			self.collectSeriesCfg[v.type1] = {}
    		end
    		if self.collectSeriesCfg[v.type1][v.subType] == nil then
    			self.collectSeriesCfg[v.type1][v.subType] = {}
    		end
    		self.collectSeriesCfg[v.type1][v.subType][v.id] = true
    		if self.collectUICfg[v.type1] then
    			for p,q in ipairs(v.type2) do
    				if self.collectUICfg[v.type1][q] then
		    			local tmTabCfg = self.collectUICfg[v.type1][q]
		    			for s,t in ipairs(v.type3) do
		    				if tmTabCfg.filt.list[t] then
		    					table.insert(tmTabCfg.filt.list[t].itemlist,{id = v.id,collecttype = v.subType,order = v.sort,name = v.name1,extCfg = v})
	    					else
	    						Box("图鉴筛选配置错误:"..v.id)
	    					end
		    			end
		    		else
		    			Box("图鉴页签配置错误:"..v.id)
		    		end
    			end
	    	else
	    		Box("图鉴分页配置错误:"..v.id)
	    	end
    	end
    end
    self.collectRemoteData = {totalTrophy = 0,rank = 0,collect = {}}
    self.otherCollectData = {totalTrophy = 0,rank = 0,collect = {}}
    self.collectPagesRed = {}
    for k,v in pairs(EC_CollectType) do
    	self.collectRemoteData.collect[v] = {itemlist = {},trophy = 0}
    	self.otherCollectData.collect[v] = {itemlist = {},trophy = 0}
    	self.collectPagesRed[v] = false
    end
    self.collectShowData = {[1] = self.collectRemoteData,[2] = self.otherCollectData}
    self.curShowPlayerType = 1 --1:自己；2：别人
    self.curShowData = self.collectShowData[self.curShowPlayerType]

    self.curShowPlayer = {}
end

function CollectDataMgr:reset()
	
end

function CollectDataMgr:onLoginOut()
    self:reset()
end

function CollectDataMgr:onLogin()
    self:init()
    TFDirector:send(c2s.ELEMENT_COLLECT_GET_ALL_ELEMENT, {})
    TFDirector:send(c2s.ELEMENT_COLLECT_REQ_ELEMENT_RANK, {})
    TFDirector:send(c2s.ELEMENT_COLLECT_REQ_ELEMENT_TYPE, {})
    return {s2c.ELEMENT_COLLECT_GET_ALL_ELEMENT,s2c.ELEMENT_COLLECT_RESP_ELEMENT_RANK,s2c.ELEMENT_COLLECT_RESP_ELEMENT_TYPE}
end


function CollectDataMgr:updateRemoteCollect(collects,isNew)
	if collects == nil then
		return
	end
	for i,v in ipairs(collects) do
		self.collectRemoteData.collect[v.type].trophy = v.trophy
		if v.element then
			if isNew == true then
				self.collectPagesRed[v.type] = true
			end
			for s,t in ipairs(v.element) do
				self.collectRemoteData.collect[v.type].itemlist[t.cid] = {rewardStat = t.reward} --[[0不可领取  1可领取 2 已领取]]
			end
		end
	end
	EventMgr:dispatchEvent(EV_COLLECT_UPDATE_INFO)
end

function CollectDataMgr:updateOtherPlayerCollect(playerInfo)
	local collectData = playerInfo.element
	self.otherCollectData.totalTrophy = collectData.totleTrophy
	self.otherCollectData.rank = collectData.rank
	for i,v in ipairs(collectData.elments) do
		self.otherCollectData.collect[v.type].trophy = v.trophy
		self.pageEnterData.remote[v.type] = v.scan
		self.otherCollectData.collect[v.type].itemlist = {}
		if v.element then
			for s,t in ipairs(v.element) do
				self.otherCollectData.collect[v.type].itemlist[t.cid] = {rewardStat = t.reward} --[[0不可领取  1可领取 2 已领取]]
			end
		end
	end
	for k,v in pairs(self.pageEnterData.pageinfo) do
		local tmvalue = true
		for s,t in pairs(v.innerType) do
			local tmrv = self.pageEnterData.remote[s]
			if tmrv == false then
				tmvalue = tmrv
			end
		end
		v.showType = tmvalue
		for s,t in pairs(v.innerType) do
			v.innerType[s] = tmvalue
		end
	end
	EventMgr:dispatchEvent(EV_COLLECT_UPDATE_INFO)
end

function CollectDataMgr:onRecvNewCollect(event)
	if event.data then
		self.collectRemoteData.totalTrophy = event.data.totleTrophy
		self.collectRemoteData.rank = event.data.rank
		self:updateRemoteCollect(event.data.elments,true)
        FamilyDataMgr:showNewPokedexFamilyNode( event.data.elments )
	end
end

function CollectDataMgr:onRecvUpdateCollect(event)
	if event.data then
		self:updateRemoteCollect({event.data.elments})
		if event.data.rewardlist and #event.data.rewardlist > 0 then
	        Utils:showReward(event.data.rewardlist)
	    end
	end
end

function CollectDataMgr:onRecvAllCollect(event)
	if event.data then
		self.collectRemoteData.totalTrophy = event.data.totleTrophy
		self.collectRemoteData.rank = event.data.rank
		self:updateRemoteCollect(event.data.elments)
	end
end

function CollectDataMgr:onRecvCollectRank(event)
	if event.data then
		self.collectRemoteData.rank = event.data.rank
	end
end

function CollectDataMgr:onRecvCollectSetting(event)
	if event.data then
		for k,v in pairs(event.data.eTypes) do
			self.collectShowSetting.remote[v.elementType] = v.type
		end
		for k,v in pairs(self.collectShowSetting.pageinfo) do
			local tmvalue = 0
			for s,t in pairs(v.innerType) do
				local tmrv = self.collectShowSetting.remote[s]
				if tmrv > tmvalue then
					tmvalue = tmrv
				end
			end
			v.showType = tmvalue
			for s,t in pairs(v.innerType) do
				v.innerType[s] = tmvalue
			end
		end
	end
end
--------------------------------------------------
function CollectDataMgr:checkCollectRedPoint()
	local showRed = false
	repeat
		for k,v in pairs(self.collectPagesRed) do
			if v == true then
				showRed = true
				break
			end
		end

		if showRed then
			break;
		end
		
		local CfgList = TabDataMgr:getData("NewPokedexTask")	
		for k, v in pairs(CfgList) do
			if v.type == 1 then
				local taskInfo = TaskDataMgr:getTaskInfo(v.id)
				if taskInfo and taskInfo.status == EC_TaskStatus.GET then
					showRed = true
					break
				end
			end
		end

	until true;
		
	return showRed
end

function CollectDataMgr:isPageShowRed(pageType)
	if self.curShowPlayerType == 2 then
		return false
	end
	local showRed = false
	local pageSubTypes = self.collectSeriesCfg[pageType]  or {}
	for k,v in pairs(pageSubTypes) do
		if self.collectPagesRed[k] == true then
			showRed = true
			break
		end
	end
	return showRed
end

function CollectDataMgr:clearRedShow(pageType)
	if self.curShowPlayerType == 2 then
		return
	end
	local pageSubTypes = self.collectSeriesCfg[pageType]  or {}
	for k,v in pairs(pageSubTypes) do
		self.collectPagesRed[k] = false
	end
end

function CollectDataMgr:getCollectsProcessByPage(pageType)
	local pageSubTypes = self.collectSeriesCfg[pageType] or {}
	local collectCount = 0
	local showCount = 0
	local totalCount = 0
	local totalTrophy = 0
	for k,v in pairs(pageSubTypes) do
		totalCount = table.count(v) + totalCount
		local tmRemoteData = self.curShowData.collect[k]
		collectCount = table.count(tmRemoteData.itemlist) + collectCount
		totalTrophy = tmRemoteData.trophy + totalTrophy
		for s,t in pairs(tmRemoteData.itemlist) do
			if v[s] == true then
				showCount = showCount + 1
			end
		end
	end
	local percent = 0
	if totalCount > 0 then
		percent = math.floor(showCount/totalCount * 100)
	end
	if collectCount ~= showCount then
		local pageName = TextDataMgr:getText(EC_CollectSettingCfg[pageType].name) 
		print(string.format("%s图鉴数据异常:任务量:%d|收集量:%d",pageName,showCount,collectCount))
	end
	return {percent = percent,trophy = totalTrophy}
end

function CollectDataMgr:getRankInfo()
	local rankInfo = {trophy = 0,rank = 0}
	rankInfo.trophy = self.curShowData.totalTrophy or 0
	rankInfo.rank = self.curShowData.rank or 0
	return rankInfo
end

function CollectDataMgr:getCurCollectorTitle(totalTrophy)
	local tmCup = 0
	local tmTitleCfg = nil
	for k,v in pairs(self.collectorCfg) do
		if v.cup <= totalTrophy then
			if v.cup >= tmCup then
				tmCup = v.cup
				tmTitleCfg = v
			end
		end
	end
	return tmTitleCfg
end

function CollectDataMgr:isCollectItemExist(subType,cid)
	if self.curShowData.collect[subType] == nil then
		return false
	end
	local itemInfo = self.curShowData.collect[subType].itemlist[cid]
	if itemInfo == nil then
		return false
	end
	return true,itemInfo
end

function CollectDataMgr:getPageGroupCfg(groupId)
	return self.collectPageCfg[groupId]
end

function CollectDataMgr:getPageUICfg(pageType)
	return self.collectUICfg[pageType]
end

function CollectDataMgr:getSkinCfg(skinId)
	return self.heroSkinCfg[skinId]
end

function CollectDataMgr:getDressCfg(dressId)
	return self.heroDressCfg[dressId]
end

function CollectDataMgr:getMedalCfg(medalId)
	return self.medalCfg[medalId]
end

function CollectDataMgr:getPortraitCfg(portraitId)
	return self.portraitCfg[portraitId]
end

function CollectDataMgr:getBGMCfg(bgmId)
	return self.bgmCfg[bgmId]
end

function CollectDataMgr:getCommonCGCfg(cgId)
	return self.cgCfg[cgId]
end

function CollectDataMgr:getActivityCGCfg(cgId)
	return self.activityCGCfg[cgId]
end

function CollectDataMgr:getItemCfg(cid)
	return self.itemCfg[cid]
end

function CollectDataMgr:getCollectorCfg()
	return self.collectorCfg
end

function CollectDataMgr:getEquipCfg(equipId)
	return self.equipCfg[equipId]
end

function CollectDataMgr:getEquipSuitCfg(suitId)
	return self.equipSuitCfg[suitId]
end

function CollectDataMgr:getTokenCfg(tokenId)
	return self.tokenCfg[tokenId]
end

function CollectDataMgr:getTokenSuitCfg(suitId)
	return self.tokenSuitCfg[suitId]
end

function CollectDataMgr:getSceneChangeCfg(cid)
	return self.sceneCfg[cid]
end

----------------------------
function CollectDataMgr:readyOwnCollect()
	TFDirector:send(c2s.ELEMENT_COLLECT_GET_ALL_ELEMENT, {})
	self.curShowPlayerType = 1
	self.curShowPlayer = MainPlayer:getPlayerInfo()
	self.curShowData = self.collectShowData[self.curShowPlayerType]
end
--查看别人的图鉴前调用
function CollectDataMgr:readyOtherCollect(playerInfo)
	self.curShowPlayerType = 2
	self.curShowPlayer = playerInfo
	self.curShowData = self.collectShowData[self.curShowPlayerType]
	self:updateOtherPlayerCollect(playerInfo)
end

function CollectDataMgr:getItemClickEnable()
	return (self.curShowPlayerType == 1)
end

function CollectDataMgr:getPlayerName()
	return self.curShowPlayer.name
end

function CollectDataMgr:getPlayerId()
	return self.curShowPlayer.pid
end

function CollectDataMgr:getShowSetting()
	local showSetting = {}
	for k,v in pairs(self.collectShowSetting.pageinfo) do
		table.insert(showSetting,{key = k,value = v.showType})
	end
	if table.count(showSetting) >= 2 then
		table.sort( showSetting, function(a,b)
			return a.key < b.key
		end )
	end
	return showSetting
end

function CollectDataMgr:checkPageCanEnter(pageType)
	if self.curShowPlayerType == 1 then
		return true
	end
	return self.pageEnterData.pageinfo[pageType].showType
end
-----------------------
function CollectDataMgr:getCollectRewards(id)
    TFDirector:send(c2s.ELEMENT_COLLECT_GET_ELEMENT_REWARD, {id})
end

function CollectDataMgr:reqChangeShowSetting(setting)
	local settingList = {}
	for k,v in pairs(setting) do
		local settingkeys = table.keys(self.collectShowSetting.pageinfo[v.key].innerType)
		for s,t in pairs(settingkeys) do
			table.insert(settingList,{t,v.value}) 
		end	
	end
	TFDirector:send(c2s.ELEMENT_COLLECT_REQ_CHANGE_ELEMENT_TYPE, {settingList})
end

function CollectDataMgr:getNewPokedexNameTextId( id )
	if self.collectCfg[id] == nil then return "NewPokedex id:" ..id .." == nil" end
	if self.collectCfg[id].nameTextId == nil then return "NewPokedex id:" ..id .." nameTextId == nil" end
	return self.collectCfg[id].nameTextId
end

function CollectDataMgr:getNewPokedexSortr( id )
	if self.collectCfg[id] == nil then return 0 end
	if self.collectCfg[id].sortr == nil then return 0 end
	return self.collectCfg[id].sortr
end

function CollectDataMgr:getNewPokedexNumInfo(subType)
	-- body
	if self.curShowData.collect[subType] == nil then
		return 0,0
	end
	local all = #self.collectSubTypeCfg[subType]
	local unLock = 0
	for _cid,_info in pairs(self.curShowData.collect[subType].itemlist) do
		if self:isCollectItemExist(subType,_cid) then
			unLock = unLock + 1
		end
	end
	return unLock,all
end

return CollectDataMgr