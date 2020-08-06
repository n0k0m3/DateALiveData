local DispatchMainLayer = class("DispatchMainLayer", BaseLayer)

function DispatchMainLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dispatch.dispatchMainLayer")
end

function DispatchMainLayer:onEnter()
    self.super.onEnter(self)

end

function DispatchMainLayer:onExit()
    self.super.onExit(self)
end

function DispatchMainLayer:onShow()
    self.super.onShow(self)
    self:updateRedPoints()
    self:timeOut(function()
        self:removeLockLayer()
        GameGuide:checkGuide(self)
    end,0.05)
    self:timeOut(function()
        DispatchDataMgr:reqHeroDispatchInfo()
        DispatchDataMgr:reqHeroStars()

        if DispatchDataMgr:checkHasRewards() then
            DispatchDataMgr:reqFinishHeroDispatch()
        end
    end,0.1)
end

function DispatchMainLayer:initData()
    self.HangupMap = TabDataMgr:getData("Hangup")
    self.buildItems_ = {}
end

function DispatchMainLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self:addLockLayer()
    self.Panel_back = TFDirector:getChildByPath(self.ui, "Panel_back")
    self.Panel_content = TFDirector:getChildByPath(self.ui, "Panel_content")
    self.UI_content = TFDirector:getChildByPath(self.ui, "UI_content")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Button_hero = TFDirector:getChildByPath(self.ui, "Button_hero")

    self.Panel_build_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_build_item")

    self:initContent()
end

function DispatchMainLayer:initContent()
    self:initBuilds()
end

function DispatchMainLayer:initBuilds()
    for k,cfg in pairs(self.HangupMap) do
        local foo = {}
        foo.root = self.Panel_build_item:clone()
        foo.Panel_touch = TFDirector:getChildByPath(foo.root, "Panel_touch")
        foo.Image_bg_icon = TFDirector:getChildByPath(foo.root, "Image_bg_icon")
        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        foo.Image_cover_icon = TFDirector:getChildByPath(foo.root, "Image_cover_icon")
        foo.Image_dispatch_flag = TFDirector:getChildByPath(foo.root, "Image_dispatch_flag")
        foo.Image_time_bg = TFDirector:getChildByPath(foo.root, "Image_time_bg")
        foo.LoadingBar_time = TFDirector:getChildByPath(foo.root, "LoadingBar_time")
        foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
        foo.Label_unlock = TFDirector:getChildByPath(foo.root, "Label_unlock")
        foo.Image_dispatch_tips = TFDirector:getChildByPath(foo.root, "Image_dispatch_tips")
        foo.Label_dispatch_tips = TFDirector:getChildByPath(foo.root, "Label_dispatch_tips")
        foo.Image_comming = TFDirector:getChildByPath(foo.root, "Image_comming")
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.Image_red_tip = TFDirector:getChildByPath(foo.root, "Image_red_tip")
        foo.Panel_spine = TFDirector:getChildByPath(foo.root, "Panel_spine")
        local heroItems = {}
        for i=1,3 do
            local heroItem = {}
            local Panel_hero = TFDirector:getChildByPath(foo.root, "Panel_hero"..i)
            heroItem.Image_bg = TFDirector:getChildByPath(Panel_hero, "Image_bg")
            heroItem.Image_add = TFDirector:getChildByPath(Panel_hero, "Image_add")
            heroItem.Image_hero_cover = TFDirector:getChildByPath(Panel_hero, "Image_hero_cover")
            heroItem.Image_gray_cover = TFDirector:getChildByPath(Panel_hero, "Image_gray_cover")
            heroItem.Image_hero_icon = TFDirector:getChildByPath(Panel_hero, "Image_hero_icon")
            heroItems[i] = heroItem
        end
        foo.heros = heroItems
        local buildPos = cfg.excursion
        foo.root:setPosition(ccp(buildPos[1],buildPos[2]))
        self.UI_content:addChild(foo.root)
        self.buildItems_[cfg.id] = foo
        foo.Panel_touch:setTouchEnabled(cfg.Open)
        foo.Panel_touch:onClick(function()
            if not cfg.Open or MainPlayer:getPlayerLv() < cfg.openLeve then
                Utils:showTips(213168)
                return
            end
            Utils:openView("dispatch.DispatchDetailLayer",{tabIdx = cfg.id})
            GameGuide:checkGuideEnd(self.guideFuncId)
        end)
    end
    self:updateBuilds()
    self:addUpdateTimer()
end

function DispatchMainLayer:updateBuilds()
    for id, foo in pairs(self.buildItems_) do
        self:updateBuildingItem(foo, self.HangupMap[id])
    end
end

