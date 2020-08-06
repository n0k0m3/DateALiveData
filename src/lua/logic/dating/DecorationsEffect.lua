local DecorationsEffect = class("DecorationsEffect")

local EffectType = {
    animation       = 1, --动画
    music           = 2, --背景音乐
    soundEffect     = 3, --音效
    kanBanAction    = 4, --看板娘动作
    kanBanExpression= 5, --看板娘表情
    triggerDating   = 6, --触发约会
}

function DecorationsEffect:ctor(targer,effectId,elvesNpc)
    local decEffectTable = clone(TabDataMgr:getData("DecorationsEffect"))
    local decEffectData = decEffectTable[effectId]
    print("decEffectData ",decEffectData)
    self.type = decEffectData.type
    self.name = decEffectData.name
    self.target = targer
    self.elvesNpc = elvesNpc
end

function DecorationsEffect:play()
    if self.type == EffectType.animation then
        self.target:play(self.name)
    elseif self.type == EffectType.music then
        TFAudio.stopMusic()
        TFAudio.playBmg(self.name,true)
    elseif self.type == EffectType.soundEffect then
        TFAudio.playEffect(self.name)
    elseif self.type == EffectType.kanBanAction then
        self.elvesNpc:newStartAction(self.name,EC_PRIORITY.FORCE)
    elseif self.type == EffectType.kanBanExpression then
        self:playExpression()
    elseif self.type == EffectType.triggerDating then
        self:triggerDating()
    end
end

function DecorationsEffect:playExpression()
    local nameList = string.split(self.name, "-")
    local exPath = nameList[1]
    local exName = nameList[2]
    local exAction = nameList[3]
    local expressionInfo = {}
    expressionInfo.rolePath = exPath
    expressionInfo.roleName = exName
    expressionInfo.roleAction = exAction
    expressionInfo.roleScale = self.target:Scale()

    self.elvesNpc:removeExpression()
    self.elvesNpc:addExpression(expressionInfo)
end

function DecorationsEffect:triggerDating()
    -- DatingDataMgr:sendGetSciptMsg()
    --这里约会只展示不做奖励
    DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,tonumber(self.name))
end

return DecorationsEffect