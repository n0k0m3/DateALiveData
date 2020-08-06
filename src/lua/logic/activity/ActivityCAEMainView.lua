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
*-- 收集和兑换活动主界面
* 
]]

local ActivityCAEMainView = class("ActivityCAEMainView",BaseLayer)
require "lua.public.ScrollMenu"

function ActivityCAEMainView:ctor( data )
	self.super.ctor(self,data)
	self.activityInfo = ActivityDataMgr2:getActivityInfo(data)
	self.showidx = 1
	self.roleList = {}

	for k,v in pairs(self.activityInfo.extendData.taskMap) do
		table.insert(self.roleList,tonumber(k))
	end
	
	self.showid = self.activityInfo.showid or self.roleList[self.showidx]

	for k,v in pairs(self.roleList) do
		if v == self.showid then
			self.showidx = k
		end
	end
	self:init("lua.uiconfig.activity.ActivityCAEMainView")
end

function ActivityCAEMainView:initUI( ui )
	self.super.initUI(self,ui)
    self.Panel_hero_list    = TFDirector:getChildByPath(ui, "Panel_hero_list")
	self.Panel_hero_item_s    = TFDirector:getChildByPath(ui, "Panel_hero_item_s")
    self.Panel_hero_item_uns    = TFDirector:getChildByPath(ui, "Panel_hero_item_uns")
	self.panel_TaskItem 	= TFDirector:getChildByPath(ui,"panel_TaskItem");
    self.Panel_right = TFDirector:getChildByPath(ui, "Panel_right")


	self.Image_hero    = TFDirector:getChildByPath(ui,"Image_hero");
	self.Button_nianshou 	= TFDirector:getChildByPath(ui,"Button_nianshou");
	self.Button_hecheng 	= TFDirector:getChildByPath(ui,"Button_hecheng");
	self.Button_jifen 	= TFDirector:getChildByPath(ui,"Button_jifen");
	self.Button_duihuan 	= TFDirector:getChildByPath(ui,"Button_duihuan");
	self.Button_huigu 	= TFDirector:getChildByPath(ui,"Button_huigu");
	self.txt_time 	= TFDirector:getChildByPath(ui,"txt_time");
	self.Button_freeRefresh 	= TFDirector:getChildByPath(ui,"Button_freeRefresh");
	self.Button_gemRefresh 	= TFDirector:getChildByPath(ui,"Button_gemRefresh");

    self.right_pos = self.Panel_right:getPosition()
    self.hero_pos = self.Image_hero:getPosition()

	self:initHeroListView()
	self:flush()
	self:updateRight()
    self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.flushTime, self))
	self:flushTime( 0 )
end

