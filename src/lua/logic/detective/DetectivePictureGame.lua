local DetectivePictureGame = class("DetectivePictureGame", BaseLayer)

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

function DetectivePictureGame:ctor(...)
	self.super.ctor(self, ...)
	self.data = ...
	self.curGroup = self.data.group
	self.count = _Count
	self.startingGame = false
	self.tPic ={}
	self:init("lua.uiconfig.activity.detectivePictureGame")
end

function DetectivePictureGame:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = ui:getChildByName("Panel_root")
	self.touchShield = self.Panel_root:getChildByName("touchShield")
	self.touchShield.size = self.touchShield:getSize()
	self.touchShield:setVisible(false)
	self.btn_close = self.Panel_root:getChildByName("btn_close")
	
	self.Button_start = self.Panel_root:getChildByName("Button_start")
	self.Button_left = self.Panel_root:getChildByName("Button_left")
	self.Button_right = self.Panel_root:getChildByName("Button_right")

	self.mask =	self.Panel_root:getChildByName("mask")
	self.mask:setVisible(false)
	
	self.sample = self.Panel_root:getChildByName("sample")

	self.countSecond = self.Panel_root:getChildByName("downcount")
	self.countSecond:setText("")
	self.grids = self.Panel_root:getChildByName("grids")
	self.Label_getway = self.Panel_root:getChildByName("Label_getway")

	for i = 1, 16 do
		local pic = self.grids:getChildByName("grid"..i)
		table.insert(self.tPic, pic)
		pic:setTouchEnabled(true)
		pic.idx = i
		pic:addMEListener(TFWIDGET_CLICK, handler(self.onClickPic,self))
	end
	self.Image_geted = self.Panel_root:getChildByName("Image_geted"):hide()
	self:resetGameData()
end

function DetectivePictureGame:resetGameData(random)
	self.isShowReward = false
	self.hasOperate = false
	self.tTranslatePics = {}
	self.cfg_ = TabDataMgr:getData("DetectiveJigsaw",self.curGroup)
	local unlockIds = DetectiveDataMgr:getUnlockSign()
	if random then
		self.randomIds_ = genRandomPhrase(self.cfg_["formulation"])
	else
		self.randomIds_ = self.cfg_["formulation"]
	end
	
	self.image_path = {}
	self.getWayTips = {}
	self.Button_start:setTouchEnabled(true)
	self.Button_start:setGrayEnabled(false)
	self.Image_geted:hide()
	for i,v in ipairs(self.cfg_["condition"]) do
		if table.indexOf(unlockIds,v) ~= -1 then
			self.image_path[v] = self.cfg_["picture"][i]
		else
			self.getWayTips[v] = self.cfg_["getWay"][i]
			self.Button_start:setTouchEnabled(false)
			self.Button_start:setGrayEnabled(true)
		end
	end
	self.sample:setTexture(self.cfg_.showPicture)
	self:reloadGridsUI()
	local gameSign = DetectiveDataMgr:getPictureGameSign()
	if table.indexOf(gameSign, self.curGroup) ~= -1 then
		self.Button_start:setTouchEnabled(false)
		self.Button_start:setGrayEnabled(true)
		self.Image_geted:show()
	end
end

function DetectivePictureGame:reloadGridsUI()
	for i,pic in ipairs(self.tPic) do
		local order = self.randomIds_[pic.idx]
		pic.isSelected = false
		pic.originPos = pic:getPosition()
		pic.order = order
		pic:setTexture(self:getImagePath(order))
		pic:setZOrder(Zorder_.Default)
		pic.selected = pic:getChildByName("select")
		pic.selected:setVisible(false)
		if self.getWayTips[order] then
			if not pic.getWay then
				local getTps = self.Label_getway:clone()
				pic:addChild(getTps,5)
				getTps:setPosition(ccp(0,-45))
				getTps:enableOutline(ccc4(56,75,105,170),1)
				pic.getWay = getTps
			end
			pic.getWay:show()
			pic.getWay:setTextById(self.getWayTips[order])
		else
			if pic.getWay then
				pic.getWay:setVisible(false)
			end
		end
		if self.data.firstGet and self.image_path[order] then
			self.data.firstGet = false
			local Spine_pintu = SkeletonAnimation:create("effect/ZT_pintu/ZT_pintu")
		    pic:addChild(Spine_pintu,10)
		    Spine_pintu:playByIndex(0,-1,-1,0)
		    Spine_pintu:setPosition(ccp(0,0))
		end
	end
end

