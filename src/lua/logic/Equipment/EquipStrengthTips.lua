local EquipStrengthTips = class("EquipStrengthTips", BaseLayer)


function EquipStrengthTips:ctor(data)
    self.super.ctor(self,data)
    self.okCallFunc = data.okCallFunc;
    self:init("lua.uiconfig.Equip.EquipStrengthTips")
end

function EquipStrengthTips:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	EquipStrengthTips.ui = ui

    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Label_title:setTextById(490014)
    self.Label_tip = TFDirector:getChildByPath(ui, "tips2")
    self.Label_tip:setTextById(490010)
    self.Label_change = TFDirector:getChildByPath(ui, "Label_change")
    self.Label_change:setTextById(490011)

    self.Button_ok = TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel");

    self.Image_select_di = TFDirector:getChildByPath(ui,"Image_select_di");
    self.Image_select    = TFDirector:getChildByPath(ui,"Image_select"):hide();

    self.Image_select_di:onClick(function()
            if self.Image_select:isVisible() then
                self.Image_select:hide();
                EquipmentDataMgr:setStrengthTipsEnable(0);
            else
                self.Image_select:show();
                EquipmentDataMgr:setStrengthTipsEnable(os.time());
            end
        end)
end


function EquipStrengthTips:registerEvents()
	self.Button_ok:onClick(function ()
            if self.okCallFunc then
                self.okCallFunc(true);
                AlertManager:close();
            end
    end)

    self.Button_cancel:onClick(function()
    		if self.okCallFunc then
                self.okCallFunc(false);
                AlertManager:close();
            end
    	end)
end

function EquipStrengthTips:onHide()
	self.super.onHide(self)
end

function EquipStrengthTips:removeUI()
	self.super.removeUI(self)
end

return EquipStrengthTips;