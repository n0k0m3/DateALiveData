TeamRoomView = class("TeamRoomView",BaseLayer)

function TeamRoomView:ctor(choiceIndex)
    self.super.ctor(self)
    self.choiceIndex = choiceIndex or 1
    self:initData()
    self:init("lua.uiconfig.teamFight.teamRoomView")
end

function TeamRoomView:initData()

end

function TeamRoomView:onShow()
    self.super.onShow(self)
end

function TeamRoomView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.TextButton_refresh = TFDirector:getChildByPath(self.Panel_root, "TextButton_refresh")

    local ScrollView_type = TFDirector:getChildByPath(self.Panel_root, "ScrollView_type")
    self.ListView_type = UIListView:create(ScrollView_type)
    self.Button_type = TFDirector:getChildByPath(self.Panel_root, "Button_type")

    local ScrollView_teamRoom= TFDirector:getChildByPath(self.Panel_root, "ScrollView_teamRoom")
    self.ListView_teamRoom = UIListView:create(ScrollView_teamRoom)

    self.Panel_team_group = TFDirector:getChildByPath(self.Panel_root, "Panel_team_group")

    self:initRoomType()
end

function TeamRoomView:initRoomType()

    self.roomTypeBtns = {}
    self.ListView_type:removeAllItems()
    local roomTypeCfg = TeamFightDataMgr:getRoomTypeCfg()
    for k,v in ipairs(roomTypeCfg) do
        local typeBtn = self.Button_type:clone()
        self.ListView_type:pushBackCustomItem(typeBtn)
        local Label_start = typeBtn:getChildByName("Label_start")
        print(v[1],v[2])
        Label_start:setTextById(v[2])
        local select = typeBtn:getChildByName("Image_select")
        table.insert(self.roomTypeBtns,{btn = typeBtn,select = select,teamType = v[1]})
        typeBtn:onClick(function()
            self:chooseRoomType(k)
        end)
    end
    self:chooseRoomType(self.choiceIndex)
end

function TeamRoomView:chooseRoomType(index)

    for k,v in ipairs(self.roomTypeBtns) do
        v.select:setVisible(index == k)
    end

    local teamType = self.roomTypeBtns[index].teamType
    self.choosedTeamType = teamType
    local data = TeamFightDataMgr:getTeamInfoByType(teamType)
    if not data then
        TeamFightDataMgr:Send_getTeamRoomInfo(teamType)
    else
        local curTime = ServerDataMgr:getServerTime()
        if curTime > data.nextTime then
            TeamFightDataMgr:Send_getTeamRoomInfo(teamType)
        else
            self:updateRoomInfo(teamType)
        end
    end
end

function TeamRoomView:updateRoomInfo(teamType)

    self.roomInfoItem = {}
    local data = TeamFightDataMgr:getTeamInfoByType(teamType)
    if not data then
        return
    end
    local teamInfo = data.teamInfo
    if not teamInfo then
        return
    end

    local roomSize = #teamInfo
    local items = self.ListView_teamRoom:getItems()
    local gap = roomSize - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_team_group = self.Panel_team_group:clone()
            self.ListView_teamRoom:pushBackCustomItem(Panel_team_group)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_teamRoom:removeItem(1)
        end
    end

    local items = self.ListView_teamRoom:getItems()
    for i=1,#items do
        local item = self.ListView_teamRoom:getItem(i)
        local info = teamInfo[i]
        self:updateRoomItems(item,info)
    end
end

function TeamRoomView:updateRoomItems(item,data)

    for k=1,3 do
        local member = data.members[k]
        local Panel_info = TFDirector:getChildByPath(item, "Panel_info"..k)
        local Button_add = TFDirector:getChildByPath(Panel_info, "Button_add")
        local Panel_playerInfo = TFDirector:getChildByPath(Panel_info, "Panel_playerInfo")
        if member then
            Button_add:setVisible(false)
            Panel_playerInfo:setVisible(true)

            local Label_name = TFDirector:getChildByPath(Panel_playerInfo, "Label_name")
            Label_name:setText(member.name)
            local Label_lv = TFDirector:getChildByPath(Panel_playerInfo, "Label_lv")
            Label_lv:setText("Lv."..member.plv)
            local Label_power = TFDirector:getChildByPath(Panel_playerInfo, "Label_power")
            Label_power:setText(member.fightPower)
            local icon = TFDirector:getChildByPath(Panel_playerInfo, "Image_player_icon")
            icon:setTexture(HeroDataMgr:getIconPathById(member.heroCid))
            local Image_power  = TFDirector:getChildByPath(Panel_playerInfo, "Image_power")
            local posX = Label_power:getPositionX() - Label_power:getContentSize().width
            Image_power:setPositionX(posX)
        else
            Button_add:setVisible(true)
            Panel_playerInfo:setVisible(false)
            Button_add:onClick(function()
                dump({data.teamId,data.battleId,data.teamType})
                TeamFightDataMgr:requestJoinTeam(data.teamId,data.battleId,data.teamType)
            end)
        end
    end

    local Image_title = TFDirector:getChildByPath(item, "Image_title")
    local Label_roomName = TFDirector:getChildByPath(item, "Label_roomName")
    local Label_roomLv = TFDirector:getChildByPath(item, "Label_roomLv")
    local Image_boss = TFDirector:getChildByPath(item, "Image_boss")
    local image_hard = TFDirector:getChildByPath(item, "image_hard")

    local Image_title2 = TFDirector:getChildByPath(item, "Image_title2")
    local Label_desc1 = TFDirector:getChildByPath(item, "Label_desc1")
    local Label_desc2 = TFDirector:getChildByPath(item, "Label_desc2")

    Image_title2:setVisible(data.teamType ~= EC_NetTeamType.FuShi)
    Image_title:setVisible(data.teamType == EC_NetTeamType.FuShi)
    -- 1,2,3,4
    local cfg = TeamFightDataMgr:getTeamLevelCfg(data.teamType,data.battleId)
    if not cfg then
        return
    end

    if data.teamType == EC_NetTeamType.FuShi then
        Label_roomName:setTextById(cfg.levelName)
        Label_roomLv:setTextById(cfg.LevelDesc)
        Image_boss:setTexture(cfg.bossicon)
        image_hard:setTexture(cfg.levelIcon)
        local affixData
        local affixID = cfg.affixID
        if affixID and affixID > 0 then
            affixData = TabDataMgr:getData("MonsterAffix",affixID)
        end
        for i = 1, 4 do
            local Image_affix = TFDirector:getChildByPath(Image_title, "Image_affix"..i):hide()
            if affixData then
                local affixIconRes  = affixData["affixIcon"..tostring(i)]
                if affixIconRes then
                    Image_affix:setVisible(true)
                    Image_affix:setTexture(affixIconRes)
                    Image_affix:setScale(0.3)
                end
            end
        end
    else
        local name = TextDataMgr:getText(cfg.levelName)
        Label_desc1:setText("Lv."..cfg.lvlLimit[1]..name)
        Label_desc2:setTextById(190000119)
    end
end

function TeamRoomView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_ROOMLIST, handler(self.updateRoomInfo, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.TextButton_refresh:onClick(function()
        local data = TeamFightDataMgr:getTeamInfoByType(self.choosedTeamType)
        if not data.nextTime then
            return
        end
        local curTime = ServerDataMgr:getServerTime()
        local remainTime = data.nextTime - curTime
        if remainTime > 0  then
            Utils:showTips(TextDataMgr:getText(100000315 , remainTime))
            return
        end
        TeamFightDataMgr:Send_getTeamRoomInfo(self.choosedTeamType)
    end)
end

return TeamRoomView