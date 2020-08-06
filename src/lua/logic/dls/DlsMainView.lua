local EC_Dir = {
    LEFT = 1,
    RIGHT = 2,
}

local EC_Animation = {
    STAND = "stand",
    MOVE = "move",
}

local Actor = class("Actor", function()
    local node = CCNode:create()
    return node
end)

function Actor:ctor(hero)
    self.hero_ = hero
    self.hero_:setPosition(ccp(0, 0))
    self:addChild(self.hero_)
end

function Actor:setDir(dir)
    if dir == EC_Dir.LEFT then
        self:setScaleX(1)
    elseif dir == EC_Dir.RIGHT then
        self:setScaleX(-1)
    end
    self.dir_ = dir
end

function Actor:playAni(action, loop)
    loop = tobool(loop)
    self.hero_:play(action, loop)
    self.animation = action
end

function Actor:playStand()
    if self.animation ~= EC_Animation.STAND then
        self:playAni(EC_Animation.STAND, true)
    end
end

function Actor:playMove()
    if self.animation ~= EC_Animation.MOVE then
        self:playAni(EC_Animation.MOVE, true)
    end
end

--------------------------------------------------------------------------------

local DlsMainView = class("DlsMainView", BaseLayer)

function DlsMainView:initData()
    self.level_ = DlsDataMgr:getDungen()
    self.initSite_ = DlsDataMgr:getBeginSite()
    self.curSite_ = DlsDataMgr:getCurSite()
    self.isAutoPopup_ = true
    self.isMove_ = false
    self.levelItems_ = {}

    local summons = SummonDataMgr:getDlsSummon()
    if summons[1] and summons[1][1] then
        local summon = summons[1][1]
        local summonCfg = SummonDataMgr:getSummonCfg(summon.id)
        self.costItemCid_, self.costItemCount_ = next(summonCfg.cost[1])
    else
        Box("召唤活动未开启")
    end

    -- 第一次进入大凉山触发约会
    if DlsDataMgr:isFirstEnter() then
        DlsDataMgr:setFirstEnter(false)
        DatingDataMgr:startDating(9101006)
    end
end

function DlsMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dls.dlsMainView")
end

function DlsMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Spine_heroItem = TFDirector:getChildByPath(self.Panel_prefab, "Spine_heroItem")
    self.Panel_mainLineItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_mainLineItem")
    self.Panel_branchLineItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_branchLineItem")
    self.Button_startSiteItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_startSiteItem")
    self.Label_debugSiteItem = TFDirector:getChildByPath(self.Panel_prefab, "Label_debugSiteItem")

    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Label_store = TFDirector:getChildByPath(self.Button_store, "Label_store")
    self.Button_welfare = TFDirector:getChildByPath(self.Panel_root, "Button_welfare")
    self.Label_welfare = TFDirector:getChildByPath(self.Button_welfare, "Label_welfare")
    self.Image_welfareTip = TFDirector:getChildByPath(self.Button_welfare, "Image_welfareTip")
    self.Button_treasure = TFDirector:getChildByPath(self.Panel_root, "Button_treasure")
    self.Label_treasure = TFDirector:getChildByPath(self.Button_treasure, "Label_treasure")
    self.Image_treasureTip = TFDirector:getChildByPath(self.Button_treasure, "Image_treasureTip")
    self.Label_open_time = TFDirector:getChildByPath(self.Panel_root, "Image_dls.Label_open_time")

    self.ScrollView_map = TFDirector:getChildByPath(self.Panel_root, "ScrollView_map")
    self.ScrollView_map:setContentSize(GameConfig.WS)

    local Image_autopop_toggle = TFDirector:getChildByPath(self.Panel_root, "Image_autopop_toggle")
    self.Image_autopop_on = TFDirector:getChildByPath(Image_autopop_toggle, "Image_autopop_on")
    self.Image_autopop_off = TFDirector:getChildByPath(Image_autopop_toggle, "Image_autopop_off")
    self.Label_autopop_on = TFDirector:getChildByPath(Image_autopop_toggle, "Label_autopop_on")
    self.Label_autopop_off = TFDirector:getChildByPath(Image_autopop_toggle, "Label_autopop_off")
    self.Panel_autopop_touch = TFDirector:getChildByPath(Image_autopop_toggle, "Panel_autopop_touch")
    self.Label_autopop_desc = TFDirector:getChildByPath(Image_autopop_toggle, "Label_autopop_desc")

    self:refreshView()
