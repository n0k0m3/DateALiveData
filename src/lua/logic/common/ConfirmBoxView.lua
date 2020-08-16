
local ConfirmBoxView = class("ConfirmBoxView", BaseLayer)

function ConfirmBoxView:initData()

end

function ConfirmBoxView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.confirmBoxView")
end

function ConfirmBoxView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_bg = TFDirector:getChildByPath(ui, "Image_bg")
    self.Panel_frame = TFDirector:getChildByPath(Image_bg, "Panel_frame")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_content = TFDirector:getChildByPath(Image_bg, "Label_content")

    self:refreshView()
end

function ConfirmBoxView:setTitle(title)
    self.Label_title:setTitle(title)
end

function ConfirmBoxView:setContent(content)
    if type(content) == "number" then
        self.Label_content:setTextById(content)
    else
        self.Label_content:setText(content)
    end
   
end

function ConfirmBoxView:setRContent(contentId,...)
    if type(contentId) == "number" then
        self.Label_content:setTextById(contentId,...)
    else
        self.Label_content:hide()
        local richLabel = TFRichText:create(ccs(self.Panel_frame:getSize().width, 0))
        richLabel:AnchorPoint(me.p(0.5, 1))
        local text = TextDataMgr:getFormatText(TextDataMgr:getTextAttr(contentId) , ...)
        richLabel:Text(text)
        richLabel:AddTo(self.Panel_frame)
    end
    
    --self.Label_content:ignoreContentAdaptWithSize(true)
    --self.Label_content:setWidth(0)
    --self.Label_content:setTextById(contentId,...)
end

function ConfirmBoxView:setCallback(callback)
    self.callback_ = callback
end

function ConfirmBoxView:refreshView()
    self.Label_title:setTextById(800011)
    self.Label_ok:setTextById(800010)
    self.Label_content:setText("")
end

function ConfirmBoxView:registerEvents()
    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            if type(self.callback_) == "function" then
                local callback = self.callback_
                AlertManager:closeLayer(self)
                callback()
            end
    end)
end

return ConfirmBoxView