function DispatchMainLayer:updateBuildingItem(foo, cfg)
    local dungeonInfo = DispatchDataMgr:getDispatchingDungeonInfo(cfg.id)
    local dispatchHeros = DispatchDataMgr:getDispathedHeros(cfg.id)
    local enableDispatch = DispatchDataMgr:checkDiapatchEnable(cfg.id)
    local playerLv = MainPlayer:getPlayerLv()
    foo.Image_red_tip:setVisible(DispatchDataMgr:checkEnableGetDispatchRewards(cfg.id))
    foo.Image_lock:setVisible(not cfg.Open or playerLv < cfg.openLeve)
    foo.Label_unlock:setVisible(not cfg.Open or playerLv < cfg.openLeve)
    foo.Image_comming:setVisible(not cfg.Open)
    foo.Label_name:setTextById(tonumber(cfg.prompt))
    foo.Image_icon:setTexture(cfg.functionsIcon)
    foo.Image_bg_icon:setVisible(dungeonInfo ~= nil)
    foo.Image_time_bg:setVisible(dungeonInfo ~= nil)
    foo.Image_dispatch_tips:show()
    foo.Image_dispatch_flag:setVisible(not dungeonInfo and enableDispatch)
    if enableDispatch and not dungeonInfo then
        if not foo.Spine_effect then
            foo.Spine_effect = SkeletonAnimation:create("effect/effect_ZHzhuye/effect_ZHzhuye")
            foo.Panel_spine:addChild(foo.Spine_effect, 0)
            foo.Spine_effect:play("effect_ZHzhuye1",true)
        end
    else
        if foo.Spine_effect then
            foo.Spine_effect:removeFromParent()
            foo.Spine_effect = nil
        end
    end
    if dungeonInfo then
        foo.Label_dispatch_tips:setTextById(213121)
    elseif enableDispatch then 
        foo.Label_dispatch_tips:setTextById(213169)
    else
        if #DispatchDataMgr:getDispatchHangUpCfgs(cfg.id) < 1 then
            foo.Image_dispatch_tips:hide()
        else
            foo.Label_dispatch_tips:setTextById(213122)
        end
    end
    if not foo.Spine_foot then
        foo.Spine_foot = SkeletonAnimation:create("effect/effect_ZHzhuye/effect_ZHzhuye")
        foo.Panel_spine:addChild(foo.Spine_foot, 0)
        foo.Spine_foot:setPosition(ccp(2, -140))
        foo.Spine_foot:play("effect_ZHzhuye2",true)
    end
    for i=1,3 do
        local heroId = dispatchHeros[i]
        if heroId then
            foo.heros[i].Image_hero_icon:setVisible(true)
            foo.heros[i].Image_hero_cover:setVisible(true)
            foo.heros[i].Image_gray_cover:setVisible(true)
            foo.heros[i].Image_hero_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
            foo.heros[i].Image_hero_icon:setScale(0.5)
        else
            foo.heros[i].Image_hero_icon:setVisible(false)
            foo.heros[i].Image_hero_cover:setVisible(false)
            foo.heros[i].Image_gray_cover:setVisible(false)
        end
    end
    if dungeonInfo then
        local config = DispatchDataMgr:getHangUpCfg(dungeonInfo.dungeonCid)
        local suplusTime = dungeonInfo.eTime - ServerDataMgr:getServerTime()
        local percent = (suplusTime / (config.hangupTime * 60)) * 100
        local iconPath = "ui/dispatch/ui_057.png"
        if percent >= 75 then
            iconPath = "ui/dispatch/ui_054.png"
        elseif percent >= 50 then
            iconPath = "ui/dispatch/ui_056.png"
        elseif percent >= 25 then
            iconPath = "ui/dispatch/ui_055.png"
        end
        foo.LoadingBar_time:setTexture(iconPath)
        foo.LoadingBar_time:setPercent(percent)
    end
end

function DispatchMainLayer:updateRedPoints()
    
end

function DispatchMainLayer:addUpdateTimer()
    if not self.updateTimer_ then
        self.updateTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.updateBuilds, self))
    end
end

function DispatchMainLayer:removeUpdateTimer()
    if self.updateTimer_ then
        TFDirector:removeTimer(self.updateTimer_)
        self.updateTimer_ = nil
    end
end

function DispatchMainLayer:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_ADD_DISPATCH_DANGUP, handler(self.updateBuilds, self))
    EventMgr:addEventListener(self, EV_FUBEN_CANCEL_DISPATCH_DANGUP, handler(self.updateBuilds, self))
    EventMgr:addEventListener(self, EV_FUBEN_GET_DISPATCH_DANGUP_REWARD, handler(self.updateBuilds, self))
    EventMgr:addEventListener(self,EV_FUBEN_ADD_DISPATCH_HEROS,handler(self.updateBuilds, self))

    self.Button_hero:onClick(function()
        Utils:openView("dispatch.DispatchHeroLayer")
    end)
end

function DispatchMainLayer:removeEvents()
    self:removeUpdateTimer()
end

--引导点击约会派遣
function DispatchMainLayer:excuteGuideFunc20001(guideFuncId)
    local targetNode
    for id, foo in pairs(self.buildItems_) do
        if id == EC_DISPATCHType.DATING then
            targetNode = foo.Image_icon
            break
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 0))
end

return DispatchMainLayer