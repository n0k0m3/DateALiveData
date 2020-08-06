
local SummonPreviewView = class("SummonPreviewView", BaseLayer)

function SummonPreviewView:initData(groupId,titleId)
    print("groupId================",groupId)
    self.titleId = titleId
    self.summonPreview_ = SummonDataMgr:getSummonPreview(groupId)
    dump(self.summonPreview_)
end

function SummonPreviewView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonPreviewView")
end

function SummonPreviewView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_categoryItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_categoryItem")
    self.Panel_heroItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_heroItem")
    self.Panel_equipmentItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_equipmentItem")
    self.Panel_attrWhiteItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attrWhiteItem")
    self.Panel_attrGrayItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attrGrayItem")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")

    self.Panel_ad = TFDirector:getChildByPath(Image_content, "Panel_ad")
    self.Image_ad = TFDirector:getChildByPath(self.Panel_ad, "Image_ad")

    self.Panel_hero = TFDirector:getChildByPath(Image_content, "Panel_hero")
    self.Label_heroTip = TFDirector:getChildByPath(self.Panel_hero, "Label_heroTip")
    local ScrollView_hero = TFDirector:getChildByPath(Image_content, "ScrollView_hero")
    self.GridView_hero = UIGridView:create(ScrollView_hero)
    self.GridView_hero:setColumn(3)
    self.GridView_hero:setColumnMargin(50)
    self.GridView_hero:setRowMargin(20)
    self.GridView_hero:setItemModel(self.Panel_heroItem)

    self.Panel_equipment = TFDirector:getChildByPath(Image_content, "Panel_equipment")
    self.Label_equipmentTip = TFDirector:getChildByPath(self.Panel_equipment, "Label_equipmentTip")
    local ScrollView_equipment = TFDirector:getChildByPath(self.Panel_equipment, "ScrollView_equipment")
    self.ListView_equipment = UIListView:create(ScrollView_equipment)
    self.ListView_equipment:setItemModel(self.Panel_equipmentItem)
    self.ListView_equipment:setItemsMargin(20)

    self.Panel_cp = TFDirector:getChildByPath(Image_content, "Panel_cp")
    local ScrollView_cp = TFDirector:getChildByPath(self.Panel_cp, "ScrollView_cp")
    self.ListView_cp = UIListView:create(ScrollView_cp)

    self.Panel_dp = TFDirector:getChildByPath(Image_content, "Panel_dp")
    local ScrollView_dp = TFDirector:getChildByPath(self.Panel_dp, "ScrollView_dp")
    self.ListView_dp = UIListView:create(ScrollView_dp)

    self.Panel_probability_1 = TFDirector:getChildByPath(Image_content, "Panel_probability_1")
    local ScrollView_probability_1 = TFDirector:getChildByPath(self.Panel_probability_1, "ScrollView_probability_1")
    self.ListView_probability_1 = UIListView:create(ScrollView_probability_1)

    local ScrollView_content = TFDirector:getChildByPath(Image_content, "ScrollView_content")
    self.ListView_content = UIListView:create(ScrollView_content)

    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function SummonPreviewView:refreshView()

    self.titleId = self.titleId or 1200040
    self.Label_title:setTextById(self.titleId)
    for i, v in ipairs(self.summonPreview_) do
        if v.type_ == EC_SummonPreviewType.AD then
            self:updateAd(v.data)
        elseif v.type_ == EC_SummonPreviewType.HERO then
            self:updateHero(v.data)
        elseif v.type_ == EC_SummonPreviewType.EQUIPMENT then
            self:updateEquipment(v.data)
        elseif v.type_ == EC_SummonPreviewType.CP then
            self:updateCp(v.data)
        elseif v.type_ == EC_SummonPreviewType.DP then
            self:updateDp(v.data)
        elseif v.type_ == EC_SummonPreviewType.PROBABILITY1 then
            self:updateProbability1(v.data)
        end
    end
end

function SummonPreviewView:addTitle(titleId)
    local Panel_categoryItem = self.Panel_categoryItem:clone()
    local Label_category = TFDirector:getChildByPath(Panel_categoryItem, "Label_category")
    Label_category:setTextById(titleId)
    self.ListView_content:pushBackCustomItem(Panel_categoryItem)
