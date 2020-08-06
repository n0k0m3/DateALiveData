local CourageBeginConfirm = class("CourageBeginConfirm", BaseLayer)

function CourageBeginConfirm:initData()

    self.goodsItem_ = {}
    self.goodsData_ = {}

    self.btnConfig_ = {
        txt = 301002,
        iconImg = "ui/bag/new_ui/new_11.png",
        bag = {EC_Bag.COURAGE_EQUIP},
    }
end

function CourageBeginConfirm:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageBeginConfirm")
end

function CourageBeginConfirm:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Panel_equip = TFDirector:getChildByPath(self.Panel_root, "Panel_equip")
    local ScrollView_equip = TFDirector:getChildByPath(self.Panel_equip, "ScrollView_equip")
    self.ListView_equip = UIListView:create(ScrollView_equip)

    self.Label_name = TFDirector:getChildByPath(self.Panel_root, "Label_name")
    self.Label_info = TFDirector:getChildByPath(self.Panel_root, "Label_info")

    local Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item")
    local ScrollView_item = TFDirector:getChildByPath(Panel_item, "ScrollView_item")

    self.Button_unequip = TFDirector:getChildByPath(Panel_item, "Button_unequip")
    self.Button_use = TFDirector:getChildByPath(Panel_item, "Button_use")
    self.Button_go = TFDirector:getChildByPath(Panel_item, "Button_go")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_bagItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bagItem")
    self.Panel_equipItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_equipItem")

    local GridView_item = UIGridView:create(ScrollView_item)
    GridView_item:setItemModel(self.Panel_bagItem)
    GridView_item:setColumn(4)
    GridView_item:setColumnMargin(4)
    GridView_item:setRowMargin(4)
    self.GridView_item = GridView_item



    self:initUILogic()

end

function CourageBeginConfirm:initUILogic()

    self:chooseType(1)
    self:updateEquipList()
end

function CourageBeginConfirm:splitGoods(goodsId)
    local goodsInfo = GoodsDataMgr:getSingleItem(goodsId)
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsInfo.cid)
    local goods = {}
    if goodsCfg.pileUp then
        if goodsCfg.pileUp then
            local count = math.floor(goodsInfo.num / goodsCfg.gridMax)
            for i = 1, count do
                local cItem = clone(goodsInfo)
                cItem.num = goodsCfg.gridMax
                local remain = table.insert(goods, cItem)
            end
        end
        local remainNum = math.fmod(goodsInfo.num, goodsCfg.gridMax)
        if remainNum > 0 then
            local cItem = clone(goodsInfo)
            cItem.num = remainNum
            table.insert(goods, cItem)
        end
    else
        table.insert(goods, clone(goodsInfo))
    end

    return goods
end

function CourageBeginConfirm:updateGoodsData()

    local chapterId,areaId = CourageDataMgr:getCurLocation()
    chapterId = chapterId or 1
    self.goodsData_ = {}
    for _, v in ipairs(self.btnConfig_.bag) do
        local bag = GoodsDataMgr:getBag(v)
        for _, item in pairs(bag) do
            local splitGoods = self:splitGoods(item.id)
            local goodsCfg = GoodsDataMgr:getItemCfg(item.cid)
            if goodsCfg.superType == EC_ResourceType.COURAGE_EQUIP then
                local outSideInfo = goodsCfg.outside
                local index = table.indexOf(outSideInfo,chapterId)   ---是该周目专属装备
                if index ~= -1 then
                    table.insertTo(self.goodsData_, splitGoods)
                end
            else
                table.insertTo(self.goodsData_, splitGoods)
            end
        end
    end
end

function CourageBeginConfirm:chooseType(index)

    self:updateGoodsData()
    self:updateItems()
end

function CourageBeginConfirm:updateItems()

    local goodsData = self.goodsData_
    local GridView_item = self.GridView_item
    for k,v in ipairs(goodsData) do
        local item = GridView_item:getItem(k)
        if not item then
            item = self:addGoodsItem()
        end
        self:updateGoodsItem(item, v)
        if not self.oldSelectItem then
            self:selectGoodsItem(item,v)
        end
    end
end

