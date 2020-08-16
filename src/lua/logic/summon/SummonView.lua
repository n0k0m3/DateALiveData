
local SummonView = class("SummonView", BaseLayer)

function SummonView:initData(paramIdx, selectHotTabIndex)
    self.summon_ = SummonDataMgr:getSummon()
    dump(self.summon_)
    self.summonItems_ = {}
    self.costItem_ = {}
    self.selectHotTabIndex_ = selectHotTabIndex or 1
    self.paramIdx_ = paramIdx

    self.hotSpotData_ = {
        [1] = {
            loopType = EC_SummonLoopType.ROLE,
            text = 1200064,
        },
        [2] = {
            loopType = EC_SummonLoopType.EQUIPMENT,
            text = 1200065,
        },
    }
    self.checkBtn = {}
end

function SummonView:getClosingStateParams()
    return {self.selectIndex_, self.selectHotTabIndex_}
end

function SummonView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonView")
end

function SummonView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_summonItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_summonItem")

    self.Button_check = TFDirector:getChildByPath(self.Panel_prefab, "Button_check")

    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    local ScrollView_summon = TFDirector:getChildByPath(self.Panel_root, "ScrollView_summon")
    self.ListView_summon = UIListView:create(ScrollView_summon)
    self.Image_preview = TFDirector:getChildByPath(self.Panel_root, "Image_preview")
    self.Button_preview = TFDirector:getChildByPath(self.Image_preview, "Button_preview")
    self.Image_preview_pos = self.Image_preview:Pos()
    self.Image_history = TFDirector:getChildByPath(self.Panel_root, "Image_history")
    self.Button_history = TFDirector:getChildByPath(self.Image_history, "Button_history")
    self.Image_history_pos = self.Image_history:Pos()
    self.Image_curOwn = TFDirector:getChildByPath(self.Panel_root, "Image_curOwn")
    self.Image_ownIcon = TFDirector:getChildByPath(self.Image_curOwn, "Image_ownIcon")
    self.Label_have = TFDirector:getChildByPath(self.Image_curOwn, "Label_have")
    self.Label_cur = TFDirector:getChildByPath(self.Image_curOwn, "Label_cur")
    self.Button_buy = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_root, "Button_buy_" .. i)
        item.Label_summon = TFDirector:getChildByPath(item.root, "Label_summon")
        item.Image_costIcon = TFDirector:getChildByPath(item.root, "Image_costIcon")
        item.Label_costNum = TFDirector:getChildByPath(item.root, "Label_costNum")
        item.Image_upTips = TFDirector:getChildByPath(item.root, "Image_upTips"):hide()
        self.Button_buy[i] = item
    end

    --英雄奖励按钮
    self.Button_award = TFDirector:getChildByPath(self.Panel_root, "Button_award")
    self.heroRewardNew = TFDirector:getChildByPath(self.Button_award, "Image_new")

    --质点按钮
    self.Button_equip = TFDirector:getChildByPath(self.Panel_root, "Button_equip")

    self.Button_newGuy = TFDirector:getChildByPath(self.Panel_root, "Button_newGuy"):hide()
    self.Image_noobnew = TFDirector:getChildByPath(self.Button_newGuy, "Image_new")
    self.Label_noob_cnt = TFDirector:getChildByPath(self.Button_newGuy, "Label_noob_cnt")
    local summonTimes = Utils:getKVP(14007, "summonTimes")
    self.Label_noob_cnt:setText(summonTimes)
    self.Label_tips = TFDirector:getChildByPath(self.Panel_root, "Label_tips"):hide()

    self.Button_goto = TFDirector:getChildByPath(self.Panel_root, "Button_goto"):hide()
    self.Button_show = TFDirector:getChildByPath(self.Panel_root, "Button_show"):hide()

    -- 契约召唤
    self.Panel_contract = TFDirector:getChildByPath(self.Panel_root, "Panel_contract")
    self.Button_contract_preview = TFDirector:getChildByPath(self.Panel_contract, "Button_contract_preview")
    self.Label_contract_tips = TFDirector:getChildByPath(self.Panel_contract, "Label_contract_tips")
    self.Image_contract_count = TFDirector:getChildByPath(self.Label_contract_tips, "Image_contract_count")
    self.Label_contract_count = TFDirector:getChildByPath(self.Image_contract_count, "Label_contract_count")

    self.Image_marquee = TFDirector:getChildByPath(self.Panel_root, "Image_marquee"):hide()
    self.Panel_marquee_mask = TFDirector:getChildByPath(self.Image_marquee, "Panel_marquee_mask")
    self.Label_marquee = TFDirector:getChildByPath(self.Panel_marquee_mask, "Label_marquee")

    self.Panel_hotSPot = TFDirector:getChildByPath(self.Panel_root, "Panel_hotSPot"):hide()
    local Panel_hotPreview = TFDirector:getChildByPath(self.Panel_hotSPot, "Panel_hotPreview"):hide()
    local Panel_hotHistory = TFDirector:getChildByPath(self.Panel_hotSPot, "Panel_hotHistory"):hide()
    self.Panel_hotPreview_pos = Panel_hotPreview:Pos()
    self.Panel_hotHistory_pos = Panel_hotHistory:Pos()
    self.Button_trailNotice = TFDirector:getChildByPath(self.Panel_hotSPot, "Button_trailNotice")
    self.Image_hotPlay = TFDirector:getChildByPath(self.Panel_hotSPot, "Image_hotPlay")
    self.Button_hotPlay = TFDirector:getChildByPath(self.Panel_hotSPot, "Button_hotPlay")
    self.Button_equipPre = TFDirector:getChildByPath(self.Panel_hotSPot,"Button_equipPre")
    self.Button_hotTab = {}
    for i = 1, 2 do
        self.Button_hotTab[i] = TFDirector:getChildByPath(self.Panel_hotSPot, "Button_hotTab_" .. i)
        local Label_hotTab = TFDirector:getChildByPath(self.Button_hotTab[i], "Label_hotTab")
        Label_hotTab:setTextById(self.hotSpotData_[i].text)
    end
    local Image_hotCount = TFDirector:getChildByPath(self.Panel_hotSPot, "Image_hotCount")
    self.Label_hotCount_1 = TFDirector:getChildByPath(Image_hotCount, "Label_hotCount_1")
    self.Label_hotCount_2 = TFDirector:getChildByPath(Image_hotCount, "Label_hotCount_2")
    self.Label_hotCount = TFDirector:getChildByPath(Image_hotCount, "Label_hotCount")

    self:refreshView()
    self:updateNoobReward()
    SummonDataMgr:resetAlreadyHaveHero()
