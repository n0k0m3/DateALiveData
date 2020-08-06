
local PreviewRewardView = class("PreviewRewardView", BaseLayer)

function PreviewRewardView:initData(rewardList)
    self.rewardList = rewardList
end

function PreviewRewardView:ctor(rewardList)
    self.super.ctor(self,rewardList)
    self:initData(rewardList)
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

    self:refreshView()
end

function PreviewRewardView:refreshView()
    if not self.rewardList then return end
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

function PreviewRewardView:registerEvents()

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

return PreviewRewardView
