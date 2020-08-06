local BattleUtils = import(".BattleUtils")
local EventTrigger= import(".EventTrigger")
local enum   = import(".enum")
local eState = enum.eState
local eMusicTriggerType = enum.eMusicTriggerType
local MusicMgr = {}
local this = MusicMgr
local GLOBAL_CD = 3000

local Music = class("Music")

function Music:ctor(data)
    self.nTime   = 0
    self.nCommon = 0
    self.data  = data
end

function Music:checkParam(value)
    value = value or 0
    if self.data.eventType == eMusicTriggerType.INJURED then
        return value >= self.data.param
    end
    return true
end

function Music:play()
    if self:isEnable() then
        if RandomGenerator._triggerTest10000(self.data.probability) then
            self:starCD()
            local index = RandomGenerator._random(1,#self.data.resources)
            local res   = self.data.resources[index]
            if this.host then
                if not this.host:checkMusicMutex(1) then
                    local handle = BattleUtils.playEffect(res)
                    if handle then
                        this.host:setMusicMutex(handle,2)
                        TFAudio.setFinishCallback(handle, function()
                            this.host:setMusicMutex(handle,nil)
                        end)
                    end
                end
            else
                BattleUtils.playEffect(res)
            end
            return true
        end
    end
end

function Music:starCD()
    self.nTime = self.data.cdTime
end

function Music:isEnable()
    return self.nTime <= 0 and #self.data.resources > 0
end

function Music:update(dt)
    -- print("dt",dt,self.nTime)
    if self.nTime > 0 then
        self.nTime = self.nTime - dt
    end
    if self.data.eventType == eMusicTriggerType.IDLE then
        local hero = battleController:getCaptain()
        if hero and hero:getState() == eState.ST_STAND then
            self.nCommon = self.nCommon + dt
            if self.nCommon > self.data.param then
                self:play()
                self.nCommon = 0
            end
        else
            self.nCommon = 0
        end
    elseif self.data.eventType == eMusicTriggerType.SAME_TEAM then --检查是否同队出战的队友音效
        --检查队伍里是否有对应角色
        if self:isEnable() then
            self.nCommon = self.nCommon + dt --每秒检查一次
            if self.nCommon > 1000 then
                self.nCommon = 0
                local hero = battleController.getHeroWithCid(self.data.param)
                if hero then 
                    self:play()
                end
            end
        end
    end
end



--------------------
function MusicMgr.init()
    this.musicMap  = {}
    this.musicList = {}
    this.roleMusic = {}
    this.nGlobalCDTime = 0
end

--设置全局CD
function MusicMgr.startGlobalCD()
    this.nGlobalCDTime = GLOBAL_CD
end

function MusicMgr.clean()
    this.musicMap  = {}
    this.musicList = {}
    this.roleMusic = {}
    this.nGlobalCDTime = 0
    TFAudio.stopAllEffects(true)
end
function MusicMgr.load(roleID,host)
    host:clearMusicMutex()
    if this.host then
        this.host:clearMusicMutex()
    end
    this.host = host
    if this.roleMusic[roleID] then
        this.musicMap  = this.roleMusic[roleID].musicMap
        this.musicList = this.roleMusic[roleID].musicList
        return
    end
    this.musicMap  = {}
    this.musicList = {}

    local eventDatas = BattleDataMgr:getEventMusic(roleID)
        -- print("roleID",roleID,eventDatas)
    if eventDatas then
        for i , datas in pairs(eventDatas) do
            for k , data in pairs(datas) do
                for i, formId in ipairs(data.formId) do
                    local music = Music:new(data)
                    this.musicMap[formId]  = this.musicMap[formId] or {}
                    this.musicList[formId] = this.musicList[formId] or {}
                    this.musicMap[formId][data.eventType] = music
                    table.insert(this.musicList[formId], music)
                end
            end
        end
    end
    this.roleMusic[roleID] = {}
    this.roleMusic[roleID].musicMap = this.musicMap
    this.roleMusic[roleID].musicList = this.musicList
end

function MusicMgr.isEnabled()
    if EventTrigger:isRunning() then
        --剧情进行中不播放事件音效
        return
    end
    if not this.host then
        return 
    end
    return this.nGlobalCDTime <= 0
end

function MusicMgr.update(dt)
    if this.nGlobalCDTime > 0 then
        this.nGlobalCDTime = this.nGlobalCDTime - dt
        -- print(this.nGlobalCDTime  ,dt)
    end
    if this.isEnabled() then
        local formId = this.host:getFormId()
        if this.musicList[formId] then 
            for i , music in ipairs(this.musicList[formId]) do
                music:update(dt)
            end
        end
    end
end


function MusicMgr.play(eventType,param)
    -- print("try play music ",eventType)
    if this.isEnabled() then
        local formId = this.host:getFormId()
        local musicMap = this.musicMap[formId]
        if musicMap then 
            local music = musicMap[eventType]
            if music and music:checkParam(param) then
                if music:play() then
                    this.startGlobalCD()
                end
            end
        else
            -- Box(tostring(this.host:getName()) .." "..tostring(formId).."形态下音效不存在")
        end
    end
end

--胜利音效
function MusicMgr.playVertigo()
    this.play(eMusicTriggerType.VERTIGO)
end
--失败音效
function MusicMgr.playDefeat()
    this.play(eMusicTriggerType.DEFEAT)
end

--出场音效(切换角色时)
function MusicMgr.playBorn()
    this.play(eMusicTriggerType.BORN)
end

--击杀音效(切换角色时)
function MusicMgr.playKill()
    this.play(eMusicTriggerType.KILL)
end

--受到巨大的伤害
function MusicMgr.playInjured(hurtValue)
    hurtValue = math.abs(hurtValue)
    --这个需要检查伤害值
    this.play(eMusicTriggerType.INJURED,hurtValue)
end

--遇到强大敌人(精英怪)
function MusicMgr.playEnemySpotted()
    this.play(eMusicTriggerType.ENEMY_SPOTTED)
end

--战斗结束音效
function MusicMgr.playEndOfBattle(win) 
    if win then   
        this.playVertigo()
    else
        this.playDefeat()
    end
end


MusicMgr.init()
return MusicMgr