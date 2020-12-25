local BaoshiSkillTipsView = class("BaoshiSkillTipsView", BaseLayer)

function BaoshiSkillTipsView:ctor(gemCid,skillId)
    self.super.ctor(self)
    self:initData(gemCid,skillId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.baoshiSkillTipsView")
end

function BaoshiSkillTipsView:initData(gemCid,skillId)
    self.gemCid = gemCid
    self.skillId = skillId
end

function BaoshiSkillTipsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Image_skill_icon = TFDirector:getChildByPath(ui, "Image_skill_icon")
    self.Label_skill_name = TFDirector:getChildByPath(ui, "Label_skill_name")
    self.Label_skill_desc = TFDirector:getChildByPath(ui, "Label_skill_desc")

    self:updateUI()
end

function BaoshiSkillTipsView:updateUI()
    local config = TabDataMgr:getData("PassiveSkills",self.skillId)
    self.Image_skill_icon:setTexture(config.icon)
    self.Label_skill_name:setTextById(tonumber(config.name))
    local cfg = EquipmentDataMgr:getGemCfg(self.gemCid)
    local skillDesc = TextDataMgr:getTextAttr(tonumber(config.des)).text
    skillDesc = string.gsub(skillDesc, "#", TextDataMgr:getText(cfg.skillName))
    self.Label_skill_desc:setText(skillDesc)
end

function BaoshiSkillTipsView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return BaoshiSkillTipsView