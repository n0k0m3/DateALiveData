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
*  -- 白色情人节活动
]]

local WhiteValentineActivityView = class("WhiteValentineActivityView",BaseLayer)

function WhiteValentineActivityView:ctor( data )
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.activity.whiteValentineActivityView")
end

function WhiteValentineActivityView:initData(data)
	self.activityId = data
	self.selectIndex = 1
end

function WhiteValentineActivityView:initUI( ui )
	self.super.initUI(self,ui)

	self.panel_content = TFDirector:getChildByPath(ui, "panel_content")
	self.panel_roleModel = TFDirector:getChildByPath(ui,"panel_roleModel")
	self.image_bg = TFDirector:getChildByPath(ui, "image_bg")
	self.image_bg.initPosX = self.image_bg:getPositionX()
	self.txt_num = TFDirector:getChildByPath(ui, "txt_num")

	self.panel_item = TFDirector:getChildByPath(ui, "panel_item"):hide()

	self.btn_exchange = TFDirector:getChildByPath(ui,"btn_exchange")
	self.Spine_effectHB =TFDirector:getChildByPath(ui,"effectHB")
	self.Spine_effectH =TFDirector:getChildByPath(ui,"effectH")

	self.time_time = TFDirector:getChildByPath(ui, "time_time")
    self.time_time_end = TFDirector:getChildByPath(ui, "time_time_end")

	self.tab_1 = TFDirector:getChildByPath(ui, "tab_1")
	self.tab_2 = TFDirector:getChildByPath(ui, "tab_2")
	self.tab_1.index = 1
	self.tab_2.index = 2

	local scroll_cost = TFDirector:getChildByPath(ui, "scroll_cost")
	self.costList = UIListView:create(scroll_cost)
	self.costList:setItemsMargin(34)

	self:selectTab(1)
end

function WhiteValentineActivityView:selectTab(index)
	self.selectIndex = index
	self:updateTab()
	self:refreshView()
end

function WhiteValentineActivityView:updateTab()
	if self.selectIndex == 1 then
		self.tab_1:setTouchEnabled(false)
		self.tab_1:setBright(false)
		self.tab_2:setTouchEnabled(true)
		self.tab_2:setBright(true)
	else
		self.tab_1:setTouchEnabled(true)
		self.tab_1:setBright(true)
		self.tab_2:setTouchEnabled(false)
		self.tab_2:setBright(false)
	end
end

function WhiteValentineActivityView:refreshView()
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local startStr =  Utils:getDateString(activityInfo.startTime)
    local endStr =  Utils:getDateString(activityInfo.endTime)
    self.time_time:setText(startStr)
    self.time_time_end:setText(endStr)

	local itemId = self:getCurItemId()
    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

	local dressId = self:getDressId()
	if dressId then
	    local dressTable = TabDataMgr:getData("Dress")
	    local dressData = dressTable[dressId]
	    if dressData and dressData.type and dressData.type == 2 then
	        modelId = dressData.highRoleModel
	    else
	    	modelId = dressData.roleModel
	    end

	    if self.elvesNpc then
	        self.elvesNpc:removeFromParent()
	        self.elvesNpc = nil
	    end

	    if not self.elvesNpc then
		    local elvesNpcTable = ElvesNpcTable:createLive2dNpcID(modelId,true,false,nil,false)
		    if not elvesNpcTable then
		        return
		    else
		        self.elvesNpc = elvesNpcTable.live2d
		    end

		    local offPos = dressData.offSet
		    if dressData and dressData.type and dressData.type == 2 then
		        if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
		            self.elvesNpc:setPosition(ccp(-50,-80) + ccp(offPos.x,offPos.y))
		        else
		            self.elvesNpc:setPosition(ccp(-50,-80));--位置
		        end
		    else
		        self.elvesNpc:setPosition(ccp(-50,-80));--位置
		    end
			self.panel_roleModel:addChild(self.elvesNpc)
	    	self.elvesNpc:setScale(0.7); --缩放
		end
		if dressData.background and #dressData.background ~= 0 then
	        spbackground = dressData.background
	    end

	    if spbackground then
	        if dressData.kanbanEffect and dressData.kanbanEffect ~= 0 then
	            self:refreshEffect(dressData.kanbanEffect)
	        else
	            self.effectSK = self.effectSK or {}
	            for k,v in pairs(self.effectSK) do
	                v:removeFromParent()
	                self.effectSK[k] = nil
	            end
	        end
	        self.effectSK = self.effectSK or {}
	        for k,v in pairs(self.effectSK) do
	            v:show()
	        end
	        if dressData.backgroundEffect and dressData.backgroundEffect ~= 0 then
	            self:refreshEffect(dressData.backgroundEffect,true)
	        else
	            self.effectSKB = self.effectSKB or {}
	            for k,v in pairs(self.effectSKB) do
	                v:removeFromParent()
	                self.effectSKB[k] = nil
	            end
	        end
	        self.effectSKB = self.effectSKB or {}
	        for k,v in pairs(self.effectSKB) do
	            v:show()
	        end
	        self.image_bg:setTexture(spbackground)
	    else
	        self.effectSK = self.effectSK or {}
	            for k,v in pairs(self.effectSK) do
	                v:removeFromParent()
	                self.effectSK[k] = nil
	            end
	        self.effectSKB = self.effectSKB or {}
	        for k,v in pairs(self.effectSKB) do
	            v:removeFromParent()
	            self.effectSKB[k] = nil
	        end
	    end
	end

	local size = self.panel_content:getContentSize()
	local scale = math.max(size.width/self.image_bg:getContentSize().width,size.height/self.image_bg:getContentSize().height)
	self.image_bg:setScale(scale)
	self.image_bg:setPositionX(self.image_bg.initPosX + 30)

	local canExchange = true
	local unLock = GoodsDataMgr:getDress(dressId)
	if unLock then
		canExchange = false
	end

	local costItems = {}
	for k, v in pairs(itemInfo.target) do
       	local num = GoodsDataMgr:getItemCount(k)
       	if num < v and (not unLock) then
       		canExchange = false
       	end
        table.insert(costItems, {id = k, num = v})
	end
	self:updateExchangeList(costItems)

  	local progress = progressInfo.progress or 0
  	local count = itemInfo.extendData.limitVal - progress
	self.txt_num:setText(count)

	self.btn_exchange:setTouchEnabled(canExchange and count > 0)
	self.btn_exchange:setGrayEnabled(not (canExchange and count > 0))
