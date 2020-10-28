local NormalHelpView = class("NormalHelpView", BaseLayer)

function NormalHelpView:ctor(tittle, content)
    self.super.ctor(self)
    self:initData(tittle, content)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.normalHelpView")
end

function NormalHelpView:initData(tittle, content)
    self.helpTittle = tittle or 3004002
    self.helpContent = content or 3004101
end

function NormalHelpView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_tittle = TFDirector:getChildByPath(self.ui, "Label_title")

    self.Label_contentCloneObj = TFDirector:getChildByPath(self.ui, "Label_text")
    local ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_help")
    self.ListView_desc = UIListView:create(ScrollView_list)

    self:initContent()
end

function NormalHelpView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NormalHelpView:initContent()
    self.Label_tittle:setTextById(self.helpTittle)

    local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_contentCloneObj:clone():Show()
    Label_content:setTextById(self.helpContent)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)
end

return NormalHelpView