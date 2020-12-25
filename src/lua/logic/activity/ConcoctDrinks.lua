--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local ClockCounter = requireNew("lua.logic.common.ClockCounter")

local ConcoctDrinks = class("ConcoctDrinks", BaseLayer)

local _Count = TabDataMgr:getData("DiscreteData", 90014).data["time"]
local _Config = TabDataMgr:getData("MJziyuan")
local AllDrinksCfg = TabDataMgr:getData("MJfenzu")

local GameType = EC_NewYearGameType.Drink
local AllDrinks = {}
local DrinkMoveTime = 0.7
local CountDialogInternal = 0

local ShowType = {remind = 1, need = 2}

local function containValue(t, val)
	for k, v in pairs(t) do
		if v == val then
			return k
		end
	end
	return nil
end


local function getAllDrinkCfg()
	AllDrinks = {}
	for r,drink in pairs(AllDrinksCfg) do
		if drink["gametype"] == 3 then
			table.insert(AllDrinks, drink)
		end
	end
end

function ConcoctDrinks:genRandomMaterial(tab)
	local ret = {}
	local temp = {}
	for k, val in pairs(tab) do
		local cfg = _Config[val]		
		table.insert(temp, cfg)
		local cfgOther =  _Config[cfg["collocation"]]
		table.insert(temp, cfgOther)
	end
	for i = 0, 3 do
		table.insert(ret, temp[2 * i + math.random(1, 2)].id)
	end

	return ret
end

function ConcoctDrinks:ctor(...)
	self.super.ctor(self, ...)

	self.data = ... --or {group = 1, result = {3001,3002,3004,3005}}
	self.result = {}

	self.deadTime = _Count + ServerDataMgr:getServerTime()
	self.count = _Count
	self.spineOver = false

	self.frontMaterial = {}
	self.backMaterial = {}
	self.operateDrinks = {}
	self.selectedDishes = {}
	self.topBarFileName = "NewYearMiniGame" 

	self.drinkConfig = TabDataMgr:getData("MJfenzu", self.data.group)

	self.MaterialIds = self:genRandomMaterial(self.drinkConfig["formulation"])


	self.npcData = TabDataMgr:getData("DiscreteData",90012).data

	getAllDrinkCfg()
	
	self.showType = ShowType.remind

	EventMgr:addEventListener(self, EV_NEW_YEAR_GAME_FINISH, handler(self.onFinish, self))
	self:init("lua.uiconfig.activity.concoctDrinks")	
end

function ConcoctDrinks:getErrorConfig(ids)
	local tab = {}
	for i = 1, #ids do
		local config = _Config[ids[i]]
		table.insert(tab, config)
	end
	return tab
end

function ConcoctDrinks:onFinish(data)
	if GameType == data.game then
		self.resultData = data
		self:runAction(Sequence:create({DelayTime:create(2.5), CallFunc:create(function()
--			ActivityDataMgr2:showGameResult(data)
--			self:gameOver()
		end)}))
	end
end

function ConcoctDrinks:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root = ui:getChildByName("Panel_root")

	self.touchShield = self.Panel_root:getChildByName("touchShield")
	self.touchShield.size = self.touchShield:getSize()
	self.touchShield:setVisible(false)
	self.npcParent = self.Panel_root:getChildByName("npc")

	self.btn_close = self.Panel_root:getChildByName("btn_close")
	self.btn_close:setVisible(false)
	self.btn_close:onClick(function()
		self:gameOver()
	end)
	self.countSecond = self.Panel_root:getChildByName("downcount")
	self.countSecond:setText("")

	self.clock = self.Panel_root:getChildByName("clock")
	self.clock:onClick(handler(self.checkGameVectory, self))

	self.dialog = self.Panel_root:getChildByName("dialog")
	self.dialog.rtext = self.dialog:getChildByName("text")
	self.dialog:setVisible(false)

	self.cupDrink = self.Panel_root:getChildByName("cupDrink")
	self.cupDrinkFull = self.Panel_root:getChildByName("cupDrinkFull")
	self.cupDrinkFull:setVisible(false)
	self.cupDrinkFull.moveDest = self.Panel_root:getChildByName("origin"):getPosition()
	self.cupDrinkFull.name = self.cupDrinkFull:getChildByName("FullDrinkName")
	self.cupDrinkFull.name.label = self.cupDrinkFull.name:getChildByName("label")
	self.cupDrinkFull.name.label:setText("")


	self.targetDrink = self.Panel_root:getChildByName("targetBg")
	self.targetDrink.content = self.targetDrink:getChildByName("targetDrink")
	self.targetDrink.content:setTexture(self.drinkConfig["picture"])
	self.targetDrink.content:setSize(ccs(80,80))
	self.targetDrink:setOpacity(0)
	self.targetDrink.name = self.targetDrink:getChildByName("targetDrinkName")
	self.targetDrink.name:setText(self.drinkConfig["name"])

	self.exchangeArrow = self.Panel_root:getChildByName("exchange_image")
	self.exchangeArrow:setVisible(true)
	self.effect_show = self.Panel_root:getChildByName("effect_show")
	self.effect_show:setVisible(true)

	self.arrow_yellow = self.Panel_root:getChildByName("arrow_yellow")
	self.arrow_yellow:setVisible(true)
	self.arrow_yellow:runAction(RepeatForever:create(Sequence:create({MoveBy:create(0.5,ccp(0,-30)), MoveBy:create(0.5,ccp(0,30))})))

	self.arrow_yellow_clock = self.Panel_root:getChildByName("arrow_yellow_clock")
	self.arrow_yellow_clock:setVisible(false)
	self.arrow_yellow_clock:runAction(RepeatForever:create(Sequence:create({MoveBy:create(0.5,ccp(0,-30)), MoveBy:create(0.5,ccp(0,30))})))
	self.arrow_yellow_clock.show = false

	self.drinkMask = self.Panel_root:getChildByName("drinks_mask")
	self.drinkMask:setVisible(false)


	self:initMaterial(ui)

	self:createNpc()

	self:addCountDownTimer()

	self:refreshView()
