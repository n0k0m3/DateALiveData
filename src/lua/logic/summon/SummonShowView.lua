
local SummonShowView = class("SummonShowView", BaseLayer)

function SummonShowView:initData(cid)
    self.itemCfg_ = GoodsDataMgr:getItemCfg(cid)
    self.cid_ = cid
end

function SummonShowView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonShowView")
end

function SummonShowView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()

    self.Panel_summonShowView_1 = TFDirector:getChildByPath(self.Panel_root, "Panel_content.Panel_summonShowView_1")
    self.Panel_hero = TFDirector:getChildByPath(self.Panel_summonShowView_1, "Panel_hero"):hide()
    self.Label_cv = TFDirector:getChildByPath(self.Panel_hero, "Label_cv")
    self.Label_heroName = TFDirector:getChildByPath(self.Panel_hero, "Label_heroName")
    self.Label_nick = TFDirector:getChildByPath(self.Panel_hero, "Label_nick")
    self.Label_heroEnName =  TFDirector:getChildByPath(self.Panel_hero, "Label_heroEnName")
    self.Panel_hero_model = TFDirector:getChildByPath(self.Panel_hero, "Panel_hero_model")

    self.Panel_equipment = TFDirector:getChildByPath(self.Panel_summonShowView_1, "Panel_equipment"):hide()
    self.Label_equipmentName = TFDirector:getChildByPath(self.Panel_equipment, "Label_equipmentName")
    self.Image_star = {}
    for i = 1, 5 do
        self.Image_star[i] = TFDirector:getChildByPath(self.Panel_equipment, "Image_star_" .. i)
    end
    self.Panel_equipment_model = TFDirector:getChildByPath(self.Panel_equipment, "Panel_equipment_model")
    self.Image_equipment_model = TFDirector:getChildByPath(self.Panel_equipment, "Image_equipment_model")

    self:refreshView()
end

function SummonShowView:refreshView()
    self.ui:runAnimation("Action0", 1)

    if self.itemCfg_.superType == EC_ResourceType.HERO then
        self.Panel_hero:show()
        Utils:createHeroModel(self.cid_, self.Panel_hero_model, 1.0, self.itemCfg_.defaultSkin)
        self.Label_heroName:setTextById(self.itemCfg_.name)
        self.Label_cv:setTextById(self.itemCfg_.cv)
        self.Label_heroEnName:setText(self.itemCfg_.enName)
        self.Label_nick:setTextById(self.itemCfg_.code)
        self.heroVoiceHandle_ = VoiceDataMgr:playVoiceByHeroID("hero_get", self.cid_)
    elseif self.itemCfg_.superType == EC_ResourceType.SPIRIT then
        self.Panel_equipment:show()
        self.Image_equipment_model:setTexture(self.itemCfg_.paint)
        self.Label_equipmentName:setTextById(self.itemCfg_.name)
        for i, v in ipairs(self.Image_star) do
            v:setVisible(i <= self.itemCfg_.star)
        end
    end


    self.Panel_touch:timeOut(function()
            self.Panel_touch:show()
    end, 0.5)
end

function SummonShowView:registerEvents()
    self.Panel_touch:onClick(function()
            AlertManager:close()
            EventMgr:dispatchEvent(EV_SUMMON_TOUCH_CONTINUE)
    end)
end

function SummonShowView:removeEvents()
    if self.heroVoiceHandle_ then
        TFAudio.stopEffect(self.heroVoiceHandle_)
    end
end

return SummonShowView
