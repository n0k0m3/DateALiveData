--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local RuleView = class("RuleView", BaseLayer)

function RuleView:ctor(...)
	self.super.ctor(self,...)
	self:init('ui.activity.groupPurchase.RuleView')
end


function RuleView:refreshView()
	self._ui.btn_label:setTextById()
	self._ui.des:setTextById()
end

function RuleView:registerEvents()
	self._ui.Button_Start:onClick(function()
		

	end)
end

return RuleView

--endregion