end

function ConcoctDrinks:initMaterial()
	local materials = self.Panel_root:getChildByName("materials")
	for i = 1, 4 do
		local frontMaterial = materials:getChildByName("material"..i)
		frontMaterial.labelID = frontMaterial:getChildByName("id")
		frontMaterial.labelID:setColor(ccRED)
		frontMaterial.labelID:setVisible(false)
		frontMaterial:setZOrder(1)
		table.insert(self.frontMaterial, frontMaterial)

		local tempSelect = {}
		tempSelect["dish"] = materials:getChildByName("select"..i)
		tempSelect["dish"]:setVisible(false)
		tempSelect["effect"] = materials:getChildByName("effect_dish"..i)
		tempSelect["effect"]:setVisible(false)
		tempSelect["effect"]:setZOrder(5)		
		table.insert(self.selectedDishes, tempSelect)	

		local backMaterial = materials:getChildByName("material"..(i + 100))
		backMaterial.labelID = backMaterial:getChildByName("id")
		backMaterial.labelID:setColor(ccRED)
		backMaterial.labelID:setVisible(false)
		backMaterial:setZOrder(10)
		table.insert(self.backMaterial, backMaterial)			
	end	
end

function ConcoctDrinks:createNpc()	
	self.elvesNpc_ = ElvesNpcTable:createLive2dNpcID(self.npcData.level2d, false, false, nil).live2d
	self.npcParent:addChild(self.elvesNpc_)
	self:playNpcExpression(self.npcData["sayhello"])
	self:showDialog(true,"r306003",self.drinkConfig.name)
	self.targetDrink:runAction(FadeIn:create(0.5))
end

function ConcoctDrinks:playNpcExpression(acName,loop,internal)	
	if loop then
		self.elvesNpc_:newStartAction(acName,EC_PRIORITY.FORCE)
		self.elvesNpc_:newStartPlayLoopAction(internal, acName)
	else
		self.elvesNpc_:newStartAction(acName,EC_PRIORITY.FORCE)
	end
end

function ConcoctDrinks:refreshView()

	
	for i = 1, 4 do
		local frontMaterial = self.frontMaterial[i]
		local frontConfig = _Config[self.MaterialIds[i]]
		frontMaterial:setTexture(frontConfig["res"])
		frontMaterial.idx = i
		frontMaterial.id = frontConfig["id"]		
		frontMaterial.config = frontConfig
		frontMaterial.labelID:setText(frontConfig["id"])
		frontMaterial:setTouchEnabled(true)
		frontMaterial:addMEListener(TFWIDGET_CLICK, handler(self.onClickMaterial, self))
		frontMaterial.OriginY = frontMaterial:getPositionY()

		local backMaterial = self.backMaterial[i]
		local backConfig = _Config[frontConfig["collocation"]]
		backMaterial:setTexture(backConfig["res"])
		backMaterial.idx = i
		backMaterial.id = backConfig["id"]		
		backMaterial.config = backConfig	
		backMaterial.labelID:setText(backConfig["id"])
		backMaterial:setTouchEnabled(true)
		backMaterial:addMEListener(TFWIDGET_CLICK, handler(self.onClickMaterial, self))
		backMaterial.OriginY = backMaterial:getPositionY()
		backMaterial:setColor(me.c3b(162, 170, 194))

		frontMaterial.pair = backMaterial	
		backMaterial.pair = frontMaterial	


		self:setMaterialScale(i)
	end

	Utils:showTips(2460096)
