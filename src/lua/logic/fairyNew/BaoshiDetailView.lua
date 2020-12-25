local BaoshiDetailView = class("BaoshiDetailView", BaseLayer)

function BaoshiDetailView:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self:initData()
    self:init("lua.uiconfig.fairyNew.baoshiDetailView")
end

function BaoshiDetailView:initData()
    self.isFromBag = self.paramData_.fromBag
    self.heroId = self.paramData_.heroId
    self.showId = self.paramData_.id
    self.showCid = self.paramData_.cid
    self.notAction = self.paramData_.notAction
    self.selectPos = nil
    self.skill_items = {}
end

function BaoshiDetailView:getClosingStateParams()
    self.paramData_.pos = self.selectPos
    return {self.paramData_}
end

function BaoshiDetailView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_left        = TFDirector:getChildByPath(ui,"Panel_left")
    self.Panel_right        = TFDirector:getChildByPath(ui,"Panel_right")
    self.Panel_pos        = TFDirector:getChildByPath(ui,"Panel_pos")
    self.Panel_detail        = TFDirector:getChildByPath(ui,"Panel_detail")
    self.Panel_di        = TFDirector:getChildByPath(ui,"Panel_di")
    self.Panel_skill_item        = TFDirector:getChildByPath(ui,"Panel_skill_item")

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

    self.Image_icon_bg = TFDirector:getChildByPath(self.Panel_detail,"Image_icon_bg")
    self.Image_icon = TFDirector:getChildByPath(self.Panel_detail,"Image_icon")
    self.Label_name = TFDirector:getChildByPath(self.Panel_detail,"Label_name")
    self.Label_hero_name = TFDirector:getChildByPath(self.Panel_detail,"Label_hero_name")
    self.Label_angel_name = TFDirector:getChildByPath(self.Panel_detail,"Label_angel_name")
    self.Image_grade = TFDirector:getChildByPath(self.Panel_detail,"Image_grade")
    self.Image_pos = {}
    for i=1,4 do
        local Image_pos = TFDirector:getChildByPath(self.Panel_detail,"Image_pos"..i)
        self.Image_pos[i] = Image_pos
    end

    local ScrollView_skills = TFDirector:getChildByPath(self.Panel_detail,"ScrollView_skills")
    self.listView_skills = UIListView:create(ScrollView_skills)

    self.Button_change    = TFDirector:getChildByPath(self.Panel_di,"Button_change")
    self.Button_drop    = TFDirector:getChildByPath(self.Panel_di,"Button_drop"):hide()
    self.Button_merge    = TFDirector:getChildByPath(self.Panel_di,"Button_merge"):hide()
    self.Button_dress = TFDirector:getChildByPath(self.Panel_di,"Button_dress")
    self.Button_recast    = TFDirector:getChildByPath(self.Panel_di,"Button_recast"):hide()
    self:selectGemPos(self.paramData_.pos or 1)
end

function BaoshiDetailView:selectGemPos(pos)
    if self.selectPos == pos then
        return
    end
    self.selectPos = pos
    self:refreshUI()
end

function BaoshiDetailView:refreshUI()
    self:refreshGemPos()
    local data = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos,self.notAction)
    if self.showId or data then
        self.Panel_detail:show()
        self:refreshInfoUI()
        self:refreshSkillItems()
    else
        self.Panel_detail:hide()
    end
    self:updateBtnState()

    if self.notAction then
        self.Panel_di:hide()
    end
end

function BaoshiDetailView:refreshGemPos()
    for i,v in ipairs(self.gem_pos) do
        self:updateGemPosItem(v, i)
    end
end

function BaoshiDetailView:updateGemPosItem(foo, pos)
    local cid
    if self.showCid then
        if pos == self.paramData_.pos then
            cid = self.showCid
        end
    else
        local data = HeroDataMgr:getGemInfoByPos(self.heroId, pos,self.notAction)
        cid = data and data.cid or nil
    end
    if cid then
        local cfg = EquipmentDataMgr:getGemCfg(cid)
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
    foo.Image_add:setTexture(self.isFromBag and "ui/fairy/new_ui/baoshi/020.png" or "ui/fairy/new_ui/baoshi/018.png")
    foo.Image_select:setVisible(not self.isFromBag and self.selectPos == pos)
end

