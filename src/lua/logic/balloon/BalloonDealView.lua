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
* 气球交易界面
* 
]]

local BalloonDealView = class("BalloonDealView", BaseLayer)

function BalloonDealView:ctor(friendId)
    self.super.ctor(self,data)
    self:initData(friendId)
    self:init("lua.uiconfig.activity.BalloonDealView")
end

function BalloonDealView:initData(friendId)
    self.friendId = friendId
    self.bagDataList = {}
    self.leftDataList = {}
    self.rightDataList = {}
    self:updateData()
end

function BalloonDealView:updateData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BALLOON_ACTIVITY)[1]
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    local extendData = {}
    if self.activityInfo then
    	extendData = self.activityInfo.extendData or {}
    end
    self.balloonList = extendData.balloonId or {}

    self:updateBagData()
end

function BalloonDealView:updateBagData()
    for k, v in ipairs(self.balloonList or {}) do
        local totalCnt = GoodsDataMgr:getItemCount(v)
        self.bagDataList[v] = totalCnt - self:getPutItemCnt(v)
    end
end

--获取已放上的道具数量
function BalloonDealView:getPutItemCnt(id)
    local cnt = 0
    for k, v in ipairs(self.leftDataList) do
        if v.key == id then
            cnt = cnt + v.value
        end
    end

    return cnt
end

--添加或者下掉交易气球
function BalloonDealView:updateLeftData(id, isAdd)
    local isFind = false
    for k, v in ipairs(self.leftDataList) do
        if v.key == id then
            isFind = true
            if isAdd then
                v.value = v.value + 1
            else
                v.value = v.value - 1
                if v.value <= 0 then
                    table.remove(self.leftDataList, k)
                end
            end
            break
        end
    end

    if isAdd and not isFind then
        table.insert(self.leftDataList, {key = id, value = 1})
    end
    self:sendReqSelectBalloon(false)
end

function BalloonDealView:sendReqSelectBalloon(confirm)
    local sendItems = {}
    for k, v in ipairs(self.leftDataList) do
        table.insert(sendItems, {v.key, v.value})
    end
    ActivityDataMgr2:sendReqSelectBalloonId(self.friendId, sendItems, confirm)
end

function BalloonDealView:initUI(ui)
    self.super.initUI(self, ui)

    local label_title = TFDirector:getChildByPath(ui, "label_title")
    label_title:setTextById(13317056)

    self.panel_item = TFDirector:getChildByPath(ui, "panel_item"):hide()
    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")

    self.btn_left = TFDirector:getChildByPath(ui, "btn_left")
    self.btn_left:setGrayEnabled(true)
    self.btn_left:setTouchEnabled(false)

    self.btn_deal = TFDirector:getChildByPath(ui, "btn_deal")
    self.btn_deal:setGrayEnabled(true)
    self.btn_deal:setTouchEnabled(false)

    self.img_right_state = TFDirector:getChildByPath(ui, "img_right_state"):hide()
    self.img_left_state = TFDirector:getChildByPath(ui, "img_left_state"):hide()
    self.img_equal = TFDirector:getChildByPath(ui, "img_equal")

    self.txt_left_cnt = TFDirector:getChildByPath(ui, "txt_left_cnt")
    self.txt_right_cnt = TFDirector:getChildByPath(ui, "txt_right_cnt")

    local txt_tip = TFDirector:getChildByPath(ui, "txt_tip")
    txt_tip:setTextById(13317030)

    local bag_title = TFDirector:getChildByPath(ui, "bag_title")
    bag_title:setTextById(13317053)

    local scroll_bag = TFDirector:getChildByPath(ui, "scroll_bag")
    local bagItem = self.panel_item:clone()
    bagItem:setScale(0.8)
    self.bagGridView = UIGridView:create(scroll_bag)
    self.bagGridView:setItemModel(bagItem)
    self.bagGridView:setColumn(2)
    self.bagGridView:setColumnMargin(3)
    self.bagGridView:setRowMargin(2)

    local scroll_left = TFDirector:getChildByPath(ui, "scroll_left")
    self.leftGridView = UIGridView:create(scroll_left)
    self.leftGridView:setItemModel(self.panel_item)
    self.leftGridView:setColumn(3)
    self.leftGridView:setColumnMargin(15)
    self.leftGridView:setRowMargin(0)

    local scroll_right = TFDirector:getChildByPath(ui, "scroll_right")
    self.rightGridView = UIGridView:create(scroll_right)
    self.rightGridView:setItemModel(self.panel_item)
    self.rightGridView:setColumn(3)
    self.rightGridView:setColumnMargin(15)
    self.rightGridView:setRowMargin(0)

    self:updateUI()