end

function DlsMainView:loadMap()
    local mapName = "dls_map_1"
    local moduleName = string.format("lua.uiconfig.dls.%s", mapName)
    local map = createUIByLuaNew(moduleName)

    local size = map:Size()
    self.ScrollView_map:setInnerContainerSize(size)
    map:setPosition(ccp(0, size.height * 0.5))
    self.ScrollView_map:addChild(map)

    -- 点位
    self.Panel_site = {}
    self.sitePosition_ = {}
    local Panel_site = TFDirector:getChildByPath(map, "Panel_site")
    local site = 1
    while true do
        local foo = TFDirector:getChildByPath(Panel_site, "Panel_site_" .. site)
        if foo then
            foo:setBackGroundColorType(0)
            self.sitePosition_[site] = foo:getPosition()
            self.Panel_site[site] = foo
            site = site + 1
        else
            break
        end
    end

    -- 人物层
    self.Panel_actor = TFDirector:getChildByPath(map, "Panel_actor")

    -- 关卡层
    self.Panel_level = TFDirector:getChildByPath(map, "Panel_level")
    self.Button_startSite = self.Button_startSiteItem:clone()
    self.Button_startSite:Pos(self.sitePosition_[self.initSite_]):AddTo(self.Panel_level)
    for site, cid in pairs(self.level_) do
        local position = self.sitePosition_[site]
        if position then
            local cfg = DlsDataMgr:getDungenCfg(cid)
            if cfg.dungentype == EC_DlsLevelType.MAIN then
                self.levelItems_[site] = self:addMainLineItem()
            elseif cfg.dungentype == EC_DlsLevelType.BRANCH then
                self.levelItems_[site] = self:addBranchLineItem()
            elseif cfg.dungentype == EC_DlsLevelType.EVENT then

            end
            self:updateLevelItem(site)
            self.levelItems_[site].root:Pos(position):AddTo(self.Panel_level)
        end
    end
    self:scrollMapToSite(self.curSite_)
end

function DlsMainView:scrollMapToSite(site)
    local innerContainer = self.ScrollView_map:getInnerContainer()

    local anchorPoint = self.ScrollView_map:getAnchorPoint()
    local innerSize = innerContainer:getSize()
    local contentSize = self.ScrollView_map:getSize()
    local center = ccp(-contentSize.width * 0.5, -contentSize.height * 0.5)
    local innerPos = innerContainer:getPosition()
    local minY = contentSize.height - innerSize.height
    local h = -minY
    local w = contentSize.width - innerSize.width

    local position = self.sitePosition_[site]
    local wp = self.Panel_site[site]:getParent():convertToWorldSpaceAR(position)
    local np = self.ScrollView_map:convertToNodeSpaceAR(wp)
    local foo = ccpSub(innerPos, wp)
    local dis = ccpSub(foo, center)
    dis.x = clampf(dis.x, 0, w)
    if w ~= 0 then
        local percentX = -dis.x * 100 / w
        local percentY = (dis.y - minY) * 100 / h
        local time = math.abs(dis.x) / 2000
        -- self.ScrollView_map:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, time, true, percentX, percentY)
        self.ScrollView_map:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, percentX, 0)
    end
end

function DlsMainView:addMainLineItem()
    local Panel_mainLineItem = self.Panel_mainLineItem:clone()
    local foo = {}
    foo.root = Panel_mainLineItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Button_lock = TFDirector:getChildByPath(foo.root, "Button_lock")
    foo.Button_unlock = TFDirector:getChildByPath(foo.root, "Button_unlock")
    foo.Button_pass = TFDirector:getChildByPath(foo.root, "Button_pass")
    foo.Label_debug_site = TFDirector:getChildByPath(foo.root, "Label_debug_site"):hide()
    return foo
end

