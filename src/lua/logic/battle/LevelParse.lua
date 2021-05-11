require("lua.logic.activity.json")
local LevelParse = class("LevelParse")
local BattleConfig = import(".BattleConfig")
local ExEventTrigger = import(".ExEventTrigger")
local VisualHero = import(".VisualHero")
local LevelNodeType = {
	MapLayer    ="MapLayer",
	MapImage    ="MapImage",
	MapEffect   ="MapEffect",      --spine动画
	MoveLayer   ="MoveLayer",      --行走面
	ResistLayer ="ResistLayer",    --阻挡 
	PointLayer  ="PointLayer",     --点控件
	NpcList 	="NpcList",		   --NPCList
	-- DieCounterTrigger    = "DieCounterTrigger",
	-- HPTrigger            = "HPTrigger",
	-- RegionTrigger        = "RegionTrigger",
	-- AliveCounterTrigger  = "AliveCounterTrigger",
	-- TimerTrigger         = "TimerTrigger",
	-- MultConditionTrigger = "MultConditionTrigger",
}

local NodeMark = {
	MOVE_TO_SCREEN_RIGHT = "MOVE_TO_SCREEN_RIGHT"
}

local LayerType = {
	Render    = 1 ,
	Role      = 2 ,
	Boss      = 3 ,
	Occlusion = 4 ,
	Logic     = 5 , 
}
LevelParse.LayerType = LayerType
LevelParse.LevelNodeType = LevelNodeType
LevelParse.DEBUG         = false --触发器
LevelParse.DEBUG_FINDER  = false --地图网格和寻路路径

local FLT_EPSILON = 0xFFFFFF

local enum       = import(".enum")
local eEvent     = enum.eEvent
LevelParse.isEvtRegist = false
function LevelParse:registEvents()
	if self.isEvtRegist == false then
		EventMgr:removeEventListenerByTarget(self)
		EventMgr:addEventListener(self, EV_BATTLE_CURTAIN, handler(self.curtainEvtHandle, self))
	    EventMgr:addEventListener(self, EV_BATTLE_PLAYCG_ANIM, handler(self.playCGAnim, self))
	    EventMgr:addEventListener(self, EV_BATTLE_PLAY_STORYTALK, handler(self.playStoryTalk, self))
	    EventMgr:addEventListener(self, EV_BATTLE_SUPER_MASK, handler(self.fullMaskHandle, self))
	    EventMgr:addEventListener(self, EV_BATTLE_CTRLS_SHOW,handler(self.ctrlShowEvtHandle,self))
	    self.isEvtRegist = true
	end
end

function LevelParse:unregistEvents()
	if self.isEvtRegist == true then
		EventMgr:removeEventListenerByTarget(self)
	    self.isEvtRegist = false
	end

end
--计算矩形
local function calculationPolygonRect(Position,ControlPoint)
	local minx     =  FLT_EPSILON
	local miny     =  FLT_EPSILON
	local maxx     = -FLT_EPSILON
	local maxy     = -FLT_EPSILON
	for _idx , point in ipairs(ControlPoint) do
		minx = math.min(minx,point.X + Position.X)
		miny = math.min(miny,point.Y + Position.Y)
		maxx = math.max(maxx,point.X + Position.X)
		maxy = math.max(maxy,point.Y + Position.Y)
	end
	return me.rect(minx,miny,maxx - minx,maxy -miny)
end