end

function ConcoctDrinks:setMaterialScale(idx)
	self.frontMaterial[idx]:setPositionY(self.frontMaterial[idx].OriginY)
	self.frontMaterial[idx]:runAction(RepeatForever:create(
			Sequence:create({MoveBy:create(0.8, ccp(0,10)), 
							 MoveBy:create(0.8, ccp(0,-10))})))
	self.frontMaterial[idx]:setScale(1.4)

	self.backMaterial[idx]:stopAllActions()
	self.backMaterial[idx]:setScale(1)
end

function ConcoctDrinks:onClickMaterial(sender)
	if self.count <= 0 then
		self.touchShield:setVisible(true)
		return
	end

	--交换位置
	local selfPos = sender:getPosition()
	local pairPos = sender.pair:getPosition()
	sender:setPosition(pairPos)
	sender.pair:setPosition(selfPos)

	--交换后更新前后的table
	local idx = sender.idx
	local material = self.frontMaterial[idx]
	self.frontMaterial[idx] = self.backMaterial[idx]	
	self.backMaterial[idx] = material	
	self.frontMaterial[idx].OriginY = self.backMaterial[idx].OriginY
	self.backMaterial[idx].OriginY = material.OriginY
	self.frontMaterial[idx]:setZOrder(1)
	self.backMaterial[idx]:setZOrder(1)

	self:setMaterialScale(idx)

	--停止sayhello 44 56 88
	self.elvesNpc_:stopPlayLoopAction()

	--self:remindTouchClocker(idx)
	for i = 1, #self.selectedDishes do
		self.selectedDishes[i]["dish"]:setVisible(i==idx)
		self.selectedDishes[i]["effect"]:setVisible(i==idx)
	end
	for i = 1, 4 do
----		if i ~= idx then
------			self.frontMaterial[i]:setColor(me.c3b(162, 170, 194))
----			self.backMaterial[i]:setColor(me.c3b(162, 170, 194))
------			self.frontMaterial[i]:setOpacity(255*0.27)
------			self.backMaterial[i]:setOpacity(255*0.27)
----		else
------			self.frontMaterial[i]:setColor(ccWHITE)
----			self.backMaterial[i]:setColor(ccWHITE)
------			self.frontMaterial[i]:setOpacity(255)
------			self.backMaterial[i]:setOpacity(255)
----		end
		self.backMaterial[i]:setColor(me.c3b(162, 170, 194))
		self.frontMaterial[i]:setColor(ccWHITE)
	end

	self:onOperate()
end

function ConcoctDrinks:onOperate()
		--隐藏对话
	self:showDialog(false)
	self.exchangeArrow:setVisible(false)
	self.effect_show:setVisible(false)
	self.arrow_yellow:setVisible(false)
	self:showClockArrow(false)

	self.arrow_yellow_clock.show = true
	CountDialogInternal = 0	
end

function ConcoctDrinks:showClockArrow(Show)
	if self.arrow_yellow_clock.show then
		self.arrow_yellow_clock:setVisible(Show)
	end
end

--检测是否胜利:条件:前排的原料能在配方里找到
function ConcoctDrinks:checkGameVectory()
	print("检测是否胜利")
	self:onOperate()
	self.result = {}
	for k, val in pairs(self.frontMaterial) do
		table.insert(self.result, val.config["id"])
	end	
	
	local curGroup ;
	for r,drink in pairs(AllDrinks) do
		local vecotry = true
		for k, val in pairs(self.result) do
			if table.indexOf(drink.formulation, val) == -1 then
				vecotry = false
				break;
			end
		end
		if vecotry then
			self:gameVectory(drink)
			return;		
		end
	end

	self:playNpcExpression(self.npcData["faild"])
	if self.count > 0 then
		self:showDialog(true, "r306007")
	else
		self:gameOver(true)
	end

end

