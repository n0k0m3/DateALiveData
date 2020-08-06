local ActivationLayer = class("ActivationLayer", BaseLayer)

function ActivationLayer:ctor(data)
	self.super.ctor(self,data)
    self:init("lua.uiconfig.loginScene.ActivationLayer")
end

function ActivationLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	ActivationLayer.ui = ui

    local Button_cancel = TFDirector:getChildByPath(ui,"Button_cancel");
    Button_cancel:onClick(function()
            AlertManager:close();
        end
        )

	self.input = TFDirector:getChildByPath(ui,"input");
	local params = {
		_type = EC_InputLayerType.OK
	}
	self.InputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.InputLayer,1000);

    local function onTextFieldChangedHandleAcc(input)
       	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.InputLayer:listener(new_text);
    end

    local function onTextFieldAttachAcc(input)
    	local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.InputLayer:show();
        self.InputLayer:listener(new_text);
    end

    self.input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_ok = TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_ok:onClick(function()
    		self:onTouchOK();
    	end)
end

function ActivationLayer:onTouchOK()
	local code = self.input:getText()
	if string.len(code) <= 0 then
		-- toastMessage("激活码不能为空")
        Utils:showTips(800083)
		return
	end

	LogonHelper:activat(code);
end

function ActivationLayer:removeUI()
	self.super.removeUI(self)
end

return ActivationLayer;
