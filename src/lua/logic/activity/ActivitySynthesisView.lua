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
*-- 道具合成界面 
]]

local ActivitySynthesisView = class("ActivitySynthesisView",BaseLayer)

function ActivitySynthesisView:ctor( data )
	self.super.ctor(self,data)
	self.synthesisNum = 0
	self.activityInfo = data
	local composeId = self.activityInfo.extendData.firecarkerId
	self.composeCfg = TabDataMgr:getData("Compose",composeId)
	self:init("lua.uiconfig.activity.ActivitySynthesisView")
end

function ActivitySynthesisView:initUI( ui )
	self.super.initUI(self,ui)

	self.synthesis_num = TFDirector:getChildByPath(ui,"synthesis_num");
	self.btn_add = TFDirector:getChildByPath(ui,"btn_add");
	self.btn_sub = TFDirector:getChildByPath(ui,"btn_sub");
	self.btn_synthesis = TFDirector:getChildByPath(ui,"btn_synthesis");
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item");
	self.spine_ani = TFDirector:getChildByPath(ui,"spine_ani");
	self.spine_ani1 = TFDirector:getChildByPath(ui,"spine_ani1");

	
	local pos4 = TFDirector:getChildByPath(self.ui,"pos"..4)

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
   	Panel_goodsItem:AddTo(pos4):Pos(0, 0)
	self.mainItem = Panel_goodsItem
	self:flushContent()
end

function ActivitySynthesisView:registerEvents( )
	self.super.registerEvents(self)

	self.btn_add:onClick(function ( ... )
		self.synthesisNum = self.synthesisNum + 1
		local maxNum = self:getMaxCanSynthesisNum( )
		self.synthesisNum = math.min(maxNum,self.synthesisNum)
		self:flushContent()
	end)

	self.btn_sub:onClick(function ( ... )
		self.synthesisNum = self.synthesisNum - 1 
		self.synthesisNum = math.max(0,self.synthesisNum)
		self:flushContent()
	end)

	self.btn_synthesis:onClick(function ( ... )
		local num,canSythesis = self:getMaxCanSynthesisNum()
		if self.synthesisNum > 0 and canSythesis then
    		TFDirector:send(c2s.SPRING_FESTIVAL_REQ_COMPOSE_FIRECRACKER,{self.composeCfg.id, self.synthesisNum})
    	elseif self.synthesisNum > 0 and not canSythesis then
    		Utils:showTips(13100077)
    	else
    		Utils:showTips(13100078)
		end
	end)

    EventMgr:addEventListener(self, EV_ACTIVITY_COMPOSE_SUC, handler(self.onSysthesisSuc, self))
end

function ActivitySynthesisView:onSysthesisSuc(event)
	self.spine_ani:playByIndex(0,-1,-1,0)
	self.spine_ani:show()
	self.spine_ani:addMEListener(TFARMATURE_COMPLETE,function()
					self.spine_ani:hide()
					self.spine_ani1:playByIndex(1,-1,-1,0)
					self.spine_ani1:show()
					self.spine_ani1:addMEListener(TFARMATURE_COMPLETE,function()
							self.spine_ani1:hide()
							self.synthesisNum = 0
							self:flushContent()
							Utils:showTips(13100079)
						end)
	                end)
end

function ActivitySynthesisView:getMaxCanSynthesisNum( )
	local maxNum = 9999
	local consumes = self.composeCfg.needItem or {}
	for k,v in pairs(consumes) do
		local hasNum = GoodsDataMgr:getItemCount(k)
		maxNum = math.min(maxNum,math.floor(hasNum/v))
	end
	local canSythesis = true
	if maxNum == 0 then
		canSythesis = false
	end
	maxNum = math.max(maxNum,1)
	return maxNum,canSythesis
end

function ActivitySynthesisView:flushContent()
	PrefabDataMgr:setInfo(self.mainItem,self.composeCfg.id,GoodsDataMgr:getItemCount(self.composeCfg.id))
	self.synthesis_num:setText(self.synthesisNum)
	local consumes = self.composeCfg.needItem or {}
	local consumeId
	for i = 1,3 do
		local pos = TFDirector:getChildByPath(self.ui,"pos"..i)
		if not pos.item then
			local item = self.panel_item:clone()
			pos:addChild(item)
			item:setPosition(me.p(0,0))
			pos.item = item
		end
		local id,num = next(consumes,consumeId)
		if id then
			consumeId = id
			pos:setVisible(true)
			self:flushItem(pos.item,{id,num})
		else
			pos:setVisible(false)
		end
	end
end

function ActivitySynthesisView:flushItem(itemNode,consume)
	local pos = TFDirector:getChildByPath(itemNode,"pos")
	if not pos.itemNode then
	    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	   	Panel_goodsItem:AddTo(pos):Pos(0, 0)
	   	pos.itemNode = Panel_goodsItem
   	end
	local need_num = TFDirector:getChildByPath(itemNode,"need_num")
	local has_num = TFDirector:getChildByPath(itemNode,"has_num")

	PrefabDataMgr:setInfo(pos.itemNode,consume[1])
	need_num:setText(self.synthesisNum*consume[2])
	has_num:setText(GoodsDataMgr:getItemCount(consume[1]))
end

return ActivitySynthesisView