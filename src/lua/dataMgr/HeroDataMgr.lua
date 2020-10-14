local BaseDataMgr = import(".BaseDataMgr")
local HeroDataMgr = class("HeroDataMgr", BaseDataMgr)

function HeroDataMgr:ctor()
	self.heroTable = clone(TabDataMgr:getData("Hero"));
	self.heroTag   = TabDataMgr:getData("HeroTag");
	self.heroSkinTable = TabDataMgr:getData("HeroSkin");
	local tab1 = TabDataMgr:getData("TrialHeroSkin")
	for k,v in pairs(tab1) do
		self.heroSkinTable[k] = v
	end

	self.evolutionTable = TabDataMgr:getData("Evolution");
	self.heroAttTable  = TabDataMgr:getData("HeroAttribute");
	self.heroWeaponModleTable = TabDataMgr:getData("HeroWeaponModle")
	self:initEvolutionCellColRow();
	self.showList = {};
	self.showListIds = {};
	self.haveList = {};
	self.formations = {};--所有阵形
	self.formation = {};--在用阵形
	self.teamleader = 0;
	self.showEvoPartition = 1; --当前显示的突破阶段

	self.myHeroTable = nil;
	self.myHaveList = nil;
	self.myFormation = nil;

    self:init()
end

function HeroDataMgr:init()
	TFDirector:addProto(s2c.HERO_HERO_UPGRADE_RESULT, self, self.recvHeroLevelUp)
	TFDirector:addProto(s2c.HERO_HERO_ADVANCE_RESULT,self,self.revcHeroStrengthen)
	TFDirector:addProto(s2c.HERO_HERO_EXP_INFO,self,self.revcHeroExp)
	TFDirector:addProto(s2c.PLAYER_FORMATION_INFO_LIST,self,self.revcFormationList)
	TFDirector:addProto(s2c.PLAYER_FORMATION_INFO,self,self.reveFormationChange)
	TFDirector:addProto(s2c.HERO_HERO_COMPOSE,self,self.revcComposeHero)
	TFDirector:addProto(s2c.HERO_RES_AWAKE_ANGEL,self,self.revcAngelAwaken)
	TFDirector:addProto(s2c.HERO_RESP_ANGEL_RESET,self,self.revcResetAngelTree)
	TFDirector:addProto(s2c.HERO_RESP_UP_QUALITY,self,self.revcHeroProgress)
	TFDirector:addProto(s2c.HERO_RESP_CHANGE_HERO_SKIN,self,self.revcHeroChangeSkin);
	TFDirector:addProto(s2c.HERO_RES_ACTIVE_CRYSTAL,self,self.revcActiveCrystal);
	TFDirector:addProto(s2c.HERO_RES_PROPERTY_CHANGE,self,self.revcPropertyChange);
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_NEW_SPIRIT_INFO,self,self.revcGetSpiritInfo)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_PUT_SPIRIT_POINTS,self,self.revcPutSpritPoints)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_RESET_SPIRIT_POINTS,self,self.revcResetSpiritPoints)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_UPGRADE_SPIRIT,self,self.revcUpgradeSpirit)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_SPIRIT_USE_ITEM,self,self.revcSpiritUseItem)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_SPIRIT_REFRESH,self,self.revcRefreshSprit)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_SHOW_NEW_SPIRIT,self,self.revcShowNewSpirit)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_UPGRADE_ANGLE_SPIRIT,self,self.revcUpgradeAngleSpirit)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_OLD_SPIRIT_FEEDBACK,self,self.revcOldSpiritFeedback)
	TFDirector:addProto(s2c.HERO_SPIRIT_RSP_OLD_SPIRIT_VIEW,self,self.revcOldSpiritShowRewards)
	
	
	TFDirector:addProto(s2c.HERO_RES_DECOMPOSE_MATERIALS,self,self.HERO_RES_DECOMPOSE_MATERIALS)
	TFDirector:addProto(s2c.HERO_RES_QUICK_ACTIVE_CRYSTAL,self,self.HERO_RES_QUICK_ACTIVE_CRYSTAL)
	
	--self:initShowList();

end

function HeroDataMgr:onLogin()
	TFDirector:send(c2s.PLAYER_GET_FORMATIONS, {})
	TFDirector:send(c2s.HERO_SPIRIT_REQ_NEW_SPIRIT_INFO,{})
	return {s2c.PLAYER_FORMATION_INFO_LIST,s2c.HERO_SPIRIT_RSP_NEW_SPIRIT_INFO}
end

function HeroDataMgr:onLoginOut()
	self.heroTable = clone(TabDataMgr:getData("Hero"));
	self.heroTag   = TabDataMgr:getData("HeroTag");
	self.showList = {};
	self.showListIds = {};
	self.haveList = {};
	self.formations = {};--所有阵形
	self.formation = {};--在用阵形
	self.teamleader = 0;

	self.myHeroTable = nil;
	self.myHaveList = nil;
	self.myFormation = nil;
end

function HeroDataMgr:revcFormationList(event,isFriend)
	self.formations = event.data;

	local formation = {}
	for k,v in pairs(self.formations) do
		for k2,v2 in pairs(v) do
			if v2.status == 1 then
				formation = v2
				break;
			end
		end
	end
	self.formation = formation;
	self.formation.heros = {}
	if formation.stance then
		for _id,hero in pairs(self.heroTable) do
			hero.job = 4;
			for _pos,sid in pairs(formation.stance) do
				if hero.ishave and hero.sid == sid then
					hero.job = _pos;  	--队长
					self.formation.heros[_pos] = hero.id
				end
			end
		end
	else
		self.formation.stance = {}
	end

	self:resetShowList();
end

function HeroDataMgr:reveFormationChange(event)
	self.formation = event.data;
	self.formation.heros = {}
	for k,v in pairs(self.formation.stance) do
		for _id,hero in pairs(self.heroTable) do
			hero.job = 4;
			for _pos,sid in pairs(self.formation.stance) do
				if hero.ishave and hero.sid == sid then
					hero.job = _pos;  	--队长
					self.formation.heros[_pos] = hero.id
				end
			end
		end
	end
	self.myFormation = self.formation
	EventMgr:dispatchEvent(EV_FORMATION_CHANGE)
end

function HeroDataMgr:getIsFormationOn(_pos)
	return self.formation.stance[_pos] ~= nil;
end

function HeroDataMgr:getHeroIdByFormationPos(_pos)
	return self.formation.heros[_pos];
end

function HeroDataMgr:getFormationHeroCnt()
	return table.count(self.formation.stance);
end

function HeroDataMgr:getFormationIsFull()
	return table.count(self.formation.stance) >= 3;
end

function HeroDataMgr:checkOnFormationByRole(heroid)
	local roleid = self:getHeroRoleId(heroid);

	for i=1,3 do
		if self:getIsFormationOn(i) then
			local id = self:getHeroIdByFormationPos(i);
			if self:getHeroRoleId(id) == roleid then
				return true;
			end
		end
	end

	return false
end

function HeroDataMgr:syncStance()
	self.formation.stance = {}
	for k,v in pairs(self.formation.heros) do
		self.formation.stance[k] = v
	end
end



function HeroDataMgr:setFormationHero(pos,id,oldId,force)
	local hero = self:getHero(id)
	if self.formation.heros[pos] == id then
		table.remove(self.formation.heros,pos);
		hero.job = 4;

		for k,v in pairs(self.formation.heros) do
			self:getHero(v).job = k;
		end

		if force then 
			self:syncStance()
		end
		return;
	end

	if not self.formation.heros[pos] and not oldId then
		table.insert(self.formation.heros,id);
		for k,v in pairs(self.formation.heros) do
			self:getHero(v).job = k;
		end

		if force then 
			self:syncStance()
		end
		return;
	end

	if oldId then
		local oldHreo = self:getHero(oldId);
		oldHreo.job = 4;
		hero.job = pos;
		self.formation.heros[pos] = id

		if force then 
			self:syncStance()
		end
	end
end

function HeroDataMgr:resetShowList(onlyHave,containSimulationTrial)
	self.showList = {};
	self.showListIds = {};
	return self:initShowList(onlyHave,containSimulationTrial);
end

function HeroDataMgr:getShowList(onlyHave,containSimulationTrial)
	return self:resetShowList(onlyHave,containSimulationTrial);
end

function HeroDataMgr:initShowList(onlyHave,containSimulationTrial)
	local time1 = os.clock()
	local tab = self.heroTable
	local temp = {}
	for k,v in pairs(self.heroTable) do
		if not onlyHave or v.ishave  then
			if containSimulationTrial or (v.heroStatus ~= 3 and v.testType ~=1) then --试炼角色不放入展示列表
				table.insert(temp,v);
			end
		end
	end
	tab = temp
	local haveTab = {};
	for k,v in pairs(tab) do
		if v.isOpen and  v.isOpen == 1 then
			self.showList = self.showList or {};
			self.showList[v.site] = self.showList[v.site] or {};
			v.isSelected = false;
			table.insert(self.showList[v.site],v);

			haveTab = haveTab or {};
			haveTab[v.site] = haveTab[v.site] or {};
			haveTab[v.site].fightPower = v.fightPower or 0 
			if v.ishave and not haveTab[v.site].ishave then
				haveTab[v.site].ishave = true;
			end

			if haveTab[v.site].job and haveTab[v.site].job > v.job then
				haveTab[v.site].job = v.job
			elseif haveTab[v.site].job and haveTab[v.site].job < v.job then

			else
				haveTab[v.site].job = v.job
			end

			local isCanCompose = self:isCanCompose(v.id);
			if not haveTab[v.site].isCanCompose and isCanCompose then
				haveTab[v.site].isCanCompose = true
			end
			
			if v.job == 1 then
				self.teamleader = v.id;
			end
		end

		
	end

	--默认第一个为选中状态，将id插入有序表方便显示处理
	for k,v in pairs(self.showList) do

		table.sort(v,function(a,b)
				local is_a_have = 0;
				if a.ishave then is_a_have = 1 end
				local is_b_have = 0;
				if b.ishave then is_b_have = 1 end

				if is_a_have == is_b_have then
					if a.job == b.job then
						return a.id < b.id;
					else
						return a.job < b.job;
					end
				else
					return is_a_have > is_b_have;
				end
			end)

		table.insert(self.showListIds,k);
		self.showList[k][1].isSelected = true;
	end
	table.sort(self.showListIds,function ( a,b )
		-- body
			local ahave,bhave = 0,0;
			local aCanCompose,bCanCompose = 0,0;
			if haveTab[a].ishave then ahave = 1 end
			if haveTab[b].ishave then bhave = 1 end
			if haveTab[a].isCanCompose then aCanCompose = 1 end
			if haveTab[b].isCanCompose then bCanCompose = 1 end

			if haveTab[a].job == haveTab[b].job then
				if ahave == bhave then
					if ahave == 0 and bhave == 0 then
						if aCanCompose == bCanCompose then
							return a < b;
						else
							return aCanCompose > bCanCompose;
						end
					else
						return haveTab[a].fightPower > haveTab[b].fightPower;  --英文版修改战力排序
					end
				else
					return haveTab[a].fightPower > haveTab[b].fightPower;  --英文版修改战力排序
				end
			else
				return haveTab[a].job < haveTab[b].job;
			end

	end)

	local time2 = os.clock();

	-- print("sort time = ".. time2 - time1);

	return self.showListIds;
end

function HeroDataMgr:changeShowOne(showidx,firstTouchIn)
	local showid = self.showListIds[showidx];
	local curtab = self.showList[showid];
	local curidx = 0;
	for k,v in pairs(curtab) do
		if v.isSelected == true then
			curidx = k;
			break;
		end
	end
	if not firstTouchIn then
		curidx = curidx + 1;
	end

	if curidx > table.count(curtab) then
		curidx = 1;
	end

	self:setSelectState(showidx,curidx);

	return curtab[curidx].id;
end

function HeroDataMgr:getShowOneCount(showidx)
	local id = self.showListIds[showidx];
	local count = table.count(self.showList[id])
	return count;
end

function HeroDataMgr:setSelectState(showidx,idx)
	local showid = self.showListIds[showidx]
	for k,v in pairs(self.showList[showid]) do
		if k == idx then
			v.isSelected = true;
		else
			v.isSelected = false;
		end
	end
end

function HeroDataMgr:getShowIdxById(id)
	local hero =  self.heroTable[id]
	if hero then
		local site = hero.site
		for k,v in pairs(self.showListIds) do
			if v == site then
				return k;
			end
		end
	end

	return 1;
end

--得到分组中以选择的英雄的id
function HeroDataMgr:getSelectedHeroId(showidx)
	local showid = self.showListIds[showidx];
	local list = self.showList[showid]
	if list then
		for k,v in pairs(list) do
			if v.isSelected then
				return v.id;
			end
		end
	end
end

function HeroDataMgr:getSelectedHeroIdx(showid)
	for i,v in ipairs(self.showListIds) do
		if v == showid then
			return i
		end
	end
	return 1
end

--得到分组中的英雄的id
function HeroDataMgr:getHeroId(showidx,idx)
	local showid = self.showListIds[showidx]
	return self.showList[showid][idx].id
end

function HeroDataMgr:getGroupFirstId(showidx)
	return self.showList[showidx][1].id
end

function HeroDataMgr:getHeroGroup(site)
    local heroGroup = {}
    if site then
        for i, v in ipairs(self.showList[site]) do
            table.insert(heroGroup, v.sid)
        end
    end
    return heroGroup
end

function HeroDataMgr:getUnFormationFirstId()
	local showidx,showid
	for i=1,table.count(self.showListIds) do
		local group = self.showList[self.showListIds[i]];
		for k,v in pairs(group) do
			if v.job >= 4 then
				showidx = i;
				showid  = v.id;
				break;
			end
		end

		if showidx then
			break
		end
	end

	return showidx or 1,showid or self:getTeamLeaderId();
end

function HeroDataMgr:isSelected(showidx,idx)
	local showid = self.showListIds[showidx]
	return self.showList[showid][idx].isSelected;
end

function HeroDataMgr:getQuality(id)
	local quality = self.heroTable[id].quality or self.heroTable[id].rarity
	return quality;
end

function HeroDataMgr:getRarity(id)
	local rarity = self.heroTable[id].rarity
	return rarity;
end

function HeroDataMgr:getQualityStringById(id)
	local quality = self:getQuality(id);
	return EC_HeroQuality[quality] or "";
end

