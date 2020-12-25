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
* 放飞气球活动主界面
* 
]]

local BalloonMainView = class("BalloonMainView", BaseLayer)

function BalloonMainView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.BalloonMainView")
end

function BalloonMainView:initData()
    self.selectIdx = -1
    self.bagDataList = {}
    self.putDataList = {}
    self:updateData()
end

function BalloonMainView:updateData()
	self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BALLOON_ACTIVITY)[1]
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    local extendData = {}
    if self.activityInfo then
    	extendData = self.activityInfo.extendData or {}
    end
    self.balloonList = extendData.balloonId or {}

    self:updateBagData()
end

function BalloonMainView:updateBagData()
	for k, v in ipairs(self.balloonList or {}) do
        local totalCnt = GoodsDataMgr:getItemCount(v)
		self.bagDataList[v] = totalCnt - self:getPutItemCnt(v)
	end
end

function BalloonMainView:getNextEmptyIndex()
    local startIdx = self.selectIdx
    if self.selectIdx >= 5 then
        startIdx = 1
    end
    for i = startIdx, 5 do
        if not self.putDataList[i] then
            return i
        end
    end

    for i = 1, startIdx do
        if not self.putDataList[i] then
            return i
        end
    end

    return self.selectIdx
end

--获取已放上的道具数量
function BalloonMainView:getPutItemCnt(id)
    local cnt = 0
    for k, v in pairs(self.putDataList) do
        if v == id then
            cnt = cnt + 1
        end
    end

    return cnt
end

function BalloonMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.panel_item = TFDirector:getChildByPath(ui, "panel_item"):hide()
    self.own_item = TFDirector:getChildByPath(ui, "own_item"):hide()
    self.bag_item = TFDirector:getChildByPath(ui, "bag_item"):hide()

    self.txt_time = TFDirector:getChildByPath(ui, "txt_time")
    self.label_total = TFDirector:getChildByPath(ui, "label_total")
    self.label_total:setTextById(13317025)
    self.txt_total = TFDirector:getChildByPath(ui, "txt_total")

    local scroll_list = TFDirector:getChildByPath(ui, "scroll_list")
    self.rewardList = UIListView:create(scroll_list)
    self.rewardList:setItemsMargin(0)

    self.bag_bg = TFDirector:getChildByPath(ui, "bag_bg"):hide()
    self.bag_bg:setTouchEnabled(true)
    self.close_btn = TFDirector:getChildByPath(self.bag_bg, "close_btn")
    local scroll_bag = TFDirector:getChildByPath(self.bag_bg, "scroll_bag")
    self.bagList = UIListView:create(scroll_bag)
    self.bagList:setItemsMargin(0)

    local label_title = TFDirector:getChildByPath(self.bag_bg, "label_title")
    label_title:setTextById(13317053)

    local panel_left = TFDirector:getChildByPath(ui, "panel_left")
    self.txt_tip = TFDirector:getChildByPath(panel_left, "txt_tip")
    self.btn_award = TFDirector:getChildByPath(panel_left, "btn_award")
    self.btn_fly = TFDirector:getChildByPath(panel_left, "btn_fly")
    self.txt_tip:setTextById(13317027)

    self.itemPanels = {}
    for i = 1, 5 do
    	local panel_item = TFDirector:getChildByPath(panel_left, "panel_item" .. i)
    	local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    	itemNode:setScale(0.7)
    	itemNode:setPosition(ccp(0, 0))
    	itemNode:hide()
        itemNode.pos = i
    	panel_item:addChild(itemNode)
    	panel_item.itemNode = itemNode
    	panel_item.img_add_bg = TFDirector:getChildByPath(panel_item, "img_add_bg")
        panel_item.img_add_bg.pos = i
        panel_item.img_add_bg:setTouchEnabled(true)
        panel_item.img_add = TFDirector:getChildByPath(panel_item, "img_add")
        panel_item.img_down = TFDirector:getChildByPath(panel_item, "img_down"):hide()
    	panel_item.img_select = TFDirector:getChildByPath(panel_item, "img_select"):hide()
    	table.insert(self.itemPanels, panel_item)
    end

    local panel_right = TFDirector:getChildByPath(ui, "panel_right")
    self.btn_friend = TFDirector:getChildByPath(panel_right, "btn_friend")
    local scroll_own = TFDirector:getChildByPath(panel_right, "scroll_own")
    self.ownList = UIListView:create(scroll_own)
    self.ownList:setItemsMargin(0)

    self:updateUI()
end

