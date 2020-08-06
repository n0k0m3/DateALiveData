local FairyStrategyView = class("FairyStrategyView", BaseLayer)


function FairyStrategyView:ctor(fairyId)
    self.super.ctor(self)
    self:initData(fairyId)
    self:init("lua.uiconfig.fairyNew.fairyStrategy")
end

function FairyStrategyView:initData(fairyId)

	self.fairyId = fairyId
	if not self.fairyId then
		print("no fairyId")
		return
	end

	self.roleDescribeCfg = TabDataMgr:getData("RoleDescribe")[self.fairyId]
	if not self.roleDescribeCfg then
		print("wrong fairyId",self.fairyId)
		Box("not found fairyId from RoleDescribe :"..tostring(self.fairyId))
		return
	end
	self.equipRecommendCfg = TabDataMgr:getData("EquipmentRecommend")[self.fairyId]

	self.skillCfg = TabDataMgr:getData("Skill")

	self.maxBaseSkill = 3
	self.maxGroupSkill = 6
end

function FairyStrategyView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self:showTopBar()

	--精灵相关
	self.Image_hero			= TFDirector:getChildByPath(ui, "Image_hero")
	self.Label_hero_name 	= TFDirector:getChildByPath(ui, "Label_hero_name")
	self.Label_enName1 	= TFDirector:getChildByPath(ui, "Label_enName1")
	self.Label_enName2 	= TFDirector:getChildByPath(ui, "Label_enName2")
	self.Image_sss_level = TFDirector:getChildByPath(ui, "Image_sss_level")
	self.Label_cv_actor = TFDirector:getChildByPath(ui, "Label_cv_actor")

	local ScrollView_fairyStrategy = TFDirector:getChildByPath(ui, "ScrollView_fairyStrategy")
	self.ListView = UIListView:create(ScrollView_fairyStrategy)

	--推荐质点
	self.Panel_equip_suit = TFDirector:getChildByPath(ui, "Panel_equip_suit"):clone()
	self.Panel_suit_model = TFDirector:getChildByPath(ui, "Panel_suit_model")

	--角色特点
	self.Panel_fairy_character = TFDirector:getChildByPath(ui, "Panel_fairy_character"):clone()
	self.Label_character_title_cn = TFDirector:getChildByPath(self.Panel_fairy_character, "Label_character_title_cn")
	self.Label_character_title_en = TFDirector:getChildByPath(self.Panel_fairy_character, "Label_character_title_en")
	self.Image_attr	= TFDirector:getChildByPath(self.Panel_fairy_character, "Image_attr")
	self.characterDesc = {}
	for i=1,3 do
		self.characterDesc[i]	= TFDirector:getChildByPath(self.Panel_fairy_character, "Labelcharacter_desc"..i)
	end

	--能量机制
	self.Panel_fairy_energy = TFDirector:getChildByPath(ui, "Panel_fairy_energy"):clone()
	self.Label_energy_title_cn = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_title_cn")
	self.Label_energy_title_en = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_title_en")
	self.Image_energyicon = TFDirector:getChildByPath(self.Panel_fairy_energy, "Image_energyicon")
	self.Label_energy_name = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_name")
	self.Label_energy_min = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_min")
	self.Label_energy_max = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_max")
	self.Label_energy_desc1 = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_desc1")
	self.Label_energy_desc2 = TFDirector:getChildByPath(self.Panel_fairy_energy, "Label_energy_desc2")
	
	--能量机制文本显示
	self.Panel_fairy_energy_text = TFDirector:getChildByPath(ui, "Panel_fairy_energy_text"):clone()
	self.Label_energy_text_title_cn = TFDirector:getChildByPath(self.Panel_fairy_energy_text, "Label_energy_title_cn")
	self.Label_energy_text_title_en = TFDirector:getChildByPath(self.Panel_fairy_energy_text, "Label_energy_title_en")
	self.Label_energy_desc = TFDirector:getChildByPath(self.Panel_fairy_energy_text, "Label_energy_desc")

	--技能
	self.Panel_fairy_skill = TFDirector:getChildByPath(ui, "Panel_fairy_skill"):clone()
	self.Label_skill_title_cn = TFDirector:getChildByPath(self.Panel_fairy_skill, "Label_skill_title_cn")
	self.Label_skill_title_en = TFDirector:getChildByPath(self.Panel_fairy_skill, "Label_skill_title_en")

	--基础技能
	self.baseSkill = {}
	for i=1,self.maxBaseSkill do
		local skillItem = {}
		skillItem.root = TFDirector:getChildByPath(self.Panel_fairy_skill, "Panel_mainskill_"..i)
		skillItem.skillbg = TFDirector:getChildByPath(skillItem.root, "Image_mainskill_bg")
		skillItem.skillIcon = TFDirector:getChildByPath(skillItem.root, "Image_skill_icon")
		skillItem.Label_skill_name = TFDirector:getChildByPath(skillItem.root, "Label_skill_name")
		skillItem.Label_skill_effect = TFDirector:getChildByPath(skillItem.root, "Label_skill_effect")
		self.baseSkill[i] = skillItem
	end

	--技能组
	self.groupSkill = {}
	for i=1,self.maxGroupSkill do
		local skillItem = {}
		skillItem.root = TFDirector:getChildByPath(self.Panel_fairy_skill, "Panel_groupskill_"..i)
		skillItem.skillbg = TFDirector:getChildByPath(skillItem.root, "Image_kill_bg")
		skillItem.skillIcon = TFDirector:getChildByPath(skillItem.root, "Image_skill_icon")
		self.groupSkill[i] = skillItem
	end

	self:initUILogic()
