--[[
    @desc：LandTurnTabletView
]]

local LandTurnTabletView = class("LandTurnTabletView",BaseLayer)

local Row = 3    -- 行
local Line = 5   -- 列

function LandTurnTabletView:initData()
    self.isFirstIn = true
    self.activityId   = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.LAND_TURNTABLET)[1]
    self.activityInfo =  ActivityDataMgr2:getActivityInfo(self.activityId)
    ActivityDataMgr2:send_ACTIVITY_REQ_ASSISTANCE_INFO(self.activityId)
    self.items = {}
    self.brandCfg = {}
    self.sumRound = self.activityInfo.extendData.roundMax
    self.sumFloor = 1
    for i, v in ipairs(TabDataMgr:getData("Brand")) do
        self.brandCfg[v.id] = v
        self.sumFloor = math.max(self.sumFloor, v.Round)
    end
end

function LandTurnTabletView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.landTurnTabletView")
end

function LandTurnTabletView:initUI(ui)
    self.super.initUI(self,ui)
    self.listView = UIListView:create(self._ui.ScrollView_landFloor)
    self.listView:setItemsMargin(8)
    self._ui.btn_one:setTouchEnabled(false)
    self._ui.btn_ten:setTouchEnabled(false)

    self._ui.label_timeTxt:setSkewX(10)
    self._ui.label_timeBegin:setSkewX(10)
    self._ui.label_timeEnd:setSkewX(10)
    self._ui.label_timeBegin:setTextById(1410001, Utils:getDate(self.activityInfo.startTime))
    self._ui.label_timeEnd:setTextById(1410001, Utils:getDate(self.activityInfo.endTime))
    local itemId = self.activityInfo.extendData.costItem
    local itemName = TextDataMgr:getText(GoodsDataMgr:getItemCfg(itemId).nameTextId)
    self._ui.lab_des:setTextById(63829,itemName)
    self._ui.lab_haveItemDesc:setTextById(63830)
    self._ui.costIemIconCopy:setTexture(GoodsDataMgr:getItemCfg(itemId).icon)
    self._ui.costIemIconCopy:setSize(CCSizeMake(35,35))

    self:initAllTablets()
    self:refreshTaskReward()
end

function LandTurnTabletView:registerEvents()
    EventMgr:addEventListener(self, EV_LAND_TURNTABLET_INFO, handler(self.updateView, self))
    EventMgr:addEventListener(self, EV_LAND_TURNTABLET_REWARD, handler(self.onRecvReward, self))
    EventMgr:addEventListener(self, EV_LAND_TURNTABLET_RANK, handler(self.onRecvRankData, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.refreshOtherUI, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.refreshTaskReward, self))
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuyResourceEvent, self))

    self._ui.btn_one:onClick(function()
        self:turnTabletClickFunc(1)
    end)
    
    self._ui.btn_ten:onClick(function()
        self:turnTabletClickFunc(5)
    end)

    self._ui.btn_rank:onClick(function(sender)
        sender:setTouchEnabled(false)
        ActivityDataMgr2:send_ACTIVITY_REQ_ASSISTANCE_FLOP_RANK(self.activityId)
    end)

    self._ui.Button_rule:onClick(function()
        Utils:openView("common.TxtRuleContentShowView", {63844})
    end)

    self._ui.img_costItemInfo:setTouchEnabled(true)
    self._ui.img_costItemInfo:onClick(function()
        Utils:showInfo(self.activityInfo.extendData.costItem, nil, true)
    end)

    self._ui.img_costItemInfo1:setTouchEnabled(true)
    self._ui.img_costItemInfo1:onClick(function()
        Utils:showInfo(self.activityInfo.extendData.costItem, nil, true)
    end)
end

function LandTurnTabletView:refreshTaskReward()
    local taskIds = self.activityInfo.items
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, taskIds[1])
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, taskIds[1])
    local id, num = next(itemInfo.reward)
    self._ui.costIemIcon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
    self._ui.costIemIcon:setSize(CCSizeMake(80,80))
    self._ui.lab_dayCanGetted:setTextById(302201,num)
    local lab = self._ui.btn_getReward:getChildByName("label")
    if progressInfo.status == EC_TaskStatus.GET then
        lab:setTextById(700013)
    else
        lab:setTextById(600025)
    end
    self._ui.btn_getReward:setTouchEnabled(progressInfo.status == EC_TaskStatus.GET)
    self._ui.btn_getReward:setGrayEnabled(progressInfo.status == EC_TaskStatus.GETED)
    self._ui.btn_getReward:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, taskIds[1])
    end)
end

