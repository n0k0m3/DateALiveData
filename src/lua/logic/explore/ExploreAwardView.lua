local ExploreAwardView = class("ExploreAwardView", BaseLayer)
function ExploreAwardView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.exploreAwardView")
end

function ExploreAwardView:initData()

end

function ExploreAwardView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")

    self.Panel_item = TFDirector:getChildByPath(self.Panel_root,"Panel_item")
    local ScrollView_drop = TFDirector:getChildByPath(self.Panel_root,"ScrollView_drop")

    self.GridView_items = UIGridView:create(ScrollView_drop)
    self.GridView_items:setItemModel(self.Panel_item)
    self.GridView_items:setColumn(8)

    self.Label_speed = TFDirector:getChildByPath(self.Panel_root,"Label_speed")
    self.Label_explore_time = TFDirector:getChildByPath(self.Panel_root,"Label_explore_time")

    self.Button_get = TFDirector:getChildByPath(self.Panel_root,"Button_get")
    self.Label_fulltip = TFDirector:getChildByPath(self.Panel_root,"Label_fulltip")

    self:updateInfo()
end


function ExploreAwardView:onShow()
    self.super.onShow(self)
    GameGuide:checkGuide(self)

end

function ExploreAwardView:updateInfo()
	self.bonusDropShow = {}

	local exExploreAward = ExploreDataMgr:getExploreExAward() or {}
	for i = 1, #exExploreAward do
		table.insert(self.bonusDropShow, {ItemInfo = exExploreAward[i], DropType = EC_DropShowType.ACTIVITY_EXTRA})
	end

    local exploreAward,cnt = ExploreDataMgr:getExploreAward()
    self.Label_fulltip:setVisible(cnt <= 0)
    self.Button_get:setVisible(cnt > 0)
    self.Label_explore_time:setText(cnt)

	exploreAward = exploreAward or {}
    for i = 1, #exploreAward do
		table.insert(self.bonusDropShow, {ItemInfo = exploreAward[i], DropType = 0})
	end

    table.sort(self.bonusDropShow,function(a,b)
        local cfgA = GoodsDataMgr:getItemCfg(a.ItemInfo.id)
        local cfgB = GoodsDataMgr:getItemCfg(b.ItemInfo.id)
        if cfgA and cfgB then
            if cfgA.quality == cfgB.quality then
                return a.ItemInfo.id < b.ItemInfo.id
            end
            return cfgA.quality > cfgB.quality
        else
            return false
        end
    end)

    --self.GridView_items:removeAllItems()

    self:showItem(1)

    local startTime,curAwardTimes,exploreSpeed = ExploreDataMgr:getCityExploreProgress()
    if not startTime or not curAwardTimes or not exploreSpeed  then
        return
    end

    local curCityId = ExploreDataMgr:getCurExploreCity()
    local cityCfg = ExploreDataMgr:getAfkCityCfg(curCityId)
    if not cityCfg then
        return
    end
    local perDistance = cityCfg.distance
    print(perDistance/exploreSpeed)
    local time = string.format("%0.2f",perDistance/exploreSpeed)
    self.Label_speed:setText(time.."min")

    --local act = CCSequence:create({
    --    CCCallFunc:create(function()
    --        local remainTime = math.max(0, ServerDataMgr:getServerTime() - startTime)
    --        local day, hour, min, sec = Utils:getDHMS(remainTime,true)
    --        self.Label_explore_time:setText(hour..":"..min..":"..sec)
    --    end),
    --    CCDelayTime:create(1)
    --})
    --self.Label_explore_time:runAction(CCRepeatForever:create(act))
end

function ExploreAwardView:showItem(index)

    local DropInfo = self.bonusDropShow[index]
    if not DropInfo then
        return
    end

    local item = self.GridView_items:getItem(index)
    if not item then
        item = self.GridView_items:pushBackDefaultItem()
    end

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
    Panel_goodsItem:setScale(0.8)
    Panel_goodsItem:setPosition(ccp(0,0))
    PrefabDataMgr:setInfo(Panel_goodsItem, {DropInfo.ItemInfo.id, DropInfo.ItemInfo.num}, DropInfo.DropType)
    item:addChild(Panel_goodsItem)

    local act = CCSequence:create({
        CCDelayTime:create(0.01),
        CCCallFunc:create(function()
            index = index + 1
            self:showItem(index)
        end)
    })
    item:runAction(act)
end


function ExploreAwardView:registerEvents()

    EventMgr:addEventListener(self, EV_FINISH_EXPLORE_DOT, handler(self.updateInfo, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_get:onClick(function ()
        ExploreDataMgr:Send_GetExploreReward(EC_AfkActivityID.Main)
        AlertManager:closeLayer(self)
    end)
end

return ExploreAwardView
