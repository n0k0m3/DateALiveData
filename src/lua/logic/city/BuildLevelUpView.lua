
local BuildLevelUpView = class("BuildLevelUpView", BaseLayer)

function BuildLevelUpView:initData(buildId)
    self.buildId_ = buildId
    CityDataMgr:sendUpgradeConfirm(buildId)
end

function BuildLevelUpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.buildLevelUpView")
end

function BuildLevelUpView:initUI(ui)
	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Image_build = TFDirector:getChildByPath(self.Panel_content, "Image_build")
    self.Label_levelUpLeft = TFDirector:getChildByPath(self.Panel_content, "Label_levelUpLeft")
    self.Label_levelUpRight = TFDirector:getChildByPath(self.Panel_content, "Label_levelUpRight")
    self.Label_levelUpTip = TFDirector:getChildByPath(self.Panel_content, "Label_levelUpTip")

    local popAniView = requireNew("lua.logic.common.PopAniView"):new()
    self:addLayerToNode(popAniView, self.Panel_bg)
    popAniView:setTitle(TextDataMgr:getText(500034))

    self:refreshView()
end

function BuildLevelUpView:refreshView()
    local buildCfg = CityDataMgr:getBuildCfg(self.buildId_)
    local preLevelBuildId = CityDataMgr:getBuildByLevel(self.buildId_, buildCfg.level - 1)
    local preLevelBuildCfg = CityDataMgr:getBuildCfg(preLevelBuildId)
    local buildInfo = CityDataMgr:getBuildInfo(buildId)

    self.Image_build:setTexture(buildCfg.icon)

    self.Label_levelUpLeft:setTextById(500024, TextDataMgr:getText(preLevelBuildCfg.nameId), preLevelBuildCfg.level)
    self.Label_levelUpRight:setTextById(500024, TextDataMgr:getText(buildCfg.nameId), buildCfg.level)

    local text = {}
    for i, v in ipairs(buildCfg.upDescribe) do
        local t = TextDataMgr:getTextEx(v)
        table.insert(text, t)
    end
    local content, isRString = TextDataMgr:concat(text, "\n")
    self.Label_levelUpTip:setTextEx(content, isRString)

end

function BuildLevelUpView:registerEvents()
    self.Panel_root:onClick(function()
            AlertManager:close()
    end)
end

return BuildLevelUpView
