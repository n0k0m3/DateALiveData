local SnowCastleUpgradeSuccess = class("SnowCastleUpgradeSuccess", BaseLayer)

function SnowCastleUpgradeSuccess:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	--self:showPopAnim(true)
	self:init("lua.uiconfig.activity.snowCastleUpgradeSuccess")

	Utils:playSound(8122,false)
end

function SnowCastleUpgradeSuccess:initData(optionId)
	self.cfg = TabDataMgr:getData("EventMemshipOption", optionId)
end

function SnowCastleUpgradeSuccess:initUI(ui)
	self.super.initUI(self, ui)
	local Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
	Panel_root:setTouchEnabled(true)
	Panel_root:setSwallowTouch(true)
	Panel_root:addMEListener(TFWIDGET_CLICK,function()
		self:runAction(Sequence:create({CallFunc:create(function() self:setScale(1) end), ScaleTo:create(0.1,1.3), ScaleTo:create(0.05, 1),
		CallFunc:create(function() 
			if self.cb then
				self.cb()
				self.cb = nil
			end
			self:removeFromParent(true) 
		end)}))		
	end)
	
	local text = TextDataMgr:getRText("r"..self.cfg.optionUpDes)
	local rich1 = TFRichText:create(ccs(30000, 3000))
	rich1:setScale(33/30)
	rich1:Text(text)	
	TFDirector:getChildByPath(ui,"Label_Descript"):show():addChild(rich1)

	local snowBookData = ActivityDataMgr2:getSnowBookData() or {} 
	local snowBuffInfo = ActivityDataMgr2:getSnowBuffInfo()

	local text = TextDataMgr:getRText("r153000", snowBookData.pamphletLevel, snowBookData.pamphletLevel + 1)
	local rich2 = TFRichText:create(ccs(30000, 3000))
	rich2:setScale(33/30)
	rich2:Text(text)
	TFDirector:getChildByPath(ui,"Label_DescriptBookLv"):show():addChild(rich2)

	self.Spine_Node = TFDirector:getChildByPath(ui,"Spine_Node")

	TFDirector:getChildByPath(ui,"Label_Descript"):getParent():setOpacity(0)
	TFDirector:getChildByPath(ui,"Label_Descript"):getParent():runAction(Sequence:create({DelayTime:create(0.45),FadeIn:create(0.1)}))
end

function SnowCastleUpgradeSuccess:closeCallback(cb)
	self.cb = cb
end


	

return SnowCastleUpgradeSuccess