function ActivityCAEMainView:flush( )
	self:updateModel()

	local casts = self.activityInfo.extendData.refreshCost
	local index = math.min(self.activityInfo.extendData.refreshCount + 1,#casts)
	local costConsume = casts[index]
	local costs = string.split(costConsume, ",")[1]
	local _cost = string.split(costs, ":")
	local id,num = _cost[1],_cost[2]
	local costIcon = TFDirector:getChildByPath(self.Button_gemRefresh,"icon");
	local txt_gem = TFDirector:getChildByPath(self.Button_gemRefresh,"txt_gem");
	costIcon:setTexture(GoodsDataMgr:getItemCfg(tonumber(id)).icon)
	txt_gem:setText(num)
	local redTip = TFDirector:getChildByPath(self.Button_jifen,"RedTip")
	redTip:setVisible(ActivityDataMgr2:isShowScoreRedPoint(self.activityInfo.id))
end

function ActivityCAEMainView:updateModel( force )
	if not force and self.elvesNpc_ and self.elvesNpc_.showid == self.showid then return end
	self.Image_hero:removeAllChildren()
	local modelInfo = TabDataMgr:getData("NewYearModel",self.showid)
    self.elvesNpc_ = ElvesNpcTable:createLive2dNpcID(modelInfo.modelId, false, false, nil).live2d
    self.elvesNpc_:registerEvents()
	self.Image_hero:addChild(self.elvesNpc_)
	self.elvesNpc_:newStartAction(modelInfo.action, EC_PRIORITY.FORCE)
	self.elvesNpc_.showid = self.showid
end

function ActivityCAEMainView:flushTime( dt )
	local remainTime = math.max(0, self.activityInfo.extendData.taskRefreshTime - ServerDataMgr:getServerTime())
    local day, hour, min, sec = Utils:getDHMS(remainTime, true)
    
    if hour ~="00" then
        self.txt_time:setTextById(13100053, hour, min)
    else
        self.txt_time:setTextById(13100054, min, sec)
    end

    self.Button_freeRefresh:setVisible(remainTime <= 0)
    self.Button_gemRefresh:setVisible(remainTime > 0)
end

function ActivityCAEMainView:dispose( )
	if self.countDownTimer_ then
		TFDirector:stopTimer(self.countDownTimer_)
		TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
	end
end

function ActivityCAEMainView:onShow( )
	self.super.onShow(self)
	self:updateModel(true)
end

function ActivityCAEMainView:onHide( )
	self.super.onHide(self)
	if self.elvesNpc_ then
		self.elvesNpc_:hide()
	end
end

function ActivityCAEMainView:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_NEWYEAR, handler(self.playFlushSucAni, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
		self:flush()
		self:updateCellInfo( self.scrollMenu:getSelCell(),self.showidx)
		self:updateRight()
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_NEWYEAR_TASK, function ( ... )
		self:playFlushSucAni()
	end)
	

	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
		self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityInfo.id)
		self.activityInfo.showid = self.showid
		self:flush()
	end)
	self.Button_huigu:onClick(function ( ... )
		print("播放剧情回顾")
		local datingId = self.activityInfo.extendData.stageDesc[self.activityInfo.extendData.stage].datingId
		FunctionDataMgr:jStartDating(datingId)
	end)

	self.Button_nianshou:onClick(function ( ... )
		print("打开年兽界面")
		if self.activityInfo.extendData.stage ~= 1 then
			Utils:openView("activity.ActivityNianShouView",self.activityInfo)
		else
			Utils:showTips(13100060)
		end
	end)

	self.Button_hecheng:onClick(function ( ... )
		print("打开合成界面")
		Utils:openView("activity.ActivitySynthesisView",self.activityInfo)
	end)

	self.Button_jifen:onClick(function ( ... )
		Utils:openView("activity.ActivityScoreRewardView",self.activityInfo)
	end)

	self.Button_duihuan:onClick(function ( ... )
		print("打开兑换界面")
		FunctionDataMgr:jDlsStore()
	end)
	self.Button_freeRefresh:onClick(function ( ... )
		print("刷新列表")
		local sendRsp = function ( ... )
			TFDirector:send(c2s.SPRING_FESTIVAL_REQ_REFRESH_SPRING_FESTIVAL_TASK,{1,self.showid})
		end	

	    local sureFunc = function ( ... )
			local taskIdList = self.activityInfo.extendData.taskMap[tostring(self.showid)]
			local hasCanGet = false
			for k,v in pairs(taskIdList) do
				local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v)
				if progressInfo.status == EC_TaskStatus.GET then
					hasCanGet = true
				end
			end
	    	if hasCanGet then
	    		local args = {
		            tittle = 2107025,
		            reType = "hulvnewyearreward",
		            content = TextDataMgr:getText(12100089),
		            confirmCall = sendRsp,
		        }
		        Utils:showReConfirm(args)
		        return
	    	end
	    	-- 发送请求
	    	sendRsp(... )
	    end
	    sureFunc()
	end)

	self.Button_gemRefresh:onClick(function ( ... )
		print("宝石刷新列表")
		local sendRsp = function ( ... )
			TFDirector:send(c2s.SPRING_FESTIVAL_REQ_REFRESH_SPRING_FESTIVAL_TASK,{2,self.showid})
		end	

	    local sureFunc = function ( ... )
			local taskIdList = self.activityInfo.extendData.taskMap[tostring(self.showid)]
			local hasCanGet = false
			for k,v in pairs(taskIdList) do
				local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType,v)
				if progressInfo.status == EC_TaskStatus.GET then
					hasCanGet = true
				end
			end
	    	if hasCanGet then
	    		local args = {
		            tittle = 2107025,
		            reType = "hulvnewyearreward",
		            content = TextDataMgr:getText(12100089),
		            confirmCall = sendRsp,
		        }
		        Utils:showReConfirm(args)
		        return
	    	end
	    	-- 发送请求
	    	sendRsp(... )
	    end
		self:showGemRefreshTips( sureFunc )
	end)
end

function ActivityCAEMainView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityInfo.id == activitId then
    	Utils:showReward(reward)
    end
end

