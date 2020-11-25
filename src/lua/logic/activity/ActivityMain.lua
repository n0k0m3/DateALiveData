
local ActivityMain = class("ActivityMain", BaseLayer)

function ActivityMain:initData(actId)
    self.curActId = actId;
    self.actBtns    = {}
    self.sevenExItem_ = {}
    self.powerReceiveId_ = nil
    self.selectSevenExIdx = ActivityDataMgr:getSevenExCurDayTag();

end

function ActivityMain:ctor(actId)
    self.super.ctor(self)
    self:initData(actId)
    self:init("lua.uiconfig.activity.ActivityMain");
end

function ActivityMain:getClosingStateParams()
    return {self.curActId}
end

function ActivityMain:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui;

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab   = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.btnListView    = TFDirector:getChildByPath(ui,"Panel_menu");
    self.btnListView    = UIListView:create(self.btnListView);
    self.actBtnItem     = TFDirector:getChildByPath(ui,"Panel_ActBtn");
    self.Button_receive = TFDirector:getChildByPath(ui,"Button_receive");

    self.Panel_sign = TFDirector:getChildByPath(ui,"Panel_sign"):hide();
    self.Panel_sign.img_signNum = TFDirector:getChildByPath(self.Panel_sign,"img_signNum")
    self.Panel_sign.lab_signLastNum = TFDirector:getChildByPath(self.Panel_sign.img_signNum,"lab_signLastNum")
    self.Panel_sign.imgIcon = TFDirector:getChildByPath(self.Panel_sign.img_signNum,"imgIcon")
    self.Panel_sign.lab_signCost = TFDirector:getChildByPath(self.Panel_sign.img_signNum,"lab_signCost")

    self.Panel_seven    = TFDirector:getChildByPath(ui,"Panel_seven"):hide()

    self.Button_sevenReceive = TFDirector:getChildByPath(self.Panel_seven,"Button_sevenReceive");
    self.Button_seven_raiders_left = TFDirector:getChildByPath(self.Panel_seven, "Button_seven_raiders_left")
    self.Button_seven_raiders_right = TFDirector:getChildByPath(self.Panel_seven, "Button_seven_raiders_right")

    self.Panel_nextDay      = TFDirector:getChildByPath(ui,"Panel_nextDay");
    self.Panel_nextDay.bg   = TFDirector:getChildByPath(self.Panel_nextDay,"Image_bg");
    self.Button_nextDayReceive  = TFDirector:getChildByPath(self.Panel_nextDay,"Button_nextDayReceive");

    self.Panel_power = TFDirector:getChildByPath(self.Panel_root, "Panel_power"):hide()
    self.Image_powerReward = TFDirector:getChildByPath(self.Panel_power, "Image_powerReward")
    self.Image_showPowerItem = TFDirector:getChildByPath(self.Image_powerReward, "Image_showItem")
    self.Label_powerTime = TFDirector:getChildByPath(self.Panel_power, "Label_powerTime")
    self.Button_powerReceive = TFDirector:getChildByPath(self.Panel_power, "Button_powerReceive")
    self.Label_powerTime2 = TFDirector:getChildByPath(self.Panel_power, "Label_powerTime2")
    self.Label_powernum = TFDirector:getChildByPath(self.Panel_power, "Label_powernum")
    self.Label_power_tip2 = TFDirector:getChildByPath(self.Panel_power , "Label_power_tip2")
    self.Label_power_tip2:setTextById(1820006)

    self.Panel_tzr = TFDirector:getChildByPath(self.Panel_root, "Panel_tzr"):hide()

    self.Panel_newGiftEn = TFDirector:getChildByPath(self.Panel_root , "Panel_newGiftEn")
    self.Panel_newGiftEn:hide()

    self.panel_sevenEx = TFDirector:getChildByPath(ui,"Panel_sevenEx"):hide()
    -- local Panel_tehui = TFDirector:getChildByPath(self.panel_sevenEx, "Panel_tehui")
    -- --暂时屏蔽七日大礼包
    -- Panel_tehui:hide()
    self.Panel_sevenExItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_sevenExItem");
    local ScrollView_sEx = TFDirector:getChildByPath(self.panel_sevenEx, "ScrollView_sEx")
    self.ListView_sevenEx = UIListView:create(ScrollView_sEx)
    self.Button_sEx_buy = TFDirector:getChildByPath(self.panel_sevenEx, "Button_sEx_buy")
    self.Button_sevenEx_gift = TFDirector:getChildByPath(self.panel_sevenEx, "Button_sevenEx_gift")
    local act1 =  CCScaleTo:create(1, 1.05)
    local act2 = CCScaleTo:create(1, 1)
    self.Button_sevenEx_gift:runAction(RepeatForever:create(CCSequence:create({act1, act2})))
    self.Image_support_store = TFDirector:getChildByPath(self.panel_sevenEx)
    self.Button_support_store = TFDirector:getChildByPath(self.Image_support_store, "Button_support_store")
    local Label_support_store = TFDirector:getChildByPath(self.Button_support_store, "Label_support_store")

    self.Panel_christmasSign = TFDirector:getChildByPath(self.Panel_root, "Panel_christmasSign")
    self.Panel_support_store = TFDirector:getChildByPath(self.Panel_root, "Panel_support_store")
    self.Panel_monthCard = TFDirector:getChildByPath(self.Panel_root, "Panel_monthCard")
    self.Panel_newGuy = TFDirector:getChildByPath(self.Panel_root, "Panel_newGuy"):hide()

    self.Panel_awardConfirm = TFDirector:getChildByPath(self.Panel_root, "Panel_awardConfirm"):hide()
    self.Button_ok = TFDirector:getChildByPath(self.Panel_awardConfirm, "Button_ok")
    self.Label_awardConfirmtip = TFDirector:getChildByPath(self.Panel_awardConfirm, "Label_tip")
    self.Label_awardConfirmtip1 = TFDirector:getChildByPath(self.Panel_awardConfirm, "Label_tip1")
    self.Button_closeConfirm = TFDirector:getChildByPath(self.Panel_awardConfirm, "Button_closeConfirm")

    for i=1,7 do
        self["sevenExTag"..i] = TFDirector:getChildByPath(self.panel_sevenEx, "Image_day_tag"..i)
        self["sevenExTag"..i]:setTouchEnabled(true)
    end

    for i=1,6 do
        self["sevenExTagLine"..i] = TFDirector:getChildByPath(self.panel_sevenEx, "Image_ActivityMain_"..i)
    end

    self.actPanels = {
        [EC_ActivityType.SIGN]      = self.Panel_sign,
        [EC_ActivityType.SEVENDAY]  = self.Panel_seven,
        [EC_ActivityType.NEXTDAY]   = self.Panel_nextDay,
        [EC_ActivityType.POWER] = self.Panel_power,
        [EC_ActivityType.SEVENEX] = self.panel_sevenEx,
        [EC_ActivityType.CHRISTMAS_SIGN] = self.Panel_christmasSign,
        [EC_ActivityType.MONTH_CARD] = self.Panel_monthCard,
        [EC_ActivityType.SUPPORT_STORE] = self.Panel_support_store,
        [EC_ActivityType.NEWGUY_SUMMON] = self.Panel_newGuy,
        [EC_ActivityType.TOUZIREN] = self.Panel_tzr,
        [EC_ActivityType2.NEWGIFT_PACK_EN] = self.Panel_newGiftEn
    }

    self.actUpdateFun = {
        [EC_ActivityType.SIGN]      = self.updateSign,
        [EC_ActivityType.SEVENDAY]  = self.updateSeven,
        [EC_ActivityType.NEXTDAY]   = self.updateNextDay,
        [EC_ActivityType.POWER]   = self.updatePower,
        [EC_ActivityType.SEVENEX] = self.updateSevenEx,
        [EC_ActivityType.CHRISTMAS_SIGN] = self.updateChristmasSign,
        [EC_ActivityType.MONTH_CARD] = self.updateMonthCard,
        [EC_ActivityType.SUPPORT_STORE] = self.updateSupportStore,
        [EC_ActivityType.NEWGUY_SUMMON] = self.updateNewGuySummon,
        [EC_ActivityType.TOUZIREN] = self.updateTouziren,
        [EC_ActivityType2.NEWGIFT_PACK_EN] = self.updateNewGiftEn
    }

    self.Image_showPowerItem:setTexture("icon/system/001.png")
    self:initActivitysBtn();