end

function BalloonDealView:updateUI()
    self:updateBagList()
    self.txt_left_cnt:setTextById(13317028, self:getItemTotalCnt(self.leftDataList))
    self.txt_right_cnt:setTextById(13317029, self:getItemTotalCnt(self.rightDataList))
end

function BalloonDealView:updateBagList()
    local curBagList = {}
    for k, v in pairs(self.bagDataList) do
        if v > 0 then
            table.insert(curBagList, {id = k, num = v})
        end
    end

    local items = self.bagGridView:getItems()
    local gap = #curBagList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.panel_item:clone()
            item:show()
            item:setScale(0.8)
            self.bagGridView:pushBackCustomItem(item)
        else
            self.bagGridView:removeItem(1)
        end
    end

    for k, v in ipairs(curBagList) do
        local item = self.bagGridView:getItem(k)
        local txt_cnt = TFDirector:getChildByPath(item, "txt_cnt")
        local img_down = TFDirector:getChildByPath(item, "img_down"):hide()
        if not item.itemNode then
            local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            itemNode:setScale(0.8)
            itemNode:setPosition(ccp(0, 0))
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

function BalloonDealView:onBagItemClick(sender)
    if not sender.id then return end
    if self.curData and self.curData.confirm then
        --已经点击确定
        Utils:showTips(13317051)
        return
    end
    self:updateLeftData(sender.id, true)
    self:updateBagData()
    self:updateBagList()
    self:updateLeftList()
end

function BalloonDealView:updateLeftList()
    local items = self.leftGridView:getItems()
    local gap = #self.leftDataList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.panel_item:clone()
            item:show()
            self.leftGridView:pushBackCustomItem(item)
        else
            self.leftGridView:removeItem(1)
        end
    end

    for k, v in ipairs(self.leftDataList) do
        local item = self.leftGridView:getItem(k)
        local txt_cnt = TFDirector:getChildByPath(item, "txt_cnt")
        if not item.itemNode then
            local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            itemNode:setScale(0.8)
            itemNode:setPosition(ccp(0, 0))
            item:addChild(itemNode)
            item.itemNode = itemNode
        end
        PrefabDataMgr:setInfo(item.itemNode, v.key)
        item.itemNode:setTouchEnabled(false)
        txt_cnt:setText("x" .. v.value)
        item.id = v.key
        item:setTouchEnabled(true)
        item:onClick(handler(self.onLeftItemClick, self))
    end
    self.txt_left_cnt:setTextById(13317028, self:getItemTotalCnt(self.leftDataList))

    self:updateLeftBtn()
end

function BalloonDealView:updateLeftBtn()
    self.img_equal:setTexture("ui/balloon/16.png")
    local curNum = self:getItemTotalCnt(self.leftDataList)
    local rightCnt = self:getItemTotalCnt(self.rightDataList)
    local isCanTouch = false
    if not self.curData then
        if curNum > 0 then
            --对方未确认，且我有选中的道具
            isCanTouch = true
        end
    elseif not self.curData.confirm then
        if self.curData.friendConfirm then
            --对方已确认
            if rightCnt == curNum then
                isCanTouch = true
            end
        else
            if curNum > 0 then
                --对方未确认，且我有选中的道具
                isCanTouch = true
            end
        end
    end

    if rightCnt == curNum then
        self.img_equal:setTexture("ui/balloon/17.png")
    end

    self.btn_left:setGrayEnabled(not isCanTouch)
    self.btn_left:setTouchEnabled(isCanTouch)

    self.img_left_state:hide()
    if self.curData and self.curData.confirm then
        self.img_left_state:show()
    end
