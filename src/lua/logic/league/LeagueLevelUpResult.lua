local LeagueLevelUpResult = class("LeagueLevelUpResult", BaseLayer)


function LeagueLevelUpResult:ctor(data)
    self.super.ctor(self,data)
    self.data = data;
    self:init("lua.uiconfig.league.leagueLevelUpResult")
end

function LeagueLevelUpResult:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	LeagueLevelUpResult.ui = ui

	local old_lv 		= TFDirector:getChildByPath(ui,"old_lv");
	local cur_lv 		= TFDirector:getChildByPath(ui,"cur_lv");
	

	old_lv:setText(self.data.old_lv);
	cur_lv:setText(self.data.cur_lv);
	
	self.Spine_fairyLevelUp = TFDirector:getChildByPath(ui , "Spine_fairyLevelUp")
	
	self.ui:setTouchEnabled(true);
	self.ui:onClick(function()
			AlertManager:closeLayer(self)
		end)

	self.Spine_fairyLevelUp:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
    	self.Spine_fairyLevelUp:removeMEListener(TFARMATURE_COMPLETE)
		self.Spine_fairyLevelUp:play("xunhuan" , true)
		
     end)
end

function LeagueLevelUpResult:onHide()
	self.super.onHide(self)
end

function LeagueLevelUpResult:removeUI()
	self.super.removeUI(self)
end

function LeagueLevelUpResult:onShow()
	self.super.onShow(self)
	
	
end


return LeagueLevelUpResult;
