local BattleConfig = require("lua.logic.battle.BattleConfig")
require("lua.logic.battle.RandomGenerator")
local enum = require("lua.logic.battle.enum")
local eAttrType  = enum.eAttrType
local UserDefault = CCUserDefault:sharedUserDefault()
local BaseDataMgr = import(".BaseDataMgr")
local BattleDataMgr = class("BattleDataMgr", BaseDataMgr)
local eDir      = enum.eDir
local eRoleType = enum.eRoleType
local __print = print
local eTableName =
{
    TB_SKILL       = 1 ,--SKILL
    TB_SKILLACTION = 2 ,--SKILLAction
    TB_SKILLEFFECT = 3 ,--SKILLEffect
    TB_SKILLHURT   = 4 ,--SKILLHurt
    TB_HEROPOWER   = 5 ,--HeroPower
    TB_HERO        = 6 ,--Hero
}

local eChangeType =
{
    MATH    = 1 ,--数学运算（加减）
    REPLACE = 2 ,--替换
    RIDE    = 3 ,--乘法
    MATH_EX = 4 ,--数学运算（加减）支持负数
    MERGE   = 5 ,--数组合并操作
}

-- 1  2  3  4  5  6
-- 7  8  9  10 11 12
-- 13 14 15 16 17 18
-- 19 20 21 22 23 24

local NextIndexMap = {
[1]  = { 0, 2, 0, 7},
[2]  = { 1, 3, 0, 8},
[3]  = { 2, 4, 0, 9},
[4]  = { 3, 5, 0,10},
[5]  = { 4, 6, 0,11},
[6]  = { 5, 0, 0,12},
[7]  = { 0, 8, 1,13},
[8]  = { 7, 9, 2,14},
[9]  = { 8,10, 3,15},
[10] = { 9,11, 4,16},
[11] = {10,12, 5,17},
[12] = {11, 0, 6,18},
[13] = { 0,14, 7,19},
[14] = {13,15, 8,20},
[15] = {14,16, 9,21},
[16] = {15,17,10,22},
[17] = {16,18,11,23},
[18] = {17, 0,12,24},
[19] = { 0,20,13, 0},
[20] = {19,21,14, 0},
[21] = {20,22,15, 0},
[22] = {21,23,16, 0},
[23] = {22,24,17, 0},
[24] = {23, 0,18, 0},
}



local function createNode(index,dungeonId ,last)
    local node     = {}
    node.index     = index
    node.dungeonId = dungeonId
    node.next      = {0,0,0,0} --关联的格子
    node.last      = last  --是否是最终关卡
    node.pass      = nil
    return node
end



function BattleDataMgr:init()
    -- 怪物
    self.monsterMap_ = TabDataMgr:getData("Monster")
    self.monsterTypeMap_ = {}
    for k, v in pairs(self.monsterMap_) do
        local monsterType = self.monsterTypeMap_[v.type] or {}
        self.monsterTypeMap_[v.type] = monsterType
        table.insert(monsterType, k)
    end

    --动作分段数据
    self.actionDatas = {}
    local datas = TabDataMgr:getData("SkillAction")
    for _, data in pairs(datas) do
        self.actionDatas[data.host] = self.actionDatas[data.host] or {}
        self.actionDatas[data.host][data.id] = data
    end
    --音效处理 (完成)
    self.musicDatas = {}
    self.musicDatas[1] = {}
    self.musicDatas[2] = {}
    self.musicDatas[3] = {}
    local datas = TabDataMgr:getData("SkillMusic")
    for _, data in pairs(datas) do
        self.musicDatas[data.cartoonType]                                   =
        self.musicDatas[data.cartoonType] or {}
        self.musicDatas[data.cartoonType][data.cartoonResource]             =
        self.musicDatas[data.cartoonType][data.cartoonResource] or {}
        self.musicDatas[data.cartoonType][data.cartoonResource][data.action] =
        self.musicDatas[data.cartoonType][data.cartoonResource][data.action] or {}
        for _, triggerEvent in ipairs(data.triggerEvents) do
            self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent] =
                self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent]  or {}
            table.insert(self.musicDatas[data.cartoonType][data.cartoonResource][data.action][triggerEvent],
                {resource = data.resource , volume = data.volume ,musicType = data.musicType  ,stopJudge = data.stopJudge })
        end
    end
    --觉醒特效处理 (完成)
    self.skillShowDatas = {}
    local datas = TabDataMgr:getData("SkillShow")
    for _, data in pairs(datas) do
        self.skillShowDatas[data.actionId] = data
    end

    --助战
    self.assistDatas =  {}
    local datas = TabDataMgr:getData("FriendHelp")
    for k,data in pairs(datas) do
        self.assistDatas[data.friendshipLevel] = data
    end
    --角色动作映射表
    self.animations ={}
    local datas = TabDataMgr:getData("RoleAction")
    for k,data in pairs(datas) do
        self.animations[data.resource] = self.animations[data.resource] or {}
        self.animations[data.resource][data.roleForm] = self.animations[data.resource][data.roleForm] or {}
        self.animations[data.resource][data.roleForm][data.action] = data
    end
    --角色事件触发音效
    self.eventMusics ={}
    local datas = TabDataMgr:getData("BattleEventsMusic")
    for k,data in pairs(datas) do
        self.eventMusics[data.roleId] = self.eventMusics[data.roleId] or {}
        self.eventMusics[data.roleId][data.eventType] = self.eventMusics[data.roleId][data.eventType] or {}
        table.insert(self.eventMusics[data.roleId][data.eventType],data)
    end

    self.mixAngleDatas = {}
end

function BattleDataMgr:onEnterMain()
    local pid = MainPlayer:getPlayerId()
    self.KEY_PRACTICE_DIFF_INDEX = string.format("key_%s_practice_diff_index", pid)
    self.KEY_PRACTICE_LEVEL_INDEX = string.format("key_%s_practice_level_index", pid)
    self.KEY_PRACTICE_LEVEL = string.format("key_%s_practice_level", pid)
    self.KEY_PRACTICE_NUMBER = string.format("key_%s_practice_number", pid)
    self.KEY_PRACTICE_HP_INDEX = string.format("key_%s_practice_hp_index", pid)
    self.KEY_PRACTICE_ATK_INDEX = string.format("key_%s_practice_atk_index", pid)
    self.KEY_PRACTICE_SUPER_INDEX = string.format("key_%s_practice_super_index", pid)
    self.KEY_PRACTICE_CATEGORY_INDEX = string.format("key_%s_practice_category_index", pid)
    self.KEY_PRACTICE_SPECIALHP_INDEX = string.format("key_%s_practice_specialhp_index", pid)
    self.KEY_PRACTICE_SPECIALCATEGORY_INDEX = string.format("key_%s_practice_specialcategory_index", pid)
    self.KEY_PRACTICE_SPECIALLEVEL_INDEX = string.format("key_%s_practice_speciallevel_index", pid)
    self.KEY_PRACTICE_SPECIALLEVEL = string.format("key_%s_practice_speciallevel", pid)
end

function BattleDataMgr:getEventMusic(roleId)
    return self.eventMusics[roleId]
end

function BattleDataMgr:getActionNames(roleId)
    return self.animations[roleId]
end

function BattleDataMgr:getShowData(acitonID)
    if self.skillShowDatas[acitonID] then
        return self.skillShowDatas[acitonID]
    end
