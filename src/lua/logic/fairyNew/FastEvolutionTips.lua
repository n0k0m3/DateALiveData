local FastEvolutionTips = class("FastEvolutionTips", BaseLayer)


function FastEvolutionTips:ctor(data)
	self.super.ctor(self,data)
	self.heroId = data
	self.isUseWanNeng = false;
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.fairyNew.fastEvolutionTips")
end

function FastEvolutionTips:initUI(ui)
	self.super.initUI(self,ui)
	FastEvolutionTips.ui = ui
end

function FastEvolutionTips:registerEvents()
	self._ui.Button_ok:onTouch(function(event)
		local msg = {
			tostring(self.heroId),
			self.isUseWanNeng
		}
        HeroDataMgr:HERO_REQ_QUICK_ACTIVE_CRYSTAL(msg)
        AlertManager:closeLayer(self)
    end)

    self._ui.Button_cancel:onTouch(function(event)
        AlertManager:closeLayer(self)
    end)

    self._ui.Panel_tips:setTouchEnabled(true);
    self._ui.Panel_tips:onClick(function()
    		local Image_select = self._ui.Panel_tips:getChildByName("Image_select");
    		Image_select:setVisible(not Image_select:isVisible());
    		self.isUseWanNeng = Image_select:isVisible();
    	end)
end

function FastEvolutionTips:onHide()
	self.super.onHide(self)
end

function FastEvolutionTips:removeUI()
	self.super.removeUI(self)
end

function FastEvolutionTips:onShow()
    self.super.onShow(self)
end

return FastEvolutionTips;