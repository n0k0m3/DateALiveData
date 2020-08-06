local FairyEnergyBreakUpView = class("FairyEnergyBreakUpView", BaseLayer)


function FairyEnergyBreakUpView:ctor(data)
    self.super.ctor(self,data)
    self:init("lua.uiconfig.fairyNew.fairyEnergyBreakUpView")
end

function FairyEnergyBreakUpView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	local old_lv 		= TFDirector:getChildByPath(ui,"old_lv")
	local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv")
	local label_get_num = TFDirector:getChildByPath(ui,"label_get_num")
	self.Image_res_bg = TFDirector:getChildByPath(ui,"Image_res_bg"):hide()
	self.Spine_break_up = TFDirector:getChildByPath(ui, "Spine_break_up")
	local Label_title = TFDirector:getChildByPath(ui,"Label_title")
	local Label_title1 = TFDirector:getChildByPath(ui,"Label_title1")
	Label_title:setTextById(1329135)
	Label_title1:setTextById(1329132)

	local breakCfg = HeroDataMgr:getHeroEnergyBreakCfg()
	local lastCfg = HeroDataMgr:getHeroEnergyBreakCfg(HeroDataMgr:getHeroEnergyBreakLevel() -1)
	old_lv:setString("Lv"..breakCfg.LimitLevel_Mini)
	cur_lv:setString("Lv"..breakCfg.LimitLevel_Max)

	local rewardCount = 0
	local lastCount = lastCfg.BreakReward
	local curCount = breakCfg.BreakReward
	rewardCount = math.max(0, curCount - lastCount)
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

return FairyEnergyBreakUpView;
