--[[--
	控件基类:

	--By: yun.bo
	--2013/7/8
]]

TFUIBase = TFUIBase or {}

if not TFUIBase.__index then TFUIBase.__index = TFUIBase end

TFUI_VERSION_COCOSTUDIO = "1.0.0.0"
TFUI_VERSION_ALPHA 		= 0
TFUI_VERSION_MEEDITOR		= 1
TFUI_VERSION_NEWMEEDITOR	= 2

TFUIBase.version 		= nil

require('TFFramework.client.system.components.luacomps.init')
require('TFFramework.client.system.components.TFUIBase.TFUIBase_Unity')
require('TFFramework.client.system.components.TFUIBase.TFUIBase_Fundation')
require('TFFramework.client.system.components.TFUIBase.TFUIBase_Setter')
require('TFFramework.client.system.components.TFUIBase.TFUIBase_NewSetter')
require('TFFramework.client.system.components.TFUIBase.TFUIBase_Load')

local TFUIBase 			= TFUIBase
local ENABLE_ADAPTOR 	= ENABLE_ADAPTOR
local tolua 			= tolua
local type 				= type
local setmetatable	 	= setmetatable
local setpeer 			= tolua.setpeer
local getpeer 			= tolua.getpeer

local PrefabCache = {}

TFUIBase.__MECppClone = CCNode.clone
TFUIBase.setPosition = CCNode.setPosition
TFUIBase.getPosition = CCNode.getPosition
TFUIBase.setPositionX = CCNode.setPositionX
TFUIBase.setPositionY = CCNode.setPositionY
TFUIBase.getPositionX = CCNode.getPositionX
TFUIBase.getPositionY = CCNode.getPositionY

TFUIBase.setScale = CCNode.setScale
TFUIBase.getScale = CCNode.getScale
TFUIBase.setScaleX = CCNode.setScaleX
TFUIBase.setScaleY = CCNode.setScaleY
TFUIBase.getScaleX = CCNode.getScaleX
TFUIBase.getScaleY = CCNode.getScaleY

TFUIBase.setColor = CCNode.setColor
TFUIBase.getColor = CCNode.getColor

TFUIBase.setVisible = CCNode.setVisible
TFUIBase.isVisible = CCNode.isVisible

TFUIBase.setOpacity = CCNode.setOpacity
TFUIBase.getOpacity = CCNode.getOpacity

--[[--
	给对象obj绑定TFUIBase的所有属性及方法
	@param obj: 需要绑定的对象
	@return : nil
]]
function TFUIBase:extends(obj)
	if  not obj then return end
	local peer = setmetatable(getpeer(obj) or {}, TFUIBase)
	-- peer.__MECppClone = peer.__MECppClone or obj.clone
	setpeer(obj, peer)
end

--[[--
	用给定的lua文件路径或lua对象加载一个UI对象, 如果提供parent,则会将加载完成的
	UI对象添加到此parent
	@param szLuaPath: lua文件路径 || lua表对象
	@param usePrefab: 是否缓存
	@return : nil
]]
function createUIByLua(szLuaPath, usePrefab)
	-- TFTime:b()
	if not szLuaPath then return end
	local TFUIBase = TFUIBase
	local tempVersion = TFUIBase.version
	local comps
	local needRefreshPrefab = false
	local szType = type(szLuaPath) -- check state
	if szType == 'string' then -- lua path, load it
		needRefreshPrefab = tolua.isnull(PrefabCache[szLuaPath])
		if not needRefreshPrefab and not package.loaded[szLuaPath] then 
			needRefreshPrefab = true
		end
		comps = require(szLuaPath)
	elseif szType == 'table' then -- already a table
		comps = szLuaPath
		needRefreshPrefab = true
	end

	TFUIBase.version = TFUIBase:adaptVersion(comps.version)
	local val
	if TFUIBase.version == TFUI_VERSION_COCOSTUDIO then
		val = comps.widgetTree
		local directory = comps.directory
		val.directory = directory
	else
		val = comps.components[1]
	end

	local objUI = nil
	if needRefreshPrefab then 
		if PrefabCache[szLuaPath] then 
			if not tolua.isnull(PrefabCache[szLuaPath]) then 
				PrefabCache[szLuaPath]:release()
			end
			PrefabCache[szLuaPath] = nil
		end

		if not PrefabCache[szLuaPath] then 
			if not comps.components then 
				assert(false, string.format("Can not create ui : %s", tostring(szLuaPath)))
			end

			objUI = TFUIBase:initChild(val, parent)

			if usePrefab then 
				PrefabCache[szLuaPath] = objUI
				objUI:retain()

				objUI = objUI:clone(true)
			end
		else 
			objUI = PrefabCache[szLuaPath]:clone(true)
		end
	else 
		if PrefabCache[szLuaPath] then 
			objUI = PrefabCache[szLuaPath]:clone(true)
		else 
			assert(false)
		end
	end

	-- init ui actions
	TFUIBase:initAction(objUI, comps.actions)
	TFUIBase.version = tempVersion
	-- TFTime:e(szLuaPath .. ":")
	return objUI
end