end

function ActivityMain:reShow()
    if ActivityDataMgr:getIsHaveActs( ) then
        Utils:openActivityPage();
    end

    AlertManager:closeLayer(self);
end

function ActivityMain:updateUI()
    if self.actUpdateFun[self.curActId] then
        self.actUpdateFun[self.curActId](self);
    end

    self:showRedPoint();
end

function ActivityMain:initActivitysBtn()

    local activitys = ActivityDataMgr:getActivitys();
    for k,v in pairs(activitys) do
        if v.id ~= 3 then
            local btn           = self.actBtnItem:clone();
            local titleLabel    = TFDirector:getChildByPath(btn,"Label");
            local icon          = TFDirector:getChildByPath(btn,"Image_icon")
            local title         = ActivityDataMgr:getActTitle(v.id);
            titleLabel:setTextById(title)
            self.btnListView:pushBackCustomItem(btn)
            if v.id == 1 then--月签到
                icon:setTexture("ui/fuli/icon4.png")
            elseif v.id == 2 then--7天登录
                icon:setTexture("ui/fuli/icon2.png")
            elseif v.id == 4 then--次日登录
                icon:setTexture("ui/fuli/icon1.png")
            end

            local button        = TFDirector:getChildByPath(btn,"Button");
            button.id        = v.id;
            button.actIdx       = k;
            self.actBtns[v.id] = button
            button:onClick(function()
                self:onTouchActBtn(button);
            end)
        end
    end

    ---萌新召唤
    local isOpenNoobSummon = SummonDataMgr:isOpenNoob()
    if isOpenNoobSummon then
        local Panel_cardBtn = self.actBtnItem:clone()
        local Button = TFDirector:getChildByName(Panel_cardBtn, "Button")
        local Label = TFDirector:getChildByName(Button, "Label")
        local Image_icon = TFDirector:getChildByName(Button, "Image_icon")
        local RedTip = TFDirector:getChildByName(Panel_cardBtn, "RedTip")
        Label:setTextById(1800005)
        Image_icon:setTexture("ui/activity/newguy_summon/008.png")
        self.btnListView:pushBackCustomItem(Panel_cardBtn)
        self.actBtns[EC_ActivityType.NEWGUY_SUMMON] = Button
        Button:onClick(function()
            self:onTouchActBtn(Button)
        end)
        Button.id = EC_ActivityType.NEWGUY_SUMMON
    end

    --七日狂欢
    if self.selectSevenExIdx > 0 then
        local btn           = self.actBtnItem:clone();
        local titleLabel    = TFDirector:getChildByPath(btn,"Label");
        local icon          = TFDirector:getChildByPath(btn,"Image_icon")
        titleLabel:setTextById(266200)
        icon:setTexture("ui/activity/sevenEx/002.png")
        self.btnListView:pushBackCustomItem(btn)
        local button        = TFDirector:getChildByPath(btn,"Button");
        button.id           = EC_ActivityType.SEVENEX;
        button.actIdx       = 5; --七日狂欢无效
        self.actBtns[EC_ActivityType.SEVENEX] = button
        button:onClick(function()
                self:onTouchActBtn(button);
            end)
    end

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_SIGN)
    if #activity > 0 then
        -- 圣诞签到
        local Panel_ActBtn = self.actBtnItem:clone()
        local Button = TFDirector:getChildByName(Panel_ActBtn, "Button")
        local Label = TFDirector:getChildByName(Button, "Label")
        local Image_icon = TFDirector:getChildByName(Button, "Image_icon")
        local RedTip = TFDirector:getChildByName(Panel_ActBtn, "RedTip")
        Label:setTextById(1890004)
        Image_icon:setTexture("ui/fuli/icon5.png")
        self.btnListView:pushBackCustomItem(Panel_ActBtn)
        self.actBtns[EC_ActivityType.CHRISTMAS_SIGN] = Button
        Button:onClick(function()
                self:onTouchActBtn(Button)
        end)
        Button.id = EC_ActivityType.CHRISTMAS_SIGN
    end

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWGIFT_PACK_EN)
    if #activity > 0 then
        --萌新礼包英文版
        local Panel_ActBtn = self.actBtnItem:clone()
        local Button = TFDirector:getChildByName(Panel_ActBtn, "Button")
        local Label = TFDirector:getChildByName(Button, "Label")
        local Image_icon = TFDirector:getChildByName(Button, "Image_icon")
        local RedTip = TFDirector:getChildByName(Panel_ActBtn, "RedTip")
        Label:setTextById(190000366)
        Image_icon:setTexture("ui/fuli/icon5.png")
        self.btnListView:pushBackCustomItem(Panel_ActBtn)
        self.actBtns[EC_ActivityType2.NEWGIFT_PACK_EN] = Button
        Button:onClick(function()
                self:onTouchActBtn(Button)
        end)
        Button.id = EC_ActivityType2.NEWGIFT_PACK_EN
    end

    --月卡
    -- local Panel_cardBtn = self.actBtnItem:clone()
    -- local Button = TFDirector:getChildByName(Panel_cardBtn, "Button")
    -- local Label = TFDirector:getChildByName(Button, "Label")
    -- local Image_icon = TFDirector:getChildByName(Button, "Image_icon")
    -- local RedTip = TFDirector:getChildByName(Panel_cardBtn, "RedTip")
    -- Label:setTextById(1605005)
    -- Image_icon:setTexture("ui/monthcard/016.png")
    -- self.btnListView:pushBackCustomItem(Panel_cardBtn)
    -- self.actBtns[EC_ActivityType.MONTH_CARD] = Button
    -- Button:onClick(function()
    --     self:onTouchActBtn(Button)
    -- end)
    -- Button.id = EC_ActivityType.MONTH_CARD

    local activitys = ActivityDataMgr:getActivitys();
    for k,v in pairs(activitys) do
        if v.id == 3 then
            local btn           = self.actBtnItem:clone();
            local titleLabel    = TFDirector:getChildByPath(btn,"Label");
            local icon          = TFDirector:getChildByPath(btn,"Image_icon")
            local title         = ActivityDataMgr:getActTitle(v.id);
            titleLabel:setTextById(title)
            self.btnListView:pushBackCustomItem(btn)
            icon:setTexture("ui/fuli/icon3.png")
            local button        = TFDirector:getChildByPath(btn,"Button");
            button.id        = v.id;
            button.actIdx       = k;
            self.actBtns[v.id] = button
            button:onClick(function()
                self:onTouchActBtn(button);
            end)
        end
    end

    if FunctionDataMgr:isOpen(TabDataMgr:getData("Investor",1).systemId) then
        -- body
        local btn           = self.actBtnItem:clone();
        local titleLabel    = TFDirector:getChildByPath(btn,"Label");
        local icon          = TFDirector:getChildByPath(btn,"Image_icon")
        titleLabel:setTextById(14300289)
        self.btnListView:pushBackCustomItem(btn)
        icon:setTexture("ui/activity/activity_score/009.png")
        local button        = TFDirector:getChildByPath(btn,"Button");
        button.id        = EC_ActivityType.TOUZIREN;
        self.actBtns[ EC_ActivityType.TOUZIREN] = button
        button:onClick(function()
            self:onTouchActBtn(button);
        end)
    end

    if self.curActId and self.actBtns[self.curActId] then
        self:onTouchActBtn(self.actBtns[self.curActId]);
    else
        if self.btnListView:getItem(1) then
            self:onTouchActBtn(self.btnListView:getItem(1):getChildByName("Button"));
        end
    end

    self:showRedPoint();