function DlsMainView:addBranchLineItem()
    local Panel_branchLineItem = self.Panel_branchLineItem:clone()
    local foo = {}
    foo.root = Panel_branchLineItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Button_lock = TFDirector:getChildByPath(foo.root, "Button_lock")
    foo.Button_unlock = TFDirector:getChildByPath(foo.root, "Button_unlock")
    foo.Button_pass = TFDirector:getChildByPath(foo.root, "Button_pass")
    foo.Label_debug_site = TFDirector:getChildByPath(foo.root, "Label_debug_site"):hide()
    return foo
end

function DlsMainView:moveToSite(site)
    if self.lastToSite_ ~= site then
        self:move(self.curSite_, site)
    end
end

function DlsMainView:updateMainLineItem(site)
    local levelCid = self.level_[site]
    local foo = self.levelItems_[site]

    local enabled = DlsDataMgr:checkLevelEnabeld(levelCid)
    foo.Button_lock:setVisible(not enabled)
    foo.Button_unlock:setVisible(enabled)
    local isComplete = DlsDataMgr:isCompleteAllEvent(levelCid)
    foo.Button_pass:setVisible(isComplete)
    foo.Label_debug_site:setText(site)
    if isComplete then
        foo.Button_unlock:hide()
    end

    foo.Button_unlock:onClick(function()
            if DlsDataMgr:isOpenTime() then
                if self.curSite_ == site then
                    self:doReady(true)
                else
                    self:moveToSite(site)
                end
            else
                Utils:showTips(1890001)
            end
    end)

    foo.Button_pass:onClick(function()
            if DlsDataMgr:isOpenTime() then
                if self.curSite_ == site then
                    self:doReady(true)
                else
                    self:moveToSite(site)
                end
            else
                Utils:showTips(1890001)
            end
    end)

    foo.Button_lock:onClick(function()
            if DlsDataMgr:isOpenTime() then
                Utils:showTips(2101700)
            else
                Utils:showTips(1890001)
            end
    end)
end

function DlsMainView:updateBranchLineItem(site)
    self:updateMainLineItem(site)
end

function DlsMainView:updateLevelItem(site)
    local cid = self.level_[site]
    local cfg = DlsDataMgr:getDungenCfg(cid)
    if cfg.dungentype == EC_DlsLevelType.MAIN then
        self:updateMainLineItem(site)
    elseif cfg.dungentype == EC_DlsLevelType.BRANCH then
        self:updateBranchLineItem(site)
    elseif cfg.dungentype == EC_DlsLevelType.EVENT then
    end
end

function DlsMainView:createActor()
    local Spine_heroItem = self.Spine_heroItem:clone()
    self.actor_ = Actor:new(Spine_heroItem)
    self.Panel_actor:addChild(self.actor_)
    self:stand(self.curSite_)
end

function DlsMainView:stand(site)
    self.actor_:playStand()
    local position = self.sitePosition_[site]
    self.actor_:setPosition(position)
    self.actor_:setDir(EC_Dir.RIGHT)
end

function DlsMainView:move(fromSite, toSite)
    self.lastToSite_ = toSite
    local pathList = DlsDataMgr:getPathList(fromSite, toSite)
    if self.isMove_ then
        local index = table.indexOf(pathList, self.lastPathList_[1])
        if index ~= -1 then
            for i = 1, index - 1 do
                table.remove(pathList, 1)
            end
        end
    else
        local fromPosition = self.sitePosition_[fromSite]
        self.actor_:setPosition(fromPosition)
        table.remove(pathList, 1)
    end
    self.lastPathList_ = pathList

    if next(pathList) then
        self.actor_:playMove()
        local site = pathList[1]

        local toPosition = self.sitePosition_[site]
        local curPosition = self.actor_:getPosition()
        if toPosition.x > curPosition.x then
            self.actor_:setDir(EC_Dir.RIGHT)
        else
            self.actor_:setDir(EC_Dir.LEFT)
        end
        local distance = ccpDistance(curPosition, toPosition)
        local duration = distance / 400
        local action = Sequence:create({
                MoveTo:create(duration, toPosition),
                CallFunc:create(function()
                        self.isMove_ = false
                        self.curSite_ = site
                        self.actor_:setPosition(toPosition)
                        self:move(self.curSite_, toSite)
                end)
        })
        self.isMove_ = true
        self.actor_:stopAllActions()
        self.actor_:runAction(action)
    else
        self:doReady(self.isAutoPopup_)
        self.actor_:playStand()
    end
