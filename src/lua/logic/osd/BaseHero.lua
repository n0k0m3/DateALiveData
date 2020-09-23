--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 同屏基础角色类
* 
]]
local OSDEnum    = import(".OSDEnum")
local StateEvent = OSDEnum.StateEvent
local HeroState  = OSDEnum.HeroState
local HeroType   = OSDEnum.HeroType
local MapUtils     = import(".MapUtils")
local ResLoader    = require("lua.logic.battle.ResLoader")
local BattleConfig = require("lua.logic.battle.BattleConfig")
local StateMachine = require("lua.logic.battle.StateMachine")
local enum = require("lua.logic.battle.enum")
local eAnimation = enum.eAnimation
local eDir = enum.eDir
local OSDControl = import(".OSDControl")
local events ={
	{name = StateEvent.FSM_BORN, from = {HeroState.OSD_STAND}, to = HeroState.OSD_BORN},
	{name = StateEvent.FSM_STAND, from = {StateMachine.WILDCARD}, to = HeroState.OSD_STAND},
	{name = StateEvent.FSM_MOVE, from = {HeroState.OSD_BORN, HeroState.OSD_STAND, HeroState.OSD_MOVE}, to = HeroState.OSD_MOVE},
}


-- local roleResList = 
-- {
-- 	["fight_10101"]=true,
-- 	["fight_10102"]=true,
-- 	["fight_10104"]=true,
-- 	["fight_10108"]=true,
-- 	["fight_10103"]=true,
-- 	["fight_10103"]=true,
-- 	["fight_10111"]=true,
-- 	["fight_10201"]=true,
-- 	["fight_10207"]=true,
-- 	["fight_10208"]=true,
-- 	["fight_10301"]=true,
-- 	["fight_10305"]=true,
-- 	["fight_10302"]=true,
-- 	["fight_10401"]=true,
-- 	["fight_10403"]=true,
-- 	["fight_10406"]=true,
-- 	["fight_10501"]=true,
-- 	["fight_10501"]=true,
-- 	["fight_10506"]=true,
-- 	["fight_10506"]=true,
-- 	["fight_10601"]=true,
-- 	["fight_10602"]=true,
-- 	["fight_10603"]=true,
-- 	["fight_10701"]=true,
-- 	["fight_10707"]=true,
-- 	["fight_10801"]=true,
-- 	["fight_10807"]=true,
-- 	["fight_10901"]=true,
-- 	["fight_11001"]=true,
-- 	["fight_11005"]=true,
-- 	["fight_11201"]=true,
-- 	["fight_11301_1"]=true,
-- 	["fight_11301_2"]=true,
-- }
local BaseHero = class("BaseHero", function()
	local node = CCNode:create()
	return node
end)

