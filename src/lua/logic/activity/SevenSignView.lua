
local SevenSignView = class("SevenSignView", BaseLayer)

function SevenSignView:initData(isEmbed)
    self.isEmbed_ = isEmbed
    self.signItems_ = {}
    self.actIndex_ = ActivityDataMgr:getActIdx(EC_ActivityType.SEVENDAY)
    self.entryCnt_  = ActivityDataMgr:getActEntryCnt(self.actIndex_)
end

function SevenSignView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.sevenSignView")
end

function SevenSignView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_sevenItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_sevenItem")
    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    local ScrollView_reward = TFDirector:getChildByPath(self.Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.Button_sevenReceive = TFDirector:getChildByPath(self.Image_content, "Button_sevenReceive")
    self.Label_signInReceive = TFDirector:getChildByPath(self.Button_sevenReceive, "Label_signInReceive")
    self.Button_seven_raiders_left = TFDirector:getChildByPath(self.Image_content, "Button_seven_raiders_left")
    self.Button_seven_raiders_right = TFDirector:getChildByPath(self.Image_content, "Button_seven_raiders_right")
    self.Button_close = TFDirector:getChildByPath(self.Image_content, "Button_close")

    self:refreshView()
end

function SevenSignView:refreshView()
    self.ListView_reward:setItemsMargin(38)
    self.ListView_reward:setInertiaScrollEnabled(false)

    for i = 1, self.entryCnt_ do
        self:addSignItem()
    end

    self.Button_close:setVisible(not self.isEmbed_)
    if self.isEmbed_ then
        self.Image_content:Pos(60, -30)
    end

    self:updateAllSignItem()
end

function SevenSignView:updateAllSignItem()
    local curIndex = 1
    for i = 1, self.entryCnt_ do
        local status, rewards = ActivityDataMgr:getActOneEntry(self.actIndex_, i)
        if status == 0 or status == 1 then
            curIndex = i
        end
    end

    for i, v in ipairs(self.ListView_reward:getItems()) do
        local status, rewards = ActivityDataMgr:getActOneEntry(self.actIndex_, i)
        local id, num = next(rewards)
        local foo = self.signItems_[v]
        PrefabDataMgr:setInfo(foo.Panel_goodsItem, id, num)
        foo.Label_cur_day:setTextById(1890015, i)
        foo.Label_day:setTextById(1890015, i)
        foo.Image_cur_day:setVisible(i == curIndex)
        foo.Label_day:setVisible(i ~= curIndex)
        foo.Image_gray:setVisible(status == 0)
        foo.Image_gou:setVisible(status == 0)
    end

    local isCanReceive = ActivityDataMgr:getIsCanReceive(self.actIndex_)
    dump(isCanReceive)
    self.Button_sevenReceive:setGrayEnabled(not isCanReceive)
    self.Button_sevenReceive:setTouchEnabled(isCanReceive)
    self.Label_signInReceive:setTextById(isCanReceive and 700013 or 600025)
end

function SevenSignView:addSignItem()
    local Panel_sevenItem = self.Panel_sevenItem:clone()
    local foo = {}
    foo.root = Panel_sevenItem
    local Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
    foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    foo.Panel_goodsItem:Scale(0.7):Pos(0, 0):AddTo(Panel_reward)
    foo.Image_cur_day = TFDirector:getChildByPath(foo.root, "Image_cur_day")
    foo.Label_cur_day = TFDirector:getChildByPath(foo.Image_cur_day, "Label_cur_day")
    foo.Label_day = TFDirector:getChildByPath(foo.root, "Label_day")
    foo.Image_gou = TFDirector:getChildByPath(foo.root, "Image_gou")
    foo.Image_gray= TFDirector:getChildByPath(foo.root, "Image_gray")
    self.ListView_reward:pushBackCustomItem(foo.root)
    self.signItems_[foo.root] = foo
    return foo
end

function SevenSignView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_UI, handler(self.onUpdateActivityEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_sevenReceive:onClick(function()
            ActivityDataMgr:receiveReward(self.actIndex_)
    end)

    self.Button_seven_raiders_left:onClick(function()
            Utils:openView("fairyNew.FairyStrategyView", 110602)
    end)

    self.Button_seven_raiders_right:onClick(function()
            Utils:openView("fairyNew.FairyStrategyView", 110501)
    end)
end

function SevenSignView:onUpdateActivityEvent()
    dump("11111111111111")
    self:updateAllSignItem()
end

return SevenSignView
