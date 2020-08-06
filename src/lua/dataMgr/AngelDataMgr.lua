local BaseDataMgr = import(".BaseDataMgr")
local AngelDataMgr = class("AngelDataMgr", BaseDataMgr)

AngelDataMgr.LOCK_TYPE = {
	STAR = 1,
	LVL  = 2,
	FRONT = 3,
	UNLOCK = 0
}

function AngelDataMgr:ctor()
	self.angelBase = clone(TabDataMgr:getData("AngelSkillTree"));
	local angelTable = {}
	for k,v in pairs(self.angelBase) do
		angelTable[v.heroId] = angelTable[v.heroId]  or {};
		for idx,skillId in pairs(v.skillId) do

			angelTable[v.heroId][skillId] = angelTable[v.heroId][skillId] or {};
			angelTable[v.heroId][skillId][v.pos] = angelTable[v.heroId][skillId][v.pos] or {};
			angelTable[v.heroId][skillId][v.pos][v.lvl] = v.id;
		end
	end

	self.angelTable = angelTable;

	local angleTreeTable = {}
	for k, v in pairs(self.angelBase) do
		if v.pos and v.pos~="" then
			angleTreeTable[v.heroId] = angleTreeTable[v.heroId] or {}
			angleTreeTable[v.heroId][v.skillType] = angleTreeTable[v.heroId][v.skillType] or {}
			angleTreeTable[v.heroId][v.skillType][v.pos] = angleTreeTable[v.heroId][v.skillType][v.pos] or {}
			angleTreeTable[v.heroId][v.skillType][v.pos][v.lvl] = k
		end
	end
	self.angleTreeBaseTable = angleTreeTable

	self.anglePassiveSkillSlotTable = TabDataMgr:getData("AngelPassiveSkillGrooves")

	self:init();
end

function AngelDataMgr:init()
	TFDirector:addProto(s2c.HERO_RESP_ANGEL_ADD_BIT, self, self.recvTalentLevelUp)
	TFDirector:addProto(s2c.HERO_RES_MODIFY_STRATEGY_NAME, self, self.recvChangeAngleTabName)
	TFDirector:addProto(s2c.HERO_RES_USE_SKILL_STRATEGY, self, self.recvUseAngleTab)
	TFDirector:addProto(s2c.HERO_RES_EQUIP_PASSIVE_SKILL, self, self.recvLoadPassiveSkill)
	TFDirector:addProto(s2c.HERO_RES_UPGRADE_SKILL, self, self.recvUpgradeSkill)
	TFDirector:addProto(s2c.HERO_RES_AWAKE_ANGEL, self, self.recvAngleAwake)
	TFDirector:addProto(s2c.HERO_RES_RESET_SKILL, self, self.recvResetAngleTabSkill)
end

function AngelDataMgr:onLogin()
	-- TFDirector:send(c2s.PLAYER_GET_FORMATIONS, {})
	-- return {s2c.PLAYER_FORMATION_INFO_LIST}
end

function AngelDataMgr:getAngleConfig(id)
	local config = TabDataMgr:getData("AngelSkillTree", id)
	return config
end

function AngelDataMgr:getAllMainSkillConfig(heroId)
	local config = TabDataMgr:getData("AngelSkillTree")
	local results = {}
	for k, v in pairs(config) do
		if v.heroId == heroId and v.skillType ~= EC_SKILL_TYPE.BEIDONG then
			table.insert(results, v)
		end
	end
	return results
end

function AngelDataMgr:getAngleBaseData(heroId, skillType, pos, level)
	if level then
		local data = self.angleTreeBaseTable[heroId][skillType][pos][level]
		return data
	end
	if pos then
		local data = self.angleTreeBaseTable[heroId][skillType][pos]
		return data
	end
	if skillType then
		local data = self.angleTreeBaseTable[heroId][skillType]
		return data
	end
	if heroId then
		local data = self.angleTreeBaseTable[heroId]
		return data
	end
	return self.angleTreeBaseTable
end

function AngelDataMgr:getPassiveSkillConfig(heroId)
	local configs = TabDataMgr:getData("AngelSkillTree")
	local results = {}
	for k, v in pairs(configs) do
		if v.heroId == heroId and v.skillType == EC_SKILL_TYPE.BEIDONG then
			table.insert(results, v)
		end
	end
	return results