end

function ActivityMain:updateTouziren( ... )
    if not self.touzirenView_ then
        self.touzirenView_ = requireNew("lua.logic.activity.Activity_touziren"):new()
        local x = -1136 * 0.5
        local y = -640 * 0.5
        local size = self.touzirenView_:getSize()
        self.touzirenView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.touzirenView_, self.Panel_tzr)
    end
end

function ActivityMain:updateNewGiftEn( ... )
    if not self.newGiftPackEnView then
        local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWGIFT_PACK_EN)[1]
        self.newGiftPackEnView = requireNew("lua.logic.activity.NewGiftByEnglishVerView"):new(activityId)
        local x = -1136 * 0.5 + 90
        local y = -640 * 0.5
        local size = self.newGiftPackEnView:getSize()
        self.newGiftPackEnView:setPosition(ccp(x, y))
        self:addLayerToNode(self.newGiftPackEnView, self.Panel_newGiftEn)
    end
end



function ActivityMain:showRedPoint()
    for k,v in pairs(self.actBtns) do
        local redTip = v:getParent():getChildByName("RedTip")
        redTip:setVisible(false)
        local isShow = false;

        if v.id == EC_ActivityType.CHRISTMAS_SIGN then
            local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_SIGN)
            if #activity > 0 then
                isShow = ActivityDataMgr2:isShowRedPoint(activity[1])
            end
            redTip:setVisible(isShow)
        elseif v.id == EC_ActivityType.MONTH_CARD then
            isShow = RechargeDataMgr:isMonthCardCanSign()
            redTip:setVisible(isShow)
        elseif v.id == EC_ActivityType.SUPPORT_STORE then
            isShow = false
        elseif v.id == EC_ActivityType.NEWGUY_SUMMON then
            local noobInfo = SummonDataMgr:getNoobInfo()
            isShow = noobInfo and noobInfo.awardState == 1
            redTip:setVisible(isShow)
        elseif v.id == EC_ActivityType.TOUZIREN then
            isShow = TaskDataMgr:isCanReceiveTask(TabDataMgr:getData("Investor",1).taskType)
            redTip:setVisible(isShow)
        elseif v.id == EC_ActivityType2.NEWGIFT_PACK_EN then
            local activityId =  ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWGIFT_PACK_EN)[1]
            if activityId then
                isShow = ActivityDataMgr2:isCanGet(activityId)
                redTip:setVisible(isShow)
            end
        else
            isShow= ActivityDataMgr:getIsCanReceive(v.actIdx)
            if isShow then
                if not v.newRed then
                    redTip:setVisible(true)
                end
            else
                if v.newRed then
                    redTip:setVisible(false)
                end
            end
        end
    end
    for i=1,7 do
        local redTips = TFDirector:getChildByPath(self["sevenExTag"..i], "Image_redTips")
        redTips:setVisible(ActivityDataMgr:getOneDayShowRedPoint(i))
    end
