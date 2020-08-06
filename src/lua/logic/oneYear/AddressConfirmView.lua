
local AddressConfirmView = class("AddressConfirmView", BaseLayer)

function AddressConfirmView:initData(newFillInfo)
    self.newFillInfo = newFillInfo
end

function AddressConfirmView:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.oneYear.addressConfirmView")
end

function AddressConfirmView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_submit = TFDirector:getChildByPath(self.Panel_root, "Button_submit")

    self.Panel_before_info = TFDirector:getChildByPath(self.Panel_root, "Panel_before_info")
    self.beforeInfo_ = {}
    self.beforeInfo_.name = TFDirector:getChildByPath(self.Panel_before_info, "Label_receive")
    self.beforeInfo_.address = TFDirector:getChildByPath(self.Panel_before_info, "Label_address")
    self.beforeInfo_.detail = TFDirector:getChildByPath(self.Panel_before_info, "Label_detail_address")
    self.beforeInfo_.email = TFDirector:getChildByPath(self.Panel_before_info, "Label_email")
    self.beforeInfo_.phone = TFDirector:getChildByPath(self.Panel_before_info, "Label_phone")
    self.beforeInfo_.qq = TFDirector:getChildByPath(self.Panel_before_info, "Label_qq")

    self.Panel_after_info = TFDirector:getChildByPath(self.Panel_root, "Panel_after_info")
    self.Label_after_tip = TFDirector:getChildByPath(self.Panel_after_info, "Label_after_tip")
    self.afterInfo_ = {}
    self.afterInfo_.name = TFDirector:getChildByPath(self.Panel_after_info, "Label_receive")
    self.afterInfo_.address = TFDirector:getChildByPath(self.Panel_after_info, "Label_address")
    self.afterInfo_.detail = TFDirector:getChildByPath(self.Panel_after_info, "Label_detail_address")
    self.afterInfo_.email = TFDirector:getChildByPath(self.Panel_after_info, "Label_email")
    self.afterInfo_.phone = TFDirector:getChildByPath(self.Panel_after_info, "Label_phone")
    self.afterInfo_.qq = TFDirector:getChildByPath(self.Panel_after_info, "Label_qq")

    self:refreshView()
end

function AddressConfirmView:refreshView()
    
    self:showBefore()
    self:showAfter()
    local name = self.beforeInfo_.name:getText()
    self.Panel_before_info:setVisible(name ~= "")
    self.Label_after_tip:setVisible(name ~= "")
    local posX = name == "" and 0 or 223
    self.Panel_after_info:setPositionX(posX)
end

function AddressConfirmView:showBefore()
    local beforeInfo = OneYearDataMgr:getFillInfo()
    if not beforeInfo then
        return
    end

    local name = beforeInfo.name or ""
    self.beforeInfo_.name:setText(name)

    local address = beforeInfo.address or ""
    self.beforeInfo_.detail:setText(address)

    local email = beforeInfo.email or ""
    self.beforeInfo_.email:setText(email)

    local phone = beforeInfo.phone or ""
    self.beforeInfo_.phone:setText(phone)

    local qq = beforeInfo.qq or ""
    self.beforeInfo_.qq:setText(qq)

    if beforeInfo.selectInfo then
        local proviceName = beforeInfo.selectInfo.proviceName or ""
        local municipalName = beforeInfo.selectInfo.municipalName or ""
        local townName = beforeInfo.selectInfo.townName or ""

        self.beforeInfo_.address:setText(proviceName..municipalName..townName)
    else
        self.beforeInfo_.address:setText("")
    end
end

function AddressConfirmView:showAfter()

    local beforeInfo = OneYearDataMgr:getFillInfo()
    if not beforeInfo then
        return
    end

    local color = ccc3(255,188,190)
    local color2 = ccc3(255,221,85)
    local name = self.newFillInfo.name or ""
    if beforeInfo.name ~= name then
        self.afterInfo_.name:setColor(color2)
    else
        self.afterInfo_.name:setColor(color)
    end
    self.afterInfo_.name:setText(name)

    local address = self.newFillInfo.address or ""
    if beforeInfo.address ~= address then
        self.afterInfo_.detail:setColor(color2)
    else
        self.afterInfo_.detail:setColor(color)
    end
    self.afterInfo_.detail:setText(address)

    local email = self.newFillInfo.email or ""
    self.afterInfo_.email:setText(email)
    if beforeInfo.email ~= email then
        self.afterInfo_.email:setColor(color2)
    else
        self.afterInfo_.email:setColor(color)
    end

    local phone = self.newFillInfo.phone or ""
    self.afterInfo_.phone:setText(phone)
    if beforeInfo.phone ~= phone then
        self.afterInfo_.phone:setColor(color2)
    else
        self.afterInfo_.phone:setColor(color)
    end

    local qq = self.newFillInfo.qq or ""
    self.afterInfo_.qq:setText(qq)
    if beforeInfo.qq ~= qq then
        self.afterInfo_.qq:setColor(color2)
    else
        self.afterInfo_.qq:setColor(color)
    end

    if self.newFillInfo.selectInfo then
        local proviceName = self.newFillInfo.selectInfo.proviceName or ""
        local municipalName = self.newFillInfo.selectInfo.municipalName or ""
        local townName = self.newFillInfo.selectInfo.townName or ""
        local selectStr = proviceName..municipalName..townName
        self.afterInfo_.address:setText(selectStr)

        local proviceName1 = ""
        if beforeInfo.selectInfo and beforeInfo.selectInfo.proviceName then
            proviceName1 = beforeInfo.selectInfo.proviceName
        end

        local municipalName1 = ""
        if beforeInfo.selectInfo and beforeInfo.selectInfo.municipalName then
            municipalName1 = beforeInfo.selectInfo.municipalName
        end

        local townName1 = ""
        if beforeInfo.selectInfo and beforeInfo.selectInfo.townName then
            townName1 = beforeInfo.selectInfo.townName
        end
        local oldStr = proviceName1..municipalName1..townName1
        if oldStr ~= selectStr then
            self.afterInfo_.address:setColor(color2)
        else
            self.afterInfo_.address:setColor(color)
        end
    end
end

function AddressConfirmView:onUpdateChangeAddress()
    Utils:showTips("更改地址成功")
    OneYearDataMgr:setFillInfo(self.newFillInfo)
    AlertManager:closeLayer(self)
end

function AddressConfirmView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_CHANGE_ADDRESS,handler(self.onUpdateChangeAddress, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_submit:onClick(function()
        local jsonData = json.encode(self.newFillInfo)
        OneYearDataMgr:Send_submitAddress(jsonData)
    end)
end

return AddressConfirmView
