local RankNoticeView = class("RankNoticeView" , BaseLayer)

local RANK_LABEL = {110000101 , 110000102  ,110000103 ,110000104 ,111000017 ,111000019,111000018 , --[[111000042]]}  --等级  充值  无尽 战力 副本 图鉴 社团 灵力回响 文本内容
local RANK_TITLE_LABEL = {190000294 , 190000295 , 190000296 , 190000297 ,190000298 ,190000299 ,190000300}  --标签页标题
local RANK_Texture = {  --tab图片路径
	"ui/mainLayer/rank_notice/img_level.png",
	"ui/mainLayer/rank_notice/img_recharge.png",
	"ui/mainLayer/rank_notice/img_endless.png",
	"ui/mainLayer/rank_notice/img_battle.png",
	"ui/mainLayer/rank_notice/img_fubenStar.png",
	"ui/mainLayer/rank_notice/img_collect.png",
	"ui/mainLayer/rank_notice/img_league.png",
	"ui/mainLayer/new_ui/btn_soulEcho.png",
	
	}

function RankNoticeView:ctor(data )
	self.super.ctor(self, data)
	self:init("lua.uiconfig.MainScene.RankNoticeView")
end

function RankNoticeView:initUI(ui)
	self:showTopBar()
	self.super.initUI(self,ui)


	self.showRankIndex = 0
	self.battleRate = Utils:getPowerRate()
	self:restData()
	local panel_prefab = TFDirector:getChildByPath(ui , "Panel_prefab")
    self.itemDemo_rank = TFDirector:getChildByPath(panel_prefab , "Panel_rankItem")


	self:initBtnTab(ui)
	self:initTopPanel(ui)
	self:initMyRankInfo(ui)
	self:initRankTableView(ui)
	--self:initRankListView(ui)   --屏蔽listview 方法 使用上面tableview


	self:selectTabBtn(1)   --默认第一个标签

	self:refreshUI()
end

function RankNoticeView:restData()
	self.rankList = {}
	self.myRank = nil
end

function RankNoticeView:initBtnTab(ui )
	local panel_right = TFDirector:getChildByPath(ui , "Panel_right")

	self.ScrollView_tab = UIListView:create(TFDirector:getChildByPath(panel_right, "ScrollView_RankNoticeView_1"))
    self.ScrollView_tab:setItemsMargin(1)

    local panel_prefab = TFDirector:getChildByPath(ui , "Panel_prefab")
	self.Panel_tabItme = TFDirector:getChildByPath(panel_prefab , "Panel_tabItme")

	self.tabBtn_list = {}
	for i=1,#RANK_TITLE_LABEL do
		if i ~= 2 then  --屏蔽充值排行
			local item = self.Panel_tabItme:clone()
			item:getChildByName("Image_icon"):setTexture(RANK_Texture[i])
			item:getChildByName("Label_name"):setTextById(RANK_TITLE_LABEL[i])
			item:getChildByName("Image_touch"):onClick(function ( ... )
				self:selectTabBtn(i)
			end)

			self.ScrollView_tab:pushBackCustomItem(item)
			table.insert(self.tabBtn_list , item)
			item.id = i
		end
		
	end

end

function RankNoticeView:initMyRankInfo(ui)
	self.panel_my_rank = TFDirector:getChildByPath(ui , "Panel_my_rank")
	self.panel_my_rank.label_rank = TFDirector:getChildByPath(self.panel_my_rank , "label_rank")
	self.panel_my_rank.label_no_rank = TFDirector:getChildByPath(self.panel_my_rank , "label_no_rank")
	self.panel_my_rank.label_my_rank = TFDirector:getChildByPath(self.panel_my_rank , "label_my_rank")
	self.panel_my_rank.label_my_rank:setTextById(190000293)
	self.panel_my_rank.label_no_rank:setTextById(263009)
end

function RankNoticeView:updateMyRankInfo()
	if self.myRank and self.myRank.rank ~= 0 then
		self.panel_my_rank.label_rank:setVisible(true)
		self.panel_my_rank.label_no_rank:setVisible(false)
		self.panel_my_rank.label_rank:setText(self.myRank.rank)
	else
		self.panel_my_rank.label_rank:setVisible(false)
		self.panel_my_rank.label_no_rank:setVisible(true)
	end
end

