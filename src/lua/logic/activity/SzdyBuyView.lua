--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local SzdyBuyView = class("SzdyBuyView", BaseLayer)
function SzdyBuyView:ctor(...)
	self.super.ctor(self)

	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.szdyBuyView")

end

function SzdyBuyView:initData(commodityId)
    self.commodityId_ = commodityId

	self.itemId_, self.itemCount_ = self.commodityId_, GoodsDataMgr:getItemCount(self.commodityId_)
    self.selectNum = 1
	
	self.itemCfg_ = GoodsDataMgr:getItemCfg(self.commodityId_)
   	self.itemRecoverCfg = TabDataMgr:getData("ItemRecover",self.itemCfg_.buyItemRecover)
	self.buyInfo = self.itemRecoverCfg.price[1][1]

	self:caculateMaxBuyCount()
end

function SzdyBuyView:caculateMaxBuyCount()
	self.maxBuyCount = math.floor(GoodsDataMgr:getItemCount(self.buyInfo[1].id) / self.buyInfo[1].num)
	if self.maxBuyCount >= 100 then
		self.maxBuyCount = 100
	end
end

function SzdyBuyView:initUI(ui)
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
    self.Button_max		= TFDirector:getChildByPath(self.Panel_batch, "Button_max")
    self.Label_num      = TFDirector:getChildByPath(Image_bg,"Label_num") 

	self.Label_cost_num = TFDirector:getChildByPath(Image_bg,"Label_cost_num") 

    self:refreshView()
end

function SzdyBuyView:refreshView()
    local itemCfg = GoodsDataMgr:getItemCfg(self.itemId_)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.itemId_, self.itemCount_)
    Panel_goodsItem:Pos(0, 0):AddTo(self.Image_head)
	TFDirector:getChildByPath(Panel_goodsItem, "Label_count"):Hide()

    self.Label_name:setTextById(itemCfg.nameTextId)

    local count = GoodsDataMgr:getItemCount(self.itemId_)
    self.Label_count:setTextById(301013, count)

	self:updateBatchPanel(0)
end

function SzdyBuyView:onClose()
    self.super.onClose(self)

    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function SzdyBuyView:registerEvents()
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuySuccessEvent, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
		self:caculateMaxBuyCount()
		self:updateBatchPanel(0)
		local count = GoodsDataMgr:getItemCount(self.itemId_)
		self.Label_count:setTextById(301013, count)
	end)

    self.Button_buy:onClick(function()
			local hasNum = GoodsDataMgr:getItemCount(self.buyInfo[1].id)
            if self.selectNum == 0 or self.selectNum * self.buyInfo[1].num > hasNum then
               Utils:showAccess(self.buyInfo[1].id)
                return
            end
            StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(self.itemRecoverCfg.id, self.selectNum)
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
            self:updateBatchPanel(self.maxBuyCount)
    end)
end

function SzdyBuyView:continueAddAction(addOrReduce)
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

function SzdyBuyView:continueReduceAction(addOrReduce)
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

function SzdyBuyView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function SzdyBuyView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function SzdyBuyView:updateBatchPanel(num)
    self.selectNum = self.selectNum + num

    if self.selectNum <= 1 then
        self.selectNum = 1
    end
	
    if self.selectNum >= self.maxBuyCount then
        self.selectNum = self.maxBuyCount
    end
    self.Label_num:setString(self.selectNum)

	self.Label_cost_num:setText(self.selectNum * self.buyInfo[1].num)
end

function SzdyBuyView:onBuySuccessEvent(id,num)
    local rewardList = {}
	table.insert(rewardList,Utils:makeRewardItem(TabDataMgr:getData("ItemRecover",id).item_id,num))
	 Utils:showReward(rewardList)
    AlertManager:closeLayer(self)  
end

return SzdyBuyView



--endregion
