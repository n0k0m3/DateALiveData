
local FubenStarRewardView = class("FubenStarRewardView", BaseLayer)

function FubenStarRewardView:initData(levelGroupId, diff)
    self.levelGroupId_ = levelGroupId
    self.levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelGroupId)
    self.levelGroupInfo_ = FubenDataMgr:getLevelGroupInfo(levelGroupId)
    if self.levelGroupCfg_ then
        self.diffReward_ = self.levelGroupCfg_.reward[diff]
    end
    self.diffReward_ = self.diffReward_ or {}
    self.stars_ = table.keys(self.diffReward_)
    table.sort(self.stars_)
    self.diff_ = diff
    self.starItems_ = {}

    self.levelTypeData_ = {
        [EC_FBLevelType.FIGHTING] = {
            star = "ui/fuben/level_star.png",
        },
        [EC_FBLevelType.DATING] = {
            star = "ui/fuben/dating_star.png",
        },
        [EC_FBLevelType.CITYDATING] = {
            star = "ui/fuben/dating_star.png",
        },
    }
end

function FubenStarRewardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.fubenStarRewardView")
end

function FubenStarRewardView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    if self.levelGroupId_ == 9401 then --海王星联动替换星星资源 
        local Image_star = TFDirector:getChildByPath(self.Panel_prefab , "Image_fubenStarRewardView_2")
        Image_star:setTexture("ui/fuben/linkage/checkpoint/020.png")
    end
    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    local ScrollView_star = TFDirector:getChildByPath(Image_bg, "ScrollView_star")
    self.ListView_star = UIListView:create(ScrollView_star)
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")

    self.Panel_starItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_starItem")

    self:refreshView()
end

function FubenStarRewardView:refreshView()
    local jumpIndex
    for i, v in ipairs(self.stars_) do
        local item = self:addStarItem()
        item.idx = i;
        self:updateStarItem(item, v)

        local isGet = FubenDataMgr:checkLevelGroupStarRewardIsGet(self.levelGroupId_, self.diff_, v)
        local isReach = FubenDataMgr:canGetLevelGroupStarReward(self.levelGroupId_, self.diff_, v)
        if not isGet and isReach and not jumpIndex then
            jumpIndex = i
        end
    end
    jumpIndex = jumpIndex or 1
    self.ListView_star:scrollToItem(jumpIndex)
end

function FubenStarRewardView:addStarItem()
    local item = self.Panel_starItem:clone()
    local foo = {}
    foo.root = item
    local Image_diban = TFDirector:getChildByPath(foo.root, "Image_diban")
    foo.Button_get = TFDirector:getChildByPath(Image_diban, "Button_get")
    foo.Label_get = TFDirector:getChildByPath(foo.Button_get, "Label_get")
    foo.Label_alreadyGet = TFDirector:getChildByPath(Image_diban, "Label_alreadyGet")
    foo.Label_notReach = TFDirector:getChildByPath(Image_diban, "Label_notReach")
    local ScrollView_reward = TFDirector:getChildByPath(Image_diban, "ScrollView_reward")
    foo.ListView_reward = UIListView:create(ScrollView_reward)
    foo.ListView_reward:setItemsMargin(10)
    foo.Label_collect = TFDirector:getChildByPath(Image_diban, "Label_collect")
    foo.Label_star_num = TFDirector:getChildByPath(Image_diban, "Label_star_num")

    self.starItems_[item] = foo
    self.ListView_star:pushBackCustomItem(item)
    return item
end

function FubenStarRewardView:updateStarItem(item, id)
    local data = self.diffReward_[id]
    local foo = self.starItems_[item]
    foo.ListView_reward:removeAllItems()
    for k, v in pairs(data.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        foo.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    foo.Label_get:setTextById(800042)
    foo.Label_alreadyGet:setTextById(800043)
    foo.Label_notReach:setTextById(1300007)

    local showCond = {}
    for i, v in ipairs(data.cond) do
        if v > 0 then
            if i == 1 then
                table.insert(showCond, {type_ = EC_FBLevelType.FIGHTING, num = v})
            elseif i == 2 then
                table.insert(showCond, {type_ = EC_FBLevelType.DATING, num = v})
            end
        end
    end

    local Panel_cond = foo.Panel_cond
    for i, v in ipairs(showCond) do
        foo.Label_star_num:setText(v.num)
        break
    end

    local isGet = FubenDataMgr:checkLevelGroupStarRewardIsGet(self.levelGroupId_, self.diff_, id)
    foo.Button_get:hide()
    foo.Button_get:setName("Button_get"..item.idx)
    foo.Label_alreadyGet:hide()
    foo.Label_notReach:hide()
    if isGet then
        foo.Label_alreadyGet:show()
    else
        local isReach = FubenDataMgr:canGetLevelGroupStarReward(self.levelGroupId_, self.diff_, id)
        foo.Button_get:setVisible(isReach)
        foo.Label_notReach:setVisible(not isReach)
    end

    foo.Button_get:onClick(function()
            local levelGroupServerID = FubenDataMgr:getLevelGroupServerId(self.levelGroupId_, diff)
            FubenDataMgr:send_DUNGEON_GET_LEVEL_GROUP_REWARD(levelGroupServerID, self.diff_, data.tag)
    end)
end

function FubenStarRewardView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))

    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

function FubenStarRewardView:onGetLevelGroupRewardEvent(diff, id)
    local index = table.indexOf(self.stars_, id)
    local item = self.ListView_star:getItem(index)
    self:updateStarItem(item, id)

    local data = self.diffReward_[id]
    local formatReward = {}
    for k, v in pairs(data.reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(formatReward, item)
    end
    Utils:showReward(formatReward)
end

return FubenStarRewardView