end

function ActivityMain:onTouchActBtn(button)
    if button.id == EC_ActivityType.SUPPORT_STORE then
        local storeData = StoreDataMgr:getOpenStore(EC_StoreType.SUPPORT_FIXED)
        if storeData[1] then
            local storeCfg = StoreDataMgr:getStoreCfg(storeData[1])
            local level = storeCfg.openContVal
            if MainPlayer:getPlayerLv() < level then
                Utils:showTips(2100037, level)
                return
            end
        end
    end

    if self.curpanel then
        self.curpanel:hide();
        self.selButton:setTextureNormal("");
    end

    self.curpanel = self.actPanels[button.id]:show();
    self.actUpdateFun[button.id](self);
    self.selButton = button;
    self.selButton:setTextureNormal("ui/common/left_side/side_select.png");
    self.curActId = button.id;
end

function ActivityMain:registerEvents()
    EventMgr:addEventListener(self,EV_ACTIVITY_UPDATE_UI,handler(self.updateUI, self));
    EventMgr:addEventListener(self,EV_ACTIVITY_LIST_CHANGE,handler(self.reShow, self));
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.updateSevenEx, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onSevenExReceiveEvent, self))
    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_UPDATE_NOOBAWARD, handler(self.onUpdateNoobAward, self))
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.updateUI, self))

    self.Button_receive:onClick(function()
            self:receiveReward();
        end)

    self.Button_nextDayReceive:onClick(function()
           self:receiveReward();
        end)

    self.Button_powerReceive:onClick(function()
            self:receiveReward();
    end)

    self.Button_sEx_buy:onClick(function()
            self:buySevenExGift()
        end)


    self.Button_sevenEx_gift:onClick(function()
        local sevenGiftBag = RechargeDataMgr:getSevenGiftBag(self.selectSevenExIdx)
        if sevenGiftBag and sevenGiftBag.buyCount ~= 0 and sevenGiftBag.buyCount - RechargeDataMgr:getBuyCount(sevenGiftBag.rechargeCfg.id) <= 0 then

        else
                Utils:openView("activity.SevenExGiftView", self.selectSevenExIdx)
        end
        end)

    for i=1,7 do
        local item = self["sevenExTag"..i];
        item:onClick(function()
                self.selectSevenExIdx = i;
                self:updateSevenEx();
            end)
    end

    self.Button_support_store:onClick(function()
            -- local storeData = StoreDataMgr:getOpenStore(EC_StoreType.SUPPORT_LIMIT)
            -- if storeData[1] then
            --     local storeCfg = StoreDataMgr:getStoreCfg(storeData[1])
            --     local level = storeCfg.openContVal
            --     if MainPlayer:getPlayerLv() >= level then
            --         Utils:openView("activity.SupportStoreView")
            --     else
            --         Utils:showTips(2100037, level)
            --     end
            -- end
            Utils:openView("supplyNew.SupplyMainNewView",2)
    end)

    self.Panel_awardConfirm:onClick(function()
        self:hideAwardConfirmView()
    end)

    self.Button_closeConfirm:onClick(function()
        self:hideAwardConfirmView()
    end)

    self.Button_ok:onClick(function()
        SummonDataMgr:send_SUMMON_GET_NOOB_AEARD({self.selectHeroId})
    end)
