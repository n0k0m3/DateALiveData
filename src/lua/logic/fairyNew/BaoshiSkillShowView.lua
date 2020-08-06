local BaoshiSkillShowView = class("BaoshiSkillShowView", BaseLayer)

function BaoshiSkillShowView:ctor(idx, gemCid)
    self.super.ctor(self)
    self:initData(idx, gemCid)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.baoshiSkillShowView")
end

function BaoshiSkillShowView:initData(idx, gemCid)
    self.skillIdx = idx
    self.gemCid = gemCid
end

function BaoshiSkillShowView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Label_title:setTextById(1100042)
    self.Panel_skill_item = TFDirector:getChildByPath(ui, "Panel_skill_item")
    local ScrollView_skills = TFDirector:getChildByPath(ui, "ScrollView_skills")
    self.GridView_item = UIGridView:create(ScrollView_skills)
    self.GridView_item:setItemModel(self.Panel_skill_item)
    self.GridView_item:setColumn(2)
    self.GridView_item:setColumnMargin(5)
    self.GridView_item:setRowMargin(5)
    self:updateUI()
end

function BaoshiSkillShowView:updateUI()
    local gemCfg = EquipmentDataMgr:getGemCfg(self.gemCid)
    local skills = gemCfg.specialSkill
    for i,skills in ipairs(gemCfg.specialSkill) do
        if self.skillIdx == i then
            for j,v in ipairs(skills) do
                local item = self.Panel_skill_item:clone()
                self:updateSkillItem(item, v, gemCfg)
                self.GridView_item:pushBackCustomItem(item)
            end
        end
    end
end

function BaoshiSkillShowView:updateSkillItem(item, skillId, gemCfg)
    local Image_skill_icon = TFDirector:getChildByPath(item,"Image_skill_icon")
    local Label_skill_name = TFDirector:getChildByPath(item,"Label_skill_name")
    local Label_skill_desc = TFDirector:getChildByPath(item,"Label_skill_desc")
    local skillCfg = TabDataMgr:getData("PassiveSkills",skillId)
    Label_skill_name:setTextById(skillCfg.name)
    Image_skill_icon:setTexture(skillCfg.icon)
    local skillDesc = TextDataMgr:getTextAttr(tonumber(skillCfg.des)).text
    skillDesc = string.gsub(skillDesc, "#", gemCfg.skillName)
    Label_skill_desc:setText(skillDesc)
end

function BaoshiSkillShowView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return BaoshiSkillShowView