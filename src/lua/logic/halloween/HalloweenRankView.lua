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
* -- 万圣节排行榜界面
]]

local HalloweenRankView = class("HalloweenRankView",BaseLayer)

function HalloweenRankView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
  	self:showPopAnim(true)
	self:init("lua.uiconfig.halloween.halloweenRankView")
end

function HalloweenRankView:initData( activityId )
	-- body
	self.activityId = activityId
	ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityId)

	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.reward = {}
	for i, v in ipairs(self.activityInfo.items) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)

       	if itemInfo.subType == EC_Activity_Assist_Subtype.REWARD_PREVIEW then
            table.insert(self.reward, itemInfo)
        end
    end

   	table.sort( self.reward, function ( a, b )
   		return a.id < b.id
   	end )
end

function HalloweenRankView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_rank = TFDirector:getChildByPath(ui,"Panel_rank")
	self.Panel_reward = TFDirector:getChildByPath(ui,"Panel_reward")
	self.Button_rank = TFDirector:getChildByPath(ui,"Button_rank")
	self.Button_reward = TFDirector:getChildByPath(ui,"Button_reward")
	self.Panel_rankItem = TFDirector:getChildByPath(ui,"Panel_rankItem")
	self.Panel_rewardItem = TFDirector:getChildByPath(ui,"Panel_rewardItem")

	local ScrollView_rank = TFDirector:getChildByPath(self.Panel_rank,"ScrollView_rank")
	self.uiList_rank = UIListView:create(ScrollView_rank)
	self.Panel_selfRank = TFDirector:getChildByPath(self.Panel_rank,"Panel_selfRank")
	self.label_time = TFDirector:getChildByPath(self.Panel_rank,"Image_tip1.label_time")

	local ScrollView_reward = TFDirector:getChildByPath(self.Panel_reward,"ScrollView_reward")
	self.uiList_reward = UIListView:create(ScrollView_reward)

	self:updateView()
	self:showRankView()
	self.tip1 = TFDirector:getChildByPath(ui,"tip1")
	self.tip1:setTextById(12101060)
end

function HalloweenRankView:registerEvents( ... )
	-- body
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, function ( data )
    	self.rankData = data
		self:updateView()
    end)

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	self.Button_reward:onClick(function ( ... )
		-- body
		self:showRewardView()
	end)

	self.Button_rank:onClick(function ( ... )
		-- body
		self:showRankView()
	end)
end

function HalloweenRankView:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function HalloweenRankView:showRankView( ... )
	self.Button_reward:setTextureNormal("ui/Halloween/Popup/012.png")
	self.Button_rank:setTextureNormal("ui/Halloween/Popup/013.png")
	self.Panel_reward:hide()
	self.Panel_rank:show()
end

function HalloweenRankView:showRewardView( ... )
	self.Button_reward:setTextureNormal("ui/Halloween/Popup/013.png")
	self.Button_rank:setTextureNormal("ui/Halloween/Popup/012.png")
	self.Panel_reward:show()
	self.Panel_rank:hide()
end

function HalloweenRankView:updateView( ... )
	-- body
	self:updateRankView()
	self:updateRewardView()
end

function HalloweenRankView:updateRankView( ... )
	-- body
	if not self.rankData then return end
	local ranklist = self.rankData.ranks or {}
	self.uiList_rank:removeAllItems()
	for k,v in ipairs(ranklist) do
		local item = self.Panel_rankItem:clone()
		self:updateRankItem(item,v ,k )

		self.uiList_rank:pushBackCustomItem(item)
	end

	local selfRankData = {rank = self.rankData.myRank,playerName = MainPlayer:getPlayerName(), level = MainPlayer:getPlayerLv(), score = self.rankData.myScore, headIcon = AvatarDataMgr:getCurUsingCid(), frameCid = AvatarDataMgr:getCurUsingFrameCid() }
	self:updateRankItem(self.Panel_selfRank,selfRankData)
	self.label_time:setText(5)
end

