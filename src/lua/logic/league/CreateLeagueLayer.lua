local CreateLeagueLayer = class("CreateLeagueLayer", BaseLayer)

function CreateLeagueLayer:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:init("lua.uiconfig.league.createLeagueLayer")
end

function CreateLeagueLayer:initData(data)
    
end

function CreateLeagueLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_create_league = TFDirector:getChildByPath(self.ui,"Button_create_league")
    self.TextField_league_name = TFDirector:getChildByPath(self.ui,"TextField_league_name")
    self.Label_league_name = TFDirector:getChildByPath(self.ui, "Label_league_name")
    self.Image_league_flag = TFDirector:getChildByPath(self.ui, "Image_league_flag")
    self.Image_res_icon = TFDirector:getChildByPath(self.ui, "Image_res_icon")
    self.Label_res_num = TFDirector:getChildByPath(self.ui, "Label_res_num")


    local Image_placeholder_bg = TFDirector:getChildByPath(self.ui , "Image_placeholder_bg")

    self.countryId = 0
    self.panel_country =  Utils:createClubCountryNamePanel(Image_placeholder_bg , ccp(200 , -10)  , true , true , function ( countryId )
        self.countryId = countryId
        Utils:updateClubCountryName(self.panel_country , LeagueDataMgr:getClubCountryDataById(self.countryId).Countryabbreviations)
    end , true)
    Utils:updateClubCountryName(self.panel_country , LeagueDataMgr:getClubCountryDataById(self.countryId).Countryabbreviations)

    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer,1000)

    local cfg = LeagueDataMgr:getDefaultEmblemCfg()
    self.Image_league_flag:setTexture(cfg.icon)
    local costMap = TabDataMgr:getData("DiscreteData",51502).data.createUnionItem
    local cost = 0
    for k, v in pairs(costMap) do
        cost = v
    end
    self.costNum = cost
    self.Label_res_num:setText(tostring(cost))
    if GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND) < self.costNum then
        self.Label_res_num:setColor(ccc3(219,50,50))
    else
        self.Label_res_num:setFontColor(ccc3(255,255,255))
    end
end

function CreateLeagueLayer:onTouchSendBtn()
    self.TextField_league_name:setText(self.Label_league_name:getText())
end

function CreateLeagueLayer:onCloseInputLayer()
    self.TextField_league_name:closeIME()
end

function CreateLeagueLayer:onCreateUnionSuccess()
    AlertManager:closeAll()
    Utils:openView("league.LeagueMainLayer")
end

function CreateLeagueLayer:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_CREATE_UNION_SUCCESS, handler(self.onCreateUnionSuccess, self))

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 16 then
            local new_text = string.gsub(text, "Â·", "")
            input:setText(new_text)
            self.Label_league_name:setText(input:getText())
            self.inputLayer:listener(input:getText())
        end
        if string.len(self.Label_league_name:getText()) < 1 then
            self.Label_league_name:setTextById(111000069)
        end
    end

    local function onTextFieldAttachAcc(input)
        input:setText("")
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_league_name:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_league_name:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_league_name:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_create_league:onClick(function()
        if GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND) < self.costNum then
            Utils:showTips(800048)
            return
        end

        local text = self.Label_league_name:getText()
        if #text == 0 or not self.Label_league_name.isSet then
            Utils:showTips(270435)
        elseif not LeagueDataMgr:createUnion(text ,self.countryId) then
            Utils:showTips(200006)
        end
    end,
    EC_BTN.CLOSE)

    self.Label_league_name:onClick(function()
        self.Label_league_name.isSet = true
        self.TextField_league_name:openIME()
    end)
end

return CreateLeagueLayer