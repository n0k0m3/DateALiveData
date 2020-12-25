local ExploreCountryView = class("ExploreCountryView", BaseLayer)


function ExploreCountryView:ctor(jumpCityId)
    self.super.ctor(self)
    self:initData(jumpCityId)
    self:init("lua.uiconfig.explore.exploreCountryView")
end

function ExploreCountryView:initData(jumpCityId)
    self.nationCid = ExploreDataMgr:getCurNation()
    self.cityNodes = {}
    self.nationCfg = ExploreDataMgr:getAfkNationCfg(self.nationCid)
    self.cityIds = self.nationCfg.cityIds
    self.jumpCityId = jumpCityId
end

function ExploreCountryView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Button_back = TFDirector:getChildByPath(self.Panel_root,"Button_back")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root,"Button_help")
    self.Label_countryName = TFDirector:getChildByPath(self.Panel_root,"Label_countryName")
    self.Label_countryName_en = TFDirector:getChildByPath(self.Panel_root,"Label_countryName_en")
    self.Panel_left = TFDirector:getChildByPath(self.Panel_root,"Panel_left")
    self.Panel_map = TFDirector:getChildByPath(self.Panel_left,"Panel_map")

    self.Label_cityName = TFDirector:getChildByPath(self.Panel_root,"Label_cityName")
    local ScrollView_item = TFDirector:getChildByPath(self.Panel_root,"ScrollView_item")
    --self.ListView_item = UIListView:create(ScrollView_item)

    self.TableView_item = Utils:scrollView2TableView(ScrollView_item)
    Public:bindScrollFun(self.TableView_item)
    self.TableView_item:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))


    self.Button_explore = TFDirector:getChildByPath(self.Panel_root,"Button_explore")
    self.Button_check = TFDirector:getChildByPath(self.Panel_root,"Button_check")
    self.Label_city_tip = TFDirector:getChildByPath(self.Panel_root,"Label_city_tip")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_root,"Label_desc")
    self.Label_desc:setDimensions(380, 0)
    self.Image_dot = TFDirector:getChildByPath(self.Panel_root,"Image_dot")
    self.Label_study_tip = TFDirector:getChildByPath(self.Panel_root,"Label_study_tip")


    self.Label_terrain = TFDirector:getChildByPath(self.Panel_root,"Label_terrain")
    self.Image_terrain_icon = TFDirector:getChildByPath(self.Panel_root,"Image_terrain_icon")

    local isWrongMap = false
    local map = createUIByLuaNew("lua.uiconfig.explore."..self.nationCfg.mapLayout)
    for i, v in ipairs(map:getChildren()) do
        local name = v:getName()
        if name ~= "bg"  and name ~= "Panel_effect" then
            local prefix, index = string.match(name, "(.*)_(.*)")
            local Image_normal = TFDirector:getChildByPath(v,"Image_normal")
            local Image_select = TFDirector:getChildByPath(v,"Image_select"):hide()
            local Image_select_small = TFDirector:getChildByPath(v,"Image_select_small"):hide()
            local bar = TFDirector:getChildByPath(v,"bar"):hide()
            local bar_bg = TFDirector:getChildByPath(v,"Image_percent_bg"):hide()
            local Image_event = TFDirector:getChildByPath(v,"Image_event_small"):hide()
            local Label_event_num = TFDirector:getChildByPath(v,"Label_event_num")
            local Panel_event = TFDirector:getChildByPath(v,"Panel_event"):hide()
            local Image_lock = TFDirector:getChildByPath(v,"Image_lock")
            local Image_new = TFDirector:getChildByPath(v,"Image_new"):hide()
            local cityId = self.cityIds[tonumber(index)]
            if not cityId then
                isWrongMap = true
            end
            self.cityNodes[tonumber(index)] = {root = v, select = Image_select,normal = Image_normal,bar = bar,bar_bg = bar_bg,event_num = Label_event_num,
                                               Image_event = Image_event,selectSmall = Image_select_small,cityId = cityId, lock = Image_lock,Image_new = Image_new,isPlayAni = false}
        end
    end

    if isWrongMap then
        Box("cityMap和配置表地图数据不匹配")
    end

    map:setScale(self.nationCfg.scale)
    map:setPosition(ccp(self.nationCfg.offset.x,self.nationCfg.offset.y))
    self.Panel_map:addChild(map)

    self:initUILogic()

end

function ExploreCountryView:initUILogic()

    self.Label_countryName:setTextById(self.nationCfg.name)
    self.Label_countryName_en:setText(self.nationCfg.nameEn)

    self:updateCityInfo()

    self.curCityId = ExploreDataMgr:getCurExploreCity()
    local cityId = self.jumpCityId and self.jumpCityId or self.curCityId
    print(cityId,self.curCityId)
    local index = table.indexOf(self.cityIds,cityId)
    if index == -1 then
        index = 1
    end
    self:chooseCity(index)
end

