
local BaseDataMgr = import(".BaseDataMgr")
local PrefabDataMgr = class("PrefabDataMgr", BaseDataMgr)

function PrefabDataMgr:onLogin()

end

function PrefabDataMgr:onEnterMain()

end

function PrefabDataMgr:reset()

end

function PrefabDataMgr:init()
    self.prefabView_ = createUIByLuaNew("lua.uiconfig.common.prefabView")
    self.prefabView_:retain()
    self.prefab_ = {}

    local children = self.prefabView_:getChildren()
    for i, v in ipairs(children) do
        self.prefab_[v:getName()] = v
    end
end

function PrefabDataMgr:getPrefab(name)
    if name then
        return self.prefab_[name]
    else
        return self.prefab_
    end
end

function PrefabDataMgr:setInfo(item, ...)
    local name = item:getName()
    local handleName = string.format("set_%s", name)
    if self[handleName] then
        self[handleName](self, item, ...)
    end
end

function PrefabDataMgr:updateEquip( item, idOrCid, count, level)
    local function getItemCid()
        if type(idOrCid) == "string" then
            local itemInfo = GoodsDataMgr:getSingleItem(idOrCid)
            return itemInfo.cid
        end
        return idOrCid
    end

    local function getEquipStep(cid)        
        if type(idOrCid) == "string" then
            return EquipmentDataMgr:getEquipStep( idOrCid )           
        end
        if (not EquipmentDataMgr:isExpEquip(cid)) then
            return EquipmentDataMgr:getEquipStepByCid( cid )
        end
        return 0
    end

    local stepLevelLabel = TFDirector:getChildByPath(item, "label_level_step")
    stepLevelLabel:hide()

    local countLabel = TFDirector:getChildByPath(item, "Label_count")
    countLabel:hide()
    --经验质点需要显示数量
    local cid = getItemCid()
    if (not (count == nil)) and ((EquipmentDataMgr:isExpEquip(cid)) or (EquipmentDataMgr:isUniversalEquip(cid))) then
        countLabel:show()
    end

    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    local step = getEquipStep(cid)   
    if step > 0 then
        if (itemCfg.maxAdvanced <= step) then            
            stepLevelLabel:setText("+MAX")
            stepLevelLabel:show()                                                          
        elseif (itemCfg.maxAdvanced > step) then                    
            stepLevelLabel:setText("+" ..step)
            stepLevelLabel:show()              
       end
    end
end

function PrefabDataMgr:addItemId(item, cid)
    if CC_TARGET_PLATFORM ~= CC_PLATFORM_WIN32 then
        return
    end

    local idText = item.idText
    if not idText then
        idText = TFLabel:create()
        idText:setFontSize(18)
        idText:setPosition(ccp(0, 0))
        idText:setAnchorPoint(ccp(0.5, 0.5))
        idText:setFontColor(ccc3(255, 255, 255))
        idText:enableStroke(ccc3(0, 0, 0), 1)
        idText:setZOrder(999)
        item:addChild(idText)
        item.idText = idText
    end
    idText:setText(cid)
end

