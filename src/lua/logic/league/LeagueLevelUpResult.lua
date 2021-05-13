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
	

	-- self.buttonOk = TFDirector:getChildByPath(ui,"Button_ok");
	-- self.buttonOk:onClick(function()
 --    		AlertManager:close();
 --    	end)
	
	self.ui:setTouchEnabled(true);
	self.ui:onClick(function()
			AlertManager:closeLayer(self)
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
	
	-- self.ui:runAnimation("Action0",1);

	-- local delay = CCDelayTime:create(0.3);
	-- local callfunc = CCCallFunc:create(function()
	-- 		self.ui:runAnimation("Action1",-1);
	-- 	end
	-- 	)
	
	-- self:runAction(CCSequence:create({delay,callfunc}));
end


return LeagueLevelUpResult;
