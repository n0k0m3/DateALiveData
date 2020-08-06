local CourageBagView = class("CourageBagView", BaseLayer)

function CourageBagView:initData()

    self.goodsItem_ = {}
    self.goodsData_ = {}

    self.btnConfig_ = {
        {
            txt = 301004,
            iconImg = "ui/bag/new_ui/new_13.png",
            bag = {EC_Bag.COURAGE_FOOD},
        },
        {
            txt = 301002,
            iconImg = "ui/bag/new_ui/new_11.png",
            bag = {EC_Bag.COURAGE_EQUIP},
        },
        {
            txt = 301003,
            iconImg = "ui/bag/new_ui/new_12.png",
            bag = {EC_Bag.COURAGE_MATERIAL},
        },
    }

    self.guideItemID = 901502
    self.guideItem_ = nil
end

function CourageBagView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageBagView")
end

function CourageBagView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root, "Button_help")
    self.Panel_selfInfo = TFDirector:getChildByPath(self.Panel_root, "Panel_selfInfo")
    self.Label_userId = TFDirector:getChildByPath(self.Panel_selfInfo, "Label_userId")
    self.Label_area = TFDirector:getChildByPath(self.Panel_selfInfo, "Label_area")
    self.Label_name = TFDirector:getChildByPath(self.Panel_selfInfo, "Label_name")
    self.Label_stage = TFDirector:getChildByPath(self.Panel_selfInfo, "Label_stage")
    self.Label_apValue = TFDirector:getChildByPath(self.Panel_selfInfo, "Label_apValue")
    self.LoadingBar_ap = TFDirector:getChildByPath(self.Panel_selfInfo, "LoadingBar_ap")
    local ScrollView_chapter = TFDirector:getChildByPath(self.Panel_selfInfo, "ScrollView_chapter")
    self.ListView_chapter = UIListView:create(ScrollView_chapter)

    self.Panel_equip = TFDirector:getChildByPath(self.Panel_root, "Panel_equip")
    local ScrollView_equip = TFDirector:getChildByPath(self.Panel_equip, "ScrollView_equip")
    self.ListView_equip = UIListView:create(ScrollView_equip)

    self.Button_guide = TFDirector:getChildByPath(self.Panel_root, "Button_guide")
    self.Image_guideItem = TFDirector:getChildByPath(self.Button_guide, "Image_guideItem")

    local Panel_item = TFDirector:getChildByPath(self.Panel_root, "Panel_item")
    self.typeBtn = {}
    for i=1,3 do
        local btn = TFDirector:getChildByPath(Panel_item, "Button_"..i)
        local Image_select = TFDirector:getChildByPath(btn, "Image_select")
        local tab = {}
        tab.btn = btn
        tab.select = Image_select
        table.insert(self.typeBtn,tab)
    end

    self.ScrollView_item = TFDirector:getChildByPath(Panel_item, "ScrollView_item")

    self.Panel_item_info = TFDirector:getChildByPath(self.Panel_root, "Panel_item_info"):hide()
    self.Label_itemName = TFDirector:getChildByPath(self.Panel_item_info, "Label_itemName")
    self.Label_itemInfo = TFDirector:getChildByPath(self.Panel_item_info, "Label_itemInfo")
    self.Button_use = TFDirector:getChildByPath(self.Panel_item_info, "Button_use")
    self.useBtnText = TFDirector:getChildByPath(self.Button_use, "Label_btn")
    self.Button_unequip = TFDirector:getChildByPath(self.Panel_item_info, "Button_unequip")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_bagItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bagItem")
    self.Panel_equipItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_equipItem")
    self.Panel_chapter_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_chapter_item")
    self.GridView_item = {}
    for i=1, 3 do
        local ScrollView_item = self.ScrollView_item:clone():show()
        ScrollView_item:AddTo(self.ScrollView_item:getParent(), 1)
        local GridView_item = UIGridView:create(ScrollView_item)
        GridView_item:setItemModel(self.Panel_bagItem)
        GridView_item:setColumn(7)
        GridView_item:setColumnMargin(8)
        GridView_item:setRowMargin(10)
        self.GridView_item[i] = GridView_item
    end

    self:initUILogic()