function DetectivePictureGame:getImagePath(order)
	if self.image_path[order] then
		local path = "ui/activity/detective/picture/group"..self.curGroup.."/"..self.image_path[order]..".png"
		return path
	end
	return "ui/activity/detective/picture/03.png"
end

function DetectivePictureGame:onClickPic(sender)
	if not self.startingGame then
		return
	end
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

function DetectivePictureGame:runTranslate()
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

function DetectivePictureGame:translateInvalid()
	local idx1 = self.tTranslatePics[1].idx - 1
	local idx2 = self.tTranslatePics[2].idx - 1
	return (idx1 % 4 == idx2 % 4 and math.abs(idx1 - idx2) == 4) or (math.floor(idx1 / 4) == math.floor(idx2 / 4) and math.abs(idx1 - idx2) == 1)
end


function DetectivePictureGame:resetSelect()
	self.tTranslatePics[1].selected:setVisible(false)
	self.tTranslatePics[1].isSelected= false
	self.tTranslatePics[1]:setZOrder(Zorder_.Default)

	self.tTranslatePics[2].selected:setVisible(false)
	self.tTranslatePics[2].isSelected= false
	self.tTranslatePics[2]:setZOrder(Zorder_.Default)
	
	self.tTranslatePics = {}
	self.touchShield:setVisible(false)
end

function DetectivePictureGame:checkVectory()
	local success = true
	local formulation = self.cfg_["formulation"]
	for i,v in ipairs(self.tPic) do
		if formulation[v.idx] and v.order ~= formulation[v.idx] then
			success = false
			break
		end
	end
	if success then
		self:gameVectory()
	end
end

function DetectivePictureGame:gameVectory()
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
			local orderIds = self.cfg_["formulation"]
			DetectiveDataMgr:Req_DetectiveGameFinish(orderIds,self.curGroup)
		end
     end)
	self.touchShield:setVisible(true)
	TFAudio.playSound("sound/dating_sound/dating_285.mp3")
	self:removeCountDownTimer()
end

function DetectivePictureGame:addCountDownTimer()
	self:removeCountDownTimer()
	local ClockCounter = requireNew("lua.logic.common.ClockCounter")
	self.clockCounter = ClockCounter:create(self.deadTime, 1000, _Count, handler(self.checkVectory, self),handler(self.onCountDownPer, self))	
	self.countSecond:addChild(self.clockCounter)
	
end

function DetectivePictureGame:removeCountDownTimer()
	if self.clockCounter then
   		self.clockCounter:stopTimer()
   	end
	self.countSecond:removeAllChildren()
	self.clockCounter = nil
	self.countSecond:hide()
end

function DetectivePictureGame:onCountDownPer(t)
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

function DetectivePictureGame:startGame()
	self.deadTime = _Count + ServerDataMgr:getServerTime()
	self:resetGameData(true)
	self:addCountDownTimer()
	self.startingGame = true
	self.countSecond:show()
	self.clockCounter:startTimer()
	self.Button_left:hide()
	self.Button_right:hide()
	self.Button_start:setTouchEnabled(false)
	self.Button_start:setGrayEnabled(true)
end


function DetectivePictureGame:gameOver(isShowTips)
	self.startingGame = false
	self:removeCountDownTimer()	
	local func =function()
		self:resetGameData()
		self.Button_left:show()
		self.Button_right:show()
		self.Button_start:setTouchEnabled(true)
		self.Button_start:setGrayEnabled(false)
	end
	if isShowTips then
		Utils:showTips(TextDataMgr:getText(190000378))
		self:runAction(Sequence:createWithTwoActions(DelayTime:create(2), CallFunc:create(func)))
	else
		--TODO CLOSE 暂时不让结束时关闭此界面
		--AlertManager:closeLayer(self)
	end
end

function DetectivePictureGame:onFinish()
	self:gameOver()
end

function DetectivePictureGame:registerEvents()
	EventMgr:addEventListener(self, EV_DETECTIVE.DETECTIVE_PICTURE_GAME_FILISH, handler(self.onFinish, self))

	self.btn_close:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self.Button_start:onClick(function()
		self:startGame()
	end)
	self.Button_left:onClick(function()
		if self.curGroup == 1 then
			self.curGroup = 2
		else
			self.curGroup = 1
		end
		self:resetGameData()
	end)

	self.Button_right:onClick(function()
		if self.curGroup == 1 then
			self.curGroup = 2
		else
			self.curGroup = 1
		end
		self:resetGameData()
	end)
end

function DetectivePictureGame:removeEvents()
    self.super.removeEvents(self)
    self:removeCountDownTimer()
end

return DetectivePictureGame