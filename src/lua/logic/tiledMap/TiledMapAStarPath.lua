
local TiledMapAStarPath = class("TiledMapAStarPath")
function TiledMapAStarPath:ctor()

end

function TiledMapAStarPath:initData(srcTiled,desTiled)

    self.srcTiled = srcTiled
    self.desTiled = desTiled

    self.openTable = {}
    self.closeTable = {}

    --以后可能会有横向和纵向移动的消耗，可以在这个修改
    self.perDistanceM,self.perDistanceN = 1,1
end

function TiledMapAStarPath:getPath()

    local reversePath = {}
    reversePath[1] = self.closeTable[#self.closeTable]
    local index = 1
    local p = self.closeTable[#self.closeTable].parent
    for i=#self.closeTable-1,1,-1 do
        if p.x == self.closeTable[i].x and p.y == self.closeTable[i].y then
            index = index + 1
            p = self.closeTable[i].parent
            reversePath[index] = self.closeTable[i]
        end
    end

    self.path = {}
    for i = 1, #reversePath do
        self.path[i] = table.remove(reversePath)
    end

    return self.path
end

--得到周围格子
function TiledMapAStarPath:getAroundTileds(tiledPos)

    local around = {}
    local aroundTileds = {}
    aroundTileds[1] = ccp(tiledPos.x-1,tiledPos.y)
    aroundTileds[2] = ccp(tiledPos.x,tiledPos.y-1)
    aroundTileds[3] = ccp(tiledPos.x,tiledPos.y+1)
    aroundTileds[4] = ccp(tiledPos.x+1,tiledPos.y)

    for k,v in ipairs(aroundTileds) do
        local isExist = TiledMapDataMgr:isExistTiled(v)
        if isExist then
            local opacity = TiledMapDataMgr:getTileOpacity(v)
            if  opacity ~= 0 then
                local isObstacle = TiledMapDataMgr:isObstacle(v)
                if not isObstacle then
                    if self.desTiled.x == v.x and self.desTiled.y == v. y then
                        table.insert(around,v)
                    else
                        local mapItem = TiledMapDataMgr:getMapItem(v.x.."-"..v.y)
                        if not mapItem then
                            table.insert(around,v)
                        end
                    end
                end
            end
        end
    end
    return around

end

--这里可以有算法优化
function TiledMapAStarPath:getMinFTiled(lastTiled)

    local minF = math.huge
    local minTiled,index
    for k,v in ipairs(self.openTable) do
        if v.valueF < minF then
            minF = v.valueF
            minTiled = v
            index = k
        end
    end

    return minTiled,k
end

function TiledMapAStarPath:isExitInTable(tiledTable,tiled)

    for i=1,#tiledTable do
        if tiled.x == tiledTable[i].x and tiled.y == tiledTable[i].y then
            return i
        end
    end
    return nil
end

function TiledMapAStarPath:equals(tiled1,tiled2)

    if tiled1.x == tiled2.x and tiled1.y == tiled2.y then
        return true
    end
    return false
end

function TiledMapAStarPath:findAStarPath()

    self.openTable = {}
    self.closeTable = {}
    table.insert(self.openTable,{x = self.srcTiled.x,y = self.srcTiled.y,valueG = 0, valueH = 0, valueF = 0, parent = nil})

    while next(self.openTable) do

        local curTiled = self:getMinFTiled()
        table.insert(self.closeTable,curTiled)
        local index = self:isExitInTable(self.openTable,curTiled)
        table.remove(self.openTable,index)

        local aroundTab = self:getAroundTileds(ccp(curTiled.x,curTiled.y))
        for k,v in ipairs(aroundTab) do
            if self:equals(v,self.desTiled) then
                table.insert(self.closeTable,{x = self.desTiled.x,y = self.desTiled.y, parent = curTiled})
                return true
            end

            --判断是否在closeTab
            if not self:isExitInTable(self.closeTable,v) then

                local valueG = curTiled.valueG + TiledMapDataMgr:calcValueDis(curTiled, v)
                local valueH = TiledMapDataMgr:calcValueDis(v,self.desTiled)
                local valueF = valueG + valueH

                local index = self:isExitInTable(self.openTable,v)
                if not index then
                    local tiledInfo = {x = v.x,y = v.y,valueG = valueG, valueH = valueH, valueF = valueF, parent = curTiled}
                    table.insert(self.openTable,tiledInfo)
                else
                    local tiledInOpenTab = self.openTable[index]
                    if valueG < tiledInOpenTab.valueG then
                        tiledInOpenTab.parent = curTiled
                        tiledInOpenTab.valueG = valueG
                    end
                end
            end
        end
    end
    return false
end

return TiledMapAStarPath