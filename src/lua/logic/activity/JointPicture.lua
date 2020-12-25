--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local JointPicture = class("JointPicture", BaseLayer)

local Zorder_ = {
	Default = 1,
	[1] = 10,
	[2] = 9,
}
local speed = 0.3
local _Count = TabDataMgr:getData("DiscreteData", 90014).data["time"]
local GameType = EC_NewYearGameType.Puzzle

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

function JointPicture:ctor(...)
	self.super.ctor(self, ...)

	self.data = ... ---or {group = 14, result = {2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016}}
	self.rewards = nil
	self.result = {}
	self.isShowReward = false
	self.deadTime = _Count + ServerDataMgr:getServerTime()
	self.count = _Count
	self.hasOperate = false
	self.topBarFileName = "NewYearMiniGame" 

	self.configFenzu = TabDataMgr:getData("MJfenzu",self.data.group)
	self.tRandomConfig = self:getRandomConfig(genRandomPhrase(self.configFenzu["formulation"]))

	self.tPic ={}
	self.tTranslatePics = {}

	EventMgr:addEventListener(self, EV_NEW_YEAR_GAME_FINISH, handler(self.onFinish, self))
	self:init("lua.uiconfig.activity.jointPicture")	
end

function JointPicture:onFinish(data)
	if GameType == data.game then
		if data.status then			
			self.rewards = data.rewards
			if self.isShowReward then
				ActivityDataMgr2:showGameResult(data)
				self:gameOver()
			end
		else
			self:gameOver()
		end
	end
end

function JointPicture:getRandomConfig(ids)	
	local _Config = TabDataMgr:getData("MJziyuan")
	local tab = {}
	for i = 1, #ids do
		local config = _Config[ids[i]]
		table.insert(tab, config)
	end
	return tab
end

function JointPicture:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = ui:getChildByName("Panel_root")
	self.touchShield = self.Panel_root:getChildByName("touchShield")
	self.touchShield.size = self.touchShield:getSize()
	self.touchShield:setVisible(false)
	self.btn_close = self.Panel_root:getChildByName("btn_close")
	self.btn_close:setVisible(false)
	self.btn_close:onClick(function()
		self:gameOver()
	end)

	self.mask =	self.Panel_root:getChildByName("mask")
	self.mask:setVisible(false)
	
	self.sample = self.Panel_root:getChildByName("sample")
	self.sample:setTexture(self.configFenzu["picture"])

	self.countSecond = self.Panel_root:getChildByName("downcount")
	self.countSecond:setText("")
	self.grids = self.Panel_root:getChildByName("grids")

	for i = 1, 16 do
		local config = self.tRandomConfig[i]
		local pic = self.grids:getChildByName("grid"..i)
		pic.isSelected = false
		pic.idx = i
		pic.originPos = pic:getPosition()
		pic.order = config.order
		table.insert(self.tPic, pic)

		
		pic:setTexture(config.res)
		pic:setZOrder(Zorder_.Default)

		pic.selected = pic:getChildByName("select")
		pic.selected:setVisible(false)

		pic:setTouchEnabled(true)
		pic:addMEListener(TFWIDGET_CLICK, handler(self.onClickPic,self))
	end


	self:addCountDownTimer()


	
end

function JointPicture:onClickPic(sender)
	if sender.isSelected then
		sender.isSelected = false
		sender.selected:setVisible(false)
		self.tTranslatePics = {}
	else
		sender.isSelected = true
		sender.selected:setVisible(true)
		table.insert(self.tTranslatePics, sender)
	end

	if table.count(self.tTranslatePics) == 2 then
		self:runTranslate()
	end
end

