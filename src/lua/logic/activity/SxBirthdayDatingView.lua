
local SxBirthdayDatingView = class("SxBirthdayDatingView", BaseLayer)

function SxBirthdayDatingView:initData(eventCid)
    self.eventCid_ = eventCid
    self.eventCfg_ = SxBirthdayDataMgr:getTohkaEventCfg(self.eventCid_)
end

function SxBirthdayDatingView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    ViewAnimationHelper.showPopOpenAnim(self)
    self:init("lua.uiconfig.activity.sxBirthdayDatingView")
end

function SxBirthdayDatingView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close"):hide()
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_head.Image_icon")
    self.Label_desc = TFDirector:getChildByPath(Image_content, "Label_desc")
    self.Button_dating = TFDirector:getChildByPath(Image_content, "Button_dating")
    self.Label_dating = TFDirector:getChildByPath(self.Button_dating, "Label_dating")

    self:refreshView()
end

function SxBirthdayDatingView:refreshView()
    self.Label_title:setTextById(self.eventCfg_.name)
    self.Label_desc:setTextById(self.eventCfg_.eventDes)
    self.Image_icon:Scale(0.8):setTexture(self.eventCfg_.head)
    self.Label_dating:setTextById(1454033)
end

function SxBirthdayDatingView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_dating:onClick(function()
            FunctionDataMgr:jStartDating(self.eventCid_)
            AlertManager:closeLayer(self)
    end)
end

return SxBirthdayDatingView
