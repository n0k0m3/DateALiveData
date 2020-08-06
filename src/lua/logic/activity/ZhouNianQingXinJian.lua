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
* -- 周年庆回忆信件事件
]]

local ZhouNianQingXinJian = class("ZhouNianQingXinJian",BaseLayer)

function ZhouNianQingXinJian:ctor(activityId, data )
	self.super.ctor(self,data)
	self.itemInfo = data
	self.activityId = activityId
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemInfo.type, self.itemInfo.id)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.letterDetailView")
end

function ZhouNianQingXinJian:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Panel_close = TFDirector:getChildByPath(ui,"Panel_close")
	self.Panel_open = TFDirector:getChildByPath(ui,"Panel_open")
	self.Spine_effect = TFDirector:getChildByPath(self.Panel_close,"Spine_effect")

	self.Panel_close:setVisible(self.progressInfo.status ~= EC_TaskStatus.GETED)
	self.Panel_open:setVisible(self.progressInfo.status == EC_TaskStatus.GETED)

	local label_dec = TFDirector:getChildByPath(ui,"label_dec")
	local Button_get = TFDirector:getChildByPath(ui,"Button_get")

	local ScrollView_text = TFDirector:getChildByPath(ui,"ScrollView_text")
	label_dec:setTextById(self.itemInfo.extendData.letterId)
	label_dec:retain()
	label_dec:removeFromParent()
	self.textList = UIListView:create(ScrollView_text);
	self.textList:pushBackCustomItem(label_dec)
	label_dec:release()

	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.rewardList = UIListView:create(ScrollView_reward);
	for k,v in pairs(self.itemInfo.reward) do
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
		Panel_goodsItem:setScale(0.55)
		self.rewardList:pushBackCustomItem(Panel_goodsItem)
	end
	Button_get:setGrayEnabled(self.progressInfo.status == EC_TaskStatus.GETED)
	Button_get:setTouchEnabled(self.progressInfo.status ~= EC_TaskStatus.GETED)
	Button_get:onClick(function ( ... )
		ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.itemInfo.id)
		AlertManager:closeLayer(self)
	end)

	self.Panel_close:setTouchEnabled(true)
	self.Panel_close:onClick(function ( ... )
		self.Spine_effect:play("effect_ZNQ_xinfeng3",0)
		self.Panel_close:setTouchEnabled(false)
		self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
			self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
			self.Panel_open:show()
        end)
	end)
	self.Spine_effect:setupPoseWhenPlay(false)
	self.Spine_effect:play("effect_ZNQ_xinfeng1",0)
	self.Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
			self.Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
			self.Spine_effect:play("effect_ZNQ_xinfeng2",1)
        end)
end

function ZhouNianQingXinJian:registerEvents( )
	-- body
	
end

return ZhouNianQingXinJian