function ExploreCountryView:updateCityInfo()

    for k,v in ipairs(self.cityNodes) do

        v.bar_bg:hide()
        v.select:hide()
        v.selectSmall:hide()

        local cityData = ExploreDataMgr:getCityEventData(v.cityId)
        if not cityData then
            v.lock:setVisible(true)
            v.Image_event:setVisible(false)
            v.Image_event:stopAllActions()
            v.isPlayAni = false
            v.Image_new:setVisible(false)
        else

            local allCanget = true
            for _,info in ipairs(cityData) do
                if info.state ~= 1 then
                    allCanget = false
                    break
                end
            end

            v.lock:setVisible(false)
            v.Image_event:setVisible(#cityData > 0)
            v.event_num:setText(#cityData)
            local res = allCanget and "ui/explore/nationmap/1.png" or "ui/explore/nationmap/2.png"
            v.Image_event:setTexture(res)
            local color = allCanget and ccc3(40,96,169) or ccc3(220,105,149)
            v.event_num:setColor(color)
            if not v.isPlayAni then
                ViewAnimationHelper.doMoveUpAndDown(v.Image_event,1.2,10)
                v.isPlayAni = true
            end

            ---是否是新城市
            local newCitys = ExploreDataMgr:getNewCity()
            local index = table.indexOf(newCitys,v.cityId)
            v.Image_new:setVisible(index ~= -1)
        end

    end
end

function ExploreCountryView:chooseCity(index)

    for k,v in ipairs(self.cityNodes) do
        v.bar_bg:setVisible(v.cityId == self.curCityId)
        v.select:setVisible(index == k)
        v.selectSmall:setVisible(index == k)
    end

    local cityNode = self.cityNodes[index]
    if not cityNode then
        return
    end


    local isLock = false
    self.selectCityId = cityNode.cityId

    local newCitys = ExploreDataMgr:getNewCity()
    local index = table.indexOf(newCitys,self.selectCityId)
    if index ~= -1 then
        table.remove(newCitys,index)
    end
    cityNode.Image_new:setVisible(false)

    local cityData = ExploreDataMgr:getCityEventData(self.selectCityId)
    if not cityData then
        isLock = true
    end

    local curCityId = ExploreDataMgr:getCurExploreCity()
    self.Button_check:setVisible(curCityId ~= self.selectCityId and not isLock)
    self.Button_explore:setVisible(not isLock)

    local cityCfg = ExploreDataMgr:getAfkCityCfg(self.selectCityId)
    if not cityCfg then
        return
    end

    local techLearned = cityCfg.condition and cityCfg.condition.techLearned
    if techLearned then
        local knowledgeId = 0
        for k,v in pairs(techLearned) do
            knowledgeId = v
            break
        end
        local cfg = ExploreDataMgr:getKnowledgeCfg(knowledgeId)
        if cfg then
            self.Label_study_tip:setTextById(13322010,TextDataMgr:getText(cfg.name))
        end
        self.Image_dot:setVisible(isLock)
    else
        self.Image_dot:hide()
    end

    self.Label_terrain:setText(cityCfg.terrainName)
    self.Image_terrain_icon:setTexture(cityCfg.terrainIcon)
    self.Label_desc:setText(cityCfg.cityDes)
    self.Label_city_tip:setTextById(cityCfg.name)
    self.bonusDropShow = cityCfg.bonusDropShow or {}
    table.sort(self.bonusDropShow,function(a,b)
        local cfgA = GoodsDataMgr:getItemCfg(a)
        local cfgB = GoodsDataMgr:getItemCfg(b)
        if cfgA and cfgB then
            if cfgA.quality == cfgB.quality then
                return a < b
            end
            return cfgA.quality > cfgB.quality
        else
            return false
        end

    end)
    self.TableView_item:reloadData()
    self.TableView_item:scrollToXTop()
end

function ExploreCountryView:cellSizeForTable()
    local size = PrefabDataMgr:getPrefab("Panel_goodsItem"):getSize()
    return size.height*0.8, size.width*0.8
end

function ExploreCountryView:numberOfCellsInTableView()
    return #self.bonusDropShow
end

function ExploreCountryView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        cell.item:setScale(0.8)
        PrefabDataMgr:setInfo(cell.item, self.bonusDropShow[idx])
    end

    return cell
end

function ExploreCountryView:closeDetailsLayer()
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("CountryDetailsView")
    if isLayerInQueue then
        AlertManager:closeLayer(layer)
    end
end

function ExploreCountryView:registerEvents()

    self.Button_back:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_explore:onClick(function()
        self.curCityId = ExploreDataMgr:getCurExploreCity()
        if self.selectCityId == self.curCityId then
            EventMgr:dispatchEvent(EV_EXPLORE_JUMPCITY,0,nil,self.selectCityId)
        else
            ExploreDataMgr:Send_switchNationOrCity(0,self.nationCid,self.selectCityId,EC_AfkActivityID.Main)
        end
        self:closeDetailsLayer()
        AlertManager:closeLayer(self)
    end)

    self.Button_check:onClick(function()
        EventMgr:dispatchEvent(EV_EXPLORE_JUMPCITY,0,nil,self.selectCityId,true)
        self:closeDetailsLayer()
        AlertManager:closeLayer(self)
    end)

    for k,v in ipairs(self.cityNodes) do
        v.normal:onClick(function()
            self:chooseCity(k)
        end)
    end

    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {2464})
    end)
end

return ExploreCountryView
