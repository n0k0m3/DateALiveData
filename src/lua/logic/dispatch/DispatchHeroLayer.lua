
local DispatchHeroLayer = class("DispatchHeroLayer", BaseLayer)

function DispatchHeroLayer:initData()
    self.heroIds = {}
    local count = HeroDataMgr:getShowCount()
    for i=1,count do
        local heroId = HeroDataMgr:getSelectedHeroId(i)
        table.insert(self.heroIds, heroId)
    end
    local function siteSort(a,b)
        local cfga = HeroDataMgr:getHero(a)
        local cfgb = HeroDataMgr:getHero(b)
        return cfga.site < cfgb.site
    end
    table.sort(self.heroIds,siteSort)
end

function DispatchHeroLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dispatch.dispatchHeroLayer")
end

function DispatchHeroLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_hero_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_hero_item")
    self.Panel_hero_item:setScale(0.9)
    self.Panel_suit_hero = TFDirector:getChildByPath(self.Panel_prefab, "Panel_suit_hero")

    self.Image_modle = TFDirector:getChildByPath(ui, "Image_modle")
    self.model_pos = self.Image_modle:getPosition()
    self.Label_hero_name = TFDirector:getChildByPath(ui, "Label_hero_name")
    self.Label_hero_desc = TFDirector:getChildByPath(ui, "Label_hero_desc")
    self.LoadingBar_value = TFDirector:getChildByPath(ui, "LoadingBar_value")
    self.Label_fatigue = TFDirector:getChildByPath(ui, "Label_fatigue")
    self.Label_hero_desc = TFDirector:getChildByPath(ui, "Label_hero_desc")
    self.Label_property = TFDirector:getChildByPath(ui, "Label_property")
    self.Panel_info_star = TFDirector:getChildByPath(ui, "Panel_info_star")
    self.Label_no_star_tips = TFDirector:getChildByPath(ui, "Label_no_star_tips")
    self.Image_hero_state = TFDirector:getChildByPath(ui, "Image_hero_state")
    self.Label_hero_state = TFDirector:getChildByPath(ui, "Label_hero_state")
    self.Button_get_power = TFDirector:getChildByPath(ui, "Button_get_power")
    self.Button_goto = TFDirector:getChildByPath(ui, "Button_goto")
    self.Button_get = TFDirector:getChildByPath(ui, "Button_get")

    for i = 1, 5 do
        self["Image_info_star"..i] = TFDirector:getChildByPath(self.Panel_info_star, "Image_info_star"..i)
    end

    self.panel_suit_items = {}
    for i=1,2 do
        local foo = {}
        local item = TFDirector:getChildByPath(ui, "Panel_suit"..i)
        foo.Panel_suit_info = TFDirector:getChildByPath(item, "Panel_suit_info")
        foo.Image_tips_frame = TFDirector:getChildByPath(item, "Image_tips_frame")
        foo.Image_suit_icon = TFDirector:getChildByPath(item, "Image_suit_icon")
        foo.Label_suit_name = TFDirector:getChildByPath(item, "Label_suit_name")
        foo.Image_effect = TFDirector:getChildByPath(item, "Image_effect")
        foo.ScrollView_heros = UIListView:create(TFDirector:getChildByPath(item, "ScrollView_heros"))
        foo.Label_suit_desc = TFDirector:getChildByPath(item, "Label_suit_desc")
        self.panel_suit_items[i] = foo
    end

    self.ScrollView_hero = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_hero"))
    self.ScrollView_hero:setItemModel(self.Panel_hero_item)
    self.ScrollView_hero:setColumn(2)
    self.ScrollView_hero:setColumnMargin(-3)
    self.ScrollView_hero:setRowMargin(5)

    self:refreshView()
end

function DispatchHeroLayer:refreshView()
    self.heroItems = {}
    self.ScrollView_hero:removeAllItems()
    for i, v in ipairs(self.heroIds) do
        local item = self.Panel_hero_item:clone()
        self:updateHeroItem(item,i)
        self.heroItems[i] = item
        self.ScrollView_hero:pushBackCustomItem(item)
        item:setTouchEnabled(true)
        item:onClick(function()
            self:selectHero(i)
        end)
    end
    self:selectHero(1) 
end

