local SnowDayMemoryEntry = class("SnowDayMemoryEntry",BaseLayer)
function SnowDayMemoryEntry:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:showPopAnim(true)

	self:init("lua.uiconfig.activity.snowDayMemoryEntry")
	
end

function SnowDayMemoryEntry:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId) or {}
end

function SnowDayMemoryEntry:initUI(ui)
	self.super.initUI(self, ui)

	TFDirector:getChildByPath(ui,"Button_go"):onClick(function()
		Utils:openView("activity.SnowDay.SnowDayMemoryLevel", self.activityId)
	end)

	self.Label_finishedStory = TFDirector:getChildByPath(ui, "Label_finishedStory")

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

	self:cacheTexture()
	self:updateFinishedStory()
end

function SnowDayMemoryEntry:cacheTexture()
	for i=1,25 do
		local str = string.format("%03d", i)
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/level/"..str..".png")
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/level/"..str.."_1.png")
	end
	for i=1,12 do
		local str = string.format("%03d", i)
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/chrismasGiftBattle/"..str..".png")
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/chrismasGiftBattle/"..str.."_1.png")
	end
	for i=1,18 do
		local str = string.format("%03d", i)
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/chrimasBattle/"..str..".png")
		me.TextureCache:addImage("ui/activity/2020SnowDay/memory/chrimasBattle/"..str.."_1.png")
	end
end

function SnowDayMemoryEntry:updateFinishedStory()
	local finishCount = 0

	for k,v in pairs(self.activityData.items or {}) do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityData.activityType, tonumber(v))
		local progressInfo = ActivityDataMgr2:getProgressInfoWithoutDefault(self.activityData.activityType, tonumber(v))
		if progressInfo then
			if itemInfo.extendData.group == 1 and itemInfo.extendData.type == 1 and progressInfo.status == EC_TaskStatus.GETED then
				finishCount = finishCount + 1
			end
		end
	end
	self.Label_finishedStory:setTextById(13202311, finishCount)
end

function SnowDayMemoryEntry:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateFinishedStory, self))
end


return SnowDayMemoryEntry