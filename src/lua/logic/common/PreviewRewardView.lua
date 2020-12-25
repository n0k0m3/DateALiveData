
local PreviewRewardView = class("PreviewRewardView", BaseLayer)

function PreviewRewardView:initData(rewardList,isSeq)
    self.rewardList = rewardList
    self.isSeq = isSeq
end

function PreviewRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.previewRewardView")
end

function PreviewRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_titleEn = TFDirector:getChildByPath(Image_content, "Label_titleEn")
    self.Label_tips = TFDirector:getChildByPath(Image_content, "Label_tips")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(5)

    local Image_scrollBarModel = TFDirector:getChildByPath(Image_content, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    self.scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.scrollBar:setVisible(false)
    self.ListView_reward:setScrollBar(self.scrollBar)

    if not self.rewardList then return end

    if self.isSeq then
        self:refreshSeqView()
    else
        self:refreshView()
    end
end

function PreviewRewardView:refreshView()
    local item = TFPanel:create()
    item:setContentSize(CCSize(4*125,125))
    local num = #self.rewardList
    local offset = math.max((4-num)*125/2,0)
    for i, v in ipairs(self.rewardList) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        if v.id then
            PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        else
            PrefabDataMgr:setInfo(Panel_goodsItem, v[1], v[2])
        end
        item:addChild(Panel_goodsItem)
        Panel_goodsItem:setPosition(ccp((i%5-1)*125 + 62.5 + offset, 0))
        if i%4 == 0 or i == num then
            self.ListView_reward:pushBackCustomItem(item)
            item = TFPanel:create()
            item:setContentSize(CCSize(4*125,125))
        end
    end
end

function PreviewRewardView:refreshSeqView()
    self.scrollBar:setVisible(true)
    self.ListView_reward:removeAllItems()
    local x, y = 20, -30
    local goodsDis = 100
    local lineNum = #self.rewardList
    for i = 1, lineNum do
        local items = self.rewardList[i]

        local panel = TFPanel:create()
        panel:setAnchorPoint(ccp(0,1))
        panel:setContentSize(ccs(self.ListView_reward:getInnerContainerSize().width, math.ceil(#items / 4) * goodsDis))
        panel:setPosition(ccp(0,0))
        local lab = TFLabel:create()
        lab:setFontSize(50)
        lab:setAnchorPoint(ccp(0,1))
        lab:setText(i)
        lab:enableStroke(ccc3(0, 0, 0), 1)
        panel:addChild(lab)
        lab:setPosition(ccp(x, y))
        for j, v in ipairs(items) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setScale(0.8)
            if v.id then
                PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
            else
                PrefabDataMgr:setInfo(Panel_goodsItem, v[1], v[2])
            end
            panel:addChild(Panel_goodsItem)
            local goodsX = j % 4 ~= 0 and j % 4 * goodsDis  or  4 * goodsDis 
            local goodsY = (y - 25) - math.floor((j - 1) / 4) * goodsDis
            if j == 5 then
                local p
            end
            Panel_goodsItem:setPosition( ccp(goodsX + x, goodsY) )
        end
        self.ListView_reward:pushBackCustomItem(panel)
    end
end

function PreviewRewardView:registerEvents()

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return PreviewRewardView
