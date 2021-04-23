local FriendWishView = class("FriendWishView",BaseLayer)

function FriendWishView:ctor( data )
    -- body
    self.super.ctor(self,data)
    self:initData(data)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.NewYear.friendWishView")

end

function FriendWishView:initData( data )

end

function FriendWishView:initUI( ui )
    self.super.initUI(self,ui)

    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    local ScrollView_item = TFDirector:getChildByPath(ui,"ScrollView_item")

    self.TableView_wish = Utils:scrollView2TableView(ScrollView_item)

    self.TableView_wish:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_wish:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_wish:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self.Panel_wish_item = TFDirector:getChildByPath(ui,"Panel_wish_item")

    TFDirector:send(c2s.ACTIVITY2_REQ_SPRING_WITH_TREE_LIST,{})

    self.Button_back = TFDirector:getChildByPath(ui,"Button_back")

end

function FriendWishView:onUpdateInfo()

    self.myInfo,self.friendWish_ = ActivityDataMgr2:getNewYearWishInfo()
    self.TableView_wish:reloadData()

end

function FriendWishView:cellSizeForTable()
    local size = self.Panel_wish_item:getSize()
    return size.height, size.width
end

function FriendWishView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_wish_item:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateWishItem(cell, idx)
    end

    return cell
end

function FriendWishView:numberOfCellsInTableView()
    return #self.friendWish_
end

function FriendWishView:updateWishItem(item, index)

    local wishInfo = self.friendWish_[index]
    if not wishInfo then
        return
    end

    local data = wishInfo.data

    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    local Image_head = TFDirector:getChildByPath(item, "Image_head")
    local Label_wish = TFDirector:getChildByPath(item, "Label_wish")
    local Label_isFriend = TFDirector:getChildByPath(item, "Label_isFriend")
    local Label_isClub = TFDirector:getChildByPath(item, "Label_isClub")
    local Image_head_cover_frame = TFDirector:getChildByPath(item, "Image_head_cover_frame")

    Label_isFriend:setVisible(wishInfo.type == 1)
    Label_isClub:setVisible(wishInfo.type == 2)

    Label_wish:setText(data.context)

    Label_name:setText(data.name)

    local headIcon = data.portraitCid
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    Image_head:setTexture(icon)

    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.portraitFrameCid)
    Image_head_cover_frame:setTexture(avatarFrameIcon)
    local headFrameEffect = Image_head_cover_frame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        Image_head_cover_frame:addChild(headFrameEffect, 1)
    end
    Image_head:setTouchEnabled(true)
    Image_head:onClick(function()
        MainPlayer:sendPlayerId(data.playerId)
    end)

end

function FriendWishView:onQueryInfoEvent(playerInfo)
    Utils:openView("chat.PlayerInfoView", playerInfo)
end

function FriendWishView:registerEvents( )

    EventMgr:addEventListener(self, EV_FRIEND_WISH_LIST, handler(self.onUpdateInfo, self))
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_back:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return FriendWishView