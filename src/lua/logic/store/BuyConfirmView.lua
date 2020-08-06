
local BuyConfirmView = class("BuyConfirmView", BaseLayer)

function BuyConfirmView:initData(commodityId)
    self.commodityId_ = commodityId
    self.commodityCfg_ = StoreDataMgr:getCommodityCfg(commodityId)
    local goods = self.commodityCfg_.goodInfo[1]
    self.itemId_, self.itemCount_ = goods.id, goods.num
    self.selectNum = 1
end

function BuyConfirmView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.store.buyConfirmView")
end

function BuyConfirmView:initUI(ui)
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

function BuyConfirmView:refreshView()
    local itemCfg = GoodsDataMgr:getItemCfg(self.itemId_)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.itemId_, self.itemCount_)
    Panel_goodsItem:Pos(0, 0):AddTo(self.Image_head)
    self.Label_desc:setTextById(itemCfg.desTextId)
    self.Label_name:setTextById(itemCfg.nameTextId)

    local count = GoodsDataMgr:getItemCount(self.itemId_)
    self.Label_count:setTextById(301013, count)

    self.Panel_batch:setVisible(self.commodityCfg_.batchBuy)
    if self.commodityCfg_.batchBuy then
        self.selectNum = 1
        self:updateBatchPanel(0)
    end
end

function BuyConfirmView:onClose()
    self.super.onClose(self)

    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function BuyConfirmView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))

    self.Button_buy:onClick(function()

            if not StoreDataMgr:currencyIsEnough(self.commodityId_, self.selectNum) then
                Utils:showTips(302200)
                return
            end
            StoreDataMgr:send_STORE_BUY_GOODS(self.commodityId_, self.selectNum)
    end)

    self.Button_close:onClick(
        function()
            AlertManager:close()
        end,
        EC_BTN.CLOSE)

    self.Button_up:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
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
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:onTouchButtonDown()
                self:continueReduceAction(false)
            end
    end)

    self.Button_max:onClick(function()
            local count = StoreDataMgr:getMaxBuyCount(self.commodityId_)
            self:updateBatchPanel(count)
    end)
end

function BuyConfirmView:continueAddAction(addOrReduce)
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

function BuyConfirmView:continueReduceAction(addOrReduce)
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

function BuyConfirmView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function BuyConfirmView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function BuyConfirmView:updateBatchPanel(num)
    self.selectNum = self.selectNum + num

    local isCan,leftTimes =  StoreDataMgr:getRemainBuyCount(self.commodityId_)
    local count = StoreDataMgr:getMaxBuyCount(self.commodityId_)

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

function BuyConfirmView:onBuySuccessEvent(data)
    -- local commodityId = data.cid
    -- local commodityNum = data.num
    -- local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    -- local goods = commodityCfg.goods
    -- local goodsId, goodsCount
    -- for k, v in pairs(data) do
    --     goodsId = k
    --     goodsCount = v
    --     break
    -- end
    local rewardList = {}
    for k,v in pairs(data.goods) do
        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
    end


    -- goodsCount = goodsCount * commodityNum

    -- local rewardList = {
    --     Utils:makeRewardItem(goodsId, goodsCount)
    -- }

    AlertManager:close()
    Utils:showReward(rewardList)
end

return BuyConfirmView
