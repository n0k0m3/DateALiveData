local HundredLoginView = class("HundredLoginView", BaseLayer)


function HundredLoginView:ctor()
    self.super.ctor(self)

    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.hundredLoginView")
end

function HundredLoginView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

	self.Button_back	= TFDirector:getChildByPath(ui,"Button_back")
	self.Button_buy		= TFDirector:getChildByPath(ui,"Button_buy")

	self.Image_hero 	= TFDirector:getChildByPath(ui,"Image_hero")

	self.Label_des = TFDirector:getChildByPath(ui , "Label_des")
	

	self.itemInfoIcon = TFDirector:getChildByPath(ui,"Imag_item_1")
	self.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.Panel_goodsItem:setTouchEnabled(true)
    self.Panel_goodsItem:Pos(0, 0):AddTo(self.itemInfoIcon)

	self:updateUI()
end

function HundredLoginView:updateUI( ... )
	local taskData = TaskDataMgr:getTaskInfo(799000)
	self.taskInfo = taskData
	local taskCfg = TaskDataMgr:getTaskCfg(799000)
	local reward = taskCfg.reward[1]
	self.Label_des:setTextById(190000237 ,taskData.progress)
    
    PrefabDataMgr:setInfo(self.Panel_goodsItem, reward[1], reward[2])

	self.Button_buy:setGrayEnabled(taskData.status ~= EC_TaskStatus.GET)
	self.Button_buy:setTouchEnabled(taskData.status == EC_TaskStatus.GET)
end



function HundredLoginView:registerEvents()
	EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
	self.Button_back:onClick(function()
    	AlertManager:closeLayer(self)
	end)

    self.Button_buy:onClick(function()
    	TaskDataMgr:send_TASK_SUBMIT_TASK(self.taskInfo.cid)
	end)
end

function HundredLoginView:onTaskUpdateEvent( ... )
	self:updateUI()
end

function HundredLoginView:onTaskReceiveEvent( reward )
	 Utils:showReward(reward)
end

function HundredLoginView:onClose()
    self.super.onClose(self)
end

return HundredLoginView
