local EditNoticeView = class("EditNoticeView", BaseLayer)

function EditNoticeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.editNoticeView")
end

function EditNoticeView:initData()
   
end

function EditNoticeView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Button_cancel = TFDirector:getChildByPath(self.ui, "Button_cancel")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.TextField_notice = TFDirector:getChildByPath(self.ui,"TextField_notice")
    self.Label_notice = TFDirector:getChildByPath(self.ui, "Label_notice")
    self.Label_tips = TFDirector:getChildByPath(self.ui, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")

    local notice = LeagueDataMgr:getUnionNotice()
    local list = string.UTF8ToCharArray(notice)
    self.allStrNum = 100
    if (TFLanguageMgr:getUsingLanguage() == cc.SIMPLIFIED_CHINESE) or (TFLanguageMgr:getUsingLanguage() == cc.TRADITIONAL_CHINESE) then
         self.allStrNum = 100
    else
         self.allStrNum = 200
    end
    local length = math.max(0,  self.allStrNum - #list)
    self.Label_tips:setTextById(270436, length)
    self.Label_notice:setText(notice)
    
    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end,
        contentSize = CCSize(933 , 50)
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)

    
end

function EditNoticeView:onTouchSendBtn()
    self.TextField_notice:setText(self.Label_notice:getText())
end

function EditNoticeView:onCloseInputLayer()
    self.TextField_notice:closeIME()
end

function EditNoticeView:onEditNoticeBack()
    AlertManager:closeLayer(self)
end

function EditNoticeView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_NOTICE_CHANGE, handler(self.onEditNoticeBack, self))
    
    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= self.allStrNum then
            input:setText(text)
            self.Label_notice:setText(text)
            self.inputLayer:listener(input:getText())
            local length = math.max(0, self.allStrNum - #list)
            self.Label_tips:setTextById(270436, length)
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        local list = string.UTF8ToCharArray(text)
        input:setText(text)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
        local length = math.max(0,  self.allStrNum - #list)
        self.Label_tips:setTextById(270436, length)
    end

    self.TextField_notice:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_notice:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_notice:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Label_notice:onClick(function()
        self.Label_notice.isSet = true
        self.TextField_notice:openIME()
    end)
    
    self.Button_cancel:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        local text = self.Label_notice:getText()
        -- if Utils:isStringContainSpecialChars(text,"%s") ~= nil then
        --     Utils:showTips(200006)
        --     return
        -- end
        LeagueDataMgr:UpdateUnionInfo(EC_UNION_EDIT_Type.PROCLAMATION, text)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return EditNoticeView