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
	self.activityId = data
	self:init("lua.uiconfig.activity.whiteValentineActivityView")
end

function WhiteValentineActivityView:initUI( ui )
	self.super.initUI(self,ui)
	self.btn_exchange = TFDirector:getChildByPath(ui,"btn_exchange")
	self.Spine_effectHB =TFDirector:getChildByPath(ui,"effectHB")
	self.Spine_effectH =TFDirector:getChildByPath(ui,"effectH")
	local btn_huigu = TFDirector:getChildByPath(ui,"btn_huigu")

	self.btn_exchange:onClick(function ( ... )
		local itemId = ActivityDataMgr2:getItems(self.activityId)[1]
		ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, itemId, 1)
	end)
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	if activityInfo.extendData.huigu and activityInfo.extendData.huigu ~= "" then
		btn_huigu:show()
	else
		btn_huigu:hide()
	end
	btn_huigu:onClick(function ( ... )
		Utils:openView("activity.ValentineReviewView",{id = self.activityId,huigu = activityInfo.extendData.huigu})
	end)
	self:refreshView()
end

function WhiteValentineActivityView:refreshView(  )
	local panel_content = TFDirector:getChildByPath(self,"panel_content")
	local image_bg = TFDirector:getChildByPath(self.ui,"image_bg")
	local image_title = TFDirector:getChildByPath(self.ui,"image_title")
	local panel_cost = TFDirector:getChildByPath(self.ui,"panel_cost")
	local txt_num = TFDirector:getChildByPath(self.ui,"txt_num")
	local panel_roleModel = TFDirector:getChildByPath(self.ui,"panel_roleModel")

	local size = panel_content:getContentSize()

	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local itemId = ActivityDataMgr2:getItems(self.activityId)[1]

    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
	image_title:setTexture(activityInfo.extendData.image_title)

	if activityInfo.extendData.dressId then
	    local dressTable = TabDataMgr:getData("Dress")
	    local dressData = dressTable[activityInfo.extendData.dressId]
	    if dressData and dressData.type and dressData.type == 2 then
	        modelId = dressData.highRoleModel
	    else
	    	modelId = dressData.roleModel
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
			panel_roleModel:addChild(self.elvesNpc)
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
	        image_bg:setTexture(spbackground)
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

	local scale = math.max(size.width/image_bg:getContentSize().width,size.height/image_bg:getContentSize().height)
    
	image_bg:setScale(scale)
	for i = 1,4 do
		local iconParent = TFDirector:getChildByPath(panel_cost,"panel_icon"..i)
		iconParent:hide()
	end

	local index = 1
	local canExchange = true
	local unLock = GoodsDataMgr:getDress(activityInfo.extendData.dressId)

	if unLock then
		canExchange = false
	end

	for k,v in pairs(itemInfo.target) do
		local iconParent = TFDirector:getChildByPath(panel_cost,"panel_icon"..index)
		iconParent:show()
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
       	Panel_goodsItem:AddTo(iconParent):Pos(0, 0)

        PrefabDataMgr:setInfo(Panel_goodsItem,k,v)
       	local num = GoodsDataMgr:getItemCount(k)
       	if num >= v or unLock then
       		iconParent:setGrayEnabled(false)
       	else
       		iconParent:setGrayEnabled(true)
       		canExchange = false
       	end
        index = index + 1
	end
  	local progress = progressInfo.progress or 0
  	local count = itemInfo.extendData.limitVal - progress
	txt_num:setText(count)

	self.btn_exchange:setTouchEnabled(canExchange and count > 0)
	self.btn_exchange:setGrayEnabled(not (canExchange and count > 0))
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
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
        mgrTab[effectId]:hide()
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

return WhiteValentineActivityView