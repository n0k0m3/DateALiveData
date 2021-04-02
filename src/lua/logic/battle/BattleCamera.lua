local BattleConfig = import(".BattleConfig")
local enum = import(".enum")
local eCameraFlag = enum.eCameraFlag
local eDir = enum.eDir
local eMode= enum.eMode
local BattleCamera = class("BattleCamera")
local BattleMgr   = import(".BattleMgr")
local levelParse   = import(".LevelParse")

function BattleCamera:ctor(controller)
    self.size         = me.size(me.EGLView:getDesignResolutionSize())
    self.zeye         = me.Director:getZEye()
    self.maxZ         = self.zeye * 1.4
    --摄像机的位置
    -- self.position3D   = me.Vertex3F(self.size.width * 0.5, self.size.height * 0.5, self.zeye )
    self.camera1      = nil  --战斗统一摄像机
    self.camera2      = nil  --气浪特效摄像机
    self.isInit       = false
    self.fixZ         = 0
    self.fixDuration  = 0
    self.controller   = controller

    self.nDir  = nil
    self.nSlow = 0.1
    self.fixzMap = {}
end

function BattleCamera:setFixZ(id,duration,fixZ)
    if duration ~= 0 then
        self.fixzMap[id] = {time = self.controller:getTime(), dura = duration, fix = fixZ}
        if self.fixZ == 0 then
            self.fixZ = fixZ
        else
            self.fixZ = math.max(self.fixZ, fixZ)
        end
        self.fixDuration = duration
    else
        if self.fixzMap[id] then
            self.fixzMap[id] = nil
        end
        if self.fixDuration > 0 then

        else
            self.fixDuration = 0
            self.fixZ = 0
            local curId
            local maxFixz = 0
            for k,v in pairs(self.fixzMap) do
                if v.fix > maxFixz then
                    maxFixz = v.fix
                    curId = k
                end
            end
            if curId then
                local info = self.fixzMap[curId]
                if info.dura == -1 then
                    self.fixDuration = info.dura
                else
                    self.fixDuration = math.max(info.dura - (self.controller:getTime() - info.time), 0)
                end
                self.fixZ = info.fix
            end
        end
    end
end

function BattleCamera:createCamera(cameraFlag ,depth , name)
    local size   = self.size
    local center = me.Vertex3F(size.width * 0.5, size.height * 0.5, 0)
    local up     = me.Vertex3F(0, 1.0, 0)
    local camera = Camera:createPerspective(60, size.width / size.height, 10, self.zeye + size.height * 2)
    camera:lookAt(center, up)
    camera:setCameraFlag(cameraFlag)
    -- camera:setDepth(depth)
    camera:setName(name)
    return camera
end


function BattleCamera:initlize()
    if self.isInit then
        return
    end
    self.isInit = true
    local scene  = Public:currentScene()
    self.camera1 = self:createCamera(eCameraFlag.CF_MAP, 2,"cameraMap")
    self.camera2 = self:createCamera(eCameraFlag.CF_EFFECT, 1,"cameraEffect")
    self.camera3 = Camera:create()
    self.camera3:setCameraFlag(eCameraFlag.CF_EFFECT_BLAST)
    -- self.camera3:setDepth(3)
    -- self:createCamera(eCameraFlag.CF_EFFECT_BLAST, 3,"cameraEffectBlast")
    scene:addChild(self.camera3)
    scene:addChild(self.camera2)
    scene:addChild(self.camera1)
    BattleMgr.bindActionMgr(self.camera3)
    BattleMgr.bindActionMgr(self.camera2)
    BattleMgr.bindActionMgr(self.camera1)
    --增加20像素避免抖屏时露黑边
    if (BattleConfig.SHADER_BLUR or BattleConfig.SHADER_BLAST) and not self.controller.flightMode then
        local spaceSize = 0

        local WSize = me.Director:getOpenGLView():getFrameSize()
        local TargetSize = ccs(GameConfig.WS.width, GameConfig.WS.height)
        local isWideScreen = false
        if WSize.width / WSize.height < GameConfig.WS.width / GameConfig.WS.height then 
            TargetSize = ccs(GameConfig.WS.width, GameConfig.WS.width * WSize.height / WSize.width)
            isWideScreen = true
            
            local w = TargetSize.width
            local h = TargetSize.height
            local border = (TargetSize.height - GameConfig.WS.height) / 2
            self.camera1:setViewport(0, border, w, h - border * 2)
            self.camera2:setViewport(0, border, w, h - border * 2)
            self.camera3:setViewport(0, border, w, h - border * 2)
        else 
            local w = TargetSize.width
            local h = TargetSize.height
            self.camera1:setViewport(0, 0, w, h)
            self.camera2:setViewport(0, 0, w, h)
            self.camera3:setViewport(0, 0, w, h)
        end

        self.camera1:setupFBOWithTexture(TargetSize.width + spaceSize, TargetSize.height + spaceSize)
        self.camera2:setupFBOWithTexture(TargetSize.width + spaceSize, TargetSize.height + spaceSize)
        self.camera3:setupFBOWithTexture(TargetSize.width + spaceSize, TargetSize.height + spaceSize)
        self.camera1Texture = self.camera1:getRenderTexture() 
        self.camera1Texture:setAliasTexParameters()
        self.camera2Texture = self.camera2:getRenderTexture()
        self.camera2Texture:setAliasTexParameters()
        self.camera3Texture = self.camera3:getRenderTexture()
        self.camera3Texture:setAliasTexParameters()      
    end
    --设置位置
    self:setPosition3D(me.Vertex3F(self.size.width * 0.5, self.size.height * 0.5, self.zeye))

    -- 未开启气浪时隐藏特效摄像机
    if not BattleConfig.SHADER_BLAST then
        self.camera2:setVisible(false)
    end
    --初始化相机位置为第一个出生点位置
    local pos = levelParse:getBornPos(1)
    self:__initPostion(pos)
