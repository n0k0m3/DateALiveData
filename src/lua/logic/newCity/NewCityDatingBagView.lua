local NewCityDatingBagView = class("NewCityDatingBagView", BaseLayer)

function NewCityDatingBagView:ctor(bagdata)
    self.super.ctor(self)
    self:initData(bagdata)
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.newCityDatingBagView")
end

function NewCityDatingBagView:initData(data)
    self.bagData = data or {}
end

function NewCityDatingBagView:initUI(ui)
    self.super.initUI(self,ui)

    self.bagItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()

    self.Label_none = TFDirector:getChildByPath(ui, "Label_none")
    self.Label_none:setTextById(12211)
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self, AlertManager.TWEEN_1)
    end)

    local ScrollView_bag = TFDirector:getChildByPath(ui,"ScrollView_bagInfo")
    self.GridView_bag = UIGridView:create(ScrollView_bag)
    self.GridView_bag:setItemModel(self.bagItem)
    self.GridView_bag:setColumn(5)
    self.GridView_bag:setColumnMargin(10)
    self.GridView_bag:setRowMargin(5)

    self:createBagItem()
end

function NewCityDatingBagView:createBagItem()
    local allkeys = table.keys(self.bagData) or {}
    if #allkeys > 0 then
        self.Label_none:hide()
    end
    for i, v in ipairs(allkeys) do
        local bagdata = self.bagData[allkeys[i]]
        local bagitem = self.bagItem:clone()
        PrefabDataMgr:setInfo(bagitem, bagdata.id, bagdata.num)
        self.GridView_bag:pushBackCustomItem(bagitem)
    end
end

return NewCityDatingBagView