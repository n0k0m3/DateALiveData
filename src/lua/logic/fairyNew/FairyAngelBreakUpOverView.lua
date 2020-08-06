local FairyAngelBreakUpOverView = class("FairyAngelBreakUpOverView", BaseLayer)


function FairyAngelBreakUpOverView:ctor(data)
    self.super.ctor(self,data)
    self.heroId = data.heroId
    self.lastLevel = data.lastLevel
    self:init("lua.uiconfig.fairyNew.fairyEnergyBreakUpView")
end

function FairyAngelBreakUpOverView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	local old_lv 		= TFDirector:getChildByPath(ui,"old_lv")
	local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv")
	local label_get_num = TFDirector:getChildByPath(ui,"label_get_num")
	self.Spine_break_up = TFDirector:getChildByPath(ui, "Spine_break_up")
	local Label_title = TFDirector:getChildByPath(ui,"Label_title")
	local Label_title1 = TFDirector:getChildByPath(ui,"Label_title1")
	local weaponType = HeroDataMgr:getHeroWeaponType(self.heroId)
	if weaponType == 1 then
		Label_title:setTextById(63651)
	else
		Label_title:setTextById(63652)
	end
	Label_title1:setTextById(1329132)

	local breakCfg = HeroDataMgr:getHeroAngelBreakCfg(self.heroId, nil)
	local lastCfg = HeroDataMgr:getHeroAngelBreakCfg(self.heroId,HeroDataMgr:getAngelBreakLevel(self.heroId) -1)
	old_lv:setString("Lv"..lastCfg.AngelLevel)
	cur_lv:setString("Lv"..breakCfg.AngelLevel)

	local rewardCount = 0
	local lastCount = 0
	local curCount = 0
	if table.count(breakCfg.BreakReward) > 0 then
		for k,v in pairs(lastCfg.BreakReward) do
			lastCount = v
			break
		end
	end
	for k,v in pairs(breakCfg.BreakReward) do
		curCount = v
		break
	end

	rewardCount = math.max(0, curCount - lastCount)
	rewardCount = math.floor(rewardCount / 100)
	label_get_num:setString("x"..rewardCount)

	self.Spine_break_up:play("chuxian",false)
    self.Spine_break_up:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_break_up:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_break_up:play("xunhuan",true)
        end, 0)
    end) 

	self:timeOut(function()
		self.ui:setTouchEnabled(true)
        self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)
    end, 1)
end

return FairyAngelBreakUpOverView;
