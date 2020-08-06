
local FubenChapterPassView = class("FubenChapterPassView", BaseLayer)

function FubenChapterPassView:initData(chapterCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(chapterCid)
end

function FubenChapterPassView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenChapterPassView")
end

function FubenChapterPassView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Label_chapterName = TFDirector:getChildByPath(self.Panel_root, "Label_chapterName")
    self.Label_chapterName_shadow = TFDirector:getChildByPath(self.Panel_root, "Label_chapterName_shadow")
    self.Label_complete = TFDirector:getChildByPath(self.Panel_root, "Label_complete")
    self.Label_spriteName = TFDirector:getChildByPath(self.Panel_root, "Label_spriteName")
    self.Label_spriteName_en = TFDirector:getChildByPath(self.Panel_root, "Label_spriteName_en")
    self.Panel_role = TFDirector:getChildByPath(self.Panel_root, "Panel_role")
    self.Label_continue = TFDirector:getChildByPath(self.Panel_root, "Image_continue.Label_continue")
    self.Panel_roleOne = TFDirector:getChildByPath(self.Panel_root, "Panel_roleOne")
    self.Panel_roleOne:setBackGroundColorType(0)
    self.Panel_roleTwo = {}
    for i = 1, 2 do
        self.Panel_roleTwo[i] = TFDirector:getChildByPath(self.Panel_root, "Panel_roleTwo_" .. i)
        self.Panel_roleTwo[i]:setBackGroundColorType(0)
    end

    self:refreshView()
end

function FubenChapterPassView:refreshView()
    self.ui:runAnimation("Action0", 1)

    local heroCfg = TabDataMgr:getData("Hero", self.chapterCfg_.endShowHero)
    local count = #self.chapterCfg_.endShowModel
    if count == 1 then
        local modelCid = self.chapterCfg_.endShowModel[1]
        local model = Utils:createHeroModelByModelId(modelCid, 1.1)
        self.Panel_roleOne:addChild(model)
    elseif count == 2 then
        for i, v in ipairs(self.Panel_roleTwo) do
            local modelCid = self.chapterCfg_.endShowModel[i]
            local model = Utils:createHeroModelByModelId(modelCid, 1.0)
            self.Panel_roleTwo[i]:addChild(model)
        end
    end

    local name = FubenDataMgr:getChapterFullName(self.chapterCid_)
    self.Label_chapterName:setText(name)
    self.Label_chapterName_shadow:setText(name)
    self.Label_spriteName:setTextById(heroCfg.name)
    self.Label_spriteName_en:setText(heroCfg.enName)
    self.Label_continue:setTextById(800018)

    self.Panel_touch:timeOut(function()
            self.Panel_touch:show()
    end, 0.7)
end

function FubenChapterPassView:registerEvents()
    self.Panel_touch:onClick(function()
            AlertManager:closeLayer(self)
            AlertManager:showStashView("summon.SummonGetHeroView")
    end)

end

return FubenChapterPassView
