local EquipmentStarUp = class("EquipmentStarUp", BaseLayer)

function EquipmentStarUp:ctor(data)
    self.super.ctor(self,data)
    self.paramData_ = data
    self.showId = data.equipmentId
    self.choosedData = nil
    self:init("lua.uiconfig.Equip.EquipStarUp")
end

function EquipmentStarUp:getClosingStateParams()
    return {self.paramData_}
end

function EquipmentStarUp:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

    local Panel_left =    TFDirector:getChildByPath(ui,"Panel_left")
    local Panel_right =    TFDirector:getChildByPath(ui,"Panel_right")
    local Panel_bottom =    TFDirector:getChildByPath(ui,"Panel_bottom")
    self.Panel_anim_show = TFDirector:getChildByPath(ui,"Panel_anim_show"):hide()

    self.Label_name        = TFDirector:getChildByPath(Panel_left,"Label_name")
    self.Image_Equip        = TFDirector:getChildByPath(Panel_left,"Image_Equip")
    for i=1,5 do
        self["Image_star"..i] = TFDirector:getChildByPath(Panel_left,"Image_star"..i)
    end
    self.Image_stage1 = TFDirector:getChildByPath(Panel_left,"Image_stage1")
    self.Image_stage2 = TFDirector:getChildByPath(Panel_left,"Image_stage2")
    self.Image_stage3 = TFDirector:getChildByPath(Panel_left,"Image_stage3")

    self.LoadingBar_star       = TFDirector:getChildByPath(Panel_right,"LoadingBar_star")
    self.stage_items = {}
    
    self.Panel_stage = TFDirector:getChildByPath(Panel_right,"Panel_stage")

    self.Panel_level  = TFDirector:getChildByPath(Panel_right,"Panel_level")
    self.Panel_hp     = TFDirector:getChildByPath(Panel_right,"Panel_hp")
    self.Panel_atk    = TFDirector:getChildByPath(Panel_right,"Panel_atk")
    self.Panel_def    = TFDirector:getChildByPath(Panel_right,"Panel_def")

    self.Label_cur_level       = TFDirector:getChildByPath(self.Panel_level,"Label_cur_level")
    self.Label_next_level       = TFDirector:getChildByPath(self.Panel_level,"Label_next_level")
    self.Label_cur_hp       = TFDirector:getChildByPath(self.Panel_hp,"Label_cur_hp")
    self.Label_next_hp       = TFDirector:getChildByPath(self.Panel_hp,"Label_next_hp")
    self.Label_cur_atk       = TFDirector:getChildByPath(self.Panel_atk,"Label_cur_atk")
    self.Label_next_atk       = TFDirector:getChildByPath(self.Panel_atk,"Label_next_atk")
    self.Label_cur_def       = TFDirector:getChildByPath(self.Panel_def,"Label_cur_def")
    self.Label_next_def       = TFDirector:getChildByPath(self.Panel_def,"Label_next_def")
    self.Label_random_attr = TFDirector:getChildByPath(Panel_right,"Label_random_attr"):hide()
    self.Label_random_attr:setTextById(490208)

    self.Panel_cost_item = TFDirector:getChildByPath(ui,"Panel_cost_item")
    self.Equip_item = TFDirector:getChildByPath(ui,"Equip_item")
    local ScrollView_cost_item    = TFDirector:getChildByPath(ui,"ScrollView_cost_item")
    self.ScrollView_cost_item = UIListView:create(ScrollView_cost_item)
    self.cost_items = {}

    self.Button_star_up = TFDirector:getChildByPath(Panel_bottom,"Button_star_up")
    self.Image_res = TFDirector:getChildByPath(Panel_bottom,"Image_res")
    self.Label_cost_num = TFDirector:getChildByPath(Panel_bottom,"Label_cost_num")

    self:refreshUI()
end

