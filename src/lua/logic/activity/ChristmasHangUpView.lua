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
* -- 圣诞挂机产出界面
]]

local ChristmasHangUpView = class("ChristmasHangUpView",BaseLayer)

function ChristmasHangUpView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.christmasHangUpVIew")
end

function ChristmasHangUpView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	
	self.label_cl = TFDirector:getChildByPath(ui,"label_cl")
	self.label_ch = TFDirector:getChildByPath(ui,"label_ch")
	self.label_chsj = TFDirector:getChildByPath(ui,"label_chsj")
	self.label_gzjs = TFDirector:getChildByPath(ui,"label_gzjs")
	self.Button_gaizao = TFDirector:getChildByPath(ui,"Button_gaizao")

	local Panel_item = TFDirector:getChildByPath(ui,"Panel_cl.Panel_item")

	self.item_cl = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	self.item_cl:setScale(0.5)
	self.item_cl:Pos(0, 0)
	Panel_item:addChild(self.item_cl)

	Panel_item = TFDirector:getChildByPath(ui,"Panel_own.Panel_item")

	self.item_own = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	self.item_own:setScale(0.4)
	self.item_own:Pos(0, 0)
	Panel_item:addChild(self.item_own)
	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.uilist_reward = UIListView:create(ScrollView_reward)
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Button_get = TFDirector:getChildByPath(ui,"Button_get")
	self.Label_own = TFDirector:getChildByPath(ui,"Label_own")
	self:refreshView()

	self.Label_des:setTextById(2130502)
end

function ChristmasHangUpView:refreshView()
	-- body
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_FIGHT)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
    
    if (not activityId) or (not self.activityInfo) then
    	self:removeEvents()
    	AlertManager:closeLayer(self) 
    	return 
    end

  	if not self.activityInfo.factoryInfo then
	    return
	end	

	local itemInfo = self.activityInfo.factoryInfo.fixedCycle[1]
	PrefabDataMgr:setInfo(self.item_cl,itemInfo.id)
	self.label_cl:setTextById(2130501,itemInfo.num)
	self.label_ch:setText(self.activityInfo.factoryInfo.count.."/"..self.activityInfo.factoryInfo.maxCount)
	local talents = TabDataMgr:getData("FactoryReform")
	local hasNum = self.activityInfo.factoryInfo.talents and #self.activityInfo.factoryInfo.talents or 0
	self.label_gzjs:setText(hasNum.."/"..table.count(talents))

	itemInfo = self.activityInfo.factoryInfo.fixed and self.activityInfo.factoryInfo.fixed[1] or {id = itemInfo.id, num = 0}
	PrefabDataMgr:setInfo(self.item_own,itemInfo.id)
	self.Label_own:setText(itemInfo.num)

	self.uilist_reward:removeAllItems()
	local reward = self.activityInfo.factoryInfo.extra or {}
	for k,v in pairs(reward) do
		local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		goodItem:setScale(0.58)
		PrefabDataMgr:setInfo(goodItem,v.id,v.num)
		self.uilist_reward:pushBackCustomItem(goodItem)
	end
end

function ChristmasHangUpView:addCountDownTimer(  )
	-- body
	self.timer = TFDirector:addTimer(1000,-1,nil,function ( ... )
		self:onCountDownCall()
	end)
	self:onCountDownCall()
end

function ChristmasHangUpView:removeCountDownTimer( ... )
	-- body
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil

	end
end


function ChristmasHangUpView:onCountDownCall()
	-- body
	local time = self.activityInfo.factoryInfo.nextTime
	self.label_chsj:setText(Utils:getTimeCountDownString(time,2))
end

function ChristmasHangUpView:registerEvents( ... )
	self.super.registerEvents(self)

	self:addCountDownTimer()

	self.Button_gaizao:onClick(function ( ... )
		-- body
		Utils:openView("activity.ChristmasRebuildView")
	end)

	self.Button_get:onClick(function ( ... )
		if self.activityInfo.factoryInfo.count == 0 then
			Utils:showTips(2130513)
			return
		end
		ActivityDataMgr2:request_CHRISTMAS_REQ2019_CHRISTMAS_PRODUCT()
	end)

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)


    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
        self:refreshView()
    end)
    
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
        self:refreshView()
    end)
end

function ChristmasHangUpView:removeEvents()
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

return ChristmasHangUpView