function HeroDataMgr:getQualityPic(id,_quality)
	local qualitypic = {
    [1] = "ui/common/hero/quality_b.png",
    [2] = "ui/common/hero/quality_a.png",
    [3] = "ui/common/hero/quality_aa.png",
    [4] = "ui/common/hero/quality_aaa.png",
    [5] = "ui/common/hero/quality_s.png",
    [6] = "ui/common/hero/quality_ss.png",
    [7] = "ui/common/hero/quality_sss.png",
	}
	local quality = _quality or self:getQuality(id)
	return qualitypic[quality] or ""
end

function HeroDataMgr:getQualityPicNotHave(id,_quality)
	local qualitypic = {
    [1] = "ui/common/hero/quality_b.png",
    [2] = "ui/common/hero/quality_a.png",
    [3] = "ui/common/hero/quality_aa.png",
    [4] = "ui/common/hero/quality_aaa.png",
    [5] = "ui/common/hero/quality_s.png",
    [6] = "ui/common/hero/quality_ss.png",
    [7] = "ui/common/hero/quality_sss.png",
	}
	local quality = _quality or self:getRarity(id)
	return qualitypic[quality] or ""
end

function HeroDataMgr:getProgressNeed(id)
	local hero = self.heroTable[id]

	local progressId = hero.attribute * 100 + hero.quality
	if not self:reachMaxQuality(id) then
		progressId = progressId + 1
	end
	local data = TabDataMgr:getData("HeroProgress",progressId)
	if not data then
		data = TabDataMgr:getData("HeroProgress",101103)
	end
	local consume = data.consume;

	return consume[1];
end

function HeroDataMgr:reachMaxQuality(id)
	local hero = self.heroTable[id]
	return hero.quality >= #EC_HeroQuality
end

function HeroDataMgr:getTeamLeaderId()
	return self.teamleader;
end

function HeroDataMgr:getHeroJob(id)
	return self.heroTable[id].job;
end

function HeroDataMgr:getHeroJobIconPath(id)
	local job = self:getHeroJob(id)
	if job == 1 then
		return "ui/fairy/new_ui/new_20.png";
	elseif job == 2 or job == 3 then
		return "ui/fairy/new_ui/new_17.png";
	end

	return ""
end

function HeroDataMgr:getIconPathById(id, skinid)
	skinid = skinid or self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).heroIcon; --self.heroTable[id].icon;
end

function HeroDataMgr:getHeadIconPathById(id, skinid)
	skinid = skinid or self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).nameIcon; --self.heroTable[id].icon;
end

function HeroDataMgr:getSmallIconPathById(id)
	local skinid = self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).smallIcon;
end

function HeroDataMgr:getSmallIconPathByIdInEvaview(id)
	return TabDataMgr:getData("HeroSkin",id).smallIcon;
end

function HeroDataMgr:getEndIconById(id)
	local skinid = self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).endIcon;
end

function HeroDataMgr:getPlayerIconPathById(id)
	local skinid = self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).playerIcon;
end

function HeroDataMgr:getPlayerBackdrop(id)
	local skinid = self:getCurSkin(id);
	return TabDataMgr:getData("HeroSkin",skinid).backdrop;
end

function HeroDataMgr:getModelPathById(id)
	print("HeroDataMgr id " , id)
	return self.heroTable[id].paint;
end

function HeroDataMgr:getNameById(id)
	local strid = self.heroTable[id].name
	return TextDataMgr:getText(strid)
end

function HeroDataMgr:getNameStrId(id)
	local strid = self.heroTable[id].name
	return strid;
end

function HeroDataMgr:getNamePic(id)
	local namePic = self.heroTable[id].namePic
	return namePic;
end

function HeroDataMgr:getDesc(id)
	local describe = self.heroTable[id].describe
	return TextDataMgr:getText(describe);
end

function HeroDataMgr:getTitleById(id)
	local strid = self.heroTable[id].title
	return TextDataMgr:getText(strid)
end

function HeroDataMgr:getTitleStrId(id)
	if self.heroTable[id]then
		local strid = self.heroTable[id].title
		return strid;
	else
		local errmsg = string.format("HeroDataMgr:getTitleStrId(%s), self.heroTable:%s ",
				tostring(id), tostring(self.heroTable ~= nil))
		Bugly:ReportLuaException(errmsg)
	end
end

function HeroDataMgr:getTitleStr(id)
	local strid = self.heroTable[id].title
	return TextDataMgr:getText(strid)
end

function HeroDataMgr:getTitlePic(id)
	local titlePic = self.heroTable[id].titlePic
	return titlePic;
end

function HeroDataMgr:getDiBanColor(id)
	local colorVal = self.heroTable[id].color2;
	return ccc3(colorVal[1],colorVal[2],colorVal[3])
end

function HeroDataMgr:getTypeIconPathAndString(id)
	local tagid = self.heroTable[id].class;
	local tag = self.heroTag[tagid];
	local ret = {}
	ret.icon = tag.icon;
	ret.describe = TextDataMgr:getText(tag.describe)
	return ret;
end

function HeroDataMgr:getLabelsIconAndString(id)
	local tagids = self.heroTable[id].label;
	local ret = {}
	for k,v in pairs(tagids) do
		ret[k] = {}
		ret[k].icon = self.heroTag[v].icon
		ret[k].describe = TextDataMgr:getText(self.heroTag[v].describe)
	end

	return ret;
end

function HeroDataMgr:getBattleTips(id)
	local tipsid = self.heroTable[id].battleTips;
	local ret = {}
	for k,v in pairs(tipsid) do
		ret[k] = TextDataMgr:getText(v)
	end

	return ret;
end

function HeroDataMgr:getHeroPower(id)
	if not self:getIsHave(id) then
		return 0;
	end

	-- local def = self:getDef(id);
	-- local hp  = self:getHp(id);
	-- local atk = self:getAtk(id);
	-- local power = atk * 1 + def * 2 + hp * 3;
	return self.heroTable[id].fightPower or 0;
end

function HeroDataMgr:getHeroInfoByID(id)
	return self.heroTable[id]
end

--判断是否拥有这个英雄
function HeroDataMgr:getIsHave(id)
	if self.heroTable[id] then 
		return self.heroTable[id].ishave;
	end
end

--英雄是否处于助战
function HeroDataMgr:getIsAssist(id)
	-- if MainPlayer:getAssistId() and MainPlayer:getAssistId() == id then
	-- 	return true
	-- end
	return self.heroTable[id].helpFight
end

function HeroDataMgr:getShowCount()
	return table.count(self.showListIds);
end

function HeroDataMgr:getComposeNeed(id)
	return self.heroTable[id].compose
end

function HeroDataMgr:isCanCompose(id)
	if self:getIsHave(id) and self.heroTable[id].heroStatus ~= 2 then
		return false;
	end

	local composeNeed = self:getComposeNeed(id);
	local needid,needCnt;
	for k,v in pairs(composeNeed) do
		needid = k;
		needCnt = v;
	end

	local spCnt = GoodsDataMgr:getItemCount(needid);

	return spCnt >= needCnt;
end

function HeroDataMgr:getLv(id)
	if not self:getIsHave(id) then
		return 1
	end

	return self.heroTable[id].lvl;
end

function HeroDataMgr:getHp(id)
	if not self:getIsHave(id) then
		return 0
	end
	local hp = self.heroTable[id].attr[EC_Attr.HP]
	hp = math.floor(hp*0.01)
	local ratio = 0
	for i = 1 , 3 do
		if self:getIsHaveEquip(id,i) then
			local equipid = self:getEquipIdByPos(id,i);
			if EquipmentDataMgr:getIsHaveSpecialAttr(equipid) then
				local attr = EquipmentDataMgr:getEquipSpecialAttrs(equipid)
				for k,v in pairs(attr) do
					if v.type == EC_Attr.HP_RATIO then
						ratio = ratio +v.val
					end
				end

			end
		end
	end
	hp = math.floor(hp * (1 + ratio*0.01))
	return hp
end

function HeroDataMgr:getDef(id)
	if not self:getIsHave(id) then
		return
	end

	local def = self.heroTable[id].attr[EC_Attr.DEF]

	for i=1,3 do
		if self:getIsHaveEquip(id,i) then
			local equipid = self:getEquipIdByPos(id,i);
			if EquipmentDataMgr:getIsHaveSpecialAttr(equipid) then
				local attr = EquipmentDataMgr:getEquipSpecialAttrs(equipid)
				for k,v in pairs(attr) do
					if v.type == EC_Attr.DEF_RATIO then
						def = def * (1 + v.val / 100)
					end
				end
			end
		end
	end
	return def / 100;--self.heroTable[id].attr[EC_Attr.HP] * (1 + ) --/ 100;
end

function HeroDataMgr:getAtk(id)
	if not self:getIsHave(id) then
		return
	end

	local atk = self.heroTable[id].attr[EC_Attr.ATK]

	for i=1,3 do
		if self:getIsHaveEquip(id,i) then
			local equipid = self:getEquipIdByPos(id,i);
			if EquipmentDataMgr:getIsHaveSpecialAttr(equipid) then
				local attr = EquipmentDataMgr:getEquipSpecialAttrs(equipid)
				for k,v in pairs(attr) do
					if v.type == EC_Attr.ATK_RATIO then
						atk = atk * (1 + v.val / 100)
					end
				end
			end
		end
	end
	return atk / 100;--self.heroTable[id].attr[EC_Attr.HP] * (1 + ) --/ 100;
end

function HeroDataMgr:getCost(id)
	if not self:getIsHave(id) then
		return 0;
	end

	local cost = 0;
	for i=1,3 do
		local equipid = self:getEquipIdByPos(id,i);
		if equipid ~= "none" then
			cost = cost + EquipmentDataMgr:getEquipCost(equipid);
		end
	end


	return cost;
end

function HeroDataMgr:getCostMax(id)
	if not self:getIsHave(id) then
		return 0;
	end
	return self.heroTable[id].attr[EC_Attr.COST];
end

function HeroDataMgr:getHeroSid(id)
	if not self:getIsHave(id) then
		return 0;
	end
	return self.heroTable[id].sid;
end

function HeroDataMgr:getHeroCid(sid)
	for k,v in pairs(self.heroTable) do
		if v.sid == sid then
			return v.id
		end
	end
end

function HeroDataMgr:getFeaturePath(id)
	local iconname = self.heroTable[id].pentacle
	--local iconname = 110101
	return iconname;--"ui/fairy/"..iconname..".png";
end

function HeroDataMgr:getExpPercent(id)
	if not self:getIsHave(id) then
		return
	end

	local hero = self.heroTable[id];
	local lv   = hero.lvl;
	local exp  = hero.exp;

	-- if lv >= self:getCurLevelMax(id) then
	-- 	return 0;
	-- end

	local maxexp = TabDataMgr:getData("LevelUp",lv).heroExp;
	print("exp = "..exp.." maxexp = "..maxexp)
	if maxexp <= 0 then
		return 0
	end
	return exp / maxexp * 100;
end

function HeroDataMgr:getExp(id)
	if not self:getIsHave(id) then
		return
	end

	return self.heroTable[id].exp;
end

function HeroDataMgr:getLevelUpExp(id)
	local lv = self.heroTable[id].lvl
	-- if lv >= self:getCurLevelMax(id) then
	-- 	return 0;
	-- end
	return TabDataMgr:getData("LevelUp",lv).heroExp;
end

function HeroDataMgr:calcLevelUp(id,exp)
	local hero = self.heroTable[id];
	local curexp = hero.exp;
	local totalExp = curexp + exp;
	local level = hero.lvl;
	while(1)do

		if level >= self:getCurLevelMax(id) then
			level = self:getCurLevelMax(id);
			break
		end

		local needexp = TabDataMgr:getData("LevelUp",level).heroExp;
		if needexp <= totalExp then
			totalExp = totalExp - needexp;
			level = level + 1;
		else
			break;
		end
	end

	return level;
end


function HeroDataMgr:getLevelUpNeed(id)
	local hero = self.heroTable[id];
	return hero.expitem;
end

function HeroDataMgr:setHeroExp(id,exp)
	self.heroTable[id].exp = exp;
end

function HeroDataMgr:getStrengthenLv(id)
	if not self:getIsHave(id) then
		return 0
	end

	return self.heroTable[id].advancedLvl;
end

function HeroDataMgr:getStrengthenNeed(id)
	local hero = self.heroTable[id];
	local strengthenId = hero.attribute * 100 + hero.advancedLvl + 1;
	local consume = TabDataMgr:getData("HeroProgress",strengthenId).consume;

	return consume;
end

function HeroDataMgr:getHero(id)
	local data = self.heroTable or {}
    if id then
        return data[id];
    else
        return data
    end
end

function HeroDataMgr:getPositionOffset(id)
	return self.heroTable[id].paintPosition
end

function HeroDataMgr:getModelSize(id)
	return self.heroTable[id].paintSize;
end

function HeroDataMgr:getHeroBySid(sid)
	return self.haveList[sid];
end

function HeroDataMgr:getHeroCidBySid(sid)
	return self.haveList[sid].cid;
end

function HeroDataMgr:setHeroAngelInfo(hero)
	local angeSkillInfos = {}

	-- if not hero.angeSkillInfos then
	-- 	hero.angeSkillInfos = hero.skillStrategyInfo[hero.useSkillStrategy].angeSkillInfos)
	-- end
	if hero.skillStrategyInfo[hero.useSkillStrategy].angeSkillInfos then
		for k,v in pairs(hero.skillStrategyInfo[hero.useSkillStrategy].angeSkillInfos) do
			angeSkillInfos[v.type] = angeSkillInfos[v.type] or {}
			angeSkillInfos[v.type][v.pos] = angeSkillInfos[v.type][v.pos] or {}
			angeSkillInfos[v.type][v.pos].lvl = v.lvl
			local skillId = self:getAngelSkllID(hero.id,v.type);
			angeSkillInfos[v.type][v.pos].talentId = AngelDataMgr:getTalentId(hero.id,skillId,v.pos,v.lvl)
		end
		hero.angeSkillInfos = angeSkillInfos;
	else
		hero.angeSkillInfos = {}
	end
end