end

function FairyStrategyView:initUILogic()

	if not self.fairyId or not self.roleDescribeCfg then
		return
	end

	local spawnAc = {
        CCMoveBy:create(0.3,ccp(-80,0)),
        ScaleTo:create(0.3,0.6)
    }
    local ac = CCSpawn:create(spawnAc)
	self.Image_hero:stopAllActions()
    self.Image_hero:runAction(ac)

    self:initEquipSuit()
	self:fairyInfo()
	self:fairyCharacterInfo()
	self:fairyEnergyInfo()
	self:fairySkillInfo()
end

function FairyStrategyView:initEquipSuit()
	local count = 0
	for i=1,3 do
		local recommend = self.equipRecommendCfg["recommend"..i]
		if recommend and #recommend > 0 then
			count = count + 1
			local model = self.Panel_suit_model:clone()
			self.Panel_equip_suit:addChild(model)
			model:setPosition(ccp(0,-50 - count * 340))
			self:updateSuitModel(model, recommend)
			model:getChildByName("Label_suit_title"):setTextById(100000151 , i)
			model:getChildByName("Label_suit_desc"):setTextById(self.equipRecommendCfg["describe"..i])
		end
	end
	self.Panel_equip_suit:setContentSize(CCSizeMake(490, count *340+50))
	self.ListView:pushBackCustomItem(self.Panel_equip_suit)
end

function FairyStrategyView:updateSuitModel(model, equipCids)
	for i=1,3 do
		local item = TFDirector:getChildByPath(model, "Panel_equip_model"..i)
		if equipCids[i] then
			item:show()
			local equipCfg = EquipmentDataMgr:getEquipCfg(EquipmentDataMgr:getEquipCid(equipCids[i]))
			item:getChildByName("Image_cover"):setVisible(not EquipmentDataMgr:isHave(equipCids[i]))
			item:getChildByName("Image_equip_back"):setTexture(EC_EquipBoard[equipCfg.quality])
		    item:getChildByName("Image_frame"):setTexture(EC_EquipFrame[equipCfg.quality])
		    for t = 1, 5 do
		        item:getChildByName("Image_star_"..t):setVisible(t <= equipCfg.star)
		    end
		    item:getChildByName("Label_levelTitle"):setTextById(800006, "")
		    item:getChildByName("Label_level"):setText(EquipmentDataMgr:getEquipLv(equipCids[i]))
		    item:getChildByName("Image_type"):setTexture(EC_EquipSubTypeIconBag[equipCfg.subType])
		    item:getChildByName("Label_cost"):setText(equipCfg.cost)
		    item:getChildByName("Image_icon"):setTexture(equipCfg.halfPaint)
		    item:setTouchEnabled(true)
		    item:onClick(function()
				Utils:showInfo(equipCids[i])
			end)
		else
			item:hide()
		end
	end
end

function FairyStrategyView:fairyInfo()

	local anim_hero = Utils:createHeroModel(self.fairyId, self.Image_hero)
    --anim_hero:setScale(0.75)

    self.Label_hero_name:setString(HeroDataMgr:getName(self.fairyId))
    self.Label_enName1:setString(HeroDataMgr:getEnName2(self.fairyId))
    self.Label_enName2:setString(HeroDataMgr:getEnName(self.fairyId))

	local ishave = HeroDataMgr:getIsHave(self.fairyId)
	if not ishave then
		self.Image_sss_level:setTexture(HeroDataMgr:getQualityPicNotHave(self.fairyId))
	else
		self.Image_sss_level:setTexture(HeroDataMgr:getQualityPic(self.fairyId))
	end

    self.Label_cv_actor:setString(self.roleDescribeCfg.cv)