end

function AngelDataMgr:getHeroCurrUsePassiveSkillData(heroId, idx)
	local useSkillStrategyData = self:getHeroCurrUseSkillStrategyData(heroId)
	if idx then
		for i, v in ipairs(useSkillStrategyData.passiveSkillInfo or {}) do
			if v.pos == idx then
				return v
			end
		end
		return {}
	end
	return useSkillStrategyData.passiveSkillInfo or {}
end

function AngelDataMgr:getHeroCurrUseSkillStrategyData(heroId)
	local pageId = HeroDataMgr:getUseSkillStrategy(heroId)
	local data = self:getHeroSkillStrategyData(heroId,pageId)
	return data
end

function AngelDataMgr:getHeroSkillStrategyData(heroId, id,flag)
	local hero = HeroDataMgr:getHero(heroId)
	local skillStrategyInfo = hero.skillStrategyInfo or {}
	if hero.testType == 1 and not flag then
		skillStrategyInfo = {}
		local defaultData = TabDataMgr:getData("HeroTest",heroId) -- TODO 获取配置默认数据
		if defaultData then
			for i = 1,3 do
				local angelSkillInfos =  {}
				local talentList = defaultData["angelUp"..i].angerID
				local temp = {}
				for i,v in pairs(talentList) do
					local talentInfo = TabDataMgr:getData("AngelSkillTree", v)
					local item = {}
					item.type = talentInfo.skillType
					item.pos = talentInfo.pos
					item.lvl = talentInfo.lvl

					if not temp[item.type.."e"..item.pos] or temp[item.type.."e"..item.pos].lvl < item.lvl then
						temp[item.type.."e"..item.pos] = temp[item.type.."e"..item.pos] or {}
						temp[item.type.."e"..item.pos].lvl = item.lvl
						if temp[item.type.."e"..item.pos].item then
							temp[item.type.."e"..item.pos].item.lvl = item.lvl
						else
							table.insert(angelSkillInfos,item)
							temp[item.type.."e"..item.pos].item = item
						end
					end
				end

				local passiveSkillInfo = {}
				local passiveSkillList = defaultData["angelUp"..i].passiveSkill

				for i,v in pairs(passiveSkillList) do
					local passive= {}
					passive.pos = i
					passive.skillId = v
					table.insert(passiveSkillInfo,passive)
				end

				local srcData = {
					id = i,
					name = defaultData["angelUp"..i].name,
					alreadyUseSkillPiont = 0,
					angeSkillInfos = angelSkillInfos,
					passiveSkillInfo = passiveSkillInfo,
				}
				table.insert(skillStrategyInfo,srcData)
			end
		end
	end
	if id then
		local srcData = nil
		for i, v in pairs(skillStrategyInfo) do
			if v.id == id then
				srcData = v
				break
			end
		end
		if not srcData then
			local pageConfig = TabDataMgr:getData("AngelSkillPage",id)
			local pageName   = TextDataMgr:getText(id, pageConfig.nameId)
			srcData = {
				id = id,
				name = pageName,
				alreadyUseSkillPiont = 0,
				angeSkillInfos = {},
				passiveSkillInfo = {},
			}
			hero.skillStrategyInfo = hero.skillStrategyInfo or {}
			table.insert(hero.skillStrategyInfo, srcData)
		end
		return srcData
	end

	return skillStrategyInfo
end

--获取某个天使页当前可使用的技能点
function AngelDataMgr:getAngleTabCurUseSkillPoint(heroId, angleTabId)
	angleTabId = angleTabId or HeroDataMgr:getUseSkillStrategy(heroId)

	local curPoint = HeroDataMgr:getSkillPoint(heroId)

	local angleTabData = self:getHeroSkillStrategyData(heroId, angleTabId)
	local curTabUsePoint = angleTabData.alreadyUseSkillPiont or 0

	local point = curPoint - curTabUsePoint

	return point
end

