local WeChatView = class("WeChatView", BaseLayer)


function WeChatView:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.MainScene.WxChatView")
end


function WeChatView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	self.Button_close 		= TFDirector:getChildByPath(ui, "Button_close")

	local pic = TFDirector:getChildByPath(ui,"Image_WxChatView_1");
	local platformId = 0;
	if HeitaoSdk then
		platformId = HeitaoSdk.getplatformId() % 10000;
	end

	if platformId == 0 or platformId == 305 then
		pic:setTexture("ui/mainLayer/new_ui/WeChatB.png")
	end
end

function WeChatView:registerEvents()

	self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return WeChatView