function BaseHero:ctor(data)
	self.data = data
	--事件触发区域
	self.areaRect   = me.rect(0,0,300, 80)
	--点击响应区域]
	self.touchRect  = me.rect(0,0,150, 220)
	self.position3D = me.Vertex3F(0, 0, 0)
	--寻路路径
	self.autoPathList = {}
	--摇杆向量
	self.rokeVector = ccp(0, 0)

	self.speedScale = 1
	--移动状[态
	self.moveState = -1

	self.autoMove = false


	self.groundNode = CCNode:create()
	self:addChild(self.groundNode)

	self.infoNode = CCNode:create()
	self.infoNode:setPosition(0,200)
	self.infoNode:setZOrder(2)
	self:addChild(self.infoNode)

	self:createInfoUI()
	self:createSkeletonNode(self.data.model, self.data.scale)
	self:createTouchPanel()
	self:createShadow()
	self:createFSM()
	self:setDir(self.data.dir)

	--设置在出生点
	local bornPos = self.data.pos
	if not self:canMove(bornPos) then
		bornPos = MapUtils:getMapParse():getBornPos(1)
	end
	self:setPosition3D(bornPos.x, bornPos.y, bornPos.y)

	self:doEvent(StateEvent.FSM_BORN)

	-- self:debugNode()

	if data.heroType == HeroType.OtherHero then 
		print("创建其他玩家")
	end
end 

--npc 功能类型
function BaseHero:getFuncType()  
	return self.data.funcType or 0
end

-- --被选中的时的特效
-- function BaseHero:createFocusEffect()   
-- 	if self.data.heroType == HeroType.NPC then 
-- 		if not self.focusEffect then 
-- 			local resource = "effects_extra_common"
-- 			local action   = "effects_extra_common"
-- 			self.focusEffect = ResLoader.createRole(resource,0.3)
-- 			self.focusEffect:play(action, 1)
-- 			self.groundNode:addChild(self.focusEffect)
-- 			self.focusEffect:setCameraMask(self.groundNode:getCameraMask())
-- 		end
-- 	end
-- end

--当前是否被选中
function BaseHero:isFocus()
	return OSDControl:getFocus() == self
end

-- function BaseHero:checkFocus()
-- 	if self.data.heroType == HeroType.NPC then
-- 		if self:isFocus() then
-- 			self.focusEffect:hide() -- 策划需求，处于NPC范围内时，取消脚下的光圈显示
-- 		else
-- 			self.focusEffect:hide()
-- 		end
-- 	end
-- end



function BaseHero:ready()
	if not self.bRead then 
		-- self:createFocusEffect()
		self.bRead = true
	end
end

--创建状态机
function BaseHero:createFSM()
	self.stateMachine = StateMachine:instace()
	local cfg = {}
	cfg.events = events
	cfg.callbacks = {
		onleavestate = handler(self.onLeaveState, self),
		onafterevent = handler(self.onEnterState, self),
	}
	cfg.initial = {
		event = StateEvent.FSM_STAND,
		state = HeroState.OSD_STAND,
	}
	self.stateMachine:setupState(cfg)
end

function BaseHero:onLeaveState(event)
	local from = event.from
	local to = event.to
	if from  == HeroState.OSD_MOVE then
		-- self:stopAllActions()
		self:cleanAotuPath()
	end
	self:setTimeScale(1)
end

function BaseHero:onEnterState(event)
	local args = unpack(event.args)
	local fromState = event.from
	local toState = event.to

	if toState == HeroState.OSD_BORN then
		self:playBorn()
	elseif toState == HeroState.OSD_STAND then
		self:playStand()
	elseif toState == HeroState.OSD_MOVE then
		self:onMove(args)
	else
		printBeck("暂时不支持此状态")
	end
end

function BaseHero:doEvent(eventName, ...)
	local canDo = self.stateMachine:canDoEvent(eventName)
	if canDo then
		self.stateMachine:doEvent(eventName, ...)
	else
		printBeck("can not doEvent ".. tostring(eventName) .. " in current state " .. self:getState())
	end
	return canDo
end

function BaseHero:doEventForce(eventName, ...)
	self.stateMachine:doEventForce(eventName, ...)
end

function BaseHero:canDoEvent(eventName)
	local canDo = self.stateMachine:canDoEvent(eventName)
	return canDo
end

function BaseHero:getState()
	return self.stateMachine:getState()
end

function BaseHero:createSkeletonNode(model, scale)
	scale = scale or 1
	self:releaseSkeletonNode()
	local heroType = self.data.heroType
	if heroType == HeroType.NPC then 
		self.skeletonNode = ResLoader.createRole(model, scale)
		self.skeletonNode:setScheduleUpdateWhenEnter(false)
		self:addChild(self.skeletonNode)
		self.skeletonNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmtureEvent, self))
		self.skeletonNode:setCameraMask(self:getCameraMask())
	else	
		self.skeletonNode = ResLoader.createRoleEx(model, scale)
		if self.skeletonNode then 
			self.skeletonNode:setScheduleUpdateWhenEnter(false)
			self:addChild(self.skeletonNode)
			self.skeletonNode:addMEListener(TFARMATURE_EVENT, handler(self.onArmtureEvent, self))
			self.skeletonNode:setCameraMask(self:getCameraMask())
		else
			self.imageNode = TFImage:create()
			self.imageNode:setTexture("ui/battle/role.png")
			self.imageNode:setCameraMask(self:getCameraMask())
			self.imageNode:setAnchorPoint(ccp(0.5,0))
			self:addChild(self.imageNode)
		end
	end
	--更新位置
	local pos = OSDDataMgr:getModelPos(model)
	self.infoNode:setPosition(pos)
	self.animation = nil
	self.touchRect  = me.rect(0, 0 , 150, pos.y + 95 )
	if self.imageNode then
		local size = self.imageNode:getSize()
		self.infoNode:setPosition(ccp(0,size.height + 5))
	end
