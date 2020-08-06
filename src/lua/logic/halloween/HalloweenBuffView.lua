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
*  -- 万圣节buff界面
]]

local HalloweenBuffView = class("HalloweenBuffView",BaseLayer)

function HalloweenBuffView:ctor( data )
	-- body
	self.super.ctor(self,data)
  	self:showPopAnim(true)
	self:init("lua.uiconfig.halloween.halloweenBuffView")
end

function HalloweenBuffView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local ScrollView_buff = TFDirector:getChildByPath(ui,"ScrollView_buff")
	self.uiList_buff = UIListView:create(ScrollView_buff)
	self.tip1 = TFDirector:getChildByPath(ui,"tip1")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self:updateView()
	self.tip1:setTextById(12101041)
end

function HalloweenBuffView:registerEvents( ... )
	-- body
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
end

function HalloweenBuffView:updateView( )
	-- body
	local bufflist = {}

	for k,v in pairs(TabDataMgr:getData("HalloweenBuff")) do
		table.insert(bufflist,v)
	end
	
	table.sort(bufflist,function ( a,b )
		local isVisible1 = ActivityDataMgr2:checkHalloweenBuffIsActivity(a.id)
		local isVisible2 = ActivityDataMgr2:checkHalloweenBuffIsActivity(b.id)
		if isVisible1 == isVisible2 then
			return a.id < b.id
		elseif isVisible1 then 
			return true 
		elseif isVisible2 then 
			return false 
		end
	end)
	self.uiList_buff:removeAllItems()
	for k,v in pairs(bufflist) do
		local item = self.Panel_item:clone()
		self:updateItem(item,v)
		self.uiList_buff:pushBackCustomItem(item)
	end
end

function HalloweenBuffView:updateItem( item, data )
	-- body
	local Panel_normal = TFDirector:getChildByPath(item, "Panel_normal")
	local Panel_activity = TFDirector:getChildByPath(item, "Panel_activity")
	local icon = TFDirector:getChildByPath(item, "icon")
	local buff_des = TFDirector:getChildByPath(item, "buff_des")
	local label_flag = TFDirector:getChildByPath(Panel_normal, "label_flag")

	icon:setTexture(data.buffIcon)
	buff_des:setTextById(data.buffDescribe)
	label_flag:setTextById(data.unlockDescribe)

	local isVisible = ActivityDataMgr2:checkHalloweenBuffIsActivity(data.id)
	Panel_normal:setVisible(not isVisible)
	Panel_activity:setVisible(isVisible)
end

return HalloweenBuffView