end

function DlsMainView:doReady(isPopup)
    if self.isMove_ then return end

    for site, v in pairs(self.levelItems_) do
        local levelCfg = DlsDataMgr:getDungenCfg(self.level_[site])
        if levelCfg.dungentype == EC_DlsLevelType.MAIN or levelCfg.dungentype == EC_DlsLevelType.BRANCH then
            v.Image_select:setVisible(site == self.curSite_)
        end
    end

    if self.curSite_ ~= self.initSite_ and isPopup then
        local cid = self.level_[self.curSite_]
        Utils:openView("dls.DlsReadyView", cid)
    end
end

function DlsMainView:refreshView()
    self.Label_open_time:setTextById(2101001)
    self.Label_store:setTextById(2101002)
    self.Label_welfare:setTextById(2101003)
    self.Label_treasure:setTextById(2101004)
    self.Label_autopop_on:setTextById(2101402)
    self.Label_autopop_off:setTextById(2101403)
    self.Label_autopop_desc:setTextById(2101404)

    self:loadMap()
    self:createActor()
    self:updateToggleState()
    self:updateWelfareTip()
    self:updateTreasureTip()
end

function DlsMainView:updateWelfareTip()
    local taskType = {EC_TaskType.DLS, EC_TaskType.DLS_CARD}
    local isShowTip = false
    for i, v in ipairs(taskType)  do
        if TaskDataMgr:isCanReceiveTask(v) then
            isShowTip = true
            break
        end
    end
    self.Image_welfareTip:setVisible(isShowTip)
end

function DlsMainView:updateTreasureTip()
    if self.costItemCid_ and self.costItemCount_ then
        local count = GoodsDataMgr:getItemCount(self.costItemCid_)
        local isShowTip = count >= self.costItemCount_
        self.Image_treasureTip:setVisible(isShowTip)
    end
end

function DlsMainView:updateToggleState()
    self.Image_autopop_on:setVisible(self.isAutoPopup_)
    self.Image_autopop_off:setVisible(not self.isAutoPopup_)
end

function DlsMainView:registerEvents()
    EventMgr:addEventListener(self, EV_DLS_TASK_COMPLETE, handler(self.onTaskCompleteEvent, self))
    EventMgr:addEventListener(self, EV_DLS_EVENT_COMPLETE, handler(self.onEventCompleteEvent, self))
    EventMgr:addEventListener(self, EV_DLS_LEVEL_UNLOCK, handler(self.onLevelUnlockEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))


    self.Button_store:onClick(function()
            FunctionDataMgr:jDlsStore()
    end)

    self.Button_welfare:onClick(function()
            Utils:openView("dls.DlsWelfareView")
    end)

    self.Button_treasure:onClick(function()
            if self.costItemCid_ and self.costItemCount_ then
                Utils:openView("dls.DlsTreasureHouseView")
            else
                Utils:showTips(TextDataMgr:getText(112000194))
            end
    end)

    self.Button_startSite:onClick(function()
            self:moveToSite(self.initSite_)
    end)

    self.Panel_autopop_touch:onClick(function()
            self.isAutoPopup_ = not self.isAutoPopup_
            self:updateToggleState()
    end)
end

function DlsMainView:updateAllLevelItem()
    for site, v in pairs(self.levelItems_) do
        self:updateLevelItem(site)
    end
end

function DlsMainView:onTaskCompleteEvent()
    self:updateAllLevelItem()
end

function DlsMainView:onEventCompleteEvent()
    self:updateAllLevelItem()
end

function DlsMainView:onLevelUnlockEvent()
    self:updateAllLevelItem()
end

function DlsMainView:onTaskReceiveEvent()
    self:updateWelfareTip()
end

function DlsMainView:onItemUpdateEvent()
    self:updateTreasureTip()
end

return DlsMainView
