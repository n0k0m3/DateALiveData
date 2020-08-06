me = me or {}
me.Physics = {
    PHYSICSBODY_MATERIAL_DEFAULT = { 
        density     = 0.1,
        restitution = 0.5,
        friction    = 0.5, 
    },
    PHYSICSSHAPE_MATERIAL_DEFAULT = { density = 0, restitution = 0, friction = 0, }
}

me.Physics.Material = function(density, restitution, friction)
    local ret       = { 
        density     = density or 0,
        restitution = restitution or 0,
        friction    = friction or 0,
    }

    return ret
end



me.Physics.RayCastInfo = function(shape, st, ed, contact, normal)
    local ret   = { 
        shape   = shape or nil,
        st      = st or ccp(0, 0),
        ed      = ed or ccp(0, 0),
        contact = contact or ccp(0, 0),
        normal  = normal or ccp(0, 0),
    }

    return ret
end