
local SkyLadderCardSetView = class("SkyLadderCardSetView", BaseLayer)

function SkyLadderCardSetView:initData()
    self.cardData_ = {596001, 596001, 596001}
    self.cardCount_ = #self.cardData_
    self.curIndex_ = 0
end

function SkyLadderCardSetView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.skyladder.skyladderCardSetView")
end

function SkyLadderCardSetView:initUI(ui)
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
    self.Label_card_desc = TFDirector:getChildByPath(Image_result, "Label_card_desc")
    self.Label_collect = TFDirector:getChildByPath(Image_result, "Label_collect")
    local Image_percent = TFDirector:getChildByPath(Image_result, "Image_percent")
    self.LoadingBar_percent = TFDirector:getChildByPath(Image_percent, "LoadingBar_percent")
    self.Label_percent = TFDirector:getChildByPath(Image_percent, "Label_percent")
    self.Image_back_card = TFDirector:getChildByPath(self.Panel_single_show, "Image_back_card")
    self.Image_back_card_pos = self.Image_back_card:Pos()

    self.Panel_all_show = TFDirector:getChildByPath(self.Panel_root, "Panel_all_show"):hide()
    local ScrollView_card = TFDirector:getChildByPath(self.Panel_all_show, "ScrollView_card")
    self.ListView_card = UIListView:create(ScrollView_card)
    self.Spine_get = TFDirector:getChildByPath(self.Panel_all_show, "Spine_get"):hide()

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")

    self:refreshView()
end

function SkyLadderCardSetView:refreshView()
    for i, cardCid in ipairs(self.cardData_) do
        local cardCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
        local itemCfg = GoodsDataMgr:getItemCfg(cardCid)
        local level = 1

        local Panel_cardItem = self.Panel_cardItem:clone():hide()
        local Button_card = TFDirector:getChildByPath(Panel_cardItem, "Button_card")
        local Image_card_type = TFDirector:getChildByPath(Button_card, "Image_card_type")
        local Label_card_lv = TFDirector:getChildByPath(Button_card, "Label_card_lv")
        local Image_card = TFDirector:getChildByPath(Button_card, "Image_card")
        local ScrollView_cost = TFDirector:getChildByPath(Button_card, "ScrollView_cost")
        local ListView_cost = UIListView:create(ScrollView_cost)
        ListView_cost:setItemsMargin(-5)
        local Label_card_name = TFDirector:getChildByPath(Button_card, "Label_card_name")

        Button_card:setTextureNormal(EC_SkyLadderCardFrame[cardCfg.rarity])
        Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[cardCfg.type])
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
    Utils:setAliginCenterByListView(self.ListView_card, true)

    self.Panel_touch:Size(GameConfig.WS):Touchable(false)

    self:doStart()
end

function SkyLadderCardSetView:play1()
    self.Panel_single_show:show()
    self.Image_result:hide()
    self.Button_card:hide()
    self.Image_back_card:Show():Pos(self.Image_back_card_pos):Alpha(1)
    self.Image_back_card:setRotationX(-15)
    self.Image_back_card:setRotationY(-20)
    local action = Sequence:create({
            Spawn:create({
                    MoveBy:create(0.3, ccp(0, 60)),
                    RotateTo:create(0.3, 0)
            }),
            EaseSineOut:create(MoveTo:create(0.3, self.Button_card_pos)),
            RotateBy:create(0.3, 0, 180),
            Hide:create(),
            CallFunc:create(function()
                    self:play2()
            end)
    })
    self.Image_back_card:runAction(action)
end

function SkyLadderCardSetView:play2()
    self.Button_card:show()
    self.Image_result:show():Alpha(0.3)
    local action = Sequence:create({
            FadeIn:create(0.3),
            CallFunc:create(function()
                    self.Panel_touch:Touchable(true)
            end)
    })
    self.Image_result:runAction(action)
end

function SkyLadderCardSetView:play3()
    self.Panel_single_show:hide()
    self.Panel_all_show:show()

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
            self.Spine_get:show():play("chuxian", false)
        end,
        0.5
    )
end

function SkyLadderCardSetView:updateCurCardInfo()
    local cardCid = self.cardData_[self.curIndex_]
    local cardCfg = SkyLadderDataMgr:getRankMatchCardCfg(cardCid)
    local itemCfg = GoodsDataMgr:getItemCfg(cardCid)
    local level = 1

    self.Button_card:setTextureNormal(EC_SkyLadderCardFrame[cardCfg.rarity])
    self.Image_card_type:setTexture(EC_SkyLadderCardTypeIcon[cardCfg.type])
    self.Image_card:setTexture(itemCfg.icon)
    self.Label_card_name:setTextById(itemCfg.nameTextId)
    self.ListView_cost:removeAllItems()
    self.Label_card_lv:setTextById(800006, level)
    self.Label_card_num:setTextById(800007, 1)
    for k = 1, cardCfg.cost do
        local Image_costItem = self.Image_costItem:clone()
        self.ListView_cost:pushBackCustomItem(Image_costItem)
    end
    Utils:setAliginCenterByListView(self.ListView_cost, true)
end

function SkyLadderCardSetView:doStart()
    self.Panel_touch:Touchable(false)
    if self.curIndex_ < self.cardCount_ then
        self.curIndex_ = self.curIndex_ + 1
        self:updateCurCardInfo()
        self:play1()
    else
        self:play3()
    end
end

function SkyLadderCardSetView:registerEvents()
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
end

return SkyLadderCardSetView
