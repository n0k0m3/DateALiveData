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
* 奖励预览界面
* 
]]

local BalloonRewardView = class("BalloonRewardView", BaseLayer)

function BalloonRewardView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.BalloonRewardView")
end

function BalloonRewardView:initData()
    self:updateData()
end

function BalloonRewardView:updateData()
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BALLOON_ACTIVITY)[1]
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
end

function BalloonRewardView:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")
    self.reward_item = TFDirector:getChildByPath(ui, "reward_item"):hide()

    local label_title = TFDirector:getChildByPath(ui, "label_title")
    label_title:setTextById(13317054)

    local scroll_list = TFDirector:getChildByPath(ui, "scroll_list")
    self.rewardList = UIListView:create(scroll_list)
    self.rewardList:setItemsMargin(0)

    self:updateUI()
end

function BalloonRewardView:updateUI()
	if not self.activityInfo then
        return
    end

    local extendData = self.activityInfo.extendData
    local rewards = extendData.reward or {}

    local items = self.rewardList:getItems()
    local gap = #rewards - #items
    for i = 1, math.abs(gap) do
        if gap > 0 then
        	local item = self.reward_item:clone()
        	item:show()
        	self.rewardList:pushBackCustomItem(item)
        else
            self.rewardList:removeItem(1)
        end
    end

    for k, v in ipairs(rewards) do
        local item = self.rewardList:getItem(k)
        self:updateAwardItem(item, v, k)
    end
end

function BalloonRewardView:updateAwardItem(item, data, index)
	local label_desc = TFDirector:getChildByPath(item, "label_desc")
    local stringId = 13317071 + index - 1
    label_desc:setTextById(stringId)

    local list = {}
    for k, v in pairs(data) do
        table.insert(list, {id = tonumber(k), num = v})
    end
    table.sort(list, function(a, b)
        return a.id < b.id
    end)

    for i = 1, 4 do
    	local pos = TFDirector:getChildByPath(item, "pos" .. i)
    	if not pos.itemNode then
    		local itemNode = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    		itemNode:setScale(0.6)
    		itemNode:setPosition(ccp(0, 0))
    		pos:addChild(itemNode)
    		pos.itemNode = itemNode
    	end
    	pos.itemNode:hide()
    	if i <= #list then
    		pos.itemNode:show()
    		PrefabDataMgr:setInfo(pos.itemNode, list[i].id, list[i].num)
    	end
    end
end

function BalloonRewardView:registerEvents()
    self.super.registerEvents(self)

    self.btn_close:onClick(function()
		AlertManager:closeLayer(self)
	end)
end

return BalloonRewardView
