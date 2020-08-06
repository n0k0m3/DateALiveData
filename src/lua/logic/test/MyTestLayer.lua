local MyTestLayer = class("MyTestLayer", BaseLayer)


function MyTestLayer:ctor(data)
    self.super.ctor(self,data)
    self.topBarType_ = {EC_TopbarType.DIAMOND, EC_TopbarType.GOLD, EC_TopbarType.POWER}
    
    self:init("lua.uiconfig.Scene1.Module1")
end

function MyTestLayer:initData(data)

end

function MyTestLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	MyTestLayer.ui = ui
end

function MyTestLayer:resetUI()
end

function MyTestLayer:registerEvents()
    self:setBackBtnCallback(function()
        AlertManager:close()
    end)

	-- self.Button_close:onClick(function ()
	-- 		print("close");
 --            AlertManager:close();
 --    	end)

--    self.Button_cancel:onClick(function()
--    		AlertManager:close();
--    	end)

--	self.Button_down:onTouch(function(event)
--		if event.name == "began" then
--			self:holdDownAction(false)
--			self:onTouchButtonDown()
--		elseif event.name == "ended" then
--			self:stopTimer()
--		end
--	end)
end

function MyTestLayer:onTouchButtonDown()
	print("onTouchButtonDown")
end

function MyTestLayer:onTouchButtonUp()
	print("onTouchButtonUp")
end

function MyTestLayer:onHide()
	self.super.onHide(self)
end

function MyTestLayer:removeUI()
	self.super.removeUI(self)
end

function MyTestLayer:onShow()
	self.super.onShow(self)
end

function MyTestLayer:onClose()
	self.super.onClose(self)
end

return MyTestLayer;
