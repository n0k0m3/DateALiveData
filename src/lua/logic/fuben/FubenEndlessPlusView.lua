
local FubenEndlessPlusView = class("FubenEndlessPlusView", BaseLayer)

function FubenEndlessPlusView:initData()

    self.floorTab = {}
    self.levelData = {}

    self.floorItem_ = {}

    self.FloorDungeonLevelCfg = TabDataMgr:getData("FloorDungeonLevel")
end

function FubenEndlessPlusView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenEndlessPlusView")

    FubenEndlessPlusDataMgr:Send_GetAllInfo()
end

function FubenEndlessPlusView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local ScrollView_floor = TFDirector:getChildByPath(ui, "ScrollView_floor")
    self.TableView_floor = Utils:scrollView2TableView(ScrollView_floor)

    self.TableView_floor:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_floor:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_floor:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    local ScrollView_reward = TFDirector:getChildByPath(ui, "ScrollView_reward")
    self.UIListView_reward = UIListView:create(ScrollView_reward)
    self.Label_floor_desc = TFDirector:getChildByPath(ui, "Label_floor_desc")

    self.Panel_floor_item = TFDirector:getChildByPath(ui, "Panel_floor_item")
    self.Panel_level_item = TFDirector:getChildByPath(ui, "Panel_level_item")
    self.Panel_bossItem = TFDirector:getChildByPath(ui, "Panel_bossItem")
    self.Panel_rewardItem = TFDirector:getChildByPath(ui, "Panel_rewardItem")

    self.Button_store = TFDirector:getChildByPath(ui, "Button_store")
    self.Button_fight = TFDirector:getChildByPath(ui, "Button_fight")
    self.Button_task = TFDirector:getChildByPath(ui, "Button_task")

    self.Label_end_time = TFDirector:getChildByPath(ui, "Label_end_time")
end

function FubenEndlessPlusView:updateFloorInfo()

    local stage = FubenEndlessPlusDataMgr:getStage()
    stage = stage == 0 and 1 or stage

    local kvpCfg = FubenEndlessPlusDataMgr:getKvpCfg(stage)
    if not kvpCfg then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    if serverTime > kvpCfg.etime then
        self.Label_end_time:setTextById(1710021)
    else
        self.Label_end_time:setTextById(1410001, Utils:getDate(kvpCfg.etime))
    end


    self.floorItem_ = {}
    self.floorTab = {}
    local floorCfg = FubenEndlessPlusDataMgr:getFloorDungeonCfg()
    for k,v in pairs(floorCfg) do
        table.insert(self.floorTab,v)
    end
    table.sort(self.floorTab,function(a,b)
        return a.floor < b.floor
    end)
    self.TableView_floor:reloadData()

    local curFloorId = FubenEndlessPlusDataMgr:getCurFloorCid() or 0
    local nexFloorId = curFloorId + 1
    nexFloorId = nexFloorId >= #self.floorTab and #self.floorTab or nexFloorId
    self:selectFloor(nexFloorId)
    self:tableViewScrollToCell(nexFloorId)
end

