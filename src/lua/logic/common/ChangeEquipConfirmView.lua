
local ChangeEquipConfirmView = class("ChangeEquipConfirmView", BaseLayer)


function ChangeEquipConfirmView:ctor(data)
    self.super.ctor(self)
    self:showPopAnim(true)
    self.callback = data.callback
    self.heroName = data.heroName
    self.titleName = data.title
    self.tipsDesc = data.tips
    self:init("lua.uiconfig.common.changeEquipConfirmView")
end

function ChangeEquipConfirmView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_title_en = TFDirector:getChildByPath(Image_content, "Label_title_en")
    self.Button_Confirm = TFDirector:getChildByPath(Image_content, "Button_confirm")
    self.Label_confirm = TFDirector:getChildByPath(Image_content, "Label_confirm")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function ChangeEquipConfirmView:refreshView()
    if self.titleName then
        self.Label_title:setText(self.titleName)
    end
    if self.tipsDesc then
        self.Label_tips:setTextById(self.tipsDesc, self.heroName)
    else
        self.Label_tips:setTextById("r30002", self.heroName)
    end
end

function ChangeEquipConfirmView:registerEvents()
    self.Button_Confirm:onClick(function()
        self.callback()
        --AlertManager:closeLayer(self)
    end)
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return ChangeEquipConfirmView
