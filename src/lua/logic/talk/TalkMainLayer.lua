local TalkMainLayer = class("TalkMainLayer",BaseLayer)

local TalkBGEnum = {
		["11"] = {
					res = "ui/battleDialog/chrTextBox.png", --背景框
					flip = false,--是否镜像
					namePos = me.p(-130,65),--名字标签坐标
					nameRotation = 0,--名字标签旋转角度
					nameFontSize = 16,--名字标签字号
					btnPos = me.p(215,-70),--箭头按钮位置
					textPos = me.p(-155,-55),--对话文本位置
					textAreaSize = me.size(400,80), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0, --对话文本旋转角度
				},
		["12"] = {
					res = "ui/battleDialog/chrTextBoxS.png",
					flip = false,
					namePos = me.p(-160,85),
					nameRotation = 0,
					nameFontSize = 16,
					btnPos = me.p(215,-55),
					textPos = me.p(-210,-40),
					textAreaSize = me.size(400,80), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0,
				},
		["21"] = {
					res = "ui/battleDialog/chrTextBox.png",
					flip = true,
					namePos = me.p(130,75),
					nameRotation = 15,
					nameFontSize = 16,
					btnPos = me.p(160,-65),
					textPos = me.p(-240,-45),
					textAreaSize = me.size(400,80), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0,
				},
		["22"] = {
					res = "ui/battleDialog/chrTextBoxS.png",
					flip = true,
					namePos = me.p(160,105),
					nameRotation = 15,
					nameFontSize = 16,
					btnPos = me.p(160,-55),
					textPos = me.p(-195,-35),
					textAreaSize = me.size(400,80), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0,
				},
		["31"] = {
					res = "ui/battleDialog/mineTextBox.png",
					flip = false,
					namePos = me.p(-145,230),
					nameRotation = 0,
					nameFontSize = 16,
					btnPos = me.p(205,75),
					textPos = me.p(-240,100),
					textAreaSize = me.size(400,92), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0,
				},
		["32"] = {
					res = "ui/battleDialog/mineTextBoxS.png",
					flip = false,
					namePos = me.p(-145,230),
					nameRotation = 0,
					nameFontSize = 16,
					btnPos = me.p(195,60),
					textPos = me.p(-240,100),
					textAreaSize = me.size(470,92), --对话文本区域规格
					textFontSize = 24,--对话文本字号
					textRotation = 0,
				},
	}

local UI_Default_Cfg = {
	headLP = me.p(170,0),
	headRP = me.p(966,0),
	ttbp = me.p(568,0),
	rtbp = me.p(568,126),
}
local TalkBGShakeAnim = {
	[1] = function(delayTime)
			local actionArr = {MoveBy:create(0.02,me.p(10,0)),MoveBy:create(0.04,me.p(-20,0)),MoveBy:create(0.02,me.p(10,0))}
			local shakeAnim = Repeat:create(Sequence:create(actionArr),5)
			if delayTime and delayTime > 0 then
				return {DelayTime:create(delayTime/1000),shakeAnim}
			end
			return {shakeAnim}
		end,
	[2] = function(delayTime)
			local actionArr = {MoveBy:create(0.02,me.p(20,0)),MoveBy:create(0.04,me.p(-40,0)),MoveBy:create(0.02,me.p(20,0))}
			local shakeAnim = Repeat:create(Sequence:create(actionArr),5)
			if delayTime and delayTime > 0 then
				return {DelayTime:create(delayTime/1000),shakeAnim}
			end
			return {shakeAnim}
	end,
}

