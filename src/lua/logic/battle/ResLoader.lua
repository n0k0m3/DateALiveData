local BattleConfig = import(".BattleConfig")
local BattleUtils  = import(".BattleUtils")
local BattleMgr    = import(".BattleMgr")
local levelParse   = import(".LevelParse")
local enum = import(".enum")
local eResType  =  enum.eResType
local eEffectType = enum.eEffectType
local _print = print
local print = BattleUtils.print
_print = print
local ResLoader = {}
ResLoader.cacheSpine = {}
local eLoadType =
{
    LT_SYNC  = 1 , --同步加载
    LT_ASYNC = 2   --异步加载
}
ResLoader.IS_CACHE_SKELETONODE = true  --是否缓存spine动画
ResLoader.loadType   = eLoadType.LT_SYNC
ResLoader.Interval   = 1 --1000/GameConfig.FPS
ResLoader.IS_PRELOAD_SKILL_EFFECT = true --是否预加载技能特效
ResLoader.IS_AUTO_RELEASE = false

if TFDeviceInfo.isLowDevice() then 
    ResLoader.IS_PRELOAD_SKILL_EFFECT = false
    ResLoader.IS_AUTO_RELEASE = true
    print_("LowDevice not pre load")
end

local defaultResList =
{
    "ui/battle/shadow.png",
    -- "ui/battle/noise.jpg",
    -- "ui/battle/loadbar/hp1.png",
}
local defaultEffectList = 
{
    -- "effect/effect_monster_die/effect_monster_die",
    -- "effect/effect_articulo/effect_articulo",
}
--大世界资源列表 只显示10种模型
local osdRoleResMap = {}
local function gettime()
    return socket.gettime()*1000
end
local function createResInfo( resType , resName)
    return {resType = resType, resName = resName}
end

--设置模型的全局缩放
function ResLoader.setModalScale(scale)
    BattleConfig.MODAL_SCALE = scale
end

--还原模型的全局缩放
function ResLoader.resetModalScale()
    BattleConfig.MODAL_SCALE = 0.6
end

--检查资源是否有效
function ResLoader.isValid(resName)
    resName = tostring(resName)
    if resName ~= "nil" and resName ~="0" and resName ~="" and resName ~= nil then
        return true
    end
    return false
end