function PrefabDataMgr:set_Panel_goodsItem(item, idOrCid, count, level, isNotAccess)
    local cid, id
    if type(idOrCid) == "string" then
        id = idOrCid
        local itemInfo = GoodsDataMgr:getSingleItem(id)
        if not itemInfo then
            return
        end
        cid = itemInfo.cid
        level = itemInfo.level
        step = itemInfo.step
        if not level then
            if not count then
                count = GoodsDataMgr:getItemCount(cid)
            end
        end
    else
        cid = idOrCid
    end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    self:addItemId(item, cid)

    local Image_frame = TFDirector:getChildByPath(item, "Image_frame")
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_level = TFDirector:getChildByPath(item, "Image_level"):hide()
    local stepLevelLabel = TFDirector:getChildByPath(item, "label_level_step"):hide()
    local Label_level_title = TFDirector:getChildByPath(Image_level, "Label_level_title")
    local Label_level = TFDirector:getChildByPath(Image_level, "Label_level")
    local Label_count = TFDirector:getChildByPath(item, "Label_count"):hide()
    local Image_heroQuality = TFDirector:getChildByPath(item, "Image_heroQuality"):hide()
    local Image_starItem = TFDirector:getChildByPath(item, "Image_starItem"):hide()
    local Spine_qualityEffect_bg = TFDirector:getChildByPath(item, "Spine_qualityEffect_bg")
    if Spine_qualityEffect_bg then
        Spine_qualityEffect_bg:hide()
    end
    local Spine_qualityEffect_up = TFDirector:getChildByPath(item, "Spine_qualityEffect_up")
    if Spine_qualityEffect_up then
        Spine_qualityEffect_up:hide()
    end
    local ScrollView_star = TFDirector:getChildByPath(item, "ScrollView_star")
    local Panel_level_star = TFDirector:getChildByPath(item, "Panel_level_star"):hide()
    Label_level_title:setString("Lv.")
    local ListView_star = item.ListView_star
    if not ListView_star then
        ListView_star = UIListView:create(ScrollView_star)
        ListView_star:setInertiaScrollEnabled(false)
        ListView_star:setItemsMargin(-3)
        item.ListView_star = ListView_star
        item.ScrollView_star = ScrollView_star
    end
    ListView_star:removeAllItems()
    item.ScrollView_star:setPositionX(0)

    if itemCfg.superType == EC_ResourceType.HERO then
        Image_heroQuality:show()
        local skinData = TabDataMgr:getData("HeroSkin", itemCfg.defaultSkin)
        Image_icon:setTexture(skinData.nameIcon)
        Image_frame:setTexture(EC_ItemIcon[itemCfg.rarity])
        Image_heroQuality:setTexture(HeroDataMgr:getQualityPic(cid, itemCfg.rarity))
    else
        local starNum = itemCfg.star or 0
        if itemCfg.superType == EC_ResourceType.FETTERS then
            local equipInfo = EquipmentDataMgr:getNewEquipInfoById(id)
            local equipCfg = EquipmentDataMgr:getNewEquipCfg(cid)
            local maxStar = equipCfg.endStar
            if equipInfo then
                starNum = equipInfo.stage
            end
            for i = 1, maxStar do
                local starItem = Image_starItem:clone():show()
                starItem:ZO(starNum - i + 1)
                if i > starNum then
                    starItem:setTexture("ui/common/starBack.png")
                end
                ListView_star:pushBackCustomItem(starItem)
            end
        elseif itemCfg.superType == EC_ResourceType.EXPLORE_TREASURE then
            local maxStar = #itemCfg.levelCost + 1
            starNum = 0
            
            if  GoodsDataMgr:getItem(cid) then
                local _,itemData = next(GoodsDataMgr:getItem(cid))
                starNum = itemData.star
            end

            for i = 1, maxStar do
                local starItem = Image_starItem:clone():show()
                starItem:ZO(starNum - i + 1)
                if i > starNum then
                    starItem:setTexture("ui/common/starBack.png")
                end
                ListView_star:pushBackCustomItem(starItem)
            end
        else
            for i = 1, starNum do
                local starItem = Image_starItem:clone():show()
                starItem:ZO(starNum - i + 1)
                ListView_star:pushBackCustomItem(starItem)
            end
            if itemCfg.superType == EC_ResourceType.SPIRIT and id then
                local starLevel = EquipmentDataMgr:getEquipStarLevel(id)
                if starLevel > 0 then
                    if starLevel < 2 then
                        item.ScrollView_star:setPositionX(-7)
                        Panel_level_star:setPositionX(31)
                    else
                        item.ScrollView_star:setPositionX(-12)
                        Panel_level_star:setPositionX(23)
                    end
                    
                    Panel_level_star:show()
                    local Image_stage1 = TFDirector:getChildByPath(Panel_level_star,"Image_stage1")
                    local Image_stage2 = TFDirector:getChildByPath(Panel_level_star,"Image_stage2")
                    local Image_stage3 = TFDirector:getChildByPath(Panel_level_star,"Image_stage3")
                    Image_stage1:setVisible(starLevel >= 1 and starLevel <= 2)
                    Image_stage2:setVisible(starLevel == 2)
                    Image_stage3:setVisible(starLevel == 3)
                end
            end
        end
        
        Utils:setAliginCenterByListView(ListView_star, true)

        if itemCfg.superType == EC_ResourceType.KABALA and
                (itemCfg.subType == Enum_KabalaItemType.ItemType_BuffItem or itemCfg.subType == Enum_KabalaItemType.ItemType_Buff)then
            local frameImg = Enum_KabalaItemFrame[itemCfg.quality]
            if not frameImg then
                frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
            end
            Image_frame:setTexture(frameImg)
        else
            Image_frame:setTexture(EC_ItemIcon[itemCfg.quality])
        end

        Image_icon:setTexture(itemCfg.icon)
        if count and count >= 0 then
            Label_count:show()
            Label_count:setText(count)
        end
        if itemCfg.superType == EC_ResourceType.BAOSHI then
            Label_count:hide()
        end
        if level then
            Image_level:show()
            Image_level:setTexture(EC_ItemLevelIcon[itemCfg.quality])
            Label_level:setText(level)
        end
        if itemCfg.durationTime then
            Label_level_title:setText("      ")
            Image_level:show()
            Label_level:show()
            Image_level:setTexture(EC_ItemLevelIcon[itemCfg.quality])
            Label_level:setTextById(itemCfg.durationTime)
        end

        if itemCfg.superType == EC_ResourceType.SPIRIT then
            self:updateEquip(item, idOrCid, count, level)
        end

        item:onClick(function()
            Utils:showInfo(cid, id, not(GuideDataMgr and GuideDataMgr:isInNewGuide() and  not isNotAccess))
        end)
    end
