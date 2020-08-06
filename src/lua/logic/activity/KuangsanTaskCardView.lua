
local KuangsanTaskCardView = class("KuangsanTaskCardView",BaseLayer)

function KuangsanTaskCardView:ctor( data )
    self.super.ctor(self,data)
    self.activityId_ = data
    --self:showPopAnim(true)
    self:initData()
    self:init("lua.uiconfig.activity.kuangsanTaskCardView")
end

function KuangsanTaskCardView:initData()

    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    dump(self.activityInfo_)
    self.speedLinkCfg = TabDataMgr:getData("SpeedLink")
    self.cardsIds = {}
end

function KuangsanTaskCardView:initUI( ui )
    -- body
    self.super.initUI(self,ui)

    self.Panel_box = TFDirector:getChildByPath(ui,"Panel_box")
    self.Panel_Grid = TFDirector:getChildByPath(ui,"Panel_Grid")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    local ScrollView_grid = TFDirector:getChildByPath(ui,"ScrollView_grid")

    local viewSize = ScrollView_grid:getContentSize()
    local itemSize = self.Panel_Grid:getContentSize()

    local column = math.floor(viewSize.width/itemSize.width)
    local offset = (viewSize.width - column*itemSize.width)/(column -1)
    self.Grid_cards = UIGridView:create(ScrollView_grid)
    self.Grid_cards:setItemModel(self.Panel_Grid)
    self.Grid_cards:setColumn(column)
    self.Grid_cards:setColumnMargin(offset)
    self.Grid_cards:setRowMargin(offset)
    self.column = column

    self.Image_cost_icon = TFDirector:getChildByPath(ui,"Image_cost_icon")
    self.Label_remain = TFDirector:getChildByPath(ui,"Label_remain")
    self.Label_cost1 = TFDirector:getChildByPath(ui,"Label_cost1")
    self.Label_progress = TFDirector:getChildByPath(ui,"Label_progress")
    self.Image_cost_icon2 = TFDirector:getChildByPath(ui,"Image_cost_icon2")
    self.Label_cost2 = TFDirector:getChildByPath(ui,"Label_cost2")
    self.Image_cost_bg = TFDirector:getChildByPath(ui,"Image_cost_bg")

    self.Panel_award = TFDirector:getChildByPath(ui,"Panel_award")
    self.Button_checkTask = TFDirector:getChildByPath(self.Panel_award,"Button_checkTask")
    self.Label_progress = TFDirector:getChildByPath(self.Panel_award,"Label_progress")
    self.Label_remain = TFDirector:getChildByPath(self.Panel_award,"Label_remain")
    self.Button_checkReward = TFDirector:getChildByPath(self.Panel_award,"Button_checkReward")
    self:updateCardView()
    self:updateCost()
    self:updateProgress()
    self:checkReset()
end

function KuangsanTaskCardView:updateCost()
    self.costInfo = json.decode(self.activityInfo_.extendData.cost)
    local itemCfg = GoodsDataMgr:getItemCfg(self.costInfo.id)
    self.Image_cost_icon:setTexture(itemCfg.icon)
    self.Image_cost_icon:setScale(0.6)
    local ownCnt = GoodsDataMgr:getItemCount(self.costInfo.id)
    self.Label_remain:setText(ownCnt)

    self.Label_cost1:setTextById(13312000,self.costInfo.num)
    local posX = self.Label_cost1:getPositionX()
    local w = self.Label_cost1:getContentSize().width
    local posCostX = posX + w + 2
    self.Image_cost_icon2:setPositionX(posCostX)
    self.Image_cost_icon2:setTexture(itemCfg.icon)
    self.Image_cost_icon2:setScale(0.4)
    local w2 = self.Image_cost_icon2:getContentSize().width*0.4
    local namePosX = posCostX + w2 + 2
    local name = TextDataMgr:getText(itemCfg.nameTextId)
    local desc = TextDataMgr:getText(13312001)
    self.Label_cost2:setText(name..desc)
    self.Label_cost2:setPositionX(namePosX)
