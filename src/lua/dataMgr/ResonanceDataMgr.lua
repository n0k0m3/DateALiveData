
local BaseDataMgr = import(".BaseDataMgr")
local ResonanceDataMgr = class("ResonanceDataMgr", BaseDataMgr)

function ResonanceDataMgr:init()

    TFDirector:addProto(s2c.MANA_RESONANCE_RES_ALL_MANA_INFO, self, self.onRecvAllManaInfo)
    TFDirector:addProto(s2c.MANA_RESONANCE_RES_MANA_LEVEL_UP, self, self.onRecvManaLevelUp)
    TFDirector:addProto(s2c.MANA_RESONANCE_RES_MANA_EQUIP, self, self.onRecvManaEquip)

    ---消耗
    self.manaCost_ = {}
    local manaCostCfg = TabDataMgr:getData("ManaCost")
    for k,v in pairs(manaCostCfg) do
        local quality = v.quality
        local lv = v.lv
        if not self.manaCost_[quality] then
            self.manaCost_[quality] = {}
        end
        self.manaCost_[quality][lv] = {cost = v.cost,restriction = v.restriction}
    end

    ---基础信息
    self.sortManaResonance = {}
    self.manaResonanceMap_ = TabDataMgr:getData("ManaResonance")
    for k,v in pairs(self.manaResonanceMap_) do
        table.insert(self.sortManaResonance,v)
    end
    table.sort(self.sortManaResonance,function (a,b)
        if a.quality == b.quality then
            return a.id < b.id
        end
        return a.quality > b.quality
    end)

    self.manaResonanceArray_ = {}
    for k,v in pairs(self.sortManaResonance) do
        local skillType = v.skillType
        if not self.manaResonanceArray_[skillType] then
            self.manaResonanceArray_[skillType] = {}
        end
        table.insert(self.manaResonanceArray_[skillType],v)
    end

    self.manaSkill_ = {}
    local manaSkillCfg = TabDataMgr:getData("ManaSkill")
    for k,v in pairs(manaSkillCfg) do
        local crystalId = v.crystalId
        local skillLevel = v.skillLevel
        if not self.manaSkill_[crystalId] then
            self.manaSkill_[crystalId] = {}
        end
        self.manaSkill_[crystalId][skillLevel] = v.buffId
    end

    self.passiveSkillsCfg = TabDataMgr:getData("PassiveSkills")
    --PassiveSkills
    self:reset()
end

function ResonanceDataMgr:reset()
    self.unLockArray_ = {}
    self.equipedSkill_ = {}
    self.unLockSkillMap_ = {}
end

function ResonanceDataMgr:onLogin()
    self:reset()
    TFDirector:send(c2s.MANA_RESONANCE_REQ_ALL_MANA_INFO, {})
    return {s2c.MANA_RESONANCE_RES_ALL_MANA_INFO}
end

function ResonanceDataMgr:onEnterMain()


end

function ResonanceDataMgr:getPassiveSkillId(cid,level)
    if not self.manaSkill_[cid] then
        return
    end
    return self.manaSkill_[cid][level]
end

function ResonanceDataMgr:getPassiveSkillCfg(cid)
    return self.passiveSkillsCfg[cid]
end

function ResonanceDataMgr:getManaResonanceCfg(cid)
    return self.manaResonanceMap_[cid]
end

function ResonanceDataMgr:getManaResonanceArrayByType(skillType)
    return self.manaResonanceArray_[skillType]
end

function ResonanceDataMgr:getManaResonanceArray()
    return self.manaResonanceArray_
end

function ResonanceDataMgr:getManaMenu()
    return self.sortManaResonance
end

function ResonanceDataMgr:getManaCostData(quality,lv)
    if not self.manaCost_[quality] then
        return
    end
    return self.manaCost_[quality][lv]
end

function ResonanceDataMgr:getUnLockArrayDataByType(skillType)
    return self.unLockArray_[skillType] or {}
end

function ResonanceDataMgr:setUnLockArrayData()

    self.unLockArray_ = {}
    for k,v in pairs(self.unLockSkillMap_) do
        local info = self:getManaResonanceCfg(k)
        if info then
            local skillType = info.skillType
            if not self.unLockArray_[skillType] then
                self.unLockArray_[skillType] = {}
            end
            table.insert(self.unLockArray_[skillType],k)
        end
    end
end

function ResonanceDataMgr:getSkillLv(cid)
    return self.unLockSkillMap_[cid]
end

function ResonanceDataMgr:setSkillLv(cid,Lv)
    self.unLockSkillMap_[cid] = Lv
    self:setUnLockArrayData()
end

function ResonanceDataMgr:setEquipedSkills(slotId,cid)

    local originalSlotId = self:getEquipedSlotId(cid)
    if originalSlotId ~= 0 then
        self.equipedSkill_[originalSlotId] = nil
    end
    self.equipedSkill_[slotId] = cid

end

function ResonanceDataMgr:getEquipedSkills(slotId)
    if not slotId then
        return self.equipedSkill_
    end
    return self.equipedSkill_[slotId] or 0
end

function ResonanceDataMgr:getEquipedSlotId(cid)
    for k,v in pairs(self.equipedSkill_) do
        if v == cid then
            return k
        end
    end
    return 0
end

function ResonanceDataMgr:getManaSkills()
    local skills = {}
    local gmCids = self:getEquipedSkills()
    for k,v in pairs(gmCids) do
        local skillLv = self:getSkillLv(v)
        if skillLv then
            local passiveSkillId = self:getPassiveSkillId(v,skillLv)
            if passiveSkillId then
                table.insert(skills,passiveSkillId)
            end
        end
    end
    return skills
end

function ResonanceDataMgr:Send_EquipSkill(slotId,cid)
    TFDirector:send(c2s.MANA_RESONANCE_REQ_MANA_EQUIP, {cid,slotId})
end

function ResonanceDataMgr:Send_UpSkill(skillId)
    TFDirector:send(c2s.MANA_RESONANCE_REQ_MANA_LEVEL_UP, {skillId})
end

function ResonanceDataMgr:onRecvAllManaInfo(event)

    local data = event.data
    if not data then
        return
    end

    ---装备信息
    local manaEquipInfo = data.manaEquipInfo or {}
    for k,v in ipairs(manaEquipInfo) do
        self.equipedSkill_[v.pos] = v.id
    end
    dump(manaEquipInfo)
    dump(self.equipedSkill_)

    ---背包信息
    local manaBagInfo = data.manaBagInfo or {}
    for k,v in ipairs(manaBagInfo) do
        self:setSkillLv(v.id,v.level)
    end
end

function ResonanceDataMgr:onRecvManaLevelUp(event)

    local data = event.data
    if not data then
        return
    end

    local manaBagInfo = data.manaBagInfo
    if not manaBagInfo then
        return
    end
    self:setSkillLv(manaBagInfo.id,manaBagInfo.level)

    EventMgr:dispatchEvent(EV_AFTER_UPGRADE_GM_SKILL)

    Utils:openView("fairyNew.GongMingSkillLvUpView",manaBagInfo.id)

end

function ResonanceDataMgr:onRecvManaEquip(event)

    local data = event.data
    if not data then
        return
    end

    local manaEquipInfo = data.manaEquipInfo
    if not manaEquipInfo then
        return
    end

    self:setEquipedSkills(manaEquipInfo.pos,manaEquipInfo.id)
    EventMgr:dispatchEvent(EV_AFTER_HANDLE_GM_SKILL,manaEquipInfo.pos,manaEquipInfo.id)

end

return ResonanceDataMgr:new()
