--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]

local WsjRankView = class("WsjRankView",BaseLayer)

function WsjRankView:ctor( activityId )
	-- body
	self.super.ctor(self)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.rankeView")
end

function WsjRankView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.title = TFDirector:getChildByPath(ui,"title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.Panel_rank = TFDirector:getChildByPath(ui,"Panel_rank")

	local ScrollView_list = TFDirector:getChildByPath(self.Panel_rank,"ScrollView_list")
	self.tableView_rank = Utils:scrollView2TableView(ScrollView_list)
	self.tableView_rank:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView_rank:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView_rank:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    self.tableView_rank:reloadData()

	self.Panel_selfItem = TFDirector:getChildByPath(self.Panel_rank,"Panel_selfItem"):hide()


	self.Panel_reward = TFDirector:getChildByPath(ui,"Panel_reward")
	local ScrollView_reward = TFDirector:getChildByPath(self.Panel_reward,"ScrollView_reward")
	self.uiList_reward = UIListView:create(ScrollView_reward)

	self.Button_reward = TFDirector:getChildByPath(ui,"Button_reward")
	self.Button_rank = TFDirector:getChildByPath(ui,"Button_rank")


	self.Panel_rank_item = TFDirector:getChildByPath(ui,"Panel_rank_item")
	self.Panel_reward_item = TFDirector:getChildByPath(ui,"Panel_reward_item")


	local tip_rank = TFDirector:getChildByPath(ui,"tip_rank")
	tip_rank:setTextById("r152601")
	local tip_reward = TFDirector:getChildByPath(ui,"tip_reward")
	tip_reward:setTextById("r152602")
	ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityId)
end	

function WsjRankView:tableCellSize(tableView, idx)
	-- body
	local itemSize = self.Panel_rank_item:getContentSize()
	local rankData = self.showRankList[idx + 1]
	if rankData.groupRank == 1 then
		if #rankData.rankPlayerInfo == 1 then
			return itemSize.height,itemSize.width
		else
			return itemSize.height + 87*(#rankData.rankPlayerInfo -1) + 10,itemSize.width
		end
	else
		return  itemSize.height,itemSize.width
	end
end

function WsjRankView:numberOfCells( tableView )
	-- body
	return self.showRankList and #self.showRankList or 0
end

function WsjRankView:tableCellAtIndex(tableView,idx)
	-- body
	local cell = tableView:dequeueCell()
    local item = nil
	if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_rank_item:clone()
		item.idx = idx
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item	
	else
		item = cell.item
    end
    cell.item:setAnchorPoint(ccp(0.5,0.5))
    self:updateRankItem(cell.item,self.showRankList[idx + 1])
    cell.item:setAnchorPoint(ccp(0,0))
    return cell
end

function WsjRankView:registerEvents( ... )
	-- body

    EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, handler(self.updateRankList, self))
    EventMgr:addEventListener(self,EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))
	

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_rank:onClick(function ( ... )
		-- body
		self.Panel_rank:show()
		self.Panel_reward:hide()
		self:refreshRankList()
		self:refreshSelfRankItem()
	end)

	self.Button_reward:onClick(function ( ... )
		-- body
		self.Panel_rank:hide()
		self.Panel_reward:show()
		self:refreshRewardList()
	end)
end

--玩家信息
function WsjRankView:onShowPlayerInfoView(playerInfo)
    if not self.checkingShareHero then
        local PlayerInfoView = require("lua.logic.chat.PlayerInfoView"):new(playerInfo)
        AlertManager:addLayer(PlayerInfoView,AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    else
        HeroDataMgr:changeDataToFriend()
        HeroDataMgr.showid = self.shareHeroId
        Utils:openView("fairyNew.FairyDetailsLayer", {showid=self.shareHeroId, friend=true, fromChatShare = true,friendLv = playerInfo.lvl})
        self.checkingShareHero = false
    end
end

function WsjRankView:removeEvents( ... )
	-- body
end

function WsjRankView:updateRankList(rankData)
	-- body
	if self.activityId ~= rankData.activityId then
		return
	end

	self.rank = rankData.myRank
	self.rankScore = rankData.myScore
	self.myHero = rankData.myHero

	self.showRankList = rankData.ranks or {}
	self:refreshRankList()
	self:refreshSelfRankItem()
end

function WsjRankView:refreshSelfRankItem( ... )
	-- body
	local selfRankData = {rank = self.rank or -1,
			score = self.rankScore or 0,
			groupRank = 0,
			heroId = self.myHero == 0 and 110101 or self.myHero,
			headIcon = self.headIcon or AvatarDataMgr:getCurUsingCid(),
			playerName = MainPlayer:getPlayerName(),
			frameCid = self.frameCid or AvatarDataMgr:getCurUsingFrameCid(),
		}
	self.Panel_selfItem:show()
	self:updateRankItem(self.Panel_selfItem, selfRankData, true)
end

function WsjRankView:refreshRankList( ... )
	-- body
	table.sort( self.showRankList, function ( a,b )
		-- body
		return a.rank < b.rank
	end )
	-- for k,v in ipairs(self.showRankList) do
	-- 	local item = self.uiList_rank:getItem(k)
	-- 	if not item then
	-- 		item = self.Panel_rank_item:clone()
	-- 		self.uiList_rank:pushBackCustomItem(item)
	-- 	end
	-- 	self:updateRankItem(item, v)
	-- end
	self.tableView_rank:reloadData()
end

function WsjRankView:refreshRewardList( ... )
	-- body
	for k,v in ipairs(self.activityInfo.extendData.rewardTaskList) do
		local item = self.uiList_reward:getItem(k)
		if not item then
			item = self.Panel_reward_item:clone()
			self.uiList_reward:pushBackCustomItem(item)
		end
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,v)
		self:updateRewardItem(item, itemInfo)
	end
