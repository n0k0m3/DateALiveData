
local SimulationTrialReward = class("SimulationTrialReward", BaseLayer)
function SimulationTrialReward:initData(heroId)
    self.missionDatas = TabDataMgr:getData("HerotestMission")
    self.heroId = heroId
    local cfg = FubenDataMgr:getSimulationTrialCfg(heroId)
    if not cfg then
        Box("no heroId "..tostring(heroId).." in SimulationTrialHigh")
        return
    end
    self.resConfig = cfg.reward
end

function SimulationTrialReward:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig."..self.resConfig.ui)
end

function SimulationTrialReward:initUI(ui)
    self.super.initUI(self, ui)
    -- local Panel_root      = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_root       = TFDirector:getChildByPath(ui, "Panel_parent")
    local Image_sign      = TFDirector:getChildByPath(self.Panel_root, "Image_sign")
    local Label_title_en  = TFDirector:getChildByPath(Image_sign, "Label_title_en")
    Label_title_en:setTextById(self.resConfig.titleEn)
    local Label_title     = TFDirector:getChildByPath(Image_sign, "Label_title")
    Label_title:setTextById(self.resConfig.titleCn)

    self.Panel_starItems   = {}
    self.Panel_starItems[1]   = TFDirector:getChildByPath(ui, "Panel_prefab_reward1"):hide()
    self.Panel_starItems[2]   = TFDirector:getChildByPath(ui, "Panel_prefab_reward2"):hide()
    local ScrollView_reward1 = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward1")
    self.ListView_reward1    = UIListView:create(ScrollView_reward1)
    self.Button_close     = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Label_tip        = TFDirector:getChildByPath(self.Panel_root, "Image_tip")
    self.Panel_btns       = TFDirector:getChildByPath(self.Panel_root , "Panel_btns")
    self.tabs = {} 
    self.tabs[1] = TFDirector:getChildByPath(self.Panel_btns  , "Button_reward1")
    
    self.tabs[2] = TFDirector:getChildByPath(self.Panel_btns  , "Button_reward2")
    self.tabs[2].Image_lock = TFDirector:getChildByPath(self.tabs[2]  , "Image_lock")

    TFDirector:getChildByPath(self.tabs[1]  , "Label_name"):setTextById(self.resConfig.buttonId1)
    TFDirector:getChildByPath(self.tabs[2]  , "Label_name"):setTextById(self.resConfig.buttonId2)

    self:setSelect(1,true)
end

function SimulationTrialReward:isTabLock(index)
    if index == 2 then 
        return not FubenDataMgr:hasFAN_ZHE(self.heroId)
    end
    return false
end

function SimulationTrialReward:setSelect(index,force)
    self.tabs[2].Image_lock:setVisible(self:isTabLock(2))
    -- if self:isTabLock(index) then
    --     return
    -- end
    if self.chooseIndex ~= index  or force then
        self.chooseIndex = index
        for k , tab in ipairs(self.tabs) do
            if k == self.chooseIndex then
--                if k == 1 then 
--                    tab:setTextureNormal(self.resConfig.btnRes1) 
--                else
--                    tab:setTextureNormal(self.resConfig.btnRes2 or "ui/simulation_trial/tab2.png")
--                end
                tab:setTextureNormal(self.resConfig.btnRes1)
                -- tab:setTouchEnabled(false)
            else
                tab:setTextureNormal(self.resConfig.btnRes2 or "ui/simulation_trial/tab.png")
                -- tab:setTouchEnabled(true)
            end
        end
        if self.chooseIndex == 1 then --首通奖励
            self.Label_tip:hide()
            local size = self.ListView_reward1:getContentSize()
            size.height = 350
            self.ListView_reward1:setContentSize(size) 
        else --击杀奖励
            self.Label_tip:show()
            local size = self.ListView_reward1:getContentSize()
            size.height = 350 - 65
            self.ListView_reward1:setContentSize(size) 
        end
        self:refreshView()
    end
end




function SimulationTrialReward:refreshView()
    -- local jumpIndex
    self.ListView_reward1:removeAllItems()

    local tasks = FubenDataMgr:getSimulationTrialHeroInfo(self.heroId).tasks_[self.chooseIndex]
    if tasks then 
        for i, v in ipairs(tasks) do
            local item = self:addStarItem(self.chooseIndex)
            item.tag = v.id
            self:updateStarItem(item, v)
        end
    end
end

function SimulationTrialReward:addStarItem(index)
    local item = self.Panel_starItems[index]:clone()
    item:show()
    item.Button_get  = TFDirector:getChildByPath(item, "Button_rev")
    item.Label_state = TFDirector:getChildByPath(item, "Label_state")
    item.Label_desc  = TFDirector:getChildByPath(item, "Label_desc")
    local ScrollView_reward = TFDirector:getChildByPath(item, "ScrollView_reward")
    item.ListView_reward = UIListView:create(ScrollView_reward)
    item.ListView_reward:setItemsMargin(2)
    self.ListView_reward1:pushBackCustomItem(item)
    return item
end

function SimulationTrialReward:updateStarItem(item, data)
    local status = data.status
    local cfg = self.missionDatas[data.id]
    -- dump(self.missionDatas)
    item.ListView_reward:removeAllItems()
    item.Label_desc:setTextById(cfg.missionName)
    for k, v in pairs(cfg.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.6)
        PrefabDataMgr:setInfo(Panel_goodsItem, v[1], v[2])
        item.ListView_reward:pushBackCustomItem(Panel_goodsItem)
    end
    item.Button_get:setVisible(status == 2)
    item.Label_state:setVisible(status ~= 2)
    if status == 3 then
        item.Label_state:setTextById(270491)
    elseif status == 1 then
        item.Label_state:setTextById(1300007)
    end
    item.Button_get:onClick(function()
        FubenDataMgr:send_HERO_REQ_COMPLETE_STTASK(data.id)
    end)
end

function SimulationTrialReward:registerEvents()
    EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_UPDATE, handler(self.onSimulationTrialUpdate, self))
    EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_TASK_REWARD, handler(self.onGetRewardEvent, self))

    self.Button_close:onClick(function()
        AlertManager:close()
    end)

    self.tabs[1]:onClick(function ( ... )
        self:setSelect(1)
    end)
    self.tabs[2]:onClick(function ( ... )
        self:setSelect(2)
    end)
end

function SimulationTrialReward:onSimulationTrialUpdate()
    if not FubenDataMgr:getSimulationTrialIsOpen() then 
        AlertManager:closeLayer(self)
    end
end
function SimulationTrialReward:onGetRewardEvent(data)
    self.tabs[2].Image_lock:setVisible(self:isTabLock(2))
    -- 更新UI
    local tasks = data.tasks
    local items = self.ListView_reward1:getItems()
    for _, task in ipairs(tasks) do
        for i, item in ipairs(items) do
            if item.tag == task.id then
                self:updateStarItem(item, task)
            end
        end
    end

    -- 弹框提示
    if data.rewards and #data.rewards > 0 then
        local formatReward = {}
        for k, v in pairs(data.rewards) do
            local item = Utils:makeRewardItem(v.id , v.num)
            table.insert(formatReward, item)
        end
        Utils:showReward(formatReward)
    end
end

return SimulationTrialReward