end

function FairyStrategyView:fairyCharacterInfo()

	self.Label_character_title_cn:setTextById(100000058)
	self.Label_character_title_en:setString("RoleCharacteristic")

	local featurePath = HeroDataMgr:getFeaturePath(self.fairyId)
	self.Image_attr:setTexture(featurePath)

	for i=1,3 do
		local desc = self.roleDescribeCfg["character"..i]
		self.characterDesc[i]:setString(desc)
	end

	self.ListView:pushBackCustomItem(self.Panel_fairy_character)
end

function FairyStrategyView:fairyEnergyInfo()

	if self.roleDescribeCfg.sign == 0 then
		self.Label_energy_title_cn:setTextById(100000059)
		self.Label_energy_title_en:setString("EnergyMechanism")
		self.Image_energyicon:setTexture(self.roleDescribeCfg.energyicon)
		self.Label_energy_name:setString(self.roleDescribeCfg.energyName)
		local color = self.roleDescribeCfg.colour
		print("color:",color)
		if #color == 7 then
			local rgb = me.c3b(tonumber("0x"..string.sub(color,2,3)),tonumber("0x"..string.sub(color,4,5)),tonumber("0x"..string.sub(color,6,7)))
			self.Label_energy_name:setColor(rgb)
			self.Label_energy_desc2:setColor(rgb)
		end
		self.Label_energy_min:setString(self.roleDescribeCfg.energyMin)
		self.Label_energy_max:setString(self.roleDescribeCfg.energyMax)

		self.Label_energy_desc1:setString(self.roleDescribeCfg.energyReply)
		self.Label_energy_desc2:setString(self.roleDescribeCfg.energyExplain)
		self.ListView:pushBackCustomItem(self.Panel_fairy_energy)
	else
		self.Label_energy_text_title_cn:setTextById(100000059)
		self.Label_energy_text_title_en:setString("EnergyMechanism")
		self.Label_energy_desc:setString(self.roleDescribeCfg.energyExplain)
		self.ListView:pushBackCustomItem(self.Panel_fairy_energy_text)
	end
end

function FairyStrategyView:fairySkillInfo()

	self.Label_skill_title_cn:setTextById(100000060)
	self.Label_skill_title_en:setString("Skill")

	--基础技能
	for i=1,self.maxBaseSkill do
		local skillId = self.roleDescribeCfg.skillId[i]
		local skillInfo = self.skillCfg[skillId]
		if not skillInfo then
			self.baseSkill[i].root:setVisible(false)
		else
			self.baseSkill[i].root:setVisible(true)
			self.baseSkill[i].skillIcon:setTexture(skillInfo.icon)
			self.baseSkill[i].Label_skill_name:setTextById(skillInfo.name)
			self.baseSkill[i].Label_skill_effect:setString(self.roleDescribeCfg["skillName"..i])
		end
	end

	--技能组
	for i=1,self.maxGroupSkill do

		local skillId = self.roleDescribeCfg.groupSkill[i]
		local skillInfo = self.skillCfg[skillId]
		if not skillInfo then
			self.groupSkill[i].root:setVisible(false)
		else
			self.groupSkill[i].root:setVisible(true)
			self.groupSkill[i].skillIcon:setTexture(skillInfo.icon)
		end
	end
	self.ListView:pushBackCustomItem(self.Panel_fairy_skill)
end

function FairyStrategyView:getGroupSkillDesc(clickSkillId)

	local skillDesc = ""
	for i=1,self.maxBaseSkill do
		local skillId = self.roleDescribeCfg.skillId[i]
		if skillId == clickSkillId then
			skillDesc = self.roleDescribeCfg["skillName"..i]
		end
	end

	return skillDesc
end

function FairyStrategyView:registerEvents()

	

	for i=1,self.maxBaseSkill do
		self.baseSkill[i].skillbg:onClick(function ()
			local skillId = self.roleDescribeCfg.skillId[i]
			local desc = self.roleDescribeCfg["skillName"..i]
			Utils:openView("fairyNew.FairySkillinfo",skillId,desc)
		end)
	end

	--技能组
	for i=1,self.maxGroupSkill do
		self.groupSkill[i].skillbg:onClick(function ()
			local skillId = self.roleDescribeCfg.groupSkill[i]
			local desc = self:getGroupSkillDesc(skillId)
			Utils:openView("fairyNew.FairySkillinfo",skillId,desc)
		end)
	end

end

return FairyStrategyView
