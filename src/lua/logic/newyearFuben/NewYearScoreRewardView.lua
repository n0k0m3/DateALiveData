local NewYearScoreRewardView = class("NewYearScoreRewardView",BaseLayer)


function NewYearScoreRewardView:initData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_FUBEN)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.scores = {}
    self.rewards = {}
    for i, v in ipairs(self.activityInfo.extendData.battlePointsReward) do
        if i % 2 == 0 then
            local reward = {}
            for k, count in pairs(v) do
                table.insert(reward,{id = tonumber(k), num = count})
            end
            table.sort(reward, function(a, b)
                return a.id < b.id
            end)
            table.insert(self.rewards,reward)
        else
            table.insert(self.scores,v)
        end
    end
end

function NewYearScoreRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.newYearScoreRewardView")
end

function NewYearScoreRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.rewardView = UIListView:create(self._ui.rewardView)
    self.rewardView:setItemsMargin(5) 
    self._ui.Label_tips:setTextById(12033019)
    self:refreshView()
end

function NewYearScoreRewardView:registerEvents()
    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NewYearScoreRewardView:refreshView()
    for i, v in ipairs(self.scores) do
        local reward = self.rewards[i]
        local item = self._ui.rewardItem:clone()
        self.rewardView:pushBackCustomItem(item)
        item:getChildByName("label_score"):setText(">="..v)
        for j = 1, 5 do
            local rewardItem = item:getChildByName("pos"..j)
            local info = reward[j]
            if info then
                rewardItem:show()
                local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                goodsItem:setScale(0.65)
                PrefabDataMgr:setInfo(goodsItem, info.id, info.num)
                goodsItem:AddTo(rewardItem):Pos(0,0):ZO(1)
            else
                rewardItem:hide()
            end
        end
    end
end

return NewYearScoreRewardView