local BaseDataMgr = import(".BaseDataMgr")
local EquipmentDataMgr = class("EquipmentDataMgr", BaseDataMgr)


function EquipmentDataMgr:ctor()
	self.equipBase = TabDataMgr:getData("Equipment");
	self.passiveSkills = TabDataMgr:getData("PassiveSkills");
	self.EquipmentRandom = TabDataMgr:getData("EquipmentRandom");
	self.EquipmentXilian = TabDataMgr:getData("EquipmentXilian");

	self.NewEquip = TabDataMgr:getData("NewEquip")
	self.NewEquipSuit = TabDataMgr:getData("NewEquipSuit")
	self.NewEquipStrengthen = TabDataMgr:getData("NewEquipStrengthen")
	self.NewEquipAdvance = TabDataMgr:getData("NewEquipAdvance")
	self.NewEquipSkill = TabDataMgr:getData("NewEquipSkill")
	self.StoneCfgMap = TabDataMgr:getData("Stone")
	self.StoneComposeCfgMap = TabDataMgr:getData("StoneCompose")
	self.EquipmentStar = TabDataMgr:getData("EquipmentStar")
	self.newEquips = {}
	self.gemsData = {}  --宝石数据
	self.chooseConditionData = {selectState = {},cids = {},isSingle = true}
	self.equipBackUpInfos = {}
    self:init()
    self:initEquipAdvancedCfg()
end

function EquipmentDataMgr:setChooseCondition(data)
	self.chooseConditionData = data
end

function EquipmentDataMgr:getChooseCondition()
	return self.chooseConditionData
end

function EquipmentDataMgr:init()
	self.equips = {};
	TFDirector:addProto(s2c.EQUIPMENT_EQUIP, self, self.recvUseEquipment)
	TFDirector:addProto(s2c.EQUIPMENT_UPGRADE, self, self.recvEquipmentLevelUp)
	TFDirector:addProto(s2c.EQUIPMENT_CHANGE_SPECIAL_ATTR, self, self.recvEquipConvert)
	TFDirector:addProto(s2c.EQUIPMENT_RES_EQUIP_REMOULD, self, self.recvEquipReform)
	TFDirector:addProto(s2c.EQUIPMENT_REPLACE_SPECIAL_ATTR, self, self.recvEquipConvertOK)
	TFDirector:addProto(s2c.EQUIPMENT_TAKE_OFF, self, self.recvEquipTakeOffOK)
	TFDirector:addProto(s2c.EQUIPMENT_LOCK, self, self.recvEquipLockStatus)
	TFDirector:addProto(s2c.EQUIPMENT_RES_EQUIP_RECYCLE, self, self.recvEquipRecycle)
	TFDirector:addProto(s2c.EQUIPMENT_RES_DRESS_NEW_EQUIP, self, self.recvNewEquipWearOrDrop)
	TFDirector:addProto(s2c.EQUIPMENT_RES_STRENGTHEN_NEW_EQUIP, self, self.recvNewEquipStrengthen)
	TFDirector:addProto(s2c.EQUIPMENT_RES_ADVANCE_NEW_EQUIP, self, self.recvNewEquipAdvance)
	TFDirector:addProto(s2c.EQUIPMENT_RES_EQUIP_RECYCLE_INFO, self, self.recvEquipRecycleItems)
	TFDirector:addProto(s2c.EQUIPMENT_RES_EQUIP_REMOULD_INFO, self, self.recvEquipReformNums)
	TFDirector:addProto(s2c.EQUIPMENT_RES_DRESS_GEM, self, self.recvDressGems)
	TFDirector:addProto(s2c.EQUIPMENT_RES_COMPOSE_GEM, self, self.recvComposeGems)
	TFDirector:addProto(s2c.EQUIPMENT_RES_UP_STAR_EQUIP, self, self.equipmentStarUpOver)

	TFDirector:addProto(s2c.EQUIPMENT_RES_REMOULD_GEM, self, self.recvRemouldGem)
	TFDirector:addProto(s2c.EQUIPMENT_RES_REMOULDED_GEM, self, self.recvRemouldChoose)
	TFDirector:addProto(s2c.EQUIPMENT_RES_DECOMPOSE_GEM, self, self.recvDecomposeGem)
	TFDirector:addProto(s2c.EQUIPMENT_RES_RECOMPOSE_GEM, self, self.recvRecomposeGem)
	TFDirector:addProto(s2c.EQUIPMENT_RES_DECOMPOSE_GEM_DESIGN, self, self.recvDecomposeGemSign)

	TFDirector:addProto(s2c.EQUIPMENT_RES_EQUIP_BACKUP_INFO, self, self.recvEquipBackUpInfo)
	TFDirector:addProto(s2c.EQUIPMENT_RES_SAVE_EQUIP_BACKUP_POS, self, self.recvSaveEquipBackUpPos)
	TFDirector:addProto(s2c.EQUIPMENT_RES_SAVE_EQUIP_BACKUP_DECR, self, self.recvSaveEquipBackUpName)
	TFDirector:addProto(s2c.EQUIPMENT_RES_USE_EQUIP_BACKUP, self, self.recvUseEquipBackUp)

	--质点突破
	TFDirector:addProto(s2c.EQUIPMENT_RSP_STEP_EQUIP, self, self.onRspStepEquip)
	TFDirector:addProto(s2c.EQUIPMENT_RSP_STEP_EQUIP_PREVIEW, self, self.onRspStepEquipPreview)

end

function EquipmentDataMgr:initEquipAdvancedCfg( )
    self.equipAdvancedCfg = {}
    local equipAdvancedCfg = TabDataMgr:getData("EquipmentAdvanced")
    for _,_equipAdvance in pairs(equipAdvancedCfg) do
        self.equipAdvancedCfg[_equipAdvance.equipmentId] = self.equipAdvancedCfg[_equipAdvance.equipmentId] or {}
        table.insert(self.equipAdvancedCfg[_equipAdvance.equipmentId], _equipAdvance)
        table.sort(self.equipAdvancedCfg[_equipAdvance.equipmentId], function(a, b)
            if a.step < b.step then
                return true
            elseif a.step > b.step then
                return false
            else
                if a.id < b.id then
                    return true
                else
                    return false
                end
            end
        end)
    end
end

function EquipmentDataMgr:onLogin()

end

function EquipmentDataMgr:reset()
	self.equips = {};
	self.equipBase = TabDataMgr:getData("Equipment");
	self.passiveSkills = TabDataMgr:getData("PassiveSkills");
	self.NewEquip = TabDataMgr:getData("NewEquip")
	self.NewEquipSuit = TabDataMgr:getData("NewEquipSuit")
	self.NewEquipStrengthen = TabDataMgr:getData("NewEquipStrengthen")
	self.NewEquipAdvance = TabDataMgr:getData("NewEquipAdvance")
	self.NewEquipSkill = TabDataMgr:getData("NewEquipSkill")
    self.NewEquipBreak = TabDataMgr:getData("NewEquipBreak")
	self.newEquips = {}
	self.gemsData = {}
	self:initEquipAdvancedCfg()
end
						  
function EquipmentDataMgr:onLoginOut()
	self:reset();
end

function EquipmentDataMgr:syncServer(equip)
	if equip.ct == EC_SChangeType.ADD or equip.ct == EC_SChangeType.DEFAULT then
        self.equips[equip.id] = equip;
    elseif equip.ct == EC_SChangeType.UPDATE then
    	self.equips[equip.id] = self.equips[equip.id] or {}
        table.merge(self.equips[equip.id],equip);
    elseif equip.ct == EC_SChangeType.DELETE then
        self.equips[equip.id] = nil;
    end
end

function EquipmentDataMgr:syncServerNewEquip(equip)
	if equip.ct == EC_SChangeType.ADD or equip.ct == EC_SChangeType.DEFAULT then
        self.newEquips[equip.id] = equip
    elseif equip.ct == EC_SChangeType.UPDATE then
    	self.newEquips[equip.id] = self.newEquips[equip.id] or {}
        table.merge(self.newEquips[equip.id],equip)
    elseif equip.ct == EC_SChangeType.DELETE then
        self.newEquips[equip.id] = nil;
    end
end

function EquipmentDataMgr:syncServerGems(gemInfo)
	if gemInfo.ct == EC_SChangeType.ADD or gemInfo.ct == EC_SChangeType.DEFAULT then
        self.gemsData[gemInfo.id] = gemInfo
    elseif gemInfo.ct == EC_SChangeType.UPDATE then
    	self.gemsData[gemInfo.id] = self.gemsData[gemInfo.id] or {}
        table.cover(self.gemsData[gemInfo.id],gemInfo)    
    elseif gemInfo.ct == EC_SChangeType.DELETE then
        self.gemsData[gemInfo.id] = nil
    end
end

function EquipmentDataMgr:chageDataToFriend(friend,isFuBen)
	self.filter = {}

	if not self.myEquips then
		self.myEquips = clone(self.equips);
	end

	self.equips = {};
	for k,v in pairs(friend.heros) do
		if v.equipments then
			for k2,v2 in pairs(v.equipments) do
				v2.equip.ct = EC_SChangeType.DEFAULT;
				self:syncServer(v2.equip);

				--剧情英雄装备过滤收集
				if v.equipFilter then
					table.insert(self.filter,v2.equip.id);
				end
			end
		end

		if v.equipFilter then

		end
	end

	if isFuBen then
		--剧情关加入本身已有质点
	 	GoodsDataMgr:resetEquip()
	end

	if not self.myNewEquips then
		self.myNewEquips = clone(self.newEquips)
	end
	self.newEquips = {}
	for k,v in pairs(friend.heros) do
		if v.euqipFetterInfo then
			for k2,v2 in pairs(v.euqipFetterInfo) do
				v2.newEquipmentInfo.ct = EC_SChangeType.DEFAULT
				self:syncServerNewEquip(v2.newEquipmentInfo)
			end
		end
	end
end

function EquipmentDataMgr:chageDataToSkyLadder()

	if not self.myEquips then
		self.myEquips = clone(self.equips);
	end

	if not self.myNewEquips then
		self.myNewEquips = clone(self.newEquips)
	end

	for k,v in pairs(self.equips) do
		v.heroId = "0"
		v.position = "0"
	end

	for k,v in pairs(self.newEquips) do
		v.heroId = "0"
		v.position = "0"
	end

	local skyLadderHero = SkyLadderDataMgr:getSkyLadderHeroInfo()
	for k,v in pairs(skyLadderHero) do

		---质点
		if v.equipments then
			for k2,v2 in pairs(v.equipments) do
				self.equips[v2.equip.id] = clone(v2.equip)
			end
		end

		---羁绊
		if v.euqipFetterInfo then
			for k2,v2 in pairs(v.euqipFetterInfo) do
				self.newEquips[v2.newEquipmentInfo.id] = clone(v2.newEquipmentInfo)
			end
		end
	end

end

function EquipmentDataMgr:changeDataToSelf()
	if self.myEquips then
		self.equips = {}--self.myEquips;
		self.filter = {}
		GoodsDataMgr:resetEquip();
		self.myEquips = nil;
	end

	if self.myNewEquips then
		self.newEquips = {}
		GoodsDataMgr:resetNewEquip()

		self.myNewEquips = nil
	end
end

function EquipmentDataMgr:isCid(id)
	if type(id) == "number" then
		return true
	end

	return false;
end

function EquipmentDataMgr:isHave(id)
	if not self:isCid(id) then
		return true;
	end

	for k,v in pairs(self.equips) do
		if v.cid == id then
			return true;
		end
	end

	return false;
end

function EquipmentDataMgr:getIdByCid(cid)
	for k,v in pairs(self.equips) do
		if v.cid == cid then
			return v.id;
		end
	end

	return "";
