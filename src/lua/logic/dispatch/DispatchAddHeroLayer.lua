local DispatchAddHeroLayer = class("DispatchAddHeroLayer", BaseLayer)

function DispatchAddHeroLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dispatch.dispatchAddHeroLayer")
end

function DispatchAddHeroLayer:onEnter()
    self.super.onEnter(self)

end

function DispatchAddHeroLayer:initData(data)
    self.hangupSystem_ = TabDataMgr:getData("HangupSystem")
    self.dungeonType = data.dungeonType
    self.dungeonCid = data.dungeonCid or 391
    self.selectedHeros = {}
    self.dispatchData = DispatchDataMgr:getDispatchs(self.dungeonType)
    self.addedHeros = {0,0,0}
    for i,v in ipairs(data.heros) do
        self.addedHeros[i] = v
        self.selectedHeros[v] = 1
    end
    self.hangUpCfg = self.hangupSystem_[self.dungeonCid]
    self:sortHeroIds()
    self.selectHeroId = nil
    self.selectHeroIdx = nil
    self.selectAddedHeroId = nil
end

function DispatchAddHeroLayer:sortHeroIds()
    local added = {}
    self.heroIds = DispatchDataMgr:getAllHeroSortIds(true)
    for i = #self.heroIds, 1, -1 do
        if self.selectedHeros[self.heroIds[i][1]] == 1 then
            table.insert(added, self.heroIds[i])
            table.remove(self.heroIds, i)
        end
    end
    self.addedHeros = {0,0,0}
    for i, v in ipairs(added) do
        table.insert(self.heroIds, 1,added[i])
        self.addedHeros[#added-i + 1] = added[i][1]
    end

end

function DispatchAddHeroLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_left = TFDirector:getChildByPath(self.ui, "Panel_left")
    self.Panel_right = TFDirector:getChildByPath(self.ui, "Panel_right"):hide()
    self.Panel_hero = TFDirector:getChildByPath(self.ui, "Panel_hero")

    self.Image_modle_bg = TFDirector:getChildByPath(self.ui, "Image_modle_bg"):hide()
    self.Image_modle = TFDirector:getChildByPath(self.ui, "Image_modle"):hide()
    self.model_pos = self.Image_modle:getPosition()
    self.Label_title1 = TFDirector:getChildByPath(self.Panel_left, "Label_title1")
    self.ScrollView_added = UIListView:create(TFDirector:getChildByPath(self.Panel_left, "ScrollView_added"))
    self.ScrollView_added:setItemsMargin(0)
    self.Label_diapatch_time = TFDirector:getChildByPath(self.Panel_left, "Label_diapatch_time")
    self.Label_fuben_name = TFDirector:getChildByPath(self.Panel_left, "Label_fuben_name")

    self.Label_title2 = TFDirector:getChildByPath(self.Panel_right, "Label_title2")
    self.Label_title3 = TFDirector:getChildByPath(self.Panel_right, "Label_title3")
    self.Label_hero_name = TFDirector:getChildByPath(self.Panel_right, "Label_hero_name")

    self.Label_desc1 = TFDirector:getChildByPath(self.Panel_right, "Label_desc1")
    self.Label_desc2 = TFDirector:getChildByPath(self.Panel_right, "Label_desc2")

    self.panel_suit_items = {}
    for i=1,2 do
        local foo = {}
        local item = TFDirector:getChildByPath(self.Panel_right, "Panel_suit"..i)
        foo.root = item
        foo.Panel_suit_info = TFDirector:getChildByPath(item, "Panel_suit_info")
        foo.Image_tips_frame = TFDirector:getChildByPath(item, "Image_tips_frame")
        foo.Image_suit_icon = TFDirector:getChildByPath(item, "Image_suit_icon")
        foo.Label_suit_name = TFDirector:getChildByPath(item, "Label_suit_name")
        foo.Image_effect = TFDirector:getChildByPath(item, "Image_effect")
        foo.ScrollView_heros = UIListView:create(TFDirector:getChildByPath(item, "ScrollView_heros"))
        foo.Label_suit_desc = TFDirector:getChildByPath(item, "Label_suit_desc")
        self.panel_suit_items[i] = foo
    end

    self.Button_dispatch = TFDirector:getChildByPath(self.Panel_hero, "Button_dispatch")
    self.Label_dispatch = TFDirector:getChildByPath(self.Button_dispatch, "Label_dispatch")
    self.ScrollView_hero_list = UIListView:create(TFDirector:getChildByPath(self.Panel_hero, "ScrollView_hero_list"))
    self.ScrollView_hero_list:setItemsMargin(10)

    self.Panel_hero_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_hero_item")
    self.Panel_add_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_add_item")
    self.Panel_suit_hero = TFDirector:getChildByPath(self.Panel_prefab, "Panel_suit_hero")

    self:refreshUI()
end

function DispatchAddHeroLayer:refreshUI()
    self:refreshHeroUI()
    self:refreshLeftUI()
end

function DispatchAddHeroLayer:refreshLeftUI()
    self.ScrollView_added:removeAllItems()
    local effectSuit = DispatchDataMgr:getEffectSuitIds(self.dungeonType)
    for i,v in ipairs(self.addedHeros) do
        local item = self.Panel_add_item:clone()
        local Image_add = TFDirector:getChildByPath(item, "Image_add")
        local Panel_info = TFDirector:getChildByPath(item, "Panel_info"):hide()
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Label_hero_name = TFDirector:getChildByPath(item, "Label_hero_name")
        local LoadingBar_progress = TFDirector:getChildByPath(item, "LoadingBar_progress")
        local Label_percent = TFDirector:getChildByPath(item, "Label_percent")
        local Panel_star = TFDirector:getChildByPath(item, "Panel_star")
        local Image_select = TFDirector:getChildByPath(item, "Image_select")
        local Image_buff_icon1 = TFDirector:getChildByPath(item, "Image_buff_icon1")
        local Image_buff_icon2 = TFDirector:getChildByPath(item, "Image_buff_icon2")
        if v > 0 then
            Image_add:hide()
            Panel_info:show()
            Image_select:setVisible(self.selectAddedHeroId == v)
            Image_icon:setTexture(HeroDataMgr:getIconPathById(v))
            Image_icon:setScale(0.68)
            Label_hero_name:setText(HeroDataMgr:getNameById(v))
            local exhaustion = DispatchDataMgr:getHeroExhaustion(v)
            local cfg = TabDataMgr:getData("HeroDispatch",v)
            Label_percent:setText(exhaustion.."/"..cfg.restorationCap)
            LoadingBar_progress:setPercent(exhaustion / cfg.restorationCap * 100)
            if exhaustion < self.hangUpCfg.consumptionFatigue then
                Label_percent:setColor(ccc3(219,50,50))
            else
                Label_percent:setColor(ccc3(255,255,255))
            end

            local stars = DispatchDataMgr:getHeroStars(v)
            for i=1,5 do
                local Image_star = TFDirector:getChildByPath(Panel_star, "Image_star"..i)
                Image_star:setVisible(i <= stars)
                Image_star:setPositionX((-50 + (5 - stars) * 8 + i * 16))
            end
            item:setTouchEnabled(true)
            item:onClick(function()
                self.selectHeroId = v
                self.selectAddedHeroId = v
                self:refreshLeftUI()
                self:refreshHeroItems()
                self:updateDispatchBtn(true)
                self:updateRightUI()
            end)

            local fetterList = DispatchDataMgr:getHeroFetterList(v)
            for j = 1, 2 do
                local Image_buff_icon = TFDirector:getChildByPath(item, "Image_buff_icon"..j)
                Image_buff_icon:removeAllChildren()
                if fetterList[j] then
                    local flag = false
                    Image_buff_icon:setVisible(true)
                    Image_buff_icon:setGrayEnabled(true)
                    for k,suitId in ipairs(effectSuit) do
                        if fetterList[j] == suitId then
                            local buffCfg = TabDataMgr:getData("HangupBuff",fetterList[j])
                            if #buffCfg.fetterIcon > 0 then
                                for m, typeId in ipairs(buffCfg.fetterIcon) do
                                    if typeId == self.dungeonType then
                                        Image_buff_icon:setGrayEnabled(false)
                                        flag = true
                                        break
                                    end
                                end
                            else
                                Image_buff_icon:setGrayEnabled(false)
                                flag = true
                            end
                        end
                    end
                    if flag then
                        local buffCfg = TabDataMgr:getData("HangupBuff",fetterList[j])
                        local state = false
                        if #buffCfg.fetterIcon > 0 then
                            for m, typeId in ipairs(buffCfg.fetterIcon) do
                                if typeId == self.dungeonType then
                                    state = true
                                    break
                                end
                            end
                        else
                            state = true
                        end
                        if state then
                            for heroId, star in pairs(buffCfg.role) do
                                local herostar = DispatchDataMgr:getHeroStars(heroId)
                                if self.selectedHeros[heroId] then
                                    if herostar < star then
                                        flag = false
                                    end
                                else
                                    herostar = DispatchDataMgr:getHeroStars(self.selectHeroId)
                                    if self.selectHeroId ~= tonumber(heroId) or herostar < star then
                                        flag = false
                                    end
                                end
                            end
                            if flag then
                                local Spine_effect = SkeletonAnimation:create("effect/effect_zhihuijl/effect_zhihuijl")
                                Image_buff_icon:addChild(Spine_effect, 0)
                                Spine_effect:play("effect_zhihuijl1",true)
                            end
                        end
                    end
                else
                    Image_buff_icon:setVisible(false)
                end
            end

        end
        self.ScrollView_added:pushBackCustomItem(item)
    end
    local costTime = self.hangUpCfg.consumptionFatigue or 0
    self.Label_diapatch_time:setText(costTime.." min")

    local funcCfg = TabDataMgr:getData("Hangup",self.dungeonType)
    self.Label_fuben_name:setTextById(self:getDispatchNameId())
end

function DispatchAddHeroLayer:getDispatchNameId()
    if self.dungeonType == EC_DISPATCHType.DAILY then
        return 213191
    elseif self.dungeonType == EC_DISPATCHType.DATING then
        return 213192
    elseif self.dungeonType == EC_DISPATCHType.THEATER then
        return 213193
    elseif self.dungeonType == EC_DISPATCHType.SPRITE then
        return 213194
    elseif self.dungeonType == EC_DISPATCHType.TEAM then
        return 213195
    end
end

function DispatchAddHeroLayer:updateRightUI()
    if not self.selectHeroId then
        self.Image_modle_bg:hide()
        self.Image_modle:hide()
        self.Panel_right:hide()
        return
    end
    self.Image_modle_bg:show()
    self.Image_modle:show()
    self.Panel_right:show()
    self.Image_modle:setPosition(self.model_pos)
    self.Image_modle_bg:setTexture(HeroDataMgr:getPlayerBackdrop(self.selectHeroId))
    local cfg = TabDataMgr:getData("HeroDispatch",self.selectHeroId)
    local skinid = HeroDataMgr:getCurSkin(self.selectHeroId)
    local model = Utils:createHeroModel(self.selectHeroId, self.Image_modle, 0.65, skinid,true)
    model:update(0.1)
    model:stop()

    self.Label_desc1:setTextById(cfg.describe)
    self.Image_modle:setPosition(ccp(self.model_pos.x + (cfg.excursion[1] or 0),self.model_pos.y + (cfg.excursion[2] or 0)))
    self.Label_hero_name:setText(HeroDataMgr:getNameById(self.selectHeroId))
    local fetterList = cfg.fetterList
    for i, foo in ipairs(self.panel_suit_items) do
        if fetterList[i] then
            foo.Panel_suit_info:show()
            foo.Image_tips_frame:hide()
            local buffCfg = TabDataMgr:getData("HangupBuff",fetterList[i])
            foo.Image_suit_icon:setTexture(buffCfg.functionsIcon)
            foo.Label_suit_name:setTextById(tonumber(buffCfg.name))
            foo.Label_suit_desc:setTextById(tonumber(buffCfg.describe))
            local state = true
            if #buffCfg.fetterIcon > 0 then
                for m, typeId in ipairs(buffCfg.fetterIcon) do
                    if typeId ~= self.dungeonType then
                        state = false
                    end
                end
            else
                state = true
            end
            foo.ScrollView_heros:removeAllItems()
            for k, v in pairs(buffCfg.role) do
                local heroId = tonumber(k)
                if not self.selectedHeros[heroId] or DispatchDataMgr:getHeroStars(heroId) < v then
                    state = false
                end
                local heroItem = self.Panel_suit_hero:clone()
                local Image_icon = TFDirector:getChildByPath(heroItem, "Image_icon")
                Image_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
                Image_icon:setScale(0.68)
                local Panel_star = TFDirector:getChildByPath(heroItem, "Panel_star")
                for j=1,5 do
                    local Image_star = TFDirector:getChildByPath(heroItem, "Image_star"..j)
                    Image_star:setVisible(j <= v)
                    Image_star:setPositionX((-50 + (5 - v) * 8 + j * 16))
                end
                if HeroDataMgr:getIsHave(heroId) then
                    if DispatchDataMgr:getHeroStars(heroId) < v then
                        Image_icon:setGrayEnabled(true)
                    end
                else
                    Image_icon:setGrayEnabled(true)
                end
                foo.ScrollView_heros:pushBackCustomItem(heroItem)
            end

            foo.Image_effect:setVisible(state)
        else
            foo.Panel_suit_info:hide()
            foo.Image_tips_frame:show()
            TFDirector:getChildByPath(foo.Image_tips_frame, "Label_suit_tips"):setTextById(213168)
        end
    end
end

function DispatchAddHeroLayer:refreshHeroUI()
    self.ScrollView_hero_list:removeAllItems()
    self.selectImage = nil
    self.heroItems = {}
    for i,v in ipairs(self.heroIds) do
        local item = self.Panel_hero_item:clone()
        local foo = {}
        foo.root = item
        foo.Image_bg_icon = TFDirector:getChildByPath(item, "Image_bg_icon")
        foo.Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        foo.Image_progress_bg = TFDirector:getChildByPath(item, "Image_progress_bg")
        foo.LoadingBar_progress = TFDirector:getChildByPath(item, "LoadingBar_progress")
        foo.Label_percent = TFDirector:getChildByPath(item, "Label_percent")
        foo.Image_not_own = TFDirector:getChildByPath(item, "Image_not_own"):hide()
        foo.Image_dispatched = TFDirector:getChildByPath(item, "Image_dispatched"):hide()
        foo.Panel_star = TFDirector:getChildByPath(item, "Panel_star")
        foo.Image_choosed = TFDirector:getChildByPath(item, "Image_choosed")
        foo.Image_star_limit = TFDirector:getChildByPath(item, "Image_star_limit"):hide()
        foo.Image_added = TFDirector:getChildByPath(item, "Image_added"):hide()
        self.ScrollView_hero_list:pushBackCustomItem(item)
        self.heroItems[i] = foo
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self:selectHero(i)
        end)
    end
    self:selectHero(self.selectHeroIdx and self.selectHeroIdx or 1)
    self:refreshHeroItems()