-- "root": {
-- 	"BornID1": 5,
-- 	"AirBlockID": 1058,
-- 	"Name": "关卡默认实例",
-- 	"SceneHeight": 0,
-- 	"MoveLayerID": 1115,
-- 	"CanBorkenID": 1060,
-- 	"Size": {
-- 		"W": 2500,
-- 		"H": 400
-- 	},
-- 	"ID": 0,
-- 	"BlockSize": 10,
-- 	"BlockOutline": 1.5
-- }
--加载JSON
function LevelParse:loadJson(file,exCfg)
	self.file         = file
	self.exCfg        = exCfg
	if not self.data then
		print("load json",string.format("levels/%s.json",self.file))
		local jsonContent = io.readfile(string.format("levels/%s.json",self.file))
		-- print("jsonContent",jsonContent)
		if jsonContent == nil or jsonContent == "" then
			Box(string.format("Read %s.json failed",self.file))
		end
		self.data = json.decode(jsonContent) --关卡数据
		if self.data == nil then
			Box(string.format("Decode %s.json failed",self.file))
			return
		end
		if self.exCfg and self.exCfg > 0 then
			local exCfgData = TabDataMgr:getData("DungeonLevelStep",self.exCfg)
			if exCfgData then
				if exCfgData.prevScript and exCfgData.prevScript ~= "" then
					self.data.root.ScriptAnimID = tonumber(exCfgData.prevScript)
				end
				if exCfgData.bornPoint and exCfgData.bornPoint ~= 0 then
					self.data.root.BornID1 = exCfgData.bornPoint
				end
			end
		end
		for key , value in pairs(self.data.root) do
			self.data[key]= value
		end
	end
end

--剔除table里的相同元素只保留一个
-- local function removeSameItem( array )
--     local t = {}
--     for i , v in ipairs(array) do
--         t[v] = v
--     end
--     return table.keys(t)
-- end
--获取资源列表
--TODO 方便策划大爷再关卡编辑器里使用资源，解析资源列表只能做拼接
function LevelParse:getRespaths()
	if not self.respaths then 
		self.respaths = {}
		self.respaths.textures = {}
		self.respaths.effects  = {}
		for i, image in ipairs(self.data.resources.images) do
			local path = "fightmap/"..image
			table.uniqueAdd(self.respaths.textures, path)
		end
		for i, effect in ipairs(self.data.resources.effects) do
			local path = "effect/"..effect
			table.uniqueAdd(self.respaths.effects, path)
		end
	end
	return self.respaths
