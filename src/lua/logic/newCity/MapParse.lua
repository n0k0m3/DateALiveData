local MapParse = class("MapParse")
local LevelNodeType = {
	MapLayer    ="MapLayer",
	MapImage    ="MapImage",
	MapEffect   ="MapEffect",      --spine动画
	MoveLayer   ="MoveLayer",      --行走面
	ResistLayer ="ResistLayer",    --阻挡 
	PointLayer  ="PointLayer",     --点控件
}
local LayerType = {
	Render    = 1 ,
	Role      = 2 ,
	Boss      = 3 ,
	Occlusion = 4 ,
	Logic     = 5 ,
}

MapParse.LayerType = LayerType
MapParse.LevelNodeType = LevelNodeType
MapParse.DEBUG         = false
MapParse.DEBUG_FINDER  = false
MapParse.DEBUG_DOT = false
function MapParse:ctor(filename)
	self.filename = filename
	local jsonContent = io.readfile(string.format("citylevels/%s.json",self.filename))
	self.data         = json.decode(jsonContent) --关卡数据
	for key , value in pairs(self.data.root) do
		self.data[key]= value
	end
	self.visualNodes    = {} --所有节点数据
	self.renderNodes    = {} --所有渲染节点
	self.occlusionNodes = {} --遮挡节点(渲染) 
	self.range          = {}
	self.brokenNodes    = {} --障碍物
	self.pathFinder = nil--寻路网格
	self:parse()
	
end

function MapParse:getRespaths()
	if not self.respaths then 
		self.respaths = {}
		self.respaths.textures = {}
		self.respaths.effects  = {}
		for i, image in ipairs(self.data.resources.images) do
			local path = "citymap/"..image
			table.uniqueAdd(self.respaths.textures, path)
		end
		for i, effect in ipairs(self.data.resources.effects) do
			local path = "effect/"..effect
			table.uniqueAdd(self.respaths.effects, path)
		end
	end
	return self.respaths
end

function MapParse:parse()
	self.mapNode    = CCNode:create() --地图渲染节点
	self:parseChildren(self.data.children,self.mapNode)
	self:initlize()
	return self
end

function MapParse:initlize()
	self.data.SceneHeight = 1200
	self.rect = me.rect(0,0,self.data.Size.W,self.data.Size.H)
	--障碍
	local brokenGroup = self.visualNodes[self.data.CanBorkenID]
	if brokenGroup then
		for index , id in ipairs(brokenGroup.List) do
			local node = self.visualNodes[id]
			self:addBrokenNode(node)
		end
	end
	--
	self:initPathFinder(self.filename)
end

function MapParse:getMapNode()
	return self.mapNode 
end

function MapParse:getBlockSize()
	return self.data.BlockSize
end


function MapParse:initPathFinder(file)
	local pathFile = string.format("citylevels/%s.path",file)
	if MapParse.DEBUG_FINDER then
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

function MapParse:getBlockWithPos(_x,_y)
	if nil == _y then
		_y = _x.y
		_x = _x.x 
	end
	local bs  = self:getBlockSize()
    local row = math.floor(_y / bs)
    local col = math.floor(_x / bs)
    return self:getBlock(row, col)
end

function MapParse:getBlock(row,col)
    if row < 0 or col < 0 or row >= self:getRow() or col >= self:getCol() then
        return 1
    end
    return self.pathFinder.astar:get(row ,col)
end

function MapParse:transPosToGridPos(pos)
	local bs  = self:getBlockSize()
    local row = math.floor(pos.y / bs)
    local col = math.floor(pos.x / bs)
    return col,row
end

function MapParse:tranGridPosToPos(col,row)
	local bs  = self:getBlockSize()
	return me.p((col+0.5) * bs,(row + 0.5)*bs)
end

