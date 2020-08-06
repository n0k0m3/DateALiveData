local NewCityEventSettlementView = class("NewCityEventSettlementView", BaseLayer)

function NewCityEventSettlementView:ctor(data, touchquit)
    self.super.ctor(self)

    self:initData(data, touchquit)
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.newCityEventSettlementView")
end

function NewCityEventSettlementView:initData(data, touchquit)
    self.reward = data
    self.isTouchQuit = touchquit and true
end

function NewCityEventSettlementView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_attItem = Panel_prefab:getChild("Panel_attItem")
    self.Panel_attrs = TFDirector:getChildByPath(self.ui, "Panel_attrs")
    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Label_touch = self.Panel_touch:getChild("Label_touch")
    if self.isTouchQuit then
        self:timeOut(function()
            self.Panel_touch:show()
            self.Panel_touch:Touchable(true)
            self.Panel_touch:onClick(function()
                AlertManager:closeLayer(self)
            end)
            self.Label_touch:setTextById(800018)
        end, 0.8)
    end

    self:initPrefab()
    self:initExpandView()
    self:initRecieveView()

    self:showExpandView()
    self:showRecieveView()
    if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_MainLine then
        self.Panel_attrs:setVisible(true)
        self:showAttrInfoView()
    else
        self.Panel_attrs:setVisible(false)
    end
end

function NewCityEventSettlementView:initExpandView()
    local ScrollView_expand = TFDirector:getChildByPath(self.ui,"ScrollView_expand")
    self.expandListView = UIListView:create(ScrollView_expand)
end

function NewCityEventSettlementView:initRecieveView()
    local ScrollView_recieve = TFDirector:getChildByPath(self.ui,"ScrollView_recieve")
    self.recieveListView = UIListView:create(ScrollView_recieve)
end

function NewCityEventSettlementView:initPrefab()
    local Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab"):hide()
    self.Panel_item = Panel_prefab:getChild("Panel_item")
end


function NewCityEventSettlementView:showExpandView()
    self.expandListView:removeAllItems()
    local itemTab = TabDataMgr:getData("Item")
    local expanddata = self.reward.costItems or {}
    for i, v in ipairs(expanddata) do
        local Panel_item = self.Panel_item:clone():show()
        local expand_item = Panel_item:getChild("Image_item")
        expand_item:setTexture(itemTab[v.id].icon)
        local expand_name = Panel_item:getChild("Label_name")
        expand_name:setTextById(itemTab[v.id].nameTextId)
        local expand_num = Panel_item:getChild("Label_count")
        expand_num:setText(v.num)
        self.expandListView:pushBackCustomItem(Panel_item)
    end
end

function NewCityEventSettlementView:showRecieveView()
    self.recieveListView:removeAllItems()
    local itemTab = TabDataMgr:getData("Item")
    local recievedata = self.reward.items or {}
    for i, v in ipairs(recievedata) do
        local Panel_item = self.Panel_item:clone()
        local recieve_item = Panel_item:getChild("Image_item")
        recieve_item:setTexture(itemTab[v.id].icon)
        local recieve_name = Panel_item:getChild("Label_name")
        recieve_name:setTextById(itemTab[v.id].nameTextId)
        local recieve_num = Panel_item:getChild("Label_count")
        recieve_num:setText(v.num)
        self.recieveListView:pushBackCustomItem(Panel_item)
    end
end

function NewCityEventSettlementView:showAttrInfoView()
    local idList = RoleDataMgr:getDatingVariableToRole(RoleDataMgr:getCurId())
    local attribute = NewCityDataMgr:getMainLineDataQuality()
    local ScrollView_att = self.Panel_attrs:getChild("ScrollView_att")
    if not self.ListView_att then
        self.ListView_att = UIListView:create(ScrollView_att)
    end
    self.ListView_att:setItemsMargin(75)
    self.ListView_att:removeAllItems()
    for k, v in pairs(idList) do
        local attr = attribute[v]
        local variableconf = TabDataMgr:getData("DatingVariable", v)
        local attitem = self.Panel_attItem:clone():show()
        attitem:getChild("Image_attr_icon"):setTexture(variableconf.icon)
        local attrname = attitem:getChild("Label_attr_name")
        local attnum = attitem:getChild("Label_attr")
        local valuemax = math.abs(variableconf.limit[2] - variableconf.limit[1])
        local percent = 0
        local namestr = TextDataMgr:getText(variableconf.name)
        if attr then
            attrname:setText(namestr)
            attnum:setText(tostring(attr.value).."/"..tostring(variableconf.limit[2]))
            percent = me.clampf(attr.value / valuemax, 0, 1)
        else
            attrname:setText(namestr)
            attnum:setText(tostring(variableconf.initialValue).."/"..tostring(variableconf.limit[2]))
            percent = me.clampf(variableconf.initialValue / valuemax, 0, 1)
        end
        local Panel_progress = attitem:getChild("Panel_progress")
        local progressidx = math.floor(percent*100/10)
        for i = 1, 10 do
            local image_progress = Panel_progress:getChild("Image_progress"..i)
            if i <= progressidx then
                image_progress:setTexture("ui/newCity/city_main/jindu"..i..".png")
            else
                image_progress:setTexture("ui/newCity/city_main/jindubg.png")
            end
        end
        self.ListView_att:pushBackCustomItem(attitem)
    end
end

return NewCityEventSettlementView