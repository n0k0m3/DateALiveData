--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  好友助力
* 
]]

local AssistanceAddrLayer = class("AssistanceAddrLayer", BaseLayer)

function AssistanceAddrLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceAddrLayer")
end

function AssistanceAddrLayer:initData( data )
    self.addressData = data.addressData
    self.itemIdx = data.itemIdx

    local activitys = ActivityDataMgr2:getActivityInfo(nil, 3)
    self.activityInfo = activitys[1]
    local itemsData = ActivityDataMgr2:getItems(self.activityInfo.id)
    self.itemId = itemsData[self.itemIdx]

    self.tabAndPanel = {}
    self.textFiledList = {}
    self.textFiledLabelList = {}
    self.imeBtnList = {}
end

function AssistanceAddrLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.closeBtn = TFDirector:getChildByPath(self.rootPanel, "btn_close")
    
 
    self.tabBtn1 = TFDirector:getChildByPath(self.rootPanel, "btn_tab1")
    self.tabBtn1.normalImg = TFDirector:getChildByPath(self.tabBtn1, "img_normal")
    self.tabBtn1.pressImg = TFDirector:getChildByPath(self.tabBtn1, "img_press")

    local addressPanel = TFDirector:getChildByPath(self.rootPanel, "panel_address")  
    table.insert(self.tabAndPanel, {tabBtn = self.tabBtn1, panel = addressPanel, func = handler(self.udpateAddressPanel, self)})
    self.tabBtn2 = TFDirector:getChildByPath(self.rootPanel, "btn_tab2")
    self.tabBtn2.normalImg = TFDirector:getChildByPath(self.tabBtn2, "img_normal")
    self.tabBtn2.pressImg = TFDirector:getChildByPath(self.tabBtn2, "img_press")
    self.okBtn = TFDirector:getChildByPath(addressPanel, "btn_ok")

    local rulePanel = TFDirector:getChildByPath(self.rootPanel, "panel_rule")
    local ruleLabel = TFDirector:getChildByPath(rulePanel, "label_rule")
    ruleLabel:setTextById(112000125)
    table.insert(self.tabAndPanel, {tabBtn = self.tabBtn2, panel = rulePanel})

    for i=1,5 do
        local textFiled = TFDirector:getChildByPath(addressPanel, "textField_" ..i)
        textFiled:setText(" ")
        table.insert(self.textFiledList, textFiled)

        local textFiledLabel = TFDirector:getChildByPath(addressPanel, "label_" ..i)
        textFiledLabel:setText("")
        table.insert(self.textFiledLabelList, textFiledLabel)

        local imeBtn = TFDirector:getChildByPath(addressPanel, "btn_imei_" ..i)
        table.insert(self.imeBtnList, imeBtn)
    end   

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)

    self:udpateUI(self.tabBtn1)
end

function AssistanceAddrLayer:onShow( )
    self.super.onShow(self)
end

function AssistanceAddrLayer:udpateUI( tabBtn )
    self:switchToTab(tabBtn)
end

