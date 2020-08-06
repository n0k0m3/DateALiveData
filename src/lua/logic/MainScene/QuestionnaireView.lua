
local QuestionnaireView = class("QuestionnaireView", BaseLayer)

function QuestionnaireView:initData()
    TaskDataMgr:setTempValue2(false)
end

function QuestionnaireView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.MainScene.questionnaireView")
end

function QuestionnaireView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    local ScrollView_content = TFDirector:getChildByPath(Image_bg, "ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)
    self.Panel_close = TFDirector:getChildByPath(Image_bg, "Panel_close")

    self.Label_contentItem = TFDirector:getChildByPath(self.Panel_prefab, "Label_contentItem")
    self.Panel_linkItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_linkItem")
    self.Panel_inscribeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_inscribeItem")

    self:refreshView()
end

function QuestionnaireView:refreshView()
    local Label_contentItem = self.Label_contentItem:clone()
    local size = Label_contentItem:Size()
    Label_contentItem:setDimensions(size.width, 0)
    Label_contentItem:setTextById(1500003)
    self.ListView_content:pushBackCustomItem(Label_contentItem)

    local Panel_linkItem = self.Panel_linkItem:clone()
    local Label_link = TFDirector:getChildByPath(Panel_linkItem, "Label_link")
    local url = TextDataMgr:getText(1500006)
    Label_link:setText(url)
    self.ListView_content:pushBackCustomItem(Panel_linkItem)
    Label_link:onScaleClick(function()
            TFDeviceInfo:openUrl(url)
    end)

    local Panel_inscribeItem = self.Panel_inscribeItem:clone()
    local Label_date = TFDirector:getChildByPath(Panel_inscribeItem, "Label_date")
    local Label_name = TFDirector:getChildByPath(Panel_inscribeItem, "Label_name")
    Label_date:setTextById(1500004)
    Label_name:setTextById(1500005)
    self.ListView_content:pushBackCustomItem(Panel_inscribeItem)
end

function QuestionnaireView:registerEvents()
    self.Panel_close:onScaleClick(function()
            AlertManager:close()
    end)
end

return QuestionnaireView