function BalloonMainView:updateUI()
	if not self.activityInfo then
        return
    end

    local startDate = Utils:getLocalDate(self.activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.txt_time:setTextById(300306, startDateStr, endDateStr)

    local extendData = self.activityInfo.extendData
    local serverCount = extendData.serverCount or 0
    self.txt_total:setText(serverCount)

    local itemList = ActivityDataMgr2:getItems(self.activityInfo.id)
    local items = self.rewardList:getItems()
    local gap = #itemList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
        	local item = self.panel_item:clone()
        	item:show()
        	self.rewardList:pushBackCustomItem(item)
        else
            self.rewardList:removeItem(1)
        end
    end

    for k, v in ipairs(itemList) do
        local item = self.rewardList:getItem(k)
        self:updateAwardItem(item, v)
    end

    self:updateOwnList()
    self:updateBagList()
    self:updateItemPanels()
end

function BalloonMainView:updateOwnList()
	if not self.activityInfo then
        return
    end
    local extendData = self.activityInfo.extendData
    local items = self.ownList:getItems()
    local gap = #self.balloonList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
        	local item = self.own_item:clone()
        	item:show()
        	self.ownList:pushBackCustomItem(item)
        else
            self.ownList:removeItem(1)
        end
    end

    for k, v in ipairs(self.balloonList) do
        local item = self.ownList:getItem(k)
        local txt_cnt = TFDirector:getChildByPath(item, "txt_cnt")
        local cnt_bg = TFDirector:getChildByPath(item, "cnt_bg")
        local bgSize = cnt_bg:getContentSize()
        if not item.itemNode then
    		local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    		itemNode:setScale(0.45)
    		itemNode:setPosition(ccp(0, 15))
    		item:addChild(itemNode)
    		item.itemNode = itemNode
    	end
        PrefabDataMgr:setInfo(item.itemNode, v)

        local ownCnt = GoodsDataMgr:getItemCount(v)
        if ownCnt < 1 then
            txt_cnt:setFontColor(ccc3(244, 31, 31))
        else
            txt_cnt:setFontColor(ccc3(255, 255, 255))
        end
        txt_cnt:setText("x" .. ownCnt)
    end
end

function BalloonMainView:updateBagList()
	local curBagList = {}
	for k, v in pairs(self.bagDataList) do
		if v > 0 then
			table.insert(curBagList, {id = k, num = v})
		end
	end

	local items = self.bagList:getItems()
    local gap = #curBagList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
        	local item = self.bag_item:clone()
        	item:show()
        	self.bagList:pushBackCustomItem(item)
        else
            self.bagList:removeItem(1)
        end
    end

    for k, v in ipairs(curBagList) do
        local item = self.bagList:getItem(k)
        local txt_cnt = TFDirector:getChildByPath(item, "txt_cnt")
        if not item.itemNode then
    		local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            itemNode:setScale(0.6)
    		itemNode:setPosition(ccp(35, 0))
    		item:addChild(itemNode)
    		item.itemNode = itemNode
    	end
        PrefabDataMgr:setInfo(item.itemNode, v.id)
        item.itemNode:setTouchEnabled(false)
        txt_cnt:setText("x" .. v.num)
        item.id = v.id
        item:setTouchEnabled(true)
        item:onClick(handler(self.onBagItemClick, self))
    end
end

function BalloonMainView:onBagItemClick(sender)
    if not sender.id or self.selectIdx == -1 then return end
    self.putDataList[self.selectIdx] = sender.id
    self:updateBagData()
    self:updateBagList()
    self:updateItemPanels()

    local nextSelect = self:getNextEmptyIndex()
    if self.selectIdx ~= nextSelect then
        self.selectIdx = nextSelect
        self:updateItemSelect()
    end
end

function BalloonMainView:updateAwardItem(item, itemId)
    local img_item_bg = TFDirector:getChildByPath(item, "img_item_bg")
	local txt_desc = TFDirector:getChildByPath(item, "txt_desc")
	local btn_get = TFDirector:getChildByPath(item, "btn_get")
    local img_get = TFDirector:getChildByPath(item, "img_get"):hide()
	local img_got = TFDirector:getChildByPath(item, "img_got"):hide()
    local item_spine = TFDirector:getChildByPath(item, "item_spine"):hide()
    item_spine:play("animation", true)

	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemId)
    local target = itemInfo.target or 100
    local rewards = itemInfo.reward or {}

    local list = {}
    for k, v in pairs(rewards) do
    	table.insert(list, {id = k, num = v})
    end
    table.sort(list, function(a, b)
        return a.id < b.id
    end)
    for i = 1, 4 do
    	local pos = TFDirector:getChildByPath(item, "pos" .. i)
    	if not pos.itemNode then
    		local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            itemNode:setScale(0.5)
    		itemNode:setPosition(ccp(0, 0))
    		pos:addChild(itemNode)
    		pos.itemNode = itemNode
    	end
    	pos.itemNode:hide()
    	if i <= #list then
    		pos.itemNode:show()
    		PrefabDataMgr:setInfo(pos.itemNode, list[i].id, list[i].num)
    	end
    end

    img_item_bg.itemInfo = nil
    img_item_bg:setTouchEnabled(false)
    img_item_bg:setColor(ccc3(255, 255, 255))
    if progressInfo.status == EC_TaskStatus.GET then
        img_item_bg.itemInfo = itemInfo
        img_item_bg:setTouchEnabled(true)
    end

    if progressInfo.status == EC_TaskStatus.GETED then
        img_item_bg:setColor(ccc3(128, 128, 128))
    end

    txt_desc:setTextById(13317026, target)
    img_get:setVisible(progressInfo.status == EC_TaskStatus.ING)
    btn_get:setVisible(progressInfo.status == EC_TaskStatus.GET)
    item_spine:setVisible(progressInfo.status == EC_TaskStatus.GET)
    img_got:setVisible(progressInfo.status == EC_TaskStatus.GETED)
    img_item_bg:onClick(handler(self.onGetBtnHandle, self))
