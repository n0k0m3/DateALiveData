local DatingQualityView = class("DatingQualityView", BaseLayer)

function DatingQualityView:ctor()
    self.super.ctor(self)

    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.dating.datingQualityView")
end

function DatingQualityView:initData()
    self.lastQuality = NewCityDataMgr:getLastMainLineQuality()
end

function DatingQualityView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_attItem = Panel_prefab:getChild("Panel_attItem")
    self.ScrollView_att = TFDirector:getChildByPath(self.ui, "ScrollView_att")
    self.ListView_att = UIListView:create(self.ScrollView_att)
    self.ListView_att:setItemsMargin(5)
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self:showAttrInfoView()
end

function DatingQualityView:showAttrInfoView()
    local idList = RoleDataMgr:getDatingVariableToRole(RoleDataMgr:getCurId())
    local attribute = NewCityDataMgr:getMainLineDataQuality()
    
    self.ListView_att:removeAllItems()
    for k, v in pairs(idList) do
        local attr = attribute[v]
        local variableconf = TabDataMgr:getData("DatingVariable", v)
        local attitem = self.Panel_attItem:clone():show()
        attitem:getChild("Image_attr_icon"):setTexture(variableconf.icon)

        local attrname = attitem:getChild("Label_attr_name")

        local Label_attr_last = attitem:getChild("Label_attr_last")
        local Label_attr_add = attitem:getChild("Label_attr_add")
        local Label_attr_max = attitem:getChild("Label_attr_max")
        Label_attr_max:setText(")/"..tostring(variableconf.limit[2]))

        local valuemax = math.abs(variableconf.limit[2] - variableconf.limit[1])
        local percent = 0
        local namestr = TextDataMgr:getText(variableconf.name)
        if attr then
            local lastInfo = self.lastQuality[v]
            Label_attr_last:setText(tostring(lastInfo.value).."(")
            local addValue = attr.value - lastInfo.value
            local flag = addValue >= 0 and "+" or "-"
            local color = addValue >= 0 and ccc3(98, 255, 120) or ccc3(227, 115, 147)
            Label_attr_add:setText(flag..math.abs(addValue))
            Label_attr_add:setColor(color)
            percent = me.clampf(attr.value / valuemax, 0, 1)
        else
            Label_attr_last:setText(tostring(variableconf.initialValue).."(")
            Label_attr_add:setText("+0")
            Label_attr_add:setColor(ccc3(98, 255, 120))
            percent = me.clampf(variableconf.initialValue / valuemax, 0, 1)
        end
        attrname:setText(namestr)
        Label_attr_add:setPositionX(Label_attr_max:getPositionX() - Label_attr_max:getSize().width)
        Label_attr_last:setPositionX(Label_attr_add:getPositionX() - Label_attr_add:getSize().width)

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

return DatingQualityView