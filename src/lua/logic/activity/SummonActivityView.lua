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
* -- 召唤活动界面
]]

local SummonActivityView = class("SummonActivityView",BaseLayer)

function SummonActivityView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self:init("lua.uiconfig.activity.summonActivity")
end

function SummonActivityView:initUI( ui )
	self.super.initUI(self,ui)
	local panel_content = TFDirector:getChildByPath(ui,"panel_content")
	self.Spine_effectHB =TFDirector:getChildByPath(panel_content,"effectHB")
	self.Spine_effectH =TFDirector:getChildByPath(panel_content,"effectH")
	self.image_bg = TFDirector:getChildByPath(panel_content,"image_bg")
	self.border_black = TFDirector:getChildByPath(ui,"border_black")
	self.label_activityTime = TFDirector:getChildByPath(ui,"label_activityTime")
	self.Button_preview = TFDirector:getChildByPath(ui,"Button_preview")
	self.Button_history = TFDirector:getChildByPath(ui,"Button_history")
	self.Button_buy = {}
	local panel_one = TFDirector:getChildByPath(ui,"panel_one")
    local item = {}
    item.root = TFDirector:getChildByPath(panel_one,"Button_one")
    item.Image_costIcon = TFDirector:getChildByPath(panel_one,"Image_icon")
    item.Label_costNum = TFDirector:getChildByPath(panel_one,"Label_num")
    self.Button_buy[1] = item

    self.label_get_num = TFDirector:getChildByPath(ui,"label_get_num"):hide()

	local panel_ten = TFDirector:getChildByPath(ui,"panel_ten")
	local item1 = {}
    item1.root = TFDirector:getChildByPath(panel_ten,"Button_ten")
    item1.Image_costIcon = TFDirector:getChildByPath(panel_ten,"Image_icon")
    item1.Label_costNum = TFDirector:getChildByPath(panel_ten,"Label_num")
    self.Button_buy[2] = item1

	local own_prop = TFDirector:getChildByPath(ui,"own_prop")
	self.ownPropIcon = TFDirector:getChildByPath(own_prop,"Image_icon")
	self.ownNum = TFDirector:getChildByPath(own_prop,"Label_num")

    self:refreshView()
    self:updateSummonInfo()
    self:updateSummonCnt()
end

function SummonActivityView:refreshView(  )
	local panel_content = TFDirector:getChildByPath(self,"panel_content")
	local panel_roleModel = TFDirector:getChildByPath(panel_content,"panel_roleModel")
	local image_bg = self.image_bg
	local size = panel_content:getContentSize()

	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local itemId = ActivityDataMgr2:getItems(self.activityId)[1]

    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)

	if activityInfo.extendData.dress then
	    local dressTable = TabDataMgr:getData("Dress")
	    local dressData = dressTable[activityInfo.extendData.dress]
	    local spbackground = activityInfo.extendData.bg
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

	self.border_black:setTexture(activityInfo.extendData.mask)
	self.label_activityTime:setTextById()
end

function SummonActivityView:refreshEffect(effectIds,isBgEffect)
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

