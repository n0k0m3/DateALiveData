
local ProclamationView = class("ProclamationView", BaseLayer)

function ProclamationView:initData()
    TaskDataMgr:setTempValue(false)
end

function ProclamationView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.MainScene.proclamationView")
end

function ProclamationView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Image_title.Label_title")
    self.Panel_close = TFDirector:getChildByPath(Image_bg, "Panel_close")
    self.Label_close = TFDirector:getChildByPath(self.Panel_close, "Label_close")
    self.Label_name = TFDirector:getChildByPath(Image_bg, "Image_name.Label_name")
    local ScrollView_desc = TFDirector:getChildByPath(Image_bg, "ScrollView_desc")
    self.ListView_desc = UIListView:create(ScrollView_desc)

    self.Label_content = TFDirector:getChildByPath(self.Panel_prefab, "Label_content")

    self:refreshView()
end

function ProclamationView:refreshView()
    self.Label_title:setTextById(800023)
    self.Label_close:setTextById(800022)
    self.Label_name:setTextById(1500001)

    local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_content:clone()
    Label_content:setTextById(1500002)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)
end

function ProclamationView:registerEvents()
    self.Panel_close:onScaleClick(function()
            AlertManager:close()
    end)
end

return ProclamationView
