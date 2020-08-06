--[[黑与白排行榜]]
local BlackAndWhiteRankingView = class("BlackAndWhiteRankingView", BaseLayer)


function BlackAndWhiteRankingView:ctor(...)
    self.super.ctor(self)
	
	self:initData(...)
	self:showPopAnim(true)
    self:init("lua.uiconfig.blackAndWhite.BlackAndWhiteRankingView")

end

function BlackAndWhiteRankingView:initData(data)
	self._rankData = data.rankInfo or {}
end

function BlackAndWhiteRankingView:initUI(ui)
	self.super.initUI(self, ui)
	

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Panel_touch:setSwallowTouch(true)	
	
	self._rankItem = TFDirector:getChildByPath(ui, "Panel_rank_item")
	self._closeBtn = TFDirector:getChildByPath(ui, "Button_close")
	self._panel_rank_item_my = TFDirector:getChildByPath(ui, "Panel_rank_item_my")
	self._label_notranking = TFDirector:getChildByPath(ui, "Label_notranking")
	
	local ScrollView_ranking = TFDirector:getChildByPath(ui, "ScrollView_ranking")
    self._scrollViewRanking = UIListView:create(ScrollView_ranking)
    self._scrollViewRanking:setItemsMargin(2)
	
	self.Label_Tips = TFDirector:getChildByPath(self.ui, "Label_Tips")
	
	self:refreshView()

end

function BlackAndWhiteRankingView:onQueryFriendEvent(friendInfo)
    local view = requireNew("lua.logic.chat.PlayerInfoView"):new(friendInfo)
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function BlackAndWhiteRankingView:registerEvents()
	EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryFriendEvent, self))
	self._closeBtn:onClick(function()
        AlertManager:closeLayer(self)
    end)
	
	    self.Panel_touch:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function BlackAndWhiteRankingView:refreshView()
	--for i = 1, 3 do
	--	local item = self._rankItem:clone()
	--	self._scrollViewRanking:pushBackCustomItem(item)
	--end
	self.Label_Tips:setTextById(14110404)
	for i, v in ipairs(self._rankData) do
		local item = self._rankItem:clone()
		self:updateItem(item,v)
		self._scrollViewRanking:pushBackCustomItem(item)
	end
	
	if nil == self._myRank then
		self._panel_rank_item_my:setVisible(false)
		self._label_notranking:setVisible(true)
	else	
		self._panel_rank_item_my:setVisible(true)
		self._label_notranking:setVisible(false)
		self:updateItem(self._panel_rank_item_my,self._myRank)
	end
end

function BlackAndWhiteRankingView:updateItem(item,data)
	dump(data)
	local Image_rank = TFDirector:getChildByPath(item, "Image_rank")
	local Image_RankIcon = TFDirector:getChildByPath(item, "Image_RankIcon")
	local Label_rank = TFDirector:getChildByPath(item, "Label_rank")

	if data.rank == 1 then
		Label_rank:setVisible(false)
		Image_RankIcon:setVisible(true)
		Image_RankIcon:setTexture("ui/activity/assist/038.png")

		
		Image_rank:setTexture("ui/BlackAndWhite/008.png")
	elseif data.rank == 2 then
		Label_rank:setVisible(false)
		Image_RankIcon:setVisible(true)
		Image_RankIcon:setTexture("ui/activity/assist/039.png")

		
		Image_rank:setTexture("ui/BlackAndWhite/007.png")
	elseif data.rank == 3 then	
		Label_rank:setVisible(false)
		Image_RankIcon:setVisible(true)
		Image_RankIcon:setTexture("ui/activity/assist/040.png")

		
		Image_rank:setTexture("ui/BlackAndWhite/006.png")
	else
		Label_rank:setVisible(true)
		Image_RankIcon:setVisible(false)
		Label_rank:setText(tostring("NO."..data.rank))
		
		Image_rank:setTexture("ui/BlackAndWhite/005.png")
	end
	
	
	
	local Label_time =  TFDirector:getChildByPath(item, "Label_time")
	
	--local m = math.floor(data.costTime / (1000 * 60))
	--local s = math.floor(data.costTime % (1000 * 60) / 1000)
	local _, min, sec = Utils:getTime(math.ceil(data.costTime * 0.001), true)
   Label_time:setTextById(800014, min, sec)
	--Label_time:setText(m .. "'" .. s)
	
	for i = #data.playerInfo + 1, 3 do
		local Image_head = TFDirector:getChildByPath(item, "Image_head" .. i)
		local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name" .. i)
		local Image_Self = TFDirector:getChildByPath(item, "Image_Self" .. i)
		local Image_head_bg = TFDirector:getChildByPath(item, "Image_head_bg" .. i)
		local Image_head_frame = TFDirector:getChildByPath(item, "Image_head_frame" .. i)
		local Image_head_cover_frame = TFDirector:getChildByPath(item, "Image_head_cover_frame" .. i)
		Image_head:hide()
		Label_player_name:hide()
		Image_Self:hide()
		Image_head_bg:hide()
		Image_head_frame:hide()
		Image_head_cover_frame:hide()
	end
	
	for i, v in ipairs(data.playerInfo) do
		
		local Image_head = TFDirector:getChildByPath(item, "Image_head" .. i)
		local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name" .. i)
		local Image_Self = TFDirector:getChildByPath(item, "Image_Self" .. i)


		local frame_path = AvatarDataMgr:getAvatarFrameIconPath(v.portraitFrameCid)
		local Image_head_frame = TFDirector:getChildByPath(item, "Image_head_cover_frame" .. i)
		Image_head_frame:setTexture(frame_path)
		Image_head_frame:setScale(0.5)
		local icon =AvatarDataMgr:getAvatarIconPath(v.headId)
		Image_head:setTextureNormal(icon)
		Image_head:setScale(0.5)
		Image_head:onClick(function()
			MainPlayer:sendPlayerId(v.pid)
		end)
		--print("size" .. size.width .. " y=" .. size.height)
		
		
		Label_player_name:setText(v.pName)
		
		
		Image_Self:setVisible(MainPlayer:getPlayerId() == v.pid)
		
		if MainPlayer:getPlayerId() == v.pid then
			Label_player_name:setColor(me.c3b(0xFF,0xFF,0x00))
			if nil == self._myRank or self._myRank.rank > data.rank then
				self._myRank = data
				
			end
		end
	end
end


return BlackAndWhiteRankingView