end

--创建角色相关的信息UI
function BaseHero:createInfoUI()


	local prefabe = createUIByLuaNew("lua.uiconfig.osd.Prefabe")

	local node 
	if self.data.heroType == HeroType.NPC then 
		local prefabNpc = TFDirector:getChildByPath(prefabe, "Image_npc")
		node = prefabNpc:clone()
		self.textName  = node:getChildByName("Label_name")
		self.npc_type  = node:getChildByName("npc_type")
		if self.data.headIcon then
			self.npc_type:show()
			self.npc_type:setTexture(self.data.headIcon)
		else
			self.npc_type:hide()
		end
	else
		local prefabPlayer    = TFDirector:getChildByPath(prefabe, "Image_player")
		node     = prefabPlayer:clone()
		self.textName  = node:getChildByName("Label_name")
		self.Label_gonghui = TFDirector:getChildByPath(node, "Label_gonghui")
		self.image_bubble = TFDirector:getChildByPath(node, "Image_bubble")
		self.label_bubble = TFDirector:getChildByPath(node, "Label_bubble")
		self.panel_title = TFDirector:getChildByPath(node, "panel_title")
		self.image_bubble:hide()
		local selfName = node:getChildByName("Label_selfname"):hide()
		if self.data.heroType == HeroType.MainHero then
			self.textName:hide()
			self.textName = selfName
			self.textName:show()
		end
	end
	node:setPosition(ccp(0,0))

	self.infoNode:addChild(node)
	self:refresName()
end

--聊天气泡显示
function BaseHero:playTalk(content)

	if self.image_bubble then 
	    self.label_bubble:setText(content)
	    self.image_bubble:stopAllActions()
	    self.image_bubble:setScale(0.2)
	    self.image_bubble:show()
	    local actions = 
	    {   
	        ScaleTo:create(0.2,1),
	        DelayTime:create(2),
	        ScaleTo:create(0.2,0.1),
	        Hide:create()
	    }
	    self.image_bubble:runAction(Sequence:create(actions))
	end
end

function BaseHero:createTouchPanel()
	if self.data.heroType == HeroType.NPC then 
		if not self.touchPanel then 
			self.touchPanel = TFPanel:create()
			self.touchPanel:setTouchEnabled(true)
			self.touchPanel:setAnchorPoint(ccp(0.5, 0))
			self.touchPanel:setSize(self.touchRect.size)
			self.touchPanel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
			self.touchPanel:setBackGroundColor(me.c3b(0, 0, 0))
			self.touchPanel:setOpacity(0)
			self.touchPanel:OnClick(handler(self.onClickHero, self))
			self:addChild(self.touchPanel)
		end
	end
end

function BaseHero:onClickHero(sender)
	if self:isFocus() then 
		OSDControl:doFunc(self:getFuncType())
	end
end

function BaseHero:createShadow()
	--创建影子
	if self.data.allowShadow then 
		if not self.shadow then  
			self.shadow = TFImage:create("ui/battle/shadow.png")
			self.groundNode:addChild(self.shadow)
		end 
	end
