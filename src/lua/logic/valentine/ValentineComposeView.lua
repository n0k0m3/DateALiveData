
local ValentineComposeView = class("ValentineComposeView", BaseLayer)

function ValentineComposeView:initData()
    local activityInfo = ValentineDataMgr:getActivityInfo()
    self.composeData_ = activityInfo.extendData.compose
end

function ValentineComposeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.valentine.valentineComposeView")
end

function ValentineComposeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_compose = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_compose_" .. i)
        foo.Panel_good = {}
        for j = 1, 3 do
            local bar = {}
            bar.root = TFDirector:getChildByPath(foo.root, "Panel_good_" .. j)
            bar.Label_cost_notEnough = TFDirector:getChildByPath(bar.root, "Label_cost_notEnough")
            -- bar.Image_cost = TFDirector:getChildByPath(bar.root, "Image_cost")
            bar.Label_cost = TFDirector:getChildByPath(bar.root, "Label_cost")
            bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            bar.Panel_goodsItem:Pos(0, 0):ZO(1):AddTo(bar.root)
            bar.Panel_goodsItem:setScale(0.7)
            foo.Panel_good[j] = bar
        end
        foo.Panel_target = TFDirector:getChildByPath(foo.root, "Panel_target")
        foo.Panel_target_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_target_goodsItem:Pos(0, 0):ZO(1):AddTo(foo.Panel_target)
        foo.Panel_target_goodsItem:setScale(0.9)
        local Image_target = TFDirector:getChildByPath(foo.Panel_target, "Image_target")
        foo.Label_have = TFDirector:getChildByPath(foo.Panel_target, "Label_have")
        foo.Label_have_title = TFDirector:getChildByPath(foo.Panel_target, "Label_have_title")
        foo.Button_make = TFDirector:getChildByPath(foo.root, "Button_make")
        foo.Label_make = TFDirector:getChildByPath(foo.Button_make, "Label_make")
        foo.Image_not_enough = TFDirector:getChildByPath(foo.root, "Image_not_enough")
        foo.Label_not_enough = TFDirector:getChildByPath(foo.Image_not_enough, "Label_not_enough")
        foo.lab_name = TFDirector:getChildByPath(foo.root, "lab_name")
        self.Panel_compose[i] = foo
    end

    self:refreshView()
end

function ValentineComposeView:refreshView()
    self:updateAllComposeItem()
end

function ValentineComposeView:updateAllComposeItem()
    for i, v in ipairs(self.Panel_compose) do
        self:updateComposeItem(i)
    end
end

function ValentineComposeView:updateComposeItem(index)
    local composeCid = self.composeData_[index]
    local composeCfg = TabDataMgr:getData("Compose", composeCid)

    local foo = self.Panel_compose[index]
    foo.Image_not_enough:setGrayEnabled(true)
    foo.Label_have_title:setTextById(1710005)
    foo.Label_not_enough:setTextById(1710007)
    foo.Label_make:setTextById(1710006)
    foo.Label_have_title:setTextById(1710005)

    local order = 1
    local isReach = true
    for cid, num in pairs(composeCfg.needItem) do
        local bar = foo.Panel_good[order]
        local count = GoodsDataMgr:getItemCount(cid)
        -- bar.Label_cost_notEnough:setTextById(800005, num, count)
        bar.Label_cost:setTextById(800005, count, num)
        bar.Label_cost_notEnough:setTextById(800005, count, num)
        PrefabDataMgr:setInfo(bar.Panel_goodsItem, cid)
        order = order + 1
        local isEnough = count >= num
        bar.Label_cost:setVisible(isEnough)
        bar.Label_cost_notEnough:setVisible(not isEnough)
        isReach = isReach and isEnough
    end

    PrefabDataMgr:setInfo(foo.Panel_target_goodsItem, composeCid)
    local count = GoodsDataMgr:getItemCount(composeCid)
    foo.Label_have:setText(count)
    foo.lab_name:setTextById(GoodsDataMgr:getItemCfg(composeCid).nameTextId)

    foo.Button_make:setVisible(isReach)
    foo.Image_not_enough:setVisible(not isReach)

    foo.Button_make:onClick(function()
            local gift = {composeCid, 1}
            ValentineDataMgr:send_VALENTINE_VALENTINE_COMPOSE(gift)
    end)
end

function ValentineComposeView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_COMPOSE, handler(self.onComposeEvent, self))
end

function ValentineComposeView:onComposeEvent(reward)
    Utils:showReward(reward)
    self:updateAllComposeItem()
end

return ValentineComposeView
