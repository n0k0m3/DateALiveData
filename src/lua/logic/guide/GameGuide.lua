
local GameGuide = class("GameGuide")

function GameGuide:ctor(...)
	self:init(...)
end

function GameGuide:init(...)

end

function GameGuide:checkGuide(ui)
	if self.ui and self.ui._GuideMain then
		return false
	end
	self:removeGuideMain()
	if not GuideDataMgr:readyToStart() or GuideDataMgr:isBattle() then
		return false
	end

	if GuideDataMgr:checkHasGuideInfo(ui) then
		local guideInfo = GuideDataMgr:getCurGuideInfo()
		local function callBack()
			self.ui = ui
			self:excuteGuide(guideInfo)
		end

		if guideInfo.delay and guideInfo.delay > 0 then
			self:delayToGuide(guideInfo.delay, callBack)
		else
			callBack()
		end
		return true
	else
		self:clearGuide()
		return false
	end
end

function GameGuide:clearGuide()
	if self.ui then
		if self.ui._GuideMain then
			self.ui._GuideMain:onClose()
			self.ui:removeLayer(self.ui._GuideMain)
		end

		self.ui._GuideMain = nil
		self.ui = nil
	end
end

function GameGuide:doNextGuide()
	self:removeGuideMain()
	GuideDataMgr:saveStep()
	self:checkGuide(self.ui)
end

function GameGuide:isInGuide()
	if self.ui and self.ui._GuideMain then
		return true
	else
		return false
	end
end

function GameGuide:showGuideLayer(ui, guideInfo, _widget, adjustPos)
	local widget = _widget
	if guideInfo.showContinue and not widget then
		if guideInfo.uiName == "1" then
			widget = TFDirector:getChildByPath(ui.topLayer, "Button_main")
		else
			widget = TFDirector:getChildByPath(ui.topLayer, "Button_back")
		end
	end

	local _GuideMain = require("lua.logic.guide.GuideMain"):new({cfg = guideInfo, ui = ui, widget = widget, pos = adjustPos})
	if GuideDataMgr:checkEnableControl(guideInfo) then
		ui._GuideMain = _GuideMain
		if ui.__cname ~= "MainLayer" and  ui.__cname ~= "NewCityInfoView" then
			_GuideMain:setAnchorPoint(ccp(0.5, 0.5))
		end
		if ui.__cname == "NewCityInfoView" then
			local visibleSize = me.Director:getVisibleSize()
    		local widthTemp = (1136 - visibleSize.width) / 2
    		_GuideMain:setPositionX(widthTemp)
		end
	    ui:addLayer(_GuideMain, 1111)
	else
		self:clearGuide()
	end
end

function GameGuide:skipNewGuide()
	GuideDataMgr:skipNewGuide()
	self:clearGuide()
end

function GameGuide:skipTeamGuideGroup()
	GuideDataMgr:skipTeamGuideGroup()
	self:clearGuide()
end

function GameGuide:checkGuideEnd(uiNameId)
	if not self.ui then
		return
	end
	self:removeGuideMain()
	local cfg = GuideDataMgr:getCurGuideInfo()
	if not cfg then
		return
	end
	if uiNameId and uiNameId == cfg.uiName then
		self:doNextGuide()
	else
		GuideDataMgr:saveStep()
		self:checkGuide(self.ui)
	end
end

function GameGuide:removeGuideMain()
	if self.ui then
		if self.ui._GuideMain then
			self.ui._GuideMain:onClose()
			self.ui:removeLayer(self.ui._GuideMain)
		end

		self.ui._GuideMain = nil
	end
end

function GameGuide:guideTargetNode(targetNode, adjustPos)
    self:showGuideLayer(self.ui, GuideDataMgr:getCurGuideInfo(), targetNode, adjustPos)
end

function GameGuide:guideFuncDown(uiNameId)
	if not self.ui then
		return
	end
	self:removeGuideMain()
	local cfg = GuideDataMgr:getCurGuideInfo()
	if uiNameId and uiNameId == cfg.uiName then
		GuideDataMgr:saveStep()
		self:checkGuide(self.ui)
	end
end

function GameGuide:excuteGuide(cfg)
	dump(cfg)
	if cfg.id == 7 then
		Utils:sendHttpLog("beginer_guide_R")
	end
    local func = self:getExcuteFunc(cfg)
    if func then
        func(self.ui, cfg.uiName)
    else
    	self:guideTargetNode()
    end
end

function GameGuide:getExcuteFunc(cfg)
    local func = self.ui["excuteGuideFunc" .. tostring(cfg and cfg.uiName)]
    if type(func) == "function" then
        return func
    end
end

function GameGuide:delayToGuide(delay, func)
	local function delayCall()
		func()
		TFDirector:removeTimer(self.timer)
	end

	self.timer = TFDirector:addTimer(delay * 1000, -1, nil, delayCall)
end


return GameGuide