local TokenPopViewNew = class("TokenPopViewNew", BaseLayer)

local GiftPos = {
    {{135,175}},
    {{90,175},{190,175}},
    {{135,183},{90,91},{190,91}},
    {{90,183},{190,183},{90,91},{190,91}}
}

function TokenPopViewNew:initDta(data, type)
    self.data = data or {}
    self.goodsId = data;
    self.goodsData = RechargeDataMgr:getOneRechargeCfg(self.goodsId);
    self.price = self.goodsData.exchangeCost[1].num;
    self.exchangeId = self.goodsData.exchangeCost[1].id;

    self.couponData = {};
    for __,_type in pairs(self.goodsData.packType or {}) do
        if _type == 1002 then
            local couponData = GoodsDataMgr:getItemsBySuperTyper(_type);
            for k,v in pairs(couponData) do
                table.insert(self.couponData,v);
            end
        end
    end

    table.sort(self.couponData,function (a,b)
                if a.cid == b.cid then
                    return a.outTime < b.outTime
                else
                    return a.cid < b.cid
                end
        end)

    -- 当前选中使用的优惠卷数量
    self.selectNum = 1
    -- 当前选中优惠卷id
    self.selectIdx = nil;

    self.selectCoupon = nil;

    self.selectAwards = {}

    self.listViewItems = {}
    self.awardViewItems = {}
end

