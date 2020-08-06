local KabalaTreeUseItem = class("KabalaTreeUseItem", BaseLayer)

function KabalaTreeUseItem:ctor(itemId)
    self.super.ctor(self)
    self:initData(itemId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeUseItemNew")
end

function KabalaTreeUseItem:initData(itemId)
    self.itemId = itemId
    self.heroImg = {}
end

function KabalaTreeUseItem:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_cancel")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Label_power_title = TFDirector:getChildByPath(self.ui, "Label_power_title")
    
    self.titleLabel         = TFDirector:getChildByPath(ui,"Label_name_title")
    self.Label_power        = TFDirector:getChildByPath(ui,"Label_power")
    self.qualityImg         = TFDirector:getChildByPath(ui,"Image_hero_puality")
    self.qualityImg:setScale(0.2)

    self.moodBg             = TFDirector:getChildByPath(ui,"Image_back2")
    self.moodValueTx        = TFDirector:getChildByPath(ui,"moodValue")
    self.Image_head         = TFDirector:getChildByPath(ui,"Image_head")
    self.moodValueDesc      = TFDirector:getChildByPath(ui,"moodValueDesc")

    --button    
    self.Button_handle      = TFDirector:getChildByPath(ui,"Button_handle")
    self.Label_handle       = TFDirector:getChildByPath(ui,"Label_handle")

    self.hero_item         = TFDirector:getChildByPath(ui,"Panel_item")
    local ScrollView_HeroList         = TFDirector:getChildByPath(ui,"ScrollView_HeroList")
    self.ListView_Hero = UIListView:create(ScrollView_HeroList)
    self.ListView_Hero:setItemsMargin(2)

    self:initUIInfo()
end

function KabalaTreeUseItem:initUIInfo()

    self.Label_title:setTextById(3005045)
    self.Label_power_title:setTextById(600032)
    self.Label_handle:setTextById(3005032)

    self:updateHeroList()
    self:showSelectHeroInfo()
end

function KabalaTreeUseItem:onHide()
    
end

function KabalaTreeUseItem:updateHeroList()

    local roleCnt = HeroDataMgr:getShowCount()
    for i=1,roleCnt do
        local heroid = HeroDataMgr:getSelectedHeroId(i)
        local isHave = HeroDataMgr:getIsHave(heroid)
        if isHave then
            local heroItem = self.hero_item:clone()
            local skinid = HeroDataMgr:getCurSkin(heroid)
            local data = TabDataMgr:getData("HeroSkin", skinid)
            local Image_hero = TFDirector:getChildByPath(heroItem,"Image_hero")
            local Panel_mask = TFDirector:getChildByPath(heroItem, "Panel_mask")
            local Image_diban = TFDirector:getChildByPath(Panel_mask, "Image_diban")
            local Panel_model = TFDirector:getChildByPath(Panel_mask, "Panel_model")
            Image_diban:setTexture(data.backdrop)

            --防止直接拖动删除model
            if not self.heroImg[heroid] then
                local model = Utils:createHeroModel(heroid, Panel_model, 0.45, skinid)
                model:update(0.1)
                model:stop()

                --截屏
                local tx = CCRenderTexture:create(140,245)
                tx:begin()
                Panel_model:visit();
                tx:endToLua()

                self.heroImg[heroid] = Sprite:createWithTexture(tx:getSprite():getTexture())
                self.heroImg[heroid]:setScaleY(-1)
                self.heroImg[heroid]:setPositionY(0)
                self.heroImg[heroid]:retain()
                self.heroImg[heroid]:setName("heroImg")
            end

            --防止self.heroImg[heroid]没有从上一个父节点移除
            if self.heroImg[heroid]:getParent() then
                self.heroImg[heroid]:removeFromParent();
            end
            Image_hero:addChild(self.heroImg[heroid])

            local name = TFDirector:getChildByPath(heroItem,"Label_name")
            name:setLineHeight(22)
            name:setTextById(HeroDataMgr:getNameStrId(heroid))

            local jobIcon = TFDirector:getChildByPath(heroItem,"Image_duty")
            local iconpath = HeroDataMgr:getHeroJobIconPath(heroid)
            jobIcon:setVisible(iconpath ~= "")
            jobIcon:setTexture(iconpath)

            local hero = HeroDataMgr:getHero(heroid)
            local Image_xianding = TFDirector:getChildByPath(heroItem,"Image_xianding")
            Image_xianding:setVisible(hero.limitType)

            --感染度
            local LoadingBar_effect = TFDirector:getChildByPath(heroItem,"LoadingBar_effect")
            local infectionValue,maxValue,fightMax = KabalaTreeDataMgr:getInfectionsByHeroId(heroid)
            local percent = (infectionValue/maxValue)*100
            LoadingBar_effect:setPercent(percent)
            local Image_jinyong  = TFDirector:getChildByPath(heroItem,"Image_jinyong")
            Image_jinyong:setVisible(infectionValue>=fightMax)

            local Image_select  = TFDirector:getChildByPath(heroItem,"Image_select")
            if i == 1 then
                Image_select:setVisible(true)
                self.lastChooseImg = Image_select
                self.selectIndex = 1
                self.selectHeroId = heroid
            else
                Image_select:setVisible(false)
            end
            self.ListView_Hero:pushBackCustomItem(heroItem)

            heroItem:onClick(function ()
                if self.selectIndex == i then
                    return
                end
                Image_select:setVisible(true)
                self.lastChooseImg:setVisible(false)
                self.selectIndex = i
                self.lastChooseImg = Image_select
                self.selectHeroId = heroid

                self:showSelectHeroInfo()
            end)
            
        end
    end
end

function KabalaTreeUseItem:showSelectHeroInfo()

    --名字
    local heroNameId = HeroDataMgr:getTitleStrId(self.selectHeroId)
    self.titleLabel:setTextById(heroNameId)

    --战斗力
    local fightPower = math.floor(HeroDataMgr:getHeroPower(self.selectHeroId))
    self.Label_power:setString(fightPower)

    --品质
    local qualityRes = HeroDataMgr:getQualityPic(self.selectHeroId)
    self.qualityImg:setTexture(qualityRes)

    local roleid = HeroDataMgr:getHeroRoleId(self.selectHeroId)
    local isHaveRole = RoleDataMgr:getIsHave(roleid)
    self.moodBg:setVisible(isHaveRole)
    if not isHaveRole then
        return
    end

    --心情
    local moodValue = RoleDataMgr:getMood(roleid)
    self.moodValueTx:setString(moodValue)

    --头像
    local headRes = RoleDataMgr:getMoodIcon(roleid)
    self.Image_head:setTexture(headRes)

    --心情描述
    local moodeDesc = RoleDataMgr:getMoodDes(roleid)
    self.moodValueDesc:setString(moodeDesc)
    
end

function KabalaTreeUseItem:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_handle:onClick(function()
        self:useKabalaItem()
    end)
end

function KabalaTreeUseItem:useKabalaItem()
    
    local heroIdTab = {}
    heroIdTab[1] = self.selectHeroId
    
    local infectionValue,maxValue = KabalaTreeDataMgr:getInfectionsByHeroId(self.selectHeroId)
    if infectionValue == 0 then
        Utils:showTips(3005053)
        return
    end

    local msg = {
        self.itemId,
        1,
        heroIdTab
    }
    TFDirector:send(c2s.QLIPHOTH_USE_ITEM, msg)

    AlertManager:closeLayer(self)
end


return KabalaTreeUseItem