function CourageBeginConfirm:addGoodsItem()
    local item = self.GridView_item:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock"):hide()
    foo.Panel_not = TFDirector:getChildByPath(foo.root, "Panel_not"):hide()
    foo.Panel_head = TFDirector:getChildByPath(foo.root, "Panel_head")
    foo.Image_carry = TFDirector:getChildByPath(foo.root, "Image_carry")

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:Pos(0, 0)
    Panel_goodsItem:AddTo(foo.Panel_head)
    foo.Panel_goodsItem = Panel_goodsItem
    self.goodsItem_[item] = foo
    return item
end

function CourageBeginConfirm:updateGoodsItem(item, data)
    local foo = self.goodsItem_[item]
    if not foo then
        item = self:addGoodsItem();
        foo = self.goodsItem_[item];
    end
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.cid,data.num)

    local isEquiped = CourageDataMgr:isEquiped(data.cid)
    foo.Image_carry:setVisible(isEquiped)

    foo.Panel_head:onClick(function()
        self:selectGoodsItem(item, data)
    end)
end

function CourageBeginConfirm:selectGoodsItem(item,data)

    if self.oldSelectItem then
        local foo = self.goodsItem_[self.oldSelectItem];
        foo.Image_select:setVisible(false)
    end

    local foo = self.goodsItem_[item]
    foo.Image_select:setVisible(true)
    self.oldSelectItem = item
    self.selectItem = data
    self:updateItemDetailInfo(data.cid)
end

function CourageBeginConfirm:updateItemDetailInfo(cid)

    local isEquip = CourageDataMgr:isEquiped(cid)
    self.Button_use:setTouchEnabled(not isEquip)
    self.Button_use:setGrayEnabled(isEquip)

    self.Button_unequip:setTouchEnabled(isEquip)
    self.Button_unequip:setGrayEnabled(not isEquip)

    self.Label_name = TFDirector:getChildByPath(self.Panel_root, "Label_name")
    self.Label_info = TFDirector:getChildByPath(self.Panel_root, "Label_info")

    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    self.Label_name:setTextById(itemCfg.nameTextId)
    local str = TextDataMgr:getText(itemCfg.desTextId)
    self:setNewText(self.Label_info,str,380,"...")
end

function CourageBeginConfirm:updateEquipList()

    self.ListView_equip:removeAllItems()

    local unLockCunt = 0
    local unlockChapter = CourageDataMgr:getUnlockChapter()
    for k,v in ipairs(unlockChapter) do
        local mazeDmgrCfg = CourageDataMgr:getMazeDMgrCfg(v)
        if not mazeDmgrCfg then
            return
        end
        local equipNumber = mazeDmgrCfg.equipNumber
        unLockCunt = unLockCunt < equipNumber and equipNumber or unLockCunt
    end


    for i=1,3 do
        local equipItem = self.Panel_equipItem:clone()
        self.ListView_equip:pushBackCustomItem(equipItem)
        self:updateBagItem(equipItem,i,unLockCunt)
    end
end

function CourageBeginConfirm:updateBagItem(item,i,unLockCunt)

    local equip = CourageDataMgr:getEquipInfo()
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock"):hide()
    local Label_lock_tip = TFDirector:getChildByPath(Image_lock, "Label_lock_tip")
    local Image_equip_bg = TFDirector:getChildByPath(item, "Image_equip_bg"):hide()
    local Image_icon = TFDirector:getChildByPath(Image_equip_bg, "Image_icon"):hide()
    local Label_name = TFDirector:getChildByPath(Image_icon, "Label_name")
    local Label_desc = TFDirector:getChildByPath(Image_icon, "Label_desc")
    local Image_equip = TFDirector:getChildByPath(Image_icon, "Image_equip")
    local Button_equip = TFDirector:getChildByPath(Image_equip_bg, "Button_equip")

    local isUnLock = i<= unLockCunt
    Image_lock:setVisible(not isUnLock)
    Image_equip_bg:setVisible(isUnLock)

    Image_icon:setVisible(equip[i] ~= nil)
    if equip[i] then
        local itemCfg = GoodsDataMgr:getItemCfg(equip[i].equipId)
        Label_name:setTextById(itemCfg.nameTextId)
        local s = TextDataMgr:getText(itemCfg.desTextId)
        self:setNewTextH(Label_desc,s,42,"...")
        local Panel_goodsItem = Image_equip:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Pos(0, 0)
            Panel_goodsItem:AddTo(Image_equip)
            Panel_goodsItem:setScale(0.7)
            Panel_goodsItem:setName("Panel_goodsItem")
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, equip[i].equipId)
    end
    local str = {13311169,13311170,13311171}
    Label_lock_tip:setTextById(str[i])
