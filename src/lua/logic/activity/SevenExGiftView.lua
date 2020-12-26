
local SevenExGiftView = class("SevenExGiftView", BaseLayer)

function SevenExGiftView:initData(dayTag)

    self.sevenGiftBag = RechargeDataMgr:getSevenGiftBag(dayTag)
    if not self.sevenGiftBag then
        return
    end
    dump(self.sevenGiftBag)
    self.selectSevenExIdx = dayTag;
    self.itemList_ = {}
    for k,v in pairs(self.sevenGiftBag.item) do
        local rewardItem = {};
        rewardItem.id = v.id;
        rewardItem.num = v.num;
        table.insert(self.itemList_,rewardItem);
    end

    self.columnNum_ = 5
    self.itemColMargin_ = 0
    self.itemRowMargin_ = 0
    self.goodsItem_ = {}
end

function SevenExGiftView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.sevenExGiftView")
end

function SevenExGiftView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Button_cancel = TFDirector:getChildByPath(ui, "Button_cancel");
    self.Button_sEx_buy = TFDirector:getChildByPath(ui, "Button_sEx_buy");
    if not self.sevenGiftBag then
        return
    end
    local curDayTag = ActivityDataMgr:getSevenExCurDayTag();
    if (self.sevenGiftBag.buyCount ~= 0 and self.sevenGiftBag.buyCount - RechargeDataMgr:getBuyCount(self.sevenGiftBag.rechargeCfg.id) <= 0) or self.selectSevenExIdx > curDayTag then
        self.Button_sEx_buy:setGrayEnabled(true)
        self.Button_sEx_buy:setTouchEnabled(false)
    else
        self.Button_sEx_buy:setGrayEnabled(false)
        self.Button_sEx_buy:setTouchEnabled(true)
    end

    local Label_price_now = TFDirector:getChildByPath(self.Button_sEx_buy,"Label_price_now");
    Label_price_now:setString(self.sevenGiftBag.exchangeCost[1].num)


    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_content, "ScrollView_reward")
    --self.ListView_reward = UIListView:create(ScrollView_reward)
    --self.ListView_reward:setItemsMargin(20)
    local itemCount = #self.itemList_

    local offW = 0
    local offH = 0
    if self.columnNum_ >= itemCount then
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * itemCount
        offH = self.Panel_goodsItem_prefab:Size().height + self.itemRowMargin_
    else
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * self.columnNum_
        offH = ScrollView_reward:getSize().height
    end
    ScrollView_reward:setContentSize(CCSize(offW, offH))

    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)
    self.GridView_reward:setColumn(self.columnNum_)
    self.GridView_reward:setColumnMargin(self.itemColMargin_)
    self.GridView_reward:setRowMargin(self.itemRowMargin_)

    self.Panel_goodsRowItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsRowItem")

    self:refreshView()
end

function SevenExGiftView:refreshView()
    --local itemMargin = 10
    --local goodsItemSize = self.Panel_goodsItem_prefab:Size()
    --local goodsItemAp = self.Panel_goodsItem_prefab:AnchorPoint()

    for i, v in ipairs(self.itemList_) do
        local data = v
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, data.id, data.num)
        table.insert(self.goodsItem_, Panel_goodsItem)
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    --local row = 0
    --for i = 1, #self.itemList_, self.columnNum_ do
    --    row = row + 1
    --    self.goodsItem_[row] = {}
    --    local Panel_goodsRowItem = self.Panel_goodsRowItem:clone()
    --    local width = 0
    --    for j = i, math.min(i + self.columnNum_ - 1, #self.itemList_) do
    --        local data = self.itemList_[j]
    --        local Panel_goodsItem = Panel_goodsItem_prefab:clone()
    --        PrefabDataMgr:setInfo(Panel_goodsItem, data.id, data.num)
    --        local remain = math.fmod(j, self.columnNum_)
    --        if remain == 0 then remain = 5 end
    --        local x = (goodsItemSize.width + itemMargin) * (remain - 1) + goodsItemSize.width * goodsItemAp.x
    --        local y = 0
    --        Panel_goodsItem:Pos(x, y)
    --        Panel_goodsItem:AddTo(Panel_goodsRowItem)
    --        width = x
    --        table.insert(self.goodsItem_[row], Panel_goodsItem)
    --    end
    --    width = width + goodsItemSize.width * (1 - goodsItemAp.x)
    --    local originSize = Panel_goodsRowItem:Size()
    --    local size = CCSize(width, originSize.height)
    --    Panel_goodsRowItem:Size(size)
    --    self.ListView_reward:pushBackCustomItem(Panel_goodsRowItem)
    --end
    --Utils:setAliginCenterByListView(self.GridView_reward, false)

    self:playAni()
    Utils:playSound(501)
end

function SevenExGiftView:playAni()
    local delay = 0
    --local offsetX = 500
    local offsetX = self.Panel_goodsItem_prefab:Size().width * 0.5
    for row, items in ipairs(self.goodsItem_) do
        --for _, item in ipairs(items) do
            local item = items
            --item:hide()
            item:Alpha(0)

            delay = delay + 0.05
            local seq = Sequence:create({
                    DelayTime:create(delay),
                    CallFunc:create(function()
                        item:PosX(item:PosX() - offsetX)
                    end),
                    Spawn:create({
                            --CallFunc:create(function()
                            --        item:show()
                            --end),
                            CCFadeIn:create(0.2),
                            MoveBy:create(0.2, ccp(offsetX, 0)),
                            --Sequence:create({
                            --        ScaleTo:create(0.05, 1.5),
                            --        DelayTime:create(0.1),
                            --        ScaleTo:create(0.05, 1.0),
                            --}),
                    })
            })
            item:runAction(seq)
        --end
    end
end

function SevenExGiftView:registerEvents()
    self.Button_cancel:onClick(function()
            AlertManager:closeLayer(self);
        end);

    self.ui:setTouchEnabled(true)
    self.ui:onClick(function()
            AlertManager:closeLayer(self);
        end);

    self.Button_sEx_buy:onClick(function()
        if self.sevenGiftBag.buyCount ~= 0 and self.sevenGiftBag.buyCount - RechargeDataMgr:getBuyCount(self.sevenGiftBag.rechargeCfg.id) <= 0 then
            Utils:showTips(800117);
        else
            RechargeDataMgr:getOrderNO(self.sevenGiftBag.rechargeCfg.id)
            AlertManager:closeLayer(self)
        end
    end)
end

function SevenExGiftView:onShow()
    self.super.onShow(self)
end

return SevenExGiftView