end

function DispatchAddHeroLayer:refreshHeroItems()
    for i,v in ipairs(self.heroItems) do
        self:updateHeroItem(i)
    end
end

function DispatchAddHeroLayer:selectHero(idx)
    local hero = self.heroIds[idx]
    local state = true
    if hero[2] == 2 then
        state = false
    elseif DispatchDataMgr:getHeroStars(hero[1]) < 1 then
        state = false
    else
        local exhaustion = DispatchDataMgr:getHeroExhaustion(hero[1])
        if exhaustion < self.hangUpCfg.consumptionFatigue then
            if not self.selectedHeros[hero[1]] then
                state = false
            end
        end
    end
    if hero[2] == 1 and not self.selectedHeros[hero[1]] then
        state = false
    end
    
    self.selectHeroId = hero[1]
    self.selectHeroIdx = idx
    self.selectAddedHeroId = -1
    for i, v in ipairs(self.addedHeros) do
        if v == hero[1] then
            self.selectAddedHeroId = hero[1]
            break
        end
    end
    
    if self.selectImage then
        self.selectImage:setVisible(false)
    end
    self:updateHeroItem(idx)
    self:updateDispatchBtn(state)
    self:refreshLeftUI()
    self:updateRightUI()
end

function DispatchAddHeroLayer:updateDispatchBtn(state)
    self.Button_dispatch:setGrayEnabled(false)
    self.Button_dispatch:setTouchEnabled(true)
    if (not state and self.selectAddedHeroId == -1) or self.dispatchData then
        self.Button_dispatch:setGrayEnabled(true)
        self.Button_dispatch:setTouchEnabled(false)
    end
    if self.selectedHeros[self.selectHeroId] then
        self.Label_dispatch:setTextById(213182)
    else
        self.Label_dispatch:setTextById(213183)
    end
