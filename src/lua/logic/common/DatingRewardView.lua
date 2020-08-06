local DatingRewardView = class("DatingRewardView",BaseLayer)

function DatingRewardView:initData(data)
    self.cgData_ = data.cgData
    self.rewards_ = data.rewards
end

function DatingRewardView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.common.datingRewardView")
end

function DatingRewardView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initCg()
    self:initReward()

    self:enterAction()
    self.ui:timeOut(function()
            self:outAction()
        end,2.8)
end

function DatingRewardView:initCg()
    local Image_cgBottom = TFDirector:getChildByPath(self.ui,"Image_cgBottom")

    if self.cgData_ then
        local Image_cg = TFDirector:getChildByPath(Image_cgBottom,"Image_cg")
        Image_cg:setTexture(self.cgData_.iconPath)
    else
        Image_cgBottom:hide()
    end
end

function DatingRewardView:initReward()
    local ScrollView_reward = TFDirector:getChildByPath(self.ui,"ScrollView_reward")
    if self.rewards_ then
        self.rewardListView = UIListView:create(ScrollView_reward)
        self.Panel_rewardItem = PrefabDataMgr:getPrefab("Panel_goodsItem")

        self:showReward()
    else
        ScrollView_reward:hide()
    end
end

function DatingRewardView:showReward()
    self.rewardListView:removeAllItems()

    for i,v in ipairs(self.rewards_) do
        local item = self.Panel_rewardItem:clone()
        PrefabDataMgr:setInfo(item,v.id,v.num)
        self.rewardListView:pushBackCustomItem(item)
    end
end

function DatingRewardView:enterAction()
    self.ui:runAnimation("Action0",1)
end

function DatingRewardView:outAction()
    self.ui:runAnimation("Action1",1)
end

function DatingRewardView:onClose()
    self.super.onClose(self)
end


function DatingRewardView:registerEvents()

end

return DatingRewardView;