function HeroDataMgr:syncServer(hero,ct)
	local function changesid(hero)
		local sid = hero.id
		local id  = hero.cid;
		hero.sid  = tostring(sid);
		hero.id   = id;
	end
	changesid(hero)

	if ct == EC_SChangeType.ADD then
	 	self.heroTable[hero.cid].ishave = true;
        table.merge(self.heroTable[hero.cid],hero);
        self.haveList[hero.sid] = self.haveList[hero.sid] or {}
        table.merge(self.haveList[hero.sid],self.heroTable[hero.cid]);
        if hero.heroStatus == 2 then
        	local heroCfg = GoodsDataMgr:getItemCfg(hero.cid)
        	local text = TextDataMgr:getText(282103,TextDataMgr:getText(heroCfg.name))
        	Utils:showTips(text)
       	elseif hero.heroStatus == 3 then
        	--获得试炼角色不需要提示
        elseif hero.provide ~= 10036 then
            local currentScene = Public:currentScene()
			local view = requireNew("lua.logic.summon.SummonGetHeroView"):new(hero.cid)
			local topView = AlertManager:getTopLayer()
			if nil ~= topView and topView.__cname == "SummonGetHeroView" then
				AlertManager:addStashGetHeroView(hero.cid)
			else
				
				if currentScene.__cname == "BattleScene" or DatingDataMgr:getIsDating() then
					AlertManager:addStashView(view, "summon.SummonGetHeroView")
				else
					AlertManager:addLayer(view)
					AlertManager:show()
				end
			end
        end
        self:setHeroAngelInfo(self.heroTable[hero.cid])
	elseif ct == EC_SChangeType.DEFAULT then
        self.heroTable[hero.cid].ishave = true;
        table.merge(self.heroTable[hero.cid],hero);
        self.haveList[hero.sid] = self.haveList[hero.sid] or {}
        table.merge(self.haveList[hero.sid],self.heroTable[hero.cid]);
        self:setHeroAngelInfo(self.heroTable[hero.cid])
    elseif ct == EC_SChangeType.UPDATE then
    	local old = clone(self.heroTable[hero.cid])
    	self.heroTable[hero.cid] = nil;
    	self.heroTable[hero.cid] = clone(TabDataMgr:getData("Hero",hero.cid));
    	self.heroTable[hero.cid].ishave = true;
        table.merge(self.heroTable[hero.cid],hero);
        self.heroTable[hero.cid].job = old.job;
        self.haveList[hero.sid] = {}
        table.merge(self.haveList[hero.sid],self.heroTable[hero.cid]);
        self:setHeroAngelInfo(self.heroTable[hero.cid])
    elseif ct == EC_SChangeType.DELETE then
        self.heroTable[hero.cid].ishave = false;
        self.heroTable[hero.cid].sid = nil;
        self.haveList[hero.sid] = nil;
    end
end

function HeroDataMgr:syncHeroSpiritInfo(spiritInfo)
	dump(spiritInfo)
	self.spiritInfo_ = spiritInfo
	EventMgr:dispatchEvent(EV_HERO_REFRESH_SPRIT)
end

function HeroDataMgr:getSpiritInfo()
	return self.spiritInfo_ or {}
end

function HeroDataMgr:changeDataToFriend(friendInfo,isFuBen)
	local friend = friendInfo or MainPlayer:getQueryPlayerInfo();
	if not self.myHeroTable then
		self.myHeroTable = clone(self.heroTable);
	end

	if not self.myFormation then
		self.myFormation = clone(self.formation)
	end

	if not self.myHaveList then
		self.myHaveList = clone(self.haveList);
	end

	self.heroTable = clone(TabDataMgr:getData("Hero"));
	self.formation = {};
	self.haveList  = {};

	local function attrAssgin(target, src)
        for k, v in pairs(src) do
            local value = v
            if k == "attr" then
            	local ischange = false;
                value = {}
                for _, attr in pairs(v) do
                	if type(attr) == "table" then
                		ischange =  true
                    	value[attr.type] = attr.val
                    end
                end
                if not ischange then
                	value = v;
                end
            end

            target[k] = value
        end
    end

	for k,v in pairs(friend.heros) do
		local hero = {};
		attrAssgin(hero,v);
		self:syncServer(hero,v.ct);
	end

	if friend.formationInfo then
		local event = {};
		event.data = friend.formationInfo
		self:revcFormationList(event,true);
	end
	MedalDataMgr:chageDataToFriend(friend)
	EquipmentDataMgr:chageDataToFriend(friend,isFuBen)
end

function HeroDataMgr:changeDataToSkyLadder()
	local skyHero = SkyLadderDataMgr:getSkyLadderHeroInfo()
	if not self.myHeroTable then
		self.myHeroTable = clone(self.heroTable);
	end

	if not self.myFormation then
		self.myFormation = clone(self.formation)
	end

	if not self.myHaveList then
		self.myHaveList = clone(self.haveList);
	end

	self.heroTable = clone(TabDataMgr:getData("Hero"));
	self.haveList  = {};

	local function attrAssgin(target, src)
		for k, v in pairs(src) do
			local value = v
			if k == "attr" then
				local ischange = false;
				value = {}
				for _, attr in pairs(v) do
					if type(attr) == "table" then
						ischange =  true
						value[attr.type] = attr.val
					end
				end
				if not ischange then
					value = v;
				end
			end

			target[k] = value
		end
	end

	for k,v in pairs(skyHero) do
		local hero = {};
		attrAssgin(hero,v);
		self:syncServer(hero,v.ct);
	end

	dump(self.formation)
	for _id,hero in pairs(self.heroTable) do
		hero.job = 4;
		for _pos,sid in pairs(self.formation.stance) do
			if hero.ishave and hero.sid == sid then
				hero.job = _pos;  	--队长
				self.formation.heros[_pos] = hero.id
			end
		end
	end
	self:resetShowList();

	MedalDataMgr:changeDataToSelf()
	EquipmentDataMgr:chageDataToSkyLadder()
end

function HeroDataMgr:changeDataToSelf()
	if self.myHeroTable then
		--self.heroTable = self.myHeroTable;
		-- self.haveList  = self.myHaveList;
		self.formation = self.myFormation;
		self.heroTable = clone(TabDataMgr:getData("Hero"));
		self.haveList  = {};

		GoodsDataMgr:resetHeros();

		for _id,hero in pairs(self.heroTable) do
			hero.job = 4;
			for _pos,cid in pairs(self.formation.heros) do
				if hero.ishave and hero.id == cid then
					hero.job = _pos;  	--队长
				end
			end
		end

		MedalDataMgr:changeDataToSelf()
		EquipmentDataMgr:changeDataToSelf();

		self.myHeroTable = nil;
		self.myHaveList = nil;
		self.myFormation = nil;

		self:resetShowList();
	end

	---清空天梯的查看英雄ID
	SkyLadderDataMgr:setCheckHeroId()
end

function HeroDataMgr:getCurLevelMax(heroid,_advancedLvl)
	--精灵等级上限由突破限制改为由玩家等级限制，精灵等级不能超过当前玩家等级。
	local maxLevel = MainPlayer:getPlayerLv()
	return maxLevel
end

---没到最高级，且有经验道具(并不是升一级)
function HeroDataMgr:checkCanLevelUp(id)
	if not self:getIsHave(id) then
		return false
	end

	local hero = self.heroTable[id];
	local curLvMax = self:getCurLevelMax(id);
	if hero.lvl >= curLvMax then
		return false
	end

	local needItem = hero.expitem;
	for k,v in pairs(needItem) do
		if GoodsDataMgr:getItemCount(v) > 0 then
			return true;
		end
	end

	return false;
end

--升级
function HeroDataMgr:heroLevelUp(id,items)
	if not self:getIsHave(id) then
		return;
	end

	local hero = self.heroTable[id];
	self.oldHero = clone(hero);
	local msg = {
			hero.sid,
			{
				{
					items[1].itemId,
					items[1].num,
				}
			}
	}

	TFDirector:send(c2s.HERO_HERO_UPGRADE, msg)
end

function HeroDataMgr:revcHeroExp(event)
	self:setHeroExp(event.data.cid,event.data.exp);
	GoodsDataMgr:syncHeroExp(event.data.cid,event.data.exp);
	EventMgr:dispatchEvent(EV_HERO_LEVEL_UP);
end

function HeroDataMgr:recvHeroLevelUp(event)
	if not self.oldHero then return end

	local id = self.oldHero.id
	if self:getLv(id) > self.oldHero.lvl then
		local layer = require("lua.logic.fairyNew.FairyLevelUpResult"):new(self.oldHero)
	    AlertManager:addLayer(layer)
	    AlertManager:show()

		EventMgr:dispatchEvent(EV_HERO_LEVEL_UP);
	end
	self.oldHero = nil;
end

--突破
function HeroDataMgr:checkHeroStrengthen(id)
	if not self:getIsHave(id) then
		return false
	end


	local lv = self:getStrengthenLv(id)

	if lv >= 10 then
		return false;
	end

	local need = self:getStrengthenNeed(id);
	for k,v in pairs(need) do
		local itemcount = GoodsDataMgr:getItemCount(v[1]);
		if itemcount < v[2] then
			return false;
		end
	end

	return true;
end

function HeroDataMgr:heroStrengthen(id)
	if not self:checkHeroStrengthen(id) then
		return;
	end

	local hero = self.heroTable[id];
	self.oldHero = clone(hero);
	local msg = {
		hero.sid
	}

	TFDirector:send(c2s.HERO_HERO_ADVANCE,msg);
end

function HeroDataMgr:revcHeroStrengthen(event)
	local layer = require("lua.logic.fairyNew.StrengthenResult"):new({self.oldHero,1})
    AlertManager:addLayer(layer)
    AlertManager:show()
    EventMgr:dispatchEvent(EV_HERO_LEVEL_UP)
end

function HeroDataMgr:heroOnBattle(sourceHeroId,targetHeroId)
	local sourcehero = self.heroTable[sourceHeroId]
	local sourceJob = sourcehero.job;
	local sourceSid = sourcehero.sid;
	local targetSid = "";
	if targetHeroId then
		targetSid = self.heroTable[targetHeroId].sid
	end

	local msg = {
			1,
			sourceSid,
			targetSid,
	}

	TFDirector:send(c2s.PLAYER_OPERATE_FORMATION,msg);
end

function HeroDataMgr:changeDataByLevelCfg(levelCfg_,formationData)
	if formationData then

		local levelFormation 	= nil
		local heroForbiddenID 	= nil
		local showHeros 		= nil

		if levelCfg_ then
			levelFormation = FubenDataMgr:getLevelFormation(levelCfg_.id)
			heroForbiddenID = levelCfg_.heroForbiddenID;
			showHeros = levelCfg_.showHero;
		end

		local friend = {};
		friend.heros = {};
		for k,v in pairs(formationData) do
			local data = v.data or {}
			friend.heros[k] = data
			friend.heros[k].Inoperable = data.isLimitHero;
			friend.heros[k].equipFilter = true;
		end

		if not levelFormation then
			levelFormation = clone(self.formation);
			local heros = {}
			for _,hero in ipairs(formationData) do
				if hero.data then
					table.insert(heros,tostring(hero.data.cid))
				end
			end
			levelFormation.stance = heros;
		end

		friend.formationInfo = {{levelFormation}};

		local function checkRepet(cid)
			for k,v in pairs(friend.heros) do
				if v.cid == cid then
					return true;
				end
			end

			return false;
		end

		local function checkForbidden(cid)
			if not heroForbiddenID then
				return false;
			end

			for k,v in pairs(heroForbiddenID) do
				if v == cid then
					return true;
				end
			end
			return false;
		end

		local function checkCanChangeOrAdd()
			if table.count(formationData) < 3 then
				return true
			end

			for k,v in pairs(formationData) do
				if v.data and not v.data.limitType then
					return true;
				end
			end

			return false
		end

		if levelCfg_ and levelCfg_.heroLimitType ~= 1 and checkCanChangeOrAdd() and  levelCfg_.heroLimitType ~= 4 then
			for k,v in pairs(self.haveList) do
				if not checkRepet(v.cid) then
					table.insert(friend.heros,v);
				end
			end
		end

		for k,v in pairs(friend.heros) do
			if checkForbidden(v.cid) then
				v.Inoperable = true;
			end
			v.ct = EC_SChangeType.DEFAULT
		end

		changeToServer = false;
		self:changeDataToFriend(friend,true);
	end
end

function HeroDataMgr:changeDataByFuben(levelID,formationData)
	local levelCfg_  = FubenDataMgr:getLevelCfg(levelID)
	self:changeDataByLevelCfg(levelCfg_,formationData)
end

function HeroDataMgr:changeFormation(_pos,_changeToServer, isEndless, isSkyLadder,limitSimulationTrial,containSimulationTrial)
	local changeToServer = _changeToServer;
	if _changeToServer == nil then
		changeToServer = true
	end


	-- if levelID and formationData then
	-- 	local levelCfg_  = FubenDataMgr:getLevelCfg(levelID)
	-- 	local levelFormation = FubenDataMgr:getLevelFormation(levelID)
	-- 	local heroForbiddenID = levelCfg_.heroForbiddenID;

	-- 	local friend = {};
	-- 	friend.heros = {};
	-- 	for k,v in pairs(formationData) do
	-- 		friend.heros[k] = v.data
	-- 		friend.heros[k].Inoperable = v.data.limitType;
	-- 	end

	-- 	if not levelFormation then
	-- 		levelFormation = clone(self.formation);
	-- 		local heros = {}
	-- 		for _,hero in ipairs(formationData) do
	-- 			table.insert(heros,tostring(hero.data.cid))
	-- 		end
	-- 		levelFormation.stance = heros;
	-- 	end

	-- 	friend.formationInfo = {{levelFormation}};

	-- 	local function checkRepet(cid)
	-- 		for k,v in pairs(friend.heros) do
	-- 			if v.cid == cid then
	-- 				return true;
	-- 			end
	-- 		end

	-- 		return false;
	-- 	end

	-- 	local function checkForbidden(cid)
	-- 		for k,v in pairs(heroForbiddenID) do
	-- 			if v == cid then
	-- 				return true;
	-- 			end
	-- 		end
	-- 		return false;
	-- 	end

	-- 	local function checkCanChangeOrAdd()
	-- 		if table.count(formationData) < 3 then
	-- 			return true
	-- 		end

	-- 		for k,v in pairs(formationData) do
	-- 			if not v.data.limitType then
	-- 				return true;
	-- 			end
	-- 		end

	-- 		return false
	-- 	end

	-- 	if levelCfg_.heroLimitType ~= 1 and checkCanChangeOrAdd() then
	-- 		for k,v in pairs(self.haveList) do
	-- 			if not checkRepet(v.cid) then
	-- 				table.insert(friend.heros,v);
	-- 			end
	-- 		end
	-- 	end

	-- 	for k,v in pairs(friend.heros) do
	-- 		if checkForbidden(v.cid) then
	-- 			v.Inoperable = true;
	-- 		end
	-- 		v.ct = EC_SChangeType.DEFAULT
	-- 	end

	-- 	changeToServer = false;
	-- 	self:changeDataToFriend(friend);
	-- end
	local layer = requireNew("lua.logic.fairy.FormationLayer"):new({
		_pos = _pos,
		changeToServer = changeToServer,
		isEndless = isEndless, 
		isSkyLadder = isSkyLadder ,
		limitSimulationTrial  = limitSimulationTrial,
		containSimulationTrial = containSimulationTrial });
    AlertManager:addLayer(layer)
    AlertManager:show()