end

--TODO 资源加载使用
function BattleDataMgr:getActionDatas(skillID)
    local actionData = self.actionDatas[skillID]
    return actionData
end

local function check(musicData,prams)
    local len = #prams
    for index, pram in ipairs(prams) do
        musicData = musicData[pram]
        if index < len then
            if not musicData then
                return {}
            end
        else
            if musicData then
                return musicData
            else
                return {}
            end
        end
    end
end
--TODO 角色音效事件触发
function BattleDataMgr:getActorMusicDatas(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[1],prams)
end
--TODO 特效音效事件触发
function BattleDataMgr:getEffectMusicData(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[2],prams)
end
--TODO 剧情音效事件
function BattleDataMgr:getScriptSoundData(resource,action,event)
    local prams = {resource,action,event}
    return check(self.musicDatas[3],prams)
end
--TODO 处理天使动态数据
local function handleAngleData(data,angleDatas,mixDatas,isClone)
    local mergeAttrs = {}
    if angleDatas then
        local attrs = angleDatas[data.id] --有没有对应ID得数据
        if attrs then
            table.insertTo(mergeAttrs, attrs)
        end
    end
    if mixDatas then
        local attrs = mixDatas[data.id] --有没有对应ID得数据
        if attrs then
            table.insertTo(mergeAttrs, attrs)
        end
    end 
    if isClone then
        data = clone(data)
    end
    for i , attr in ipairs(mergeAttrs) do
        if attr.changeType == eChangeType.MATH or attr.changeType == eChangeType.MATH_EX then     --加减
            local _changeValue   = attr["data"..attr.valueType]
            data[attr.fieldName] = data[attr.fieldName] + _changeValue
            if attr.changeType == eChangeType.MATH then
                data[attr.fieldName] = math.max(data[attr.fieldName],0)
            end
        elseif attr.changeType == eChangeType.REPLACE then --替换
            data[attr.fieldName] = attr["data"..attr.valueType]
        elseif attr.changeType == eChangeType.RIDE then --乘
            data[attr.fieldName] = data[attr.fieldName] * attr["data"..attr.valueType]
            -- data[attr.fieldName] = math.floor(data[attr.fieldName] + 0.5) --四舍五入  (波哥让屏蔽四舍五入)
        elseif attr.changeType == eChangeType.MERGE then -- 数组类型合并 
            table.insertTo(data[attr.fieldName],attr["data"..attr.valueType])
        end
    end
    return data
end


function BattleDataMgr:getSkillData(id,angleDatas)
    local skillData = TabDataMgr:getData("Skill", id)
    if skillData and angleDatas then  --处理天使数据
        skillData = handleAngleData(skillData,angleDatas[eTableName.TB_SKILL],self.mixAngleDatas[eTableName.TB_SKILL],true)
    end
    return skillData
end

function BattleDataMgr:getActionData(id,angleDatas)
    local actionData = TabDataMgr:getData("SkillAction",id)
    if actionData and angleDatas then  --处理天使数据
        actionData = handleAngleData(actionData,angleDatas[eTableName.TB_SKILLACTION],self.mixAngleDatas[eTableName.TB_SKILLACTION],true)
    end
    return actionData
end

function BattleDataMgr:getEffectData(id,angleDatas)
    local effectData = TabDataMgr:getData("SkillEffect",id)
    if effectData and angleDatas then  --处理天使数据
        effectData = handleAngleData(effectData,angleDatas[eTableName.TB_SKILLEFFECT],self.mixAngleDatas[eTableName.TB_SKILLEFFECT],true)
    end
    return effectData
end

function BattleDataMgr:getHurtData(id,angleDatas)
    local hurtData = TabDataMgr:getData("SkillHurt",id)
    if hurtData and angleDatas then
        hurtData = handleAngleData(hurtData,angleDatas[eTableName.TB_SKILLHURT],self.mixAngleDatas[eTableName.TB_SKILLHURT],true)
    end
    return hurtData
end

function BattleDataMgr:getEnergyData(id,angleDatas)
    local energyData = TabDataMgr:getData("HeroPower", id)
    if energyData and angleDatas then  --处理天使数据
        energyData = handleAngleData(energyData,angleDatas[eTableName.TB_HEROPOWER],self.mixAngleDatas[eTableName.TB_HEROPOWER],true)
    end
    return energyData
end

function BattleDataMgr:getHeroDataByAngle(heroData,angleDatas)
    if heroData and angleDatas then  --处理天使数据
        heroData = handleAngleData(heroData,angleDatas[eTableName.TB_HERO],self.mixAngleDatas[eTableName.TB_HERO],false)
    end
    return heroData
end

