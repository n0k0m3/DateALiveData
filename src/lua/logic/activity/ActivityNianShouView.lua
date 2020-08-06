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
*-- 年兽召唤界面
* 
]]

local ActivityNianShouView = class("ActivityNianShouView",BaseLayer)

function ActivityNianShouView:ctor( data )
	self.super.ctor(self,data)
	self.activityInfo = data
	self.nianBeastIdIndex = {}
	self:init("lua.uiconfig.activity.ActivityNianShouView")
end

function ActivityNianShouView:initUI( ui )
	self.super.initUI(self,ui)
	self.tip1 = TFDirector:getChildByPath(ui,"tip1");
	self.btn_call = TFDirector:getChildByPath(ui,"btn_call");
	self.btn_go = TFDirector:getChildByPath(ui,"btn_go");
	self.tip2 = TFDirector:getChildByPath(ui,"tip2");
	self.txt_num = TFDirector:getChildByPath(ui,"txt_num");
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item");
	local stage2Cfg = self.activityInfo.extendData.stageDesc[2]
	local stage3Cfg = self.activityInfo.extendData.stageDesc[3]

	local startTime = string.sub(stage2Cfg.startTime,0,10)
	local endTime = string.sub(stage3Cfg.endTime,0,10)
	self.tip1:setTextById(13100057,startTime,endTime)
	self:flushState( )
end

function ActivityNianShouView:registerEvents( )
	self.super.registerEvents(self)

	self.btn_call:onClick(function ( ... )
		-- 发送召唤年兽请求
		if GoodsDataMgr:getItemCount(self.activityInfo.extendData.firecarkerId) > 0 then
			local args = {
	            tittle = 2107025,
	            reType = "arrestnianshou",
	            content = TextDataMgr:getText(13100062),
	            confirmCall = function ( ... )
					TFDirector:send(c2s.SPRING_FESTIVAL_REQ_USE_FIRECRACKER,{})
	            end,
	        }
	        Utils:showReConfirm(args)
		    return
		else
			Utils:showTips(13100063)
		end
	end)
	EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_NIANBREAST, function ( ... )
			local nianshouData = ActivityDataMgr2:getNianShouData( )
			local index = self.nianBeastIdIndex[nianshouData.id]
			self:playPMDAni(index,function ( ... )
				self:flushState()
				local nianshouData = ActivityDataMgr2:getNianShouData( )
				Utils:openView("activity.NianShouCallSuccessTip",nianshouData)
				self.btn_call:setTouchEnabled(true)
			end)
		end)

	self.btn_go:onClick(function ( ... )
		-- 调转城建主界面
		AlertManager:closeLayer(self)
		FunctionDataMgr:jCity()
	end)
end

function ActivityNianShouView:flushState( )
	local cfgs = TabDataMgr:getData("NianBeast")
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityInfo.id)
    local hasNianshou = ActivityDataMgr2:getNianShouState( )
	local idx = 1
	for k,v in pairs(cfgs) do
		if idx > 5 then break end
		if not self.nianBeastIdIndex[v.id] then
			self.nianBeastIdIndex[v.id] = idx
		end
		local pos = TFDirector:getChildByPath(self.ui,"pos"..idx)
		if not pos.item then
			local item = self.panel_item:clone()
			item:setPosition(me.p(0,0))
			pos:addChild(item)
			pos.item = item
			self.itemNodes = self.itemNodes or {}
			table.insert(self.itemNodes, item)
		end

		local itemNode = pos.item
		-- 填充数据
		if itemNode then
			local image_bg = TFDirector:getChildByPath(itemNode,"image_bg")
			local image_head = TFDirector:getChildByPath(itemNode,"image_head")
			if hasNianshou and self.activityInfo.extendData.nianBeastId == v.id then
				image_bg:setTexture("ui/activity/newYear/nianshou/003.png")
				image_head:onClick(function (  )
					local nianshouData = ActivityDataMgr2:getNianShouData()
					Utils:openView("activity.NianShouCallSuccessTip",nianshouData)
				end)
			else
				image_bg:setTexture("ui/activity/newYear/nianshou/002.png")
				image_head:onClick(function (  )
					Utils:openView("activity.NianShouTip",v.id)
				end)
			end
			image_head:setTexture(v.headIcon)
		end
		idx = idx + 1
	end

	self.txt_num:setText(GoodsDataMgr:getItemCount(self.activityInfo.extendData.firecarkerId))
	if hasNianshou then
		self.btn_go:setVisible(true)
		self.btn_call:setVisible(false)
	else
		self.btn_go:setVisible(false)
		self.btn_call:setVisible(true)
	end	

end

function ActivityNianShouView:onShow()
	self.super.onShow(self)
end

function ActivityNianShouView:playPMDAni( endIndex, callBack )
	local delayTime = 0.1
	local repeatCount = 4
	local endDelayTime = 1
	self.btn_call:setTouchEnabled(false)
	for i = 1,#self.itemNodes do
		local node = self.itemNodes[i]
		local callFun1 = CallFunc:create(function()
				local image_bg = TFDirector:getChildByPath(node,"image_bg")
				image_bg:setTexture("ui/activity/newYear/nianshou/003.png")
			end)

		local callFun2 = CallFunc:create(function()
				local image_bg = TFDirector:getChildByPath(node,"image_bg")
				image_bg:setTexture("ui/activity/newYear/nianshou/002.png")
			end)
		local delayAni1 = DelayTime:create(delayTime)
		local delayAni2 = DelayTime:create(delayTime*(#self.itemNodes - 1))
        local arr = {}
        table.insert(arr,callFun1)
        table.insert(arr,delayAni1)
        table.insert(arr,callFun2)
        table.insert(arr,delayAni2)
		local seq = CCSequence:create(arr)
		local arr1 = {}
        table.insert(arr1,DelayTime:create(delayTime*(i - 1)))
        local index = 5 - (endIndex + 5 - i)%5
        local time = (index + 1)*index/2*(endDelayTime/5)
		if i < endIndex then
        	table.insert(arr1,CCRepeat:create(seq,repeatCount - 1))
        	table.insert(arr1,DelayTime:create(time))
        	table.insert(arr1,callFun1:clone())
        	table.insert(arr1,DelayTime:create(delayTime + time/3))
        	table.insert(arr1,callFun2:clone())
			node:runAction(CCSequence:create(arr1))
		elseif i == endIndex then
        	table.insert(arr1,CCRepeat:create(seq,repeatCount-1))
			table.insert(arr1,DelayTime:create(time))
			table.insert(arr1,callFun1:clone())
			table.insert(arr1,CallFunc:create(function ( ... )
				local spineAni = TFDirector:getChildByPath(node,"spine_ani")
				local image_bg = TFDirector:getChildByPath(node,"image_bg")
				spineAni:setVisible(true)
				image_bg:setVisible(false)
				spineAni:playByIndex(0,-1,-1,0)
				spineAni:addMEListener(TFARMATURE_COMPLETE,function()
 	                    spineAni:setVisible(false)
						image_bg:setVisible(true)
						callBack()
  	                end)
			end))
			node:runAction(CCSequence:create(arr1))
		elseif i > endIndex then
        	table.insert(arr1,CCRepeat:create(seq,repeatCount-2))
        	table.insert(arr1,DelayTime:create(time))
        	table.insert(arr1,callFun1:clone())
        	table.insert(arr1,DelayTime:create(delayTime + time/3))
        	table.insert(arr1,callFun2:clone())
			if repeatCount ~= 0 then
				node:runAction(CCSequence:create(arr1))
			end
		end
	end
end
return ActivityNianShouView