end

function ActivityMain:buySevenExGift()
    local sevenGiftBag = RechargeDataMgr:getSevenGiftBag(self.selectSevenExIdx)
    if sevenGiftBag then
        if sevenGiftBag.buyCount ~= 0 and sevenGiftBag.buyCount - RechargeDataMgr:getBuyCount(sevenGiftBag.rechargeCfg.id) <= 0 then
            Utils:showTips(800117);
        else
            RechargeDataMgr:getOrderNO(sevenGiftBag.rechargeCfg.id);
        end
    end
end

function ActivityMain:receiveReward()
    local actIdx = ActivityDataMgr:getActIdx(self.curActId)
    ActivityDataMgr:receiveReward(actIdx)
end

function ActivityMain:updateSign()
    local actIdx = ActivityDataMgr:getActIdx(EC_ActivityType.SIGN)
    local entryCnt = ActivityDataMgr:getActEntryCnt(actIdx)

    local col = 8
    local row = math.floor((entryCnt - 1) / col) + 1

    local Panel_reward = TFDirector:getChildByPath(self.Panel_sign, "Panel_reward")
    local size = Panel_reward:getSize()
    Panel_reward:removeAllChildren();

    local Image_item_bg = TFDirector:getChildByPath(self.Panel_prefab, "Image_item_bg")
    local receivedIdx   = ActivityDataMgr:getReceivedIndex(actIdx);
    local isCanReceive  = ActivityDataMgr:getIsCanReceive(actIdx);
    
    local canSignAain, canSignDay,  hadSupplyDays = ActivityDataMgr:isCanSignAgainByIdx(actIdx)
    local kvpCfg      = ActivityDataMgr:getSignKvpCfg()
    local goodsCost   = nil
    local _cfg        = kvpCfg["supplyCost"][hadSupplyDays+ 1]
    if _cfg then
        local _id , _num = next(kvpCfg["supplyCost"][hadSupplyDays + 1])
        goodsCost   = {id = _id, num = _num}
        self.Panel_sign.imgIcon:setTexture(GoodsDataMgr:getItemCfg(goodsCost.id).icon)
        local _txt = GoodsDataMgr:getItemCount(goodsCost.id).."/"..goodsCost.num
        self.Panel_sign.lab_signCost:setText(_txt)
    end
    self.Panel_sign.lab_signLastNum:setText(canSignDay)
    self.Panel_sign.img_signNum:setVisible(nil ~= _cfg)

    for index = 1, entryCnt do
        local i = (index-1) % col + 1
        local j = math.ceil(index / col)

        local x = (i-0.5) * (size.width / col)
        local y = (row-j+0.5) * (size.height / row)

        local item = Image_item_bg:clone():show()
        Panel_reward:addChild(item)
        item:setScale(0.9)
        item:setPosition(ccp(x, y))
        self:updateOneSignEntry(item,index);


        -- if index < receivedIdx then
        --     item:getChild("Image_gray"):show()
        --     --item:setGrayEnabled(true);
        -- end
    end

    self.Button_receive:setGrayEnabled(not isCanReceive and not canSignAain);
    self.Button_receive:setTouchEnabled(isCanReceive or canSignAain);

    local receiveLabel = TFDirector:getChildByPath(self.Button_receive,"Label_receive");
    if not isCanReceive and not canSignAain then
        receiveLabel:setTextById(1810002);
    elseif not isCanReceive and  canSignAain then
        receiveLabel:setText("补签")
    else
        receiveLabel:setTextById(1810001);
    end

    -- TODO CLOSE
    -- 屏蔽补签功能
    -------------------------------------
    self.Panel_sign.img_signNum:setVisible(false)
    self.Button_receive:setGrayEnabled(not isCanReceive);
    self.Button_receive:setTouchEnabled(isCanReceive);

    local receiveLabel = TFDirector:getChildByPath(self.Button_receive,"Label_receive")
    if not isCanReceive then
        receiveLabel:setTextById(1810002)
    else
        receiveLabel:setTextById(1810001)
    end
    -------------------------------------
