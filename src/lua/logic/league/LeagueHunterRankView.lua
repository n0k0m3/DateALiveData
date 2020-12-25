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
* -- 追猎计划排行
]]
local LeagueHunterRankingView = class("LeagueHunterRankingView",BaseLayer)

--排名图标
local RankImages =
{
	"ui/activity/assist/038.png",
	"ui/activity/assist/039.png",
	"ui/activity/assist/040.png",
}

function LeagueHunterRankingView:ctor( data )
	self.super.ctor(self,data)
	self.chooseIndex = 1
	self:initData()
   	self:showPopAnim(true)
	self:init("lua.uiconfig.league.leagueHunterRankingView")
end

function LeagueHunterRankingView:initData(  )
	local data           = LeagueDataMgr.huntingRankList
	self.honerList       = data.damages or {} -- 社团伤害排行
	self.playerHonerList = data.honors  or {} -- 玩家贡献列表
	self.selfHoner       = data.selfDamage -- 自己社团伤害数据
	self.selfPlayerHoner = data.selfHonor  -- 自己玩家贡献数据
	local function sortFunc(obj1,obj2)
		return obj1.rank < obj2.rank
	end
	table.sort( self.honerList, sortFunc )
	table.sort( self.playerHonerList, sortFunc )
end

function LeagueHunterRankingView:initUI( ui )
	self.super.initUI(self,ui)
	local Panel_top     = TFDirector:getChildByPath(ui,"Panel_top")
	local Label_honer     = TFDirector:getChildByPath(ui,"Label_honer")
	local Label_league  = TFDirector:getChildByPath(ui,"Label_league")
	self.Label_nullList   = TFDirector:getChildByPath(ui,"Label_nullList")
	Label_honer:setTextById(3300030)
	Label_league:setTextById(3300031)
	self.Label_nullList:setTextById(3300034)
	self.panel_player   = TFDirector:getChildByPath(Panel_top,"panel_player")

    self.image_line3 = TFDirector:getChildByPath(ui,"image_line3")

	local panel_playerTitles ={}
	for i = 1 , 4 do
		panel_playerTitles[i] = TFDirector:getChildByPath(self.panel_player,"Label_title"..i)
	end
	panel_playerTitles[3]:setTextById(3300026) 
	self.panel_league   = TFDirector:getChildByPath(Panel_top,"panel_league")
	-- self.ScrollView_items = TFDirector:getChildByPath(ui,"ScrollView_items")
	-- self.uilistView     = UIListView:create(self.ScrollView_items)
	-- self.uilistView:setItemsMargin(4)

	local panel_ScrollView = TFDirector:getChildByPath(ui,"panel_ScrollView")

	self.listView = TFTableView:create()
    self.listView:setTableViewSize(panel_ScrollView:getContentSize())
    self.listView:setDirection(TFTableView.TFSCROLLVERTICAL)
    --列表设置为从小到大显示，及idx从0开始
    self.listView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

	self.listView:onNumberOfCells(handler(self.tableNumberOfCells,self))
	self.listView:onCellSize(handler(self.tableSizeOfCell,self))
	self.listView:onCellAtIndex(handler(self.tableCellAtIndex,self))
    panel_ScrollView:addChild(self.listView,200)
    self.listView.logic = self

	self.Button_close   = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_honer   = TFDirector:getChildByPath(ui,"Button_honer")
	self.Button_league  = TFDirector:getChildByPath(ui,"Button_league")


	self.Panel_honer_self_Item       = TFDirector:getChildByPath(ui,"Panel_honer_self_Item")
	self.Panel_playerHoner_self_Item = TFDirector:getChildByPath(ui,"Panel_playerHoner_self_Item")
	self.Panel_honer_Item            = TFDirector:getChildByPath(ui,"Panel_honer_Item")
	self.Panel_playerHoner_Item      = TFDirector:getChildByPath(ui,"Panel_playerHoner_Item")


	--自己的社团信息
	self.Panel_honer_self_Item.league_name  = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"league_name")
	self.Panel_honer_self_Item.league_lv    = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"league_lv")
	self.Panel_honer_self_Item.image_rank   = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"image_rank")
	self.Panel_honer_self_Item.label_rank   = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"label_rank")
	self.Panel_honer_self_Item.boss_lv      = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"boss_lv") --
	self.Panel_honer_self_Item.hurt_per     = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"hurt_per")
	self.Panel_honer_self_Item.image_boss   = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"image_boss")
	self.Panel_honer_self_Item.label_tip    = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"label_tip")
	self.Panel_honer_self_Item.label_noRank = TFDirector:getChildByPath(self.Panel_honer_self_Item ,"label_noRank")

	--角色信息
	self.Panel_playerHoner_self_Item.image_rank   = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"image_rank")
	self.Panel_playerHoner_self_Item.label_rank   = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"label_rank")
	self.Panel_playerHoner_self_Item.player_name  = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"player_name")
	self.Panel_playerHoner_self_Item.player_lv    = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"player_lv")
	self.Panel_playerHoner_self_Item.count        = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"count")
	self.Panel_playerHoner_self_Item.honor        = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"honor") --
	self.Panel_playerHoner_self_Item.image_boss   = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"image_boss")
	self.Panel_playerHoner_self_Item.label_tip    = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"label_tip")
	self.Panel_playerHoner_self_Item.label_noRank = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"label_noRank")
	self.Panel_playerHoner_self_Item.hurtvalue    = TFDirector:getChildByPath(self.Panel_playerHoner_self_Item ,"hurtvalue")



	self.tabs = {}
	self.tabs[1]           = self.Button_honer
	self.tabs[2]           = self.Button_league
	self:setSelect(1,true)