function EquipmentStarUp:refreshUI()
    self.Panel_anim_show:setTouchEnabled(false)
    self.Panel_anim_show:setSwallowTouch(false)
    self.Button_star_up:setTouchEnabled(true)
    self.Panel_anim_show:hide()
    local paintPath = EquipmentDataMgr:getEquipPaint(self.showId)
    self.Image_Equip:setTexture(paintPath)
    local pos = EquipmentDataMgr:getEquipPaintPosition(self.showId)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.showId)
    self.Image_Equip:setScale(scale)
    self.Image_Equip:setPosition(pos)

    local name = EquipmentDataMgr:getEquipName(self.showId)
    self.Label_name:setString(name..EquipmentDataMgr:getStepText(self.showId))

    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
    local starLv    = EquipmentDataMgr:getEquipStarLv(self.showId)
    for i=1,5 do
        if i > starLv then
            self["Image_star"..i]:setVisible(false)
        else
            self["Image_star"..i]:setVisible(true)
        end
    end
    self.Image_stage1:setVisible(starLevel >= 1 and starLevel < 3)
    self.Image_stage2:setVisible(starLevel == 2)
    self.Image_stage3:setVisible(starLevel == 3)
    
    local Image_stage1 = TFDirector:getChildByPath(self.Panel_stage,"Image_stage1")
    local Image_stage2 = TFDirector:getChildByPath(self.Panel_stage,"Image_stage2")
    local Image_stage3 = TFDirector:getChildByPath(self.Panel_stage,"Image_stage3")
    Image_stage1:setVisible(starLevel <= 1)
    Image_stage2:setVisible(starLevel == 1)
    Image_stage3:setVisible(starLevel >= 2)

    self.LoadingBar_star:setPercent(starLevel / 3 * 100)

    self:refreshAttrs()
    self:refreshCostItems()
end

function EquipmentStarUp:refreshAttrs()
    local starCfg = EquipmentDataMgr:getEquipStarCfg(self.showId)
    local stageLevel = EquipmentDataMgr:getEquipStageLevel(self.showId)
    local curLevel = EquipmentDataMgr:getEquipLv(self.showId)
    local maxLv = EquipmentDataMgr:getEquipMaxLv(self.showId)
    local nextLevel = EquipmentDataMgr:getEquipStarUpToLevel(self.showId)
    self.Label_cur_level:setString(curLevel.."/"..maxLv)
    self.Label_next_level:setString(curLevel.."/"..nextLevel)
    
    local curHp = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.HP, nil, curLevel)
    local curAtk = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.ATK, nil, curLevel)
    local curDef = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.DEF, nil, curLevel)
    self.Label_cur_hp:setString(curHp)
    self.Label_cur_atk:setString(curAtk)
    self.Label_cur_def:setString(curDef)
    local nextHp = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.HP, nil, curLevel, true)
    local nextAtk = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.ATK, nil, curLevel, true)
    local nextDef = EquipmentDataMgr:getEquipmentAttrById(self.showId, EC_Attr.DEF, nil, curLevel, true)
    self.Label_next_hp:setString(nextHp)
    self.Label_next_atk:setString(nextAtk)
    self.Label_next_def:setString(nextDef)

    if stageLevel > 2 then
        self.Label_random_attr:show()
    end
end

