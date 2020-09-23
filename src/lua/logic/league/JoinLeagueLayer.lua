local JoinLeagueLayer = class("JoinLeagueLayer", BaseLayer)

function JoinLeagueLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.league.JoinLeagueLayer")
end

function JoinLeagueLayer:initData()
   self.searchState = false
   self.filterState = false
end

function JoinLeagueLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.CheckBox_join = TFDirector:getChildByPath(self.ui, "CheckBox_join")
    self.Label_limit_tips = TFDirector:getChildByPath(self.ui, "Label_limit_tips")
    self.Button_fast = TFDirector:getChildByPath(self.ui, "Button_fast")
    self.Button_refresh = TFDirector:getChildByPath(self.ui, "Button_refresh")
    self.Label_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh")
    self.Button_search_join = TFDirector:getChildByPath(self.ui, "Button_search_join")
    local ScrollView_league = TFDirector:getChildByPath(self.ui, "ScrollView_league")

    self.TextField_league_id = TFDirector:getChildByPath(self.ui,"TextField_league_id")
    self.Label_league_id = TFDirector:getChildByPath(self.ui, "Label_league_id")

    self.Panel_league_item = TFDirector:getChildByPath(self.ui, "Panel_league_item")

    self.ScrollView_league = UIListView:create(ScrollView_league)
    self.ScrollView_league:setItemsMargin(5)

    self.Label_refresh:setTextById(700026)
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
end

function JoinLeagueLayer:onShow()
    self.super.onShow(self)
    LeagueDataMgr:queryUnionList()
end

function JoinLeagueLayer:onTouchSendBtn()
    self.TextField_league_id:setText(self.Label_league_id:getText())
end

function JoinLeagueLayer:onCloseInputLayer()
    self.TextField_league_id:closeIME()
end

function JoinLeagueLayer:refreshLeagueList()
    if self.joinSuccess then
        return
    end
    self.searchState = false
    self.ScrollView_league:removeAllItems()
    local unionData = LeagueDataMgr:getQueryUnionList()
    if unionData then
        for i,union in ipairs(unionData) do
            if self.filterState then
                if union.canApply and MainPlayer:getPlayerLv() >= union.limitLevel and union.memberCount < union.memberCountMax then 
                    local item = self.Panel_league_item:clone()
                    self:updateLeagueItem(item, union)
                    self.ScrollView_league:pushBackCustomItem(item)
                end
            else
                local item = self.Panel_league_item:clone()
                self:updateLeagueItem(item, union)
                self.ScrollView_league:pushBackCustomItem(item)
            end
        end
    end
end

function JoinLeagueLayer:refreshSearchUnion()
    self.searchState = true
    local union = LeagueDataMgr:getSearchOutUnion()
    if union then
        self.ScrollView_league:removeAllItems()
        if self.filterState then
            if union.canApply and MainPlayer:getPlayerLv() >= union.limitLevel and union.memberCount < union.memberCountMax then 
                local item = self.Panel_league_item:clone()
                self:updateLeagueItem(item, union)
                self.ScrollView_league:pushBackCustomItem(item)
            end
        else
            local item = self.Panel_league_item:clone()
            self:updateLeagueItem(item, union)
            self.ScrollView_league:pushBackCustomItem(item)
        end
    end
end

function JoinLeagueLayer:refreshContentUI()
    if self.searchState then
        self:refreshSearchUnion()
    else
        self:refreshLeagueList()
    end
end

