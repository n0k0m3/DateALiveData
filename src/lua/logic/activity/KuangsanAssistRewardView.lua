local KuangsanAssistRewardView = class("KuangsanAssistRewardView", BaseLayer)

function KuangsanAssistRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.kuangsanAssistRewardView")
end

function KuangsanAssistRewardView:initData(activityId)
    self.activityId = activityId
end

function KuangsanAssistRewardView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_reward_item = TFDirector:getChildByPath(ui, "Panel_reward_item")

    local Label_tittle = TFDirector:getChildByPath(ui, "Label_tittle")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    local ScrollView_rank = TFDirector:getChildByPath(ui, "ScrollView_rank")
    self.ListView_ranking = UIListView:create(ScrollView_rank)
    self.ListView_ranking:setItemsMargin(2)

    local ScrollView_pic = TFDirector:getChildByPath(ui, "ScrollView_pic")
    self.ListView_pic = UIListView:create(ScrollView_pic)
    self.ListView_pic:setItemsMargin(2)

    self.Button_rank = TFDirector:getChildByPath(ui, "Button_rank")
    self.Button_pic = TFDirector:getChildByPath(ui, "Button_pic")

    self:refreshView()
    self:selectTabBtn(1)
end

function KuangsanAssistRewardView:refreshView()
    local rankData = ActivityDataMgr2:getAssistItemInfos(self.activityId, EC_Activity_Assist_Subtype.RANK_REWARD)
    for i,v in ipairs(rankData) do
        local item = self.Panel_reward_item:clone()
        self.ListView_ranking:pushBackCustomItem(item)
        TFDirector:getChildByPath(item, "Label_desc"):setText(v.extendData.des2 or "")
        local Image_item_bg = TFDirector:getChildByPath(item, "Image_item_bg")
        local count = 0
        local goodsId, goodsNum
        for k, reward in pairs(v.reward) do
            local id, num = next(v.reward, goodsId)
            if id then
                goodsId = id
                goodsNum = num
                local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                PrefabDataMgr:setInfo(goodsItem, goodsId, goodsNum)
                goodsItem:AddTo(Image_item_bg):Pos(32 + count * 69, 0):Scale(0.6)
                count = count + 1
            end
        end
    end

    local picData = ActivityDataMgr2:getAssistItemInfos(self.activityId, EC_Activity_Assist_Subtype.CG_UNLOCK)
    for i,v in ipairs(picData) do
        local item = self.Panel_reward_item:clone()
        self.ListView_pic:pushBackCustomItem(item)
        TFDirector:getChildByPath(item, "Label_desc"):setText(v.extendData.des2 or "")
        local Image_item_bg = TFDirector:getChildByPath(item, "Image_item_bg")
        local count = 0
        local goodsId, goodsNum
        for k, reward in pairs(v.reward) do
            local id, num = next(v.reward, goodsId)
            if id then
                goodsId = id
                goodsNum = num
                local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                PrefabDataMgr:setInfo(goodsItem, goodsId, goodsNum)
                goodsItem:AddTo(Image_item_bg):Pos(32 + count * 69, 0):Scale(0.6)
                count = count + 1
            end
        end
    end
end

function KuangsanAssistRewardView:selectTabBtn(idx)
    if self.selectIdx == idx then
        return
    end
    self.selectIdx = idx
    if self.selectIdx == 1 then
        self.Button_rank:setTextureNormal("ui/activity/assist/kuangsan/tip_001.png")
        self.Button_pic:setTextureNormal("ui/activity/assist/kuangsan/tip_002.png")
        self.ListView_ranking:setVisible(true)
        self.ListView_pic:setVisible(false)
    else
        self.Button_rank:setTextureNormal("ui/activity/assist/kuangsan/tip_002.png")
        self.Button_pic:setTextureNormal("ui/activity/assist/kuangsan/tip_001.png")
        self.ListView_ranking:setVisible(false)
        self.ListView_pic:setVisible(true)
    end
end

function KuangsanAssistRewardView:registerEvents()
    self.Button_rank:onClick(function()
        self:selectTabBtn(1)
    end)

    self.Button_pic:onClick(function()
        self:selectTabBtn(2)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return KuangsanAssistRewardView
