
local ActivityBuyConfirmView = class("ActivityBuyConfirmView", BaseLayer)

function ActivityBuyConfirmView:initData(activityId, itemId)
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(activityId)
    self.itemId_ = itemId
    self.itemInfo_ = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, itemId)
    self.isBatchBuy_ = false
    if self.itemInfo_.extendData then
        self.isBatchBuy_ = tobool(self.itemInfo_.extendData.batchBuy ~= 0)
    end
    local itemId, itemCount
    for k, v in pairs(self.itemInfo_.reward) do
        self.goodsId_ = k
        self.goodsCount_ = v
        break
    end
    self.selectNum = 1
end

function ActivityBuyConfirmView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.store.buyConfirmView")
end

function ActivityBuyConfirmView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Image_head = TFDirector:getChildByPath(Image_bg, "Image_head")
    self.Label_name = TFDirector:getChildByPath(Image_bg, "Label_name")
    self.Label_count = TFDirector:getChildByPath(Image_bg, "Label_count")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Label_desc = TFDirector:getChildByPath(Image_bg, "Label_desc")
    self.Button_buy = TFDirector:getChildByPath(Image_bg, "Button_buy")

    self.Panel_batch    = TFDirector:getChildByPath(Image_bg,"Panel_batch")
    self.Button_down    = TFDirector:getChildByPath(Image_bg,"Button_down")
    self.Button_up      = TFDirector:getChildByPath(Image_bg,"Button_up")
    self.Button_max = TFDirector:getChildByPath(self.Panel_batch, "Button_max")
    self.Label_num      = TFDirector:getChildByPath(Image_bg,"Label_num")

    self:refreshView()
end

function ActivityBuyConfirmView:refreshView()
    local itemCfg = GoodsDataMgr:getItemCfg(self.goodsId_)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.goodsId_, self.goodsCount_)
    Panel_goodsItem:Pos(0, 0):AddTo(self.Image_head)
    self.Label_desc:setTextById(itemCfg.desTextId)
    self.Label_name:setTextById(itemCfg.nameTextId)

    if itemCfg.superType == EC_ResourceType.UNION_EXP or
        itemCfg.superType == EC_ResourceType.UNION_CONTRIBUTION or
        itemCfg.superType == EC_ResourceType.KABALA or
        itemCfg.superType == EC_ResourceType.DLS or
        itemCfg.superType == EC_ResourceType.UNION_TRAIN_SCORE or
        itemCfg.superType == EC_ResourceType.CHENGHAO
    then
        self.Label_count:setText("")
    else
        self.Label_count:setTextById(301013, GoodsDataMgr:getItemCount(self.goodsId_))
    end

    self.Panel_batch:setVisible(self.isBatchBuy_)
    if self.isBatchBuy_ then
        self.selectNum = 1
        self:updateBatchPanel(0)
    end
end

function ActivityBuyConfirmView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))

    self.Button_buy:onClick(function()
            if not ActivityDataMgr2:currencyIsEnough(self.activityInfo_.activityType, self.itemId_, self.selectNum) then
                Utils:showTips(302200)
                return
            end
            local args = {
                self.activityId_,
                self.itemId_,
                self.selectNum,
            }
            --韩服好友助力兑换商店修改
            local extendData = {num = self.selectNum}
            local json = require("LuaScript.extends.json")
            local jsonExtendData = json.encode(extendData)
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, self.itemId_, jsonExtendData)
            --ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId_, self.itemId_, self.selectNum)
    end)

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_up:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                self:onTouchButtonUp()
                self:continueAddAction(true)
            end
        end)

    self.Button_down:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                self:onTouchButtonDown()
                self:continueReduceAction(false)
            end
    end)

    self.Button_max:onClick(function()
            local count = ActivityDataMgr2:getMaxBuyCount(self.activityInfo_.activityType, self.itemId_)
            self:updateBatchPanel(count)
    end)
end

function ActivityBuyConfirmView:continueAddAction(addOrReduce)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonUp()
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function ActivityBuyConfirmView:continueReduceAction(addOrReduce)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonDown()
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function ActivityBuyConfirmView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function ActivityBuyConfirmView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function ActivityBuyConfirmView:updateBatchPanel(num)
    self.selectNum = self.selectNum + num

    local isCan,leftTimes =  ActivityDataMgr2:getRemainBuyCount(self.activityInfo_.activityType, self.itemId_)
    local count = ActivityDataMgr2:getMaxBuyCount(self.activityInfo_.activityType, self.itemId_)

    if self.selectNum <= 1 then
        self.selectNum = 1
    end

    if leftTimes then
        count = math.min(count, leftTimes)
    end
    if self.selectNum >= count then
        self.selectNum = count
    end

    self.Label_num:setString(self.selectNum)
end

function ActivityBuyConfirmView:onBuySuccessEvent(data)
    local commodityId = data.cid
    local commodityNum = data.num
    local commodityCfg = ActivityDataMgr2:getCommodityCfg(commodityId)
    local goods = commodityCfg.goods
    local goodsId, goodsCount
    for k, v in pairs(goods) do
        goodsId = k
        goodsCount = v
        break
    end
    goodsCount = goodsCount * commodityNum

    local rewardList = {
        Utils:makeRewardItem(goodsId, goodsCount)
    }

    AlertManager:closeLayer(self)
    Utils:showReward(rewardList)
end

function ActivityBuyConfirmView:onSubmitSuccessEvent(activitId, itemId, reward)
    AlertManager:closeLayer(self)
    Utils:showReward(reward)
end

function ActivityBuyConfirmView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

return ActivityBuyConfirmView
