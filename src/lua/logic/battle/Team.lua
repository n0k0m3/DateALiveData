local WitchTime   = import(".WitchTime")
local BattleConfig = import(".BattleConfig")
local BattleUtils  = import(".BattleUtils")
local Hero = import(".Hero")
local enum = import(".enum")
local eEvent      = enum.eEvent
local eRoleType   = enum.eRoleType
local eStateEvent = enum.eStateEvent
local eState      = enum.eState
local eAngerRule  = enum.eAngerRule
local eFlag       = enum.eFlag
local eBFState    = enum.eBFState
local MaxCampNum  = 10 --最大支持的阵营数量

local Team = class("Team")
function Team:ctor()
    self.member_   = {}
    self.heroList  = {}
    self._heroList = {} --队员列表(包涵死亡的队员)
    self.witchTime = nil
end

--触发魔女时间
function Team:triggerWitchTime(camp,data)
    self.witchTime = WitchTime:new(self,data)
    self.witchTime.camp = camp
    return self.witchTime
end

--取消魔女时间? 直接通过阵营来处理
function Team:cancelWitchTime(object)
    if self.witchTime == object then
        self.witchTime = nil 
    end 
end

--
function Team:getTimeScale(camp)
    if self.witchTime then
        if BattleUtils.campState(self.witchTime.camp,camp) == 2 then
            return self.witchTime:getTimeScale()
        end
    end
    return 1
end


function Team:addMember(member)
    table.insertTo(self.member_, member)
end

function Team:realeaseHeros()
    for index ,hero in ipairs(self.heroList) do
        hero:release()
        hero:checkAndRelease()
    end
    self.heroList = {}
    self._heroList = {}
end

-- local function handleCallFunc(count ,callback)
--     local len = count
--     return function()
--         len = len -1
--         if len <= 0 then
--             if callback then
--                 callback()
--             end
--         end
--     end
-- end

