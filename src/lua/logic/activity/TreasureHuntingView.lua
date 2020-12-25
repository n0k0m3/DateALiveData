--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local TreasureHuntingView = class("TreasureHuntingView", BaseLayer)
function TreasureHuntingView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.treasureHuntingView")
end

function TreasureHuntingView:initData(activityId)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	dump(self.activityInfo)
end

function TreasureHuntingView:initUI(ui)
	self.super.initUI(self,ui)

	self.Panel_root		= TFDirector:getChildByPath(ui,"Panel_root")

	self.act_time		= TFDirector:getChildByPath(self.Panel_root,"act_time")
	self.act_time:setSkewX(10)
	self.act_time.Start = TFDirector:getChildByPath(self.Panel_root,"act_timeStart")
	self.act_time.Start:setSkewX(5)
	self.act_time.End	= TFDirector:getChildByPath(self.Panel_root,"act_timeEnd")
	self.act_time.End:setSkewX(5)

	local year, month, day = Utils:getDate(self.activityInfo.showStartTime or 0)
	self.act_time.Start:setTextById(1410001,year, month, day)

	year, month, day = Utils:getDate(self.activityInfo.endTime or 0)
	self.act_time.End:setTextById(1410001,year, month, day)

	self.desc = TFDirector:getChildByPath(self.Panel_root,"desc")
	self.desc:setText(self.activityInfo.activityTitle)

	self.Button_go = TFDirector:getChildByPath(self.Panel_root,"Button_go")
	self.Button_go:onClick(function()
		FunctionDataMgr:jFlyShip()
	end)

	self.Button_shop = TFDirector:getChildByPath(self.Panel_root,"Button_shop")
	self.Button_shop:onClick(function()
		FunctionDataMgr:jStore(327000)
	end)
end

function TreasureHuntingView:registerEvents()

end

return TreasureHuntingView

--endregion