function TokenPopViewNew:ctor(...)
    self.super.ctor(self)
    self:initDta(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.recharge.tokenPopViewNew")
end

function TokenPopViewNew:initUI(ui)
    self.super.initUI(self,ui) 

    self.listView = UIListView:create(self._ui.listview)
    self.listView:setItemsMargin(10)
    self:updateLeftView()

    self.awardView = UIListView:create(self._ui.awardView)
    self.awardView:setItemsMargin(5)
    self:updateAwardView()

    local exchangeCfg =  GoodsDataMgr:getItemCfg(self.exchangeId);
    self._ui.imgToken:setTexture(exchangeCfg.icon);
    self._ui.imgToken:setSize(CCSizeMake(45,45));

    TFDirector:getChildByPath(ui , "Label_tokenPopView_2"):hide()

    self:refreshBottomPannel();
end

function TokenPopViewNew:updateCountDown()
    local remainTime = math.max(0, self.selectCoupon.outTime - ServerDataMgr:getServerTime())
    if remainTime == 0 then
        self:removeCountDownTimer()
        self._ui.labShowTip2:setTextById(301010)
    else
        local day, hour, min = Utils:getTimeDHMZ(remainTime)
        self._ui.labShowTip2:setTextById(301005, day,hour, min)
    end
end

function TokenPopViewNew:onCountDownPer()
    self:updateCountDown()
end

function TokenPopViewNew:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function TokenPopViewNew:removeCountDownTimer()
    if self.countDownTimer_ then
        self._ui.labShowTip2:setText("")
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function TokenPopViewNew:registerEvents()
    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i, btn in ipairs(self._ui.pannelChooseBtns:getChildren()) do
        btn:onClick(function()
            if i ~= self.curChooseType then
                self.curChooseType = i
                self:updateLeftView()
            end
        end)
    end

    self._ui.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self._ui.Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self._ui.Button_max:onClick(function()
        local count = self:getOnceUseLimit()
        self:updateBatchPanel(count)
    end)

    self._ui.btnNotUse:onClick(function()
        for i, v in ipairs(self.listView:getItems()) do
            local item = self.listViewItems[v]
            item.imgSelect:hide();
        end
        self:removeCountDownTimer();
        self.oldLine = nil;
        self.oldrow  = nil;
        self.selectIdx = nil;
        self.selectCoupon = nil;
        self:refreshBottomPannel()
    end)

    -- 确定按钮
    self._ui.btnSure:onClick(function()
        if not self:checkTokenMoney() then
            Utils:showAccess(self.goodsData.exchangeCost[1].id)
            AlertManager:closeLayer(self)
            return;
        end

        if self.selectCoupon then
            RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(self.goodsId,self.selectCoupon.id)
        else
            RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(self.goodsId)
        end
        AlertManager:closeLayer(self)
    end)
end

function TokenPopViewNew:checkTokenMoney()
    local need = tonumber(self._ui.labTokenNum:getString())
    local have = GoodsDataMgr:getItemCount(self.goodsData.exchangeCost[1].id);
    dump({need,have})
    if need > have then
        return false;
    end

    return true;
end

function TokenPopViewNew:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function TokenPopViewNew:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function TokenPopViewNew:updateBatchPanel(num)
    self.selectNum = self.selectNum + num;
    if self.selectNum <= 1 then
        self.selectNum = 1
    end
    local count = self:getOnceUseLimit()
    if self.selectNum >= count then
        self.selectNum = count
    end
    self:setLabelNum(self.selectNum)
end

function TokenPopViewNew:getOnceUseLimit()
    return 555
end

function TokenPopViewNew:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function TokenPopViewNew:addItem()
    local item = self._ui.viewItem:clone()
    local tab = {}
    tab.rewards = {}
    tab.root = item
    tab.imgSelect = item:getChildByName("imgSelect")
    tab.imgSelect:setVisible(false)
    for i = 1, 4 do
        local foo = {}
        foo.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.goodsItem:setScale(0.7)
        foo.goodsItem:AddTo(item:getChildByName(string.format("itemPos%d",i))):Pos(0,0):ZO(-1)
        tab.rewards[i] = foo
    end
    self.listViewItems[tab.root] = tab
    return item
end

function TokenPopViewNew:updateLeftView()
    -- for i, btn in ipairs(self._ui.pannelChooseBtns:getChildren()) do
    --     local imgSelect = btn:getChildByName("imgSelect")
    --     imgSelect:setVisible(self.curChooseType == i)
    -- end

    local tt = #(self.couponData)--self.curChooseType == 1 and 0 or 9 --TODO
    self._ui.labNullShow:setVisible(tt == 0)
    if self.goodsData.packType then
        self._ui.labNullShow:setTextById(223508)
    else
        self._ui.labNullShow:setTextById(223509)
    end
    self._ui.labShowTip1:setVisible(not self._ui.labNullShow:isVisible())
    --self._ui.pannelContentRight:setVisible(not self._ui.labNullShow:isVisible())
    --self._ui.pannelbottom:setVisible(not self._ui.labNullShow:isVisible())

    local nums = math.ceil(tt / 4)
    local items = self.listView:getItems()
    local gap = nums - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local item = self:addItem()
            item:setName("item"..i)
            self.listView:pushBackCustomItem(item)
        end
    else
        for i = 1, math.abs(gap) do
            self.listView:removeItem(1)
        end
    end

    local index = 1;
    for i, v in ipairs(self.listView:getItems()) do
        item = self.listViewItems[v]
        for j, award in ipairs(item.rewards) do
            local lastLineNum =  tt - (i - 1)*4
            if lastLineNum >= j then
                PrefabDataMgr:setInfo(award.goodsItem, self.couponData[index].cid) --TODO
                award.goodsItem:show()
                award.goodsItem.idx = index;
                award.goodsItem:onClick(function(sender)
                    -- self.selectId = id  --TODO
                    self:chooseSelect(i,j,award.goodsItem.idx)
                end)
                index = index + 1;
            else
                award.goodsItem:hide()
            end
        end
    end
    if tt == 0 then 
        return
    end
    --self:chooseSelect(1,1,1)
end

function TokenPopViewNew:addAwardItem()
    -- local item = self._ui.awardViewItem:clone()
    -- local tab = {}
    -- tab.rewards = {}
    -- tab.root = item
    -- for i = 1, 2 do
    --     local foo = {}
    --     foo.diBg = item:getChildByName(string.format("imgDi_%d",i))
    --     foo.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    --     foo.goodsItem:setScale(0.7)
    --     foo.goodsItem:AddTo(foo.diBg):Pos(0,0):ZO(1)
    --     tab.rewards[i] = foo
    -- end
    -- self.awardViewItems[tab.root] = tab
    -- return item
end

function TokenPopViewNew:updateAwardView()
    -- local nums = math.ceil(#(self.goodsData.item) / 2)
    -- local items = self.awardView:getItems()
    -- local gap = nums - #items
    -- if gap > 0 then
    --     for i = 1, math.abs(gap) do
    --         local item = self:addAwardItem()
    --         item:setName("item"..i)
    --         self.awardView:pushBackCustomItem(item)
    --     end
    -- else
    --     for i = 1, math.abs(gap) do
    --         self.awardView:removeItem(1)
    --     end
    -- end

    -- local index = 1;
    -- for i, v in ipairs(self.awardView:getItems()) do
    --     item = self.awardViewItems[v]
    --     for j, award in ipairs(item.rewards) do
    --         local lastLineNum =  #(self.goodsData.item) - (i - 1) * 2
    --         if lastLineNum >= j then
    --             local id = self.goodsData.item[index].id
    --             PrefabDataMgr:setInfo(award.goodsItem, id, self.goodsData.item[index].num) --TODO
    --             --TFDirector:getChildByPath(award.goodsItem, "Image_frame"):hide();
    --             award.diBg:show()
    --             index = index + 1
    --         else
    --             award.diBg:hide()
    --         end
    --     end
    -- end

    local item = self.goodsData.item or {}
    local posIndex = #item;
    for k,v in pairs(item) do
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone();
        PrefabDataMgr:setInfo(item, v.id, v.num)
        item:setScale(0.8)
        self._ui.pannelContentRight:addChild(item);
        local pos = GiftPos[posIndex][k];
        item:setPosition(pos[1],pos[2]);
    end
end

-- 
function TokenPopViewNew:chooseSelect(line,row,index)
    local item, sender, imgSelect
    local function getByLr(_line, _row)
        item = self.listView:getItems()[_line]
        sender = item:getChildByName(string.format( "itemPos%d",_row))
        imgSelect = item:getChildByName("imgSelect")
    end
    if self.oldLine and  self.oldrow  then
        getByLr(self.oldLine, self.oldrow)
        imgSelect:setVisible(false)
    end
    getByLr(line, row)
    imgSelect:setPosition(sender:getPosition())
    imgSelect:setVisible(true)
    self.listView:doLayout()
    self.oldLine = line
    self.oldrow  = row

    self.selectIdx = index
    self:refreshBottomPannel()
end

function TokenPopViewNew:refreshBottomPannel()
    local oneCoupon,oneCouponCfg;
    if self.couponData and table.count(self.couponData) > 0 and self.selectIdx then
        oneCoupon = self.couponData[self.selectIdx];
        oneCouponCfg = GoodsDataMgr:getItemCfg(oneCoupon.cid)
        self._ui.labShowTip1:setTextById(oneCouponCfg.desTextId);
        self.selectCoupon = oneCoupon;
        self:addCountDownTimer();
    end

    local price = self.price;
    if oneCouponCfg then
        price = math.floor(price * oneCouponCfg.useProfit.discount / 100 );
        if price < 1 then
            price = 1;
        end
    end

    self._ui.labTokenNum:setString(price)
end

function TokenPopViewNew:removeUI()
    self:removeCountDownTimer();
end

return TokenPopViewNew