function createUIBySceneConfig(path)
	local config = nil
	if type(path) == 'table' then 
		config = path
	else 	
		config = require(path)
	end

	local Root = CCNode:create()
    if config.size then 
        Root:Size(config.size)
    else 
        Root:Size(ccs(1136, 640))
    end

    local function travel_children(info, parent)
        local node = nil
        if info.type == "Image" then 
            node = TFImage:create(info.path or ""):Size(100, 100)
            node.path = info.path
        elseif info.type == "Spine" then 
            node = TFSpine:create(info.path or "")
			-- node:setFile(info.path or "")
			if info.animName and info.animName ~= "" then 
				node:play(info.animName, 1)
			else 
				node:playByIndex(info.animIndex or 0, 1)
			end
            node:Size(100, 100)
			node.path = info.path
			node.animName = info.animName
        elseif info.type == "Node" then 
            node = CCNode:create():Size(100, 100):AnchorPoint(ccp(0.5, 0.5))
            --TFPanel:create({backColor=ccc3(255,255,255)}):Alpha(0.5):AddTo(node):AnchorPoint(ccp(0.5, 0.5))
    	elseif info.type == "TFParticle" then
        	node = TFParticle:create()
        end

        parent:addChild(node)

        if info.name then 
            node:Name(info.name)
        end
        if info.pos then 
            node:Pos(info.pos)
        end
        if info.rotate then 
            node:Rotate(info.rotate)
        end
        if info.scaleX then 
            node:ScaleX(info.scaleX)
        end
        if info.scaleY then 
            node:ScaleY(info.scaleY)
        end
        if info.zorder then 
            node:ZO(info.zorder)
        end
        if info.size then 
            node:Size(info.size)
        end
		if info.alpha then 
			node:setOpacity(info.alpha)
		end
        if info.eventID then 
            node.eventID = info.eventID
        end
        if info.nodeType then 
            node.nodeType = info.nodeType
        end
		if info.radiusEnabled then 
            node.radiusEnabled = info.radiusEnabled
			node:setHitType(TFTYPE_CIRCLE)
			node:setHitRadius(node:getSize().width / 2)
		end
		
		local part = info.particle
		if part then 
			if part.path and part.path ~= "" then 
				node:setParticle(part.path)
			end
		end

		if info.physics then 
			local physics = json.decode(info.physics)
			if physics then 
				local body = PhysicsBody:create()
				node:setPhysicsBody(body)
				if physics.isEnabled            ~= nil then body:setEnabled(physics.isEnabled) end
				if physics.Tag                  ~= nil then body:setTag(physics.Tag) end
				if physics.CategoryBitmask      ~= nil then body:setCategoryBitmask(physics.CategoryBitmask) end
				if physics.ContactTestBitmask   ~= nil then body:setContactTestBitmask(physics.ContactTestBitmask) end
				if physics.CollisionBitmask     ~= nil then body:setCollisionBitmask(physics.CollisionBitmask) end
				if physics.IsGravityEnabled     ~= nil then body:setGravityEnable(physics.IsGravityEnabled) end
				if physics.IsRotationEnabled    ~= nil then body:setRotationEnable(physics.IsRotationEnabled) end
				if physics.IsDynamic            ~= nil then body:setDynamic(physics.IsDynamic) end
				if physics.Mass                 ~= nil then body:setMass(physics.Mass) end

				for idx, shapeInfo in ipairs(physics.shapes) do 
					local tp = shapeInfo.type
					
					local material  = me.Physics.Material(shapeInfo.Density or 0, shapeInfo.Restitution or 0, shapeInfo.Friction or 0)
					local offset    = shapeInfo.Offset or ccp(0, 0)
					local border    = shapeInfo.Border or 1
					local Size      = shapeInfo.Size or ccs(1, 1)
					local points    = shapeInfo.Points or { ccp(0, 0), ccp(0, 1) }
					local PointA    = shapeInfo.PointA or ccp(0, 0)
					local PointB    = shapeInfo.PointB or ccp(0, 1)

					local shape = nil
					if tp == 1 then -- "圆",
						shape = PhysicsShapeCircle:create(shapeInfo.Radius or 1, material, offset)
					elseif tp == 2 then -- "矩形",
						shape = PhysicsShapeBox:create(Size, material, offset)
					elseif tp == 3 then -- "多边形",   
						shape = PhysicsShapePolygon:create(points, #points, material, offset)
					elseif tp == 4 then -- "线段",
						shape = PhysicsShapeEdgeSegment:create(PointA, PointB, material, border)
					elseif tp == 5 then -- "空心矩形",
						shape = PhysicsShapeEdgeBox:create(Size, material, offset, border)
					elseif tp == 6 then -- "空心多边形",  
						shape = PhysicsShapeEdgePolygon:create(points, #points, material, border)
					elseif tp == 7 then -- "链条",
						shape = PhysicsShapeEdgeChain:create(points, #points, material, border)
					end
					body:addShape(shape)
					
					if shapeInfo.Tag        ~= nil then shape:setTag(shapeInfo.Tag) end
					if shapeInfo.IsSensor   ~= nil then shape:setSensor(shapeInfo.IsSensor) end
					if shapeInfo.Mass       ~= nil then shape:setMass(shapeInfo.Mass) end

				end

			end
		end

        info.children = info.children or {}
        for i = 1, #info.children do 
            travel_children(info.children[i], node)
        end
    end

    for i = 1, #config do 
        travel_children(config[i], Root)
    end

	return Root
end

--[[--
	用于创建lua配置文件的粒子控件
	返回粒子控件
	@szLuaPath: lua配置文件
	@szParticleName: 界面上的粒子名字
]]
function createParticleByLua(szLuaPath, szParticleName)
	local ui = createUIByLua(szLuaPath)
	local particle = TFDirector:getChildByName(ui, szParticleName)
	particle:removeFromParent()
	return particle
end

function TFUIBase:adaptVersion(version)
	if type(version) == 'string' then 
		version = TFUI_VERSION_COCOSTUDIO 
	elseif version == nil then
		version = TFUI_VERSION_ALPHA
	elseif version == 1 then
		version = TFUI_VERSION_MEEDITOR
	elseif version == 2 then
		version = TFUI_VERSION_NEWMEEDITOR
	end
	return version
end

return TFUIBase