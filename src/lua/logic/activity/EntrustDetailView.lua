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
* --委托详细界面
]]

local EntrustDetailView = class("EntrustDetailView",BaseLayer)

function EntrustDetailView:ctor( activityId, data )
	self.super.ctor(self,data)
	self.activityId = activityId
	self.itemInfo = data
    self:showPopAnim(true)
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemInfo.type,self.itemInfo.id)
	self:init("lua.uiconfig.activity.EntrustDetailView")
end

function EntrustDetailView:initUI( ui )
	self.super.initUI(self,ui)
	local headIcon = TFDirector:getChildByPath(ui,"headIcon")
	local label_des = TFDirector:getChildByPath(ui,"label_des")
	local panel_award = TFDirector:getChildByPath(ui,"panel_award")
	local btn_go = TFDirector:getChildByPath(ui,"btn_go")
	local btn_award = TFDirector:getChildByPath(ui,"btn_award")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local label_title = TFDirector:getChildByPath(ui,"label_title")
	local label_type = TFDirector:getChildByPath(ui,"label_type")
	label_title:setText(self.itemInfo.extendData.des)
	label_type:setText(self.itemInfo.extendData.typeDes or "")
	Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	local Label_costNum = TFDirector:getChildByPath(ui,"Label_costNum")
	local Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")
	local image5 = TFDirector:getChildByPath(ui,"image5")
	Label_costNum:setText(self.itemInfo.extendData.consume)


	for i = 1,3 do
		local panel_icon = TFDirector:getChildByPath(self.ui,"panel_icon"..i)
		panel_icon:setVisible(false)
	end
	local idx = 1 
	for id,num in pairs(self.itemInfo.reward) do
		local panel_icon = TFDirector:getChildByPath(self.ui,"panel_icon"..idx)
		panel_icon:removeAllChildren()
		panel_icon:setVisible(true)
        local itemCfg = GoodsDataMgr:getItemCfg(id)
        local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        panel_goodsItem:Scale(0.8)
        PrefabDataMgr:setInfo(panel_goodsItem, id, num)
        panel_goodsItem:setPosition(me.p(0, 0))
        panel_icon:addChild(panel_goodsItem)
	    idx = idx + 1
	end

	label_des:setText(self.itemInfo.extendData.des2)
	headIcon:setTexture(self.itemInfo.extendData.iconShow)

	btn_go:setVisible(self.progressInfo.status == EC_TaskStatus.ING)
	btn_award:setVisible(self.progressInfo.status == EC_TaskStatus.GET)
	local isVisible = self.progressInfo.status ~= EC_TaskStatus.GET and self.itemInfo.extendData.consume > 0
	Label_costNum:setVisible(isVisible)
	Image_costIcon:setVisible(isVisible)
	image5:setVisible(isVisible)
	if self.itemInfo.extendData.consume == 0 then
		btn_go:setPosition(btn_award:getPosition())
	end

	btn_go:onClick(function ( ... )
		---开始约会
        FunctionDataMgr:enterByFuncId(self.itemInfo.extendData.jumpInterface,self.itemInfo.extendData.datingScriptId)
        AlertManager:closeLayer(self)
	end)
	
	btn_award:onClick(function ( ... )
		---领取奖励
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, self.itemInfo.id)
        AlertManager:closeLayer(self)
	end)
end

return EntrustDetailView