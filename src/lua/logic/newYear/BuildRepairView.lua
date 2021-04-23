local BuildRepairView = class("BuildRepairView", BaseLayer)

function BuildRepairView:initData()

    self.BuildRepairCfg = TabDataMgr:getData("SpringFestivalPark")

    self.selectNum = 0
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.NEWYEAR_BUILDREPAIR)[1]
    self.activityId = activityId
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    if self.activityInfo and self.activityInfo.extendData then
        self.submitId = self.activityInfo.extendData.submitId
        self.interval = self.activityInfo.extendData.interval
        self.pernum = self.activityInfo.extendData.once or 1
    end
    dump(self.activityInfo)
end

function BuildRepairView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    --self:showPopAnim(true)
    self:init("lua.uiconfig.NewYear.buildRepairView")
end

function BuildRepairView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Label_bar = TFDirector:getChildByPath(self.Panel_root, "Label_bar")
    self.Label_bar_exp = TFDirector:getChildByPath(self.Panel_root, "Label_bar_exp")
    self.bar = TFDirector:getChildByPath(self.Panel_root, "bar")
    self.prebar = TFDirector:getChildByPath(self.Panel_root, "prebar")

    self.btnType = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Button_type"..i)
        local select = TFDirector:getChildByPath(btn, "select")
        local Label_btn = TFDirector:getChildByPath(btn, "Label_btn")
        table.insert(self.btnType,{btn = btn, select = select, Label_btn = Label_btn})
    end

    self.Panel_cur = TFDirector:getChildByPath(self.Panel_root, "Panel_cur")
    self.Panel_next = TFDirector:getChildByPath(self.Panel_root, "Panel_next")

    self.Button_down = TFDirector:getChildByPath(self.Panel_root, "Button_down")
    self.Button_up = TFDirector:getChildByPath(self.Panel_root, "Button_up")
    self.Label_num = TFDirector:getChildByPath(self.Panel_root, "Label_num")
    self.Label_cost_tip = TFDirector:getChildByPath(self.Panel_root, "Label_cost_tip")
    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_root, "Image_cost_bg")
    self.Label_cost_tip:setTextById(15011218)

    self.Panel_repair = TFDirector:getChildByPath(self.Panel_root, "Panel_repair")
    self.Panel_produce = TFDirector:getChildByPath(self.Panel_root, "Panel_produce")

    self.Button_use = TFDirector:getChildByPath(self.Panel_root, "Button_use")
    self.Button_get = TFDirector:getChildByPath(self.Panel_root, "Button_get")

    self.btn_rule = TFDirector:getChildByPath(self.Panel_root, "btn_rule")

    self.panel_cell = TFDirector:getChildByPath(ui, "Panel_cell")

    self.Label_null = TFDirector:getChildByPath(self.Panel_produce, "Label_null")
    self.Label_null:setTextById(15011219)

    local scroll_list = TFDirector:getChildByPath(self.Panel_produce, "scroll_list")
    self.TableView_item = Utils:scrollView2TableView(scroll_list)
    --Public:bindScrollFun(self.TableView_item)
    --self.TableView_item:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    TFDirector:send(c2s.ACTIVITY2_REQ_REPAIR_DATA,{})

    self.Label_time_tip = TFDirector:getChildByPath(ui, "Label_time_tip")
    self.Label_time_begin = TFDirector:getChildByPath(ui, "Label_time_begin")
    self.Label_time_end = TFDirector:getChildByPath(ui, "Label_time_end"):hide()

    if self.activityInfo then
        local startDate = Utils:getLocalDate(self.activityInfo.startTime)
        local startDateStr = startDate:fmt("%Y.%m.%d")
        local endDate = Utils:getLocalDate(self.activityInfo.endTime)
        local endDateStr = endDate:fmt("%Y.%m.%d")
        self.Label_time_begin:setText(startDateStr.."-"..endDateStr)
        --self.Label_time_end:setText("-"..endDateStr)
    end
end

function BuildRepairView:onHide()
    self.super.onHide(self)
end

function BuildRepairView:onClose()
    self.super.onClose(self)
end

function BuildRepairView:onShow()
    self.super.onShow(self)
    local curExp,curLv = ActivityDataMgr2:getBuildRepairInfo()
    DatingDataMgr:triggerDating(self.__cname,"onShow")
    DatingDataMgr:triggerDating(self.__cname,"onShow2",{repairsBuildLevel = curLv})
end

function BuildRepairView:getCfgByLv(lv)

    for k,v in ipairs(self.BuildRepairCfg) do
        if v.level == lv then
            return v
        end
    end
end

function BuildRepairView:getBeforeExp(lv)

    local totalExp = 0
    for k,v in ipairs(self.BuildRepairCfg) do
        if v.level < lv then
            totalExp = totalExp + v.exp
        end
    end
    return totalExp
end

function BuildRepairView:updateView()

    self.typeIndex = self.typeIndex or 1
    self:chooseFun(self.typeIndex)
end