end

function CourageBagView:onShow()
    self.super.onShow(self)
    self:timeOut(function()
        GameGuide:checkGuide(self);
    end,0.1)
end

function CourageBagView:initUILogic()

    self:updateSelfInfo()
    self:chooseType(1)
    self:updateEquipList()
    self:upDateSwitchState(true)
    self:updateApInfo()
end

function CourageBagView:updateApInfo()
    local apInfo = CourageDataMgr:getApInfo()
    if not apInfo then
        return
    end
    local cur,max = apInfo.value,apInfo.limit
    cur = cur >= 0 and cur or 0
    max = max == 0 and 1 or max
    local percent = math.floor(cur/max*100)
    self.LoadingBar_ap:setPercent(percent)
    self.Label_apValue:setText(cur.."/"..max)
end

function CourageBagView:updateSelfInfo()

    local userId = MainPlayer:getPlayerId()
    self.Label_userId:setText("ID:"..userId)

    local curCapter,areaCid = CourageDataMgr:getCurLocation()

    if areaCid then
        local cfg = CourageDataMgr:getMapCfgByCid(areaCid)
        if cfg then
            self.Label_area:setText(cfg.areaName)
        end
    end

    local userName = MainPlayer:getPlayerName()
    self.Label_name:setText(userName)

    local curCapter,curAreaId = CourageDataMgr:getCurLocation()
    self.ListView_chapter:removeAllItems()
    self.chapterId_ = {}
    local mapInfo = CourageDataMgr:getMapCfgByType()
    for k,v in pairs(mapInfo) do
        if k <= curCapter then
            table.insert(self.chapterId_,k)
        end
    end
    table.sort(self.chapterId_,function(a,b)
        return a < b
    end)

    print(curCapter)
    for k,v in ipairs(self.chapterId_) do
        local chapterItem = self.Panel_chapter_item:clone()
        local Image_not = TFDirector:getChildByPath(chapterItem, "Image_not")--:hdie()
        local Label_name = TFDirector:getChildByPath(Image_not, "Label_name")
        Label_name:setText(v)
        local Image_arrow = TFDirector:getChildByPath(Image_not, "Image_arrow")
        Image_arrow:setVisible(k ~= #self.chapterId_)
        local Image_finish = TFDirector:getChildByPath(chapterItem, "Image_finish")--:hdie()
        local Label_name = TFDirector:getChildByPath(Image_finish, "Label_name")
        Label_name:setText(v)
        local Image_arrow = TFDirector:getChildByPath(Image_finish, "Image_arrow")
        Image_arrow:setVisible(k ~= #self.chapterId_)
        local Image_cur = TFDirector:getChildByPath(chapterItem, "Image_cur")--:hdie()
        local Label_name = TFDirector:getChildByPath(Image_cur, "Label_name")
        Label_name:setText(v)
        local Image_arrow = TFDirector:getChildByPath(Image_cur, "Image_arrow")
        Image_arrow:setVisible(k ~= #self.chapterId_)

        Image_finish:setVisible(v < curCapter)
        Image_cur:setVisible(v == curCapter)
        Image_not:setVisible(v > curCapter)

        self.ListView_chapter:pushBackCustomItem(chapterItem)
    end
end

function CourageBagView:splitGoods(goodsId)
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

function CourageBagView:updateGoodsData(index)
    local chapterId,areaId = CourageDataMgr:getCurLocation()
    chapterId = chapterId or 1
    local config = self.btnConfig_[index]
    self.goodsData_[index] = {}
    for _, v in ipairs(config.bag) do
        local bag = GoodsDataMgr:getBag(v)
        for _, item in pairs(bag) do
            local splitGoods = self:splitGoods(item.id)
            local goodsCfg = GoodsDataMgr:getItemCfg(item.cid)
            if goodsCfg.superType == EC_ResourceType.COURAGE_EQUIP then
                local outSideInfo = goodsCfg.outside
                local isCurChapterEquip = table.indexOf(outSideInfo,chapterId)   ---是该周目专属装备
                if isCurChapterEquip ~= -1 then
                    table.insertTo(self.goodsData_[index], splitGoods)
                end
            else
                table.insertTo(self.goodsData_[index], splitGoods)
            end
        end
    end
end

function CourageBagView:chooseType(index)

    self.chooseIndex = index
    for k,v in ipairs(self.typeBtn) do
        v.select:setVisible(index == k)
        self.GridView_item[k]:setVisible(index == k)
    end
    self.Panel_item_info:setVisible(false)
    if self.oldSelectItem then
        local foo = self.goodsItem_[self.oldSelectItem];
        foo.Image_select:setVisible(false)
    end
    self.oldSelectItem = nil
    self:updateGoodsData(index)
    self:updateItems()
end

function CourageBagView:updateItems()

    local goodsData = self.goodsData_[self.chooseIndex]
    local GridView_item = self.GridView_item[self.chooseIndex]
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

function CourageBagView:addGoodsItem()
    local item = self.GridView_item[self.chooseIndex]:pushBackDefaultItem()
    local foo = {}
    foo.root = item
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select"):hide()
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock"):hide()
    foo.Panel_not = TFDirector:getChildByPath(foo.root, "Panel_not"):hide()
    foo.Panel_head = TFDirector:getChildByPath(foo.root, "Panel_head")
    foo.Image_carry = TFDirector:getChildByPath(foo.root, "Image_carry"):hide()

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:Pos(0, 0)
    Panel_goodsItem:AddTo(foo.Panel_head)
    foo.Panel_goodsItem = Panel_goodsItem
    self.goodsItem_[item] = foo
    return item
end

function CourageBagView:updateGoodsItem(item, data)
    local foo = self.goodsItem_[item]
    if not foo then
        item = self:addGoodsItem();
        foo = self.goodsItem_[item];
    end
    PrefabDataMgr:setInfo(foo.Panel_goodsItem, data.cid,data.num)

    local isEquiped = CourageDataMgr:isEquiped(data.cid)
    foo.Image_carry:setVisible(isEquiped)

    if data.cid == self.guideItemID then
        self.guideItem_ = item
    end

    foo.Panel_head:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        self:selectGoodsItem(item, data)
    end)
end

function CourageBagView:selectGoodsItem(item,data)

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

function CourageBagView:updateItemDetailInfo(cid)

    self.Panel_item_info:setVisible(true)

    local itemCfg = GoodsDataMgr:getItemCfg(cid)
    local isEquip = itemCfg.bagType == EC_Bag.COURAGE_EQUIP
    self.Label_itemName:setTextById(itemCfg.nameTextId)
    self.Label_itemInfo:setTextById(itemCfg.desTextId)

    local isEquiped = CourageDataMgr:isEquiped(cid)
    --self.Button_unequip:setVisible(isEquip and isEquiped)
    self.Button_unequip:setVisible(false)

    if isEquip then
        --self.Button_use:setVisible(not isEquiped)
        self.Button_use:setVisible(false)
    else
        local canUsing = GoodsDataMgr:isCanUsing(cid)
        self.Button_use:setVisible(canUsing)
    end


    local str = isEquip and "装备" or "使用"
    self.useBtnText:setText(str)

end

function CourageBagView:useItem()

    Utils:playSound(5033)
    local itemCfg = GoodsDataMgr:getItemCfg(self.selectItem.cid)
    local isEquip = itemCfg.bagType == EC_Bag.COURAGE_EQUIP
    if not isEquip then
        GoodsDataMgr:useItem({{self.selectItem.id, 1}})
    else
        CourageDataMgr:Send_HandleEquip(true,self.selectItem.cid)
    end
end

function CourageBagView:updateEquipList()

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

function CourageBagView:updateBagItem(item,i,unLockCunt)

    local equip = CourageDataMgr:getEquipInfo()
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock"):hide()
    local Label_lock_tip = TFDirector:getChildByPath(Image_lock, "Label_lock_tip")
    local Image_equip_bg = TFDirector:getChildByPath(item, "Image_equip_bg"):hide()
    local Image_icon = TFDirector:getChildByPath(Image_equip_bg, "Image_icon"):hide()
    local Label_name = TFDirector:getChildByPath(Image_icon, "Label_name")
    local Label_desc = TFDirector:getChildByPath(Image_icon, "Label_desc")
    local Button_equip = TFDirector:getChildByPath(Image_equip_bg, "Button_equip")

    local isUnLock = i<= unLockCunt
    Image_lock:setVisible(not isUnLock)
    Image_equip_bg:setVisible(isUnLock)

    Image_icon:setVisible(equip[i] ~= nil)
    if equip[i] then
        local itemCfg = GoodsDataMgr:getItemCfg(equip[i].equipId)
        Label_name:setTextById(itemCfg.nameTextId)
        --Label_desc:setTextById(itemCfg.desTextId)
        local s = TextDataMgr:getText(itemCfg.desTextId)
        self:setNewTextH(Label_desc,s,46,"...")
        local Panel_goodsItem = Image_icon:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Pos(0, 0)
            Panel_goodsItem:AddTo(Image_icon)
            Panel_goodsItem:setScale(0.7)
            Panel_goodsItem:setName("Panel_goodsItem")
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, equip[i].equipId)
    end
    local str = {13311169,13311170,13311171}
    Label_lock_tip:setTextById(str[i])
end

function CourageBagView:onItemUpdateEvent(oldGoods, goods)
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
            self.oldSelectItem = nil
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

    self.Panel_item_info:setVisible(#goodsData > 0)
end

function CourageBagView:onRecvHandleEquip()
    self:updateEquipList()
    self:updateGoodsItem(self.oldSelectItem, self.selectItem)
    self:updateItemDetailInfo(self.selectItem.cid)
end


function CourageBagView:excuteGuideFunc30007(guideFuncId)
    local targetNode = self.typeBtn[1].btn
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageBagView:excuteGuideFunc30008(guideFuncId)

    if not self.guideItem_ then
        return
    end
    local targetNode = self.guideItem_
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageBagView:excuteGuideFunc30009(guideFuncId)
    local targetNode = self.Button_use
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function CourageBagView:upDateSwitchState(init)
    local isOpen = CourageDataMgr:getGuideState()
    local posX = isOpen and -34 or 34
    if not init then
        self.Image_guideItem:runAction(CCMoveTo:create(0.3,ccp(posX,0)))
    else
        self.Image_guideItem:setPositionX(posX)
    end
end

function CourageBagView:setNewTextH(labelObj,labelStr,limitHeight,otherStr)


    local function getStrMap(str)
        local strTab = {}
        for uchar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
            strTab[#strTab+1] = uchar
        end
        return strTab
    end

    local strMap = getStrMap(labelStr)

    labelObj:setDimensions(220,0)
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


function CourageBagView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_UPDATE_AP, handler(self.updateApInfo, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_HANDLE_EQUIP, handler(self.onRecvHandleEquip, self))
    EventMgr:addEventListener(self, EV_COURAGE.EV_NEWGUIDE_STATE, handler(self.upDateSwitchState, self))

    for k,v in ipairs(self.typeBtn) do
        v.btn:onClick(function()
            if k == 1 then
                GameGuide:checkGuideEnd(self.guideFuncId)
            end
            self:chooseType(k)
        end)
    end

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_use:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
        self:useItem()
    end)

    self.Button_unequip:onClick(function()
        CourageDataMgr:Send_HandleEquip(false,self.selectItem.cid)
    end)

    self.Button_guide:onClick(function()
        CourageDataMgr:Send_guideState()
    end)

    self.Button_help:onClick(function()
        local layer = require("lua.logic.common.HelpView"):new({1052})
        AlertManager:addLayer(layer)
        AlertManager:show()
    end)

end


return CourageBagView