function LandTurnTabletView:turnTabletClickFunc(turnNum)
    local costId = self.activityInfo.extendData.costItem
    local lastTurnNum = self:getCurTurnNumAndSum() 
    local count = GoodsDataMgr:getItemCount(costId)

    if turnNum > lastTurnNum then
        Utils:showTips(63849)
        return
    else
        if turnNum > count then
            local itemrecoverId = self.activityInfo.extendData.Itemrecover
            local itemRecoverCfg = StoreDataMgr:getItemRecoverCfg(itemrecoverId)
            local buyCount = StoreDataMgr:getItemRecoverBuyCount(itemrecoverId)
            local remainCount = math.max(0, #(itemRecoverCfg.price) - buyCount)
            if remainCount > 0 then
                local maxCanGetCostNum = math.min(remainCount, (turnNum - count))
                local costNum = 0 
                local targetNum = 0
                for i = 1, maxCanGetCostNum do
                    local _costData = itemRecoverCfg.price[buyCount + i][1]
                    costNum = _costData[1].num + costNum
                    targetNum = _costData.targetNum + targetNum
                end
                local costId = itemRecoverCfg.price[buyCount + 1][1][1].id
                local costCfg = GoodsDataMgr:getItemCfg(costId)
                local costName = TextDataMgr:getText(costCfg.nameTextId)
                local targetName = TextDataMgr:getText(GoodsDataMgr:getItemCfg(self.activityInfo.extendData.costItem).nameTextId)
                local hadBuyCount = TextDataMgr:getText(800005, buyCount, #(itemRecoverCfg.price))
                local args = {
                    tittle = 63828,
                    content = TextDataMgr:getText(63848, costNum,costCfg.icon,targetNum,targetName,hadBuyCount),
                    confirmCall = function()
                        if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                            self.targetId = self.activityInfo.extendData.costItem
                            self.targetNum = targetNum
                            StoreDataMgr:send_PLAYER_REQ_BUY_RESOURCES(itemrecoverId, maxCanGetCostNum)
                        else
                            Utils:showTips(TextDataMgr:getText(63847, costName))
                        end
                    end,
                }
                Utils:showReConfirm(args)
            else
                local args = {
                    tittle = 63828,
                    content = TextDataMgr:getText(63833),
                    confirmCall = function()
                    end,
                }
                Utils:showReConfirm(args)
            end
        else
            local num = math.min(count, lastTurnNum)
            if turnNum > num then
                local args = {
                    tittle = 63828,
                    content = TextDataMgr:getText(63832, num),
                    confirmCall = function()
                        ActivityDataMgr2:send_ACTIVITY_REQ_ASSISTANCE_FLOP(self.activityId, num)
                    end,
                }
                Utils:showReConfirm(args)
            else
                local args = {
                    tittle = 63828,
                    content = TextDataMgr:getText(63831, turnNum), 
                    confirmCall = function()
                        ActivityDataMgr2:send_ACTIVITY_REQ_ASSISTANCE_FLOP(self.activityId, turnNum)
                    end,
                }
                Utils:showReConfirm(args)
            end
        end
    end
end

function LandTurnTabletView:initAllTablets()
    self._ui.panel_gameMain:removeAllChildren()
    
    local itemScale = 1
    local size = self._ui.panel_gameMain:getContentSize()
    local itemSize = self._ui.tabletItem:getContentSize()
    self._ui.tabletItem:setScale(itemScale)
    local limitWidth = itemSize.width * itemScale
    local limitHight = itemSize.height * itemScale
    local disW = (size.width - itemSize.width * Line)/(Line - 1)
    local disH = (size.height - itemSize.height * Row)/(Row - 1)

    for i = 1, Row * Line do
        local _x, _y
        local item = self._ui.tabletItem:clone()
        local _row = math.ceil(i / Line)
        local _line = i % Line
        _line = _line == 0 and Line or _line

        if _line == 1 then     
            _x = limitWidth / 2
        elseif _line == Line then
            _x = size.width - limitWidth / 2
        else
            _x = (limitWidth + disW) * (_line - 1) + limitWidth / 2
        end

        if _row == 1 then      
            _y = -limitWidth / 2
        elseif _row == Line then
            _y = -size.height + limitHight / 2
        else
            _y = -(limitHight + disH) * (_row - 1) - limitHight / 2
        end

        item:setTouchEnabled(false)
        self.items[i] = item
        item:setPosition(ccp(_x, _y))
        item:AddTo(self._ui.panel_gameMain)
    end
end

function LandTurnTabletView:initListView()
    self.listView:removeAllItems()
    for i = 1, self.sumFloor do
        local item = self._ui.floorItem:clone()
        item.img_normal = TFDirector:getChildByPath(item, "img_normal")
        item.img_curTag = TFDirector:getChildByPath(item, "img_curTag")
        item.lab_txtNormal = TFDirector:getChildByPath(item.img_normal, "lab_txtNormal")
        item.img_lock = TFDirector:getChildByPath(item, "img_lock")
        item.lab_txtLock = TFDirector:getChildByPath(item.img_lock, "lab_txtLock")
        item.lab_lastNum = TFDirector:getChildByPath(item.img_normal, "lab_lastNum")
        self.listView:pushBackCustomItem(item)
    end
    self:refreshListView()
end

function LandTurnTabletView:refreshListView()
    local curFloor = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).round
    local turnNum, sumNum = self:getCurTurnNumAndSum()
    for i, item in ipairs(self.listView:getItems()) do
        item.lab_lastNum:setTextById(800005, turnNum, sumNum)
        item.lab_lastNum:setVisible(i == curFloor)
        item.lab_txtNormal:setTextById(63827,i)
        item.lab_txtLock:setTextById(63827,i)
        item.img_curTag:setVisible(i == curFloor)
        item.img_normal:setVisible(i <= curFloor)
        item.img_lock:setVisible(i > curFloor)
        item:setTouchEnabled(true)
        item:onClick(function()
            if i > curFloor then
                Utils:showTips(63836)
            elseif i == curFloor and not self:isFinishAllRound() then
                Utils:showTips(63837)
            else
                Utils:showTips(63838)
            end
        end)
    end
    self.listView:jumpToItem(curFloor)
    self.listView:doLayout()
end

function LandTurnTabletView:refreshAllTablets()
    local data = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).asInfo
    for i, v in ipairs(self.items) do
        local info = data[i]
        local isHadShow = info.status or false
        local Image_iconFrame = TFDirector:getChildByPath(v, "Image_iconFrame")
        local Image_hadGetted = TFDirector:getChildByPath(v, "Image_hadGetted")
        Image_iconFrame:setVisible(not isHadShow)
        Image_hadGetted:setVisible(isHadShow)
        if isHadShow then
            if not v.goods then
                local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                goods:setScale(0.75)
                goods:Pos(ccp(0, 0))
                goods:AddTo(Image_hadGetted, 1)
                v.goods = goods
            end
            local cfg = self.brandCfg[info.id]
            local key, value = next(cfg.reward)
            PrefabDataMgr:setInfo(v.goods, key, value)
        end
    end
