local KabalaTreeFormation = class("KabalaTreeFormation", BaseLayer)

function KabalaTreeFormation:ctor(headSlotId)
    self.super.ctor(self)
    self:initData(headSlotId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeFormationNew")
end

function KabalaTreeFormation:initData(headSlotId)

    self.headSlotId = headSlotId                  --主界面点击的头像槽位id
    self.btnStr = {100000065,100000115,100000116,100000117}
    self.heroImg = {}
end

function KabalaTreeFormation:initUI(ui)
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

    --若过通过聊天打开了查看阵容界面，会改变自己的阵容

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FairyDetailsLayer")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("FairyMainLayer")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    local isLayerInQueue,layer = AlertManager:isLayerInQueue("PlayerInfoView")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end

    HeroDataMgr:changeDataToSelf()
    HeroDataMgr:resetShowList(true)
    self:initUIInfo()
end

function KabalaTreeFormation:initUIInfo()

    self.Label_title:setTextById(3005045)
    self.Label_power_title:setTextById(600032)

    self:updateHeroList()
    self:showSelectHeroInfo()
end

function KabalaTreeFormation:updateHeroList()

    local roleCnt = HeroDataMgr:getShowCount()
    for i=1,roleCnt do
        local heroid = HeroDataMgr:getSelectedHeroId(i)
        local isHave = HeroDataMgr:getIsHave(heroid)
        if isHave then
            local heroItem = self.hero_item:clone()
            local skinid = HeroDataMgr:getCurSkin(heroid)
            local data = TabDataMgr:getData("HeroSkin", skinid)

            --heroImg:setSize(ccs(140,245))
            local Image_hero = TFDirector:getChildByPath(heroItem, "Image_hero")
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

            local Image_duty = TFDirector:getChildByPath(heroItem,"Image_duty")
            --local iconpath = HeroDataMgr:getHeroJobIconPath(heroid)
            Image_duty:setVisible(false)
            --jobIcon:setTexture(iconpath)

            local hero = HeroDataMgr:getHero(heroid)
            local Image_xianding = TFDirector:getChildByPath(heroItem,"Image_xianding")
            Image_xianding:setVisible(hero.limitType)
            
            --感染度
            local LoadingBar_effect = TFDirector:getChildByPath(heroItem,"LoadingBar_effect")
            local infectionValue,maxValue,fightMax = KabalaTreeDataMgr:getInfectionsByHeroId(heroid)
            local percent = (infectionValue/maxValue)*100
            LoadingBar_effect:setPercent(percent)

            local isFotbid = infectionValue>=fightMax
            local Image_jinyong  = TFDirector:getChildByPath(heroItem,"Image_jinyong")
            Image_jinyong:setVisible(isFotbid)
            local Label_forbid = TFDirector:getChildByPath(Image_jinyong,"Label_forbid")
            Label_forbid:setTextById(3005014)

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

function KabalaTreeFormation:showSelectHeroInfo()

    --名字
    local heroNameId = HeroDataMgr:getTitleStrId(self.selectHeroId)
    self.titleLabel:setTextById(heroNameId)

    --战斗力
    local fightPower = math.floor(HeroDataMgr:getHeroPower(self.selectHeroId))
    self.Label_power:setString(fightPower)

    --品质
    local qualityRes = HeroDataMgr:getQualityPic(self.selectHeroId)
    self.qualityImg:setTexture(qualityRes)

    --操作按钮状态
    local handleBtnState = self:getHandleButtonState()
    self.Label_handle:setTextById(self.btnStr[handleBtnState])
    self.Button_handle:setGrayEnabled(handleBtnState == 4)
    self.Button_handle:setTouchEnabled(not (handleBtnState == 4))

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

function KabalaTreeFormation:getHandleButtonState()

    --1:移除 2:更换 3：加入 4：已在队伍
    local isHavePlayer = false
    local formation = KabalaTreeDataMgr:getFormation()
    if formation[self.headSlotId] then
        isHavePlayer = true
    end

    local formationSlotId = KabalaTreeDataMgr:beInFormation(self.selectHeroId)
    print(self.headSlotId,formationSlotId)
    --所选英雄不在阵型中
    if formationSlotId == 0 then
        if isHavePlayer then
            return 2
        else
            return 3
        end
    --所选英雄在阵型中
    elseif formationSlotId ~= 0 then

        if formationSlotId == self.headSlotId then
            if self.selectHeroId == formation[self.headSlotId] then
                return 1
            else
                return 4
            end
        else
            return 4
        end
    end
end


function KabalaTreeFormation:handleFormation()

    local srcHeroId = 0
    local formation = KabalaTreeDataMgr:getFormation()
    if formation[self.headSlotId] then
        srcHeroId = formation[self.headSlotId]
    end

    local param1,param2
    local state = self:getHandleButtonState()

    if state == 1 then
        param1 = self.selectHeroId
        param2 = 0
    elseif state == 3 then
        param1 = self.selectHeroId
        param2 = srcHeroId
    elseif state == 2 then
        param1 = srcHeroId
        param2 = self.selectHeroId
    end

    if not param1 or not param2 then
        return
    end

    local msg = {
        param1,
        param2
    }

    TFDirector:send(c2s.QLIPHOTH_OPERATE_FORMATION, msg)
end

function KabalaTreeFormation:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_handle:onClick(function()
        self:handleFormation()
    end)

    EventMgr:addEventListener(self,EV_UPDATE_FORMATION,handler(self.onRecvChangeMember, self))
end

function KabalaTreeFormation:onRecvChangeMember()
    AlertManager:close()
end

return KabalaTreeFormation