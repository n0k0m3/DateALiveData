
local SkyLadderCardLevelUpView = class("SkyLadderCardLevelUpView", BaseLayer)

function SkyLadderCardLevelUpView:initData(cardId,fightCardPos)

    self.cardCid_ = cardId
    dump(self.cardCid_)
    self.itemCfg_ = SkyLadderDataMgr:getRankMatchCardCfg(self.cardCid_)
    self.fightCardPos = fightCardPos
    self.btnStr = {3202044,3202045,3202043,3202046}

end

function SkyLadderCardLevelUpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderCardLevelUpView")
end

function SkyLadderCardLevelUpView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_costItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    local Image_name = TFDirector:getChildByPath(Image_content, "Image_name")
    self.Label_name_title = TFDirector:getChildByPath(Image_name, "Label_name_title")
    self.Label_name = TFDirector:getChildByPath(Image_name, "Label_name")
    self.Image_rarity = TFDirector:getChildByPath(Image_name, "Image_rarity")
    self.Label_rarity = TFDirector:getChildByPath(self.Image_rarity, "Label_rarity")
    local Image_effect = TFDirector:getChildByPath(Image_content, "Image_effect")
    self.Label_effect_title = TFDirector:getChildByPath(Image_effect, "Label_effect_title")

    self.Image_type_diban = TFDirector:getChildByPath(Image_effect, "Image_type_diban")
    self.Label_type = TFDirector:getChildByPath(self.Image_type_diban, "Label_type")
    self.Label_desc = TFDirector:getChildByPath(Image_effect, "Label_desc")
    self.Button_upgrade = TFDirector:getChildByPath(Image_content, "Button_upgrade")
    self.Label_upgrade = TFDirector:getChildByPath(self.Button_upgrade, "Label_upgrade")
    self.Button_dismount = TFDirector:getChildByPath(Image_content, "Button_dismount")
    self.Label_dismount = TFDirector:getChildByPath(self.Button_dismount, "Label_dismount")
    self.Image_cost = TFDirector:getChildByPath(Image_content, "Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Image_cost, "Label_cost_num")
    self.Label_cost_num_red = TFDirector:getChildByPath(self.Image_cost, "Label_cost_num_red")
    self.Button_card = TFDirector:getChildByPath(Image_content, "Button_card")
    self.Image_card_type = TFDirector:getChildByPath(self.Button_card, "Image_card_type")
    self.Label_card_lv = TFDirector:getChildByPath(self.Button_card, "Label_card_lv")
    self.Image_card = TFDirector:getChildByPath(self.Button_card, "Image_card")
    local ScrollView_cost = TFDirector:getChildByPath(self.Button_card, "ScrollView_cost")
    self.ListView_cost = UIListView:create(ScrollView_cost)
    self.ListView_cost:setItemsMargin(-5)
    self.Label_card_name = TFDirector:getChildByPath(self.Button_card, "Label_card_name")
    self.Image_progress = TFDirector:getChildByPath(self.Button_card, "Image_progress")
    self.LoadingBar_collect = TFDirector:getChildByPath(self.Button_card, "LoadingBar_collect")
    self.Label_collect = TFDirector:getChildByPath(self.Button_card, "Label_collect")
    self.Image_up = TFDirector:getChildByPath(self.Button_card, "Image_up")
    self.Spine_up = TFDirector:getChildByPath(self.Button_card, "Spine_up")
    self.Spine_up:play("animation", true)
    self.Spine_up_succeed = TFDirector:getChildByPath(self.Button_card, "Spine_up_succeed")

    self:refreshView()
end

function SkyLadderCardLevelUpView:cardLvUpSucceed()

    Utils:playSound(1002)
    self.Spine_up_succeed:play("animation", false)
    self:refreshView()
end

function SkyLadderCardLevelUpView:refreshView()
    self.Label_name_title:setTextById(3202026)
    self.Label_rarity:setTextById(EC_SkyLadderCardRarityName[self.itemCfg_.quality])
    self.Image_rarity:setTexture(EC_SkyLadderCardDiban[self.itemCfg_.quality])
    self.Label_name:setTextById(self.itemCfg_.nameTextId)
    self.Label_effect_title:setTextById(3202027)

    self.Image_type_diban:setTexture(EC_SkyLadderCardTypeDiban[self.itemCfg_.abilityType])
    self.Label_type:setTextById(EC_SkyLadderCardTypeName[self.itemCfg_.abilityType])

    local level = 1
    local cardInfo = SkyLadderDataMgr:getOwnedCardByID(self.cardCid_)
    if cardInfo then
        level = cardInfo.cardLv
    end
    --self.Label_desc:setTextById(self.itemCfg_.Describe1)
    local isMax = self.itemCfg_.maxLevel == level
    local curBuffId = self.itemCfg_.skill[level]
    if curBuffId then
        local buffInfo = SkyLadderDataMgr:getRankMatchBuff(curBuffId)
        self.Label_desc:setTextById(buffInfo.buffDescribe)
    else
        self.Label_desc:setText("")
    end

    self.Button_card:setTextureNormal(EC_SkyLadderCardFrame[self.itemCfg_.quality])
    self.Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[self.itemCfg_.abilityType])
    self.Image_card:setTexture(self.itemCfg_.icon)
    self.Label_card_name:setTextById(self.itemCfg_.nameTextId)
    self.ListView_cost:removeAllItems()
    if isMax then
        self.Label_card_lv:setText("Max")
    else
        self.Label_card_lv:setTextById(800006, level)
    end

    for k = 1, self.itemCfg_.cost do
        local Image_costItem = self.Image_costItem:clone()
        self.ListView_cost:pushBackCustomItem(Image_costItem)
    end
    Utils:setAliginCenterByListView(self.ListView_cost, true)

    local isOwned = SkyLadderDataMgr:getOwnedCardByID(self.cardCid_)
    self.Image_progress:setVisible(isOwned and (not isMax))
    if isOwned and not isMax then

        local covertCid
        for k,v in pairs(self.itemCfg_.convertMax) do
            covertCid = k
            break
        end

        if not covertCid then
            return
        end
        local count = GoodsDataMgr:getItemCount(covertCid)
        local nextLevel = level + 1
        local costCount = self.itemCfg_.levelUpCoins[nextLevel][covertCid]
        if costCount then
            self.Label_collect:setTextById(800005, count, costCount)
            local percent = clampf(count / costCount * 100, 0, 100)
            self.LoadingBar_collect:setPercent(percent)
            self.Image_up:setVisible(percent < 100)
            self.Spine_up:setVisible(percent == 100)
        end

        self.Button_upgrade:setVisible(costCount <= count)
        self.Image_cost:setVisible(costCount <= count)

        ---消耗
        local coinshowId = self.itemCfg_.coinshow
        local costCfg = GoodsDataMgr:getItemCfg(coinshowId)
        local costItemCnt = self.itemCfg_.levelUpCoins[nextLevel][coinshowId]
        if costItemCnt then
            self.Image_cost_icon:setTexture(costCfg.icon)
            self.Label_cost_num:setText(costItemCnt)
            self.Label_cost_num_red:setText(costItemCnt)
            local isEnough = GoodsDataMgr:currencyIsEnough(coinshowId, costItemCnt)
            self.Label_cost_num:setVisible(isEnough)
            self.Label_cost_num_red:setVisible(not isEnough)
        end
    else
        self.Button_upgrade:setVisible(false)
        self.Image_cost:setVisible(false)
        self.Button_dismount:setVisible(false)
    end

    if self.fightCardPos and isOwned then
        self.Button_dismount:setVisible(true)
        local state = SkyLadderDataMgr:getHandleButtonState(self.fightCardPos,self.cardCid_)
        if state == 4 then
            self.Label_dismount:setTextById(self.btnStr[1])
            --self.Button_dismount:setGrayEnabled(state == 4)
            --self.Button_dismount:setTouchEnabled(not (state == 4))
        else
            self.Label_dismount:setTextById(self.btnStr[state])
        end

        local fightCnt = SkyLadderDataMgr:getCardFightCnt(self.cardCid_)
        if fightCnt == 0 and state == 3 then
            self.Button_dismount:setGrayEnabled(true)
            self.Button_dismount:setTouchEnabled(false)
        end
    else
        self.Button_dismount:setVisible(false)
    end