-- hero和monster 转换成同样的结构
function BattleDataMgr:transData(roleType,data,job,limitCid,manaInfo)
    job = job or 0
    local levelCfg = self:getLevelCfg()
    local newData
    if roleType == eRoleType.Monster then
        local tmpData  = TabDataMgr:getData("Monster", data.id)
        newData      = clone(tmpData)
        newData.dir  = eDir.LEFT --怪物初始化超左
        newData.job  = 0
        newData.strName  = TextDataMgr:getText(newData.name)
        if levelCfg.fightingMode == 2 then
            local bullets = TabDataMgr:getData("Bullet")
            local barrages = {}
            for j, id in ipairs(data.bullet) do
                local cfg = clone(bullets[id])
                local jsonPath = string.format("res/basic/barrage/%s.json", cfg.bullet)
                local barrage = {cfg = cfg, emitter = {}}
                if TFFileUtil:existFile(jsonPath) then
                    local rawContent = io.readfile(jsonPath)
                    if rawContent then
                        local content = json.decode(rawContent)
                        if content then
                            for i, item in ipairs(content.items) do
                                local tmpPath = item.Barrage.Bullet.Path
                                tmpPath = string.gsub(tmpPath, "res/basic/", "")
                                item.Barrage.Bullet.Path = tmpPath
                                barrage.emitter[i] = item.Barrage
                            end
                        end
                    end

                end
                barrages[j] = barrage
            end
            newData.flySkills = barrages
        end
        for k, v in pairs(data) do
            newData[k] = v
        end
        newData.isPlayBornAction = true
        newData.isPlayVictorAction = false
        newData.roleType = roleType
        newData.angleDatas = {}  --怪物没有天使数据
        newData.angleBuffer = {}
        newData.enterField = newData.enterField or 0 --出场冷却时间
        --外形数据
        newData.formDatas  = {} 
        for _, formId in ipairs(newData.allForm) do
            local formData = TabDataMgr:getData("HeroForm", formId)
            table.insert(newData.formDatas,clone(formData))
        end

        newData.passivitySkills = newData.passivitySkills or {}
        if self:getBattleData().isDuelMod then
            local duelModSkills = levelCfg.duelModSkills
            if duelModSkills and duelModSkills > 0 then
                table.insert(newData.passivitySkills , duelModSkills)
            end
        end
        -- dump({newData.passivitySkills,"AAAA"})
        -- Box("zzzaz:"..tostring(self:getBattleData().isDuelMod).." - "..tostring(levelCfg.duelModSkills ))
    elseif roleType == eRoleType.Hero then
        newData          = clone(data)
        newData.limitCid = limitCid
        newData.job      = job
        newData.lvl = data.lvl
        newData.exp = data.exp
        newData.strName  = TextDataMgr:getText(newData.name)
        newData.subType  = 0 --生物类型
        newData.isPlayBornAction   = levelCfg.isPlayBornAction
        newData.isPlayVictorAction = levelCfg.isPlayVictorAction
        newData.roleType = roleType
        newData.angleDatas  = {}
        newData.angleBuffer = {}
        --外形数据
        newData.formDatas = {}
        --检查是否有看板
        if newData.role and RoleDataMgr:getRoleInfo(newData.role) then
            local moodLevel  = RoleDataMgr:getMoodLevel(newData.role) --心情等级
            local moodBuffId = RoleDataMgr:getMoodBuffId(newData.role,moodLevel)
            if moodBuffId ~= 0 then
                table.insert(newData.angleBuffer,moodBuffId)
                print("添加心情值BufferID:"..tostring(moodBuffId))
            end
        end
        --skinId
        newData.skinId = data.skinCid
        --克隆Skin数据
        local skinData = TabDataMgr:getData("HeroSkin", newData.skinId)
        skinData = clone(skinData)
        if levelCfg.fightingMode == 2 then
            local wingmanFlyForm = skinData.wingmanFlyForm
            local flyFormData = TabDataMgr:getData("FlyForm", skinData.heroFlyForm)
            local wingmanData
            if wingmanFlyForm ~= 0 and wingmanFlyForm ~= nil then
                wingmanData = TabDataMgr:getData("FlyForm", wingmanFlyForm)
            end
            local bullets = TabDataMgr:getData("Bullet")
            local  function transBullet(flySkills)
                local result = {}
                for i, value in ipairs(flySkills) do
                    local group = {}
                    for j, id in ipairs(value) do
                        local cfg = clone(bullets[id])
                        local jsonPath = string.format("res/basic/barrage/%s.json", cfg.bullet)
                        local barrage = {cfg = cfg, emitter = {}}
                        if TFFileUtil:existFile(jsonPath) then
                            local rawContent = io.readfile(jsonPath)
                            if rawContent then
                                local content = json.decode(rawContent)
                                if content then
                                    for i, item in ipairs(content.items) do
                                        local tmpPath = item.Barrage.Bullet.Path
                                        tmpPath = string.gsub(tmpPath, "res/basic/", "")
                                        item.Barrage.Bullet.Path = tmpPath
                                        barrage.emitter[i] = item.Barrage
                                    end
                                end
                            end
                        end
                        group[j] = barrage
                    end
                    result[i] = group
                end
                return result
            end
            local flySkills = TabDataMgr:getData("FlySkill")
            local function transSkill(skills)
                local result = {}
                for _, id in ipairs(skills) do
                    result[id] = clone(flySkills[id])
                end
                return result
            end
            for k, v in pairs(flyFormData) do
                skinData[k] = clone(v)
            end
            skinData.flySkills = transBullet(flyFormData.flySkills)
            if skinData.skills then
                skinData.skills = transSkill(flyFormData.skills)
            end
            if wingmanData and wingmanData.flySkills then
                skinData.wingman = clone(wingmanData)
                skinData.wingman.flySkills = transBullet(wingmanData.flySkills)
            end
        elseif levelCfg.fightingMode == 3 then
            local flyFormData = TabDataMgr:getData("FlyForm", skinData.heroFlyForm)
            local flySkills = TabDataMgr:getData("FlySkill")
            for k, v in pairs(flyFormData) do
                skinData[k] = clone(v)
            end
            local function transSkill(skills)
                local result = {}
                for _, id in ipairs(skills) do
                    result[id] = clone(flySkills[id])
                end
                return result
            end
            if skinData.skills then
                skinData.skills = transSkill(flyFormData.skills)
            end
        else
            --角色所有形态
            for _, formId in ipairs(skinData.allForm) do
                local formData = TabDataMgr:getData("HeroForm", formId)
                table.insert(newData.formDatas,clone(formData))
            end
        end


        -- print(newData.formData)
        -- Box("asdfsdf")
        --根据等级计算觉醒技能
        -- local angelLvl   = newData.angelLvl or 1
        -- local angleSkill = skinData.supperSkills[angelLvl]
        -- table.insert(skinData.skills,angleSkill) --TODO 需要调整
        for k,v in pairs(skinData) do
            if k ~= "id" then
                newData[k] = v
            end
        end

        --装备被动技能(起始就是加buff)
        local passiveSkillList = HeroDataMgr:getSkillTab(data.id)
        for i, _skillID in ipairs(passiveSkillList) do
            if _skillID ~= 0 then 
                table.insert(newData.passivitySkills,_skillID)
            else
                Box("passiveSkillList id :"..tostring(_skillID))
            end
        end
        -- 精灵挑战关卡被动技能
        local levelCfg = self:getLevelCfg()
        if levelCfg and levelCfg.dungeonType == EC_FBLevelType.SPRITE then
            local challengeInfo = FubenDataMgr:getSpriteChallengeInfo()
            if challengeInfo and challengeInfo.buffCid then
                table.insert(newData.passivitySkills, challengeInfo.buffCid)
            end
        end
      -- print("angleIds",angleIds)
        local affixeIDS = {}
        --被动技能
        for i, skillID in ipairs(newData.passivitySkills) do
            local skillData = TabDataMgr:getData("PassiveSkills",skillID)
            if skillData then
               local  angelSkillFunctions = skillData.angelSkillFunctions[newData.id] or skillData.angelSkillFunctions[0]
                if angelSkillFunctions then
                    for i, skillFunID in pairs(angelSkillFunctions) do
                        table.insert(affixeIDS,skillFunID)
                    end
                end
            else 
                Box("can not found PassiveSkills :"..tostring(skillID))
            end
        end

        --天使数据
        local angleIds = HeroDataMgr:getAngelTalents(newData.cid)
        for i,angleId in ipairs(angleIds) do
            local tmpData = TabDataMgr:getData("AngelSkillTree",angleId)
            print(tmpData.affixeID)
            table.insertTo(newData.angleBuffer,tmpData.attachBuff)
            table.insertTo(affixeIDS,tmpData.affixeID)
        end
        table.sort(affixeIDS)
        -- print("affixeIDS",tostring(newData.strName))
        -- dump(affixeIDS)
        for i , attrId in ipairs(affixeIDS) do
            local attrData = TabDataMgr:getData("AngelSkillFunction", attrId)
            if attrData.interchangeable then
                self.mixAngleDatas[attrData.listName] = self.mixAngleDatas[attrData.listName] or {}
                for i, dataId in ipairs(attrData.listData) do
                    self.mixAngleDatas[attrData.listName][dataId] =self.mixAngleDatas[attrData.listName][dataId] or {}
                    table.insert(self.mixAngleDatas[attrData.listName][dataId],attrData)
                end
            else
                newData.angleDatas[attrData.listName] = newData.angleDatas[attrData.listName] or {}
                for i, dataId in ipairs(attrData.listData) do
                    newData.angleDatas[attrData.listName][dataId] =newData.angleDatas[attrData.listName][dataId] or {}
                    table.insert(newData.angleDatas[attrData.listName][dataId],attrData)
                end
            end
        end
        newData.camp = 1 --TODO 设置默认阵营

        -- 熟悉缩放值（万分比）
        newData.attrScale = {}
        if self.battleType_ == EC_BattleType.ENDLESS then
            if FubenDataMgr:isEndlessRacingMode(self.levelCid_) then
                newData.attrScale[eAttrType.ATTR_NOW_HP] = FubenDataMgr:getEndlessHeroHpPercent(newData.id)
            end
        end

        -- Box("角色"..newData.id.."皮肤："..newData.skinId)
    elseif roleType == eRoleType.Assist then --助战
        local tmpData = TabDataMgr:getData("Hero",data.cid)
        newData       = clone(tmpData)
        newData.job      = 0
        newData.angelLvl = data.angelLvl
        newData.skinId   = data.skinCid
        newData.strName  = TextDataMgr:getText(newData.name)
        newData.attr  = {}
        --属性格式转换为统一格式
        if data.attr then
            for i, attrInfo in ipairs(data.attr) do
                newData.attr[attrInfo.type] = attrInfo.val
            end
        else
            --TODO 服务器助战数据有问题 临时测试使用
            local attrInfo    = TabDataMgr:getData("MonsterLevel",11001)
            for key , value in pairs (attrInfo.baseAttr) do
                newData.attr[key] = value
            end
        end
        --TODO 服务器助战数据有问题 临时测试使用
        newData.skinId = newData.defaultSkin


        newData.subType  = 0 --生物类型

        newData.isPlayBornAction   = levelCfg.isPlayBornAction
        newData.isPlayVictorAction = levelCfg.isPlayVictorAction
        newData.roleType  = roleType --eRoleType.Hero
        newData.angleDatas  = {}  --助战有天使数据(等服务器下发)
        newData.angleBuffer = {}
        --外形数据
        newData.formDatas = {}
       --克隆Skin数据
        local skinData = TabDataMgr:getData("HeroSkin", newData.skinId)
        skinData = clone(skinData)
        --角色所有形态
        for _, formId in ipairs(skinData.allForm) do
            local formData = TabDataMgr:getData("HeroForm", formId)
            table.insert(newData.formDatas,clone(formData))
        end
        -- local angelLvl   = newData.angelLvl or 1
        -- local angleSkill = skinData.supperSkills[angelLvl]  --
        -- table.insert(skinData.skills,angleSkill)
        for k,v in pairs(skinData) do
            if k ~= "id" then
                newData[k] = v
            end
        end

        --天使和技能数据
        -- local angleIds , passiveSkillList = HeroDataMgr:getFriendSkillInfo(data)
        -- for i, _skillID in ipairs(passiveSkillList) do
        --     table.insert(newData.passivitySkills,_skillID)
        -- end
        -- --天使数据
        -- local affixeIDS = {}
        -- --被动技能
        -- for i, skillID in ipairs(newData.passivitySkills) do
        --     local skillData = TabDataMgr:getData("PassiveSkills",skillID)
        --     if skillData then
        --        local  angelSkillFunctions = skillData.angelSkillFunctions[newData.id] or skillData.angelSkillFunctions[0]
        --         if angelSkillFunctions then
        --             for i, skillFunID in pairs(angelSkillFunctions) do
        --                 table.insert(affixeIDS,skillFunID)
        --             end
        --         end

        --     else 
        --         Box("can not found PassiveSkills :"..tostring(skillID))
        --     end
        -- end
        -- print("angleIds",angleIds)
        -- for i,angleId in ipairs(angleIds) do
        --     local tmpData = TabDataMgr:getData("AngelSkillTree",angleId)
        --     print(tmpData.affixeID)
        --     table.insertTo(newData.angleBuffer,tmpData.attachBuff)
        --     table.insertTo(affixeIDS,tmpData.affixeID)
        -- end
        -- table.sort(affixeIDS)
        -- print("affixeIDS",tostring(newData.strName))
        -- dump(affixeIDS)
        -- for i , attrId in ipairs(affixeIDS) do
        --     local attrData = TabDataMgr:getData("AngelSkillFunction", attrId)
        --     self.mixAngleDatas[attrData.listName] = self.mixAngleDatas[attrData.listName] or {}
        --     for i, dataId in ipairs(attrData.listData) do
        --         self.mixAngleDatas[attrData.listName][dataId] =self.mixAngleDatas[attrData.listName][dataId] or {}
        --         table.insert(self.mixAngleDatas[attrData.listName][dataId],attrData)
        --     end
        -- end

        --TODO 助战橘色测试AI
        newData.camp = 1 --TODO 设置默认阵营
    elseif roleType == eRoleType.Team then
        local tmpData = TabDataMgr:getData("Hero",data.cid)
        newData       = clone(tmpData)
        newData.angelLvl = data.angelLvl
        newData.skinId   = data.skinCid
        newData.lvl = data.lvl
        newData.exp = data.exp

        newData.strName  = TextDataMgr:getText(newData.name)
        newData.attr  = {}
        --属性格式转换为统一格式
        for i, attrInfo in ipairs(data.attr) do
            newData.attr[attrInfo.type] = attrInfo.val
        end
        newData.subType     = 0 --生物类型
        newData.isPlayBornAction   = levelCfg.isPlayBornAction
        newData.isPlayVictorAction = levelCfg.isPlayVictorAction
        newData.roleType    = eRoleType.Team
        newData.angleDatas  = {}  --助战有天使数据(等服务器下发)
        newData.angleBuffer = {}
        --外形数据
        newData.formDatas = {}
        newData.job = 0

        --克隆Skin数据
        local skinData = TabDataMgr:getData("HeroSkin", newData.skinId)
        skinData = clone(skinData)
        -- local angelLvl   = newData.angelLvl or 1
        -- local angleSkill = skinData.supperSkills[angelLvl]
        -- table.insert(skinData.skills,angleSkill)
        for k,v in pairs(skinData) do
            if k ~= "id" then
                newData[k] = v
            end
        end
        newData.quality = data.quality
        --角色所有形态
        for _, formId in ipairs(skinData.allForm) do
            local formData = TabDataMgr:getData("HeroForm", formId)
            table.insert(newData.formDatas,clone(formData))
        end

        if newData.role and RoleDataMgr:getRoleInfo(newData.role) then
            local moodLevel  = RoleDataMgr:getMoodLevel(newData.role) --心情等级
            local moodBuffId = RoleDataMgr:getMoodBuffId(newData.role,moodLevel)
            if moodBuffId ~= 0 then
                table.insert(newData.angleBuffer,moodBuffId)
                print("添加心情值BufferID:"..tostring(moodBuffId))
            end
        end

        --天使和技能数据
        local angleIds , passiveSkillList = HeroDataMgr:getFriendSkillInfo(data)
        for i, _skillID in ipairs(passiveSkillList) do
            table.insert(newData.passivitySkills,_skillID)
        end

        if manaInfo then
            for k,v in ipairs(manaInfo) do
                local passiveSkillId = ResonanceDataMgr:getPassiveSkillId(v.id,v.level)
                if passiveSkillId then
                    table.insert(newData.passivitySkills,passiveSkillId)
                end
            end
        end

        -- --天使数据
        local affixeIDS = {}
        --被动技能附带的天使数据
        for i, skillID in ipairs(newData.passivitySkills) do
            local skillData = TabDataMgr:getData("PassiveSkills",skillID)
            if skillData then
               local  angelSkillFunctions = skillData.angelSkillFunctions[newData.id] or skillData.angelSkillFunctions[0]
                if angelSkillFunctions then
                    for i, skillFunID in pairs(angelSkillFunctions) do
                        table.insert(affixeIDS,skillFunID)
                    end
                end
            else 
                Box("can not found PassiveSkills :"..tostring(skillID))
            end
        end

        for i,angleId in ipairs(angleIds) do
            local tmpData = TabDataMgr:getData("AngelSkillTree",angleId)
            print(tmpData.affixeID)
            table.insertTo(newData.angleBuffer,tmpData.attachBuff)
            table.insertTo(affixeIDS,tmpData.affixeID)
        end
        table.sort(affixeIDS)
        -- print("affixeIDS",tostring(newData.strName))
        -- dump(affixeIDS)
        for i , attrId in ipairs(affixeIDS) do
            local attrData = TabDataMgr:getData("AngelSkillFunction", attrId)
            if attrData.interchangeable then
                self.mixAngleDatas[attrData.listName] = self.mixAngleDatas[attrData.listName] or {}
                for i, dataId in ipairs(attrData.listData) do
                    self.mixAngleDatas[attrData.listName][dataId] = self.mixAngleDatas[attrData.listName][dataId] or {}
                    table.insert(self.mixAngleDatas[attrData.listName][dataId],attrData)
                end
            else
                newData.angleDatas[attrData.listName] = newData.angleDatas[attrData.listName] or {}
                for i, dataId in ipairs(attrData.listData) do
                    newData.angleDatas[attrData.listName][dataId] =newData.angleDatas[attrData.listName][dataId] or {}
                    table.insert(newData.angleDatas[attrData.listName][dataId],attrData)
                end
            end
        end
        newData.camp = 1 --TODO 设置默认阵营
    end
    newData.healthBar   = newData.healthBar or 1 --血条数量
    newData.healthColor = newData.healthColor or 1 --1 红色 2 绿色
    newData.layer  = newData.layer or 1   --1根据Y轴排序2最上3最下
    newData.shadow = newData.shadow or 1 --1显示影子 2不显示影子

    newData.fixedDir = 0 -- 0 可以自由转向 1 固定朝向
    newData.dir      = newData.dir or eDir.RIGHT -- 初始朝向
    -- newData.layerSign= newData.layerSign or 0
    newData.markID = newData.id
    return newData
