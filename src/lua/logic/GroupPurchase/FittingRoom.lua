--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local FittingRoom = class("FittingRoom", BaseLayer)
local image_path = "ui/activity/groupPurchase/pay_add.png"

local TimeInterval = 10
local GiftStatus = {None = -1, CannotGet = 0, CanGet = 1, Got = 2}

function FittingRoom:ctor(...)
	self.super.ctor(self, ...)
	self:initData(...)
	self:init('lua.uiconfig.activity.FittingRoom')

	self:initView()
	self:reqestUpdate()
end

function FittingRoom:initData(activityInfo, giftId)
	self.gifts = {}
	self.partner = {}
	self.curGift = nil
	self.activityInfo = activityInfo
	self.giftId = giftId

	self.firstEnter = true
	self.bUpateInvitBtn = false
	self.isShowInHall = true
	self.invitTime = TimeInterval

	local extData = self.activityInfo.extendData
	self.rechargeId = extData.rechange

	self.timeInterval = TabDataMgr:getData("DiscreteData", 90015).data.maxTime 
end

function FittingRoom:resetLeftUI()
	self.originator.head:setTexture(image_path)
	self.originator.head:setVisible(true)
	self.originator.name:setText("")
	self.originator.headFrame:setVisible(false)
	for k, v in pairs(self.partner) do
		v.name:setText("")
		v.head:setTexture(image_path)
		v.head:setVisible(false)
		v.default:setVisible(true)
		v.headFrame:setVisible(true)
	end
end

function FittingRoom:initUI(ui)
	self.super.initUI(self, ui)

	self.Button_cancel=TFDirector:getChildByPath(ui, "Button_cancel")
	self.Button_invitServer=TFDirector:getChildByPath(ui, "Button_invitServer")
	self.Button_invitServer.label=TFDirector:getChildByPath(self.Button_invitServer, "label")
	self.Button_invitServer.text = self.Button_invitServer.label:getText()

	self.Button_inivtPartner=TFDirector:getChildByPath(ui, "Button_inivtPartner")
	self.Button_noStart=TFDirector:getChildByPath(ui, "Button_noStart")
	self.Button_noStart:setTouchEnabled(false)

	self.GroupClothesName = TFDirector:getChildByPath(ui, "GroupClothesName")

	self.Button_get=TFDirector:getChildByPath(ui, "Button_get")

	self.endTimeCount=TFDirector:getChildByPath(ui, "endTimeCount")
	self.endTimeCount:setVisible(false)
	
	self.showInHall=TFDirector:getChildByPath(ui, "showInHall")
	self.showInHall.selected=TFDirector:getChildByPath(self.showInHall, "selected")
	self.showInHall.touch=TFDirector:getChildByPath(self.showInHall, "touch")
	self.showInHall.touch:setTouchEnabled(true)
	self.showInHall.touch:addMEListener(TFWIDGET_CLICK,function()
		self.isShowInHall = not self.isShowInHall	
		TFDirector:send(c2s.RECHARGE_REQ_SHOW_GROUP_TEAM, {self.curGift.data.giftId, self.isShowInHall})
	end)

	self.touchmask = TFDirector:getChildByPath(ui, "touchmask")
	self.touchmask:setTouchEnabled(true)
	self.touchmask:setSwallowTouch(true)

	self.Button_noStart:setEnabled(false)
	self.Button_noStart:setVisible(true)
	self._ui.Button_get:setVisible(false)
	self._ui.Button_cancel:setVisible(false)

	for i = 1, 2 do
		local clothe = TFDirector:getChildByPath(self.ui, "clothe"..i)
		table.insert(self.gifts, clothe)
		clothe:setTouchEnabled(false)

		clothe.selected = TFDirector:getChildByPath(clothe, "selected")
		clothe.selected:setVisible(false)

		clothe.finish = TFDirector:getChildByPath(clothe, "finish")
		clothe.finish:setVisible(false)

		clothe.canget = TFDirector:getChildByPath(clothe, "canget")
		clothe.canget:setVisible(false)

		clothe.itemPos = TFDirector:getChildByPath(clothe, "itemPos")
		clothe.touchmask = TFDirector:getChildByPath(clothe, "touchmask")
		clothe.touchmask:setTouchEnabled(true)
		clothe.touchmask:setSwallowTouch(false)
		clothe.touchmask:addMEListener(TFWIDGET_CLICK, function(sender)
			self:onClickClothe(clothe)
		end)

		clothe.giftId =self.rechargeId[i]
	end

	self.originator = TFDirector:getChildByPath(self.ui, "Originator")	
	self.originator.head = TFDirector:getChildByPath(self.originator, "head")
	self.originator.name = TFDirector:getChildByPath(self.originator, "name")	
	self.originator.headFrame = TFDirector:getChildByPath(self.originator, "headFrame")

	for i = 1, 2 do
		local partner = TFDirector:getChildByPath(self.ui, "partner"..i)
		partner.default = TFDirector:getChildByPath(partner, "default")
		partner.head = TFDirector:getChildByPath(partner, "head")
		partner.name = TFDirector:getChildByPath(partner, "name")
		partner.headFrame = TFDirector:getChildByPath(partner, "headFrame")

		table.insert(self.partner, partner)		
	end
