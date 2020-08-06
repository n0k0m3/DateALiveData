
local SkyLadderCardPackageView = class("SkyLadderCardPackageView", BaseLayer)

function SkyLadderCardPackageView:initData(cardData_)
    self.cardData_ = cardData_ or {}
    self.cardCount_ = #self.cardData_
    self.curIndex_ = 0
    dump(cardData_)
    self.sabeUseItemId = SkyLadderDataMgr:getSaveUseItemId()
end

function SkyLadderCardPackageView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.skyladder.skyladderCardPackageView")
end

function SkyLadderCardPackageView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_cardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cardItem")
    self.Image_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_costItem")

    self.Panel_single_show = TFDirector:getChildByPath(self.Panel_root, "Panel_single_show"):hide()
    self.Image_result = TFDirector:getChildByPath(self.Panel_single_show, "Image_result")
    self.Button_card = TFDirector:getChildByPath(self.Panel_single_show, "Button_card"):hide()
    self.Button_card_pos = self.Button_card:Pos()
    self.Image_card_type = TFDirector:getChildByPath(self.Button_card, "Image_card_type")
    self.Label_card_lv = TFDirector:getChildByPath(self.Button_card, "Label_card_lv")
    self.Image_card = TFDirector:getChildByPath(self.Button_card, "Image_card")
    self.Label_card_num = TFDirector:getChildByPath(self.Button_card, "Label_card_num")
    self.Image_new = TFDirector:getChildByPath(self.Button_card, "Image_new")
    local ScrollView_cost = TFDirector:getChildByPath(self.Button_card, "ScrollView_cost")
    self.ListView_cost = UIListView:create(ScrollView_cost)
    self.ListView_cost:setItemsMargin(-5)
    self.Label_card_name = TFDirector:getChildByPath(self.Image_result, "Label_card_name")
    self.Label_card_desc = TFDirector:getChildByPath(self.Image_result, "Label_card_desc")
    self.Label_collect = TFDirector:getChildByPath(self.Image_result, "Label_collect")
    self.Image_percent = TFDirector:getChildByPath(self.Image_result, "Image_percent")
    self.LoadingBar_percent = TFDirector:getChildByPath(self.Image_percent, "LoadingBar_percent")
    self.Label_percent = TFDirector:getChildByPath(self.Image_percent, "Label_percent")
    self.Image_back_card = TFDirector:getChildByPath(self.Panel_single_show, "Image_back_card")
    self.Image_light = TFDirector:getChildByPath(self.Panel_single_show, "Image_light"):hide()
    self.Spine_effect = TFDirector:getChildByPath(self.Panel_single_show, "Spine_effect"):hide()
    self.Spine_effect_pos = self.Spine_effect:Pos()

    self.Button_onekeyOpen = TFDirector:getChildByPath(self.Panel_root, "Button_onekeyOpen")

    self.Panel_all_show = TFDirector:getChildByPath(self.Panel_root, "Panel_all_show"):hide()
    self.Panel_package = TFDirector:getChildByPath(self.Panel_all_show, "Panel_package")
    self.Panel_package_pos = self.Panel_package:Pos()
    local ScrollView_card = TFDirector:getChildByPath(self.Panel_all_show, "ScrollView_card"):hide()
    self.ListView_card = UIListView:create(ScrollView_card)
    self.Spine_line = TFDirector:getChildByPath(self.Panel_all_show, "Spine_line"):hide()
    self.Spine_get = TFDirector:getChildByPath(self.Panel_all_show, "Spine_get"):hide()

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    self.Button_package = TFDirector:getChildByPath(self.Panel_root, "Button_package")
    self.Button_package_pos = self.Button_package:Pos()
    self.Label_count = TFDirector:getChildByPath(self.Button_package, "Label_count")
    self.Label_remain_count = TFDirector:getChildByPath(self.Label_count, "Label_remain_count")

    self.Panel_touch:setContentSize(GameConfig.WS)
    self.Panel_touch:setSwallowTouch(false)

    self:refreshView()
end

function SkyLadderCardPackageView:doStart()
    if self.curIndex_ < self.cardCount_ then
        self.curIndex_ = self.curIndex_ + 1
        self:updateCurCardInfo()
        self:play1()
    end
end

