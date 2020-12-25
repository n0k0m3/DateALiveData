local DetailsBossPage = class("DetailsBossPage", BaseLayer)


function DetailsBossPage:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.explore.detailsBossPage")
end

function DetailsBossPage:initData()

    self.attrIds = {101,111,121}
    self.monsterLevelCfg = TabDataMgr:getData("AfkMonsterLevel")
    self.shipAttTable  = TabDataMgr:getData("ShipAttribute")
    self.attr = {}
    self.dropItem = {}
end

function DetailsBossPage:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui,"Panel_root")
    self.Panel_item = TFDirector:getChildByPath(self.Panel_root,"Panel_item")
    local ScrollView_item = TFDirector:getChildByPath(self.Panel_root,"ScrollView_item")

    self.TurnView_items = UITurnView:create(ScrollView_item)
    self.TurnView_items:setItemModel(self.Panel_item)

    self.Spine_boss = TFDirector:getChildByPath(self.Panel_root,"Spine_boss")

    for i=1,3 do
        local attrbg = TFDirector:getChildByPath(self.Panel_root,"Image_attr_"..i)
        local name = TFDirector:getChildByPath(attrbg,"Label_name")
        local value = TFDirector:getChildByPath(attrbg,"Label_value")
        table.insert(self.attr,{name = name,value = value})
    end

    self.Label_bossName =  TFDirector:getChildByPath(self.Panel_root,"Label_bossName")

    self.awardbg_ = {}
    for i=1,3 do
        self.awardbg_[i] = TFDirector:getChildByPath(self.Panel_root,"Image_goodbg"..i)
    end

    local ScrollView_award = TFDirector:getChildByPath(self.Panel_root,"ScrollView_award"):hide()

    --self.TableView_item = Utils:scrollView2TableView(ScrollView_award)
    --self.TableView_item:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    --self.TableView_item:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    --self.TableView_item:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    self:updateBaseInfo()
end

--[[function DetailsBossPage:cellSizeForTable()
    local size = PrefabDataMgr:getPrefab("Panel_goodsItem"):getSize()
    return size.height*0.6, size.width*0.6
end

function DetailsBossPage:numberOfCellsInTableView()
    return #self.dropItem
end

function DetailsBossPage:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        cell.item:setScale(0.6)
        PrefabDataMgr:setInfo(cell.item, self.dropItem[idx].id,self.dropItem[idx].num)
    end
    return cell
end--]]


function DetailsBossPage:updateBaseInfo()

    self.nationCid = ExploreDataMgr:getCurNation()
    self.bossItem_ = {}
    self.cityGroup =  ExploreDataMgr:getAfkCityGroup(self.nationCid)
    if not self.cityGroup then
        Box("nationId: " .. self.nationCid .. ",找不到对应城市")
        return
    end

    table.sort(self.cityGroup,function(a,b)
        return a.exploreOrder < b.exploreOrder
    end)

    for k,v in ipairs(self.cityGroup) do
        if not self.bossItem_[k] then
            self:addBossItem(k)
        end
        self:updateBossItem(k, v)
    end
end

function DetailsBossPage:addBossItem(id)

    local item = self.TurnView_items:pushBackItem()
    item:show()
    local foo = {}
    foo.root = item
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Label_desc = TFDirector:getChildByPath(foo.root, "Label_desc")
    foo.Image_find = TFDirector:getChildByPath(foo.root, "Image_find")
    foo.Button_fight = TFDirector:getChildByPath(foo.root, "Button_fight")
    local Label_btn = TFDirector:getChildByPath(foo.Button_fight, "Label_btn")
    Label_btn:setSkewX(10)
    foo.Button_jump = TFDirector:getChildByPath(foo.root, "Button_jump")

    local btnEffect = SkeletonAnimation:create("effect/effects_icon/effects_icon")
    btnEffect:setAnimationFps(GameConfig.ANIM_FPS)
    btnEffect:play("animation",true)
    foo.Button_jump:addChild(btnEffect)

    foo.Image_pass = TFDirector:getChildByPath(foo.root, "Image_pass")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Label_name:setSkewX(10)
    foo.Image_normal_bg = TFDirector:getChildByPath(foo.root, "Image_normal_bg")
    local ScrollView_award = TFDirector:getChildByPath(foo.root, "ScrollView_award")
    ScrollView_award:setSwallowTouch(false)
    foo.ListView_award = UIListView:create(ScrollView_award)

    foo.awardbg_ = {}
    for i=1,3 do
        foo.awardbg_[i] = TFDirector:getChildByPath(foo.root,"Image_goodbg"..i)
    end

    self.bossItem_[id] = foo
    return item
end

