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
local YanHuaComposeView = class("YanHuaComposeView",BaseLayer)

function YanHuaComposeView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self.curIdx = 1
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.composeIds = self.activityInfo.extendData.composeIds or {}
	self:initData()
	self:init("lua.uiconfig.activity.yanhuaComposeView")
end

function YanHuaComposeView:initData( ... )
	self.synthesisNum = 0
	local composeId = self.composeIds[self.curIdx]
	self.composeCfg = TabDataMgr:getData("Compose",composeId)
end

function YanHuaComposeView:initUI( ui )
	self.super.initUI(self,ui)

	self.btn_synthesis = TFDirector:getChildByPath(ui,"btn_synthesis");
	self.panel_item = TFDirector:getChildByPath(ui,"panel_item");
	self.Button_left = TFDirector:getChildByPath(ui,"Button_left");
	self.Button_right = TFDirector:getChildByPath(ui,"Button_right");
	self.spine_ani = TFDirector:getChildByPath(ui,"spine_ani");

	self.panel_synthesis = {}
	self.panel_synthesis[1] = TFDirector:getChildByPath(ui,"panel_synthesis_1");
	self.panel_synthesis[2] = TFDirector:getChildByPath(ui,"panel_synthesis_2");
	self.panel_synthesis[3] = TFDirector:getChildByPath(ui,"panel_synthesis_3");
	self.panel_synthesis[4] = TFDirector:getChildByPath(ui,"panel_synthesis_4");

	self.Panel_dotList = TFDirector:getChildByPath(ui,"Panel_dotList");
	self.Panel_dot = TFDirector:getChildByPath(ui,"Panel_dot");

	self.panel_dots = {}
	for i = 1,table.count(self.composeIds) do
		local dot = self.Panel_dot:clone()
		dot:setPosition(ccp((i - 1)*40,0))
		local image_n = TFDirector:getChildByPath(dot,"image_normal")
		self.panel_dots[i] = TFDirector:getChildByPath(dot,"image_light")
		image_n:onClick(function ( ... )
			-- body
			if self.curIdx == i then return end
			self.curIdx = i
			self:initData()
			self:flushContent()
		end)
		self.Panel_dotList:addChild(dot)
	end
	
	self:flushContent()
end