function AngelDataMgr:getSkillLevel(heroId, skillType, pos)
	local hero = HeroDataMgr:getHero(heroId)
	-- if not hero.angeSkillInfos then
	-- 	return 0 --没有找到这个天使技能，默认0级
	-- end
	local currAnglePageInfo = self:getHeroCurrUseSkillStrategyData(heroId)
	local angeSkillInfos = currAnglePageInfo.angeSkillInfos or {}
	for i, v in ipairs(angeSkillInfos) do
		if v.type == skillType and v.pos == pos then
			return v.lvl
		end
	end
	return 0 --没有找到这个天使技能，默认0级
end

function AngelDataMgr:getSkillMaxLevel(heroId, skillType, pos)
	local posDatas = self:getAngleBaseData(heroId, skillType, pos)
	local maxLevel = #posDatas
	return maxLevel
end

function AngelDataMgr:getIsUnlockSkill(skillId,dataCfg)
	if dataCfg and dataCfg.constTrue then -- 试用精灵的解锁由配置等级决定
		if self:getSkillLevel(dataCfg.heroid,dataCfg.skillType,dataCfg.pos) > 0 then
			return true,0
		else
			return false,0
		end
	end

	local angleConfig = self:getAngleConfig(skillId)
	local hero        = HeroDataMgr:getHero(angleConfig.heroId)

	local heroLv = HeroDataMgr:getLv(angleConfig.heroId)
	if heroLv < angleConfig.needHeroLvl then
		return false,-1,angleConfig.needHeroLvl --英雄等级不足，未解锁
	end

	local angleLv = HeroDataMgr:getAngelLevel(angleConfig.heroId)
	if angleLv < angleConfig.needAngelLvl then
		return false,-2,angleConfig.needAngelLvl --天使等级不足，未解锁
	end
	for i, v in ipairs(angleConfig.frontCondition) do
		for i2, v2 in ipairs(v) do
			local tmpAngleConfig = self:getAngleConfig(v2)
			local curSkillLevel  = self:getSkillLevel(tmpAngleConfig.heroId, tmpAngleConfig.skillType, tmpAngleConfig.pos)
			if curSkillLevel < tmpAngleConfig.lvl then
				return false,-3,{nameId=tmpAngleConfig.nameId, lvl=tmpAngleConfig.lvl} --前置技能等级不足，未解锁
			end
		end
	end
	return true,0 --满足所有解锁条件，已解锁
end

--获取英雄的某个被动技能槽是否解锁
function AngelDataMgr:getIsUnlockPassiveSkillSlot(heroId, idx)
	local hero = HeroDataMgr:getHero(heroId)
	local config = self.anglePassiveSkillSlotTable[idx]
	local angleLv = HeroDataMgr:getAngelLevel(heroId)
	local isUnlock = hero and hero.lvl and hero.lvl >= config.needHeroLvl and angleLv >= config.AngelLvl
	return isUnlock, config.AngelLvl
end

--获取当前是否装备了某个被动技能
function AngelDataMgr:getIsLoadPassiveSkill(heroId,skillId)
	local SkillStrategyData = self:getHeroCurrUseSkillStrategyData(heroId)
	if SkillStrategyData.passiveSkillInfo then
		for i, v in ipairs(SkillStrategyData.passiveSkillInfo) do
			if v.skillId == skillId then
				return v
			end
		end
	end
	return false
end

--获取是否有空余的被动技能槽
function AngelDataMgr:getIsHaveEmptyPassiveSkillSlot(heroId)
	local currPassiveSkillInfos = self:getHeroCurrUsePassiveSkillData(heroId)
	local curCount = #currPassiveSkillInfos

	for i=1, 4 do
		local data = currPassiveSkillInfos[i]
		if not data or data.skillId <= 0 then
			local isUnlock = self:getIsUnlockPassiveSkillSlot(heroId, i)
			if isUnlock then
				return true, i --有解锁且空余的技能槽
			end
		end
	end

	return false
end

--获取当前被动技能槽位置是否装备了技能
function AngelDataMgr:getIsLoadPassiveSkillByPos(heroId, pos)
	local currPassiveSkillInfos = self:getHeroCurrUsePassiveSkillData(heroId)
	for i, v in ipairs(currPassiveSkillInfos) do
		if v and v.pos == pos and v.skillId and v.skillId>0 then
			return true
		end
	end
	return false
end

