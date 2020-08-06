
module("Triangulate", package.seeall)

local EPSILON = 1.0e-6

  --------------------------------------------------------------
  -- Vertex class
  --------------------------------------------------------------

Vertex = class("Vertex")

function Vertex:ctor(x, y)
    self.x = x
    self.y = y
end

  --------------------------------------------------------------
  -- Triangle class
  --------------------------------------------------------------

Triangle = class("Triangle")

function Triangle:ctor(v0, v1, v2)
    self.v0 = v0
    self.v1 = v1
    self.v2 = v2

    self:calcCircumcircle()
end

function Triangle:calcCircumcircle()
    -- From: http://www.exaflop.org/docs/cgafaq/cga1.html

    local A = self.v1.x - self.v0.x
    local B = self.v1.y - self.v0.y
    local C = self.v2.x - self.v0.x
    local D = self.v2.y - self.v0.y

    local E = A * (self.v0.x + self.v1.x) + B * (self.v0.y + self.v1.y)
    local F = C * (self.v0.x + self.v2.x) + D * (self.v0.y + self.v2.y)

    local G = 2.0 * (A * (self.v2.y - self.v1.y) - B * (self.v2.x - self.v1.x))

    local dx, dy

    if (math.abs(G) < EPSILON) then
        -- Collinear - find extremes and use the midpoint

        local minx = math.min(self.v0.x, self.v1.x, self.v2.x)
        local miny = math.min(self.v0.y, self.v1.y, self.v2.y)
        local maxx = math.max(self.v0.x, self.v1.x, self.v2.x)
        local maxy = math.max(self.v0.y, self.v1.y, self.v2.y)

        self.center = Vertex:new((minx + maxx) / 2, (miny + maxy) / 2)

        dx = self.center.x - minx
        dy = self.center.y - miny
    else
        local cx = (D * E - B * F) / G
        local cy = (A * F - C * E) / G

        self.center = Vertex:new(cx, cy)

        dx = self.center.x - self.v0.x
        dy = self.center.y - self.v0.y
    end

    self.radius_squared = dx * dx + dy * dy
    self.radius = math.sqrt(self.radius_squared)
end

function Triangle:inCircumcircle(v)
    local dx = self.center.x - v.x
    local dy = self.center.y - v.y
    local dist_squared = dx * dx + dy * dy

    return (dist_squared <= self.radius_squared)
end

--------------------------------------------------------------
-- Edge class
--------------------------------------------------------------

Edge = class("Edge")

function Edge:ctor(v0, v1)
    self.v0 = v0
    self.v1 = v1
end

function Edge:equals(other)
    return (self.v0 == other.v0 and self.v1 == other.v1)
end

function Edge:inverse()
    return Edge:new(self.v1, self.v0)
end

--------------------------------------------------------------
-- triangulate
--
-- Perform the Delaunay Triangulation of a set of vertices.
--
-- vertices: Array of Vertex objects
--
-- returns: Array of Triangles
--------------------------------------------------------------
function Triangulate(vertices)
    local triangles = {}

    --
    -- First, create a "supertriangle" that bounds all vertices
    --
    local st = createBoundingTriangle(vertices)

    table.insert(triangles, st)

    --
    -- Next, begin the triangulation one vertex at a time
    --
    table.walk(vertices, function(vertex)
        -- NOTE: self is O(n^2) - can be optimized by sorting vertices
        -- along the x-axis and only considering triangles that have 
        -- potentially overlapping circumcircles
        triangles = addVertex(vertex, triangles)
    end)

    --
    -- Remove triangles that shared edges with "supertriangle"
    --
    triangles = table.filterArray(triangles, function(triangle)
        return not (
            triangle.v0 == st.v0 or triangle.v0 == st.v1 or triangle.v0 == st.v2 or
            triangle.v1 == st.v0 or triangle.v1 == st.v1 or triangle.v1 == st.v2 or
            triangle.v2 == st.v0 or triangle.v2 == st.v1 or triangle.v2 == st.v2
        )
    end)

    return triangles
end

-- Internal: create a triangle that bounds the given vertices, with room to spare
function createBoundingTriangle(vertices)
    -- NOTE: There's a bit of a heuristic here. If the bounding triangle 
    -- is too large and you see overflow/underflow errors. If it is too small 
    -- you end up with a non-convex hull.

    local minx, miny, maxx, maxy
    table.walk(vertices, function(vertex)
        if (minx == nil or vertex.x < minx) then minx = vertex.x end
        if (miny == nil or vertex.y < miny) then miny = vertex.y end
        if (maxx == nil or vertex.x > maxx) then maxx = vertex.x end
        if (maxy == nil or vertex.y > maxy) then maxy = vertex.y end
    end)

    local dx = (maxx - minx) * 10
    local dy = (maxy - miny) * 10

    local stv0 = Vertex:new(minx - dx, miny - dy * 3)
    local stv1 = Vertex:new(minx - dx, maxy + dy)
    local stv2 = Vertex:new(maxx + dx * 3, maxy + dy)

    return Triangle:new(stv0, stv1, stv2)
end

-- Internal: update triangulation with a vertex 
function addVertex(vertex, triangles)
    local edges = {}

    -- Remove triangles with circumcircles containing the vertex

    triangles = table.filterArray(triangles, function(triangle)
        if (triangle:inCircumcircle(vertex)) then
            table.insert(edges, Edge:new(triangle.v0, triangle.v1))
            table.insert(edges, Edge:new(triangle.v1, triangle.v2))
            table.insert(edges, Edge:new(triangle.v2, triangle.v0))
            return false
        end

        return true
    end)

    edges = uniqueEdges(edges)

    -- Create Triangle:news from the unique edges and Vertex:new
    table.walk(edges, function(edge)
        table.insert(triangles, Triangle:new(edge.v0, edge.v1, vertex))
    end)

    return triangles
end

-- Internal: remove duplicate edges from an array
function uniqueEdges(edges)
    -- TODO: self is O(n^2), make it O(n) with a hash or some such
    local uniqueEdges = {}
    for i = 1, #edges do
        local edge1 = edges[i]
        local unique = true

        for j = 1, #edges do
            if (i ~= j) then            
                local edge2 = edges[j]
                if (edge1:equals(edge2) or edge1:inverse():equals(edge2)) then
                    unique = false
                    break
                end
            end
        end

        if (unique) then
            table.insert(uniqueEdges, edge1)
        end
    end

    return uniqueEdges
end
