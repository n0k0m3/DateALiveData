local BattleConfig  = import(".BattleConfig")
local BattleUtils  = import(".BattleUtils")
local Property  = import(".Property")
local enum      = import(".enum")
local eAttrType = enum.eAttrType
local eRoleType = enum.eRoleType
local eBFState = enum.eBFState
local print = BattleUtils.print
local PropertyEx = class("PropertyEx")

local AttrFullEvent = {}
AttrFullEvent[eAttrType.ATTR_NOW_ENERGY] = eBFState.E_ATTR_FULL_56

local AttrEmptyEvent = {}
AttrEmptyEvent[eAttrType.ATTR_NOW_ENERGY] = eBFState.E_ATTR_EMPTY_56

function PropertyEx:ctor()
    self.basePro = Property:new()
    self.dynaPro = Property:new()  --修改的属性
    self.tempPro = Property:new()  --临时属性
    self.expandPro = Property:new()  --扩展属性(音乐小游戏属性加成)
    --属性变更监听器
    self.listener = nil
end

--设置属性变更监听器
function PropertyEx:setListener(listener)
    self.listener = listener
end

function PropertyEx:doChange(attrType,value,event)
    if attrType < 100 or attrType > 2000 or attrType == 503 or attrType == 507 then
        if self.listener then
            self.listener(attrType,value,event)
            if attrType == eAttrType.ATTR_NOW_HP then
                self.listener(eAttrType.ATTR_NOW_HP_PERCENT,0)
            end
        end
    end
end

local function mapToList2(map)
    local list = {}
    for key , value in pairs(map) do
        table.insert( list , {key = key,value =value } )
    end
    return list
end

local function mapToList(map)
    local list = {}
    for key , value in pairs(map) do
        table.insert( list ,value )
    end
    table.sort(list)
    return list
end

--所有属性变更通知
function PropertyEx:dispatchChange()
    local list = mapToList(eAttrType)
    for _ , attrType in ipairs(list) do
        local value = self:getValue(attrType)
        -- if value > 0 then  --负责属性触发天赋buffer
            self:doChange(attrType,value)
        -- end
    end
end

function PropertyEx:parseFrom(data,host)
    self.basePro:parseFrom(data,host)
    self.dynaPro:setValue(eAttrType.ATTR_NOW_AGR,self.basePro:getValue(eAttrType.ATTR_NOW_AGR))
    self.dynaPro:setValue(eAttrType.ATTR_NOW_HP,self.basePro:getValue(eAttrType.ATTR_NOW_HP))
    self.dynaPro:setValue(eAttrType.ATTR_NOW_SLD,self.basePro:getValue(eAttrType.ATTR_SLD))
    self.dynaPro:setValue(eAttrType.ATTR_NOW_ENERGY,self.basePro:getValue(eAttrType.ATTR_NOW_ENERGY))
end

--算出来的
function PropertyEx:getValue(attrType)
    local value = 0
    if attrType < 50 then
        local baseValue = self.basePro:getValue(attrType) + self.dynaPro:getValue(attrType)
        local ratio     = self.basePro:getValue(attrType + 1000) + self.dynaPro:getValue(attrType+1000)
        value = baseValue*(1 + ratio*0.0001)
    elseif attrType > 50 and attrType < 100 then  --血和怒气和
        value = self.dynaPro:getValue(attrType)
    elseif attrType > 500 and attrType < 1000 then
        value = self.basePro:getValue(attrType) + self.dynaPro:getValue(attrType)
    elseif attrType > 1000 and attrType < 2000 then
        value = self.basePro:getValue(attrType) + self.dynaPro:getValue(attrType)
    elseif attrType > 2000 then --临时属性(常驻)
        if attrType == eAttrType.ATTR_LOASS_HP then                  --失血
            value = self:getLossHp()
        elseif attrType == eAttrType.ATTR_NOW_HP_PERCENT then              -- 当前血量百分比
            value = self:getHpPercent()
        elseif attrType == eAttrType.ATTR_LOASS_HP_PERCENT then        -- 当前血量损失的百分比
            value = self:getLossHpPercent()
        elseif attrType == eAttrType.ATTR_NOW_SPEED_PERCENT then       --当前速度百分比
            value = self:getSpeedPercent()
        elseif attrType == eAttrType.ATTR_NOW_HURT_PERCENT then
            value = self:getHurtPercent()
        else
            value = self.dynaPro:getValue(attrType)
        end
    end
    --附加临时属性(非常驻)
    if attrType < 2001 then
        value = value + self.tempPro:getValue(attrType) 
    end
    --TODO 扩展属性只考虑觉醒技能加成比
    if attrType == eAttrType.ATTR_DMADD_JX then
        value = value + self.expandPro:getValue(attrType) 
    end
    return math.floor(value)