function BuildRepairView:chooseFun(typeIndex)

    self.typeIndex = typeIndex
    for k,v in ipairs(self.btnType) do
        v.select:setVisible(typeIndex == k)
        local color = typeIndex == k and ccc3(132,37,64) or ccc3(155,192,242)
        v.Label_btn:setColor(color)
    end

    self.Panel_repair:setVisible(typeIndex == 1)
    self.Panel_produce:setVisible(typeIndex == 2)

    if typeIndex == 1 then
        self:uppdateRepair()
    elseif typeIndex == 2 then
        self.repairOutput = ActivityDataMgr2:getBuildOutPut()
        self.TableView_item:reloadData()

        local haveOutPut = false
        for k,v in ipairs(self.repairOutput) do
            if v.output ~= 0 then
                haveOutPut = true
                break
            end
        end

        self.Button_get:setTouchEnabled(haveOutPut)
        self.Button_get:setGrayEnabled(not haveOutPut)

        if not next(self.repairOutput) then
            self.Label_null:show()
        else
            self.Label_null:hide()
        end
    end

end



function BuildRepairView:uppdateRepair()

    local curExp,curLv = ActivityDataMgr2:getBuildRepairInfo()
    local curCfg = self:getCfgByLv(curLv)
    if not curCfg then
        return
    end

    self.Label_bar:setText("Lv."..curLv)

    local nextLv = curLv + 1
    local nextCfg = self:getCfgByLv(nextLv)
    if not nextCfg then
        self.Label_bar_exp:setText("max")
        self.bar:setPercent(100)
        --self.Panel_next:setVisible(false)
        --self:updateInfo(self.Panel_cur,curCfg.desc or "",false)
        self:updateInfo(self.Panel_cur,15011311 or "",false)
    else
        local exp = curExp
        local needExp = nextCfg.exp
        self.Label_bar_exp:setText(exp.."/"..needExp)
        self.bar:setPercent(math.floor(exp/needExp*100))
        self:updateInfo(self.Panel_cur,nextCfg.desc or "",true)
        --self.Panel_next:setVisible(true)
    end

    --local posX = nextCfg and 428 or 590
    --self.Panel_cur:setPositionX(posX)

    self:updateNum(0)
end

function BuildRepairView:updateInfo(pl,desc,isNext)

    local Label_desc = TFDirector:getChildByPath(pl, "Label_desc")
    Label_desc:setTextById(desc)
    local Label_title_next = TFDirector:getChildByPath(pl, "Label_title_next")
    local Label_title = TFDirector:getChildByPath(pl, "Label_title")
    Label_title_next:setVisible(isNext)
    Label_title:setVisible(not isNext)
end

function BuildRepairView:updateNum(num)

    local maxCnt = GoodsDataMgr:getItemCount(self.submitId)

    self.selectNum = self.selectNum + num
    if num > 0 then
        self.selectNum = math.min(self.selectNum, maxCnt)
    elseif num < 0 then
        self.selectNum = math.max(self.selectNum, 0)
    end
    self.Label_num:setText(maxCnt.."/"..self.selectNum);

    self.Button_up:setGrayEnabled(self.selectNum >= maxCnt)
    self.Button_up:setTouchEnabled(self.selectNum < maxCnt)
    self.Button_down:setGrayEnabled(self.selectNum<= 0)
    self.Button_down:setTouchEnabled(self.selectNum > 0)

    --local Panel_goodsItem = self.Image_cost_bg:getChildByName("Panel_goodsItem")
    --if not Panel_goodsItem then
    --    Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    --    Panel_goodsItem:Pos(0, 0):AddTo(self.Image_cost_bg)
    --    Panel_goodsItem:setName("Panel_goodsItem")
    --end

    local itemCfg = GoodsDataMgr:getItemCfg(self.submitId)
    if itemCfg then
        self.Image_cost_bg:setTexture(itemCfg.icon)
        self.Image_cost_bg:onClick(function()
            Utils:showInfo(self.submitId)
        end)
    end
    --PrefabDataMgr:setInfo(Panel_goodsItem, self.submitId)

    if self.selectNum <= 0 or self.selectNum >= maxCnt then
        self:stopTimer()
        return
    end
end


function BuildRepairView:cellSizeForTable()
    local size = self.panel_cell:getContentSize()
    return size.height, size.width
end