function EquipmentStarUp:refreshCostItems()
    self.ScrollView_cost_item:removeAllItems()
    self.cost_items = {}
    local starCfg = EquipmentDataMgr:getEquipStarCfg(self.showId)
    local stageLevel = EquipmentDataMgr:getEquipStageLevel(self.showId)
    local baseCost = starCfg.baseCost[1][stageLevel]
    local flag = false
    for k, v in pairs(baseCost) do
        local costItem = self.Panel_cost_item:clone()
        local item = TFDirector:getChildByPath(costItem,"Panel_item")
        local label_num = TFDirector:getChildByPath(costItem,"Label_num")
        local info = baseCost[i]
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, tonumber(k))
        Panel_goodsItem:setScale(0.8)
        Panel_goodsItem:AddTo(item):Pos(0, 0)
        local count = GoodsDataMgr:getItemCount(k)
        label_num:setText(count.."/"..v)
        if count >= tonumber(v) then
            label_num:setColor(ccc3(48,53,74))
        else
            flag = true
            label_num:setColor(ccc3(219,50,50))
        end
        self.ScrollView_cost_item:pushBackCustomItem(costItem)
        table.insert(self.cost_items, costItem)
    end
    local coinCost = starCfg.coinCost[1][stageLevel]
    for k, v in pairs(coinCost) do
        self.Image_res:setTexture(GoodsDataMgr:getItemCfg(k).icon)
        self.Image_res:setContentSize(CCSizeMake(40, 40))
        self.Label_cost_num:setText(v)
        if GoodsDataMgr:getItemCount(tonumber(k)) >= tonumber(v) then
            self.Label_cost_num:setColor(ccc3(255,255,255))
        else
            flag = true
            self.Label_cost_num:setColor(ccc3(219,50,50))
        end
        self.Image_res:setTouchEnabled(true)
        self.Image_res:onClick(function()
            Utils:showInfo(tonumber(k), nil, true)
        end)
        break
    end
    
    flag = self:updateCostEquipUI(flag)
    self.Button_star_up:setGrayEnabled(flag)
    self.Button_star_up:setTouchEnabled(not flag)
end

function EquipmentStarUp:onEquipChoosed(data)
    self.choosedData = data
    self:refreshCostItems()
end

function EquipmentStarUp:updateCostEquipUI(flag)
    local rflag = flag
    local starCfg = EquipmentDataMgr:getEquipStarCfg(self.showId)
    local stageLevel = EquipmentDataMgr:getEquipStageLevel(self.showId)
    local equipmentCost = starCfg.equipmentCost[1][stageLevel]
    if equipmentCost then
        local costItem = self.Equip_item:clone()
        local Image_equip_bg = TFDirector:getChildByPath(costItem,"Image_equip_bg")
        local Image_equip_icon = TFDirector:getChildByPath(costItem,"Image_equip_icon")
        local Image_equip_type = TFDirector:getChildByPath(costItem,"Image_equip_type")
        local Panel_cover = TFDirector:getChildByPath(costItem,"Panel_cover")
        local Label_add = TFDirector:getChildByPath(costItem,"Label_add")
        local Label_num = TFDirector:getChildByPath(costItem,"Label_num")
        local star = equipmentCost[3]
        for i=1,5 do
            local Image_star = TFDirector:getChildByPath(costItem,"Image_star"..i)
            Image_star:setVisible(i <= star)
        end
        local cid = equipmentCost[1]

        if cid > 0 then
            Image_equip_bg:setTexture(EC_ItemIcon[EquipmentDataMgr:getEquipQuality(cid)])
            Image_equip_icon:setTexture(EquipmentDataMgr:getEquipIcon(cid))
            Image_equip_bg:setContentSize(CCSizeMake(84,84))
            Image_equip_icon:setContentSize(CCSizeMake(82,82))
        else
            Image_equip_bg:setTexture(EC_ItemIcon[4])
            Image_equip_icon:setTexture("ui/Equipment/new_ui/random_icon.png")
            Image_equip_bg:setContentSize(CCSizeMake(84,84))
            Image_equip_icon:setContentSize(CCSizeMake(80,80))
        end
        Image_equip_type:setVisible(equipmentCost[2] > 0)
        if equipmentCost[2] > 0 then
            Image_equip_type:setTexture(EC_EquipSubTypeIcon[equipmentCost[2]])
            Image_equip_type:Size(CCSizeMake(32,32))
        end
        if self.choosedData then
            Image_equip_bg:setTexture(EC_ItemIcon[EquipmentDataMgr:getEquipQuality(self.choosedData.cid)])
            Image_equip_icon:setTexture(EquipmentDataMgr:getEquipIcon(self.choosedData.cid))
            Image_equip_type:setTexture(EC_EquipSubTypeIcon[EquipmentDataMgr:getEquipSubType(self.choosedData.id)])
            Image_equip_bg:setContentSize(CCSizeMake(84,84))
            Image_equip_icon:setContentSize(CCSizeMake(82,82))
            Image_equip_type:Size(CCSizeMake(32,32))
        end
        
        if self.choosedData then
            Label_num:setString("1/"..equipmentCost[4])
            Label_num:setColor(ccc3(48,53,74))
        else
            rflag = true
            Label_num:setString("0/"..equipmentCost[4])
            Label_num:setColor(ccc3(219,50,50))
        end
        Panel_cover:setVisible(rflag)
        Label_add:setVisible(rflag)
        self.ScrollView_cost_item:pushBackCustomItem(costItem)
        table.insert(self.cost_items, costItem)
        costItem:setTouchEnabled(true)
        costItem:onClick(function()
            local equipmentCost = starCfg.equipmentCost[1][stageLevel]
            local needCid = equipmentCost[1] > 0 and equipmentCost[1] or nil
            Utils:openView("Equipment.StarUpEquipChoose", {id = self.showId, cid = needCid, sType = equipmentCost[2], star = equipmentCost[3], limit = equipmentCost[4], choosed = self.choosedData})
        end)
    end
    return rflag
