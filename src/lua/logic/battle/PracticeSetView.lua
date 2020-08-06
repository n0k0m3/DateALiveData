
local PracticeSetView = class("PracticeSetView", BaseLayer)
local BrushMonster = import(".BrushMonster")

function PracticeSetView:initData(selectIndex)
    self.practiceData_ = BattleDataMgr:getPracticeData()
    self.showHeroId = self.practiceData_.formation_[1].limitCid
    self.skinId = self.practiceData_.skinId or self.practiceData_.formation_[1].skinCid
    self.levelCfg_ = BattleDataMgr:getLevelCfg()
    self.minLevel_ = 1
    self.maxLevel_ = 99
    self.minNumber_ = 1
    self.maxNumber_ = 5
    self.tabItem_ = {}
    self.monster_ = {}
    self.skinItemsList_ = {}
    self.specicalMonster_ = {}
    self.defaultSelectIndex_ = selectIndex or 1

    self.tabData_ = {
        [1] = {
            name = 2107028,
            en = 2107030,
        },
        [2] = {
            name = 2107029,
            en = 2107031,
        },
        [3] = {
            name = 2107501,
            en = 2107502,
        },
    }

    for i, v in ipairs(self.levelCfg_.monsterGroupId) do
        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", v)
        local monsterCfg = TabDataMgr:getData("Monster", monsterSectionCfg.fixedMonster[1])
        table.insert(self.monster_, {type_ = monsterCfg.type, id = monsterSectionCfg.fixedMonster})
    end
    for i, v in ipairs(self.levelCfg_.heroForbiddenID) do
        local monsterSectionCfg = TabDataMgr:getData("MonsterSection", v)
        local monsterCfg = TabDataMgr:getData("Monster", monsterSectionCfg.fixedMonster[1])
        table.insert(self.specicalMonster_, {type_ = monsterCfg.type, id = monsterSectionCfg.fixedMonster[1]})
    end
end

function PracticeSetView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.battle.practiceSetView")
end

function PracticeSetView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_diffItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_diffItem")
    self.Panel_levelItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_levelItem")
    self.Panel_numberItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_numberItem")
    self.Panel_hpItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_hpItem")
    self.Panel_superItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_superItem")
    self.Panel_categoryItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_categoryItem")
    self.Panel_specialItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_specialItem")
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Label_titleEn = TFDirector:getChildByPath(Image_content, "Label_titleEn")
    self.Button_save = TFDirector:getChildByPath(Image_content, "Button_save")
    self.Label_save = TFDirector:getChildByPath(self.Button_save, "Label_save")
    self.Button_reset = TFDirector:getChildByPath(Image_content, "Button_reset")
    self.Label_reset = TFDirector:getChildByPath(self.Button_reset, "Label_reset")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    local ScrollView_normal = TFDirector:getChildByPath(Image_content, "ScrollView_normal")
    self.ListView_normal = UIListView:create(ScrollView_normal)
    self.ListView_normal:setItemsMargin(5)
    local ScrollView_special = TFDirector:getChildByPath(Image_content, "ScrollView_special")
    self.ListView_special = UIListView:create(ScrollView_special)
    self.ListView_special:setItemsMargin(5)
    local ScrollView_skin = TFDirector:getChildByPath(Image_content, "ScrollView_skin"):hide()
    self.Panel_skin_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_skin_model")
    self.ListView_skin = UITurnView:create(ScrollView_skin)
    self.ListView_skin:setItemModel(self.Panel_skin_item)

    self.Button_skin = TFDirector:getChildByPath(Image_content, "Button_skin")


    local ScrollView_tab = TFDirector:getChildByPath(Image_content, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)

    self:refreshView()
end

function PracticeSetView:updateAllState()
    self:updateDiffState()
    self:updateLevelState()
    self:updateNumberState()
    self:updateHpState()
    self:updateSuperState()
    self:updateCategoryState()
    self:updateSpecialHpState()
    self:updateSpecialCategoryState()
    self:updateSpecialLevelState()
end