end



function BaseHero:onMove(arg)
	self.moveState = arg
	self:playMove()
end

--出生效果
function BaseHero:playBorn()
	local function onCallBack()
		self:doEvent(StateEvent.FSM_STAND)
	end

	if self.data and self.data.bornEffect then
		local bornEffect = "born"
		local bornAction = "born_up"
		self:playEffect(bornEffect, nil, bornAction, onCallBack)
		self:playStand()
	else
		onCallBack()
	end
end

--待机
function BaseHero:playStand()
	if self.animation ~= eAnimation.STAND then  
		self:playAni(eAnimation.STAND, true)
	end
end

--移动动作
function BaseHero:playMove()
	if self.animation ~= eAnimation.MOVE then
		self:playAni(eAnimation.MOVE, true)
	end
end

function BaseHero:setRokeVector(vx, vy)
	self:setAutoMove(false)
	self.rokeVector.x = vx
	self.rokeVector.y = vy
end

function BaseHero:getRokeVector()
	return self.rokeVector
end


function BaseHero:getRealAction(action)
	if self.data.actionIndex > 0 then 
		local actionNames = BattleDataMgr:getActionNames(self.data.model)
		if actionNames then
			local data = actionNames[self.data.actionIndex][action]
			if data then 
				return data.realAction
			end
		end
	end
	return action
end


function BaseHero:playAni(action, loop, completeCallback)
	if not self.skeletonNode then return end
	self.animation = action --记录程序定义动作名称
	local realAction = self:getRealAction(action)
	loop = not (not loop)
	local l = loop and 1 or 0
	self.skeletonNode:play(realAction, l)
	if completeCallback and l == 0 then
		self.skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(skeletonNode)
			skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
			completeCallback(skeletonNode)
		end)
	else
		self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
	end
end

--播放特效
function BaseHero:playEffect(effectName, effectScale, actionName, callFunc)
	local resPath = string.format("effect/%s/%s", effectName, effectName)
	local skeletonNode = ResLoader.createSpine(resPath, effectScale)
	if actionName then
		skeletonNode:play(actionName, 0)
	else
		skeletonNode:playByIndex(0, 0)
	end
	skeletonNode:addMEListener(TFARMATURE_COMPLETE, function(_skeletonNode)
		if callFunc then
			callFunc(_skeletonNode)
		end
		_skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		_skeletonNode:removeFromParent()
	end)
	skeletonNode:setCameraMask(self:getCameraMask())
	MapUtils:setSkeletonNodeDir(skeletonNode, self:getDir())
	self:addChild(skeletonNode, 2)
	return skeletonNode
end

function BaseHero:update(dt)
	self:ready()
	-- self:checkFocus()
	self:updateSkeletonNode(dt)	
	self:updateHeroNode(dt)

	if #self.autoPathList > 0 then
		self:pathMove(dt)
	end

	if self:isMainHero() and not self.autoMove then
		--手动控制的角色
		self:handleMove(dt)
	end
end

function BaseHero:updateHeroNode(dt)
	if self:isVisible() then 
		local pos = self.position3D
		self.groundNode:setPosition(pos.x, pos.y)
		-- self.infoNode:setPosition(pos.x, pos.y + 200)
	end 
end

function BaseHero:updateSkeletonNode(dt)
	if self.skeletonNode then  
		self.skeletonNode:update(dt)
	end
end