end

function SummonView:addSummonItem(i)
    local Panel_summonItem = self.Panel_summonItem:clone()
    local foo = {}
    foo.root = Panel_summonItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_upTips = TFDirector:getChildByPath(foo.root, "Image_upTips"):hide()
    foo.id = i
    self.ListView_summon:pushBackCustomItem(foo.root)
    self.summonItems_[i] = foo
end

function SummonView:updateSummonItem(index)
    local summon = self.summon_[index]
    local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    local foo = self.summonItems_[index]
    foo.Image_icon:setTexture(summonCfg.smallIcon)
    foo.Label_name:setTextById(summonCfg.name)
    foo.Image_upTips:setVisible(summonCfg.up)
    if summonCfg.summonType == EC_SummonType.DIAMOND then
        local isNewGuy = SummonDataMgr:isOpenNoob()
        foo.Image_upTips:setVisible(isNewGuy or summonCfg.summonType == EC_SummonType.ELF_CONTRACT )
    end
    foo.root:onClick(function()
            self:selectSummon(index)
    end)
end

----萌新召唤奖励状态
function SummonView:updateNoobReward()

    local noobInfo = SummonDataMgr:getNoobInfo()
    if noobInfo and noobInfo.awardState == 1 then
        self.Image_noobnew:setVisible(true)
    else
        self.Image_noobnew:setVisible(false)
    end

end