end

function DispatchAddHeroLayer:updateHeroItem(idx)
    local foo = self.heroItems[idx]
    local hero = self.heroIds[idx]
    foo.Image_dispatched:hide()
    foo.Image_added:hide()
    foo.Image_bg_icon:setTexture("ui/dispatch/ui_079.png")
    foo.Image_icon:setTexture(HeroDataMgr:getIconPathById(hero[1]))
    foo.Image_icon:setScale(0.84)
    if hero[2] == 2 then
        foo.Image_progress_bg:hide()
        foo.Image_not_own:show()
        foo.Image_icon:setGrayEnabled(true)
    else
        if hero[2] == 1 then
            if self.selectedHeros[hero[1]] then
                
            else
                foo.Image_dispatched:show()
            end       
        end
        local exhaustion = DispatchDataMgr:getHeroExhaustion(hero[1])
        local cfg = TabDataMgr:getData("HeroDispatch",hero[1])
        foo.Label_percent:setText(exhaustion.."/"..cfg.restorationCap)
        foo.LoadingBar_progress:setPercent(exhaustion / cfg.restorationCap * 100)
        if exhaustion < self.hangUpCfg.consumptionFatigue then
            foo.Label_percent:setColor(ccc3(219,50,50))
        else
            foo.Label_percent:setColor(ccc3(255,255,255))
        end
    end
    local stars = DispatchDataMgr:getHeroStars(hero[1])
    for i=1,5 do
        local Image_star = TFDirector:getChildByPath(foo.Panel_star, "Image_star"..i)
        Image_star:setVisible(i <= stars)
        Image_star:setPositionX((-58 + (5 - stars) * 9 + i * 18))
    end

    if self.selectedHeros[hero[1]] then
        foo.Image_bg_icon:setTexture("ui/dispatch/ui_0103.png")
    end
    if DispatchDataMgr:checkHeroInDispatching(hero[1]) then
        foo.Image_dispatched:show()
    elseif hero[2] == 1 then
        foo.Image_added:show()
    else
        foo.Image_star_limit:setVisible(stars < 1 and hero[2] ~= 2)
    end

    foo.Image_choosed:setVisible(false)
    if self.selectHeroId == hero[1] then
        self.selectImage = foo.Image_choosed
        foo.Image_choosed:setVisible(true)
    end
