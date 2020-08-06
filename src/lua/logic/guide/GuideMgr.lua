local BattleConfig = require("lua.logic.battle.BattleConfig")
local enum   = require("lua.logic.battle.enum")
local eEvent = enum.eEvent
local eGuideAction = enum.eGuideAction

local GuideMgr = class("GuideMgr")
function GuideMgr:ctor()
	self.guideLayer = nil
    self.data = TabDataMgr:getData("BattleGuide")
    EventMgr:addEventListener(self, eEvent.EVENT_GUIDE_TRIGGER, handler(self.onStepTrigger,self))
    EventMgr:addEventListener(self, eEvent.EVENT_GUIDE_END, handler(self.onStepEnd,self))
    EventMgr:addEventListener(self, eEvent.EVENT_GUIDE_SKIP, handler(self.onStepSkip,self))
	--0 还没开始
	--1 记录的就是已经完成的
	self.nStep     = 0  --当前
	self.nNextStep = 0
end

--载入引导状态
function GuideMgr:reloadState()
    local state = GuideDataMgr:getBattleGuideState()
    if not state then
        self.nStep     = 0  --当前
        self.nNextStep = 1
    else
        self.nStep     = 0
        self.nNextStep = 0
    end
end

function GuideMgr:getGuideInfo(index)
	return self.data[index]
end
function GuideMgr:getStep()
	return self.nStep
end

function GuideMgr:getNextStep()
	return self.nNextStep
end
function GuideMgr:getNextStepInfo()
	if self.nNextStep > 0 then
		return self:getGuideInfo(self.nNextStep)
	end
end

function GuideMgr:onStepTrigger(guideInfo)
    local id = guideInfo.id
    if id == 1 then
    	battleController.setAiEnabled(false)
    end
    self.nStep = id
    self.nNextStep = self.nStep + 1
end

function GuideMgr:onStepEnd(guideInfo)
    local step = guideInfo.id
    if guideInfo.nextStep > 0 then
    	self:doGuideAction(eGuideAction.NEXT,step,0)
	else
        self.nStep     = 0
        self.nNextStep = 0
        battleController.setAiEnabled(true)
        GuideDataMgr:setBattleGuideState(true)
	end
end

--跳过操作跳过一大步
function GuideMgr:onStepSkip()
    -- if self.guideLayer then
    --     self.guideLayer:forceClose()
    -- end
    self.nStep     = 0
    self.nNextStep = 0
    battleController.setAiEnabled(true)
    GuideDataMgr:setBattleGuideState(true)
end

function GuideMgr:setGuideLayer(layer)
	self.guideLayer = layer
end
function GuideMgr:getGuideLayer()
	return self.guideLayer
end


function GuideMgr:doGuideInfo(guideInfo)
	local guideView = self:getGuideLayer()
    if not guideView then
    	local GuideView = require("lua.logic.guide.GuideView")
        guideView = GuideView:new()
        AlertManager:addLayer(guideView,AlertManager.NONE)
        AlertManager:show()
    end
    guideView:doStep(guideInfo)

end


function GuideMgr:doGuide(stepId)
    local guideInfo = self:getGuideInfo(stepId)
    self:doGuideInfo(guideInfo)
end

function GuideMgr:doNextGuide()
    local guideView = self:getGuideLayer()
    if guideView then
        guideView:doNextStep()
    end
end
--当前正在处理的ID
function GuideMgr:getGuideID()
    local guideView = self:getGuideLayer()
    if guideView and guideView.guideInfo then
        return guideView.guideInfo.id
    end
end


function GuideMgr:doGuideAction(action,param1,param2)
	if not BattleConfig.GUIDE then
		return
	end
	param1 = param1 or 0
	param2 = param2 or 0
	-- Box("action"..action.."param1"..param1.."param2"..param2)
	local stepInfo = self:getNextStepInfo()
	if stepInfo  then
		-- dump(stepInfo)
		if stepInfo.condition == action and stepInfo.param1  == param1 and stepInfo.param2  == param2 then
			self:doGuideInfo(stepInfo)
		end
	end
    -- print("act:"..action.." p1:"..param1.." p2:"..param2)
end

return GuideMgr:new()