end

function LeagueHunterRankingView:tableNumberOfCells( table )
	local num = 0
	if self.chooseIndex == 1 then
		num = #self.playerHonerList

	else
		num = #self.honerList
	end

	return num
end

function LeagueHunterRankingView:tableSizeOfCell( table ,idx)
	local size = self.curCellItem:getContentSize() 
	return size.height+5,size.width
end

function LeagueHunterRankingView:tableCellAtIndex( table ,idx )
	local cell = table:dequeueCell()
   	if nil == cell or not table.cells[cell] then
	  	table.cells = table.cells or {}
        cell = TFTableViewCell:create()
        local parentNode = self.curCellItem:clone()
   		parentNode:setVisible(true)
   		parentNode:setAnchorPoint(ccp(0,0))
   		parentNode:setPosition(ccp(0,0))
	    cell:addChild(parentNode)
	    cell.node = parentNode
		table.cells[cell] = true
    end

    local item = cell.node
	if self.chooseIndex == 1 then
		self:updatePlayerHonerItem(item,self.playerHonerList[idx + 1])

	else
		self:updateHonerItem(item,self.honerList[idx + 1])
	end
    return cell
end

--  15:03:55]  - "<var>" = {
-- [LUA-print] [06/18/19 15:03:55]  -     "selfDamage" = {
-- [LUA-print] [06/18/19 15:03:55]  -         "bossLv"    = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "dmgRate"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "rank"      = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionId"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionLv"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionName" = ""
-- [LUA-print] [06/18/19 15:03:55]  -     }
-- [LUA-print] [06/18/19 15:03:55]  -     "selfHonor" = {
-- [LUA-print] [06/18/19 15:03:55]  -         "fightCount" = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "honor"      = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "playerId"   = 539556324
-- [LUA-print] [06/18/19 15:03:55]  -         "playerLv"   = 66
-- [LUA-print] [06/18/19 15:03:55]  -         "playerName" = ""
-- [LUA-print] [06/18/19 15:03:55]  -         "rank"       = 0
-- [LUA-print] [06/18/19 15:03:55]  -     }
-- [LUA-print] [06/18/19 15:03:55]  - }



-- if isOwn then
--         local icon = AvatarDataMgr:getSelfAvatarIconPath()
--         Image_icon:setTexture(icon)
--     else
--         local headIcon = data.headId
--         if headIcon == 0 then
--             headIcon = 101
--         end
--         local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
--         Image_icon:setTexture(icon)

--         if data.pid ~= MainPlayer:getPlayerId() then
--             Image_icon:onClick(function()
--                     MainPlayer:sendPlayerId(data.pid)
--             end)
--         end
--     end


 local function setHeadTexture(imageHead ,data)
 	local headId = data.headId
    if not headId or headId == 0 then
        headId = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headId)
    imageHead:setTexture(icon)
    -- imageHead:setSize(me.size(64,64))
    --TODO 查看功能是否需要
    -- if data.playerId ~= MainPlayer:getPlayerId() then
    --     imageHead:onClick(function()
    --             MainPlayer:sendPlayerId(data.pid)
    --     end)
    -- end
end



  -- "selfDamage" = {
-- [LUA-print] [06/18/19 15:03:55]  -         "bossLv"    = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "dmgRate"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "rank"      = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionId"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionLv"   = 0
-- [LUA-print] [06/18/19 15:03:55]  -         "unionName" = ""
-- [LUA-print] [06/18/19 15:03:55]  -     }

