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
* -- 圣诞改造界面
]]

local ChristmasRebuildView = class("ChristmasRebuildView",BaseLayer)

function ChristmasRebuildView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:showPopAnim(true)
	self.talents = TabDataMgr:getData("FactoryReform")
	self.tabIds = clone(table.keys(self.talents))
	table.sort(self.tabIds,function ( a, b)
		return a <  b
	end)
	self.curKey = 1
	self:init("lua.uiconfig.activity.christmasRebuildView")
end

function ChristmasRebuildView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	
	self.Label_skillName = TFDirector:getChildByPath(ui,"Label_skillName")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Button_gaizao = TFDirector:getChildByPath(ui,"Button_gaizao")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_cost = {}
	self.Panel_cost[1] = TFDirector:getChildByPath(ui,"Panel_cost1")
	self.Panel_cost[2] = TFDirector:getChildByPath(ui,"Panel_cost2")
	self.Panel_cost[3] = TFDirector:getChildByPath(ui,"Panel_cost3")
	self.Panel_skillItem = TFDirector:getChildByPath(ui,"Panel_skillItem")
	self.Label_gaizao = TFDirector:getChildByPath(ui,"Label_gaizao")
	self.Label_gaizao_1 = TFDirector:getChildByPath(ui,"Label_gaizao_1")


	self.ScrollView_skill = TFDirector:getChildByPath(ui,"ScrollView_skill")


	self.Image_container = TFDirector:getChildByPath(ui,"Image_container")

	self.pos = {}

	for i = 1,17 do
		self.pos[i] = TFDirector:getChildByPath( self.Image_container,"pos"..i)
	end
 	self:refreshView()
end

function ChristmasRebuildView:refreshView()
	-- body
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS_FIGHT)[1]
    self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)

    if (not activityId) or (not self.activityInfo) then 
    	AlertManager:closeLayer(self) 
    	return 
    end

  	if not self.activityInfo.factoryInfo then
	    return
	end	

    
	for k,v in pairs(self.pos) do
		if not v.skillItem then
			local skillItem = self.Panel_skillItem:clone()
			skillItem:show()
			skillItem:setPosition(ccp(0,0))
			v:addChild(skillItem)
			v.skillItem = skillItem
		end

		self:updateSkillItem(v.skillItem, k)
	end

	-- body
	local id = self.tabIds[self.curKey]

	local curTalentInfo = self.talents[id]

	self.Label_skillName:setTextById(curTalentInfo.name)
	self.Label_des:setTextById(curTalentInfo.describ)

	self:updateCost(curTalentInfo)
	self:focusSkill(self.curKey)


	local canActive, preUnLock, hasActive = self:checkTalentsStatus(id)


	for k,v in ipairs(self.Panel_cost) do
		v:setVisible(v:isVisible() and not hasActive)
	end
	self.Label_gaizao:setVisible(not hasActive)
	self.Label_gaizao_1:setVisible(hasActive)
	self.Button_gaizao:setGrayEnabled(hasActive)
	self.Button_gaizao:setTouchEnabled(not hasActive)
end

function ChristmasRebuildView:updateCost( info )
	-- body
	local costs = info.cost
	local id
	local num
	for k,v in ipairs(self.Panel_cost) do
		v:hide()
	end
	for k,v in ipairs(self.Panel_cost) do
		id,num = next(info.cost, id)
		if not id then return end
		v:show()
		local Image_icon = TFDirector:getChildByPath(v,"Image_icon")
		local Label_num = TFDirector:getChildByPath(v,"Label_num")
		Image_icon:setTexture(GoodsDataMgr:getItemCfg(id).icon)
		Label_num:setText(GoodsDataMgr:getItemCount(id).."/"..num)

		if GoodsDataMgr:getItemCount(id) < num then
			Label_num:setColor(ccc3(255,0,0))
		else
			Label_num:setColor(ccc3(255,255,255))
		end
		Image_icon:setTouchEnabled(true)
		local itemId = id
		Image_icon:onClick(function ( ... )
			-- body
			Utils:showInfo(itemId)
		end)
	end
end

function ChristmasRebuildView:updateSkillItem( item, key)
	-- body
	local id = self.tabIds[key]

	local talentInfo = self.talents[id]



	local image_sel = TFDirector:getChildByPath(item,"image_sel")
	local image_icon = TFDirector:getChildByPath(item,"image_icon")
	local Label_level = TFDirector:getChildByPath(item,"Label_level")
	Label_level:setSkewX(10)
	image_sel:setVisible(key == self.curKey)
	local imagePath = talentInfo.icon
	local talentInfos = self.activityInfo.factoryInfo.talents or {}
	if table.find(talentInfos,id) == -1 then
		imagePath = string.sub(imagePath, 0, -5).."_1.png"
	end

	image_icon:setTexture(imagePath)
	Label_level:setText(talentInfo.level)
	image_icon:setTouchEnabled(true)
	image_icon:onClick(function ( ... )
		-- body
		self:selectSkill(key)
	end)
end

function ChristmasRebuildView:selectSkill( key )
	-- body
	if self.curKey == key then
		return
	end

	self.curKey = key
	self:refreshView()
end

function ChristmasRebuildView:focusSkill( key )
	-- body
	local minOffset = self.ScrollView_skill:getContentSize().height - self.Image_container:getContentSize().height
	local pos = self.ScrollView_skill:getContentSize().height/2 - (self.pos[key]:getPositionY() + self.Image_container:getContentSize().height/2) 

 	local percentY = 0
    if pos ~= 0 then
        percentY = pos * 100 / minOffset
    end
    percentY = 100 - percentY

    percentY = math.max(0,percentY)
    percentY = math.min(100,percentY)
    self.ScrollView_skill:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_VERTICAL, 0.2, false, 0, percentY)
end


function ChristmasRebuildView:registerEvents( ... )
	self.super.registerEvents(self)

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	self.Button_gaizao:onClick(function ( ... )

		local id = self.tabIds[self.curKey]

		local canActive, preUnLock, hasActive = self:checkTalentsStatus(id)

		if not canActive then
			Utils:showTips(2130504) -- 材料不足
		elseif not preUnLock then
			Utils:showTips(2130505) -- 前置条件未解锁
		elseif hasActive then
		else
			ActivityDataMgr2:request_CHRISTMAS_REQ2019_CHRISTMAS_TALENT( id )
		end 

	end)

    
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function ( ... )
        self:refreshView()
    end)
	
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
        self:refreshView()
    end)
end

function ChristmasRebuildView:removeEvents()
	-- body
	self.super.removeEvents(self)
end

function ChristmasRebuildView:checkIsActive( id )
	local talentInfos = self.activityInfo.factoryInfo.talents or {}
	return table.find(talentInfos, id) ~= -1
end

function ChristmasRebuildView:checkTalentsStatus( id )
	-- body
	local curTalentInfo = self.talents[id]
	local canActive = true
	for k,v in pairs(curTalentInfo.cost) do
		if GoodsDataMgr:getItemCount(k) < v then
			canActive = false
			break;
		end
	end

	local preUnLock = true
	for k,v in pairs(curTalentInfo.unlock) do
		if not self:checkIsActive(v) then
			preUnLock = false
			break
		end
	end

	local hasActive = self:checkIsActive(id)

	return canActive,preUnLock,hasActive
end

return ChristmasRebuildView