end

function KuangsanTaskCardView:updateProgress()

    local cardInfo = KsanCardDataMgr:getCardInfo()
    local finishCnt = 0
    for k,v in ipairs(cardInfo) do
        if v.id then
            finishCnt = finishCnt + 1
        end
    end
    local totalCnt = #cardInfo
    local str = TextDataMgr:getText(13312004)
    self.Label_progress:setText(str.." "..(totalCnt - finishCnt).."/"..totalCnt)
end

function KuangsanTaskCardView:getGridPic(id)

    local cardCfg = KsanCardDataMgr:getCardCfg(id)
    if not cardCfg then
        return ""
    end
    return cardCfg.cardFace
end

function KuangsanTaskCardView:openCard( cardInfo ,callBack)
    -- body
    --self.playAning = true
    Utils:playSound(5022)
    local item = self.Grid_cards:getItem(cardInfo.pos)
    if not item then return end
    local Image_card = TFDirector:getChildByPath(item,"Image_card")
    local Image_front = TFDirector:getChildByPath(item,"Image_front")
    local arr = {
        CCScaleTo:create(0.2,0,1),
        CCCallFunc:create(function ()

            Image_card:setTexture(self:getGridPic(cardInfo.id))
            Image_front:setScaleX(0)
            Image_front:setOpacity(255)
            item:setTouchEnabled(false)
            Image_front:runAction(CCScaleTo:create(0.2,1,1))
        end),
        CCScaleTo:create(0.2,1,1),
        CCCallFunc:create(function ()

            if callBack then
                callBack()
            end
            self.playAning = false
        end),
    }

    Image_card:runAction(CCSequence:create(arr))

end

function KuangsanTaskCardView:updateCardView()

    self:updateAllCards()

end

function KuangsanTaskCardView:updateAllCards()
    self.Grid_cards:removeAllItems()
    local cardInfo = KsanCardDataMgr:getCardInfo()
    for k,v in ipairs(cardInfo) do
        local item = self.Grid_cards:pushBackDefaultItem()
        self:updateGridItem(item,v)
        table.insert(self.cardsIds,k)
    end
end

function KuangsanTaskCardView:closeAllCards()

    self.closeTab = Utils:shuffle(clone(self.cardsIds))
    if not next(self.closeTab) then
        return
    end
    self:closeCard(1)
end

function KuangsanTaskCardView:closeCard( idx )
    -- body
    self.playAning = true
    local itemIdx = self.closeTab[idx]
    if not itemIdx then
        self.playAning = false
        return
    end
    local item = self.Grid_cards:getItem(itemIdx)
    if not item then return end
    item:setGrayEnabled(false)
    local Image_card = TFDirector:getChildByPath(item,"Image_card")
    local Image_front = TFDirector:getChildByPath(item,"Image_front")
    Image_front:runAction(CCScaleTo:create(0.2,0,1))
    local arr = {
        CCScaleTo:create(0.2,0,1),
        CCCallFunc:create(function ()
            if idx then
                local cardBackResName = idx%2 == 1 and "001.png" or "002.png"
                Image_card:setTexture("ui/activity/kuangsan_card/"..cardBackResName)
            end
            item:setTouchEnabled(true)
            Image_front:setOpacity(0)
            local nextIdx = idx + 1
            self:closeCard(nextIdx)
        end),
        CCScaleTo:create(0.2,1,1),
    }

    Image_card:runAction(CCSequence:create(arr))
end

