--[[
    @desc：LandTurnTabletRankView
]]

local LandTurnTabletRankView = class("LandTurnTabletRankView",BaseLayer)

function LandTurnTabletRankView:initData(rankData, isFinishAllTurn, turnNum)
    self.rankData = rankData.rankInfo or {}
    self.myRankData = rankData.myRank
    self.isFinishAllTurn = isFinishAllTurn
    self.turnNum = turnNum
    self.activityId   = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.LAND_TURNTABLET)[1]
    self.activityInfo =  ActivityDataMgr2:getActivityInfo(self.activityId)
    self.stopRankTime = self.activityInfo.extendData.listtime
end

function LandTurnTabletRankView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.landTurnTabletRankView")
end

function LandTurnTabletRankView:initUI(ui)
    self.super.initUI(self,ui)

    self.tableView = Utils:scrollView2TableView(self._ui.ScrollView_content)
    self.tableView:onNumberOfCells(function()
        return table.count(self.rankData)
    end)
    self.tableView:onCellSize(function()
        local size = self._ui.PanelRankItem:getContentSize() 
	    return size.height+5, size.width
    end)
    self.tableView:onCellAtIndex(function(table, idx)
        local cell = table:dequeueCell()
        if nil == cell then
            table.cells = table.cells or {}
            cell = TFTableViewCell:create()
            local parentNode = self._ui.PanelRankItem:clone()
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
    self.tableView:reloadData()

    self._ui.lab_hadgetnum1:setTextById(63850)
    self._ui.lab_hadGetNums:setText(TextDataMgr:getText(63850)..":")

    self._ui.lab_noRank:setVisible(table.count(self.rankData) == 0)
    self:refreshMyRankInfo()
end

function LandTurnTabletRankView:refreshMyRankInfo()
    local function timerCallFunc()
        local lastTime = ServerDataMgr:getServerTime() - self.activityInfo.startTime
        local day, hour, min, sec = Utils:getTimeDHMZ(lastTime, true)
        self._ui.lab_myCostTime:setTextById(63834, day, hour, min, sec)
    end

    local myRankTxt
    if not self.myRankData then
        -- if self.isFinishAllTurn then
        --     myRankTxt = TextDataMgr:getText(63841)
        -- else
            myRankTxt = TextDataMgr:getText(63835)
        -- end
        -- if not self.timer then
        --     self.timer = TFDirector:addTimer(1000, -1, nil, function ()
        --         timerCallFunc()
        --     end)
        -- end 
        -- timerCallFunc()
    else
        myRankTxt = self.myRankData.rank == 0 and TextDataMgr:getText(63840) or TextDataMgr:getText(15010043, self.myRankData.rank) 
        -- local day, hour, min, sec = Utils:getTimeDHMZ(self.myRankData.successTime / 1000, true)
        -- self._ui.lab_myCostTime:setTextById(63834, day, hour, min, sec)
        local layer = self.myRankData.layer
        local location = self.myRankData.location
        local curRound = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).roundNum
        if curRound == 1 then
            layer = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).round
            location = self.turnNum
        end
        self._ui.lab_myCostTime:setTextById(800005, layer, location)
    end
    self._ui.lab_myRankTxt:setText(myRankTxt)

    local curTime = ServerDataMgr:getServerTime()
    if self.stopRankTime < curTime and ((self.myRankData and self.myRankData.rank == 0) or not self.myRankData) then
        self._ui.lab_myRankTxt:hide()
    end
    self._ui.lab_outRankTime:setVisible(self.stopRankTime < curTime)
    self._ui.lab_myCostTime:setVisible(self.stopRankTime >= curTime and self.myRankData)
end

function LandTurnTabletRankView:updateCell(cell, idx)
    local data = self.rankData[idx]

    local lab_legaueName = TFDirector:getChildByPath(cell, "lab_legaueName")
    local lab_playerName = TFDirector:getChildByPath(cell, "lab_playerName")
    local lab_cannel = TFDirector:getChildByPath(cell, "lab_cannel")
    local lab_rankTxt = TFDirector:getChildByPath(cell, "lab_rankTxt")
    local img_Icon = TFDirector:getChildByPath(cell, "img_Icon"):hide()

    local stringId = TextDataMgr:getText(63640)
    if data.group == 8 then
        stringId = TextDataMgr:getText(63639)
    elseif data.group == 14 then
        stringId = "内网Dev"
    end

    lab_cannel:setText(stringId)
    lab_playerName:setText(data.playerName)
    lab_rankTxt:setText(data.rank)
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
        lab_rankTxt:setSkewX(15)
        lab_rankTxt:setFontColor(me.WHITE)
    end

    lab_legaueName:setVisible(nil ~= data.unionName)
    if data.unionName then
        lab_legaueName:setText(data.unionName)
    end 

    TFDirector:getChildByPath(cell, "lab_costTime"):setTextById(800005, data.layer, data.location)
    -- local day, hour, min, sec = Utils:getTimeDHMZ(data.successTime / 1000, true)
    -- TFDirector:getChildByPath(cell, "lab_costTime"):setTextById(63834, day, hour, min, sec)
end

function LandTurnTabletRankView:registerEvents()
    self._ui.btn_reward:onClick(function()
        Utils:openView("activity.LandTurnTabletRewardView", self.activityInfo)
    end)

    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)
end

function LandTurnTabletRankView:removeEvents()
	self.super.removeEvents(self)
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil

	end
end

return LandTurnTabletRankView