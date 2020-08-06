local BaoshiTuzhiSortView = class("BaoshiTuzhiSortView", BaseLayer)

function BaoshiTuzhiSortView:ctor(data)
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.baoshiTuzhiSortView")
end

function BaoshiTuzhiSortView:initData(data)
    self.rarity_ = data.rarity
    self.heroId = data.heroId
    self.isDecompose = data.decompose
    self.isTuZhi = data.isTuZhi
    self.isSortGem = data.sortGem
    if self.isSortGem then
        self.heroInfos = EquipmentDataMgr:getHeroOwnGemInfos(math.max(self.rarity_ - 1, 1))
    else
        self.heroInfos = EquipmentDataMgr:getHeroOwnTuzhiInfos(self.rarity_)
    end
    local info = {num = 0, posNum = {0,0,0,0}}
    for i, v in ipairs(self.heroInfos) do
        info.num = info.num + v.num
    end
    table.insert(self.heroInfos, 1, info)
    self.selectHero = nil
    self.selectPos = nil
    self.hero_items = {}
    self.pos_items = {}
    self.quality_items = {}
end

function BaoshiTuzhiSortView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    local Panel_info = TFDirector:getChildByPath(ui, "Panel_info")
    self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
    self.Label_desc1 = TFDirector:getChildByPath(Panel_info, "Label_desc1")
    self.Label_desc2 = TFDirector:getChildByPath(Panel_info, "Label_desc2")

    if self.isSortGem then
        self.Label_title:setTextById(1100032)
        self.Label_desc1:setTextById(1100033)
        self.Label_desc2:setTextById(1100034)
    elseif self.isDecompose then
        self.Label_title:setTextById(1100032)
        self.Label_desc1:setTextById(1100033)
        self.Label_desc2:setTextById(1100038)
    else
        self.Label_title:setTextById(1100036)
        self.Label_desc1:setTextById(1100037)
        self.Label_desc2:setTextById(1100038)
    end
    
    self.Panel_hero_item = TFDirector:getChildByPath(ui, "Panel_hero_item")
    self.Panel_PosSel = TFDirector:getChildByPath(ui, "Panel_PosSel")
    self.Panel_qualitySel = TFDirector:getChildByPath(ui, "Panel_qualitySel")
    local ScrollView_hero    = TFDirector:getChildByPath(Panel_info,"ScrollView_hero")
    self.ScrollView_hero = UIListView:create(ScrollView_hero)

    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Panel_info, "Panel_pos"..i)
        foo.Image_bg = TFDirector:getChildByPath(foo.root, "Image_bg")
        foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
        table.insert(self.pos_items, foo)
    end


    for i = 1, 6 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Panel_info, "Panel_quality"..i)
        foo.Image_bg = TFDirector:getChildByPath(foo.root, "Image_bg")
        foo.Image_quality = TFDirector:getChildByPath(foo.root, "Image_quality")
        foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
        table.insert(self.quality_items, foo)
    end

    self.Panel_PosSel:setVisible( not self.isDecompose )
    self.Panel_qualitySel:setVisible(self.isDecompose )
    self:refreshQualityItems()

    self:initHeroList()
end

function BaoshiTuzhiSortView:initHeroList()
    self.ScrollView_hero:removeAllItems()
    self.heroSelect = nil
    for i,v in ipairs(self.heroInfos) do
        local foo = {}
        foo.root = self.Panel_hero_item:clone()
        foo.Image_item_bg = TFDirector:getChildByPath(foo.root, "Image_item_bg")
        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        foo.Image_Select = TFDirector:getChildByPath(foo.root, "Image_Select"):hide()
        foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
        foo.Panel_cover = TFDirector:getChildByPath(foo.root, "Panel_cover"):hide()
        self:updateHeroItem(i, foo)
        self.ScrollView_hero:pushBackCustomItem(foo.root)
        table.insert(self.hero_items, foo)
        if self.heroId and v.id and v.id == self.heroId then
            self:onHeroItemClick(i)
        else
            if i == 1 and v.num > 0 then
                self:onHeroItemClick(i)
            end
        end
    end
end