--请求修改天使标签名字
function AngelDataMgr:doReqModifyStrategyName(heroId, tabId, name)
    if Utils:isStringContainSpecialChars(name) ~= nil then
        return false
    end
	heroId = HeroDataMgr:getHeroSid(heroId)
    local msg = {heroId, tabId, name}
    dump(msg)
    TFDirector:send(c2s.HERO_REQ_MODIFY_STRATEGY_NAME, msg)
    return true
end

--请求使用天使页
function AngelDataMgr:doReqUseSkillStrategy(heroId, tabId)
	heroId = HeroDataMgr:getHeroSid(heroId)
    local msg = {heroId, tabId}
    dump(msg)
    TFDirector:send(c2s.HERO_REQ_USE_SKILL_STRATEGY, msg)
end

--请求装备/卸下被动技能
function AngelDataMgr:doReqEquipPassiveSkill(heroId, skillId, pos)
	heroId = HeroDataMgr:getHeroSid(heroId)
    local msg = {heroId, skillId, pos}
    dump(msg)
    TFDirector:send(c2s.HERO_REQ_EQUIP_PASSIVE_SKILL, msg)
end

--请求升级天使技能
-- operation	：1 升级 2 降级，默认升级
function AngelDataMgr:doReqUpgradeSkill(heroId, skillType, pos, operation)
	heroId = HeroDataMgr:getHeroSid(heroId)
	operation = operation or 1
    local msg = {heroId, skillType, pos, operation}
    print("请求升级天使技能")
    dump(msg)
    TFDirector:send(c2s.HERO_REQ_UPGRADE_SKILL, msg)
end

--重置技能
function AngelDataMgr:doReqResetSkill(heroId, angleTabId)	
	heroId = HeroDataMgr:getHeroSid(heroId)
    local msg = {heroId, angleTabId}
    print("请求重置天使页技能")
    dump(msg)
    TFDirector:send(c2s.HERO_REQ_RESET_SKILL, msg)
end

function AngelDataMgr:getPosIsHave(heroId,skillId,pos)
	if not self.angelTable[heroId] then 
		return false
	end
	if not self.angelTable[heroId][skillId] then
		return false;
	end

	return self.angelTable[heroId][skillId][pos] ~= nil;
end

function AngelDataMgr:getTalentsType(heroId,skillId)
	return self.angelTable[heroId][skillId]
end

function AngelDataMgr:getOneTalentIcon(heroId,skillId,pos,lvl)
	if not self.angelTable[heroId] then 
		return ""
	end
	if not self.angelTable[heroId][skillId] then
		return "";
	end
	
	if not self.angelTable[heroId][skillId][pos] then
		return "";
	end

	local id = self.angelTable[heroId][skillId][pos][lvl];
	
	return self.angelBase[id].icon
end

function AngelDataMgr:getHaveCount(heroId,skillId)
	return table.count(self.angelTable[heroId][skillId]);
end

function AngelDataMgr:getOneTalentName(heroId,skillId,pos,lvl,talentid)

	local id = talentid or self.angelTable[heroId][skillId][pos][lvl];
	return self.angelBase[id].nameId
end

function AngelDataMgr:getOneTalentDes(heroId,skillId,pos,lvl)
	local id = self.angelTable[heroId][skillId][pos][lvl];
	return self.angelBase[id].describe
end

function AngelDataMgr:getOneTalentTips2(heroId,skillId,pos,lvl)
	local id = self.angelTable[heroId][skillId][pos][lvl];
	return self.angelBase[id].tips2
end

function AngelDataMgr:getOneTalentTips1(heroId,skillId,pos,lvl)
	local id = self.angelTable[heroId][skillId][pos][lvl];
	return self.angelBase[id].tips1
end

function AngelDataMgr:getOneTalentNeed(heroId,skillId,pos,lvl)
	local id = self.angelTable[heroId][skillId][pos][lvl];
	local needSkillPiont = self.angelBase[id].needSkillPiont
	return needSkillPiont;
end

function AngelDataMgr:getOneTalentMaxLv(heroId,skillId,pos)
	return table.count(self.angelTable[heroId][skillId][pos]);
end

function AngelDataMgr:getTalentPos(talentid)
	return self.angelBase[talentid].pos;
