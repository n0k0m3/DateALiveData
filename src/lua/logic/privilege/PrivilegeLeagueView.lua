local PrivilegeLeagueView = class("PrivilegeLeagueView", BaseLayer)

function PrivilegeLeagueView:initData()

    self.mapPrivilege = {}
    self.costItem_ = {}
    self.costItemData = {}
    self.selectNum = 1
    self.kvpCfg = Utils:getKVP(11006)

    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.PRIVILEGE_ACTIVITY_DATA)
    if activityIds and activityIds[1] then
        self.activityId = activityIds[1]
    end
end

function PrivilegeLeagueView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.privilege.privilegeLeagueView")
end

function PrivilegeLeagueView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root, "Button_help")

    self.Label_tip = TFDirector:getChildByPath(self.Panel_root, "Label_tip")
    self.Label_gain_exp = TFDirector:getChildByPath(self.Panel_root, "Label_gain_exp")
    self.Label_upExp_tip = TFDirector:getChildByPath(self.Panel_root, "Label_upExp_tip")

    self.Spine_level_up_tip = TFDirector:getChildByPath(self.Panel_root, "Spine_level_up_tip"):hide()

    self.Label_bar = TFDirector:getChildByPath(self.Panel_root, "Label_bar")
    self.Label_bar_exp = TFDirector:getChildByPath(self.Panel_root, "Label_bar_exp")
    self.bar = TFDirector:getChildByPath(self.Panel_root, "bar")
    self.prebar = TFDirector:getChildByPath(self.Panel_root, "prebar")

    local ScrollView_privilege = TFDirector:getChildByPath(self.Panel_root, "ScrollView_privilege")
    self.TableView_priviledge = Utils:scrollView2TableView(ScrollView_privilege)
    Public:bindScrollFun(self.TableView_priviledge)
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_priviledge:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    local ScrollView_costItem = TFDirector:getChildByPath(self.Panel_root, "ScrollView_costItem")
    self.UIListView_costItem = UIListView:create(ScrollView_costItem)
    self.UIListView_costItem:setItemsMargin(60)

    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up")
    self.Button_down = TFDirector:getChildByPath(self.Panel_root, "Button_down")
    self.Label_num = TFDirector:getChildByPath(self.Panel_root, "Label_num")
    self.Button_max = TFDirector:getChildByPath(self.Panel_root, "Button_max")
    self.Button_use = TFDirector:getChildByPath(self.Panel_root, "Button_use")

    self.Panel_privilege = TFDirector:getChildByPath(self.Panel_root, "Panel_privilege")
    self.Panel_buji = TFDirector:getChildByPath(self.Panel_root, "Panel_buji")
    local ScrollView_tip = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tip")
    self.UIListView_tip = UIListView:create(ScrollView_tip)
    self.Label_refresh_time = TFDirector:getChildByPath(self.Panel_root, "Label_refresh_time")
    self.Label_refresh_tip = TFDirector:getChildByPath(self.Panel_root, "Label_refresh_tip")
    self.Label_buji_cnt = TFDirector:getChildByPath(self.Panel_root, "Label_buji_cnt")
    self.Label_buji_tip = TFDirector:getChildByPath(self.Panel_root, "Label_buji_tip")
    self.Label_buji_tip:setTextById(13202005)

    self.btnType = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Button_type"..i)
        local select = TFDirector:getChildByPath(btn, "select")
        local Label_btn = TFDirector:getChildByPath(btn, "Label_btn")
        table.insert(self.btnType,{btn = btn, select = select, Label_btn = Label_btn})
    end

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_privilegeItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_privilegeItem")
    self.Panel_costItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_costItem")
    self.Label_tip_item = TFDirector:getChildByPath(self.Panel_prefab, "Label_tip_item")

    self:initUILogic()
end

function PrivilegeLeagueView:onHide()
    self:stopTimer()
    self.super.onHide(self)
end

function PrivilegeLeagueView:onClose()
    self:stopTimer()
    self.super.onClose(self)
end

function PrivilegeLeagueView:initUILogic()

    local tipItem = self.Label_tip_item:clone()
    tipItem:setTextById(13202004)
    tipItem:setDimensions(260, 0)
    self.UIListView_tip:pushBackCustomItem(tipItem)
    self.endTtime = ServerDataMgr:getServerTime() + 100
    self:chooseFun(1)
end

