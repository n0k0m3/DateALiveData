
local BuyConfirmView2 = class("BuyConfirmView2", BaseLayer)

function BuyConfirmView2:initData(commodityId)
    self.commodityId_ = commodityId
    self.commodityCfg_ = RechargeDataMgr:getOneRechargeCfg(commodityId)
    self.selectNum = 1
	EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.onBuySuccessEvent, self))
end

function BuyConfirmView2:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.store.buyConfirmView")
end

function BuyConfirmView2:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Image_head = TFDirector:getChildByPath(Image_bg, "Image_head")
    self.Label_name = TFDirector:getChildByPath(Image_bg, "Label_name")
    self.Label_count = TFDirector:getChildByPath(Image_bg, "Label_count")
	self.Label_count:setVisible(false)
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

local RewardPos = {
	[1] = {pos = {{x=0,	  y=0}},										scale = 1},
	[2] = {pos = {{x=-60, y=0}, {x=60,y=0}},							scale = 1},
	[3] = {pos = {{x=-100,y=0}, {x=0, y=0},{x=100,y=0}},				scale = 0.8},
	--[4] = {pos = {{x=-75, y=30},{x=75,y=30},{x=-75,y=-40},{x=75,y=-40}},scale = 0.65}
	[4] = {pos = {{x=-128, y=0},{x=43,y=0},{x=-43,y=-0},{x=128,y=-0}},  scale = 0.75}
}

function BuyConfirmView2:refreshView()
	self.listView = UIListView:create(self._ui.rewardList)
	self.commodityCfg_.item = self.commodityCfg_.item or {}
	local PosIdx = #self.commodityCfg_.item or 1
	for k, v  in pairs(self.commodityCfg_.item) do
		local itemCfg = GoodsDataMgr:getItemCfg(v.id)
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		Panel_goodsItem:setTouchEnabled(false)
		PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
		local pos = RewardPos[PosIdx]["pos"][k]
		Panel_goodsItem:Pos(pos):AddTo(self.Image_head)
		Panel_goodsItem:setScale(RewardPos[PosIdx]["scale"])
	end
    self.Label_desc:setText(self.commodityCfg_.des3)
    --self.Label_name:setTextById(itemCfg.nameTextId)
	
    self.Panel_batch:setVisible(true)
    if true then
        self.selectNum = 1
        self:updateBatchPanel(0)
    end
end

function BuyConfirmView2:onClose()
    self.super.onClose(self)

    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function BuyConfirmView2:currencyIsEnough()
	local enough = true
	for i = 1, #self.commodityCfg_.exchangeCost do
		local cost = self.commodityCfg_.exchangeCost[i]
        local haveNum = GoodsDataMgr:getItemCount(cost["id"])
        if haveNum < cost["num"] * self.selectNum then
			enough = false
			break;
		end     
    end
	return enough
end

function BuyConfirmView2:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))

    self.Button_buy:onClick(function()

            if not self:currencyIsEnough() then
                Utils:showAccess(self.commodityCfg_.exchangeCost[1].id)
                return
            end
            RechargeDataMgr:RECHARGE_REQ_CHARGE_EXCHANGE(self.commodityId_,"",0,"", self.selectNum)
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
            local count = self:getMaxBuyCount()
            self:updateBatchPanel(count)
    end)
end

function BuyConfirmView2:getMaxBuyCount()
	local coinNum = 0;
	local Cost = self.commodityCfg_.exchangeCost

    local buyCount = INT_MAXVALUE
    for i = 1, #self.commodityCfg_.exchangeCost do
		local cost = self.commodityCfg_.exchangeCost[i]
        local haveNum = GoodsDataMgr:getItemCount(cost["id"])
        local count = math.floor(haveNum / cost["num"])
        if buyCount then
            buyCount = math.min(buyCount, count)
        else
            buyCount = count
        end
    end
    if self.commodityCfg_.buyCount ~= 0 then
        --限购
        local sellCount = RechargeDataMgr:getBuyCount(self.commodityId_) 
        local leftCount = self.commodityCfg_.buyCount - sellCount
        if leftCount < 0 then leftCount = 0 end
        buyCount = math.min(buyCount, leftCount)
    end
    return buyCount
end

function BuyConfirmView2:continueAddAction(addOrReduce)
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

function BuyConfirmView2:continueReduceAction(addOrReduce)
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

function BuyConfirmView2:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function BuyConfirmView2:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function BuyConfirmView2:updateBatchPanel(num)
    self.selectNum = self.selectNum + num

    local leftTimes =  self.commodityCfg_["buyCount"]
    local count = self:getMaxBuyCount()

    if self.selectNum <= 1 then
        self.selectNum = 1
    end

    if leftTimes then
        count = math.min(count, leftTimes)
    end
    if self.selectNum >= count then
        self.selectNum = count
    end
	if self.selectNum <= 1 then
        self.selectNum = 1
    end
    self.Label_num:setString(self.selectNum)
end

function BuyConfirmView2:onBuySuccessEvent(data)
	AlertManager:closeLayer(self)
end

return BuyConfirmView2
