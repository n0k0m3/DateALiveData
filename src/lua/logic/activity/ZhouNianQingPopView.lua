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
local ZhouNianQingPopView = class("ZhouNianQingPopView",BaseLayer)

function ZhouNianQingPopView:ctor( activityId,data )
	self.super.ctor(self,data)
	self.activityId = activityId
	self.itemData = data
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemData.type, self.itemData.id)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.znqPopView")
end

function ZhouNianQingPopView:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_ad = TFDirector:getChildByPath(ui,"Image_ad")
	self.Button_goShop = TFDirector:getChildByPath(ui,"Button_goShop")
	self.Button_goSummon = TFDirector:getChildByPath(ui,"Button_goSummon")
	self.Label_tip = TFDirector:getChildByPath(ui,"Label_tip")
	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")
	local ScrollView_prop = TFDirector:getChildByPath(ui,"ScrollView_prop")
	self.uiList = UIListView:create(ScrollView_prop)
	self:refreshView(  )
end

function ZhouNianQingPopView:registerEvents( )
	-- body
	self.super.registerEvents(self)
	self.Button_goSummon:onClick(function ( ... )
		-- body
    	SimulationSummonDataMgr:reqSimulateSummonInfo() 
    	AlertManager:closeLayer(self)
	end)

	self.Button_goShop:onClick(function ( ... )
		-- body
    	FunctionDataMgr:jStore(storeCid,EC_StoreType.ZNQ)
    	AlertManager:closeLayer(self)
	end)
end

function ZhouNianQingPopView:refreshView(  )
	-- body
	self.Image_ad:setTexture(self.itemData.extendData.pic)
	self.Image_ad:setScale(800/self.Image_ad:getSize().width)
	self.Label_tip:setTextById(self.itemData.extendData.des)
	local items = self.itemData.extendData.item or {}
	for k,v in pairs(items) do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem, v)
		Panel_goodsItem:setScale(0.6)
		self.uiList:pushBackCustomItem(Panel_goodsItem)
	end

	if self.itemData.extendData.yearBirthEvent == EC_YearActivityEventType.SHOP then
		self.Button_goSummon:hide()
		self.Button_goShop:show()
		self.Label_tip1:setTextById(14210030)
	elseif self.itemData.extendData.yearBirthEvent == EC_YearActivityEventType.SUMMON then
		self.Button_goSummon:show()
		self.Button_goShop:hide()
		self.Label_tip1:setTextById(14210029)
	end
	self.uiList.scrollView_:setPositionX(self.Label_tip1:getPositionX() + self.Label_tip1:getSize().width)
end

return ZhouNianQingPopView