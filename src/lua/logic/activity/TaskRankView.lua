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
local TaskRankView = class("TaskRankView",BaseLayer)

function TaskRankView:ctor( activityId )
	-- body
	self.super.ctor(self)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.taskActivityRankView")
end

function TaskRankView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_empty_tip = TFDirector:getChildByPath(ui,"Label_empty_tip")
	

	local ScrollView_rank = TFDirector:getChildByPath(ui,"ScrollView_rank")
	self.tableView_rank = Utils:scrollView2TableView(ScrollView_rank)
	self.tableView_rank:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView_rank:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
	self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView_rank:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    self.tableView_rank:reloadData()

	self.Panel_rank_item = TFDirector:getChildByPath(ui,"Panel_rank")

	self.Label_rank = TFDirector:getChildByPath(ui,"Label_rank")
	self.Label_value = TFDirector:getChildByPath(ui,"Label_value")

	self.Label_rank:setTextById(14240013)
	self.Label_value:setText(0)


	ActivityDataMgr2:SEND_ACTIVITY_REQ_CROSS_SUPPORT_INFO()
end	

function TaskRankView:tableCellSize(tableView, idx)
	-- body
	local itemSize = self.Panel_rank_item:getContentSize()

	return  itemSize.height+2,itemSize.width
end

function TaskRankView:numberOfCells( tableView )
	-- body
	return self.showRankList and #self.showRankList or 0
end

function TaskRankView:tableCellAtIndex(tableView,idx)
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

function TaskRankView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_CROSS_SUPPORT_INFO, handler(self.updateRankList, self))
	

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

end


function TaskRankView:removeEvents( ... )
	-- body
end

function TaskRankView:updateRankList(rankData)
	-- body
	self.showRankList = rankData.info or {}
	for k,v in pairs(self.showRankList) do
		local isSelfRank = v.playerId == MainPlayer:getPlayerId()
		if isSelfRank then -- 根据排行数据刷新自己数据
			self.Label_rank:setText(v.rank)
		end
	end
	self.Label_value:setText(rankData.myScore)
	self:refreshRankList()
end


function TaskRankView:refreshRankList( ... )
	-- body
	table.sort( self.showRankList, function ( a,b )
		-- body
		return a.rank < b.rank
	end )
	self.Label_empty_tip:setVisible(#self.showRankList <= 0)
	self.tableView_rank:reloadData()
end

function TaskRankView:getRankReward( rank )
	-- body
	for k,v in ipairs(self.activityInfo.extendData.reward) do
		if v.rank[1] <= rank and v.rank[2] >= rank then
			return v.list
		end
	end
	return {}
end

function TaskRankView:updateRankItem( _item, data)
	local isSelfRank = data.playerId == MainPlayer:getPlayerId()
	local Panel_other = TFDirector:getChildByPath(_item,"Panel_other"):hide()
	local Panel_self = TFDirector:getChildByPath(_item,"Panel_self"):hide()

	local item = isSelfRank and Panel_self or Panel_other
	item:show()

	local Image_rank_1 = TFDirector:getChildByPath(item,"Image_rank_1")
	local Image_rank_2 = TFDirector:getChildByPath(item,"Image_rank_2")
	local Image_rank_3 = TFDirector:getChildByPath(item,"Image_rank_3")
	local Label_rank = TFDirector:getChildByPath(item,"Label_rank")

	local Panel_player_1 = TFDirector:getChildByPath(item,"Panel_player_1")
	local Label_value = TFDirector:getChildByPath(item,"Label_value")
	local ScrollView_reward = TFDirector:getChildByPath(item,"ScrollView_reward")


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

	Label_value:setText(data.score)
	self:updatePlayInfo(Panel_player_1, data)

	local reward = self:getRankReward(data.rank)
	Utils:createRewardListHor(ScrollView_reward,reward)
end

function TaskRankView:updatePlayInfo( playerInfoNode, playerInfo )
	-- body
	local head_frame = TFDirector:getChildByPath(playerInfoNode,"head_frame")
	local head_icon = TFDirector:getChildByPath(playerInfoNode,"head_icon")
	local player_name = TFDirector:getChildByPath(playerInfoNode,"player_name")
	local union_name = TFDirector:getChildByPath(playerInfoNode,"union_name")
	local server_name = TFDirector:getChildByPath(playerInfoNode,"server_name")


  	head_icon:setTexture(AvatarDataMgr:getAvatarIconPath(playerInfo.headId))
  	local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(playerInfo.headFrameId)
	head_frame:setTexture(avatarFrameIcon)

	player_name:setText(playerInfo.name)
	union_name:setText(playerInfo.unionName)
	server_name:setTextById(Utils:getKVP(49004,"ChannelIdList")[playerInfo.serverId])
end

return TaskRankView