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
* -- 周年庆回忆奖励事件
]]

local ZhouNianQingJiangLi = class("ZhouNianQingJiangLi",BaseLayer)

function ZhouNianQingJiangLi:ctor( activityId,data )
	self.super.ctor(self,data)
	self.activityId = activityId
	self.itemData = data
	self.progressInfo = ActivityDataMgr2:getProgressInfo(self.itemData.type, self.itemData.id)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.rewardDetailView")
end

function ZhouNianQingJiangLi:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Panel_Item = TFDirector:getChildByPath(ui,"Panel_Item")
	self.Panel_Item:setPositionX(-1000)
	self.awardItem = {}
	for k,v in ipairs(self.itemData.extendData.choiceAward) do
		self.awardItem[k] = self.Panel_Item:clone()
		self:updateAward(k,v)
		self.Panel_Item:getParent():addChild(self.awardItem[k])
	end

	local offsetX = (1136 - #self.awardItem * self.Panel_Item:getSize().width)/(#self.awardItem + 1)
	local startPos = offsetX + self.Panel_Item:getSize().width* self.Panel_Item:getAnchorPoint().x
	local offsetX = offsetX + self.Panel_Item:getSize().width
	for j,item in ipairs(self.awardItem) do
		item:setPositionX(startPos + (j - 1)*offsetX)
	end
end

function ZhouNianQingJiangLi:getClosingStateParams()
    local selectChapter = FubenDataMgr:getCacheSelectChapter()
    local selectLevelCid = FubenDataMgr:getCacheSelectLevel()
    return {selectChapter, selectLevelCid, self.exChapterId or 0, self.ishardLevel or false}
end

function ZhouNianQingJiangLi:registerEvents( )
	-- body
	self.super.registerEvents(self)
end

function ZhouNianQingJiangLi:updateAward(key,data)
	local item = self.awardItem[key]
	local icon = TFDirector:getChildByPath(item,"icon")
	local label_dec = TFDirector:getChildByPath(item,"label_dec")
	label_dec:setText(data.describe)
	local ScrollView_reward = TFDirector:getChildByPath(item,"ScrollView_reward")
	if not ScrollView_reward.uiList_award then
		ScrollView_reward.uiList_award = UIListView:create(ScrollView_reward)
		local award = data.award
		for k,v in pairs(award) do  
			local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
			Panel_goodsItem:setScale(0.55)
			ScrollView_reward.uiList_award:pushBackCustomItem(Panel_goodsItem)
		end
    	ScrollView_reward.uiList_award:setCenterArrange()
	end

	local Button_get = TFDirector:getChildByPath(item,"Button_get")
	local Label_getted = TFDirector:getChildByPath(item,"Label_getted")
	if self.progressInfo.status == EC_TaskStatus.GETED then
		Button_get:setGrayEnabled(true)
		Button_get:setTouchEnabled(false)
		Button_get:setVisible(key ~= self.progressInfo.progress)
		Label_getted:setVisible(key == self.progressInfo.progress)
		if key == self.progressInfo.progress then
			icon:setTexture("ui/task/box_3.png")
		end
	else
		Label_getted:hide()
	end

	Button_get:onClick(function ( ... )
		ActivityDataMgr2:finishNewYearActivityItems(self.activityId,self.itemData.id,key)
		AlertManager:closeLayer(self)
	end)
end

return ZhouNianQingJiangLi