function PracticeSetView:initNormalMonster()
    self.Panel_diff = self.Panel_diffItem:clone()
    local Label_selectDiff = TFDirector:getChildByPath(self.Panel_diff, "Label_selectDiff")
    Label_selectDiff:setTextById(2107008)
    self.Panel_select_diff = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_diff, "Panel_select_diff_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        self.Panel_select_diff[i] = item
    end
    for i, v in ipairs(self.Panel_select_diff) do
        local monster = self.monster_[i]
        v.root:setVisible(tobool(monster))
        if monster then
            v.Label_name:setTextById(EC_MonsterTypeName[monster.type_])
        end
    end
    self.ListView_normal:pushBackCustomItem(self.Panel_diff)

    self.Panel_category = self.Panel_categoryItem:clone()
    local Label_category_title = TFDirector:getChildByPath(self.Panel_category, "Label_category_title")
    Label_category_title:setTextById(2107027)
    self.Panel_select_category = {}
    for i = 1, 4 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_category, "Panel_select_category_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        self.Panel_select_category[i] = item
    end
    self.ListView_normal:pushBackCustomItem(self.Panel_category)

    self.Panel_level = self.Panel_levelItem:clone()
    local Label_selectLevel = TFDirector:getChildByPath(self.Panel_level, "Label_selectLevel")
    Label_selectLevel:setTextById(2107023)

    local optionStr = {2107015, 2107016}
    self.Panel_select_level = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_level, "Panel_select_level_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Label_name:setTextById(optionStr[i])
        self.Panel_select_level[i] = item
    end
    self.Label_slider_level = TFDirector:getChildByPath(self.Panel_level, "Label_slider_level")
    self.Slider_level = TFDirector:getChildByPath(self.Panel_level, "Slider_level")
    self.ListView_normal:pushBackCustomItem(self.Panel_level)

    self.Panel_number = self.Panel_numberItem:clone()
    local Label_selectNumber = TFDirector:getChildByPath(self.Panel_number, "Label_selectNumber")
    Label_selectNumber:setTextById(2107009)
    self.Label_number = TFDirector:getChildByPath(self.Panel_number, "Label_number")
    self.Slider_number = TFDirector:getChildByPath(self.Panel_number, "Slider_number")
    self.ListView_normal:pushBackCustomItem(self.Panel_number)

    self.Panel_hp = self.Panel_hpItem:clone()
    local Label_selectHp = TFDirector:getChildByPath(self.Panel_hp, "Label_selectHp")
    Label_selectHp:setTextById(2107010)
    self.Panel_select_hp = {}
    local optionStr = {2107017, 2107018}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_hp, "Panel_select_hp_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Label_name:setTextById(optionStr[i])
        self.Panel_select_hp[i] = item
    end
    self.ListView_normal:pushBackCustomItem(self.Panel_hp)

    self.Panel_super = self.Panel_superItem:clone()
    local Label_selectSuper = TFDirector:getChildByPath(self.Panel_super, "Label_selectSuper")
    self.Panel_select_super = {}
    local optionStr = {2107019, 2107020}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_super, "Panel_select_super_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Label_name:setTextById(optionStr[i])
        self.Panel_select_super[i] = item
    end
    self.ListView_normal:pushBackCustomItem(self.Panel_super)
end

function PracticeSetView:initSpecialMonster()
    local Panel_special = self.Panel_specialItem:clone()
    local Label_special_title = TFDirector:getChildByPath(Panel_special, "Label_special_title")
    Label_special_title:setTextById(2107032)
    self.Panel_select_special_category = {}
    for i = 1, 4 do
        local item = {}
        item.root = TFDirector:getChildByPath(Panel_special, "Panel_select_special_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        local Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        local Image_icon = TFDirector:getChildByPath(item.root, "ClippingNode_icon.Image_icon")
        self.Panel_select_special_category[i] = item
        local monsterData = self.specicalMonster_[i]
        item.root:setVisible(tobool(monsterData))
        if item.root:isVisible() then
            local monsterCfg = TabDataMgr:getData("Monster", monsterData.id)
            Label_name:setTextById(monsterCfg.name)
            Image_icon:setTexture(monsterCfg.fightIcon)
        end
    end
    self.ListView_special:pushBackCustomItem(Panel_special)

    self.Panel_special_level = self.Panel_levelItem:clone()
    local Label_selectLevel = TFDirector:getChildByPath(self.Panel_special_level, "Label_selectLevel")
    Label_selectLevel:setTextById(2107023)
    local optionStr = {2107015, 2107016}
    self.Panel_select_special_level = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_special_level, "Panel_select_level_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Label_name:setTextById(optionStr[i])
        self.Panel_select_special_level[i] = item
    end
    self.Label_special_slider_level = TFDirector:getChildByPath(self.Panel_special_level, "Label_slider_level")
    self.Slider_special_level = TFDirector:getChildByPath(self.Panel_special_level, "Slider_level")
    self.ListView_special:pushBackCustomItem(self.Panel_special_level)

    self.Panel_hp = self.Panel_hpItem:clone()
    local Label_selectHp = TFDirector:getChildByPath(self.Panel_hp, "Label_selectHp")
    Label_selectHp:setTextById(2107010)
    self.Panel_select_special_hp = {}
    local optionStr = {2107017, 2107018}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_hp, "Panel_select_hp_" .. i)
        item.Button_select = TFDirector:getChildByPath(item.root, "Button_select")
        item.Button_unselect = TFDirector:getChildByPath(item.root, "Button_unselect")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Label_name:setTextById(optionStr[i])
        self.Panel_select_special_hp[i] = item
    end
    self.ListView_special:pushBackCustomItem(self.Panel_hp)
