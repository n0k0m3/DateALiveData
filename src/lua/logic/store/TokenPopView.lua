local TokenPopView = class("TokenPopView", BaseLayer)

local GiftPos = {
    {{135,175}},
    {{90,175},{190,175}},
    {{135,183},{90,91},{190,91}},
    {{90,183},{190,183},{90,91},{190,91}}
}
local SuperType = {
	daily = 64,
	common = 65
}

function TokenPopView:initDta(data, defaultPrice)
    self.data = data or {}
    self.goodsId = data;
	self.defaultPrice = defaultPrice
    self.goodsData = RechargeDataMgr:getOneRechargeCfg(self.goodsId);
    self.price = self.defaultPrice or self.goodsData.exchangeCost[1].num;
    self.exchangeId = self.goodsData.exchangeCost[1].id;

    self.couponData = {[SuperType.common] = {},  [SuperType.daily] = {}};
    for __,_type in pairs(SuperType) do
		self.couponData[_type] = {}
        local couponData = GoodsDataMgr:getItemsBySuperTyper(_type);
        for k,v in pairs(couponData) do
            table.insert(self.couponData[_type],v);
        end
    end

	for k, v in pairs(self.couponData) do
		table.sort(v,function (a,b)
                if a.cid == b.cid then
                    return a.outTime < b.outTime
                else
                    return a.cid < b.cid
                end
        end)
	end
   
    -- 当前选中使用的优惠卷数量
    self.selectNum = 1
    -- 当前选中优惠卷id
    self.selectIdx = nil;
	self.curTab = SuperType.daily

    self.selectCoupon = nil;
	self.selectItem = nil
	
    self.selectAwards = {}

    self.listViewItems = {}
    self.awardViewItems = {}
end

