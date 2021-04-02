local ResLoader   = import(".ResLoader")
local enum        = import(".enum")
local eEvent      = enum.eEvent

local EndlessPauseView = class("EndlessPauseView", BaseLayer)

function EndlessPauseView:initData()
    local battleData = BattleDataMgr:getBattleData()
    self.levelCid_ = battleData.stageId
end

function EndlessPauseView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.battle.endlessPauseView")
end

function EndlessPauseView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rewardItem")

    self.Button_leave    = TFDirector:getChildByPath(self.Panel_root, "Button_leave")
    self.Button_continue = TFDirector:getChildByPath(self.Panel_root, "Button_continue")
    self.Button_set      = TFDirector:getChildByPath(self.Panel_root, "Button_set")
    self.Label_totalTime = TFDirector:getChildByPath(self.Panel_root, "Label_totalTime")
    local Image_playDesc = TFDirector:getChildByPath(self.Panel_root, "Image_playDesc")
    self.Label_playDescTitle = TFDirector:getChildByPath(Image_playDesc, "Label_playDescTitle")
    self.Label_playDesc = TFDirector:getChildByPath(self.Panel_root, "Label_playDesc")
    local Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward")
    self.Label_rewardTitle = TFDirector:getChildByPath(Image_reward, "Label_rewardTitle")
    self.Label_battleInfo = TFDirector:getChildByPath(self.Panel_root, "Label_battleInfo")
    self.PageView_reward = TFDirector:getChildByPath(self.Panel_root, "PageView_reward")
    self.Image_right = TFDirector:getChildByPath(self.Panel_root, "Image_right")
    self.Label_time_title = TFDirector:getChildByPath(self.Panel_root, "Label_time_title")

    self:refreshView()

    self.Pane_prefab = TFDirector:getChildByPath(ui, "Pane_prefab_item"):hide()
    local ScrollView_buffer = TFDirector:getChildByPath(self.Panel_root, "ScrollView_buffer")
    self.listView = UIListView:create(ScrollView_buffer)
    -- self.listView:setItemsMargin(0)
    local hero = battleController.getCaptain()
    if hero then 
        local bufferEffects = hero:getEffectingBufferEffect()
        for i,bufferEffect in ipairs(bufferEffects) do
            local data = bufferEffect:getData()
            if data.duration ~= 0 and data.iconDisplay then 
                local node = self:createItem(bufferEffect)
                self.listView:pushBackCustomItem(node)
            end
        end
    end


end

function EndlessPauseView:createItem(effect)
    local item        = self.Pane_prefab:clone()
    item:show()
    local Image_icon  = TFDirector:getChildByPath(item, "Image_icon")
    local Label_num   = TFDirector:getChildByPath(item, "Label_num")
    Label_num:setSkewX(15)
    local Label_desc  = TFDirector:getChildByPath(item, "Label_desc")
    local Image_time1 = TFDirector:getChildByPath(item, "Image_time1")
    local Image_time2 = TFDirector:getChildByPath(item, "Image_time2")
    local Label_time  = TFDirector:getChildByPath(Image_time1, "Label_time")
    local data = effect:getData()
    if data.duration  == -1 then 
        Image_time2:show()
        Image_time1:hide()
    elseif data.duration  > 0 then
        Image_time1:show()
        Image_time2:hide()
        local time = effect.nDuration*0.001 --换算苗
        Label_time:setText(string.format("%.2fs",time))
    end
    if ResLoader.isValid(data.icon) then 
        Image_icon:show()
        Image_icon:setTexture(data.icon)
    else
        Image_icon:hide()
    end
    if effect.nAddTimes > 1 then 
        Label_num:show()
        Label_num:setTextById(302201,effect.nAddTimes)
    else
        Label_num:hide()
    end
    if data.iconDes then 
        Label_desc:setText(data.iconDes)
    else
        Label_desc:setText("bufferEffect "..data.id.." 没有配置效果描述")
    end
    return item
end

function EndlessPauseView:refreshView()
    self.Label_playDescTitle:setTextById(300833)
    self.Label_playDesc:setLineHeight(30)
    self.Label_rewardTitle:setTextById(300838)
    self.Label_playDesc:setTextById(300831)
    self.Label_time_title:setTextById(2105004)

    local statistics = battleController.getStatistics()

    local date = Utils:getUTCDate(math.floor(statistics.endlessTime * 0.001))
    local hour = date:gethours()
    local min = date:getminutes()
    local sec = date:getseconds()
    local formatHour = string.format("%02d", hour)
    local formatMin = string.format("%02d", min)
    local formatSec = string.format("%02d", sec)
    if hour > 0 then
        self.Label_totalTime:setTextById(800026, formatHour, formatMin, formatSec)
    else
        self.Label_totalTime:setTextById(800014, formatMin, formatSec)
    end

    local pageNum = 5
    local data = {}
    local pageIndex = 1
    for i, v in ipairs(statistics.endlessReward) do
        local pageData = data[pageIndex] or {}
        if #pageData == pageNum then
            pageIndex = pageIndex + 1
            pageData = data[pageIndex] or {}
        end
        table.insert(pageData, v)
        data[pageIndex] = pageData
    end

    for i, v in ipairs(data) do
        local item = self.Panel_rewardItem:clone()
        local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")
        local ListView_reward = UIListView:create(ScrollView_reward)
        for _, reward in ipairs(v) do
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Scale(0.7)
            Panel_goodsItem:setTouchEnabled(false)
            PrefabDataMgr:setInfo(Panel_goodsItem, reward.id, reward.num)
            ListView_reward:pushBackCustomItem(Panel_goodsItem)
        end
        self.PageView_reward:addPage(item)
    end

    self.Image_right:setVisible(#data > 1)
    local levelCfg = BattleDataMgr:getLevelCfg()
    self.Label_battleInfo:setTextById(300839, levelCfg.order)
end

function EndlessPauseView:registerEvents()
    self.Button_leave:onClick(function()
            EventMgr:dispatchEvent(eEvent.EVENT_LEAVE)
            AlertManager:closeLayer(self)
    end)

    self.Button_continue:onClick(function()
            EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
            AlertManager:closeLayer(self)
    end)

    --TODO 设置
    self.Button_set:onClick(function()
        Utils:openView("settings.SettingsView")
    end)
end

return EndlessPauseView