end

--临时属性值
function PropertyEx:getTampValue(attrType)
    return self.tempPro:getValue(attrType)
end 

function PropertyEx:setTempValue(attrType,value)
    return self.tempPro:setValue(attrType,value)
end

function PropertyEx:changeTempValue(attrType,value)
    if DEBUG then
        print(string.format("TEAMP ATTR[%s]+%s  CURRENT=%s ",attrType, value ,self:getTampValue(attrType)))
    end
    return self.tempPro:changeValue(attrType,value)
end
--清空临时属性值
function PropertyEx:cleanTemp()
    return self.tempPro:clean()
end



--扩展属性值
function PropertyEx:getExpandValue(attrType)
    return self.expandPro:getValue(attrType)
end 

function PropertyEx:setExpandValue(attrType,value)
    -- printError("setExpandValue:"..tostring(attrType).." -- "..tostring(value))
    return self.expandPro:setValue(attrType,value)
end

--清空临时属性值
function PropertyEx:cleanExpand()
    return self.expandPro:clean()
end

function PropertyEx:getBaseValue(attrType)
    return self.basePro:getValue(attrType)
end

function PropertyEx:setBaseValue(attrType,value)
    return self.basePro:setValue(attrType,value)
end
-- 计算Calculation
function PropertyEx:calcuPlusValue(attrType,value)
    if attrType < 50 then
        value = value*(1 + self:getValue(attrType + 1000)*0.0001)
    elseif attrType == eAttrType.ATTR_NOW_SLD then
        value = value*(1 + self:getValue(eAttrType.ATTR_SLD_RATIO)*0.0001)
    end
    return value
