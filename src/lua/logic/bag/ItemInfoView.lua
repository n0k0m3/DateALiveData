
local ItemInfoView = class("ItemInfoView", BaseLayer)

function ItemInfoView:initData(itemCid, itemId, isShowAccess, isNotShowTry)
    dump(itemCid)
    self.itemCid_ = itemCid
    self.itemId_ = itemId
    self.isShowAccess_ = tobool(isShowAccess)
    self.isNotShowTry_ = tobool(isNotShowTry)
    if self.itemId_ then
        self.itemInfo_ = GoodsDataMgr:getSingleItem(self.itemId_)
        self.itemCid_ = self.itemInfo_.cid
    end
    self.itemCfg_ = GoodsDataMgr:getItemCfg(self.itemCid_)
    self.costEnable_ = true
    self.countDownTimer_ = nil
    self.selectNum = 1;
end

function ItemInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.bag.itemInfoView")
end

function ItemInfoView:initUI(ui)
	self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Image_head = TFDirector:getChildByPath(Panel_content, "Image_head")
    self.Label_count = TFDirector:getChildByPath(Panel_content, "Label_count")
    self.Button_close = TFDirector:getChildByPath(Panel_content, "Button_close")
    self.Label_name = TFDirector:getChildByPath(Panel_content, "Label_name")
    self.Label_desc = TFDirector:getChildByPath(Panel_content, "Label_desc")
    self.Image_line2 = TFDirector:getChildByPath(Panel_content, "Image_line2")
    self.Button_use = TFDirector:getChildByPath(Panel_content, "Button_use"):hide()
    self.Label_use = TFDirector:getChildByPath(self.Button_use, "Label_use")
    self.Button_access = TFDirector:getChildByPath(Panel_content, "Button_access")
    self.Button_try = TFDirector:getChildByPath(Panel_content, "Button_try"):hide()
    self.Label_try = TFDirector:getChildByPath(self.Button_try, "Label_try")
    self.Button_compose = TFDirector:getChildByPath(Panel_content, "Button_compose")
    self.Label_access = TFDirector:getChildByPath(Panel_content, "Label_access")
    self.Label_countDown = TFDirector:getChildByPath(Panel_content, "Label_countDown"):hide()
    local ScrollView_cost = TFDirector:getChildByPath(Panel_content, "ScrollView_cost")
    self.ListView_cost = UIListView:create(ScrollView_cost)

    self.Panel_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_costItem")

    self.Panel_batch    = TFDirector:getChildByPath(Panel_content,"Panel_batch");
    self.Button_down    = TFDirector:getChildByPath(Panel_content,"Button_down");
    self.Button_up      = TFDirector:getChildByPath(Panel_content,"Button_up");
    self.Button_max = TFDirector:getChildByPath(self.Panel_batch, "Button_max")
    self.Label_num      = TFDirector:getChildByPath(Panel_content,"Label_num");
    self.Label_use:enableOutline(ccc4(0,0,0,50),1)
    self.Label_access:enableOutline(ccc4(0,0,0,50),1)
    self.Label_try:enableOutline(ccc4(0,0,0,50),1)

	self.Button_mirror = TFDirector:getChildByPath(Panel_content,"Button_mirror"):hide();

    self:refreshView()
end

