local BaoshiChooselView = class("BaoshiChooselView", BaseLayer)

function BaoshiChooselView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self:initData()
    self:init("lua.uiconfig.fairyNew.baoshiChooselView")
end

function BaoshiChooselView:initData()
    self.heroId = self.paramData_.heroId
    self.selectPos = nil
    self.raritySort_ = {}
end

function BaoshiChooselView:getClosingStateParams()
    return {self.paramData_}
end

function BaoshiChooselView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_pos        = TFDirector:getChildByPath(ui,"Panel_pos")
    self.Panel_detail        = TFDirector:getChildByPath(ui,"Panel_detail")
    self.Panel_di        = TFDirector:getChildByPath(ui,"Panel_di")
    self.Panel_baoshi_item        = TFDirector:getChildByPath(ui,"Panel_baoshi_item")

    self.Image_angel_icon = TFDirector:getChildByPath(self.Panel_left,"Image_angel_icon")
    self.gem_pos = {}
    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_left,"Panel_pos_"..i)
        foo.Image_add   = TFDirector:getChildByPath(foo.root,"Image_add")
        foo.Image_select = TFDirector:getChildByPath(foo.root,"Image_select")
        foo.Image_bg  = TFDirector:getChildByPath(foo.root,"Image_bg")
        foo.Image_quality_bg    = TFDirector:getChildByPath(foo.root,"Image_quality_bg")
        foo.Image_quality  = TFDirector:getChildByPath(foo.root,"Image_quality")
        foo.Image_icon    = TFDirector:getChildByPath(foo.root,"Image_icon")
        self.gem_pos[i] = foo
    end

    local ScrollView_items = TFDirector:getChildByPath(self.Panel_detail,"ScrollView_items")
    self.listView_items = UIListView:create(ScrollView_items)
    self.Label_no_gems = TFDirector:getChildByPath(self.Panel_detail,"Label_no_gems"):hide()
    self.Label_no_gems:setTextById(1100041)

    self.Button_change    = TFDirector:getChildByPath(self.Panel_di,"Button_change")
    self.Button_drop    = TFDirector:getChildByPath(self.Panel_di,"Button_drop")
    self.Button_sort    = TFDirector:getChildByPath(self.Panel_di,"Button_sort")
    self.Button_dress = TFDirector:getChildByPath(self.Panel_di,"Button_dress")
    self:selectGemPos(self.paramData_.pos or 1)
end

function BaoshiChooselView:selectGemPos(pos)
    if self.selectPos == pos then
        return
    end
    self.selectPos = pos
    self:refreshUI()
end

function BaoshiChooselView:refreshUI()
    self:refreshGemPos()
    self:refreshBaoshiItems()
    self:updateButtonState()
end

function BaoshiChooselView:refreshGemPos()
    for i,v in ipairs(self.gem_pos) do
        self:updateGemPosItem(v, i)
    end
end

function BaoshiChooselView:updateGemPosItem(foo, pos)
    local data = HeroDataMgr:getGemInfoByPos(self.heroId, pos)
    if data then
        local cfg = EquipmentDataMgr:getGemCfg(data.cid)
        foo.Image_bg:setVisible(true)
        foo.Image_quality_bg:setVisible(true)
        foo.Image_quality:setVisible(true)
        foo.Image_icon:setVisible(true)
        foo.Image_icon:setTexture(cfg.icon)
        foo.Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
        foo.Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
        foo.Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    else
        foo.Image_bg:setVisible(false)
        foo.Image_quality_bg:setVisible(false)
        foo.Image_quality:setVisible(false)
        foo.Image_icon:setVisible(false)
    end
    foo.Image_add:setTexture("ui/fairy/new_ui/baoshi/018.png")
    foo.Image_select:setVisible(self.selectPos == pos)
end

