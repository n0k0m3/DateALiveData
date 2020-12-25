
local GetItemView = class("GetItemView", BaseLayer)

function GetItemView:initData(itemList,staticRewardList,hideCallBack,titleId)
    self.directClose = nil
    self.itemList_ = itemList or {}
    self.staticItemList_ = staticRewardList or {}
    --self.itemList_ = {}
    --self.itemList_[1] = itemList[1]
    self.columnNum_ = 5
    self.itemColMargin_ = 10
    self.itemRowMargin_ = 15
    self.itemScale = 1
    self.goodsItem_ = {}
    self.hideCallBack = hideCallBack
    self.titleId = titleId
end

function GetItemView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bag.getItemView")
end

function GetItemView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_bg"):hide()
    self.Panel_guide = TFDirector:getChildByPath(ui, "Panel_guide")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Spine_getItem = TFDirector:getChildByPath(ui, "Spine_getItem")
    self.Spine_before = TFDirector:getChildByPath(ui, "Spine_before")
    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Image_scrollBarModel = TFDirector:getChildByPath(ui, "Image_scrollBarModel"):hide()
    local Image_scrollBar = self.Image_scrollBarModel:clone():show()
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    Image_scrollBar:AddTo(self.Image_scrollBarModel:getParent())
    self.scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)

    self.image_game_title = TFDirector:getChildByPath(ui, "image_game_title"):hide()
    self.label_title = TFDirector:getChildByPath(self.image_game_title, "label_title")
    if self.titleId then
        self.image_game_title:show()
        self.label_title:setTextById(self.titleId)
        local titleSize = self.image_game_title:getContentSize()
        self.image_game_title:setContentSize(CCSize(self.label_title:getContentSize().width + 10, titleSize.height))
    end
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_content, "ScrollView_reward")
    self.Panel_item_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_item_mask")
    --self.ListView_reward = UIListView:create(ScrollView_reward)
    --self.ListView_reward:setItemsMargin(20)

    self.Panel_static_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_static_reward"):hide()
    self.staticRewardTitle = TFDirector:getChildByPath(self.Panel_static_reward, "image_title")
    self.image_line = TFDirector:getChildByPath(self.Panel_static_reward, "image_line")

    local staticScrollList = TFDirector:getChildByPath(self.Panel_static_reward, "ScrollView_static_reward")

    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:setSize(GameConfig.WS)

    local itemCount = #self.itemList_

    local offW = 0
    local offH = 0
    if self.columnNum_ >= itemCount then
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * itemCount
        offH = self.Panel_goodsItem_prefab:Size().height + self.itemRowMargin_
    else
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * self.columnNum_
        offH = ScrollView_reward:getSize().height
    end
    ScrollView_reward:setContentSize(CCSize(offW, offH))
    if #self.staticItemList_ > 0 then
        self.Panel_static_reward:show()
        local size = staticScrollList:getSize()
        staticScrollList:setContentSize(CCSize(size.width,offH))
        self.Uilist_staticReward = UIListView:create(staticScrollList)
        self.Uilist_staticReward:setScrollBar(self.scrollBar)
        self.staticRewardTitle:setPositionY(self.staticRewardTitle:getPositionY()+(offH - size.height)/2)
        if itemCount > 1 then
            self.Panel_static_reward:setPositionX(-170)
            self.itemScale = 0.85

            if self.columnNum_ < itemCount then
                self.staticRewardTitle:setPositionY(self.staticRewardTitle:getPositionY() - 35)
            end
        end
        local posX = self.Panel_static_reward:getPositionX()
        self.Panel_item_mask:setPositionX(offW/2 + posX + 20)
        self.image_line:setContentSize(CCSizeMake(3,offH))
        staticScrollList:setPositionY(staticScrollList:getPositionY()+self.itemRowMargin_/2)
    end

    self.Panel_item_mask:setContentSize(CCSize(offW+50, offH+40))
    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)
    self.GridView_reward:setColumn(self.columnNum_)
    self.GridView_reward:setColumnMargin(self.itemColMargin_)
    self.GridView_reward:setRowMargin(self.itemRowMargin_)
    self.GridView_reward:setScrollBar(self.scrollBar)

    self.scrollBar:setVisible(false)

    self.Panel_goodsRowItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsRowItem")
    self.Spine_before:play("effect_props_start",false)
    self.Spine_before:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_before:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_before:play("effect_props_start_1",true)
        end, 0)
    end)
    Utils:playSound(6001)
    self:timeOut(function()
        self:refreshView()
    end, 0.2)
    --self:refreshView()
