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
* 基础相机
* 
]]

local MapUtils = import(".MapUtils")
local enum = require("lua.logic.battle.enum")
local eCameraFlag = enum.eCameraFlag
local eDir = enum.eDir

local BaseCamera = class("BaseCamera")

function BaseCamera:ctor( initPos)
    self.size = me.size(me.EGLView:getDesignResolutionSize())
    self.zeye = me.Director:getZEye()
    self.maxZ = self.zeye * 1.4
    --摄像机的位置
    -- self.position3D = me.Vertex3F(self.size.width * 0.5, self.size.height * 0.5, self.zeye )
    --地图统一摄像机
    self.camera = nil  
    --镜头跟随目标
    self.focusNode = nil    
    self.fixZ = 150
    self.fixDuration = 0
    self.nDir = nil
    self.nSlow = 0.1
    self.nSlowDel = 0.001
    self.isInit = false
    self._initPos = initPos or ccp(300,300)
end

function BaseCamera:init()
	if self.isInit then
        return
    end
    self.isInit = true

    local scene = Public:currentScene()
    self.camera = self:createCamera(eCameraFlag.CF_MAP, 2, "cameraMap")
    scene:addChild(self.camera)

    --设置位置
    self:setPosition3D(me.Vertex3F(self.size.width * 0.5, self.size.height * 0.5, self.zeye))

    --初始化相机位置为第一个出生点位置
    self:initPostion(self._initPos)
end

function BaseCamera:createCamera(cameraFlag, depth, name)
    local size = self.size
    local center = me.Vertex3F(size.width * 0.5, size.height * 0.5, 0)
    local up = me.Vertex3F(0, 1.0, 0)
    local camera = Camera:createPerspective(60, size.width / size.height, 10, self.zeye + size.height * 4)
    camera:lookAt(center, up)
    camera:setCameraFlag(cameraFlag)
    -- camera:setDepth(depth)
    camera:setName(name)
    return camera
end

--计算摄像机的初始位置
function BaseCamera:initPostion(focusPosition)
    local airwall = MapUtils:getMapParse():getCameraRect()
    local node = CCNode:create()
    node:setPosition(focusPosition) 
    node.getBonePosition = node.getPosition
    node.getDir = function()
        return eDir.RIGHT
    end
    local tarPos3D = self:checkPos3d(node, airwall) --计算目标位置
    self:setPosition3D(tarPos3D)
end

function BaseCamera:setFocusNode(focusNode)
    self.focusNode = focusNode
end

function BaseCamera:getFocusNode()
    return self.focusNode
end

function BaseCamera:update(dt)
	if not self.isInit then
        self:init()
    end

    if self.focusNode then
        --空气墙的限制
        local airwall = MapUtils:getMapParse():getCameraRect()
        local tarPos3D = self:checkPos3d(self.focusNode, airwall) --计算目标位置
        self:slowMove(tarPos3D)  --缓动到目标位置
    end
end

function BaseCamera:calcPos3D(focusNode)
    if not focusNode then
        return me.Vertex3F(self.position3D.x, self.position3D.y , self.position3D.z)
    end
    local nowPos = focusNode:getBonePosition("point")
    local position3D = me.Vertex3F(nowPos.x, nowPos.y + 50 , self.zeye * 0.85)
    --计算黄金分割线
    local dir = focusNode:getDir()
    local rate = 0.1 - self.nSlowDel
    rate = math.max(0,rate)
    rate = math.min(0.1,rate)
    if dir == eDir.LEFT then
        position3D.x = position3D.x - self.size.width * rate 
    else
        position3D.x = position3D.x + self.size.width * rate
    end
    if dir ~= self.nDir then
        self.nDir = dir
        self.nSlow = 0
    end
    return position3D
end

function BaseCamera:setFixZ( fixZ )
    -- body
    self.fixZ = fixZ
end

function BaseCamera:setSlowMoveDel( dt )
    -- body
    self.nSlowDel = dt
end

function BaseCamera:checkPos3d(focusNode, range)
    local tarPos3D  = self:calcPos3D(focusNode)
    if self.fixZ then
        tarPos3D.z = tarPos3D.z + self.fixZ
    end
    --各种修正保证不露黑边
    local maxHeight = MapUtils:getMapParse():getSceneHeight()
    local maxz1 = self.zeye * maxHeight / self.size.height
    local maxz2 = self.zeye * range.size.width / self.size.width
    --纵向最大|空气墙最大|全局最大|
    tarPos3D.z = math.min(math.min(math.min(maxz1, maxz2), self.maxZ), tarPos3D.z)

    local width = self.size.width / 2
    width = width * tarPos3D.z / self.zeye
    local height = self.size.height / 2
    height = height * tarPos3D.z / self.zeye
    if range then
        local left  = range.origin.x
        local right = left + range.size.width
        if tarPos3D.x > right  - width  then
            tarPos3D.x = right - width
        elseif tarPos3D.x < left + width then
            tarPos3D.x = left + width
        end
    end
    tarPos3D.y = math.min(tarPos3D.y, maxHeight - height)
    tarPos3D.y = math.max(tarPos3D.y, height)
    return tarPos3D
end

function BaseCamera:slowMove(pos3D)
    local oldPos = self:getPosition3D()
    if oldPos then
        if self.nSlow  < 0.1 then
            self.nSlow = self.nSlow + self.nSlowDel
        end
        pos3D.x = oldPos.x + self:offset(pos3D.x, oldPos.x) 
        pos3D.y = oldPos.y + self:offset(pos3D.y, oldPos.y) 
        pos3D.z = oldPos.z + self:offset(pos3D.z, oldPos.z) 
    end

    self:setPosition3D(pos3D)
end

function BaseCamera:offset(a, b)
    local value = a - b
    if math.abs(value) > 0.1 then
        value = value* self.nSlow 
    end
    return value
end

--场景坐标转UI坐标
function BaseCamera:transPosition(pos)
    local dsSize = self.size
    local zeye = self.zeye
    local cameraPos = self:getPosition3D()
    local size = me.size(dsSize.width * cameraPos.z/zeye, dsSize.height * cameraPos.z/zeye)
    local point = me.p((pos.x - (cameraPos.x - size.width/2))/size.width,  (pos.y - (cameraPos.y - size.height/2))/size.height)
    return me.p(dsSize.width * point.x , dsSize.height * point.y)
end

function BaseCamera:setPosition3D(pos3D)
    self.camera:setPosition3D(pos3D)
    self.position3D = pos3D
end

function BaseCamera:getPosition3D()
    return self.position3D
end

return BaseCamera
