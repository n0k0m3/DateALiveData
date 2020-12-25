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
* 解析地图编辑器输出文件
* 
]]

local OSDEnum = import(".OSDEnum")
local MapLayerType = OSDEnum.MapLayerType
local MapNodeType  = OSDEnum.MapNodeType
local BattleConfig = require("lua.logic.battle.BattleConfig")

local BaseMapParse = class("BaseMapParse")

local FLT_EPSILON = 0xFFFFFF

BaseMapParse.DEBUG         = false
BaseMapParse.DEBUG_FINDER  = false

function BaseMapParse:ctor()
	self:initData()
end

function BaseMapParse:initData()
	self.data = nil							 --地图数据
	self.fileName = nil						 --地图文件
	self.resPaths = nil						 --资源列表
	self.mapNode = nil 						 --地图node
	self.pathFinder = nil    				 --寻路网格
	self.bornPts = {}						 --出生点
	self.randomBornPts = {}					 --随机出生点
	self.visualNodes = {}					 --所有节点数据
	self.renderNodes  = {}					 --所有渲染节点
	self.occlusionNodes = {}				 --遮挡节点(渲染) 
	self.brokenNodes = {}					 --障碍物
	self.triggerNodes = {}					 --触发点
	self.npcNodes = {}						 --NPC
	self.rect = me.rect(0, 0, 0, 0) 		 --空气墙
	self.allMoveRect = me.rect(0, 0, 0, 0)	 --可移动区域
	self.moveRect = me.rect(0, 0, 0, 0)		 --可行走区域(重算一次)
end

function BaseMapParse:cleanUp()
	self:initData()
end

--读文件
function BaseMapParse:loadJson(fileName)
	print("[BaseMapParse]parse file ==== ", fileName)
	local jsonContent = io.readfile(string.format("levels/%s.json", fileName))
	if jsonContent == nil or jsonContent == "" then
		Box(string.format("Read %s.json failed", fileName))
		return
	end

	local data = json.decode(jsonContent) 	 --地图数据
	self:loadData(data, fileName)
end

--如果有缓存数据，读数据
function BaseMapParse:loadData(data, fileName)
	self.fileName = fileName
	self.data = data

	if self.data == nil then
		Box(string.format("Decode %s.json failed", self.fileName))
		return
	end
	for key, value in pairs(self.data.root) do
		self.data[key]= value
	end
end

--解析地图
function BaseMapParse:parse()
	self.mapNode = CCNode:create() --地图渲染节点
	self:parseChildren(self.data.children, self.mapNode)
	self:initlize()
end

--解析子节点
function BaseMapParse:parseChildren(data, parent)
	if not data then return end 
	for k, v in pairs(data) do
		local childType = v["type"] 
		if childType== MapNodeType.MapLayer then
			self:parseMapLayer(v, parent)
		elseif childType == MapNodeType.MapImage then
			self:parseImg(v, parent)
		elseif childType== MapNodeType.MapEffect then
			self:parseEffect(v, parent)
		elseif childType == MapNodeType.MoveLayer then
			self:parsePolygonNode(v, parent)
		elseif childType == MapNodeType.ResistLayer then
			self:parsePolygonNode(v, parent)
		elseif childType == MapNodeType.PointLayer then
			self:parsePointNode(v, parent)
		elseif childType == MapNodeType.NpcList then
			self:parseNpcNode(v, parent)
		else
			if string.match(v["type"], "Trigger") then
				self:parseTriggerNode(v, parent)
			end
		end
		self:addVisualNode(v.ID ,v)
	end
end