end

function EquipmentStarUp:onEquipUpOver(data)
    self.Button_star_up:setTouchEnabled(false)
    local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
    for i,item in ipairs(self.cost_items) do
        local effect = TFDirector:getChildByPath(item,"Spine_item_effect")
        effect:show()
        effect:play("equipment_satr_low_goods",false)
        effect:addMEListener(TFARMATURE_COMPLETE,function()
            effect:removeMEListener(TFARMATURE_COMPLETE)
            effect:hide()
        end)
    end
    if starLevel < 3 then
        for i, item in ipairs(self.cost_items) do
            local effectParticle = TFParticle:create("particles/equipment_satr_low_fly.plist")
            effectParticle:show()
            self.ui:addChild(effectParticle, 100)
            effectParticle:setVisible(true)
            local pos = item:getParent():convertToWorldSpace(item:getPosition())
            pos.x = pos.x + 50
            pos.y = pos.y + 70
            local toPos = self.Image_stage3:getParent():convertToWorldSpace(self.Image_stage3:getPosition())
            effectParticle:setPosition(pos)
            effectParticle:resetSystem()
            effectParticle:runAction(CCSequence:create({
            CCMoveTo:create(0.6, toPos),
            CCDelayTime:create(0.2),
            CCCallFunc:create(function()
                effectParticle:removeFromParent()
            end)}))
        end
    end
    local time = starLevel < 3 and 0.8 or 0.2
    self.ui:timeOut(function()
        self.Image_stage1:setVisible(false)
        self.Image_stage2:setVisible(false)
        self.Image_stage3:setVisible(false)
        if starLevel == 1 then
            local Spine_effect = SkeletonAnimation:create("effect/equipment_satr_low/equipment_satr_low")
            Spine_effect:setPosition(self.Image_stage1:getParent():convertToWorldSpace(self.Image_stage1:getPosition()))
            self.ui:addChild(Spine_effect, 100)
            Spine_effect:play("equipment_satr_low_plus",false)
            Spine_effect:addMEListener(TFARMATURE_COMPLETE,function()
                Spine_effect:removeMEListener(TFARMATURE_COMPLETE)
                Spine_effect:removeFromParent()
                self.choosedData = nil
                self:refreshUI()
            end)
        elseif starLevel == 2 then
            local Spine_effect1 = SkeletonAnimation:create("effect/equipment_satr_low/equipment_satr_low")
            local Spine_effect2 = SkeletonAnimation:create("effect/equipment_satr_low/equipment_satr_low")
            Spine_effect1:setPosition(self.Image_stage1:getParent():convertToWorldSpace(self.Image_stage1:getPosition()))
            self.ui:addChild(Spine_effect1, 100)
            Spine_effect2:setPosition(self.Image_stage2:getParent():convertToWorldSpace(self.Image_stage2:getPosition()))
            self.ui:addChild(Spine_effect2, 100)
            Spine_effect1:play("equipment_satr_low_plus",false)
            Spine_effect2:play("equipment_satr_low_plus",false)
            Spine_effect2:addMEListener(TFARMATURE_COMPLETE,function()
                Spine_effect2:removeMEListener(TFARMATURE_COMPLETE)
                Spine_effect1:removeFromParent()
                Spine_effect2:removeFromParent()
                self.choosedData = nil
                self:refreshUI()
            end)
        elseif starLevel == 3 then
            self.choosedData = nil
            self:refreshUI()
            self:showStarUpAnim()
        end
    end,time)