end

function BalloonDealView:onLeftItemClick(sender)
    if not sender.id then return end
    if self.curData and self.curData.confirm then
        --已经点击确定
        Utils:showTips(13317051)
        return
    end
    self:updateLeftData(sender.id, false)
    self:updateBagData()
    self:updateBagList()
    self:updateLeftList()
end

--更新选中的气球
function BalloonDealView:onUpdateSelectBalloon(data)
    self.curData = data
    self.rightDataList = data.friendItems or {}
    local items = self.rightGridView:getItems()
    local gap = #self.rightDataList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            local item = self.panel_item:clone()
            item:show()
            self.rightGridView:pushBackCustomItem(item)
        else
            self.rightGridView:removeItem(1)
        end
    end

    for k, v in ipairs(self.rightDataList) do
        local item = self.rightGridView:getItem(k)
        local txt_cnt = TFDirector:getChildByPath(item, "txt_cnt")
        local img_down = TFDirector:getChildByPath(item, "img_down"):hide()
        if not item.itemNode then
            local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            itemNode:setScale(0.8)
            itemNode:setPosition(ccp(0, 0))
            item:addChild(itemNode)
            item.itemNode = itemNode
        end
        PrefabDataMgr:setInfo(item.itemNode, v.key)
        item.itemNode:setTouchEnabled(false)
        txt_cnt:setText("x" .. v.value)
    end

    self.txt_right_cnt:setTextById(13317029, self:getItemTotalCnt(self.rightDataList))

    self.img_right_state:hide()
    if data.friendConfirm then
        self.img_right_state:show()
    end

    self.btn_deal:setGrayEnabled(true)
    self.btn_deal:setTouchEnabled(false)
    if data.confirm and data.friendConfirm then
        self.btn_deal:setGrayEnabled(false)
        self.btn_deal:setTouchEnabled(true)
    end

    self:updateLeftBtn()
end

function BalloonDealView:getItemTotalCnt(items)
    local totalCnt = 0
    for k, v in ipairs(items) do
        totalCnt = totalCnt + v.value
    end
    return totalCnt
end

function BalloonDealView:onExchangeResult(data)
    if data.result == 1 then
        --交易成功
        local rewards = data.rewards or {}
        Utils:showReward(rewards)
    else
        --取消交易
        Utils:showTips(13317052)
    end
    AlertManager:closeLayer(self)
end

function BalloonDealView:bagItemUpdate()
    self:updateBagData()
    self:updateBagList()
    self:updateLeftList()
end

function BalloonDealView:closeHandle()
    AlertManager:closeLayer(self)
end

function BalloonDealView:registerEvents()
    self.super.registerEvents(self)

    self.btn_left:onClick(function()
        self:sendReqSelectBalloon(true)
    end)

    self.btn_close:onClick(function()
        Utils:openView("balloon.BalloonOpPanel", self.friendId)
	end)

    self.btn_deal:onClick(function()
        ActivityDataMgr2:sendReqConfirmTrade(self.friendId)
        self.btn_deal:setGrayEnabled(true)
        self.btn_deal:setTouchEnabled(false)
    end)

    -- EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.bagItemUpdate, self))
    EventMgr:addEventListener(self, EV_BALLOON_CHOOSE_UPDATE, handler(self.onUpdateSelectBalloon, self))
    EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_RESULT, handler(self.onExchangeResult, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.closeHandle, self))
end

return BalloonDealView
