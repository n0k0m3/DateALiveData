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

local KnowledgeInfoView = class("KnowledgeInfoView",BaseLayer)

function KnowledgeInfoView:ctor( skillId )
	-- body
	self.super.ctor(self,data)
	self.skillCfg = TabDataMgr:getData("AfkKnowledge",skillId)
	self:showPopAnim(true)
	self:init("lua.uiconfig.explore.knowledgeInfoView")
end

function KnowledgeInfoView:checkCostEnough( ... )
	-- body
	for k,v in pairs(self.skillCfg.cost) do
		if v > GoodsDataMgr:getItemCount(k) then
			return false
		end
	end

	return true
end

function KnowledgeInfoView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
	local Label_tip = TFDirector:getChildByPath(ui,"Label_tip")
	local Label_name = TFDirector:getChildByPath(ui,"Label_name")
	local Label_des = TFDirector:getChildByPath(ui,"Label_des")
	local Label_des1 = TFDirector:getChildByPath(ui,"Label_des1")
	local Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local Image_notActive = TFDirector:getChildByPath(ui,"Image_notActive")
	local Image_active = TFDirector:getChildByPath(ui,"Image_active")
	local ScrollView_cost = TFDirector:getChildByPath(ui,"ScrollView_cost")
	local Button_active = TFDirector:getChildByPath(ui,"Button_active")
	local Panel_costItem = TFDirector:getChildByPath(ui,"Panel_costItem")
	local costGlodBg = TFDirector:getChildByPath(ui,"CostGoods"):hide()
	local goldIcon = TFDirector:getChildByPath(ui,"goldIcon")
	local goldnum = TFDirector:getChildByPath(ui,"goldnum")

	local uiList_cost = UIListView:create(ScrollView_cost)
	uiList_cost:setItemsMargin(10)
	local state =  ExploreDataMgr:getKnowledgeState(self.skillCfg.type, self.skillCfg.id)

	Image_active:setVisible(state and state ~= 0)
	Image_notActive:setVisible(not state or state == 0)
	if state ~= 1 then
		Image_icon:setTexture(string.sub(self.skillCfg.icon,0,-5).."_1.png")
	else
		Image_icon:setTexture(self.skillCfg.icon)
	end

	Label_tip:setText(self.skillCfg.des2)
	Label_name:setText(self.skillCfg.name)
	Label_des:setText(self.skillCfg.describe)
	Label_des1:setText(self.skillCfg.des3)
	Label_des1:setVisible(not state)
	if state == 0 then
		local k,v
		for i = 1,table.count(self.skillCfg.cost) do
			k,v = next(self.skillCfg.cost,k)
			local count = GoodsDataMgr:getItemCount(tonumber(k))
			if k == EC_SItemType.GOLD then
				costGlodBg:show()
				local cfg = GoodsDataMgr:getItemCfg(k)
				if cfg then
					goldIcon:setTexture(cfg.icon)
				end
				local color = count >= v and me.WHITE or ccc3(255,91,141)
				goldnum:setColor(color)
				goldnum:setText(Utils:format_number(count).."/"..v)
			else
				local item = Panel_costItem:clone()
				local Panel_good = TFDirector:getChildByPath(item,"Panel_good")
				local Label_num = TFDirector:getChildByPath(item,"Label_num")
				local Label_num1 = TFDirector:getChildByPath(item,"Label_num1")

				if not Panel_good.Panel_goodsItem then
					local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
					Panel_goodsItem:setPosition(ccp(0,0))
					Panel_goodsItem:setScale(0.78)
					Panel_good:addChild(Panel_goodsItem)
					Panel_good.Panel_goodsItem = Panel_goodsItem
				end

				PrefabDataMgr:setInfo(Panel_good.Panel_goodsItem,tonumber(k))


				Label_num1:setText(Utils:format_number(count).."/"..v)
				Label_num:setText(Utils:format_number(count).."/"..v)

				Label_num1:setVisible(count < v)
				Label_num:setVisible(count >= v)
				uiList_cost:pushBackCustomItem(item)
			end
		end
		uiList_cost:setCenterArrange()
	end
	Button_active:setVisible(state == 0)
	Button_active:onClick(function ( ... )
		-- body
		if not self:checkCostEnough() then
    		Utils:showTips(13311257)
			return
		end

		ExploreDataMgr:Send_ExploreTechUpgrade(self.skillCfg.type,0,self.skillCfg.id)
		AlertManager:closeLayer(self)
	end)

	Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return KnowledgeInfoView