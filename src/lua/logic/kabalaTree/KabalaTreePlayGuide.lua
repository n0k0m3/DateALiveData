local KabalaTreePlayGuide = class("KabalaTreePlayGuide", BaseLayer)

function KabalaTreePlayGuide:ctor(tittle, content)
    self.super.ctor(self)
    self:initData(tittle, content)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreePlayGuide")
end

function KabalaTreePlayGuide:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreePlayGuide:initData(tittle, content)
    self.helpTittle = tittle or 3004002
    self.helpContent = content or 3004101
end

function KabalaTreePlayGuide:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")

    local ScrollView_desc = TFDirector:getChildByPath(self.ui, "ScrollView_desc")
    self.ListView_desc = UIListView:create(ScrollView_desc)
    self.Label_contentCloneObj = TFDirector:getChildByPath(self.ui, "Label_contentCloneObj")

    self:initContent()
end

function KabalaTreePlayGuide:initContent()
    self.Label_title:setTextById(self.helpTittle)

    local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_contentCloneObj:clone():Show()
    Label_content:setTextById(self.helpContent)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)
end

return KabalaTreePlayGuide