function BaseHero:move(xv, yv, fix)
	if not self.skeletonNode and not self.imageNode then 
		return 
	end
	local pos = self.position3D
	local nx = pos.x + xv
	local ny = pos.y + yv
	-- _print("xv=",xv,"yv=",yv)
	if self:canMove(nx, ny) then
		pos.x = nx
		pos.y = ny
	elseif self:canMove(nx, pos.y) and xv ~= 0 then
		pos.x = nx
	elseif self:canMove(pos.x, ny) and yv ~= 0 then
		pos.y = ny
	else
		if fix then
			if xv ~= 0 and yv == 0 then
				local mvU = self:canMove(pos.x , pos.y + MapUtils:getMapParse():getBlockSize())
				local mvD = self:canMove(pos.x , pos.y - MapUtils:getMapParse():getBlockSize())
				if mvD and mvU then
					return
				elseif mvD then
					pos.y = pos.y - math.abs(xv)
				elseif mvU then
					pos.y = pos.y + math.abs(xv)
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end
	pos.z = pos.y --逻辑位置和渲染位置相同
	self:setPosition(pos.x, pos.z)
	local moveSpeed = self:getMoveSpeed()
	local flag = moveSpeed * xv
	if flag < 0 then
		self:setDir(eDir.LEFT)
	elseif flag > 0 then
		self:setDir(eDir.RIGHT)
	end
end

function BaseHero:moveTo(pos, callback)
	self:setAutoMove(true)
	self.moveCallBack = callback
	self:findPath(pos)
	if state ~= HeroState.OSD_MOVE then
		self:doEvent(StateEvent.FSM_MOVE)
	end
end

function BaseHero:setAutoMove(value)
	self.autoMove = value
	if self.autoMove == false then
		self:cleanAotuPath()
	end
end

--寻路
function BaseHero:findPath(pos)
	if not self:canMove(pos.x, pos.y) then
		self.autoPathList = {}
		return self.autoPathList
	end
	local heroPos = self:getPosition()
	self.autoPathList = MapUtils:getMapParse():find(heroPos, pos)
	return self.autoPathList
end

--根据寻路路径移动，放在update
function BaseHero:pathMove(dt)
	local speed = self:getUnsignedMoveSpeed()
	local targetPos = self.autoPathList[1]
	local pos  = self:getPosition3D()
	local distance  = me.pGetDistance(targetPos,pos)
	local sub = me.pSub(targetPos, pos)
	local _time = distance / speed
	if _time ~= 0 then
		local xv = sub.x / _time * dt
		local yv = sub.y / _time * dt
		-- _print("xv:",xv ,"yv:",yv,"sub.x:",sub.x,"sub.y:",sub.y ,"_time",_time)
		if math.abs(sub.x) < math.abs(xv) then
			xv = sub.x
		end
		if math.abs(sub.y) < math.abs(yv) then
			yv = sub.y
		end

		self:move(xv, yv)
		pos = self:getPosition3D()
		distance = me.pGetDistance(targetPos, pos)
		if distance < 1 then
			table.remove(self.autoPathList, 1)
			self:setPosition3D(targetPos.x, targetPos.y)
		end
	else
		table.remove(self.autoPathList, 1)
		self:setPosition3D(targetPos.x, targetPos.y)
	end

	if #self.autoPathList <= 0 then
		self:moveToStand()
		if self.moveCallBack then
			self.moveCallBack()
			self.moveCallBack = nil
		end
	end
end

--清空自动寻路列表
function BaseHero:cleanAotuPath()
	self.autoPathList = {}
end

--手动控制下移动处理
function BaseHero:handleMove(dt)
	if not self:checkMoveState() then return end

	local state = self:getState()
	local moveSpeed = self:getUnsignedMoveSpeed()
	moveSpeed = moveSpeed * dt
	local vector = self:getRokeVector()
	local xv = moveSpeed * vector.x
	local yv = moveSpeed * vector.y * BattleConfig.YV_ATTENUATION_RATIO
	if xv ~= 0 or yv ~= 0 then
		self:move(xv, yv, true)
		if state ~= HeroState.OSD_MOVE then
			self:doEvent(StateEvent.FSM_MOVE)
		end
	else
		self:moveToStand()
	end
end