function KuangsanTaskCardView:updateGridItem(item, data)

    local Image_card = TFDirector:getChildByPath(item,"Image_card")
    local Image_flag = TFDirector:getChildByPath(item,"Image_flag"):setOpacity(0)
    local Image_front = TFDirector:getChildByPath(item,"Image_front")
    local Label_count = TFDirector:getChildByPath(item,"Label_count")
    local pos = data.pos
    if pos then
        local cardBackResName = pos%2 == 1 and "001.png" or "002.png"
        Image_card:setTexture("ui/activity/kuangsan_card/"..cardBackResName)
    end

    local id = data.id
    if id then
        Image_front:setOpacity(255)
        local cardCfg = KsanCardDataMgr:getCardCfg(id)
        Image_card:setTexture(cardCfg.cardFace)
        local itmCfg = GoodsDataMgr:getItemCfg(cardCfg.itemShow)
        Image_front:setTexture(itmCfg.icon)
        local num = cardCfg.itemMap[cardCfg.itemShow]
        Label_count:setText("x"..num)
        Label_count:setSkewX(15)
        local rgb = cardCfg.rgb
        Label_count:setColor(ccc3(rgb.r,rgb.g,rgb.b))

        local fnishNum = KsanCardDataMgr:finishMatchNum(id)
        item:setGrayEnabled(fnishNum >= 2)
    else
        Image_front:setOpacity(0)
    end

    item:onClick(function ()
        if self.playAning then return end
        local cardInfo = KsanCardDataMgr:getCardInfo(pos)
        if cardInfo.id then
            return
        end
        KsanCardDataMgr:Send_OpenCard(self.activityId_,pos)
    end)

end

function KuangsanTaskCardView:askOpenCardResp( data )

    dump(data)

    local cardInfo = data.cardInfo
    local rewards = data.rewards or {}
    table.sort(rewards,function(a,b)
        local cfgA= GoodsDataMgr:getItemCfg(a.id)
        local cfgB= GoodsDataMgr:getItemCfg(b.id)
        return cfgA.order < cfgB.order
    end)
    local cardCfg = KsanCardDataMgr:getCardCfg(cardInfo.id)
    if not cardCfg then
        return
    end

    local item = self.Grid_cards:getItem(cardInfo.pos)
    if not item then return end
    local Image_front = TFDirector:getChildByPath(item,"Image_front")
    local Label_count = TFDirector:getChildByPath(item,"Label_count")
    local itmCfg = GoodsDataMgr:getItemCfg(cardCfg.itemShow)
    Image_front:setTexture(itmCfg.icon)
    local num = cardCfg.itemMap[cardCfg.itemShow]
    Label_count:setText("x"..num)
    Label_count:setSkewX(15)
    local rgb = cardCfg.rgb
    Label_count:setColor(ccc3(rgb.r,rgb.g,rgb.b))

    self:openCard(cardInfo,function ()
        self:updateProgress()

        local cardInfo = KsanCardDataMgr:getCardInfo()
        for k,v in ipairs(cardInfo) do
            if v.id then
                local fnishNum = KsanCardDataMgr:finishMatchNum(v.id)
                if fnishNum >= 2 then
                    local item = self.Grid_cards:getItem(v.pos)
                    item:setGrayEnabled(fnishNum >= 2)
                end
            end
        end
        
        local function hideCallBack()
            self:checkReset()
        end

        if next(rewards) then
            Utils:showReward(rewards,nil,hideCallBack)
        end

    end )

end

function KuangsanTaskCardView:checkReset()
    local canRest = true
    local cardInfo = KsanCardDataMgr:getCardInfo()
    for k,v in ipairs(cardInfo) do
        if not v.id then
            canRest = false
            break
        end
    end

    if canRest then
        KsanCardDataMgr:Send_ResetCards(self.activityId_)
    end
end

function KuangsanTaskCardView:registerEvents()

    EventMgr:addEventListener(self, EV_KSAN_CARDS, handler(self.closeAllCards, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateCost, self))
    EventMgr:addEventListener(self, EV_KSAN_MATCH_CARDS, handler(self.askOpenCardResp, self))

    self.Button_checkTask:onClick(function()
        self:closeAllCards()
    end)

    self.Button_checkReward:onClick(function()
        Utils:openView("activity.KuangsanTaskAwardScan")
    end)

    self.Image_cost_bg:onClick(function()
        if self.costInfo then
            Utils:showInfo(self.costInfo.id,nil,true)
        end
    end)
end


return KuangsanTaskCardView