function SummonActivityView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
    	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    	self:refreshView()
    	self:updateSummonInfo()
    end)
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE,  function ( ... )
        self:updateSummonInfo()
    end)
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_COUNT_UPDATE, handler(self.updateSummonCnt, self))

    self.Button_preview:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.activityInfo.extendData.summon[1])
        Utils:openView("summon.SummonPreviewView", summonCfg.groupId)
    end)

    self.Button_history:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.activityInfo.extendData.summon[1])
        SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
    end)

    for i, v in ipairs(self.Button_buy) do
        v.root:onClick(function()
                local cost = self.costItem_[i]
                if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
                    local function reaSummon()
                        SummonDataMgr:send_SUMMON_SUMMON(tonumber(self.activityInfo.extendData.summon[i]), cost.index)
                    end
                    if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_Summon) then
                        reaSummon()
                    else
                        local rstr = TextDataMgr:getTextAttr(1200042 + i -1)
                        local formatStr = rstr and rstr.text or ""
                        local content = string.format(formatStr, cost.num, TabDataMgr:getData("Item", cost.id).icon)
                        Utils:openView("common.ReConfirmTipsView", {tittle = 1200041, content = content, reType = EC_OneLoginStatusType.ReConfirm_Summon, confirmCall = reaSummon})
                    end
                else
                    local summonCfg = SummonDataMgr:getSummonCfg(self.activityInfo.extendData.summon[i])
                    if summonCfg.costCommodity == 0 then
                        Utils:showAccess(cost.id)
                    else
                        local haveCount = GoodsDataMgr:getItemCount(cost.id)
                        Utils:openView("summon.SummonBuyResourceView", summonCfg.costCommodity, cost.num - haveCount)
                    end
                end
        end)
    end
end

function SummonActivityView:onSummonResultEvent(reward, staticItem)
    Utils:showReward(reward or {}, staticItem or {})
end

function SummonActivityView:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView",historyData)
end

function SummonActivityView:updateSummonInfo(  )
    local summon = self.activityInfo.extendData.summon or {}
	self.costItem_ = {}
    local showCostCid
    for i, v in ipairs(self.Button_buy) do
        v.root:setVisible(tobool(summon[i]))
        v.root:setGrayEnabled(false);
        v.root:setTouchEnabled(true);

        if v.root:isVisible() then
            local summonCfg = SummonDataMgr:getSummonCfg(summon[i])
            --v.Label_summon:setTextById(1200006, summonCfg.cardCount)
            for j, cost in ipairs(summonCfg.cost) do
                local costIndex = j
                local costId, costNum
                for id, num in pairs(cost) do
                    costId = id
                    costNum = num
                    break
                end

                if not showCostCid then
                    if GoodsDataMgr:getItemCount(costId) > 0 then
                        showCostCid = costId
                    else
                        if j == #summonCfg.cost then
                            showCostCid = costId
                        end
                    end
                end

                local costCfg = GoodsDataMgr:getItemCfg(costId)
                costicon = costCfg.icon
                v.Image_costIcon:setTexture(costCfg.icon)
                v.Label_costNum:setTextById(800007, costNum)
                self.costItem_[i] = {
                    id = costId,
                    num = costNum,
                    index = costIndex,
                }
                if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                    break
                end
            end
        end
    end

    local summonCfg = SummonDataMgr:getSummonCfg(self.activityInfo.extendData.summon[1])
    local cost = summonCfg.cost[1]
    local cost = summonCfg.cost[1]
    local ownCostId
    for k, v in pairs(cost) do
        ownCostId = k
        break
    end

    self.label_activityTime:setText("")
    if self.activityInfo.startTime and self.activityInfo.endTime then
        local startShow = TFDate(self.activityInfo.startTime):tolocal():fmt("%Y.%m.%d")
        local endShow = TFDate(self.activityInfo.endTime):tolocal():fmt("%Y.%m.%d")
        self.label_activityTime:setTextById(14300100, startShow, endShow)
    end
    local costCfg = GoodsDataMgr:getItemCfg(ownCostId)
    self.ownPropIcon:setTexture(costCfg.icon)
    self.ownNum:setText(GoodsDataMgr:getItemCount(ownCostId))
    self.costItemId_ = ownCostId
end

function SummonActivityView:updateSummonCnt()
    self.label_get_num:hide()
    if self.activityInfo and self.activityInfo.extendData and self.activityInfo.extendData.dis == 1 then
        local summonTab = self.activityInfo.extendData.summon
        local totalCnt = 0
        for k, v in ipairs(summonTab or {}) do
            totalCnt = totalCnt + SummonDataMgr:getSummonCount(v)
        end
        self.label_get_num:show()
        self.label_get_num:setTextById(2130519, totalCnt)
    end
end

return SummonActivityView