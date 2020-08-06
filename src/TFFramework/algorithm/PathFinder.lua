PathFinder = class("PathFinder")

function PathFinder:ctor(path, drawNode, bs)
    path = me.FileUtils:fullPathForFilename(path)
    if TFFileUtil:existFile(path) then 
        self.astar = AStar:new(path)
    end

    self.drawNode = drawNode
    self.BS = bs or 20
    self.HBS = self.BS / 2
end

function PathFinder:SetBlockSize(bs)
    self.BS = bs or 20
    self.HBS = self.BS / 2

    self:RebuildDebugDraw()
end

function PathFinder:RebuildDebugDraw(path, st)
    if not self.astar then return end   
    local astar = self.astar 
    local pathNode = self.drawNode 
        
    local BS = self.BS    
    local HBS = self.HBS
    if pathNode then pathNode:clear() end
    if pathNode then
        local col = astar:getWidth()
        local row = astar:getHeight()
        for i = 0, col -1 do 
            local x = BS * i
            for j = 0, row-1 do 
                local y = BS * j
                if astar:get(j, i) > 0 then 
                    pathNode:drawSolidRect(ccp(x, y), ccp(x, y) + ccp(BS, BS), ccc4(1, 0, 1, 0.5))
                else 
                    pathNode:drawSolidRect(ccp(x, y), ccp(x, y) + ccp(BS, BS), ccc4(0, 1, 1, 0.5))
                end
            end
        end
        path = path or {}
        for i = 1, #path do 
            pathNode:drawSolidCircle(path[i], 5, 360, 36, ccc4(1, 0, 0, 1))
        end

        -- if st then 
        --     local rowX = math.ceil(st.y / BS)
        --     local colX = math.ceil(st.x / BS)
        --     TFLuaTime:b()
        --     local fd = self.astar:findRandomPos(rowX, colX, 10, 30)
        --     TFLuaTime:e("---:")

        --     local pos = ccp(fd.x * BS, fd.y * BS)

        --     print(fd, pos, rowX, colX)
        --     pathNode:drawSolidCircle(pos, 5, 360, 36, ccc4(1, 0, 1, 1))
        -- end


        for i = 1, #path - 1 do 
            pathNode:drawLine(path[i], path[i+1], ccc4(0, 0, 1, 1))
        end
    end
end

function PathFinder:find(st, ed)
    if not self.astar then return {} end
    local astar = self.astar
    local pathNode = self.drawNode        
    local BS = self.BS
    local rowX = math.floor(st.y / BS)
    local colX = math.floor(st.x / BS)
    local rowY = math.floor(ed.y / BS)
    local colY = math.floor(ed.x / BS)

    local ret = astar:find(colX, rowX, colY, rowY)
        
    if ret[0] then 
        local tmp = {}
        for i = 0, #ret do 
            ret[i].x = ret[i].x * BS + self.HBS
            ret[i].y = ret[i].y * BS + self.HBS
            table.insert(tmp, ret[i])
        end
        ret = tmp
    end
    
    self:RebuildDebugDraw(ret, st)

    return ret
end

function PathFinder:Activate(blocks)
    if not self.astar then return end
    blocks = blocks or {}
    for i = 1, #blocks, 2 do 
        local row = blocks[i] or 0
        local col = blocks[i+1] or 0
        local val = self.astar:get(row, col)
        self.astar:set(row, col, val + 1)
    end
    self:RebuildDebugDraw()
end

function PathFinder:DeActivate(blocks)
    if not self.astar then return end
    blocks = blocks or {}
    for i = 1, #blocks, 2 do 
        local row = blocks[i] or 0
        local col = blocks[i+1] or 0
        local val = self.astar:get(row, col)
        if val > 0 then val = val - 1 end
        self.astar:set(row, col, val)
    end
    self:RebuildDebugDraw()
end

return PathFinder