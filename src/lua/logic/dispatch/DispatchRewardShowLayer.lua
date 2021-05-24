
local DispatchRewardShowLayer = class("DispatchRewardShowLayer", BaseLayer)

function DispatchRewardShowLayer:initData(data,rewardBuff)
    self.rewards_ = data.rewards
    self.rewardBuff = rewardBuff
    self.rewardList = {}
    for k, info in pairs(self.rewards_) do
        for i,v in ipairs(info.rewards) do
            table.insert(self.rewardList, {id = v.id, num = v.num})
        end
    end
    local hangupMap = TabDataMgr:getData("Hangup")
    self.typeInfo = {
    {name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.DAILY].prompt)), showIcon = "ui/dispatch/ui_033.png"},
    {name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.SPRITE].prompt)), showIcon = "ui/dispatch/ui_032.png"},
    {name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.THEATER].prompt)), showIcon = "ui/dispatch/ui_031.png"},
    {name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.TEAM].prompt)), showIcon = "ui/dispatch/ui_034.png"},
    {name = TextDataMgr:getText(tostring(hangupMap[EC_DISPATCHType.DATING].prompt)), showIcon = "ui/dispatch/ui_035.png"},
    }
end

function DispatchRewardShowLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dispatch.dispatchRewardShowLayer")
end

function DispatchRewardShowLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_reward_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_reward_item")
    self.Panel_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_item")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    local ScrollView_items = TFDirector:getChildByPath(ui, "ScrollView_items")
    self.ScrollView_items = UIListView:create(ScrollView_items)
    self.ScrollView_items:setItemsMargin(10)

    self:refreshView()
end

function DispatchRewardShowLayer:refreshView()
    self.ScrollView_items:removeAllItems()
    self.ScrollView_items:AsyncUpdateItem(self.rewards_,function ( )
        return self.Panel_reward_item:clone()
    end,function (reward_item,info)
        local Image_icon = TFDirector:getChildByPath(reward_item, "Image_icon")
        local Label_name = TFDirector:getChildByPath(reward_item, "Label_name")
        local Label_buff_title = TFDirector:getChildByPath(reward_item, "Label_buff_title")
        local Label_buff_value = TFDirector:getChildByPath(reward_item, "Label_buff_value")
        local ScrollView_reward = UIListView:create(TFDirector:getChildByPath(reward_item, "ScrollView_reward"))
        Label_buff_title:setTextById(190000570)
        local buff = self.rewardBuff[info.type] or 0
        Label_buff_value:setText(tostring(buff).."%")
        Image_icon:setTexture(self.typeInfo[info.type].showIcon)
        Label_name:setText(self.typeInfo[info.type].name)
        ScrollView_reward:AsyncUpdateItem(info.rewards,function (...)
            return self.Panel_item:clone()
        end,function (item,v)
            local Label_count = TFDirector:getChildByPath(item, "Label_count")
            Label_count:setText(tostring(v.num))
            local Panel_goods = TFDirector:getChildByPath(item, "Panel_goods")
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(Panel_goodsItem, v.id, -1)
            Panel_goodsItem:setScale(0.7)
            Panel_goodsItem:Pos(0, 0):AddTo(Panel_goods)
        end)
    end)
end

function DispatchRewardShowLayer:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function DispatchRewardShowLayer:onClose()
   self.super.onClose(self)
   Utils:showReward(clone(self.rewardList))
end

return DispatchRewardShowLayer
