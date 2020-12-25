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
* --游乐园地图
]]

local BasicMap = import("lua.logic.mmoBasicClass.BasicMap")

local AmusementPackMapView = class("AmusementPackMapView",BasicMap)

function AmusementPackMapView:ctor( ... )
	-- body
	self.super.ctor(self, WorldRoomDataMgr:getCurControl())
end

function AmusementPackMapView:createLayers( ... )
	-- body
	self.roleGroundLayer = CCNode:create()
    self.rolePanel:addChild(self.roleGroundLayer)
	self.roleLayer = CCNode:create()
    self.rolePanel:addChild(self.roleLayer)
	self.roleEmojiLayer = CCNode:create()
    self.rolePanel:addChild(self.roleEmojiLayer)
end

function AmusementPackMapView:initMapElement( ... )
	-- body

	local npcList = self.mapParse:getNpcList()
    for k, v in ipairs(npcList) do
        local npcCfg = self.control:getNpcCfg(tonumber(v.CfgID))
        if npcCfg then
            local npcId = npcCfg.id
            local pos = me.p(v.Position.X, v.Position.Y)
            local npcData = self.control:getActorDataByPid(npcId)

            if not npcData then
                npcData = self.control:createNewEmptyData(npcId)
            end
            
            npcData.pos =  me.p(v.Position.X, v.Position.Y)
            npcData.areaRect = me.rect(0,0,v.Size.W, v.Size.H)
            self.control:updateActorData(npcData)
        end
    end

    self:createActors()
end

function AmusementPackMapView:createActors( ... )
	-- body
    self.control:checkInScreen()
end

function AmusementPackMapView:addObject( child, index )
    -- body
    if self["addObject"..index] then
        self["addObject"..index](self,child)
    end
end

function AmusementPackMapView:addObject1( child )
	-- body
    child:setCameraMask(self.roleGroundLayer:getCameraMask())
	self.roleGroundLayer:addChild(child)
end

function AmusementPackMapView:addObject2( child )
	-- body
    child:setCameraMask(self.roleLayer:getCameraMask())
	self.roleLayer:addChild(child)

    if not child.getSortY then
        child.getSortY = child.getPositionY
    end
    self.nSortCount = self.nSortCount + 1
    child._sortIndex = self.nSortCount
    table.insert(self.sortChilds, child)
    
end

function AmusementPackMapView:addObject3( child )
	-- body
    child:setCameraMask(self.roleEmojiLayer:getCameraMask())
	self.roleEmojiLayer:addChild(child)
end

function AmusementPackMapView:addObject4( child )
	-- body
    child:setCameraMask(self.bossPanel:getCameraMask())
	self.bossPanel:addChild(child)
end

function AmusementPackMapView:checkInViewByPos( pos )
    -- body
    if not pos then return false end
    local cameraSize = self.camera.size
    local cameraPos = self.camera:getPosition3D()
    local cameraPos2d = ccp(cameraPos.x,cameraPos.y)
    local _pos = ccp(pos.x - cameraPos2d.x, pos.y - cameraPos2d.y)
    if math.abs(_pos.x) < cameraSize.width/2 + 400 and math.abs(_pos.y) < cameraSize.height/2 + 400 then
        return true
    else
        return false
    end
end

function AmusementPackMapView:getMapInfoSizeAndPos(  )
    -- body
    if not self.control:getMainHero() then
        return CCSizeMake(1136,640),ccp(0,0)
    end

    local size = self.rolePanel:getContentSize()
    if size.width == 0 then
        size = CCSizeMake(1386,640)
    end

    return size,self.control:getMainHero():getPosition()
end

return AmusementPackMapView