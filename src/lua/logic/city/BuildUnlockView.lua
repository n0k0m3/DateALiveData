
local BuildUnlockView = class("BuildUnlockView", BaseLayer)

function BuildUnlockView:initData(unlockBuild)
    self.unlockBuild_ = unlockBuild
    self.showNum_ = 3
end

function BuildUnlockView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.buildUnlockView")
end

function BuildUnlockView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    local ScrollView_build = TFDirector:getChildByPath(self.Panel_content, "ScrollView_build")
    self.ListView_build = UIListView:create(ScrollView_build)

    self.Panel_buildItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_buildItem")

    local popAniView = requireNew("lua.logic.common.PopAniView"):new()
    self:addLayerToNode(popAniView, self.Panel_bg)
    popAniView:setTitle(TextDataMgr:getText(500035))

    self:refreshView()
end

function BuildUnlockView:refreshView()
    local contentSize
    for i, v in ipairs(self.unlockBuild_) do
        local buildCfg = CityDataMgr:getBuildCfg(v)
        local item = self.Panel_buildItem:clone()
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        Image_icon:setTexture(buildCfg.icon)
        Label_name:setTextById(buildCfg.nameId)
        self.ListView_build:pushBackCustomItem(item)
        if i <= self.showNum_ then
            contentSize = self.ListView_build:getInnerContainerSize()
        end
    end
    local isMoreThan = #self.unlockBuild_ > self.showNum_
    self.ListView_build:setBounceEnabled(isMoreThan)
    if contentSize then
        self.ListView_build:setContentSize(contentSize)
    end
end

function BuildUnlockView:registerEvents()
    self.Panel_root:onClick(function()
            AlertManager:close()
    end)
end

return BuildUnlockView
