--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local PrivilageCard = class("PrivilageCard", BaseLayer)

function PrivilageCard:ctor()
	self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.supplyNew.privilegeCard")
end

function PrivilageCard:initData()
	self:showPopAnim(true)

	self.signData = RechargeDataMgr:getMonthCardSignData()

	self.weekData = RechargeDataMgr:getWeekCardInfo()

	self.isDoubleCardOpen = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)

	self.packageData = RechargeDataMgr:getGiftListByType(20)

	self.monthRewardNodes = {}
	self.monthTargetRewardNodes = {}
	self.weekRewardNodes = {}
	self.packageListNodes = {}
	self.labelSkew = {}
end

function PrivilageCard:initUI(ui)
	self.super.initUI(self, ui)

	self.monthCard								= TFDirector:getChildByPath(ui, "monthCard")
	self.monthCard.time							= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard, "time"), "label")
	self.monthCard.reward						= TFDirector:getChildByPath(self.monthCard, "reward")
	self.monthCard.reward.btn_claim				= TFDirector:getChildByPath(self.monthCard.reward,	"btn_claim")
	self.monthCard.reward.reward1				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "cur_reward"),		"reward_1")
	self.monthCard.reward.reward2				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "cur_reward"),		"reward_2")
	self.monthCard.reward.double1				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "cur_reward"),		"Image_Double_1")
	self.monthCard.reward.double2				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "cur_reward"),		"Image_Double_2")
	self.monthCard.reward.target_reward			= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "target_reward"),	"reward_1")
	self.monthCard.reward.target_day			= TFDirector:getChildByPath(TFDirector:getChildByPath(self.monthCard.reward, "label_sign_again"),"label2")
	self.monthCard.btn_check					= TFDirector:getChildByPath(self.monthCard, "btn_check")
	self.monthCard.btn_purchase					= TFDirector:getChildByPath(self.monthCard, "btn_purchase")
	self.monthCard.btn_Explain					= TFDirector:getChildByPath(self.monthCard.btn_purchase, "btn_Explain")
	self.monthCard.btn_purchase.buyName			= TFDirector:getChildByPath(self.monthCard.btn_purchase, "buyName")

	self.weekCard								= TFDirector:getChildByPath(ui, "weekCard")
	self.weekCard.time							= TFDirector:getChildByPath(TFDirector:getChildByPath(self.weekCard, "time"), "label")
	self.weekCard.reward						= TFDirector:getChildByPath(self.weekCard, "reward")
	self.weekCard.reward.btn_claim				= TFDirector:getChildByPath(self.weekCard.reward,	"btn_claim")
	self.weekCard.reward.reward1				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.weekCard.reward, "cur_reward"),		"reward_1")
	self.weekCard.reward.reward2				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.weekCard.reward, "cur_reward"),		"reward_2")
	self.weekCard.reward.reward3				= TFDirector:getChildByPath(TFDirector:getChildByPath(self.weekCard.reward, "target_reward"),	"reward_1")
	self.weekCard.btn_check						= TFDirector:getChildByPath(self.weekCard, "btn_check")
	self.weekCard.btn_purchase					= TFDirector:getChildByPath(self.weekCard, "btn_purchase")

	self.package								= TFDirector:getChildByPath(ui, "package")
	self.btnJump								= TFDirector:getChildByPath(self.package, "btn_jump")

	for i=1,3 do
		local gift = TFDirector:getChildByPath(self.package, "gift"..i)
		if gift then
			local data = self.packageData[i]
			if data then
				gift.data = data
				gift.name = TFDirector:getChildByPath(gift, "name")
				gift.name:setText(data.name)
				gift.price = TFDirector:getChildByPath(gift, "price")
				gift.price:setText("￥" .. data.rechargeCfg.price)
				table.insert(self.packageListNodes, gift)
			else
				gift:hide()
			end
		end
	end

	for i=1,14 do
		local label = TFDirector:getChildByPath(ui, "label_skew_"..i)
		label:setSkewX(15)
	end

	self:initMonthCard()
	self:initWeekCard()
end

function PrivilageCard:registerEvents()
	self.monthCard.reward.btn_claim:onClick(function()	RechargeDataMgr:sendMonthCardSignIn()	end)
	self.monthCard.btn_check:onClick(function()	Utils:openView("store.PrivilageContent",EC_CardPrivilege.Month)	end)
	self.monthCard.btn_purchase:onClick(function()	
		-- local layer = require("lua.logic.store.MonthCard"):new({{998},RechargeDataMgr:getSubscribeMonthCardCfg()})
  --       AlertManager:addLayer(layer)
  --       AlertManager:show()	
  			--写死调用月卡购买id为40 2020-11-20
        	RechargeDataMgr:getOrderNO(40)
		end)
--	self.monthCard.btn_Explain:onClick(function()	
--		local layer = require("lua.logic.store.MonthCard"):new({{998},RechargeDataMgr:getSubscribeMonthCardCfg(), noBtn = true})
--        AlertManager:addLayer(layer)
--        AlertManager:show()
--		end)

	self.weekCard.reward.btn_claim:onClick(function()	RechargeDataMgr:sendWeekCardSign()	end)
	self.weekCard.btn_check:onClick(function()	Utils:openView("store.PrivilageContent",EC_CardPrivilege.Week)	end)
	self.weekCard.btn_purchase:onClick(function()	RechargeDataMgr:getOrderNO(910004)	end)

	self.btnJump:onClick(function()	FunctionDataMgr:jStore(191000)	end)

	for k,v in ipairs(self.packageListNodes) do
		v:onClick(function()
			self:showGiftContent(v.data)
		end)
	end

	EventMgr:addEventListener(self, EV_MONTHCARD_STATUS_UPDATE, handler(self.initMonthCard, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onCheckMonthCardDouble, self))
	EventMgr:addEventListener(self, EV_WEEKCARD_UPDATE, handler(self.initWeekCard, self))