function PrivilegeLeagueView:updateBar(addExp,isAnim)

    local curCid,exp = PrivilegeDataMgr:getCurClubWishTreeInfo()
    if not curCid or not exp then
        return
    end

    local curLv = 0
    if curCid ~= 0 then
        local curCfg = PrivilegeDataMgr:getClubWishTreeCfg(curCid)
        if curCfg then
            curLv = curCfg.level
        end
    end

    exp = exp + (addExp or 0)

    local nextLv = curLv + 1
    local nextCfg = PrivilegeDataMgr:getClubWishTreeByLv(nextLv)
    if not nextCfg then
        self.Label_bar:setText("Lv.max")
        self.bar:setPercent(100)
        return
    end

    local needExp = nextCfg.exp
    self.Label_bar_exp:setText(exp.."/"..needExp)
    if not isAnim then
        self.bar:setPercent(math.floor(exp/needExp*100))
        self.prebar:setPercent(math.floor(exp/needExp*100))
        self.Label_bar:setText("Lv."..curLv)
    else
        local totalExp = exp
        for i=1,curLv do
            local cfg = PrivilegeDataMgr:getClubWishTreeByLv(i)
            if cfg then
                totalExp = totalExp + cfg.exp
            end
        end

        local preLv = 0
        local allExp = 0
        local membershipCfg = PrivilegeDataMgr:getClubWishTreeCfg()
        for k,v in ipairs(membershipCfg) do
            allExp = allExp + v.exp
            if totalExp >= allExp then
                preLv = v.level
            end
        end
        self.Label_bar:setText("Lv."..preLv)

        print(math.floor(exp/needExp*100))
        Utils:loadingBarChangeActionInTime(self.prebar,math.floor(exp/needExp*100),0.5)
    end



end

function PrivilegeLeagueView:cellSizeForTable()
    local size = self.Panel_privilegeItem:getSize()
    return size.height, size.width
end

function PrivilegeLeagueView:numberOfCellsInTableView()
    return #self.mapPrivilege
end

function PrivilegeLeagueView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_privilegeItem:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updatePrivilegeItem(cell.item, self.mapPrivilege[idx])
    end

    return cell
end

function PrivilegeLeagueView:updatePrivilegeItem(item,data)

    local privilegeId = data.privilegeId
    local privilegeCfg = PrivilegeDataMgr:getPrivilegeCfg(privilegeId)
    if not privilegeCfg then
        return
    end

    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    Label_name:setTextById(15010161,data.level)

    local Label_info = TFDirector:getChildByPath(item, "Label_info")
    Label_info:setTextById(privilegeCfg.describe)
    Label_info:setDimensions(500,0)

    local curCid,exp = PrivilegeDataMgr:getCurClubWishTreeInfo()
    local isUnlock = data.id <= curCid
    --local color = data.id <= curCid and  me.RED or me.WHITE
    --Label_info:setColor(color)

    local Image_cell = TFDirector:getChildByPath(item, "Image_cell")
    Image_cell:setVisible(isUnlock)
    local Image_cell_bg = TFDirector:getChildByPath(item, "Image_cell_bg")
    Image_cell_bg:setVisible(not isUnlock)
end

function PrivilegeLeagueView:updateCost()

    self.costItemData = {}
    for k,v in ipairs(self.kvpCfg.cost) do
        for costId,costNum in pairs(v) do
            table.insert(self.costItemData,{id = costId,perCostNum = costNum})
            break
        end
    end
    local items = self.UIListView_costItem:getItems()
    local gap = #self.costItemData - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local item = self:addCostItem(i)
            self.UIListView_costItem:pushBackCustomItem(item)
        end
    else
        for i = 1, math.abs(gap) do
            self.UIListView_costItem:removeItem(1)
            table.remove(self.costItem_,1)
        end
    end

    Utils:setAliginCenterByListView(self.UIListView_costItem, true)

    local items = self.UIListView_costItem:getItems()
    for i, v in ipairs(items) do
        self:updateCostItem(i)
        if not self.chooseCostIndex then
            self.chooseCostIndex = 1
        end
    end

    local addedCnt = PrivilegeDataMgr:getAddedCnt()
    local maxCnt = self.kvpCfg.max
    local cnt = math.max(0,maxCnt-addedCnt)
    self.Label_tip:setTextById(15010113 ,cnt)

    self:chooseCostItem(self.chooseCostIndex)
end

function PrivilegeLeagueView:addCostItem(index)

    local Panel_costItem = self.Panel_costItem:clone()
    local foo = {}
    foo.root = Panel_costItem
    foo.Image_item = TFDirector:getChildByPath(foo.root, "Image_item")
    foo.Label_owncnt = TFDirector:getChildByPath(foo.root, "Label_owncnt")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    foo.Panel_goodsItem:Scale(0.75)
    foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.Image_item)
    foo.Panel_touchItem = TFDirector:getChildByPath(foo.root, "Panel_touchItem")
    self.costItem_[index] = foo

    return Panel_costItem
end