end

function PracticeSetView:initSkin()
    local _cfgs = TabDataMgr:getData("TrialHeroSkin")

    local ret = {}
    for k,v in pairs(_cfgs) do
        if v.fitting and v.matchHero == self.showHeroId then
            table.insert(ret,v)
        end
    end

    local sortFunc = function(a,b)
        local ause = 0;
        local buse = 0;
        local aunlock = 0;
        local bunlock = 0;
        if a.id == self.skinId or a.matchSkin == self.skinId then
            ause = 1;
        end

        if b.id == self.skinId or b.matchSkin == self.skinId then
            buse = 1;
        end

        if ause == buse then
            return a.id  < b.id
        else
            return ause > buse
        end
    end

    table.sort(ret,sortFunc)


    for i = 1,#ret do
        if not self.skinItemsList_[i] then
            self:addSkinItem(i, ret[i])
        end
        self:updateSkinItem(i)
    end
end

function PracticeSetView:addSkinItem(idx, skinData) 
    local item = self.ListView_skin:pushBackItem()
    local foo = {}
    foo.root = item
    item:setVisible(true)
    foo.image = TFDirector:getChildByPath(foo.root,"Image_skin")
    foo.skinData = skinData
    foo.imageLock = TFDirector:getChildByPath(foo.root,"Image_lock")
    foo.Label_skin_name = TFDirector:getChildByName(foo.root,"Label_skin")
    foo.Panel_Touch = TFDirector:getChildByName(foo.root,"Panel_Touch")
    foo.Button_skinDetail = TFDirector:getChildByName(foo.root,"Button_skinDetail")
    foo.Image_using = TFDirector:getChildByPath(foo.root, "Image_using")
    self.skinItemsList_[idx] = foo
    
    return foo.root
end

function PracticeSetView:updateSkinItem(idx)
    local foo = self.skinItemsList_[idx]
    local skinData = foo.skinData
    local item = foo.root
    item:setVisible(true)
    item:setTouchEnabled(true)
    local isUsing = tobool(self.skinId == foo.skinData.id or self.skinId == foo.skinData.matchSkin)
    foo.Image_using:setVisible(isUsing)
    foo.imageLock:setVisible(false)
    foo.Label_skin_name:setTextById(skinData.nameTextId)
    foo.image:setTexture(skinData.skinImg)
    foo.Panel_Touch:onClick(function()
       self.ListView_skin:scrollToItem(idx)
    end)
    foo.Button_skinDetail:onClick(function()
        --if self.showSkinID then
        --    self.notHide = true
        dump(foo.skinData.id)
            Utils:showInfo(foo.skinData.id)
        --end
    end)
end



function PracticeSetView:initTab()
    for i, v in ipairs(self.tabData_) do
        local Panel_tabItem = self.Panel_tabItem:clone()
        local foo = {}
        foo.root = Panel_tabItem
        foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
        local Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        local Label_name_en = TFDirector:getChildByPath(foo.root, "Label_name_en")
        Label_name:setTextById(v.name)
        Label_name_en:setTextById(v.en)
        foo.root:onClick(function()
                self:selectTab(i)
        end)
        self.tabItem_[foo.root] = foo
        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function PracticeSetView:refreshView()
    self.Label_title:setTextById(2107007)
    self.Label_save:setTextById(2107022)
    self.Label_reset:setTextById(2107021)
    self:initTab()
    self:initNormalMonster()
    self:initSpecialMonster()
    self:initSkin()
    self:updateAllState()

    self:selectTab(self.defaultSelectIndex_)
