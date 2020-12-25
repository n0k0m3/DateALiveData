--[[
    @descï¼šWorldBossPersonHurtView
]]

local WorldBossPersonHurtView = class("WorldBossPersonHurtView",BaseLayer)

function WorldBossPersonHurtView:initData(data, sumHurtNum)
    self.data = data
    self.sumHurtNum = sumHurtNum
    local levelCfg = FubenDataMgr:getLevelCfg(LeagueDataMgr:getCurInvade().dungeonLevelId)
    self.fightCount = levelCfg.fightCount
end

function WorldBossPersonHurtView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.worldBossPersonHurtView")
end

function WorldBossPersonHurtView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.noData:setVisible(#self.data == 0)

    self.scrollBar = UIScrollBar:create(self._ui.Image_shieldingScrollBar, self._ui.Image_scrollBarInner)

    self.tableView = Utils:scrollView2TableView(self._ui.ScrollView_members)
    self.tableView:onNumberOfCells(function()
        return table.count(self.data)
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
    self.tableView:reloadData()

    local innerSize = self.tableView:getContentSize()
    local size      = self.tableView:getSize()
    local ratio     = size.height / innerSize.height
    ratio = ratio <= 1 and ratio or 1
    self.scrollBar:setRatio(ratio)
    self.scrollBar:setPercent(1)

    self._ui.lab_joinPersonNum:setText(table.count(self.data).."/"..LeagueDataMgr:getUnionMaxMemberCount())
    self._ui.lab_sumHurt:setText(Utils:converNumWithComma(self.sumHurtNum))
end

function WorldBossPersonHurtView:updateCell(item, idx)
    local data = self.data[idx]
    local lab_rankNum = item:getChildByName("lab_rankNum")
    local lab_leagueHurtNum = item:getChildByName("lab_leagueHurtNum")
    local Image_icon = item:getChildByName("Image_icon")
    local Image_icon_cover_frame = item:getChildByName("Image_icon_cover_frame")
    local Label_name = item:getChildByName("Label_name")
    local Label_recentLogin = item:getChildByName("Label_recentLogin")
    local Label_power = item:getChildByName("Label_power")
    local lab_times = item:getChildByName("lab_times")
    local Label_level = item:getChildByName("Label_level")
    lab_rankNum:setSkewX(15)
    lab_rankNum:setText(data.rank)
    if data.rank == 1 then
        lab_rankNum:setFontColor(ccc3(236,214,124))
    elseif data.rank == 2 then
        lab_rankNum:setFontColor(ccc3(194,238,242))
    elseif data.rank == 2 then
        lab_rankNum:setFontColor(ccc3(247,174,121))
    else
        lab_rankNum:setFontColor(ccc3(255,255,255))
    end
    
    lab_leagueHurtNum:setSkewX(15)
    lab_leagueHurtNum:setText(Utils:converNumWithComma(data.damage))
    local icon = AvatarDataMgr:getAvatarIconPath(data.portraitCid)

    Image_icon:setTexture(icon)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.portraitFrameCid == 0 and 10000 or data.portraitFrameCid)
    Image_icon_cover_frame:setTexture(avatarFrameIcon)
    local headFrameEffect = Image_icon_cover_frame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        Image_icon_cover_frame:addChild(headFrameEffect, 1)
    end

    Label_name:setText(data.name)
    Label_level:setTextById(800006, data.lvl)
    if data.online then
        Label_recentLogin:setTextById(700037)
    else
        local nowDate = Utils:getUTCDate(ServerDataMgr:getServerTime())
        local lastLoginDate = Utils:getUTCDate(data.lastLoginTime / 1000)
        local diffDate = TFDate.diff(nowDate, lastLoginDate)
        local day = diffDate:spandays()
        local hour = diffDate:spanhours()
        local min = diffDate:spanminutes()
        if day >= 1 then
            Label_recentLogin:setTextById(16000306, math.floor(day))
        elseif hour >= 1 then
            Label_recentLogin:setTextById(16000307, math.floor(hour))
    else
            Label_recentLogin:setTextById(16000308, math.max(1, math.floor(min)))
        end
    end
    Label_power:setText(data.fightPower)
    lab_times:setText(data.count.."/"..self.fightCount)
end

function WorldBossPersonHurtView:registerEvents()

    self.tableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))


    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)
end

function WorldBossPersonHurtView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = -contentOffset.y/length
    percent = percent <= 1 and percent or 1
    percent = percent < 0 and 0 or percent
    self.scrollBar:setPercent(percent)
end

return WorldBossPersonHurtView