function SummonView:updateSelectInfo()

    local summon = self.currentSummon_
    local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    local summonType = summonCfg.summonType
    self.Image_ad:setTexture(summonCfg.icon)

    local summonInfo = SummonDataMgr:getServerSummonInfo(summon[1].id)
    if summonInfo and summonCfg.summonType == EC_SummonType.APPOINT_HERO then
        if summonInfo.summonShow and next(summonInfo.summonShow) then
            local isNewReward = SummonDataMgr:isNewReward(summon[1].id)
            self.heroRewardNew:setVisible(isNewReward)
            self.Button_award:setVisible(true)
        else
            self.Button_award:setVisible(false)
        end
    else
        self.Button_award:setVisible(false)
    end

    self.Button_goto:setVisible(summonCfg.summonType == EC_SummonType.CLOTHESE)
    self.Button_show:setVisible(summonCfg.summonType == EC_SummonType.CLOTHESE)
    
    --暂时屏蔽狂三卡池试用
    self.Button_show:hide()


    if summonInfo and summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT then
        if summonInfo.equipRewards and next(summonInfo.equipRewards) then
            self.Button_equip:setVisible(true)
        else
            self.Button_equip:setVisible(false)
        end
    else
        self.Button_equip:setVisible(false)
    end

    self.costItem_ = {}
    local showCostCid
    for i, v in ipairs(self.Button_buy) do
        v.root:setVisible(tobool(summon[i]))

        if summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT or
                summonCfg.summonType == EC_SummonType.APPOINT_HERO then
            local inOpenStage = SummonDataMgr:isInOpenStage(summon[i].id)
            v.root:setGrayEnabled(not inOpenStage);
            v.root:setTouchEnabled(inOpenStage);
        else
            v.root:setGrayEnabled(false);
            v.root:setTouchEnabled(true);
        end

        v.Image_upTips:setVisible(summonCfg.up)
        if v.root:isVisible() then
            local summonCfg = SummonDataMgr:getSummonCfg(summon[i].id)
            v.Label_summon:setTextById(1200006, summonCfg.cardCount)
            local desc = {
                TextDataMgr:getText(summonCfg.ad1),
                TextDataMgr:getText(summonCfg.ad2),
            }
            for j, cost in ipairs(summonCfg.cost) do
                local costIndex = j
                local costId, costNum
                for id, num in pairs(cost) do
                    costId = id
                    costNum = num
                    break
                end

                if not showCostCid then
                    if GoodsDataMgr:getItemCount(costId) > 0 then
                        showCostCid = costId
                    else
                        if j == #summonCfg.cost then
                            showCostCid = costId
                        end
                    end
                end

                local costCfg = GoodsDataMgr:getItemCfg(costId)
                costicon = costCfg.icon
                v.Image_costIcon:setTexture(costCfg.icon)
                v.Label_costNum:setTextById(800007, costNum)
                self.costItem_[i] = {
                    id = costId,
                    num = costNum,
                    index = costIndex,
                }
                if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                    break
                end
            end
        end
    end


    local cost = summonCfg.cost[1]
    local ownCostId
    for k, v in pairs(cost) do
        ownCostId = k
        break
    end

    self.Label_tips:setVisible(true)
    self.Label_tips:setText("")
    if summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT or summonCfg.summonType == EC_SummonType.APPOINT_HERO then
        if summonInfo then
            local startShow = TFDate(summonInfo.startShow + GV_UTC_TIME_ZONE * 3600):fmt("%Y.%m.%d")
            local endShow = TFDate(summonInfo.endShow+ GV_UTC_TIME_ZONE * 3600):fmt("%Y.%m.%d %H:%M")
            self.Label_tips:setText(TextDataMgr:getText( 14300100, startShow, endShow)..GV_UTC_TIME_STRING)
        end
    end

    --增加狂三猫爪娘日期
    if summonCfg.summonType == EC_SummonType.CLOTHESE then
       if summonInfo then
            local startShow = TFDate(summonInfo.startShow + GV_UTC_TIME_ZONE * 3600):fmt("%Y.%m.%d")
            local endShow = TFDate(summonInfo.endShow+ GV_UTC_TIME_ZONE * 3600):fmt("%Y.%m.%d %H:%M")
            self.Label_tips:setText(TextDataMgr:getText( 14300100, startShow, endShow)..GV_UTC_TIME_STRING)
        end
    end

    local costCfg = GoodsDataMgr:getItemCfg(ownCostId)
    self.Image_ownIcon:setTexture(costCfg.icon)
    self.Label_cur:setTextById(800007, GoodsDataMgr:getItemCount(ownCostId))
    self.costItemId_ = ownCostId

    self.Label_have:setTextById(1200001, TextDataMgr:getText(costCfg.nameTextId))

    -- 契约召唤
    self.Panel_contract:setVisible(summonCfg.summonType == EC_SummonType.ELF_CONTRACT)
    self.Image_curOwn:setVisible(summonCfg.summonType ~= EC_SummonType.ELF_CONTRACT)
    if summonCfg.summonType == EC_SummonType.ELF_CONTRACT then
        local contractCfg = SummonDataMgr:getSummonContractInfo()
        if contractCfg.summonInfo.leftCount > 0 then
            self.Label_contract_tips:setTextById(1325311)
            self.Label_contract_count:setText(contractCfg.summonInfo.leftCount)
            self.Image_contract_count:show()
        else
            self.Label_contract_tips:setTextById(1325312)
            self.Image_contract_count:hide()
        end
    end

    --普通召唤判断是否是萌新状态
    if summonCfg.summonType == EC_SummonType.DIAMOND then
        local isNewGuy = SummonDataMgr:isOpenNoob()
        self.Button_newGuy:setVisible(isNewGuy)
        if isNewGuy then
            self.Image_ad:setTexture(summonCfg.noobIcon)
        else
            self.Image_ad:setTexture(summonCfg.icon)
        end

        for i, v in ipairs(self.Button_buy) do
            v.Image_upTips:setVisible(isNewGuy)
        end
        local noobInf = SummonDataMgr:getNoobInfo()
        if noobInf and isNewGuy then
            local remainTime = noobInf.endTime -ServerDataMgr:getServerTime()
            remainTime = remainTime > 0 and remainTime or 0
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            self.Label_tips:setTextById(100000074, day, hour, min)
        end
    else
        self.Button_newGuy:setVisible(false)
    end

    -- 热点召唤
    local isHotSummon = summonType == EC_SummonType.HOT_ROLE or summonType == EC_SummonType.HOT_EQUIPMENT
    self.Panel_hotSPot:setVisible(isHotSummon)
    self.Image_preview:Pos(isHotSummon and self.Panel_hotPreview_pos or self.Image_preview_pos)
    self.Image_history:Pos(isHotSummon and self.Panel_hotHistory_pos or self.Image_history_pos)
    if isHotSummon then
        self.Label_hotCount_1:setTextById(1200066)
        self.Label_hotCount_2:setTextById(summonType == EC_SummonType.HOT_ROLE and 1200067 or 1200068)
        local tabData = self.hotSpotData_[self.selectHotTabIndex_]
        local timestamp = SummonDataMgr:getHotSummonEndTime(tabData.loopType)
        local date = TFDate(timestamp + GV_UTC_TIME_ZONE * 3600)
        local timeStr = date:fmt("%Y-%m-%d %H:%M:%S")
        self.Label_tips:setTextById(1200070, timeStr..GV_UTC_TIME_STRING)
        local remainCount = SummonDataMgr:getHotSummonRemainCount(tabData.loopType)
        self.Label_hotCount:setText(remainCount)
        self.Image_hotPlay:setVisible(tabData.loopType == EC_SummonLoopType.ROLE)
        self.Image_ad:setTexture(summonCfg.icon)
        self.Button_equipPre:setVisible(tabData.loopType == EC_SummonLoopType.EQUIPMENT)
    end

    ---检测坐标
    for k,v in ipairs(self.checkBtn) do
        self.checkBtn[k].btn:removeFromParent()
    end
    self.checkBtn = {}
    for k,v in ipairs(summonCfg.detailsPosition) do
        local btn = self.Button_check:clone()
        btn:setPosition(ccp(v.x,v.y))
        btn:onClick(function()
            Utils:showInfo(v.itemId)
        end)
        self.Image_ad:addChild(btn)
        self.checkBtn[k] = {btn = btn,itemId = v.itemId}
    end