--战斗资源列表
function ResLoader.createResList(data)
    local roleNameMap = {} --角色 模型

    --所有技能
    local effecNameMap = {}
    local soundNameMap = {}
    local imageNameMap = {}
    local function createSimpleOne(heroData)
        local formData = TabDataMgr:getData("HeroForm",heroData.beginForm)
        roleNameMap[formData.model] = formData.model
    end
    local function createOne(heroData)
        --预加载初始形态的资源
        local formData = TabDataMgr:getData("HeroForm",heroData.beginForm)
        roleNameMap[formData.model] = formData.model
        --TODO 默认技能资源预加载 未处理完成
        local skills = {}
        if ResLoader.IS_PRELOAD_SKILL_EFFECT then
            skills = formData.skills 
        end
        for m , skillId in ipairs(skills) do
            local skillData = BattleDataMgr:getSkillData(skillId,heroData.angleDatas)
            --ICON
            if  not  skillData then
                Box("skill "..tostring(skillId).." not found")
            end
            if ResLoader.isValid(skillData.icon) then
                imageNameMap[skillData.icon] = skillData.icon
            end
            --动作数据
            local actionDatas = BattleDataMgr:getActionDatas(skillId)
            if not  actionDatas then
                print("skill action" ..tostring(skillId).." not found")
                return
            end
            for k, actionData in pairs(actionDatas) do
                -- print("actionData.id::",actionData.id)
                local actionData = BattleDataMgr:getActionData(actionData.id,heroData.angleDatas)
                local showData = BattleDataMgr:getShowData(actionData.id)
                if showData then
                    -- dump(showData)
                    for kk, effect in pairs(showData.effectsUp) do
                        effecNameMap[effect.animation] = effect.animation
                    end
                    for kk, effect in pairs(showData.effectsDown) do
                        effecNameMap[effect.animation] = effect.animation
                    end
                    --觉醒模型(角色类型) TODO 和角色模型应该相同????
                    if showData.showAction then
                        if ResLoader.isValid(showData.showAction.animation) then
                            roleNameMap[showData.showAction.animation] = showData.showAction.animation
                        end
                    end
                    --觉醒音效
                    if ResLoader.isValid(showData.showSound) then
                        soundNameMap[showData.showSound] = showData.showSound
                    end
                end

                --包涵特效
                for i, effectId in ipairs(actionData.includeEffect) do
                    local effectData = BattleDataMgr:getEffectData(effectId,heroData.angleDatas)
                    if not effectData then
                        Box("effect "..tostring(effectId).." not found")
                    else
                        if ResLoader.isValid(effectData.resource) then
                            effecNameMap[effectData.resource] = effectData.resource
                        end
                        if ResLoader.isValid(skillData.endEffect) then
                           effecNameMap[effectData.endEffect] =effectData.endEffect
                        end
                        if ResLoader.isValid(skillData.hurtEffect) then
                            effecNameMap[effectData.hurtEffect]=effectData.hurtEffect
                        end
                    end
                end
            end
            --动作附带特效预加载处理
            local roleActions = BattleDataMgr:getActionNames(heroData.model)
            if roleActions then 
                for i, actionInfos in ipairs(roleActions) do
                    for k,actionInfo in pairs(actionInfos) do
                        for i, resource in ipairs(actionInfo.resourceUp) do
                            effecNameMap[resource] = resource
                        end
                        for i, resource in ipairs(actionInfo.resourceDown) do
                            effecNameMap[resource] = resource
                        end
                    end
                end
            end
        end
    end
    local showAttackEffect = true
    -- if  data.battleType == EC_BattleType.HIGH_TEAM_FIGHT 
    --     or data.battleType == EC_BattleType.TEAM_FIGHT then 
    --     if data.teamType ~= 5 then
    --         showAttackEffect = SettingDataMgr:getAttactEffectVal()
    --     end
    -- end
 
    for k , heroData in ipairs(data.heros) do
        if showAttackEffect then 
            createOne(heroData)
        else
            if heroData.pid == MainPlayer:getPlayerId() then
                dump("createOne:"..heroData.pid)
                createOne(heroData)
            else
                dump("createSimpleOne:"..heroData.pid)
                createSimpleOne(heroData)
            end
        end
    end

