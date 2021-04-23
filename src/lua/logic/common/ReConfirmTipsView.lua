local ReConfirmTipsView = class("ReConfirmTipsView", BaseLayer)

function ReConfirmTipsView:ctor(...)
    self.super.ctor(self, ...)
    self:initData(...)
    if self.showData.showPopAnim == false then
    else
        self:showPopAnim(true)
    end
    if self.showData.uiPath then
        self:init(self.showData.uiPath )
    else
        self:init("lua.uiconfig.common.reConfirmTipsView")
    end
end

function ReConfirmTipsView:initData(...)
    self.showData = ... or {}
end

function ReConfirmTipsView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Panel_content = TFDirector:getChildByPath(self.ui, "Panel_content")

    self.Label_change = TFDirector:getChildByPath(self.ui, "Label_change")

    self.Button_no = TFDirector:getChildByPath(self.ui, "Button_no")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_cancel")
    self.Label_cancle = TFDirector:getChildByPath(self.Button_no, "Label_cancle")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")

    self.Image_select_di = TFDirector:getChildByPath(ui,"Image_select_di")
    self.Image_select  = TFDirector:getChildByPath(ui,"Image_select"):hide()
    self.Label_content = TFDirector:getChildByPath(ui,"Label_content")
    self.Label_content_1 = TFDirector:getChildByPath(ui,"Label_content_1")
    self.Label_content_1:setText("")
    self.Label_change = TFDirector:getChildByPath(ui, "Label_change")

    self.Label_title:setTextById(self.showData.tittle)
    self.Label_content:setText("")

    if self.showData.tips then
        self.Label_content_1:setTextById(self.showData.tips)
    end
    local rich = TFRichText:create(ccs(500, 160))
    local str = string.format([[<font face="fangzheng_zhunyuan26" color="#C0C8D0">%s</font>]], self.showData.content)
    rich:Text(str)
    self.Panel_content:Add(rich)
    self.Label_change:setTextById(800045)
    self.Image_select_di:setVisible(self.showData.reType)
    self.Label_change:setVisible(self.showData.reType)
    self.Button_no:setVisible(tobool(self.showData.showCancle))

    if self.showData.showClose ~= nil then
        self.Button_close:setVisible(tobool(self.showData.showClose))
    end

    local cancleTextId = self.showData.cancleId
    cancleTextId = cancleTextId or 1329129
    self.Label_cancle:setTextById(cancleTextId)

    local confirmTextId = self.showData.confirmId
    confirmTextId = confirmTextId or 1329128
    self.Label_ok:setTextById(confirmTextId)
end

function ReConfirmTipsView:registerEvents()
    self.Image_select_di:onClick(function()
        if self.Image_select:isVisible() then
            self.Image_select:hide();
            MainPlayer:setOneLoginStatus(self.showData.reType, 0)
        else
            self.Image_select:show();
            MainPlayer:setOneLoginStatus(self.showData.reType, 1)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end, EC_BTN.CLOSE)

    self.Button_no:onClick(function()
        if self.showData.cancleCall then
            self.showData.cancleCall()
        end
        AlertManager:closeLayer(self)
    end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
        self.Button_ok:setTouchEnabled(false) --禁用按钮点击事件防止重复点击引发异常
        if self.showData.confirmCall then
            self.showData.confirmCall()
        end
        AlertManager:closeLayer(self)
    end)
end

return ReConfirmTipsView