end

function FittingRoom:onClickClothe(sender)
	self:selectGift(sender)
end

function FittingRoom:registerEvents()
	self.super.registerEvents(self)	

	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_GET,			handler(self.onGetGift,  self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_CANCEL,		handler(self.onCancel,   self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_SELF,			handler(self.updateData, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_QUERY_GIFT,	handler(self.updateData, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_SHOW_HALL,	handler(self.resetShowBtn,self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_DISSLUTION,	handler(self.updateData, self))
	EventMgr:addEventListener(self, EV_GROUP_PURCHASE_OTHER_JOIN,	handler(self.updateData, self))
 
	self._ui.Button_return:onClick(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_CLOSE_PANEL, {target = self})
	end)
	self.Button_inivtPartner:onClick(function()
		EventMgr:dispatchEvent(EV_GROUP_PURCHASE_OPEN_PANEL, {type =EC_GroupOpenPanel.Invit, giftId = self.curGift.data.giftId})
	end)
	self.Button_invitServer:onClick(function()
		if ServerDataMgr:getServerTime() < ActivityDataMgr2:getNextinvitServer() then
			Utils:showTips(216029)
			return;
		end
		local giftId = self.curGift.giftId
		local giftData = RechargeDataMgr:getGiftSingleData(giftId)	
		local teamId = ActivityDataMgr2:getGPTeamIdByGiftId(giftId)
		local cost = {[1] = {id = giftData.exchangeCost[1].id, num = giftData.exchangeCost[1].num}}
		local content = {str = string.format(TextDataMgr:getText(14300294),giftData.name), teamId = teamId, activtyID = self.activityInfo["id"], giftId = giftId,
				cost =cost,showItemtab = giftData.firstBuyItem[1]}

		local msg = {
			1,
			EC_ChatState.GROUP_PURCHASE,
			json.encode(content),
			0,	
			giftId	
		}
		TFDirector:send(c2s.CHAT_CHAT,msg)
		ActivityDataMgr2:setNextinvitServer(TimeInterval)
		self.bUpateInvitBtn = true
	end)

	self._ui.Button_get:onClick(function()
		TFDirector:send(c2s.RECHARGE_REQ_RECEIVE_GROUP_GIFT, {self.curGift.giftId})
	end)

	self._ui.Button_cancel:onClick(function()
		local func =function()
			TFDirector:send(c2s.RECHARGE_REQ_EXIT_GROUP_TEAM, {self.curGift.data.teamId})
		end

		local args = {
		    tittle = 2107025,
		    reType = false,
		    content = TextDataMgr:getText(14300295),
		    confirmCall = func,
		}
		Utils:showReConfirm(args)
	end)
end

function FittingRoom:initView()
	self:addTimeCounter()
end
function FittingRoom:addTimeCounter()
	if self.counter == nil then
		self.counter = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
	end

end

function FittingRoom:onCountDownPer(dt)
	if self.bUpateInvitBtn then
		self.invitTime = self.invitTime - dt
		local str ="(%s)"
		if self.invitTime < 0 then
			self.invitTime = TimeInterval	
			str = ""	
			self.bUpateInvitBtn = false
		end
		self.Button_invitServer.label:setText(self.Button_invitServer.text .. string.format(str, math.floor(self.invitTime)))
	end

	if self.counter == nil or self.curGift==nil or self.curGift.data == nil or self.curGift.status ~= GiftStatus.CannotGet then
		if self.endTimeCount then
			self.endTimeCount:setVisible(false)
		end
		return
	end
	local createtime = self.curGift.data.createTime
	local lefttime = createtime + self.timeInterval * 60 - ServerDataMgr:getServerTime()
	if lefttime < 0 then
		lefttime = 0
	end		
	local _,h,m,s = Utils:getDHMS(lefttime,true)
	self.endTimeCount:setTextById(300591, h,m,s)
	self.endTimeCount:setVisible(true)
end

function FittingRoom:resetShowBtn()
	self.showInHall.selected:setVisible(self.isShowInHall)	
	if self.curGift.data then
		local giftId = self.curGift.data.giftId
		ActivityDataMgr2:setTeamShowStatus(giftId, self.isShowInHall)
	end
end

function FittingRoom:selectGift(sender)

	if self.curGift then
		self.curGift.selected:setVisible(false)
	end
	
	sender.selected:setVisible(true)
	self.Button_invitServer:setVisible(sender.data ~= nil and sender.status == GiftStatus.CannotGet)
	self.Button_inivtPartner:setVisible(sender.data ~= nil and sender.status == GiftStatus.CannotGet)
	self.endTimeCount:setVisible(sender.data ~= nil and sender.status == GiftStatus.CannotGet)

	self.curGift = sender
	self:updateView()
end

function FittingRoom:updateData()
	self:bindData()
	self:selectGift(self:autoSelect())
end

function FittingRoom:bindData()
	for i=1,#self.gifts do
		local id = self.gifts[i].giftId
		local data = ActivityDataMgr2:getMyGroupPurchaseInfo(id)
		self.gifts[i].data =data
		self.gifts[i].status = GiftStatus.None

		self.gifts[i]:setTouchEnabled(true)

		local statusData = ActivityDataMgr2:getGiftStatus(id)
		if statusData then
			self.gifts[i].status = statusData.status 
		end
	end
end

function FittingRoom:updateView()
	self:refreshLeftPanel()
	self:refreshRightPanel()
end

function FittingRoom:refreshLeftPanel()
	local giftData = RechargeDataMgr:getGiftSingleData(self.curGift.giftId)	
	self.GroupClothesName:setText(giftData.name)

	local data = self.curGift.data
	if data == nil then
		self:resetLeftUI()
		return;
	end
	self:refreshOriginator()
	self:refreshPartner()

end

function FittingRoom:refreshRightPanel()
	for i=1, #self.gifts do	
		local giftNode = self.gifts[i]
		local giftData = RechargeDataMgr:getGiftSingleData(giftNode.giftId)
		local id = giftData["firstBuyItem"][1].id
		
		giftNode.itemPos:removeAllChildren()

		if giftNode.status == GiftStatus.CannotGet then
			if giftNode.data then
				giftNode:setVisible(true)
				self:addItem(giftNode.itemPos, id)
			else
				giftNode:setTexture(image_path)
				giftNode.canget:setVisible(false)
				giftNode.finish:setVisible(false)
			end
		elseif giftNode.status == GiftStatus.CanGet then
			giftNode:setVisible(true)
			self:addItem(giftNode.itemPos, id)
			giftNode.canget:setVisible(true)
			giftNode.finish:setVisible(false)
		elseif giftNode.status == GiftStatus.Got then
			giftNode.canget:setVisible(false)
			giftNode.finish:setVisible(true)
			self:addItem(giftNode.itemPos, id)
		else
			giftNode:setTexture(image_path)
			giftNode.canget:setVisible(false)
			giftNode.finish:setVisible(false)		
		end
	end
	self.Button_cancel:setVisible((self.curGift.data ~= nil and self.curGift.status == GiftStatus.CannotGet))
	self.Button_noStart:setVisible((self.curGift.data == nil))
	self.Button_get:setVisible((self.curGift.status == GiftStatus.CanGet))
	if self.curGift.data ~= nil and self.curGift.status == GiftStatus.CannotGet then
		self.showInHall:setVisible(true)
		self.isShowInHall = self.curGift.data.isShow
		self.showInHall.selected:setVisible(self.isShowInHall)	
	else
		self.showInHall:setVisible(false)
	end
end

function FittingRoom:addItem(parent,id)
	local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(goodItem, id)
	parent:addChild(goodItem)
	goodItem:setVisible(true)
	goodItem:setPosition(0,0)
	goodItem:setTouchEnabled(false)
	goodItem:setName("ITEM")
	parent.ITEM = goodItem
	return goodItem
end

function FittingRoom:refreshOriginator()
	local creator = self.curGift.data.creator
	if #creator == 0 then
		return
	end
	local portraiCfg = TabDataMgr:getData("Portrait", creator[1].portraitCid==0 and 101 or creator[1].portraitCid)
	if portraiCfg then
		self.originator.head:setTexture(portraiCfg.icon)
	end
	self.originator.name:setText(creator[1].playerName)
	self:updateHeadFrame(self.originator, creator[1].portraitFrameId)
end

function FittingRoom:refreshPartner()
	local data = self.curGift.data
	for i = 1, 2 do
		local partnerNode = self.partner[i]
		if data.partner[i] then
			local portraiCfg = TabDataMgr:getData("Portrait", data.partner[i].portraitCid==0 and 101 or data.partner[i].portraitCid)
			partnerNode.head:setTexture(portraiCfg.icon)
			partnerNode.head:setVisible(true)
			partnerNode.default:setVisible(false)
			partnerNode.name:setText(data.partner[i].playerName)
			self:updateHeadFrame(partnerNode, data.partner[i].portraitFrameId)
		else
			partnerNode.head:setVisible(false)
			partnerNode.default:setVisible(true)
			partnerNode.name:setText("")
		end
	end
end

function FittingRoom:updateHeadFrame(node, frameID)
	local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(frameID==0 and 10000 or frameID)
	node.headFrame:setVisible(true)
	if avatarFrameIcon then
		node.headFrame:setTexture(avatarFrameIcon)
	end
    local headFrameEffect = node.headFrame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        node.headFrame:addChild(headFrameEffect, 1)
    end
end

function FittingRoom:onCancel(event)
	local item = event.data
	self:queryGiftStatus()
end

function FittingRoom:reqestUpdate()
	TFDirector:send(c2s.RECHARGE_REQ_MY_GROUP_TEAM, {})
end
function FittingRoom:onGetGift(data)
	Utils:showReward(data.items)
	self:queryGiftStatus()
end
function FittingRoom:queryGiftStatus()
	ActivityDataMgr2:sendQueryGiftStatus()
end

function FittingRoom:addItem(parent,id)
	local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(goodItem, id)
	parent:addChild(goodItem)
	goodItem:setVisible(true)
	goodItem:setPosition(0,0)
	goodItem:setTouchEnabled(false)
	return goodItem
end

function FittingRoom:autoSelect()
	--第一次进入界面选中 主页所选中的礼包
	if self.firstEnter then
		for i = 1, #self.gifts do
			if self.gifts[i].giftId == self.giftId then
				return self.gifts[i]
			end
		end
		self.firstEnter = false
	end

	--如果当前已被选择  刷新还是选择这个礼包
	if self.curGift and self.curGift.data then
		return self.curGift
	end

	--如果当前的礼包数据不存在了  就寻找有数据的礼包并选中
	for i = 1, #self.gifts do
		local id = self.gifts[i].giftId
		local data = ActivityDataMgr2:getMyGroupPurchaseInfo(id)
		if data then
			return self.gifts[i]
		end
	end

	--如果前面都没有满足就选择第一个、、、、太尼玛复杂了
	return self.gifts[1]
end

function FittingRoom:stopTimeCounter()
	if self.counter then
		TFDirector:stopTimer(self.counter)
        TFDirector:removeTimer(self.counter)
        self.counter = nil
	end
end

function FittingRoom:removeEvents()
	self:stopTimeCounter()
end


return FittingRoom

--endregion