end

function WsjRankView:updateRankItem( item, data , isSelf)
	local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
	local Image_rank_1 = TFDirector:getChildByPath(item,"Image_rank_1")
	local Image_rank_2 = TFDirector:getChildByPath(item,"Image_rank_2")
	local Image_rank_3 = TFDirector:getChildByPath(item,"Image_rank_3")
	local Label_rank = TFDirector:getChildByPath(item,"Label_rank")

	local Panel_player_1 = TFDirector:getChildByPath(item,"Panel_player_1")
	local Label_time = TFDirector:getChildByPath(item,"Label_time")

	local isSelfRank = self.rank == data.rank

	if not isSelf  then
		if isSelfRank then
			Image_bg:setTexture("ui/activity/activity_2020wsj/tip/001.png")
		else
			Image_bg:setTexture("ui/activity/activity_2020wsj/tip/002.png")
		end
	end

	Image_rank_1:setVisible(data.rank == 1)
	Image_rank_2:setVisible(data.rank == 2)
	Image_rank_3:setVisible(data.rank == 3)
	Label_rank:setVisible(data.rank > 3)
	
	Label_rank:setSkewX(10)
	if data.rank == -1 then
		Image_rank_1:hide()
		Image_rank_2:hide()
		Image_rank_3:hide()
		Label_rank:show()
		Label_rank:setTextById(14240013)
	else
		Label_rank:setText(data.rank)
	end
	if data.score > 0 then
		local mill = data.score%1000
		local sec = math.floor(data.score/1000)%60
		local min = math.floor(math.floor(data.score/1000)/60)%60
		Label_time:setText(string.format("%02d:%02d.%03d",min,sec,mill))
	else
		Label_time:setText("--:--:--")
	end

	item.players = item.players or {Panel_player_1}

	for i,v in ipairs(item.players) do
		v:hide()
	end
	local sizeHeight = 82
	if data.groupRank == 1 then
		local addHeight = 87*(#data.rankPlayerInfo - 1)
		local startPos = addHeight/2
		local offset = 87
		if addHeight > 0 then
			sizeHeight = sizeHeight + addHeight + 10
		end
		for k,v in ipairs(data.rankPlayerInfo) do
			if v.playerId == MainPlayer:getPlayerId() and not isSelf and isSelfRank then -- 刷新个人数据
				self.headIcon = v.headIcon
				self.frameCid = v.frameCid
			end

			local playerInfoItem = item.players[k]
			if not playerInfoItem then
				playerInfoItem = Panel_player_1:clone()
				playerInfoItem:AddTo(Panel_player_1:getParent())
				item.players[k] = playerInfoItem
			end

			playerInfoItem:setPositionY((k-1)*-1*offset + startPos)
			playerInfoItem:show()
			self:updatePlayInfo(playerInfoItem, v)
			
		end
	else
		if not isSelf and data.playerId == MainPlayer:getPlayerId() then
			self.headIcon = data.headIcon
			self.frameCid = data.frameCid
		end

		local playerInfoItem = item.players[1]
		playerInfoItem:show()

		playerInfoItem:setPositionY(0)
		self:updatePlayInfo(playerInfoItem, data)
	end
	item:setContentSize(CCSizeMake(item:getContentSize().width,sizeHeight))
	Image_bg:setContentSize(CCSizeMake(item:getContentSize().width,sizeHeight))
end

function WsjRankView:updatePlayInfo( playerInfoNode, playerInfo )
	-- body
	local head_frame = TFDirector:getChildByPath(playerInfoNode,"head_frame")
	local head_icon = TFDirector:getChildByPath(playerInfoNode,"head_icon")
	local player_name = TFDirector:getChildByPath(playerInfoNode,"player_name")
	local sprite_icon = TFDirector:getChildByPath(playerInfoNode,"sprite_icon")


  	head_icon:setTexture(AvatarDataMgr:getAvatarIconPath(playerInfo.headIcon))
  	local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(playerInfo.frameCid)
	head_frame:setTexture(avatarFrameIcon)
	player_name:setText(playerInfo.playerName)
	if playerInfo.heroId then
		sprite_icon:setTexture(HeroDataMgr:getIconPathById(playerInfo.heroId, 0, true))
	end

	head_icon:setTouchEnabled(true)
	head_icon:onClick(function ( ... )
		-- body
		if playerInfo.playerId and playerInfo.playerId == MainPlayer:getPlayerId() then
            return
        end

        MainPlayer:sendPlayerId(playerInfo.playerId)
	end)
end

function WsjRankView:updateRewardItem( item, data )

	local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
	local Image_rank_1 = TFDirector:getChildByPath(item,"Image_rank_1")
	local Image_rank_2 = TFDirector:getChildByPath(item,"Image_rank_2")
	local Image_rank_3 = TFDirector:getChildByPath(item,"Image_rank_3")
	local Label_rank = TFDirector:getChildByPath(item,"Label_rank")
	local ScrollView_reward = TFDirector:getChildByPath(item,"ScrollView_reward")

	Image_rank_1:setVisible(tonumber(data.details) == 1)
	Image_rank_2:setVisible(tonumber(data.details) == 2)
	Image_rank_3:setVisible(tonumber(data.details) == 3)

	Label_rank:setSkewX(10)
	if #data.details > 2 then
		Label_rank:setVisible(true)
		Label_rank:setText(data.details)
	elseif tonumber(data.details) <= 3 then
		Label_rank:setVisible(false)
	end
	Utils:createRewardListHor(ScrollView_reward,data.reward)
end

return WsjRankView