local NewCityPersonalInfoView = class("NewCityPersonalInfoView", BaseLayer)

function NewCityPersonalInfoView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.newCity.personalInfoView")
end

function NewCityPersonalInfoView:initData(data)

end

function NewCityPersonalInfoView:initUI(ui)
    self.super.initUI(self,ui)

    self.bagItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()

    self.Label_tittle = TFDirector:getChildByPath(ui, "Label_tittle")
    self.Label_tip = TFDirector:getChildByPath(ui, "Label_tip")
    local ScrollView_building_info = TFDirector:getChildByPath(ui, "ScrollView_building_info")
    self.Panel_building_level_item = TFDirector:getChildByPath(ui, "Panel_building_level_item")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Panel_attr_info = TFDirector:getChildByPath(ui, "Panel_attr_info")
    self.Image_attr_icon = TFDirector:getChildByPath(ui, "Image_attr_icon")

    self.attr_name = {}
    self.attr_value = {}
    for i=1,5 do
        local labelName = TFDirector:getChildByPath(self.Panel_attr_info, "Label_attr"..i)
        self.attr_name[i] = labelName
        local labelValue = TFDirector:getChildByPath(self.Panel_attr_info, "Label_attr_value"..i)
        self.attr_value[i] = labelValue
    end

    self.ScrollView_building_info = UIGridView:create(ScrollView_building_info)
    self.ScrollView_building_info:setItemModel(self.Panel_building_level_item)
    self.ScrollView_building_info:setColumn(3)
    self.ScrollView_building_info:setColumnMargin(5)
    self.ScrollView_building_info:setRowMargin(10)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self, AlertManager.TWEEN_1)
    end)
    self:refreshView()
end