-- function Team:born(callFunc)
--     local heroList = self:getAliveHeros() --只处理出战队员
--     local _callFunc = handleCallFunc(#heroList,callFunc)
--     for index , hero in ipairs(heroList) do
--         hero:doEvent(eStateEvent.BH_BORN,_callFunc)
--     end
-- end

--创建英雄
--如果是召唤的情况，host 为召唤的宿主
function Team:createHeros(callback,host)
    local bornEventHero = {}
    for index , heroData in ipairs(self.member_) do
        local hero = Hero:new(heroData,self,host)
        table.insert(self.heroList, hero)
        if hero:getRoleType() == eRoleType.Hero
        or hero:getRoleType() == eRoleType.Team then
            table.insert(self._heroList, hero)
        end
        --出场动画
        if hero:isBattle() then
            if hero:getData().isPlayBornAction then
                hero:doEvent(eStateEvent.BH_BORN,callback)
                callback = nil
            else
                if hero:getRoleType() == eRoleType.Hero
                or hero:getRoleType() == eRoleType.Team then
                    -- bornEventHero = hero
                    table.insert(bornEventHero,hero)
                end
                hero:doEvent(eStateEvent.BH_STAND) 
                hero:getActor():show()
                hero:getActor().skeletonNode:show()
                hero:setFight(true)
            end
        end
    end
    self.member_ = {}
    if callback then
        callback()
    end
    --所有角色创建完处理出场事件
    if #bornEventHero > 0 then
        for i,hero in ipairs(bornEventHero) do
            hero:onEventTrigger(eBFState.E_HERO_ENTER,hero)
        end 
    end
end

-- --替补队员
-- function Team:getBench()
--     local retHeros = {}
--     for i, hero in ipairs(self._heroList) do
--         if not hero:isActive() then
--             retHeros[#retHeros + 1] = hero
--         end
--     end
--     return retHeros
-- end
--从队伍里删除
function Team:remove(hero,flag)
    table.removeItem(self.heroList,hero)
    if flag then
        table.removeItem(self._heroList,hero)
    end
end

function Team:update(delta)
    if self.witchTime then
        self.witchTime:update(delta)
    end

end

--发起战斗
function Team:startfight(camp)
    for index ,hero in ipairs(self.heroList) do
        if hero:getCamp() == camp or camp == nil then
            hero:startFight()
        end
    end
end

--发起战斗
function Team:stopFight(camp)
    for index ,hero in ipairs(self.heroList) do
        if hero:getCamp() == camp or camp == nil then
            hero:stopFight()
        end
    end
end

--获取阵营的敌对成员 ? 角色死亡判定
function Team:getEnemys(camp)
    return self:getMenbers_(camp,2)
end

--友方阵营 包含自己？
function Team:getFriends(camp)
    return self:getMenbers_(camp,1,false) --要包含未上场的角色
end

--检查队伍里的队员是否全部死亡
function Team:isAllDead(roleType)
    assert(roleType,"roleType can not is nil")
    for index , hero in ipairs(self.heroList) do
        if hero:getRoleType() == roleType then
            if hero:isAlive()  then
                return false
            end
        end
    end
    return true
end


function Team:isAllDeadByCampType(campType)
    assert(campType,"campType can not is nil")
    for index , hero in ipairs(self.heroList) do
        if hero:getCampType() == campType then
            if hero:isAlive()  then
                return false
            end
        end
    end
    return true
end

function Team:isAllDeadByCamp(camp)
    assert(camp,"camp can not is nil")
    for index , hero in ipairs(self.heroList) do
        if hero:getCamp() == camp then
            if hero:isAlive()  then
                return false
            end
        end
    end
    return true
end

--检查指定角色类型的角色是否全部销毁
function Team:isAllDestoryByRoleType(...)
    -- assert(roleType,"campType can not is nil")
    local roleTypes = {...}
    for index , hero in ipairs(self.heroList) do
        local _roleType = hero:getRoleType()
        for i, roleType in ipairs(roleTypes) do     
            if _roleType == roleType then
                if not hero:isFlag(eFlag.DEAD_Statistics) then
                    return false
                end
            end
        end
    end
    return true
end

--检查指定阵营的角色是否全部销毁
function Team:isAllDestoryByCamp(camp)
    assert(camp,"camp can not is nil")
    for index , hero in ipairs(self.heroList) do
        if hero:getCamp() == camp then
            if not hero:isFlag(eFlag.DEAD_Statistics) then
                return false
            end
        end
    end
    return true
end


--检查指定阵营的角色是否全部销毁
function Team:isAllDestoryByCampTyp(campType)
    for index , hero in ipairs(self.heroList) do
        if hero:getCampType() == campType then
            if not hero:isFlag(eFlag.DEAD_Statistics) then
                return false
            end
        end
    end
    return true
end



function Team:clearAllBuff(camp)
    for index ,hero in ipairs(self.heroList) do
        if hero:getCamp() == camp or camp == nil then
            hero:removeAllBuff()
            hero:stopMoveEffect()
        end
    end
end

--获取助战队员
function Team:getAssist()
    for index ,hero in ipairs(self.heroList) do
        if hero:getRoleType() == eRoleType.Assist then
            return hero
        end
    end
end

--所有队员包含死亡的
function Team:getHeros()
    return self._heroList
end
--所有未死亡的角色
function Team:getHerosEx()
    return self.heroList
end

--队伍队员
function Team:getMenbers(campType)
    local heros = {}
    for index ,hero in ipairs(self.heroList) do
        if hero:getCampType() == campType then
            if hero:isActive() then
                heros[#heros + 1] = hero
            end
        end
    end
    return heros
end

--TODO 包含没有死亡统计的
function Team:getMenbers___(campType)
    local heros = {}
    for index ,hero in ipairs(self.heroList) do
        if hero:getCampType() == campType then
            if hero:isActive() or not hero:isFlag(eFlag.DEAD_Statistics) then
                heros[#heros + 1] = hero
            end
        end
    end
    return heros
end



--阵营 
--阵营关系
function Team:getMenbers_(camp,campState,needActive)
    if needActive == nil then 
        needActive = true
    end
    local list = {}
    for i,hero in ipairs(self.heroList) do
        local camp1 = hero:getCamp()
        -- dump({hero:getName(),camp1,camp })
        if BattleUtils.campState(camp,camp1) == campState then
            if needActive then
                if hero:isActive() then
                    list[#list + 1] = hero
                end
            else
                list[#list + 1] = hero
            end
        end
    end
    return list
end



--组队队长
function Team:getCaptain()
    --找可出战的队员
    for index ,hero in ipairs(self.heroList) do
        if hero:getRoleType() == eRoleType.Team then
            if hero:getData().job == 1 then
                return hero
            end
        end
    end
end


--随机个队长
function Team:nextCaptain()
    --找可出战的队员
    for index ,hero in ipairs(self.heroList) do
        if hero:getRoleType() == eRoleType.Hero then
            if hero:isAlive() and not hero:isBattle() then
                return hero
            end
        end
    end
end

function Team:getHeroWithID(id)
    for index ,hero in ipairs(self.heroList) do
        if hero:getData().id == id then
            return hero
        end
    end
end

function Team:getHeroWithPID(id)
    for index ,hero in ipairs(self.heroList) do
        if hero:getPID() == id then
            return hero
        end
    end
end

function Team:isPlayedEndAction(campType)
    for index ,hero in ipairs(self.heroList) do
        if hero:getCampType() == campType then
            if not hero:isPlayedEndAction() then
                return false
            end
        end
    end
    return true
end
--[[
我方角色(出战/非出战) 只能有一个出战

助战角色(出战/非出战)

小怪(出战)
--]]
--[[

可破坏障碍物

陷阱Hero

角色Hero

阵营1  陷阱/角色/障碍物
阵营2

--]]


--战斗使用
--buffer使用

return Team