end

function PracticeSetView:updateDiffState()
    for i, v in ipairs(self.Panel_select_diff) do
        local isSelect = self.practiceData_.diffIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end

    self:updateCategoryState()
end

function PracticeSetView:updateLevelState()
    for i, v in ipairs(self.Panel_select_level) do
        local isSelect = self.practiceData_.levelIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end

    local percent = math.floor(self.practiceData_.level / self.maxLevel_ * 100)
    self.Slider_level:setPercent(percent)
    self.Label_slider_level:setTextById(800006, self.practiceData_.level)
end

function PracticeSetView:updateNumberState()
    local percent = (self.practiceData_.number - 1) * (100 / (self.maxNumber_ - 1))
    self.Slider_number:setPercent(percent)
    self.Label_number:setText(self.practiceData_.number)
end

function PracticeSetView:updateHpState()
    for i, v in ipairs(self.Panel_select_hp) do
        local isSelect = self.practiceData_.hpIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end
end

function PracticeSetView:updateSuperState()
    for i, v in ipairs(self.Panel_select_super) do
        local isSelect = self.practiceData_.superIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end
end

function PracticeSetView:updateCategoryState()
    local monster = self.monster_[self.practiceData_.diffIndex]
    for i, v in ipairs(self.Panel_select_category) do
        local monsterCid = monster.id[i]
        v.root:setVisible(tobool(monsterCid))
        if v.root:isVisible() then
            local monsterCfg = TabDataMgr:getData("Monster", monsterCid)
            v.Label_name:setTextById(EC_MonsterSubTypeName[monsterCfg.subType])
        end
    end

    self.practiceData_.categoryIndex = math.min(#monster.id, self.practiceData_.categoryIndex)
    for i, v in ipairs(self.Panel_select_category) do
        local isSelect = self.practiceData_.categoryIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end
end

function PracticeSetView:updateSpecialHpState()
    for i, v in ipairs(self.Panel_select_special_hp) do
        local isSelect = self.practiceData_.specialHpIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end
end

function PracticeSetView:updateSpecialCategoryState()
    for i, v in ipairs(self.Panel_select_special_category) do
        local isSelect = self.practiceData_.specialCategoryIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end
end

function PracticeSetView:updateSpecialLevelState()
    for i, v in ipairs(self.Panel_select_special_level) do
        local isSelect = self.practiceData_.specialLevelIndex == i
        v.Button_select:setVisible(isSelect)
        v.Button_unselect:setVisible(not isSelect)
    end

    local percent = math.floor(self.practiceData_.specialLevel / self.maxLevel_ * 100)
    self.Slider_special_level:setPercent(percent)
    self.Label_special_slider_level:setTextById(800006, self.practiceData_.specialLevel)
end

function PracticeSetView:selectTab(index)
    if index ~= 3 then 
        self.selectIndex_ = index
    end
    self.ListView_normal:setVisible(index == 1)
    self.ListView_special:setVisible(index == 2)
    self.ListView_skin.scrollView_:setVisible(index == 3)
    self.Button_skin:setVisible(index == 3)
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local foo = self.tabItem_[v]
        foo.Image_select:setVisible(i == index)
    end
end

function PracticeSetView:registerEvents()
    self.panelTouchFunc = function()
            AlertManager:closeLayer(self)
    end
    self.Button_close:onClick(self.panelTouchFunc)
    
    self.Button_skin:onClick(function (  )
         local foo = self.skinItemsList_[self.ListView_skin:getSelectIndex()]
        if foo then
            self.practiceData_.skinId = foo.skinData.id
            BattleDataMgr:cachePracticeData(self.practiceData_)
            self:initSkin() 
            --TODO 最好是在skinId 不同的时候再发事件
            EventMgr:dispatchEvent(EV_PRACTICE_SET_SKIN, self.practiceData_.skinId)
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_save:onClick(function()

            local foo = self.skinItemsList_[self.ListView_skin:getSelectIndex()]
            if foo then
                self.practiceData_.skinId = foo.skinData.id
                self:initSkin() 
                --TODO 最好是在skinId 不同的时候再发事件
                EventMgr:dispatchEvent(EV_PRACTICE_SET_SKIN, self.practiceData_.skinId)
            end

            BattleDataMgr:cachePracticeData(self.practiceData_)
            BrushMonster:initPracticeSite()
            EventMgr:dispatchEvent(EV_PRACTICE_BRUSH_MONSTER, self.selectIndex_)
            AlertManager:closeLayer(self)
    end)

    self.Button_reset:onClick(function()
            self.practiceData_.diffIndex = 1
            self.practiceData_.levelIndex = 1
            self.practiceData_.level = 1
            self.practiceData_.number = 1
            self.practiceData_.hpIndex = 1
            self.practiceData_.superIndex = 1
            self.practiceData_.categoryIndex = 1
            self.practiceData_.specialHpIndex = 1
            self.practiceData_.specialCategoryIndex = 1
            self:updateAllState()
    end)

    for i, v in ipairs(self.Panel_select_diff) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.diffIndex = i
                self:updateDiffState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.diffIndex = i
                self:updateDiffState()
        end)
    end

    for i, v in ipairs(self.Panel_select_level) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.levelIndex = i
                self:updateLevelState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.levelIndex = i
                self:updateLevelState()
        end)
    end

    for i, v in ipairs(self.Panel_select_hp) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.hpIndex = i
                self:updateHpState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.hpIndex = i
                self:updateHpState()
        end)
    end

    for i, v in ipairs(self.Panel_select_super) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.superIndex = i
                self:updateSuperState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.superIndex = i
                self:updateSuperState()
        end)
    end

    for i, v in ipairs(self.Panel_select_category) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.categoryIndex = i
                self:updateCategoryState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.categoryIndex = i
                self:updateCategoryState()
        end)
    end

    for i, v in ipairs(self.Panel_select_special_category) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.specialCategoryIndex = i
                self:updateSpecialCategoryState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.specialCategoryIndex = i
                self:updateSpecialCategoryState()
        end)
    end

    for i, v in ipairs(self.Panel_select_special_hp) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.specialHpIndex = i
                self:updateSpecialHpState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.specialHpIndex = i
                self:updateSpecialHpState()
        end)
    end

    for i, v in ipairs(self.Panel_select_special_level) do
        v.Button_unselect:onClick(function()
                v.Button_select:show()
                v.Button_unselect:hide()
                self.practiceData_.specialLevelIndex = i
                self:updateSpecialLevelState()
        end)
        v.Button_select:onClick(function()
                v.Button_select:hide()
                v.Button_unselect:show()
                self.practiceData_.specialLevelIndex = i
                self:updateSpecialLevelState()
        end)
    end

    self.Slider_level:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.Slider_level:getPercent()
            local level = math.floor(self.maxLevel_ * percent / 100)
            self.practiceData_.level = clamp(level, self.minLevel_, self.maxLevel_)
            self.Label_slider_level:setTextById(800006, self.practiceData_.level)
        end
    )

    self.Slider_special_level:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.Slider_special_level:getPercent()
            local level = math.floor(self.maxLevel_ * percent / 100)
            self.practiceData_.specialLevel = clamp(level, self.minLevel_, self.maxLevel_)
            self.Label_special_slider_level:setTextById(800006, self.practiceData_.specialLevel)
        end
    )

    self.Slider_number:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.Slider_number:getPercent()
            local number = percent / (100 / (self.maxNumber_ - 1))
            self.practiceData_.number = math.floor(number) + 1
            self.Label_number:setText(self.practiceData_.number)
        end
    )
    local function scrollCallback(target, offsetRate, customOffsetRate)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            local rCustomRate = 1 - customRate
            item:setOpacity(255 * rrate)
            item:setPositionZ(-customRate * 100)
            item:setZOrder(rrate * 100)
        end
    end

    self.ListView_skin:registerScrollCallback(scrollCallback)
    self.ListView_skin:registerSelectCallback(handler(self.onSelectItems, self))
end

function PracticeSetView:onSelectItems(target, selectIndex)
   
end

function PracticeSetView:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

return PracticeSetView
