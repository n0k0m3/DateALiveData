
local ValentineHandselView = class("ValentineHandselView", BaseLayer)

function ValentineHandselView:initData(roleCid)
    self.roleCid_ = roleCid
    self.roleCfg_ = ValentineDataMgr:getValentineRoleCfg(self.roleCid_)
end

function ValentineHandselView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.valentine.valentineHandselView")
end

function ValentineHandselView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_desc = TFDirector:getChildByPath(Image_content, "Label_desc")
    self.Label_confession = TFDirector:getChildByPath(Image_content, "Label_confession")
    self.Button_gift = TFDirector:getChildByPath(Image_content, "Button_gift")
    self.Label_gift = TFDirector:getChildByPath(self.Button_gift, "Label_gift")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_icon")

    self:refreshView()
end

function ValentineHandselView:refreshView()
    self.Label_confession:setLineHeight(42)
    self.Label_name:setTextById(self.roleCfg_.name)
    self.Label_desc:setTextById(self.roleCfg_.present)
    self.Label_confession:setTextById(self.roleCfg_.confession)
    self.Image_icon:setTexture(self.roleCfg_.head)
end

function ValentineHandselView:registerEvents()
    self.Button_gift:onClick(function()
            Utils:openView("valentine.ValentineTaskView", self.roleCid_)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return ValentineHandselView
