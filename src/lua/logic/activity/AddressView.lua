
local AddressView = class("AddressView", BaseLayer)

function AddressView:initData()
    self.proviceName = ""
    self.municipalName = ""
    self.townName = ""
    self.cdTime = 60
end

function AddressView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.addressView")
end

function AddressView:initUI(ui)
    self.super.initUI(self, ui)

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Panel_address = TFDirector:getChildByPath(self.Panel_root, "Panel_address")

    self.Button_submit = TFDirector:getChildByPath(self.Panel_root, "Button_submit")
    self.Button_detail1 = TFDirector:getChildByPath(self.Panel_root, "Button_detail_1")
    self.Button_detail2 = TFDirector:getChildByPath(self.Panel_root, "Button_detail_2")
    self.Button_detail3 = TFDirector:getChildByPath(self.Panel_root, "Button_detail_3")
    self.Label_submit = TFDirector:getChildByPath(self.Button_submit, "Label_submit")
    self.detailBox = {}
    for i=1,3 do
        local tab = {}
        tab.pl = TFDirector:getChildByPath(self.Panel_root, "Panel_detail_"..i)
        tab.name = TFDirector:getChildByPath(tab.pl, "Label_detail_name")
        tab.Panel_more = TFDirector:getChildByPath(tab.pl, "Panel_more"):hide()
        local ScrollView_detail = TFDirector:getChildByPath(tab.pl, "ScrollView_detail")
        tab.list_view = UIListView:create(ScrollView_detail)
        table.insert(self.detailBox,tab)
    end

    self.TextFieldTab_ = {}
    self.TextField_receive = TFDirector:getChildByPath(self.Panel_root, "TextField_receive")
    self.TextField_detail = TFDirector:getChildByPath(self.Panel_root, "TextField_detail")
    self.TextField_email = TFDirector:getChildByPath(self.Panel_root, "TextField_email")
    self.TextField_phone = TFDirector:getChildByPath(self.Panel_root, "TextField_phone")

    self.TextField_qq = TFDirector:getChildByPath(self.Panel_root, "TextField_qq")
    table.insert(self.TextFieldTab_,self.TextField_receive)
    table.insert(self.TextFieldTab_,self.TextField_detail)
    table.insert(self.TextFieldTab_,self.TextField_email)
    table.insert(self.TextFieldTab_,self.TextField_phone)
    table.insert(self.TextFieldTab_,self.TextField_qq)


    self:updateAddress()
    self:choosePL(1)
end

function AddressView:updateAddress()

    self.fillInfo = clone(ActivityDataMgr2:getFillInfo())
    local name = self.fillInfo.name or ""
    self.TextField_receive:setText(name)

    local address = self.fillInfo.address or ""
    self.TextField_detail:setText(address)

    local email = self.fillInfo.email or ""
    self.TextField_email:setText(email)

    local phone = self.fillInfo.phone or ""
    self.TextField_phone:setText(phone)

    local qq = self.fillInfo.qq or ""
    self.TextField_qq:setText(qq)

    if self.fillInfo.selectInfo then
        local proviceName = self.fillInfo.selectInfo.proviceName or ""
        if proviceName == "" then
            self.detailBox[1].name:setText("请选择省份")
        else
            self.detailBox[1].name:setText(proviceName)
        end

        local municipalName = self.fillInfo.selectInfo.municipalName or ""
        if municipalName == "" then
            self.detailBox[2].name:setText("请选择城市")
        else
            self.detailBox[2].name:setText(municipalName)
        end


        local townName = self.fillInfo.selectInfo.townName or ""
        if townName == "" then
            self.detailBox[3].name:setText("请选择区县")
        else
            self.detailBox[3].name:setText(townName)
        end
        self.proviceId = self.fillInfo.selectInfo.proviceId
        self.municipalId = self.fillInfo.selectInfo.municipalId
        self.proviceName,self.municipalName,self.townName = proviceName,municipalName,townName
    else
        self.fillInfo.selectInfo = {}
    end

    local act = CCSequence:create({
        CCCallFunc:create(function()
            local nextTime = ActivityDataMgr2:getNextTime()
            local curTime = ServerDataMgr:getServerTime()
            if curTime > nextTime then
                if name ~= "" then
                    self.Label_submit:setText("更改")
                else
                    self.Label_submit:setText("提交")
                end
                self.Button_submit:setTouchEnabled(true)
                self.Button_submit:setGrayEnabled(false)
                self.Label_submit:stopAllActions()
            else
                self.Button_submit:setTouchEnabled(false)
                self.Button_submit:setGrayEnabled(true)
                self.Label_submit:setText(nextTime - curTime)
            end
        end),
        CCDelayTime:create(1)
    })
    self.Label_submit:runAction(CCRepeatForever:create(act))

end

function AddressView:choosePL(id)
    self.Panel_address:setVisible(id == 1)
end

function AddressView:chooseDetialBox(id)
    local visible = self.detailBox[id].Panel_more:isVisible()
    self.detailBox[id].Panel_more:setVisible(not visible)
    if id == 1 then
        self:updateProvinceList()
    elseif id == 2 then
        self:updateMunicipalList()
    elseif id == 3 then
        self:updateTownList()
    end
end

