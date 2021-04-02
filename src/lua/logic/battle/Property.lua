local BattleConfig  = import(".BattleConfig")
local enum      = import(".enum")
local eAttrType = enum.eAttrType
local eRoleType = enum.eRoleType
local Property = class("Property")

local MinValue = -0xFFFFFF
local MaxValue = 0xFFFFFF

--属性变更过滤器
local filter_attrs =
{
    [eAttrType.ATTR_HURT]     = eAttrType.ATTR_HURT,
    [eAttrType.ATTR_REV_HURT] = eAttrType.ATTR_REV_HURT,
}

-- print (CBit.And(1, 2))
-- print (CBit.Or(1, 2))
-- print (CBit.Xor(3, 2))
-- print (CBit.Lshift(1, 2))
-- print (CBit.Rshift(100, 2))
-- print (CBit.Not(1))








function Property:ctor()
    --所有属性
    self.attr = {}
    for k , attrType in pairs(eAttrType) do
        self.attr[attrType] = 0
    end
    self.valueRange = {}
    --属性默认取值范围
    for k , attrType in pairs(eAttrType) do
        self.valueRange[attrType] = {minValue = MinValue,maxValue = MaxValue}
    end
end


function Property:preAttrs100()
    for attrId, value in pairs(self.attr) do
        if attrId < 100 then
            local value = math.floor(self.attr[attrId]*0.01)
            self.attr[attrId] = value
        end
    end
end




--设置属性取值范围
function Property:setRange(attrType,minValue,maxValue)
    self.valueRange[attrType] = {minValue = minValue,maxValue = maxValue}
end

function Property:getValue(attrType)
    if not self.attr[attrType] then
        print("xxxxxxxxxxxxxx不存在的属性类型"..tostring(attrType))
        self.attr[attrType] = 0
        return 0
    end
    return self.attr[attrType]
end

function Property:setValue(attrType,value)
    -- print(string.format("setValue(%s,%s)",attrType,value))
    
    -- local oldValue = self.attr[attrType]
    -- if not oldValue then
    --     print("xxxxxxxxxxxxxx不存在的属性类型"..tostring(attrType))
    -- end
    self.attr[attrType] = math.floor(value)
end

function Property:_changeValue(attrType,value)
    local oldValue = self:getValue(attrType)
    value = oldValue + value
    self:setValue(attrType,value)
end

function Property:changeValue(attrType,value)
    self:_changeValue(attrType,value)
end

function Property:parseFrom(data,host)
    -- dump(data,"data")
    if data.roleType == eRoleType.Monster then
        local level = math.max(data.level,1)
        local monsterType = data.monsterType
        print("MonsterLevel ID:",monsterType)
        local attrInfo = TabDataMgr:getData("MonsterLevel",monsterType)
        if host then  --召唤怪
            print("召唤怪 属性："..host:getName() .." callType: "..tostring(data.callType))
            local callType = data.callType
            if callType == 0 then 
                for key , value in pairs (attrInfo.baseAttr) do
                    self:setValue(key,value)
                end
                for key , value in pairs (attrInfo.upAttr) do
                    local _value = value*(level+2)^1.5*0.5
                    self:_changeValue(key,_value)
                end
                --属性除以100预处理
                self:preAttrs100()
            elseif callType == 1 then --角色基础属性
                for key , ratio in pairs (attrInfo.callAttr) do
                    local value = host:getBaseValue(key)
                    self:setValue(key,value*ratio*0.0001)
                end
            elseif callType == 2 then --角色当前属性
                for key , ratio in pairs (attrInfo.callAttr) do
                    local value = host:getValue(key)
                    self:setValue(key,value*ratio*0.0001)
                end
            end
        else --普通刷怪
            for key , value in pairs (attrInfo.baseAttr) do
                 self:setValue(key,value)
            end
            for key , value in pairs (attrInfo.upAttr) do
                local _value = value*(level+2)^1.5*0.5
                self:_changeValue(key,_value)
            end
            --属性除以100预处理
            self:preAttrs100()
        end


        local hpValue  = self:getValue(eAttrType.ATTR_MAX_HP)*(1+self:getValue(eAttrType.ATTR_MAX_HP_RATIO)*0.0001)
        if data.initialhp and data.initialhp ~= 100 then --百分比
            hpValue = hpValue * data.initialhp * 0.01  
        end
        self:setValue(eAttrType.ATTR_NOW_HP,hpValue)
        -- local agrValue = self:getValue(eAttrType.ATTR_MAX_AGR)*(1+self:getValue(eAttrType.ATTR_MAX_AGR_RATIO)*0.0001)
        -- self:setValue(eAttrType.ATTR_NOW_AGR,agrValue)
        --初始护盾值
        local sldValue = self:getValue(eAttrType.ATTR_SLD)*(1+self:getValue(eAttrType.ATTR_SLD_RATIO)*0.0001)
        self:setValue(eAttrType.ATTR_NOW_SLD,sldValue)
        --最大抵挡值初始化为最大HP
        -- self:setValue(eAttrType.ATTR_MAX_RST,hpValue)
    else
        local tempAttr = {}
        if data.attr then
            for key , value in pairs (data.attr) do
                table.insert( tempAttr, {key= key ,value = value}) 
            end
        else
            for key , value in pairs (data.attr) do
                table.insert( tempAttr, {key= key ,value = value}) 
            end
        end



        -- print("Hero DATA",data.attr)
        for _ , attr in ipairs (tempAttr) do
            self:setValue(attr.key,attr.value)
        end
        self:preAttrs100()
        local hpValue  = self:getValue(eAttrType.ATTR_MAX_HP)*(1+self:getValue(eAttrType.ATTR_MAX_HP_RATIO)*0.0001)
        -- print(self:getValue(eAttrType.ATTR_MAX_HP),"*",(1+self:getValue(eAttrType.ATTR_MAX_HP_RATIO)*0.0001))
        if data.attrScale then
            local percent = data.attrScale[eAttrType.ATTR_NOW_HP]
            if percent then
                hpValue = hpValue * percent * 0.0001
            end
        end
        self:setValue(eAttrType.ATTR_NOW_HP,hpValue)
        -- local agrValue = self:getValue(eAttrType.ATTR_MAX_AGR)*(1+self:getValue(eAttrType.ATTR_MAX_AGR_RATIO)*0.0001)
        -- self:setValue(eAttrType.ATTR_NOW_AGR,agrValue)
        --初始护盾值
        local sldValue = self:getValue(eAttrType.ATTR_SLD)*(1+self:getValue(eAttrType.ATTR_SLD_RATIO)*0.0001)
        self:setValue(eAttrType.ATTR_NOW_SLD,sldValue)
        --最大抵挡值初始化为最大HP
        -- self:setValue(eAttrType.ATTR_MAX_RST,hpValue)
    end

end

--清零(零食属性)
function Property:clean()
    for k , v in pairs(self.attr) do
        self:setValue(k,0)
    end
end

return Property

