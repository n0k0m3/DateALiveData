--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local LightRiddles = class("LightRiddles", BaseLayer)

local OperateStatus = {
	wait = 1,
	operate = 2,
	complete = 3
}
local offy = {30, -25, -20, -20, 15, -30}
local _Count = TabDataMgr:getData("DiscreteData", 90014).data["time"]
local GameType = 4

local function genRandomPhrase(tab)
	local temp = clone(tab)
	local ret = {}
	local idx = 1
	local function func() 
		local len = #temp 
		return len > 0
	end
	while func() do
		local randomIdx = math.random(1, #temp)
		table.insert(ret, temp[randomIdx])
		table.remove(temp, randomIdx)
		idx = idx + 1
	end

	return ret
end

function LightRiddles:ctor(...)
	self.super.ctor(self, ...)
	self.data = ... --or {group = 7, result = {1011,1012,1013,1014,1015,1016}}
	self.rewards = nil
	self.spineOver = false

	self.lights = {}
	self.posVec = {}
	self.result = {}
	self.topBarFileName = "NewYearMiniGame" 
	self.curLightIdx = 1
	self.curPhraseStr = ""
	self.deadTime = _Count + ServerDataMgr:getServerTime()
	self.count = _Count
	self.hasOperate = OperateStatus.wait

	self.tRightPhraseCfg = self:getPhraseConfig()
	self.tRandomPhraseCfg = genRandomPhrase(self.tRightPhraseCfg)


	EventMgr:addEventListener(self, EV_NEW_YEAR_GAME_FINISH, handler(self.onFinish, self))

	self:init("lua.uiconfig.activity.lightRiddles")	
end

function LightRiddles:onFinish(data)
	if GameType == data.game then
		if data.status then			
			self.rewards = data.rewards
			if self.spineOver then
				ActivityDataMgr2:showGameResult(data)
				self:gameOver()
			end
		else
--			Utils:showTips("游戏未完成")
			self:gameOver()
		end
	end
end

function LightRiddles:getPhraseConfig()
	local configFenzu = TabDataMgr:getData("MJfenzu",self.data.group)
	local ids = configFenzu["formulation"]
	local _Config = TabDataMgr:getData("MJziyuan")
	local tab = {}
	for i = 1, #ids do
		local config = _Config[ids[i]]
		table.insert(tab, config)
	end
	return tab
end

function LightRiddles:getRightPhrase()
	local ret = ""
	for i = 1, #self.tRightPhraseCfg do
		ret = ret .. self.tRightPhraseCfg[i].name
	end
	return ret
end

function LightRiddles:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = ui:getChildByName("Panel_root")
	self.Panel_root.size = self.Panel_root:getSize()
	self.Panel_root.lights = self.Panel_root:getChildByName("lights")
	self.touchShield = self.Panel_root:getChildByName("touchShield")
	self.touchShield.size = self.touchShield:getSize()
	self.touchShield:setVisible(false)

	self.Panel_root.close = self.Panel_root:getChildByName("btn_close")
	self.Panel_root.close:setVisible(false)
	self.Panel_root.close:onClick(function()
		self:gameOver()
	end)
	self.countSecond =	self.Panel_root:getChildByName("downcount")
	self.countSecond:setText("")

	self.mask =	self.Panel_root:getChildByName("mask")
	self.mask:setVisible(false)


	for i = 1,6 do
		local light = self.Panel_root.lights:getChildByName("light"..i)
		table.insert(self.lights, light)
		table.insert(self.posVec, light:getPosition())
		light.config = self.tRandomPhraseCfg[i]
--		light.order = self.tRandomPhraseCfg[i].order
		light.isBright = false
		light.y = light:getPositionY()
		light:setPositionY(light.y + offy[i])	

		light.label = light:getChildByName("label")
		light.label:setText(self.tRandomPhraseCfg[i].name)
		light.bright = light:getChildByName("Spine_bright")
		light.black = light:getChildByName("black")

		light.bright:setVisible(false)
		light.black:setVisible(true)
		light:setTouchEnabled(true)
		light:addMEListener(TFWIDGET_CLICK, function(sender)
			self:onClickLantern(sender)
		end)
	end

	for i = 1,6 do
		local light = self.lights[i]
		local idx = light.config["order"]
		light.originPos = self.posVec[idx]
	end

	self:refreshView()
	self:addCountDownTimer()
	self:doEffect()
end

function LightRiddles:refreshView()
	
end


function LightRiddles:doEffect()

	for k, light in pairs(self.lights) do		
		local move  = MoveBy:create(1.5 + 0.1 * k, ccp(0, -offy[k]))
		local forever = RepeatForever:create(Sequence:create({move,move:reverse()}))
		light:runAction(forever)		
	end
end

--熄灭所有
function LightRiddles:putOutAllLanterns()
	for k, v in pairs(self.lights) do
		self:putOutOneLantern(v)
	end
end

--熄灭一个
function LightRiddles:putOutOneLantern(lantern)
	if lantern == nil then
		return
	end
	lantern.isBright = false
	lantern.bright:setVisible(false)
	lantern.black:setVisible(true)
end

--点亮
function LightRiddles:brightOneLantern(lantern)
	if lantern == nil then
		return
	end
	lantern.isBright = true
	lantern.bright:setVisible(true)
	lantern.black:setVisible(false)
end

--点击
function LightRiddles:onClickLantern(lantern)
	if lantern == nil then
		return
	end

	lantern:runAction(Sequence:createWithTwoActions(ScaleTo:create(0.1,1.1), ScaleTo:create(0.1,1.0)))

	if lantern.isBright or self.curLightIdx > #self.tRightPhraseCfg then
		return;
	end

	
	self.hasOperate = OperateStatus.operate

	--顺序对了就点亮
	if lantern.config["order"] == self.curLightIdx then
		self:brightOneLantern(lantern)
		self.curPhraseStr = self.curPhraseStr .. lantern.label:getText()

		table.insert(self.result, lantern.config["id"])

		self:checkGameVectory()

		self.curLightIdx = self.curLightIdx  + 1
				
	else--错了就全部熄灭
		if self.curLightIdx == 1 then
			Utils:showTips(2460093)
		end

		self.curLightIdx = 1
		self.curPhraseStr = ""
		self.result = {}
		self:putOutAllLanterns()
	end	
end

function LightRiddles:checkGameVectory()
	local function __checkResult()
		local win = true
		for i = 1, #self.data.result do
			if not self.result[i] or self.result[i] ~= self.data.result[i] then
				win = false
			end
		end
		return win
	end
	if self.curLightIdx >= #self.tRightPhraseCfg and  self.curPhraseStr == self:getRightPhrase() and __checkResult() then
		self:gameVectory()
	end
end

function LightRiddles:gameOver(isShowTips)
	self:removeCountDownTimer()	

	local func =function()
		AlertManager:closeLayer(self)
	end
	if isShowTips then
		Utils:showTips("倒计时结束")
		self:runAction(Sequence:createWithTwoActions(DelayTime:create(2), CallFunc:create(func)))
	else
		func()
	end
end

function LightRiddles:gameVectory()
	for k, v in pairs (self.lights) do
		v:stopAllActions()
		v:runAction(MoveTo:create(0.8, v.originPos))
	end
	self.hasOperate = OperateStatus.complete
	self.countSecond:setVisible(false)
	self:removeCountDownTimer()	
	

	local spineSuccess = SkeletonAnimation:create("effect/effect_MJyouxichenggong/MJyouxichenggong")
	spineSuccess:setPosition(ccp(self.touchShield.size.width / 2, self.touchShield.size.height / 2))
    spineSuccess:play("animation", false)
	spineSuccess:setPosition(ccp(0,0))
	spineSuccess:setMix("animation","animation1",0.2)
	spineSuccess:setMix("animation1","animation",0.2)
    self.Panel_root:addChild(spineSuccess, 10)
    spineSuccess:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
		if animationName == "animation" then
			spine:play("animation1", false)
			self.mask:setVisible(true)
		elseif animationName == "animation1" then
			if self.rewards and #self.rewards >0 then
				local data = {}
				data.rewards = self.rewards
				ActivityDataMgr2:showGameResult(data)
				self.spineOver = true
			end
			self:gameOver()
		end
		
     end)
	self.touchShield:setVisible(true)
	TFAudio.playSound("sound/dating_sound/dating_285.mp3")

	ActivityDataMgr2:Req2020FestivalGameFinish(self.data.group, self.result)
end

function LightRiddles:addCountDownTimer()
	local ClockCounter = requireNew("lua.logic.common.ClockCounter")
	self.clockCounter = ClockCounter:create(self.deadTime, 1000, _Count, handler(self.checkGameVectory, self),handler(self.onCountDownPer, self))	
	self.countSecond:addChild(self.clockCounter)
	self.clockCounter:startTimer()
end

function LightRiddles:removeCountDownTimer()
   self.clockCounter:stopTimer()
end

function LightRiddles:onCountDownPer(t)
	self.count = t
	
	if self.hasOperate == OperateStatus.wait and self.count < _Count - 3 then
		Utils:showTips(2460044)
		self.hasOperate = true
	end

	if self.count == 0 then
		self.touchShield:setVisible(true)
		self:gameOver(true)
	end
end

function LightRiddles:removeEvents()
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

return LightRiddles


--endregion