function MapParse:getRandomDP(curpos,w,h)
	local col,row = self:transPosToGridPos(curpos)
    local isCanMove = self:_canMove(row,col)
    if isCanMove == false then
        print("Add on wrong position!")
    else
        local gridpos = self.pathFinder.astar:findRandomPos(row, col, w, h)
        if gridpos.x == col and gridpos.y == row then
            print("The Same Point$$$$$$$$$$$$$$$$$$$")
        else
            return self:tranGridPosToPos(gridpos.x,gridpos.y)
        end
	    
    end
	return nil
end


function MapParse:getCol()
	return self.pathFinder.astar:getWidth()
end

function MapParse:getRow()
	return self.pathFinder.astar:getHeight()
end

function MapParse:find(st, ed)
	local path = self.pathFinder:find(st,ed)
	return path
end

function MapParse:_canMove(row,col)
	return self:getBlock(row,col) == 0
end

function MapParse:addBrokenNode(node)
	self.brokenNodes[#self.brokenNodes+1] = node
end


function MapParse:parseChildren(cfg,parent)
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
		else
			
		end
		self:addVisualNode(v.ID ,v)
	end
end

--是否是遮挡节点
function MapParse:isOcclusionNode(node)
	local cfg = node.cfg
	if cfg then
		if cfg.type == LevelNodeType.MapLayer and cfg.Mark == LayerType.Occlusion then
			return true
		end
	end
end

--解析地图分层图层
function MapParse:parseMapLayer(cfg,parent)
	local node = TFLayer:create()
	node.cfg   = cfg
	parent:addChild(node)
	self:parseCommonAttr(cfg,node)
	self:addRenderNode(cfg.ID,node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(cfg.children,node)

end

--解析图片配置
function MapParse:parseImg(cfg,parent)
	local node = TFImage:create("citymap/"..cfg.Path)
	node.cfg   = cfg
	parent:addChild(node)
	self:parseCommonAttr(cfg,node)
	self:addRenderNode(cfg.ID,node)
	if self:isOcclusionNode(parent) then
		self:addOcclusionNode(node)
	end
	self:parseChildren(cfg.children,node)
end

--解析动画配置
function MapParse:parseEffect(cfg,parent)
	local node = SkeletonAnimation:create("effect/"..cfg.Path)
	node.cfg   = cfg
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



--圆形节点
function MapParse:parsePointNode(cfg,parent)
	if MapParse.DEBUG or MapParse.DEBUG_DOT then 
		local node   = TFDrawNode:create()
		node.cfg     = cfg
		local color  = cfg.Color
		local radius = cfg.Radius
		node:drawDot(me.p(0 , 0), 5, ccc4(color.R,color.G,color.B,color.A))
	  	self:parseCommonAttr(cfg,node)
	  	parent:addChild(node)  
  	end 
end
--矩形节点
function MapParse:parsePolygonNode(cfg,parent)
	if MapParse.DEBUG then 
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
function MapParse:parseCommonAttr(attrCfg,tarNode)
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
			tarNode:setVisible(true)
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

function MapParse:addOcclusionNode(node)
	self.occlusionNodes[#self.occlusionNodes+1] = node
end

function MapParse:addRenderNode(key,renderNode)
	--renderNode:setName(key)
	self.renderNodes[key] = renderNode
end

---- doRefresh
function MapParse:addVisualNode(key,visualNode)
	self.visualNodes[key] = visualNode
end

function MapParse:getRenderNode(id)
	return self.renderNodes[id]
end

function MapParse:getVisualNode(id)
	return self.visualNodes[id]
end



function MapParse:getMapLayer(layerType)
	for i , node in pairs(self.renderNodes) do
		local cfg = node.cfg
		if cfg.type == LevelNodeType.MapLayer then
			print(cfg.type,cfg.Mark,cfg.Name,cfg.ID , layerType)
			if cfg.Mark == layerType then
				return node
			end 
		end
	end
end


function MapParse:getSceneHeight()
	return self.data.SceneHeight
end

return MapParse