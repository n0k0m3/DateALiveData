--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local DressVotePreView = class("DressVotePreView", BaseLayer)
function DressVotePreView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.dressVotePreView")
end

function DressVotePreView:initData(data)
	self.path = data.extendData.des2 or ""
end

function DressVotePreView:initUI(ui)
	self.super.initUI(self, ui)

	self.ScrollView		= TFDirector:getChildByPath(ui,"ScrollView")
	self.ScrollView:setSize(me.Director:getWinSize())
	self.Image = TFDirector:getChildByPath(self.ui,"Image_bg")
	self.Image:setTexture(self.path)
	self.Image:setTouchEnabled(true)
	self.Image:setSwallowTouch(true)
	self.Image:addMEListener(TFWIDGET_CLICK, function()
		self:stopAllActions()
		self:runAction(Sequence:create({
			ScaleTo:create(0.3,0),
			CallFunc:create(function()
				AlertManager:closeLayer(self)
			end)
		}))	
	end)

	self:setScale(0.1)
	self:runAction(ScaleTo:create(0.3,1))
end

function DressVotePreView:registerEvents()
	self.super.registerEvents(self)	
end

return DressVotePreView
--endregion