end

function SkyLadderCardLevelUpView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_CARD_LV, handler(self.cardLvUpSucceed, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_dismount:onClick(function()

        local curInfo = SkyLadderDataMgr:getCurCircleInfo()
        if not curInfo then
            return
        end

        local totalPoint = curInfo.cardPoint
        local equipCost = 0
        local haveActiveCard = false
        local equipPos
        local usingCards = SkyLadderDataMgr:getUsingCards()
        for k,v in ipairs(usingCards) do
            local cfg = SkyLadderDataMgr:getRankMatchCardCfg(v)
            equipCost = equipCost + cfg.cost
            if cfg.abilityType == 2 then
                haveActiveCard = true
            end
            if self.cardCid_ == v then
                equipPos = k
            end
        end

        local preEquipcfg = SkyLadderDataMgr:getRankMatchCardCfg(self.cardCid_)
        local state = SkyLadderDataMgr:getHandleButtonState(self.fightCardPos,self.cardCid_)
        ---装备
        if state == 3 then
            if preEquipcfg.abilityType == 2 and haveActiveCard then
                Utils:showTips(3203017)
                return
            end
            if equipCost + preEquipcfg.cost > totalPoint then
                Utils:showTips(3203015)
                return
            end
        end

        ---替换
        if state == 2 then
            local originalCardId = usingCards[self.fightCardPos]
            local originalCardCfg = SkyLadderDataMgr:getRankMatchCardCfg(originalCardId)
            if equipCost - originalCardCfg.cost + preEquipcfg.cost > totalPoint then
                Utils:showTips(3203016)
                return
            end

            if preEquipcfg.abilityType == 2 and originalCardCfg.abilityType ~= 2 and haveActiveCard then
                Utils:showTips(3203018)
                return
            end
        end

        if state == 4 then
            if equipPos then
                self.fightCardPos = equipPos
            end
        end

        SkyLadderDataMgr:handleFormation(self.fightCardPos,self.cardCid_)
        AlertManager:closeLayer(self)
    end)

    self.Button_upgrade:onClick(function()
        SkyLadderDataMgr:Send_UpgradeCard(self.cardCid_)
    end)
end

return SkyLadderCardLevelUpView