function SkyLadderCardPackageView:refreshView()

    local pacakageCfg = GoodsDataMgr:getItemCfg(self.sabeUseItemId)
    if pacakageCfg then
        self.Button_package:setTextureNormal(EC_SkyLadderPakageBigPic[pacakageCfg.quality])
    end

    for i,v  in ipairs(self.cardData_) do
        local cardCid = v.id
        local cardCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
        local itemCfg = GoodsDataMgr:getItemCfg(cardCid)
        local level = 1
        local Panel_cardItem = self.Panel_cardItem:clone():hide()
        local Button_card = TFDirector:getChildByPath(Panel_cardItem, "Button_card")
        local Image_card_type = TFDirector:getChildByPath(Button_card, "Image_card_type")
        local Label_card_lv = TFDirector:getChildByPath(Button_card, "Label_card_lv")
        local Image_card = TFDirector:getChildByPath(Button_card, "Image_card")
        local Label_use_tip = TFDirector:getChildByPath(Button_card, "Label_use_tip")
        local ScrollView_cost = TFDirector:getChildByPath(Button_card, "ScrollView_cost")
        local ListView_cost = UIListView:create(ScrollView_cost)
        ListView_cost:setItemsMargin(-5)
        local Label_card_name = TFDirector:getChildByPath(Button_card, "Label_card_name")

        Label_use_tip:setText("X"..v.num)
        Button_card:setTextureNormal(EC_SkyLadderCardFrame[cardCfg.quality])
        Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[cardCfg.abilityType])
        Image_card:setTexture(itemCfg.icon)
        Label_card_name:setTextById(itemCfg.nameTextId)
        ListView_cost:removeAllItems()
        Label_card_lv:setTextById(800006, level)
        for k = 1, cardCfg.cost do
            local Image_costItem = self.Image_costItem:clone()
            ListView_cost:pushBackCustomItem(Image_costItem)
        end
        Utils:setAliginCenterByListView(ListView_cost, true)


        self.ListView_card:pushBackCustomItem(Panel_cardItem)
    end
    local contentSize = self.ListView_card:getInnerContainerSize()
    if contentSize.width <= 1100 then
        Utils:setAliginCenterByListView(self.ListView_card, true)
    end
    self.Label_remain_count:setText(self.cardCount_)

    self:doStart()
end

function SkyLadderCardPackageView:registerEvents()
    self.Button_package:onClick(function()
            self:doStart()
    end)

    self.Panel_touch:onClick(function()
        self:doStart()
    end)

    self.Spine_get:addMEListener(
        TFARMATURE_COMPLETE,
        function(_, aniName)
            if aniName == "chuxian" then
                self.Spine_get:play("xunhuan", true)
            end
        end
    )

    self.Button_onekeyOpen:onClick(function()
        self.Button_package:Touchable(false)
        self.Panel_touch:Touchable(false)
        self.Button_onekeyOpen:setVisible(false)
        self:play4()
    end)
end

function SkyLadderCardPackageView:updateCurCardInfo()

    local cardCid = self.cardData_[self.curIndex_].id
    local num = self.cardData_[self.curIndex_].num
    local itemCfg = GoodsDataMgr:getItemCfg(cardCid)
    local level = 1

    local cardInfo = SkyLadderDataMgr:getOwnedCardByID(cardCid)
    if cardInfo then
        level = cardInfo.cardLv
    end

    local isMax = itemCfg.maxLevel == level
    if isMax then
        self.Label_card_lv:setText("Max")
    else
        self.Label_card_lv:setTextById(800006, level)
    end
    self.Button_card:setTextureNormal(EC_SkyLadderCardFrame[itemCfg.quality])
    self.Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[itemCfg.abilityType])
    self.Label_card_desc:setTextById(itemCfg.Describe1)
    self.Image_card:setTexture(itemCfg.icon)
    self.Label_card_name:setTextById(itemCfg.nameTextId)
    self.ListView_cost:removeAllItems()
    self.Label_card_num:setTextById(800007, num)
    for k = 1, itemCfg.cost do
        local Image_costItem = self.Image_costItem:clone()
        self.ListView_cost:pushBackCustomItem(Image_costItem)
    end

    self.Image_new:setVisible(false)
    self.Image_percent:setVisible(cardInfo and (not isMax))
    if cardInfo and not isMax then
        local covertCid
        for k,v in pairs(itemCfg.convertMax) do
            covertCid = k
            break
        end
        if not covertCid then
            return
        end
        local count = GoodsDataMgr:getItemCount(covertCid)
        local berforCnt = count - num
        berforCnt = berforCnt < 0 and 0 or berforCnt
        local nextLevel = level + 1
        local costCount = itemCfg.levelUpCoins[nextLevel][covertCid]
        if costCount then
            self.Label_percent:setTextById(800005, berforCnt, costCount)
            self.LoadingBar_percent:setPercent(berforCnt/costCount * 100)
            self.realCount,self.costCount = count,costCount
        end
        self.Image_new:setVisible(berforCnt==0 and cardInfo.cardLv == 1)
    end
    Utils:setAliginCenterByListView(self.ListView_cost, true)
    Utils:playSound(7001)