function RankNoticeView:selectTabBtn( id )
	if self.showRankIndex == id then return end
	for k ,v in pairs(self.tabBtn_list) do
		if v.id == id then
			v:getChildByName("Image_select"):setVisible(true)
			self.showRankIndex = id
		else
			v:getChildByName("Image_select"):setVisible(false)
		end
	end
	self:restData()
	---更新页面内容
	ActivityDataMgr:sendGetRankByTypeReq(self.showRankIndex)
end

function RankNoticeView:initTopPanel(ui )
	local Panel_top = TFDirector:getChildByPath(ui , "Panel_top")
	self.panel_rank_top = {}
	for i=1,3 do
		self.panel_rank_top[i]  = TFDirector:getChildByPath(Panel_top , "Panel_rank_"..i)
		local panel_root = self.panel_rank_top[i]
		self.panel_rank_top[i].imagePaint = TFDirector:getChildByPath(panel_root , "panel_paint")
		self.panel_rank_top[i].buttonDetail = TFDirector:getChildByPath(panel_root , "Button_detail")
		self.panel_rank_top[i].labelPlayerName = TFDirector:getChildByPath(panel_root , "Label_player_name")
		self.panel_rank_top[i].labelValue = TFDirector:getChildByPath(panel_root , "Label_rank_value")
		self.panel_rank_top[i].imageNone = TFDirector:getChildByPath(panel_root , "Image_none")

		self.panel_rank_top[i].buttonDetail.idx = i
		self.panel_rank_top[i].buttonDetail:onClick(function ( sender )
			local idx = sender.idx  --查看前三详情
			self:showRankDetail(idx)
		end)
	end
end

function RankNoticeView:initRankTableView( ui )
	self.panel_bottom = TFDirector:getChildByPath(ui , "Panel_bottom")
	self.panel_list_rank = TFDirector:getChildByPath(self.panel_bottom , "Panel_rank_scroll")

	self.tableView_rank = TFTableView:create()
    self.tableView_rank:setTableViewSize(self.panel_list_rank:getContentSize())
    self.tableView_rank:setDirection(TFTableView.TFSCROLLVERTICAL)
    self.tableView_rank:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

    self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEFORINDEX, self.cellSizeForTable_rank)
    self.tableView_rank:addMEListener(TFTABLEVIEW_SIZEATINDEX, self.tableCellAtIndex_rank)
    self.tableView_rank:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, self.numberOfCellsInTableView_rank)

    self.tableView_rank.logic = self
    self.panel_list_rank:addChild(self.tableView_rank)

    

    self.itemSize_rank = self.itemDemo_rank:getContentSize()
end

--此处为listview代码段-----------------------------------------------start

-- function RankNoticeView:initRankListView( ui )
-- 	self.rankItems_ = {}
-- 	local panel_bottom = TFDirector:getChildByPath(ui , "Panel_bottom")
-- 	local Image_rankBar = TFDirector:getChildByPath(panel_bottom, "Image_rankBar")
--     local Image_rankScrollBar = TFDirector:getChildByPath(Image_rankBar, "Image_rankScrollBar")
--     local scrollBar = UIScrollBar:create(Image_rankBar, Image_rankScrollBar)
--     local Scroll_rank = TFDirector:getChildByPath(panel_bottom, "Scroll_rank")
--     self.ListView_rank = UIListView:create(Scroll_rank)
--     self.ListView_rank:setScrollBar(scrollBar)

--     self:showRankListView()
-- end
-- function RankNoticeView:addRankListItem()
--     local itemDemo_rank = self.itemDemo_rank:clone()
--     local item = {}
--     item.root = itemDemo_rank
--     item.Label_rank = TFDirector:getChildByPath( item.root, "Label_rank_select")
--     item.Button_detail = TFDirector:getChildByPath(item.root , "Button_detail")
--     self.rankItems_[item.root] = item
--     return itemDemo_rank
-- end
-- function RankNoticeView:showRankListView()

--     local items = self.ListView_rank:getItems()
--     local gap = 1197 - #items
--     if gap > 0 then
--         for i = 1, math.abs(gap) do
--             local itemDemo_rank = self:addRankListItem()
--             self.ListView_rank:pushBackCustomItem(itemDemo_rank)
--         end
--     else
--         for i = 1, math.abs(gap) do
--             self.ListView_rank:removeItem(1)
--         end
--     end

