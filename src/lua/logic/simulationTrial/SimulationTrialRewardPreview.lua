
local SimulationTrialRewardPreview = class("SimulationTrialRewardPreview", BaseLayer)

function SimulationTrialRewardPreview:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.simulationTrialRewardPreviewView")
end

function SimulationTrialRewardPreview:initData(levelGroupId,rewardId)
    self.levelGroupId_   = levelGroupId
    self.levelGroupCfg_  = FubenDataMgr:getLevelGroupCfg(levelGroupId)
    -- self.levelGroupInfo_ = FubenDataMgr:getLevelGroupInfo(levelGroupId)
    self.rewardId = rewardId or 1
    self.data = self.levelGroupCfg_.reward[1][rewardId]
end

function SimulationTrialRewardPreview:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root         = TFDirector:getChildByPath(ui, "Panel_root")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.ListView_reward    = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(5)
    self.Button_close       = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_get         = TFDirector:getChildByPath(self.Panel_root, "Button_get"):hide()
    self.Label_state        = TFDirector:getChildByPath(self.Panel_root, "Label_state"):hide()
    self.Label_star_num     = TFDirector:getChildByPath(self.Panel_root, "Label_star_num")
    self.Label_star_num:setText(tostring(self.data.cond[1]))
    self.Image_star         = TFDirector:getChildByPath(self.Panel_root, "Image_star")
    local heroId = FubenDataMgr:getSelectSimulationHeroId()
    local cfg = FubenDataMgr:getSimulationTrialCfg(heroId)
    if cfg and cfg.rewardstar and cfg.rewardstar.rewardstar then
        self.Image_star:setTexture(cfg.rewardstar.rewardstar)
    end

    local count = 0
    for k, v in pairs(self.data.reward) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
        self.ListView_reward:pushBackCustomItem(Panel_goodsItem)
        count = count + 1
    end
    local size = me.size(114 *count,110)
    self.ListView_reward:setContentSize(size)
end

function SimulationTrialRewardPreview:registerEvents()
    EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_UPDATE, handler(self.onSimulationTrialUpdate, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function SimulationTrialRewardPreview:onSimulationTrialUpdate()
    if not FubenDataMgr:getSimulationTrialIsOpen() then 
        AlertManager:closeLayer(self)
    end
end
return SimulationTrialRewardPreview