function ItemInfoView:refreshView()
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:AddTo(self.Image_head)
    self.Image_head:setTexture("")
    Panel_goodsItem:Pos(0, 0)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.itemCid_)

    --卡巴拉道具不显示拥有数量
    if self.itemCfg_.superType == EC_ResourceType.UNION_EXP
        or self.itemCfg_.superType == EC_ResourceType.UNION_CONTRIBUTION
        or self.itemCfg_.superType == EC_ResourceType.KABALA
        or self.itemCfg_.superType == EC_ResourceType.DLS
        or self.itemCfg_.superType == EC_ResourceType.UNION_TRAIN_SCORE
        or self.itemCfg_.superType == EC_ResourceType.CHENGHAO then
        self.Label_count:setText("")
    else
        self.Label_count:setTextById(301013, GoodsDataMgr:getItemCount(self.itemCid_))
    end

    self.Button_try:hide()
    if self.itemCfg_.superType == EC_ResourceType.DRESS then
        self.Button_try:show()
    end
    if self.isNotShowTry_ then
        self.Button_try:hide()
    end
    
    self.Label_desc:setTextById(self.itemCfg_.desTextId)
    self.Label_name:setTextById(self.itemCfg_.nameTextId)
    local size = self.Label_name:Size()
    self.Button_access:setVisible(self.isShowAccess_)

    local canUsing = normalizeBool(GoodsDataMgr:isCanUsing(self.itemCid_) and self.itemId_)
    self.Button_use:setVisible(canUsing)
    if canUsing then
        for i, v in ipairs(self.itemCfg_.useCast) do
            local itemCfg = GoodsDataMgr:getItemCfg(v[1])
            local Panel_costItem = self.Panel_costItem:clone()
            local Image_costIcon = TFDirector:getChildByPath(Panel_costItem, "Image_costIcon")
            local Label_costNum = TFDirector:getChildByPath(Panel_costItem, "Label_costNum")
            local Label_costNumRed = TFDirector:getChildByPath(Panel_costItem, "Label_costNumRed")
            Image_costIcon:setTexture(itemCfg.icon)
            Label_costNum:setText(v[2])
            Label_costNumRed:setText(v[2])
            local isEnough = GoodsDataMgr:currencyIsEnough(v[1], v[2])
            if not isEnough then
                self.costEnable_ = false
            end
            Label_costNum:setVisible(isEnough)
            Label_costNumRed:setVisible(not isEnough)
            self.ListView_cost:pushBackCustomItem(Panel_costItem)
        end
        local containerSize = self.ListView_cost:getInnerContainerSize()
        self.ListView_cost:setContentSize(containerSize)
    elseif self.itemCfg_.superType == EC_ResourceType.TRAILCARD and GoodsDataMgr:getItemCount(self.itemCid_) > 0 then
        self.Button_use:setVisible(true)
    else
        self.Button_access:setPositionX(self.Button_use:getPositionX())
    end

    if self.itemInfo_ and self.itemInfo_.outTime then
        self.Label_countDown:show()
        self:addCountDownTimer()
        self:updateCountDown()
    end

    self.Panel_batch:setVisible(canUsing and self.itemCfg_.batchUse);
    if canUsing and self.itemCfg_.batchUse then
        self.selectNum = 1;
        self:updateBatchPanel(0);
    end

    self.Button_compose:setVisible(self.itemCfg_.superType == EC_ResourceType.BAOSHITUZHI and GoodsDataMgr:getItemCount(self.itemCid_) > 0)

	self.Button_mirror:setVisible(self.itemCfg_.showBgPreview and self.itemCfg_.showBgPreview > 0)
end

function ItemInfoView:updateCountDown()
    local remainTime = math.max(0, self.itemInfo_.outTime - ServerDataMgr:getServerTime())
    if remainTime == 0 then
        self.Button_use:hide()
        self:removeCountDownTimer()
        self.Label_countDown:setTextById(301010)
    else
        local day, hour, min = Utils:getTimeDHMZ(remainTime)
        self.Label_countDown:setTextById(301005, day,hour, min)
    end
end

function ItemInfoView:onCountDownPer()
    self:updateCountDown()
end

