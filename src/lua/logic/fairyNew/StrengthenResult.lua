local StrengthenResult = class("StrengthenResult", BaseLayer)


function StrengthenResult:ctor(data)
    self.super.ctor(self,data)
    self.oldHero = data[1];
    self._type 	 = data[2];
    self.heroid = self.oldHero.id;
    self.oldHero.advancedLvl = self.oldHero.advancedLvl or 0;
    self:init("lua.uiconfig.fairyNew.strengthenResult")
end


local strName = {
	TextDataMgr:getText(800066),
	TextDataMgr:getText(800067)
}
function StrengthenResult:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	StrengthenResult.ui = ui

	local Panel_strengthen	= TFDirector:getChildByPath(ui,"Panel_strengthen");
	local Panel_progress	= TFDirector:getChildByPath(ui,"Panel_progress");
	self.Spine_gradeUp	 	= TFDirector:getChildByPath(ui,"Spine_gradeUp");
	
	Panel_strengthen:setVisible(self._type == 1);
	Panel_progress:setVisible(self._type == 2);

	local old_lv 			= TFDirector:getChildByPath(ui,"old_lv");
	local cur_lv 			= TFDirector:getChildByPath(ui,"cur_lv");
	local old_basic_atk		= TFDirector:getChildByPath(ui,"old_basic_atk");
	local old_basic_def 	= TFDirector:getChildByPath(ui,"old_basic_def");
	local old_basic_hp 		= TFDirector:getChildByPath(ui,"old_basic_hp");
	local cur_basic_atk 	= TFDirector:getChildByPath(ui,"cur_basic_atk");
	local cur_basic_def 	= TFDirector:getChildByPath(ui,"cur_basic_def");
	local cur_basic_hp 		= TFDirector:getChildByPath(ui,"cur_basic_hp");

	local old_gr_atk		= TFDirector:getChildByPath(ui,"old_gr_atk");
	local old_gr_def 		= TFDirector:getChildByPath(ui,"old_gr_def");
	local old_gr_hp 		= TFDirector:getChildByPath(ui,"old_gr_hp");
	local old_gr_sk 		= TFDirector:getChildByPath(ui,"old_gr_sk");

	local cur_gr_atk 		= TFDirector:getChildByPath(ui,"cur_gr_atk");
	local cur_gr_def 		= TFDirector:getChildByPath(ui,"cur_gr_def");
	local cur_gr_hp 		= TFDirector:getChildByPath(ui,"cur_gr_hp");
	local cur_gr_sk 		= TFDirector:getChildByPath(ui,"cur_gr_sk");


	local oldLvMax 			= TFDirector:getChildByPath(ui,"old_lvMax");
	local curLvMax 			= TFDirector:getChildByPath(ui,"cur_lvMax");

	if self._type == 1 then
		local oldlv = self.oldHero.advancedLvl or 0;
		local curlv = HeroDataMgr:getStrengthenLv(self.heroid)
		old_lv:setText(oldlv);
		cur_lv:setText(curlv);

		--等级上限
		oldLvMax:setString(HeroDataMgr:getCurLevelMax(self.heroid,oldlv));
		curLvMax:setString(HeroDataMgr:getCurLevelMax(self.heroid));
	else
		local old = self.oldHero.quality;
		local cur = HeroDataMgr:getQuality(self.heroid);
		old_lv:hide();
		cur_lv:hide();
		local Image_hero_puality_old = TFDirector:getChildByPath(Panel_progress,"Image_hero_puality_old");
		Image_hero_puality_old:setTexture(HeroDataMgr:getQualityPic(self.heroid,old));
		local quality_di = TFDirector:getChildByPath(Image_hero_puality_old,"Image_quality_di");
		if old > 1 then
			quality_di:setTexture("ui/xj100.png");
		else
			quality_di:setTexture("ui/xj020.png");
		end

		local Image_hero_puality_cur = TFDirector:getChildByPath(Panel_progress,"Image_hero_puality_cur");
		Image_hero_puality_cur:setTexture(HeroDataMgr:getQualityPic(self.heroid));
		local quality_di = TFDirector:getChildByPath(Image_hero_puality_cur,"Image_quality_di");
		if cur > 1 then
			quality_di:setTexture("ui/xj100.png");
		else
			quality_di:setTexture("ui/xj020.png");
		end
	end

	local lv = HeroDataMgr:getLv(self.heroid);

	-- local strengthenId = self.oldHero.attribute * 100 + self.oldHero.advancedLvl;
	local progressId   = self.oldHero.attribute * 100  + self.oldHero.quality
	--local oldBasic = TabDataMgr:getData("HeroProgress",strengthenId).baseAttr;
	local oldGr    = TabDataMgr:getData("HeroProgress",progressId).upAttr;

	--old_basic_atk:setString(math.floor(oldBasic[EC_Attr.ATK] / 100));
	--old_basic_def:setString(math.floor(oldBasic[EC_Attr.DEF] / 100));
	--old_basic_hp:setString(math.floor(oldBasic[EC_Attr.HP] / 100));
	old_gr_atk:setString(math.floor(oldGr[EC_Attr.ATK] / 100));
	old_gr_def:setString(math.floor(oldGr[EC_Attr.DEF] / 100));
	old_gr_hp:setString(math.floor(oldGr[EC_Attr.HP]  / 100));
	old_gr_sk:setString(math.floor(self.oldHero.attr[EC_Attr.ATTR_SKILL_POINT] / 100));
	
	local advancedLvl = self.oldHero.advancedLvl + 1
	if  advancedLvl >= 10 then
		advancedLvl = 10;
	end
	-- strengthenId = self.oldHero.attribute * 100 + advancedLvl;

	local quality = self.oldHero.quality + 1;
	if quality >= 7 then
		quality = 7;
	end
	progressId   = self.oldHero.attribute * 100  + quality

	--local curBasic = TabDataMgr:getData("HeroProgress",strengthenId).baseAttr;
	local curGr    = TabDataMgr:getData("HeroProgress",progressId).upAttr;

	--cur_basic_atk:setString(math.floor(curBasic[EC_Attr.ATK] / 100));
	--cur_basic_def:setString(math.floor(curBasic[EC_Attr.DEF] / 100));
	--cur_basic_hp:setString(math.floor(curBasic[EC_Attr.HP] / 100));

	cur_gr_atk:setString(math.floor(curGr[EC_Attr.ATK]  / 100));
	cur_gr_def:setString(math.floor(curGr[EC_Attr.DEF]  / 100));
	cur_gr_hp:setString(math.floor(curGr[EC_Attr.HP]  / 100));
	cur_gr_sk:setString(HeroDataMgr:getSkillPointMax(self.heroid));

	self.Spine_gradeUp:play("chuxian",false)
    self.Spine_gradeUp:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_gradeUp:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_gradeUp:play("xunhuan",true)
        end, 0)
    end) 

	self.ui:setTouchEnabled(true);
	self.ui:onClick(function()
			AlertManager:close();
		end)

	VoiceDataMgr:playVoiceByHeroID("ability_up",self.heroid)
end

function StrengthenResult:onHide()
	self.super.onHide(self)
end

function StrengthenResult:removeUI()
	self.super.removeUI(self)
end

function StrengthenResult:onShow()
	self.super.onShow(self)
	-- self.ui:runAnimation("Action0",1);
	-- local delay = CCDelayTime:create(0.3);
	-- local callfunc = CCCallFunc:create(function()
	-- 		self.ui:runAnimation("Action1",-1);
	-- 	end
	-- 	)
	
	-- self:runAction(CCSequence:create({delay,callfunc}));

	-- VoiceDataMgr:playVoiceByHeroID("ability_up",self.heroid)
end

return StrengthenResult;