local _insert = table.insert
module("Polygon", package.seeall)

function vec(x, y)
    return {x = x, y = y}
end
 
function dot(v1, v2)
    return v1.x*v2.x + v1.y*v2.y
end
 
function normalize(v)
    local mag = math.sqrt(v.x^2 + v.y^2)
    return vec(v.x/mag, v.y/mag)
end
 
function perp(v)
    return {x = v.y, y = -v.x}
end
 
function segment(a, b)
    local obj = {a=a, b=b}
    obj.x = b.x - a.x
    obj.y = b.y - a.y
    return obj
end
 
function polygon(vertices)
    local obj = {}
    obj.vertices = vertices
    obj.edges = {}
    for i=1, #vertices do
        _insert(obj.edges, segment(vertices[i], vertices[1+i%(#vertices)]))
    end
    return obj
end

function project(a, axis)
    local min = dot(a.vertices[1],axis)
    local max = min
    for i,v in ipairs(a.vertices) do
        local proj =  dot(v, axis) -- projection
        if proj < min then min = proj end
        if proj > max then max = proj end
    end
 
    return {min, max}
end
 
function overlap(a_, b_)
    if a_[1] >= b_[1] and a_[1] <= b_[2] then return true
    elseif a_[2] >= b_[1] and a_[2] <= b_[2] then return true
    elseif b_[1] >= a_[1] and b_[1] <= a_[2] then return true
    elseif b_[2] >= a_[1] and b_[2] <= a_[2] then return true
    end
    return false
end

function sat(a, b)
    for i,v in ipairs(a.edges) do
        local axis = perp(v)
        axis = normalize(axis)
        local a_, b_ = project(a, axis), project(b, axis)
        if not overlap(a_, b_) then return false end
    end
    for i,v in ipairs(b.edges) do
        local axis = perp(v)
        axis = normalize(axis)
        local a_, b_ = project(a, axis), project(b, axis)
        if not overlap(a_, b_) then return false end
    end
 
    return true
end

function IntersectLua(pts1, pts2)   
    if pts1[#pts1] == pts1[1] then table.remove(pts1, #pts1) end
    if pts2[#pts2] == pts2[1] then table.remove(pts2, #pts2) end

    local plg1 = polygon(pts1)
    local plg2 = polygon(pts2)
    return sat(plg1, plg2)
end

function Intersect(pts1, pts2) 
    if pts1[#pts1] == pts1[1] then table.remove(pts1, #pts1) end
    if pts2[#pts2] == pts2[1] then table.remove(pts2, #pts2) end

    return (CCNode.PolygonIntersect or IntersectLua)(pts1, pts2)
end


-- local pts1 = { ccp(0, 0), ccp(100, 0), ccp(100, 100), ccp(0, 100) }
-- local pts2 = { ccp(10, 10), ccp(90, 10), ccp(90, 90), ccp(10, 90) }
-- local ret2 = Intersect(pts1, pts2)
-- print(ret2)