--     local items = self.ListView_rank:getItems()
--     for i, v in ipairs(items) do
--         local item = self.rankItems_[v]
--         item.Label_rank:setText(i + 3)
--         item.Button_detail:onClick(function ( ... )
--         	local idx = i + 3
--         	print("click button detail " , idx)
--         end)
--     end
   
-- end

--此处为listview代码段------------------------------------------end


function RankNoticeView:onShow( ... )
	self.super.onShow(self)
end

function RankNoticeView.cellSizeForTable_rank(table, idx)
	local self = table.logic
	return self.itemSize_rank.height, self.itemSize_rank.width
end

function RankNoticeView.tableCellAtIndex_rank(table, idx)
	local cell = table:dequeueCell()
    local self = table.logic

    if nil == cell then
        cell = TFTableViewCell:create()
		local itemCell = self.itemDemo_rank:clone()
		itemCell:setVisible(true)
		itemCell:setPosition(ccp(self.itemSize_rank.width /2, self.itemSize_rank.height / 2))
		itemCell.buttonDetail  = TFDirector:getChildByPath(itemCell , "Button_detail")
		itemCell.buttonDetail:onClick(function (sender)
			self:showRankDetail(sender.idx)
		end)
		cell.itemCell = itemCell
		cell:addChild(itemCell)
    end

    self:updateItem_rank(cell.itemCell, idx + 1)

    return cell
end

function RankNoticeView:updateItem_rank( itemCell , idx )
	local actualRankIdx = idx + 3
	local Label_rank_select = TFDirector:getChildByPath(itemCell , "Label_rank_select")
	Label_rank_select:setText(actualRankIdx)

	local image_icon = TFDirector:getChildByPath(itemCell , "Image_icon")
	local image_icon_frame = TFDirector:getChildByPath(itemCell , "Image_icon_frame")
	local Label_player_name = TFDirector:getChildByPath(itemCell , "Label_player_name")
	local label_value = TFDirector:getChildByPath(itemCell , "Label_desc")
	local Button_detail = TFDirector:getChildByPath(itemCell , "Button_detail")
	Button_detail.idx = actualRankIdx

	local rankInfo = self.rankList[actualRankIdx]
	if rankInfo then
		if self.myRank and rankInfo.pid == self.myRank.pid then
			Button_detail:setVisible(false)
		else
			Button_detail:setVisible(true)
		end
    	if self.showRankIndex == 7 then   --如果是社团排行
	    	local emblemCfg = LeagueDataMgr:getEmblemCfgById(rankInfo.uninIcon or 101)
	    	image_icon:setTexture(emblemCfg.icon)

    		label_value:setColor(ccc3(69 ,102 , 170))
	    	Label_player_name:setColor(ccc3(69 ,102 , 170))
	    	label_value:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params)
	    	Label_player_name:setText(rankInfo.unionName)
	    	image_icon:setScale(0.6)
	    	image_icon_frame:setVisible(false)
    	else --通用排行数据
    		image_icon:setTexture(AvatarDataMgr:getAvatarIconPath(rankInfo.headId))

            local avatarFrameIcon,avatarFrameEffect = nil, nil
			if rankInfo.frameId == 0 or rankInfo.frameId == nil then  --设置默认头像框
                avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(10000)
				--image_icon_frame:setTexture(AvatarDataMgr:getAvatarFrameIconPath(10000))
			else
				--image_icon_frame:setTexture(AvatarDataMgr:getAvatarFrameIconPath(rankInfo.frameId))
                avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(rankInfo.frameId)
			end
            if avatarFrameIcon and avatarFrameIcon ~= "" then
                image_icon_frame:setTexture(avatarFrameIcon)
            end
            image_icon_frame:setVisible(true)

            if avatarFrameEffect and avatarFrameEffect ~= "" then
                if itemCell.HeadFrameEffect then
                    itemCell.HeadFrameEffect:removeFromParent()
                    itemCell.HeadFrameEffect = nil
                end
                if not itemCell.HeadFrameEffect then
                    itemCell.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
                    itemCell.HeadFrameEffect:setAnchorPoint(ccp(0,0))
                    itemCell.HeadFrameEffect:setPosition(ccp(0,0))
                    itemCell.HeadFrameEffect:play("animation", true)
                    image_icon_frame:addChild(itemCell.HeadFrameEffect, 1)
                end
            else
                if itemCell.HeadFrameEffect then
                    itemCell.HeadFrameEffect:removeFromParent()
                    itemCell.HeadFrameEffect = nil
                end
            end

    		label_value:setColor(ccc3(69 ,102 , 170))
	    	Label_player_name:setColor(ccc3(69 ,102 , 170))
	    	if self.showRankIndex ==4 then
	    		label_value:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params*self.battleRate)
	    	elseif self.showRankIndex == 2 then --
	    		label_value:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params/100)
	    	else
	    		label_value:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params)
	    	end
	    	
	        local name ,_ = TFGlobalUtils:checkPlayerProvision(rankInfo.pName)	
	    	Label_player_name:setText(name)
	    	image_icon:setScale(0.7)
    	end
	else---没有数据的时候默认显示虚位以待
		image_icon:setTexture("ui/mainLayer/rank_notice/img_6.png")
		image_icon_frame:setVisible(false)
		image_icon:setScale(1)

		label_value:setColor(ccc3(113 ,117 , 129))
    	Label_player_name:setColor(ccc3(113 ,117 , 129))

    	label_value:setTextById(RANK_LABEL[self.showRankIndex] , "" )
    	Label_player_name:setTextById(110000105)
    	Button_detail:setVisible(false)
	end
	

	