function JoinLeagueLayer:updateLeagueItem(item, data)
    local Image_league_flag = TFDirector:getChildByPath(item, "Image_league_flag")
    local Label_league_name = TFDirector:getChildByPath(item, "Label_league_name")
    local Label_league_level = TFDirector:getChildByPath(item, "Label_league_level")
    local Label_members_num = TFDirector:getChildByPath(item, "Label_members_num")
    local Label_active_num = TFDirector:getChildByPath(item, "Label_active_num")
    local Label_limit = TFDirector:getChildByPath(item, "Label_limit")
    local Label_limit_desc = TFDirector:getChildByPath(item, "Label_limit_desc")
    local Button_aply = TFDirector:getChildByPath(item, "Button_aply")
    local Button_join = TFDirector:getChildByPath(item, "Button_join")
    local Label_aplied = TFDirector:getChildByPath(item, "Label_aplied")


    local countryStr = ""
    if data.showCountry then
        countryStr = " ("..LeagueDataMgr:getClubCountryDataById(data.country).Countryabbreviations..")"
    end
    
    local emblemCfg = LeagueDataMgr:getEmblemCfgById(data.icon or 101)
    Image_league_flag:setTexture(emblemCfg.icon)
    Label_league_name:setText(data.name .. countryStr)
    Label_league_level:setText("Lv."..tostring(data.level))
    Label_members_num:setText(tostring(data.memberCount).."/"..data.memberCountMax)
    local active = data.active
    if active > 0 then
        Label_active_num:setText(tostring(active).."%")
    else
        Label_active_num:setText("--")
    end
    
    Label_limit:setVisible(data.limitLevel > 1)
    Label_limit_desc:setVisible(data.limitLevel > 1)
    Label_limit_desc:setTextById(270437,data.limitLevel)
    Button_aply:setVisible(true)
    Button_join:setVisible(false)
    Label_aplied:setVisible(false)
    Button_aply:setTouchEnabled(true)
    Button_aply:setGrayEnabled(false)
    if data.apply then
        Button_join:setVisible(false)
        Button_aply:setVisible(false)
        Label_aplied:setVisible(true)
    end
    if not data.canApply 
        or MainPlayer:getPlayerLv() < data.limitLevel 
        or data.memberCount >= data.memberCountMax then
        Button_aply:setTouchEnabled(false)
        Button_aply:setGrayEnabled(true)
    end

    Button_join:onClick(function()
        if MainPlayer:getPlayerLv() < data.limitLevel then
            Utils:showTips(270438)
            return
        end
        LeagueDataMgr:operateUnionMember(EC_UNIONType.APLY, {data.id})
    end)

    Button_aply:onClick(function()
        if MainPlayer:getPlayerLv() < data.limitLevel then
            Utils:showTips(270438)
            return
        end
        LeagueDataMgr:operateUnionMember(EC_UNIONType.APLY, {data.id})
    end)
end

function JoinLeagueLayer:updateFilterState(state)
    self.filterState = state
    self:refreshContentUI()
end

function JoinLeagueLayer:joinUnionSuccess()
    if self.joinSuccess then
        return
    end
    self.joinSuccess = true
    self.ui:timeOut(function()
        AlertManager:closeAll()
        Utils:openView("league.LeagueMainLayer")
    end,0.1)
end

function JoinLeagueLayer:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_QUERY_UNION_LIST, handler(self.refreshLeagueList, self))
    EventMgr:addEventListener(self, EV_UNION_SEARCH_UNION, handler(self.refreshSearchUnion, self))
    EventMgr:addEventListener(self, EV_UNION_APPLY_JOIN_UNION, handler(self.refreshContentUI, self))
    EventMgr:addEventListener(self, EV_UNION_FAST_JOIN_UNION, handler(self.joinUnionSuccess, self))
    EventMgr:addEventListener(self, EV_UNION_BASE_INFO_UPDATE, handler(self.joinUnionSuccess, self))
    

    local function onTextFieldChangedHandleAcc(input)
        local text = input:getText()
        local list = string.UTF8ToCharArray(text)
        if #list <= 9 then
            local new_text = string.gsub(text, "·", "")
            input:setText(new_text)
            self.Label_league_id:setText(input:getText())
            self.inputLayer:listener(input:getText())
        end
    end

    local function onTextFieldAttachAcc(input)
        local text = ""
        local new_text = string.gsub(text, "·", "")
        input:setText(new_text)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_league_id:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_league_id:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_league_id:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)


    self.CheckBox_join:onEvent(function(event)
        if event.name == "selected" then
            self:updateFilterState(true)
        else
            self:updateFilterState(false)
        end
    end)

    self.Label_league_id:onClick(function()
        self.Label_league_id:setText("")
        self.Label_league_id.isSet = true
        self.TextField_league_id:openIME()
    end)

    self.Button_fast:onClick(function()
        LeagueDataMgr:operateUnionMember(EC_UNIONType.FAST_JOIN)
    end)

    self.Button_refresh:onClick(function()
        LeagueDataMgr:queryUnionList()
        local cdTime = 5
        self.Button_refresh:setTouchEnabled(false)
        self.Button_refresh:setGrayEnabled(true)
        self.Label_refresh:setTextById(800040, cdTime)
        self.refreshTimerId_ = TFDirector:addTimer(
                1000,
                cdTime,
                function()
                    self.Button_refresh:setTouchEnabled(true)
                    self.Button_refresh:setGrayEnabled(false)
                    self.Label_refresh:setTextById(700026)
                    TFDirector:removeTimer(self.refreshTimerId_)
                    self.refreshTimerId_ = nil
                end,
                function()
                    cdTime = cdTime - 1
                    self.Label_refresh:setTextById(800040, cdTime)
                end
        )
    end)

    self.Button_search_join:onClick(function()
        local text = self.Label_league_id:getText()
        if #text == 0 or not self.Label_league_id.isSet then
            Utils:showTips(270439)
        elseif not LeagueDataMgr:SearchUnion(text) then
            Utils:showTips(200006)
        end
    end)
end

function JoinLeagueLayer:removeEvents()
    if self.refreshTimerId_ then
        TFDirector:removeTimer(self.refreshTimerId_)
    end
end

return JoinLeagueLayer