function BaoshiDetailView:refreshInfoUI()
    local cid 
    if self.showCid then
        cid = self.showCid
    else
        local data = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos,self.notAction)
        cid = data and data.cid
    end
    local cfg =  EquipmentDataMgr:getGemCfg(cid)
    self.Image_icon_bg:setTexture(EC_ItemIcon[cfg.quality])
    self.Image_icon:setTexture(cfg.icon)
    self.Label_name:setTextById(cfg.nameTextId)
    self.Label_hero_name:setText(HeroDataMgr:getNameById(self.heroId))
    local skillCfg = TabDataMgr:getData("PassiveSkills",cfg.baseSkill)
    local skillDesc = TextDataMgr:getTextAttr(tonumber(skillCfg.des)).text
    skillDesc = string.gsub(skillDesc, "#", TextDataMgr:getText(cfg.skillName))
    self.Label_angel_name:setText(skillDesc)

    self.Image_grade:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))

    for i,v in ipairs(self.Image_pos) do
        v:setTexture((self.selectPos == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png"))
    end
end

function BaoshiDetailView:refreshSkillItems()
    if #self.skill_items < 1 then
        self.listView_skills:removeAllItems()
        for i = 1, 3 do
            local item = self.Panel_skill_item:clone()
            self.listView_skills:pushBackCustomItem(item)
            self.skill_items[#self.skill_items + 1] = item
        end
    end

    local cid, data 
    if self.showId then
        data = EquipmentDataMgr:getGemInfo(self.showId) or {}
    else
        data = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos, self.notAction) or {}
    end
    if self.showCid then
        cid = self.showCid
    else
        local info = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos,self.notAction)
        cid = info and info.cid
    end
    local cfg =  EquipmentDataMgr:getGemCfg(cid)
    local skillNum = cfg.rarity -4
    for i,item in ipairs(self.skill_items) do
        local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
        local Panel_info = TFDirector:getChildByPath(item,"Panel_info")
        local Label_skill_name = TFDirector:getChildByPath(item,"Label_skill_name")
        local Button_show = TFDirector:getChildByPath(item,"Button_show")
        local Image_skill_icon = TFDirector:getChildByPath(item,"Image_skill_icon")
        local Label_skill_desc = TFDirector:getChildByPath(item,"Label_skill_desc")
        local Label_no_skill = TFDirector:getChildByPath(item,"Label_no_skill")
        Button_show:setVisible(false)
        local skillId = data.randSkill and data.randSkill[i]
        if skillId then
            Panel_info:setVisible(true)
            Label_no_skill:setVisible(false)
            local skillCfg = TabDataMgr:getData("PassiveSkills",skillId)
            Label_skill_name:setTextById(skillCfg.name)
            Image_skill_icon:setTexture(skillCfg.icon)
            local cfg = EquipmentDataMgr:getGemCfg(data.cid)
            local skillDesc = TextDataMgr:getTextAttr(tonumber(skillCfg.des)).text
            skillDesc = string.gsub(skillDesc, "#", TextDataMgr:getText(cfg.skillName))
            Label_skill_desc:setText(skillDesc)
            Button_show:setVisible(true)
        else
            if i <= skillNum then
                Label_no_skill:setVisible(false)
                Label_skill_name:setTextById(1100039)
                Label_skill_desc:setTextById(1100040)
                Image_skill_icon:setTexture("ui/fairy/new_ui/baoshi/random.png")
                Button_show:setVisible(true)
            else
                Panel_info:setVisible(false)
                Label_no_skill:setVisible(true)
                Label_no_skill:setText(self:getSkillEffectTips(i))
            end
        end
        Button_show:onClick(function()
            Utils:openView("fairyNew.BaoshiSkillShowView", i, cid)
        end)
        Button_show:setVisible(not self.notAction)
    end
end

function BaoshiDetailView:getSkillEffectTips(idx)
    if idx == 1 then
        return TextDataMgr:getText(1100020)
    elseif idx == 2 then
        return TextDataMgr:getText(1100021)
    elseif idx == 3 then
        return TextDataMgr:getText(1100022)
    end
end

function BaoshiDetailView:updateBtnState()
    local data = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos,self.notAction)
    self.Button_change:setVisible(not self.isFromBag and data)
    self.Button_dress:setVisible(not self.isFromBag and not data)
    self.Button_recast:hide()
    local id = self.showId
    local cid = self.showCid
    if not cid and data then
        cid = data.cid
        id = data.id
    end
    local gemInfo = EquipmentDataMgr:getGemInfo(id)
    if cid and gemInfo then
        local cfg = EquipmentDataMgr:getGemCfg(cid)
        self.Button_recast:setVisible(cfg and #cfg.specialSkill > 0)
    else
        self.Button_recast:hide()
    end
    if not self.isFromBag and not data then
        AlertManager:closeLayer(self)
    end
end

function BaoshiDetailView:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_GEM_DRESS_OR_DROP,handler(self.refreshUI, self))
    EventMgr:addEventListener(self,EQUIPMENT_GEM_REMOULDED_GEM,handler(self.refreshUI, self))

    for i,v in ipairs(self.gem_pos) do
        v.root:setTouchEnabled(true)
        v.root:onClick(function()
            local data = HeroDataMgr:getGemInfoByPos(self.heroId, i,self.notAction)
            if not self.isFromBag then
                if data then
                    self:selectGemPos(i)
                else
                    Utils:openView("fairyNew.BaoshiChooselView", {heroId = self.heroId,pos = i,fromBag = false})
                end
            end
        end)
    end
    self.Button_change:onClick(function()
        Utils:openView("fairyNew.BaoshiChooselView", {heroId = self.heroId, pos = self.selectPos})
    end)

    self.Button_dress:onClick(function()
        Utils:openView("fairyNew.BaoshiChooselView", {heroId = self.heroId, pos = self.selectPos})
    end)
 
    self.Button_drop:onClick(function()
        -- local data = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos)
        -- EquipmentDataMgr:reqEquipGemOrDrop(2, self.heroId, data.id, self.selectPos)
    end)

    self.Button_merge:onClick(function()
        --Utils:openView("fairyNew.BaoshiComposeView")
    end)

    self.Button_recast:onClick(function ( ... )
        local id = self.showId
        if not self.showId then
            id = HeroDataMgr:getGemInfoByPos(self.heroId, self.selectPos, self.notAction).id
        end
        Utils:openView("fairyNew.BaoshiRecastView",id)
    end)
end

return BaoshiDetailView