end

function PrefabDataMgr:set_Panel_cgItem(item, idOrCid, count, level)
    local cid, id
    if type(idOrCid) == "string" then
        id = idOrCid
        local itemInfo = GoodsDataMgr:getSingleItem(id)
        cid = itemInfo.cid
        level = itemInfo.level
        if not level then
            if not count then
                count = GoodsDataMgr:getItemCount(cid)
            end
        end
    else
        cid = idOrCid
    end
    local itemCfg = GoodsDataMgr:getItemCfg(cid)

    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Label_count = TFDirector:getChildByPath(item, "Label_count"):hide()
    Image_icon:setTexture(itemCfg.icon)
    Image_icon:setSize(CCSizeMake(250, 160))
end

function PrefabDataMgr:set_Panel_dropGoodsItem(item, Panel_goodsItem_arg, flag, arg)
    flag = flag or 0
    arg = arg or {}
    local Panel_goodsItem = TFDirector:getChildByPath(item, "Panel_goodsItem")
    self:setInfo(Panel_goodsItem, unpack(Panel_goodsItem_arg))
    local Image_geted = TFDirector:getChildByPath(item, "Image_geted"):hide()
    local Label_geted = TFDirector:getChildByPath(Image_geted, "Label_geted")
    local Image_activity_extra = TFDirector:getChildByPath(item, "Image_activity_extra"):hide()
    local Label_activity_extra = TFDirector:getChildByPath(Image_activity_extra, "Label_activity_extra")
    local Image_activity_multiple = TFDirector:getChildByPath(item, "Image_activity_multiple"):hide()
    local Label_activity_multiple = TFDirector:getChildByPath(Image_activity_multiple, "Label_activity_multiple")
    local Image_firstPass = TFDirector:getChildByPath(item, "Image_firstPass"):hide()
    local Label_firstPass = TFDirector:getChildByPath(Image_firstPass, "Label_firstPass")
    local Image_mass = TFDirector:getChildByPath(item, "Image_mass"):hide()
    local Label_mass = TFDirector:getChildByPath(item, "Label_title")
    local Image_dating_geted = TFDirector:getChildByPath(item, "Image_dating_geted"):hide()

    local visible = bit.band(flag, EC_DropShowType.TEAM_MASS) ~= 0
    Image_mass:setVisible(visible)
    Label_mass:setTextById(2100152)
    if visible then return end

    local visible = bit.band(flag, EC_DropShowType.GETED) ~= 0
    Image_geted:setVisible(visible)
    if visible then return end

    local visible = bit.band(flag, EC_DropShowType.DATING_GETED) ~= 0
    Image_dating_geted:setVisible(visible)
    if visible then return end

    local visible = bit.band(flag, EC_DropShowType.ACTIVITY_EXTRA) ~= 0
    Image_activity_extra:setVisible(visible)
    Label_activity_extra:setTextById(1890013)
    if visible then return end

    local visible = bit.band(flag, EC_DropShowType.ACTIVITY_MULTIPLE) ~= 0
    Image_activity_multiple:setVisible(visible)
    if visible then
        Label_activity_multiple:setTextById(1890012, tostring(arg.multiple))
    end
    if visible then return end

    local visible = bit.band(flag, EC_DropShowType.FIRST_PASS) ~= 0
    Image_firstPass:setVisible(visible)
    Label_firstPass:setTextById(1890014)
    if visible then return end
end

function PrefabDataMgr:set_Panel_element(item , elementId , isUp , isTouch)
    local panel_element = TFDirector:getChildByPath(item , "Panel_element")
    local img_arrow_up = panel_element:getChildByName("img_arrow_up")
    local img_arrow_down = panel_element:getChildByName("img_arrow_down")
    local Image_icon = panel_element:getChildByName("img_icon")

    img_arrow_up:setVisible(false)
    img_arrow_down:setVisible(false)


    if isUp == nil then
    else
        if isUp then
            img_arrow_up:setVisible(true)
        else
            img_arrow_down:setVisible(true)
        end
    end

    if isTouch == nil then
        isTouch = true
    end

    if isTouch then
        item:setTouchEnabled(true)
        item:onClick(function ( ... )
            --Utils:openView("fairyNew.FairyElementPanel")
        end)
    else
        item:setTouchEnabled(false)
    end
    

    Image_icon:setTexture("icon/element/"..elementId..".png")

end


return PrefabDataMgr:new()