end

function CourageBeginConfirm:onItemUpdateEvent(oldGoods, goods)
    if not self.btnConfig_ then
        return
    end
    local cid
    for _, v in pairs({oldGoods, goods}) do
        if v then
            cid = v.cid
            break
        end
    end
    if not cid then
        return
    end
    local tabIndex
    for i, v in ipairs(self.btnConfig_) do
        local itemCfg = GoodsDataMgr:getItemCfg(cid)
        if table.indexOf(v.bag, itemCfg.bagType) ~= -1 then
            tabIndex = i
            break
        end
    end
    if not tabIndex then return end
    if self.chooseIndex ~= tabIndex then return end

    local goodsData = self.goodsData_[self.chooseIndex]
    local gridView = self.GridView_item[self.chooseIndex]

    if oldGoods and goods then
        local goodsId = goods.id
        local goodsCid = goods.cid
        local goodsCfg = GoodsDataMgr:getItemCfg(goodsCid)
        -- 更新
        local index
        local sameGoods = {}
        for i, v in ipairs(goodsData) do
            if v.id == goods.id then
                if goodsCfg.pileUp then
                    table.insert(sameGoods, i)
                else
                    index = i
                end
            end
        end

        local needUpdateGoods = {}
        if #sameGoods > 0 then
            local splitGoods = self:splitGoods(goodsId)
            if #splitGoods < #sameGoods then
                local removeIndex = {}
                for i = #sameGoods, 1, -1 do
                    if i > #splitGoods then
                        table.insert(removeIndex, sameGoods[i])
                        table.remove(goodsData, sameGoods[i])
                    else
                        goodsData[sameGoods[i]] = splitGoods[i]
                        table.insert(needUpdateGoods, sameGoods[i])
                    end
                end
                gridView:removeItems(removeIndex)
            else
                for i, v in ipairs(splitGoods) do
                    if i > #sameGoods then
                        table.insert(goodsData, v)
                        self:addGoodsItem()
                        table.insert(needUpdateGoods, #goodsData)
                    else
                        goodsData[sameGoods[i]] = v
                        table.insert(needUpdateGoods, sameGoods[i])
                    end
                end
            end
        else
            goodsData[index] = GoodsDataMgr:getSingleItem(goodsId)
            table.insert(needUpdateGoods, index)
        end
        for i, v in ipairs(needUpdateGoods) do
            local item = gridView:getItem(v)
            self:updateGoodsItem(item, goodsData[v])
        end
    else
        if not oldGoods then
            -- 新增
            local splitGoods = self:splitGoods(goods.id)
            table.insertTo(goodsData, splitGoods)
            for i, v in ipairs(splitGoods) do
                local item = self:addGoodsItem()
                self:updateGoodsItem(item, v)
            end
        else
            -- 删除
            local removeIndex = {}
            for i = #goodsData, 1, -1 do
                if goodsData[i].id == oldGoods.id then
                    table.insert(removeIndex, i)
                    table.remove(goodsData, i)
                end
            end
            gridView:removeItems(removeIndex)
        end

        for k,v in ipairs(goodsData) do
            local item = gridView:getItem(k)
            if item then
                if not self.oldSelectItem then
                    self:selectGoodsItem(item,v)
                end
            end
        end
    end
end

function CourageBeginConfirm:onRecvHandleEquip()
    self:updateEquipList()
    --self:updateGoodsItem(self.oldSelectItem, self.selectItem)
    self:updateItemDetailInfo(self.selectItem.cid)

    for k,v in ipairs(self.goodsData_) do
        local item = self.GridView_item:getItem(k)
        if not item then
            item = self:addGoodsItem()
        end
        self:updateGoodsItem(item, v)
    end
end

function CourageBeginConfirm:jumpToMainView()

    local chapterId,areaId = CourageDataMgr:getCurLocation()
    chapterId = chapterId or 1

    local unLockCunt = 0
    local unlockChapter = CourageDataMgr:getUnlockChapter()
    for k,v in ipairs(unlockChapter) do
        local mazeDmgrCfg = CourageDataMgr:getMazeDMgrCfg(v)
        if not mazeDmgrCfg then
            return
        end
        local equipNumber = mazeDmgrCfg.equipNumber
        unLockCunt = unLockCunt < equipNumber and equipNumber or unLockCunt
    end

    local openEquipSolt = unLockCunt

    local ownEquipCnt = 0
    local equip = CourageDataMgr:getEquipInfo()
    equip = equip or {}
    local bagdata = GoodsDataMgr:getBag(EC_Bag.COURAGE_EQUIP)
    for k,item in pairs(bagdata) do
        local goodsCfg = GoodsDataMgr:getItemCfg(item.cid)
        if goodsCfg.superType == EC_ResourceType.COURAGE_EQUIP then
            local isEquiped = CourageDataMgr:isEquiped(item.cid)     ---没装备cid 的装备
            if not isEquiped then
                local outSideInfo = goodsCfg.outside
                local index = table.indexOf(outSideInfo,chapterId)   ---是该周目专属装备
                if index ~= -1 then
                    ownEquipCnt = ownEquipCnt + 1
                end
            end
        end
    end

    local equip = CourageDataMgr:getEquipInfo()
    local equipCnt = equip and #equip or 0

    if openEquipSolt == 0 then
        CourageDataMgr:Send_EnterGame()
        AlertManager:closeLayer(self)
    else
        local tipStr = "进入游戏后装备不可更换，要出发了吗？"
        if openEquipSolt > equipCnt and ownEquipCnt ~= 0 then
            tipStr = "仍有空的装备槽可使用，就这样出发吗？"
        end
        local args = {
            tittle = 2107025,
            content = tipStr,
            reType = EC_OneLoginStatusType.ReconFirm_Courage,
            confirmCall = function()
                CourageDataMgr:Send_EnterGame()
                AlertManager:closeLayer(self)
            end,
        }
        Utils:showReConfirm(args)
    end
end

function CourageBeginConfirm:setNewText(labelObj,labelStr,limitWidth,otherStr)


    local function getStrMap(str)
        local strTab = {}
        for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
            strTab[#strTab+1] = uchar
        end
        return strTab
    end

    local strMap = getStrMap(labelStr)

    labelObj:setDimensions(0,0)
    labelObj:setText(labelStr)

    if labelObj:getContentSize().width <= limitWidth then
        return
    end

    local setStr = ""
    local tempStr2 = ""
    for k,v in ipairs(strMap) do
        local tempStr = tempStr2..v
        labelObj:setString(tempStr..otherStr)
        if labelObj:getContentSize().width > limitWidth then
            break
        else
            tempStr2 = tempStr
        end
    end
    setStr = setStr .. tempStr2 .. otherStr
    labelObj:setString(setStr)

end

function CourageBeginConfirm:setNewTextH(labelObj,labelStr,limitHeight,otherStr)


    local function getStrMap(str)
        local strTab = {}
        for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
            strTab[#strTab+1] = uchar
        end
        return strTab
    end

    local strMap = getStrMap(labelStr)

    labelObj:setDimensions(160,0)
    labelObj:setText(labelStr)

    if labelObj:getContentSize().height <= limitHeight then
        return
    end

    local setStr = ""
    local tempStr2 = ""
    for k,v in ipairs(strMap) do
        local tempStr = tempStr2..v
        labelObj:setString(tempStr..otherStr)
        if labelObj:getContentSize().height > limitHeight then
            break
        else
            tempStr2 = tempStr
        end
    end
    setStr = setStr .. tempStr2 .. otherStr
    labelObj:setString(setStr)

end

function CourageBeginConfirm:registerEvents()

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_HANDLE_EQUIP, handler(self.onRecvHandleEquip, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_use:onClick(function()
        CourageDataMgr:Send_HandleEquip(true,self.selectItem.cid)
    end)

    self.Button_unequip:onClick(function()
        CourageDataMgr:Send_HandleEquip(false,self.selectItem.cid)
    end)

    self.Button_go:onClick(function()
        self:jumpToMainView()
    end)
end


return CourageBeginConfirm
