
local InputLayer = class("InputLayer", BaseLayer)

--CREATE_PANEL_FUN(InputLayer)


function InputLayer:ctor(data)
    self.super.ctor(self,data)
    self.isShow = false;
    self._type = data._type;
    self.screenType = data.screenType
    self.buttonCallback = data.buttonCallback;
    self.closeCallback  = data.closeCallback;
    local uiStr = "lua.uiconfig.common.inputLayer"
    if self.screenType == SCREEN_ORIENTATION_PORTRAIT then
        uiStr = "lua.uiconfig.common.inputLayerS"
    end
    self:init(uiStr)
end

function InputLayer:initUI(ui)
	self.super.initUI(self,ui)

    self.Panel_top      = TFDirector:getChildByPath(ui,"Panel_top");
    self.Panel_top:setPositionY(GameConfig.WS.height);
    self.Label_input    = TFDirector:getChildByPath(ui,"Label_input");
    self.Label_button   = TFDirector:getChildByPath(ui,"Label_button");
    self.Button_input   = TFDirector:getChildByPath(ui,"Button_input");
    self.Panel_back     = TFDirector:getChildByPath(ui,"Panel_back"):hide();
    self.Image_gb       = TFDirector:getChildByPath(ui,"Image_gb");
    Public:BlinkAction(self.Image_gb);

    if self._type == EC_InputLayerType.OK then
        self.Label_button:setTextById(800010);
    elseif self._type == EC_InputLayerType.SEND then
        self.Label_button:setTextById(800065);
    end


end

function InputLayer:onShow()
    self.super.onShow(self)
end

function InputLayer:registerEvents()
    self.Button_input:onClick(function()
            self.isShow = false;
            if self._type == EC_InputLayerType.ok then
                self:hideAction();
            elseif self._type == EC_InputLayerType.SEND then
                if self.buttonCallback then
                    self.buttonCallback();
                end
                self:hideAction();
            else
                self:hideAction();
            end
        end
        )

    self.ui:onClick(function()
            self:hideAction();
        end)
end

function InputLayer:hideAction()
    self.Panel_top:setPositionY(GameConfig.WS.height);
    self.ui:setTouchEnabled(false);
    self.Panel_back:hide();
    self.isShow = false
    if self.closeCallback then
        self.closeCallback();
    end
end

function InputLayer:removeUI()
    self.super.removeUI(self)
end

function InputLayer:onHide()
    self.super.onHide(self)
end

function InputLayer:show()

    if self.isShow then
        self:hideAction();
        self.isShow = false;
    end

    if not self.isShow then
        self.isShow = true
        self.Panel_top:setPositionY(GameConfig.WS.height);
        self.Panel_top:runAction(CCMoveBy:create(0.1,ccp(0,-72)));
        self.ui:setTouchEnabled(true);
        self.Panel_back:show();
    end

end

function InputLayer:listener(string)
    self:timeOut(function()
        self.Label_input:setText(string);
        local size = self.Label_input:getSize();
        local posx = self.Label_input:getPositionX();
        self.Image_gb:setPositionX(posx + size.width + 5);
    end,0.1)
end

function InputLayer:removeUI()
	self.super.removeUI(self);
end

function InputLayer:specialKeyBackLogic( )
    return true
end

return InputLayer;