end

local TEAM_MAX_HEROS = 3
function BattleDataMgr:heroData()
    local _max_num = TEAM_MAX_HEROS
    local dungeonType = self:getLevelCfg().dungeonType
    if dungeonType == EC_FBLevelType.PRACTICE or dungeonType == EC_FBLevelType.MUSIC_GAME then
        _max_num =  5
    end

    local rawDataList = {}
    local dataList = {}

    local endlessJobPos
    for pos = 1 , _max_num do
        if self.formation_ then
            local formation = self.formation_[pos]
            if formation then
                local limitCid
                local data
                if formation.limitType == EC_BattleHeroType.OWN 
                    or formation.limitType == EC_BattleHeroType.SIMULATION  then
                    data = HeroDataMgr:getHero(formation.limitCid)
                    if formation.skinCid then --指定skin [木桩试用灵装使用]
                        data = clone(data)
                        data.skinCid = formation.skinCid
                    end
                else
                    data = FubenDataMgr:getLimitHero(formation.limitCid)
                    limitCid = formation.limitCid
                end
                local job = 0
                if pos == 1 then --位置为1的始终为队长
                    job = 1
                end
                if not data then
                    local limitHero = FubenDataMgr.limitHeros_
                    local levelFormation = FubenDataMgr.levelFormation_
                    local limitReqData =  FubenDataMgr.limitReqData
                    local limitRespData = FubenDataMgr.limitRespData
                    local dataStr = MainPlayer:getPlayerId().."-passNum:"..FubenDataMgr:getPassLevelNum().."-limitReqData:"
                    for k,v in pairs(limitReqData) do
                        dataStr = dataStr..k.."--"
                    end
                    dataStr = dataStr.."limitRespData:"
                    for k,v in pairs(limitRespData) do
                        dataStr = dataStr..k.."--"
                    end
                    dataStr = dataStr.."levelFormation:"
                    for k,v in pairs(levelFormation) do
                        dataStr = dataStr..k.."--"
                    end
                    dataStr = dataStr.."limitHero:"
                    for k,v in pairs(limitHero) do
                        dataStr = dataStr..k.."--"
                    end
                    
                    local saveParam = FubenDataMgr:getCurFightParam()
                    if saveParam then
                        dataStr = dataStr.."-sendCid:"
                        dataStr = dataStr..saveParam[1] or ""
                        dataStr = dataStr.."-sendHeros:"
                        for i,v in ipairs(saveParam[4] or {}) do
                            dataStr = dataStr..v[2].."--"
                            dataStr = dataStr..v[1].."--"
                        end
                    end
                    local formaStr = ""
                    for k,v in pairs(self.formation_) do
                        formaStr = formaStr..v.limitCid.."--"..v.limitType.."--"
                    end
                    local errMsg = string.format("BattleDataMgr:heroData ERROR: limitData = %s levelCid=%s formatData=%s !",
                        dataStr,
                        tostring(self.levelCid_ ),
                        formaStr)
                        Bugly:ReportLuaException(errMsg)
                        Box(errMsg)
                end
                table.insert(rawDataList, clone(data))
                data = self:transData(eRoleType.Hero, data, job,limitCid)
                --初始玩家头像列表显示顺序
                if job == 1 then 
                    data.headShowIndex = 0
                else
                    data.headShowIndex = pos
                end
                table.insert(dataList, data)
            end
        else
            local isOn = HeroDataMgr:getIsFormationOn(pos)
            if isOn then
                local id = HeroDataMgr:getHeroIdByFormationPos(pos)
                local data = HeroDataMgr:getHero(id)
                table.insert(rawDataList, clone(data))

                local job
                if self.battleType_ == EC_BattleType.ENDLESS then
                    local percent = FubenDataMgr:getEndlessHeroHpPercent(data.id)
                    if percent > 0 and not endlessJobPos then
                        endlessJobPos = pos
                    end
                    job = (endlessJobPos == pos) and 1 or 0
                else
                    job = data.job
                end

                data = self:transData(eRoleType.Hero, data, job)
                data.limitType = EC_BattleHeroType.OWN
                --初始玩家头像列表显示顺序
                if job == 1 then 
                    data.headShowIndex = 0
                else
                    data.headShowIndex = pos
                end
                table.insert(dataList, data)
            end
        end
    end
    FubenDataMgr:setFormation(rawDataList)
    return dataList