end
function PropertyEx:changeValue(attrType,value)
    local lastValue = self:getValue(attrType)
    value = math.floor(value)
    local _changeValue = value
    if value == 0 then
        return value
    end
    if attrType < 50 then
        local tmpValue = self:getValue(attrType)
        self.dynaPro:changeValue(attrType,value)
        if attrType == eAttrType.ATTR_MAX_HP then
            tmpValue = self:getValue(attrType) - tmpValue
            if tmpValue > 0 then
                self:changeValue(eAttrType.ATTR_NOW_HP,tmpValue)
            else
                self:fixAttr(eAttrType.ATTR_NOW_HP)
                self:fixAttr(eAttrType.ATTR_NOW_SLD)
            end

        elseif attrType == eAttrType.ATTR_MAX_AGR then
            tmpValue = self:getValue(attrType) - tmpValue
            if tmpValue > 0 then
                self:changeValue(eAttrType.ATTR_NOW_AGR,tmpValue)
            else
                self:fixAttr(eAttrType.ATTR_NOW_AGR)
            end
        end
    elseif attrType == eAttrType.ATTR_NOW_AGR then
        if value > 0 then --怒气恢复加成
            value = value*(1 + self:getValue(eAttrType.ATTR_RECOVER_AGR_RATIO)*0.0001) + self:getValue(eAttrType.ATTR_RECOVER_AGR)
        end
        self.dynaPro:changeValue(attrType,value)
    elseif attrType == eAttrType.ATTR_NOW_HP then
        if value > 0 then --治疗加成
            value = value*(1 + self:getValue(eAttrType.ATTR_TREATMENT_RATE)*0.0001)
        end
        self.dynaPro:changeValue(attrType,value)
    elseif attrType == eAttrType.ATTR_NOW_SLD then
        if value > 0 then --护盾计算加成
            value = value*(1 + self:getValue(eAttrType.ATTR_SLD_RATIO)*0.0001)
        end
        self.dynaPro:changeValue(attrType,value)

    elseif attrType == eAttrType.ATTR_MAX_HP_RATIO then
        tmpValue = self:getValue(eAttrType.ATTR_MAX_HP)
        self.dynaPro:changeValue(attrType,value)
        tmpValue = self:getValue(eAttrType.ATTR_MAX_HP) - tmpValue
        if tmpValue > 0 then
            self:changeValue(eAttrType.ATTR_NOW_HP,tmpValue)
        else
            self:fixAttr(eAttrType.ATTR_NOW_HP)
            self:fixAttr(eAttrType.ATTR_NOW_SLD)
        end
    elseif attrType == eAttrType.ATTR_MAX_AGR_RATIO then
        self.dynaPro:changeValue(attrType,value)
        self:fixAttr(eAttrType.ATTR_NOW_AGR)
    elseif attrType == eAttrType.ATTR_SUPER_ENERGY_LEVEL then 
        if self:getValue(eAttrType.ATTR_SUPER_ENERGY) > 0 then
            self.dynaPro:changeValue(attrType,value)
        end
    elseif attrType == eAttrType.ATTR_SUPER_ENERGY then 
        if value > 0 then
            if self:getValue(eAttrType.ATTR_NOW_ENERGY) > 0 then
                self.dynaPro:changeValue(attrType,value)
            end
        else
            self.dynaPro:changeValue(attrType,value)
        end
    else
        self.dynaPro:changeValue(attrType,value)
    end
    
    local event = self:checkFullOrEmptyEvent(attrType,lastValue)
    self:fixAttr(attrType)
    self:doChange(attrType,value,event)
    if DEBUG == 1 then
        if _changeValue > 0 then 
            print(string.format("ATTR[%s]+%s=%s",attrType,_changeValue ,self:getValue(attrType)))
        else
            print(string.format("ATTR[%s]%s=%s",attrType,_changeValue ,self:getValue(attrType)))
        end
    end
    return value
end

function PropertyEx:checkFullOrEmptyEvent(attrType,lastValue)
    local nowValue = self:getValue(attrType)
    local minValue = 0
    local maxValue = 0 
    if attrType == eAttrType.ATTR_NOW_ENERGY then
        minValue = 0
        maxValue = self:getValue(eAttrType.ATTR_MAX_ENERGY)
    end
    if lastValue < maxValue and nowValue >= maxValue then
        return AttrFullEvent[attrType] or 0
    elseif lastValue > minValue and nowValue <= minValue then
        return AttrEmptyEvent[attrType] or 0
    end
    return 0
end

