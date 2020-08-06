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
* --新年活动详细界面
]]

local NewYearDetailView = class("NewYearDetailView",BaseLayer)

function NewYearDetailView:ctor( activityId, data )
	self.super.ctor(self,data)
	self.activityId = activityId
	self.itemInfo = data
    self:showPopAnim(true)
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemInfo.type,self.itemInfo.id)
	self:init("lua.uiconfig.activity.NewYearDetailView")
end

function NewYearDetailView:initUI( ui )
	self.super.initUI(self,ui)
	local headIcon = TFDirector:getChildByPath(ui,"headIcon")
	local label_des = TFDirector:getChildByPath(ui,"label_des")
	local panel_award = TFDirector:getChildByPath(ui,"panel_award")
	local btn_go = TFDirector:getChildByPath(ui,"btn_go")
	local btn_award = TFDirector:getChildByPath(ui,"btn_award")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local label_title = TFDirector:getChildByPath(ui,"label_title")
	label_title:setText(self.itemInfo.extendData.des1)
	Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	for i = 1,3 do
		local panel_icon = TFDirector:getChildByPath(self.ui,"panel_icon"..i)
		panel_icon:setVisible(false)
	end
	local idx = 1 
	for id,num in pairs(self.itemInfo.extendData.reward[1]) do
		local panel_icon = TFDirector:getChildByPath(self.ui,"panel_icon"..idx)
		panel_icon:removeAllChildren()
		panel_icon:setVisible(true)
        local itemCfg = GoodsDataMgr:getItemCfg(tonumber(id))
        local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        panel_goodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(panel_goodsItem, tonumber(id), tonumber(num))
        panel_goodsItem:setPosition(me.p(0, 0))
        panel_icon:addChild(panel_goodsItem)
	    idx = idx + 1
	end

	label_des:setText(self.itemInfo.extendData.des2)
	headIcon:setTexture(self.itemInfo.extendData.iconShow)

	btn_go:setVisible(self.progressInfo.status == EC_TaskStatus.ING)
	btn_award:setVisible(self.progressInfo.status == EC_TaskStatus.GET)

	btn_go:onClick(function ( ... )
		---开始约会
		AlertManager:closeLayer(self)
		local data = self.itemInfo.extendData
        FunctionDataMgr:enterByFuncId(tonumber(data.jumpInterface),tonumber(data.jumpprama))
	end)
	
	btn_award:onClick(function ( ... )
		---领取奖励
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.itemInfo.id)
        AlertManager:closeLayer(self)
	end)
end

return NewYearDetailView