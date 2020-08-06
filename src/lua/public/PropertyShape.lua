PropertyShape = class("PropertyShape", function()
    return CCNode:create()
end)

function PropertyShape:ctor(edgeCount, color, size, path)
    self.count  = math.max(edgeCount or 3, 3)
    self.color  = color or ccc4(1, 0, 1, 0.53)
    self.size   = size or 200
    self.radius = self.size / 2
    self.points = {}

    if TFFileUtil:existFile(path or "") then 
        self.path  = path
        self.color = ccc4(1, 1, 1, 1)
    end

    self:setSize(ccs(self.size, self.size))

    self:Draw()
end


function PropertyShape:calcPoints(props)
    local angle = 2 / self.count * math.pi
    local pos = me.pForAngle(90) * self.radius
    self.points = {}

    local ta = math.pi * 0.5
    for i = 0, self.count - 1 do 
        table.insert(self.points, me.pForAngle(ta + i * angle) * self.radius * (props[i+1] or 1))
    end
end

function PropertyShape:Draw(props)
    props = props or { 0.7, 0.9, 0.3 }

    self:calcPoints(props)

    self:removeAllChildren()

    if self.path then 
        local hsize = ccp(self.radius, self.radius)
        local verts = { hsize }
        for idx, pos in ipairs(self.points) do 
            table.insert(verts, ccp(pos) + hsize)
        end

        local indis = {}            
        for idx, pos in ipairs(self.points) do 
            table.insert(indis, 0)
            table.insert(indis, idx)
            table.insert(indis, idx + 1)
        end
        indis[#indis] = 1

        local sp = Sprite:createWithPolygon(self.path, verts, indis, ccs(self.size, self.size)):AddTo(self):ZO(-1)

    end
end