end

function WhiteValentineActivityView:updateExchangeList(data)
	data = data or {}
	local items = self.costList:getItems()
    local gap = #items - #data
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.costList:removeItem(1)
        else
            local goodsItem = self.panel_item:clone()
            goodsItem:show()
            self.costList:pushBackCustomItem(goodsItem)
        end
    end

    for i, goodsItem in ipairs(self.costList:getItems()) do
    	local img_di = TFDirector:getChildByPath(goodsItem, "img_di")
    	local img_icon = TFDirector:getChildByPath(goodsItem, "img_icon")
    	local img_gray = TFDirector:getChildByPath(goodsItem, "img_gray"):hide()
        local itemInfo = data[i]
        local itemCfg = GoodsDataMgr:getItemCfg(itemInfo.id)
        PrefabDataMgr:addItemId(goodsItem, itemInfo.id)
        img_icon:setTexture(itemCfg.icon)
        img_di:setTexture("ui/fairy_particle/" .. itemCfg.quality .. ".png")
        local num = GoodsDataMgr:getItemCount(itemInfo.id)
        if num >= itemInfo.num or unLock then
       		img_gray:hide()
       	else
       		img_gray:show()
       	end
       	img_di:setTouchEnabled(true)
       	img_di:onClick(function()
            Utils:showInfo(itemInfo.id, nil, true)
        end)
    end
end

function WhiteValentineActivityView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_effectH
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
    	local effect, cfg = Utils:createEffectByEffectId(effectId)
        if effect then			
			local x = (cfg["offset"]["x"] or 0)
			local y = (cfg["offset"]["y"] or 0)
			effect:setPosition(ccp(prefab:getPositionX() + x - 125, prefab:getPositionY() + y))
            effect.savePos = effect:getPosition()
            effect:setZOrder(prefab:getZOrder())
			prefab:getParent():addChild(effect)
			table.insert(mgrTab, effect)
        end
    end
end

function WhiteValentineActivityView:onSubmitSuccessEvent(activitId, itemId, reward)
	if self.activityId == activitId then
		Utils:showReward(reward)
	end
end

function WhiteValentineActivityView:updateActivity()
    self:refreshView()
end

function WhiteValentineActivityView:onUpdateProgressEvent()
    self:refreshView()
end

function WhiteValentineActivityView:onTabBtnHandle(sender)
	local index = sender.index or 1
	self:selectTab(index)
end

function WhiteValentineActivityView:registerEvents()
	self.btn_exchange:onClick(function(...)
		local itemId = self:getCurItemId()
		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemId, 1)
	end)

	self.tab_1:onClick(handler(self.onTabBtnHandle, self))
	self.tab_2:onClick(handler(self.onTabBtnHandle, self))

	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.refreshView, self))
end

function WhiteValentineActivityView:getDressId()
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	if self.selectIndex == 1 then
		return activityInfo.extendData.dressId
	else
		return activityInfo.extendData.dressId2
	end
end

function WhiteValentineActivityView:getCurItemId()
	local items = ActivityDataMgr2:getItems(self.activityId)
	if self.selectIndex > #items then
		return items[#items]
	else
		return items[self.selectIndex]
	end
end

return WhiteValentineActivityView