end

function AngelDataMgr:getOneTalentShowId(skillId)
	return self.angelBase[skillId].pos_position;
end

function AngelDataMgr:getTalentFrontPos(talentid)
	dump(talentid)
	local frontT = self.angelBase[talentid].frontCondition;
	if table.count(frontT) == 0 then
		return nil;
	end

	local pos = {}
	for k,v in pairs(frontT) do
		for k2,v2 in pairs(v) do
			local talent = self.angelBase[v2]
			table.insert(pos,talent.pos);
		end
	end

	return pos;
end

function AngelDataMgr:getTalentFront(talentid)
	local frontT = self.angelBase[talentid].frontCondition;
	if table.count(frontT) == 0 then
		return nil;
	end

	local fronts = {}
	for k,v in pairs(frontT) do
		for k2,v2 in pairs(v) do
			table.insert(fronts,v2);
		end
	end

	return fronts;
end

function AngelDataMgr:checkUnlock(talentid,heroid)
	--local heroid 		= self.angelBase[talentid].heroId;
	local angelLv 		= HeroDataMgr:getAngelLevel(heroid);
	local heroLv 		= HeroDataMgr:getLv(heroid);
	local needAngelLvl  = self.angelBase[talentid].needAngelLvl;
	local needHeroLvl	= self.angelBase[talentid].needHeroLvl;
	if angelLv < needAngelLvl then
		return false,AngelDataMgr.LOCK_TYPE.STAR,needAngelLvl
	end

	if heroLv < needHeroLvl then
		return false,AngelDataMgr.LOCK_TYPE.LVL,needHeroLvl
	end

	local isFront = false;
	local fronts = self:getTalentFront(talentid);

	if not fronts  then
		return true;
	end

	local needFrontID = 0
	for k,v in pairs(fronts) do
		local pos,lv,_type = self:getTalentPosLvType(v);
		needFrontID = v;
		local targetLv = HeroDataMgr:getAngelTalentLv(heroid,_type,pos)
		if targetLv >= lv then
			isFront = true;
			break
		end
	end


	return isFront,AngelDataMgr.LOCK_TYPE.FRONT,needFrontID;
end

function AngelDataMgr:getTalentPosLvType(talentid)
	local pos = self.angelBase[talentid].pos
	local _type = self.angelBase[talentid].skillType 
	local skill = self.angelBase[talentid].skillId;
	--local t = self.angelTable[skill][pos];
	local lv = self.angelBase[talentid].lvl --table.indexOf(t,talentid)

	return pos,lv,_type
end

function AngelDataMgr:getTalents(heroid,skillId)
	return self.angelTable[heroid][skillId]
end

function AngelDataMgr:getTalentId(heroid,skillId,pos,lvl)
	return self.angelTable[heroid][skillId][pos][lvl]
end

function AngelDataMgr:talentLevelUp(heroid,talentid)
	heroid = HeroDataMgr:getHeroSid(heroid)
	local msg = {
		heroid,
		talentid
	}

	dump(msg);
	TFDirector:send(c2s.HERO_REQ_ANGEL_ADD_BIT,msg);
end

function AngelDataMgr:recvTalentLevelUp(event)
	dump(event.data);
	--EventMgr:dispatchEvent(EV_HERO_LEVEL_UP);
end

function AngelDataMgr:recvChangeAngleTabName(event)
	dump(event.data)
	local data = event.data
	data.heroId = HeroDataMgr:getHeroCid(data.heroId)
	local angleTabData = self:getHeroSkillStrategyData(data.heroId, data.skillStrategyId)
	angleTabData.name = data.name
	GoodsDataMgr:syncHero(HeroDataMgr:getHero(data.heroId));
	EventMgr:dispatchEvent(EV_HERO_ANGLE_CHANGE_TAB_NAME,data);
end

function AngelDataMgr:recvUseAngleTab(event)
	dump(event.data)
	local data = event.data
	data.heroId = HeroDataMgr:getHeroCid(data.heroId)
	local hero = HeroDataMgr:getHero(data.heroId)
	hero.useSkillStrategy = data.skillStrategyId
	-- local angleTabData = self:getHeroSkillStrategyData(data.heroId, data.skillStrategy.id)
	-- table.merge(angleTabData, data.skillStrategy)
	HeroDataMgr:setHeroAngelInfo(hero)
	GoodsDataMgr:syncHeroAngelTab(hero.cid,data.skillStrategyId)
	EventMgr:dispatchEvent(EV_HERO_ANGLE_USE_TAB, data)