function PrivilegeLeagueView:updateCostItem(i,costNum)

    local foo = self.costItem_[i]
    if not foo then
        return
    end

    local data = self.costItemData[i]
    if not data then
        return
    end

    PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.id)

    self:updateCostNum(i,data.id,costNum)

    foo.Panel_touchItem:onClick(function()
        if i == self.chooseCostIndex then
            return
        end
        self:chooseCostItem(i)
        self:resetNum()
    end)
end

function PrivilegeLeagueView:updateCostNum(i,itemId,num)

    local foo = self.costItem_[i]
    if not foo then
        return
    end

    local ownCnt = GoodsDataMgr:getItemCount(itemId)
    num = num or 0
    foo.Label_owncnt:setText(ownCnt.."/"..num)

end

function PrivilegeLeagueView:resetNum()
    self.selectNum = 0
    self:updateNum(0)
end

function PrivilegeLeagueView:chooseCostItem(i)

    if self.chooseCostIndex then
        self.costItem_[self.chooseCostIndex].Image_select:hide()
    end

    self.chooseCostIndex = i
    self.costItem_[self.chooseCostIndex].Image_select:show()

    local costItemData = self.costItemData[self.chooseCostIndex]
    if costItemData then
        self.perCostNum = costItemData.perCostNum
    end

end

function PrivilegeLeagueView:onTouchButtonDown()

    --self:updateNum(-(self.perCostNum or 0),true)
    self:updateNum(-1,true)
end

function PrivilegeLeagueView:onTouchButtonUp()
    --self:updateNum(self.perCostNum or 0,true)
    self:updateNum(1,true)
end

function PrivilegeLeagueView:updateNum(num,isAnim)

    local costItemData = self.costItemData[self.chooseCostIndex]
    if not costItemData then
        return
    end

    self.selectNum = self.selectNum + num
    local addedCnt = PrivilegeDataMgr:getAddedCnt()
    local leftAddMaxNum = math.max(0,self.kvpCfg.max - addedCnt)
    local ownCnt = GoodsDataMgr:getItemCount(costItemData.id)
    local mayCnt = math.floor(ownCnt/costItemData.perCostNum)
    local maxCnt = math.min(mayCnt,leftAddMaxNum)

    if num > 0 then
        self.selectNum = math.min(self.selectNum, maxCnt)
    elseif num < 0 then
        self.selectNum = math.max(self.selectNum, 0)
    end

    local addExp = self.kvpCfg.exp[self.chooseCostIndex] or 0
    addExp = addExp * self.selectNum --* costItemData.perCostNum

    ---没有可提升经验值时，不展示经验增长的预览
    local expLimit = PrivilegeDataMgr:getExpLimit()
    if expLimit <= 0 then
        addExp = 0
    end

    self:updateBar(addExp,isAnim)
    self.Label_gain_exp:setTextById(15010114,addExp)

    self.Label_num:setText(self.selectNum);

    self.Button_up:setGrayEnabled(self.selectNum >= maxCnt)
    self.Button_up:setTouchEnabled(self.selectNum < maxCnt)
    self.Button_down:setGrayEnabled(self.selectNum<= 0)
    self.Button_down:setTouchEnabled(self.selectNum > 0)

    self.Button_max:setGrayEnabled(self.selectNum >= maxCnt)
    self.Button_max:setTouchEnabled(self.selectNum < maxCnt)

    self:updateCostNum(self.chooseCostIndex,costItemData.id,self.selectNum*costItemData.perCostNum)

    if self.selectNum <= 0 or self.selectNum >= maxCnt then
        self:stopTimer()
        return
    end
end

function PrivilegeLeagueView:updateMaxNum()

    local costItemData = self.costItemData[self.chooseCostIndex]
    if not costItemData then
        return
    end

    local addedCnt = PrivilegeDataMgr:getAddedCnt()
    local leftAddMaxNum = (self.kvpCfg.max - addedCnt)*costItemData.perCostNum
    local ownCnt = GoodsDataMgr:getItemCount(costItemData.id)
    local maxCnt = math.min(ownCnt,leftAddMaxNum)
    self.selectNum = 0
    self:updateNum(maxCnt,true)

end

function PrivilegeLeagueView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function PrivilegeLeagueView:stopTimer()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil;
    end
end

function PrivilegeLeagueView:updateInfo()

    local curCid,exp = PrivilegeDataMgr:getCurClubWishTreeInfo()
    if self.oldCurCid < curCid then
        self.oldCurCid = curCid
        self:playEffect()
    end

    local expLimit = PrivilegeDataMgr:getExpLimit()
    self.Label_upExp_tip:setTextById(15010112,expLimit)
    self.TableView_priviledge:reloadData()
    self:updateCost()
    self:resetNum()
end

