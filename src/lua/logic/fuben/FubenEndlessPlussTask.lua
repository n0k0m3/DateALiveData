
local FubenEndlessPlussTask = class("FubenEndlessPlussTask", BaseLayer)

function FubenEndlessPlussTask:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)

    self:initData()
    self:init("lua.uiconfig.fuben.fubenEndlessPlussTask")
end

function FubenEndlessPlussTask:initData()
    self.curBtn = nil
end

function FubenEndlessPlussTask:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")

    self.Panel_Item = TFDirector:getChildByPath(self.Panel_root, "Panel_Item")

    local list = TFDirector:getChildByPath(self.Image_content, "ScrollView")
    self.TableView_task = Utils:scrollView2TableView(list)
    self.TableView_task:setDirection(TFTableView.TFSCROLLVERTICAL)
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.TableView_task:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.TableView_task:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

    self:updateTaskInfo()
end

function FubenEndlessPlussTask:tableCellSize(TableView_task, idx)
    local size = self.Panel_Item:getSize()
    return size.height, size.width + 5
end

function FubenEndlessPlussTask:numberOfCells(TableView_task)
    local size = #self.task;
    return size
end

function FubenEndlessPlussTask:tableCellAtIndex(TableView_task,idx)
    local cell = TableView_task:dequeueCell()
    local item = nil
    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_Item:clone()
        item:show()
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:updateItem(item, idx + 1)
    return cell
end

function FubenEndlessPlussTask:updateItem(cell, idx)

    local taskCid = self.task[idx]
    if not taskCid then
        return
    end
    local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
    local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
    if not taskCfg or not taskInfo then
        return
    end

    ---描述
    local Label_desc = cell:getChildByName("Label_desc")
    Label_desc:setTextById(taskCfg.des)

    ---进度
    local Label_progress = cell:getChildByName("Label_progress")
    Label_progress:setTextById(800005, taskInfo.progress, taskCfg.progress)

    ---奖励
    if cell.rewardList then
        cell.rewardList:removeAllItems()
        cell.rewardList = nil
    end
    cell.rewardList = UIListView:create(TFDirector:getChildByPath(cell, "rewardList"))
    cell.rewardList:setItemsMargin(2)
    for k, v in pairs(taskCfg.reward) do
        local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(panel_goodsItem, tonumber(v[1]), v[2])
        panel_goodsItem:setScale(0.75)
        cell.rewardList:pushBackCustomItem(panel_goodsItem)
    end

    local Button_receive = cell:getChildByName("Button_receive")
    local Label_geted = cell:getChildByName("Label_geted")
    local Label_receive = cell:getChildByName("Label_receive")
    local Button_goto = cell:getChildByName("Button_goto")
    local Label_goto = cell:getChildByName("Label_goto")
    local Label_not_finish = cell:getChildByName("Label_not_finish")

    Button_receive:setVisible(taskInfo.status == EC_TaskStatus.GET)
    Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
    Label_receive:setTextById(1300008)
    --Button_goto:setVisible(taskInfo.status == EC_TaskStatus.ING and taskCfg.jumpInterface ~= 0)
    Button_goto:setVisible(false)
    Label_goto:setTextById(1300009)
    Label_not_finish:setVisible(taskInfo.status == EC_TaskStatus.ING)

    Button_goto:onClick(function()
        FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
    end)

    Button_receive:onClick(function()
        TaskDataMgr:send_TASK_SUBMIT_TASK(taskInfo.cid)
    end)

end

function FubenEndlessPlussTask:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function FubenEndlessPlussTask:updateTaskInfo()
    self.task = TaskDataMgr:getTask(EC_TaskType.ENDLESS_PLUSS) or {}
    dump(self.task)
    self.TableView_task:reloadData()
end

function FubenEndlessPlussTask:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.updateTaskInfo, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return FubenEndlessPlussTask
