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
* -- 福利礼包活动
]]

local WelfareRechargeView = class("WelfareRechargeView",BaseLayer)

function WelfareRechargeView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.activityId = data
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    if self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 3 then
        self:init("lua.uiconfig.activity.welfareRechargeView1")
    else
        self:init("lua.uiconfig.activity.welfareRechargeView")
    end
end

function WelfareRechargeView:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content") 

    self.Button_action = TFDirector:getChildByPath(self.Panel_root, "Button_action")
    self.Label_action = TFDirector:getChildByPath(self.Button_action, "Label_signInReceive")

    self.goodsData = RechargeDataMgr:getOneRechargeCfg(self.activityInfo.extendData.rechargeId)
    local cfg = GoodsDataMgr:getItemCfg(self.goodsData.exchangeCost[1].id)

    self.Label_action.img_icon = TFImage:create(cfg.icon)
    self.Label_action.img_icon:setScale(0.5)

    self.Label_action.img_icon:setPositionX(-50)
    self.Label_action:addChild(self.Label_action.img_icon)
    self.label_tip = TFDirector:getChildByPath(self.Panel_root, "label_tip")
    self.label_buyTimes = TFDirector:getChildByPath(self.Panel_root, "label_buyTimes")
    self.Label_timing = TFDirector:getChildByPath(ui, "Label_timing")
 
    local ScrollView_reward = TFDirector:getChildByPath(self.Image_content, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(26)
    self:refreshView()
end

function WelfareRechargeView:refreshView()
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.giftData = RechargeDataMgr:getGiftData({self.activityInfo.extendData.rechargeId})[1]
	self.items = ActivityDataMgr2:getItems(self.activityId)
	self.canBuy = true
	self.curItemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, self.items[1])
	for k,v in pairs(self.items) do
		local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, v)
	    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, v)
       	if progressInfo and progressInfo.status ~= EC_TaskStatus.ING then
       		self.canBuy = false
       		self.curItemInfo = itemInfo
       		self.progressInfo = progressInfo
       	end
	end
	self.ListView_reward:removeAllItems()
    self.signItems_ = {}
	for i,v in pairs(self.curItemInfo.reward) do
		self:addSignItem()
	end
    self:updateAllSignItem()
    self.Image_content:setTexture(self.activityInfo.extendData.bgPath)

    self.Label_action.img_icon:hide()
    if self.canBuy then
    	self.Button_action:setTouchEnabled(true)
    	self.Button_action:setGrayEnabled(false)
    	self.Label_action:setText("     "..self.goodsData.exchangeCost[1].num)
        self.Label_action.img_icon:show()
    elseif self.progressInfo.status ~= EC_TaskStatus.GETED then
    	self.Button_action:setTouchEnabled(self.progressInfo.status == EC_TaskStatus.GET)
    	self.Button_action:setGrayEnabled(self.progressInfo.status ~= EC_TaskStatus.GET)
    	self.Label_action:setTextById(700013)
    elseif self.progressInfo.status == EC_TaskStatus.GETED then
    	self.Label_action:setTextById(1300015)
    	self.Button_action:setTouchEnabled(false)
    	self.Button_action:setGrayEnabled(true)
    end

    local startDate = Utils:getUTCDate(self.activityInfo.startTime, GV_UTC_TIME_ZONE)
    local endDate = Utils:getUTCDate(self.activityInfo.endTime , GV_UTC_TIME_ZONE)
    local startDateStr = startDate:fmt("%m.%d")
    local endDateStr = endDate:fmt("%m.%d")
    if self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 3 then
        self.Label_timing:setTextById(800041, startDateStr, endDateStr)
    end

    local date = TextDataMgr:getText(800041, startDateStr, endDateStr)..GV_UTC_TIME_STRING
    self.label_tip:setTextById(self.activityInfo.extendData.tip or 13143, date)
    self:updateCountDown()
    self.Button_action:onClick(function ( ... )
    	if self.canBuy then
    		RechargeDataMgr:getOrderNO(self.activityInfo.extendData.rechargeId)
    	else
       		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.curItemInfo.id)
    	end
    end)
end

function WelfareRechargeView:registerEvents()
 end

function WelfareRechargeView:onUpdateProgressEvent()
     self:refreshView()
end

function WelfareRechargeView:onUpdateActivityEvent()
    self:refreshView()
end

function WelfareRechargeView:onUpdateCountDownEvent()
    self:updateCountDown()
end


function WelfareRechargeView:updateCountDown()
    -- local isEnd = ActivityDataMgr2:isEnd(self.activityId)
    local serverTime = ServerDataMgr:getServerTime()
    local str = ""
    local giftData = self.giftData
    if not giftData.endDate then return end
    if self.canBuy then
        if giftData.endDate - serverTime > 0 then
            local day, hour, min  = Utils:getFuzzyDHMS(giftData.endDate-serverTime, true)
            -- str = day.."天"..hour.."小时"..min.."分后结束"
          if day == "00" then
                self.label_buyTimes:setTextById(self.activityInfo.extendData.hourRstring or 13145, hour, min)
            else
                self.label_buyTimes:setTextById(self.activityInfo.extendData.dayRstring or 13144 , day, hour)
            end
        else
            self.label_buyTimes:setTextById(self.activityInfo.extendData.hourRstring or 13145, "00", "00")
        end
    else
        self.label_buyTimes:setTextById(277003)
    end
    
end

function WelfareRechargeView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function WelfareRechargeView:updateAllSignItem()
    local id, num = next(self.curItemInfo.reward)
    for i, v in ipairs(self.ListView_reward:getItems()) do
        local foo = self.signItems_[v]
        PrefabDataMgr:setInfo(foo.root, id, num)
        id, num = next(self.curItemInfo.reward,id)
    end
end

function WelfareRechargeView:addSignItem()
    local foo = {}
    foo.root = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    foo.root:Scale(0.7):Pos(0, 0)
    self.ListView_reward:pushBackCustomItem(foo.root)
    self.signItems_[foo.root] = foo
    return foo
end


return WelfareRechargeView