function ItemInfoView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function ItemInfoView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function ItemInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_USE_ITEM, handler(self.onUseItemEvent, self))
    EventMgr:addEventListener(self, EV_BAG_USE_TRAIL, handler(self.onUseTrailEvent, self))

    self.Button_use:onClick(function()
            if not self.costEnable_ then
                Utils:showTips(301006)
                return
            end

            if self.itemCfg_.superType == EC_ResourceType.TRAILCARD then
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_TryUseHero) then
                    GoodsDataMgr:useTrailCard(self.itemId_)
                else
                    local args = {
                        tittle = 2107025,
                        content = TextDataMgr:getText(301027),
                        reType = EC_OneLoginStatusType.ReConfirm_TryUseHero,
                        confirmCall = function()
                            GoodsDataMgr:useTrailCard(self.itemId_)
                        end,
                    }
                    Utils:showReConfirm(args)
                end
                return
            end

            if self.itemCfg_.superType == EC_ResourceType.FIRST_RECHARGE_ITEM or
                self.itemCfg_.superType == EC_ResourceType.CONTRACT_ITEM then
                --首冲重置道具 or 精灵锲约重置道具
                self:useSpeicalItem()
                return
            end

            if self.itemCfg_.useProfit.custom then
                local itemId = self.itemId_
                AlertManager:closeLayer(self)
                Utils:openView("bag.UseItemSelectView",itemId, self.selectNum)

                -- local useItemSelectView = requireNew("lua.logic.bag.UseItemSelectView"):new(itemId, self.selectNum)
                -- AlertManager:addLayer(useItemSelectView)
                -- AlertManager:show()
            else
                GoodsDataMgr:useItem({{self.itemId_, self.selectNum}})
            end
    end)

    self.Button_access:onClick(function()
            Utils:openView("bag.ItemAccessView", self.itemCid_)
            AlertManager:closeLayer(self)
    end)

    self.Button_compose:onClick(function()
        Utils:openView("fairyNew.BaoshiComposeView", {rarity = self.itemCfg_.rarity})
    end)

    self.Button_try:onClick(function()
        self:tryOnDress(self.itemCfg_.id)
    end)

    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)

    self.Button_up:onTouch(function(event)
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

    self.Button_down:onTouch(function(event)
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

    self.Button_max:onClick(function()
            local count = self:getOnceUseLimit()
            self:updateBatchPanel(count)
    end)

	self.Button_mirror:onClick(function()
		Utils:openView("collect.CollectScenePreView", self.itemCfg_.showBgPreview)
	end)
end

function ItemInfoView:tryOnDress(dressId)
    local roleId = nil
    local roleCfg = TabDataMgr:getData("Role")
    for k, v in pairs(roleCfg) do
        if table.indexOf(v.dress, dressId) ~= -1 then
            roleId = v.id
            break
        end
    end

    if roleId then
        Utils:openView("role.NewRoleShowView", roleId, dressId)
    end
end

function ItemInfoView:useSpeicalItem()
    local content = ""
    local tips = ""
    local reType = false
    local confirmId = 1329128

    if self.itemCfg_.superType == EC_ResourceType.FIRST_RECHARGE_ITEM then
        --首冲重置道具
        confirmId = 13242
        tips = "r7102"
        content = TextDataMgr:getText(13241)
    elseif self.itemCfg_.superType == EC_ResourceType.CONTRACT_ITEM then
        --精灵锲约重置道具
        confirmId = 13240
        tips = "r7101"
        content = TextDataMgr:getText(13239)
    end

    local args = {
        tittle = 2107025,
        content = content,
        reType = reType,
        tips = tips,
        confirmId = confirmId,
        showCancle = true,
        confirmCall = function()
            GoodsDataMgr:useItem({{self.itemId_, self.selectNum}})
        end,
    }
    Utils:showReConfirm(args)
end

function ItemInfoView:holdDownAction(isAddOp)
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

function ItemInfoView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function ItemInfoView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function ItemInfoView:getOnceUseLimit()
    local count = GoodsDataMgr:getItemCount(self.itemCid_)
    local onceUseLimit = self.itemCfg_.onceUseLimit
    if onceUseLimit > 0 and count > onceUseLimit then 
        count = onceUseLimit 
    end
    return count
end


function ItemInfoView:updateBatchPanel(num)
    self.selectNum = self.selectNum + num;
    if self.selectNum <= 1 then
        self.selectNum = 1;
    end
    local count = self:getOnceUseLimit()
    if self.selectNum >= count then
        self.selectNum = count;
    end

    self.Label_num:setString(self.selectNum);
end

function ItemInfoView:removeEvents()
    if self.itemInfo_ then
        self:removeCountDownTimer()
    end
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function ItemInfoView:onUseItemEvent(reward,isSkyLadderCardBag)
    AlertManager:closeLayer(self)
    if next(reward) then
        Utils:showReward(reward)
    end
end

function ItemInfoView:onUseTrailEvent()
    AlertManager:closeLayer(self)
end


return ItemInfoView