--手动移动切换到站立状态
function BaseHero:moveToStand()
	self:setAutoMove(false)
	if self:getState() == HeroState.OSD_MOVE then
		self:doEvent(StateEvent.FSM_STAND)
	end
end

--手动移动的状态判断
function BaseHero:checkMoveState()
	local state = self:getState()
	if self:isMainHero() then
		if state == HeroState.OSD_STAND or state == HeroState.OSD_MOVE then
			return true
		end
	end

	return false
end

function BaseHero:canMove(x, y)
	return MapUtils:getMapParse():canMoveXY(x, y)
end

function BaseHero:addTo(panel)
	-- Box("ADDTO MAP")
	MapUtils:addChild(panel, self, 2)             --中层
	MapUtils:addChild(panel, self.groundNode, 1)  --最下层
	-- MapUtils:addChild(panel, self.infoNode, 3)    --最上层
end

-- function BaseHero:updateData(heroData)
-- 	local model = self.data.model
-- 	local scale = self.data.scale
-- 	self.data = heroData
-- 	self.textName:setText(self.data.name) --
-- 	if model ~= self.data.model then 
-- 		self:createSkeletonNode(self.data.model ,self.data.scale)
-- 		self:setDir(self.dir or eDir.RIGHT)
-- 		self:doEventForce(StateEvent.FSM_STAND)
-- 		self:playEffect("born", nil, "born_up")
-- 	end
-- 	self.skeletonNode:setScale(self.data.scale)
-- 	self:refresName()
-- end



function BaseHero:changeSkin()
	self:createSkeletonNode(self.data.model ,self.data.scale)
	self:setDir(self.dir or eDir.RIGHT)
	self:doEventForce(StateEvent.FSM_STAND)
	self:playEffect("born", nil, "born_up")
	if self.skeletonNode then
		self.skeletonNode:setScale(self.data.scale)
	end
	self:refresName()
	print("BaseHero change skin")
end

function BaseHero:refresName()

	if self.data.heroType == HeroType.MainHero 
		or self.data.heroType == HeroType.OtherHero then
		local nameStr = "Lv." .. self.data.level .. "  "  .. self.data.name
		self.textName:setText(nameStr)
		if self.Label_gonghui then
			if self.data.unionName and #self.data.unionName > 0 then 
				self.Label_gonghui:show()
				local countryStr = ""
	            if self.data.showCountry then
	                countryStr = " ("..LeagueDataMgr:getClubCountryDataById(self.data.country).Countryabbreviations..")"
	            end
				self.Label_gonghui:setText(string.format("[%s]",self.data.unionName..countryStr))
			else
				self.Label_gonghui:hide()
			end 
		end
		
		if self.panel_title then
			if self.panel_title.effect then
				self.panel_title.effect:removeFromParent()
				self.panel_title.effect = nil
			end
			if self.data.titleId and self.data.titleId > 0 then
				self.panel_title:show()
				local effect = TitleDataMgr:getTitleEffectSkeletonModle(self.data.titleId,3)
				effect:setCameraMask(self:getCameraMask())
				self.panel_title:addChild(effect)
				self.panel_title.effect = effect
			else
				self.panel_title:hide()
			end
		end

		local posY = self.textName:getPositionY() + (1 - self.textName:getAnchorPoint().y) * self.textName:getContentSize().height + 2
		if self.Label_gonghui and self.Label_gonghui:isVisible() then
			self.Label_gonghui:setPositionY(posY + self.Label_gonghui:getAnchorPoint().y * self.Label_gonghui:getContentSize().height)
			posY = self.Label_gonghui:getPositionY() + (1 - self.Label_gonghui:getAnchorPoint().y) * self.Label_gonghui:getContentSize().height + 2
		end

		if self.panel_title and self.panel_title:isVisible() then
			self.panel_title:setPositionY(posY)
		end
	else
		self.textName:setText(self.data.name) --
	end

end