end


function BattleDataMgr:randomMonster(poolData)
    local monster = {}
    for _, v in ipairs(poolData) do
        local monsterPoolCfg = TabDataMgr:getData("MonsterPool", v[1])
        local data = monsterPoolCfg.data
        local poolType = monsterPoolCfg.poolType
        local pool = {}
        if poolType == 1 then
            pool = data
        elseif poolType == 2 then
            local type_ = data[1]
            local subType = data[2]
            local orgnazitionType = data[3]
            for i, v in ipairs(self.monsterTypeMap_[type_]) do
                local monsterCfg = self:getMonsterCfg(v)
                if monsterCfg.subType == subType and monsterCfg.orgnazitionType == orgnazitionType then
                    table.insert(pool, v)
                end
            end
        end
        for i = 1, v[2] do
            local index = RandomGenerator.random(#pool)
            table.insert(monster, pool[index])
        end
    end
    return monster
end

function BattleDataMgr:getPreloadMonster()
    local levelCfg = self:getLevelCfg()
    local monster = {}
    for _, monsterSectionCid in ipairs(levelCfg.monsterGroupId) do
        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", monsterSectionCid)
        for _, monsterCid in ipairs(monsterSectionCfg.fixedMonster) do
            table.uniqueAdd(monster, monsterCid)
        end
        for _, data in ipairs(monsterSectionCfg.randomMonster) do
            local monsterPoolCfg = TabDataMgr:getData("MonsterPool", data[1])
            if monsterPoolCfg.poolType == 1 then
                for _, monsterCid in ipairs(monsterPoolCfg.data) do
                    table.uniqueAdd(monster, monsterCid)
                end
            elseif monsterPoolCfg.poolType == 2 then
                local type_ = monsterPoolCfg.data[1]
                local subType = monsterPoolCfg.data[2]
                local orgnazitionType = monsterPoolCfg.data[3]
                for _, monsterCid in ipairs(self.monsterTypeMap_[type_]) do
                    local monsterCfg = self:getMonsterCfg(monsterCid)
                    if monsterCfg.subType == subType and monsterCfg.orgnazitionType == orgnazitionType then
                        table.uniqueAdd(monster, monsterCid)
                    end
                end
            end
        end
    end
    return monster
end

--当前战斗的服务器返回的数据
function BattleDataMgr:setServerData(sData, battleType)
    self.mixAngleDatas = {}
    self.serverData   = sData --缓存服务器返回的数据
    self.levelCid_ = sData.levelCid
    self.battleType_ = battleType
    self.formation_ = sData.limitHeros
    self.racingEndlessBuff_ = sData.buff or {}
    --组织战斗数据
    local levelCfg    = self:getLevelCfg()
    local data        = {}
    data.isDuelMod    = sData.isDuelMod
    data.battleType   = battleType
    data.heros        = self:heroData()  --组织角色数据

    data.victoryCfg = {}
    data.starCfg = {}
    data.pointId     = sData.levelCid
    data.cameraAmend = levelCfg.cameraAmend
    data.preloadMonster = self:getPreloadMonster()
    data.exMap = levelCfg.levelStepID
    data.bgm = levelCfg.bgm

    if battleType == EC_BattleType.COMMON then
        local pointId     = data.pointId
        data.map = levelCfg.levelScript
        --关卡挑战信息
        local starTypes  = levelCfg.starType
        local starParams = levelCfg.starParam
        local index = 1
        for pos, starType in ipairs(levelCfg.starType) do
            if not FubenDataMgr:judgeStarIsActive(pointId, pos) then
                data.starCfg[index] = {}
                data.starCfg[index].starType      = starType
                data.starCfg[index].starParam     = levelCfg.starParam[pos]
                data.starCfg[index].pos     = pos
                index = index + 1
            end
        end
        --关卡胜利条件
        for index, victoryType in ipairs(levelCfg.victoryType) do
            data.victoryCfg[index] = {}
            data.victoryCfg[index].victoryType  = victoryType
            data.victoryCfg[index].victoryParam = clone(levelCfg.victoryParam[index])
            data.victoryCfg[index].victoryTypeDescribe = clone(levelCfg.victoryTypeDescribe[index])
            data.victoryCfg[index].victoryParam2 = clone(levelCfg.victoryParam2[index])
        end

        ---助战数据
        if self.serverData.hero then --组织助战角色数据
            data.assistHero =  self:transData(eRoleType.Assist,self.serverData.hero)
            table.insert(data.heros,data.assistHero)
        end

        -- 初始化练习模式数据
        if levelCfg.dungeonType == EC_FBLevelType.PRACTICE or levelCfg.dungeonType == EC_FBLevelType.MUSIC_GAME then
            self:loadPracticeData()
        end
    elseif battleType == EC_BattleType.ENDLESS then
        local index = RandomGenerator.random(#levelCfg.levelScript)
        data.map = levelCfg.levelScript[index]
        --关卡胜利条件
        for index, victoryType in ipairs(levelCfg.victoryType) do
            data.victoryCfg[index] = {}
            data.victoryCfg[index].victoryType = victoryType
            data.victoryCfg[index].victoryParam = clone(levelCfg.victoryParam[index])
        end
    end

    self.battleData = data
    -- Box("playerID "..tostring(MainPlayer:getPlayerId()))
end

function BattleDataMgr:getServerData()
    return self.serverData 
end
--当前战斗的服务器返回的数据
function BattleDataMgr:setServerTeamData(sData)
    self.mixAngleDatas = {}
    self.serverData   = sData --缓存服务器返回的数据
    self.battleType_  = sData.battleType
    self.racingEndlessBuff_ = {}
    local data        = {}
 
    --组织战斗数据
    local levelCfg    = FubenDataMgr:getLevelCfg(sData.levelCid)
    if levelCfg.dungeonType == EC_FBLevelType.TEAMFIGHT_EX_PARENT then  --高级组队父关卡
        local dungeons    = sData.randomDungeons 
        --当前所在的关卡位置
        data.dungeonIndex = dungeons[1].index + 1  --第一个为其实关卡
        self.levelCid_    = dungeons[1].dungeonId
        --关卡路线
        data.dungeonNodes = self:transRoute(dungeons)
        levelCfg          = FubenDataMgr:getLevelCfg(self.levelCid_)
        sData.levelCid    = self.levelCid_
        sData.dungeonCid  = self.levelCid_
    else  --普通组队关卡
        self.levelCid_    = sData.levelCid
    end
    -- dump(sData.randomDungeons)
    -- dump(data.dungeonNodes)
    -- dump(data.dungeonIndex)

    -- Box("asdf")



    data.fightServerHost = sData.fightServerHost
    data.fightServerPort = sData.fightServerPort
    data.randomSeed      = sData.randomSeed
    data.teamType        = sData.teamType  --组队战斗类型
    --设置随机种子
    RandomGenerator.randomseed(data.randomSeed,data.randomSeed)
    data.battleType   = sData.battleType
    data.fightId      = sData.fightId

    --队长ID 
    data.leader       = TeamFightDataMgr:getLeaderId()
    data.heros        = {} --组织角色额数据

   -- 18: message FightPlayer{
   -- 19   required int32 pid = 1;     // 玩家ID
   -- 20   repeated HeroInfo heros = 2;    // 战斗英雄数据
    for i, baseData in ipairs(sData.players) do
        -- dump(baseData)
        -- Box(">>>>>>>>>")
        local heroData = self:transData(eRoleType.Team,baseData.heros[1],nil,nil,baseData.manaInfo)
        heroData.pid   = baseData.pid
        heroData.reviveCount = baseData.reviveCount
        heroData.pname       = baseData.pname
        heroData.portraitCid = baseData.portraitCid
        heroData.unionName   = baseData.unionName
        heroData.titleId     = baseData.titleId
        heroData.portraitFrameId = baseData.portraitFrameId
        heroData.manaInfo = baseData.manaInfo
        if heroData.portraitCid == 0 then
            heroData.portraitCid = 101
        end
        heroData.hurtValue   = 0 --造成伤害
        heroData.bornIndex   = i
        -- if heroData.pid == data.leader then
        --     heroData.leader = true --队长
        --     heroData.priority = 999 --设置优先级用于同步Boss位置
        -- else
        --     heroData.priority = i
        -- end
        if MainPlayer:getPlayerId() == heroData.pid then
            heroData.job = 1
            local dataList = {}
            table.insert(dataList, heroData)
            TeamFightDataMgr:setReviveCount(heroData.reviveCount)
            FubenDataMgr:setFormation(clone(dataList))
        end
        table.insert(data.heros, heroData)
    end
 

    data.victoryCfg   = {}
    data.starCfg      = {}
    data.pointId      = sData.levelCid
    data.cameraAmend    = levelCfg.cameraAmend
    data.preloadMonster = self:getPreloadMonster()

    local pointId     = data.pointId
    data.map   = levelCfg.levelScript
    data.exMap = levelCfg.levelStepID
    data.bgm   = levelCfg.bgm
    --关卡胜利条件
    for index, victoryType in ipairs(levelCfg.victoryType) do
        data.victoryCfg[index] = {}
        data.victoryCfg[index].victoryType  = victoryType
        data.victoryCfg[index].victoryParam = clone(levelCfg.victoryParam[index])
        data.victoryCfg[index].victoryTypeDescribe = clone(levelCfg.victoryTypeDescribe[index])
    end

    self.battleData = data
    -- Box("playerID "..tostring(MainPlayer:getPlayerId()))
end

function BattleDataMgr:getMixAngleDatas()
    return self.mixAngleDatas
end


--重置组队数据(高级组队用)
function BattleDataMgr:resetServerData(sData,dungeonNodes,dungeonIndex,leaderID)
    self.serverData   = sData --缓存服务器返回的数据
    self.battleType_  = sData.battleType
    self.racingEndlessBuff_ = {}
    local data        = {}

    data.dungeonNodes = dungeonNodes
    --当前所在的关卡位置
    data.dungeonIndex = dungeonIndex  
    sData.dungeonCid  = data.dungeonNodes[data.dungeonIndex].dungeonId
    sData.levelCid    = sData.dungeonCid
    self.levelCid_    = sData.levelCid 
    --组织战斗数据
    local levelCfg    = FubenDataMgr:getLevelCfg(self.levelCid_)
    if not levelCfg then 
        -- dump(sData.dungeonCid)
        -- dump(self.levelCid_)
        -- Box("asdf")
    end



    data.fightServerHost = sData.fightServerHost
    data.fightServerPort = sData.fightServerPort
    data.randomSeed      = sData.randomSeed
    data.teamType        = sData.teamType  --组队战斗类型
    --设置随机种子
    RandomGenerator.randomseed(data.randomSeed,data.randomSeed)
    data.battleType   = sData.battleType
    data.fightId      = sData.fightId
    --队长ID 
    data.leader       = leaderID --指定队长
    data.heros        = {} --组织角色额数据

   -- 18: message FightPlayer{
   -- 19   required int32 pid = 1;     // 玩家ID
   -- 20   repeated HeroInfo heros = 2;    // 战斗英雄数据
    -- for i, baseData in ipairs(sData.players) do
    --     -- dump(baseData)
    --     -- Box(">>>>>>>>>")
    --     local heroData = self:transData(eRoleType.Team,baseData.heros[1])
    --     heroData.pid   = baseData.pid
    --     heroData.reviveCount = baseData.reviveCount
    --     heroData.pname       = baseData.pname
    --     heroData.portraitCid = baseData.portraitCid
    --     if heroData.portraitCid == 0 then
    --         heroData.portraitCid = 101
    --     end
    --     heroData.hurtValue   = 0 --造成伤害
    --     heroData.bornIndex   = i
    --     -- if heroData.pid == data.leader then
    --     --     heroData.leader = true --队长
    --     --     heroData.priority = 999 --设置优先级用于同步Boss位置
    --     -- else
    --     --     heroData.priority = i
    --     -- end
    --     if MainPlayer:getPlayerId() == heroData.pid then
    --         heroData.job = 1
    --         local dataList = {}
    --         table.insert(dataList, heroData)
    --         TeamFightDataMgr:setReviveCount(heroData.reviveCount)
    --         FubenDataMgr:setFormation(clone(dataList))
    --     end
    --     table.insert(data.heros, heroData)
    -- end


    data.victoryCfg   = {}
    data.starCfg      = {}
    data.pointId      = sData.levelCid
    data.cameraAmend    = levelCfg.cameraAmend
    data.preloadMonster = self:getPreloadMonster()

    local pointId     = data.pointId
    data.map   = levelCfg.levelScript
    data.exMap = levelCfg.levelStepID
    data.bgm   = levelCfg.bgm
    --关卡胜利条件
    for index, victoryType in ipairs(levelCfg.victoryType) do
        data.victoryCfg[index] = {}
        data.victoryCfg[index].victoryType  = victoryType
        data.victoryCfg[index].victoryParam = clone(levelCfg.victoryParam[index])
        data.victoryCfg[index].victoryTypeDescribe = clone(levelCfg.victoryTypeDescribe[index])
    end

    self.battleData = data
    -- Box("playerID "..tostring(MainPlayer:getPlayerId()))
    return self.battleData
end


function BattleDataMgr:getPointId()
    return self.battleData.pointId
end

function BattleDataMgr:getLevelCfg()
    local levelCfg
    if self.battleType_ == EC_BattleType.COMMON then
        levelCfg = FubenDataMgr:getLevelCfg(self.levelCid_)
    elseif self.battleType_ == EC_BattleType.ENDLESS then
        levelCfg = FubenDataMgr:getEndlessCloisterLevelCfg(self.levelCid_)
    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then
        levelCfg = FubenDataMgr:getLevelCfg(self.levelCid_)
    end
    return levelCfg
end
function BattleDataMgr:setCurLevelCid(cid)
    self.levelCid_ = cid
end
function BattleDataMgr:getCurLevelCid()
    return self.levelCid_
end
function BattleDataMgr:getBattleData()
    return self.battleData
end
-- 1000  1  0 1100
--当前副本所用的战斗地图
function BattleDataMgr:getMap()
    return self.battleData.map
end

--清除临时数据
function BattleDataMgr:clearTempData()
    self.serverData = nil
    self.battleData = {}
end

function BattleDataMgr:getAssistInfo(level)
    return self.assistDatas[level]
end

-- function ToStringEx(value)
--     if type(value)=='table' then
--        return TableToStr(value)
--     elseif type(value)=='string' then
--         return "\'"..value.."\'"
--     else
--        return tostring(value)
--     end
-- end

-- function TableToStr(t)
--     if t == nil then return "" end
--     local retstr= "{"

--     local i = 1
--     for key,value in pairs(t) do
--         local signal = ","
--         if i==1 then
--           signal = ""
--         end

--         if key == i then
--             retstr = retstr..signal..ToStringEx(value)
--         else
--             if type(key)=='number' or type(key) == 'string' then
--                 retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
--             else
--                 if type(key)=='userdata' then
--                     retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
--                 else
--                     retstr = retstr..signal..key.."="..ToStringEx(value)
--                 end
--             end
--         end

--         i = i+1
--     end

--      retstr = retstr.."}"

--       local file,err = io.open( "D:test.lua", "wb" )
--         if err then return err end
--         file:write( retstr)
--         file:close()
--      return retstr
-- end
function BattleDataMgr:getMonsterCfg(monsterCid)
    return self.monsterMap_[monsterCid]
end

function BattleDataMgr:getBattleType()
    return self.battleData.battleType
end

function BattleDataMgr:getMonsterByType(type_)
    return self.monsterTypeMap_[type_]
end

function BattleDataMgr:getController()
    local isFlight = false
    local levelCfg = self:getLevelCfg()
    if self.battleType_ == EC_BattleType.COMMON then
        if levelCfg.fightingMode == 2 or levelCfg.fightingMode == 3 then
            isFlight = true
        end
    end

    if isFlight then
        local flightController = require("lua.logic.battle.flight.FlightController")
        return flightController
    else
        local battleController = require("lua.logic.battle.BattleController")
        return battleController
    end
end

function BattleDataMgr:setBattleResutlData(data)
    if self.battleType_ == EC_BattleType.COMMON then
        if self:getLevelCfg().dungeonType == EC_FBLevelType.MUSIC_GAME then
            self.resultData_ = data
        else
            self.resultData_.dropReward = data
        end
    elseif self.battleType_ == EC_BattleType.ENDLESS then

    elseif self.battleType_ == EC_BattleType.TEAM_FIGHT then

    end
end

function BattleDataMgr:setBattleResutlOrgData(data)
     self.resultData_ = {}
    self.resultData_.orgData = data
end

function BattleDataMgr:getBattleResultData()
    return self.resultData_
end

function BattleDataMgr:loadPracticeData()
    local function format(value, defaultValue)
        if #value == 0 then
            value = defaultValue
        end
        return tonumber(value)
    end

    local diffIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_DIFF_INDEX)
    local levelIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_LEVEL_INDEX)
    local level = UserDefault:getStringForKey(self.KEY_PRACTICE_LEVEL)
    local number = UserDefault:getStringForKey(self.KEY_PRACTICE_NUMBER)
    local hpIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_HP_INDEX)
    local superIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_SUPER_INDEX)
    local categoryIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_CATEGORY_INDEX)
    local specialHpIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_SPECIALHP_INDEX)
    local specialCategoryIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_SPECIALCATEGORY_INDEX)
    local specialLevelIndex = UserDefault:getStringForKey(self.KEY_PRACTICE_SPECIALLEVEL_INDEX)
    local specialLevel = UserDefault:getStringForKey(self.KEY_PRACTICE_SPECIALLEVEL)

    self.practiceData_ = {}
    self.practiceData_.diffIndex = format(diffIndex, 1)
    self.practiceData_.levelIndex = format(levelIndex, 1)
    self.practiceData_.level = format(level, 1)
    self.practiceData_.number = format(number, 1)
    self.practiceData_.hpIndex = format(hpIndex, 1)
    self.practiceData_.superIndex = format(superIndex, 1)
    self.practiceData_.categoryIndex = format(categoryIndex, 1)
    self.practiceData_.specialHpIndex = format(specialHpIndex, 1)
    self.practiceData_.specialCategoryIndex = format(specialCategoryIndex, 1)
    self.practiceData_.specialLevelIndex = format(specialLevelIndex, 1)
    self.practiceData_.specialLevel = format(specialLevel, 1)
    self.practiceData_.formation_ = self.formation_