end

function GetItemView:refreshView()
    --local itemMargin = 10
    --local goodsItemSize = self.Panel_goodsItem_prefab:Size()
    --local goodsItemAp = self.Panel_goodsItem_prefab:AnchorPoint()
    for i, v in ipairs(self.itemList_) do
        local data = v
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, data.originId or data.id, data.num)
        Panel_goodsItem:setScale(2)
        Panel_goodsItem:setOpacity(0)
        local itemCfg = GoodsDataMgr:getItemCfg(data.id)

        if itemCfg  then
            if EC_ItemQualityEffect[itemCfg.quality] then
                local Spine_qualityEffect_bg = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_bg")
                Spine_qualityEffect_bg:setVisible(true)
                Spine_qualityEffect_bg:play(EC_ItemQualityEffect[itemCfg.quality].bg,true)
                local Spine_qualityEffect_up2 = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_up2")
                Spine_qualityEffect_up2:play(EC_ItemQualityEffect[itemCfg.quality].up2,true)
                Spine_qualityEffect_up2:setVisible(false)
                local pos = ccp(1,-1)
                if itemCfg.quality == EC_ItemQuality.PURPLE then
                    pos = ccp(2,-1)
                elseif itemCfg.quality == EC_ItemQuality.RED then
                    pos = ccp(1,1)
                end
                Spine_qualityEffect_up2:setPosition(pos)
            end
            Panel_goodsItem.quality = itemCfg.quality
        end

        table.insert(self.goodsItem_, Panel_goodsItem)
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    for i,v in ipairs(self.staticItemList_) do
        local data = v
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, data.originId or data.id, data.num)
        Panel_goodsItem:setScale(self.itemScale)
        -- Panel_goodsItem:setOpacity(0)
        local itemCfg = GoodsDataMgr:getItemCfg(data.id)

        if itemCfg  then
            if EC_ItemQualityEffect[itemCfg.quality] then
                local Spine_qualityEffect_bg = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_bg")
                Spine_qualityEffect_bg:setVisible(true)
                Spine_qualityEffect_bg:play(EC_ItemQualityEffect[itemCfg.quality].bg,true)
                local Spine_qualityEffect_up2 = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_up2")
                Spine_qualityEffect_up2:play(EC_ItemQualityEffect[itemCfg.quality].up2,true)
                Spine_qualityEffect_up2:setVisible(false)
                local pos = ccp(1,-1)
                if itemCfg.quality == EC_ItemQuality.PURPLE then
                    pos = ccp(2,-1)
                elseif itemCfg.quality == EC_ItemQuality.RED then
                    pos = ccp(1,1)
                end
                Spine_qualityEffect_up2:setPosition(pos)
            end
            Panel_goodsItem.quality = itemCfg.quality
        end
        self.Uilist_staticReward:pushBackCustomItem(Panel_goodsItem)
    end

    if self.Uilist_staticReward then
        Utils:setAliginCenterByListView(self.Uilist_staticReward)
    end
    
    --local row = 0
    --for i = 1, #self.itemList_, self.columnNum_ do
    --    row = row + 1
    --    self.goodsItem_[row] = {}
    --    local Panel_goodsRowItem = self.Panel_goodsRowItem:clone()
    --    local width = 0
    --    for j = i, math.min(i + self.columnNum_ - 1, #self.itemList_) do
    --        local data = self.itemList_[j]
    --        local Panel_goodsItem = Panel_goodsItem_prefab:clone()
    --        PrefabDataMgr:setInfo(Panel_goodsItem, data.id, data.num)
    --        local remain = math.fmod(j, self.columnNum_)
    --        if remain == 0 then remain = 5 end
    --        local x = (goodsItemSize.width + itemMargin) * (remain - 1) + goodsItemSize.width * goodsItemAp.x
    --        local y = 0
    --        Panel_goodsItem:Pos(x, y)
    --        Panel_goodsItem:AddTo(Panel_goodsRowItem)
    --        width = x
    --        table.insert(self.goodsItem_[row], Panel_goodsItem)
    --    end
    --    width = width + goodsItemSize.width * (1 - goodsItemAp.x)
    --    local originSize = Panel_goodsRowItem:Size()
    --    local size = CCSize(width, originSize.height)
    --    Panel_goodsRowItem:Size(size)
    --    self.ListView_reward:pushBackCustomItem(Panel_goodsRowItem)
    --end
    --Utils:setAliginCenterByListView(self.GridView_reward, false)

    self:timeOut(function()
        self:playAni()
    end, 0.1)

end

function GetItemView:playAni()
    local delay = -0.1
    --local offsetX = 500
    local offsetX = self.Panel_goodsItem_prefab:Size().width * 0.5
    local itemCount = #self.goodsItem_
    local waitTime = itemCount == 1 and 0.2 or 0.1
    local showItemCnt = 0
    for row, items in ipairs(self.goodsItem_) do
        --for _, item in ipairs(items) do
            local item = items
            --item:hide()
            item:Alpha(0)
            local Spine_qualityEffect_up = TFDirector:getChildByPath(item, "Spine_qualityEffect_up")
            Spine_qualityEffect_up:setVisible(true)
            local itemQuality =  item.quality
            local normalTime = 0.1
            delay = delay + normalTime
            local seq = Sequence:create({
                    DelayTime:create(delay),
                    Spawn:create({
                            --CallFunc:create(function()
                            --        item:show()
                            --end),
                            CCFadeIn:create(0.15),
                            --MoveBy:create(0.2, ccp(offsetX, 0)),
                            CCScaleTo:create(0.15,self.itemScale),
                            --Sequence:create({
                            --        ScaleTo:create(0.05, 1.5),
                            --        DelayTime:create(0.1),
                            --        ScaleTo:create(0.05, 1.0),
                            --}),
                    }),
                    CallFunc:create(function()
                        Utils:playSound(6002)
                        showItemCnt = showItemCnt + 1
                        print(showItemCnt)
                        if not self.directClose then
                            self.Panel_touch:setVisible(showItemCnt >= itemCount)
                        end
                    end),
                    DelayTime:create(waitTime),
                    CallFunc:create(function()
                        if itemQuality and EC_ItemQualityEffect[itemQuality] then
                            local pos = ccp(1,-1)
                            if item.quality == EC_ItemQuality.PURPLE then
                                pos = ccp(0,2)
                            elseif item.quality == EC_ItemQuality.RED then
                                pos = ccp(1,1)
                            end
                            Spine_qualityEffect_up:setPosition(pos)
                            Spine_qualityEffect_up:play(EC_ItemQualityEffect[itemQuality].up,false)
                            local Spine_qualityEffect_up2 = TFDirector:getChildByPath(item, "Spine_qualityEffect_up2")
                            Spine_qualityEffect_up2:setVisible(true)
                        end
                    end),
            })
            item:runAction(seq)
        --end
    end

end

function GetItemView:registerEvents()
    self.Panel_touch:onClick(function()
        if self.hideCallBack then
            self.hideCallBack()
        end
        AlertManager:closeLayer(self)
		--EventMgr:dispatchEvent(EV_CLOSE_MAIN_LAYER)
		MainUISettingMgr:closeMainLayer()
    end)

    self.Panel_guide:onClick(function()
        if self.hideCallBack then
            self.hideCallBack()
        end
        AlertManager:closeLayer(self)
        --EventMgr:dispatchEvent(EV_CLOSE_MAIN_LAYER)
        MainUISettingMgr:closeMainLayer()
    end)
end

function GetItemView:onShow()
    self.super.onShow(self)
    if not self.Panel_touch:isVisible() then
        if not self.timer then
            self.timer = TFDirector:addTimer(1000, -1, nil, function()
                self.directClose = true
                self.Panel_touch:setVisible(true)
            end)
        end
    end

    GameGuide:checkGuide(self)

end

function GetItemView:removeEvents()
    if self.timer then
        TFDirector:stopTimer(self.timer)
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end

    self.directClose = nil
end

return GetItemView