end

function AngelDataMgr:recvLoadPassiveSkill(event)
	dump(event.data)
	local data = event.data
	data.heroId = HeroDataMgr:getHeroCid(data.heroId)
	local hero = HeroDataMgr:getHero(data.heroId)
	local angleTabData = self:getHeroSkillStrategyData(data.heroId, HeroDataMgr:getUseSkillStrategy(data.heroId))
	angleTabData.passiveSkillInfo = angleTabData.passiveSkillInfo or {}

	local srcData = nil
	local newData = data.passiveSkillInfo
	for i, v in ipairs(angleTabData.passiveSkillInfo) do
		if v.pos == newData.pos then
			srcData = v
			break
		end
	end
	if not srcData then
		table.insert(angleTabData.passiveSkillInfo, newData)
	else
		srcData.skillId = newData.skillId
	end

	dump(angleTabData.passiveSkillInfo)
	GoodsDataMgr:syncHero(HeroDataMgr:getHero(data.heroId));
	EventMgr:dispatchEvent(EV_HERO_ANGLE_LOAD_PASSIVE_SKILL, data)
end

function AngelDataMgr:recvUpgradeSkill(event)
	dump(event.data)
	local data = event.data
	data.heroId = HeroDataMgr:getHeroCid(data.heroId)
	local hero = HeroDataMgr:getHero(data.heroId)
	local angleTabData = self:getHeroSkillStrategyData(data.heroId, HeroDataMgr:getUseSkillStrategy(data.heroId))
	angleTabData.angeSkillInfos = angleTabData.angeSkillInfos or {}
	angleTabData.alreadyUseSkillPiont = data.useSkillPiont

	local srcData = nil
	local newData = data.angeSkillInfo
	for i, v in ipairs(angleTabData.angeSkillInfos) do
		if v.type == newData.type and v.pos == newData.pos then
			srcData = v
			break
		end
	end
	if not srcData then
		table.insert(angleTabData.angeSkillInfos, newData)
	else
		srcData.lvl = newData.lvl
	end

	--hero.angeSkillInfos = angleTabData.angeSkillInfos
	HeroDataMgr:setHeroAngelInfo(hero)
	GoodsDataMgr:syncHero(hero)
	EventMgr:dispatchEvent(EV_HERO_ANGLE_UPGRADE_SKILL, data)
end

function AngelDataMgr:recvResetAngleTabSkill(event)
	dump(event.data)
	local data = event.data
	data.heroId = HeroDataMgr:getHeroCid(data.heroId)
	local angleTabData = self:getHeroSkillStrategyData(data.heroId, data.skillStrategy.id)
	angleTabData.name = data.skillStrategy.name
	angleTabData.alreadyUseSkillPiont = data.skillStrategy.alreadyUseSkillPiont or 0
	angleTabData.angeSkillInfos = data.skillStrategy.angeSkillInfos or {}
	angleTabData.passiveSkillInfo = data.skillStrategy.passiveSkillInfo or {}
	HeroDataMgr:setHeroAngelInfo(HeroDataMgr:getHero(data.heroId))
	
	GoodsDataMgr:syncHero(HeroDataMgr:getHero(data.heroId));
	EventMgr:dispatchEvent(EV_HERO_ANGLE_USE_TAB,data);
end

function AngelDataMgr:getAngelTreeUiCfg(heroId)
	local skind = HeroDataMgr:getCurSkin(heroId);
	local cfg = TabDataMgr:getData("HeroSkin",skind).AngelSkillTree;
	return cfg;
end

function AngelDataMgr:getAngelAwakenTalentId(heroId)
	local angelLv = HeroDataMgr:getAngelLevel(heroId)
	local skillId = HeroDataMgr:getAngelSkllID(heroId,EC_SKILL_TYPE.JUEXING);
	return self.angelTable[heroId][skillId][1][angelLv - 1]
end

return AngelDataMgr:new();