function BaoshiChooselView:refreshBaoshiItems()
    self.loadIndex = 1
    self.lastImageSelect = nil
    self.gemsInfos = EquipmentDataMgr:getGemInfosByHeroIdAndPos(self.heroId, self.selectPos, self.raritySort_)

    self.Label_no_gems:setVisible(#self.gemsInfos < 1)
    local items = self.listView_items:getItems()
    local gap = #items - #self.gemsInfos
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.listView_items:removeItem(1)
        end
    end
    
    local function loadGemItem()
        if self.loadIndex > #self.gemsInfos then
            return
        end
        local item = self.listView_items:getItem(self.loadIndex)
        if not item then
            item = self.Panel_baoshi_item:clone()
            self.listView_items:pushBackCustomItem(item)
        end
        self:updateBaoshiItem(self.loadIndex, item, self.gemsInfos[self.loadIndex])
        if self.loadIndex == 1 then
            self:selectBaoshiItem(self.loadIndex, item)
        end
        local seq = Sequence:create({
                DelayTime:create(0.05),
                CallFunc:create(function()
                        self.loadIndex = self.loadIndex + 1
                        loadGemItem()
                end)
        })
        self.Panel_detail:stopAllActions()
        self.Panel_detail:runAction(seq)
    end
    loadGemItem()
end

function BaoshiChooselView:updateBaoshiItem(idx, item, data)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    local Image_icon_bg = TFDirector:getChildByPath(item,"Image_icon_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
    local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
    local Image_carry = TFDirector:getChildByPath(item,"Image_carry"):hide()

    local cfg = EquipmentDataMgr:getGemCfg(data.cid)
    Image_carry:setVisible(data.heroId == self.heroId and cfg.skillType == self.selectPos)
    Image_icon_bg:setTexture(EC_ItemIcon[cfg.quality])
    Image_icon:setTexture(cfg.icon)
    Label_name:setTextById(tonumber(cfg.nameTextId))
    Label_name:setColor(EquipmentDataMgr:getGemNameColor(cfg.quality))
    local skillCfg = TabDataMgr:getData("PassiveSkills",cfg.baseSkill)
    local skillDesc = TextDataMgr:getTextAttr(tonumber(skillCfg.des)).text
    skillDesc = string.gsub(skillDesc, "#", TextDataMgr:getText(cfg.skillName))
    Label_desc:setText(skillDesc)
    Image_bg:setTexture(EquipmentDataMgr:getGemItemBg(cfg.quality))
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    for i=1,4 do
        local Image_pos = TFDirector:getChildByPath(item,"Image_pos"..i)
        Image_pos:setTexture(cfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
    end
    for i=1,3 do
        local Image_skill = TFDirector:getChildByPath(item,"Image_skill"..i)
        local skillId = data.randSkill and data.randSkill[i]
        if skillId then
            Image_skill:setVisible(true)
            local skillCfg = TabDataMgr:getData("PassiveSkills",skillId)
            local Image_skill_icon = TFDirector:getChildByPath(Image_skill,"Image_skill_icon")
            local Label_skill_name = TFDirector:getChildByPath(Image_skill,"Label_skill_name")
            Label_skill_name:setTextById(tonumber(skillCfg.name))
            Image_skill_icon:setTexture(skillCfg.icon)
            Image_skill_icon:setScale(0.55)
            Image_skill:setTouchEnabled(true)
            Image_skill:onClick(function()
                Utils:openView("fairyNew.BaoshiSkillTipsView", data.cid, skillId)
            end)
        else
            Image_skill:setVisible(false)
        end
    end
    item:setTouchEnabled(true)
    item:onClick(function()
        self:selectBaoshiItem(idx, item)
    end)
end

function BaoshiChooselView:selectBaoshiItem(idx, item)
    self.selectItemIdx = idx
    if self.lastImageSelect then
        self.lastImageSelect:setVisible(false)
    end
    local Image_select = TFDirector:getChildByPath(item,"Image_select")
    Image_select:setVisible(true)
    self.lastImageSelect = Image_select
    self:updateButtonState()
end

function BaoshiChooselView:updateButtonState()
    local gemInfo = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos)
    local selectInfo = self.gemsInfos[self.selectItemIdx]
    self.Button_change:setVisible(false)
    self.Button_drop:setVisible(false)
    self.Button_dress:setVisible(false)
    if selectInfo then
        if gemInfo and selectInfo.id == gemInfo.id then
            self.Button_drop:setVisible(true)
        elseif not gemInfo then
            self.Button_dress:setVisible(true)
        elseif gemInfo.id ~= selectInfo.id then
            self.Button_change:setVisible(true)
        end
    end
end

function BaoshiChooselView:onRaritySetBack(raritys)
    self.raritySort_ = raritys
    self:refreshUI()
end

function BaoshiChooselView:playDressGemEffect()
    for i,v in ipairs(self.gem_pos) do
        if i == self.selectPos then
            local spineEffect = SkeletonAnimation:create("effect/ui_stone_bg/ui_stone_bg")
            spineEffect:setAnimationFps(60) 
            v.root:addChild(spineEffect,10)
            spineEffect:play("baoshiliuguang",true)
            spineEffect:addMEListener(TFARMATURE_COMPLETE,function()
                spineEffect:removeMEListener(TFARMATURE_COMPLETE)
                spineEffect:removeFromParent()
            end) 
        end
    end
end
function BaoshiChooselView:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_GEM_DRESS_OR_DROP,handler(self.refreshUI, self))
    EventMgr:addEventListener(self,EQUIPMENT_GEM_QUALITY_SORT,handler(self.onRaritySetBack, self))

    for i,v in ipairs(self.gem_pos) do
        v.root:setTouchEnabled(true)
        v.root:onClick(function()
            self:selectGemPos(i)
        end)
    end

    self.Button_change:onClick(function()
        local selectInfo = self.gemsInfos[self.selectItemIdx]
        EquipmentDataMgr:reqEquipGemOrDrop(1, self.heroId, selectInfo.id, self.selectPos)
        self:playDressGemEffect()
        Utils:playSound(802, false)
    end)

    self.Button_dress:onClick(function()
        local selectInfo = self.gemsInfos[self.selectItemIdx]
        EquipmentDataMgr:reqEquipGemOrDrop(1, self.heroId, selectInfo.id, self.selectPos)
        self:playDressGemEffect()
        Utils:playSound(802, false)
    end)
 
    self.Button_drop:onClick(function()
        local selectInfo = self.gemsInfos[self.selectItemIdx]
        EquipmentDataMgr:reqEquipGemOrDrop(2, self.heroId, selectInfo.id, self.selectPos)
    end)

    self.Button_sort:onClick(function()
        Utils:openView("fairyNew.BaoshiRaritySortChooseView", self.raritySort_)
    end)
end

return BaoshiChooselView