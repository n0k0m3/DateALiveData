local ExploreRankView = class("ExploreRankView", BaseLayer)


function ExploreRankView:ctor(rankList,selRank)
    self.super.ctor(self)
    self:initData(rankList,selRank)
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.exploreRankView")
end

function ExploreRankView:initData(rankList,selRank)
    self.rankList = rankList or {}
    self.selRank = selRank
    self.imageRes = {"ui/explore/rank/02.png","ui/explore/rank/03.png","ui/explore/rank/04.png"}
end

function ExploreRankView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root,"Label_time")
    self.Label_no = TFDirector:getChildByPath(self.Panel_root,"Label_no")
    self.my_rank_item = TFDirector:getChildByPath(self.Panel_root,"my_rank_item")
    self.Button_check = TFDirector:getChildByPath(self.Panel_root,"Button_check")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")
    self.Label_fresh_tip = TFDirector:getChildByPath(self.Panel_root,"Label_fresh_tip")
    self.Label_fresh_tip:setTextById(15010044)

    self.Pannle_prefab = TFDirector:getChildByPath(ui,"Pannle_prefab")
    self.rank_item = TFDirector:getChildByPath(self.Pannle_prefab,"rank_item")

    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_root,"ScrollView_rank")
    self.TableView_rank = Utils:scrollView2TableView(ScrollView_rank)
    Public:bindScrollFun(self.TableView_rank)
    --self.TableView_rank:setDirection(TFTableView.TFSCROLLVERTICAL)
    self.TableView_rank:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_rank:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_rank:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))
    self.TableView_rank:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))

    self.Image_bar_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bar_bg")
    local Image_bar = TFDirector:getChildByPath(self.Image_bar_bg, "Image_bar")
    self.scrollBar = UIScrollBar:create(self.Image_bar_bg, Image_bar)

    self:initUILogic()
end

function ExploreRankView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent = clamp(-contentOffset.y / length, 0, 1)
    self.scrollBar:setPercent(percent)
end

function ExploreRankView:cellSizeForTable()
    local size = self.rank_item:getSize()
    return size.height, size.width
end

function ExploreRankView:numberOfCellsInTableView()
    return #self.rankList
end

function ExploreRankView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.rank_item:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateRankItem(cell.item, self.rankList[idx])
    end

    return cell
end

function ExploreRankView:updateRankItem(item,data)

    if not data then
        return
    end

    local rank = data.rank
    local ranknum = TFDirector:getChildByPath(item,"ranknum")
    if rank == 0 then
        ranknum:setText("暂未上榜")
    else
        ranknum:setText(rank)
    end

    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    if self.imageRes[rank] then
        ranknum:hide()
        Image_bg:setTexture(self.imageRes[rank])
    else
        Image_bg:setTexture("ui/explore/rank/06.png")
        ranknum:show()
    end

    ---头像
    local Image_head = TFDirector:getChildByPath(item,"Image_head")
    Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(data.headId))

    ---头像框
    local frame_cover = TFDirector:getChildByPath(item,"frame_cover")
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.headFrame)
    frame_cover:setTexture(avatarFrameIcon)

    local Lable_name = TFDirector:getChildByPath(item,"Lable_name")
    Lable_name:setText(data.playerName)

    local Lable_Lv = TFDirector:getChildByPath(item,"Lable_Lv")
    Lable_Lv:setText(data.playerLv)

    local Lable_value = TFDirector:getChildByPath(item,"Lable_value")
    Lable_value:setText(data.fightPower)

    local Lable_union = TFDirector:getChildByPath(item,"Lable_union"):hide()
    Lable_union:setText(data.unionName)
    --Lable_union:setVisible(data.unionId ~= 0)

    ---查看其他玩家
    local headIcon = TFDirector:getChildByPath(item,"headIcon")
    headIcon:onClick(function()
        if data.playerId ~= MainPlayer:getPlayerId() then
            MainPlayer:sendPlayerId(data.playerId)
        end
    end)
end

function ExploreRankView:initUILogic()

    self.Label_no:setVisible(#self.rankList <= 0)

    local isOpen = ActivityDataMgr2:isOpen(EC_ActivityType2.EXPLORE)
    if not isOpen then
        self.Label_time:setTextById(1710021)
    else
        local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.EXPLORE)
        local activityInfo = ActivityDataMgr2:getActivityInfo(activityId[1])
        if activityInfo then
            self.Label_time:setText(Utils:getActivityDateString(activityInfo.startTime, activityInfo.endTime, activityInfo.extendData.dateStyle))
        else
            self.Label_time:setText("")
        end
    end

    self.TableView_rank:reloadData()

    local contentOffset = self.TableView_rank:getContentOffset()
    local contentSize   = self.TableView_rank:getContentSize()
    local size          = self.TableView_rank:getSize()
    local length        = contentSize.height - size.height

    local ratio = size.height / contentSize.height
    self.Image_bar_bg:setVisible(ratio < 1)
    self.scrollBar:setRatio(ratio)
    self.scrollBar:setPercent(1)

    local percent = clamp(-contentOffset.y / length, 0, 1)
    self.scrollBar:setPercent(percent)

    self:updateRankItem(self.my_rank_item,self.selRank)
end

function ExploreRankView:onShowPlayerInfoView(playerInfo)
    local PlayerInfoView = require("lua.logic.chat.PlayerInfoView"):new(playerInfo)
    AlertManager:addLayer(PlayerInfoView,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function ExploreRankView:registerEvents()

    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))

    self.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    self.Button_check:onClick(function()
        Utils:openView("explore.ExploreRankAwardView")
    end)

end

return ExploreRankView