function ConcoctDrinks:gameVectory(drink)
	self:playNpcExpression(self.npcData["success"])

	self.cupDrinkFull.name.label:setText(drink["name"])

	--禁止触摸 结束计时
	self.touchShield:setVisible(true)
	self.cupDrink:setVisible(false)
	self.drinkMask:setVisible(true)

	self.cupDrinkFull:setTexture(drink["picture"])
	
	self:removeClock()

	local spineSuccess = SkeletonAnimation:create("effect/MJyinliaohecheng/MJyinliaohecheng")
	spineSuccess:setPosition(ccp(self.touchShield.size.width / 2, self.touchShield.size.height / 2))   
	self.touchShield:addChild(spineSuccess, 10)
	spineSuccess:addMEListener(TFARMATURE_COMPLETE,function(spine,animationName)
		self.cupDrinkFull:setVisible(true)
		self.cupDrinkFull:setOpacity(0)
		self.cupDrinkFull:runAction(Sequence:create({
			FadeIn:create(0.3),
			DelayTime:create(1.5), 
			CallFunc:create(function()
				self.cupDrinkFull.name:setVisible(false)
			end), 
			Spawn:create({MoveTo:create(DrinkMoveTime, self.cupDrinkFull.moveDest), ScaleTo:create(DrinkMoveTime, 0.7)}),
			CallFunc:create(function()
				self.drinkMask:setVisible(false)
			end),
			DelayTime:create(1), 
			CallFunc:create(function()
				if self.resultData then
					ActivityDataMgr2:showGameResult(self.resultData)
				end
				self:gameOver()
			end)}))
		--self:runAction(Sequence:create({DelayTime:create(3.5),CallFunc:create(function()self:gameOver()end)}))
	end)

	for k,val in pairs(self.frontMaterial) do
		val:runAction(Sequence:create({MoveTo:create(0.4, spineSuccess:getPosition()), 
			CallFunc:create(function()
				val:setVisible(false)
				if k == #self.frontMaterial then
					spineSuccess:play("animation", false)  
				end
		end)}))
	end

	local formulation = drink.formulation
	local correctDrink = true
	for i = 1, #self.data.result do
		if formulation[i] ~= self.data.result[i] then
			correctDrink = false
			break;
		end	
	end
	if correctDrink then
		self:showDialog(true, "r306004")
	else
		self:showDialog(true, "r306005")
	end

	for i = 1, #self.selectedDishes do
		self.selectedDishes[i]["dish"]:setVisible(false)
		self.selectedDishes[i]["effect"]:setVisible(false)
	end

	ActivityDataMgr2:Req2020FestivalGameFinish(self.data.group, self.result)
end

function ConcoctDrinks:addCountDownTimer()
	self.clockCounter = ClockCounter:create(self.deadTime, 1000, _Count, handler(self.checkGameVectory, self),handler(self.onCountDownPer, self))	
	self.countSecond:addChild(self.clockCounter)
	self.clockCounter:startTimer()

end

function ConcoctDrinks:onCountDownPer(t)
	self.count = t	
	if self.count == 0 then
		self.touchShield:setVisible(true)
	end

	if CountDialogInternal > 4 then
--		if self.showType == ShowType.need then
--			self:showDialog(true,"r306003",self.drinkConfig.name)
--			self:playNpcExpression(self.npcData["sayhello"], false, 5000)
--			self.showType = ShowType.remind
--			self:showClockArrow(false)
--		else
			if self.arrow_yellow_clock.show then
				self:showDialog(true, "r306008")
				self:playNpcExpression(self.npcData["sayhello"], false, 5000)
				self.showType = ShowType.need
				self:showClockArrow(true)
			end
--		end
		CountDialogInternal = 0
	end
	if self.arrow_yellow_clock.show then
		CountDialogInternal = CountDialogInternal + 1
	end
end

function ConcoctDrinks:gameOver(directClose)
	self:removeClock()
	local func =function()
		AlertManager:closeLayer(self)
	end
	if directClose then
		self:showDialog(true, "r306006")
		self:runAction(CCSequence:create({CCDelayTime:create(2.5), CallFunc:create(func)}))
	else
		func()
	end
	
end

function ConcoctDrinks:showDialog(bool, strID,content)
	self.dialog:setVisible(bool)
	if bool then
		 -- 富文本模拟配置
		self.dialog:stopAllActions()
 		self.dialog.rtext:setTextById(strID, content)
		self.dialog:setScale(0.1)
		self.dialog:runAction(CCScaleTo:create(0.1,1))
	end
end

function ConcoctDrinks:removeEvents()
    self.super.removeEvents(self)
	self:removeClock()
end

function ConcoctDrinks:removeClock()
	 if self.clockCounter then
    	self.clockCounter:stopTimer()
		self.clockCounter = nil
    end
end


function ConcoctDrinks:remindTouchClocker(idx)
	if not containValue(self.operateDrinks, idx) then
		table.insert(self.operateDrinks, idx)
	end
	local ret = true
	for i = 1, 4 do
		if table.indexOf(self.operateDrinks, i) == -1 then
			ret = false
			break;
		end
	end
	if ret then
		self:showDialog(true, "r306008")
		self:playNpcExpression(self.npcData["sayhello"], true, 5000)
	end
end

return ConcoctDrinks


--endregion