function PrivilegeLeagueView:chooseFun(typeIndex)

    self.typeIndex = typeIndex
    for k,v in ipairs(self.btnType) do
        v.select:setVisible(typeIndex == k)
        local color = typeIndex == k and ccc3(109,120,198) or ccc3(155,198,242)
        v.Label_btn:setColor(color)
    end

    self.Panel_privilege:setVisible(typeIndex == 1)
    self.Panel_buji:setVisible(typeIndex == 2)

    if typeIndex == 1 then
        local curCid,exp = PrivilegeDataMgr:getCurClubWishTreeInfo()
        self.oldCurCid = curCid
        self.mapPrivilege = PrivilegeDataMgr:getClubWishTreeCfg() or {}
        PrivilegeDataMgr:Send_GetClubWishTree()
    elseif typeIndex == 2 then
        self:updateKongTouTime()
        WorldRoomDataMgr:Send_GetTouFang()
    end

end

function PrivilegeLeagueView:updateKongTouData(data)
    local areaShowData = data.areaShowData
    if not areaShowData then
        return
    end

    local cnt = 0
    local relevantData = WorldRoomDataMgr:getRelevantData()
    for k,v in ipairs(relevantData.giftInfo or {}) do
        if v.type == areaShowData.type then
            cnt = v.count
            break
        end
    end

    self.Label_buji_cnt:setText(cnt.."/"..areaShowData.total)

end

function PrivilegeLeagueView:updateKongTouTime()

    local control = WorldRoomDataMgr:getCurExtDataControl()
    if not control then
        return
    end

    self.Label_refresh_time:stopAllActions()
    local showTimeData = control.showTimeInfo
    if not showTimeData then
        self.Label_refresh_tip:setTextById(13202009)
        self.Label_refresh_time:setText("")
        return
    end


    local curTime = ServerDataMgr:getServerTime()
    if curTime >= showTimeData.stime and  curTime < showTimeData.etime then
        self.Label_refresh_tip:setTextById(13202003)
        self.Label_refresh_time:setText("")
    elseif curTime < showTimeData.stime then
        self.Label_refresh_tip:setTextById(13202001)
        local act = CCSequence:create({
            CCCallFunc:create(function()
                local remainTime = math.max(0, showTimeData.stime - ServerDataMgr:getServerTime())
                local day, hour, min,sec = Utils:getDHMS(remainTime, true)
                self.Label_refresh_time:setText(hour..":"..min..":"..sec)
            end),
            CCDelayTime:create(1)
        })
        self.Label_refresh_time:runAction(CCRepeatForever:create(act))
    elseif curTime >= showTimeData.etime then
        self.Label_refresh_tip:setTextById(13202009)
        self.Label_refresh_time:setText("")
    end
end

function PrivilegeLeagueView:playEffect()

    Utils:playSound(1002)
    self.Spine_level_up_tip:show()
    self.Spine_level_up_tip:play("chuxian",false)
    self.Spine_level_up_tip:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_level_up_tip:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_level_up_tip:play("xunhuan",true)
            self:timeOut(function()
                self.Spine_level_up_tip:hide()
            end, 1)
        end, 0)
    end)
end

function PrivilegeLeagueView:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_CLUB_WISHTREE_LV, handler(self.updateInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateCost, self))
    EventMgr:addEventListener(self, EV_WORLD_AREA_DATA, handler(self.updateKongTouData, self))
    EventMgr:addEventListener(self, EV_WORLD_AREA_TIME, handler(self.updateKongTouTime, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId and self.activityId == activityId then
            Utils:showTips(14110403)
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {3110})
    end)

    self.Button_up:onTouch(function(event)
        if event.name == "began" then
            self:holdDownAction(true)
            self:onTouchButtonUp()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)

    self.Button_down:onTouch(function(event)
        if event.name == "began" then
            self:holdDownAction(false)
            self:onTouchButtonDown()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)

    self.Button_max:onClick(function()
        self:updateMaxNum()
    end)

    self.Button_use:onClick(function()
        local costItemData = self.costItemData[self.chooseCostIndex]
        if not costItemData then
            return
        end
   
        if self.selectNum <= 0 then
            return
        end

        local expLimit = PrivilegeDataMgr:getExpLimit()
        if expLimit > 0 then
            PrivilegeDataMgr:Send_UpClubWishTreeLv(costItemData.id,costItemData.perCostNum,self.selectNum)
        else
            local args = {
                tittle = 2107025,
                reType = nil,
                content = TextDataMgr:getText(15010155),
                confirmCall = function ( ... )
                    PrivilegeDataMgr:Send_UpClubWishTreeLv(costItemData.id,costItemData.perCostNum,self.selectNum)
                end,
            }
            Utils:showReConfirm(args)
        end
    end)

    for k,v in ipairs(self.btnType) do
        v.btn:onClick(function()
            if k == self.typeIndex then
                return
            end
            self:chooseFun(k)
        end)
    end

end


return PrivilegeLeagueView
