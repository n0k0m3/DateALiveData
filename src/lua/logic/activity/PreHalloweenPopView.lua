local PreHalloweenPopView = class("PreHalloweenPopView",BaseLayer)

function PreHalloweenPopView:initData(ghostPos,ghostId)
    self.ghostPos = ghostPos
    self.ghostId = ghostId
end

function PreHalloweenPopView:ctor(ghostPos,ghostId)
    self.super.ctor(self)
    self:initData(ghostPos,ghostId)
    self:init("lua.uiconfig.activity.preHalloweenPopView")
end

function PreHalloweenPopView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    local ScrollView_gift = TFDirector:getChildByPath(ui,"ScrollView_gift")
    self.UIListView_gift = UIListView:create(ScrollView_gift)

    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_gift = TFDirector:getChildByPath(ui,"Button_gift")

    self.Panel_giftItem = TFDirector:getChildByPath(ui,"Panel_giftItem")


    self:initUILogic()
end

function PreHalloweenPopView:initUILogic()

    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN_GHOST)
    if not activityIds or not activityIds[1] then
        return
    end

    self.selectImg = {}
    local activityData = ActivityDataMgr2:getActivityInfo(activityIds[1])
    self.costItem = activityData.extendData.cost or {}
    for index,itemInfo in ipairs(self.costItem) do
        local itemId,num
        for k,v in pairs(itemInfo) do
            itemId,num = k,v
            break
        end
        print(itemId,num)
        if itemId and num then
            local item = self.Panel_giftItem:clone()
            self.UIListView_gift:pushBackCustomItem(item)
            local Image_item = TFDirector:getChildByPath(item,"Image_item")
            local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
            self.selectImg[index] = Image_select
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Pos(0, 0):AddTo(Image_item)
            PrefabDataMgr:setInfo(Panel_goodsItem, tonumber(itemId), num)
            Panel_goodsItem:setTouchEnabled(false)
            item:setTouchEnabled(true)
            item:onClick(function()
                self:selectGift(index)
            end)
        end
    end

end

function PreHalloweenPopView:selectGift(index)
    self.giftIndex = index
    for k,v in ipairs(self.selectImg) do
        v:setVisible(k == index)
    end
end


function PreHalloweenPopView:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_gift:onClick(function ()

        if not self.giftIndex then
            Utils:showTips(15010201)
            return
        end

        local itemInfo = self.costItem[self.giftIndex] or {}
        local itemId,num
        for k,v in pairs(itemInfo) do
            itemId,num = tonumber(k),v
            break
        end
        local isEnought = GoodsDataMgr:currencyIsEnough(itemId, num)
        if not isEnought then
            Utils:showAccess(itemId)
            return
        end

        print(self.ghostId,self.ghostPos-1,self.giftIndex)

        ActivityDataMgr2:Send_giveGift(self.ghostId,self.ghostPos,self.giftIndex)

        --local data = {}
        --table.insert(data,{id = 532101,num = 1})
        --table.insert(data,{id = 532101,num = 1})
        --table.insert(data,{id = 532101,num = 1})
        --table.insert(data,{id = 532101,num = 1})
        --
        --EventMgr:dispatchEvent(EV_PRE_HALLOWEEN_GIFT,data,self.giftIndex)

        AlertManager:closeLayer(self)
    end)
end



return PreHalloweenPopView