end

function LandTurnTabletView:getCurTurnNumAndSum()
    local data = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).asInfo
    local turnNum = 0
    for i, v in ipairs(data) do
        if not v.status then
            turnNum = turnNum + 1
        end
    end
    return turnNum, #data
end

function LandTurnTabletView:refreshOtherUI()
    local num = GoodsDataMgr:getItemCount(self.activityInfo.extendData.costItem)
    local curRound = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).roundNum
    self._ui.lab_itemNum:setText(num)
    self._ui.lab_curRound:setTextById(800005, curRound, self.sumRound)
end

function LandTurnTabletView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function LandTurnTabletView:updateView()
    self:refreshAllTablets()
    self:refreshOtherUI()

    if self.isFirstIn then
        self:initListView()
        self._ui.btn_one:setTouchEnabled(true)
        self._ui.btn_ten:setTouchEnabled(true)
        self.isFirstIn = false
    else
        self:refreshListView()
    end

    local _isFinishAllRound = self:isFinishAllRound()
    self._ui.btn_one:setTouchEnabled(not _isFinishAllRound)
    self._ui.btn_ten:setTouchEnabled(not _isFinishAllRound)
    -- self._ui.btn_one:setGrayEnabled(_isFinishAllRound)
    -- self._ui.btn_ten:setGrayEnabled(_isFinishAllRound)
    self._ui.btn_one:setVisible(not _isFinishAllRound)
    self._ui.btn_ten:setVisible(not _isFinishAllRound)
    self._ui.img_noRound:setVisible(_isFinishAllRound)
end

function LandTurnTabletView:onRecvReward(data)
    local function hideCallBack()
        local isOpen = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET).open
        if self.isFirstIn then
            return
        end
        if isOpen then
            local args = {
                tittle = 63828,
                content = TextDataMgr:getText(63843),
                confirmCall = function()
                end,
            }
            Utils:showReConfirm(args)
        end
    end
    Utils:showReward(data, nil, hideCallBack)
end

function LandTurnTabletView:isFinishAllRound()
    local isFinishAllTurn = false
    local data = ActivityDataMgr2:getCfgDataByType(EC_ActivityType2.LAND_TURNTABLET)
    local turnNum = self:getCurTurnNumAndSum()
    if self.sumFloor == data.round and turnNum == 0 and data.roundNum >= self.sumRound then
        isFinishAllTurn = true
    end
    return isFinishAllTurn
end

function LandTurnTabletView:onRecvRankData(rankData)
    local turnNum, sumNum = self:getCurTurnNumAndSum()
    Utils:openView("activity.LandTurnTabletRankView", rankData, self:isFinishAllRound(), (sumNum - turnNum))
    self._ui.btn_rank:setTouchEnabled(true)
    ActivityDataMgr2:setLandTabletRankRedFalse()
end

function LandTurnTabletView:onBuyResourceEvent()
    if  self.targetId and self.targetNum then
        Utils:showReward({{id = self.targetId, num = self.targetNum}})
    end
end

function LandTurnTabletView:onShow()
    self.super.onShow(self)
    self._ui.img_rankRed:setVisible(ActivityDataMgr2:isLandTabletRankRedShow())
end

return LandTurnTabletView