
local DuanwuMakeView = class("DuanwuMakeView", BaseLayer)

function DuanwuMakeView:initData(makeDating)
    self.selectNum_ = {1, 1, 1}

    self.makeDating = makeDating or {}
    local store = StoreDataMgr:getOpenStore(EC_StoreType.DUANWU)
    self.storeCid_ = store[1]
    self.commodity_ = StoreDataMgr:getCommodity(self.storeCid_)
end

function DuanwuMakeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)

    if ActivityDataMgr2:getActivityUIType() == 1 then
        self.__cname = "MidAutumnMakeView"
        self:init("lua.uiconfig.activity.midAutumnMakeView")
    elseif ActivityDataMgr2:getActivityUIType() == 2 then
        self.__cname = "LanternFestivalMakeView"
        self:init("lua.uiconfig.activity.lanternFestivalMakeView")
    else
        self:init("lua.uiconfig.activity.duanwuMakeView")
    end
   
end

function DuanwuMakeView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_make = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Image_make_" .. i)
        foo.Panel_target = TFDirector:getChildByPath(foo.root, "Panel_target")
        foo.Panel_goodsItem_target = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem_target:AddTo(foo.Panel_target):Pos(0, 0):Scale(0.8)
        foo.Label_target_num = TFDirector:getChildByPath(foo.root, "Label_target_num")
        foo.Panel_item = {}
        for j = 1, 3 do
            local bar = {}
            bar.root = TFDirector:getChildByPath(foo.root, "Panel_item_" .. j)
            bar.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            bar.Panel_goodsItem:AddTo(bar.root):Pos(0, 0):Scale(0.8)
            bar.Label_num = TFDirector:getChildByPath(bar.root, "Label_num")
            foo.Panel_item[j] = bar
        end
        local Image_select_num = TFDirector:getChildByPath(foo.root, "Image_select_num")
        foo.Button_down = TFDirector:getChildByPath(Image_select_num, "Button_down")
        foo.Button_up = TFDirector:getChildByPath(Image_select_num, "Button_up")
        foo.Label_num = TFDirector:getChildByPath(Image_select_num, "Label_num")
        foo.Button_make = TFDirector:getChildByPath(foo.root, "Button_make")
        local Label_make = TFDirector:getChildByPath(foo.Button_make, "Label_make")
        Label_make:setTextById(100000139)
        foo.Image_not_enough = TFDirector:getChildByPath(foo.root, "Image_not_enough")
        local Label_not_enough = TFDirector:getChildByPath(foo.Image_not_enough, "Label_not_enough")
        Label_not_enough:setTextById(100000138)
        local Image_name = TFDirector:getChildByPath(foo.root, "Image_name")
        foo.Label_name = {}
        for j = 1, 2 do
            foo.Label_name[j] = TFDirector:getChildByPath(Image_name, "Label_name_" .. j)
        end

        self.Image_make[i] = foo
    end

    self:refreshView()
end

