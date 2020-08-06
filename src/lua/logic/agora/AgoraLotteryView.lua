local AgoraLotteryView = class("AgoraLotteryView", BaseLayer)

function AgoraLotteryView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.agora.agoraLotteryView")
end

function AgoraLotteryView:initData()
    self.LotterySummmon = {}
    self.summon_ = SummonDataMgr:getAgoraSummon()
    for k,v in ipairs(self.summon_) do
        for i,info in ipairs(v) do
            table.insert(self.LotterySummmon,info)
        end
    end

    self.treData = Utils:getKVP(47004, "showReward")
    dump(self.treData)
end

function AgoraLotteryView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_lotteryOnce = TFDirector:getChildByPath(self.ui, "Button_lottery1")
    self.widgetInfo = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.ui, "Button_lottery"..i)
        tab.btnTx = TFDirector:getChildByPath(tab.btn, "Label_btn")
        tab.costNumTx = TFDirector:getChildByPath(tab.btn, "Label_num")
        tab.costIcon = TFDirector:getChildByPath(tab.btn, "Image_icon")
        tab.Image_cost = TFDirector:getChildByPath(tab.btn, "Image_cost")

        table.insert(self.widgetInfo,tab)
    end

    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Button_preview = TFDirector:getChildByPath(self.ui, "Button_preview")
    self.Button_history = TFDirector:getChildByPath(self.ui, "Button_history")

    self.Panel_tree = TFDirector:getChildByPath(self.ui, "Panel_tree")
    self.Label_summon_cnt = TFDirector:getChildByPath(self.Panel_tree, "Label_summon_cnt")
    self.Image_flash = TFDirector:getChildByPath(self.Panel_tree, "Image_flash")

    self.treeItem = {}
    for i=1,6 do
        self.treeItem[i] = TFDirector:getChildByPath(self.ui, "Panel_gift_"..i)
        local Label_geted = TFDirector:getChildByPath(self.treeItem[i] , "Label_geted")
        Label_geted:setTextById(303044)
    end

    self:initUiInfo()
end

function AgoraLotteryView:initUiInfo()

    --local act = RotateBy:create(5,360)
    --self.Image_flash:runAction(CCRepeatForever:create(act))

    self.Panel_tree:setVisible(false)
    TFDirector:send(c2s.CHRISTMAS_REQ_SUMMON, {})

    self:updateSummonCnt()
    self:updateLotteryInfo()
end

function AgoraLotteryView:updateGiftTree()

    self.Panel_tree:setVisible(true)
    for i=1,6 do

        if not self.treData[i] then
            self.treeItem[i]:setVisible(false)
        else
            self.treeItem[i]:setVisible(true)
            local itemCfg = GoodsDataMgr:getItemCfg(self.treData[i])
            if not itemCfg then
                self.treeItem[i]:setVisible(false)
            else
                local Image_gift_bg = TFDirector:getChildByPath(self.treeItem[i] , "Image_gift_bg")
                local Image_gift_item = TFDirector:getChildByPath(Image_gift_bg , "Image_gift_item")
                local Image_getted = TFDirector:getChildByPath(self.treeItem[i] , "Image_getted")
                local isSummoned = AgoraDataMgr:isSummoned(self.treData[i])
                Image_getted:setVisible(tobool(isSummoned))
                print(itemCfg.superType)
                if itemCfg.superType == EC_ResourceType.SPIRIT then
                    Image_gift_bg:setTexture("ui/fairy_particle/" .. itemCfg.quality .. ".png")
                    Image_gift_item:setTexture(itemCfg.equipPaint)
                else
                    Image_gift_bg:setTexture(EC_ItemIcon[itemCfg.quality])
                    Image_gift_item:setTexture(itemCfg.icon)
                end

                Image_gift_bg:onClick(function()
                    Utils:showInfo(self.treData[i], nil, true)
                end)
            end
        end
    end
end

function AgoraLotteryView:updateSummonCnt()

    local progress = ActivityDataMgr2:getProgress(EC_ActivityType2.CHRISTMAS, EC_Activity_CHRISTMAS_Subtype.ONLY_RECORD)
    local str = TextDataMgr:getText(303045,progress)
    self.Label_summon_cnt:setText(str)