end

function SkyLadderCardPackageView:updateCardPercent()
    print(self.realCount,self.costCount)
    local percent = clampf(self.realCount / self.costCount * 100, 0, 100)
    local labelAct = Sequence:create({
        DelayTime:create(0.5),
        CallFunc:create(function()
            Utils:playSound(7002)
            Utils:progressToEx(self.LoadingBar_percent, 0.2, percent, function()
                self.Label_percent:setTextById(800005, self.realCount, self.costCount)
            end)
        end)
    })
    self.Label_percent:runAction(labelAct)
end

function SkyLadderCardPackageView:play1()
    self.Panel_single_show:show()
    self.Image_result:hide()
    self.Button_card:hide()
    self.Button_package:Touchable(false)
    self.Panel_touch:Touchable(false)
    self.Image_back_card:Show():Pos(self.Button_package_pos)
    self.Image_back_card:Rotate(15):Scale(0)

    local action = Sequence:create({
            Spawn:create({
                    ScaleTo:create(0.4, 1),
                    EaseSineOut:create(MoveBy:create(0.4, ccp(100, 250))),
                    RotateTo:create(0.4, 0)
            }),
            RotateBy:create(0.2, 0, 180),
            CallFunc:create(function()
                self.Label_remain_count:setText(self.cardCount_ - self.curIndex_)
                self:updateCardPercent()
                self:play2()
            end),
    })
    self.Image_back_card:runAction(action)

    local action = Sequence:create({
            DelayTime:create(0.2),
            FadeIn:create(0.2),
            FadeOut:create(0.2),
            Hide:create(),
    })
    self.Image_light:Show():Alpha(0):runAction(action)

    local action = Sequence:create({
            DelayTime:create(0.2),
            Show:create(),
            CallFunc:create(function()
                    self.Spine_effect:play("animation", false)
            end),
            MoveBy:create(0.4, ccp(0, 60))
    })
    self.Spine_effect:Pos(self.Spine_effect_pos):runAction(action)
end


function SkyLadderCardPackageView:play2()
    local wp = self.Image_back_card:getParent():convertToWorldSpaceAR(self.Image_back_card:Pos())
    local np = self.Button_card:getParent():convertToNodeSpaceAR(wp)
    local action = Sequence:create({
            CallFunc:create(function()
                    self.Image_back_card:hide()
                    self.Button_card:Show():Pos(np)
            end),
            EaseSineOut:create(MoveTo:create(0.4, self.Button_card_pos)),
            CallFunc:create(function()
                    self:play3()
            end)
    })

    self.Button_card:runAction(action)
end

function SkyLadderCardPackageView:play3()
    self.Image_result:Show():Alpha(0.5)
    local action = Sequence:create({
            FadeIn:create(0.3),
            CallFunc:create(function()
                    if self.curIndex_ < self.cardCount_ then
                        self.Button_package:Touchable(true)
                        self.Panel_touch:Touchable(true)
                    else
                        self:play4()
                    end
            end)
    })
    self.Image_result:runAction(action)
end

function SkyLadderCardPackageView:play4()
    local action = Sequence:create({
            DelayTime:create(0.4),
            CallFunc:create(function()
                    self.Panel_single_show:hide()
                    self.Panel_all_show:show()
                    self.Label_count:hide()
            end),
            Spawn:create({
                    ScaleTo:create(0.5, 0.8),
                    EaseSineOut:create(MoveTo:create(0.5, self.Panel_package_pos)),
                    CallFunc:create(function()
                            self:play5()
                    end)
            })
    })
    self.Button_package:runAction(action)
end

function SkyLadderCardPackageView:play5()
    self.ListView_card:s():setVisible(true)
    for i, v in ipairs(self.ListView_card:getItems()) do
        v:PosY(v:PosY() - 40):Alpha(0)
        local action = Spawn:create({
                Show:create(),
                FadeIn:create(1),
                EaseSineOut:create(MoveBy:create(0.5, ccp(0, 40)))
        })
        v:runAction(action)
    end

    self.Panel_root:timeOut(
        function()
            self.Spine_line:show():play("hengxian", false)
            self.Spine_get:show():play("chuxian", false)
            self.Button_package:Touchable(false)
            self.Panel_touch:Touchable(false)
            self.Button_onekeyOpen:setVisible(false)
        end,
        0.5
    )
end

return SkyLadderCardPackageView