function BaseMapParse:parseMapLayer(data, parent)
	local node = TFLayer:create()
	node.data = data
	parent:addChild(node)
	self:parseCommonAttr(data, node)
	self:addRenderNode(data.ID, node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(data.children, node)
end

function BaseMapParse:parseImg(data, parent)
	local node = TFImage:create("fightmap/" .. data.Path)
	node.data = data
	node:setVisible(data.Active)
	parent:addChild(node)
	self:parseCommonAttr(data, node)
	self:addRenderNode(data.ID, node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(data.children, node)
end

function BaseMapParse:parseEffect(data, parent)
	local node = SkeletonAnimation:create("effect/" .. data.Path)
	node.data = data
	node:setVisible(data.Active)
    node:setAnimationFps(GameConfig.ANIM_FPS)
    node.playAnimation = function(self)
    	self:play(self.data.ActionName, self.data.Loop and 1 or 0)
    end
    if data.Active == true then
    	node:playAnimation()
    end
    parent:addChild(node)
    self:parseCommonAttr(data, node)
    self:addRenderNode(data.ID, node)
	self:parseChildren(data.children, node)
end

function BaseMapParse:parsePolygonNode(data, parent)
	if BaseMapParse.DEBUG then 
		local node = TFDrawNode:create()
		node.data = data
		local points = {}
		local color = data.Color
		for k, point in pairs(data.ControlPoint) do
			points[k] = me.p(point.X, point.Y)
		end
	    node:drawSolidPoly(points, ccc4(color.R, color.G, color.B, color.A))
	    node:drawPoly(points, true, ccc4(1, 1, 0, 0.5))
		self:parseCommonAttr(data, node)
		parent:addChild(node)  
	end
end

function BaseMapParse:parsePointNode(data, parent)
-- 93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115
	if data.ID >=93 and  data.ID <=115 then
		table.insert(self.randomBornPts,ccp(data.Position.X,data.Position.Y))
	end
	if BaseMapParse.DEBUG then 
		local node = TFDrawNode:create()
		node.data = data
		local color = data.Color
		local radius = data.Radius
		node:drawDot(me.p(0 , 0), radius, ccc4(color.R, color.G, color.B, color.A))
	  	self:parseCommonAttr(data, node)
	  	parent:addChild(node)  
  	end 
end

--NPC列表
function BaseMapParse:parseNpcNode(data, parent)
	self:addNpcNode(data)
	if BaseMapParse.DEBUG then 
		local node = TFDrawNode:create()
		node.data = data
		local color = data.Color
		local radius = data.Radius
		node:drawDot(me.p(0 , 0), radius, ccc4(color.R, color.G, color.B, color.A))
	  	self:parseCommonAttr(data, node)
	  	parent:addChild(node)  
  	end 
end

--触发器节点
function BaseMapParse:parseTriggerNode(data, parent)
	self:addTriggerNode(data.ID, data)
	if BaseMapParse.DEBUG then
		if data.type == "RegionTrigger" then
			local node = TFDrawNode:create()
		    node:drawRect(data.Size.W * data.Scale.X, data.Size.H*data.Scale.Y, ccc4(0, 1, 1, 0.5), ccc4(1, 0, 1, 0.5))
		    node:setPosition(me.p(data.Position.X - (data.Size.W/2 * data.Scale.X), data.Position.Y - (data.Size.H/2 * data.Scale.Y)))
			parent:addChild(node,1000)  
		end
	end
end

--初始化
function BaseMapParse:initlize()
	if self.data.SceneHeight == 0 then
		self.data.SceneHeight = 1200
	end

	--空气墙
	self.rect = me.rect(0, 0, self.data.Size.W, self.data.Size.H)

	--计算整个地图行走面
	local moveNode = self.visualNodes[self.data.MoveLayerID]
	self.allMoveRect = self:calculationPolygonRect(moveNode.Position, moveNode.ControlPoint)

	--更新空气墙
	self:onAirPointChange()
	--初始化出生点
	self:initBornPts()

	--障碍
	local brokenGroup = self.visualNodes[self.data.CanBorkenID]
	if brokenGroup then
		for index, id in ipairs(brokenGroup.List) do
			local node = self.visualNodes[id]
			self:addBrokenNode(node)
		end
	end

	--初始化寻路网格
	self:initPathFinder()
end

--空气墙状态改变
function BaseMapParse:onAirPointChange()
	local group = self.visualNodes[self.data.AirBlockID]
	local points = {} 
	for index , id in ipairs(group.List) do
		local node = self.visualNodes[id]
		if node.Active then
			if string.upper(node.Mark) == "MOVE_TO_SCREEN_RIGHT" then
				table.insert(points, GameConfig.WS.width)
			else
				table.insert(points, node.Position.X)
			end
		end
	end
    if #points ~= 2 then
        return
    end

	table.sort(points, function(a, b)
		return a < b
	end)

	--更新空气墙位置
	if #points == 2 then
		self.rect.origin.x = points[1]
		self.rect.size.width = points[2] - points[1]
	end

	-- printBeck(self.rect)
    --更新当前行走面
	local __rect = clone(self.rect)
	self.moveRect = me.rectIntersection(self.allMoveRect, __rect)
	--行走区域的2边固定间隔
	self.moveRect.origin.x = __rect.origin.x + BattleConfig.SPACE_AIRWALL
	self.moveRect.size.width = __rect.size.width - BattleConfig.SPACE_AIRWALL*2
	self.moveRect.origin.x  = math.ceil(self.moveRect.origin.x/ self:getBlockSize()) * self:getBlockSize()
	self.moveRect.size.width = math.floor(self.moveRect.size.width/ self:getBlockSize()) * self:getBlockSize()
	self.moveRect.origin.y = math.floor(self.moveRect.origin.y/ self:getBlockSize()) * self:getBlockSize()
	self.moveRect.size.height = math.ceil(self.moveRect.size.height/ self:getBlockSize()) * self:getBlockSize()
end

--初始化出生点
function BaseMapParse:initBornPts()
	self.bornPts = {}
	for index = 1, 6  do
		local id = self.data[string.format("BornID%d", index)]
		if id and id > 0 then
			local node = self.visualNodes[id]
			table.insert(self.bornPts, me.p(node.Position.X, node.Position.Y))
	    end
	end
end

--初始化寻路网格
function BaseMapParse:initPathFinder()
	local pathFile = string.format("levels/%s.path", self.fileName)
	if BaseMapParse.DEBUG_FINDER then
		local blockSize = self:getBlockSize()
		local pathNode = TFDrawNode:create()
		local logicNode = self:getMapLayer(MapLayerType.Logic)
		local navMeshNode = DrawNode:create()
		logicNode:addChild(navMeshNode, -999)
		logicNode:addChild(pathNode, 999)
		self.pathFinder = PathFinder:new(pathFile, pathNode, self:getBlockSize())
		--绘制网格
		local size = self.data.Size
		local row  = math.ceil(size.H / blockSize)
		local col  = math.ceil(size.W / blockSize)
		for k = 0 , col - 1 do
			local x = k * blockSize
			for m = 0 , row - 1 do
				local y = m * blockSize
				if self.pathFinder.astar:get(m, k) ~=0 then
					navMeshNode:drawSolidRect(ccp(x, y), ccp(k * blockSize, m * blockSize) + ccp(blockSize,blockSize), ccc4(0.2, 0.2, 0.2, 0.8))
				else
					navMeshNode:drawRect(ccp(x, y), ccp(k * blockSize, m * blockSize) + ccp(blockSize, blockSize), ccc4(0, 1, 0, 0.1))
				end
			end
		end
	else
		self.pathFinder = PathFinder:new(pathFile, nil, self:getBlockSize())
	end
end

--是否是遮挡节点
function BaseMapParse:isOcclusionNode(node)
	local data = node.data
	if data then
		if data.type == MapNodeType.MapLayer and data.Mark == MapLayerType.Occlusion then
			return true
		end
	end
	return false
end

--设置属性
function BaseMapParse:parseCommonAttr(data, node)
	for k, v in pairs(data) do
		if k == "CameraZ" then
			node:setPositionZ(v)
		elseif k == "Z" then
			node:setZOrder(v)
		elseif k == "Size" then
			node:setSize(me.size(v.W, v.H))
		elseif k == "Alpha" then
			node:setOpacity(v)
		elseif k == "Scale" then
			node:setScaleX(v.X)
			node:setScaleY(v.Y)
		elseif k == "Rotation" then
			node:setRotation(v)
		elseif k == "Color" then
			node:setColor(ccc3(v.R, v.G, v.B))
		elseif k == "Position" then
			node:setPosition(me.p(v.X, v.Y))
		elseif k == "Active" then
			node:setVisible(v)
		elseif k == "Name" then
			node:setName(v)
		elseif k == "FlipX" then
			node:setFlipX(v)
		elseif k == "FlipY" then
			node:setFlipY(v)
		elseif k == "Visible" then
			-- node:setVisible(v)
		end
	end
end

--所有节点数据
function BaseMapParse:addVisualNode(key, visualNode)
	self.visualNodes[key] = visualNode
end

function BaseMapParse:addTriggerNode(key, triggerNode)
	self.triggerNodes[key] = triggerNode
end

--渲染节点
function BaseMapParse:addRenderNode(key, renderNode)
	self.renderNodes[key] = renderNode
end

--障碍物
function BaseMapParse:addBrokenNode(node)
	self.brokenNodes[#self.brokenNodes + 1] = node
end

--遮挡节点
function BaseMapParse:addOcclusionNode(node)
	local pos  = node:getPosition()
    local size = node:getSize()
    --初始计算好检测区域
    node.rect  = me.rect(pos.x - size.width/2 , pos.y - size.height/2, size.width, size.height)
    self.occlusionNodes[#self.occlusionNodes + 1] = node
end

--npc or 传送点
function BaseMapParse:addNpcNode(npcNode)
	self.npcNodes[#self.npcNodes + 1] = npcNode
end

function BaseMapParse:getData()
	return self.data
end

function BaseMapParse:getMapNode()
	return self.mapNode 
end

function BaseMapParse:getOcclusionNodes()
	return self.occlusionNodes
end

function BaseMapParse:getNpcList()
	return self.npcNodes
end

function BaseMapParse:getBlockSize()
	return self.data.BlockSize
end

function BaseMapParse:getMapLayer(layerType)
	for i, node in pairs(self.renderNodes) do
		local data = node.data
		if data and data.type == MapNodeType.MapLayer then
			-- printBeck(data.type, data.Mark, data.Name, data.ID, layerType)
			if tonumber(data.Mark) == layerType then
				return node
			end 
		end
	end
end

function BaseMapParse:getBlockWithPos(_x, _y)
	if _y == nil then
		_y = _x.y
		_x = _x.x 
	end
	local bs  = self:getBlockSize()
    local row = math.floor(_y / bs)
    local col = math.floor(_x / bs)
    return self:getBlock(row, col)
end

function BaseMapParse:getBlock(row,col)
    if row < 0 or col < 0 or row >= self:getRow() or col >= self:getCol() then
        return 1
    end
    return self.pathFinder.astar:get(row ,col)
end

function BaseMapParse:getRenderNode(id)
	return self.renderNodes[id]
end

function BaseMapParse:getVisualNode(id)
	return self.visualNodes[id]
end

function BaseMapParse:transPosToGridPos(pos)
	local bs = self:getBlockSize()
    local row = math.floor(pos.y / bs)
    local col = math.floor(pos.x / bs)
    return col, row
end

function BaseMapParse:tranGridPosToPos(col,row)
	local bs = self:getBlockSize()
	return me.p((col+0.5) * bs, (row + 0.5) * bs)
end

function BaseMapParse:getCol()
	return self.pathFinder.astar:getWidth()
end

function BaseMapParse:getRow()
	return self.pathFinder.astar:getHeight()
end

function BaseMapParse:find(st, ed)
	local path = self.pathFinder:find(st, ed)
	-- print("FIND:",st, ed ,path)
	return path
end

function BaseMapParse:getSceneHeight()
	return self.data.SceneHeight
end

--行走面
function BaseMapParse:getMoveRect()
	return self.moveRect
end

--空气墙
function BaseMapParse:getCameraRect()
	return self.rect
end

function BaseMapParse:canMoveGrid(row, col)
	return self:getBlock(row, col) == 0
end

function BaseMapParse:canMoveXY(x, y)
	if not me.rectContainsPoint(self.moveRect, me.p(x, y)) then
		--空气墙限制
		return false
	end
	return self:getBlockWithPos(x, y) == 0 
end

--获取出生点位置
function BaseMapParse:getBornPos(bornIndex)
	bornIndex = bornIndex or 1
	bornIndex = math.min(bornIndex, #self.bornPts)
	if #self.bornPts <= 0 then
		print("fuck!!!!! there is no born pos")
		return ccp(0, 0)
	end
	local pos = self.bornPts[bornIndex]
	return pos 
end

--随机出生点
function BaseMapParse:randomBornPos()
	-- local rect = self:getMoveRect()
	-- return self:randomPos(rect)
	if #self.randomBornPts > 0 then 
		print("随机位置")
		return clone(self.randomBornPts[math.random(#self.randomBornPts)])
	end
	return self:getBornPos(1)
end

--随机一个不在阻挡区域的位置
function BaseMapParse:randomPos(rect)
	rect = me.rectIntersection(rect, self:getMoveRect())
	local blockSize = self:getBlockSize()
	local sCol = math.ceil(rect.origin.x / blockSize)
	local eCol = math.floor((rect.origin.x + rect.size.width)/blockSize) -1
	local sRow = math.ceil(rect.origin.y/blockSize)
	local eRow = math.floor((rect.origin.y + rect.size.height)/blockSize) -1
	sCol = math.max(sCol, 0)
	eCol = math.min(eCol, self:getCol() - 1)
	sRow = math.max(sRow, 0)
	eRow = math.min(eRow, self:getRow() - 1)
	local col = -1
    local row = -1
	repeat  
		col = RandomGenerator.random(sCol, eCol)
		row = RandomGenerator.random(sRow, eRow)
		-- print(string.format("randomPos (%s-%s),(%s-%s),(%s,%s),(%s,%s),%s",sRow,eRow, sCol,eCol,row,col,
		-- 	self:getRow(), self:getCol(), tostring(self:canMoveGrid(row, col)) ))
	until self:canMoveGrid(row, col) 
	return ccp(col * blockSize + blockSize/2 , row * blockSize + blockSize/2) 

end

--获取资源列表
function BaseMapParse:getRespaths()
	if not self.resPaths then 
		self.resPaths = {}
		self.resPaths.textures = {}
		self.resPaths.effects  = {}
		for i, image in ipairs(self.data.resources.images) do
			local path = "fightmap/" .. image
			table.uniqueAdd(self.resPaths.textures, path)
		end
		for i, effect in ipairs(self.data.resources.effects) do
			local path = "effect/" .. effect
			table.uniqueAdd(self.resPaths.effects, path)
		end
	end
	return self.resPaths
end

--获取npc列表，只用于预加载
function BaseMapParse:getNpcResList()
	if not self.data then return {} end 
	local npcResList = {}

	local function parseData(data)
		if not data then return end
		for k, v in pairs(data) do
			local childType = v["type"]
			if childType== MapNodeType.MapLayer then
				parseData(v.children)
			elseif childType == MapNodeType.MapImage then
				parseData(v.children)
			elseif childType== MapNodeType.MapEffect then
				parseData(v.children)
			elseif childType == MapNodeType.NpcList then
				npcResList[#npcResList + 1] = v
			end
		end
	end

	parseData(self.data.children)

	return npcResList
end

--计算矩形
function BaseMapParse:calculationPolygonRect(position, controlPoint)
	local minx = FLT_EPSILON
	local miny = FLT_EPSILON
	local maxx = -FLT_EPSILON
	local maxy = -FLT_EPSILON
	for _idx, point in ipairs(controlPoint) do
		minx = math.min(minx, point.X + position.X)
		miny = math.min(miny, point.Y + position.Y)
		maxx = math.max(maxx, point.X + position.X)
		maxy = math.max(maxy, point.Y + position.Y)
	end
	return me.rect(minx, miny, maxx - minx, maxy -miny)
end

return BaseMapParse