end

function EquipmentDataMgr:getEquipCnt(cid)
    local count = 0
    if cid then
        for k, v in pairs(self.equips) do
            if v.cid == cid then
                count = count + 1
            end
        end
    else
        count = table.count(self.equips);
    end
    return count
end

function EquipmentDataMgr:isCanUseEquip()
	-- if self:getEquipCnt() <= 0 then
	-- 	return false;
	-- end

	-- for k,v in pairs(self.equips) do
	-- 	if not self:isUesing(v.id) then
	-- 		return true;
	-- 	end
	-- end

	-- return false;
	return true
end

function EquipmentDataMgr:getEquipLv(id)
	if self:isCid(id) then
		return 1
	end

	return self.equips[id].level;
end

function EquipmentDataMgr:getEquipStarLv(id)
	local cid = 0;
	local starLv = 0
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
		starLv = self.equips[id].star
	end

	starLv = self.equipBase[cid].star + starLv;
	return starLv;
end

function EquipmentDataMgr:getEquiGrowthpStar(id)
	local cid = 0;
	local starLv = 0
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
		starLv = self.equips[id].star
	end

	starLv = self.equipBase[cid].star + self:getEquipStarLevel(id)
	return starLv
end

function EquipmentDataMgr:getEquipQuality(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local quality = self.equipBase[cid].quality;
	return quality;
end

function EquipmentDataMgr:getEquipShowType(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local showType = self.equipBase[cid].showType;
	return showType;
end

function EquipmentDataMgr:getEquipName(id)
	local cid = 0;

	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local nameid = self.equipBase[cid].name;

	return TextDataMgr:getText(nameid);
end

function EquipmentDataMgr:isUesing(id)
	if self:isCid(id) then
		return false;
	end

	if string.find(id,"equipment") then return false end 
	return self.equips[id].heroId ~= "0";
end

function EquipmentDataMgr:getHeroSid(id)
	return self.equips[id].heroId;
end

function EquipmentDataMgr:getPosition(id)
	return self.equips[id].position;
end

function EquipmentDataMgr:getEquipNum(id)
	return self.equips[id].num;
end

function EquipmentDataMgr:getEquipCid(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	return cid;
end

function EquipmentDataMgr:getEquipCurExp(id)
	if not self.equips[id] then
		return 0;
	end

	return self.equips[id].exp;
end

function EquipmentDataMgr:getEquipMaxLv(id)
	local cid = 0;
	local rid
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
		rid = id
	end
	if rid then
		local starCfg = self:getEquipStarCfg(id)
	    local stageLevel = self:getEquipStageLevel(id) - 1
	    local toLevel = self.equipBase[cid].maxLevel
	    for i = 1, stageLevel do
	    	toLevel = toLevel + starCfg.levelIncrease[1][i]
	    end
		return toLevel
	else
		return self.equipBase[cid].maxLevel
	end
end

function EquipmentDataMgr:getEquipCurNeedExp(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local star   = self:getEquiGrowthpStar(id)
	local lv 	 = self:getEquipLv(id);

	return TabDataMgr:getData("EquipmentGrowth",star).needExp[lv];
end

function EquipmentDataMgr:getEquipTotalExp(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local curexp = self:getEquipCurExp(id);
	local star   = self:getEquiGrowthpStar(id)
	local baseExp= self.equipBase[cid].exp;
	local lv 	 = self:getEquipLv(id);
	local total  = 0;
	for i=1,lv - 1 do
		total = total + TabDataMgr:getData("EquipmentGrowth",star).needExp[i];
	end
	return total + curexp + baseExp;
end

function EquipmentDataMgr:calcLevelUp(id,exp)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local curexp = self:getEquipCurExp(id);
	local star   = self:getEquiGrowthpStar(id)
	local lv 	 = self:getEquipLv(id);
	local maxLv  = self:getEquipMaxLv(id);
	local curNeed= TabDataMgr:getData("EquipmentGrowth",star).needExp[lv] - curexp;
	
	local isMax  = lv >= maxLv;
	local isUp = false;
	while exp >= curNeed do
		isUp = true
		if lv >= maxLv then
			isMax = true;
			break;
		else
			lv = lv + 1;
			exp = exp - curNeed;
			curNeed = TabDataMgr:getData("EquipmentGrowth",star).needExp[lv];
		end
	end
	local curpercent = 0
	if isMax then
		curpercent = 100
	else
		local lvNeed = TabDataMgr:getData("EquipmentGrowth",star).needExp[lv]
		curpercent = exp / lvNeed * 100;
		if not isUp then
			curpercent = (exp + curexp) / lvNeed * 100;
		end
	end

	return isMax,lv,curpercent;
end

function EquipmentDataMgr:getEquipExpPercent(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end


	local curexp = self:getEquipCurExp(id);
	local star   = self:getEquiGrowthpStar(id)
	local lv 	 = self:getEquipLv(id);
	local maxexp = TabDataMgr:getData("EquipmentGrowth",star).needExp[lv];

	return curexp / maxexp * 100;
end

function EquipmentDataMgr:getEquipIcon(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local iconpath = self.equipBase[cid].icon;
	return iconpath;
end

--升星相关
function EquipmentDataMgr:getStarUpEquipsByCidAndStar(cid, subType, star)
	local equips = {}
	for k, v in pairs(self.equips) do
		local cfg = self:getEquipCfg(v.cid)
		local pCid = cid or v.cid
		local pType = subType > 0 and subType or cfg.subType
		local pStar = star or cfg.star
		--print("888888888888888888888",subType, v.subType, cfg.star)
		if (v.star < 1 and v.stage < 1 and pCid == v.cid and pType == cfg.subType and pStar == cfg.star) or (cfg.subType == 101) then
			table.insert(equips, v)
		end
	end
	local function __equipSort(equipList)
        table.sort(equipList, function(a, b)
           local cfgA = self:getEquipCfg(a.cid)
           local cfgB = self:getEquipCfg(b.cid)
           if a.level == b.level then
               if cfgA.quality == cfgB.quality then
                   if cfgA.subType == cfgB.subType then
                       return a.cid < b.cid
                   end
                   return cfgA.subType < cfgB.subType
               end
               return cfgA.quality > cfgB.quality
           end
           return a.level > b.level
        end)
    end
    local carry = {}
    local notCarry = {}

    for i, v in ipairs(equips) do
        if self:isUesing(v.id) then
            table.insert(carry, v)
        else
            table.insert(notCarry, v)
        end
    end
    __equipSort(carry)
    __equipSort(notCarry)
    equips = {}
    for i = 1, #carry do
        table.insert(equips, carry[i])
    end
    for i = 1, #notCarry do
        table.insert(equips, notCarry[i])
    end
    return equips
end

function EquipmentDataMgr:getEquipStarGrow(id)
	local cid = 0
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid
	end

	return self.equipBase[cid].starGrow
end

--升星配置
function EquipmentDataMgr:getEquipStarCfg(id)
	local cid = 0
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid
	end
	return self.EquipmentStar[cid]
end

function EquipmentDataMgr:getEquipStarUpBaseAttr(id, useStage)
	if self:getEquipStarGrow(id) then
		local starCfg = self:getEquipStarCfg(id)
		local level 
		if useStage then
			level = self:getEquipStageLevel(id)
		else
			level = self:getEquipStarLevel(id)
		end
		local attrs = {}
		for i=1,level do
			local attr = starCfg.baseAttributeIncrease[1][i]
			for k, v in pairs(attr) do
				attrs[k] = attrs[k] or 0
				attrs[k] = attrs[k] + v
			end
		end
		return attrs
	else
		return nil
	end
end

function EquipmentDataMgr:getEquipStarUpGrowthAttr(id, useStage)
	if self:getEquipStarGrow(id) then
		local starCfg = self:getEquipStarCfg(id)
		local level 
		if useStage then
			level = self:getEquipStageLevel(id)
		else
			level = self:getEquipStarLevel(id)
		end
		local attrs = {}
		for i=1,level do
			local attr = starCfg.growthAttributeIncrease[1][i]
			for k, v in pairs(attr) do
				attrs[k] = attrs[k] or 0
				attrs[k] = attrs[k] + v
			end
		end
		return attrs
	else
		return nil
	end
end

function EquipmentDataMgr:getEquipStageLevel(id)
	local stageLevel = 0
	if not self:isCid(id) then
		local equip = self.equips[id]
		stageLevel = equip.star * 2 + equip.stage + 1
	end
	return stageLevel
end

--当前升星等级
function EquipmentDataMgr:getEquipStarLevel(id)
	local starLevel = 0
	if not self:isCid(id) then
		local equip = self.equips[id]
		starLevel = equip.star * 3 + equip.stage
	end
	return starLevel
end

function EquipmentDataMgr:getEquipStarLimitLevel(id)
	local stageLevel = self:getEquipStageLevel(id)
	local limitLevel = self:getEquipStarCfg(id).level[1][stageLevel]
	return limitLevel
end

function EquipmentDataMgr:getEquipStarUpLevel(id)
	local maxLevel = self:getEquipMaxLv(id)
	local starCfg = self:getEquipStarCfg(id)
    local stageLevel = self:getEquipStageLevel(id) - 1
    local toLevel = maxLevel
    for i = 1, stageLevel do
    	toLevel = toLevel + starCfg.levelIncrease[1][i]
    end
end

function EquipmentDataMgr:getEquipStarUpToLevel(id)
	local maxLevel = self:getEquipMaxLv(id)
	local starCfg = self:getEquipStarCfg(id)
    local stageLevel = self:getEquipStageLevel(id)
    local toLevel = maxLevel
    toLevel = toLevel + starCfg.levelIncrease[1][stageLevel]
   
	return toLevel
end

function EquipmentDataMgr:getEquipPhotoSize(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	return self.equipBase[cid].photoSize;
end

function EquipmentDataMgr:getEquipBaseAtk(id,lv,useStage)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local _lv = lv or self:getEquipLv(id);
	local atk = self.equipBase[cid].baseAttribute[EC_Attr.ATK];
	local starBaseAttr = self:getEquipStarUpBaseAttr(id, useStage)
	atk = atk + (starBaseAttr and starBaseAttr[EC_Attr.ATK] or 0)
	local growthAtk = self.equipBase[cid].growthAttribute[EC_Attr.ATK]
	local starGrowthAttr = self:getEquipStarUpGrowthAttr(id, useStage)
	growthAtk = growthAtk + (starGrowthAttr and starGrowthAttr[EC_Attr.ATK] or 0)
	return (atk + (_lv - 1) * growthAtk) / 100;
end

function EquipmentDataMgr:getEquipBaseHp(id,lv,useStage)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local _lv = lv or self:getEquipLv(id);
	local hp = self.equipBase[cid].baseAttribute[EC_Attr.HP];
	local growthHp = self.equipBase[cid].growthAttribute[EC_Attr.HP]
	local starBaseAttr = self:getEquipStarUpBaseAttr(id, useStage)
	hp = hp + (starBaseAttr and starBaseAttr[EC_Attr.HP] or 0)
	local starGrowthAttr = self:getEquipStarUpGrowthAttr(id, useStage)
	growthHp = growthHp + (starGrowthAttr and starGrowthAttr[EC_Attr.HP] or 0)
	return (hp + (_lv - 1) * growthHp) / 100;
end

function EquipmentDataMgr:getEquipBaseDef(id,lv,useStage)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local _lv = lv or self:getEquipLv(id);
	local def = self.equipBase[cid].baseAttribute[EC_Attr.DEF];
	local growthDef = self.equipBase[cid].growthAttribute[EC_Attr.DEF]
	local starBaseAttr = self:getEquipStarUpBaseAttr(id, useStage)
	def = def + (starBaseAttr and starBaseAttr[EC_Attr.DEF] or 0)
	local starGrowthAttr = self:getEquipStarUpGrowthAttr(id, useStage)
	growthDef = growthDef + (starGrowthAttr and starGrowthAttr[EC_Attr.DEF] or 0)
	return (def + (_lv - 1) * growthDef) / 100;
end

function EquipmentDataMgr:getEquipSubType(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	elseif self.equips[id] then
		cid = self.equips[id].cid;
	else
		Bugly:ReportLuaException("errorEquipId:========================="..id)
	end

	local subType = -1
	if self.equipBase[cid] then
	 	subType = self.equipBase[cid].subType
	end
	return subType;
end

function EquipmentDataMgr:getEquipHalfPaint(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local halfPaint = self.equipBase[cid].halfPaint;
	return halfPaint;
end

function EquipmentDataMgr:getEquipHalfPaint2(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local halfPaint = self.equipBase[cid].equipPaint;
	dump(halfPaint)
	return halfPaint;
end

function EquipmentDataMgr:getEquipPaint(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local paint = self.equipBase[cid].paint;
	return paint;
end

function EquipmentDataMgr:getEquipPaintPosition(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local paintPosition = self.equipBase[cid].paintPosition;
	return paintPosition;
end

function EquipmentDataMgr:getEquipPaintScale(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local size = self.equipBase[cid].size;
	return size;
end

function EquipmentDataMgr:getEquipCost(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local cost = self.equipBase[cid].cost;
	return cost;
end

function EquipmentDataMgr:getEquipInherentAttrDesc(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local skillID = self.equipBase[cid].inherentAttribute;

	local descid = self.passiveSkills[skillID].des

	-- for k,v in pairs(attr) do
	-- 	if k >= 1000 then
	-- 		v = math.floor(v / 100);
	-- 	end
	-- 	desc = TextDataMgr:getText(EC_AttrAddText + k,v);
	-- end


	return descid;
end

function EquipmentDataMgr:getEquipInherentSkill(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local skillID = self.equipBase[cid].inherentAttribute;

	return skillID;
end

function EquipmentDataMgr:getEquipSpecialAttrs(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local attrs = self.equips[id].attrs;
	local ret = {};
	for k,v in pairs(attrs) do
		local _ret = {}
		_ret.id = v.cid;
		_ret._type = self.EquipmentRandom[_ret.id].attrType
		_ret._superType = self.EquipmentRandom[_ret.id].superType
		local descID = EC_AttrAddText + _ret._type;
		_ret.val = v.value / 100;
		_ret.desc = TextDataMgr:getText(descID,_ret.val);
		_ret.level = self.EquipmentRandom[_ret.id].level;
		_ret.index = v.index;
		table.insert(ret,_ret);
	end

	local function sort(a,b)
		if a.level == b.level then
			return a.id < b.id;
		else
			return a.level < b.level;
		end
	end

	table.sort( ret, sort )
	return ret;
end

function EquipmentDataMgr:getIsHaveSpecialAttr(id)
	if self:isCid(id) then
		return false
	end

	return self.equips[id].attrs ~= nil;
end

function EquipmentDataMgr:getEquipSpecialAttrsColors(id)
	if self:isCid(id) then
		return {}
	end
	if self.equips[id].attrs then
		local color = {}
		for k,v in pairs(attrs) do
			local level = self.EquipmentRandom[v.cid].level
			if table.indexOf(color, level) == -1 then
				table.insert(color,level)
			end
		end
		return color
	else
		return {}
	end
end

function EquipmentDataMgr:getEquipCombInfo(id, defalut)
	local ret = {};
	if not self.equips[id] and not defalut then
		return ret;
	end

	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local combination = self.equipBase[cid].combination;

    for k,v in pairs(combination) do
    	local combinationID = v;
    	local combinationNeed = TabDataMgr:getData("EquipmentCombination",v).needParticle;
    	ret[combinationID] = combinationNeed;
    end

    return ret;
end

function EquipmentDataMgr:getEquipCombSkillInfo(id)
	local ret = {};
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local combination = self.equipBase[cid].combination;
	local star = self:getEquipStarLv(id);
	for k,v in pairs(combination) do
    	local combinationID = v;
    	local skillTab = TabDataMgr:getData("EquipmentCombination",v).skill;
    	local needParticle = TabDataMgr:getData("EquipmentCombination",v).needParticle;
    	local skill = skillTab[star];
    	ret[combinationID] = ret[combinationID] or {};
    	ret[combinationID].skill = skill;
    	ret[combinationID].needParticle = needParticle;
    end

    return ret;
end

function EquipmentDataMgr:getEquipSuitInfo(id)
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end

	local suit = self.equipBase[cid].suit;
	return suit;
end

function EquipmentDataMgr:getEquipSuitInfos(id)
	if id == "none" then return {} end
	local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self.equips[id].cid;
	end
	local suitsData = {}
	local suit = self.equipBase[cid].suit
	for i, suitId in ipairs(suit) do
		for k, v in pairs(self.equipBase) do
			if table.indexOf(v.suit, suitId) ~= -1 then
				suitsData[suitId] = suitsData[suitId] or {}
				table.insert(suitsData[suitId], v.id)
			end
		end
	end
	return suitsData
end

function EquipmentDataMgr:getAllEquipSuitCfgs()
	local suitsCfgs = {}
	for k, v in pairs(self.equipBase) do
		if v.showType == 0 then
			for m, suitId in pairs(v.suit) do
				suitsCfgs[suitId] = suitsCfgs[suitId] or {}
				if table.indexOf(suitsCfgs[suitId], v.id) == -1 then
					table.insert(suitsCfgs[suitId], v.id)
				end
			end
		end
	end
	for k, suitIds in pairs(suitsCfgs) do
		table.sort(suitIds,function(a,b)
			return a < b
		end)
	end
	local sortData = {}
	for k, v in pairs(suitsCfgs) do
		table.insert(sortData,{suitId = k,equipCids = v})
	end
	table.sort(sortData,function(a,b)
		return a.suitId < b.suitId
	end)
	return sortData
end

function EquipmentDataMgr:useEquipment(heroId,pos,equipId)
	local msg = {
			HeroDataMgr:getHeroSid(heroId),
			equipId,
			pos,
	}

	TFDirector:send(c2s.EQUIPMENT_EQUIP,msg);
end

function EquipmentDataMgr:recvUseEquipment(event)
	dump(event.data);
	local cid = self.equips[event.data.equipment.id].cid;
	event.data.equipment.cid = cid;
	--更新进背包
	GoodsDataMgr:__equipmentHandle(event.data.equipment);

	if event.data.oldEquipment then
		event.data.oldEquipment.cid = self.equips[event.data.oldEquipment.id].cid;
		GoodsDataMgr:__equipmentHandle(event.data.oldEquipment);
	end

	EventMgr:dispatchEvent(EV_EQUIPMENT_OPERATION,event.data.equipment.id,true);
end

function EquipmentDataMgr:takeOffEquipment(heroId,equipmentId,pos)
	local msg = {
			HeroDataMgr:getHeroSid(heroId),
			equipmentId,
			pos,
	}
	self.takeoffID = equipmentId;
	TFDirector:send(c2s.EQUIPMENT_TAKE_OFF_EQUIPMENT,msg);
end

function EquipmentDataMgr:recvEquipTakeOffOK(event)
	EventMgr:dispatchEvent(EV_EQUIPMENT_OPERATION,self.takeoffID,false);
	self.takeoffID = nil;
end

function EquipmentDataMgr:equipLevelUp(id,needs)
	local function levelUp()
		local msg = {
			id,
		};

		table.insert(msg,needs)
		self.levelUpID = id
		self.useItems = needs
		TFDirector:send(c2s.EQUIPMENT_UPGRADE,msg);
	end

	for k,v in pairs(needs) do
		if self:getEquipStarLv(v) > 3 and not self:getStrengthTipsEnable() then
				local layer = require("lua.logic.Equipment.EquipStrengthTips"):new({okCallFunc = function(isok)
	            if isok then
	                levelUp();
	            end
	        end});
		    AlertManager:addLayer(layer)
		    AlertManager:show()
		    return;
		end
	end

	levelUp();
end

function EquipmentDataMgr:recvEquipmentLevelUp(event)
	EventMgr:dispatchEvent(EV_EQUIPMENT_OPERATION,self.levelUpID,true,self.useItems);
	self.useItems = nil;
	self.levelUpID = nil;

	local skyHeroId = SkyLadderDataMgr:getCheckHeroId()
	if skyHeroId then
		SkyLadderDataMgr:Send_GetHeroNewData({skyHeroId})
	end
end

function EquipmentDataMgr:equipConvert(equipId,attrIdxs,costEquipId,costAttrIndexs)
	local msg = {
		equipId,
		attrIdxs,
		costEquipId,
		costAttrIndexs
	};

	self.attrIdxs = attrIdxs
	self.costAttrIndexs = costAttrIndexs

	dump(msg)

	TFDirector:send(c2s.EQUIPMENT_CHANGE_SPECIAL_ATTR,msg);
end

function EquipmentDataMgr:equipReform(equipId,attrIdxs)
	local msg = {
		equipId,
		attrIdxs,
	};
	TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_REMOULD,msg);
end

function EquipmentDataMgr:setBackFromReform(equipId)
	self.reformEquipId = equipId
end

function EquipmentDataMgr:getBackFromReform()
	return self.reformEquipId
end

function EquipmentDataMgr:recvEquipConvert(event)
	dump(event.data);

	EventMgr:dispatchEvent(EQUIPMENT_CHANGE_SPECIAL_ATTR,event.data);
	local skyHeroId = SkyLadderDataMgr:getCheckHeroId()
	if skyHeroId then
		SkyLadderDataMgr:Send_GetHeroNewData({skyHeroId})
	end
end

function EquipmentDataMgr:equipConvertConfirm(data)

	EventMgr:dispatchEvent(EQUIPMENT_CHANGE_SPECIAL_ATTRTIPS,data)

end

function EquipmentDataMgr:recvEquipReform(event)

	dump(event.data)

	EventMgr:dispatchEvent(EQUIPMENT_REFORM_RESULT,event.data);
	local skyHeroId = SkyLadderDataMgr:getCheckHeroId()
	if skyHeroId then
		SkyLadderDataMgr:Send_GetHeroNewData({skyHeroId})
	end
end

function EquipmentDataMgr:equipConvertOK(equipId,isok)
	local msg = {
		equipId,
		isok
	};

	TFDirector:send(c2s.EQUIPMENT_REPLACE_SPECIAL_ATTR,msg);
end

function EquipmentDataMgr:getEquipRecycleItems(equipId)
	local msg = {
		equipId
	};

	TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_RECYCLE_INFO,msg);
end

function EquipmentDataMgr:recvEquipConvertOK(event)
	EventMgr:dispatchEvent(EQUIPMENT_REPLACE_SPECIAL_ATTR, event.data);
end

function EquipmentDataMgr:changeEquipLockStatus(equipmentId)
	TFDirector:send(c2s.EQUIPMENT_LOCK, {tostring(equipmentId)})
end

function EquipmentDataMgr:recvEquipLockStatus(event)
	local data = event.data
	if not data then return end
	self.equips[data.equipmentId].isLock = data.isLock
	EventMgr:dispatchEvent(EQUIPMENT_LOCK_RESULT)
end

function EquipmentDataMgr:recvEquipRecycle(event)
	EventMgr:dispatchEvent(EQUIPMENT_RECYCLERESULTS, event.data)
end

function EquipmentDataMgr:equipmentStarUp(id, costIds)
	local msg = {
		id,
		costIds,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_UP_STAR_EQUIP,msg)
end

function EquipmentDataMgr:equipmentStarUpOver(event)
	local data = event.data
	if data then
		GoodsDataMgr:__equipmentHandle(data.equipmentInfo)
	end
	EventMgr:dispatchEvent(EQUIPMENT_STAR_UP_OVER, data)
end

--新装备羁绊
function EquipmentDataMgr:recvNewEquipWearOrDrop(event)
	local data = event.data
	if data then
		GoodsDataMgr:syncHeroNewEquip(data)
		HeroDataMgr:updateEuqipFetterInfo(data)
		self:updateNewEquipMentEquipState(data)
	end
	EventMgr:dispatchEvent(EQUIPMENT_DRESS_NEW_EQUIP, data)
end

function EquipmentDataMgr:updateNewEquipMentEquipState(data)
	local heroId = data.heroId
	local euqipFetterInfo = data.euqipFetterInfo or {}
	if euqipFetterInfo then
		for k, v in pairs(euqipFetterInfo) do
			local newEquipmentInfo = v.newEquipmentInfo
			if self.newEquips[newEquipmentInfo.id] then
				table.merge(self.newEquips[newEquipmentInfo.id], newEquipmentInfo)
			end
		end
		for k,v in pairs(self.newEquips) do
			if tonumber(v.heroId) == tonumber(heroId) then
				local flag = true
				for k, equipment in pairs(euqipFetterInfo) do
					if v.id == equipment.newEquipmentInfo.id then
						flag = false
						break
					end
				end
				if flag then
					v.heroId = "0"
					v.position = "0"
				end
			end
		end
	else
		for k,v in pairs(self.newEquips) do
			if tonumber(v.heroId) == tonumber(heroId) then
				v.heroId = "0"
				v.position = "0"
			end
		end
	end
end

function EquipmentDataMgr:recvNewEquipStrengthen(event)
	local data = event.data
	local skyHeroId = SkyLadderDataMgr:getCheckHeroId()
	if skyHeroId then
		SkyLadderDataMgr:Send_GetHeroNewData({skyHeroId})
	end
	EventMgr:dispatchEvent(EQUIPMENT_STRENGTHEN_NEW_EQUIP, data)
end

function EquipmentDataMgr:recvNewEquipAdvance(event)
	local data = event.data
	local skyHeroId = SkyLadderDataMgr:getCheckHeroId()
	if skyHeroId then
		SkyLadderDataMgr:Send_GetHeroNewData({skyHeroId})
	end
	EventMgr:dispatchEvent(EQUIPMENT_ADVANCE_NEW_EQUIP, data)
end

function EquipmentDataMgr:recvEquipRecycleItems(event)
	EventMgr:dispatchEvent(EQUIPMENT_GETRECYCLEITEMS, event.data)
end

function EquipmentDataMgr:recvEquipReformNums(event)
	EventMgr:dispatchEvent(EQUIPMENT_RES_EQUIP_REMOULD_INFO, event.data)
end

--穿戴或卸下宝石
function EquipmentDataMgr:reqEquipGemOrDrop(cType,heroId,gemId,idx)
	local msg = {
			cType,
			heroId,
			gemId,
			idx,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_GEM,msg)
end

function EquipmentDataMgr:reqComposeGem(id,designId,gemIds)
	local msg = {
			id,
			designId,
			gemIds,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_COMPOSE_GEM,msg)
end

function EquipmentDataMgr:recvDressGems(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_GEM_DRESS_OR_DROP, data)
end

--合成宝石
function EquipmentDataMgr:recvComposeGems(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_GEM_COMPOSE, data)
end

function EquipmentDataMgr:initShowList(heroId,pos,isSkyLadder)
	self.showList = {}
	local function getOtherPosSubType(heroId,pos1,pos2)
		local other1,ohter2 = -1 ,-1
		local equip1 = HeroDataMgr:getEquipIdByPos(heroId,pos1)
		if equip1 ~= "none" then
			other1 = self:getEquipSubType(equip1)
		else
			other1 = -1;
		end
		local equip2 = HeroDataMgr:getEquipIdByPos(heroId,pos2)
		if equip2 ~= "none" then
			other2 = self:getEquipSubType(equip2)
		else
			other2 = -1
		end

		return other1,other2;
	end

	local otherType1,otherType2
	if pos == 1 then
		otherType1,otherType2 = getOtherPosSubType(heroId,2,3)
	elseif pos == 2 then
		otherType1,otherType2 = getOtherPosSubType(heroId,1,3)
	else
		otherType1,otherType2 = getOtherPosSubType(heroId,1,2)
	end


	local function checkFilter(id)
		if not self.filter or table.count(self.filter) <= 0 then
			return false
		end

		for k,v in pairs(self.filter) do
			if v == id then
				return true;
			end
		end

		return false;
	end

	local herosid = HeroDataMgr:getHeroSid(heroId);
	--全部
	for k,v in pairs(self.equips) do
		local continue = true;
		local subType  = self:getEquipSubType(v.id);

		if checkFilter(v.id) then
			continue = false
		elseif subType == EC_EquipSubType.Daat or subType == EC_EquipSubType.Wanneng then
			continue = false;
			--elseif self:isUesing(v.id) and v.heroId ~= herosid then
			--	continue = false;
		-- elseif self:getEquipIsLock(v.id) then
		-- 	continue = false;
		elseif self:isUesing(v.id) and v.heroId == herosid and v.position ~= pos then
			continue = false;
		elseif otherType1 ~= -1 and otherType1 == subType then
			continue = false;
		elseif otherType2 ~= -1 and otherType2 == subType then
			continue = false;
		end

		if isSkyLadder then
			local bindHero = SkyLadderDataMgr:getSkyHeroEquipBind(v.id)
			if bindHero and bindHero ~= heroId then
				continue = false
			end
		end

		if continue then
			--排除模拟试炼的质点
			if self:getEquipShowType(v.id) == 0 then
				table.insert(self.showList,v.id);
			end
		end
	end

	self.combList = {}
	--组合

	local function getSame(tab,id)
		for k,v in pairs(tab) do
			if v == id then
				return true
			end
		end
		return false
	end

	for i,v in ipairs(self.showList) do
		if pos == 1 then
			local info = HeroDataMgr:checkCombByPos(heroId,1,2,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end

			local info = HeroDataMgr:checkCombByPos(heroId,1,3,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end
		elseif pos == 2 then
			local info = HeroDataMgr:checkCombByPos(heroId,1,1,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end

			local info = HeroDataMgr:checkCombByPos(heroId,1,3,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end
		else
			local info = HeroDataMgr:checkCombByPos(heroId,1,1,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end

			local info = HeroDataMgr:checkCombByPos(heroId,1,2,v);
			if info.isok and not getSame(self.combList,v) then
				table.insert(self.combList,v)
			end
		end
	end

	--同类
	self.sameList = {}
	local ishave = HeroDataMgr:getIsHaveEquip(heroId,pos)
	if ishave then
		local id = HeroDataMgr:getEquipIdByPos(heroId,pos);
		local subType = self:getEquipSubType(id);
		for i,v in ipairs(self.showList) do
			if self:getEquipSubType(v) == subType then
				table.insert(self.sameList,v);
			end
		end
	end

	local sortfunc = function(a,b)
		local aCid = self:getEquipCid(a);
		local bCid = self:getEquipCid(b);
		local aStar = self:getEquipStarLv(a);
		local bStar = self:getEquipStarLv(b);
		local aLv 	= self:getEquipLv(a);
		local bLv	= self:getEquipLv(b);
		local aSuit = self:getEquipSuitInfo(a)
		local bSuit = self:getEquipSuitInfo(b)
		local aUse  = self:isUesing(a);
		if aUse then aUse = 1;else aUse = 0 end
		local bUse 	= self:isUesing(b);
		if bUse then bUse = 1;else bUse = 0 end

		--if aUse == bUse then
		--	if aStar == bStar then
		--		if aLv == bLv then
		--			return aCid < bCid;
		--		else
		--			return aLv > bLv
		--		end
		--	else
		--		return aStar > bStar;
		--	end
		--else
		--	return aUse > bUse
		--end
		if self:getHeroSid(a) == tostring(heroId) and self:getHeroSid(b) ~= tostring(heroId) then
			return true
		end

		if self:getHeroSid(b) == tostring(heroId) and self:getHeroSid(a) ~= tostring(heroId) then
			return false
		end

		if aUse == bUse then
			if aStar == bStar then
				if aCid == bCid then
					return aLv > bLv
				else
					return aCid < bCid
				end
			else
				return aStar > bStar;
			end
		else
			return aUse > bUse
		end

	end

	table.sort(self.showList,sortfunc);
	table.sort(self.combList,sortfunc);
	table.sort(self.sameList,sortfunc);

	local function Grouping(list)
		local showList = {}
		local num = 0;
		local idx = 0;
		for i,v in ipairs(list) do
			num = num + 1;
			if num % 4 == 1 then
				idx = idx + 1;
			end

			showList[idx] = showList[idx] or {};
			table.insert(showList[idx],v);
		end
		return showList,num;
	end
	local allnum,combnum,samnum
	self.showList,allnum = Grouping(self.showList);
	self.combList,combnum = Grouping(self.combList);
	self.sameList,samnum = Grouping(self.sameList);
	return self.showList,allnum,self.combList,combnum,self.sameList,samnum;
end

function EquipmentDataMgr:initShowListByStrengthen(equipmentId)
	self.showList = {}
	for k,v in pairs(self.equips) do
		--排除模拟试炼的质点
		if self:getEquipShowType(v.id) == 0 then
			if v.star < 1 and v.stage < 1 and not self:isUesing(v.id) and v.id ~= equipmentId and not self:getEquipIsLock(v.id) then
				local equipCid = self:getEquipCid(v.id)
				local goodsCfg = GoodsDataMgr:getItemCfg(equipCid)
				if goodsCfg.subType == 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
					local index = self:getMergeEquipIndex(equipCid)
					if not index then
						local tab = {}
						tab.id = v.id
						tab.merge = {}
						table.insert(tab.merge,v.id)
						table.insert(self.showList,tab);
					else
						table.insert(self.showList[index].merge,v.id)
					end
				else
					table.insert(self.showList,{id = v.id});
				end
			end
		end
	end

	local sortfunc = function(a,b)
		local aCid 	= self.equips[a.id].cid
		local bCid 	= self.equips[b.id].cid
		local aMax 	= self.equipBase[aCid].maxLevel;
		local bMax 	= self.equipBase[bCid].maxLevel;
		local aexp 	= self:getEquipTotalExp(a.id);
		local bexp 	= self:getEquipTotalExp(b.id);
		local aType	= self:getEquipSubType(a.id);
		local bType	= self:getEquipSubType(b.id);
		if aMax == bMax then
			if aexp == bexp then
				if aType == bType then
					return aCid < bCid;
				else
					return aType < bType;
				end
			else
				return aexp < bexp;
			end
		else
			return aMax < bMax;
		end
	end

	table.sort(self.showList,sortfunc);
	return self.showList;
end

function EquipmentDataMgr:getMergeEquipIndex(cid)
	for k,v in ipairs(self.showList) do
		local equipCid = self:getEquipCid(v.id)
		if equipCid == cid then
			return k
		end
	end
end

function EquipmentDataMgr:initShowListByConvert(equipId)
	local showList = {}
	local subType = self:getEquipSubType(equipId);
	for k,v in pairs(self.equips) do
		if not self:isUesing(v.id) and 
			self:getIsHaveSpecialAttr(v.id) 	and
			v.id ~= equipId 					and
			not self:getEquipIsLock(v.id) 		and 
			self:getEquipStarLevel(v.id) < 1 	then
			   	--排除模拟试炼的质点
			   	if self:getEquipShowType(v.id) == 0 then
					table.insert(showList,v.id);
				end
		end
	end

	local sortfunc = function(a,b)
		local aCid = self:getEquipCid(a);
		local bCid = self:getEquipCid(b);
		local aStar = self:getEquipStarLv(a);
		local bStar = self:getEquipStarLv(b);
		local aLv 	= self:getEquipLv(a);
		local bLv	= self:getEquipLv(b);

		if aStar == bStar then
			if aLv == bLv then
				return aCid < bCid;
			else
				return aLv < bLv;
			end
		else
			return aStar > bStar;
		end
	end

	table.sort(showList,sortfunc);

	self.showList = {};
	local num = 0;
	local idx = 0;
	for i,v in ipairs(showList) do
		num = num + 1;
		if num % 4 == 1 then
			idx = idx + 1;
		end

		self.showList[idx] = self.showList[idx] or {};
		table.insert(self.showList[idx],v);
	end

	return self.showList,num;
end

function EquipmentDataMgr:setStrengthTipsEnable(time)
	CCUserDefault:sharedUserDefault():setStringForKey(MainPlayer:getPlayerName().."strengthTime",time);
end

function EquipmentDataMgr:getStrengthTipsEnable()
	local time = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerName().."strengthTime");
	if time == "" or time == "0" then
		return false
	end

	time = tonumber(time);

	local date = os.date("*t",time);
	local curdate = os.date("*t",os.time());

	if date.day == curdate.day then
		return true
	end

	return false;
end

function EquipmentDataMgr:getEquipCfg(cid)
    return self.equipBase[cid]
end

function EquipmentDataMgr:getEquipIsLock(id)
	if self:isCid(id) then
		return false;
	end
	return tobool(self.equips[id].isLock)
end

function EquipmentDataMgr:getEquipIsLockOrUsing(id)
	if self:isCid(id) then
		return false;
	end
	return tobool(self.equips[id].isLock) or self.equips[id].heroId ~= "0"
end

function EquipmentDataMgr:getXilianNeedGold(starLv, xilianCount)
	for k, v in pairs(self.EquipmentXilian) do
		if v and v.star == starLv and v.attributeNum == xilianCount then
			return v.gifts[500001] or 0
		end
	end
	return 0
end

function EquipmentDataMgr:getEquipRecycleResults(equipmentId)
	local star = self:getEquiGrowthpStar(id)
    local lv     = self:getEquipLv(equipmentId)
    local totalExpCur = self:getEquipCurExp(equipmentId)
    for i=1,lv - 1 do
        totalExpCur = totalExpCur + TabDataMgr:getData("EquipmentGrowth",star).needExp[i];
    end
    local ratio = TabDataMgr:getData("DiscreteData",4005).data.ratio
    local totalExp = totalExpCur * ratio / 10000
    local size = table.getn(TabDataMgr:getData("DiscreteData",4004).data.equipment)
    local item = {}
    for i = 1, size do
    	item[i] = TabDataMgr:getData("DiscreteData",4004).data.equipment[i]
    end

    local exp = {}
    for i = 1, size do
    	exp[i] = self:getEquipTotalExp(item[i])
    end
   
    local num = {}
    local yu = totalExp
    for i = 1, size do
    	local prev = yu
    	yu = yu % exp[i]
    	num[i] = (prev - yu) / exp[i] 
    end

    local strengthRatio = TabDataMgr:getData("DiscreteData",4002).data.ratio
    local goldNum = totalExp * strengthRatio / 10000

    local results = {}
    local index = 1
    for i = 1, size do
    	if num[i] ~= 0 then
    		results[index] = {id = item[i], num = num[i]}
    		index = index + 1
    	end
    end
    if goldNum ~= 0 then
    	results[index] = {id = EC_SItemType.GOLD, num = goldNum}
    end

    return results

end

--新装备羁绊相关
function EquipmentDataMgr:sendReqEquipDressOrDrop(sType, heroId, equipId, pos)
	TFDirector:send(c2s.EQUIPMENT_REQ_DRESS_NEW_EQUIP, {sType, tostring(heroId), tostring(equipId), pos})
end

function EquipmentDataMgr:sendReqEquipStrengthen(heroId, pos)
	local euipMent = HeroDataMgr:getNewEquipInfoByPos(heroId, pos)
	local equipInfo = self:getNewEquipInfoByCid(euipMent.cid)
	TFDirector:send(c2s.EQUIPMENT_REQ_STRENGTHEN_NEW_EQUIP, {equipInfo.id})
end

function EquipmentDataMgr:sendReqEquipAdvance(heroId, pos)
	local euipMent = HeroDataMgr:getNewEquipInfoByPos(heroId, pos)
	local equipInfo = self:getNewEquipInfoByCid(euipMent.cid)
	TFDirector:send(c2s.EQUIPMENT_REQ_ADVANCE_NEW_EQUIP, {equipInfo.id})
end

function EquipmentDataMgr:getNewEquipInfoByCid(cid)
	for k, v in pairs(self.newEquips) do
		if v.cid == cid then
			return v
		end
	end
end

function EquipmentDataMgr:checkNewEquipInUse(cid)
	for k, v in pairs(self.newEquips) do
		if v.cid == cid and tonumber(v.heroId) > 0 then
			return true
		end
	end
	return false
end

function EquipmentDataMgr:checkNewEquipSuitEnableEffect(heroId, suitId)
	local suitCfg = self:getNewEquipSuitCfg(suitId)
	if #suitCfg.Exclusive < 1 or self:checkHeroIdInSuit(suitCfg.Exclusive, heroId) then
		return true
	end
	return false
end

function EquipmentDataMgr:getAllNewEquips()
	return self.newEquips
end

function EquipmentDataMgr:getAllNewEquipsCount()
	return table.count(self.newEquips)
end

function EquipmentDataMgr:getSingleNewEquipsCount()
	local count = 0
	for k,v in pairs(self.newEquips) do
		local cfg = self:getNewEquipCfg(v.cid)
		if tonumber(cfg.suitId) < 1 then
        	count = count + 1
        end
	end
	return count
end

function EquipmentDataMgr:getNewEquipsBySortType(heroId, sType, isSkyLadder)
	local sortfunc = function(a,b)
		local acfg = self:getNewEquipCfg(a.cid)
		local bcfg = self:getNewEquipCfg(b.cid)
		local ainfo = self:getNewEquipInfoByCid(a.cid)
		local binfo = self:getNewEquipInfoByCid(b.cid)
		local aCid = a.cid
		local bCid = b.cid
		local alevel = ainfo.level
		local blevel = binfo.level
		local aStar = acfg.endStar
		local bStar = bcfg.endStar
		local aquality = acfg.quality
		local bquality = bcfg.quality
		local aUse  = self:checkNewEquipInUse(a.cid)
		if aUse then aUse = 1 else aUse = 0 end
		local bUse 	= self:checkNewEquipInUse(b.cid)
		if bUse then bUse = 1 else bUse = 0 end

		if aUse == bUse then
			if aquality == bquality then 
				if aStar == bStar then
					if alevel == blevel then
						return aCid < bCid
					else
						return alevel > blevel
					end
				else
					return aStar > bStar
				end
			else
				return aquality > bquality
			end
		else
			return aUse > bUse
		end
	end
	local equips = {}
	if sType == 1 then
		for k,v in pairs(self.newEquips) do
			local cfg = self:getNewEquipCfg(v.cid)
	        if cfg.display and tonumber(v.heroId) ~= tonumber(heroId) then
				if not isSkyLadder then
					equips[#equips + 1] = v
				else
					local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind(v.id)
					if not bindHero then
						equips[#equips + 1] = v
					elseif bindHero and bindHero ==tonumber(heroId) then
						equips[#equips + 1] = v
					end
				end
			end
		end
	elseif sType == 2 then
		local suitCIds = {}
		for k,v in pairs(self.newEquips) do
			local cfg = self:getNewEquipCfg(v.cid)
		    if cfg.display and tonumber(v.heroId) == tonumber(heroId) then
		    	if tonumber(cfg.suitId) > 0 then
		    		local suitCfg = self:getNewEquipSuitCfg(cfg.suitId)
		    		for k, cid in pairs(suitCfg.suitarmsID) do
		    			if table.indexOf(suitCIds, cid) == -1 then
							table.insert(suitCIds, cid)
						end
		    		end
		    	end
		    end
		end

		for i, cid in ipairs(suitCIds) do
			local equipInfo = self:getNewEquipInfoByCid(cid)
			if equipInfo and tonumber(equipInfo.heroId) ~= tonumber(heroId) then
				if not isSkyLadder then
					equips[#equips + 1] = equipInfo
				else
					local bindHero = SkyLadderDataMgr:getSkyHeroNewEquipBind(equipInfo.id)
					if not bindHero then
						equips[#equips + 1] = equipInfo
					elseif bindHero and bindHero == tonumber(heroId) then
						equips[#equips + 1] = equipInfo
					end
				end
			end
		end
	end
	table.sort(equips, sortfunc)

	return equips
end

function EquipmentDataMgr:getNewEquipsCfgDataArray()
	local sortfunc = function(acfg, bcfg)
		local ainfo = self:getNewEquipInfoByCid(acfg.id)
		local binfo = self:getNewEquipInfoByCid(bcfg.id)
		local alevel = ainfo and ainfo.level or 1
		local blevel = binfo and binfo.level or 1
		local aStar = ainfo and ainfo.stage or acfg.star
		local bStar = binfo and binfo.stage or bcfg.star
		local aquality = acfg.quality
		local bquality = bcfg.quality

		if aquality == bquality then
			if aStar == bStar then
				if alevel == blevel then
					return acfg.id > bcfg.id
				else
					return alevel > blevel
				end
			else
				return aStar > bStar
			end
		else
			return aquality < bquality
		end
	end

	local cfgsArray = {}
	for k,v in pairs(self.NewEquip) do
		if v.display and tonumber(v.suitId) < 1 then
        	cfgsArray[#cfgsArray + 1] = v
        end
	end

	table.sort(cfgsArray, sortfunc)

	return cfgsArray
end

function EquipmentDataMgr:getOwnEquipNumInSuit(suitId)
	local num = 0
	local suitCfg = self.NewEquipSuit[tonumber(suitId)]
	local flag = true
	for i,cid in ipairs(suitCfg.suitarmsID) do
		local cfg = self:getNewEquipCfg(cid)
		if not cfg.display then
			flag = false
			break
		end
	end
	if flag then
		for i,cid in ipairs(suitCfg.suitarmsID) do
			for k,v in pairs(self.newEquips) do
		        if tonumber(v.cid) == tonumber(cid) then
					num = num + 1
				end
			end
		end
	end
	return num
end

function EquipmentDataMgr:getNewEquipsSuitCfgArray()
	local sortfunc = function(acfg, bcfg)
		return acfg.id < bcfg.id
	end
	local cfgArray = {}
	for k,v in pairs(self.NewEquipSuit) do
		local flag = true
		for i,cid in ipairs(v.suitarmsID) do
			local cfg = self:getNewEquipCfg(cid)
			if not cfg.display then
				flag = false
				break
			end
		end
		if flag then
			cfgArray[#cfgArray + 1] = v
		end
	end
	table.sort(cfgArray, sortfunc)

	return cfgArray
end

function EquipmentDataMgr:getNewEquipCfg(equipCid)
	return self.NewEquip[equipCid]
end

function EquipmentDataMgr:getNewEquipSuitCfg(suitId)
	return self.NewEquipSuit[tonumber(suitId)]
end

function EquipmentDataMgr:getNewEquipSkillCfgBySuitId(suitId)
	if self.NewEquipSuit[tonumber(suitId)] then
		return  self:getNewEquipSkillCfg(self.NewEquipSuit[tonumber(suitId)].suitSkill)
	end
end

function EquipmentDataMgr:getNewEquipSkillCfg(skillId)
	return self.NewEquipSkill[skillId]
end

function EquipmentDataMgr:getNewEquipStrengthenCfg(lv)
	for k,v in pairs(self.NewEquipStrengthen) do
		if v.equiplv == lv then
			return v
		end
	end
end

function EquipmentDataMgr:getNewEquipSuitEffectByHeroId(heroId)
	local suitIds = {}
	for k, suit in pairs(self.NewEquipSuit) do
		if #suit.Exclusive < 1 or self:checkHeroIdInSuit(suit.Exclusive, heroId) then
			local flag = true
			for i, cid in ipairs(suit.suitarmsID) do
				local sflag = true
			 	for k,equipment in pairs(self.newEquips) do
					if tonumber(equipment.heroId) == tonumber(heroId) and equipment.cid == cid then
						sflag = false
					end
				end
				if sflag then
					flag = false
				end
			 end
			if flag then
				suitIds[#suitIds + 1] = suit.id
			end 
		end
	end
	return suitIds
end

function EquipmentDataMgr:getNewEquipSkillEffectByHeroId(heroId)
	local suitIds = self:getNewEquipSuitEffectByHeroId(heroId)
	local skillIs = {}
	for i,suitId in ipairs(suitIds) do
		local suitSkillCfg = self:getNewEquipSkillCfg(self:getNewEquipSuitCfg(suitId).suitSkill)
		if suitSkillCfg then
			skillIs[#skillIs + 1] = suitSkillCfg.suitSkill
		end
	end
	return skillIs
end

function EquipmentDataMgr:getNewEquipOwnNumBySuitId(suitId)
	local num = 0
	local suitarmsIDs = self:getNewEquipSuitCfg(suitId).suitarmsID
	for i, v in ipairs(suitarmsIDs) do
		for k,equipment in pairs(self.newEquips) do
			if  equipment.cid == v then
				num = num + 1
			end
		end
	end
	return num
end

function EquipmentDataMgr:checkHeroIdInSuit(exclusive, heroId)
	for i,v in ipairs(exclusive) do
		if v == tonumber(heroId) then
			return true
		end
	end
	return false
end

function EquipmentDataMgr:getNewEquipAdvanceCfg(equipCid, stage)
	local equipCfg = self:getNewEquipCfg(equipCid)
	local equipInfo = self:getNewEquipInfoByCid(equipCid)
	local realStage = stage or (equipInfo and equipInfo.stage or equipCfg.star)
    local advanceId = equipCfg.attribute * 100 + realStage
	for k,v in pairs(self.NewEquipAdvance) do
		if v.id == advanceId then
			return v
		end
	end
end

function EquipmentDataMgr:getNewEquipMaxLevel(equipCid)
	local equipCfg = self:getNewEquipCfg(equipCid)
    local maxLevel = 1
	for k,v in pairs(self.NewEquipAdvance) do
		if math.floor(v.id / 100) == equipCfg.attribute and v.Advlevel <= equipCfg.endStar then
			maxLevel = math.max(maxLevel, v.limitLevel)
		end
	end
	return maxLevel
end

function EquipmentDataMgr:getNewEquipMaxStar(equipCid)
	local equipCfg = self:getNewEquipCfg(equipCid)
	return equipCfg.endStar
end

function EquipmentDataMgr:checkNewEquipReachMaxLv(equipCid)
	if self:getNewEquipInfoByCid(equipCid).level >= self:getNewEquipMaxLevel(equipCid) then
		return true
	end
	return false
end

function EquipmentDataMgr:getHeroNewEquipAttribute(heroId)
	local equipFetterInfo = HeroDataMgr:getNewEquipFetterInfo(heroId)
	local allValus = {}
	if equipFetterInfo then
		for k,v in pairs(equipFetterInfo) do
			if v.newEquipmentInfo then
				local attrValues = self:getNewEquipCurAttribute(v.newEquipmentInfo.cid)
				for k,v in pairs(attrValues) do
					allValus[k] = (allValus[k] or 0) + v
				end
			end
		end
	end
	return allValus
end

function EquipmentDataMgr:getNewEquipCurAttribute(equipCid, stage, level)
	local equipInfo = self:getNewEquipInfoByCid(equipCid)
    local equipCfg = self:getNewEquipCfg(equipCid)
    local advanceCfg = self:getNewEquipAdvanceCfg(equipCid, stage)

    local attrValues = {}
    for k, baseValue in pairs(advanceCfg.Attr) do
    	local realLevel = level or (equipInfo and equipInfo.level or equipCfg.level)
    	local upValue = advanceCfg.upAttr[k] or 0
    	local value = baseValue +  (upValue * math.max((realLevel - 1), 0))
    	value = string.format("%.1f", (value / 100))
    	attrValues[k] = tonumber(value)
    end
    return attrValues
end

function EquipmentDataMgr:getNewEquipStarPosArrar(starNum)
	local equip_star_pos = {
	    {ccp(0,-52)},
	    {ccp(-8,-50),ccp(8,-50)},
	    {ccp(-15,-48),ccp(0,-52),ccp(15,-48)},
	    {ccp(-22,-44),ccp(-8,-50),ccp(8,-50),ccp(22,-44)},
	    {ccp(-28,-40),ccp(-15,-48),ccp(0,-52),ccp(15,-48),ccp(28,-40)}
	}
	return equip_star_pos[starNum]
end

function EquipmentDataMgr:getNewEquipQualityIcon(quality)
	if quality == 2 then
		return "ui/new_equip/005.png"
	elseif quality == 3 then
		return "ui/new_equip/004.png"
	elseif quality == 4 then
		return "ui/new_equip/002.png"
	elseif quality == 5 then
		return "ui/new_equip/003.png"
	end
	return "ui/new_equip/005.png"
end


--宝石
function EquipmentDataMgr:getAllGemsData()
	return self.gemsData
end

function EquipmentDataMgr:getGemCfg(cid)
	return self.StoneCfgMap[cid]
end

function EquipmentDataMgr:getGemInfo(id)
	return self.gemsData[id]
end

function EquipmentDataMgr:getGemInfosByHeroIdAndPos(heroId, pos, raritys)
	local gemInfos = {}
	for k, v in pairs(self.gemsData) do
		local cfg = self:getGemCfg(v.cid)
		if cfg.heroId == heroId and cfg.skillType == pos then
			if raritys and #raritys > 0 then
				if table.indexOf(raritys, cfg.rarity) ~= -1 then
					table.insert(gemInfos, v)
				end
			else
			    table.insert(gemInfos, v)
			end 
		end
	end

	local gemInfo = HeroDataMgr:getGemInfoByPos(heroId, pos)
	local sortfunc = function(a,b)
		local aCfg = self:getGemCfg(a.cid)
		local bCfg = self:getGemCfg(b.cid)
		local aUse, bUse
		if gemInfo and gemInfo.id == a.id then aUse = 1 else aUse = 0 end
		if gemInfo and gemInfo.id == b.id then bUse = 1 else bUse = 0 end

		if aUse == bUse then
			if aCfg.quality == bCfg.quality then
				return a.cid > b.cid
			else
				return aCfg.quality > bCfg.quality
			end
		else
			return aUse > bUse
		end
	end
	table.sort(gemInfos,sortfunc)

	return gemInfos
end

function EquipmentDataMgr:getUnUseGemInfosByHeroIdAndPos(rarity, heroId, pos)
	local gemInfos = {}
	for k, v in pairs(self.gemsData) do
		local cfg = self:getGemCfg(v.cid)
		local pId = heroId or cfg.heroId
		local pPos = pos or cfg.skillType
		if v.heroId < 1 
			and cfg.rarity == rarity 
			and cfg.heroId == pId then
			if pPos == 0 or cfg.skillType == pPos  then
				table.insert(gemInfos, v)
			end
		end			
	end

	local sortfunc = function(a,b)
		return a.cid < b.cid
	end
	table.sort(gemInfos,sortfunc)

	return gemInfos
end

function EquipmentDataMgr:getCanDecomposeGemInfos(isTuzhi)
	if isTuzhi then return self:getCanDecomposeTuzhi() end
	local gemInfos = {}
	for k, v in pairs(self.gemsData) do
		local cfg = self:getGemCfg(v.cid)
	
		if cfg.decompose and v.heroId < 1 then
			table.insert(gemInfos, v)
		end			
	end

	local sortfunc = function(a,b)
		local cfga = self:getGemCfg(a.cid)
		local cfgb = self:getGemCfg(b.cid)
		if cfga.rarity == cfgb.rarity then
			return a.cid > b.cid
		end
		return cfga.rarity > cfgb.rarity
	end
	table.sort(gemInfos,sortfunc)

	return gemInfos
end

function EquipmentDataMgr:getCanDecomposeTuzhi()
	local tuZhis = {}
	for k,v in pairs(self.StoneCfgMap) do
		local num = GoodsDataMgr:getItemCount(v.id)
		if v.superType == 44 and v.decompose and num > 0 then
			table.insert(tuZhis,{cid = v.id, id = v.id, num = num})
		end
	end
	table.sort( tuZhis, function ( a , b )
		local cfga = self:getGemCfg(a.cid)
		local cfgb = self:getGemCfg(b.cid)
		if cfga.rarity == cfgb.rarity then
			return a.cid > b.cid
		end
		return cfga.rarity > cfgb.rarity
	end )
	return tuZhis
end

function EquipmentDataMgr:getRarityCanDecomposeGem(isTuzhi)
	-- body
	local raritys = {}
	local gemInfos = self:getCanDecomposeGemInfos(isTuzhi)
	for k,v in pairs(gemInfos) do		
		local cfg = self:getGemCfg(v.cid)
		raritys[cfg.rarity] = true
	end
	return table.keys(raritys)
end

function EquipmentDataMgr:getGemComposeCfgs(rarity, heroId, pos)
	local cfgs = {}
	for k, v in pairs(self.StoneComposeCfgMap) do
		if v.needDrawing then
			local condition = v.materialCondition
			local pId = heroId or condition[2]
			local gemCfg = self:getGemCfg(v.drawingId)
			local pPos = pos or gemCfg.skillType
			if v.rarity == rarity
				and condition[2] == pId then
				if pPos == 0 or gemCfg.skillType == pPos then
					table.insert(cfgs, v)
				end
			end
		else
			if v.rarity == rarity then
				table.insert(cfgs, v)
			end
		end
	end

	local sortfunc = function(a,b)
		if a.graph == b.graph then
			return a.drawingId < b.drawingId
		else
			return a.graph < b.graph
		end
	end
	table.sort(cfgs,sortfunc)

	return cfgs
end

function EquipmentDataMgr:getHeroOwnTuzhiInfos(rarity)
	local infos = {}
    local composeCfgs = self:getGemComposeCfgs(rarity)
    local count = HeroDataMgr:getShowCount()
    for i=1,count do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        infos[heroId] = {id = heroId, num = 0, posNum = {0,0,0,0}}
    end
    for k, v in pairs(composeCfgs) do
    	if v.needDrawing then
	        local condition = v.materialCondition
	        local num = GoodsDataMgr:getItemCount(v.drawingId)
	        local tuzhiCfg = self:getGemCfg(v.drawingId)
	        if num > 0 then
	            local info = infos[condition[2]]
	            local posNum = info.posNum[tuzhiCfg.skillType]
	            info.num = info.num + num
	            info.posNum[tuzhiCfg.skillType] = info.posNum[tuzhiCfg.skillType] + num
	        end
	    end
    end
    local heroInfos = {}
    for k, v in pairs(infos) do
    	table.insert(heroInfos, v)
    end
    table.sort(heroInfos, function(a,b)
    	return a.num > b.num
    end)
    return heroInfos
end

function EquipmentDataMgr:getHeroOwnGemInfos(rarity)
	local infos = {}
	local gemInfos = self:getUnUseGemInfosByHeroIdAndPos(rarity)
    local count = HeroDataMgr:getShowCount()
    for i=1,count do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        infos[heroId] = {id = heroId, num = 0, posNum = {0,0,0,0}}
    end
    for k, v in pairs(gemInfos) do
    	local cfg = self:getGemCfg(v.cid)
    	if cfg.rarity == rarity then
	    	local info = infos[cfg.heroId]
	        info.num = info.num + 1
	        info.posNum[cfg.skillType] = info.posNum[cfg.skillType] + 1
	    end
    end
    local heroInfos = {}
    for k, v in pairs(infos) do
    	table.insert(heroInfos, v)
    end
    table.sort(heroInfos, function(a,b)
    	return a.num > b.num
    end)
    return heroInfos
end

function EquipmentDataMgr:checkGemInUse(id)
	for k, v in pairs(self.gemsData) do
		if v.id == id and v.heroId > 1 then
			return true
		end
	end

	return false
end

function EquipmentDataMgr:getGemCountByCid(cid)
	local count = 0
	for k, v in pairs(self.gemsData) do
		if v.cid == cid then
			count = count + 1
		end
	end

	return count
end
--宝石重铸
function EquipmentDataMgr:reqRemouldGem(gemId,attrID)
	local msg = {
			gemId,
			attrID,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_REMOULD_GEM,msg)
end

--宝石重铸属性选择
function EquipmentDataMgr:reqRemouldedGem(gemId,isRetain)
	local msg = {
			gemId,
			isRetain,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_REMOULDED_GEM,msg)
end

--分解宝石
function EquipmentDataMgr:reqDecomposeGem(gemIds)
	TFDirector:send(c2s.EQUIPMENT_REQ_DECOMPOSE_GEM,{gemIds})
end

--分解宝石
function EquipmentDataMgr:reqDecomposeGemSigns(gemSigns)
	TFDirector:send(c2s.EQUIPMENT_REQ_DECOMPOSE_GEM_DESIGN,{gemSigns})
end

--合成宝石或者图纸
function EquipmentDataMgr:reqRecomposeGem(heroId,rarity,index,ctype)
	local msg = {
			heroId,
			rarity,
			index,
			ctype,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_RECOMPOSE_GEM,msg)
end

function EquipmentDataMgr:recvRemouldGem(event)
	local data = event.data
	self:syncServerGems(data.gem)
	EventMgr:dispatchEvent(EQUIPMENT_GEM_REMOULD_GEM,event.data)
end

function EquipmentDataMgr:recvRemouldChoose(event)
	local data = event.data
	self:syncServerGems(data.gem)
	EventMgr:dispatchEvent(EQUIPMENT_GEM_REMOULDED_GEM,event.data)
end

function EquipmentDataMgr:recvDecomposeGem(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_GEM_DECOMPOSE_GEM,event.data)
end

function EquipmentDataMgr:recvDecomposeGemSign(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_GEM_DECOMPOSE_GEM,event.data)
end



function EquipmentDataMgr:recvRecomposeGem(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_GEM_RECOMPOSE_GEM,event.data)
end

function EquipmentDataMgr:getRemouldingGem()
	for k, v in pairs(self.gemsData) do
		if v.randSkillTemp then
			return v
		end
	end
end

function EquipmentDataMgr:getGemComposeBg(graph)
	if graph == 3 then
		return "ui/fairy/new_ui/baoshi/027.png"
	elseif graph == 4 then
		return "ui/fairy/new_ui/baoshi/028.png"
	elseif graph == 5 then
		return "ui/fairy/new_ui/baoshi/029.png"
	end
	return "ui/fairy/new_ui/baoshi/027.png"
end

function EquipmentDataMgr:getGemIconBg(quality)
	local gemIconBg = {
	"ui/fairy/new_ui/baoshi/006.png",
	"ui/fairy/new_ui/baoshi/008.png",
	"ui/fairy/new_ui/baoshi/010.png",
	"ui/fairy/new_ui/baoshi/014.png",
	"ui/fairy/new_ui/baoshi/012.png",
	"ui/fairy/new_ui/baoshi/016.png",
	"ui/fairy/new_ui/baoshi/041.png",
	}
	return  gemIconBg[quality] or "ui/fairy/new_ui/baoshi/006.png"
end

function EquipmentDataMgr:getGemQualityBg(quality)
	local qualityIcon = {
	"ui/fairy/new_ui/baoshi/007.png",
	"ui/fairy/new_ui/baoshi/009.png",
	"ui/fairy/new_ui/baoshi/011.png",
	"ui/fairy/new_ui/baoshi/015.png",
	"ui/fairy/new_ui/baoshi/013.png",
	"ui/fairy/new_ui/baoshi/017.png",
	"ui/fairy/new_ui/baoshi/042.png",
	}
	return  qualityIcon[quality] or "ui/fairy/new_ui/baoshi/007.png"
end

function EquipmentDataMgr:getGemRarityIcon(rarity)
	local rarityIcon = {
	"ui/common/hero/quality_d.png",
	"ui/common/hero/quality_c.png",
	"ui/common/hero/quality_b.png",
	"ui/common/hero/quality_a.png",
	"ui/common/hero/quality_aaa.png",
	"ui/common/hero/quality_s.png",
	"ui/common/hero/quality_ss.png",
	}
	return  rarityIcon[rarity] or "ui/common/hero/quality_d.png"
end

function EquipmentDataMgr:getGemItemBg(quality)
	local itemIcon = {
	"ui/fairy/new_ui/baoshi/JLXL_bg_5_bai.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_5_lv.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_1_lan.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_4_zi.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_3_huang.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_2_hong.png",
	"ui/fairy/new_ui/baoshi/JLXL_bg_5_jin.png",
	}
	return  itemIcon[quality]
end

function EquipmentDataMgr:getGemPosBg(quality)
	local posBgIcon = {
	"ui/fairy/new_ui/baoshi/pos_1.png",
	"ui/fairy/new_ui/baoshi/pos_2.png",
	"ui/fairy/new_ui/baoshi/pos_3.png",
	"ui/fairy/new_ui/baoshi/pos_4.png",
	"ui/fairy/new_ui/baoshi/pos_5.png",
	"ui/fairy/new_ui/baoshi/pos_6.png",
	"ui/fairy/new_ui/baoshi/pos_7.png",
	}
	return  posBgIcon[quality]
end

function EquipmentDataMgr:getGemNameColor(quality)
	local color = {
	ccc3(255,255,255),
	ccc3(28,112,83),
	ccc3(26,85,134),
	ccc3(70,35,114),
	ccc3(117,78,22),
	ccc3(134,28,62),
	ccc3(180,66,24),
	}
	return color[quality]
end

---单件装备可以升一级
function EquipmentDataMgr:equipCouldUp(equipmentId)

	if not self:isUesing(equipmentId) then
		return false
	end

	local heroid = self:getHeroSid(equipmentId)
	local heroCid = HeroDataMgr:getHeroCidBySid(heroid);
	local isHave =HeroDataMgr:getIsHave(heroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(heroCid)
	if job >= 4 then
		return false
	end

	local upEquip = false
	local lv 		= self:getEquipLv(equipmentId);
	local equipMaxLv = self:getEquipMaxLv(equipmentId)
	if lv < equipMaxLv then
		local exp       = self:getEquipCurExp(equipmentId);
		local maxExp    = self:getEquipCurNeedExp(equipmentId);
		local delExp = maxExp - exp
		local showList,equipCnt = self:initShowListByStrengthen(equipmentId);
		local ownExp = 0
		for k,v in ipairs(showList) do
			local equipCid = self:getEquipCid(v.id)
			local goodsCfg = GoodsDataMgr:getItemCfg(equipCid)
			if goodsCfg.subType == 100 and goodsCfg.superType == EC_ResourceType.SPIRIT then
				ownExp = ownExp + goodsCfg.exp
				if ownExp >= delExp then
					upEquip = true
					break
				end
			end

		end
	end
	return upEquip
end

---装备可升星
function EquipmentDataMgr:equipCouldUpStar(equipmentId)

	if not self:isUesing(equipmentId) then
		return false
	end

	local heroid = self:getHeroSid(equipmentId)
	local heroCid = HeroDataMgr:getHeroCidBySid(heroid);
	local isHave =HeroDataMgr:getIsHave(heroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(heroCid)
	if job >= 4 then
		return false
	end

	local starCfg = self:getEquipStarCfg(equipmentId)
	if not starCfg then
		return false
	end

	local starLevel = self:getEquipStarLevel(equipmentId)
	if starLevel >= 3 then
		return false
	end

	local curLevel = self:getEquipLv(equipmentId)
	local limitLevel = self:getEquipStarLimitLevel(equipmentId)
	if curLevel < limitLevel then
		return false
	end

	local stageLevel = self:getEquipStageLevel(equipmentId)
	local baseCost = starCfg.baseCost[1][stageLevel]
	for k, v in pairs(baseCost) do
		local count = GoodsDataMgr:getItemCount(k)
		if count < tonumber(v) then
			return false
		end
	end
	local coinCost = starCfg.coinCost[1][stageLevel]
	for k, v in pairs(coinCost) do
		local own = GoodsDataMgr:getItemCount(tonumber(k))
		if own < tonumber(v) then
			return false
		end
	end

	local equipmentCost = starCfg.equipmentCost[1][stageLevel]
	local needEquipCid,needEquipType,needEquipStar,needEquipNum = equipmentCost[1],equipmentCost[2],equipmentCost[3],equipmentCost[4]
	needEquipCid = needEquipCid > 0 and needEquipCid or nil
	local ownEquip = self:getStarUpEquipsByCidAndStar(needEquipCid, needEquipType, needEquipStar)
	local ownCnt = 0
	for i,v in ipairs(ownEquip) do
		if v.id ~= equipmentId then
			ownCnt = ownCnt + 1
		end
	end
	if ownCnt < needEquipNum then
		return false
	end

	return true
end

---有星级更高的装备
function EquipmentDataMgr:haveBetterEquip(equipmentId)

	if not self:isUesing(equipmentId) then
		return false
	end

	local heroid = self:getHeroSid(equipmentId)
	local heroCid = HeroDataMgr:getHeroCidBySid(heroid);
	local isHave =HeroDataMgr:getIsHave(heroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(heroCid)
	if job >= 4 then
		return false
	end

	local cost = HeroDataMgr:getCost(heroCid) + HeroDataMgr:getNewEquipCost(heroCid)
	local costmax = HeroDataMgr:getCostMax(heroCid)

	local starLv = self:getEquipStarLv(equipmentId)
	for k,v in pairs(self.equips) do
		if equipmentId ~= v.id and not self:isUesing(v.id) then
			local equipcost = self:getEquipCost(v.id)
			local otherStarLv = self:getEquipStarLv(v.id)
			if equipcost <= costmax - cost and otherStarLv > starLv then
				return true
			end
		end
	end

	return false
end

---单件信物可以强化
function EquipmentDataMgr:newEquipCouldStrengthen(neweEquipCid)

	local equipInfo = self:getNewEquipInfoByCid(neweEquipCid)
	if not equipInfo then
		return false
	end
	local heroCid = tonumber(equipInfo.heroId)
	local isHave =HeroDataMgr:getIsHave(heroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(heroCid)
	if job >= 4 then
		return false
	end

	local acvanceCfg = self:getNewEquipAdvanceCfg(neweEquipCid)
	if self:checkNewEquipReachMaxLv(neweEquipCid) then
		return false
	end
	if equipInfo.level >= acvanceCfg.limitLevel then
		return false
	end

	local consume = self:getNewEquipStrengthenCfg(equipInfo.level).consume
	consume = consume or {}
	for k, v in pairs(consume) do
		local haveNum,needNum = GoodsDataMgr:getItemCount(v[1]),v[2]
		if haveNum < needNum then
			return false
		end
	end

	return true
end

---单件信物可进阶
function EquipmentDataMgr:newEquipCouldUpStage(neweEquipCid)

	local equipInfo = self:getNewEquipInfoByCid(neweEquipCid)
	if not equipInfo then
		return false
	end

	local heroCid = tonumber(equipInfo.heroId)
	local isHave =HeroDataMgr:getIsHave(heroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(heroCid)
	if job >= 4 then
		return false
	end

	local acvanceCfg = self:getNewEquipAdvanceCfg(neweEquipCid)
	local equipCfg = self:getNewEquipCfg(neweEquipCid)
	if equipInfo.stage >= equipCfg.endStar then
		return false
	end

	if equipInfo.level < acvanceCfg.limitLevel then
		return false
	end

	if self:checkNewEquipReachMaxLv(neweEquipCid) then
		return false
	end

	local consume = self:getNewEquipAdvanceCfg(neweEquipCid, equipInfo.stage).consume
	consume = consume or {}
	for k, v in pairs(consume) do
		local haveNum,needNum = GoodsDataMgr:getItemCount(v[1]),v[2]
		if haveNum < needNum then
			return false
		end
	end

	return true
end

---有更好的宝石
function EquipmentDataMgr:haverBetterStone(stoneId)

	local gemInfo = self:getGemInfo(stoneId)
	if not gemInfo then
		return false
	end

	local equipHeroCid = gemInfo.heroId
	if equipHeroCid == 0 then
		return false
	end
	local isHave =HeroDataMgr:getIsHave(equipHeroCid)
	if not isHave then
		return false
	end
	local job = HeroDataMgr:getHeroJob(equipHeroCid)
	if job >= 4 then
		return false
	end
	local cfg = self:getGemCfg(gemInfo.cid)
	local gemsData =  self:getAllGemsData()
	for k,v in pairs(gemsData) do
		local newCfg = self:getGemCfg(v.cid)
		if newCfg.heroId == equipHeroCid and newCfg.skillType == cfg.skillType and v.heroId == 0 and v.id ~= stoneId then
			if cfg.rarity < newCfg.rarity then
				return true
			end
		end
	end

	return false
end

--请求质点升阶
function EquipmentDataMgr:sendReqStepEquip(equipId, costEquipId)
	TFDirector:send(c2s.EQUIPMENT_REQ_STEP_EQUIP , {equipId , costEquipId})
end

--请求预览质点升阶消耗质点（用于消耗质点已被培养）
function EquipmentDataMgr:sendReqStepEquipPreview(equipId, costEquipId)
	TFDirector:send(c2s.EQUIPMENT_REQ_STEP_EQUIP_PREVIEW , {equipId, costEquipId})
end

function EquipmentDataMgr:getEquipStep( id )
	if self:isCid(id) then
		return self:getEquipStepByCid(id)
	else
		return self:getEquipStepById(id)
	end

    return -1
end

function EquipmentDataMgr:isExpEquip(id)
    local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self:getEquipCid( id )
	end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    return (itemCfg.subType == 100)
end

function EquipmentDataMgr:getEquipStepById(id)
    if self:isExpEquip(id) then return -1 end
    for _, _equip in pairs(self.equips) do
        if not self:isExpEquip(_equip.id) and _equip.id == id then
            return _equip.step
        end
    end
	return -1
end

function EquipmentDataMgr:getEquipStepByCid(cid)
    if self:isExpEquip(cid) then return -1 end
    for _, _equip in pairs(self.equips) do
    	if not self:isExpEquip(_equip.id) and _equip.cid == cid then
            return _equip.step
        end
    end
    return -1
end

function EquipmentDataMgr:getStepText( id )
    local step = -1
    local cid = 0
	if self:isCid(id) then
		cid = id
        step = self:getEquipStepByCid(id)
	else
		cid = self:getEquipCid( id )
        step = self:getEquipStepById(id)
	end

    if step <= 0 then return "" end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    if itemCfg.maxAdvanced and itemCfg.maxAdvanced <= step then
        return "+MAX"
    end

    if itemCfg.maxAdvanced and itemCfg.maxAdvanced > step then
        return "+" ..step
    end
    return ""
end

--获取质点突破对应的材料列表
function EquipmentDataMgr:getStepUpEquipList(equipId)
	local equipCid = self:getEquipCid(equipId)
	local allList = {}
	local unEquipList = {}
	local unStepList = {}
    local function initShowListTable(equips)
        for k, v in pairs(equips) do
		    if v.id ~= equipId and self:getEquipCid(v.id) == equipCid then
			    table.insert(allList, v.id)
			    if not self:isUesing(v.id) then
			    	--未装备的
			    	table.insert(unEquipList, v.id)
			    end

			    local step = self:getEquipStep(v.id)
				if not step or step <= 0 then
					--未突破的
					table.insert(unStepList, v.id)
				end 
		    end
	    end
    end
    local tmpList = {}
    for _, _equip in pairs(self.equips) do
    	if not self:isExpEquip(_equip.id) then
    		table.insert(tmpList, _equip)
        end
    end
    initShowListTable(tmpList)

    local sortfunc = function(a, b)
		local aLv = self:getEquipLv(a)
		local bLv = self:getEquipLv(b)
		local aStep = self:getEquipStep(a)
		local bStep = self:getEquipStep(b)
		if not aStep then aStep = 0 end
		if not bStep then bStep = 0 end

		local aUse  = self:isUesing(a)
		if aUse then aUse = 1 else aUse = 0 end
		local bUse 	= self:isUesing(b)
		if bUse then bUse = 1 else bUse = 0 end

		if aStep == bStep then
			if aUse == bUse then
				return aLv < bLv
			else
				return aUse < bUse
			end
		else
			return aStep < bStep
		end

	end

	table.sort(allList, sortfunc)
	table.sort(unEquipList, sortfunc)
	table.sort(unStepList, sortfunc)

    return {allList, unEquipList, unStepList}
end

function EquipmentDataMgr:getEquipAdvancedList( cid )
    local equipAdvancedList = self.equipAdvancedCfg[cid]
    return equipAdvancedList or {}
end

function EquipmentDataMgr:getEquipAdvancedHp( id, step)
    local cid = self:getEquipCid( id )

    local advancedList = self:getEquipAdvancedList(cid)
    local advanced = advancedList[step]
    if (advanced == nil) or (advanced.hp == nil) then return 0 end
    return advanced.hp*0.0001
end

function EquipmentDataMgr:getEquipAdvancedAp( id, step)
    local cid = self:getEquipCid( id )
    local advancedList = self:getEquipAdvancedList(cid)
    local advanced = advancedList[step]
    if (advanced == nil) or (advanced.ap == nil) then return 0 end
    return advanced.ap*0.0001
end

function EquipmentDataMgr:getEquipAdvancedDef( id, step)
    local cid = self:getEquipCid( id )
    local advancedList = self:getEquipAdvancedList(cid)
    local advanced = advancedList[step]
    if (advanced == nil) or (advanced.def == nil) then return 0 end
    return advanced.def*0.0001
end

function EquipmentDataMgr:getEquipStepAddAttrById( id, attrId, step )
    local equipStep = step or self:getEquipStep(id)
    if attrId == EC_Attr.HP then
        local advancedHp = self:getEquipAdvancedHp(id, equipStep)
        return math.ceil(self:getEquipBaseHp(id, 1)*advancedHp)
    end
    if attrId == EC_Attr.ATK then
       local advanceAp = self:getEquipAdvancedAp(id, equipStep)
       return math.ceil(self:getEquipBaseAtk(id, 1)*advanceAp)
    end
    if attrId == EC_Attr.DEF then
       local advancedDef = self:getEquipAdvancedDef(id, equipStep)
       return math.ceil(self:getEquipBaseDef(id, 1)*advancedDef)
    end
    return 0
end

--质点当前属性
function EquipmentDataMgr:getEquipmentAttrById(id, attrId, step, level, useStage)
    local baseValue = 0
    if attrId == EC_Attr.HP then
        baseValue = self:getEquipBaseHp(id, level, useStage)
    end
    if attrId == EC_Attr.ATK then
        baseValue = self:getEquipBaseAtk(id, level, useStage)
    end
    if attrId == EC_Attr.DEF then
        baseValue = self:getEquipBaseDef(id, level, useStage)
    end
    return math.floor(baseValue + self:getEquipStepAddAttrById(id, attrId, step))
end

--质点突破返还
function EquipmentDataMgr:onRspStepEquip(event)
	local data = event.data
	EventMgr:dispatchEvent(EV_EQUIP_STEP_UP, data)
	Utils:openView("Equipment.EquipStepUpSucessLayer", data)
end

--质点突破返还材料预览
function EquipmentDataMgr:onRspStepEquipPreview(event)
	local data = event.data
	EventMgr:dispatchEvent(EV_EQUIP_STEP_UP_PREVIEW, data)
	if not data.items or #data.items <= 0 then
		--没有返还材料，直接突破
		self:sendReqStepEquip(data.equipId, data.costEquipId)
		return
	end
	Utils:openView("Equipment.EquipStepUpTips", data)
end

---质点保存方案
function EquipmentDataMgr:ReqEquipBackupInfo()
	TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_BACKUP_INFO,{})
end

function EquipmentDataMgr:ReqSaveEquipBackupPos(posId, saveDetail)
	local msg = {
		posId,
		saveDetail,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_SAVE_EQUIP_BACKUP_POS,msg)
end

function EquipmentDataMgr:ReqSaveEquipBackupDecr(posId,nameDesc)
	local msg = {
		posId,
		nameDesc,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_SAVE_EQUIP_BACKUP_DECR,msg)
end

function EquipmentDataMgr:ReqUseEquipBackup(posId,heroId)
	local msg = {
		posId,
		heroId,
	}
	TFDirector:send(c2s.EQUIPMENT_REQ_USE_EQUIP_BACKUP,msg)
end

function EquipmentDataMgr:recvEquipBackUpInfo(event)
	local data = event.data
	self.equipBackUpInfos = {}
	for i, v in ipairs(data.info or {}) do
		self.equipBackUpInfos[v.id] = v
	end
	EventMgr:dispatchEvent(EQUIPMENT_BACKUP_INFO, data)
end

function EquipmentDataMgr:recvSaveEquipBackUpPos(event)
	local data = event.data
	self:ReqEquipBackupInfo()
	EventMgr:dispatchEvent(EQUIPMENT_SAVE_BACKUP_POS, data)
end

function EquipmentDataMgr:recvSaveEquipBackUpName(event)
	local data = event.data
	self:ReqEquipBackupInfo()
	EventMgr:dispatchEvent(EQUIPMENT_SAVE_BACKUP_NAME, data)
	Utils:showTips(270454)
end

function EquipmentDataMgr:recvUseEquipBackUp(event)
	local data = event.data
	EventMgr:dispatchEvent(EQUIPMENT_USE_BACKUP_INFO, data)
end

function EquipmentDataMgr:getSortEquipBackUpInfo()
	return self.equipBackUpInfos
end

function EquipmentDataMgr:isUniversalEquip(id)
    local cid = 0;
	if self:isCid(id) then
		cid = id
	else
		cid = self:getEquipCid( id )
	end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    return (itemCfg.subType == 101)
end

return EquipmentDataMgr:new();