end
function SummonView:selectSummon(index, force)

    if self.selectIndex_ == index then return end
    self.selectIndex_ = index

    local summon = self.summon_[self.selectIndex_]
    local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    for i, foo in pairs(self.summonItems_) do
        foo.Image_select:setVisible(i == index)
    end

    if summonCfg.summonType == EC_SummonType.HOT_ROLE then
        self:selectHotTab(self.selectHotTabIndex_)
    else
        self.currentSummon_ = summon
        self:updateSelectInfo()
    end
end

function SummonView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self);
    end,0.05)

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
end

function SummonView:refreshView()
    local firstIndex
    self.selectIndex_ = nil

    self.ListView_summon:removeAllItems()
    self.summonItems_ = {}
    for i, v in ipairs(self.summon_) do
        --此处增加删选
        if v[1].isOpen then
            if not firstIndex then
                firstIndex = i
            end
            self:addSummonItem(i)
            self:updateSummonItem(i)
        end
    end

    if not firstIndex then
        firstIndex = 1
    end
    if self.paramIdx_ then
        firstIndex = self.paramIdx_
    end
    self:selectSummon(firstIndex)
end

function SummonView:registerEvents()
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_SHOWRESULT_END, handler(self.onShowResultEndEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_PANEL_INFO, handler(self.onRecvUpdatePanelInfo, self))
    EventMgr:addEventListener(self, EV_SUMMON_UPATE_HERO, handler(self.onRecvUpdateHeroData, self))
    EventMgr:addEventListener(self, EV_SUMMON_SELECT, handler(self.onRecvNewGuideSelect, self))
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HOTSPLOT_UPDATE, handler(self.onHotSpotUpdateEvent, self))

    self.Button_preview:onClick(function()
            local summon = self.currentSummon_
            local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
            if summonCfg.summonType == EC_SummonType.APPOINT_HERO or
                summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT then
                local isInStage = SummonDataMgr:isInOpenStage(summon[1].id)
                if not isInStage then
                    Utils:showTips(1200054)
                    return
                end
                Utils:openView("summon.SummonPreviewView", summonCfg.groupId)
            else
                Utils:openView("summon.SummonPreviewView", summonCfg.groupId)
            end
    end)

    self.Button_history:onClick(function()
        local summon = self.currentSummon_
        local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
        if summonCfg.summonType == EC_SummonType.APPOINT_HERO or
           summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT then
            local isInStage = SummonDataMgr:isInOpenStage(summon[1].id)
            if not isInStage then
                Utils:showTips(1200054)
                return
            end
            SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
        else
            SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
        end
    end)

    for i, v in ipairs(self.Button_buy) do
        v.root:onClick(function()
                local cost = self.costItem_[i]
                if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
                    local function reaSummon()
                        local summon = self.currentSummon_                                       
                        SummonDataMgr:send_SUMMON_SUMMON(summon[i].id, cost.index)                                              
                        GameGuide:checkGuideEnd(self.guideFuncId)
                    end
                    if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_Summon) or GuideDataMgr:isInNewGuide() then
                        reaSummon()
                    else
                        local rstr = TextDataMgr:getTextAttr(1200042 + i -1)
                        local formatStr = rstr and rstr.text or ""
                        local content = string.format(formatStr, cost.num, TabDataMgr:getData("Item", cost.id).icon)
                        Utils:openView("common.ReConfirmTipsView", {tittle = 1200041, content = content, reType = EC_OneLoginStatusType.ReConfirm_Summon, confirmCall = reaSummon})
                    end
                else
                    local summon = self.currentSummon_
                    local summonCfg = SummonDataMgr:getSummonCfg(summon[i].id)
                    if summonCfg.costCommodity == 0 then
                        Utils:showAccess(cost.id)
                    else
                        local haveCount = GoodsDataMgr:getItemCount(cost.id)
                        Utils:openView("summon.SummonBuyResourceView", summonCfg.costCommodity, cost.num - haveCount)
                    end
                end
        end)
    end

    self.Image_ownIcon:onClick(function()
            Utils:showInfo(self.costItemId_, nil, true)
    end)

    self.Button_award:onClick(function()
        local summon = self.currentSummon_
        local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
        if summonCfg.summonType == EC_SummonType.APPOINT_HERO then
            local isInStage = SummonDataMgr:isInOpenStage(summon[1].id)
            if not isInStage then
                Utils:showTips(1200054)
                return
            end
            Utils:openView("summon.SummonHeroView",summon[1].id)
        end
    end)

    self.Button_equip:onClick(function()
        local summon = self.currentSummon_
        local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
        if summonCfg.summonType == EC_SummonType.APPOINT_EQUIPMENT then
            local isInStage = SummonDataMgr:isInOpenStage(summon[1].id)
            if not isInStage then
                Utils:showTips(1200054)
                return
            end
            Utils:openView("summon.SummonEquipView",summon[1].id)
        end
    end)

    self.Button_equipPre:onClick(function()
            local summon = self.currentSummon_
            local summonCfg = SummonDataMgr:getSummonCfg(summon[EC_SummonLoopType.EQUIPMENT].id)

            if summonCfg.summonType == EC_SummonType.HOT_EQUIPMENT then
                Utils:openView("summon.HotSummonEquipView",summon[EC_SummonLoopType.EQUIPMENT].id)
            end
        end)

    self.Button_newGuy:onClick(function()
        AlertManager:closeLayer(self)
        local isLayerInQueue,layer = AlertManager:isLayerInQueue("ActivityMain")
        if not isLayerInQueue then
            FunctionDataMgr:jWelfare(EC_ActivityType.NEWGUY_SUMMON)
        else
            AlertManager:showLayer(layer)
        end
    end)

    self.Button_goto:onClick(function()
        Utils:openView("role.NewRoleShowView", 104, 410409)
    end)

    self.Button_show:onClick(function()
        FubenDataMgr:enterPracticeLevel(110101,1101016)
    end)

    self.Button_contract_preview:onClick(function()
        local summon = self.currentSummon_
        local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
        Utils:openView("summon.SummonContractPreviewView",summonCfg)
    end)

    for i, v in ipairs(self.Button_hotTab) do
        v:onClick(function()
                self:selectHotTab(i)
        end)
    end

    self.Button_trailNotice:onClick(function()
            local tabData = self.hotSpotData_[self.selectHotTabIndex_]
            Utils:openView("summon.SummonHotNoticeView", tabData.loopType)
    end)

    self.Button_hotPlay:onClick(function()
            local summon = self.currentSummon_
            local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
            if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_HotSpotTryPlay) then
                FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(summonCfg.dungeonId1)
            else
                local args = {
                    tittle = 2107025,
                    content = TextDataMgr:getText(2107037),
                    reType = EC_OneLoginStatusType.ReConfirm_HotSpotTryPlay,
                    confirmCall = function()
                        FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(summonCfg.dungeonId1)
                    end,
                }
                Utils:showReConfirm(args)
            end
    end)