function BaoshiTuzhiSortView:updateHeroItem(idx, foo)
    local info = self.heroInfos[idx]
    local iconPath = (idx == 1 and "ui/fairy/new_ui/baoshi/allpick.png" or HeroDataMgr:getIconPathById(info.id))
    foo.Image_icon:setPosition(idx == 1 and ccp(38,38) or ccp(9,38))
    foo.Image_icon:setTexture(iconPath)
    foo.Label_count:setText(info.num)
    foo.Label_count:setVisible(not self.isDecompose)
    foo.Panel_cover:setVisible(info.num < 1)
end

function BaoshiTuzhiSortView:onHeroItemClick(idx)
    if self.heroIdx == idx then
        -- if self.heroSelect then
        --     self.heroSelect:hide()
        -- end
        -- self.heroIdx = nil
        -- self.selectPos = nil
        -- for i,foo in ipairs(self.pos_items) do
        --     foo.Label_count:setText("0")
        --     foo.Image_bg:setTexture("ui/fairy/new_ui/baoshi/038.png")
        -- end
        return
    end
    local info = self.heroInfos[idx]
    self.heroIdx = idx
    local foo = self.hero_items[idx]
    self.selectHero = info.id
    if self.heroSelect then
        self.heroSelect:hide()
    end
    self.heroSelect = foo.Image_Select
    self.heroSelect:show()
    self:refreshPosItems()
    self:refreshQualityItems()
end

function BaoshiTuzhiSortView:onPosItemClick(idx)
    if not self.heroIdx or not self.selectHero then
        return
    end
    if self.selectPos == idx then
        self.selectPos = nil
        if self.posSelect then
            self.posSelect:setTexture("ui/fairy/new_ui/baoshi/038.png")
        end
        return
    end
    local info = self.heroInfos[self.heroIdx]
    self.selectPos = idx
    local foo = self.pos_items[idx]
    if self.posSelect then
        self.posSelect:setTexture("ui/fairy/new_ui/baoshi/038.png")
    end
    self.posSelect = foo.Image_bg
    self.posSelect:setTexture("ui/fairy/new_ui/baoshi/037.png")
end

function BaoshiTuzhiSortView:refreshPosItems()
    self.selectPos = nil
    local info = self.heroInfos[self.heroIdx]
    for i,foo in ipairs(self.pos_items) do
        foo.Label_count:setText(info.posNum[i])
        foo.Image_bg:setTexture("ui/fairy/new_ui/baoshi/038.png")
    end
end

function BaoshiTuzhiSortView:onQualityItemClick(idx)
    if self.selectPos == idx then
        self.selectPos = nil
        if self.qualitySelect then
            self.qualitySelect:hide()
        end
        return
    end
    local info = self.heroInfos[self.heroIdx]

    local raritys = EquipmentDataMgr:getRarityCanDecomposeGem(self.isTuZhi)
    self.selectPos = idx
    local foo = self.quality_items[idx]
    if self.qualitySelect then
        self.qualitySelect:hide()
    end
    self.qualitySelect = foo.Image_select
    self.qualitySelect:show()
end

function BaoshiTuzhiSortView:refreshQualityItems()
    self.selectPos = nil
    self.qualitySelect = nil
    local info = self.heroInfos[self.heroIdx]
    local raritys = EquipmentDataMgr:getRarityCanDecomposeGem(self.isTuZhi)
    local offsetWidth = 715/#raritys
    local index = 1
    for i,foo in ipairs(self.quality_items) do
        if table.find(raritys,i) ~= -1 then
            foo.Image_select:hide()
            foo.root:setPositionX((index-0.5)*offsetWidth)
            index = index + 1
        else
            foo.root:hide()
        end
    end
end

function BaoshiTuzhiSortView:registerEvents()
    for i,foo in ipairs(self.hero_items) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self:onHeroItemClick(i)
        end)
    end

    for i,foo in ipairs(self.pos_items) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self:onPosItemClick(i)
        end)
    end

    for i,foo in ipairs(self.quality_items) do
        foo.root:setTouchEnabled(true)
        foo.root:onClick(function()
            self:onQualityItemClick(i)
        end)
    end

    self.Button_ok:onClick(function()
        if self.heroIdx then
            EventMgr:dispatchEvent(EQUIPMENT_GEM_TUZHI_SORT, self.selectHero, self.selectPos, self.isDecompose)
            AlertManager:closeLayer(self)
        end
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return BaoshiTuzhiSortView