function HalloweenRankView:updateRewardView( ... )
	self.uiList_reward:removeAllItems()
	for k,v in ipairs(self.reward) do
		local item = self.Panel_rewardItem:clone()
		self:updateRewardItem(item,v ,k )
		self.uiList_reward:pushBackCustomItem(item)
	end
end

function HalloweenRankView:updateRankItem(item ,data ,idx)
	-- body

	local function formatScore(score)
		if score < 0 then return "" end
	    local timestamp = math.floor(score / 1000)
	    local msec = string.format("%.2d", math.mod(score, 1000))
	    local hour, min, sec = Utils:getTime(timestamp, true)
	    local str = min..":"..sec
	    return str
	end

	local bg = TFDirector:getChildByPath(item,"bg")
	local Image_rank = TFDirector:getChildByPath(item,"Image_rank")
	local label_rank = TFDirector:getChildByPath(item,"label_rank")
	local label_lv = TFDirector:getChildByPath(item,"label_lv")
	local label_name = TFDirector:getChildByPath(item,"label_name")
	local label_time = TFDirector:getChildByPath(item,"label_time")
	local image_icon = TFDirector:getChildByPath(item,"image_icon")
	local image_frame = TFDirector:getChildByPath(item,"image_frame")
	if idx then
		local imageIdx = 23+(idx+1)%2
		bg:setTexture("ui/Halloween/Popup/0"..imageIdx..".png")
	end
	label_rank:setSkewX(10)
	label_time:setSkewX(10)
    label_rank:setText(tostring(data.rank))
	label_time:setText(formatScore(data.score))
    label_name:setText(data.playerName)
    label_lv:setText("LV."..data.level)


	if data.rank < 1 then
        Image_rank:setVisible(false)
        label_rank:setVisible(true)
        label_rank:setTextById(263009)
    elseif data.rank <= 3 then
        Image_rank:setVisible(true)
        label_rank:setVisible(false)
        local num = 37 + data.rank
        Image_rank:setTexture("ui/activity/assist/0"..num..".png")
    else
        local rankStr = tostring("NO."..data.rank)
        if data.rank > 10000 then
            rankStr = ">10000"
        end
        Image_rank:setVisible(false)
        label_rank:setVisible(true)
        label_rank:setText(rankStr)
    end

    local headIcon = data.headIcon
    if headIcon == 0 then
        headIcon = 101
    end
    local icon = AvatarDataMgr:getAvatarIconPath(headIcon)
    image_icon:setTexture(icon)
	image_icon:setTouchEnabled(true)
	image_icon:onClick(function ( ... )
		if data.playerId then
        	TFDirector:send(c2s.PLAYER_REQ_TARGET_PLAYER_INFO,{data.playerId})
		end
	end)


    local frameIcon = data.frameCid
    if frameIcon == 0 then
        frameIcon = 10101
    end
	local frame = AvatarDataMgr:getAvatarIconPath(frameIcon)
    image_frame:setTexture(frame)
end

function HalloweenRankView:updateRewardItem(item ,data ,idx)
	local bg = TFDirector:getChildByPath(item,"bg")
	local label_rank = TFDirector:getChildByPath(item,"label_rank")
	local imageIdx = 23+(idx+1)%2
	bg:setTexture("ui/Halloween/Popup/0"..imageIdx..".png")

	local goodsId, goodsNum
	for i = 1,4 do
		local pos = TFDirector:getChildByPath(item,"Panel_pos"..i)
        local id, num = next(data.reward, goodsId)
        if id then
            goodsId = id
            goodsNum = num
        end

        if i <= table.count(data.reward) then
	        pos:setVisible(true)
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			pos:addChild(Panel_goodsItem)
			Panel_goodsItem:setScale(0.6)
			Panel_goodsItem:Pos(ccp(0,0))
			PrefabDataMgr:setInfo(Panel_goodsItem,goodsId,goodsNum)
		else
	        pos:setVisible(false)
		end
	end
	label_rank:setText(data.extendData.des2)
	label_rank:setSkewX(10)
end

return HalloweenRankView