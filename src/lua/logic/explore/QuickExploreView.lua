local QuickExploreView = class("QuickExploreView", BaseLayer)
---1-多次触发事件,2-战斗事件,3-展示事件,4-奖励事件
local EC_eventType = {
    mulTrigger = 1,
    fight = 2,
    show = 3,
    award = 4
}

function QuickExploreView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.quickExploreView")
end

function QuickExploreView:initData()

    self.kvpData  = Utils:getKVP(90030)

end

function QuickExploreView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")
    self.Button_use = TFDirector:getChildByPath(self.Panel_root,"Button_use")
    self.Label_btn = TFDirector:getChildByPath(self.Button_use,"Label_btn")

    self.Label_freshTime = TFDirector:getChildByPath(self.Panel_root,"Label_freshTime")
    self.Label_leftcount = TFDirector:getChildByPath(self.Panel_root,"Label_leftcount")
    self.Image_cost = TFDirector:getChildByPath(self.Panel_root,"Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Image_cost,"Image_cost_icon")
    self.Label_cost = TFDirector:getChildByPath(self.Image_cost,"Label_cost")
    self.Label_tip = TFDirector:getChildByPath(self.Panel_root,"Label_tip")

    self:update()
end

function QuickExploreView:update()

    local usedCount = ExploreDataMgr:getQuickExploreTimes()
    local remainCount = #self.kvpData - usedCount < 0 and 0 or #self.kvpData - usedCount
    self.Label_leftcount:setTextById(270509,remainCount)

    local nextUseCount = usedCount + 1
    if nextUseCount > #self.kvpData then
        nextUseCount = #self.kvpData
    end
    local nextInfo = self.kvpData[nextUseCount]
    self.Label_tip:setTextById(13322004,nextInfo.awardTimes)
    self.Label_tip:setDimensions(450,0)

    local costId,costNum
    for k,v in pairs(nextInfo.cost) do
        costId,costNum = k,v
        break
    end
    if not costId then
        self.Image_cost:hide()
        self.Label_btn:setTextById(2106010)
    else
        self.Image_cost:show()
        local itemCfg = GoodsDataMgr:getItemCfg(costId)
        self.Image_cost_icon:setTexture(itemCfg.icon)
        self.Label_cost:setText(costNum)
        self.Label_btn:setTextById(3005052)
    end

    self.Label_freshTime:stopAllActions()
    local act = CCSequence:create({
        CCCallFunc:create(function()
            self:setFreshTime()
        end),
        CCDelayTime:create(1)
    })
    self.Label_freshTime:runAction(CCRepeatForever:create(act))
end

function QuickExploreView:setFreshTime()
    local serverTime = ServerDataMgr:getServerTime()
    local hour, min, sec = Utils:getTime(serverTime)
    local passTime = hour*60*60 + min*60 + sec
    local remainTime = 0
    if hour < 6 then
        remainTime = 6*60*60 - passTime
    else
        remainTime = 24*60*60 + 6*60*60 - passTime
    end
    local day,hour, min, sec = Utils:getDHMS(remainTime, true)
    self.Label_freshTime:setTextById(13322005,hour..":"..min..":"..sec)
end

function QuickExploreView:registerEvents()

    EventMgr:addEventListener(self, EC_EXPLORE_QUICK, handler(self.update, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_use:onClick(function()
        ExploreDataMgr:Send_QuickExplore(EC_AfkActivityID.Main)
    end)
end

return QuickExploreView
