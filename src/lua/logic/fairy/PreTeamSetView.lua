local PreTeamSetView = class("PreTeamSetView", BaseLayer)


function PreTeamSetView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:init("lua.uiconfig.fairy.preTeamSetView")
end

function PreTeamSetView:initData(data)

    self.isSkyLadder = data.isSkyLadder
    self.isHwx = data.isHwx
    self.isEndless = data.isEndless
    self.maxPreTeamCount = Utils:getKVP(52003,"max",7)
    self.teamItem_ = {}
end

function PreTeamSetView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.Panel_base = TFDirector:getChildByPath(ui,"Panel_base")

    self.Panel_cell = TFDirector:getChildByPath(self.Panel_base,"Panel_cell")
    local ScrollView_team = TFDirector:getChildByPath(self.Panel_base,"ScrollView_team")
    self.GridView_team = UIGridView:create(ScrollView_team)
    self.GridView_team:setColumn(2)
    self.GridView_team:setColumnMargin(60)
    self.GridView_team:setRowMargin(20)
    self.GridView_team:setItemModel(self.Panel_cell)
    
    self.TextField_input = TFDirector:getChildByPath(self.Panel_base,"TextField_input")

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

    HeroDataMgr:Send_GetPreTeamInfo()
end

function PreTeamSetView:onCloseInputLayer()
    self.TextField_input:closeIME()
    self.TextField_input:setText("")
end

function PreTeamSetView:onTouchSendBtn()
    local content = self.TextField_input:getText()
    if content and #content > 0 and self.teamId then
        HeroDataMgr:Send_MotifyTeamName(self.teamId,content)
    end
end

function PreTeamSetView:updateAllTeamInfo()
    for teamId=1,self.maxPreTeamCount do
        local item = self.GridView_team:getItem(teamId)
        if not item then
            item = self:addTeamItem(teamId)
        end
        local teamData = HeroDataMgr:getPreTeamInfo(teamId)
        self:updateTeamItem(teamId, teamData)
    end

end

function PreTeamSetView:addTeamItem(teamId)

    local item = self.GridView_team:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.Label_team_name = TFDirector:getChildByPath(foo.root, "Label_team_name")
    foo.Button_modifyName = TFDirector:getChildByPath(foo.root, "Button_modifyName")
    foo.Button_select = TFDirector:getChildByPath(foo.root, "Button_select")

    local headInfo = {}
    for i=1,3 do
        local Panel_team = TFDirector:getChildByPath(foo.root, "Panel_team"..i)
        local Panel_head = TFDirector:getChildByPath(Panel_team, "Panel_head")
        local headIcon = TFDirector:getChildByPath(Panel_head, "Image_team_head")
        local Image_add = TFDirector:getChildByPath(Panel_team, "Image_add")
        table.insert(headInfo,{Panel_head = Panel_head, headIcon = headIcon, Image_add = Image_add})
    end
    foo.headInfo = headInfo

    self.teamItem_[teamId] = foo
    return item
end

function PreTeamSetView:updateTeamItem(teamId,teamData)

    local teamItem = self.teamItem_[teamId]
    if not teamItem then
        return
    end
    if not teamData then
        teamItem.Label_team_name:setTextById(14300321,teamId)
        teamItem.Button_modifyName:setTouchEnabled(false)
        teamItem.Button_modifyName:setGrayEnabled(true)
        teamItem.Button_select:setTouchEnabled(false)
        teamItem.Button_select:setGrayEnabled(true)
    else
        local teamName = teamData.teamName == "" and TextDataMgr:getText(14300321,teamData.teamId) or teamData.teamName
        teamItem.Label_team_name:setText(teamName)
        teamItem.Button_modifyName:setTouchEnabled(true)
        teamItem.Button_modifyName:setGrayEnabled(false)
        teamItem.Button_select:setTouchEnabled(true)
        teamItem.Button_select:setGrayEnabled(false)
    end

    for i=1,3 do
        if teamData then
            local heroId = teamData.formation[i]
            if heroId then
                teamItem.headInfo[i].Panel_head:show()
                local headIconRes = HeroDataMgr:getIconPathById(tonumber(heroId))
                teamItem.headInfo[i].headIcon:setTexture(headIconRes)
            else
                teamItem.headInfo[i].Panel_head:hide()
            end
        else
            teamItem.headInfo[i].Panel_head:hide()
        end

        teamItem.headInfo[i].Image_add:onClick(function()
            HeroDataMgr:changeFormation(i, false,self.isEndless,self.isSkyLadder,self.isHwx,false,false,teamId)
        end)
    end

    teamItem.Button_select:onClick(function()
        self:selectPreTeam(teamId)
    end)

    teamItem.Button_modifyName:onClick(function()
        self.teamId = teamId
        self.TextField_input:openIME()
    end)
end

function PreTeamSetView:selectPreTeam(teamId)

    local teamInfo = HeroDataMgr:getPreTeamInfo(teamId)
    if not teamInfo then
        return
    end

    local formation = teamInfo.formation
    local count = #formation
    if count == 0 then
        return
    end

    local teamName = teamInfo.teamName
    local tipStr = TextDataMgr:getText(14300318,teamName)
    local args = {
        tittle = 2107025,
        content = tipStr,
        reType = EC_OneLoginStatusType.ReconFirm_PreTeam,
        confirmCall = function()
            HeroDataMgr:Send_SelectPreTeam(teamId)
        end,
    }
    Utils:showReConfirm(args)

end

function PreTeamSetView:updateTeamInfo(teamId)

    if not teamId then
        self:updateAllTeamInfo()
    else
        local teamData = HeroDataMgr:getPreTeamInfo(teamId)
        dump(teamData)
        if teamData then
            self:updateTeamItem(teamId, teamData)
        end
    end

end

function PreTeamSetView:onRecvSetPreTeam()
    Utils:showTips(14300319)
    AlertManager:closeLayer(self)
end

function PreTeamSetView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_PRE_TEAM, handler(self.updateTeamInfo, self))
    EventMgr:addEventListener(self, EV_SET_PRE_TEAM, handler(self.onRecvSetPreTeam, self))

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
    end

    self.TextField_input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

end

return PreTeamSetView
