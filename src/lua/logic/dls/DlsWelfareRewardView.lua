
local DlsWelfareRewardView = class("DlsWelfareRewardView", BaseLayer)

function DlsWelfareRewardView:initData(taskCid)
    self.taskCid_ = taskCid
    self.taskInfo_ = TaskDataMgr:getTaskInfo(taskCid)
    self.taskCfg_ = TaskDataMgr:getTaskCfg(taskCid)
    self.itemCid_ = EC_SItemType.WORKER_CARD
end

function DlsWelfareRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dlsWelfareRewardView")
end

function DlsWelfareRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    local ScrollView_reward = TFDirector:getChildByPath(Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setTouchEnabled(false)
    self.ListView_reward:setInertiaScrollEnabled(false)
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Panel_goods = TFDirector:getChildByPath(Image_content, "Panel_goods")
    self.Label_collect_1 = TFDirector:getChildByPath(self.Panel_goods, "Label_collect_1")
    self.Label_collect_2 = TFDirector:getChildByPath(self.Panel_goods, "Label_collect_2")
    self.Image_icon = TFDirector:getChildByPath(self.Panel_goods, "Image_icon")
    self.Button_receive = TFDirector:getChildByPath(Image_content, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")

    self:refreshView()
end

function DlsWelfareRewardView:refreshView()
    self.Label_title:setTextById(2101005)
    self.Label_collect_1:setTextById(2101006)
    self.Label_collect_2:setTextById(2101007, self.taskCfg_.progress)
    local itemCfg = GoodsDataMgr:getItemCfg(self.itemCid_)
    self.Image_icon:setTexture(itemCfg.icon)

    for i, v in ipairs(self.taskCfg_.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(Panel_goodsItem, v[1], v[2])
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    Utils:setAliginCenterByListView(self.ListView_reward, true)

    local status = self.taskInfo_.status
    self.Button_receive:setTouchEnabled(status == EC_TaskStatus.GET)
    self.Button_receive:setGrayEnabled(status ~= EC_TaskStatus.GET)
    if status == EC_TaskStatus.GET then
        self.Label_receive:setTextById(262012)
    elseif status == EC_TaskStatus.ING then
        self.Label_receive:setTextById(2109034)
    elseif status == EC_TaskStatus.GETED then
        self.Label_receive:setTextById(700033)
    end
end

function DlsWelfareRewardView:registerEvents()
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))

    self.Button_receive:onClick(function()
            TaskDataMgr:send_TASK_SUBMIT_TASK(self.taskCid_)
    end)

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)
end

function DlsWelfareRewardView:onTaskReceiveEvent()
    AlertManager:closeLayer(self)
end

return DlsWelfareRewardView
