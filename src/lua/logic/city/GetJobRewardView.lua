
local GetJobRewardView = class("GetJobRewardView", BaseLayer)

function GetJobRewardView:initData(jobInfo)
    self.jobInfo_ = jobInfo
end

function GetJobRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dating.getJobRewardView")
end

function GetJobRewardView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_attr_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attr_item")
    self.Panel_reward_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_reward_item")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.Image_attr_bg = TFDirector:getChildByPath(self.Panel_root, "Image_attr_bg")
    self.Label_attr_tiele = TFDirector:getChildByPath(self.Panel_root, "Label_attr_tiele")
    self.Label_attr_tiele:setTextById(190000507)

    self.ScrollView_reward = UIListView:create(ScrollView_reward)
    self.ScrollView_reward:setItemsMargin(10)
    self.ScrollView_ = TFDirector:getChildByPath(ui, "ScrollView_attr")
    self.ScrollView_attr = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_attr"))
    self.ScrollView_attr:setItemsMargin(2)
    self.Panel_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_reward")

    self.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()

    self:refreshView()

    self.Label_touch = self.Panel_root:getChild("Label_touch")
    self.ui:timeOut(function()
        self.Label_touch:setTextById(800018)
    end)
end

function GetJobRewardView:refreshView()
    local totalCouunt = 0
    if self.jobInfo_.rewards then
        totalCouunt = totalCouunt + #self.jobInfo_.rewards
    end
     if self.jobInfo_.extraRewards then
        totalCouunt = totalCouunt + #self.jobInfo_.extraRewards
    end
    local countIdx = 0
    if self.jobInfo_.rewards then
        for k,v in pairs(self.jobInfo_.rewards) do
            if CityJobDataMgr:checkItemEnableShow(v.id) then
                countIdx = countIdx + 1
                local itemBase = self.Panel_reward_item:clone()
                local itemReward = self.Panel_goodsItem:clone()
                itemReward:setScale(0.8)
                PrefabDataMgr:setInfo(itemReward, v.id, v.num)
                local Panel_item = TFDirector:getChildByPath(itemBase, "Panel_item")
                Panel_item:addChild(itemReward, 5)
                itemReward:setPosition(ccp(0,0))
                self.Panel_reward:addChild(itemBase)
                itemBase:setPosition(ccp((totalCouunt * -60) - 60  + countIdx * 120, 0))
            end
        end
    end

    if self.jobInfo_.extraRewards then
        for k,v in pairs(self.jobInfo_.extraRewards) do
            if CityJobDataMgr:checkItemEnableShow(v.id) then
                countIdx = countIdx + 1
                local itemBase = self.Panel_reward_item:clone()
                local itemReward = self.Panel_goodsItem:clone()
                itemReward:setScale(0.8)
                PrefabDataMgr:setInfo(itemReward, v.id, v.num)
                local Panel_item = TFDirector:getChildByPath(itemBase, "Panel_item")
                Panel_item:addChild(itemReward, 5)
                itemReward:setPosition(ccp(0,0))

                local Image_item_bg = TFDirector:getChildByPath(itemBase, "Image_item_bg")
                local Label_extra = TFDirector:getChildByPath(itemBase, "Label_extra")
                Image_item_bg:setVisible(true)
                Label_extra:setTextById(2100152)
                Label_extra:setVisible(true)
                self.Panel_reward:addChild(itemBase)
                itemBase:setPosition(ccp((totalCouunt * -60) - 60  + countIdx * 120, 0))
            end
        end
    end
    local jobCfg = CityJobDataMgr:getCityJobCfgById(self.jobInfo_.jobId)
    local attrs = {}
    for k,v in pairs(jobCfg.resultShow3) do
        table.insert(attrs,{tonumber(k), v})
    end
    table.sort(attrs, function(a, b)
        return a[1] < b[1]
    end)
    for i,v in ipairs(attrs) do
        local itemAttr = self.Panel_attr_item:clone()
        local cfg = GoodsDataMgr:getItemCfg(v[1])
        TFDirector:getChildByPath(itemAttr, "Label_attr_name"):setTextById(cfg.nameTextId)
        local count = GoodsDataMgr:getItemCount(v[1]) or 0
        if count >= cfg.totalMax then
            TFDirector:getChildByPath(itemAttr, "Label_attr_value"):setText("+0")
        else
            TFDirector:getChildByPath(itemAttr, "Label_attr_value"):setText("+"..tostring(v[2]))
        end
        self.ScrollView_attr:pushBackCustomItem(itemAttr)
    end
    local posx = self.ScrollView_:getPositionX()
    local subCount =  5 - #attrs
    self.ScrollView_:setPositionX(posx + subCount * 70)

    if #attrs < 1 then
        self.Image_attr_bg:setVisible(false)
        self.Label_attr_tiele:setVisible(false)
    end
end

function GetJobRewardView:registerEvents()

end

return GetJobRewardView