end

function DispatchAddHeroLayer:onAddDispatchBack()
    local heros = DispatchDataMgr:getDispathedHeros(self.dungeonType)
    self.addedHeros = {0,0,0}
    self.selectedHeros = {}
    for i,v in ipairs(heros) do
        self.addedHeros[i] = v
        self.selectedHeros[v] = 1
    end
    for i, v in ipairs(self.addedHeros) do
        if v == self.selectHeroId then
            self.selectAddedHeroId = self.selectHeroId
            break
        end
    end
    self:sortHeroIds()
    self:refreshHeroItems()
    self:refreshLeftUI()
    self:updateRightUI()
    self:updateDispatchBtn(true)
end

function DispatchAddHeroLayer:registerEvents()
    EventMgr:addEventListener(self,EV_FUBEN_ADD_DISPATCH_HEROS,handler(self.onAddDispatchBack, self))

    self.Button_dispatch:onClick(function()
        local heros = {}
        if self.selectedHeros[self.selectHeroId] then
            for k, v in pairs(self.selectedHeros) do
                local heroId = tonumber(k)
                if heroId ~= self.selectHeroId then
                    table.insert(heros, heroId)
                end
            end
        else
            if table.count(self.selectedHeros) >= 3 then
                Utils:showTips(213184)
                return
            else
                for k, v in pairs(self.selectedHeros) do
                    local heroId = tonumber(k)
                    if heroId > 0 then
                        table.insert(heros, heroId)
                    end
                end
                table.insert(heros, self.selectHeroId)
            end
        end
        DispatchDataMgr:ReqResetDispatchHero(self.dungeonType, heros)
    end)
end

return DispatchAddHeroLayer