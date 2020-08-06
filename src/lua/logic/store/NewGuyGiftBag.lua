local NewGuyGiftBag = class("NewGuyGiftBag", BaseLayer)


function NewGuyGiftBag:ctor()
    self.super.ctor(self)

    self:showPopAnim(true)
    self:init("lua.uiconfig.recharge.NewGuyGiftBag")
end

function NewGuyGiftBag:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Button_back	= TFDirector:getChildByPath(ui,"Button_back")
	self.Button_buy		= TFDirector:getChildByPath(ui,"Button_buy")

	self.Image_hero 	= TFDirector:getChildByPath(ui,"Image_hero")

	self.itemInfo = {}
	for i=1,3 do
		local item = {}
		item.icon	= TFDirector:getChildByPath(ui,"Imag_item_"..i)
		item.Label_cnt	= TFDirector:getChildByPath(ui,"Label_cnt_"..i)
		self.itemInfo[i] = item
	end 

	self:initUILogic()
end

function NewGuyGiftBag:initUILogic()

	self.voiceHandle = VoiceDataMgr:playVoice("mian_morning",101)

	local newGuyFlag = CommonManager:getNewGuyGifyBagFlage()
	if not newGuyFlag then
		CommonManager:saveNewGuyGifyBagFlage()
	end

	self:showGiftItem()
	self:updateHeroSkin()
end

function NewGuyGiftBag:showGiftItem()

	local newGiftBag = TabDataMgr:getData("Recharge")[100]
	if not newGiftBag then
		return
	end

	local giftBagCfg = TabDataMgr:getData("RechargeGiftBag")[newGiftBag.goodsId]
    if not giftBagCfg then
        return
    end
    local itemIndex = 1
    local items = giftBagCfg.item
	for k,v in pairs(items) do
		local itemCfg = GoodsDataMgr:getItemCfg(k)
		if itemCfg then
			self.itemInfo[itemIndex].icon:setTexture(itemCfg.icon)
		end
		self.itemInfo[itemIndex].Label_cnt:setText("x"..v)
		if itemIndex == 2 then
			self.itemInfo[itemIndex].icon:setScale(0.83)
		end

		self.itemInfo[itemIndex].icon:onClick(function()
			Utils:showInfo(k, nil, false)
		end)

		itemIndex = itemIndex + 1
		if itemIndex >= 3 then
			itemIndex = 3
		end
	end

end

function NewGuyGiftBag:updateHeroSkin()

	local showHeroId = 110101
	local showSkinID = 1101013
    local model = Utils:createHeroModel(showHeroId, self.Image_hero, nil,showSkinID)
    --model:setScale(0.5)
    --model:setPositionY(40)
end

function NewGuyGiftBag:registerEvents()

	EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.afterBuy, self));

	self.Button_back:onClick(function()
    	AlertManager:closeLayer(self)
	end)

    self.Button_buy:onClick(function()
    	RechargeDataMgr:getOrderNO(100);
	end)
end

function NewGuyGiftBag:afterBuy()
	AlertManager:closeLayer(self)
end

function NewGuyGiftBag:onClose()
	if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
    self.super.onClose(self)
end

return NewGuyGiftBag