end

function BattleDataMgr:loadMusicGameCustomData()
    self.musicGameCustomData = {}
    self.musicGameCustomData.diffIndex = 1
    self.musicGameCustomData.levelIndex = 1
    self.musicGameCustomData.level = 1
    self.musicGameCustomData.number = 1
    self.musicGameCustomData.hpIndex = 1
    self.musicGameCustomData.superIndex = 1
    self.musicGameCustomData.categoryIndex = 1
    self.musicGameCustomData.specialHpIndex = 2
    self.musicGameCustomData.specialCategoryIndex = 1
    self.musicGameCustomData.specialLevelIndex = 1
    self.musicGameCustomData.specialLevel = 1
    self.musicGameCustomData.formation_ = self.formation_
end

function BattleDataMgr:getMusicGameCustomData()
    if not self.musicGameCustomData then
        self:loadMusicGameCustomData()
    end
    return clone(self.musicGameCustomData)
end

function BattleDataMgr:getPracticeData()
    return clone(self.practiceData_)
end

function BattleDataMgr:cachePracticeData(data)
    if data then
        for k, v in pairs(data) do
            self.practiceData_[k] = v
        end
    end
    UserDefault:setStringForKey(self.KEY_PRACTICE_DIFF_INDEX, tostring(self.practiceData_.diffIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_LEVEL_INDEX, tostring(self.practiceData_.levelIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_LEVEL, tostring(self.practiceData_.level))
    UserDefault:setStringForKey(self.KEY_PRACTICE_NUMBER, tostring(self.practiceData_.number))
    UserDefault:setStringForKey(self.KEY_PRACTICE_HP_INDEX, tostring(self.practiceData_.hpIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_SUPER_INDEX, tostring(self.practiceData_.superIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_CATEGORY_INDEX, tostring(self.practiceData_.categoryIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_CATEGORY_INDEX, tostring(self.practiceData_.categoryIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_SPECIALHP_INDEX, tostring(self.practiceData_.specialHpIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_SPECIALCATEGORY_INDEX, tostring(self.practiceData_.specialCategoryIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_SPECIALLEVEL_INDEX, tostring(self.practiceData_.specialLevelIndex))
    UserDefault:setStringForKey(self.KEY_PRACTICE_SPECIALLEVEL, tostring(self.practiceData_.specialLevel))
end

function BattleDataMgr:getRacingEndlessBuff()
    return self.racingEndlessBuff_ or {}
end
--转换线路图
function BattleDataMgr:transRoute(_randomDungeons)
    local randomDungeons = clone(_randomDungeons)
    for i,v in ipairs(randomDungeons) do
        v.index = v.index + 1
        if v.branchDungeonId and v.branchDungeonId > 0 then --支线关卡 
            v.branchIndex = v.branchIndex + 1 
        end
    end
    local nodes = {}
    local preNode
    for i, v in ipairs(randomDungeons) do
        
        local node = createNode(v.index,v.dungeonId,i == #randomDungeons)
        nodes[v.index] = node

        if preNode then 
            local nextIndexs = NextIndexMap[preNode.index]
            for k, index in ipairs(nextIndexs) do
                if index == node.index then 
                    preNode.next[k] = index
                end
            end

            local nextIndexs = NextIndexMap[node.index]
            for k, index in ipairs(nextIndexs) do
                if index == preNode.index then 
                    node.next[k] = index
                end
            end
        end
        preNode = node
        if v.branchDungeonId and v.branchDungeonId > 0 then 
            local childNode = createNode(v.branchIndex,v.branchDungeonId,false)
            nodes[v.branchIndex] = childNode
            local nextIndexs = NextIndexMap[childNode.index]
            for k, index in ipairs(nextIndexs) do
                if index == node.index then 
                    childNode.next[k] = index
                end
            end
 
            local nextIndexs = NextIndexMap[node.index]
            for k, index in ipairs(nextIndexs) do
                if index == childNode.index then 
                    node.next[k] = index
                end
            end

        end 
    end
    dump(randomDungeons)
    dump(nodes)
    -- Box("xxx")
    return nodes
end

function BattleDataMgr:isPracticeLevel()
    return self:getLevelCfg().dungeonType == EC_FBLevelType.PRACTICE
end

function BattleDataMgr:isMusicGameLevel()
    return self:getLevelCfg().dungeonType == EC_FBLevelType.MUSIC_GAME
end

local instace = BattleDataMgr:new()
return instace
