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
local SummonPieceUpgradeView = class("SummonPieceUpgradeView",BaseLayer)

function SummonPieceUpgradeView:ctor( storeId )
	-- body
	self.super.ctor(self)
	self.storeId = storeId
	self.storeCfg = StoreDataMgr:getStoreCfg(storeId)
	self.storeCfg.extendData = json.decode(self.storeCfg.extra)
	self:init("lua.uiconfig.summon.summonPieceUpgrade")
end

function SummonPieceUpgradeView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local ScrollView_title = TFDirector:getChildByPath(ui,"ScrollView_title")
	self.uilist_title = UIListView:create(ScrollView_title)
	local ScrollView_item = TFDirector:getChildByPath(ui,"ScrollView_item")
	self.uilist_item = UIListView:create(ScrollView_item)

	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Panel_reward = TFDirector:getChildByPath(ui,"Panel_reward")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self:updateTitleList()
	self:updateItemList()
	self:updateShowReward()
end

function SummonPieceUpgradeView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_sure:onClick(function ( ... )
		-- body
		local commodityCfg = StoreDataMgr:getCommodityCfg(self.selectId)

    	local goodsCfg = GoodsDataMgr:getItemCfg(commodityCfg.goodInfo[1].id)
		local isEnough = StoreDataMgr:currencyIsEnough(self.selectId)
        if isEnough then
            if goodsCfg.superType == EC_ResourceType.DRESS or goodsCfg.superType == EC_ResourceType.REWARD then
                if GoodsDataMgr:getItemCount(goodsId) > 0 then
                    Utils:openView("store.RepeatBuyTipsView", self.selectId)
                else
                    Utils:openView("store.BuyConfirmView", self.selectId)
                end
            else
                Utils:openView("store.BuyConfirmView", self.selectId)
            end
        else
            local costId = commodityCfg.priceType
            local costNum = commodityCfg.priceVal
            for i = 1, math.min(#costId, #costNum) do
                if not GoodsDataMgr:currencyIsEnough(costId[i], costNum[i] * 1) then
                    Utils:showAccess(costId[i])
                    break
                end
            end
        end
	end)


    EventMgr:addEventListener(self, EV_STORE_BUYINFO_UPDATE, function ( ... )
    	-- body
    	self:updateItemList()
    end)

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( ... )
    	-- body
    	self:updateItemList()
    	self:updateShowReward()
    end)

end

function SummonPieceUpgradeView:updateTitleList( ... )
	-- body
	local key = table.keys(self.storeCfg.extendData.ext)

	for i = #key,1,-1 do
		if not tonumber(key[i]) then
			table.remove(key,i)
		end
	end
	self.curRole = self.curRole or tonumber(key[1])
	for k,v in ipairs(key) do
		local item = self.uilist_title:getItem(k)
		if not item then
			item = self.Panel_role:clone()
			self.uilist_title:pushBackCustomItem(item)
		end
		self:updateTitleItem(item,tonumber(v))
	end
end

function SummonPieceUpgradeView:updateItemList( ... )
	-- body
	local items = self.storeCfg.extendData.ext[tostring(self.curRole)]
	local num = #self.uilist_item:getItems() - #items
	if num > 0 then
		for i = 1,num do
			self.uilist_item:removeItem(1)
		end
	end

	self.selectId = self.selectId or items[1]
	for k,v in ipairs(items) do
		local item = self.uilist_item:getItem(k)
		if not item then
			item = self.Panel_item:clone()
			self.uilist_item:pushBackCustomItem(item)
		end
		self:updateItem(item,v)
	end
end

function SummonPieceUpgradeView:updateTitleItem(item, roleid)
	local Image_n = TFDirector:getChildByPath(item,"Image_n")
	local Image_s = TFDirector:getChildByPath(item,"Image_s")

	Image_n:setTexture("ui/summon/piece/"..roleid.."_n.png")
	Image_s:setTexture("ui/summon/piece/"..roleid.."_s.png")

	Image_n:setVisible(self.curRole ~= roleid)
	Image_s:setVisible(self.curRole == roleid)

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		self.curRole = roleid
		self.selectId = nil
		self:updateTitleList()
		self:updateItemList()
		self:updateShowReward()
	end)
end

function SummonPieceUpgradeView:updateItem(item, data)
	local Image_n = TFDirector:getChildByPath(item,"Image_n")
	local Image_s = TFDirector:getChildByPath(item,"Image_s")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
    local commodityCfg = StoreDataMgr:getCommodityCfg(data)
    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal
	for i = 1,2 do
		local Panel_pos = TFDirector:getChildByPath(item,"Panel_pos"..i):show()
		local Label_num = TFDirector:getChildByPath(Panel_pos,"Label_num")

		if i > #costId then
			Panel_pos:hide()
			break
		end

		if not Panel_pos.goodsItem then
			local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	    	Panel_pos.goodsItem = goodItem
	    	goodItem:setScale(0.7)
	    	Panel_pos:addChild(goodItem)
	    	goodItem:setPosition(ccp(0,0))
		end
    	PrefabDataMgr:setInfo(Panel_pos.goodsItem, costId[i])
    	local count = GoodsDataMgr:getItemCount(costId[i])
    	Label_num:setText(count.."/"..costNum[i])

    	if count < costNum[i] then
    		Label_num:setColor(ccc3(255,0,0))
    	else
    		Label_num:setColor(ccc3(255,255,255))
    	end
	end

	Image_n:setVisible(self.selectId ~= data)
	Image_s:setVisible(self.selectId == data)
	Label_des:setTextById(commodityCfg.sellDescribtion)

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		self.selectId = data
		self:updateItemList()
		self:updateShowReward()
	end)

end

function SummonPieceUpgradeView:updateShowReward( ... )
	-- body
    local commodityCfg = StoreDataMgr:getCommodityCfg(self.selectId)

    local goods = commodityCfg.goodInfo[1]
    self.Label_name:setTextById(GoodsDataMgr:getItemCfg(goods.id).nameTextId)
    if not self.Panel_reward.goodsItem then
    	local goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    	self.Panel_reward.goodsItem = goodItem
    	goodItem:setScale(0.8)
    	self.Panel_reward:addChild(goodItem)
    	goodItem:setPosition(ccp(0,0))
    end
    PrefabDataMgr:setInfo(self.Panel_reward.goodsItem,goods.id,goods.num) 
end

return SummonPieceUpgradeView