-- dump(data.preloadMonster,"data.preloadMonster")
--     Box("xxx")
    for _, monsterCid in ipairs(data.preloadMonster) do
        local monsterCfg = BattleDataMgr:getMonsterCfg(monsterCid)
        if monsterCfg then
            createOne(monsterCfg)
        else
            Box("No monster:"..monsterCid)
        end
        
    end

    local resList = {}
    for k , actorModel in pairs(roleNameMap) do
        actorModel = string.format("effect/%s/%s",actorModel,actorModel)
        table.insert(resList,createResInfo(eResType.RT_IMAGE,actorModel..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,actorModel))
    end
    -- TODO临时屏蔽特效预加载

    for k , effecName in pairs(effecNameMap) do
        effecName = string.format("effect/%s/%s",effecName,effecName)
        table.insert(resList,createResInfo(eResType.RT_IMAGE,effecName..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,effecName))
    end
    -- TODO 音效暂不做预加载处理
    -- for k , soundName in pairs(soundNameMap) do
        -- table.insert(resList,createResInfo(eResType.RT_SOUND,soundName))
    -- end
    --战斗主场景资源
    

    local battleView = require(TFGlobalUtils:loadUIConfigFilePath("lua.uiconfig.battle.battleView"))
    local ctrlView   = require(TFGlobalUtils:loadUIConfigFilePath("lua.uiconfig.battle.ctrlView"))
    for k , texture in pairs(battleView.respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    for k , texture in pairs(ctrlView.respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    --关卡地图资源
    levelParse:clean()
    levelParse:loadJson(data.map,data.exMap) --加载json
    local respaths = levelParse:getRespaths()
    for k , texture in pairs(respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    for k , effecName in pairs(respaths.effects) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,effecName..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,effecName))
    end
    --默认资源
    for k , texture in pairs(defaultResList) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    -- for k , effecName in pairs(defaultEffectList) do
    --     table.insert(resList,createResInfo(eResType.RT_IMAGE,effecName..".png"))
    --     table.insert(resList,createResInfo(eResType.RT_SPINE,effecName))
    -- end

    table.sort( resList, function ( a , b )
        return a.resType > b.resType
    end )
    return resList
end



function ResLoader.loadAllRes(data ,callFunc)
    --處理資源預加載
    GuideDataMgr:setIsBattle(true)
    AlertManager:changeScene(SceneType.Load)
    ResLoader.stopTimer()
    ResLoader.timer = TFDirector:addTimer(100, 1, nil, function ()
        ResLoader.stopTimer()
        local resList = ResLoader.createResList(data)
        ResLoader.startLoad(resList, callFunc)
    end)           
end

function ResLoader.createResListWidthFlight(data)
    local roleNameMap = {} --角色 模型

    --所有技能
    local effectNameMap = {}
    local soundNameMap = {}
    local imageNameMap = {}
    local function createPlayer(playerData)
        roleNameMap[playerData.model] = playerData.model
        if playerData.wingman then
            roleNameMap[playerData.wingman.model] = playerData.wingman.model
            for _, levels in ipairs(playerData.wingman.flySkills) do
                for _, skill in ipairs(levels) do
                    if skill.cfg.hitEffect.effectName and skill.cfg.hitEffect.effectName ~= "" then
                        effectNameMap[skill.cfg.hitEffect.effectName] = skill.cfg.hitEffect.effectName
                    end
                    if skill.cfg.fireEffect.effectName and skill.cfg.fireEffect.effectName ~= "" then
                        effectNameMap[skill.cfg.fireEffect.effectName] = skill.cfg.fireEffect.effectName
                    end
                    for _, barrage in ipairs( skill.emitter) do
                        BulletCache:PreCache(barrage.Bullet.Path, 10)
                    end
                end
            end
        end
        for _, levels in ipairs(playerData.flySkills) do
            for _, skill in ipairs(levels) do
                if skill.cfg.hitEffect.effectName and skill.cfg.hitEffect.effectName ~= "" then
                    effectNameMap[skill.cfg.hitEffect.effectName] = skill.cfg.hitEffect.effectName
                end
                if skill.cfg.fireEffect.effectName and skill.cfg.fireEffect.effectName ~= "" then
                    effectNameMap[skill.cfg.fireEffect.effectName] = skill.cfg.fireEffect.effectName
                end
                for _, barrage in ipairs( skill.emitter) do
                    BulletCache:PreCache(barrage.Bullet.Path, 60)
                end
            end
        end
        for _, skill in ipairs(playerData.skills) do
            if skill.effectName and skill.effectName ~= "" then
                effectNameMap[skill.effectName] = skill.effectName
            end
            if skill.hitEffect.effectName and skill.hitEffect.effectName ~= "" then
                effectNameMap[skill.hitEffect.effectName] = skill.hitEffect.effectName
            end
            if skill.fireEffect.effectName and skill.fireEffect.effectName ~= "" then
                effectNameMap[skill.fireEffect.effectName] = skill.fireEffect.effectName
            end
        end
        if playerData.launchEffect and playerData.launchEffect.effectName and playerData.launchEffect.effectName ~= "" then
            roleNameMap[playerData.launchEffect.effectName] = playerData.launchEffect.effectName
        end
        if playerData.bumpEffect and playerData.bumpEffect.effectName and playerData.bumpEffect.effectName ~= "" then
            effectNameMap[playerData.bumpEffect.effectName] = playerData.bumpEffect.effectName
        end

        if playerData.moveEffect and playerData.moveEffect.effectName and playerData.moveEffect.effectName~= "" then
            roleNameMap[playerData.moveEffect.effectName] = playerData.moveEffect.effectName
        end
    end

    local function createMonster(monsterData)
        roleNameMap[monsterData.model] = monsterData.model
        if monsterData.flySkills then
            for i, skill in ipairs(monsterData.flySkills) do
                if skill.cfg.hitEffect.effectName and skill.cfg.hitEffect.effectName ~= "" then
                    effectNameMap[skill.cfg.hitEffect.effectName] = skill.cfg.hitEffect.effectName
                end
                if skill.cfg.fireEffect.effectName and skill.cfg.fireEffect.effectName ~= "" then
                    effectNameMap[skill.cfg.fireEffect.effectName] = skill.cfg.fireEffect.effectName
                end
                for _, barrage in ipairs( skill.emitter) do
                    BulletCache:PreCache(barrage.Bullet.Path)
                end
            end
        end
        if monsterData.deadEffect and monsterData.deadEffect.effectName and monsterData.deadEffect.effectName ~= "" then
            effectNameMap[monsterData.deadEffect.effectName] = monsterData.deadEffect.effectName
        end
        if monsterData.warningEffect and monsterData.warningEffect.effectName and monsterData.warningEffect.effectName ~= "" then
            effectNameMap[monsterData.warningEffect.effectName] = monsterData.warningEffect.effectName
        end
        --imageNameMap[monsterData.dropItem.]
        for _, item in pairs(monsterData.itemDrop) do
            if item.data and item.data.resource and item.data.resource ~= "" then
                if item.data.resType == 1 then
                    imageNameMap[item.data.resource] = item.data.resource
                elseif item.data.resType == 2 then
                    effectNameMap[item.data.resource] = item.data.resource
                else
                    printError("item id:%d resource resType error", item.data.id)
                end
            end
            if item.data and item.data.getResource and item.data.getResource ~= "" then
                if item.data.resType == 1 then
                    imageNameMap[item.data.getResource] = item.data.getResource
                elseif item.data.resType == 2 then
                    effectNameMap[item.data.getResource] = item.data.getResource
                else
                    printError("item id:%d getResource resType error", item.data.id)
                end
            end
        end
    end

    for k , player in ipairs(data.heros) do
        createPlayer(player)
    end

    -- dump(data.preloadMonster,"data.preloadMonster")
    --     Box("xxx")
    for _, values in pairs(data.preloadMonster) do
        for _, monster in pairs(values) do
            createMonster(monster)
        end
    end

    local resList = {}
    for k , actorModel in pairs(roleNameMap) do
        actorModel = string.format("effect/%s/%s",actorModel,actorModel)
        table.insert(resList,createResInfo(eResType.RT_IMAGE,actorModel..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,actorModel))
    end
    -- TODO临时屏蔽特效预加载

    for k , effectName in pairs(effectNameMap) do
        effectName = string.format("effect/%s/%s",effectName,effectName)
        --table.insert(resList,createResInfo(eResType.RT_IMAGE,effectName..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,effectName))
    end
    -- TODO 音效暂不做预加载处理
    -- for k , soundName in pairs(soundNameMap) do
    -- table.insert(resList,createResInfo(eResType.RT_SOUND,soundName))
    -- end
    --战斗主场景资源
    local battleView = require(TFGlobalUtils:loadUIConfigFilePath("lua.uiconfig.battle.battleView"))
    local ctrlView   = require(TFGlobalUtils:loadUIConfigFilePath("lua.uiconfig.battle.flightCtrlView"))
    for k , texture in pairs(battleView.respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    for k , texture in pairs(ctrlView.respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    --关卡地图资源
    levelParse:clean()
    levelParse:loadJson(data.map,data.exMap) --加载json
    local respaths = levelParse:getRespaths()
    for k , texture in pairs(respaths.textures) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    for k , effecName in pairs(respaths.effects) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,effecName..".png"))
        table.insert(resList,createResInfo(eResType.RT_SPINE,effecName))
    end
    --默认资源
    for k , texture in pairs(defaultResList) do
        table.insert(resList,createResInfo(eResType.RT_IMAGE,texture))
    end
    table.sort( resList, function ( a , b )
        return a.resType > b.resType
    end )
    -- dump(resList)
    -- Box("xxxx")
    return resList
end

function ResLoader.loadAllResWithFlight(data, callFunc)
    GuideDataMgr:setIsBattle(true)
    AlertManager:changeScene(SceneType.Load)     
    ResLoader.stopTimer()
    ResLoader.timer = TFDirector:addTimer(100, 1, nil, function ()
        ResLoader.stopTimer()
        local resList = ResLoader.createResListWidthFlight(data)
        ResLoader.startLoad(resList, callFunc)
    end) 
end
function ResLoader.startLoad(resList, callFunc)
    if ResLoader.loadType == eLoadType.LT_SYNC then  -- 同步加载
        ResLoader.loadResSync(100,resList,callFunc)
    else
        ResLoader.loadResAsync(100,resList,callFunc)
    end
end
function ResLoader.loadRes(resInfo)
    print("load res",resInfo)
    local time = gettime()
    local resType = resInfo.resType
    if resType == eResType.RT_SPINE then
        ResLoader.loadSpine(resInfo.resName)
    elseif resType == eResType.RT_IMAGE then
        ResLoader.loadImage(resInfo.resName)
    elseif resType == eResType.RT_SOUND then
        ResLoader.loadSound(resInfo.resName)
    end
    return gettime() - time
end
--图片
function ResLoader.loadImage(resName)
    me.TextureCache:addImage(resName)
end
--spine
function ResLoader.loadSpine(filePath,scale)
    scale =  scale or 1
    if ResLoader.IS_CACHE_SKELETONODE  then
        ResLoader.getSkeletonNode(filePath)
    else
        SpineCache:getInstance():addFile(filePath..".skel",filePath..".atlas",scale)
    end
end
--音效
function ResLoader.loadSound(filePath)
     TFAudio.preloadMusic(filePath)
end

function ResLoader.createSpine(resPath,scale,toSetupPose)
    if toSetupPose == nil then
        toSetupPose = true
    end
    scale = scale and scale or BattleConfig.MODAL_SCALE
    local skeletonNode  = ResLoader.getSkeletonNode(resPath,true)
    skeletonNode:setupPoseWhenPlay(toSetupPose)
    skeletonNode.bSetupPoseWhenPlay = toSetupPose
    if skeletonNode then
        skeletonNode:setScale(scale)
    end
    return skeletonNode
end

function ResLoader.createRole(roleName,scale)
    local resPath = string.format("effect/%s/%s", roleName, roleName)
    return ResLoader.createSpine(resPath,scale,BattleConfig.TO_SETUP_POSE)
end

function ResLoader.createEffect(effectName,scale)
    if not effectName or effectName == "" then
        printError("xxx")
    end
    local resPath = string.format("effect/%s/%s", effectName, effectName)
    local skeletonNode = ResLoader.createSpine(resPath,scale)
    skeletonNode:setScheduleUpdateWhenEnter(true)
    BattleMgr.bindSchedule(skeletonNode)
    return skeletonNode
end


--同步加载
function ResLoader.loadResSync(proportion,resList,callFunc)
    --资源同步加载
    local resSize = #resList
    local timerID
    local time = 0
    local startTime = gettime()
    ResLoader.stopTimer()
    ResLoader.timer = TFDirector:addTimer(ResLoader.Interval, -1, nil, function()
        if #resList > 0 then
            time = time + ResLoader.loadRes(resList[1])
            table.remove(resList,1)
            local status = (100 - proportion) + proportion*(resSize - #resList)/resSize
            EventMgr:dispatchEvent(EV_RES_LOAD_STATUS,math.floor(status))
            return
        end
        ResLoader.stopTimer()
        if callFunc then
            print("load res consume time  ", gettime() -startTime ,time )
            callFunc()
        end
    end)
end


--异步加载(只有图片spine动画能异步加载，音效不支持异步加载)
function ResLoader.loadResAsync(proportion ,resList,callFunc)
    local size   = #resList
    local loaded = 0
    local function asynCallFunc( ... )
        loaded = loaded + 1
        local percent = math.floor(proportion*loaded/size)
        EventMgr:dispatchEvent(EV_RES_LOAD_STATUS,percent)
        if loaded == size then
            callFunc()
        end
    end

    for i, resInfo in ipairs(resList) do
        if resInfo.resType == eResType.RT_IMAGE then
            me.TextureCache:addFileAsync(resInfo.resName,function(...)
                asynCallFunc(...)
            end,1)
        elseif resInfo.resType == eResType.RT_SPINE then
            SpineCache:getInstance():addFileAsync(resInfo.resName..".skel",resInfo.resName..".atlas",function ( result )
                asynCallFunc(result)
            end)
        else
            loaded = loaded + 1
        end
    end
end

--动画缓存
local skeletonNodeCache = {}

function ResLoader.clean()
    _print("ResLoader.clean")
    _print(skeletonNodeCache)
    for k , skeletonNode in pairs(skeletonNodeCache) do
        _print(string.format("release[%s][%s]",skeletonNode.resPath,skeletonNode:retainCount()))
        skeletonNode:release()
    end
    skeletonNodeCache = {}
    osdRoleResMap  ={}
end


--
function ResLoader.stopTimer()
    if ResLoader.timer ~= nil then
        TFDirector:removeTimer(ResLoader.timer)
        ResLoader.timer = nil
    end
end

function ResLoader.getSkeletonNode(resPath,autoRelease)
    if ResLoader.IS_AUTO_RELEASE and autoRelease then
        ResLoader.autoRelease(resPath)
    end
    if ResLoader.IS_CACHE_SKELETONODE  then
        local skeletonNode = skeletonNodeCache[resPath]
        if skeletonNode and skeletonNode:retainCount() == 1 then
            --找到空闲的重置一下拿出去用
            skeletonNode:removeMEListener(TFARMATURE_EVENT)
            skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
            skeletonNode:removeMEListener(TFWIDGET_ENTER)
            skeletonNode:removeMEListener(TFWIDGET_EXIT)
            -- _print("找到 skeleton:"..skeletonNode:retainCount().." "..resPath)
            --重置位置
            skeletonNode:setPosition(me.p(0,0))
            skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
            skeletonNode:setColor(me.WHITE)
            skeletonNode:setRotation(0)
            skeletonNode:clearTracks()
            skeletonNode.useTime  = os.time()
            return skeletonNode
        end

        --新创建并做retain 防止被释放
        skeletonNode   = SkeletonAnimation:create(resPath)
        skeletonNode.resPath = resPath
        skeletonNode:setDebugSlotsEnabled(BattleConfig.DEBUG_SLOTS)
        skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
        if not skeletonNodeCache[resPath] then
            skeletonNodeCache[resPath] = skeletonNode
            skeletonNode:retain()
        end
        skeletonNode.useTime  = os.time()
        -- _print("创建 skeleton:"..skeletonNode:retainCount().." "..resPath)
        return skeletonNode
    else
        local skeletonNode = SkeletonAnimation:create(resPath)
        skeletonNode.resPath = resPath
        skeletonNode:setDebugSlotsEnabled(BattleConfig.DEBUG_SLOTS)
        skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
        --skeletonNode:setClearOnDestroy(true);
        return skeletonNode
    end
end


function ResLoader.createSkeletonAnimation(resPath,scale)
    -- resPath = string.format("effect/%s/%s",resPath,resPath)
    scale = scale and scale or BattleConfig.MODAL_SCALE
    local skeletonNode   = SkeletonAnimation:create(resPath)
    skeletonNode.resPath = resPath
    skeletonNode:setDebugSlotsEnabled(BattleConfig.DEBUG_SLOTS)
    skeletonNode:setAnimationFps(GameConfig.ANIM_FPS)
    skeletonNode:setScale(scale)
    return skeletonNode
end

--异步加载动画
function ResLoader.createSkeletonAnimationAsync(resPath,scale,asynCallFunc)
    if ResLoader.loadType   == eLoadType.LT_SYNC then
        SpineCache:getInstance():addFile(resPath..".skel",resPath..".atlas")
        local skeleton = ResLoader.createSkeletonAnimation(resPath,scale)
        asynCallFunc(skeleton)
    else
        SpineCache:getInstance():addFileAsync(resPath..".skel",resPath..".atlas",function ( result )
            local skeleton = ResLoader.createSkeletonAnimation(resPath,scale)
            asynCallFunc(skeleton)
        end)
    end
end

--自动释放
function ResLoader.autoRelease(resPath)
    local time = os.time()
    local willRelease
    for _resPath , skeletonNode in pairs(skeletonNodeCache) do
        if _resPath ~= resPath then
            if skeletonNode:retainCount() == 1 then
                local passTime = time - skeletonNode.useTime
                if passTime > 10 then  --10 秒回收一次
                    print_(string.format("XXX res : %s Time: %s",_resPath,passTime))
                    skeletonNode:release() 
                    skeletonNodeCache[_resPath] = nil
                    willRelease = true
                end
            end
        end  
    end

    if willRelease then
        print_("willRelease"..tostring(willRelease))
        SpineCache:getInstance():clearUnused()
        me.TextureCache:removeUnusedTextures()
    end
end

--只能创建10种不同的模型
function ResLoader.createRoleEx(roleName,scale)
    if osdRoleResMap[roleName] or #table.keys(osdRoleResMap) < 10 then 
        osdRoleResMap[roleName] = true
        local resPath = string.format("effect/%s/%s", roleName, roleName)
        return ResLoader.createSpine(resPath,scale,BattleConfig.TO_SETUP_POSE)
    end
end

return ResLoader
