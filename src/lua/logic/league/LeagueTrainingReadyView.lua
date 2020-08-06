local LeagueTrainingReadyView = class("LeagueTrainingReadyView", BaseLayer)
require "lua.public.ScrollMenu"

function LeagueTrainingReadyView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.league.leagueTrainingReadyView")
end

function LeagueTrainingReadyView:registerEvents()
    EventMgr:addEventListener(self, EV_UNION_TRAINMATRIX_REVERT, handler(self.updateUI, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.updateTask, self))

    self.Button_task:onClick(function()
        local themeconf = self.themeList[self.curSelThemeIdx]
        if themeconf then
            --dump(themeconf, "themeconf")
            Utils:openView("league.LeagueTrainingTaskView", themeconf.mission)
        end
    end)

    self.Button_go:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_detail:onClick(function(sender)
        local themeconf = self.themeList[self.curSelThemeIdx]
        if themeconf then
            Utils:openView("league.LeagueTrainingBriefView", themeconf.id)
        end
    end)
end

function LeagueTrainingReadyView:initData()
    self.themeList = nil
    self.curSelThemeIdx = nil
end

function LeagueTrainingReadyView:initUI(ui)
    self.super.initUI(self, ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_themeItem = TFDirector:getChildByPath(Panel_prefab, "Panel_themeItem")

    self.Panel_model = TFDirector:getChildByPath(ui, "Panel_model")
    self.Panel_theme = TFDirector:getChildByPath(ui, "Panel_theme")
    self.Panel_info = TFDirector:getChildByPath(ui, "Panel_info")
    self.Label_theam_title = TFDirector:getChildByPath(self.Panel_info, "Label_theam_title")
    self.Label_train_name = TFDirector:getChildByPath(self.Panel_info, "Label_train_name")
    self.Label_train_content = TFDirector:getChildByPath(self.Panel_info, "Label_train_content")
    self.Button_detail = TFDirector:getChildByPath(self.Panel_info, "Button_detail")

    self.Button_task = TFDirector:getChildByPath(ui, "Button_task")
    self.Label_taskPercent = TFDirector:getChildByPath(ui, "Label_taskPercent")
    self.Button_go = TFDirector:getChildByPath(ui, "Button_go")
    self.ListView_theme = UIListView:create(TFDirector:getChildByPath(self.Panel_theme, "ScrollView_theme"))
    self.ListView_reward = UIListView:create(TFDirector:getChildByPath(self.Panel_info, "ScrollView_reward"))
    self.ListView_theme:setItemsMargin(2)
    self:initThemeList()
end

function LeagueTrainingReadyView:initThemeList()
    self.ListView_theme:removeAllItems()
    self.themeList = LeagueDataMgr:getTrainMatrixThemeList()
    local curthemeid = LeagueDataMgr:getTrainMatrixThemeId()
    local idx = 1
    for i, v in ipairs(self.themeList) do
        if v.id == curthemeid then
            idx = i
            break
        end
    end
    self.curSelThemeIdx = idx
    for i, v in ipairs(self.themeList) do
        local item = self.Panel_themeItem:clone()
        self:updateThemeItem(item, i)
        if i == self.curSelThemeIdx then
            self.selectItem = item
        end
        self.ListView_theme:pushBackCustomItem(item)
    end
    self:updatePanelInfo()
end

function LeagueTrainingReadyView:updateThemeItem(item,idx)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Label_theme = TFDirector:getChildByPath(item,"Label_theme")
    local Panel_clip_hero = TFDirector:getChildByPath(item,"Panel_clip_hero")
    local Image_hero_icon = TFDirector:getChildByPath(item,"Image_hero_icon")
    local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
    local curthemeid = LeagueDataMgr:getTrainMatrixThemeId()
    local cfg = self.themeList[idx]
    Label_theme:setTextById(cfg.trainingtitle)
    Image_hero_icon:setTexture(cfg.subject)
    if self.curSelThemeIdx == idx then
        Image_bg:setTexture("ui/league/texun/020.png")
        Image_lock:setContentSize(CCSizeMake(218, 125))
        Panel_clip_hero:setPositionX(218)
    else
        Image_bg:setTexture("ui/league/texun/019.png")
        Image_lock:setContentSize(CCSizeMake(185, 124))
        Panel_clip_hero:setPositionX(184)
    end
    Image_lock:setVisible(cfg.id ~= curthemeid)

    item:setTouchEnabled(true)
    item:onClick(function()
        if self.curSelThemeIdx == idx then
            return
        end
        local lastIdx = self.curSelThemeIdx
        self.curSelThemeIdx = idx
        if self.selectItem then
            self:updateThemeItem(self.selectItem, lastIdx)
        end
        self:updateThemeItem(item, self.curSelThemeIdx)
        self.selectItem = item
        self:updatePanelInfo()
    end)
end

function LeagueTrainingReadyView:updatePanelInfo()
    local themeCfg = self.themeList[self.curSelThemeIdx]
    if themeCfg then
        Utils:createHeroModel(themeCfg.hero, self.Panel_model, 0.4, themeCfg.heromodel,true)

        self.Label_theam_title:setTextById(themeCfg.trainingtitle)
        self.Label_train_name:setTextById(themeCfg.trainingtitle1)
        self.Label_train_content:setTextById(themeCfg.trainingdes1)

        local rewards = themeCfg.cleareditem
        local newcount = #rewards
        local oldcount = #self.ListView_reward:getItems()
        if newcount >= oldcount then
            local addcount = newcount - oldcount
            for i = 1, addcount do
                local itemPrefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
                local item = itemPrefab:clone()
                item:setScale(0.7)
                self.ListView_reward:pushBackCustomItem(item)
            end
        else
            local removecount = oldcount - newcount
            for i = 1, removecount do
                self.ListView_reward:removeLastItem()
            end
        end
        for i, v in ipairs(rewards) do
            local item = self.ListView_reward:getItem(i)
            PrefabDataMgr:setInfo(item, v[1], v[2])
        end

        local bCanFight = tobool(LeagueDataMgr:getTrainMatrixThemeId() == themeCfg.id and LeagueDataMgr:getTrainMatrixInfo().remainTimes > 0)
        self.Button_go:setTouchEnabled(bCanFight)
        self.Button_go:setGrayEnabled(not bCanFight)
    else
        self.Button_go:setTouchEnabled(false)
        self.Button_go:setGrayEnabled(true)
    end

    self:updateTask()
end

function LeagueTrainingReadyView:updateTask()
    local themeCfg = self.themeList[self.curSelThemeIdx]
    if themeCfg then
        local ingCount, getCount, getedCount = TaskDataMgr:getTaskCountByCids(themeCfg.mission)
        local allCount = ingCount + getCount + getedCount
        if allCount <= 0 then
            allCount = 1
        end
        local finishCount = getCount + getedCount
        self.Label_taskPercent:setText(tostring(finishCount).."/"..tostring(allCount))
    end
end

return LeagueTrainingReadyView