end


function HeroDataMgr:composeHero(id)
	if self:getIsHave(id) and self.heroTable[id].heroStatus ~= 2 then
		return;
	end

	local msg = {
		id
	}

	TFDirector:send(c2s.HERO_HERO_COMPOSE,msg);
end

function HeroDataMgr:revcComposeHero(event)
	EventMgr:dispatchEvent(EV_HERO_REFRESH)
end
--
--装备
--

function HeroDataMgr:getIsHaveEquip(heroid,_pos,isTrial)
	if not self:getIsHave(heroid) and not isTrial then
		return false;
	end

	local ret = false;
	local equipid =  "";
	local equipCid = ""
	local equipments = self.heroTable[heroid].equipments;
	if isTrial and (not equipments or #equipments == 0) and self.heroTable[heroid].testType == 1 then -- 判断是否拥有默认数据
		equipments = {}
		local defaultData = TabDataMgr:getData("HeroTest",heroid) -- TODO 获取配置默认数据
		if defaultData then
			local equipLists = defaultData.equipID or {}
			for i,v in pairs(equipLists) do
				local tmp = {}
				tmp.position = i
				tmp.equipmentId = "equipmentId"..i
				tmp.equip = {}
				tmp.equip.cid = v
				table.insert(equipments,tmp)
			end
		end
	end

	if equipments then
		for k,v in pairs(equipments) do
			if v.position == _pos then
				ret = true;
				equipid = v.equipmentId;
				equipCid = v.equip.cid
				break;
			end
		end
	end

	return ret ,equipid, equipCid;
end

function HeroDataMgr:getEquipIdByPos(heroid,_pos,isTrial)
	local ret ,equipid,equipCid = self:getIsHaveEquip(heroid,_pos,isTrial);
	if ret then
		return equipid,equipCid;
	end

	return "none";
end

---判断装备组合技能是否激活
function HeroDataMgr:checkCombByPos(heroid,pos1,pos2,equip,isTrial)
	local ret = {}
	local equip1 = equip
	local _equipCid1 = 0
	if not equip then
		equip1,_equipCid1 = self:getEquipIdByPos(heroid,pos1,isTrial);
	end
	local equip2,_equipCid2 = self:getEquipIdByPos(heroid,pos2,isTrial);

	if equip1 == "none" or equip2 == "none" then
		ret.isok = false;
		return ret;
	end
	local default = false
	if string.find(equip1,"equipmentId") then
		equip1 = _equipCid1
		default = true
	end


	if string.find(equip2,"equipmentId") then
		equip2 = _equipCid2
	end


	local subType1 = EquipmentDataMgr:getEquipSubType(equip1);
	local subType2 = EquipmentDataMgr:getEquipSubType(equip2);
	local star1   = EquipmentDataMgr:getEquipStarLv(equip1);
	local star2   = EquipmentDataMgr:getEquipStarLv(equip2);

	local star = star1;
	if star2 < star then
		star = star2
	end


	local combination = EquipmentDataMgr:getEquipCombInfo(equip1,default);
	for combid,combneed in pairs(combination) do
		if table.indexOf(combneed,subType2) ~= -1 then
			ret.combid = combid;
			ret.isok = true;
			ret.skillid = TabDataMgr:getData("EquipmentCombination",combid).skill[star]
			ret.lv = star;
			return ret;
		end
	end

	ret.isok = false;
	return ret;
end

function HeroDataMgr:checkSuit(heroid)
	local equip1 = self:getEquipIdByPos(heroid,1);
	local equip2 = self:getEquipIdByPos(heroid,2);
	local equip3 = self:getEquipIdByPos(heroid,3);
	local ret = {}
	if equip1 == "none" or equip2 == "none" or equip3 == "none" then
		return ret
	end

	local suitData1 = EquipmentDataMgr:getEquipSuitInfos(equip1);
	if table.count(suitData1) < 1 then
		return ret
	end
	local suitData2 = EquipmentDataMgr:getEquipSuitInfos(equip2)
	local suitData3 = EquipmentDataMgr:getEquipSuitInfos(equip3)
	for k, v in pairs(suitData1) do
		if suitData2[k] and suitData3[k] then
			table.insert(ret, tonumber(k))
		end
	end
	if #ret > 0 then
		return ret
	end

	local combInfo = {}
	combInfo[1] = self:checkCombByPos(heroid,1,2);
	combInfo[2] = self:checkCombByPos(heroid,2,3);
	combInfo[3] = self:checkCombByPos(heroid,1,3);
	for i=1,3 do
		if combInfo[i].isok == false then
			ret = {}
			break
		end
	end
	return ret
end

function HeroDataMgr:getSkillTab(heroid,isTeam)
	local skillTab = {};

	--组合技能
	local combInfo = {}
	combInfo[1] = self:checkCombByPos(heroid,1,2);
	combInfo[2] = self:checkCombByPos(heroid,2,3);
	combInfo[3] = self:checkCombByPos(heroid,1,3);
	for i=1,3 do
		if combInfo[i].isok ~= false then
			table.insert(skillTab,combInfo[i].skillid);
		end
	end

	--固有技能
	for i=1,3 do
		local equipid = self:getEquipIdByPos(heroid,i);
		if equipid ~= "none" then
			local skillid = EquipmentDataMgr:getEquipInherentSkill(equipid);
			table.insert(skillTab,skillid);
		end
	end

	--套装技能

	local suitIds = self:checkSuit(heroid)
	if #suitIds > 0 then
		for i, suitid in ipairs(suitIds) do
		    local skillID = TabDataMgr:getData("EquipmentSuit",suitid).suitSkill
		    table.insert(skillTab,skillID)
		end
	end

	--装备羁绊技能
	local skillIds = EquipmentDataMgr:getNewEquipSkillEffectByHeroId(heroid)
	for i,v in ipairs(skillIds) do
		table.insert(skillTab,v)
	end

	--宝石技能
	local gemSkills = self:getGemSkillEffectId(heroid)
	for i,v in ipairs(gemSkills) do
		table.insert(skillTab,v)
	end

	--灵力共鸣技能(组队用战斗数据)
	local isOpen = FunctionDataMgr:isOpen(151)
	if not isTeam and isOpen then
		local manaSkills = ResonanceDataMgr:getManaSkills()
		for i,v in ipairs(manaSkills) do
			table.insert(skillTab,v)
		end
	end

	return skillTab;
end

function HeroDataMgr:getAngelSkllID(heroid,idx,lv)
	local angelLvl = self:getAngelLevel(heroid)
	local skinid   = self:getCurSkin(heroid);

	if idx == EC_SKILL_TYPE.JUEXING then
		--if lv then
			return self.heroSkinTable[skinid].supperSkills
		--else
			--return self.heroSkinTable[skinid].supperSkills[angelLvl]
		--end
	end

	return self.heroSkinTable[skinid].angelSkills[idx];
end

function HeroDataMgr:getUseSkillStrategy(heroid)
	return self.heroTable[heroid].useSkillStrategy or 1;
end

function HeroDataMgr:setTmpUseSkillStrategy(heroid, pageId)
	self.heroTable[heroid].useSkillStrategy  = pageId;
end

function HeroDataMgr:getAngelLevel(heroid)

	return self.heroTable[heroid].angelLvl or 1;
end

function HeroDataMgr:getAngelName(heroid)
	local angelLvl = self:getAngelLevel(heroid);
	local skinid = self:getCurSkin(heroid);
	local weaponCid   = self.heroSkinTable[skinid].paintWeapon
	return self.heroWeaponModleTable[weaponCid].weaponName
end

function HeroDataMgr:getName(heroid)
	local nameId = self.heroTable[heroid].name
	local name   = TextDataMgr:getText(nameId)
	return name
end

function HeroDataMgr:getEnName2(heroid)
	local enName = self.heroTable[heroid].enName2
	return enName
end

function HeroDataMgr:getEnName(heroid)
	local enName = self.heroTable[heroid].enName
	return enName
end

function HeroDataMgr:getHeroWeaponType(heroid)
	local _type = self.heroTable[heroid].weaponType
	return _type
end

function HeroDataMgr:getHeroWeaponName(heroid)
	local _type = self.heroTable[heroid].weaponType
	return TextDataMgr:getText(EC_Hero_Weapon_Name[_type])
end

function HeroDataMgr:getAngelModelPath(heroid)
	local skinid = self:getCurSkin(heroid);
	local weaponCid   = self.heroSkinTable[skinid].paintWeapon
	local path = self.heroWeaponModleTable[weaponCid].weaponPaint
	return path;
end

function HeroDataMgr:getAngelModelScale(heroid)
	local skinid = self:getCurSkin(heroid);
	local weaponCid   = self.heroSkinTable[skinid].paintWeapon
	local scale   = self.heroWeaponModleTable[weaponCid].weaponPaintSize
	return scale;
end

function HeroDataMgr:getAngelModelPosOffset(heroid)
	local skinid = self:getCurSkin(heroid);
	local weaponCid   = self.heroSkinTable[skinid].paintWeapon
	local pos   = self.heroWeaponModleTable[weaponCid].weaponPaintPosition;
	return pos;
end

function HeroDataMgr:getAngelModelEffect(heroid)
    local skinid = self:getCurSkin(heroid)
    local weaponCid = self.heroSkinTable[skinid].paintWeapon
    local effect = self.heroWeaponModleTable[weaponCid].particleEffect
    return effect
end

function HeroDataMgr:getEquipShowHeroIconPath(heroid)
	local skinid = self:getCurSkin(heroid)
	local iconPath   = self.heroSkinTable[skinid].Equipheroicon
	return iconPath
end

function HeroDataMgr:getSkinAngleSkillID(heroid, skillType)
	local skinid = self:getCurSkin(heroid)
	local heroSkinInfo   = self.heroSkinTable[skinid]
	local skillId = nil
	-- if skillType == EC_SKILL_TYPE.NORMAL then
	-- 	skillId = heroSkinInfo.angelSkills[1]
	-- elseif skillType == EC_SKILL_TYPE.SKILL_1 then
	-- 	skillId = heroSkinInfo.angelSkills[2]
	-- elseif skillType == EC_SKILL_TYPE.SHANBI then
	-- 	skillId = heroSkinInfo.angelSkills[3]
	-- elseif skillType == EC_SKILL_TYPE.BEIDONG then
	-- 	skillId = heroSkinInfo.angelSkills[4]
	if skillType == EC_SKILL_TYPE.JUEXING then
		local angleLv = self:getAngelLevel(heroid)
		skillId = heroSkinInfo.supperSkills
	else
		skillId = heroSkinInfo.angelSkills[skillType]
	end
	return skillId
end

function HeroDataMgr:getAwakenNeed(heroid)
	local angelLvl = self:getAngelLevel(heroid);
	local cons = self.heroTable[heroid].angelWakeCons[angelLvl];
	local need,needid = 0,0
	for k,v in pairs(cons) do
		need = v;
		needid = k;
	end

	return need,needid;
end

function HeroDataMgr:getMaxAgr(heroid)
	return self.heroTable[heroid].attr[EC_Attr.MAX_AGR] / 100
end

function HeroDataMgr:getSkillPoint(heroid)
	local attr = self.heroTable[heroid].attr[EC_Attr.ATTR_SKILL_POINT]
	if type(attr) == "table" then
		attr = attr.val
	end
	local total = attr / 100;
	local point = self.heroTable[heroid].useSkillPiont;
	return total - point;
end

function HeroDataMgr:getSkillPointMax(heroid)
	local attr = self.heroTable[heroid].attr[EC_Attr.ATTR_SKILL_POINT]
	if type(attr) == "table" then
		attr = attr.val
	end
	local total = attr / 100;
	--local point = self.heroTable[heroid].useSkillPiont;
	return total;
end

function HeroDataMgr:angelAwaken(heroid)
	local need,needid = self:getAwakenNeed(heroid);
	local count = GoodsDataMgr:getItemCount(needid);
	if need > count then
		return;
	end

	self.awakenHeroId = heroid
	self.oldSkillPoint = self:getSkillPointMax(heroid)
	heroid = self:getHeroSid(heroid);
	local msg = {
		heroid
	}
	TFDirector:send(c2s.HERO_REQ_AWAKE_ANGEL,msg);
end

function HeroDataMgr:revcAngelAwaken(event)
	local hero = self:getHero(tonumber(event.data.heroId))
	hero.angelLvl = event.data.angelLvl
	GoodsDataMgr:syncHeroAngelLv(tonumber(event.data.heroId),event.data.angelLvl)
	EventMgr:dispatchEvent(EV_HERO_ANGLE_AWAKE, event.data)
	local layer = require("lua.logic.angel.AngelAwakenResult"):new({self.awakenHeroId,self.oldSkillPoint})
    AlertManager:addLayer(layer)
    AlertManager:show()
    self.awakenHeroId = nil;
end

function HeroDataMgr:getAngelTalentLv(heroid,type,pos)
	if not self:getAngelSkillInfo(heroid) then
		return 0;
	end

	if not self:getAngelSkillInfo(heroid)[type] then
		return 0
	end

	if not self:getAngelSkillInfo(heroid)[type][pos] then
		return 0
	end

	return self:getAngelSkillInfo(heroid)[type][pos].lvl or 0
end

function HeroDataMgr:calcOneAngelSkillPointUse(heroid,_type)
	if index == 5 then
		return 0;
	end

	local total = 0
	local skillid = self:getAngelSkllID(heroid,_type);
	for pos = 1 ,9 do
		local lv = self:getAngelTalentLv(heroid,_type,pos);
		if lv == 0 then
			total = total +  0;
		else

			for i=1,lv do
				total = total + AngelDataMgr:getOneTalentNeed(heroid,skillid,pos,i)
			end

		end
	end

	return total;
end

function HeroDataMgr:resetAngelTree(heroid,_types)
	heroid = self:getHeroSid(heroid);
	local msg = {
		heroid,
		_types
	}
	TFDirector:send(c2s.HERO_REQ_ANGEL_RESET,msg);
end

function HeroDataMgr:revcResetAngelTree(event)
end

function HeroDataMgr:getAngelSkillInfo(heroid, fangAnID)
	local angelSkillInfos = self.heroTable[heroid].angeSkillInfos or {}
	
	return angelSkillInfos
end

function HeroDataMgr:getAngelTalents(heroid)
	local hero = self.heroTable[heroid];
	if not hero then
		return {};
	end

	if not self:getAngelSkillInfo(hero.cid) then
		return {}
	end

	local ret = {};

	--主技能
	local angelLv = self:getAngelLevel(heroid);
	if angelLv > 1 then
		local talentid = AngelDataMgr:getAngelAwakenTalentId(heroid);
		table.insert(ret,talentid);
	end

	for _type,v in pairs(self:getAngelSkillInfo(hero.cid)) do
		for pos ,v2 in pairs(v) do
			table.insert(ret,v2.talentId);
		end
	end

	--被动技能
	local useID = self:getUseSkillStrategy(heroid);
	local angelSkillInfo = AngelDataMgr:getHeroSkillStrategyData(heroid,useID,true);
	local passiveSkillInfo = angelSkillInfo.passiveSkillInfo or {}
	for k,v in pairs(passiveSkillInfo) do
		for k2,v2 in pairs(v) do
			if k2 == "skillId" and v2 ~= 0 then
				table.insert(ret,v2);
			end
		end
	end

	table.sort(ret)
	dump({"getAngelTalents",heroid,ret})
	return ret;
end

function HeroDataMgr:heroProgress(heroid)
	local hero = self.heroTable[heroid];
	self.oldHero = clone(hero);
	local msg = {
		hero.sid,
	}
	TFDirector:send(c2s.HERO_REQ_UP_QUALITY,msg);
end

function HeroDataMgr:revcHeroProgress(event)
	local layer = require("lua.logic.fairyNew.StrengthenResult"):new({self.oldHero,2})
    AlertManager:addLayer(layer)
    AlertManager:show()
    local condition = self.heroTable[self.oldHero.cid].condition
	if condition and condition.heroQuality and self:getQuality(self.oldHero.cid) >= condition.heroQuality then
        local superSkin = self:getHeroSuperSkin(self.oldHero.cid)
        self:changeSkin(self.oldHero.cid,superSkin, true)
	end
end

function HeroDataMgr:getAttributes()
	return self.heroAttTable
end

function HeroDataMgr:getAttributeValue(heroId,attId)
	-- 之前的属性是服务端直接发的，只有攻防血3个。
	-- 现在的话有2个变化：
	-- 1是有些属性显示的格式需要客户端进行处理，比如暴击率、格挡率这种，
	--  服务端发的应该是万分比，需要客户端处理为15%这种类型。
	-- 2是现在需要把天赋类buff的值加到属性中进行显示，需要客户端去找装备、
	--  技能上的天赋类buff和他们对应的属性值，然后和服务端发的同类属性加到一起进行显示。
	local hero      = self:getHero(heroId)
	local heroAtt   = hero and hero.attr or nil
	if not hero or not heroAtt then
		return 0
	end
	local attVal    = heroAtt[attId] or 0


	if type(attVal) == "table" then
		attVal = attVal.val
	end

	local skilltab = self:getSkillTab(heroId);
	for k,v in pairs(skilltab) do
		local data = TabDataMgr:getData("PassiveSkills",v)
		if data and data.attribute then
			for k2,v2 in pairs(data.attribute) do
				if k2 == attId then
					attVal = attVal + v2;
				end
			end
		end
		if data.attributeExtra and data.attributeExtra[heroId] then
			local extraAttr = data.attributeExtra[heroId]
			if extraAttr then
				for k3,v3 in pairs(extraAttr) do
					if k3 == attId then
						attVal = attVal + v3
					end
				end
			end
		end
	end

	if attVal > 0 then
		local attConfig = self:getAttributeConfig(attId)
		local addRatio = 0
		if attConfig.hasRatio == 1 then
			addRatio = self:getAttributeValue(heroId,attConfig.ratioAttributeId)
		end
		--最终的属性值=基础模块属性值*（1+对应加成率/10000）
		attVal = attVal * (1+addRatio/10000) / attConfig.division
	end
	return attVal
end

function HeroDataMgr:getAttributeValueStr(heroId,attId)
	local attValue = self:getAttributeValue(heroId,attId)
	if not attValue or attValue<=0 then
		return "0"
	end

	local attConfig = self:getAttributeConfig(attId)
	attValue = string.format("%."..attConfig.decimal.."f",attValue)
	attValue = string.format(attConfig.displayFormat,attValue)

	return attValue
end

function HeroDataMgr:sortAttributeTable()
	table.sort(self.heroAttTable, function(a, b)
		return a.order < b.order
	end)
end

function HeroDataMgr:getAttributeConfigByType(attType)
	local tabAtt = {}
	for i, v in ipairs(self.heroAttTable) do
		if v.attributeType == attType then
			table.insert(tabAtt, v)
		end
	end
	table.sort(tabAtt, function(a,b)
		return a.order < b.order
	end)
	return tabAtt
end

function HeroDataMgr:getAttributeConfig(attId)
	for i, v in ipairs(self.heroAttTable) do
		if v.attributeId == attId then
			return v
		end
	end
	return nil
end

function HeroDataMgr:checkCompose()
	local ret = false
	for k,v in pairs(self.heroTable) do
		if not self:getIsHave(v.id) and self:isCanCompose(v.id) then
			ret = true
			break;
		end
	end
	return ret;
end

function HeroDataMgr:chckCanProgress(id)
	local ret = false;
	if self:getIsHave(id) then
		local quality = self:getQuality(id);

		if quality < 5 then
			local needs = self:getProgressNeed(id);--合成
	        local costId, costNum;
	        costId = needs[1];
	        costNum = needs[2];

	        if GoodsDataMgr:currencyIsEnough(costId, costNum) then
	           ret = true;
	        end
	    end
	end

	return ret;
end

function HeroDataMgr:checkProgress()
	local ret = false;
	for k,v in pairs(self.heroTable) do
		if self:chckCanProgress(v.id) then
			ret = true;
			break;
		end
	end

	return ret;
end

function HeroDataMgr:checkLevelUp()
	local ret = false;
	for k,v in pairs(self.heroTable) do
		if self:getIsHave(v.id) then
			if self:checkCanLevelUp(v.id) then
				ret = true;
				break
			end
		end
	end

	return ret;
end

function HeroDataMgr:checkStrengthen()
	local ret = false;
	for k,v in pairs(self.heroTable) do
		if self:getIsHave(v.id) then
			if self:checkHeroStrengthen(v.id) then
				ret = true;
				break
			end
		end
	end

	return ret;
end

function HeroDataMgr:checkOneHeroEquip(id)
	if self:getIsHave(id) then
		for i=1,3 do
			local ishave = self:getIsHaveEquip(id ,i);
			if not ishave then
				local list = EquipmentDataMgr:initShowList(id,i);
				if table.count(list) > 0 then
					local cost = self:getCost(id) + self:getNewEquipCost(id)
					local costmax = self:getCostMax(id)
					for i1, v1 in ipairs(list) do
						for i2, v2 in ipairs(v1) do
							local equipcost = EquipmentDataMgr:getEquipCost(v2)
							if equipcost <= costmax - cost then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function HeroDataMgr:checkEquipment()
	local ret = false;
	if not EquipmentDataMgr:isCanUseEquip() then
		return ret;
	end

	for k,v in pairs(self.heroTable) do
		if self:checkOneHeroEquip(v.id) then
			return true
		end
	end

	return ret
end

function HeroDataMgr:checkOneHeroAngel(id)
	local ret = false

	if not self:getIsHave(id) then
		return false;
	end

	if self:getAngelLevel(id) >= 5 then
		return false;
	end

	local costNum,costId = self:getAwakenNeed(id)
    if GoodsDataMgr:currencyIsEnough(costId, costNum) then
        ret = true;
    end
    return ret;
end

function HeroDataMgr:checkAngel()
	local ret = false;
	for k,v in pairs(self.heroTable) do
		if self:getIsHave(v.id) and self:checkOneHeroAngel(v.id) then
			ret = true;
			break;
		end
	end

	return ret;
end

function HeroDataMgr:checkOneHero(id)
	local ret = false;
	if not ret then
		ret = self:isCanCompose(id)
	end

	if not ret then
		if self:getIsHave(id) then
			ret = self:chckCanProgress(id);
		end
	end

	if not ret then
		ret = self:checkCanLevelUp(id)
	end

	if not ret then
		ret = self:checkHeroStrengthen(id);
	end

	if not ret then
		ret  = self:checkOneHeroEquip(id)
	end

	if not ret then
		ret = self:checkOneHeroAngel(id);
	end

	return ret;
end

function HeroDataMgr:checkRedPoint()
	local ret = false;

	ret = self:checkCompose();

	if not ret then
		ret = self:checkProgress()
	end

	if not ret then
		ret = self:checkLevelUp();
	end

	if not ret then
		-- ret = self:checkStrengthen() --突破不要了？改成结晶了？测试先屏蔽掉
	end

	if not ret then
		ret = self:checkEquipment();
	end

	if not ret then
		ret = self:checkAngel();
	end

	return ret;
end

function HeroDataMgr:getHeroIdByRoleId(roleId)
    local heroId
    for k, v in pairs(self.heroTable) do
        if v.role == roleId then
            heroId = k
            break
        end
    end
    return heroId
end

function HeroDataMgr:getHeroRoleId(id)
	local data = self.heroTable or {}
	local info = data[id] or {}
	return info.role;
end


function HeroDataMgr:checkSkinUnlock(skinid)
	local skins = GoodsDataMgr:getBag(11);
	local isCid = type(skinid) == "number";
	if isCid then
		for k,v in pairs(skins) do
			if v.cid == skinid then
				return true
			end
		end
	else
		if skins[skinid] then
			return true;
		end
	end

	return false;
end

function HeroDataMgr:getSkinSid(skinid)
	local skins = GoodsDataMgr:getBag(11);
	for k,v in pairs(skins) do
		if v.cid == skinid then
			return v.id
		end
	end

	return "";
end

function HeroDataMgr:getSkins(heroid)
	local ret = {};
	local skins = self.heroTable[heroid].optionalSkin;
	local sortFunc = function(a,b)
		local ause = 0;
		local buse = 0;
		local aunlock = 0;
		local bunlock = 0;
		if a == self:getCurSkin(heroid) then
			ause = 1;
		end

		if b == self:getCurSkin(heroid) then
			buse = 1;
		end

		if self:checkSkinUnlock(a) then
			aunlock = 1;
		end

		if self:checkSkinUnlock(a) then
			bunlock = 1;
		end

		if ause == buse then
			if aunlock == bunlock then
				return a < b
			else
				return aunlock > bunlock;
			end
		else
			return ause > buse
		end
	end

	table.sort(skins,sortFunc);
	return skins;
end

function HeroDataMgr:getCurSkin(heroid)
	if self:getIsHave(heroid) then
		if self.heroTable[heroid].skinCid then
			return self.heroTable[heroid].skinCid;
		else
			local skins = GoodsDataMgr:getBag(11);
			local skinSid = self.heroTable[heroid].skinId;
			local skinCid = skins[skinSid].cid
			return skinCid;
		end
	else
		return self.heroTable[heroid].defaultSkin;
	end
end

function HeroDataMgr:checkEnableShowChangeSkinBtn(heroid)
	if self:getIsHave(heroid) then
		if self.heroTable[heroid] then
			return self.heroTable[heroid].changeType
		end
	end
	return false
end

function HeroDataMgr:checkEnableChangeSkin(heroid)
	if self:getIsHave(heroid) then
		local condition = self.heroTable[heroid].condition
		if condition and condition.heroQuality and self:getQuality(heroid) >= condition.heroQuality then
			return true
		end
	end
	Utils:showTips(self.heroTable[heroid].accessdes)
	return false
end

function HeroDataMgr:getHeroSuperSkin(heroid)
	if self:getIsHave(heroid) then
		return self.heroTable[heroid].paint
	end
end

function HeroDataMgr:getHeroTempSkinCid(heroid)
	if self:getIsHave(heroid) then
		return self.heroTable[heroid].skinCidTemp
	end
end

function HeroDataMgr:getFightModelPath(heroid,skinid)
	local _skinid = skinid or self:getCurSkin(heroid);
	local fightIdx = TabDataMgr:getData("HeroSkin",_skinid).model;
	local fullPath = "effect/"..fightIdx.."/"..fightIdx;
	return fullPath;
end

function HeroDataMgr:changeSkin(heroid,skinid,isSwitch)
	local sid = self:getHeroSid(heroid);
	local skinId = isSwitch and tostring(skinid) or self:getSkinSid(skinid)
	if skinId == "" then
		skinId = tostring(skinid)
	end
	local msg = {
		sid,
		skinId,
		isSwitch
	}
	TFDirector:send(c2s.HERO_REQ_CHANGE_HERO_SKIN,msg);
end

function HeroDataMgr:revcHeroChangeSkin(event)
	Utils:showTips(800068)
	EventMgr:dispatchEvent(EV_HERO_CHANGE_SKIN,true);
end

function HeroDataMgr:getAngelResetFreeTimes()
	local kvp = Utils:getKVP(8001)
	local usetime = MainPlayer:getFreeTimesUse(1);
	local time = kvp.freeResetCount - usetime;
	return time;
end

function HeroDataMgr:getFriendSkillInfo(heroInfo)
	local player = {}
	player.heros = {heroInfo}
	self:changeDataToFriend(player);
	local angelTalents = self:getAngelTalents(heroInfo.cid);
	local skillTab = self:getSkillTab(heroInfo.cid);
	self:changeDataToSelf();
	return angelTalents,skillTab
end

--获取指定稀有度(阶段)的结晶突破配置数据
function HeroDataMgr:getEvolutionDataByPartition(heroId,partition)
	local tabData = {}
	for i, v in ipairs(self.evolutionTable) do
		if partition then
			if v.heroId == heroId and v.partition == partition then
				table.insert(tabData, v)
			end
		else
			if v.heroId == heroId then
				table.insert(tabData, v)
			end
		end
	end
	return tabData
end

--获取某个阶段内的结晶是否全部突破完成
function HeroDataMgr:getEvolutionPartitionIsFinish(heroId, partition)
	local evoDatas = self:getEvolutionDataByPartition(heroId, partition)
	local isAllFinish = true
	for i, v in ipairs(evoDatas) do
		local isFinish = self:getEvolutionIsFinish(v)
		if not isFinish then
			isAllFinish = false
			break
		end
	end
	return isAllFinish
end

--获取指定结晶是否已完成突破
function HeroDataMgr:getEvolutionIsFinish(evoData)
	--需要服务器的数据来判断
	local cryInfo = self:getCrystalInfo(evoData.heroId, evoData.partition, evoData.cell)
	return cryInfo~=nil
end

--获取指定结晶是否已解锁
function HeroDataMgr:getEvolutionIsUnlock(evoData)
	if not evoData.unlockCondition or #evoData.unlockCondition<=0 then
		return true --没有解锁条件,默认已解锁
	end
	for i, v in ipairs(evoData.unlockCondition) do
		if v == 0 then  --默认已解锁
			return true
		end
		local data  = self:getEvolutionDataById(evoData.heroId, nil, v)
		local isFinish = self:getEvolutionIsFinish(data)
		if isFinish then
			return true
		end
	end
	return false
end

--获取指定id的结晶配置数据
function HeroDataMgr:getEvolutionDataById(heroId,partition,cellId)
	local parDatas = self:getEvolutionDataByPartition(heroId,partition)
	for i, v in ipairs(parDatas) do
		if v.cell == cellId then
			return v
		end
	end
	return nil
end

--从heroId精灵的所有阶段中获取下一个可突破的单个结晶数据，如果没有找到则返回第一阶段的第一个突破数据
function HeroDataMgr:getEvolutionNextCanUpDataByAll(heroId)
	local firstData = nil
	for i=1, 7 do
		local evoDatas = self:getEvolutionDataByPartition(heroId, i)
		local retData, isHave = self:getEvolutionNextCanUpData(evoDatas, heroId)
		if isHave then
			return retData, true
		end
		if i==1 then
			firstData = evoDatas[1]
		end
	end
	return firstData, false
end

--获取指定阶段中下一个可突破的结晶数据,如果没有可突破或已全部突破则返回第一个
function HeroDataMgr:getEvolutionNextCanUpData(evoDatas,heroId)
	if type(evoDatas) == "number" then
		evoDatas = self:getEvolutionDataByPartition(evoDatas,heroId)
	end
	for i, v in ipairs(evoDatas) do
		local isFinish = self:getEvolutionIsFinish(v)
		if not isFinish then
			local isUnlock = self:getEvolutionIsUnlock(v)
			if isUnlock then
				return v, true
			end
		end
	end
	return evoDatas[1], false
end

--请求突破结晶
-- heroId 	: 英雄ID
-- partition: 第几阶段
-- cellId   : 所在格子ID
function HeroDataMgr:doReqActiveCrystal(heroId, partition, cellId,isUseWanNeng)
	heroId = self:getHeroSid(heroId)
	local msg = {
		heroId,
		partition,
		cellId,
		isUseWanNeng
	}

	TFDirector:send(c2s.HERO_REQ_ACTIVE_CRYSTAL, msg)
end

--响应突破结晶
function HeroDataMgr:revcActiveCrystal(event)
	print("响应突破结晶")
	event.data.heroId = self:getHeroCid(event.data.heroId)
	dump(event.data)
	self:addCrystalInfo(event.data)
	EventMgr:dispatchEvent(EV_HERO_ACTIVECRYSTAL, event.data)
end

--响应属性变化(突破结晶后属性改变)
function HeroDataMgr:revcPropertyChange(event)
	print("响应属性变化")
	event.data.heroId = self:getHeroCid(event.data.heroId)
	local data = event.data
	local hero = self:getHero(data.heroId)
	hero.fightPower = data.fightPower
	GoodsDataMgr:syncHeroFightPower(data.heroId,hero.fightPower)
	for i, v in ipairs(data.attr) do
		hero.attr[v.type] = v.val
	end

	---同步天梯数据
	SkyLadderDataMgr:Send_GetHeroNewData({data.heroId})

	EventMgr:dispatchEvent(EV_HERO_PROPERTYCHANGE,data.heroId)
end

--初始化所有突破格子所对应的col、row数据
function HeroDataMgr:initEvolutionCellColRow()
	self.evoCellPosTable = {}

	local typeOneRow = 5 --一列5行 格子类型 如：1、3、5、7列
	local typeTwoRow = 6 --一列6行 格子类型 如：2、4、6列

	--初始化一列5个格子类型的所有列格子的col/row数据，如：1、3、5、7列
	local col = 4
	for i=1, col do
		local realCol = i * 2 - 1
		for i2=1, typeOneRow do
			local index    = (i-1)*(typeOneRow+typeTwoRow)+i2 --格子实际的索引位置index
			self.evoCellPosTable[index] = {col=realCol, row=i2}
		end
	end

	--初始化一列4个格子类型的所有列格子的col/row数据，如：2、4、6列
	local col = 3
	for i=1, col do
		local realCol = i * 2
		for i2=1, typeTwoRow do
			local index    = (i-1)*(typeOneRow+typeTwoRow)+i2+typeOneRow --格子实际的索引位置index
			self.evoCellPosTable[index] = {col=realCol, row=i2}
		end
	end
end

function HeroDataMgr:getEvoCellColRowData(cellIndex)
	local data = self.evoCellPosTable[cellIndex]
	return data
end

function HeroDataMgr:getEvoCellPos(col,row,cellWidth,cellHeight,offsetX,offsetY,parentHeight)
	local posx = col * cellWidth - cellWidth*0.5 + offsetX
	local posy = 0
	if col%2==0 then
		posy = parentHeight - (row * cellHeight - cellHeight*0.5 - cellHeight*0.5) - offsetY
	else
		posy = parentHeight - (row * cellHeight - cellHeight*0.5) - offsetY
	end
	local pos  = ccp(posx, posy)
	return pos
end

function HeroDataMgr:getCellIndexPos(cellIndex,cellWidth,cellHeight,offsetX,offsetY,parentHeight)
	local col_row = self:getEvoCellColRowData(cellIndex)
	local pos     = self:getEvoCellPos(col_row.col,col_row.row,cellWidth,cellHeight,offsetX,offsetY,parentHeight)
	return pos
end

function HeroDataMgr:getShowEvoPartition()
	return self.showEvoPartition
end

function HeroDataMgr:setShowEvoPartition(index)
	self.showEvoPartition = index
end

--获取突破某个结晶点的材料是否充足
function HeroDataMgr:getEvoGoodsIsEnough(evoData)
	local goodsT ={};--需要替换的万能道具的材料
	local goodsTable = TabDataMgr:getData("Item")
	for k, v in pairs(evoData.material) do
		local needCount = v
		local currCount = GoodsDataMgr:getItemCount(k)
		if needCount > currCount then
			-- local t = {id = k,num = needCount - currCount}
			-- table.insert(goodsT,t);
			return false;
		end
	end

	-- if #goodsT == 0 then
	-- 	return true,false --材料够并且不需要用万能道具
	-- end

	-- local needWN = 0;
	-- local WNCount = GoodsDataMgr:getItemCount(510241)
	-- for k,v in pairs(goodsT) do
	-- 	local data = TabDataMgr:getData("EvolutionMaterial",v.id);
	-- 	for k2,v2 in pairs(data.exchange) do
	-- 		needWN = needWN + v.num * v2
	-- 	end
	-- end

	-- if needWN > WNCount then
	-- 	return false,false,needWN --材料不够，万能道具也不够
	-- end

	return true
end

function HeroDataMgr:getEvoNeedWN(evoData)
	local goodsT ={};--需要替换的万能道具的材料
	for k, v in pairs(evoData.material) do
		local needCount = v
		local currCount = GoodsDataMgr:getItemCount(k)
		if needCount > currCount then
			local t = {id = k,num = needCount - currCount}
			table.insert(goodsT,t);
		end
	end

	if #goodsT == 0 then
		return 0;
	end

	local needWN = 0;
	local WNCount = GoodsDataMgr:getItemCount(510241)
	local isCoin = true;
	for k,v in pairs(goodsT) do
		if v.id ~= 500001 then
			local data = TabDataMgr:getData("EvolutionMaterial",v.id);
			for k2,v2 in pairs(data.exchange) do
				needWN = needWN + v.num * v2
			end
		else
			isCoin = v.num <= GoodsDataMgr:getItemCount(500001)
		end
	end

	return needWN,WNCount,(needWN <= WNCount) and isCoin,needWN <= WNCount
end

function HeroDataMgr:getAngleByPos(p1,p2)
    local p = {}
    p.x = p2.x - p1.x
    p.y = p2.y - p1.y

    local r = -math.atan2(p.y,p.x)*180/math.pi
    return r
end

function HeroDataMgr:getModelInfo(heroId, _skinId)
    local skinId = _skinId or self:getCurSkin(heroId)
    local skinInfo = TabDataMgr:getData("HeroSkin", skinId)
    local modelInfo = TabDataMgr:getData("HeroModle",skinInfo.paint);
    return modelInfo
end

function HeroDataMgr:getModelAnimPath(heroId, _skinId)
	local info = self:getModelInfo(heroId, _skinId)
	return info.paint
end

--获取某个英雄的突破数据
function HeroDataMgr:getCrystalInfo(heroId, partition, cellId)
	local heroData = self:getHero(heroId)
	local crystalInfo = heroData.crystalInfo or {}

	if not partition then
		return crystalInfo
	elseif not cellId then
		local tabData = {}
		for i, v in ipairs(crystalInfo) do
			if v.rarity == partition then
				table.insert(tabData, v)
			end
		end
		return tabData
	else
		for i, v in ipairs(crystalInfo) do
			if v.rarity == partition and v.gridId == cellId then
				return v
			end
		end
	end
end

--新增一个结晶突破数据
function HeroDataMgr:addCrystalInfo(data)
	local heroData = self:getHero(data.heroId)
	if not heroData.crystalInfo then
		heroData.crystalInfo = {}
	end
	table.insert(heroData.crystalInfo, data)
	GoodsDataMgr:setHeroCrystalInfo(data.heroId,heroData.crystalInfo)
end

function HeroDataMgr:getOpenedHeroNum()
	local num = 0
	for k, v in pairs(self.heroTable) do
		if v.isOpen and  v.isOpen == 1  and v.heroStatus ~= 3 and v.testType ~=1 then
			num = num + 1
		end
	end
	return num
end

---新装备羁绊
function HeroDataMgr:getNewEquipFetterInfo(heroid)
	local equipFetterInfo = self.heroTable[heroid].euqipFetterInfo
	if (not equipFetterInfo or #equipFetterInfo == 0) and self.heroTable[heroid].testType == 1 then
		local defaultData = TabDataMgr:getData("HeroTest", heroid) -- TODO 获取配置默认数据
		if defaultData then
			local equipFetterList = defaultData.newequipID 
			equipFetterInfo = {}
			for i,v in pairs(equipFetterList) do
				local cfg = TabDataMgr:getData("NewEquip",v)
				local info = {}
				info.index = i - 1
				info.newEquipmentInfo = {}
				info.newEquipmentInfo.id = "defaultId"..i
				info.newEquipmentInfo.cid = v
				info.newEquipmentInfo.stage = cfg.star
				info.newEquipmentInfo.level = cfg.level
				info.newEquipmentInfo.heroId = heroid
				info.newEquipmentInfo.position = i - 1
				table.insert(equipFetterInfo,info)
			end
		end
	end
	return equipFetterInfo
end

function HeroDataMgr:updateEuqipFetterInfo(data)
	self.heroTable[tonumber(data.heroId)].euqipFetterInfo = data.euqipFetterInfo
end

function HeroDataMgr:getNewEquipInfoByPos(heroid, pos)
	local euqipFetterInfo = self:getNewEquipFetterInfo(heroid)
	if euqipFetterInfo then
		for i,v in ipairs(euqipFetterInfo) do
			if v.index == (pos - 1) then
				return v.newEquipmentInfo
			end
		end
	end
end

function HeroDataMgr:checkNewEquipOnHero(heroid, cid)
	local euqipFetterInfo = self:getNewEquipFetterInfo(heroid)
	if euqipFetterInfo then
		for i,v in ipairs(euqipFetterInfo) do
			if v.newEquipmentInfo.cid  == cid then
				return true
			end
		end
	end
	return false
end

function HeroDataMgr:getNewEquipCost(heroid)
	local cost = 0
	local euqipFetterInfo = self.heroTable[heroid].euqipFetterInfo
	if euqipFetterInfo then
		for i,v in ipairs(euqipFetterInfo) do
			local equipCfg = EquipmentDataMgr:getNewEquipCfg(v.newEquipmentInfo.cid)
			cost = cost + equipCfg.cost
		end
	end
	return cost
end

function HeroDataMgr:getEquipSuitAttrDesc(heroid)
	local suitDesc = {}

	return suitDesc
end


---宝石相关
function HeroDataMgr:getGemInfos(heroid, isTrial)
	local gemInfos = self.heroTable[heroid].gemInfos
	if isTrial and  (not gemInfos or #gemInfos == 0) and self.heroTable[heroid].testType == 1  then
		local defaultData = TabDataMgr:getData("HeroTest",heroid)
		if defaultData then
			local gems = defaultData.stoneID or {}
			local stoneCfg = TabDataMgr:getData("Stone")
			gemInfos = {}
			for i,v in pairs(gems) do
				local gemInfo = {}
				gemInfo.id = "stone"..i
				gemInfo.cid = v
				gemInfo.heroId = heroid
				gemInfo.randSkill = stoneCfg[v].specialSkill[1] or {}
				table.insert(gemInfos,gemInfo)
			end
		end
	end
	return gemInfos or {}
end

function HeroDataMgr:getGemInfoByPos(heroid, pos, isTrial)
	if not self:getGemInfos(heroid, isTrial) then
		return nil
	end
	for k, v in pairs(self:getGemInfos(heroid, isTrial)) do
		local idx = math.floor((v.cid % 100) / 10)
		if pos == idx then
			return v
		end
	end
end

function HeroDataMgr:getGemSkillEffectId(heroid)
	if not self:getGemInfos(heroid) then
		return {}
	end
	local skillIds = {}
	for k, v in pairs(self:getGemInfos(heroid)) do
		local gemCfg = EquipmentDataMgr:getGemCfg(v.cid)
		if gemCfg and gemCfg.baseSkill then
			table.insert(skillIds, gemCfg.baseSkill)
		end
		if v.randSkill then
			for i,skillId in ipairs(v.randSkill) do
				table.insert(skillIds, skillId)
			end
		end
	end
	return skillIds
end

function HeroDataMgr:getGemAngelTypeSkills(heroid)
	if not self:getGemInfos(heroid) then
		return {}
	end
	local typeSkills = {}
	for k, v in pairs(self:getGemInfos(heroid)) do
		if v.randSkill then
			local cfg = EquipmentDataMgr:getGemCfg(v.cid)
			typeSkills[cfg.skillType] = typeSkills[cfg.skillType] or {}
			for i,skillId in ipairs(v.randSkill) do
				table.insert(typeSkills[cfg.skillType], skillId)
			end
		end
	end

	return typeSkills
end


-----灵力聚合相关

function HeroDataMgr:getHeroEnergyUpIds()
	local ids = {}
	local data = TabDataMgr:getData("DiscreteData",51507).data
	local limitLevel = data.HeroLevel
    local heroRank = data.HeroRank
	for k, v in pairs(self.heroTable) do
		local quality = self:getQuality(v.id)
		if v.testType == 0 and self:getLv(v.id) >= limitLevel and quality >= heroRank then
			table.insert(ids, v.id)
		end
	end
	table.sort(ids, function(a, b)
		return self.heroTable[a].site <  self.heroTable[b].site
	end)
	return ids
end

function HeroDataMgr:checkHeroEnableEnergyUp(heroId)
	local data = TabDataMgr:getData("DiscreteData",51507).data
	local limitLevel = data.HeroLevel
    local heroRank = data.HeroRank
    local quality = self:getQuality(heroId)
	if self.heroTable[heroId].lvl >= limitLevel and quality >= heroRank then
		return true
	end
	return false
end

function HeroDataMgr:checkHeroAngelEnableBreakUp(heroId)
	local data = TabDataMgr:getData("DiscreteData",90008).data
	local limitLevel = data.heroLevel
    local heroRank = data.heroRank
    local quality = self:getQuality(heroId)
	if self.heroTable[heroId].lvl >= limitLevel and quality >= heroRank then
		return true
	end
	return false
end

--获取灵力信息
function HeroDataMgr:ReqNewSpiritInfo()
	TFDirector:send(c2s.HERO_SPIRIT_REQ_NEW_SPIRIT_INFO,{})
end

function HeroDataMgr:revcGetSpiritInfo(event)
	local data = event.data
	if data.spirits then
		self:syncHeroSpiritInfo(data.spirits)
	end
end

--灵力值加点
function HeroDataMgr:putSpiritPoints(points)
	local msg = {
		points
	}
	TFDirector:send(c2s.HERO_SPIRIT_REQ_PUT_SPIRIT_POINTS,msg)
end

function HeroDataMgr:revcPutSpritPoints(event)
	local data = event.data
	if data.spirit then
		self:syncHeroSpiritInfo(data.spirit)
	end
end

--重置灵力点
function HeroDataMgr:resetSpiritPoints(energyType)
	TFDirector:send(c2s.HERO_SPIRIT_REQ_RESET_SPIRIT_POINTS,{energyType})
end

function HeroDataMgr:revcResetSpiritPoints(event)
	local data = event.data
	if data.spirit then
		self:syncHeroSpiritInfo(data.spirit)
	end
end

--灵力升阶
function HeroDataMgr:reqUpgradeSpirit(costId)
	TFDirector:send(c2s.HERO_SPIRIT_REQ_UPGRADE_SPIRIT,{costId})
end

function HeroDataMgr:revcUpgradeSpirit(event)
	local data = event.data
	if data.spirit then
		self:syncHeroSpiritInfo(data.spirit)
	end
	EventMgr:dispatchEvent(EV_HERO_UPGRADE_SPRIT_POINTS, data)
end

--灵力升级
function HeroDataMgr:reqSpiritUseItem(items)
	TFDirector:send(c2s.HERO_SPIRIT_REQ_SPIRIT_USE_ITEM,{items})
end

function HeroDataMgr:revcSpiritUseItem(event)
	local data = event.data
	if data.spirit then
		self:syncHeroSpiritInfo(data.spirit)
	end
	EventMgr:dispatchEvent(EV_HERO_USE_ITEM_UP_SPRIT, data)
end

function HeroDataMgr:reqOldSpiritView()
	TFDirector:send(c2s.HERO_SPIRIT_REQ_OLD_SPIRIT_VIEW,{})
end

function HeroDataMgr:reqOldSpiritFeedback()
	TFDirector:send(c2s.HERO_SPIRIT_REQ_OLD_SPIRIT_FEEDBACK,{})
end

function HeroDataMgr:revcOldSpiritShowRewards(event)
	local data = event.data
	if data.heroViews then
		Utils:openView("fairyNew.FairyEnergyFeedBackRewardView",data)
	end
end

function HeroDataMgr:revcOldSpiritFeedback(event)
	local data = event.data
	if data.rewards then
		Utils:showReward(data.rewards)
	end
end


--天使灵力升级
function HeroDataMgr:reqUpgradeAngleSpirit(heroId, costId)
	TFDirector:send(c2s.HERO_SPIRIT_REQ_UPGRADE_ANGLE_SPIRIT,{heroId,costId})
end

function HeroDataMgr:revcUpgradeAngleSpirit(event)
	local data = event.data
	EventMgr:dispatchEvent(EV_HERO_ANGEL_BREAK, data)
end

function HeroDataMgr:checkAngelBreakUpEnable(heroId)
	if not self:checkHeroAngelEnableBreakUp(heroId) then
		return false
	end
	
	return true
end

function HeroDataMgr:checkAngelBreakReachMax(heroId)
	local cfg = self:getHeroAngelBreakCfg(heroId, self:getAngelBreakLevel(heroId) + 1)
	if not cfg then
		return true
	end
	return false
end

function HeroDataMgr:getAngelBreakCost(heroId)
	local breakLevel = self:getAngelBreakLevel(heroId)
	local cfgCid = self.heroTable[heroId].AngelLevelId * 1000 + breakLevel
	local cfgMap = TabDataMgr:getData("AngelBreakthrough")
	local cfg = cfgMap[cfgCid]
	return cfg and cfg.BreakCost or {}
end

function HeroDataMgr:getHeroAngelBreakCfg(heroId, level)
	local breakLevel = level or self:getAngelBreakLevel(heroId)
	local cfgCid = self.heroTable[heroId].AngelLevelId * 1000 + breakLevel
	local cfgMap = TabDataMgr:getData("AngelBreakthrough")
	local cfg = cfgMap[cfgCid]
	return cfg
end

function HeroDataMgr:getAngelBreakLevel(heroId)
	local angleSpirits = self.spiritInfo_ and self.spiritInfo_.angleSpirits or {}
	for k,v in pairs(angleSpirits) do
		if v.heroCid == heroId then
			return v.lv
		end
	end
	return 0
end

function HeroDataMgr:reqShowNewSpirit()
	TFDirector:send(c2s.HERO_SPIRIT_REQ_SHOW_NEW_SPIRIT,{})
end

function HeroDataMgr:revcShowNewSpirit(event)
	for k,v in pairs(self.heroTable) do
		if v.spiritInfo then
			if v.spiritInfo.firstShow then
				v.spiritInfo.firstShow = false
			end
		end
	end
end

function HeroDataMgr:revcRefreshSprit(event)
	local data = event.data
	if data.spirits then
		self:syncHeroSpiritInfo(data.spirits)
	end
end


function HeroDataMgr:getHeroEnergyAttrId(heroId)
	return self.heroTable[heroId].EnergyBreakLevel
end

function HeroDataMgr:getHeroEnergyLevel()
	return self.spiritInfo_ and self.spiritInfo_.level or 0
end

function HeroDataMgr:getHeroEnergyUpTimes()
	return self.spiritInfo_ and self.spiritInfo_.dayCount or 0
end

function HeroDataMgr:getHeroEnergyBreakLevel()
	return self.spiritInfo_ and self.spiritInfo_.grade or 0
end

function HeroDataMgr:getHeroEnergyDailyLevelTimes(heroId)
	return self.spiritInfo_ and self.spiritInfo_.dayCount or 0
end

function HeroDataMgr:getHeroEnergyExp()
	return self.spiritInfo_ and self.spiritInfo_.exp or 0
end

function HeroDataMgr:getHeroEnergyLevelUpExp(level)
	local lvl = level or self:getHeroEnergyLevel()
	lvl = lvl + 1
	local maxLevel = self:getEnergyUpMaxLevel()
	if lvl >= maxLevel then
		lvl = maxLevel
	end
	local levelCfg = self:getHeroEnergyLevelCfg(nil ,lvl)
	return levelCfg and levelCfg.EnergyExp or 0
end

function HeroDataMgr:checkEnergyUpEnable()
	local curLv = self:getHeroEnergyLevel()
	local maxLevel = self:getHeroEnergyMaxLevel()
	local breakMaxLevel = self:getEnergyBreakMaxLevel()
	if curLv >= breakMaxLevel then
		return false
	end

	return true
end

function HeroDataMgr:calcEnergyLevelUp(exp)
	local curexp = self:getHeroEnergyExp()
	local totalExp = curexp + exp;
	local level = self:getHeroEnergyLevel()
	local maxLevel = self:getHeroEnergyMaxLevel()
	local breakMaxLevel = self:getEnergyBreakMaxLevel()
	while(1)do

		if level >= maxLevel then
			level = maxLevel
			break
		end
		if level >= breakMaxLevel then
			level = breakMaxLevel
			break
		end

		local needexp = self:getHeroEnergyLevelUpExp(level)
		if needexp <= totalExp then
			totalExp = totalExp - needexp;
			level = level + 1;
		else
			break;
		end
	end

	return level;
end

function HeroDataMgr:getHeroEnergyExpPercent()
	local curExp = self:getHeroEnergyExp()
	local maxExp = self:getHeroEnergyLevelUpExp()
	return curExp / maxExp * 100
end

function HeroDataMgr:getHeroEnergyBreakCid(breakLevel)
	local attrId = self:getHeroEnergyAttrId(heroId)
	local lvl = breakLevel or self:getHeroEnergyBreakLevel()
	local maxLevel = self:getEnergyBreakMaxLevel()
	if lvl >= maxLevel then
		lvl = maxLevel
	end
	local cid = attrId * 1000 + lvl
	return cid
end

function HeroDataMgr:getHeroEnergyBreakCfg(breakLevel)
	local level  = breakLevel or self.spiritInfo_ and self.spiritInfo_.grade or 0
	local cfgMap = TabDataMgr:getData("ContractBreak")
	if cfgMap[level + 1000] then
		return cfgMap[level + 1000]
	end
	return cfgMap[level - 1 + 1000]
end

function HeroDataMgr:getEnergyBreakCost()
	local breakLevel = self.spiritInfo_.grade + 1
	if self:checkHeroMaxEnergyBreak() then
		breakLevel = self.spiritInfo_.grade
	end
	local breakCfg = self:getHeroEnergyBreakCfg(breakLevel)
	local breakCost = breakCfg.BreakCost
	local costData = {}
	for k,v in pairs(breakCost) do
		table.insert(costData,{id = k, num = v})
	end
	return costData
end

function HeroDataMgr:getEnergyUpMaxLevel()
	return self.spiritInfo_ and self.spiritInfo_.maxLv or 0
end

function HeroDataMgr:checkHeroMaxEnergyLevel(level)
	local limitLevel = self.spiritInfo_ and self.spiritInfo_.maxLv or 0
	local lvl = level or self:getHeroEnergyLevel()
	if lvl >= limitLevel then
		return true
	end
	return false
end

function HeroDataMgr:checkHeroMaxEnergyBreak(breakLevel)
	local limitLevel = self.spiritInfo_ and self.spiritInfo_.maxLv or 0
	local lvl = breakLevel or self:getHeroEnergyBreakLevel()
	local cfg = self:getHeroEnergyBreakCfg(lvl + 1)
	if cfg.LimitLevel_Max < 1 or limitLevel > cfg.LimitLevel_Max  then
		return true
	end
	return false 
end

function HeroDataMgr:getHeroEnergyBreakEmblem()
	local cfg = self:getHeroEnergyBreakCfg()
	return cfg.Emblem
end

function HeroDataMgr:getHeroEnergyMaxLevel()
	return self.spiritInfo_ and self.spiritInfo_.maxLv or 0
end

function HeroDataMgr:getEnergyBreakMaxLevel()
	local cfg = self:getHeroEnergyBreakCfg()
	return cfg.LimitLevel_Max
end

function HeroDataMgr:getHeroEnergyLevelCfg(breakLevel, level)
	local breakCfg = self:getHeroEnergyBreakCfg(breakLevel)
	local lvl = level or self:getHeroEnergyLevel()
	local cid = breakCfg.MatchHero * 10000 + lvl
	return TabDataMgr:getData("ContractLevel", cid)
end

function HeroDataMgr:getEnergyPropertyCfg(cid)
	return TabDataMgr:getData("ContractProperty", cid)
end

function HeroDataMgr:checkEnergyEnableBreak(breakLevel)
	local breakCfg = self:getHeroEnergyBreakCfg(breakLevel)
	local lvl = self:getHeroEnergyLevel()
	local maxLevel = self:getHeroEnergyMaxLevel()
	local breakMaxLevel = self:getEnergyBreakMaxLevel()
	if lvl == breakMaxLevel then
		return true
	end
	return false
end

function HeroDataMgr:getHeroEnergyPropertyCfg(cid)
	return TabDataMgr:getData("ContractProperty", cid)
end

function HeroDataMgr:getHeroEnergyPropertyCfgs(energyType)
	local energyPropertys = TabDataMgr:getData("ContractProperty")
	local cfgs = {}
	for k, v in pairs(energyPropertys) do
		if v.EnergyType == energyType then
			table.insert(cfgs, v)
		end
	end

	table.sort(cfgs, function(a, b)
		return a.id < b.id
	end)
	return cfgs
end

function HeroDataMgr:getHeroEnergyPropertyData(energyType)
	local specialism = self.spiritInfo_ and self.spiritInfo_.specialism or {}
	local data = {}
	for i,v in ipairs(specialism) do
		data[v.cid] = v
	end
	return data
end

function HeroDataMgr:getHeroEnergyUseData()
	local specialism = self.spiritInfo_ and self.spiritInfo_.specialism or {}
	local data = {}
	for i,v in ipairs(specialism) do
		local cfg = self:getHeroEnergyPropertyCfg(v.cid)
		if not data[cfg.EnergyType] then
			data[cfg.EnergyType] = 0
		end
		data[cfg.EnergyType] = data[cfg.EnergyType] + v.num
	end
	return data
end

function HeroDataMgr:getHeroEnergyPoints()
	return self.spiritInfo_ and self.spiritInfo_.spiritPoints or 0
end

function HeroDataMgr:checkHeroEnergyUnlock()
	local unlockIds = {}
	for k,v in pairs(self.heroTable) do
		if v.testType ~= 1 then
			if v.spiritInfo then
				if v.spiritInfo.firstShow then
					table.insert(unlockIds, v.id)
				end
			end
		end
	end

	if #unlockIds > 0 then
        --TODO close
		--Utils:openView("fairyNew.FairyHeroEnergyUnlockView",unlockIds)
		self:reqShowNewSpirit()
	end
end

function HeroDataMgr:checkEnergyRedpoint()
	local data = self:getHeroEnergyUseData()
	local usePoint = 0
	for k,v in pairs(data) do
		usePoint = usePoint + v
	end
	if self:getHeroEnergyPoints() - usePoint > 0 then
		return true
	end
	return false
end

function HeroDataMgr:getEnergyAttrValue(attrs, point)
	local attValue = 0
	for k,v in pairs(attrs) do
		local attConfig = self:getAttributeConfig(tonumber(k))
		local attValue = point * v / attConfig.division
		local decimal = attConfig.decimal
		decimal = math.max(2, decimal)
		attValue = string.format("%."..decimal.."f",attValue)
		attValue = string.format(attConfig.displayFormat,attValue)
		return attValue
	end
end

function HeroDataMgr:getEnergyAttrIcon(energyType, isSelect)
    if energyType == 1 then
    	if isSelect then
    		return "ui/fairy/new_ui/energy/ui_008.png"
    	else
    		return "ui/fairy/new_ui/energy/ui_008.png"
    	end
    elseif energyType == 2 then
    	if isSelect then
        	return "ui/fairy/new_ui/energy/ui_007.png"
        else
        	return "ui/fairy/new_ui/energy/ui_007.png"
        end
    elseif energyType == 3 then
    	if isSelect then
        	return "ui/fairy/new_ui/energy/ui_006.png"
        else
        	return "ui/fairy/new_ui/energy/ui_006.png"
        end
    end 
end

function HeroDataMgr:getEnergyResetAttrIcon(energyType)
    if energyType == 1 then
    	return "ui/fairy/new_ui/energy/ui_029.png"
    elseif energyType == 2 then
    	return "ui/fairy/new_ui/energy/ui_027.png"
    elseif energyType == 3 then
    	return "ui/fairy/new_ui/energy/ui_028.png"
    end 
end

function HeroDataMgr:getEnergyAttrNameId(energyType)
    if energyType == 1 then
        return 1329104
    elseif energyType == 2 then
        return 1329102
    elseif energyType == 3 then
        return 1329103
    end 
end

function HeroDataMgr:checkLockHero()

	local haveCouldUnlockHero = false
	local roleCnt = self:getShowCount()
	for i=1,roleCnt do
		local heroid = self:getSelectedHeroId(i)
		local hero = self:getHero(heroid)
		if not hero.ishave or hero.heroStatus == 2 then
			local needs = self:getComposeNeed(heroid);--合成
			local id,needCnt
			for k,v in pairs(needs) do
				id = k;
				needCnt = v;
			end

			local spCnt = GoodsDataMgr:getItemCount(id);
			if spCnt >= needCnt then
				haveCouldUnlockHero = true
				break
			end
		end
	end

	return haveCouldUnlockHero
end

function HeroDataMgr:checkHeroUp()

	local haveCouldUnlockHero = false
	local roleCnt = self:getShowCount()
	for i=1,roleCnt do
		local heroid = self:getSelectedHeroId(i)
		local hero = self:getHero(heroid)
		local isHave =self:getIsHave(heroid)
		if isHave then
			if hero.heroStatus ~= 2 then
				---进阶
				haveCouldUnlockHero = self:heroCouldUpStage(heroid)
				if haveCouldUnlockHero then
					break
				end
			end

			---升级
			haveCouldUnlockHero = self:heroCouldUpLevel(heroid)
			if haveCouldUnlockHero then
				break
			end

			---天使相关
			haveCouldUnlockHero = self:heroCouldUpAngle(heroid)
			if haveCouldUnlockHero then
				break
			end

			---质点相关
			haveCouldUnlockHero = self:heroCouldUpEquip(heroid)
			if haveCouldUnlockHero then
				break
			end

			---信物相关
			haveCouldUnlockHero = self:heroCouldUpNewEquip(heroid)
			if haveCouldUnlockHero then
				break
			end

			---有可穿戴宝石
			haveCouldUnlockHero = self:haveStoneEquip(heroid)
			if haveCouldUnlockHero then
				break
			end

			haveCouldUnlockHero = self:crystalRedTip(heroid)
			if haveCouldUnlockHero then
				break
			end
		end
	end

	return haveCouldUnlockHero
end

---升阶
function HeroDataMgr:heroCouldUpStage(heroid)

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

    if self:reachMaxQuality(heroid) then
        return false
    end

	local needs = self:getProgressNeed(heroid)
	local id = needs[1]
	local needCnt = needs[2]
	local spCnt = GoodsDataMgr:getItemCount(id)
	return spCnt >= needCnt

end

---成功升一级
function HeroDataMgr:heroCouldUpLevel(heroid)

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

	local couldLevelUp = self:checkCanLevelUp(heroid)
	if not couldLevelUp then
		return false
	end
	local curLv = self:getLv(heroid)
	local levelUpCfg = TabDataMgr:getData("LevelUp")[curLv]
	local hero = self.heroTable[heroid];
	local needExp = levelUpCfg.heroExp
	local needItem = hero.expitem;
	local ownExp = self:getExp(heroid) or 0
	for k,v in pairs(needItem) do
		if GoodsDataMgr:getItemCount(v) > 0 then
			local itemCfg = GoodsDataMgr:getItemCfg(v)
			ownExp = ownExp + itemCfg.useProfit.fix.items[1].num
		end
	end
	return ownExp >= needExp
end

function HeroDataMgr:angleActiveSkill(heroid)

	local couldUp = false
	local curSKillPoint    = AngelDataMgr:getAngleTabCurUseSkillPoint(heroid)
	for i,skillType in pairs(EC_SKILL_TYPE) do
		if skillType < 8 then
			local angleBase = AngelDataMgr:getAngleBaseData(heroid,skillType)
			local skill = self:getSkinAngleSkillID(heroid,skillType);
			if skill then
				if skillType ~= EC_SKILL_TYPE.JUEXING and angleBase then
					for pos,skillId in pairs(angleBase) do
						local curLevel = AngelDataMgr:getSkillLevel(heroid, skillType, pos)
						local maxLevel = AngelDataMgr:getSkillMaxLevel(heroid, skillType, pos)
						local oneLvSkillId = AngelDataMgr:getAngleBaseData(heroid, skillType, pos, 1)
						local isUnlock = AngelDataMgr:getIsUnlockSkill(oneLvSkillId)
						if isUnlock and curLevel < maxLevel then
							local nextLvSkillId = AngelDataMgr:getAngleBaseData(heroid, skillType, pos, curLevel + 1)
							local nextLevelConfig  = AngelDataMgr:getAngleConfig(nextLvSkillId)
							local isUnlockNextLv,notUnlockNextLvCode,notUnlockNextLvTips = AngelDataMgr:getIsUnlockSkill(nextLvSkillId)
							couldUp = couldUp or curSKillPoint >= nextLevelConfig.needSkillPiont
						end
					end
				end
			end
		end
	end
	return couldUp
end

---天使相关
function HeroDataMgr:heroCouldUpAngle(heroid)

	local isOpen = FunctionDataMgr:isOpen(31)
	if not isOpen then
		return false
	end

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

	---技能可激活
	local couldUp = self:angleActiveSkill(heroid)

	---可装备被动
	if not couldUp then
		for i=1, 4 do
			local isUnlock = AngelDataMgr:getIsUnlockPassiveSkillSlot(heroid, i)
			local isHaveLoadSkill = AngelDataMgr:getIsLoadPassiveSkillByPos(heroid, i)
			if not isHaveLoadSkill and isUnlock then
				couldUp = true
				break
			end
		end
	end

	-----天使可觉醒
	if not couldUp then
		couldUp = self:checkOneHeroAngel(heroid)
	end
	return couldUp
end

---质点相关
function HeroDataMgr:heroCouldUpEquip(heroid)

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

	---质点可穿戴
	local couldUp = self:checkOneHeroEquip(heroid)

	if not couldUp then
		for i=1,3 do
			local ishave = self:getIsHaveEquip(heroid ,i);
			if ishave then

				---可升级
				local equipmentId 	= self:getEquipIdByPos(heroid,i);
				local canUp = EquipmentDataMgr:equipCouldUp(equipmentId)
				if canUp then
					couldUp = canUp
					break
				end

				---可升星
				local canUpStar = EquipmentDataMgr:equipCouldUpStar(equipmentId)
				if canUpStar then
					couldUp = canUpStar
					break
				end

				---有更好的装备
				local haverBetter = EquipmentDataMgr:haveBetterEquip(equipmentId)
				if haverBetter then
					couldUp = haverBetter
					break
				end
			end
		end
	end
	return couldUp
end

---信物相关
function HeroDataMgr:heroCouldUpNewEquip(heroid)

	local isOpen = FunctionDataMgr:isOpen(80)
	if not isOpen then
		return false
	end

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end
	local ret = self:haveOtherNewEquip(heroid)
	if not ret then
		for i=1,6 do
			local newEquipMent = self:getNewEquipInfoByPos(heroid ,i);
			if newEquipMent then
				local canStrengthen = EquipmentDataMgr:newEquipCouldStrengthen(newEquipMent.cid)
				if canStrengthen then
					ret = canStrengthen
					break
				end
				local canUpStage = EquipmentDataMgr:newEquipCouldUpStage(newEquipMent.cid)
				if canUpStage then
					ret = canUpStage
					break
				end
			end
		end
	end
	return ret
end

---有可装备的信物
function HeroDataMgr:haveOtherNewEquip(heroid)

	local cost = self:getCost(heroid) + self:getNewEquipCost(heroid)
	local costmax = self:getCostMax(heroid)
	local list = EquipmentDataMgr:getNewEquipsBySortType(heroid,1);

	for i=1,6 do
		local ishave = self:getNewEquipInfoByPos(heroid ,i);
		if not ishave then
			if table.count(list) > 0 then
				for i1, v in ipairs(list) do
					if v.heroId == "0" then
						local equipCfg = EquipmentDataMgr:getNewEquipCfg(v.cid)
						local equipcost = equipCfg.cost
						if equipcost <= costmax - cost then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

---有可装备的宝石
function HeroDataMgr:haveStoneEquip(heroid)

	local isOpen = FunctionDataMgr:isOpen(107)
	if not isOpen then
		return false
	end

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

	for i=1,4 do
		local data = self:getGemInfoByPos(heroid, i)
		if not data then
			local gemsInfos = EquipmentDataMgr:getGemInfosByHeroIdAndPos(heroid, i)
			if #gemsInfos > 0 then
				return true
			end
		else
			local haverBetter = EquipmentDataMgr:haverBetterStone(data.id)
			if haverBetter then
				return true
			end
		end
	end


	return false
end

---结晶可突破
function HeroDataMgr:crystalRedTip(heroid)

	local isHave =self:getIsHave(heroid)
	if not isHave then
		return false
	end

	local job = self:getHeroJob(heroid)
	if job >= 4 then
		return false
	end

	local isHaveRedTip = false
	local sss_level = self:getQuality(heroid)
	for page=1, 7 do
		local evoDatas  = self:getEvolutionDataByPartition(heroid, page)
		for k,v in ipairs(evoDatas) do
			local evoData  = self:getEvolutionDataById(heroid, page, v.cell)
			if page <= sss_level then
				local isUnlock = self:getEvolutionIsUnlock(evoData)
				local isUped = self:getEvolutionIsFinish(evoData)
				if isUnlock and not isUped then
					local isHaveGoods = self:getEvoGoodsIsEnough(evoData)
					isHaveRedTip = isHaveRedTip or isHaveGoods
				end
			end

		end
	end
	return isHaveRedTip
end

function HeroDataMgr:checkEquipmentUnLockState(heroid)
	return self.heroTable[heroid].equipments and #self.heroTable[heroid].equipments > 0
end

function HeroDataMgr:checkEquipSuitUnLockState(heroid)
	return self.heroTable[heroid].euqipFetterInfo and #self.heroTable[heroid].euqipFetterInfo > 0
end

function HeroDataMgr:checkAngelSkillUnLockState(heroid, pageId)
	return self.heroTable[heroid].skillStrategyInfo and self.heroTable[heroid].skillStrategyInfo[pageId] and self.heroTable[heroid].skillStrategyInfo[pageId].angeSkillInfos and #self.heroTable[heroid].skillStrategyInfo[pageId].angeSkillInfos > 0
end

function HeroDataMgr:checkGemsUnLockState(heroid)
	return self.heroTable[heroid].gemInfos and #self.heroTable[heroid].gemInfos > 0
end



--结晶转化
function HeroDataMgr:HERO_REQ_DECOMPOSE_MATERIALS(msg)
	dump(msg)
	TFDirector:send(c2s.HERO_REQ_DECOMPOSE_MATERIALS,msg);
end

function HeroDataMgr:HERO_RES_DECOMPOSE_MATERIALS(event)
	dump(event.data)
	Utils:showReward(event.data.rewards);
	EventMgr:dispatchEvent(EV_HERO_RES_DECOMPOSE_MATERIALS);
end 

function HeroDataMgr:HERO_REQ_QUICK_ACTIVE_CRYSTAL(msg)
	dump(msg)
	TFDirector:send(c2s.HERO_REQ_QUICK_ACTIVE_CRYSTAL,msg);
end

function HeroDataMgr:HERO_RES_QUICK_ACTIVE_CRYSTAL(event)
	dump(event.data)
	event.data.heroId = self:getHeroCid(event.data.heroId)
	if event.data.crystalInfo then
		for i,v in ipairs(event.data.crystalInfo) do
			v.heroId = event.data.heroId;
			self:addCrystalInfo(v)
		end
		EventMgr:dispatchEvent(EV_HERO_ACTIVECRYSTAL_BATCH, event.data.crystalInfo)
		-- local index = 1;
		-- TFDirector:addTimer(1000, #(event.data.crystalInfo),nil,function()
		-- 	local data = event.data.crystalInfo[index];
		-- 	data.heroId = event.data.heroId;
		-- 	self:addCrystalInfo(data)
		-- 	EventMgr:dispatchEvent(EV_HERO_ACTIVECRYSTAL, data)
		-- 	index = index + 1
		-- end)
	end
end

return HeroDataMgr:new()
