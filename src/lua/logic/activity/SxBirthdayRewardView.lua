
local SxBirthdayRewardView = class("SxBirthdayRewardView", BaseLayer)

function SxBirthdayRewardView:initData(cityCid, eventCid, reward)
    self.cityCid_ = cityCid
    self.eventCid_ = eventCid
    self.reward_ = reward or {}
    self.eventCfg_ = SxBirthdayDataMgr:getTohkaEventCfg(self.eventCid_)
end

function SxBirthdayRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    ViewAnimationHelper.showPopOpenAnim(self)
    self:init("lua.uiconfig.activity.sxBirthdayRewardView")
end

function SxBirthdayRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close"):hide()
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_head.Image_icon")
    self.Label_desc = TFDirector:getChildByPath(Image_content, "Label_desc")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.Button_receive = TFDirector:getChildByPath(Image_content, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")

    self:refreshView()
end

function SxBirthdayRewardView:refreshView()
    self.Label_title:setTextById(self.eventCfg_.name)
    self.Label_desc:setTextById(self.eventCfg_.eventDes)
    self.Image_icon:Scale(0.8):setTexture(self.eventCfg_.head)
    self.Label_receive:setTextById(700013)
    self.ListView_reward:setItemsMargin(10)

    for i, v in ipairs(self.reward_) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.75)
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    Utils:setAliginCenterByListView(self.ListView_reward, true)
end

function SxBirthdayRewardView:registerEvents()
    EventMgr:addEventListener(self, EV_SXBIRTHDAY_GET_REWARD, handler(self.onGetRewardEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_receive:onClick(function()
            SxBirthdayDataMgr:send_BIRTH_DAY_REQ_GET_EXPLORE_AWARD(self.cityCid_)
    end)
end

function SxBirthdayRewardView:onGetRewardEvent(eventCid, rewards)
    AlertManager:closeLayer(self)
    Utils:showReward(rewards)
end

return SxBirthdayRewardView
