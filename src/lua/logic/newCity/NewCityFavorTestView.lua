local NewCityFavorTestView = class("NewCityFavorTestView", BaseLayer)

function NewCityFavorTestView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.newCity.newCityFavorTestView")
end

function NewCityFavorTestView:registerEvents()
    EventMgr:addEventListener(self, EV_NEW_CITY.favorDatingTestData, handler(self.showData, self))
end

function NewCityFavorTestView:initData()

end

function NewCityFavorTestView:initUI(ui)
    self.super.initUI(self, ui)

    local TextField_input = TFDirector:getChildByPath(ui, "TextField_input")
    local Button_send = TFDirector:getChildByPath(ui, "Button_send")
    local ScrollView_data = TFDirector:getChildByPath(ui, "ScrollView_data")
    self.ListView_data = UIListView:create(ScrollView_data)
    self.Label_data = TFDirector:getChildByPath(ui, "Label_data")
    
    Button_send:onClick(function()
        local favorid = tonumber(TextField_input:getText())
        if favorid then
            NewCityDataMgr:sendGetFavorTestInfo(favorid)
        end
    end)
end

function NewCityFavorTestView:showData(data)
    self.ListView_data:removeAllItems()
    local quality = data.qualityInfo or {}
    local sign = data.signList or {}
    local items = data.items or {}
    if #quality > 0 then
        local label = self.Label_data:clone():show()
        label:setPosition(me.p(0, 0))
        local str = TextDataMgr:getText(500038) --"属性:\n" 
        for i, v in ipairs(quality) do
            str = str.."id = "..v.qualityId..", value = "..v.value.."\n"
        end
        label:setText(str)
        self.ListView_data:pushBackCustomItem(label)
    end
    if #sign > 0 then
        local label = self.Label_data:clone():show()
        label:setPosition(me.p(0, 0))
        local str = TextDataMgr:getText(500039) --"标记:\n"
        for i, v in ipairs(sign) do
            str = str..v.."\n"
        end
        label:setText(str)
        self.ListView_data:pushBackCustomItem(label)
    end
    if #items > 0 then
        local label = self.Label_data:clone():show()
        label:setPosition(me.p(0, 0))
        local str = TextDataMgr:getText(500040) --"物品:\n"
        for i, v in ipairs(items) do
            str = str.."id = "..v.id..", num = "..v.num.."\n"
        end
        label:setText(str)
        self.ListView_data:pushBackCustomItem(label)
    end
end

return NewCityFavorTestView