end

function ActivityMain:updateOneSignEntry(item,index)
    local actIdx = ActivityDataMgr:getActIdx(EC_ActivityType.SIGN)
    local status, rewards = ActivityDataMgr:getActOneEntry(actIdx,index);
    local id,num;
    for k,v in pairs(rewards) do
        id = k;
        num = v;
    end

    local itemCfg = GoodsDataMgr:getItemCfg(id);
    item:setTexture(EC_ItemIcon[itemCfg.quality]);
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon");
    Image_icon:setTexture(itemCfg.icon);
    --Image_icon:setSize(CCSizeMake(90,90));

    local Label_num = TFDirector:getChildByPath(item,"Label_num");
    Label_num:setString(tostring(num));

    local Image_select = TFDirector:getChildByPath(item,"Image_select");
    Image_select:setVisible(status == 1);

    local Image_recieved = TFDirector:getChildByPath(item,"Image_recieved");
    Image_recieved:setVisible(status == 0);


    local Image_gray = TFDirector:getChildByPath(item, "Image_gray")
    Image_gray:setVisible(status == 0)

    if itemCfg.superType == EC_ResourceType.SPIRIT then
        for i=1,itemCfg.star do
            TFDirector:getChildByPath(item,"Image_star"..i):show();
        end
    end

    item:setTouchEnabled(true);
    item:onClick(function()
            Utils:showInfo(id);
        end)
end

function ActivityMain:updateSeven()
    if not self.seventSignView_ then
        self.seventSignView_ = requireNew("lua.logic.activity.SevenSignView"):new(true)
        local x = -GameConfig.WS.width * 0.5
        local y = -GameConfig.WS.height * 0.5
        local size = self.seventSignView_:getSize()
        self.seventSignView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.seventSignView_, self.Panel_seven)
    end
end

function ActivityMain:updateNextDay()
    local actIdx    = ActivityDataMgr:getActIdx(EC_ActivityType.NEXTDAY)
    local bgPath    = ActivityDataMgr:getActBg(actIdx);
    self.Panel_nextDay.bg:setTexture(bgPath);

    local status, rewards = ActivityDataMgr:getActOneEntry(actIdx,1);
    local textLabel = self.Button_nextDayReceive:getChildByName("Label_nextDayReceive");
    if status == 0 then
        textLabel:setTextById(700013);
        self.Button_nextDayReceive:setGrayEnabled(true);
        self.Button_nextDayReceive:setTouchEnabled(false);
    elseif status == 1 then
        textLabel:setTextById(700013);
        self.Button_nextDayReceive:setGrayEnabled(false);
        self.Button_nextDayReceive:setTouchEnabled(true);
    else
        textLabel:setTextById(600025);
        self.Button_nextDayReceive:setGrayEnabled(true);
        self.Button_nextDayReceive:setTouchEnabled(false);
    end
end

function ActivityMain:updatePower()
    local actId     = EC_ActivityType.POWER
    local actIdx    = ActivityDataMgr:getActIdx(actId)
    local data      = ActivityDataMgr:getActData(actIdx)
    local isCanReceive = ActivityDataMgr:getIsCanReceive(actIdx);
    self.Button_powerReceive:setTouchEnabled(isCanReceive)
    self.Button_powerReceive:setGrayEnabled(not isCanReceive)
    
    local timeTab = {}
    local idx =  1;
    local tempStr = "%02d:00-%02d:00";
    local function setString(time1,time2)
        local _time1 = time1 / 3600;
        local _time2 = time2 / 3600;
        timeTab[idx] = string.format(tempStr,_time1,_time2);
        idx = idx + 1;
    end
    local actCfg1 = ActivityDataMgr:getActivityFirstCfgById(actId, 1)
    local actCfg2 = ActivityDataMgr:getActivityFirstCfgById(actId, 2)
    if actCfg1 and actCfg1.time then
        for k,v in pairs(actCfg1.time) do
            setString(tonumber(k), tonumber(v))
        end
    end

    if actCfg2 and actCfg2.time then
        for k,v in pairs(actCfg2.time) do
            setString(tonumber(k), tonumber(v))
        end
    end
    self.Label_powerTime:setText(timeTab[1])
    self.Label_powerTime2:setText(timeTab[2])
    --self.Label_powerTime:setTextById("r40001", unpack(timeTab))
end

function ActivityMain:updateSupportStore()
    if not self.supportStoreView_ then
        self.supportStoreView_ = requireNew("lua.logic.activity.SupportStoreView"):new(true)
        local x = -GameConfig.WS.width * 0.5 + 40
        local y = -GameConfig.WS.height * 0.5
        local size = self.supportStoreView_:getSize()
        self.supportStoreView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.supportStoreView_, self.Panel_support_store)
    end
