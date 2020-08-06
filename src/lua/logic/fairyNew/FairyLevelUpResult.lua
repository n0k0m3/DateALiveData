local FairyLevelUpResult = class("FairyLevelUpResult", BaseLayer)


function FairyLevelUpResult:ctor(data)
    self.super.ctor(self,data)
    self.oldHero = data;
    self:init("lua.uiconfig.fairyNew.fairyLevelUpResult")
end

function FairyLevelUpResult:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	FairyLevelUpResult.ui = ui
	self:addLockLayer()

	local old_lv 		= TFDirector:getChildByPath(ui,"old_lv");
	local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv");
	local old_atk		= TFDirector:getChildByPath(ui,"old_atk");
	local old_def 		= TFDirector:getChildByPath(ui,"old_def");
	local old_hp 		= TFDirector:getChildByPath(ui,"old_hp");
	local old_fuzhong 	= TFDirector:getChildByPath(ui,"old_fuzhong");
	local cur_atk 		= TFDirector:getChildByPath(ui,"cur_atk");
	local cur_def 		= TFDirector:getChildByPath(ui,"cur_def");
	local cur_hp 		= TFDirector:getChildByPath(ui,"cur_hp");
	local cur_fuzhong 	= TFDirector:getChildByPath(ui,"cur_fuzhong");
	local cur_skill		= TFDirector:getChildByPath(ui,"cur_skill");
	local old_skill		= TFDirector:getChildByPath(ui,"old_skill");
	self.Spine_fairyLevelUp = TFDirector:getChildByPath(ui, "Spine_fairyLevelUp")

	self.heroid = self.oldHero.id;
	old_lv:setText(self.oldHero.lvl);
	old_atk:setString(math.floor(self.oldHero.attr[EC_Attr.ATK] / 100));
	old_def:setString(math.floor(self.oldHero.attr[EC_Attr.DEF] / 100));
	old_hp:setString(math.floor(self.oldHero.attr[EC_Attr.HP] / 100));
	old_fuzhong:setString(self.oldHero.attr[EC_Attr.COST]);
	old_skill:setString(math.floor(self.oldHero.attr[EC_Attr.ATTR_SKILL_POINT] / 100));

	cur_lv:setText(math.floor(HeroDataMgr:getLv(self.heroid)));
	cur_atk:setString(math.floor(HeroDataMgr:getAtk(self.heroid)));
	cur_def:setString(math.floor(HeroDataMgr:getDef(self.heroid)));
	cur_hp:setString(math.floor(HeroDataMgr:getHp(self.heroid)));
	cur_fuzhong:setString(HeroDataMgr:getCostMax(self.heroid));
	cur_skill:setString(HeroDataMgr:getSkillPointMax(self.heroid));

	-- self.buttonOk = TFDirector:getChildByPath(ui,"Button_ok");
	-- self.buttonOk:onClick(function()
 --    		AlertManager:close();
 --    	end)

 	self.Spine_fairyLevelUp:play("chuxian",false)
    self.Spine_fairyLevelUp:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_fairyLevelUp:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_fairyLevelUp:play("xunhuan",true)
        end, 0)
    end) 
	
	self:timeOut(function()
		self.ui:setTouchEnabled(true);
        self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)
    end, 1)
end

function FairyLevelUpResult:onHide()
	self.super.onHide(self)
end

function FairyLevelUpResult:removeUI()
	self.super.removeUI(self)
end

function FairyLevelUpResult:onShow()
	self.super.onShow(self)
	self:removeLockLayer()
	self:timeOut(function()
        if GameGuide:checkGuide(self) then
        	if self.blockUI then
		        self.blockUI:setBackGroundColorOpacity(100)
		    end
        end
    end,0)
	-- self.ui:runAnimation("Action0",1);

	-- local delay = CCDelayTime:create(0.3);
	-- local callfunc = CCCallFunc:create(function()
	-- 		self.ui:runAnimation("Action1",-1);
	-- 	end
	-- 	)
	
	-- self:runAction(CCSequence:create({delay,callfunc}));
end


return FairyLevelUpResult;
