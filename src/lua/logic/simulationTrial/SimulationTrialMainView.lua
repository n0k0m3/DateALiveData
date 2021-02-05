
local SimulationTrialMainView = class("SimulationTrialMainView", BaseLayer)
function SimulationTrialMainView:initData(chapterId)
    dump(chapterId)

    self.heroId,self.resConfig = self:getResConfig(chapterId)--ResConfig[chapterId]
    -- FubenDataMgr:getSimulationTrialMainHeroId()
    dump(self.resConfig)
    self.topBarFileName = self.resConfig.topHelp
    FubenDataMgr:setSelectSimulationHeroId(self.heroId)
    --Box("SimulationTrialMainView")
end

function SimulationTrialMainView:getResConfig(chapterId)
    local heroId,cfgData
    local cfg = TabDataMgr:getData("SimulationTrialHigh")
    for k,v in pairs(cfg) do
        if v.main.chapterId == chapterId then
            heroId,cfgData = k,v.main
            break
        end
    end
    return heroId,cfgData
end

function SimulationTrialMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    print(self.resConfig.ui)
    self:init("lua.uiconfig."..self.resConfig.ui)
end

function SimulationTrialMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root       = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_role          = TFDirector:getChildByPath(self.Panel_root  , "Image_role")
    self.Button_view_role    = TFDirector:getChildByPath(self.Panel_root  , "Button_view_role")
    self.Button_view_role.Image_redpoint    = TFDirector:getChildByPath(self.Button_view_role  , "Image_redpoint")
    self.Button_enter_funben = TFDirector:getChildByPath(self.Panel_root  , "Button_enter_funben")
    self.Button_enter_funben.Image_redpoint    = TFDirector:getChildByPath(self.Button_enter_funben  , "Image_redpoint")
    self.Button_call         = TFDirector:getChildByPath(self.Panel_root  , "Button_call")
    self.Button_call.Image_redpoint    = TFDirector:getChildByPath(self.Button_call  , "Image_redpoint"):hide()
    self.Button_strategy     = TFDirector:getChildByPath(self.Panel_root  , "Button_strategy")
    self.Button_strategy.Image_redpoint    = TFDirector:getChildByPath(self.Button_strategy  , "Image_redpoint"):hide()
    self.Label_desc          = TFDirector:getChildByPath(self.Panel_root  , "Label_desc")
    self.Label_desc:setTextById(self.resConfig.desc)
    self.Label_desc:setSkewX(8)
    self.Label_time          = TFDirector:getChildByPath(self.Panel_root  , "Label_time")
    self.Label_time:setSkewX(8)        
    self.Label_time:setTextById(self.resConfig.timeStr)
    Utils:createHeroModel(self.heroId, self.Image_role,self.resConfig.modelScale)
    --召唤红点
    -- self:onRedPointUpdateSummon()
    --试炼关卡洪点
    self:onRedPointUpdateSimulationTrialLevel()
    --精灵成长红点
    self:onRedPointUpdateRole()
end


function SimulationTrialMainView:registerEvents()
    -- EventMgr:addEventListener(self, EV_SUMMON_COMPOSE_UPDATE, handler(self.onRedPointUpdateSummon, self))
    EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_UPDATE, handler(self.onRedPointUpdateSimulationTrialLevel, self))
    EventMgr:addEventListener(self, EV_SIMULATION_TRIAL_TASK_REWARD, handler(self.onRedPointUpdateSimulationTrialLevel, self))
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onRedPointUpdateSimulationTrialLevel, self))
    self.Button_view_role:onClick(function()
        HeroDataMgr.showid =  self.heroId
        Utils:openView("simulationTrial.FairyTrailDetailsLayer", {showid=HeroDataMgr.showid , friend=false, gotoWhichTab = 1})
    end)
    self.Button_enter_funben:onClick(function()
        Utils:openView("simulationTrial.SimulationTrialLevelView",self.heroId)
    end)
    self.Button_call:onClick(function()
        -- FunctionDataMgr:jSummonMain()
        FunctionDataMgr:jSummon()
        AlertManager:closeLayer(self)
    end)
    self.Button_strategy:onClick(function()
        Utils:openView("fairyNew.FairyStrategyView", self.heroId)
    end)
end

--召唤红点
-- function SimulationTrialMainView:onRedPointUpdateSummon()
--     local isShow = SummonDataMgr:isShowRedPointInMainView()
--     self.Button_call.Image_redpoint:setVisible(isShow)
-- end

--关卡
function SimulationTrialMainView:onRedPointUpdateSimulationTrialLevel()
    if not FubenDataMgr:getSimulationTrialIsOpen() then 
        AlertManager:closeLayer(self)
        return
    end
    local isShow = false
    --
    local infos = FubenDataMgr:getSimulationTrialInfo().info_

    if infos then 
        for i,v in pairs(infos) do
            for u,k in ipairs(v.tasks) do
                if k.status == 2 then 
                    isShow = true
                    break
                end
            end
        end
    end
-------第二章奖励
    if not isShow then
        local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(411, 1)
        isShow = isCanReceive
    end
    self.Button_enter_funben.Image_redpoint:setVisible(isShow)
end

--精灵成长
function SimulationTrialMainView:onRedPointUpdateRole()
    local isShow = false
    self.Button_view_role.Image_redpoint:setVisible(isShow)
end

    
return SimulationTrialMainView
