
local SummonBuyResourceView = class("SummonBuyResourceView", BaseLayer)

function SummonBuyResourceView:initData(commodityCid, buyCount, desTxtId)
    self.commodityCid_ = commodityCid
    self.commodityCfg_ = StoreDataMgr:getCommodityCfg(commodityCid)
    self.buyCount_ = buyCount
    self.desTxtId = desTxtId or 1200048
    local goods = self.commodityCfg_.goodInfo[1]
    local itemId, itemCount = goods.id, goods.num
    self.itemCid_, self.itemCount_ = goods.id, goods.num

    local costId = self.commodityCfg_.priceType
    local costNum = self.commodityCfg_.priceVal
    self.costCid_ = costId[1]
    self.costNum_ = costNum[1] *  buyCount
end

function SummonBuyResourceView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.buyResourceView")
end

function SummonBuyResourceView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_bg, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Label_remainCount = TFDirector:getChildByPath(Image_bg, "Label_remainCount")
    self.Label_tips = TFDirector:getChildByPath(Image_bg, "Label_tips"):hide()

    self.Image_costIcon = TFDirector:getChildByPath(Image_bg, "Image_costIcon")
    self.Label_costNum = TFDirector:getChildByPath(self.Image_costIcon, "Label_costNum")
    self.Image_targetIcon = TFDirector:getChildByPath(Image_bg, "Image_targetIcon")
    self.Label_targetNum = TFDirector:getChildByPath(self.Image_targetIcon, "Label_targetNum")
    self.Label_targetItemDesc = TFDirector:getChildByPath(Image_bg, "Label_targetItemDesc")
    self:refreshView()
end

function SummonBuyResourceView:refreshView()
    self.Label_title:setTextById(800020)

    local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.costCid_)
    Panel_goodsItem:setPosition(ccp(0,0))
    Panel_goodsItem:setScale(0.8)
    self.Image_costIcon:addChild(Panel_goodsItem)
    self.Label_costNum:setText(self.costNum_)

    --兑换物
    local targetItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(targetItem, self.itemCid_)
    targetItem:setPosition(ccp(0,0))
    targetItem:setScale(0.8)
    self.Image_targetIcon:addChild(targetItem)
    self.Label_targetNum:setText(self.itemCount_ * self.buyCount_)

    --描述
    self.Label_targetItemDesc:setTextById(self.desTxtId, self.buyCount_)
end

function SummonBuyResourceView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuyResourceEvent, self))

    self.Button_close:onClick(
        function()
            AlertManager:close()
        end, EC_BTN.CLOSE)

    self.Button_ok:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                StoreDataMgr:send_STORE_BUY_GOODS(self.commodityCid_, self.buyCount_)
            else
                Utils:showAccess(self.costCid_)
            end
    end)
end

function SummonBuyResourceView:onBuyResourceEvent(data)
    -- local commodityId = data.cid
    -- local commodityNum = data.num
    -- local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    -- local goods = commodityCfg.goods
    -- local goodsId, goodsCount
    -- for k, v in pairs(goods) do
    --     goodsId = k
    --     goodsCount = v
    --     break
    -- end
    -- goodsCount = goodsCount * commodityNum

    -- local rewardList = {
    --     Utils:makeRewardItem(goodsId, goodsCount)
    -- }
    local rewardList = {}
    for k,v in pairs(data.goods) do
        table.insert(rewardList,Utils:makeRewardItem(v.id, v.num))
    end
    Utils:showReward(rewardList)
    AlertManager:closeLayer(self)
end

return SummonBuyResourceView