end

function BattleCamera:calcPos3D(focusNode)
    if not focusNode then
        return me.Vertex3F(self.position3D.x, self.position3D.y , self.position3D.z)
    end
    local nowPos     = focusNode:getBonePosition("point")
    local position3D = me.Vertex3F(nowPos.x, nowPos.y +  50 , self.zeye*0.85)
    --计算黄金分割线
    local dir = focusNode:getDir()
    if dir == eDir.LEFT then
        position3D.x  = position3D.x -  self.size.width*0.1 
    else
        position3D.x  = position3D.x +  self.size.width*0.1 
    end
    if dir ~= self.nDir then
        self.nDir  = dir
        self.nSlow = 0
    end
    return position3D
end

function BattleCamera:checkPos3d(focusNode,range)
    local tarPos3D     = self:calcPos3D(focusNode)
    tarPos3D.z = tarPos3D.z + self.controller.getGlobalFixZ()
    if self.fixZ then
        tarPos3D.z = tarPos3D.z + self.fixZ
    end
    --各种修正保证不露黑边
    local maxHeight = self.controller.getMaxCameraHeight()
    local maxz1     = self.zeye*maxHeight/self.size.height
    local maxz2     = self.zeye*range.size.width/self.size.width
    --纵向最大|空气墙最大|全局最大|
    tarPos3D.z = math.min(math.min(math.min(maxz1,maxz2),self.maxZ),tarPos3D.z)

    local width = self.size.width/2
    width = width*tarPos3D.z /self.zeye
    local height = self.size.height/2
    height = height*tarPos3D.z /self.zeye
    if range then
        local left  = range.origin.x
        local right = left + range.size.width
        if tarPos3D.x > right  - width  then
            tarPos3D.x = right - width
        elseif tarPos3D.x < left + width then
            tarPos3D.x = left + width
        end
    end
    -- print("tarPos3D.z",tarPos3D.z ,tarPos3D.z/self.zeye )
    --边界判定
    -- tarPos3D.x = math.max(tarPos3D.x, width)
    tarPos3D.y = math.min(tarPos3D.y, maxHeight - height)
    tarPos3D.y = math.max(tarPos3D.y, height)
    return tarPos3D
end

function BattleCamera:_update()
    local cameraMode = self.controller.getCameraMode()
    if cameraMode == eMode.FOLLOW then
        local focusNode = self.controller.getFocusNode()
        if focusNode then
            --空气墙的限制
            local airwall  = self.controller.getAirwall()
            local tarPos3D = self:checkPos3d(focusNode,airwall) --计算目标位置
            self:slowMove(tarPos3D)  --缓动到目标位置
            -- self:setPosition3D(tarPos3D)
        end
    elseif cameraMode == eMode.MANUAL then  --移动到指定位置   做指定大小缩放
        local pos3D = self.camera1:getPosition3D()
        -- self.position3D = pos3D
        -- self.controller.cameraPos3D = pos3D
        self:setPosition3D(pos3D)
    elseif cameraMode == eMode.FOLLOW_NODE then  --移动到指定位置   做指定大小缩放
        local focusNode = self.controller.getFocusNode()
        if focusNode then
            local rect = focusNode:getBoundingBox("SC")
            local size = rect.size
            local pos  = me.p(me.rectGetMidX(rect) , me.rectGetMidY(rect))
            local z    = size.height/self.size.height * self.zeye  
            local position3D = me.Vertex3F(pos.x,pos.y,z)
            -- self.position3D = position3D
            self:slowMove(position3D)  --缓动到目标位置
        end
    end