end

function BalloonMainView:onGetBtnHandle(sender)
    local itemInfo = sender.itemInfo
    if not itemInfo then return end
    ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemInfo.id)
end

function BalloonMainView:updateItemPanels()
    for k, v in ipairs(self.itemPanels) do
        v.itemNode.id = nil
        if self.putDataList[k] then
            v.img_add_bg:hide()
            v.img_down:show()
            v.itemNode:show()
            v.itemNode.id = self.putDataList[k]
            PrefabDataMgr:setInfo(v.itemNode, self.putDataList[k])
            v.itemNode:onClick(handler(self.onPutItemClick, self))
        else
            v.img_add_bg:show()
            v.img_down:hide()
            v.itemNode:hide()
        end
    end
end

function BalloonMainView:onPutItemClick(sender)
    if not sender.id then return end
    self.putDataList[sender.pos] = nil
    self:updateBagData()
    self:updateBagList()
    self:updateItemPanels()
end

function BalloonMainView:updateItemSelect()
    for k, v in ipairs(self.itemPanels) do
        v.img_select:hide()
        if k == self.selectIdx then
            v.img_select:show()
        end
    end
end

function BalloonMainView:bagItemUpdate()
    for k, v in ipairs(self.balloonList or {}) do
        if GoodsDataMgr:getItemCount(v) <= 0 then
            self.putDataList[v] = nil
        end
    end

    self:updateBagData()
    self:updateBagList()
    self:updateOwnList()
    self:updateItemPanels()
end

function BalloonMainView:onFlySuccRsp()
    self.putDataList = {}
    self.selectIdx = -1
    self.bag_bg:hide()
    self:updateBagData()
    self:updateBagList()
    self:updateOwnList()
    self:updateItemPanels()
    self:updateItemSelect()
end

function BalloonMainView:updateUIByData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BALLOON_ACTIVITY)
    if #activity <= 0 then
        Utils:showTips(1710021)
        AlertManager:closeLayer(self)
        return
    end
    self:updateData()
    self:updateUI()
end

function BalloonMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function BalloonMainView:registerEvents()
    self.super.registerEvents(self)

    self.btn_award:onClick(handler(self.onAwardHandle, self))
    self.btn_fly:onClick(handler(self.onFlyHandle, self))
    self.btn_friend:onClick(handler(self.onFriendHandle, self))


    self.close_btn:onClick(function()
        self.selectIdx = -1
		self.bag_bg:hide()
        self:updateItemSelect()
	end)

	for k, v in ipairs(self.itemPanels) do
		v.img_add_bg:onClick(handler(self.onSelectItem, self))
	end

	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.bagItemUpdate, self))
    EventMgr:addEventListener(self, EV_BALLOON_FLY_SUCC, handler(self.onFlySuccRsp, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateUIByData, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateUIByData, self))
end

function BalloonMainView:onSelectItem(sender)
    self.selectIdx = sender.pos
    self.bag_bg:show()
    self:updateItemSelect()
end

function BalloonMainView:onAwardHandle()
	Utils:openView("balloon.BalloonRewardView")
end

function BalloonMainView:onFlyHandle()
    for i = 1, 5 do
        if not self.putDataList[i] then
            --放入的气球不足5个
            Utils:showTips(13317011)
            return
        end 
    end
    ActivityDataMgr2:sendReqFlyBalloon(self.putDataList)
end

function BalloonMainView:onFriendHandle()
    FunctionDataMgr:jFriend()
end

return BalloonMainView