end

function RankNoticeView.numberOfCellsInTableView_rank(table)
	local self = table.logic
	local len = #self.rankList - 3
	if len < 5 then
		return 5 
	else
		return len
	end
end

function RankNoticeView:updateTopPanel()
	for k , v in pairs(self.panel_rank_top) do
		if self.rankList[k] then
			local rankInfo = self.rankList[k] 
			if self.myRank and rankInfo.pid == self.myRank.pid then
				v.buttonDetail:setVisible(false)
			else
				v.buttonDetail:setVisible(true)
			end
			if self.showRankIndex == 7 then
				v.labelPlayerName:setText(rankInfo.unionName)
			else
				local name ,_ = TFGlobalUtils:checkPlayerProvision(rankInfo.pName)
				v.labelPlayerName:setText(name)
			end
			

	    	if self.showRankIndex ==4 then
	    		v.labelValue:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params*self.battleRate)
	    	elseif self.showRankIndex == 2 then
	    		v.labelValue:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params/100)
	    	else
	    		v.labelValue:setTextById(RANK_LABEL[self.showRankIndex] , rankInfo.params)
	    	end

			v.labelValue:setVisible(true)
			
			local anim_hero = Utils:createTeamHeroModel(rankInfo.heroId, v.imagePaint,rankInfo.skinCid)

			anim_hero:setScale(0.5)

			v.imageNone:setVisible(false)
			v.imagePaint:setVisible(true)
			--v.buttonDetail:setVisible(true)
		else  --当前三排行没有数据

			v.imageNone:setVisible(true)
			v.labelValue:setVisible(false)
			v.buttonDetail:setVisible(false)
			v.imagePaint:setVisible(false)

			v.labelPlayerName:setTextById(110000105)
		end
		
	end
end

function RankNoticeView:showRankDetail( idx )   --显示详情界面
	if self.showRankIndex == 7 then  --如果是查看社团
		LeagueDataMgr:SearchUnion(self.rankList[idx].unionId)
	else  --查看玩家信息
		MainPlayer:sendPlayerId(tonumber(self.rankList[idx].pid))
	end
	
end

function RankNoticeView:registerEvents( ... )
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_RANK_NOTICE_UPDATE, handler(self.onRecvRankList, self))
	EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryFriendEvent, self))
	EventMgr:addEventListener(self, EV_UNION_SEARCH_UNION, handler(self.onSearchUnionBack, self))
end

function RankNoticeView:refreshUI()
	self.tableView_rank:reloadData()
	self.tableView_rank:setScrollToBegin()
	self:updateTopPanel()
	self:updateMyRankInfo()
end

--显示社团详情
function RankNoticeView:onSearchUnionBack( data )
	if self.showRankIndex == 7 then
		 Utils:openView("league.LeagueSnapInfoView", data.union)
	end
	
end


function RankNoticeView:onRecvRankList( data )
	self.rankList = data.rankList or {}
	self.myRank = data.selfRank


	self:refreshUI()
end
function RankNoticeView:removeEvents( ... )
	self.super.removeEvents(self)

end

function RankNoticeView:onQueryFriendEvent(friendInfo)
    local view = requireNew("lua.logic.chat.PlayerInfoView"):new(friendInfo)
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

return RankNoticeView