end

function SummonView:selectHotTab(index)
    self.selectHotTabIndex_ = index
    local tabData = self.hotSpotData_[index]
    self.selectHotTabIndex_ = index
    for i, v in ipairs(self.Button_hotTab) do
        v:setTouchEnabled(i ~= index)
        v:setBright(i ~= index)
    end
    local hotSpotInfo = SummonDataMgr:getHotSpotInfo()
    local summon = SummonDataMgr:getHotSummon(tabData.loopType)
    self.currentSummon_ = summon
    self:updateSelectInfo()
end

function SummonView:testMarquee(isInit)
    self.Label_marquee:setTextById(self.marqueeData_[self.curIndex_])
    local textSize = self.Label_marquee:Size()
    local size = self.Panel_marquee_mask:Size()
    local ap = self.Panel_marquee_mask:AnchorPoint()
    local curX = size.width * ap.x
    local targetX = size.width * ap.x * -1 - textSize.width - 20
    self.Label_marquee:Pos(curX, 0)

    local function setup()
        self.curIndex_ = self.curIndex_ + 1
        if self.curIndex_ > #self.marqueeData_ then
            local action = Sequence:create({
                    FadeOut:create(0.5),
                    Hide:create()
            })
            self.Image_marquee:runAction(action)
        else
            self:testMarquee()
        end
    end

    local moveDuration = math.abs(targetX - curX) / 300
    local action = Sequence:create({
            MoveTo:create(moveDuration, ccp(targetX, 0)),
            CallFunc:create(function()
                    setup()
            end)
    })
    self.Label_marquee:stopAllActions()
    self.Label_marquee:runAction(action)

    if isInit then
        self.Image_marquee:stopAllActions()
        self.Image_marquee:Show():Alpha(0.3)
        self.Image_marquee:fadeIn(0.5)
    end
