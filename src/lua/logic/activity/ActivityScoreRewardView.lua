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
* -- 积分奖励界面
* 
]]

local json = require("LuaScript.extends.json")
local ActivityScoreRewardView = class("ActivityScoreRewardView",BaseLayer)

function ActivityScoreRewardView:ctor( data)
	self.super.ctor(self,data)
    self:showPopAnim(true)
    self.activityInfo = data
    self.scoreList = self.activityInfo.scoreList or json.decode(self.activityInfo.extendData.scoreTaskList)
    self.activityInfo.scoreList = self.scoreList
    self.showCount = #self.scoreList
	self:init("lua.uiconfig.activity.ActivityScoreRewardView")
end

function ActivityScoreRewardView:initUI( ui )
	self.super.initUI(self,ui)
	self.panel_list = TFDirector:getChildByPath(ui,"panel_list")
	self.scrollView_list = TFDirector:getChildByPath(ui,"scrollView_list")

	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item")
	self.has_score = TFDirector:getChildByPath(ui,"has_score")

	self:initTableView()
	self:flushUI()
end


function ActivityScoreRewardView:flushUI(  )
	self.has_score:setText(self.activityInfo.extendData.totalScore)
    self:updateAllList()
end

function ActivityScoreRewardView:initTableView()
    self.listScrollView = UIListView:create(self.scrollView_list)

    self:updateAllList()
end

function ActivityScoreRewardView:updateAllList(  )
    local items = self.listScrollView:getItems()
    local gap = #self.scoreList - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self:addItem()
        else
            local item = self.listScrollView:getItem(1)
            self.listScrollView:removeItem(1)
        end
    end

    -- 更新活动信息
    for i = 1,#self.scoreList do
        self:updateItem(i)
    end
end

function ActivityScoreRewardView:addItem(index)
    local panel_item = self.panel_item:clone()
    self.listScrollView:pushBackCustomItem(panel_item)
end

function ActivityScoreRewardView:updateItem(index)
    local itemInfo = self.scoreList[index]

    local item = self.listScrollView:getItem(index)

	local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, itemInfo.id)

	local Image_diban = TFDirector:getChildByPath(item,"Image_diban")
	local Image_finish = TFDirector:getChildByPath(item,"Image_finish")
	local btn_getReward = TFDirector:getChildByPath(item,"Button_receive")
	local label_ylq = TFDirector:getChildByPath(item,"Label_state")
	local txt_score = TFDirector:getChildByPath(item,"target_score")
	local Label_desc = TFDirector:getChildByPath(item,"Label_desc")

	Label_desc:setText(itemInfo.des1)
	txt_score:setText(itemInfo.progress)

	Image_diban:show()
	Image_finish:hide()
	local goodsId ,goodsNum
	for i = 1, 4 do
        local root = TFDirector:getChildByPath(item, "Image_reward_" .. i)
        if not root.goodItem then
	       	local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	        Panel_goodsItem:AddTo(root):Pos(0, 0)
	        root.goodItem = Panel_goodsItem
	    end
    	root:setVisible(false)
    end
    local index = 1
    for k,v in pairs(itemInfo.reward[1]) do
    	local root = TFDirector:getChildByPath(item, "Image_reward_" .. index)
       	root:setVisible(true)
       	PrefabDataMgr:setInfo(root.goodItem, tonumber(k), tonumber(v))
       	index = index + 1
    end

	if progressInfo.status == EC_TaskStatus.GET then
		btn_getReward:show()
		btn_getReward:setGrayEnabled(false)
		btn_getReward:setTouchEnabled(true)
		label_ylq:hide()
	elseif progressInfo.status == EC_TaskStatus.GETED then
		Image_diban:hide()
		Image_finish:show()
		label_ylq:show()
		btn_getReward:hide()
	else
		btn_getReward:show()
		btn_getReward:setGrayEnabled(true)
		btn_getReward:setTouchEnabled(false)
		label_ylq:hide()
	end

	btn_getReward:onClick(function ( ... )
		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo.id, itemInfo.id)
	end)
end

function ActivityScoreRewardView:registerEvents(  )
	self.super.registerEvents(self)
	self.Button_close:onClick(function (  )
		AlertManager:closeLayer(self)
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
		self:flushUI()
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
		self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityInfo.id)
		self:flushUI()
	end)
end

return ActivityScoreRewardView