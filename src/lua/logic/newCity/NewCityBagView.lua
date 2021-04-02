local NewCityBagView = class("NewCityBagView", BaseLayer)
local bagTab = {
    liwu = 1,
    cailiao = 2,
}

function NewCityBagView:ctor(bagdata)
    self.super.ctor(self)
    self:initData(bagdata)
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.newCityBagView")
end

function NewCityBagView:initData(data)
    self.selectTab = nil
    self.selectGridView = nil
    self.bagData = data or {}
    self.GridView_items = {}
    self.tabData = {}
end

function NewCityBagView:initUI(ui)
    self.super.initUI(self,ui)

    self.bagItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.Panel_bag = TFDirector:getChildByPath(ui, "Panel_bag")
    self.Label_none = TFDirector:getChildByPath(ui, "Label_none")
    self.Label_none:setTextById(12211)
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self, AlertManager.TWEEN_1)
    end)

    local ScrollView_bag = TFDirector:getChildByPath(ui,"ScrollView_bagInfo")
    for i = bagTab.liwu, bagTab.cailiao do
        local scrollview = ScrollView_bag:clone():show()
        self.Panel_bag:addChild(scrollview)
        self.GridView_items[i] = UIGridView:create(scrollview)
        self.GridView_items[i]:setVisible(false)
        self.GridView_items[i].count = 0
        self.GridView_items[i]:setItemModel(self.bagItem)
        self.GridView_items[i]:setColumn(5)
        self.GridView_items[i]:setColumnMargin(10)
        self.GridView_items[i]:setRowMargin(5)
    end

    self.Button_liwu = TFDirector:getChildByPath(ui, "Button_liwu")
    self.Button_cailiao = TFDirector:getChildByPath(ui, "Button_cailiao")
    self.Button_liwu:onClick(function(sender)
        self:createBagItem(1)
        self:bagTabSwitch(sender, self.GridView_items[bagTab.liwu])

    end)
    self.Button_cailiao:onClick(function(sender)
        self:createBagItem(2)
        self:bagTabSwitch(sender, self.GridView_items[bagTab.cailiao])
    end)

    self:createBagItem(1)
    self:bagTabSwitch(self.Button_liwu, self.GridView_items[bagTab.liwu])
end

function NewCityBagView:bagTabSwitch(tab, gridview)
    if self.selectTab then
        self.selectTab:setTextureNormal("ui/common/edge_normal.png")
        self.selectTab:Touchable(true)
    end
    self.selectTab = tab
    self.selectTab:setTextureNormal("ui/common/edge_select.png")
    self.selectTab:Touchable(false)
    if self.selectGridView then
        self.selectGridView:setVisible(false)
    end
    self.selectGridView = gridview
    self.selectGridView:setVisible(true)
    self.Label_none:setVisible(not (self.selectGridView.count > 0))
end

function NewCityBagView:createBagItem(tab)
    if self.tabData[tab] then
        return
    end
    self.tabData[tab] = true
    local allkeys = table.keys(self.bagData) or {}
    local createItem = function(id, num)
        local bagitem = self.bagItem:clone()
        PrefabDataMgr:setInfo(bagitem, id, num)
        return bagitem
    end

    local gifts = {}
    local materials = {}
    for i, v in ipairs(allkeys) do
        local bagdata = self.bagData[allkeys[i]]
        local cfg = GoodsDataMgr:getItemCfg(bagdata.cid)
        if cfg.superType == EC_ResourceType.GIFT then
            table.insert(gifts,bagdata)
            self.GridView_items[bagTab.liwu].count = self.GridView_items[bagTab.liwu].count + 1
        elseif cfg.superType == EC_ResourceType.MATERIAL then
            table.insert(materials,bagdata)
            self.GridView_items[bagTab.cailiao].count = self.GridView_items[bagTab.cailiao].count + 1
        end
    end

    if tab == 1 then
        self.GridView_items[bagTab.liwu]:AsyncUpdateItem(gifts, function ( ... )
            -- body
        end, function ( bagdata )
            -- body
            local item = createItem(bagdata.id, bagdata.num)
            self.GridView_items[bagTab.liwu]:pushBackCustomItem(item)
            return item
        end)
    else
        self.GridView_items[bagTab.cailiao]:AsyncUpdateItem(materials, function ( ... )
            -- body
        end, function ( bagdata )
            -- body
            local item = createItem(bagdata.id, bagdata.num)
            self.GridView_items[bagTab.cailiao]:pushBackCustomItem(item)
            return item
        end)
    end
end

return NewCityBagView