function NewCityPersonalInfoView:refreshView()
    local buildMap = TabDataMgr:getData("NewBuild")
    local jobBuildingIds = {}
    for k,v in pairs(buildMap) do
        if #v.jobLevels > 0 then
            jobBuildingIds[#jobBuildingIds + 1] = v.id
        end
    end
    table.sort(jobBuildingIds, function(a, b)
        return a < b
    end)

    for i, v in ipairs(jobBuildingIds) do
        local buildingItem = self.Panel_building_level_item:clone()
        self:updateBuildingItem(buildingItem, v)
        self.ScrollView_building_info:pushBackCustomItem(buildingItem)
    end

    local attrs = {EC_SItemType.MEILI, EC_SItemType.ZHISHI, EC_SItemType.XINGYUN, EC_SItemType.WENROU, EC_SItemType.ZHUANZHU}
    local maxValue = 0
    local valueArray = {0,0,0,0,0}
    for i,v in ipairs(attrs) do
        local itemCfg = GoodsDataMgr:getItemCfg(v) or nil
        local count = GoodsDataMgr:getItemCount(v) or 0
        if itemCfg then
            self.attr_name[i]:setTextById(itemCfg.nameTextId)
        end
        self.attr_value[i]:setText(tostring(count))
        maxValue = math.max(maxValue, itemCfg.totalMax)
        valueArray[i] = count
    end

    self:drawAttrPolygon(maxValue, valueArray)
end

function NewCityPersonalInfoView:drawAttrPolygon(maxValue, valueArray)
    self.Image_attr_icon:removeAllChildren()
    local PI = 3.1415926
    local polygonMax = 70.5
    local solidMax = 70
    local percents = {0, 0, 0, 0, 0}
    local baseMax = maxValue
    local baseValue = baseMax / 5
    for i,v in ipairs(valueArray) do
        percents[i] = math.min(1, (v + baseValue) / baseMax)
    end
    local points = {
    ccp(0, polygonMax * percents[1]),
    ccp(-polygonMax * math.cos(1 / 10 * PI) * percents[2], polygonMax * math.sin(1 / 10 * PI) * percents[2]),
    ccp(-polygonMax * math.sin(1 / 5 * PI) * percents[3], -polygonMax * math.cos(1 / 5 * PI) * percents[3]),
    ccp(polygonMax * math.sin(1 / 5 * PI) * percents[4], -polygonMax * math.cos(1 / 5 * PI) * percents[4]), 
    ccp(polygonMax * math.cos(1 / 10 * PI) * percents[5], polygonMax * math.sin(1 / 10 * PI) * percents[5]),
    }
    local pointsSolid = {
    ccp(0, solidMax * percents[1]),
    ccp(-solidMax * math.cos(1 / 10 * PI) * percents[2], solidMax * math.sin(1 / 10 * PI) * percents[2]),
    ccp(-solidMax * math.sin(1 / 5 * PI) * percents[3], -solidMax * math.cos(1 / 5 * PI) * percents[3]),
    ccp(solidMax * math.sin(1 / 5 * PI) * percents[4], -solidMax * math.cos(1 / 5 * PI) * percents[4]), 
    ccp(solidMax * math.cos(1 / 10 * PI) * percents[5], solidMax * math.sin(1 / 10 * PI) * percents[5]),
    }
    
    local attrNodeSide = TFDrawNode:create()
    self.Image_attr_icon:addChild(attrNodeSide, 100)
    attrNodeSide:drawPoly(points, true, ccc4(1, 1, 1, 0.5))
    attrNodeSide:setPosition(ccp(0, -6))

    local attrNode = TFDrawNode:create()
    self.Image_attr_icon:addChild(attrNode, 100)
    attrNode:drawSolidPoly(pointsSolid, ccc4(227 / 255, 115 / 255, 147 / 255, 1))
    attrNode:setPosition(ccp(0, -6))
end

local work_icon = {
["102"] = "ui/newCity/city/6.png", 
["103"] = "ui/newCity/city/7.png", 
["104"] = "ui/newCity/city/8.png", 
["105"] = "ui/newCity/city/4.png", 
["106"] = "ui/newCity/city/3.png", 
["107"] = "ui/newCity/city/5.png"
}
function NewCityPersonalInfoView:updateBuildingItem(item, buildingId)
    local info = CityJobDataMgr:getJobInfoListByBuildingId(buildingId)
    local buildingCfg = TabDataMgr:getData("NewBuild", buildingId)
    local Image_bg1 = TFDirector:getChildByPath(item, "Image_bg1")
    local Image_building_icon = TFDirector:getChildByPath(item, "Image_building_icon")
    local LoadingBar_exp = TFDirector:getChildByPath(item, "LoadingBar_exp")
    local Label_level = TFDirector:getChildByPath(item, "Label_level")
    local Label_building_name = TFDirector:getChildByPath(item, "Label_building_name")
    if info then
        local isReachMax = info.level > #buildingCfg.jobLevels
        if isReachMax then
            Image_bg1:setTexture("ui/newCity/city/9.png")
            LoadingBar_exp:setTexture("ui/newCity/city/1.png")
            Label_level:setText("MAX")
            Label_level:setColor(ccc3(248, 212, 152))
            Label_building_name:setColor(ccc3(248, 212, 152))
        else
            Image_bg1:setTexture("ui/newCity/city/13.png")
            LoadingBar_exp:setTexture("ui/newCity/city/12.png")
            Label_level:setText("Lv."..info.level)
            Label_level:setColor(ccc3(255, 255, 255))
            Label_building_name:setColor(ccc3(162, 164, 200))
        end
        local level = math.min(info.level, #buildingCfg.jobLevels)
        local percent = info.exp / buildingCfg.jobLevels[level] * 100
        LoadingBar_exp:setPercent(percent)
    else
        Image_bg1:setTexture("ui/newCity/city/13.png")
        LoadingBar_exp:setTexture("ui/newCity/city/12.png")
        Label_level:setText("Lv.1")
        Label_level:setColor(ccc3(255, 255, 255))
        Label_building_name:setColor(ccc3(162, 164, 200))
        LoadingBar_exp:setPercent(0)
    end
    Label_building_name:setTextById(buildingCfg.nameId)
    Image_building_icon:setTexture(work_icon[tostring(buildingId)])
end

return NewCityPersonalInfoView