--[[
    @desc：LandTurnTabletRewardView
]]

local LandTurnTabletRewardView = class("LandTurnTabletRewardView",BaseLayer)

function LandTurnTabletRewardView:initData(activityInfo)
    self.activityInfo = activityInfo
    self.rewardData = {}

    for num, v in pairs(self.activityInfo.extendData.pointsReward) do
        local _v = {}
        _v.rewards = v
        _v.rankTxt = num
        table.insert(self.rewardData, _v)
    end
    table.sort(self.rewardData, function(a, b)
        return a.rankTxt < b.rankTxt
    end)
    local _tmpClone = clone(self.rewardData)
    for i, v in ipairs(self.rewardData) do
        if not _tmpClone[i - 1] then
            v.rankTxt = "1~"..v.rankTxt
        else
            v.rankTxt = (tonumber(_tmpClone[i - 1].rankTxt) + 1).."~"..v.rankTxt
        end 
    end

    table.insert(self.rewardData,{rankTxt = TextDataMgr:getText(63595), rewards = activityInfo.extendData.award})
end

function LandTurnTabletRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.landTurnTabletRewardView")
end

function LandTurnTabletRewardView:initUI(ui)
    self.super.initUI(self,ui)
    self.listView = UIListView:create(self._ui.ScrollView_content)
    self.listView:setItemsMargin(5)
    self._ui.lab_overTime:setTextById(63842)
    self._ui.lab_desc:setTextById(63839)

    self:refreshListView()
end

function LandTurnTabletRewardView:refreshListView()
    self.listView:removeAllItems()
    for i, _data in ipairs(self.rewardData) do
        local item = self._ui.PanelRewardItem:clone()
        local lab_rankTxt = TFDirector:getChildByPath(item, "lab_rankTxt")
        local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")
        local scrollViewReward = UIListView:create(ScrollView_reward)
        scrollViewReward:setItemsMargin(20)
        lab_rankTxt:setText(_data.rankTxt)
        for id, num in pairs(_data.rewards) do
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(goods, id, num)
            goods:setScale(0.65)
            scrollViewReward:pushBackCustomItem(goods)
        end
        self.listView:pushBackCustomItem(item)
    end
end

function LandTurnTabletRewardView:registerEvents()
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)
end

return LandTurnTabletRewardView