-- function BaseHero:updateSkin(model)
--     local resPath = string.format("effect/%s/%s", model, model)
--     local bornEffect = "born"
--     local bornAction = "born_up"
--     self:playEffect("born", nil, "born_up")
--     self.skeletonNode:setFile(resPath)

--     if self.skeletonNode:getScale() ~= self.data.scale then
--         self.skeletonNode:setScale(self.data.scale)
--     end


--     self:createSkeletonNode(model, scale)

--     self:setDir(self.dir or eDir.RIGHT)
--     self:doEventForce(StateEvent.FSM_STAND)
-- end

function BaseHero:getDir()
	return self.dir
end
function BaseHero:setDir(dir)
	if dir == eDir.LEFT then
		self:setFlipX(true)
	elseif dir == eDir.RIGHT then
		self:setFlipX(false)
	end
	self.dir = dir
end

function BaseHero:setFlipX(flipX)
	local node = self.skeletonNode or self.imageNode
	if node then  
		local scaleX = node:getScaleX()
		if flipX then
			scaleX = -math.abs(scaleX)
		else
			scaleX = math.abs(scaleX)
		end
		node:setScaleX(scaleX)
	end
end

function BaseHero:getFlipX() 
	if self.skeletonNode then 
		return self.skeletonNode:getScaleX() < 0
	end
	if self.imageNode then 
		return self.imageNode:getScaleX() < 0
	end
end

function BaseHero:setPosition3D(x, y, z)
	if x then
		self.position3D.x = x
	end
	if y then
		self.position3D.y = y
	end
	if z then
		self.position3D.z = z
	end

	--刷新模型位置
	self:setPosition(self.position3D.x, self.position3D.z)
end

function BaseHero:getPosition3D()
	return self.position3D
end

--npc的功能触发区域
function BaseHero:getNpcRect()
	local origin = self.areaRect.origin
	local size   = self.areaRect.size
	origin.x     = self.position3D.x - size.width/2
	origin.y     = self.position3D.y - size.height/2
	return self.areaRect
end

-- --点击响应
-- function BaseHero:getTouchRect()
--     local origin = self.touchRect.origin
--     local size   = self.touchRect.size
--     origin.x     = self.position3D.x - size.width/2
--     origin.y     = self.position3D.y - size.height
--     return self.touchRect
-- end


--[[-
参数说明：
	1、spine动画 
	2、当前播放的动作名 
	3、帧事件名 
	4、5、6: 在spine对应的帧事件的参数(int, float, string)
-]]
function BaseHero:onArmtureEvent(...)
   local data = {...}
end

function BaseHero:getData()
	return self.data
end

function BaseHero:isMainHero()
	if not self.data then return false end

	return self.data.heroType == HeroType.MainHero   
end

function BaseHero:getPid()
	if not self.data then return 0 end

	return self.data.pid   
end

function BaseHero:getId()
	return self.data.id   
end
function BaseHero:getSkinId()
	return self.data.skinId   
end

function BaseHero:getMoveSpeed()
	return self.data.moveSpeed * self.speedScale
end

function BaseHero:getUnsignedMoveSpeed()
	return math.abs(self.data.moveSpeed * self.speedScale)
end

function BaseHero:setTimeScale(scale)
	if self.skeletonNode then
		self.skeletonNode:setTimeScale(scale)
	end
end

function BaseHero:getTimeScale()
	if self.skeletonNode then
		return self.skeletonNode:getTimeScale()
	end
	return 1
end

function BaseHero:pause()
	if self.skeletonNode then 
		self.skeletonNode:stop()
	end
	self:pauseSchedulerAndActions()
end

function BaseHero:resume()
	if self.skeletonNode then 
		self.skeletonNode:resume()
	end
	self:resumeSchedulerAndActions()
end


function BaseHero:releaseSkeletonNode()
	if self.imageNode then 
		self.imageNode:removeFromParent()
		self.imageNode = nil
	end
	if self.skeletonNode then
		self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
		self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
		self.skeletonNode:removeFromParent()
		self.skeletonNode = nil
	end