end

function BattleCamera:_offset(a, b)
    local value =  a - b
    if math.abs(value) > 0.1 then
        value = value* self.nSlow 
    end
    -- if self.nSlow > 0 then
    --     self.nSlow = self.nSlow - 1
    --     value = value * 0.5
    --     print(value)
    -- end 
    return value
end

function BattleCamera:slowMove(pos3D)
    local oldPos = self:getPosition3D()
    if oldPos then
        -- print("xxoo",(pos3D.x - oldPos.x),(pos3D.x - oldPos.x) * 0.1)
        if self.nSlow  < 0.1 then
            self.nSlow = self.nSlow + 0.001
        end
        pos3D.x = oldPos.x + self:_offset(pos3D.x , oldPos.x) 
        pos3D.y = oldPos.y + self:_offset(pos3D.y , oldPos.y) 
        pos3D.z = oldPos.z + self:_offset(pos3D.z , oldPos.z) 

    end
    self:setPosition3D(pos3D)
end

function BattleCamera:runAction(...)
    local data = {...}
    local moveTime   = data[1]
    local position3D = data[2]
    local stayTime   = data[3]
    local backTime   = data[4]
    local callBack   = data[5]

    local actions1 = {}
    local actions2 = {}
    local position = self:getPosition3D()
    table.insert(actions1, MoveTo:create(moveTime,position3D))
    table.insert(actions2, MoveTo:create(moveTime,position3D))
    if stayTime then
        table.insert(actions1,DelayTime:create(stayTime))
        table.insert(actions2,DelayTime:create(stayTime))
    end
    if backTime then
        table.insert(actions1, MoveTo:create(backTime,position))
        table.insert(actions2, MoveTo:create(backTime,position))
    end
    if callBack then
        table.insert(actions1, CallFunc:create(callBack))
    end
    self.camera1:runAction(Sequence:create(actions1))
    self.camera2:runAction(Sequence:create(actions2))
   
end


function BattleCamera:setPosition3D(pos3D)
    self.camera1:setPosition3D(pos3D)
    self.camera2:setPosition3D(pos3D)
    -- self.camera3:setPosition3D(pos3D)
    self.position3D = pos3D
    --TODO临时记录摄像机位置
    self.controller.setCameraPos3D(pos3D)
end

function BattleCamera:getPosition3D()
    return self.position3D
end

function BattleCamera:update(dt)
    if not self.isInit then
        self:initlize()
    end
    self:_update(dt)
    --摄像机修正持续时间
    if self.fixDuration > 0 then
        self.fixDuration = self.fixDuration - dt
        if self.fixDuration <= 0 then
            self.fixZ = 0
            self.fixDuration = 0
        end
    end
end

--计算角色在屏幕里的锚点
function BattleCamera:getRoleAnchorPoint()
    local hero = self.controller.getCaptain()
    if hero then
        local dsSize       = self.size
        local zeye         = self.zeye
        local cameraPos = self:getPosition3D()
        -- print("cameraPos=",cameraPos.x,cameraPos.y,cameraPos.z)
        local size = me.size(dsSize.width*cameraPos.z / zeye ,dsSize.height*cameraPos.z / zeye)
        local pos  = hero:getHitPosition()
        local point = me.p((pos.x - (cameraPos.x - size.width/2))/size.width ,  (pos.y - (cameraPos.y - size.height/2))/size.height)
        -- print("xxxxxxxx1",point.x,point.y)
        return point
    end
    return me.p(0.5,0.5)
end

--场景坐标转UI坐标
function BattleCamera:transPosition(pos)
    local dsSize       = self.size
    local zeye         = self.zeye
    local cameraPos    = self:getPosition3D()
    local size         = me.size(dsSize.width*cameraPos.z / zeye ,dsSize.height*cameraPos.z / zeye)
    local point        = me.p((pos.x - (cameraPos.x - size.width/2))/size.width ,  (pos.y - (cameraPos.y - size.height/2))/size.height)
    return me.p(dsSize.width*point.x , dsSize.height*point.y)
end


--计算摄像机的初始位置
function BattleCamera:__initPostion(focusPosition)
    local airwall  = self.controller.getAirwall()
    local node     = CCNode:create()
    node:setPosition(focusPosition) 
    --TODO 偷懒临时创建一个节点来作为Actor使用
    node.getBonePosition = node.getPosition
    node.getDir = function()
        return eDir.RIGHT
    end
    local tarPos3D = self:checkPos3d(node,airwall) --计算目标位置
    self:setPosition3D(tarPos3D)
end
return BattleCamera