local TalkRoleShakeAnim = {
	[1] = function(delayTime)
			local actionArr = {MoveBy:create(0.02,me.p(10,0)),MoveBy:create(0.04,me.p(-20,0)),MoveBy:create(0.02,me.p(10,0))}
			local shakeAnim = Repeat:create(Sequence:create(actionArr),10)
			if delayTime and delayTime > 0 then
				return {DelayTime:create(delayTime/1000),shakeAnim}
			end
			return {shakeAnim}
		end,
	[2] = function(delayTime)
			local actionArr = {MoveBy:create(0.02,me.p(20,0)),MoveBy:create(0.04,me.p(-40,0)),MoveBy:create(0.02,me.p(20,0))}
			local shakeAnim = Repeat:create(Sequence:create(actionArr),10)
			if delayTime and delayTime > 0 then
				return {DelayTime:create(delayTime/1000),shakeAnim}
			end
			return {shakeAnim}
	end,
}
function TalkMainLayer:checkContentMatch(conditions,formation)
	local isMatch = true
	if formation == nil then
		return isMatch
	end
	if conditions == nil then
		return isMatch
	end
	local conditionOrMatch = false
	if conditions.heroIdOr then
		for i,v in ipairs(conditions.heroIdOr) do
			if formation[v] then
				conditionOrMatch = true
				break
			end
		end
	else
		conditionOrMatch = true
	end
	local conditionAndMatch = true
	if conditions.heroIdAnd then
		for i,v in ipairs(conditions.heroIdAnd) do
			if formation[v] == nil then
				isMatch = conditionAndMatch
				break
			end
		end
	end
	isMatch = (conditionOrMatch and conditionAndMatch)
	return isMatch
