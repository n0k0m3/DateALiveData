local KabalaTreeBag = class("KabalaTreeBag", BaseLayer)

function KabalaTreeBag:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeBag")
end

function KabalaTreeBag:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
    EventMgr:addEventListener(self,EV_UPDATE_KABALABAG,handler(self.updateBag, self))
end

function KabalaTreeBag:initData()

    self.MaxEnergy = Utils:getKVP(19001, "oilValue").max
    self.goodsItem_ = {}
end

function KabalaTreeBag:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_bagItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_bagItem")

    local ScrollView_bag = TFDirector:getChildByPath(self.ui, "ScrollView_bag")
    self.ListView_State = UIListView:create(ScrollView_bag)
    self.ListView_State:setItemsMargin(5)

    self:updateBag()
end

function KabalaTreeBag:updateBag()

    self.bagItemTab = {}
    local kabalaBg = KabalaTreeDataMgr:getBag()
    for k,v in ipairs(kabalaBg) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.itemId)
        local itemType = itemCfg.subType
        if itemType ~= Enum_KabalaItemType.ItemType_Buff and itemType ~= Enum_KabalaItemType.ItemType_BuffItem then
            table.insert(self.bagItemTab,v)
        end
    end

    self.ListView_State:removeAllItems()
    local index = 1
    for k,v in pairs(self.bagItemTab) do

        local itemCfg = GoodsDataMgr:getItemCfg(v.itemId)
        local itemType = itemCfg.subType
        local itemBg = self.Panel_bagItem:clone()
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.65)
        Panel_goodsItem:setPosition(ccp(-300,0))
        PrefabDataMgr:setInfo(Panel_goodsItem, v.itemId, v.itemNum)
        itemBg:addChild(Panel_goodsItem)
        
        local Image_choosebg = itemBg:getChildByName("Image_choosebg")
        local chooseBgRes = index%2 == 0 and "ui/kabalatree/cell_bg2.png" or "ui/kabalatree/cell_bg1.png"
        Image_choosebg:setTexture(chooseBgRes)

        local itemName = itemBg:getChildByName("Label_itemName")
        itemName:setTextById(itemCfg.nameTextId)

        local itemDes  = itemBg:getChildByName("Label_itemDesc")
        itemDes:setTextById(itemCfg.desTextId)

        local itemOwnCnt = itemBg:getChildByName("Label_haveCnt")
        local str = TextDataMgr:getText(3005031,v.itemNum)
        itemOwnCnt:setText(str)

        local Button_use = itemBg:getChildByName("Button_use")
        local btnNameTx = Button_use:getChildByName("Label_btn")
        btnNameTx:setTextById(3005032)
        Button_use:onClick(function ()
            self:useItem(v.itemId,v.itemNum,itemType)
        end)
        self.ListView_State:pushBackCustomItem(itemBg)

        index = index + 1
    end
end

function KabalaTreeBag:useItem(itemId,count,itemType)

    if count <= 0 then
        Utils:showTips(3005033)
        return
    end

    if itemType == Enum_KabalaItemType.ItemType_ForAll then
        Utils:openView("kabalaTree.KabalaTreeUseItem",itemId)
    else

        local formation = KabalaTreeDataMgr:getFormation()
        if itemId == 590003 then
            local cnt = 0
            for i=1,3 do
                local heroId = formation[i]
                if heroId then
                    local infectionValue,maxValue = KabalaTreeDataMgr:getInfectionsByHeroId(heroId)
                    if infectionValue ~= 0 then
                        cnt = cnt + 1
                    end
                end
            end

            if cnt == 0 then
                Utils:showTips(3005034)
                return
            end
        elseif itemId == 590001 then
            local curEnergy = KabalaTreeDataMgr:getEnergy()
            if curEnergy >= self.MaxEnergy then
                Utils:showTips(3005035)
                return
            end
        end
        
        local msg = {
            itemId,
            1,
            formation
        }
        TFDirector:send(c2s.QLIPHOTH_USE_ITEM, msg)
    end
end

return KabalaTreeBag