function BuildRepairView:numberOfCellsInTableView()
    self.repairOutput = self.repairOutput or {}
    local cnt = math.ceil(#self.repairOutput/2)
    return cnt
end

function BuildRepairView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.panel_cell:clone():show()
        --item:setAnchorPoint(ccp(0.5, 0.5))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        for i=1,2 do
            local root = TFDirector:getChildByPath(cell.item, "panel_item_"..i)
            local commodityIndex = (idx-1)*2+i
            local data = self.repairOutput[commodityIndex]
            if not data then
                root:hide()
            else
                root:show()
                self:updateOutputItem(root, data)
            end

        end
    end

    return cell
end

function BuildRepairView:updateOutputItem(item, data)

    local curExp,curLv = ActivityDataMgr2:getBuildRepairInfo()
    local curRepairCfg = self.BuildRepairCfg[curLv]
    if not curRepairCfg then
        return
    end

    local index,output = data.index,data.output
    local itemId = curRepairCfg.itemType[index]
    local itemLimit = curRepairCfg.itemLimit[index]
    local itemNumber = curRepairCfg.itemNumber[index]
    local icon = curRepairCfg.icon[index]

    if not itemId or not itemLimit or not itemNumber or not icon then
        return
    end

    local min = self.interval/60
    local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    Label_desc:setTextById(15011221,self.interval/60,itemNumber)
    local cell_item = TFDirector:getChildByPath(item, "cell_item")
    --local Panel_goodsItem = cell_item:getChildByName("Panel_goodsItem")
    --if not Panel_goodsItem then
    --    Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    --    Panel_goodsItem:ZO(1):AddTo(cell_item)
    --    Panel_goodsItem:Pos(0, 0)
    --    Panel_goodsItem:setName("Panel_goodsItem")
    --end
    --if Panel_goodsItem.ListView_star then
    --    Panel_goodsItem.ListView_star:removeAllItems()
    --    Panel_goodsItem.ListView_star = nil
    --end
    --PrefabDataMgr:setInfo(Panel_goodsItem, itemId)

    local Label_cnt = TFDirector:getChildByPath(item, "Label_cnt")
    Label_cnt:setText(Utils:format_number(output,10000).."/"..Utils:format_number(itemLimit,10000))

    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    Image_icon:setTexture(itemCfg.icon)

    local Label_item_name = TFDirector:getChildByPath(item, "Label_item_name")
    Label_item_name:setTextById(itemCfg.nameTextId)

    local Label_item_desc = TFDirector:getChildByPath(item, "Label_item_desc")
    Label_item_desc:setTextById(itemCfg.desTextId)

    Image_icon:setTouchEnabled(true)
    Image_icon:onClick(function()
        Utils:showInfo(itemId)
    end)
end

function BuildRepairView:afterBuildRepair()
    self.selectNum = 0
    self:updateNum(0)
end

function BuildRepairView:playAni()
    self.Button_use:setTouchEnabled(false)
    self.Button_use:setGrayEnabled(true)
    self.Button_use:stopAllActions()
    local act = CCSequence:create({
        CCDelayTime:create(3),
        CCCallFunc:create(function()
            self.Button_use:setTouchEnabled(true)
            self.Button_use:setGrayEnabled(false)
        end)
    })
    self.Button_use:runAction(act)
end

function BuildRepairView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        if not self.timer then
            return
        end
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
    self:stopTimer()
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function BuildRepairView:stopTimer()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil;
    end
end

function BuildRepairView:onTouchButtonDown()

    --self:updateNum(-(self.perCostNum or 0),true)
    self:updateNum(-self.pernum)
end

function BuildRepairView:onTouchButtonUp()
    --self:updateNum(self.perCostNum or 0,true)
    self:updateNum(self.pernum)
end


function BuildRepairView:onHide()
    self:stopTimer()
    self.super.onHide(self)
end

function BuildRepairView:onClose()
    self:stopTimer()
    self.super.onClose(self)
end


function BuildRepairView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateActivityView, self))
    EventMgr:addEventListener(self, EV_BUILD_REPAIR_DATA, handler(self.updateView, self))
    EventMgr:addEventListener(self, EV_AFTER_BUILD_REPAIR, handler(self.afterBuildRepair, self))

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId and self.activityId == activityId then
            Utils:showTips(14110403)
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
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

    self.Button_use:onClick(function()

        local haveCnt = GoodsDataMgr:getItemCount(self.submitId)
        if haveCnt < self.selectNum then
            Utils:showTips(3005033)
            return
        end
        if self.selectNum <= 0 then
            return
        end
        TFDirector:send(c2s.ACTIVITY2_REQ_REPAIR_SUBMIT,{self.selectNum})
        self:playAni()
    end)

    self.Button_get:onClick(function()

        self.repairOutput = ActivityDataMgr2:getBuildOutPut()
        if not self.repairOutput or not next(self.repairOutput) then
            Utils:showTips(15011220)
            return
        end
        local haveOutPut = false
        for k,v in ipairs(self.repairOutput) do
            if v.output ~= 0 then
                haveOutPut = true
                break
            end
        end

        if not haveOutPut then
            Utils:showTips(15011220)
            return
        end

        TFDirector:send(c2s.ACTIVITY2_REQ_TAKE_REPAIR_OUTPUT,{})
    end)

    for k,v in ipairs(self.btnType) do
        v.btn:onClick(function()
            if k == self.typeIndex then
                return
            end
            self:chooseFun(k)
        end)
    end

    self.btn_rule:onClick(function()
        Utils:openView("common.HelpView", {3128})
    end)
end


return BuildRepairView
