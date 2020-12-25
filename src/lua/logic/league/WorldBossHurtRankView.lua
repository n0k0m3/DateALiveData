--[[
    @descï¼šWorldBossHurtRankView
]]

local WorldBossHurtRankView = class("WorldBossHurtRankView",BaseLayer)

function WorldBossHurtRankView:initData(data)
    dump(data)
    self.rankData = data.unionDamage or {}
    self.myData   = data.myUnionDamage
    self.type = data.type
    self.personHurt = data.damage or 0

    table.sort(self.rankData, function(a, b)
        return a.rank < b.rank
    end)
end

function WorldBossHurtRankView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.worldBossHurtRankView")
end

function WorldBossHurtRankView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.noData:setVisible(#self.rankData == 0)
    self._ui.lab_myLeagueHurtNum:setSkewX(15)

    self.scrollBar = UIScrollBar:create(self._ui.Image_shieldingScrollBar, self._ui.Image_scrollBarInner)

    self.tableView = Utils:scrollView2TableView(self._ui.ScrollView_members)
    self.tableView:onNumberOfCells(function()
        return table.count(self.rankData)
    end)
    self.tableView:onCellSize(function()
        local size = self._ui.Panel_rankItem:getContentSize() 
	    return size.height + 5, size.width
    end)
    self.tableView:onCellAtIndex(function(table, idx)
        local cell = table:dequeueCell()
        if nil == cell then
            table.cells = table.cells or {}
            cell = TFTableViewCell:create()
            local parentNode = self._ui.Panel_rankItem:clone()
            parentNode:setVisible(true)
            parentNode:setPosition(ccp(0,0))
            cell:addChild(parentNode)
            cell.node = parentNode
            table.cells[cell] = true
        end
        local itemNode = cell.node
        self:updateCell(itemNode, idx + 1)
        return cell
    end)

    self:refreshView()
end

function WorldBossHurtRankView:updateCell(item, idx)
    local data = self.rankData[idx]
    local lab_rankNum = TFDirector:getChildByPath(item, "lab_rankNum")
    local lab_leagueName = TFDirector:getChildByPath(item, "lab_leagueName")
    local lab_leagueHurtNum = TFDirector:getChildByPath(item, "lab_leagueHurtNum")
    local img_Icon = TFDirector:getChildByPath(item, "img_Icon"):hide()
    lab_leagueHurtNum:setSkewX(15)
    local iconSrc = nil
    if data.rank == 1 then
        iconSrc = "ui/league/worldBoss/13.png"
    elseif data.rank == 2 then
        iconSrc = "ui/league/worldBoss/14.png"
    elseif data.rank == 3 then
        iconSrc = "ui/league/worldBoss/15.png"
    end
    if iconSrc then
        img_Icon:setTexture(iconSrc)
        img_Icon:show()
    end

    lab_rankNum:setSkewX(15)
    lab_rankNum:setText(data.rank)
    lab_leagueName:setText(data.unionName)
    lab_leagueHurtNum:setText(Utils:converNumWithComma(data.damage))
end

function WorldBossHurtRankView:refreshView()
    self.tableView:reloadData()
    local innerSize = self.tableView:getContentSize()
    local size      = self.tableView:getSize()
    local ratio     = size.height / innerSize.height
    ratio = ratio <= 1 and ratio or 1
    self.scrollBar:setRatio(ratio)
    self.scrollBar:setPercent(1)

    local txt = self.myData.rank
    if txt == -1 then
        txt = TextDataMgr:getText(16000305)
    elseif txt > 100 and txt <= 1000 then
        txt = "101-1000"
    elseif txt > 1000 then
        txt = TextDataMgr:getText(16000305)
    end
    self._ui.lab_myLeagueRankNum:setSkewX(15)
    self._ui.lab_myLeagueRankNum:setText(txt)
    self._ui.lab_myLeagueName:setText(LeagueDataMgr:getMyUnionInfo().name)
    self._ui.lab_myLeagueHurtNum:setText(Utils:converNumWithComma(self.myData.damage))

    local _tmp
    local cfg = LeagueDataMgr:getCurInvade()
    if cfg.type == EC_WorldBossType.World then
         _tmp, self.personHurt = LeagueDataMgr:getIsRewardsAndMaxNum()
    end
    self._ui.lab_myHurtNum:setText(Utils:converNumWithComma(self.personHurt))
end

function WorldBossHurtRankView:registerEvents()

    self.tableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))

    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    local cfg = LeagueDataMgr:getCurInvade()
    if cfg.type == EC_WorldBossType.World then
        self._ui.Panel_myLeagueInfo:setTouchEnabled(true)
        self._ui.Panel_myLeagueInfo:onClick(function()
            LeagueDataMgr:send_send_JU_NAI_INVASION_REQ_GET_UNION_PLAYER_RANK()
        end)
    else
        self._ui.Panel_myLeagueInfo:setTouchEnabled(false)
    end
    
    self._ui.btn_rankAward:onClick(function()
        Utils:openView("league.WorldBossRankAwardView", 2, self.type, self.personHurt)
    end)

    EventMgr:addEventListener(self, EV_LEAGUE_WORLDBOSS_ATTACKRANK_UPDATE, function(data)
        if not AlertManager:getLayerBySpecialName("WorldBossPersonHurtView") then
            Utils:openView("league.WorldBossPersonHurtView", data, self.myData.damage)
        end
    end)
end

function WorldBossHurtRankView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = -contentOffset.y/length
    percent = percent <= 1 and percent or 1
    percent = percent < 0 and 0 or percent
    self.scrollBar:setPercent(percent)
end

return WorldBossHurtRankView