end
function LevelParse:parse(controller)
	self.mapNode    = CCNode:create() --地图渲染节点
	if self.exCfg ~= 0 then
		self.exJson = ExEventTrigger:getExTriggerCfg(self.exCfg)
	else
		self.exJson = nil
	end
	self:parseChildren(self.data.children,self.mapNode)
	if self.exJson then
		if self.exJson["visualNode"] and #self.exJson["visualNode"] > 0 then
			local group = self.visualNodes[self.data.AirBlockID]
			group.List = {}
			for i,v in ipairs(self.exJson["visualNode"]) do
				self:addVisualNode(v.ID ,v)
				group.List[#group.List + 1] = v.ID
			end
		end
		
		for i,v in ipairs(self.exJson["triggers"]) do
			self:parseTriggerNode(v,self.mapNode)
		end
	end
	self:initlize(controller)
	return self
end


function LevelParse:getMapNode()
	return self.mapNode 
end

function LevelParse:initlize(controller)
	self.controller = controller
	if self.data.SceneHeight == 0 then
		self.data.SceneHeight = 1200
	end
	self.rect = me.rect(0,0,self.data.Size.W,self.data.Size.H)
	--初始化出生点
	self:initBornPts()

	--计算整个地图行走面
	local moveNode    = self.visualNodes[self.data.MoveLayerID]
	self.allMoveRect  = calculationPolygonRect(moveNode.Position,moveNode.ControlPoint)
	--空气墙
	self:onAirPointChange()

	-- --可破坏障碍
	-- local brokenGroup = self.visualNodes[self.data.CanBorkenID]
	-- if brokenGroup then
	-- 	for index , id in ipairs(brokenGroup.List) do
	-- 		local node = self.visualNodes[id]
	-- 		self:addBrokenNode(node)
	-- 	end
	-- end
	--
	self:initPathFinder(self.file)

	-- self:randomPos(self:getMoveRect())
	-- Box("AAA")
end


function LevelParse:initBornPts()
	self.bornPts = {}
	for index = 1 , 3  do
		local id = self.data[string.format("BornID%d",index)]
		if id and id > 0 then
			local node  = self.visualNodes[id]
			table.insert(self.bornPts,me.p(node.Position.X , node.Position.Y))
	    end
	end
end



function LevelParse:getBlockSize()
	if self.data then
		return self.data.BlockSize
	else
		return 10
	end
end


function LevelParse:initPathFinder(file)
	local pathFile = string.format("levels/%s.path",file)
	if LevelParse.DEBUG_FINDER then
		local blockSize    = self:getBlockSize()
		local pathNode     = TFDrawNode:create()
		local logicNode    = self:getMapLayer(LayerType.Logic)
		local navMeshNode  = DrawNode:create()
		logicNode:addChild(navMeshNode,-999)
		logicNode:addChild(pathNode,999)
		self.pathFinder = PathFinder:new(pathFile,pathNode,self:getBlockSize())
		--绘制网格
		local size = self.data.Size
		local row  = math.ceil(size.H / blockSize)
		local col  = math.ceil(size.W / blockSize)
		for k = 0 , col - 1 do
			local x = k*blockSize
			for m = 0 , row - 1 do
				local y = m*blockSize
				if self.pathFinder.astar:get(m,k) ~=0 then
					navMeshNode:drawSolidRect(ccp(x,y) , ccp(k*blockSize,m*blockSize) + ccp(blockSize,blockSize) , ccc4(0.2 , 0.2, 0.2, 0.8))
				else
					navMeshNode:drawRect(ccp(x,y) , ccp(k*blockSize,m*blockSize) + ccp(blockSize,blockSize) , ccc4(0, 1, 0, 0.1))
				end
			end
		end
	else
		self.pathFinder = PathFinder:new(pathFile,nil,self:getBlockSize())
	end
end






function LevelParse:getBlockWithPos(_x,_y)
	if nil == _y then
		_y = _x.y
		_x = _x.x 
	end
	local bs  = self:getBlockSize()
    local row = math.floor(_y / bs)
    local col = math.floor(_x / bs)
    return self:getBlock(row, col)
end

function LevelParse:getBlock(row,col)
    if row < 0 or col < 0 or row >= self:getRow() or col >= self:getCol() then
        return 1
    end
    return self.pathFinder.astar:get(row ,col)
end

--激活障碍
function LevelParse:Activate(blocks)
	-- print(blocks)
	-- Box("Activate blocks")
	for i , block in ipairs(blocks) do
		local value = self.pathFinder.astar:get(block.y ,block.x)
		self.pathFinder.astar:set(block.y ,block.x,value +1)
	end
end
--移除障碍
function LevelParse:DeActivate(blocks)
	-- print(blocks)
	-- Box("DeActivate blocks")
	for i , block in ipairs(blocks) do
		local value = self.pathFinder.astar:get(block.y ,block.x)
		self.pathFinder.astar:set(block.y ,block.x,value -1)
	end
end

function LevelParse:getCol()
	return self.pathFinder.astar:getWidth()
end

function LevelParse:getRow()
	return self.pathFinder.astar:getHeight()
end

function LevelParse:find(st, ed)
	-- print("FIND:",st, ed)
	local path = self.pathFinder:find(st,ed)
	if #path > 0 then
		local pos  = path[1]

		-- if pos.x ~= ed.x or pos.y ~= ed.y then
			 -- path[#path+1] = ed
		-- end
		pos.x = st.x
		pos.y = st.y
	end
	-- print("FIND:",st, ed ,path)
	return path
	-- return self.pathFinder:find(st,ed)
end

function LevelParse:canMove(x,y)
	if not me.rectContainsPoint(self.moveRect,me.p(x,y)) then
		--空气墙限制
		return false
	end
	return self:getBlockWithPos(x,y) == 0 
end

function LevelParse:canMoveWithoutAir(x, y)
	return self:getBlockWithPos(x,y) == 0
end

function LevelParse:_canMove(row,col)
	return self:getBlock(row,col) == 0 
end


function LevelParse:parseChildren(cfg,parent)
	if not cfg then return  end 
	for k,v in pairs(cfg) do
		local childType = v["type"] 
		if childType== LevelNodeType.MapLayer then
			self:parseMapLayer(v,parent)
		elseif childType == LevelNodeType.MapImage then
			self:parseImg(v,parent)
		elseif childType== LevelNodeType.MapEffect then
			self:parseEffect(v,parent)
		elseif childType == LevelNodeType.MoveLayer then
			self:parsePolygonNode(v,parent)
		elseif childType == LevelNodeType.ResistLayer then
			self:parsePolygonNode(v,parent)
		elseif childType == LevelNodeType.PointLayer then
			self:parsePointNode(v,parent)
		elseif childType == LevelNodeType.NpcList then
			self:parseNpcNode(v,parent)
		else
			if string.match(v["type"],"Trigger") then
				self:parseTriggerNode(v,parent)
			end
		end
		self:addVisualNode(v.ID ,v)
	end
end

--是否是遮挡节点
function LevelParse:isOcclusionNode(node)
	local cfg = node.cfg
	if cfg then
		if cfg.type == LevelNodeType.MapLayer and cfg.Mark == LayerType.Occlusion then
			return true
		end
	end
end
--触发器节点
function LevelParse:parseTriggerNode(cfg,parent)
	self:addTriggerNode(cfg.ID,cfg)
	if LevelParse.DEBUG then
		if cfg.type == "RegionTrigger" then
			local node    = TFDrawNode:create()
		    node:drawRect(cfg.Size.W*cfg.Scale.X,cfg.Size.H*cfg.Scale.Y,ccc4(0, 1, 1, 0.5),ccc4(1, 0, 1, 0.5))
		    node:setPosition(me.p(cfg.Position.X - (cfg.Size.W/2*cfg.Scale.X),cfg.Position.Y - (cfg.Size.H/2*cfg.Scale.Y)))
			parent:addChild(node,1000)  
		end
	end
end

--解析地图分层图层
function LevelParse:parseMapLayer(cfg,parent)
	local node = TFLayer:create()
	node.cfg   = cfg
	node:setVisible(cfg.Active)
	parent:addChild(node)
	self:parseCommonAttr(cfg,node)
	self:addRenderNode(cfg.ID,node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(cfg.children,node)

end

--解析图片配置
function LevelParse:parseImg(cfg,parent)
	local node = TFImage:create("fightmap/"..cfg.Path)
	node.cfg   = cfg
	node:setVisible(cfg.Active)
	parent:addChild(node)
	self:parseCommonAttr(cfg,node)
	self:addRenderNode(cfg.ID,node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(cfg.children,node)
end

--解析动画配置
function LevelParse:parseEffect(cfg,parent)
	local node = SkeletonAnimation:create("effect/"..cfg.Path)
	node.cfg   = cfg
	node:setVisible(cfg.Active)
    node:setAnimationFps(GameConfig.ANIM_FPS)
    node.playAnimation = function(self)
    	self:play(self.cfg.ActionName,self.cfg.Loop and 1 or 0)
    end
    if cfg.Active == true then
    	node:playAnimation()
    end
    parent:addChild(node)
    self:parseCommonAttr(cfg,node)
    self:addRenderNode(cfg.ID,node)
	self:parseChildren(cfg.children,node)
end

--NPC列表
function LevelParse:parseNpcNode(data, parent)
	self.npcNodes[#self.npcNodes + 1] = data
end

--圆形节点
function LevelParse:parsePointNode(cfg,parent)
	if LevelParse.DEBUG then 
		local node   = TFDrawNode:create()
		node.cfg     = cfg
		local color  = cfg.Color
		local radius = cfg.Radius
		node:drawDot(me.p(0 , 0), radius, ccc4(color.R,color.G,color.B,color.A))
	  	self:parseCommonAttr(cfg,node)
	  	parent:addChild(node)  
  	end 
end
--矩形节点
function LevelParse:parsePolygonNode(cfg,parent)
	if LevelParse.DEBUG then 
		local node    = TFDrawNode:create()
		node.cfg      = cfg
		local pts     = {}
		local color   = cfg.Color
		for k, point in pairs(cfg.ControlPoint) do
			pts[k] = me.p(point.X,point.Y)
		end
	    node:drawSolidPoly(pts, ccc4(color.R, color.G, color.B, color.A))
	    node:drawPoly(pts, true, ccc4(1, 1, 0, 0.5))
		self:parseCommonAttr(cfg,node)
		parent:addChild(node)  
	end
end

--通用属性设置
function LevelParse:parseCommonAttr(attrCfg,tarNode)
	for k,v in pairs(attrCfg) do
		if k == "CameraZ" then
			tarNode:setPositionZ(v)
		elseif k == "Z" then
			tarNode:setZOrder(v)
		elseif k == "Size" then
			tarNode:setSize(me.size(v.W,v.H))
		elseif k == "Alpha" then
			tarNode:setOpacity(v)
		elseif k == "Scale" then
			tarNode:setScaleX(v.X)
			tarNode:setScaleY(v.Y)
		elseif k == "Rotation" then
			tarNode:setRotation(v)
		elseif k == "Color" then
			tarNode:setColor(ccc3(v.R,v.G,v.B))
		elseif k == "Position" then
			tarNode:setPosition(me.p(v.X,v.Y))
		elseif k == "Active" then
			tarNode:setVisible(v)
		elseif k == "Name" then
			tarNode:setName(v)
		elseif k == "FlipX" then
			tarNode:setFlipX(v)
		elseif k == "FlipY" then
			tarNode:setFlipY(v)
		elseif k == "Visible" then
			-- tarNode:setVisible(v)
		end
	end
end


function LevelParse:getRenderNode(id)
	return self.renderNodes[id]
end

function LevelParse:getVisualNode(id)
	return self.visualNodes[id]
end

function LevelParse:getNpcList()
	return self.npcNodes
end

function LevelParse:getMapLayer(layerType)
	for i , node in pairs(self.renderNodes) do
		local cfg = node.cfg
		if cfg.type == LevelNodeType.MapLayer then
			print(cfg.type,cfg.Mark,cfg.Name,cfg.ID , layerType)
			if cfg.Mark == layerType then
				return node
			end 
		end
	end
	-- assert(false,"not found target layer "..tostring(layerType))
end


function LevelParse:getSceneHeight()
	return self.data.SceneHeight
end
--行走面
function LevelParse:getMoveRect()
	return self.moveRect
end

--空气墙
function LevelParse:getCameraRect()
	return self.rect
end

function LevelParse:addTriggerNode(key,triggerNode)
	self.triggers[key] = triggerNode
end


function LevelParse:addRenderNode(key,renderNode)
	self.renderNodes[key] = renderNode
end

---- doRefresh
function LevelParse:addVisualNode(key,visualNode)
	self.visualNodes[key] = visualNode
	--逻辑节点绑定函数
	local mgr  = self
    visualNode.doRefresh = function(self, ...)
    	-- if self.handType then
        	mgr:onNodeRefresh(self)
    	-- end
    end
end

function LevelParse:addOcclusionNode(node)
	self.occlusionNodes[#self.occlusionNodes+1] = node
end

-- function LevelParse:addBrokenNode(node)
-- 	self.brokenNodes[#self.brokenNodes+1] = node
-- end

-- 节点调用刷新
function LevelParse:onNodeRefresh(node)
	print("onNodeRefresh:")
	local childType = node.type 
	if childType == LevelNodeType.MapLayer then
		self:getRenderNode(node.ID):setVisible(node.Active)
	elseif childType == LevelNodeType.MapImage then
		self:getRenderNode(node.ID):setVisible(node.Active)
	elseif childType == LevelNodeType.MapEffect then
		self:getRenderNode(node.ID):setVisible(node.Active)
		self:getRenderNode(node.ID):playAnimation()
	elseif childType == LevelNodeType.MoveLayer then
		print("TDOO暂时不应该修改")
	elseif childType == LevelNodeType.ResistLayer then

	elseif childType == LevelNodeType.PointLayer then
		--空气墙更新
		self:onAirPointChange()
	else  --

	end
end

function LevelParse:clean()
    self.needMoveObjs = {} --需要移动的对象
	self.bornPts        = {} --出生点
	self.visualNodes    = {} --所有节点数据
	self.renderNodes    = {} --所有渲染节点
	self.occlusionNodes = {} --遮挡节点(渲染) 
	-- self.obstacle       = {} --TODO障碍物
	self.range          = {} 
	self.triggers       = {}
	-- self.brokenNodes    = {} --障碍物
	self.exJson         = nil
	self.data           = nil
	self.respaths       = nil
	self.visualHeros = {} --假战斗的假人
	self.npcNodes       = {} --NPC 节点(跳转点)
end

--获取出生点位置
function LevelParse:getBornPos(bornIndex)
	bornIndex = bornIndex or 1
	bornIndex = math.min(bornIndex,#self.bornPts)
	local pos = self.bornPts[bornIndex]
	assert(pos)
	return pos 
end
--随机出生点
function LevelParse:randomBonePos()
	local rect = self:getMoveRect()
	return self:randomPos(rect)
end

--随机一个不在阻挡区域的位置
function LevelParse:randomPos(rect)
	rect = me.rectIntersection(rect,self:getMoveRect())
	-- print("randomPos",rect)
	local blockSize = self:getBlockSize()
	local sCol = math.ceil(rect.origin.x/blockSize)
	local eCol = math.floor((rect.origin.x + rect.size.width)/blockSize) -1

	local sRow = math.ceil(rect.origin.y/blockSize)
	local eRow = math.floor((rect.origin.y + rect.size.height)/blockSize) -1
	sCol = math.max(sCol,0)
	eCol = math.min(eCol,self:getCol()-1)
	sRow = math.max(sRow,0)
	eRow = math.min(eRow,self:getRow()-1)
	local col = -1
    local row = -1
	repeat  
		col = RandomGenerator.random(sCol,eCol)
		row = RandomGenerator.random(sRow,eRow)
		-- print(string.format("randomPos (%s-%s),(%s-%s),(%s,%s),(%s,%s),%s",sRow,eRow, sCol,eCol,row,col,
			-- self:getRow(),self:getCol(),tostring(self:_canMove(row,col)) ))
	until self:_canMove(row,col) 
	return ccp(col*blockSize + blockSize/2 , row*blockSize + blockSize/2) 

end


--空气墙状态改变
function LevelParse:onAirPointChange()
	local group = self.visualNodes[self.data.AirBlockID]
	local points = {} 
	for index , id in ipairs(group.List) do
		local node = self.visualNodes[id]
		if node.Active then
			if string.upper(tostring(node.Mark)) == NodeMark.MOVE_TO_SCREEN_RIGHT then
				table.insert(points, GameConfig.WS.width)
			else
				table.insert(points,node.Position.X)
			end
		end
	end
    if #points ~= 2 then
        return
    end
	table.sort(points,function(a , b)
		return a < b
	end)
	-- dump(points)
	--更新空气墙位置
	if #points == 2 then
		self.rect.origin.x   = points[1]
		self.rect.size.width = points[2] - points[1]
	end
	-- dump(self.rect)
    --更新当前行走面
	local __rect = clone(self.rect)

	self.moveRect = me.rectIntersection(	self.allMoveRect ,__rect)
	--行走区域的2边固定间隔
	self.moveRect.origin.x   = __rect.origin.x   + BattleConfig.SPACE_AIRWALL
	self.moveRect.size.width = __rect.size.width - BattleConfig.SPACE_AIRWALL*2
	self.moveRect.origin.x   = math.ceil(self.moveRect.origin.x/ self:getBlockSize())*self:getBlockSize()
	self.moveRect.size.width = math.floor(self.moveRect.size.width/ self:getBlockSize())*self:getBlockSize()
	self.moveRect.origin.y   = math.floor(self.moveRect.origin.y/ self:getBlockSize())*self:getBlockSize()
	self.moveRect.size.height = math.ceil(self.moveRect.size.height/ self:getBlockSize())*self:getBlockSize() + self:getBlockSize()
	-- dump(self.moveRect)
	-- Box("AAA")
	EventMgr:dispatchEvent(eEvent.EVENT_AIR_POINT_CHANGE)
end

function LevelParse:moveObject(cfg)
	local moveObj = {}
	local obj = self.renderNodes[cfg.TargetID]
	if obj then
		local isObjEnable = false
		moveObj.mobj = obj
		moveObj.objId = cfg.TargetID
		local tarpos = string.split(cfg.MovePos,",")
		moveObj.tarPos = me.p(tonumber(tarpos[1]),tonumber(tarpos[2]))
		moveObj.duration = cfg.Duration
		if moveObj.duration <= 0 then
			moveObj.duration = 1
		end
		moveObj.sv = cfg.StartVel
		moveObj.ac = cfg.Accelerate
		moveObj.curTime = 0
		if cfg.CanReadPos == true then
			local beginpos = string.split(cfg.StartPos,",")
			moveObj.sPos = me.p(tonumber(beginpos[1]),tonumber(beginpos[2]))
		else
			moveObj.sPos = obj:getPosition()
		end
		if moveObj.ac == 0 then
			moveObj.speed = me.p((moveObj.tarPos.x - moveObj.sPos.x)/(moveObj.duration/1000),(moveObj.tarPos.y - moveObj.sPos.y)/(moveObj.duration/1000))
			isObjEnable = true
		else
			--检查目的地是否可达
			local len = me.pGetLength(me.pSub(moveObj.tarPos,moveObj.sPos))
			local delta = moveObj.sv^2 + 2*moveObj.ac*len
			if delta < 0 then
				Box("到不了")
			else
				local unitvect = me.pDiv(me.pSub(moveObj.tarPos,moveObj.sPos),len)
				moveObj.uv = unitvect
				moveObj.movelen = len
				isObjEnable = true
			end
		end
		if isObjEnable == true then
			if self.needMoveObjs[moveObj.objId] == nil then
				self.needMoveObjs[moveObj.objId] = {}
			end
			-- self.needMoveObjs[moveObj.objId] = {}
			-- moveObj.mobj:setPosition(moveObj.sPos)
			table.insert(self.needMoveObjs[moveObj.objId],1,moveObj)
		end
		
	end
end



function LevelParse:update(dt)
	for k,v in pairs(self.needMoveObjs) do
		local moveObj = v[#v]
		moveObj.curTime = moveObj.curTime + (dt/1000)
	 	if moveObj.ac ~= 0 then
	 		local movelen = moveObj.sv * moveObj.curTime + 0.5*moveObj.ac * ((moveObj.curTime)^2)
	 		local tmpos = me.pAdd(moveObj.sPos,me.p(movelen*moveObj.uv.x,movelen*moveObj.uv.y)) 
	 		moveObj.mobj:setPosition(tmpos)
	 		if movelen >= moveObj.movelen then
	 			moveObj.mobj:setPosition(moveObj.tarPos)
	 			table.remove(v,#v)
	 		end
	 	else
	 		local tmpos = me.pAdd(moveObj.sPos,me.pMult(moveObj.speed,moveObj.curTime))
	 		moveObj.mobj:setPosition(tmpos)
	 		if moveObj.curTime >= (moveObj.duration/1000) then
	 			moveObj.mobj:setPosition(moveObj.tarPos)
	 			table.remove(v,#v)
	 		end
	 	end
	 	if #v == 0 then
			self.needMoveObjs[k] = nil
		end
	end
end

--上下黑边
function LevelParse:curtainEvtHandle(param)
	if param.isShow == true then
	    local view = requireNew("lua.logic.battle.CurtainLayer"):new(param)
	    AlertManager:addLayer(view,AlertManager.BLOCK)
	    AlertManager:show()
	end

end

--全屏遮罩
function LevelParse:fullMaskHandle(param)
	if param.maskAction == 1 then
		local view = requireNew("lua.logic.battle.FullMaskLayer"):new(param)
	    AlertManager:addLayer(view,AlertManager.BLOCK)
	    AlertManager:show()
	end
end

--播放CG
function LevelParse:playCGAnim(param)
	Utils:openView("battle.BattleCGLayer",param)
end

--播放剧情对话
function LevelParse:playStoryTalk(param)
	local view = requireNew("lua.logic.talk.TalkMainLayer"):new(param)
    AlertManager:addLayer(view,AlertManager.BLOCK)
    AlertManager:show()
end

--显示隐藏控件

function LevelParse:ctrlShowEvtHandle(param)
	for k,v in pairs(param.list) do
		if v.group == 1 then
			self:hpBarShow(v.val)
		elseif v.group == 2 then
			EventMgr:dispatchEvent(eEvent.EVENT_KEYBOARD_SHOW, v.val)
		elseif v.group == 3 then
			EventMgr:dispatchEvent(eEvent.EVENT_BATTLE_UI_SHOW, v.val)
		elseif v.group == 4 then
			local herolist = {}
			local hero = self.controller.getCaptain()
			if hero then
				herolist[#herolist + 1] = hero
			end
			local enemylist = self.controller.getEnemyMember()
			if enemylist then
				for s,t in pairs(enemylist) do	
					herolist[#herolist + 1] = t
				end
			end
			local assishero = self.controller.getAssist()
			if assishero then
				herolist[#herolist + 1] = assishero
			end
			for s,t in pairs(herolist) do
				t:setVisible(v.val)
			end
		elseif v.group == 5 then
			for k,v in pairs(self.visualHeros) do
				v:setVisible(v.val)
			end
		else

		end
	end
	

	if param.callback then
		param.callback()
	end
end

function LevelParse:hpBarShow(isShow)
	local herolist = {}
	local hero = self.controller.getCaptain()
	herolist[#herolist + 1] = hero

	local enemylist = self.controller.getEnemyMember()
	for k,v in pairs(enemylist) do
		if v:getData().id == tmTrigger.cfg.TargetID then
			herolist[#herolist + 1] = v
		end
	end
	for k,v in pairs(herolist) do
		v:getActor():showInfoNode(isShow)
	end
		
end

function LevelParse:getVisualHero(vhid)
	if self.visualHeros[vhid] == nil then
		local tmVh = VisualHero:new({modelId = vhid,order = 2,controller = self.controller})
		self.visualHeros[vhid] = tmVh
	end
	return self.visualHeros[vhid]
end

function LevelParse:loadVisualHero(cfg,callback)
	local tmVh = VisualHero:new({modelId = cfg.tarID,asyc = true,callback = callback,order = cfg.parentOrder,controller = self.controller})
	if cfg.position then
		tmVh:setPosition(cfg.position)
	end
	self.visualHeros[cfg.tarID] = tmVh
end

function LevelParse:removeVisualHeros()
	for k,v in pairs(self.visualHeros) do
		local focusNode = self.controller.getFocusNode()
		if focusNode then
			if focusNode.modelId == v.modelId then
				self.controller.setFocusNode()
			end
		end
		v:removeFromParent()
	end
	self.visualHeros = {}
	print("Removed Visual Hero !!!")
end



--x列 y行
function LevelParse:test(x,y)
	local row = self:getRow() 
	local col = self:getCol() 
	local data = {}  
 	for m = 1 , row , 1 do 
 		data[m] = {}
	 	for n = 1 , col , 1 do 
	 		local block = self:getBlock(m-1,n-1) 
	 		data[m][n] = { value = block ,flag = block}
	 	end
	end
	local openList = {}
	self:checkOpen(data , x ,y ,openList)
	return openList
end

function LevelParse:checkOpen(data , x,y ,openList)
	if y < 1 or y > #data or x < 1 or x  > #data[1] then 
		return 
	end
	local cell = data[y][x]
	if cell.value == 0 and cell.flag == 0 then
		cell.flag = 1
		table.insert(openList,{x=x,y=y})
		self:checkOpen(data,x-1,y ,openList)
		self:checkOpen(data,x+1,y ,openList)
		self:checkOpen(data,x , y + 1 ,openList)
		self:checkOpen(data,x , y - 1 ,openList)
	end
end



return LevelParse:new()