end
function TalkMainLayer:initData(data)
	self.talkdata = {}
	local dialogData = TabDataMgr:getData("Dialog")
	for k,v in pairs(dialogData) do
		if v.scriptId == data.groupid then
			if data.formation then
				if self:checkContentMatch(v.conditions,data.formation) == true then
					self.talkdata[#self.talkdata + 1] = v
				end
			else
				self.talkdata[#self.talkdata + 1] = v
			end
		end
	end
	if #self.talkdata > 1 then
		table.sort( self.talkdata, function(a,b)
			return a.order < b.order
		end)
	end

	self.completeCallback = data.callback
	self.isHideSkipBtn = data.isHideSkip
	self.curTextArea = nil
	self.talkidx = 0
	self.textSpeed = 0.1
	self.enableNext = true
	self.clickedSkip = false
	self.curNextBtn = nil
end

function TalkMainLayer:ctor(param)
	self.super.ctor(self)
    self:initData(param)
	self:init("lua.uiconfig.story.mainStoryLayer")
end

function TalkMainLayer:initUI(ui)
	self.super.initUI(self, ui)
	self.root_panel = TFDirector:getChildByPath(ui, "Panel_root")
	self.root_panel:onClick(function()
		self:nextStep()
	end)
	self.panel_bg = self.root_panel:getChildByName("Panel_bg")
	self.panel_role = self.root_panel:getChildByName("Panel_role")
	self.panel_talk = self.root_panel:getChildByName("Panel_talk")
	self.default_roleLineH = self.panel_talk:getChildByName("Panel_role_talk"):getChildByName("TextArea_talk"):getLineHeight()
	self.default_thirdLineH = self.panel_talk:getChildByName("Panel_third_talk"):getChildByName("TextArea_talk"):getLineHeight()
    self.default_roleFontSize = self.panel_talk:getChildByName("Panel_role_talk"):getChildByName("TextArea_talk"):getFontSize()
    self.default_thirdFontSize = self.panel_talk:getChildByName("Panel_third_talk"):getChildByName("TextArea_talk"):getFontSize()
	self.Image_bg = TFDirector:getChildByPath(self.root_panel, "Image_bg"):hide()

	self.panel_ctrl = self.root_panel:getChildByName("Panel_ctrl")
	self.panel_ctrl:getChildByName("Button_skip"):onClick(function()
		self:skipTalk()
	end)
	self.panel_ctrl:getChildByName("Button_skip"):setVisible(not self.isHideSkipBtn)
	self:nextStep()
end

function TalkMainLayer:updateTalk(cfg)
	self.panel_bg:setVisible(cfg.showBG == 1)
	self:updateHeads(cfg)
	local talkPanel = self.panel_talk:getChildByName("Panel_role_talk")
	talkPanel:stopAllActions()
	talkPanel:setPosition(UI_Default_Cfg.rtbp)
	if cfg.textBg == 31 or cfg.textBg == 32 then
		talkPanel = self.panel_talk:getChildByName("Panel_third_talk")
		talkPanel:setPosition(UI_Default_Cfg.ttbp)
		talkPanel:stopAllActions()

		self.panel_talk:getChildByName("Panel_role_talk"):setVisible(false)
		
	else
		self.panel_talk:getChildByName("Panel_third_talk"):setVisible(false)
	end
	if cfg.bgName and #cfg.bgName > 0 then
		self.Image_bg:show()
		self.Image_bg:setTexture(cfg.bgName)
	else
		self.Image_bg:hide()
	end
	self:updateTalkPanel(talkPanel,cfg)
end

function TalkMainLayer:updateHeads(cfg)
	local function handleHead(headroot,headcfg)
		local imgHead = headroot:getChildByName("Image_head")
		local imgMask = headroot:getChildByName("Image_mask")
		if headcfg.head and headcfg.head ~= "0" and headcfg.head ~= "" then
			local headpath = string.format("icon/battleDialog/btlPortrait_%s.png",headcfg.head)
			imgHead:setTexture(headpath)
			imgMask:setTexture(headpath)
			imgMask:setColor(ccc4(0,0,0,255))
			imgMask:setOpacity(125)
			imgHead:setFlipX(headcfg.flip)
			imgMask:setFlipX(headcfg.flip)
			imgHead:setVisible(true)
			imgMask:setVisible(not headcfg.highLight)
			local headAnim = {}
			if #headcfg.animCfg > 0 then
				for i,v in ipairs(headcfg.animCfg) do
					local tmanims = TalkRoleShakeAnim[v.id](v.delay)
					table.insertTo(headAnim,tmanims)
				end
			end
			local headHolder = string.sub(headcfg.head,1,5)
			if imgHead.head_holder ~= headHolder or imgHead.stat ~= headcfg.highLight then
				imgHead.stat = headcfg.highLight
				imgHead.head_holder = headHolder
				if headcfg.highLight == true then
					headroot:setScale(0.9)
					table.insert(headAnim,1,ScaleTo:create(0.1,1))
				else
					headroot:setScale(1)
					table.insert(headAnim,1,ScaleTo:create(0.1,0.9))
				end
			end
			if #headAnim > 0 then
				headroot:runAction(Sequence:create(headAnim))
			end
		else
			imgHead:setVisible(false)
			imgMask:setVisible(false)
		end
		
	end
	local headLeftCfg = {head = cfg.headL,flip = cfg.headMirrorL,highLight = cfg.isSpeakingL,animCfg = cfg.actionL}
	local headRightCfg = {head = cfg.headR,flip = cfg.headMirrorR,highLight = cfg.isSpeakingR,animCfg = cfg.actionR}
	local head_root_l = self.panel_role:getChildByName("Panel_role_left")
	local head_root_r = self.panel_role:getChildByName("Panel_role_right")
	head_root_l:stopAllActions()
	head_root_r:stopAllActions()
	head_root_l:setPosition(UI_Default_Cfg.headLP)
	head_root_r:setPosition(UI_Default_Cfg.headRP)
	handleHead(head_root_l,headLeftCfg)
	handleHead(head_root_r,headRightCfg)
end

function TalkMainLayer:updateTalkPanel(talk_panel,cfg)
	--名字
	local textBGAnim = {}
	for i,v in ipairs(cfg.actionText) do
		local tmAnim = TalkBGShakeAnim[v.id](v.delay)
		table.insertTo(textBGAnim,tmAnim)
	end
	talk_panel:setVisible(true)
	if #textBGAnim > 0 then
		talk_panel:runAction(Sequence:create(textBGAnim))
	end
	local img_talk_bg = talk_panel:getChildByName("Image_talk_bg")
	local talkBGCfg = TalkBGEnum[tostring(cfg.textBg)]
	img_talk_bg:setTexture(talkBGCfg.res)
	img_talk_bg:setFlipX(talkBGCfg.flip)
	local name_bg = talk_panel:getChildByName("Image_name_bg")
	-- name_bg:setPosition(talkBGCfg.namePos)
	-- name_bg:setRotation(talkBGCfg.nameRotation)
	--英文版强制修改标题位置
	name_bg:setPositionY(90)
	name_bg:setRotation(5)
	if cfg.name == "1" then
		name_bg:getChildByName("Label_role_name"):setText(MainPlayer:getPlayerName())
	else
		name_bg:getChildByName("Label_role_name"):setText(cfg.name)
	end
	name_bg:getChildByName("Label_role_name"):setFontSize(talkBGCfg.nameFontSize)
	local nextBtn = talk_panel:getChildByName("Button_talk_next")
	nextBtn:setPosition(talkBGCfg.btnPos)
	nextBtn:onClick(function()
		self:nextStep()
	end)
	self.curNextBtn = nextBtn
	self.curNextBtn:setVisible(false)
	local textArea = talk_panel:getChildByName("TextArea_talk")
	textArea:setPosition(talkBGCfg.textPos)
	textArea:setRotation(talkBGCfg.textRotation)
	if GAME_LANGUAGE_VAR == "" then
		textArea:setFontSize(talkBGCfg.textFontSize)
		textArea:setTextAreaSize(talkBGCfg.textAreaSize)
	else
		textArea:setFontSize(20)
	end
	
	self:updateContent(textArea,cfg)
	if self.voicehandle and TFAudio.isEffectPlaying(self.voicehandle) then
		TFAudio.stopEffect(self.voicehandle)
		self.voicehandle = nil
	end
	if cfg.voice and cfg.voice ~= "" then
		self:playVoice(cfg.voice)
	end
end

function TalkMainLayer:updateContent(textArea,cfg)
	local str = ""
	local textInfo = {}
	local strlen = 0
	local textData = cfg.text
	local holdtime = cfg.autoShutTime
	local defaultLineH = self.default_roleLineH
    local defaultFontS = self.default_roleFontSize
	if cfg.textBg == 31 or cfg.textBg == 32 then
		defaultLineH = self.default_thirdLineH
        defaultFontS = self.default_thirdFontSize
	end
	local maxLineHeight = defaultLineH
	for k,v in ipairs(textData) do
		local tmtext = v.text
		local plusColorCfg = {}
		if string.match(tmtext,"%%s") then
			local playername = MainPlayer:getPlayerName()
			local tmsidx,tmeidx = string.find(tmtext,"%%s")
			local headStr = ""
			if tmsidx > 1 then
				headStr = string.sub(tmtext,1,tmsidx-1)
			end
			local headStrLen = string.utf8len(headStr)
			local nameLen = string.utf8len(playername)
			plusColorCfg.color = me.c3b(253,56,112)
			plusColorCfg.pos = {strlen + headStrLen + 1,strlen +headStrLen + nameLen}
			tmtext = string.format(tmtext,playername)
		end
        local scale = v.scale or 1
		str = str..tmtext
		local color = v.color or "101117"
		local rgb = me.c3b(tonumber("0x"..string.sub(color,1,2)),tonumber("0x"..string.sub(color,3,4)),tonumber("0x"..string.sub(color,5,6)))
		
		local tmLineH = defaultLineH * scale
		maxLineHeight = math.max(tmLineH,maxLineHeight)
		local curlen = string.utf8len(tmtext)
	
		local seidx = {strlen + 1,strlen + curlen}
		strlen = strlen + curlen
		local tmtextCfg = {color = rgb,txtpos = seidx,times = curlen,scale = scale,pcolor = plusColorCfg}
		if v.delay then
			tmtextCfg.delayTime = v.delay/1000
		end
		if v.speed then
			tmtextCfg.speed = v.speed/1000
		end
		textInfo[#textInfo + 1] = tmtextCfg
	end
	--英文版断行规则关闭 正常断词
	if GAME_LANGUAGE_VAR ~= "" then
		textArea:setLineBreakWithoutSpace(false)
	else
		textArea:setLineBreakWithoutSpace(true)
	end
	textArea:setText(str)
	textArea:setLineHeight(maxLineHeight)
	local actionArr = {}
    textArea.fidx = 0
    textArea.strlen = strlen
    -- local tmStrLen = textArea:getStringLength()
    -- if tmStrLen ~= strlen then
    -- 	Box("M:"..strlen.."|T:"..tmStrLen)
    -- end

	for i=1,#textInfo do
		local cuttxtinfo = textInfo[i]
		for j = cuttxtinfo.txtpos[1],cuttxtinfo.txtpos[2] do
			local letter = textArea:getLetter(j-1)
			if letter then
				letter:setColor(cuttxtinfo.color)
				if cuttxtinfo.pcolor.color then
					if j >= cuttxtinfo.pcolor.pos[1] and j <= cuttxtinfo.pcolor.pos[2] then
						letter:setColor(cuttxtinfo.pcolor.color)
					end
				end
                letter:setScale(cuttxtinfo.scale)
				letter:setVisible(false)
				local doShowLetter = CallFunc:create(function()
					local tmletter = textArea:getLetter(textArea.fidx)
					if tmletter then
						tmletter:setVisible(true)
					else
						-- Box("Fuck2")
					end
					textArea.fidx = textArea.fidx + 1
				end)
				local delayTime = DelayTime:create(cuttxtinfo.speed or self.textSpeed)
				local actsequence = Sequence:create({doShowLetter,delayTime})
				actionArr[#actionArr + 1] = actsequence
			else
				-- Box("Fuck1")
			end
		end
		if cuttxtinfo.delayTime then
			actionArr[#actionArr + 1] = DelayTime:create(cuttxtinfo.delayTime)
		end
	end
	local nextBtnShow = CallFunc:create(function()
		if self.curNextBtn then
			self.curNextBtn:setVisible(true)
		end
		self.curNextBtn = nil
	end)
	actionArr[#actionArr + 1] = nextBtnShow
	if holdtime > 0 then
		actionArr[#actionArr + 1] = DelayTime:create(holdtime/1000)
		local completeCall = CallFunc:create(function()
			self:nextStep()
		end)
		actionArr[#actionArr + 1] = completeCall
	end
	
	local tmSequence = Sequence:create(actionArr)
	textArea:runAction(tmSequence)
	self.curTextArea = textArea
end

function TalkMainLayer:playVoice(voice)
	if TFFileUtil:existFile(voice) then
		self.voicehandle = TFAudio.playVoice(voice,false)
	else
		print(string.format("Not Exist sound file:%s",voice))
	end	
end

function TalkMainLayer:nextStep()
	if self.enableNext == false then
		return
	end
	self.enableNext = false
	local showAllFunc = CallFunc:create(function( ... )
		if self.curTextArea then
			self.curTextArea:stopAllActions()
			for i=1,self.curTextArea.strlen do
				local tmletter = self.curTextArea:getLetter(i)
				if tmletter then
					tmletter:setVisible(true)
				end
				if i == self.curTextArea.strlen then
					self.curTextArea.fidx = self.curTextArea.strlen
					if self.curNextBtn then
						self.curNextBtn:setVisible(true)
						self.curNextBtn = nil
					end
				end
			end
		end
	end)

	local waitAMoment = DelayTime:create(0.25)
	local allShowedCall = CallFunc:create(function()
		self.enableNext = true
	end)
	local doNextFunc = CallFunc:create(function( ... )
		self.talkidx = self.talkidx + 1
		local talkcfg = self.talkdata[self.talkidx]
		if talkcfg then
			self:updateTalk(talkcfg)
			self.enableNext = true
		else
			self:skipTalk()
		end
	end)
	local actArr = {doNextFunc}
	if self.curTextArea then
		if self.curTextArea.fidx < self.curTextArea.strlen then
			actArr = {showAllFunc,allShowedCall}
		else
			actArr = {waitAMoment,doNextFunc}
		end
	end
	self:runAction(Sequence:create(actArr))
end

function TalkMainLayer:skipTalk()
	if self.clickedSkip == false then
		self.clickedSkip = true
		if self.curTextArea then
			self.curTextArea:stopAllActions()
		end
		self:storyComplete()
	end
end

function TalkMainLayer:storyComplete()
	if self.completeCallback then
		self.completeCallback()
	end
	if self.voicehandle and TFAudio.isEffectPlaying(self.voicehandle) then
		TFAudio.stopEffect(self.voicehandle)
		self.voicehandle = nil
	end
	AlertManager:closeLayer(self)
end
return TalkMainLayer