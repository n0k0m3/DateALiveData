local TreasureConfirm = class("TreasureConfirm", BaseLayer)


function TreasureConfirm:ctor(eventCid,callBack)
    self.super.ctor(self)
    self:initData(eventCid,callBack)
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.treasureConfirm")
end

function TreasureConfirm:initData(eventCid,callBack)

    local eventCfg = ExploreDataMgr:getAfkEventCfg(eventCid)
    if not eventCfg then
        return
    end
    self.fitCid = eventCfg.condition.showItemId
    print(self.fitCid,type(self.fitCid))
    self.callBack = callBack
    self.monsterLevelCfg = TabDataMgr:getData("MonsterLevel")
end

function TreasureConfirm:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root,"Button_close")

    self.Label_treasure_tip = TFDirector:getChildByPath(self.Panel_root,"Label_treasure_tip")

    local ScrollView_treasure = TFDirector:getChildByPath(self.Panel_root,"ScrollView_treasure")
    local Image_item_bg = TFDirector:getChildByPath(ui,"Image_item_bg"):clone()
    self.GridView_award = UIGridView:create(ScrollView_treasure)
    self.GridView_award:setItemModel(Image_item_bg)
    self.GridView_award:setColumn(2)
    self.GridView_award:setColumnMargin(20)
    self.GridView_award:setRowMargin(10)

    self:initUILogic()
end

function TreasureConfirm:initUILogic()

    local bagList = {}
    local bagdata = GoodsDataMgr:getBag(EC_Bag.EXPLORE_TREASURE)
    for k,v in pairs(bagdata) do
        table.insert(bagList,v)
    end
    table.sort(bagList,function(a,b)
        local priorityA = a.cid == self.fitCid and 1 or 0
        local priorityB = b.cid == self.fitCid and 1 or 0
        return priorityA > priorityB
    end)

    self.Label_treasure_tip:setVisible(#bagList <= 0)

    self.GridView_award:removeAllItems()
    for k,v in ipairs(bagList) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.cid)
        if itemCfg then
            local item = self.GridView_award:pushBackDefaultItem()
            local Label_name = TFDirector:getChildByPath(item,"Label_name")
            Label_name:setTextById(itemCfg.nameTextId)
            local icon = TFDirector:getChildByPath(item,"icon")
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setAnchorPoint(ccp(0.5,0.5))
            Panel_goodsItem:setPosition(ccp(0,0))
            icon:addChild(Panel_goodsItem)
            PrefabDataMgr:setInfo(Panel_goodsItem, v.cid)
            local Image_not_fit = TFDirector:getChildByPath(item,"Image_not_fit")
            Image_not_fit:setVisible(self.fitCid ~= v.cid)
            local Image_fit = TFDirector:getChildByPath(item,"Image_fit")
            Image_fit:setVisible(self.fitCid == v.cid)
            item:setTouchEnabled(true)
            item:onClick(function()
                if self.fitCid ~= v.cid then
                    Utils:showTips(13322014)
                    return
                end
                if self.callBack then
                    self.callBack(v.id,self.fitCid)
                    AlertManager:closeLayer(self)
                end
            end)
        end
    end
end


function TreasureConfirm:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return TreasureConfirm
