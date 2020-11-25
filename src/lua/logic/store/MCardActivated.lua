
local MCardActivated = class("MCardActivated", BaseLayer)

local CardType = {
    MonthCard = 1,
    MonthCardEx = 2,
    --SeasonCard = 2,
    --HalfYearCard = 3,
}
 
function MCardActivated:initData()
    local cardData = RechargeDataMgr:getMonthCardList()
    local cardType = CardType.MonthCard
    self.cardData_ = cardData[cardType]
end

function MCardActivated:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.mCardActivated")
end

function MCardActivated:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_remain_days = TFDirector:getChildByPath(Image_content, "Label_remain_days")
    self.Button_Go = TFDirector:getChildByPath(Image_content, "Button_Go")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_headname = TFDirector:getChildByPath(Image_content,"Label_headname")
    self.Image_head = TFDirector:getChildByPath(Image_content,"Image_head")
    self.listView = TFDirector:getChildByPath(Image_content,"ScrollView_mCardActivated_1")
    self.listView = UIListView:create(self.listView)
    self.listView:setItemsMargin(30)

    local leftTime = RechargeDataMgr:getMonthCardLeftTime()
    self.Label_remain_days:setString(leftTime)


    local extraData = AvatarDataMgr:getExtraData()
    local month = extraData.month or 1
    local data = TabDataMgr:getData("Portrait",10003);
    local findData = nil
    for k,v in pairs(data.toggle) do
        for k2,v2 in pairs(v) do
            if k2 == "month" then
                if month >= v2[1] and month <= v2[2] then
                    findData = v;
                    break;
                end
            end
        end
    end
    if findData then 
        self.Image_head:setTexture(findData.icon);
        self.Label_headname:setTextById(findData.name);
    else
        self.Image_head:setTexture(data.icon);
        self.Label_headname:setTextById(data.name);
    end
    self.Image_head:setScale(0.6)
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local rewards = TabDataMgr:getData("MonthCardSign",1).baseReward;
    for k,v in pairs(rewards) do
        local item = self.Panel_goodsItem_prefab:clone();
        PrefabDataMgr:setInfo(item, k, v)
        item:setScale(0.8)
        self.listView:pushBackCustomItem(item);
    end
end


function MCardActivated:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_Go:onClick(function()
            --Utils:openView("store.GiftPackMainView", 2)
            AlertManager:closeLayer(self)
            EventMgr:dispatchEvent(EV_MONTHCARD_RECHARGE_SUCESS)
			Utils:openView("supplyNew.SupplyMainNewView", 3)
    end)
end

return MCardActivated