end

function SummonView:onSummonResultEvent(reward)
  --   MovieScene:create({
	-- 	path = "video/summon.mp4",
	-- 	showSkip = true,
	-- 	endCall = function()
  --           Utils:openView("summon.SummonResultView", reward or {})
	-- 	end,
  --       onSkipClick = function()
  --           AudioExchangePlay.stopAllBgm()
  --       end
	-- })

  --   -- local vlcPlayer
  --   -- local function onVideoPlayComplete()
  --   --     vlcPlayer:removeFromParent()
  --   --     Utils:openView("summon.SummonResultView", reward or {})
  --   -- end
  --   -- vlcPlayer = VlcPlayer:create({
  --   --         filePath = "video/summon.mp4",
  --   --         onVideoPlayComplete = onVideoPlayComplete,
  --   -- })
  --   -- self.topLayer:getParent():addChild(vlcPlayer)
  --   -- vlcPlayer:setZOrder(999)
  --   -- vlcPlayer:play()
  --   self:updateSelectInfo()

  --   AudioExchangePlay.stopAllBgm()
  --   TFAudio.playBmg("sound/card1.mp3")
    self:updateNoobReward()
    self:updateSelectInfo()
    Utils:openView("summon.SummonResultView", reward or {})
end

function SummonView:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView",historyData)
end