function FubenEndlessPlusView:tableViewScrollToCell(idx,dt)
    dt = dt or 0
    local container = self.TableView_floor:getContainer()
    local containerSize = container:getSize()
    local viewSize = self.TableView_floor:getSize()
    local cellSize = self.Panel_floor_item:getSize()
    local offset = self.TableView_floor:getContentOffset()
    local minY = viewSize.height - containerSize.height
    local y = -cellSize.height * ( math.max(#self.floorTab - idx, 0)) + viewSize.height - cellSize.height
    y = math.max(minY, y)
    y = math.min(0, y)
    self.TableView_floor:setContentOffsetInDuration(ccp(offset.x, y),dt)
end

function FubenEndlessPlusView:cellSizeForTable()
    local size = self.Panel_floor_item:getSize()
    return size.height, size.width
end

function FubenEndlessPlusView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_floor_item:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateFloorItem(cell, idx)
    end

    return cell
end

function FubenEndlessPlusView:numberOfCellsInTableView()
    return #self.floorTab
end

function FubenEndlessPlusView:updateFloorItem(cell,index)

    local data = self.floorTab[index]
    if not data then
        return
    end

    local floorId = data.floor
    self.floorItem_[floorId] = cell
    local Label_name = TFDirector:getChildByPath(cell, "Label_name")
    Label_name:setTextById(data.name)


    local curFloorId = FubenEndlessPlusDataMgr:getCurFloorCid()
    local nextFloorId = curFloorId + 1
    nextFloorId = nextFloorId > #self.floorTab and #self.floorTab or nextFloorId

    local isUnlock = floorId <= curFloorId or nextFloorId == floorId
    ----通关时间
    local isPass = false
    local passTime = FubenEndlessPlusDataMgr:getPassRecordByFloor(floorId)
    if passTime then
        isPass = true
    end

    local Image_finish = TFDirector:getChildByPath(cell, "Image_finish")
    Image_finish:setVisible(isPass)

    local Image_lock = TFDirector:getChildByPath(cell, "Image_lock")
    Image_lock:setVisible(not isUnlock)

    local Image_select = TFDirector:getChildByPath(cell, "Image_select"):hide()
    Image_select:setVisible(floorId == nextFloorId)


    local Label_state_tip = TFDirector:getChildByPath(cell, "Label_state_tip")
    local Label_tip = TFDirector:getChildByPath(cell, "Label_tip")

    local color = nextFloorId == floorId and ccc3(25,66,122) or ccc3(255,255,255)
    Label_name:setColor(color)
    Label_state_tip:setColor(color)
    Label_tip:setColor(color)

    local quality = isUnlock and 255 or 125
    Label_name:setOpacity(quality)
    Label_state_tip:setOpacity(quality)
    Label_tip:setOpacity(quality)

    if isPass then
        Label_state_tip:setTextById(303039)
    else
        local str = nextFloorId == floorId and 15011151 or 15011150
        Label_state_tip:setTextById(str)
    end

    cell.item:onClick(function()
        --self:selectFloor(floorId)
    end)
end

function FubenEndlessPlusView:selectFloor(selectFloorCid)

    local curFloorId = FubenEndlessPlusDataMgr:getCurFloorCid()
    local isUnlock = selectFloorCid <= curFloorId or (curFloorId + 1) == selectFloorCid
    if not isUnlock then
        return
    end

    for k,v in ipairs(self.floorItem_) do
        local Image_select = TFDirector:getChildByPath(v, "Image_select")
        Image_select:setVisible(v.idx == selectFloorCid)
    end

    local data = self.floorTab[selectFloorCid] or {}
    self.levelData = data.dungeonId or {}

    self.Label_floor_desc:setTextById(data.describe)

    local isPass = false
    local passTime = FubenEndlessPlusDataMgr:getPassRecordByFloor(data.id)
    if passTime then
        isPass = true
    end

    self.UIListView_reward:removeAllItems()
    local reward = data.reward or {}
    for k,v in pairs(reward) do
        local item = self.Panel_rewardItem:clone()
        self.UIListView_reward:pushBackCustomItem(item)

        local Image_item = TFDirector:getChildByPath(item, "Image_item")
        local Image_geted = TFDirector:getChildByPath(item, "Image_geted"):hide()
        local Panel_goodsItem = Image_item:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setName("Panel_goodsItem")
            Panel_goodsItem:setScale(0.6)
            Image_item:addChild(Panel_goodsItem)
            Panel_goodsItem:setPosition(ccp(0,0))
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        Image_geted:setVisible(isPass)
    end

end

function FubenEndlessPlusView:updateLevelItem(cell, idx)

    local levelCid = self.levelData[idx]
    if not levelCid then
        return
    end

    local levelCfg =  self.FloorDungeonLevelCfg[levelCid]
    if not levelCfg then
        return
    end

    local Label_level_name = TFDirector:getChildByPath(cell, "Label_level_name")
    Label_level_name:setTextById(levelCfg.dungeonName)

    local ScrollView_monster = TFDirector:getChildByPath(cell, "ScrollView_monster")
    if not cell.bossListView then
        cell.bossListView = UIListView:create(ScrollView_monster)
    end

    cell.bossListView:removeAllItems()
    for k,v in ipairs(levelCfg.icon) do
        local bossItem = self.Panel_bossItem:clone()
        local image = TFDirector:getChildByPath(bossItem, "Image_boss")
        image:setTexture(v)
        cell.bossListView:pushBackCustomItem(bossItem)
    end

end

function FubenEndlessPlusView:jumpToPlusSquadView()

    local curFloorId = FubenEndlessPlusDataMgr:getCurFloorCid()
    local nextFloorId = curFloorId + 1
    nextFloorId = nextFloorId > #self.floorTab and #self.floorTab or nextFloorId
    local passTime = FubenEndlessPlusDataMgr:getPassRecordByFloor(nextFloorId)
    if passTime then
        Utils:showTips(15011148)
        return
    end


    Utils:openView("fuben.FubenEndlessPlusSquadView",nextFloorId)

end

function FubenEndlessPlusView:onQueryInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function FubenEndlessPlusView:registerEvents()

    -------全局事件-----
    EventMgr:addEventListener(self, EV_UPDATE_ENDLESSPLUS_ALLINFO, handler(self.updateFloorInfo, self))
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryInfoEvent, self))

    self.Button_store:onClick(function()
        FunctionDataMgr:jStore(403000)
        --Utils:openView("battle.EndlessPlusLevelResultView", 2310015)

        --local view = requireNew("lua.logic.battle.EndlessPlusCountdownView"):new(completeCallback)
        --AlertManager:addLayer(view, AlertManager.NONE)
        --AlertManager:show()
    end)

    self.Button_fight:onClick(function()
        self:jumpToPlusSquadView()
    end)

    self.Button_task:onClick(function()
        Utils:openView("fuben.FubenEndlessPlussTask")
    end) 
    
end

return FubenEndlessPlusView
