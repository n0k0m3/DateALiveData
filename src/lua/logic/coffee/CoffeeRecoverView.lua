
local CoffeeRecoverView = class("CoffeeRecoverView", BaseLayer)

function CoffeeRecoverView:initData(maidId)
    self.maidId_ = maidId
    self.maidInfo_ = CoffeeDataMgr:getMaidInfo(maidId)
    self.maidCfg_ = CoffeeDataMgr:getMaidCfg(maidId)

    local charge = Utils:getKVP(46016, "charge")
    self.itemCid_, self.addPower_ = next(charge)
    self.count_ = 1
    self.maxCount_ = math.ceil((self.maidCfg_.strength - self.maidInfo_.strength) / self.addPower_)
end

function CoffeeRecoverView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.coffee.coffeeRecoverView")
end

function CoffeeRecoverView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Image_maid_icon = TFDirector:getChildByPath(Image_content, "Image_head.Image_maid_icon")
    local Image_power = TFDirector:getChildByPath(Image_content, "Image_power")
    self.Label_power_title = TFDirector:getChildByPath(Image_power, "Label_power_title")
    self.Label_power = TFDirector:getChildByPath(Image_power, "Label_power")
    self.Label_tips_1 = TFDirector:getChildByPath(Image_content, "Label_tips_1")
    self.Label_tips_2 = TFDirector:getChildByPath(Image_content, "Label_tips_2")
    self.Image_cost_icon = TFDirector:getChildByPath(Image_content, "Image_cost_icon")
    self.Button_recover = TFDirector:getChildByPath(Image_content, "Button_recover")
    self.Label_recover = TFDirector:getChildByPath(self.Button_recover, "Label_recover")
    self.Button_get = TFDirector:getChildByPath(Image_content, "Button_get")
    self.Label_get = TFDirector:getChildByPath(self.Button_get, "Label_get")
    local Image_count = TFDirector:getChildByPath(Image_content, "Image_count")
    self.Label_count = TFDirector:getChildByPath(Image_count, "Label_count")
    self.Button_sub = TFDirector:getChildByPath(Image_count, "Button_sub")
    self.Button_add = TFDirector:getChildByPath(Image_count, "Button_add")

    self:refreshView()
end

function CoffeeRecoverView:refreshView()
    self.Label_title:setTextById(13410023)
    self.Label_tips_1:setTextById(13410024)
    self.Label_tips_2:setTextById(13410025)
    self.Image_maid_icon:setTexture(self.maidCfg_.icon1)
    local itemCfg = GoodsDataMgr:getItemCfg(self.itemCid_)
    self.Image_cost_icon:setTexture(itemCfg.icon)

    self:updateBatchPanel(0)
end

function CoffeeRecoverView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function CoffeeRecoverView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function CoffeeRecoverView:continueAddAction(addOrReduce)
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

function CoffeeRecoverView:continueReduceAction(addOrReduce)
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

function CoffeeRecoverView:updateBatchPanel(num)
    num = num or 0

    local haveCount = GoodsDataMgr:getItemCount(self.itemCid_)
    if haveCount > 0 then
        local maxCount = math.min(self.maxCount_, haveCount)
        self.count_ = clamp(self.count_ + num, 1, maxCount)
    else
        self.count_ = 1
    end

    local power = math.min(self.addPower_ * self.count_ + self.maidInfo_.strength, self.maidCfg_.strength)
    self.Label_power:setTextById(244277, CoffeeDataMgr:converPower(self.maidInfo_.strength), CoffeeDataMgr:converPower(power))
    self.Label_count:setTextById(800005, haveCount, self.count_)

    self.Button_recover:setVisible(haveCount > 0 and self.count_ > 0)
    self.Button_get:setVisible(haveCount == 0)
end

function CoffeeRecoverView:registerEvents()
    EventMgr:addEventListener(self, EV_COFFEE_MAID_FEED, handler(self.onFeedEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_recover:onClick(function()
            CoffeeDataMgr:send_MAID_ACTIVITY_REQ_FEED_MAID(self.maidId_, self.itemCid_, self.count_)
    end)

    self.Button_get:onClick(function()
            Utils:showAccess(self.itemCid_)
    end)

    self.Button_add:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                self:onTouchButtonUp()
                self:continueAddAction(true)
            end
    end)

    self.Button_sub:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil
            end
            if event.name == "began" then
                self:onTouchButtonDown()
                self:continueReduceAction(false)
            end
    end)
end

function CoffeeRecoverView:onFeedEvent()
    AlertManager:closeLayer(self)
end

function CoffeeRecoverView:onItemUpdateEvent()
    self:updateBatchPanel(0)
end

return CoffeeRecoverView