function DetailsBossPage:updateBossItem(id,data)

    local bossItem = self.bossItem_[id]
    if not bossItem then
        return
    end
    local cityBossEventCid = data.cityBoss
    local afkEventCfg = ExploreDataMgr:getAfkEventCfg(cityBossEventCid)
    if not afkEventCfg then
        return
    end

    local item = {}
    for k,v in pairs(afkEventCfg.award) do
        table.insert(item,{id = k,num = v})
    end

    for k,v in ipairs(bossItem.awardbg_) do
        local Panel_goodsItem = v:getChildByName("Panel_goodsItem")
        if item[k] then
            if not Panel_goodsItem then
                Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:setScale(0.7)
                Panel_goodsItem:setName("Panel_goodsItem")
                Panel_goodsItem:Pos(0, 0):AddTo(v)
            end
            PrefabDataMgr:setInfo(Panel_goodsItem, item[k].id,item[k].num)
        else
            if Panel_goodsItem then
                Panel_goodsItem:hide()
            end
        end
    end

    local eventParam = afkEventCfg.eventPrams
    local monsterId = eventParam.monsterId

    local monsterCfg = ExploreDataMgr:getAfkMonsterCfg(monsterId)
    if not monsterCfg then
        return
    end

    bossItem.Label_name:setTextById(monsterCfg.name)
    bossItem.Image_icon:setTexture(monsterCfg.targetIcon)

    local isUnLock = true
    local foundEventData = ExploreDataMgr:getFoundEventData(cityBossEventCid)
    if not foundEventData then
        isUnLock = false
    end

    bossItem.Label_desc:setTextById(data.cityBossNotice)

    local isPass = ExploreDataMgr:isFinishEvent(cityBossEventCid)
    bossItem.Image_pass:setVisible(isPass)
    bossItem.Image_normal_bg:setVisible(isUnLock and not isPass)
    if not isPass then
        bossItem.Image_lock:setVisible(not isUnLock)
    else
        bossItem.Image_lock:setVisible(false)
    end


    bossItem.Button_fight:onClick(function()
        Utils:openView("explore.BossFightConfirm",afkEventCfg,data.id,nil,true)
    end)

    bossItem.Button_jump:onClick(function()
        Utils:openView("explore.ExploreCountryView",afkEventCfg.city)
    end)
end

function DetailsBossPage:onTurnViewSelect(target, selectIndex)

    for k,v in ipairs(self.bossItem_) do
        v.Image_select:setVisible(selectIndex == k)
    end

    if not self.cityGroup or not self.cityGroup[selectIndex] then
        return
    end

    local afkEventCfg = ExploreDataMgr:getAfkEventCfg(self.cityGroup[selectIndex].cityBoss)
    if not afkEventCfg then
        return
    end

    self.dropItem =  {}
    local award = afkEventCfg.award
    for k,v in pairs(award) do
        table.insert(self.dropItem,{id = k,num = v})
    end
    --self.TableView_item:reloadData()

    for k,v in ipairs(self.awardbg_) do
        local Panel_goodsItem = v:getChildByName("Panel_goodsItem")
        if self.dropItem[k] then
            if not Panel_goodsItem then
                Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:setScale(0.7)
                Panel_goodsItem:setName("Panel_goodsItem")
                Panel_goodsItem:Pos(0, 0):AddTo(v)
            end
            PrefabDataMgr:setInfo(Panel_goodsItem, self.dropItem[k].id,self.dropItem[k].num)
        else
            if Panel_goodsItem then
                Panel_goodsItem:hide()
            end
        end
    end

    local monsterCfg = ExploreDataMgr:getAfkMonsterCfg(afkEventCfg.eventPrams.monsterId)
    if not monsterCfg then
        return
    end

    self.Label_bossName:setTextById(monsterCfg.name)

    if self.modelName ~= monsterCfg.model then
        self.Spine_boss:setFile(string.format("effect/%s/%s",monsterCfg.model,monsterCfg.model))
        self.Spine_boss:play("stand",true)
        self.Spine_boss:setScale(monsterCfg.modelSize3)
        self.Spine_boss:setPosition(ccp(monsterCfg.offset2.x,monsterCfg.offset2.y))
        self.modelName = monsterCfg.model
    end



    local attributesType = monsterCfg.attributesType
    local monsterLevelCfg = self.monsterLevelCfg[attributesType]
    if not monsterLevelCfg then
        return
    end

    local baseAttr = monsterLevelCfg.baseAttr
    local upAttr = monsterLevelCfg.upAttr
    for i=1,3 do
        local attrId = self.attrIds[i]
        if not attrId then
            self.attr[i].name:setText("")
            self.attr[i].value:setText("")
        else
            local attrData = self:getAttributeConfig(attrId)
            local nameStr = TextDataMgr:getText(attrData.name)
            self.attr[i].name:setText(nameStr)
            local baseValue = baseAttr[attrId] or 0
            local upValue = upAttr[attrId] or 0
            local level = monsterCfg.level
            local value = baseValue + upValue*level
            self.attr[i].value:setText(value)
        end
    end

end

function DetailsBossPage:getAttributeConfig(attId)
    for i, v in ipairs(self.shipAttTable) do
        if v.attributeId == attId then
            return v
        end
    end
    return nil
end

function DetailsBossPage:registerEvents()

    local function scrollCallback(target, offsetRate, customOffsetRate, index)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            local rCustomRate = 1 - customRate
            --item:setOpacity(255 * rrate)
            --item:setPositionZ(-customRate * 100)
            --item:setZOrder(rrate * 100)
        end
    end
    self.TurnView_items:registerScrollCallback(scrollCallback)
    self.TurnView_items:registerSelectCallback(handler(self.onTurnViewSelect, self))

    for k,v in ipairs(self.bossItem_) do
        v.root:onClick(function()
            self.TurnView_items:scrollToItem(k)
        end)
    end
end

return DetailsBossPage
