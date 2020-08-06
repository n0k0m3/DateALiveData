local FairyEnergyLevelUpView = class("FairyEnergyLevelUpView", BaseLayer)


function FairyEnergyLevelUpView:ctor(lastLevel)
    self.super.ctor(self, lastLevel)
    self.lastLevel = lastLevel
    self:init("lua.uiconfig.fairyNew.fairyEnergyLevelUpView")
end

function FairyEnergyLevelUpView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	local old_lv 		= TFDirector:getChildByPath(ui,"old_lv")
	local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv")
	local Label_title = TFDirector:getChildByPath(ui,"Label_title")
	local label_get_num = TFDirector:getChildByPath(ui,"label_get_num")
	self.Spine_level_up = TFDirector:getChildByPath(ui, "Spine_level_up")
	Label_title:setTextById(1329130)
	local curLevel = HeroDataMgr:getHeroEnergyLevel()
	old_lv:setString(self.lastLevel)
	cur_lv:setString(curLevel)

	local lastCfg = HeroDataMgr:getHeroEnergyLevelCfg(nil, self.lastLevel)
	local curCfg = HeroDataMgr:getHeroEnergyLevelCfg(nil, curLevel)
	local rewardCount = 0
	local lastCount = lastCfg.LevelUpReward
	local curCount = curCfg.LevelUpReward
	rewardCount = math.max(0, curCount - lastCount)
	label_get_num:setString("x"..rewardCount)

	self.Spine_level_up:play("chuxian",false)
    self.Spine_level_up:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_level_up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_level_up:play("xunhuan",true)
        end, 0)
    end) 

    self:timeOut(function()
		self.ui:setTouchEnabled(true)
        self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)
    end, 1)
end

return FairyEnergyLevelUpView;
