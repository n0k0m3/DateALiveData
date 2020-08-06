local NewCityRewardView = class("NewCityRewardView", BaseLayer)

function NewCityRewardView:ctor(data, touchquit)
    self.super.ctor(self)

    self:initData(data, touchquit)
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.newCityRewardView")
end

function NewCityRewardView:initData(data, touchquit)
    self.reward = data
    self.isTouchQuit = touchquit and true
end

function NewCityRewardView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Label_touch = self.Panel_touch:getChild("Label_touch")
    if self.isTouchQuit then
        self:timeOut(function()
            self.Panel_touch:show()
            self.Panel_touch:Touchable(true)
            self.Panel_touch:onClick(function()
                AlertManager:closeLayer(self)
            end)
            self.Label_touch:setTextById(800018)
        end, 0.8)
    end

    local Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab"):hide()
    self.Panel_item = Panel_prefab:getChild("Panel_item")

    local ScrollView_reward = TFDirector:getChildByName(self.ui, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)

    self:showReward()
end

function NewCityRewardView:showReward()
    self.ListView_reward:removeAllItems()
    local itemTab = TabDataMgr:getData("Item")
    local rewarddata = self.reward or {}
    for i, v in ipairs(rewarddata) do
        local Panel_item = self.Panel_item:clone():show()
        local expand_item = Panel_item:getChild("Image_item")
        expand_item:setTexture(itemTab[v.id].icon)
        local expand_name = Panel_item:getChild("Label_name")
        expand_name:setTextById(itemTab[v.id].nameTextId)
        local expand_num = Panel_item:getChild("Label_count")
        expand_num:setText(v.num)
        self.ListView_reward:pushBackCustomItem(Panel_item)
    end
end

return NewCityRewardView