end



function AgoraLotteryView:updateLotteryInfo()
    self.costItem_ = {}
    for k,lptteryInfo in ipairs(self.widgetInfo) do
        local summonCfgInfo =  self.LotterySummmon[k]
        if not summonCfgInfo then
            lptteryInfo.btn:setVisible(false)
        else

            local summonCfg = SummonDataMgr:getSummonCfg(summonCfgInfo.id)
            if not summonCfg then
                return
            end
            lptteryInfo.btn:setVisible(true)
            lptteryInfo.btnTx:setTextById(303035, summonCfg.cardCount)

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

                local ownNum = GoodsDataMgr:getItemCount(costId)
                local costCfg = GoodsDataMgr:getItemCfg(costId)
                costicon = costCfg.icon
                lptteryInfo.costIcon:setTexture(costCfg.icon)
                if costNum > ownNum then
                    lptteryInfo.costNumTx:setTextById("r151006", tostring(ownNum), tostring(costNum))
                else
                    lptteryInfo.costNumTx:setTextById("r151005", tostring(ownNum), tostring(costNum))
                end

                lptteryInfo.Image_cost:onClick(function()
                    Utils:showInfo(costId, nil, true)
                end)

                self.costItem_[k] = {
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
end

function AgoraLotteryView:onLotteryHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView",historyData,303033)
end

function AgoraLotteryView:onSummonResultEvent(reward)

    Utils:openView("summon.SummonResultView", reward or {})
    self:updateLotteryInfo()
    dump(reward)
    --[[MovieScene:create({
        path = "video/summon.mp4",
        showSkip = true,
        endCall = function()
            Utils:openView("summon.SummonResultView", reward or {})
        end,
        onSkipClick = function()
            AudioExchangePlay.stopAllBgm()
        end
    })

    AudioExchangePlay.stopAllBgm()
    TFAudio.playBmg("sound/card1.mp3")]]
end

function AgoraLotteryView:onItemUpdateEvent()
    self:updateLotteryInfo()
end

function AgoraLotteryView:updateGiftTreeInfo()
    self:updateGiftTree()
end

function AgoraLotteryView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onLotteryHistoryEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateSummonCnt, self))
    EventMgr:addEventListener(self, EV_CHRISMAS_SUMMON_RECORD, handler(self.updateGiftTreeInfo, self))

    self.Button_preview:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.LotterySummmon[1].id)
        Utils:openView("summon.SummonPreviewView", summonCfg.groupId,303032)
    end)

    self.Button_history:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.LotterySummmon[1].id)
        SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
    end)

    for i, v in ipairs(self.widgetInfo) do
        v.btn:onClick(function()
            local cost = self.costItem_[i]
            local summonCfgInfo =  self.LotterySummmon[i]
            if not summonCfgInfo then
                return
            end
            if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
                local function reaSummon()
                    SummonDataMgr:send_SUMMON_SUMMON(summonCfgInfo.id, cost.index)
                end
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_AgoraLottery) then
                    reaSummon()
                else
                    local rstr = TextDataMgr:getTextAttr(303002 + i -1)
                    local formatStr = rstr and rstr.text or ""
                    local content = string.format(formatStr, cost.num, TabDataMgr:getData("Item", cost.id).icon)
                    Utils:openView("common.ReConfirmTipsView", {tittle = 303001, content = content, reType = EC_OneLoginStatusType.ReConfirm_AgoraLottery, confirmCall = reaSummon})
                end
            else
                --[[local summonCfg = SummonDataMgr:getSummonCfg(summonCfgInfo.id)
                if summonCfg.costCommodity == 0 then
                    Utils:showAccess(cost.id)
                else
                    local haveCount = GoodsDataMgr:getItemCount(cost.id)
                    Utils:openView("summon.SummonBuyResourceView", summonCfg.costCommodity, cost.num - haveCount)
                end]]
                Utils:showTips(303046)
            end
        end)
    end
end

return AgoraLotteryView