function TokenPopView:ctor(...)
    self.super.ctor(self)
    self:initDta(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.recharge.tokenPopView")
end

function TokenPopView:initUI(ui)
    self.super.initUI(self,ui) 

	self.Image_tokenPopView_1 = ui:getChildByName("Image_tokenPopView_1")
	self.Image_tokenPopView_1:setVisible(true)
	self.Image_tokenPopView_2 = ui:getChildByName("Image_tokenPopView_2")
	self.Image_tokenPopView_2:setVisible(false)

    self.listView = UIListView:create(self._ui.listview)
    self.listView:setItemsMargin(3)
    self:updateLeftView()

	self.btn1Image = self._ui.btn1:getChildByName("imgSelect")
	self.btn1Image:setVisible(true)
	self.btn2Image = self._ui.btn2:getChildByName("imgSelect")
	self.btn2Image:setVisible(false)

    self.awardView = UIListView:create(self._ui.awardView)
    self.awardView:setItemsMargin(5)
    self:updateAwardView()

    local exchangeCfg =  GoodsDataMgr:getItemCfg(self.exchangeId);
    self._ui.imgToken:setTexture(exchangeCfg.icon);
    self._ui.imgToken:setSize(CCSizeMake(45,45));

	self._ui.imgTokenDiscount:setTexture(exchangeCfg.icon);
	self._ui.imgTokenDiscount:setSize(CCSizeMake(45,45));

	self._ui.originPriceIcon:setTexture(exchangeCfg.icon);
    self._ui.originPriceIcon:setSize(CCSizeMake(45,45));

    self:refreshBottomPannel();
	self:addCountDownTimer()
	self:setBuyLimitTips()
end

function TokenPopView:setBuyLimitTips()
  	local exsit = true
	for __,_type in pairs(self.goodsData.packType or {}) do
		if _type == SuperType.daily then
			exsit = false
			break;
		end
	end
	if exsit then
		self._ui.useLimitTip:setVisible(true)
		self._ui.useLimitTip:setTextById(14220110)
	else
		self._ui.useLimitTip:setVisible(false)
	end
end

function TokenPopView:updateCountDown()
	for k,v in pairs(self.listViewItems) do
		local remainTime = math.max(0, v.Coupon.outTime - ServerDataMgr:getServerTime())
		if remainTime == 0 then
--		    self:removeCountDownTimer()
		    v.time:setTextById(301010)			
		else
			
		    local day, hour, min = Utils:getTimeDHMZ(remainTime)
		    v.time:setTextById(800044, day,hour, min)
			v.time:setVisible(true)
		end
		v.remainTime = remainTime
	end
end

function TokenPopView:onCountDownPer()
    self:updateCountDown()
end

function TokenPopView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function TokenPopView:removeCountDownTimer()
    if self.countDownTimer_ then
        self._ui.labShowTip2:setText("")
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function TokenPopView:registerEvents()
    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i, btn in ipairs(self._ui.pannelChooseBtns:getChildren()) do
        btn:onClick(function()
            if i ~= self.curChooseType then
                self.curChooseType = i
				if SuperType.daily == self.curTab then
					self.curTab = SuperType.common
				else
					self.curTab = SuperType.daily
				end
                self:updateLeftView()
				self:refreshBottomPannel()
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
--        self:removeCountDownTimer();
        self.oldLine = nil;
        self.oldrow  = nil;
        self.selectIdx = nil;
        self.selectCoupon = nil; 
		if self.selectItem then    
			self.selectItem.imgSelect:setVisible(false)
			self.selectItem = nil
		end
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

function TokenPopView:checkTokenMoney()
    local need = tonumber(self._ui.labTokenNum:getString())
    local have = GoodsDataMgr:getItemCount(self.goodsData.exchangeCost[1].id);
    dump({need,have})
    if need > have then
        return false;
    end

    return true;
end

function TokenPopView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function TokenPopView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function TokenPopView:updateBatchPanel(num)
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

function TokenPopView:getOnceUseLimit()
    return 555
end

function TokenPopView:holdDownAction(isAddOp)
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

function TokenPopView:addItem(idx)

    local item = self._ui.Panel_cardItem:clone()
    local tab = {}
    tab.rewards = {}
	tab.remainTime = 1
	tab.idx = idx
    tab.root = item
	tab.root:setTouchEnabled(true)
--	tab.root:setSwallowTouches(true)
    tab.imgSelect = item:getChildByName("imgSelect")
    tab.imgSelect:setVisible(false)

    tab.icon = item:getChildByName("icon")
    tab.icon:setVisible(true)
	local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	goodsItem:AddTo(tab.icon)
	goodsItem:setPosition(0,0)
	goodsItem:setScale(0.9)

	local Coupon = self.couponData[self.curTab][tab.idx];
    local CouponCfg = GoodsDataMgr:getItemCfg(Coupon.cid)
	tab.Coupon = Coupon
	tab.CouponCfg = CouponCfg
	tab.time = item:getChildByName("time")
	tab.des = item:getChildByName("des")	
	tab.des:setTextById(CouponCfg.desTextId)
	PrefabDataMgr:set_Panel_goodsItem(goodsItem, Coupon.cid)

	tab.name = item:getChildByName("name")
	tab.name:setTextById(CouponCfg.nameTextId)
    self.listViewItems[tab.root] = tab
    return item
end

function TokenPopView:updateLeftView()
     for i, btn in ipairs(self._ui.pannelChooseBtns:getChildren()) do
         local imgSelect = btn:getChildByName("imgSelect")
         imgSelect:setVisible(self.curChooseType == i)
     end

    local tt = #(self.couponData[self.curTab])--self.curChooseType == 1 and 0 or 9 --TODO
    self._ui.labNullShow:setVisible(tt == 0)
    if self.goodsData.packType then
        self._ui.labNullShow:setTextById(223508)
    else
        self._ui.labNullShow:setTextById(223509)
    end

	self.listView:removeAllItems()
	self.listViewItems = {}
	self.selectItem = nil
	self.selectIdx = nil
    if tt > 0 then
        for i = 1, math.abs(tt) do
            local item = self:addItem(i)
            item:setName("item"..i)
            self.listView:pushBackCustomItem(item)
        end
    else
--        for i = 1, math.abs(gap) do
--            self.listView:removeItem(1)
--        end
    end

	if table.indexOf(self.goodsData.packType or {}, self.curTab) == -1  then
		self._ui.touch_mask:setVisible(tt > 0)
		self._ui.maskTip:setTextById(14220110)
		self._ui.maskTip:setVisible(tt > 0)
	else
		self._ui.touch_mask:setVisible(false)
		self._ui.maskTip:setVisible(false)
	end

    local index = 1;
    for i, v in ipairs(self.listView:getItems()) do
        local tab = self.listViewItems[v]

		tab.root:onClick(function(sender)
            self:chooseSelect(tab)		
        end)
		
    end
    if tt == 0 then 
        return
    end
    --self:chooseSelect(1,1,1)
end

function TokenPopView:addAwardItem()
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

function TokenPopView:updateAwardView()

    local item = self.goodsData.item or {}
    local posIndex = #item;
    for k,v in pairs(item) do
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone();
        PrefabDataMgr:setInfo(item, v.id, v.num)
        item:setScale(0.8)
        self._ui.pannelContentRight:addChild(item);
        local pos = GiftPos[posIndex][k];
        item:setPosition(pos[1] +40,pos[2]);
    end
end

-- 
function TokenPopView:chooseSelect(tab)
    self.selectIdx = tab.idx  
	if self.selectItem then
		self.selectItem.imgSelect:setVisible(false)
	end
	tab.imgSelect:setVisible(true)
	self.selectItem = tab

	self:refreshBottomPannel()
end

function TokenPopView:refreshBottomPannel()
    local oneCoupon,oneCouponCfg;
    if self.couponData and self.couponData[self.curTab] and table.count(self.couponData[self.curTab]) > 0 and self.selectIdx then
        oneCoupon = self.couponData[self.curTab][self.selectIdx];
        oneCouponCfg = GoodsDataMgr:getItemCfg(oneCoupon.cid)
        self._ui.labShowTip1:setTextById(oneCouponCfg.desTextId);
        self.selectCoupon = oneCoupon;
--        self:addCountDownTimer();

		self._ui.discountScale:setTextById(277004, math.floor(oneCouponCfg.useProfit.discount / 10 ))
    end

    local price = self.price;
    if oneCouponCfg then
        price = math.floor(price * oneCouponCfg.useProfit.discount / 100 );
        if price < 1 then
            price = 1;
        end
    end

    self._ui.labTokenNum:setString(price)
	self._ui.originPriceLab:setString(self.price)
	self._ui.labTokenNumDiscount:setString(price)

	self.Image_tokenPopView_1:setVisible(not self.selectItem or self.selectItem.remainTime <= 0)
	self.Image_tokenPopView_2:setVisible(self.selectItem and self.selectItem.remainTime > 0)
end

function TokenPopView:removeUI()
    self:removeCountDownTimer();
end

return TokenPopView