function SummonView:onItemUpdateEvent()
    self.Label_cur:setTextById(800007, GoodsDataMgr:getItemCount(self.costItemId_))
end

function SummonView:onRecvUpdatePanelInfo()
    print("SummonView: the recv update panel info...............")
    self.summon_ = SummonDataMgr:getSummon()
    dump(self.summon_)
    self:refreshView()
end

function SummonView:onRecvUpdateHeroData()

    local summon = self.currentSummon_
    if not summon then
        return
    end
    local summonInfo = SummonDataMgr:getServerSummonInfo(summon[1].id)
    local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    if summonInfo and summonCfg.summonType == EC_SummonType.APPOINT_HERO then
        if summonInfo.summonShow and next(summonInfo.summonShow) then
            local isNewReward = SummonDataMgr:isNewReward(summon[1].id)
            self.heroRewardNew:setVisible(isNewReward)
        end
    end
end

function SummonView:onRecvNewGuideSelect()
    print("SummonView: the recv new guide select...............")
    dump(self.summon_)

    --引导召唤 需要设定对应的卡池类型
    local normalIndex = 1
    for i, v in ipairs(self.summon_) do
        local summonCfg = SummonDataMgr:getSummonCfg(v[1].id)
        if v[1].isOpen and summonCfg.summonType == EC_SummonType.DIAMOND then
            normalIndex = i
            break
        end
    end
    self:selectSummon(normalIndex)
end

function SummonView:onLimitHeroEvent()
    local summon = self.currentSummon_
    local summonCfg = SummonDataMgr:getSummonCfg(summon[1].id)
    local levelCid = summonCfg.dungeonId1

    local levelFormation =  FubenDataMgr:getLevelFormation(levelCid)
    if not levelFormation then
        return
    end

    local formationData_ = FubenDataMgr:getInitFormation(levelCid)
    if formationData_ then
        HeroDataMgr:changeDataByFuben(levelCid, formationData_)
    end

    local heros = {}
    for i, v in ipairs(formationData_) do
        table.insert(heros, {limitType = v.type, limitCid = v.id})
    end

    FubenDataMgr:setFormation(levelFormation)
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(
        {
            levelCid = levelCid,
            limitHeros = heros,
            isDuelMod = false,
        },
        EC_BattleType.COMMON
    )
end

function SummonView:onHotSpotUpdateEvent()
    self:updateSelectInfo()
end

---------------------------guide------------------------------

--引导抽一次卡
function SummonView:excuteGuideFunc9001(guideFuncId)

    local targetNode = self.Button_buy[1].root
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

---------------------------guide------------------------------

--引导查看概率
function SummonView:excuteGuideFunc9002(guideFuncId)
    local targetNode = nil
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function SummonView:onShowResultEndEvent()
    self.super.onShow(self)
end

return SummonView