function AssistanceAddrLayer:registerEvents( )
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onRecvSubmitActivity, self))
    
    self.closeBtn:onClick(function(sender)
        AlertManager:closeLayer(self)
    end)

    self.okBtn:onClick(function(sender)
        local _, remainCount = ActivityDataMgr2:getRemainBuyCount(self.activityInfo.activityType, self.itemId)
        local nameText = self.textFiledLabelList[1]:getText()
        local addressText = self.textFiledLabelList[2]:getText()
        local postText = self.textFiledLabelList[3]:getText()
        local telText = self.textFiledLabelList[4]:getText()
        local faceBookText = self.textFiledLabelList[5]:getText()
        --必填信息
        if nameText == "" or addressText == "" or postText == "" or telText == "" then
            Utils:showTips(112000128)
            return 
        end

        if not (string.match(telText,"[0-9][0-9][0-9]%-[0-9][0-9][0-9][0-9]%-[0-9][0-9][0-9][0-9]") == telText) then
            Utils:showTips(112000126)
            return 
        end

        if not (string.match(postText,"[0-9][0-9][0-9][0-9][0-9]") == postText) then
            Utils:showTips(112000127)
            return 
        end

        local json = require("LuaScript.extends.json")
        local addressJson = json.encode({name =  nameText, address = addressText, post = postText, tel = telText, faceBook = faceBookText})
        local extendData = ({num = remainCount, address = {name =  nameText, address = addressText, post = postText, tel = telText, faceBook = faceBookText}})  
        local jsonExtendData = json.encode(extendData)
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, self.itemId, jsonExtendData)
    end)

    self.tabBtn1:onClick(function(sender)
        self:udpateUI(self.tabBtn1)
    end)
    self.tabBtn2:onClick(function(sender)
        self:udpateUI(self.tabBtn2)
    end)

    for _idx,_btn in ipairs(self.imeBtnList) do  
        _btn:onClick(function(sender)
            self.inputTextField = self.textFiledList[_idx]
            self.textFiledList[_idx]:openIME()
        end)
    end

    local function tranTel(s)
        s = string.gsub(s, "-", "");
        local k = string.len(s)
        local list1 = {}
        for i=1,k do
            list1[i]= string.sub(s,i,i)
        end
        local text = ""
        for i=1,k do
            text = text ..list1[i]
            if i == 3 or i == 7 then
                text = text .."-"
            end
        end
        return text
    end

    local function onTextFieldChangedHandleAcc(input)
        for _idx,_input in ipairs(self.textFiledList) do   
            if _input  == input then
                local text = input:getText()
                if _input == self.textFiledList[4] then
                    if not(text == "" or text == " ") then
                        text = tranTel(text)       
                    end                               
                else
                   text = input:getText()
                end
                self.textFiledLabelList[_idx]:setText(text)
                self.inputLayer:listener(text)
            end          
        end
    end

    local function onTextFieldAttachAcc(input)        
        self.inputLayer:show()
        for _idx,_input in ipairs(self.textFiledList) do   
            if _input  == input then
                local text = input:getText()
                if _input == self.textFiledList[4] then  
                    if not(text == "" or text == " ") then
                        text = tranTel(text)      
                    end                                                                           
                else
                    text = input:getText()
                end
                self.textFiledLabelList[_idx]:setText(text)
                self.inputLayer:listener(text)
            end          
        end
    end

    for k,_textFiled in ipairs(self.textFiledList) do
        _textFiled:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
        _textFiled:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
        _textFiled:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
    end
end

function AssistanceAddrLayer:removeEvents( )
    self.super.removeEvents(self)
end

function AssistanceAddrLayer:switchToTab( tabBtn )
    for _,_tabInfo in ipairs(self.tabAndPanel) do  
        _tabInfo.panel:hide()
        _tabInfo.tabBtn.normalImg:show()
        _tabInfo.tabBtn.pressImg:hide()
        if _tabInfo.tabBtn == tabBtn then
            _tabInfo.panel:show()
            _tabInfo.tabBtn.normalImg:hide()
            _tabInfo.tabBtn.pressImg:show()
            if _tabInfo.func then
                _tabInfo.func()
            end
        end
    end   
end

function AssistanceAddrLayer:udpateAddressPanel( )
    if self.addressData and self.addressData.address and self.addressData.address ~= "" then     
        local json = require("LuaScript.extends.json")
        local address = json.decode(self.addressData.address)
        self.textFiledLabelList[1]:setText(address.name)
        self.textFiledLabelList[2]:setText(address.address)
        self.textFiledLabelList[3]:setText(address.post)
        self.textFiledLabelList[4]:setText(address.tel)
        self.textFiledLabelList[5]:setText(address.faceBook)
    end
end

function AssistanceAddrLayer:onTouchSendBtn()
end

function AssistanceAddrLayer:onCloseInputLayer()
    if self.inputTextField then self.inputTextField:closeIME() end
end

function AssistanceAddrLayer:onRecvSubmitActivity( )
    AlertManager:closeLayer(self)
end

return AssistanceAddrLayer