function DispatchHeroLayer:selectHero(idx)
    if self.selectHeroIdx == idx then
        return
    end
    self.selectHeroIdx = idx
    local heroId = self.heroIds[idx]
    local item = self.heroItems[idx]
    if self.selectImage then
        self.selectImage:hide()
    end
    local cfg = TabDataMgr:getData("HeroDispatch",heroId)
    self.selectImage = TFDirector:getChildByPath(item, "Image_select")
    self.selectImage:show()
    self.Label_hero_name:setText(HeroDataMgr:getNameById(heroId))
    self.Label_hero_desc:setTextById(cfg.describe)
    -- self.anim_hero = Utils:createHeroModel(heroId, self.Image_hero)
    -- self.anim_hero:setScale(0.32)
    self.Image_modle:setPosition(self.model_pos)
    local skinid = HeroDataMgr:getCurSkin(heroId)
    local model = Utils:createHeroModel(self.selectHeroId, self.Image_modle, 0.50, skinid,true)
    model:update(0.1)
    model:stop()

    self.Image_modle:setPosition(ccp(self.model_pos.x + (cfg.excursion[1] or 0),self.model_pos.y + (cfg.excursion[2] or 0)))
    local stars = DispatchDataMgr:getHeroStars(heroId)
    for i=1,5 do
        self["Image_info_star"..i]:setVisible(i <= stars)
    end
    self.Label_no_star_tips:setVisible(stars <=0)
    self.Label_no_star_tips:setTextById(213185)
    local exhaustion = DispatchDataMgr:getHeroExhaustion(heroId)
    
    self.Label_fatigue:setText(exhaustion.."/"..cfg.restorationCap)
    self.LoadingBar_value:setPercent(exhaustion / cfg.restorationCap * 100)

    local fetterList = cfg.fetterList
    for i, foo in ipairs(self.panel_suit_items) do
        if fetterList[i] then
            foo.Panel_suit_info:show()
            foo.Image_tips_frame:hide()
            local buffCfg = TabDataMgr:getData("HangupBuff",fetterList[i])
            foo.Image_suit_icon:setTexture(buffCfg.functionsIcon)
            foo.Label_suit_name:setTextById(tonumber(buffCfg.name))
            foo.Label_suit_desc:setTextById(tonumber(buffCfg.describe))
            foo.ScrollView_heros:removeAllItems()
            for k, v in pairs(buffCfg.role) do
                local heroItem = self.Panel_suit_hero:clone()
                local heroId = tonumber(k)
                local Image_icon = TFDirector:getChildByPath(heroItem, "Image_icon")
                Image_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
                Image_icon:setScale(0.68)
                local Panel_star = TFDirector:getChildByPath(heroItem, "Panel_star"):hide()
                if HeroDataMgr:getIsHave(heroId) then
                    Panel_star:show()
                    for i=1,5 do
                        local Image_star = TFDirector:getChildByPath(heroItem, "Image_star"..i)
                        Image_star:setVisible(i <= v)
                        Image_star:setPositionX((-48 + (5 - v) * 8 + i * 16))
                    end
                else
                    Image_icon:setGrayEnabled(true)
                end
                foo.ScrollView_heros:pushBackCustomItem(heroItem)
            end
            foo.Image_effect:setVisible(false)
        else
            foo.Panel_suit_info:hide()
            foo.Image_tips_frame:show()
            TFDirector:getChildByPath(foo.Image_tips_frame, "Label_suit_tips"):setTextById(213168)
        end
    end

    self.Button_goto:setVisible(true)
    self.Image_hero_state:setVisible(true)
    local pType = DispatchDataMgr:getHeroDispatchType(heroId)
    if pType then
        self.Label_hero_state:setText(TextDataMgr:getText(112000212) ..TextDataMgr:getText(self:getDispatchNameId(pType)))
    elseif HeroDataMgr:getIsHave(heroId) then
        self.Button_goto:setVisible(false)
        self.Label_hero_state:setText(TextDataMgr:getText(112000212)..TextDataMgr:getText(213170))
    else
        self.Button_goto:setVisible(false)
        self.Image_hero_state:setVisible(false)
    end
end

function DispatchHeroLayer:getDispatchNameId(pType)
    if pType == EC_DISPATCHType.DAILY then
        return 213206
    elseif pType == EC_DISPATCHType.DATING then
        return 213197
    elseif pType == EC_DISPATCHType.THEATER then
        return 213198
    elseif pType == EC_DISPATCHType.SPRITE then
        return 213199
    elseif pType == EC_DISPATCHType.TEAM then
        return 213200
    end
end

function DispatchHeroLayer:updateHeroItem(item, idx)
    local heroId = self.heroIds[idx]
    local Image_hero_icon = TFDirector:getChildByPath(item, "Image_hero_icon")
    local Image_select = TFDirector:getChildByPath(item, "Image_select"):hide()
    Image_hero_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
    if not HeroDataMgr:getIsHave(heroId) then
        Image_hero_icon:setGrayEnabled(true)
    end
end

function DispatchHeroLayer:registerEvents()
    self.Button_get_power:onClick(function()
        local heroId = self.heroIds[self.selectHeroIdx]
        Utils:openView("fairyNew.FairyMainLayer",{showid = heroId})
    end)
    self.Button_goto:onClick(function()
        local heroId = self.heroIds[self.selectHeroIdx]
        local pType = DispatchDataMgr:getHeroDispatchType(heroId)
        if pType then
            Utils:openView("dispatch.DispatchDetailLayer",{tabIdx = pType})
        end
    end)
    self.Button_get:onClick(function()
        local heroId = self.heroIds[self.selectHeroIdx]
        local needs = HeroDataMgr:getComposeNeed(heroId)
        local costId, costNum
        for k, v in pairs(needs) do
            costId = k
            costNum = v
            break
        end
        self.notHide = true
        Utils:showAccess(costId)
    end)
end

return DispatchHeroLayer
