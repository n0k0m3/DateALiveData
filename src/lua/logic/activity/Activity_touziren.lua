--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]

local TouzirenView = class("TouzirenView",BaseLayer)

function TouzirenView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.investorCfg = TabDataMgr:getData("Investor",1)
	self:init("lua.uiconfig.activity.touzhirenView")
end

function TouzirenView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.LoadingBar_process = TFDirector:getChildByPath(ui,"LoadingBar_process")
	self.label_process = TFDirector:getChildByPath(ui,"label_process")
	self.label_lv = TFDirector:getChildByPath(ui,"label_lv")
	self.Button_web = TFDirector:getChildByPath(ui,"Button_web")
	self.Button_help = TFDirector:getChildByPath(ui,"Button_help")
	self.img_di = TFDirector:getChildByPath(ui,"img_di")

	local ScrollView_task = TFDirector:getChildByPath(ui,"ScrollView_task")

	self.Grid_task = UIGridView:create(ScrollView_task)
    self.Grid_task:setItemModel(self.img_di)
    self.Grid_task:setColumn(4)
    self.Grid_task:setColumnMargin(10)
    self.Grid_task:setRowMargin(10)
    self.column = column
    
    local typeId = self.investorCfg.battenId
    local info = FunctionDataMgr:getMainFuncInfo(typeId);
    self.Button_web:setVisible(info)
    self:refreshLevel()
    self:refreshView()
end

function TouzirenView:registerEvents()
	-- body
	self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.refreshView, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.refreshLevel, self))

    self.Button_web:onClick(function ( ... )
    	MainPlayer:checkTzrTypeInfo()
    end)

    self.Button_help:onClick(function ( ... )
    	local layer = require("lua.logic.common.HelpView"):new(self.investorCfg.helpInterface)
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)
end

function TouzirenView:refreshLevel( )
	local level, curProcess, maxProcess = MainPlayer:getTouzirenLevel();
	self.label_lv:setText(level)
	self.LoadingBar_process:setPercent( curProcess*100 / maxProcess)
	self.label_process:setText(curProcess.. "/" ..maxProcess )
end

function TouzirenView:refreshView( )
	-- body
	self.task_ =  TaskDataMgr:getTask(self.investorCfg.taskType)
	self.Grid_task:AsyncUpdateItem(self.task_,function (item,v)
		self:updateTaskItem(item, v)
	end)
end

function TouzirenView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function TouzirenView:updateTaskItem( item, taskCid )
	-- body
    local taskCfg = TaskDataMgr:getTaskCfg(taskCid)
    local taskInfo = TaskDataMgr:getTaskInfo(taskCid)
    local progress = taskCfg.progress

	local Label_score = TFDirector:getChildByPath(item,"Label_score")
	local Panel_reward = TFDirector:getChildByPath(item,"Panel_reward")
	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Label_geted = TFDirector:getChildByPath(item,"Label_geted")

	Label_score:setText(progress)

	local  reward = taskCfg.reward
	local rewards = {}

	for k,v in pairs(reward) do
		table.insert( rewards, Utils:makeRewardItem(v[1], v[2]))
	end
	Utils:createRewardItemStyle1(Panel_reward,rewards,true)

	Button_get:setVisible(taskInfo.status ~= EC_TaskStatus.GETED)
	Label_geted:setVisible(taskInfo.status == EC_TaskStatus.GETED)
	Button_get:setTouchEnabled(taskInfo.status == EC_TaskStatus.GET)
	Button_get:setGrayEnabled(taskInfo.status ~= EC_TaskStatus.GET)
	Button_get:onClick(function ( ... )
		-- body
		TaskDataMgr:send_TASK_SUBMIT_TASK(taskCid)
	end)
end

return TouzirenView