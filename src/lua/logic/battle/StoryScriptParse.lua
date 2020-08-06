local StoryScriptParse = StoryScriptParse or {}
local ScriptEvtNode = import(".ScriptEvtNode")

function StoryScriptParse:parse(param)
	self:clear()
	self.callback = param.callback
	self.ActiveTriggerId = param.triggerId
	self.scriptId = param.scriptName
	self.battleCtrl = param.battleCtrl
	if TFFileUtil:existFile(string.format("storyscript/story_%s.lua",tostring(param.scriptName))) == true then
		self.scriptCont = requireNew("res.basic.storyscript.story_"..tostring(param.scriptName))
	else
		if DEBUG and DEBUG == 1 and CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
			Box(string.format("Not exist:storyscript/story_%s.lua",tostring(param.scriptName)))
		end
	end
	if self.scriptCont then
		self:parseChildEvtNode(self.scriptCont)
		self:runScript()
	end
end

function StoryScriptParse:clear()
	self.scriptCont = nil
	self.evtNodeList = {}
	self.idnum = 100000
end

function StoryScriptParse:getIdxNum()
	self.idnum = self.idnum + 1
	return self.idnum
end

function StoryScriptParse:makeEvtNode(cfg,tmparent)
	local nodeidxnum = self:getIdxNum()
	local tmNode = ScriptEvtNode:new({cfg = clone(cfg),idxnum = nodeidxnum,parent = tmparent,battleCtrl = self.battleCtrl})
	self.evtNodeList[#self.evtNodeList + 1] = tmNode
	if tmNode.nodeClass == "EvtSequence" or tmNode.nodeClass == "EvtSpaw" then
		self:parseChildEvtNode(clone(cfg.Evts),tmNode)
	end
end

function StoryScriptParse:parseChildEvtNode(cfg,parent)
	for i,v in ipairs(cfg) do
        self:makeEvtNode(clone(v),parent)
	end
end

function StoryScriptParse:runScript()
	table.sort( self.evtNodeList, function(a,b)
		return a.IdxNum < b.IdxNum
	end )
	self.evtNodeList[1]:registCompleteCallback(handler(self.onScriptComplete,self))
	self.evtNodeList[1]:runEvent()
end


function StoryScriptParse:onScriptComplete()
	--脚本执行完回调
	print("Story Script Play Complete !!!!")
	local param = {scriptId = self.scriptId}
	if self.ActiveTriggerId and self.ActiveTriggerId ~= "" then
		param.event = "TriggerEventActivate"
		param.triggers = string.split(self.ActiveTriggerId,",")
	end
	self.callback(param)
end

return StoryScriptParse