end

function ActivityMain:updateSevenEx()
    if not ActivityDataMgr:checkSevenExEnable() then
        return
    end
    local curDayTag = ActivityDataMgr:getSevenExCurDayTag();
    local sevenExData = ActivityDataMgr:getSevenExData();
    self.sevenExTask_ = sevenExData[self.selectSevenExIdx];

    local items = self.ListView_sevenEx:getItems()
    local gap = #self.sevenExTask_ - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local Panel_dailyItem = self:addSevenExItem()
            self.ListView_sevenEx:pushBackCustomItem(Panel_dailyItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_sevenEx:removeItem(1)
        end
    end

    local items = self.ListView_sevenEx:getItems()
    for i, v in ipairs(items) do
        local item = self.sevenExItem_[v]
        local taskCid = self.sevenExTask_[i]
        local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
        local taskInfo = TaskDataMgr:getTaskInfo(taskCid) or {progress = 0, status = EC_TaskStatus.ING, virtual = true}
        item.Label_progress:setTextById(800005, taskInfo.progress, taskCfg.progress)
        if taskInfo.progress > taskCfg.progress then
            item.Label_progress:setTextById(800005, taskCfg.progress, taskCfg.progress)
        end
        item.Image_icon:setTexture(taskCfg.icon)
        local desc = TaskDataMgr:getTaskDesc(taskCid)
        item.Label_desc:setText(desc)
        item.Label_name:setTextById(taskCfg.name)
        -- item.Image_type:setVisible(#taskCfg.typeDes > 0)
        -- item.Label_type:setVisible(#taskCfg.typeDes > 0)
        -- if item.Label_type:isVisible() then
        --     item.Label_type:setTextById(taskCfg.typeDes)
        -- end
        local size=  item.Label_name:Size()
        item.Image_active:PosX(size.width + 10)

        local showReward = {}
        local activeReward
        for i, v in ipairs(taskCfg.reward) do
            if v[1] == EC_SItemType.ACTIVITY then
                activeReward = v
            else
                table.insert(showReward, v)
            end
        end
        item.Image_active:setVisible(tobool(activeReward))
        if activeReward then
            local itemCfg = GoodsDataMgr:getItemCfg(activeReward[1])
            item.Image_active_icon:setTexture(itemCfg.icon)
            item.Label_active_num:setTextById(800007, activeReward[2])
        end

        for j, Panel_reward in ipairs(item.Panel_reward) do
            local reward = showReward[j]
            if reward then
                Panel_reward.Panel_goodsItem:show()
                PrefabDataMgr:setInfo(Panel_reward.Panel_goodsItem, reward[1], reward[2])
            else
                Panel_reward.Panel_goodsItem:hide()
            end
        end

        item.Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
        item.Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
        item.Label_receive:setTextById(1300008)
        item.Button_goto:setVisible(taskInfo.status == EC_TaskStatus.ING and taskCfg.jumpInterface ~= 0)
        item.Label_goto:setTextById(1300009)

        if taskInfo.virtual then
            item.Button_goto:setTouchEnabled(false)
            item.Button_goto:setGrayEnabled(true)
        else
            item.Button_goto:setTouchEnabled(true)
            item.Button_goto:setGrayEnabled(false)
        end

        item.Button_goto:onClick(function()
                if taskCfg.subType == EC_TaskSubType.LEVEL then
                    local levelId = taskCfg.finishParams["dunId"]
                    FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface, levelId)
                else
                    FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
                end
        end)

        item.Button_receive:onClick(function()
                TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
        end)
    end

    --七日狂欢标签
    for i=1,7 do
        local item = self["sevenExTag"..i];
        item:setTouchEnabled(true)
        local Label_day_tag = TFDirector:getChildByPath(item,"Label_day_tag");
        local Label_day_tag1 = TFDirector:getChildByPath(item,"Label_day_tag1");
        local Image_yulan = TFDirector:getChildByPath(item,"Image_yulan");
        Image_yulan:hide()
        if i <= curDayTag then
            Label_day_tag:setFontColor(ccc3(87,171,229))
            Label_day_tag1:setFontColor(ccc3(87,171,229))
            item:setTexture("ui/activity/sevenEx/006.png");
        end

        if i > curDayTag then
            Label_day_tag:setFontColor(ccc3(255,255,255))
            Label_day_tag1:setFontColor(ccc3(255,255,255))
            item:setTexture("ui/activity/sevenEx/008.png");
            if i > curDayTag + 1 then
                item:setTouchEnabled(false)
            else
                Image_yulan:show()
            end
        end

        if i == self.selectSevenExIdx then
            Label_day_tag:setFontColor(ccc3(255,255,255))
            Label_day_tag1:setFontColor(ccc3(255,255,255))
            item:setTexture("ui/activity/sevenEx/007.png");
        end
    end

    for i=1,6 do
        self["sevenExTagLine"..i]:setVisible(i < curDayTag);
    end

    ---七日狂欢礼包
    local Label_price_now = TFDirector:getChildByPath(self.panel_sevenEx,"Label_price_now");
    local sevenGiftBag = RechargeDataMgr:getSevenGiftBag(self.selectSevenExIdx)
    if sevenGiftBag then
        Label_price_now:setTextById(1605003 ,string.format("%.2f" ,sevenGiftBag.rechargeCfg.price/100))

        if (sevenGiftBag.buyCount ~= 0 and sevenGiftBag.buyCount - RechargeDataMgr:getBuyCount(sevenGiftBag.rechargeCfg.id) <= 0) or self.selectSevenExIdx > curDayTag then
            self.Button_sEx_buy:setTouchEnabled(false)
            self.Button_sEx_buy:setGrayEnabled(true)
        else
            self.Button_sEx_buy:setTouchEnabled(true)
            self.Button_sEx_buy:setGrayEnabled(false)
        end
    end

    local curDayCfg = TabDataMgr:getData("SevenGift",self.selectSevenExIdx);
    local Label_price_old = TFDirector:getChildByPath(self.panel_sevenEx,"Label_price_old");
    Label_price_old:setTextById(1605003 ,string.format("%.2f" ,curDayCfg.saleprice[500002]/100))

    self:showRedPoint()
end

function ActivityMain:addSevenExItem()
    local Panel_sevenExItem = self.Panel_sevenExItem:clone()
    local item = {}
    item.root = Panel_sevenExItem
    item.Label_progress = TFDirector:getChildByPath(item.root, "Label_progress")
    item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Image_active = TFDirector:getChildByPath(item.Label_name, "Image_active"):hide()
    item.Image_active_icon = TFDirector:getChildByPath(item.Image_active, "Image_active_icon")
    item.Label_active_num = TFDirector:getChildByPath(item.Image_active, "Label_active_num")
    item.Label_desc = TFDirector:getChildByPath(item.root, "Label_desc")
    item.Panel_reward = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item.root, "Image_reward_" .. i)
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Scale(0.75)
        foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.root)
        item.Panel_reward[i] = foo
    end
    item.Button_goto = TFDirector:getChildByPath(item.root, "Button_goto")
    item.Label_goto = TFDirector:getChildByPath(item.Button_goto, "Label_goto")
    item.Button_receive = TFDirector:getChildByPath(item.root, "Button_receive")
    item.Label_receive = TFDirector:getChildByPath(item.Button_receive, "Label_receive")
    item.Label_reward = TFDirector:getChildByPath(item.root, "Label_reward")
    item.Label_reward:setTextById(1300018)
    item.Image_type = TFDirector:getChildByPath(item.root, "Image_type")
    item.Label_type = TFDirector:getChildByPath(item.root, "Label_type")
    item.Label_geted = TFDirector:getChildByPath(item.root, "Label_geted")
    self.sevenExItem_[item.root] = item
    return Panel_sevenExItem