function DuanwuMakeView:updateMakeInfo()
    for i, foo in ipairs(self.Image_make) do
        local commodityCid = self.commodity_[i]
        local commodityCfg = StoreDataMgr:getCommodityCfg(commodityCid)
        local goods = commodityCfg.goodInfo[1]
        local goodsId, goodsCount = goods.id, goods.num
        local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)
        PrefabDataMgr:setInfo(foo.Panel_goodsItem_target, goodsId)
        foo.Label_target_num:setTextById(100000140, GoodsDataMgr:getItemCount(goodsId))

        local name = string.UTF8ToCharArray(TextDataMgr:getText(goodsCfg.nameTextId))
        for j, Label_name in ipairs(foo.Label_name) do
            Label_name:setText(name[j])
        end

        local costId = commodityCfg.priceType
        local costNum = commodityCfg.priceVal

        for j, bar in ipairs(foo.Panel_item) do
            local id = costId[j]
            local num = costNum[j]
            if id and num then
                PrefabDataMgr:setInfo(bar.Panel_goodsItem, id)
                bar.Label_num:setTextById(800005, GoodsDataMgr:getItemCount(id), num)
            end

            if ActivityDataMgr2:getActivityUIType() == 2 then
                if GoodsDataMgr:currencyIsEnough(id, num) then
                    bar.Label_num:setFontColor(ccc3(255,194,76))
                else
                    bar.Label_num:setFontColor(ccc3(70,170,223))
                end
            end
            
        end

        local isEnough = StoreDataMgr:currencyIsEnough(commodityCid, self.selectNum_[i])
        foo.Button_make:setVisible(isEnough)
        foo.Image_not_enough:setVisible(not isEnough)
        foo.Button_down:setTouchEnabled(isEnough)
        foo.Button_up:setTouchEnabled(isEnough)
        foo.Button_down:setGrayEnabled(not isEnough)
        foo.Button_up:setGrayEnabled(not isEnough)

        foo.Button_make:onClick(function()
                StoreDataMgr:send_STORE_BUY_GOODS(commodityCid, self.selectNum_[i])
        end)

        foo.Button_down:onTouch(function(event)
                if event.name == "ended" then
                    TFDirector:removeTimer(self.timer)
                    self.timer = nil
                end
                if event.name == "began" then
                    TFAudio.playSound(Utils:getKVP(1001, "ui_clickSound"))
                    self:onTouchButtonDown(i)
                    self:continueReduceAction(i)
                end
        end)

        foo.Button_up:onTouch(function(event)
                if event.name == "ended" then
                    TFDirector:removeTimer(self.timer)
                    self.timer = nil
                end
                if event.name == "began" then
                    TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                    self:onTouchButtonUp(i)
                    self:continueAddAction(i)
                end
        end)
    end
end

function DuanwuMakeView:onTouchButtonDown(index)
    local count = StoreDataMgr:getMaxBuyCount(self.commodity_[index])
    if count == 0 then return end

    local num = self.selectNum_[index]
    num = num - 1
    self.selectNum_[index] = clamp(num, 1, count)
    self:updateSelectNumInfo()
end

function DuanwuMakeView:onTouchButtonUp(index)
    local count = StoreDataMgr:getMaxBuyCount(self.commodity_[index])
    if count == 0 then return end

    local num = self.selectNum_[index]
    num = num + 1
    self.selectNum_[index] = clamp(num, 1, count)
    self:updateSelectNumInfo()
end

function DuanwuMakeView:continueAddAction(index)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonUp(index)
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function DuanwuMakeView:continueReduceAction(index)
    local delayTime = 0
    local neddTime  = 0.5
    local function action(dt)
        delayTime = delayTime + dt
        if delayTime >= neddTime then
            self:onTouchButtonDown(index)
            delayTime = 0
            neddTime = 0.05
        end
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function DuanwuMakeView:updateSelectNumInfo()
    for i, foo in ipairs(self.Image_make) do
        foo.Label_num:setText(self.selectNum_[i])
    end
end

function DuanwuMakeView:refreshView()
    self:updateMakeInfo()
    self:updateSelectNumInfo()
end

function DuanwuMakeView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))
end

function DuanwuMakeView:onItemUpdateEvent()
    self:updateMakeInfo()
end

function DuanwuMakeView:onBuySuccessEvent(data)
    local rewardList = {}
    for k,v in pairs(data.goods) do
        table.insert(rewardList, Utils:makeRewardItem(v.id, v.num))
    end
    Utils:showReward(rewardList)

    local reward = rewardList[1]
    
    if reward then
        local rewardCid = reward.id
        local datingId  = self.makeDating[tostring(rewardCid)]
        if datingId then
            local value = Utils:getLocalSettingValue("ActivityTpye_DUANWU_1"..rewardCid..datingId)
            if value == "" then
                FunctionDataMgr:jStartDating(datingId)
                Utils:setLocalSettingValue("ActivityTpye_DUANWU_1"..rewardCid..datingId,"true")
            end
        end
    end

    self.selectNum_ = {1, 1, 1}
    self:updateSelectNumInfo()
    self:updateMakeInfo()
end

return DuanwuMakeView
