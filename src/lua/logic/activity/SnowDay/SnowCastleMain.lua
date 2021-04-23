--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local SnowCastleMain = class("SnowCastleMain", BaseLayer)

function SnowCastleMain:ctor(...)
	self.super.ctor(self)

	self:initData(...)

	self:init("lua.uiconfig.activity.snowCastleMain")
end

function SnowCastleMain:initUI(ui)
	self.super.initUI(self, ui)
	self.Image_snowMan = TFDirector:getChildByPath(ui, "Image_snowMan"):hide()

	self.Button_castle = TFDirector:getChildByPath(ui, "Button_castle")
	self.Button_castle:onClick(function() Utils:openView("activity.SnowDay.SnowCastleUpgrade", self.activityId) end)
	self.Button_castle.Spine_lv = TFDirector:getChildByPath(self.Button_castle, "Spine_lv"):hide()
	self.Button_castle.Label_castle = TFDirector:getChildByPath(self.Button_castle, "Label_castle")

	self.Button_book = TFDirector:getChildByPath(ui, "Button_book")
	self.Button_book:onClick(function() Utils:openView("activity.SnowDay.SnowBook", self.activityId) end)

	self.TaskProgress = TFDirector:getChildByPath(ui, "TaskProgress")
	self.TaskProgress:setPercent(0)
	self.ProgressBg = TFDirector:getChildByPath(ui, "ProgressBg")
	self.ProgressBg.Spine_lv = TFDirector:getChildByPath(self.ProgressBg, "Spine_lv"):hide()

	self.Label_progress = TFDirector:getChildByPath(ui, "Label_progress")
	self.Label_progress:setText("0/0")

	self.DayLimit = TFDirector:getChildByPath(ui, "DayLimit")
	self.LvProgress = TFDirector:getChildByPath(ui, "LvProgress")
	

	self.Level = TFDirector:getChildByPath(ui, "Level")

	self.act_time = TFDirector:getChildByPath(ui, "act_time")
	self.act_time:setSkewX(10)
	self.act_timeStart = TFDirector:getChildByPath(ui, "act_timeStart")
	self.act_timeStart:setSkewX(10)
	self.act_timeEnd = TFDirector:getChildByPath(ui, "act_timeEnd")
	self.act_timeEnd:setSkewX(10)

	local year, month, day = Utils:getDate(self.activityData.showStartTime)
	local format = TextDataMgr:getText(300324)
	local text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day).."-"
	self.act_timeStart:setText(text)

	year, month, day = Utils:getDate(self.activityData.showEndTime)
	text = string.format(format, year).. string.format(format, string.format("%.2d", month)).. string.format("%.2d", day)
	self.act_timeEnd:setText(text)

	
end

function SnowCastleMain:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)
	--dump(self.activityData)
end

function SnowCastleMain:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ICE_SNOW_UPGRADE, handler(self.upgradeSucess, self))	
	EventMgr:addEventListener(self, EV_ICE_SNOW_BOOK_DATA, handler(self.calculateBookLv, self))


	ActivityDataMgr2:sendEnterSnowDay()
end

function SnowCastleMain:upgradeSucess()	
	self:calculateBookLv()
end

function SnowCastleMain:calculateBookLv()
	self.snowBookData = ActivityDataMgr2:getSnowBookData() or {}
	dump(self.snowBookData)
	self.snowBookData.dayExp = self.snowBookData.dayExp or 0

	local pamphletLevel = self.snowBookData.pamphletLevel or 0
	local exp = self.snowBookData.exp or 0

	local cfgLastOption = TabDataMgr:getData("EventMembership", pamphletLevel- 1) or {}
	cfgLastOption.costToNext = cfgLastOption.costToNext or 0
	local cfgOption = TabDataMgr:getData("EventMembership", pamphletLevel) or {}
	cfgOption.costToNext = cfgOption.costToNext or 0
	local percent = math.max(exp-cfgLastOption.costToNext, 0) / (cfgOption.costToNext-cfgLastOption.costToNext) * 100
	self.TaskProgress:setPercent( percent)

	self.Button_castle:setTouchEnabled(percent>=100)
	self.Button_castle:setGrayEnabled(percent < 100)

	self.Level:setTextById(13202309, pamphletLevel, self.activityData.extendData.maxLevel)


	--self.Label_progress:show():setTextById(800005, exp, cfgOption.costToNext)

	if exp-(cfgLastOption.costToNext or 0) >= cfgOption.costToNext-(cfgLastOption.costToNext or 0) then
		self.Button_castle.Spine_lv:show()
		self.ProgressBg.Spine_lv:show()
	else
		self.Button_castle.Spine_lv:hide()
		self.ProgressBg.Spine_lv:hide()
	end

	local denominator = cfgOption.costToNext-(cfgLastOption.costToNext or 0)
	local numerator = math.max(exp-(cfgLastOption.costToNext or 0), 0)
	self.LvProgress:setTextById(270609, math.min(numerator,denominator), denominator)
	self.DayLimit:setTextById(13202423, self.snowBookData.dayExp or 0, self.activityData.extendData.expDailyLimit or 0)

--	if self.snowBookData.dayExp >= self.activityData.extendData.expDailyLimit then
--		self.DayLimit:setTextById(13202307, self.snowBookData.dayExp or 0, self.activityData.extendData.expDailyLimit or 0)
--	else	
--		self.DayLimit:setTextById(13202423, self.snowBookData.dayExp or 0, self.activityData.extendData.expDailyLimit or 0)
--	end	

	if pamphletLevel >=	self.activityData.extendData.maxLevel then
		self.Button_castle.Label_castle:setTextById(13202310)
		self.Button_castle:setTouchEnabled(false)
		self.Button_castle:setGrayEnabled(true)
		self.Button_castle.Spine_lv:hide()
		self.ProgressBg.Spine_lv:hide()
		self.DayLimit:setTextById(13202424)
		self.LvProgress:hide()
	end

	self.Image_snowMan:show()
	if cfgOption.coverBg then
		self.Image_snowMan:setTexture(cfgOption.coverBg)
	end
end


return SnowCastleMain

--endregion