end

function ActivityMain:updateChristmasSign()
    if not self.christmsSignInView_ then
        self.christmsSignInView_ = requireNew("lua.logic.activity.ChristmasSignInView"):new(true)
        local x = -GameConfig.WS.width * 0.5
        local y = -GameConfig.WS.height * 0.5
        local size = self.christmsSignInView_:getSize()
        self.christmsSignInView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.christmsSignInView_, self.Panel_christmasSign)
    end
end

function ActivityMain:updateMonthCard()
    if not self.monthCardView_ then
        self.monthCardView_ = requireNew("lua.logic.activity.MonthCardView"):new()
        local x = -GameConfig.WS.width * 0.5
        local y = -GameConfig.WS.height * 0.5
        self.monthCardView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.monthCardView_, self.Panel_monthCard)
    end
    self.monthCardView_:updateContentView()
end

function ActivityMain:showNoobSummonConfirm(selectHeroId)
    self.selectHeroId = selectHeroId
    self.Panel_awardConfirm:setVisible(true)
    local name = HeroDataMgr:getName(selectHeroId)
    self.Label_awardConfirmtip:setTextById(100000305 , name)
    self.Label_awardConfirmtip1:setTextById(100000306)

end

function ActivityMain:hideAwardConfirmView()
    self.Panel_awardConfirm:setVisible(false)
end

---萌新召唤
function ActivityMain:updateNewGuySummon()

    local function callbck(selectHeroId)
        self:showNoobSummonConfirm(selectHeroId)
    end

    if not self.newGuySummonView_ then
        self.newGuySummonView_ = requireNew("lua.logic.activity.NewGuySummonView"):new(callbck)
        local x = -GameConfig.WS.width * 0.5
        local y = -GameConfig.WS.height * 0.5
        local size = self.newGuySummonView_:getSize()
        self.newGuySummonView_:setPosition(ccp(x, y))
        self:addLayerToNode(self.newGuySummonView_, self.Panel_newGuy)
    end
end

function ActivityMain:onUpdateNoobAward()
    self:showRedPoint()
    self:hideAwardConfirmView()
end

function ActivityMain:onSevenExReceiveEvent(reward)
    Utils:showReward(reward)
end

function ActivityMain:onUpdateProgressEvent()
    self:showRedPoint()
end

return ActivityMain
