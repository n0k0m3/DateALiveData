local SkyLadderRewardView = class("SkyLadderRewardView", BaseLayer)

function SkyLadderRewardView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderAward")
end

function SkyLadderRewardView:initData()

    self.rankSortMathCfg = {}
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg()
    for k,v in pairs(rankMatchCfg) do
        table.insert(self.rankSortMathCfg,v)
    end

    table.sort(self.rankSortMathCfg,function(a,b)
        return a.id > b.id
    end)
end

function SkyLadderRewardView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.Panel_root, "Label_title")
    self.Label_title:setTextById(3202055)
    self.chooseBtn = {}
    local Image_left = TFDirector:getChildByPath(self.Panel_root, "Image_left")
    for i=1,2 do
        local btn = TFDirector:getChildByPath(Image_left, "Button_item_"..i)
        local btnName1 = TFDirector:getChildByPath(btn, "Label_btn_1")
        local btnTextId = i == 1 and 3202010 or 3202011
        btnName1:setTextById(btnTextId)
        local btnName2 = TFDirector:getChildByPath(btn, "Label_btn_2")
        local btnStr2 = i == 1 and "Periodic rewards" or "Season rewards"
        btnName2:setText(btnStr2)
        self.chooseBtn[i] = btn
    end

    self.Label_skyladderAward_tip = TFDirector:getChildByPath(self.Panel_root, "Label_skyladderAward_tip")
    self.Label_skyladderAward_tip:setTextById(3203002)

    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root, "ScrollView_award")
    self.ListView_award = UIListView:create(ScrollView_award)

    self.Panel_award_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_award_item")

    self:chooseAwardList(1)
end

function SkyLadderRewardView:chooseAwardList(listId)

    self.listId = listId or 1
    self.desTextId = self.listId == 1 and 3203013 or 3203014
    for i=1,2 do
        if self.listId == i then
            self.chooseBtn[i]:setTextureNormal("ui/setting/uires/002.png")
        else
            self.chooseBtn[i]:setTextureNormal("")
        end
    end

    self:updateAwardList()

end

function SkyLadderRewardView:updateAwardList()


    local curSubRankId = SkyLadderDataMgr:getCurSubRankId()
    if not curSubRankId then
        return
    end

    self.ListView_award:removeAllItems()
    self.itemIndex = 0
    local rankIndex = 1
    self.Panel_root:stopAllActions()
    local seqact = Sequence:create({
        --DelayTime:create(0.01),
        CallFunc:create(function()
            self.itemIndex = self.itemIndex + 1
            local info = self.rankSortMathCfg[self.itemIndex]
            if info then
                if curSubRankId == info.id then
                    rankIndex = self.itemIndex
                end
                local Panel_award_item = self.Panel_award_item:clone()
                Panel_award_item:setOpacity(0)
                self:updateItem(Panel_award_item,info,curSubRankId)
                self.ListView_award:pushBackCustomItem(Panel_award_item)
            else
                self.itemIndex = 0
                self.Panel_root:stopAllActions()
                self.ListView_award:jumpToItem(rankIndex)
                self.ListView_award:doLayout()
            end
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(seqact))

    --for k,v in ipairs(self.rankSortMathCfg) do
    --    local Panel_award_item = self.Panel_award_item:clone()
    --    if curSubRankId == v.id then
    --        rankIndex = k
    --    end
    --    self:updateItem(Panel_award_item,v,curSubRankId)
    --    self.ListView_award:pushBackCustomItem(Panel_award_item)
    --end

end

function SkyLadderRewardView:updateItem(Panel_award_item,info,curSubRankId)
    Panel_award_item:runAction(CCFadeIn:create(0.01))
    local rankId = info.rankID

    local Image_select = TFDirector:getChildByPath(Panel_award_item, "Image_select")
    Image_select:setVisible(curSubRankId == info.id)

    local Label_stage_desc = TFDirector:getChildByPath(Panel_award_item, "Label_stage_desc")
    Label_stage_desc:setTextById(self.desTextId)

    --名字
    local Label_stage_name = TFDirector:getChildByPath(Panel_award_item, "Label_stage_name")
    Label_stage_name:setTextById(info.rankName)

    local Image_stage_icon = TFDirector:getChildByPath(Panel_award_item, "Image_stage_icon")
    Image_stage_icon:setTexture(EC_SkyLadderMedal[rankId])
    Image_stage_icon:setScale(0.5)
    --
    local Label_taget = TFDirector:getChildByPath(Panel_award_item, "Label_taget")
    Label_taget:setTextById(info.rankName)
    Label_taget:setColor(EC_SkyLadderColor[rankId])

    local award = self.listId == 1 and info.weekAwardShow or info.seasonAwardShow
    local itemIndx = 1
    for k,v in pairs(award) do
        local itemImg = TFDirector:getChildByPath(Panel_award_item, "Image_item_"..itemIndx)
        itemImg:setVisible(true)
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:AddTo(itemImg)
        Panel_goodsItem:Pos(0, 0)
        PrefabDataMgr:setInfo(Panel_goodsItem, k,v)
        itemIndx = itemIndx + 1
    end
end

function SkyLadderRewardView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i=1,2 do
        self.chooseBtn[i]:onClick(function()
            self:chooseAwardList(i)
        end)
    end
end

return SkyLadderRewardView