end

function SummonPreviewView:updateAd(data)
    local cfg = SummonDataMgr:getSummonPreviewCfg(data)
    self.Image_ad:setTexture(cfg.adIcon)

    self.Panel_ad:retain()
    self.Panel_ad:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_ad)
    self.Panel_ad:release()
end

function SummonPreviewView:updateHero(data)
    local cfg = SummonDataMgr:getSummonPreviewCfg(data)
    self:addTitle(cfg.typeName)
    self.Label_heroTip:setTextById(1200049)

    local rawSize = self.GridView_hero:s():getInnerContainerSize()
    for i, v in ipairs(cfg.items) do
        local heroCfg = TabDataMgr:getData("Hero", v)
        local item = self.GridView_hero:pushBackDefaultItem()
        local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
        local Image_quality = TFDirector:getChildByPath(item, "Image_quality")
        local Label_name = TFDirector:getChildByPath(item, "Label_name")
        -- Image_icon:setTexture(heroCfg.summonIcon)
        Image_quality:setTexture(EC_HeroQualityPic[heroCfg.rarity])
        Label_name:setTextById(heroCfg.name)
    end
    local contentSize = self.GridView_hero:s():getInnerContainerSize()
    self.GridView_hero:s():setContentSize(contentSize)
    local height = contentSize.height - rawSize.height
    local size = self.Panel_hero:Size()
    self.Panel_hero:Size(size.width, size.height + height)

    self.Panel_hero:retain()
    self.Panel_hero:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_hero)
    self.Panel_hero:release()
end

function SummonPreviewView:updateEquipment(data)
    local cfg = SummonDataMgr:getSummonPreviewCfg(data)
    self:addTitle(cfg.typeName)
    self.Label_equipmentTip:setTextById(1200050)

    local rawSize = self.ListView_equipment:s():getInnerContainerSize()
    for i, v in ipairs(cfg.items) do
        local item = self.ListView_equipment:pushBackDefaultItem()
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Pos(0, 0):AddTo(item)
        PrefabDataMgr:setInfo(Panel_goodsItem, v)
    end
    Utils:setAliginCenterByListView(self.ListView_equipment, true)

    local contentSize = self.ListView_equipment:s():getInnerContainerSize()
    self.ListView_equipment:s():setContentSize(contentSize)
    local height = contentSize.height - rawSize.height
    local size = self.Panel_equipment:Size()
    self.Panel_equipment:Size(size.width, size.height + height)

    self.Panel_equipment:retain()
    self.Panel_equipment:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_equipment)
    self.Panel_equipment:release()
end

function SummonPreviewView:updateCp(data)

    local isOpenNoobSummon = SummonDataMgr:isOpenNoob()

    local rawSize = self.ListView_cp:s():getInnerContainerSize()
    for i, v in ipairs(data) do
        local cfg = SummonDataMgr:getSummonPreviewCfg(v)
        if i == 1 then
            self:addTitle(cfg.typeName)
        end
        local modelItem = self.Panel_attrWhiteItem
        if math.fmod(i, 2) == 0 then
            modelItem = self.Panel_attrGrayItem
        end
        local item = modelItem:clone()
        local Label_attrTitle = TFDirector:getChildByPath(item, "Label_attrTitle")
        local Label_attrValue = TFDirector:getChildByPath(item, "Label_attrValue")
        local Image_upTips = TFDirector:getChildByPath(item, "Image_upTips"):hide()
        local Image_arrow = TFDirector:getChildByPath(item, "Image_arrow")
        Image_arrow:setVisible(cfg.up)
        Label_attrTitle:setTextById(cfg.name)

        Label_attrValue:setTextById(800017, cfg.probability/100)
        if isOpenNoobSummon or cfg.showUpTips then
            Label_attrValue:setTextById(800017, cfg.noobProbability/100)
            Image_arrow:setVisible(cfg.noobProbability > cfg.probability)
            Image_upTips:setVisible(cfg.noobProbability > cfg.probability)
        end
        self.ListView_cp:pushBackCustomItem(item)
    end
    local contentSize = self.ListView_cp:s():getInnerContainerSize()
    self.ListView_cp:s():setContentSize(contentSize)
    local height = contentSize.height - rawSize.height
    local size = self.Panel_cp:Size()
    self.Panel_cp:Size(size.width, size.height + height)

    self.Panel_cp:retain()
    self.Panel_cp:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_cp)
    self.Panel_cp:release()