function ActivityCAEMainView:showGemRefreshTips( callFuc )
	
	local casts = self.activityInfo.extendData.refreshCost
	local index = math.min(self.activityInfo.extendData.refreshCount + 1,#casts)
	local costConsume = casts[index]
	local costs = string.split(costConsume, ",")[1]
	local _cost = string.split(costs, ":")
	local id,num = _cost[1],_cost[2]

   	local args = {
        tittle = 2107025,
        reType = "newyearactivityrefresh",
        content = TextDataMgr:getText(13100061,tonumber(num),self.activityInfo.extendData.refreshCount,#casts),
        confirmCall = function ()
			if self.activityInfo.extendData.refreshCount >= #casts then
				Utils:showTips(13100075)
				return
			end
        	if GoodsDataMgr:currencyIsEnough(tonumber(id),tonumber(num)) then
        		callFuc()
            else
                Utils:showAccess(tonumber(id))
        	end
        end,
    }
    Utils:showReConfirm(args)
end

function ActivityCAEMainView:initHeroListView()
    local params = {
        ["upItem"]                  = self.Panel_hero_item_uns,
        ["downItem"]                = self.Panel_hero_item_uns,
        ["selItem"]                 = self.Panel_hero_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = #self.roleList,
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_hero_list:getContentSize(),
        ["isFromFairy"]             = true
    }
     local scrollMenu = ScrollMenu:create(params);
     scrollMenu:setPosition(self.Panel_hero_list:getPosition())
     self.Panel_hero_list:getParent():removeChild(self.Panel_hero_list:getParent():getChildByName("heroHeads"))
     self.Panel_hero_list:getParent():addChild(scrollMenu,10)
     scrollMenu:setName("heroHeads")
     self.scrollMenu = scrollMenu
     local jumpTo = HeroDataMgr:getSelectedHeroIdx(self.showid)
     self.scrollMenu:jumpTo(self.showidx)
end

function ActivityCAEMainView:updateCellInfo(cell,cellIdx)
    local heroid = self.roleList[cellIdx]

    local imgQuality = TFDirector:getChildByPath(cell,"Image_item_quality");
    -- imgQuality:setTexture(HeroDataMgr:getQualityPic(heroid))
    imgQuality:setVisible(false)

    local icon = TFDirector:getChildByPath(cell,"Image_icon")
	local modelInfo = TabDataMgr:getData("NewYearModel",heroid)
    icon:setTexture(modelInfo.icon)
    --icon:setContentSize(CCSizeMake( 90,90))


    local redTip = TFDirector:getChildByPath(cell,"RedTip")
    redTip:setVisible(ActivityDataMgr2:isShowRoleHeadRedPoint(self.activityInfo.id, heroid))

    local Image_duty = TFDirector:getChildByPath(cell,"Image_duty")
    local Image_duty_1 = TFDirector:getChildByPath(cell,"Image_duty_1")
    Image_duty:setVisible(false)
    Image_duty_1:setVisible(false)
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    lock:setVisible(false)
end

function ActivityCAEMainView:selCallback(cell,cellIdx)
    self.Panel_right:stopAllActions()
    self.Image_hero:stopAllActions()
    self.Panel_right:setPosition(self.right_pos)
    self.Image_hero:setPosition(self.hero_pos)
    if self.selectCellItem then
       --self.selectCellItem:stopAllActions() --获得精灵时会报错，先注释掉
    end
    self.selectCellItem = cell
    self.selectCellItem:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
    ViewAnimationHelper.doMoveFadeInAction(self.Image_hero, {direction = 1, distance = 30, ease = 1})
    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})


    local heroid = self.roleList[cellIdx]
    self.showid = heroid
    self.activityInfo.showid = heroid
    self.showidx = cellIdx
	self:updateHeroBaseInfo()
    if self.curChangeHeroHandle then
        TFAudio.stopEffect(self.curChangeHeroHandle)
        self.curChangeHeroHandle = nil
    end
    local modelInfo = TabDataMgr:getData("NewYearModel",self.showid)
    self.curChangeHeroHandle = TFAudio.playSound(modelInfo.voicePath);

end

function ActivityCAEMainView:updateHeroBaseInfo()
	self:flush()
	self:updateRight()
end


function ActivityCAEMainView:updateRight()
	for i = 1,3 do
		local pos = TFDirector:getChildByPath(self.ui,"pos"..i)
		if not pos.item then
			local item = self.panel_TaskItem:clone()
			pos:addChild(item)
			item:setPosition(me.p(0,0))
			pos.item = item
		end
		local taskId = self.activityInfo.extendData.taskMap[tostring(self.showid)][i]
		if not taskId then
			pos.item:setVisible(false)
		else
			pos.item:setVisible(true)
			self:flushItem(pos.item,taskId)
		end
	end
end

function ActivityCAEMainView:flushItem(itemNode,taskId)
    local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, taskId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, taskId)
	local parentNode = nil
	local parentNode1 = TFDirector:getChildByPath(itemNode,"panel_ywc")
	local parentNode2 = TFDirector:getChildByPath(itemNode,"panel_wwc")
	if progressInfo.status == EC_TaskStatus.GETED then
		parentNode = parentNode1
		parentNode2:setVisible(false)
	else
		parentNode = parentNode2
		local flag = TFDirector:getChildByPath(parentNode,"image_zs1")
		flag:setVisible(progressInfo.status == EC_TaskStatus.GET)
		parentNode1:setVisible(false)
	end
	parentNode:setVisible(true)

	local btn = TFDirector:getChildByPath(parentNode,"image_bg")
	local txt_taskName = TFDirector:getChildByPath(parentNode,"txt_taskName")

	btn:onClick(function ( ... )
		Utils:openView("activity.NewYearDetailView",self.activityInfo.id,itemInfo)
	end)
	txt_taskName:setLineHeight(35)
	txt_taskName:setText(itemInfo.extendData.des1)

end

function ActivityCAEMainView:playFlushSucAni()
	self.ui:setAnimationCallBack("Action1", TFANIMATION_END, function()
    	 	self:updateRight()
			self.ui:runAnimation("Action2",1)
    	  end)
	self.ui:runAnimation("Action1",1)
end

return ActivityCAEMainView