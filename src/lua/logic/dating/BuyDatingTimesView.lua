local BuyDatingTimesView = class("BuyDatingTimesView",BaseLayer)

function BuyDatingTimesView:ctor(itemId)
    self.super.ctor(self,itemId)

    self:initData(itemId)
    self:init("lua.uiconfig.dating.buyDatingTimesView")
end

function BuyDatingTimesView:initData(itemId)
    self.times_ = DatingDataMgr:getDayDatingTimes()
    self.itemId_ = itemId
    self.itemCfg_ = GoodsDataMgr:getItemCfg(itemId)
    self.itemRecoverCfg_ = StoreDataMgr:getItemRecoverCfg(self.itemCfg_.buyItemRecover)
end

function BuyDatingTimesView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Button_ok = TFDirector:getChildByPath(ui,"Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self.Label_times = TFDirector:getChildByPath(ui, "Label_times")
    self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
    self.Label_name = TFDirector:getChildByPath(self.Image_icon,"Label_name")
    self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
    self.Label_times2 = TFDirector:getChildByPath(ui, "Label_times2")
    self.Label_targetNum = TFDirector:getChildByPath(ui,"Label_targetNum")

    self:refreshUI()
end

function BuyDatingTimesView:refreshUI()

    self.Label_times:setText(self.times_)

    local targetName = TextDataMgr:getText(self.itemCfg_.nameTextId)
    local buyCount = StoreDataMgr:getItemRecoverBuyCount(self.itemCfg_.buyItemRecover)
    local remainCount = math.max(0, #self.itemRecoverCfg_.price - buyCount)

    local cost = self.itemRecoverCfg_.price[buyCount + 1][1]
    local costCfg = GoodsDataMgr:getItemCfg(cost[1].id)

    local costName = TextDataMgr:getText(costCfg.nameTextId)
    --self.Label_des:setTextById("r50001", costName, targetName, remainCount)

    local code = TFLanguageMgr:getUsingLanguage()
    if not((code == cc.SIMPLIFIED_CHINESE) or (code == cc.TRADITIONAL_CHINESE)) then
        self.Label_des:setTextById(190000059)
    end
    self.Label_times2:setText(remainCount)

    self.Image_icon:setTexture(costCfg.icon)
    --self.Label_name:setText(costName .. " x " .. cost[1].num)

    --self.Label_targetNum:setTextById("900217",cost.targetNum) -- 暂时不动态设置次数

end
function BuyDatingTimesView:onClose()
    self.super.onClose(self)
end

function BuyDatingTimesView:registerEvents()

    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuyResourceEvent, self))

    self.Button_ok:onClick(function()
        local count = GoodsDataMgr:getItemCount(self.itemId_)
        if count < self.itemCfg_.totalMax then
            local costNum = GoodsDataMgr:getItemCount(570032)
            if costNum == 0 then
                Utils:showInfo(570032,nil,true)
            else
                DatingDataMgr:buyDayDatingTimes()
            end
        else
            Utils:showTips(900210)
        end
    end)
    self.Button_close:onClick(function()
        AlertManager:close()
    end)
end

function BuyDatingTimesView:onBuyResourceEvent()
    Utils:showTips(900211)
    self.Button_ok:Touchable(false)
    self.Button_close:Touchable(false)
    self.ui:timeOut(function()
        AlertManager:close()
    end,1.2)
end

return BuyDatingTimesView;
