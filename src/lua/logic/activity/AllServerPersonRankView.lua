--[[
    @desc:全服支援自己社团积分排行
]]
local AllServerPersonRankView = class("AllServerPersonRankView", BaseLayer)

function AllServerPersonRankView:initData()
    self.rankData = {}
    ActivityDataMgr:sendWORLD_HELP_REQ_RANK_INFO(1)
end

function AllServerPersonRankView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.allServerPersonRankView")
end

function AllServerPersonRankView:initUI(ui)
    self.super.initUI(self, ui)
    self.rankView = Utils:scrollView2TableView(self._ui.scrollView)
    self.rankView:hide()
end

function AllServerPersonRankView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    EventMgr:addEventListener(self, EV_ALLSERVER_ASSISTANCE_RANK, handler(self.onRecvRankData,self))
    
    self.rankView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.rankView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.rankView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
end

function AllServerPersonRankView:onRecvRankData(data)
    if data.type == 1 then
        self.rankData = data.rank or {}
        self:refreshTableView()
    end
end

function AllServerPersonRankView:refreshTableView()
    self.rankView:reloadData()
    self.rankView:show()
end

function AllServerPersonRankView:rankCellSize()
    local size = self._ui.Panel_RankItem:getContentSize()
    return size.height, size.width
end

function AllServerPersonRankView:numberOfCells()
    return #self.rankData 
end

function AllServerPersonRankView:tableCellAtIndex(tableView, idx)
    local cell = tableView:dequeueCell()
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.Panel_RankItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshCellItem(item, idx + 1)
    return cell
end

function AllServerPersonRankView:refreshCellItem(item, idx)
    local data = self.rankData[idx]

    local bg = TFDirector:getChildByPath(item, "Image_bg")
    local lab_Rank = TFDirector:getChildByPath(item, "lab_Rank")
    local playerHead = TFDirector:getChildByPath(item, "playerHead")
    local playerHeadFrame = TFDirector:getChildByPath(playerHead, "playerHeadFrame")
    local playerName = TFDirector:getChildByPath(item, "playerName")
    local playerScore = TFDirector:getChildByPath(item, "playerScore")
    playerScore:setSkewX(15)

    bg:setVisible(idx%2 == 0)
    lab_Rank:setText(data.rank)
    playerHead:setTexture(AvatarDataMgr:getAvatarIconPath(data.portraitCid))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.portraitFrameCid == 0 and 10000 or data.portraitFrameCid )
    playerHeadFrame:setTexture(avatarFrameIcon)
    playerName:setText(data.name)
    playerScore:setText(data.score)

end

return AllServerPersonRankView