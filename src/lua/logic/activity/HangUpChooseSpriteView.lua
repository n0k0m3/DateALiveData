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
* -- 挂机选择精灵界面
]]
local HangUpChooseSpriteView = class("HangUpChooseSpriteView", BaseLayer)

function HangUpChooseSpriteView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.chooseSpriteView")
end

function HangUpChooseSpriteView:initData( activityId ,eventId)
	-- body
	self.activityId = activityId
	self.eventId = eventId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
end

function HangUpChooseSpriteView:initUI( ui )
	-- body
	self.super.initUI(self, ui)
	local ScrollView_sprite = TFDirector:getChildByPath(ui,"ScrollView_sprite")
	self.Panel_spriteItem = TFDirector:getChildByPath(ui,"Panel_spriteItem")
	self.uiList_sprite = UIListView:create(ScrollView_sprite)
  	self.uiList_sprite:setItemsMargin(5)
  	self:initSpriteList()
end

function HangUpChooseSpriteView:registerEvents(  )
	-- body
	self.super.registerEvents(self)
end

function HangUpChooseSpriteView:checkSpriteStatus( spriteInfo )
	-- body
	local eventInfo = nil
	local isWorking, isUpHero
	for k,v in pairs(self.activityInfo.data.eventList) do
		if spriteInfo.currentEventId == v.eventId then
			isWorking = true
			break;
		end
		
	end

	local eventCfg = TabDataMgr:getData("HangUpEvent",self.eventId)
	if table.find(eventCfg.upHero,spriteInfo.roleId) ~= -1 then
		isUpHero = true
	end
	
	return isWorking, isUpHero
end

function HangUpChooseSpriteView:initSpriteList( ... )
	-- body
	local sprites = self.activityInfo.data.hangUpRoleInfo or {}
	self.uiList_sprite:removeAllItems()
	for k,v in pairs(sprites) do
		local item = self.Panel_spriteItem:clone()
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Label_lv = TFDirector:getChildByPath(item,"Label_lv")
		local Image_working = TFDirector:getChildByPath(item,"Image_working")
		local Image_up = TFDirector:getChildByPath(item,"Image_up")

		local spriteInfo = TabDataMgr:getData("HangUpRole", v.roleId)
		local isWorking,isUpHero = self:checkSpriteStatus(v)

		Image_up:setVisible(isUpHero)
		Image_working:setVisible(isWorking)

		Image_icon:setTexture(spriteInfo.icon)
		Label_lv:setText("Lv."..v.level)
		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			-- body
			if isWorking then
				local eventCfg = TabDataMgr:getData("HangUpEvent",v.currentEventId)
				local eventName = TextDataMgr:getText(eventCfg.name)
				local args = {
		            tittle = 2107025,
		            content = TextDataMgr:getText(14300207,eventName),
		            reType = "UPHANGUPROLE",
		            confirmCall = function()
		            	if v.currentEventId ~= self.eventId then
							ActivityDataMgr2:send_ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE(self.activityId, v.roleId, true, self.eventId)
						end
						AlertManager:closeLayer(self)
		            end,
		        }
		        Utils:showReConfirm(args)
		        return
			end
			ActivityDataMgr2:send_ACTIVITY_REQ_UP_OR_DOWN_HANG_UP_ROLE(self.activityId, v.roleId, true, self.eventId)
			AlertManager:closeLayer(self)
		end)
		self.uiList_sprite:pushBackCustomItem(item)
	end
end


return HangUpChooseSpriteView