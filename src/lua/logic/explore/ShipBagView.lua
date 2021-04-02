local ShipBagView = class("ShipBagView", BaseLayer)


function ShipBagView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.explore.shipBagView")
end

function ShipBagView:initData()

end

function ShipBagView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")


    local ScrollView_treasure = TFDirector:getChildByPath(self.Panel_root,"ScrollView_item")


    local Panel_item = TFDirector:getChildByPath(ui,"Panel_item"):clone()
    self.GridView_award = UIGridView:create(ScrollView_treasure)
    self.GridView_award:setItemModel(Panel_item)
    self.GridView_award:setColumn(6)

    self.Label_Name = TFDirector:getChildByPath(self.Panel_root,"Label_Name")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root,"Label_desc")
    self.Label_desc:setDimensions(200, 0)
    self:initUILogic()
end

function ShipBagView:initUILogic()

    self.GridView_award:removeAllItems()
    local bagdata = GoodsDataMgr:getBag(EC_Bag.EXPLORE_MATERIAL)
    local showList = {}
    for k,v in pairs(bagdata) do
        table.insert(showList,v)
    end
    table.sort(showList, function ( v1, v2 )
        -- body
        return v1.cid > v2.cid
    end)

    self.GridView_award:AsyncUpdateItem(showList,function( Panel_Item,v )
        local itemCfg = GoodsDataMgr:getItemCfg(v.cid)
        local Image_icon = TFDirector:getChildByPath(Panel_Item,"Image_icon")
        local Panel_goodsItem = Image_icon.goods
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:setAnchorPoint(ccp(0.5,0.5))
            Panel_goodsItem:setPosition(ccp(0,0))
            Panel_goodsItem:setScale(0.7)
            Image_icon:addChild(Panel_goodsItem)
            Image_icon.goods = Panel_goodsItem
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, v.cid, v.num)

        local Image_select = TFDirector:getChildByPath(Panel_Item,"Image_select"):hide()
        if not self.select then
            self.select = Image_select
            self.Label_Name:setTextById(itemCfg.nameTextId)
            self.Label_desc:setTextById(itemCfg.desTextId)
            Image_select:show()
        end
        Panel_goodsItem:onClick(function()
            if self.select then
                self.select:hide()
            end
            Image_select:show()
            self.select = Image_select
            self.Label_Name:setTextById(itemCfg.nameTextId)
            self.Label_desc:setTextById(itemCfg.desTextId)
        end)
    end,
    function ( data )
        local itemCfg = GoodsDataMgr:getItemCfg(data.cid)
        if itemCfg then
            local Panel_Item = self.GridView_award:pushBackDefaultItem()
            return Panel_Item
        end
    end)
end

function ShipBagView:registerEvents()
    self.super.registerEvents(self)
    self.Button_close:onClick(function ( ... )
        -- body
        AlertManager:closeLayer(self)
    end)
end

return ShipBagView
