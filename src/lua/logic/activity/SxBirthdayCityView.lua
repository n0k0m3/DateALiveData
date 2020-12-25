
local SxBirthdayCityView = class("SxBirthdayCityView", BaseLayer)

function SxBirthdayCityView:initData(cityCid)
    self.cityCid_ = cityCid
    self.cityCfg_ = SxBirthdayDataMgr:getActivityCityCfg(self.cityCid_)
    self.costCid_, self.costNum_ = next(self.cityCfg_.cost)
    self.costCfg_ = GoodsDataMgr:getItemCfg(self.costCid_)

end

function SxBirthdayCityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.sxBirthdayCityView")
end

function SxBirthdayCityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
	self.Panel_prefab:setTouchEnabled(true)
	self.Panel_prefab:setSwallowTouch(true)
	
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.Label_name = TFDirector:getChildByPath(self.Panel_root, "Image_name.Label_name")
    local Image_place = TFDirector:getChildByPath(self.Panel_root, "Image_place")
    self.Label_place = TFDirector:getChildByPath(Image_place, "Label_place")
    self.Label_desc = TFDirector:getChildByPath(Image_place, "Label_desc")
    self.Label_get = TFDirector:getChildByPath(self.Panel_root, "Label_get")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    local Image_cost = TFDirector:getChildByPath(self.Panel_root, "Image_cost")
    self.Label_cost_num = TFDirector:getChildByPath(Image_cost, "Label_cost_num")
    self.Image_cost_icon = TFDirector:getChildByPath(Image_cost, "Image_cost_icon")
    self.Button_explore = TFDirector:getChildByPath(self.Panel_root, "Button_explore")
    self.Label_explore = TFDirector:getChildByPath(self.Button_explore, "Label_explore")
    self.Panel_part = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_part_" .. i)
        foo.Image_unlock = TFDirector:getChildByPath(foo.root, "Image_unlock")
        foo.Image_order_unlock = TFDirector:getChildByPath(foo.root, "Image_order_unlock")
        local Label_order_unlock = TFDirector:getChildByPath(foo.Image_order_unlock, "Label_order_unlock")
        Label_order_unlock:setText(i)
        foo.Button_dating = TFDirector:getChildByPath(foo.root, "Button_dating")
        local Label_dating = TFDirector:getChildByPath(foo.Button_dating, "Label_dating")
        Label_dating:setTextById(1454033)
        foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
        foo.Image_order_lock = TFDirector:getChildByPath(foo.root, "Image_order_lock")
        local Label_order_lock = TFDirector:getChildByPath(foo.Image_order_lock, "Label_order_lock")
        Label_order_lock:setText(i)
		foo.Image_complete = TFDirector:getChildByPath(foo.root, "Image_complete")

        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        foo.Image_order_complete = TFDirector:getChildByPath(foo.root, "Image_order_complete")
        local Label_order_complete = TFDirector:getChildByPath(foo.Image_order_complete, "Label_order_complete")
        Label_order_complete:setText(i)
        foo.Label_part = TFDirector:getChildByPath(foo.root, "Label_part")
        foo.Label_title = TFDirector:getChildByPath(foo.root, "Label_title")
        foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
        self.Panel_part[i] = foo
    end

    self:refreshView()
end


function SxBirthdayCityView:refreshView()
    self.Image_bg:setTexture(self.cityCfg_.background)
    self.Label_name:setTextById(self.cityCfg_.title2)
    self.Label_place:setTextById(self.cityCfg_.title1)
    self.Label_desc:setTextById(self.cityCfg_.describe)
    self.Label_get:setTextById(13310002)

    self.Label_cost_num:setText(self.costNum_)
    self.Image_cost_icon:setTexture(self.costCfg_.icon)
    self.Image_cost_icon:Touchable(true)
    self.Image_cost_icon:onClick(function()
            Utils:showInfo(self.costCid_)
    end)

    for i, v in ipairs(self.cityCfg_.rewards) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    self:updatePart()
end

function SxBirthdayCityView:updatePart()
	local ret = {};
    local cityInfo = SxBirthdayDataMgr:getCityInfo(self.cityCid_)
    local part = cityInfo.partInfo
    for i, v in ipairs(self.Panel_part) do
        local partInfo = cityInfo.partInfo[i]
        local prePart = i - 1
        local isUnlock = false
        if prePart < 1 then
            isUnlock = true
        else
            local prePartInfo = cityInfo.partInfo[prePart]
            isUnlock = prePartInfo.state == 2
        end
        local partCfg = SxBirthdayDataMgr:getTohkaDatingCfg(partInfo.cityPartId)
        local isCompete = partInfo.state == 2
        v.Image_lock:setVisible(not isUnlock)
        v.Image_unlock:setVisible(isUnlock and not isCompete)
		v.Image_complete:setVisible(isCompete)
		table.insert(ret, isCompete)

        if isUnlock then
            local title = TextDataMgr:getText(partCfg.title)
            local state = TextDataMgr:getText(partInfo.state == 0 and 13300270 or 13300271)
            v.Label_title:setText(title .. state)
            v.Label_desc:setTextById(partCfg.eventDes)
        else
            v.Label_title:setTextById(13310004)
            v.Label_desc:setTextById(13310004)
        end

        v.Button_dating:setGrayEnabled(partInfo.state == 0)
        v.Button_dating:setTouchEnabled(partInfo.state == 1)

        v.Button_dating:onClick(function()
                FunctionDataMgr:jStartDating(partInfo.cityPartId)
        end)
    end
	return ret
end

function SxBirthdayCityView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SXBIRTHDAY_EXPLORE, handler(self.onExploreEvent, self))
    EventMgr:addEventListener(self, EV_SXBIRTHDAY_CITYINFO_UPDATE, handler(self.onCityInfoUpdateEvent, self))
    self.Button_explore:onClick(function()
            local count = GoodsDataMgr:getItemCount(self.costCid_)
            if count < self.costNum_ then
                if StoreDataMgr:canContinueBuyItemRecover(self.costCfg_.buyItemRecover) then
                    Utils:openView("common.BuyResourceView", self.costCid_)
                else
                    Utils:showTips(800021)
                end
            else
				Utils:openView("activity.sxBirthdayWheelView", self.cityCid_)
            end
    end)
end

function SxBirthdayCityView:onItemUpdateEvent()

end

function SxBirthdayCityView:onExploreEvent(eventCid, rewards)
--    local eventCfg = SxBirthdayDataMgr:getTohkaEventCfg(eventCid)
--    if eventCfg.type == EventType.Item then
--		self.funcExplore = function()
--			Utils:openView("activity.SxBirthdayRewardView", self.cityCid_, eventCid, rewards)
--		end
--		self:launchWheel(eventCid)
--    elseif eventCfg.type == EventType.Dating then
--		self.funcExplore = function()
--			Utils:openView("activity.SxBirthdayDatingView", eventCid)
--		end
--		self:launchWheel(DatingEventId)
--    end
end

function SxBirthdayCityView:onCityInfoUpdateEvent()
    local ret = self:updatePart()
	if table.indexOf(ret, false) == -1 then
		AlertManager:closeLayer(self)
	end
end


return SxBirthdayCityView
