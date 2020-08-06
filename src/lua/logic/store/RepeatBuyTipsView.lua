
local RepeatBuyTipsView = class("RepeatBuyTipsView", BaseLayer)

function RepeatBuyTipsView:initData(commodityCid)
    self.commodityCid_ = commodityCid
    self.commodityCfg_ = StoreDataMgr:getCommodityCfg(self.commodityCid_)
    local goods = self.commodityCfg_.goodInfo[1]
    self.goodsCid_, self.goodsCount_ = goods.id, goods.num
    self.goodsCfg_ = GoodsDataMgr:getItemCfg(self.goodsCid_)
end

function RepeatBuyTipsView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.store.repeatBuyTipsView")
end

function RepeatBuyTipsView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(Image_content, "Button_ok")
    self.Label_ok = TFDirector:getChildByPath(self.Button_ok, "Label_ok")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_icon")
    self.Label_count = TFDirector:getChildByPath(Image_content, "Label_count")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")

    self:refreshView()
end

function RepeatBuyTipsView:refreshView()
    self.Label_ok:setTextById(800010)
    self.Label_tips:setTextById(302208)
    self.Label_name:setTextById(302207)

    -- 购买大富翁道具卡的提示
    if (self.goodsCfg_.superType == EC_ResourceType.DFW_NEW_CARD) then
        self.Label_tips:setTextById(190000040)
    end

    local convertCid, converNum = next(self.goodsCfg_.convertMax)
    convertCfg = GoodsDataMgr:getItemCfg(convertCid)
    self.Image_icon:setTexture(convertCfg.icon)
    self.Label_count:setTextById(800007, converNum * self.goodsCount_)

    self.Image_icon:onClick(function()
            Utils:showInfo(convertCid)
    end)
end

function RepeatBuyTipsView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))

    self.Button_ok:onClick(function()
            if not StoreDataMgr:currencyIsEnough(self.commodityCid_, 1) then
                Utils:showTips(302200)
                return
            end
            StoreDataMgr:send_STORE_BUY_GOODS(self.commodityCid_, 1)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

function RepeatBuyTipsView:onBuySuccessEvent(data)
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

    AlertManager:close()
    Utils:showReward(rewardList)
end

return RepeatBuyTipsView