local function TO_PERCENT( value )
	value = value*0.01
	return string.format('%.2f%%',value)
end

function LeagueHunterRankingView:showPanelHoner()

	local data = self.selfHoner
	self.Panel_honer_self_Item.league_name:setText(tostring(data.unionName))  
	self.Panel_honer_self_Item.league_lv:setText("Lv."..tostring(data.unionLv))  
	self.Panel_honer_self_Item.boss_lv:setText(tostring(data.bossLv))   



	self.Panel_honer_self_Item.hurt_per:setText(TO_PERCENT(data.dmgRate))  

	local cfg = LeagueDataMgr:getEmblemCfgById(data.icon)
	self.Panel_honer_self_Item.image_boss:setTexture(cfg.icon) 
	self.Panel_honer_self_Item.image_boss:setScale(0.5) 
	-- self.Panel_honer_self_Item.label_tip:setText("我的帮会")  

	if not data.rank or data.rank == 0  then 
		self.Panel_honer_self_Item.label_noRank:show()
	    self.Panel_honer_self_Item.image_rank:hide()  
		self.Panel_honer_self_Item.label_rank:hide() 
	elseif data.rank >= 1 and data.rank <= 3 then 
		self.Panel_honer_self_Item.label_noRank:hide()
    	self.Panel_honer_self_Item.label_rank:hide()  
		self.Panel_honer_self_Item.image_rank:show()  
		self.Panel_honer_self_Item.image_rank:setTexture(RankImages[data.rank]) 
	else
		self.Panel_honer_self_Item.label_noRank:hide()
    	self.Panel_honer_self_Item.image_rank:hide() 
    	self.Panel_honer_self_Item.label_rank:show() 
		self.Panel_honer_self_Item.label_rank:setText(tostring(data.rank)) 
	end

end


--玩家自己信息
function LeagueHunterRankingView:showPanelPlayer()

	-- self.selfHoner       = data.selfDamage -- 自己社团伤害数据
	-- self.selfPlayerHoner = data.selfHonor  -- 自己玩家贡献数据
	local data = self.selfPlayerHoner
	self.Panel_playerHoner_self_Item.player_name:setText(MainPlayer:getPlayerName())  
	self.Panel_playerHoner_self_Item.player_lv:setText("Lv."..MainPlayer:getPlayerLv())  
	self.Panel_playerHoner_self_Item.count:setText(tostring(data.fightCount))  
	self.Panel_playerHoner_self_Item.honor:setText(tostring(data.honor))
	dump(data)
	local dmgRate = data.dmgRate and data.dmgRate or 0
	self.Panel_playerHoner_self_Item.hurtvalue:setText(TO_PERCENT(dmgRate))
	local icon = AvatarDataMgr:getSelfAvatarIconPath()
	self.Panel_playerHoner_self_Item.image_boss:setTexture(icon)  
	-- self.Panel_playerHoner_self_Item.label_tip:setText("我的信息")    
	if not data.rank or data.rank == 0  then 
		self.Panel_playerHoner_self_Item.label_noRank:show()
	    self.Panel_playerHoner_self_Item.image_rank:hide()  
		self.Panel_playerHoner_self_Item.label_rank:hide() 
	elseif data.rank >= 1 and data.rank <= 3 then 
		self.Panel_playerHoner_self_Item.label_noRank:hide()
    	self.Panel_playerHoner_self_Item.label_rank:hide()  
		self.Panel_playerHoner_self_Item.image_rank:show()  
		self.Panel_playerHoner_self_Item.image_rank:setTexture(RankImages[data.rank]) 
	else
		self.Panel_playerHoner_self_Item.label_noRank:hide()
    	self.Panel_playerHoner_self_Item.image_rank:hide()  
    	self.Panel_playerHoner_self_Item.label_rank:show()
		self.Panel_playerHoner_self_Item.label_rank:setText(tostring(data.rank)) 
	end
end