function PropertyEx:fixAttr(attrType)
    if attrType == eAttrType.ATTR_NOW_AGR then
        local value    = self.dynaPro:getValue(attrType)
        local maxValue = self:getValue(eAttrType.ATTR_MAX_AGR)
        value = math.max(0,value)
        value = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_NOW_AGR,value)
    elseif attrType == eAttrType.ATTR_NOW_HP then
        local value = self.dynaPro:getValue(attrType)
        local maxValue = self:getValue(eAttrType.ATTR_MAX_HP)
        value = math.max(0,value)
        value = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_NOW_HP,value)
    elseif attrType == eAttrType.ATTR_NOW_SLD then
        local value    = self.dynaPro:getValue(eAttrType.ATTR_NOW_SLD)
        local maxValue = self:getValue(eAttrType.ATTR_MAX_HP)
        value = math.max(0,value)
        value = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_NOW_SLD,value)
    elseif attrType == eAttrType.ATTR_NOW_ENERGY then
        local value    = self.dynaPro:getValue(eAttrType.ATTR_NOW_ENERGY)
        local maxValue = self:getValue(eAttrType.ATTR_MAX_ENERGY)
        value = math.max(0,value)
        value = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_NOW_ENERGY,value)
    elseif attrType == eAttrType.ATTR_NOW_RST then
        local value    = self.dynaPro:getValue(eAttrType.ATTR_NOW_RST)
        local maxValue = self:getValue(eAttrType.ATTR_MAX_RST)
        value = math.max(0,value)
        value = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_NOW_RST,value)
    elseif attrType == eAttrType.ATTR_FIRE_SPIRIT_NUM then --取值范围[0-5]
        local value = self.dynaPro:getValue(attrType)
        value = math.max(0,value)
        value = math.min(value,5)
        self.dynaPro:setValue(attrType,value)
    elseif attrType == eAttrType.ATTR_BASE_FIRE_DAMAGE 
        or attrType == eAttrType.ATTR_BASE_BLEED_DAMAGE then --取值范围[0-无限大]
        local value = self.dynaPro:getValue(attrType)
        value = math.max(0,value)
        self.dynaPro:setValue(attrType,value)
    elseif attrType == eAttrType.ATTR_DESPAIR 
        or attrType == eAttrType.ATTR_MAX_DESPAIR then 
        local value    = self.dynaPro:getValue(eAttrType.ATTR_DESPAIR)
        local maxValue = self.dynaPro:getValue(eAttrType.ATTR_MAX_DESPAIR)
        maxValue = math.max(0,maxValue)
        value    = math.max(0,value)
        value    = math.min(value,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_MAX_DESPAIR,maxValue)
        self.dynaPro:setValue(eAttrType.ATTR_DESPAIR,value)
    elseif attrType == eAttrType.ATTR_2105 then --取值范围[0-5]
        local value = self.dynaPro:getValue(attrType)
        value = math.max(0,value)
        value = math.min(value,5)
        self.dynaPro:setValue(attrType,value)
    elseif attrType == eAttrType.ATTR_SUPER_ENERGY then --取值范围[0-100]
        local value = self.dynaPro:getValue(attrType)
        value = math.max(0,value)
        value = math.min(value,100)
        self.dynaPro:setValue(attrType,value)
        if self:getValue(eAttrType.ATTR_SUPER_ENERGY) <= 0 then
            self:setValue(eAttrType.ATTR_SUPER_ENERGY_LEVEL,0)
        end
    elseif attrType == eAttrType.ATTR_SUPER_ENERGY_LEVEL then --取值范围[0-5]
        local value = self.dynaPro:getValue(attrType)
        value = math.max(0,value)
        value = math.min(value,5)
        self.dynaPro:setValue(attrType,value)
    end
end

function PropertyEx:setValue(attrType,value)
    self.dynaPro:setValue(attrType,value)
    if DEBUG == 1 then 
        print(string.format("ATTR[%s]=%s",attrType,value))
    end
end


--------------------------------------
function PropertyEx:getMaxHp()
    return self:getValue(eAttrType.ATTR_MAX_HP)
end
--当取血量
function PropertyEx:getLossHp()
    return math.floor(self:getValue(eAttrType.ATTR_MAX_HP) - self:getValue(eAttrType.ATTR_NOW_HP))
end

function PropertyEx:getShieldPercent()
    return math.floor(self:getValue(eAttrType.ATTR_NOW_SLD)*10000 /self:getValue(eAttrType.ATTR_MAX_HP))
end
function PropertyEx:getHpPercent()
    return math.floor(self:getValue(eAttrType.ATTR_NOW_HP)*10000 /self:getValue(eAttrType.ATTR_MAX_HP))
end

function PropertyEx:getAngerPercent()
    return math.floor(self:getValue(eAttrType.ATTR_NOW_AGR)*10000 /self:getValue(eAttrType.ATTR_MAX_AGR))
end

function PropertyEx:getLossHpPercent()
    return math.floor(self:getLossHp()*10000/self:getMaxHp())
end
--当前速度百分比
function PropertyEx:getSpeedPercent()
    --初始速度
    local baseSpeed = self.basePro:getValue(eAttrType.ATTR_MOVE_SPEED)
    local speed     = self:getValue(eAttrType.ATTR_MOVE_SPEED)
    return math.floor(speed*10000/baseSpeed)
end
--受伤百分比
function PropertyEx:getHurtPercent()
    local hurtVale = self:getValue(eAttrType.ATTR_REV_HURT)
    local maxValue = self:getMaxHp()
    return math.floor(hurtVale*10000/maxValue)
end


return PropertyEx