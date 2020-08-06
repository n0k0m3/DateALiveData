local PlayerInfoSettingView = class("PlayerInfoSettingView", BaseLayer)
local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function PlayerInfoSettingView:initData(data)
    self.showid = MainPlayer:getAssistId()
    self.offsetX = data or 0
end

function PlayerInfoSettingView:ctor(data)
    self.super.ctor(self)

    self:initData(data)
    self:init("lua.uiconfig.playerInfo.playerInfoSettingView")
end

function PlayerInfoSettingView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

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
    self.inputLayer:setPositionX(-(GameConfig.WS.width - 1136) / 2);

    self:initInfo()
    self:refreshInfo()
end

function PlayerInfoSettingView:initInfo()
    self.Image_bg = TFDirector:getChildByPath(self.ui,"Image_bg")
    self.Image_bg:PosX(self.Image_bg:PosX()+self.offsetX)
    self.Image_head = TFDirector:getChildByPath(self.ui,"Image_head")
    self.Label_playerName = TFDirector:getChildByPath(self.ui,"Label_playerName")
    self.Label_playerId = TFDirector:getChildByPath(self.ui,"Label_playerId")
    self.Label_as_name = TFDirector:getChildByPath(self.ui,"Label_as_name")
    self.Label_quality = TFDirector:getChildByPath(self.ui,"Label_quality")
    self.Button_modifyName = TFDirector:getChildByPath(self.ui,"Button_modifyName")
    self.Button_copy = TFDirector:getChildByPath(self.ui,"Button_copy")

    self:initPlayerLv()
    self:initDeclaration()
end

function PlayerInfoSettingView:refreshInfo()
    print("PlayerInfoSettingView:refreshInfo")
    self.showid = MainPlayer:getAssistId()
    local headPath = HeroDataMgr:getPlayerIconPathById(self.showid)
    local qualityStr = HeroDataMgr:getQualityStringById(self.showid)
    local playerName = MainPlayer:getPlayerName()
    local playerId = MainPlayer:getPlayerId()
    -- local asName = "未开放"
    local asName = TextDataMgr:getText(600027)
    if MainPlayer:getAs() then
        asName = MainPlayer:getAs().asName
    end
    self.Image_head:setTexture(headPath)
    self.Label_quality:setString(qualityStr)
    self.Label_playerName:setString(playerName)
    self.Label_playerId:setString(playerId)
    self.Label_as_name:setString(asName)

    self:refreshPlayerLv()
    self:refreshDeclaration()
end

function PlayerInfoSettingView:initPlayerLv()
    self.Label_lv = TFDirector:getChildByPath(self.ui,"Label_lv")
    self.Label_maxLv = TFDirector:getChildByPath(self.ui, "Label_maxLv")
    self.LoadingBar_lv  = TFDirector:getChildByPath(self.ui,"LoadingBar_lv")
    self.Label_curExp = TFDirector:getChildByPath(self.ui,"Label_curExp")

    -- self.LoadingBar_lv:setAngle(45)
end

function PlayerInfoSettingView:refreshPlayerLv()
    local expPercent = MainPlayer:getExpProgress()
    local lv = MainPlayer:getPlayerLv()
    local curExp = MainPlayer:getPlayerExp()
    local curLevelMaxExp = TabDataMgr:getData("LevelUp",lv).playerExp
    self.LoadingBar_lv:setPercent(expPercent)
    if curLevelMaxExp <= 0 then
        self.Label_curExp:setString("max")
    else
        self.Label_curExp:setString(curExp .."/".. curLevelMaxExp)
    end    
    self.Label_lv:setString("Lv." .. MainPlayer:getPlayerLv())
    self.Label_maxLv:setText("/"..60)
end

function PlayerInfoSettingView:initDeclaration()
    self.Label_dec = TFDirector:getChildByPath(self.ui,"Label_dec")
    self.TextField_des = TFDirector:getChildByPath(self.ui,"TextField_des"):hide()
    self.Button_dec_modify = TFDirector:getChildByPath(self.ui,"Button_dec_modify")
    self.Label_dec_modify = TFDirector:getChildByPath(self.ui,"Label_dec_modify")
    self.Label_dec_modify_ok = TFDirector:getChildByPath(self.ui,"Label_dec_modify_ok")
end

function PlayerInfoSettingView:refreshDeclaration()
    self.Label_dec:show()
    local decStr = MainPlayer:getDeclaration()
    if decStr ~= "" then
        self.Label_dec:setString(decStr)
    end
end

function PlayerInfoSettingView:registerEvents()
    EventMgr:addEventListener(self, EV_MODIFY_DEC, handler(self.onModifyDecEvent, self))

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
        EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

    self.TextField_des:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_des:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_dec_modify:onClick(function()
        self.TextField_des:openIME()
    end)

    self.Button_modifyName:onClick(function()
        --改名
        local modifyNameView = require("lua.logic.playerInfo.ModifyNameView"):new()
        AlertManager:addLayer(modifyNameView)
        AlertManager:show()
    end)

    self.Button_copy:onClick(function()
            local content = self.Label_playerId:getString()
            TFDeviceInfo:copyToPasteBord(content)
            Utils:showTips(600010)
        end)
end

function PlayerInfoSettingView:onTouchSendBtn()
    print("onTouchSendBtn")
    local content = self.TextField_des:getText()
    if content and #content > 0 then
        if not MainPlayer:setDeclaration(content) then
            Utils:showTips(200006)
        end
        self.TextField_des:setText("")
    else
        -- toastMessage("发送内容不能为空")
        Utils:showTips(800104)
    end
end

function PlayerInfoSettingView:onCloseInputLayer()
    EventMgr:dispatchEvent(PlayerInfoConfig.EV_OUTPUT)
    self.TextField_des:closeIME()
    self.TextField_des:setText("")
end


function PlayerInfoSettingView:onModifyDecEvent()
    self:refreshInfo()
end

return PlayerInfoSettingView