function LeagueHunterRankingView:setSelect(index,force)

    local posX = index == 1 and 512 or 540
    self.image_line3:setPositionX(posX)

    if self.chooseIndex ~= index  or force then
        self.chooseIndex = index
        for k , tab in ipairs(self.tabs) do
            if k == self.chooseIndex then
                tab:setTextureNormal("ui/new_equip/new_001.png") 
                tab:setTouchEnabled(false)
            else
                tab:setTextureNormal("ui/new_equip/new_02.png")
                tab:setTouchEnabled(true)
            end
        end
		self.panel_player:setVisible(self.chooseIndex == 1)
		self.panel_league:setVisible(self.chooseIndex ~= 1)
		self:showPanelPlayer()
		self:showPanelHoner()
		self.Panel_honer_self_Item:setVisible(self.chooseIndex ~= 1)
		self.Panel_playerHoner_self_Item:setVisible(self.chooseIndex == 1)
		if self.chooseIndex == 1 then
			self.curCellItem = self.Panel_playerHoner_Item
		else
			self.curCellItem = self.Panel_honer_Item
		end
		self.listView.cells = {}
		self.listView:reloadData()
    end
	self.Label_nullList:setVisible(self:tableNumberOfCells() == 0)
end



function LeagueHunterRankingView:refreshView( )
	self:setSelect(self.chooseIndex,true)
end

function LeagueHunterRankingView:updateHonerItem( item, data )
	local image_rank  = TFDirector:getChildByPath(item,"image_rank")
	local label_rank  = TFDirector:getChildByPath(item,"label_rank")
	local league_name = TFDirector:getChildByPath(item,"league_name")
	local league_lv   = TFDirector:getChildByPath(item,"league_lv")
	local boss_lv     = TFDirector:getChildByPath(item,"boss_lv")
	local hurt_per    = TFDirector:getChildByPath(item,"hurt_per")
	local image_boss  = TFDirector:getChildByPath(item,"image_boss")
	local btn_search  = TFDirector:getChildByPath(item,"btn_search")
	btn_search:hide()
	local cfg = LeagueDataMgr:getEmblemCfgById(data.icon)
	image_boss:setTexture(cfg.icon)
	image_boss:setScale(0.5)
	--排名显示优化
	if data.rank >= 1 and data.rank  <= 3 then 
		image_rank:show()
		image_rank:setTexture(RankImages[data.rank])
		label_rank:hide()
	else
		label_rank:show()
		label_rank:setText(data.rank)
		image_rank:hide()
	end
	league_name:setText(data.unionName)
	league_lv:setText("Lv."..data.unionLv)
	boss_lv:setText(data.bossLv)
	hurt_per:setText(TO_PERCENT(data.dmgRate))
	-- btn_search:onClick(function ( ... )
	-- 	Utils:showTips("获取社团信息，暂未加接口")
	-- end)
end

function LeagueHunterRankingView:updatePlayerHonerItem( item, data )
	local image_rank  = TFDirector:getChildByPath(item,"image_rank")
	local label_rank  = TFDirector:getChildByPath(item,"label_rank")
	local player_name = TFDirector:getChildByPath(item,"player_name")
	local player_lv   = TFDirector:getChildByPath(item,"player_lv")
	local honer       = TFDirector:getChildByPath(item,"honer")
	local challengeCount = TFDirector:getChildByPath(item,"challengeCount")
	local image_head = TFDirector:getChildByPath(item,"image_head")
	local btn_search = TFDirector:getChildByPath(item,"btn_search")
	local hurtValue = TFDirector:getChildByPath(item,"hurtValue")
	setHeadTexture(image_head,data)
	--排名显示优化
	if data.rank >= 1 and data.rank  <= 3 then 
		image_rank:show()
		image_rank:setTexture(RankImages[data.rank])
		label_rank:hide()
	else
		label_rank:show()
		label_rank:setText(data.rank)
		image_rank:hide()
	end
	player_name:setText(data.playerName)
	player_lv:setText("Lv."..data.playerLv)
	honer:setText(data.honor)
	challengeCount:setText(data.fightCount)
	local dmgRate = data.dmgRate and data.dmgRate or 0
	hurtValue:setText(TO_PERCENT(dmgRate))
	if data.playerId ~= MainPlayer:getPlayerId() then
		btn_search:show()
		btn_search:onClick(function ( ... )
			MainPlayer:sendPlayerId(data.playerId)  --查看其它玩家信息
		end)
	else
		btn_search:hide()
	end
end

function LeagueHunterRankingView:registerEvents()
	self.super.registerEvents(self)
	self.Button_honer:onClick(function ( ... )
		self:setSelect(1)
	end)
	self.Button_league:onClick(function ( ... )
		self:setSelect(2)
	end)
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
    EventMgr:addEventListener(self,EV_RECV_PLAYERINFO, function ( playerInfo )
       local view = AlertManager:getLayer(-1)
       if view.__cname == self.__cname then
           Utils:openView("chat.PlayerInfoView", playerInfo)
       end
  	end)
end

return LeagueHunterRankingView