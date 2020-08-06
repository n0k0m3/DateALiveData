local AssistRankRewardView = class("AssistRankRewardView", BaseLayer)

function AssistRankRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.assistRankRewardView")
end

function AssistRankRewardView:initData(data, content)
    self.data_ = data
    self.content_ = content
end

function AssistRankRewardView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_rank_item = TFDirector:getChildByPath(ui, "Panel_rank_item")

    local Label_tittle = TFDirector:getChildByPath(ui, "Label_tittle")
    self.Label_desc = TFDirector:getChildByPath(ui, "Label_desc")
    Label_tittle:setTextById(263000)

    local ScrollView_desc = TFDirector:getChildByPath(ui, "ScrollView_desc")
    self.text_list = UIListView:create(ScrollView_desc)
    ScrollView_desc:setTouchEnabled(true)

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    local ScrollView_ranking = TFDirector:getChildByPath(ui, "ScrollView_ranking")
    self.ScrollView_ranking = UIListView:create(ScrollView_ranking)
    self.ScrollView_ranking:setItemsMargin(2)

    self:refreshView()
end

function AssistRankRewardView:refreshView()
    local label = self.Label_desc:clone()
    label:setTextById(self.content_)
    label:setWidth(500)
    self.text_list:pushBackCustomItem(label)

    for i,v in ipairs(self.data_) do
        local item = self.Panel_rank_item:clone()
        local Image_bg = TFDirector:getChildByPath(item, "Image_bg")
        if i % 2 == 0 then
            Image_bg:setTexture("ui/activity/assist/036.png")
        else
            Image_bg:setTexture("ui/activity/assist/035.png")
        end
        local Label_rank = TFDirector:getChildByPath(item, "Label_rank")
        Label_rank:setText(v.extendData.des2)
        local rewards = v.reward
        local Panel_rewards = TFDirector:getChildByPath(item, "Panel_rewards")
        local count = 1
        for id,num in pairs(rewards) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(Panel_goodsItem, id, num)
            Panel_goodsItem:setScale(0.5)
            Panel_goodsItem:setAnchorPoint(ccp(1, 0.5))
            Panel_goodsItem:setPosition(ccp(-(count - 1)*60, 35))
            Panel_rewards:addChild(Panel_goodsItem)
            local Label_count = TFDirector:getChildByPath(Panel_goodsItem, "Label_count")
            Label_count:setFontSize(30)
            Label_count:setPositionY(Label_count:getPositionY() - 5)
            count = count + 1
        end
        self.ScrollView_ranking:pushBackCustomItem(item)
    end
end


return AssistRankRewardView