end

--删除监听
function BaseHero:removeTFArmatureListener()
	if self.skeletonNode then
		self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
	end
end

--移除角色
function BaseHero:removeHero()
	if self.groundNode then
		self.groundNode:removeFromParent()
		self.groundNode = nil
	end

	-- if self.infoNode then
	-- 	self.infoNode:removeFromParent()
	-- 	self.infoNode = nil
	-- end

	if self.touchPanel then
		self.touchPanel:removeFromParent()
		self.touchPanel = nil
	end

	self:removeFromParent()
end

--获取当前播放的动画
function BaseHero:getAnimation()
	if self.skeletonNode then 
		return self.skeletonNode:getAnimation()
	end
end

function BaseHero:isInsertRect(rect)
	-- if not rect then return false end
	local pos = self:getPosition()
	local mRect = me.rect(pos.x - 50, pos.y, 100, 120)
	return me.rectIntersectsRect(rect, mRect)
end

-- function BaseHero:getBoundingBox(boneName)
-- 	local rect = self.skeletonNode:getBoundingBox2(boneName)
-- 	if math.abs(rect.origin.x) > 8192
-- 		or  math.abs(rect.origin.y) > 8192
-- 		or  rect.size.width > 8192
-- 		or  rect.size.height > 8192  then --非法碰撞框
-- 		rect.size.width = 0
-- 		rect.size.width = 0
-- 		rect.origin.x = 0
-- 		rect.origin.y = 0
-- 	end
-- 	local pos  = ccp(self:getPosition())
-- 	rect.origin.x = rect.origin.x + pos.x
-- 	rect.origin.y = rect.origin.y + pos.y
-- 	return rect
-- end

-- function BaseHero:getRelativeBoundingBox(boneName)
-- 	if self.skeletonNode then 
-- 		return self.skeletonNode:getBoundingBox2(boneName)
-- 	else
-- 		return ccp(0,60)
-- 	end
-- end

function BaseHero:getBonePosition(boneName)
	local pos = self:getRelativeBonePosition(boneName)
	return me.pAdd(self:getPosition(), pos)
end

function BaseHero:getRelativeBonePosition(boneName)
	if self.skeletonNode then 
		local pos = self.skeletonNode:getBonePosition(boneName)
		local scaleX = self.skeletonNode:getScaleX()
		local scaleY = self.skeletonNode:getScaleY()
		return ccp(pos.x * scaleX, pos.y * scaleY)
	end
	return ccp(0,60)
end

-- function BaseHero:haveAnim(animName)
-- 	animName = animName .. ";"
-- 	local movNames = self.skeletonNode:getMovementNameStrings()
-- 	movNames = movNames .. ";"
-- 	if string.find(movNames, animName) then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end


--调试节点
-- function BaseHero:debugNode()
-- 	if self.data.heroType == HeroType.NPC then
-- 		local drawNode = TFDrawNode:create()
-- 		-- drawNode:drawSolidCircle(me.p(0,0), 5, 360, 36, ccc4(1, 1, 0, 1))
-- 		local size = self.areaRect.size
-- 		local rect = me.rect(-size.width/2,-size.height/2,size.width,size.height)
-- 		drawNode:drawSolidRect(rect.origin , rect.origin + ccp(rect.size.width,rect.size.height) , ccc4(0 , 0.2, 0, 0.3))

-- 		-- 
-- 		-- size = self.touchRect.size
-- 		-- rect = me.rect(-size.width/2,0,size.width,size.height)
-- 		-- drawNode:drawSolidRect(rect.origin , rect.origin + ccp(rect.size.width,rect.size.height) , ccc4(0.1 , 0.1, 0, 0.3))
-- 		self:addChild(drawNode,-999)
-- 	end
-- end

return BaseHero