end

function EquipmentStarUp:showStarUpAnim()
    self:hideTopBar()
    self.Panel_anim_show:show()
    local Spine_big_star = TFDirector:getChildByPath(self.Panel_anim_show,"Spine_big_star")
    local Image_hero = TFDirector:getChildByPath(self.Panel_anim_show,"Image_hero")
    local Spine_stars = TFDirector:getChildByPath(self.Panel_anim_show,"Spine_stars"):hide()
    local Spine_splash = TFDirector:getChildByPath(self.Panel_anim_show,"Spine_splash"):hide()
    local paintPath = EquipmentDataMgr:getEquipPaint(self.showId)
    Image_hero:setTexture(paintPath)
    local scale = EquipmentDataMgr:getEquipPaintScale(self.showId)
    Image_hero:setScale(scale)
    self.ui:timeOut(function()
        Spine_stars:show()
        Spine_stars:setAnimationFps(100)
        Spine_stars:play("equipment_satr_high_star",false)
        Spine_stars:addMEListener(TFARMATURE_COMPLETE,function()
            Spine_splash:show()
            Spine_splash:play("animation",false)
            Spine_splash:addMEListener(TFARMATURE_COMPLETE,function()
                self.Panel_anim_show:setTouchEnabled(true)
                self.Panel_anim_show:setSwallowTouch(true)
                self.Panel_anim_show:onClick(function()
                    AlertManager:closeLayer(self)
                end)
            end)
        end)
    end,2)
end

function EquipmentStarUp:onItemUpdateEvent()
    self:refreshCostItems()
end

function EquipmentStarUp:registerEvents()
    EventMgr:addEventListener(self,EQUIPMENT_STAR_UP_EQUIP_CHOOSE,handler(self.onEquipChoosed, self))
    EventMgr:addEventListener(self,EQUIPMENT_STAR_UP_OVER,handler(self.onEquipUpOver, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    
    self.Button_star_up:onClick(function()
        local starLevel = EquipmentDataMgr:getEquipStarLevel(self.showId)
        local stageLevel = EquipmentDataMgr:getEquipStageLevel(self.showId)
        if starLevel >= 3 then
            Utils:showTips(490407)
            return
        end

        local curLevel = EquipmentDataMgr:getEquipLv(self.showId)
        local limitLevel = EquipmentDataMgr:getEquipStarLimitLevel(self.showId)
        if curLevel < limitLevel then 
            Utils:showTips(490401, limitLevel)
            return
        end

        local function starUp()
            local starCfg = EquipmentDataMgr:getEquipStarCfg(self.showId)
            local equipmentCost = starCfg.equipmentCost[1][stageLevel]
            local costIds = {}
            table.insert(costIds, self.choosedData.id)
            EquipmentDataMgr:equipmentStarUp(self.showId, costIds)
        end
        
        if stageLevel == 1 then
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(starUp)
            view:setContent(TextDataMgr:getText(490405))
            return
        end
        starUp()
    end)
end

return EquipmentStarUp