function YanHuaComposeView:registerEvents( )
	self.super.registerEvents(self)

	self.btn_synthesis:onClick(function ( ... )
		local num,canSythesis = self:getMaxCanSynthesisNum()
		if self.synthesisNum > 0 and canSythesis then
    		TFDirector:send(c2s.SPRING_FESTIVAL_REQ_COMPOSE_FIRECRACKER,{self.composeCfg.id ,self.synthesisNum})
    	elseif self.synthesisNum > 0 and not canSythesis then
    		Utils:showTips(12103050)
    	else
    		Utils:showTips(12103051)
		end
	end)

	self.Button_left:onClick(function ( ... )
		-- body
		if self.isScrolling or self.curIdx <= 1 then return end
		self.curIdx = math.max(1,self.curIdx - 1)
		self:initData()
		self:flushContent()

		if self.curPanel then
			local arry = {
				CCCallFunc:create(function ( ... )
					self.isScrolling = true
					self.curPanel:setOpacity(0)
					self.curPanel:setPositionX(self.curPanel:getPositionX() + 20)
				end),
				CCSpawn:create({CCFadeIn:create(0.5), CCMoveBy:create(0.5,ccp(-20,0))}),
				CCCallFunc:create(function ( ... )
					self.isScrolling = false
				end),
			}

			self.curPanel:runAction(CCSequence:create(arry))
		end
	end)

	self.Button_right:onClick(function ( ... )
		-- body
		if self.isScrolling or self.curIdx >= #self.composeIds then return end
		self.curIdx = math.min(#self.composeIds,self.curIdx + 1)
		self:initData()
		self:flushContent()
		if self.curPanel then
			local arry = {
				CCCallFunc:create(function ( ... )
					self.isScrolling = true
					self.curPanel:setOpacity(0)
					self.curPanel:setPositionX(self.curPanel:getPositionX() - 20)
				end),

				CCSpawn:create({CCFadeIn:create(0.5), CCMoveBy:create(0.5,ccp(20,0))}),
				CCCallFunc:create(function ( ... )
					self.isScrolling = false
				end),
			}

			self.curPanel:runAction(CCSequence:create(arry))
		end
	end)

    EventMgr:addEventListener(self, EV_ACTIVITY_COMPOSE_SUC, handler(self.onSysthesisSuc, self))
end

function YanHuaComposeView:onSysthesisSuc(event)
	self.spine_ani:playByIndex(0,-1,-1,0)
	self.spine_ani:show()
	TFAudio.playSound("sound/composeSuccess.mp3")
	self.spine_ani:addMEListener(TFARMATURE_COMPLETE,function()
					self.spine_ani:hide()
					self.spine_ani1:playByIndex(1,-1,-1,0)
					self.spine_ani1:show()
					self.spine_ani1:addMEListener(TFARMATURE_COMPLETE,function()
							self.spine_ani1:hide()
							self.synthesisNum = 0
							self:flushContent()
							Utils:showTips(12103052)
						end)
	                end)
end

function YanHuaComposeView:getMaxCanSynthesisNum( )
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

function YanHuaComposeView:flushContent()
	if (not self.composeCfg.needItem) or table.count(self.composeCfg.needItem) == 0 then return end

	for k,v in pairs(self.panel_synthesis) do
		if k == table.count(self.composeCfg.needItem) then
			v:show()
			self.curPanel = v
		else
			v:hide()
		end
	end

	for k,v in pairs(self.panel_dots) do
		if k == self.curIdx then
			v:show()
		else
			v:hide()
		end
	end

	local synthesis_num = TFDirector:getChildByPath(self.curPanel,"synthesis_num");
	local btn_add = TFDirector:getChildByPath(self.curPanel,"btn_add");
	local btn_sub = TFDirector:getChildByPath(self.curPanel,"btn_sub");
	self.spine_ani1 = TFDirector:getChildByPath(self.curPanel,"spine_ani1");



	btn_add:onClick(function ( ... )
		self.synthesisNum = self.synthesisNum + 1
		local maxNum = self:getMaxCanSynthesisNum( )
		self.synthesisNum = math.min(maxNum,self.synthesisNum)
		self:flushContent()
	end)

	btn_sub:onClick(function ( ... )
		self.synthesisNum = self.synthesisNum - 1 
		self.synthesisNum = math.max(0,self.synthesisNum)
		self:flushContent()
	end)

	local pos_item = TFDirector:getChildByPath(self.curPanel,"pos_item")

	if not pos_item.goodsItem then
	    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	   	Panel_goodsItem:AddTo(pos_item):Pos(0, 0)
		pos_item.goodsItem = Panel_goodsItem
		Panel_goodsItem:show()
	end

	PrefabDataMgr:setInfo(pos_item.goodsItem,self.composeCfg.id,GoodsDataMgr:getItemCount(self.composeCfg.id))
	synthesis_num:setText(self.synthesisNum)
	local consumes = self.composeCfg.needItem or {}
	local consumeId
	for i = 1,table.count(consumes) do
		local pos = TFDirector:getChildByPath(self.curPanel,"pos"..i)
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

function YanHuaComposeView:flushItem(itemNode,consume)
	local pos = TFDirector:getChildByPath(itemNode,"pos")
	if not pos.itemNode then
	    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    Panel_goodsItem:setScale(0.8)
	   	Panel_goodsItem:AddTo(pos):Pos(0, 0)
	   	pos.itemNode = Panel_goodsItem
   	end
	local need_num = TFDirector:getChildByPath(itemNode,"need_num")
	local has_num = TFDirector:getChildByPath(itemNode,"has_num")

	PrefabDataMgr:setInfo(pos.itemNode,consume[1])
	need_num:setText(self.synthesisNum*consume[2])
	has_num:setText(GoodsDataMgr:getItemCount(consume[1]))
end

return YanHuaComposeView