end

function SummonPreviewView:updateDp(data)

    local isOpenNoobSummon = SummonDataMgr:isOpenNoob()
    local rawSize = self.ListView_dp:s():getInnerContainerSize()
    for i, v in ipairs(data) do
        local cfg = SummonDataMgr:getSummonPreviewCfg(v)
        if i == 1 then
            self:addTitle(cfg.typeName)
        end
        local modelItem = self.Panel_attrWhiteItem
        if math.fmod(i, 2) == 0 then
            modelItem = self.Panel_attrGrayItem
        end
        local item = modelItem:clone()
        local Label_attrTitle = TFDirector:getChildByPath(item, "Label_attrTitle")
        local Label_attrValue = TFDirector:getChildByPath(item, "Label_attrValue")
        local Image_upTips = TFDirector:getChildByPath(item, "Image_upTips"):hide()
        local Image_arrow = TFDirector:getChildByPath(item, "Image_arrow")
        Image_arrow:setVisible(cfg.up)
        Label_attrTitle:setTextById(cfg.name)
        Label_attrValue:setTextById(800017, cfg.probability/100)
        if isOpenNoobSummon then
            Label_attrValue:setTextById(800017, cfg.noobProbability/100)
            Image_arrow:setVisible(cfg.noobProbability > cfg.probability)
            Image_upTips:setVisible(cfg.noobProbability > cfg.probability)
        end
        self.ListView_dp:pushBackCustomItem(item)
    end
    local contentSize = self.ListView_dp:s():getInnerContainerSize()
    self.ListView_dp:s():setContentSize(contentSize)
    local height = contentSize.height - rawSize.height
    local size = self.Panel_dp:Size()
    self.Panel_dp:Size(size.width, size.height + height)

    self.Panel_dp:retain()
    self.Panel_dp:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_dp)
    self.Panel_dp:release()
end

function SummonPreviewView:updateProbability1(data)

    local isOpenNoobSummon = SummonDataMgr:isOpenNoob()

    local rawSize = self.ListView_probability_1:s():getInnerContainerSize()
    for i, v in ipairs(data) do
        local cfg = SummonDataMgr:getSummonPreviewCfg(v)
        if i == 1 then
            self:addTitle(cfg.typeName)
        end
        local modelItem = self.Panel_attrWhiteItem
        if math.fmod(i, 2) == 0 then
            modelItem = self.Panel_attrGrayItem
        end
        local item = modelItem:clone()
        local Label_attrTitle = TFDirector:getChildByPath(item, "Label_attrTitle")
        local Label_attrValue = TFDirector:getChildByPath(item, "Label_attrValue")
        local Image_upTips = TFDirector:getChildByPath(item, "Image_upTips"):hide()
        local Image_arrow = TFDirector:getChildByPath(item, "Image_arrow")
        Image_arrow:setVisible(cfg.up)
        Label_attrTitle:setTextById(cfg.name)

        Label_attrValue:setTextById(800017, cfg.probability/100)
        if isOpenNoobSummon or cfg.showUpTips then
            Label_attrValue:setTextById(800017, cfg.noobProbability/100)
            Image_arrow:setVisible(cfg.noobProbability > cfg.probability)
            Image_upTips:setVisible(cfg.noobProbability > cfg.probability)
        end
        self.ListView_probability_1:pushBackCustomItem(item)
    end
    local contentSize = self.ListView_probability_1:s():getInnerContainerSize()
    self.ListView_probability_1:s():setContentSize(contentSize)
    local height = contentSize.height - rawSize.height
    local size = self.Panel_probability_1:Size()
    self.Panel_probability_1:Size(size.width, size.height + height)

    self.Panel_probability_1:retain()
    self.Panel_probability_1:removeFromParent(false)
    self.ListView_content:pushBackCustomItem(self.Panel_probability_1)
    self.Panel_probability_1:release()
end

function SummonPreviewView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

return SummonPreviewView
