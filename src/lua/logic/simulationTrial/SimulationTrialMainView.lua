
local SimulationTrialMainView = class("SimulationTrialMainView", BaseLayer)

local ResConfig = 
{ 
    [EC_ActivityFubenType.SIMULATION_TRIAL] = {
        modelScale    = 1.1,
        ui            = "lua.uiconfig.fuben.simulationTrialMainView",
        topBarFileName  = "SimulationTrialMainView1",
        desc_text_id  = 2110001,
        time_string_id= 2108103,
        heroId =110211
    },
    [EC_ActivityFubenType.SIMULATION_TRIAL_2] = {
        modelScale    = 1.08,
        ui        = "lua.uiconfig.fuben.simulationTrialMainView3",
        topBarFileName  = "SimulationTrialMainView2",
        desc_text_id  = 2110012,
        time_string_id= 2108153,
        heroId = 111411 --111301
    },
    [EC_ActivityFubenType.SIMULATION_TRIAL_3] = {
        modelScale    = 1.08,
        ui        = "lua.uiconfig.fuben.simulationTrialMainView2",
        topBarFileName  = "SimulationTrialMainView3",
        desc_text_id  = 2110013,
        time_string_id= 2108153,
        heroId = 111511 --111401
    },
    [EC_ActivityFubenType.SIMULATION_TRIAL_4] = {
        modelScale    = 1.08,
        ui        = "lua.uiconfig.fuben.simulationTrialMainView4",
        topBarFileName  = "SimulationTrialMainView4", 
        desc_text_id  = 2110014,
        time_string_id= 2108193,
        heroId = 110113 
    },
    [EC_ActivityFubenType.SIMULATION_TRIAL_5] = {
        modelScale    = 1.08,
        ui        = "lua.uiconfig.fuben.simulationTrialMainView5",
        topBarFileName  = "SimulationTrialMainView5", 
        desc_text_id  = 2110015,
        time_string_id= 2108220,
        heroId = 110414
    }
}

function SimulationTrialMainView:initData(chapterId)
    dump(chapterId)

    self.resConfig = ResConfig[chapterId]
    self.heroId    = self.resConfig.heroId     -- FubenDataMgr:getSimulationTrialMainHeroId()
    self.topBarFileName = self.resConfig.topBarFileName
    FubenDataMgr:setSelectSimulationHeroId(self.heroId)
end

function SimulationTrialMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init(self.resConfig.ui)
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
    self.Label_desc:setTextById(self.resConfig.desc_text_id)
    self.Label_desc:setSkewX(8)
    self.Label_time          = TFDirector:getChildByPath(self.Panel_root  , "Label_time")
    self.Label_time:setSkewX(8)        
    self.Label_time:setTextById(self.resConfig.time_string_id)
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
    local tasks = FubenDataMgr:getSimulationTrialInfo().tasks
    if tasks then 
        for i,v in ipairs(tasks) do
            if v.status == 2 then 
                isShow = true
                break
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
