
local FubenTheaterRewardView = class("FubenTheaterRewardView", BaseLayer)

function FubenTheaterRewardView:initData()
    self.data_ = Utils:getKVP(46010, "task")
    self.starItems_ = {}
    self.theaterBossInfo_ = FubenDataMgr:getTheaterBossInfo()
end

function FubenTheaterRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenTheaterRewardView")
end

function FubenTheaterRewardView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    local ScrollView_star = TFDirector:getChildByPath(Image_bg, "ScrollView_star")
    self.ListView_star = UIListView:create(ScrollView_star)
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")

    self.Panel_starItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_starItem")

    self:refreshView()
end

function FubenTheaterRewardView:refreshView()
    local jumpIndex
    for i, v in ipairs(self.data_) do
        local item = self:addStarItem()
        self:updateStarItem(i)
        local isGet = table.indexOf(self.theaterBossInfo_.selfContriPrizeStatus, v.id) ~= -1
        if not isGet and not jumpIndex then
            local count = GoodsDataMgr:getItemCount(EC_SItemType.CONTRIBUTION)
            if count >= v.num then
                jumpIndex = i
            end
        end
    end
    jumpIndex = jumpIndex or 1
    self.ListView_star:scrollToItem(jumpIndex)
end

function FubenTheaterRewardView:addStarItem()
    local item = self.Panel_starItem:clone()
    local foo = {}
    foo.root = item
    local Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
    foo.Button_get = TFDirector:getChildByPath(Image_diban, "Button_get")
    foo.Label_get = TFDirector:getChildByPath(foo.Button_get, "Label_get")
    foo.Label_alreadyGet = TFDirector:getChildByPath(Image_diban, "Label_alreadyGet")
    foo.Label_notReach = TFDirector:getChildByPath(Image_diban, "Label_notReach")
    local ScrollView_reward = TFDirector:getChildByPath(Image_diban, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)
    foo.ListView_reward:setItemsMargin(10)
    foo.Label_collect = TFDirector:getChildByPath(Image_diban, "Label_collect")
    foo.Label_star_num = TFDirector:getChildByPath(Image_diban, "Label_star_num")

    self.starItems_[item] = foo
    self.ListView_star:pushBackCustomItem(item)
    return item
end

function FubenTheaterRewardView:updateStarItem(index)
    local data = self.data_[index]
    local item = self.ListView_star:getItem(index)
    local foo = self.starItems_[item]
    foo.ListView_reward:removeAllItems()
    for k, v in pairs(data.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    foo.Label_get:setTextById(800042)
    foo.Label_alreadyGet:setTextById(800043)
    foo.Label_notReach:setTextById(1300007)
    foo.Label_collect:setTextById(300991)

    foo.Label_star_num:setText(data.num)

    local isGet = table.indexOf(self.theaterBossInfo_.selfContriPrizeStatus, data.id) ~= -1
    foo.Button_get:hide()
    foo.Label_alreadyGet:hide()
    foo.Label_notReach:hide()
    if isGet then
        foo.Label_alreadyGet:show()
    else
        local count = GoodsDataMgr:getItemCount(EC_SItemType.CONTRIBUTION)
        local isReach = count >= data.num
        foo.Button_get:setVisible(isReach)
        foo.Label_notReach:setVisible(not isReach)
    end

    foo.Button_get:onClick(function()
            FubenDataMgr:send_ODEUM_REQ_SELF_CONTRI_PRIZE(data.id)
    end)
end

function FubenTheaterRewardView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_RECEIVE_REWARD, handler(self.onReceiveRewardEvent, self))

    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

function FubenTheaterRewardView:onReceiveRewardEvent(id, reward)
    for i, v in ipairs(self.ListView_star:getItems()) do
        self:updateStarItem(i)
    end

    Utils:showReward(reward)
end

return FubenTheaterRewardView