end

function PrivilageCard:initMonthCard()
	self.monthCard.time:setTextById(15010196, tostring(RechargeDataMgr:getMonthCardLeftTime()))

	self.monthCard.reward.target_day:setText(self.signData.extDay)

	local havecard = tobool(RechargeDataMgr:getMonthCardLeftTime() > 0)
    local cansign = RechargeDataMgr:isMonthCardCanSign()
    self.monthCard.reward.btn_claim:setTouchEnabled(havecard and cansign)
    --self.monthCard.reward.btn_claim:setGrayEnabled(not havecard or not cansign, true)
	Utils:setNodeGray(self.monthCard.reward.btn_claim, not havecard or not cansign)

	self:initMonthSignReward()

	if (me.platform == "ios" and tonumber(TFDeviceInfo:getCurAppVersion()) >= 3.65) or me.platform == "win32" then
        self.monthCard.btn_purchase:setTextureNormal("ui/supplyNew/privilegeCard/12.png")
    else
        self.monthCard.btn_purchase:setTextureNormal("ui/supplyNew/privilegeCard/20.png")
		self.monthCard.btn_purchase.buyName:setTextById(1660011)
		self.monthCard.btn_purchase.buyName:setPositionY(-2)
		self.monthCard.btn_Explain:hide()
    end
end

function PrivilageCard:removeAllMonthCardRewardNodes()
	for i, v in ipairs(self.monthRewardNodes) do
		v:removeFromParent(true)
	end
	self.monthRewardNodes = {}

	for i, v in ipairs(self.monthTargetRewardNodes) do
		v:removeFromParent(true)
	end
	self.monthTargetRewardNodes = {}
end

function PrivilageCard:removeAllWeekCardRewardNodes()
	for i, v in ipairs(self.weekRewardNodes) do
		v:removeFromParent(true)
	end
	self.weekRewardNodes = {}
end

function PrivilageCard:initMonthSignReward()
	self:removeAllMonthCardRewardNodes()

	local signData = RechargeDataMgr:getMonthCardSignData()

	local basereward  = signData.basrReward or {}
    for i, v in ipairs(basereward) do
        local Item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6):Pos(0,0)
		local num = v.num
		if self.isDoubleCardOpen then
			num = num * 2
		end
		if self.monthCard.reward["double"..i] then
			self.monthCard.reward["double"..i]:setVisible(self.isDoubleCardOpen)
		end
	
        PrefabDataMgr:setInfo(Item, v.id, num)
		if self.monthCard.reward["reward"..i] then
			self.monthCard.reward["reward"..i]:addChild(Item)
			table.insert(self.monthRewardNodes,Item)
		end
    end

	local extrareward  = signData.specialReward or {}
	for i, v in ipairs(extrareward) do
		local Item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6):Pos(0,0)
		PrefabDataMgr:setInfo(Item, v.id, v.num)
		if self.monthCard.reward["target_reward"] then
			self.monthCard.reward["target_reward"]:addChild(Item)
			table.insert(self.monthTargetRewardNodes,Item)
		end
		break;
    end
end

function PrivilageCard:initWeekCard()
	local data = RechargeDataMgr:getWeekCardInfo()

    local lastTime = data.etime - ServerDataMgr:getServerTime()
    local havecard = tobool(lastTime > 0)
    if havecard then
        local days =  math.ceil(lastTime/(24*3600))
        self.weekCard.time:setTextById(15010196,days)
    else
        self.weekCard.time:setTextById(15010196,0)
    end

	self:initWeekSignReward()

	self.weekCard.reward.btn_claim:setTouchEnabled(havecard and data.canSign)
    --self.weekCard.reward.btn_claim:setGrayEnabled(not havecard or not data.canSign, true)
	Utils:setNodeGray(self.weekCard.reward.btn_claim, not havecard or not data.canSign)
end

function PrivilageCard:initWeekSignReward()
	self:removeAllWeekCardRewardNodes()

	local data = RechargeDataMgr:getWeekCardInfo()
    for i, v in ipairs(data.basrReward or {}) do
        local Item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():Scale(0.6):Pos(0,0)
        PrefabDataMgr:setInfo(Item, v.id, v.num)
		if self.weekCard.reward["reward"..i] then
			self.weekCard.reward["reward"..i]:addChild(Item)
			table.insert(self.weekRewardNodes,Item)
		end
    end
end

function PrivilageCard:showGiftContent(data)
	Utils:openView("store.PrivilageGiftContent",data)
end

function PrivilageCard:onCheckMonthCardDouble()
    local newstatus = ActivityDataMgr2:isOpen(EC_ActivityType2.DOUBLE_CARD)
    if self.isDoubleCardOpen ~= newstatus then
        self.isDoubleCardOpen = newstatus
        self:initMonthCard()
    end
end


return PrivilageCard
--endregion
