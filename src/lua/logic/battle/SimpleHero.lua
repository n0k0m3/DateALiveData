local Property   = import(".PropertyEx")
local enum       = import(".enum")
local eEvent     = enum.eEvent
local eAttrType   = enum.eAttrType
local SimpleHero = class("SimpleHero")


function SimpleHero:ctor(data)
    self.data = data
    --基础属性
    self.property = Property.new()
    self.property:parseFrom(self.data,host)
end
function SimpleHero:getPID()
    return self.data.pid
end

function SimpleHero:getName()
    return self.data.strName
end
function SimpleHero:getPName()
    return self.data.pname or ""
end

function SimpleHero:getHpPercent()
    return self.property:getValue(eAttrType.ATTR_NOW_HP)*10000 /self.property:getValue(eAttrType.ATTR_MAX_HP)
end


function SimpleHero:isAlive()
    return self.property:getValue(eAttrType.ATTR_NOW_HP)> 0
end
function SimpleHero:isDead()
    return not self:isAlive()
end


function SimpleHero:getData()
    return self.data
end

--角色状态修正
function SimpleHero:fix( posX , posY , dir , hp, state)
    if hp then
        self:setValue(eAttrType.ATTR_NOW_HP,hp,true)
    end
end

--伤害修正 组队状态同步用
function SimpleHero:fixHurtValue(value)
    if self.data.hurtValue then
        self.data.hurtValue = 0
    end
    if value > self.data.hurtValue then
        self.data.hurtValue = value
    end
    EventMgr:dispatchEvent(eEvent.EVENT_STATUS_HERO,self) 
end

function SimpleHero:getHurtValue()
    return self.data.hurtValue or 0
end


function SimpleHero:setValue(attrType,value,event)
    self.property:setValue(attrType,value)
    if event then
        self.property:doChange(attrType,0)
    end
end

function SimpleHero:setRokeVector()

end

function SimpleHero:excuteFrameData()

end

function SimpleHero:createAndPush()
    -- body
end

function SimpleHero:excuteAction(action)
    if action == 1 then --离开队伍
        self:setValue(eAttrType.ATTR_NOW_HP,0 ,true)
        battleController.removeSimpleHero(self)
    end
end

function SimpleHero:getRevHurtValue()
    return 8888
end

return SimpleHero


---TODO 优化处理追猎计划不需要同步角色操作 和 位置 只需要同步角色 血量 和伤害