function AddressView:updateProvinceList()

    local proviceInfo = OneYearDataMgr:getProvince()
    if not proviceInfo then
        return
    end

    self.detailBox[1].list_view:removeAllItems()
    for k,v in ipairs(proviceInfo) do
        local detailItem = self.Button_detail1:clone()
        self.detailBox[1].list_view:pushBackCustomItem(detailItem)
        local Label_detail = detailItem:getChildByName("Label_detail")
        Label_detail:setText(v.value)
        Label_detail:setColor(ccc3(255,255,255))
        detailItem:onClick(function()
            self.detailBox[1].Panel_more:setVisible(false)
            self.detailBox[1].name:setText(v.value)
            self.proviceId = v.label
            self.proviceName = v.value
            self:updateMunicipalList()
        end)
    end

end

function AddressView:updateMunicipalList()

    self.detailBox[2].list_view:removeAllItems()
    local municipalInfo = OneYearDataMgr:getMunicipal(self.proviceId)

    local firstMunicipal = municipalInfo[1]
    if firstMunicipal then
        self.detailBox[2].name:setText(firstMunicipal.value)
        self.municipalName = firstMunicipal.value
        self.municipalId = firstMunicipal.label
        self:updateTownList()
    end

    for k,v in ipairs(municipalInfo) do
        local detailItem = self.Button_detail2:clone()
        self.detailBox[2].list_view:pushBackCustomItem(detailItem)
        local Label_detail = detailItem:getChildByName("Label_detail")
        Label_detail:setText(v.value)
        Label_detail:setColor(ccc3(255,255,255))
        detailItem:onClick(function()
            self.detailBox[2].Panel_more:setVisible(false)
            self.detailBox[2].name:setText(v.value)
            self.municipalId = v.label
            self.municipalName = v.value
            self:updateTownList()
        end)
    end
end

function AddressView:updateTownList()

    self.detailBox[3].list_view:removeAllItems()
    local townInfo = OneYearDataMgr:getTown(self.municipalId)

    local firstTown = townInfo[1]
    if firstTown then
        self.detailBox[3].name:setText(firstTown.value)
        self.townName = firstTown.value
    end
    for k,v in ipairs(townInfo) do
        local detailItem = self.Button_detail3:clone()
        self.detailBox[3].list_view:pushBackCustomItem(detailItem)
        local Label_detail = detailItem:getChildByName("Label_detail")
        Label_detail:setText(v.value)
        Label_detail:setColor(ccc3(255,255,255))
        detailItem:onClick(function()
            self.detailBox[3].Panel_more:setVisible(false)
            self.detailBox[3].name:setText(v.value)
            self.townName = v.value
        end)
    end
end

function AddressView:onTouchSendBtn()

end

function AddressView:onCloseInputLayer()

end

function AddressView:setNewfillInfo()

    local receive = self.TextField_receive:getText()
    local detail = self.TextField_detail:getText()
    local email = self.TextField_email:getText()
    local phone = self.TextField_phone:getText()
    local qq = self.TextField_qq:getText()
    self.newFillInfo = {}
    self.newFillInfo.name = receive
    self.newFillInfo.address = detail
    self.newFillInfo.phone = phone
    self.newFillInfo.email = email
    self.newFillInfo.qq = qq
    self.newFillInfo.selectInfo = {proviceName = self.proviceName,municipalName = self.municipalName,townName = self.townName,
                      proviceId = self.proviceId,municipalId = self.municipalId}

end

function AddressView:checkEmpty()

    if self.newFillInfo.name == "" then
        Utils:showTips("收件人名字未填写，无法提交")
        return true
    end

    if self.newFillInfo.address == "" then
        Utils:showTips("详细地址填写，无法提交")
        return true
    end

    if self.newFillInfo.phone == "" then
        Utils:showTips("手机号码未填写，无法提交")
        return true
    end

    if self.proviceName == "" or self.municipalName == "" or self.townName == "" then
        Utils:showTips("未请选择省，城市，区县，无法提交")
        return true
    end

    if #self.newFillInfo.phone < 11 then
        Utils:showTips("手机号码填写不正确，无法提交")
        return true
    end

    return false
end

function AddressView:checkChange()

    if self.newFillInfo.name ~= self.fillInfo.name then
        return true
    end

    if self.newFillInfo.address ~= self.fillInfo.address then
        return true
    end

    if self.newFillInfo.phone ~= self.fillInfo.phone then
        return true
    end

    if self.newFillInfo.email ~= self.fillInfo.email then
        return true
    end

    if self.newFillInfo.qq ~= self.fillInfo.qq then
        return true
    end

    local proviceName = self.fillInfo.selectInfo.proviceName or ""
    local municipalName = self.fillInfo.selectInfo.municipalName or ""
    local townName = self.fillInfo.selectInfo.townName or ""

    if self.newFillInfo.selectInfo.proviceName ~= proviceName then
        return true
    end

    if self.newFillInfo.selectInfo.municipalName ~= municipalName then
        return true
    end

    if self.newFillInfo.selectInfo.townName ~= townName then
        return true
    end

    return false
end

function AddressView:submitAddress()

    self:setNewfillInfo()

    local isExistEmpty = self:checkEmpty()
    if isExistEmpty then
        return
    end

    local isExistChange = self:checkChange()
    print("isExistChange:",isExistChange)

    Utils:openView("activity.AddressConfirmView",self.newFillInfo)

end


function AddressView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_BASE_ONFO,handler(self.updateAddress, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.detailBox) do
        v.pl:onClick(function()
            self:chooseDetialBox(k)
        end)
    end

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText());
    end

    local function onTextFieldAttachAcc(input)
        self.inputTextField = input
        self.inputLayer:show();
        self.inputLayer:listener(input:getText());
    end

    for k,v in ipairs(self.TextFieldTab_) do
        v:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
        v:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
        v:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
    end

    self.Button_submit:onClick(function()
        self:submitAddress()
    end)


end

return AddressView