function JointPicture:runTranslate()
	if table.count(self.tTranslatePics) ~= 2 then
		return
	end

	if not self:translateInvalid() then
		self:resetSelect()
		return
	end

	self.touchShield:setVisible(true)
	
	self.tTranslatePics[1]:setZOrder(Zorder_[1])
	self.tTranslatePics[1].selected:setVisible(false)
	self.tTranslatePics[2]:setZOrder(Zorder_[2])
	self.tTranslatePics[2].selected:setVisible(false)	
	
	local p1 = self.tTranslatePics[1]:getPosition()
	local p2 = self.tTranslatePics[2]:getPosition()
	local idx1 = self.tTranslatePics[1].idx
	local idx2 = self.tTranslatePics[2].idx

	self.tTranslatePics[1]:runAction(MoveTo:create(speed, p2))
	self.tTranslatePics[2]:runAction(Sequence:createWithTwoActions(MoveTo:create(speed + 0.01, p1), CallFunc:create(function()
		self.tTranslatePics[1]:setZOrder(Zorder_.Default)
		self.tTranslatePics[1].originPos = p2		
		self.tTranslatePics[1].isSelected= false
		self.tTranslatePics[1].idx = idx2

		self.tTranslatePics[2]:setZOrder(Zorder_.Default)
		self.tTranslatePics[2].originPos = p1
		self.tTranslatePics[2].isSelected= false
		self.tTranslatePics[2].idx = idx1

		self:resetSelect()

		self:checkVectory()
	end)))

end

function JointPicture:translateInvalid()
	local idx1 = self.tTranslatePics[1].idx - 1
	local idx2 = self.tTranslatePics[2].idx - 1
	return (idx1 % 4 == idx2 % 4 and math.abs(idx1 - idx2) == 4) or (math.floor(idx1 / 4) == math.floor(idx2 / 4) and math.abs(idx1 - idx2) == 1)
end


function JointPicture:resetSelect()
	self.tTranslatePics[1].selected:setVisible(false)
	self.tTranslatePics[1].isSelected= false
	self.tTranslatePics[1]:setZOrder(Zorder_.Default)

	self.tTranslatePics[2].selected:setVisible(false)
	self.tTranslatePics[2].isSelected= false
	self.tTranslatePics[2]:setZOrder(Zorder_.Default)
	
	self.tTranslatePics = {}
	self.touchShield:setVisible(false)
end


function JointPicture:refreshView()
	
end

function JointPicture:checkVectory()
	local success = true
	for k, val in pairs(self.tPic) do
		if val.order ~= val.idx then
			success = false
			break;
		end
	end

	if success then
		self:gameVectory()
	end
end




function JointPicture:gameVectory()

	local spineSuccess = SkeletonAnimation:create("effect/effect_MJyouxichenggong/MJyouxichenggong")
	spineSuccess:setPosition(ccp(self.touchShield.size.width / 2, self.touchShield.size.height / 2))
    spineSuccess:play("animation", false)
	spineSuccess:setMix("animation","animation1",0.2)
	spineSuccess:setMix("animation1","animation",0.2)
	spineSuccess:setPosition(ccp(0,0))
    self.Panel_root:addChild(spineSuccess, 10)
    spineSuccess:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
		if animationName == "animation" then
			spine:play("animation1", false)
			self.mask:setVisible(true)
		elseif animationName == "animation1" then
			if self.rewards and #self.rewards >0 and not self.isShowReward then
				local data = {}
				data.rewards = self.rewards
				ActivityDataMgr2:showGameResult(data)
				self.isShowReward = true
			end
			self:gameOver()
		end
		
     end)
	self.touchShield:setVisible(true)
	TFAudio.playSound("sound/dating_sound/dating_285.mp3")

	
	self:removeCountDownTimer()
	ActivityDataMgr2:Req2020FestivalGameFinish(self.data.group, self.data.result)
end

function JointPicture:addCountDownTimer()
	local ClockCounter = requireNew("lua.logic.common.ClockCounter")
	self.clockCounter = ClockCounter:create(self.deadTime, 1000, _Count, handler(self.checkGameVectory, self),handler(self.onCountDownPer, self))	
	self.countSecond:addChild(self.clockCounter)
	self.clockCounter:startTimer()
end

function JointPicture:removeCountDownTimer()
   self.clockCounter:stopTimer()
end

function JointPicture:onCountDownPer(t)
	self.count = t
	
	if not self.hasOperate and self.count < _Count - 3 then
		Utils:showTips(2460045)
		self.hasOperate = true
	end

	if self.count == 0 then
		self.touchShield:setVisible(true)
		self:gameOver(true)
	end
end

function JointPicture:gameOver(isShowTips)
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

function JointPicture:removeEvents()
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

return JointPicture


--endregion
