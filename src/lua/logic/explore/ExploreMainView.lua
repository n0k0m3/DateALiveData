local ExploreMainView = class("ExploreMainView", BaseLayer)


function ExploreMainView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.explore.exploreMainView")
end

function ExploreMainView:initData()
    self.enterBattle = false
    self.effectNode = {}
    self.worldMapItem_ = {}
    self.attrData_ = {}

    self.attributeCfgs = {}
    local shipAttribute = TabDataMgr:getData("ShipAttribute")
    for k,v in pairs(shipAttribute) do
        self.attributeCfgs[v.attributeId] = v
    end
end

function ExploreMainView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Button_exit = TFDirector:getChildByPath(self.Panel_root,"Button_exit"):hide()
    self.Button_help = TFDirector:getChildByPath(self.Panel_root,"Button_help"):hide()
    self.Button_ship = TFDirector:getChildByPath(self.Panel_root,"Button_ship"):hide()

    self.Panel_guide = TFDirector:getChildByPath(self.Panel_root,"Panel_guide")

    self.Button_map = TFDirector:getChildByPath(self.Panel_root,"Button_map"):hide()
    self.Image_map_red_tip = TFDirector:getChildByPath(self.Button_map,"Image_map_red_tip"):hide()
    self.Button_detail = TFDirector:getChildByPath(self.Panel_root,"Button_detail"):hide()
    self.Image_detail_red_tip = TFDirector:getChildByPath(self.Button_detail,"Image_detail_red_tip"):hide()

    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.Panel_nationItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_nationItem")
    self.Image_event = TFDirector:getChildByPath(self.Panel_prefab,"Image_event")

    ---屏幕
    self.Panel_screen = TFDirector:getChildByPath(self.Panel_root,"Panel_screen")
    self.Panel_screen:setClippingEnabled(true)
    self.Spine_screen = TFDirector:getChildByPath(self.Panel_root,"Spine_screen")

    ---信息
    self.Panel_Info_bg = TFDirector:getChildByPath(self.Panel_root,"Panel_Info_bg")
    self.Panel_Info = TFDirector:getChildByPath(self.Panel_root,"Panel_Info"):hide()
    self.Label_nationName = TFDirector:getChildByPath(self.Panel_Info,"Label_nationName")
    self.Label_nation_des = TFDirector:getChildByPath(self.Panel_Info,"Label_nation_des")
    self.Label_lock = TFDirector:getChildByPath(self.Panel_Info,"Label_lock")
    self.Image_info_icon = TFDirector:getChildByPath(self.Panel_Info,"Image_info_icon")
    self.Image_lock = TFDirector:getChildByPath(self.Panel_Info,"Image_lock")
    self.Spine_huapingmu = TFDirector:getChildByPath(self.Panel_root,"Spine_huapingmu")
    self.Image_info_bg = TFDirector:getChildByPath(self.Panel_Info_bg,"Image_info_bg")

    ---城市
    self.Panel_cityZone = TFDirector:getChildByPath(self.Panel_root,"Panel_cityZone"):hide()
    self.Button_random = TFDirector:getChildByPath(self.Panel_cityZone,"Button_random")
    self.Label_cityName = TFDirector:getChildByPath(self.Panel_cityZone,"Label_cityName")
    self.Label_cityname_en = TFDirector:getChildByPath(self.Panel_cityZone,"Label_cityname_en")
    self.Image_terrain_bg = TFDirector:getChildByPath(self.Panel_cityZone,"Image_terrain_bg")
    self.Label_terrain = TFDirector:getChildByPath(self.Panel_cityZone,"Label_terrain")
    self.Image_terrain_icon = TFDirector:getChildByPath(self.Panel_cityZone,"Image_terrain_icon")
    self.Image_terrain_tip_bg = TFDirector:getChildByPath(self.Panel_cityZone,"Image_terrain_tip_bg"):hide()
    self.Label_terrain_name = TFDirector:getChildByPath(self.Image_terrain_tip_bg,"Label_terrain_name")
    self.Label_terrain_effect = TFDirector:getChildByPath(self.Image_terrain_tip_bg,"Label_terrain_effect")
    self.Panel_close_terrain_bg = TFDirector:getChildByPath(self.Panel_cityZone,"Panel_close_terrain_bg")
    self.Panel_close_terrain_bg:setSwallowTouch(false)

    self.Button_back = TFDirector:getChildByPath(self.Panel_cityZone,"Button_back")
    self.Panel_Box = TFDirector:getChildByPath(self.Panel_cityZone,"Panel_Box")
    self.Image_full = TFDirector:getChildByPath(self.Panel_cityZone,"Image_full")
    self.Spine_box = TFDirector:getChildByPath(self.Panel_cityZone,"Spine_box")
    self.Button_quick = TFDirector:getChildByPath(self.Panel_cityZone,"Button_quick")
    self.ScrollView_cityZone = TFDirector:getChildByPath(self.Panel_root,"ScrollView_cityZone")

    local  ScrollView_terrain = TFDirector:getChildByPath(self.Panel_root,"ScrollView_terrain")
    self.UIListView_terrain = UIListView:create(ScrollView_terrain)
    self.Spine_change = TFDirector:getChildByPath(self.Panel_root,"Spine_change")

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root,"Panel_touch"):hide()
    self.Panel_touch:setContentSize(GameConfig.WS)

    ---自由掉落弹窗
    self.Panel_randomDrop = TFDirector:getChildByPath(self.Panel_root,"Panel_randomDrop"):hide()
    self.Panel_randomDrop:setContentSize(GameConfig.WS)
    self.Button_closeDropPL = TFDirector:getChildByPath(self.Panel_randomDrop,"Button_closeDropPL")
    local ScrollView_drop = TFDirector:getChildByPath(self.Panel_randomDrop,"ScrollView_drop")
    --self.ListView_drop = UIListView:create(ScrollView_drop)
    self.TableView_item = Utils:scrollView2TableView(ScrollView_drop)
    Public:bindScrollFun(self.TableView_item)
    self.TableView_item:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_item:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    ---开场进度
    self.Panel_start = TFDirector:getChildByPath(self.Panel_root,"Panel_start"):hide()
    self.LoadingBar_start = TFDirector:getChildByPath(self.Panel_start,"LoadingBar_start")

    self.Panel_explore = TFDirector:getChildByPath(self.Panel_root,"Panel_explore"):hide()
    self.Panel_guaji = TFDirector:getChildByPath(self.Panel_root,"Panel_guaji"):hide()
    self.Panel_exploreMask = TFDirector:getChildByPath(self.Panel_root,"Panel_exploreMask"):hide()

    ----国家信息
    self.Panel_worldMap = TFDirector:getChildByPath(self.Panel_root,"Panel_worldMap"):hide()
    self.Button_enter = TFDirector:getChildByPath(self.Panel_worldMap,"Button_enter")
    self.Label_country = TFDirector:getChildByPath(self.Panel_worldMap,"Label_country")
    self.Label_worldMap = TFDirector:getChildByPath(self.Panel_worldMap,"Label_worldMap")
    self.Label_worldMap:setTextById(13322019)
    self.Panel_worldMap:setOpacity(0)
    local ScrollView_worldMap = TFDirector:getChildByPath(self.Panel_worldMap,"ScrollView_worldMap")
    self.TurnView_worldMap = UITurnView:create(ScrollView_worldMap)
    self.TurnView_worldMap:setItemModel(self.Panel_nationItem)

    ----属性
    self.Panel_attr = TFDirector:getChildByPath(self.Panel_root,"Panel_attr"):hide()
    self.Label_attr_title1 = TFDirector:getChildByPath(self.Panel_attr,"Label_attr_title1")
    self.Label_attr_title2 = TFDirector:getChildByPath(self.Panel_attr,"Label_attr_title2")
    self.Label_attr_title2:setSkewX(12)
    self.Label_attr_title_en = TFDirector:getChildByPath(self.Panel_attr,"Label_attr_title_en")
    self.Label_power = TFDirector:getChildByPath(self.Panel_attr,"Label_power")
    self.Label_power:setSkewX(15)
    self.Button_attr = TFDirector:getChildByPath(self.Panel_attr,"Button_attr")
    self.Spine_attr_ship = TFDirector:getChildByPath(self.Panel_attr,"Spine_attr_ship")

    self.Panel_speed_item = TFDirector:getChildByPath(self.Panel_attr,"Panel_speed_item")
    self.Panel_capacity_item = TFDirector:getChildByPath(self.Panel_attr,"Panel_capacity_item")
    self.Spine_attr_change = TFDirector:getChildByPath(self.Panel_attr,"Spine_attr_change")

    self.Panel_closeAttrTip = TFDirector:getChildByPath(self.Panel_attr,"Panel_closeAttrTip")
    self.Panel_closeAttrTip:setSwallowTouch(false)
    self.tip_bg = TFDirector:getChildByPath(self.Panel_attr,"tip_bg"):hide()
    self.Label_equip_des = TFDirector:getChildByPath(self.Panel_attr,"Label_equip_des")
    self.Label_equip_des:setDimensions(236,0)

    local ScrollView_attr = TFDirector:getChildByPath(self.Panel_attr,"ScrollView_attr")
    self.TableView_attr = Utils:scrollView2TableView(ScrollView_attr)
    Public:bindScrollFun(self.TableView_item)
    --self.TableView_attr:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.TableView_attr:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForAttrTable, self))
    self.TableView_attr:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndexAttr, self))
    self.TableView_attr:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInAttrTableView, self))
    self.Panel_attr_item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_attr_item")
    local ScrollView_equip = TFDirector:getChildByPath(self.Panel_attr,"ScrollView_equip")
    self.UIListView_equip = UIListView:create(ScrollView_equip)
    self.Panel_euiqp_item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_euiqp_item")
    self.Button_change = TFDirector:getChildByPath(self.Panel_attr,"Button_change")
    self.Label_system_name = TFDirector:getChildByPath(self.Panel_attr,"Label_system_name")

	
	
    self:initBattleView()
    self:initWorldMap()

    ExploreDataMgr:Send_GetExploreInfo(EC_AfkActivityID.Main)
end

function ExploreMainView:cellSizeForAttrTable()
    local size = self.Panel_attr_item:getSize()
    return size.height, size.width
end

function ExploreMainView:numberOfCellsInAttrTableView()
    return #self.attrData_
end

function ExploreMainView:tableCellAtIndexAttr(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_attr_item:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateAttrItem(cell.item, self.attrData_[idx])
    end

    return cell
end

function ExploreMainView:updateAttrItem(item,attrData)

    local attConfig = self.attributeCfgs[attrData.attrId]
    local Label_attr_name = TFDirector:getChildByPath(item, "Label_attr_name")
    local Label_attr_value = TFDirector:getChildByPath(item, "Label_attr_value")
    local Label_attr_add = TFDirector:getChildByPath(item, "Label_attr_add")
    local Image_attr_icon = TFDirector:getChildByPath(item, "Image_attr_icon")

    Label_attr_add:setVisible(attrData.attrType == 1)

    local attValue = attrData.baseValue / attConfig.division
    attValue = string.format("%."..attConfig.decimal.."f",attValue)
    attValue = string.format(attConfig.displayFormat,attValue)
    Label_attr_name:setTextById(tonumber(attConfig.name))
    Label_attr_value:setText(attValue)

    local addValue = attrData.addValue or 0
    if addValue ~= 0 then
        addValue = addValue / attConfig.division
        addValue = string.format("%."..attConfig.decimal.."f",addValue)
        addValue = string.format(attConfig.displayFormat,addValue)
        Label_attr_add:setText("+"..addValue)
    else
        Label_attr_add:setText("")
    end


    Image_attr_icon:setTexture(attConfig.icon)
end


function ExploreMainView:cellSizeForTable()
    local size = PrefabDataMgr:getPrefab("Panel_goodsItem"):getSize()
    return size.height, size.width
end

function ExploreMainView:numberOfCellsInTableView()
    return #self.bonusDropShow
end

function ExploreMainView:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        PrefabDataMgr:setInfo(cell.item, {self.bonusDropShow[idx].itemID}, self.bonusDropShow[idx].DropType)
    end

    return cell
end

function ExploreMainView:initWorldMap()

    self.TurnView_worldMap:removeAllItems()
    self.afkNationList = ExploreDataMgr:getAfkNationList(EC_AfkActivityID.Main)
    table.sort(self.afkNationList, function(a,b)
        local nationCfgA = ExploreDataMgr:getAfkNationCfg(a)
        local nationCfgB = ExploreDataMgr:getAfkNationCfg(b)
        return nationCfgA.displayOrder < nationCfgB.displayOrder
    end)
    for k,v in ipairs(self.afkNationList) do
        local nationCfg = ExploreDataMgr:getAfkNationCfg(v)
        if nationCfg then
            local nationItem = self.TurnView_worldMap:pushBackItem()
            nationItem:setName("nationItem"..k)
            self:addWorldMapItem(k,nationItem,nationCfg)
            --self:updateWoldMapItem(k,nationItem,nationCfg)
        end
    end
end

function ExploreMainView:addWorldMapItem(k,item,nationCfg)

    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    Image_icon:stopAllActions()
    ViewAnimationHelper.doMoveUpAndDown(Image_icon,2,5)
    local Panel_Spine = TFDirector:getChildByPath(item,"Panel_Spine")
    local spine = Panel_Spine:getChildByName("spine")
    if not spine then
        spine = SkeletonAnimation:create("effect/afk_kaijiqidong/afk_kaijiqidong")
        spine:play("animation1", true)
        spine:setName("spine")
        Panel_Spine:addChild(spine)
    end

    local icon_b = TFDirector:getChildByPath(item,"icon_b")
    local icon = TFDirector:getChildByPath(item,"icon")
    icon_b:setTexture("icon/explore/nation/select/"..nationCfg.nationIcon)
    icon:setTexture("icon/explore/nation/normal/"..nationCfg.nationIcon)

    local Image_cur = TFDirector:getChildByPath(item,"Image_cur")
    local Image_cur_b = TFDirector:getChildByPath(item,"Image_cur_b")

    local Label_name_s = TFDirector:getChildByPath(item,"Label_name_s")
    local Label_name_b = TFDirector:getChildByPath(item,"Label_name_b")


    local Label_percent_s = TFDirector:getChildByPath(item,"Label_percent_s")
    local Label_percent_b = TFDirector:getChildByPath(item,"Label_percent_b")

    local Image_lock_b = TFDirector:getChildByPath(item,"Image_lock_b")
    local Image_lock = TFDirector:getChildByPath(item,"Image_lock")

    local new_b = TFDirector:getChildByPath(item,"new_b"):hide()
    local new_s = TFDirector:getChildByPath(item,"new_s"):hide()

    self.worldMapItem_[k] = {root = item,Image_cur = Image_cur, Image_cur_b = Image_cur_b,
                             Label_name_s = Label_name_s,Label_name_b = Label_name_b,
                             Label_percent_s = Label_percent_s,Label_percent_b = Label_percent_b,
                             Image_lock_b = Image_lock_b,Image_lock = Image_lock,new_b = new_b,new_s = new_s}
end

function ExploreMainView:initBattleView()
    local function battleState(state)
        self:updateBattleState(state)
    end
    local function clickShipCallBack()
        --self:showAttrPanel()
    end
    local battleView = requireNew("lua.logic.explore.ExploreBattleView"):new(battleState,clickShipCallBack)
    self.Panel_explore:addChild(battleView)
    self.battleView = battleView
end

function ExploreMainView:loadMap()

    self.nodeSelect = nil
    self.cityNodes = {}

    self.nationCfg = ExploreDataMgr:getAfkNationCfg(self.curNationId)
    self.cityIds = self.nationCfg.cityIds

    local isWrongMap = false

    self.ScrollView_cityZone:removeAllChildren()
    local map = createUIByLuaNew("lua.uiconfig.explore."..self.nationCfg.mapLayout)
    for i, v in ipairs(map:getChildren()) do

        local name = v:getName()
        if name ~= "bg" and name ~= "Panel_effect" then
            local prefix, index = string.match(name, "(.*)_(.*)")
            local Image_normal = TFDirector:getChildByPath(v,"Image_normal")
            local Image_select = TFDirector:getChildByPath(v,"Image_select"):hide()
            local Image_select_small = TFDirector:getChildByPath(v,"Image_select_small"):hide()
            local bar = TFDirector:getChildByPath(v,"bar")
            bar:setPercent(0)
            local bar_bg = TFDirector:getChildByPath(v,"Image_percent_bg"):hide()
            local _texture = ExploreDataMgr:getShipCfg().icon2
            if _texture then
                bar_bg:setTexture(_texture)
            end
            local Image_event_small = TFDirector:getChildByPath(v,"Image_event_small"):hide()
            local Panel_event = TFDirector:getChildByPath(v,"Panel_event"):hide()
            local Image_lock = TFDirector:getChildByPath(v,"Image_lock"):hide()
            Image_normal:setTouchEnabled(false)
            local Image_new = TFDirector:getChildByPath(v,"Image_new"):hide()
            ----事件点位
            local eventNode = {}
            for k, node in ipairs(Panel_event:getChildren()) do
                --node:setVisible(false)
                node:setScale(0)
                table.insert(eventNode,{node = node, id = 0, isPlay = false})
            end

            local cityId = self.cityIds[tonumber(index)]
            if not cityId then
                isWrongMap = true
            end
            bar_bg:setTouchEnabled(true)
            bar_bg:onClick(function()
                self:showAttrPanel()
            end)

            ViewAnimationHelper.doMoveUpAndDown(bar_bg,1.2,8)

            self.cityNodes[tonumber(index)] = {root = v, select = Image_select,normal = Image_normal,bar = bar,bar_bg = bar_bg,lock = Image_lock,
                                               eventNode = eventNode,Image_event = Image_event_small,Panel_event = Panel_event,Image_new = Image_new,cityId = cityId}
        end

        if name == "Panel_effect" then
            self.Panel_effect = v
            self.effectNode = {}
        end
    end

    if isWrongMap then
        Box("cityMap和配置表地图数据不匹配")
    end

    self.ScrollView_cityZone:addChild(map)
    self.ScrollView_cityZone:setInnerContainerSize(CCSizeMake(map:getSize()))
    self.ScrollView_cityZone:setInertiaScrollEnabled(false)
end

function ExploreMainView:updateWorldMap()
    for k,v in ipairs(self.afkNationList) do
        local nationCfg = ExploreDataMgr:getAfkNationCfg(v)
        if nationCfg then
            self:updateWoldMapItem(k,nationCfg)
        end
    end
    local index = table.indexOf(self.afkNationList,self.curNationId)
    if index ~= -1 then
        self.TurnView_worldMap:scrollToItem(index)
    end
end

function ExploreMainView:updateWoldMapItem(k,nationCfg)

    if not self.worldMapItem_[k] then
        return
    end

    local curNationCid = ExploreDataMgr:getCurNation()
    self.worldMapItem_[k].Image_cur:setVisible(nationCfg.id == curNationCid)
    self.worldMapItem_[k].Image_cur_b:setVisible(nationCfg.id == curNationCid)

    self.worldMapItem_[k].Label_name_s:setTextById(nationCfg.name)
    self.worldMapItem_[k].Label_name_b:setTextById(nationCfg.name)


    local countCfg = ExploreDataMgr:getAfkCountCfg(nationCfg.id)
    if countCfg then
        local finishCount,totalCount = 0,0
        for itemType,data in ipairs(countCfg) do
            for k,v in ipairs(data) do
                local isFinish = ExploreDataMgr:isFinishExploreCount(nationCfg.id,v)
                if isFinish == 1 then
                    finishCount = finishCount + 1
                end
            end
            totalCount = totalCount + #data
        end
        local percent = finishCount/totalCount * 100
        percent = math.min(percent,100)
        percent = string.format("%.2f",percent)
        self.worldMapItem_[k].Label_percent_s:setText(percent .. "%")
        self.worldMapItem_[k].Label_percent_b:setText(percent .. "%")
    end

    local isUnLock = ExploreDataMgr:isopenNation(nationCfg.id)
    self.worldMapItem_[k].Image_lock_b:setVisible(not isUnLock)
    self.worldMapItem_[k].Image_lock:setVisible(not isUnLock)

    self.worldMapItem_[k].Label_percent_s:setVisible(isUnLock)
    self.worldMapItem_[k].Label_percent_b:setVisible(isUnLock)

    local newNations = ExploreDataMgr:getNewNation()
    local index = table.indexOf(newNations,nationCfg.id)
    self.worldMapItem_[k].new_b:setVisible(index ~= -1)
    self.worldMapItem_[k].new_s:setVisible(index ~= -1)

end

function ExploreMainView:updateSelectNationInfo(nationIndex)

    local nationCid = self.afkNationList[nationIndex]
    if not nationCid then
        return
    end
    self.selectNationId = nationCid
    local afkNationCfg = ExploreDataMgr:getAfkNationCfg(self.selectNationId)
    if not afkNationCfg then
        return
    end
    self.Label_country:setTextById(afkNationCfg.name)
    self.Label_nationName:setTextById(afkNationCfg.name)
    self.Label_nation_des:setTextById(afkNationCfg.describe)
    self.Label_lock:setTextById(afkNationCfg.unlockDes)
    self.Image_info_icon:setTexture(afkNationCfg.nationBG)


    local unlock = ExploreDataMgr:isopenNation(self.selectNationId)
    if unlock then
        local countCfg = ExploreDataMgr:getAfkCountCfg(self.selectNationId)
        local finishCount,totalCount = 0,0
        for itemType,data in ipairs(countCfg) do
            for k,v in ipairs(data) do
                local isFinish = ExploreDataMgr:isFinishExploreCount(self.selectNationId,v)
                if isFinish == 1 then
                    finishCount = finishCount + 1
                end
            end
            totalCount = totalCount + #data
        end
        local percent = finishCount/totalCount * 100
        percent = math.min(percent,100)
        percent = string.format("%.2f",percent)
        self.Label_lock:setTextById(13322002,percent)
    end
end

function ExploreMainView:startShip()

    self.isFirstPlay = ExploreDataMgr:isFirstPlay()
    self.Panel_start:setVisible(self.isFirstPlay)
    self.percent = 0
    if self.isFirstPlay then
        local act = CCSequence:create({
            CCCallFunc:create(function()
                self.percent = self.percent + 1
                self.LoadingBar_start:setPercent(self.percent)
                if self.percent >= 100 then
                    self:showScreenAnim()
                    self.Panel_start:stopAllActions()
                end
            end),
            CCDelayTime:create(0.02)
        })
        self.Panel_start:runAction(CCRepeatForever:create(act))
    else
        self:startExplore()
    end
end

function ExploreMainView:onShow()
    self.super.onShow(self)
    
    if Utils:getLocalSettingValue("flyshipDating") == "" then
        FunctionDataMgr:jStartDating(649)
        Utils:setLocalSettingValue("flyshipDating","true")
        return
    end
    local step,groupId = GuideDataMgr:getCurStepInfo()
    if groupId == 29 and step > 604 then
        GameGuide:checkGuide(self)
    end

    if self.curNationId and self.curCityId then
        ExploreDataMgr:Send_GetShipAttrsInfo(EC_AfkActivityID.Main,self.curNationId,self.curCityId)
    end
end

function ExploreMainView:startExplore()

    GameGuide:checkGuide(self)


    self.Button_exit:show()
    self.Button_help:show()
    self.Button_ship:show()

    self.Spine_screen:play("animation2",true)
    self.Panel_start:hide()
    if self.isFirstPlay then
        self.Panel_worldMap:runAction(CCFadeIn:create(0.3))
    else
        self.Panel_worldMap:setOpacity(255)
    end

    self.Panel_guaji:show()
    local step,groupId = GuideDataMgr:getCurStepInfo()
    local isExploring = not (self.isFirstPlay or self.curCityId == 0 or (groupId == 29 and step >= 601))
    self:updateScreenInfo(isExploring)
    self:locateCurExploreCity()
end

function ExploreMainView:updateScreenInfo(isExploring,infoAct)

    Utils:playSound(5053)
    self.Spine_huapingmu:play("animation",false)
    if infoAct then
        --self.Spine_huapingmu:addMEListener(TFARMATURE_COMPLETE,function()
        --    self.Spine_huapingmu:removeMEListener(TFARMATURE_COMPLETE)
        --end)
    end

    self.Panel_Info:setVisible(not isExploring)
    self.Image_info_bg:setVisible(not isExploring)

    self.Button_enter:setVisible(not isExploring)
    self.Button_back:setVisible(isExploring)

    self.Panel_cityZone:setVisible(isExploring)
    self.Panel_worldMap:setVisible(not isExploring)
    self.Panel_explore:setVisible(isExploring)

    self.Button_map:setVisible(isExploring)
    self.Button_detail:setVisible(isExploring)
end

function ExploreMainView:showScreenAnim()

    self.Spine_screen:play("animation",false)
    self.Spine_screen:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_screen:removeMEListener(TFARMATURE_COMPLETE)
        self:timeOut(function()
            self:startExplore()
        end)
    end)
end

function ExploreMainView:showRandomDropAward()

    self.bonusDropShow = {}
    local cityCfg = ExploreDataMgr:getAfkCityCfg(self.curCityId)
    if not cityCfg then
        return
    end

	local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.TREASUREHUNTING) or {}
	if #activityIds > 0 then
		local activityId = activityIds[1]
		local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
		local isHide = activityInfo.extendData.isHide
		if activityInfo and tonumber(activityInfo.extendData.isHide) ~= 1 then
			local dropItems = {}
			for i = 1, #activityInfo.items do
				local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, activityInfo.items[i])
				local extendData = itemInfo.extendData or {}
				local activityProfit = extendData.activityProfit or {}
				local roll = activityProfit.roll or {}
				local items = roll.items or {}
				for j = 1, #items do 
					table.insert(self.bonusDropShow, {DropType = EC_DropShowType.ACTIVITY_EXTRA, itemID = items[i].id})
				end
			end
		end
	end
	
	if cityCfg then
		cityCfg.bonusDropShow = cityCfg.bonusDropShow or {}

		for i = 1, #cityCfg.bonusDropShow do
			table.insert(self.bonusDropShow, {DropType = 0,  itemID = cityCfg.bonusDropShow[i]})
		end
	end

	if #self.bonusDropShow == 0 then
		return
	end

    table.sort(self.bonusDropShow,function(a,b)
        local cfgA = GoodsDataMgr:getItemCfg(a.itemID)
        local cfgB = GoodsDataMgr:getItemCfg(b.itemID)
        if cfgA and cfgB then
            if cfgA.quality == cfgB.quality then
                return a.itemID < b.itemID
            end
            return cfgA.quality > cfgB.quality
        else
            return false
        end

    end)

    self.TableView_item:reloadData()
    self.TableView_item:scrollToXTop()
end

function ExploreMainView:locateCurExploreCity()

    local cityIndex = 1
    for k,v in ipairs(self.cityNodes) do
        if v.cityId == self.curCityId then
            cityIndex = k
        end
    end
    self:jumpToCity(cityIndex)
end

function ExploreMainView:jumpToCity(index, isDelay)

    if not self.cityNodes[index] then
        return
    end
    local cityNode = self.cityNodes[index].root
    local select = self.cityNodes[index].select

    for k,v in ipairs(self.cityNodes) do
        self.cityNodes[k].Panel_event:setVisible(index == k)
        self.cityNodes[k].bar_bg:setVisible(index == k and self.cityNodes[k].cityId == self.curCityId)
    end

    if self.nodeSelect then
        self.nodeSelect:hide()
    end
    self.nodeSelect = select
    self.nodeSelect:show()

    local position = cityNode:Pos()
    local innerContainer = self.ScrollView_cityZone:getInnerContainer()
    innerContainer:stopAllActions()
    local innerSize = innerContainer:getSize()
    local offset = self.ScrollView_cityZone:getContentOffset()
    local posX = -(position.x - 820 / 2)
    local posY = -(position.y - 360 / 2)
    local maxX = 0
    local maxY = 0
    local minX = 820 - innerSize.width
    local minY = 360 - innerSize.height
    posX = posX > maxX and maxX or posX
    posX = posX < minX and minX or posX
    posY = posY > maxY and maxY or posY
    posY = posY < minY and minY or posY
    local distancX = math.abs(posX - offset.x)
    local distancY = math.abs(posY - offset.y)
    local distance = math.max(distancX, distancY)
    local time = isDelay and distance / 1000 or 0

    if isDelay then
        self.Spine_change:play("animation",false)
    end
    self.ScrollView_cityZone:setContentOffset(ccp(posX,posY), time)

    self:updateSelectCityInfo(index)

end

function ExploreMainView:updateSelectCityInfo(index)

    if not self.cityNodes[index] then
        return
    end

    local node = self.cityNodes[index]
    self.selectCityId = node.cityId

    ---只有所处的城市才显示进度和事件
    self.Panel_exploreMask:setVisible(self.selectCityId ~= self.curCityId)

    ---开是探索
    self:startExploreDot()
    
    local afkCityCfg = ExploreDataMgr:getAfkCityCfg(self.selectCityId)
    if not afkCityCfg then
        return
    end

    self.Label_cityName:setTextById(afkCityCfg.name)

    self.Label_terrain:setText(afkCityCfg.terrainName)
    self.Label_terrain_name:setText(afkCityCfg.terrainName)
    self.Label_terrain_effect:setText("")
    self.Image_terrain_icon:setTexture(afkCityCfg.terrainIcon)

    self.UIListView_terrain:removeAllItems()
    local Label_content = self.Label_terrain_effect:clone():Show()
    Label_content:setText(afkCityCfg.terrainDes)
    Label_content:setDimensions(300, 0)
    self.UIListView_terrain:pushBackCustomItem(Label_content)

    local w = self.Label_terrain:getContentSize().width
    local posX = self.Label_terrain:getPositionX() + w
    self.Image_terrain_icon:setPositionX(posX)

    ---刷新事件信息
    self:updateEventItem(self.selectCityId)
end

function ExploreMainView:startExploreDot()

    self:updateAwardBox()

    self.Panel_root:stopAllActions()

    if self.selectCityId ~= self.curCityId then
        return
    end

    self.startTime,self.curAwardTimes,self.exploreSpeed,self.lastPassTime = ExploreDataMgr:getCityExploreProgress()

    if self.startTime == 0 or self.exploreSpeed == 0 then
        print("self.startTime,self.exploreSpeed",self.startTime,self.exploreSpeed)
        return
    end

    local cityCfg = ExploreDataMgr:getAfkCityCfg(self.curCityId)
    if not cityCfg then
        return
    end

    if self.curDis and self.curDis > self.curAwardTimes * self.perDistance then
        print(self.curDis,self.curAwardTimes * self.perDistance)
    end

    self.perDistance = cityCfg.distance
    self.totalDis = cityCfg.awardTimes * self.perDistance
    self.curDis = self.curAwardTimes * self.perDistance + self.lastPassTime * self.exploreSpeed /60
    self.freshTime = 1/self.exploreSpeed

    local maxCapacity = ExploreDataMgr:getMaxCapacity()
    local exploreAward,cnt = ExploreDataMgr:getExploreAward()
    dump({
        lastPassTime = self.lastPassTime,
        cityId = self.curCityId,
        curAwardTimes = self.curAwardTimes,
        curDis = self.curDis,
        perDistance = cityCfg.distance,
        freshTime = self.freshTime*60,
        speed = self.exploreSpeed,
        totalDis = self.totalDis
    })

    if maxCapacity ~= 0 and cnt >= maxCapacity then
        self:setExplorePercent()
        return
    end

    local act = CCSequence:create({
        CCCallFunc:create(function()
            self:updateCityPercent()
        end),
        CCDelayTime:create(self.freshTime*60 + 0.01),
        CCCallFunc:create(function()
            self.curDis = self.curDis + 1
        end)
    })
    self.Panel_root:runAction(CCRepeatForever:create(act))
end

function ExploreMainView:updateCityPercent()

    local newAwardTimes = math.floor(self.curDis/self.perDistance)
    --print("updateCityPercent",self.cnt,newAwardTimes,self.curDis,self.exploreSpeed,self.curAwardTimes,self.perDistance)
    if newAwardTimes > self.curAwardTimes then
        ExploreDataMgr:Send_reachExploreDot(EC_AfkActivityID.Main)
        dump({
            sendTime = ServerDataMgr:getServerTime()
        },"Send_reachExploreDot")
        self.Panel_root:stopAllActions()
    end

    self:setExplorePercent()
end

function ExploreMainView:setExplorePercent()

    local percent = math.floor(self.curDis/self.totalDis*100)
    --print("percent",self.curDis,percent)
    if percent >= 100 then
        self.Panel_root:stopAllActions()
    end
    for k,v in ipairs(self.cityNodes) do
        v.bar_bg:setVisible(v.cityId == self.curCityId)
        if v.cityId == self.curCityId then
            v.bar:setPercent(percent)
            break
        end
    end
end

function ExploreMainView:onTurnViewSelect(target, selectIndex)
    self:updateSelectNationInfo(selectIndex)
end

function ExploreMainView:onUpdateJmupCity(switchType,nationCid,cityId,isCheck)

    --0 切换城市 , 1 切换国家
    if switchType == 0 then
        local isDelay = self.curCityId ~= cityId
        self.curCityId = ExploreDataMgr:getCurExploreCity()
        local index = table.indexOf(self.cityIds,cityId)
        self:jumpToCity(index,isDelay)
        self.Panel_Info:hide()
        self:updateScreenInfo(true,false)

        self:changeBgColor()
    else
        self:updateExploreInfo()
    end
end

function ExploreMainView:changeBgColor()
    local nationCfg = ExploreDataMgr:getAfkNationCfg(self.curNationId)
    if not nationCfg then
        return
    end
    local colorTab = clone(nationCfg.bgColors)
    if not self.cityBgColor then
        local index = math.random(1,#colorTab)
        self.cityBgColor = colorTab[index]
    else
        local index = table.indexOf(colorTab,self.cityBgColor)
        if not index then
            local index = math.random(1,#colorTab)
            self.cityBgColor = colorTab[index]
        else
            table.remove(colorTab,index)
            local index = math.random(1,#colorTab)
            self.cityBgColor = colorTab[index]
        end
    end
    local color = Utils:covertToColorRGB(self.cityBgColor)
    self.battleView:setBgColor(color)
end


function ExploreMainView:onRemoveEvent(cityId,eventId,rewards)

    self:updateEventItem(cityId,eventId)

    local cfg = ExploreDataMgr:getAfkEventCfg(eventId)
    if cfg and cfg.eventType == 2 then
        self.fightReward = rewards
        return
    end

    if #rewards > 0 then
        Utils:showReward(rewards)
    end

    self:updateRedTip()
end

function ExploreMainView:removeEvents( ... )
    -- body
    self.super.removeEvents(self)
    if self.battleView then
        self.battleView:removeEvents()
    end
end

function ExploreMainView:updateRedTip()

    ---判断是否有boss可打
    local showRedTip = false
    local cityGroup =  ExploreDataMgr:getAfkCityGroup(self.curNationId)
    for k,v in ipairs(cityGroup) do
        local foundEventData = ExploreDataMgr:getFoundEventData(v.cityBoss)
        if foundEventData then
            showRedTip = true
            break
        end
    end

    ---天赋
    local knowledgeData = ExploreDataMgr:getKnowledgeState(0)
    for k,v in pairs(knowledgeData) do
        if v == 0 then
            local cfg = ExploreDataMgr:getKnowledgeCfg(k)
            if cfg and cfg.chapterID == self.curNationId then
                local costId,costNum
                for id,num in pairs(cfg.cost) do
                    costId,costNum = id,num
                    break
                end

                if costId and costNum then
                   local ownCount = GoodsDataMgr:getItemCount(costId)
                    if ownCount >= costNum then
                        showRedTip = true
                        break
                    end
                end
            end
        end
    end
    self.Image_detail_red_tip:setVisible(showRedTip)

    showRedTip = false
    ---是否有可进行的事件
    for k,v in ipairs(self.cityNodes) do
        local cityData = ExploreDataMgr:getCityEventData(v.cityId)
        if cityData then
            for _,info in ipairs(cityData) do
                if info.state == 1 then
                    showRedTip = true
                    break
                end
            end
        end
    end
    self.Image_map_red_tip:setVisible(showRedTip)
end

function ExploreMainView:updateExploreInfo(isUpdate)
    self.curNationId = ExploreDataMgr:getCurNation()
    self.curCityId = ExploreDataMgr:getCurExploreCity()
    print(isUpdate,self.curNationId,self.curCityId)
    if not isUpdate then
        self:loadMap()
        self:startShip()
    end
    self:updateWorldMap()
   -- self:showRandomDropAward()

    if self.battleView then
        self.battleView:setNationChapter(self.curNationId)
    end

    local cfg = ExploreDataMgr:getAfkNationCfg(self.curNationId)
    if cfg then
        self:changeBgm(cfg.bgm)
    end

    ExploreDataMgr:Send_GetShipAttrsInfo(EC_AfkActivityID.Main,self.curNationId,self.curCityId)
    self:updateRedTip()

end

---刷新探索奖励box
function ExploreMainView:updateAwardBox()
    local award,cnt = ExploreDataMgr:getExploreAward()
    self.Panel_Box:setVisible(next(award) ~= nil and (not self.enterBattle))
    local maxCapacity = ExploreDataMgr:getMaxCapacity()
    self.Image_full:setVisible(cnt >= maxCapacity)
    dump({
        cnt = cnt,
        maxCapacity = maxCapacity,
    },"背包容量")
end

---切换战斗状态
function ExploreMainView:updateBattleState(enterBattle)
    self.enterBattle = enterBattle
    self:updateAwardBox()

    local bgm = "sound/explore/battle.mp3"
    if not enterBattle and self.fightReward then
        Utils:showReward(self.fightReward)
        self.fightReward = nil
    end

    if not enterBattle then
        local cfg = ExploreDataMgr:getAfkNationCfg(self.curNationId)
        if cfg then
            bgm = cfg.bgm
        end
    end

    self.Panel_touch:setVisible(enterBattle)
    self:changeBgm(bgm)
end

function ExploreMainView:finishExploreDot(awardInfo)

    self:updateRedTip()
    self:updateEventItem(self.curCityId,false,true)
    self:startExploreDot()
    if not self.battleView or not awardInfo then
        return
    end

    self.battleView:startNormalBattle(awardInfo)
end

function ExploreMainView:updateEventItem(cityId,deleteEventId,isFinishDot)

    local node
    for k,v in ipairs(self.cityNodes) do
        if v.cityId == cityId then
            node = v
            break
        end
    end

    if not node then
        return
    end

    ---删除
    if deleteEventId then
        for i,event in ipairs(node.eventNode) do
            if event.id == deleteEventId then
                event.node:runAction(CCScaleTo:create(0.2,0))
                event.node:setTouchEnabled(false)
                event.id = 0
                event.isPlay = false
            end
        end
    end

    local eventData = ExploreDataMgr:getCityEventData(cityId) or {}
    for k,v in ipairs(eventData) do
        local isShow = false
        for i,event in ipairs(node.eventNode) do
            if v.id == event.id then
                isShow = true
                break
            end
        end

        if not isShow then
            for i,event in ipairs(node.eventNode) do
                if event.id == 0 then
                    event.id = v.id
                    event.node:setTouchEnabled(true)
                    local eventCfg = ExploreDataMgr:getAfkEventCfg(v.id)

                    local act = CCSequence:create({
                        CCScaleTo:create(0.2,0.6),
                        CCCallFunc:create(function()
                            ViewAnimationHelper.doMoveUpAndDown(event.node,1.2,8)
                        end)
                    })
                    event.node:runAction(act)

                    event.isPlay = true

                    event.node:setTexture(eventCfg.icon)
                    event.node:onClick(function()
                        GameGuide:checkGuideEnd(self.guideFuncId)
                        Utils:openView("explore.EventConfirm",node.cityId,v.id)
                    end)

                    if isFinishDot then
                        Utils:playSound(5050)
                        local effectInfo = self:getEventSpine()
                        if effectInfo and self.Panel_effect then
                            effectInfo.spine:show()
                            local position = event.node:getPosition()
                            local wp = event.node:getParent():convertToWorldSpaceAR(position)
                            local np = self.Panel_effect:convertToNodeSpaceAR(wp)
                            effectInfo.spine:setPosition(np)
                            effectInfo.spine:play("animation",false)
                            effectInfo.spine:addMEListener(TFARMATURE_COMPLETE,function()
                                effectInfo.spine:hide()
                                effectInfo.state = false
                            end)
                        end
                    end
                    break
                end
            end
        end
    end
end

function ExploreMainView:getEventSpine()

    local index
    for k,v in ipairs(self.effectNode) do
        if v.state == false then
            index = k
            break
        end
    end

    if index then
        self.effectNode[index].state = true
        return self.effectNode[index]
    else
        local effect = SkeletonAnimation:create("effect/effect_afk/effects_afk_radarscan")
        self.Panel_effect:addChild(effect)
        table.insert(self.effectNode,{state = true,spine = effect})
        return self.effectNode[#self.effectNode]
    end

end

function ExploreMainView:quickExplore()
    Utils:openView("explore.QuickExploreView")
end

function ExploreMainView:enterBossFight(data)
    if not self.battleView then
        return
    end
    local isLayerInQueue,layer = AlertManager:isLayerInQueue("ExploreMainView")
    if isLayerInQueue and layer then
        AlertManager:closeAllBeforLayer(layer)
    end
    self.battleView:startBossBattle(data.fightData)
end

function ExploreMainView:onGetExploreAward()
    self:startExploreDot()
end

function ExploreMainView:onReconect()
    ExploreDataMgr:Send_GetExploreInfo(EC_AfkActivityID.Main)
end

function ExploreMainView:onUpdateBagItem()

    for k,v in ipairs(self.afkNationList) do
        local nationCfg = ExploreDataMgr:getAfkNationCfg(v)
        if nationCfg then
            self:updateWoldMapItem(k,nationCfg)
        end
    end

    local index = table.indexOf(self.afkNationList,self.selectNationId)
    if index == -1 then
        return
    end
    self:updateSelectNationInfo(index)

end

function ExploreMainView:excuteGuideFunc40000(guideFuncId)

    local node
    for k,v in ipairs(self.cityNodes) do
        if v.cityId == self.curCityId then
            node = v
            break
        end
    end

    if not node then
        return
    end

    local targetNode
    for i,event in ipairs(node.eventNode) do
        if event.id ~= 0 then
            local eventCfg = ExploreDataMgr:getAfkEventCfg(event.id)
            if eventCfg.eventType == 2 then
                targetNode = event.node
            end
        end
    end
    if not targetNode then
        return
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function ExploreMainView:excuteGuideFunc39999(guideFuncId)

    local targetNode = self.Panel_guide

    local rewards = {}
    local AfkDropCfg = TabDataMgr:getData("AfkDrop", 11)
    if AfkDropCfg then
        local items = AfkDropCfg.useProfit.fix.items
        for k,v in ipairs(items) do
            table.insert(rewards,{id = v.id,num = v.max})
        end
    end

    local data = {
        dropId = 11,
        rewards = rewards
    }

    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)

    self:timeOut(function()
        if self.battleView then
            self.battleView:startNormalBattle(data)
        end
    end,0.1)

end

function ExploreMainView:changeBgm(bgm)
    if bgm ~= "" and self.bgm ~= bgm then
        AudioExchangePlay.playBGM(self,true,bgm)
        self.bgm = bgm
    end
end

function ExploreMainView:clearNationNew(nationCid)

    local newNations = ExploreDataMgr:getNewNation()
    local index = table.indexOf(newNations,nationCid)
    if index ~= -1 then
        table.remove(newNations,index)
    end

    local itemIndex = table.indexOf(self.afkNationList,nationCid)
    if itemIndex ~= -1 then
        if self.worldMapItem_[itemIndex] then
            self.worldMapItem_[itemIndex].new_b:hide()
            self.worldMapItem_[itemIndex].new_s:hide()
        end
    end
end

function ExploreMainView:enterNation()

    local unlock = ExploreDataMgr:isopenNation(self.selectNationId)
    if not unlock then
        Utils:showTips(13322026)
        return
    end
    self:clearNationNew(self.selectNationId)
    if self.selectNationId ~= self.curNationId then
        local cfg = ExploreDataMgr:getAfkNationCfg(self.selectNationId)
        if not cfg then
            return
        end
        ExploreDataMgr:Send_switchNationOrCity(1,self.selectNationId,cfg.cityIds[1],EC_AfkActivityID.Main)
        return
    end
    self:onUpdateJmupCity(0,self.curNationId,self.curCityId,true)
end

function ExploreMainView:showAttrPanel()
    self.Panel_attr:show()
    self.Spine_attr_change:play("animation",false)
    self:updateShipAttr()
end

function ExploreMainView:checkEquipRoomUnlock( roomCfg )
    local unlock = true
    if roomCfg.unlockCondition then
        for k,v in pairs(roomCfg.unlockCondition) do
            local _cfg, detailCfg = ExploreDataMgr:getCabinCfg(k)
            if detailCfg.level < v then
                unlock = false
                break;
            end
        end
    end
    return unlock
end

function ExploreMainView:updateEquipItem(item,equipId,isRoomUnLock)

    local equipInfo = GoodsDataMgr:getItem(equipId)
    local unLock = equipInfo and true or false
    unLock = unLock and isRoomUnLock
    local equipCfg = TabDataMgr:getData("ExploreEquip",equipId)
    local equip_icon = TFDirector:getChildByPath(item,"equip_icon")
    local Image_equip = TFDirector:getChildByPath(item,"Image_equip")
    local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
    local Label_lv = TFDirector:getChildByPath(item,"Label_lv")

    equip_icon:setTexture(string.sub(equipCfg.icon,0,-5).."_1.png")
    Image_lock:setVisible(not unLock)

    local level = 0
    if unLock then
        local _,itemInfo = next(equipInfo)
        level = itemInfo and itemInfo.level or 0
        Label_lv:setText("Lv."..level)

        local curLevelCfg = ExploreDataMgr:getEquipLevelCfg(equipId, level)
        if curLevelCfg then
            self.Label_equip_des:setText(curLevelCfg.desc2)
        else
            self.Label_equip_des:setText("")
        end
        local h = self.Label_equip_des:getContentSize().height
        self.tip_bg:setContentSize(CCSizeMake(250,h+5))
    else
        Label_lv:setText("")
    end

    Image_equip:setTouchEnabled(unLock)
    Image_equip:onClick(function()
        local wp = item:getParent():convertToWorldSpace(item:Pos())
        local np = self.tip_bg:getParent():convertToNodeSpaceAR(wp)
        self.tip_bg:setPosition(np)
        if self.oldItem ~= item then
            self.tip_bg:setVisible(true)
            self.oldItem = item
        else
            local visible = self.tip_bg:isVisible()
            self.tip_bg:setVisible(not visible)
        end

        local visible = self.tip_bg:isVisible()
        if visible then
            local curLevelCfg = ExploreDataMgr:getEquipLevelCfg(equipId, level)
            if curLevelCfg then
                self.Label_equip_des:setText(curLevelCfg.desc2)
            else
                self.Label_equip_des:setText("")
            end
            local h = self.Label_equip_des:getContentSize().height
            self.tip_bg:setContentSize(CCSizeMake(250,h+15))
        end
    end)
end

function ExploreMainView:changeEquip()

    self.roomType = self.roomType == ShipRoomType.ARMOR and ShipRoomType.WEAPON or ShipRoomType.ARMOR
    self:showEquip()
end

function ExploreMainView:showEquip()
    local str = self.roomType == ShipRoomType.WEAPON and 13322055 or 13322056
    self.Label_system_name:setTextById(str)
    self.UIListView_equip:removeAllItems()
    local roomCfg = ExploreDataMgr:getCabinCfg(self.roomType)
    if roomCfg then
        local equipList = roomCfg.equipId or {}
        for k,v in ipairs(equipList) do
            local item = self.UIListView_equip:getItem(k)
            if not item then
                item = self.Panel_euiqp_item:clone()
                self.UIListView_equip:pushBackCustomItem(item)
            end
            self:updateEquipItem(item,v,self:checkEquipRoomUnlock(roomCfg))
        end
        self.UIListView_equip:setCenterArrange()
    end
end

function ExploreMainView:updateShipAttr()

    local tab = {12001,10001,11001}
    local cfg = ExploreDataMgr:getShipCfg()
    self.Label_attr_title1:setText(cfg.nameCn)
    self.Spine_attr_ship:setFile(string.format("effect/exploreSkinEffects/%s/%s",cfg.id,cfg.fightMask))
    self.Spine_attr_ship:setPosition(ccp(cfg.showSite3.x, cfg.showSite3.y))
    self.Spine_attr_ship:play("animation",true)
    self.Label_attr_title2:setTextById(13311310 + ExploreDataMgr.shipInfo.shape)
    self.attrData_ = {}
    local attrsInfo= ExploreDataMgr:getShipAttrsInfo() or {}
    for k,v in ipairs(attrsInfo.attr or {}) do
        local attConfig = self.attributeCfgs[v.attrId]
        ---战斗力
        if attConfig.attributeId == tab[1] then
            local attValue = v.baseValue / attConfig.division
            attValue = string.format("%."..attConfig.decimal.."f",attValue)
            attValue = string.format(attConfig.displayFormat,attValue)
            self.Label_power:setText(attValue)
        end

        ---飞行速度
        if attConfig.attributeId == tab[2] then
            self:updateAttrItem(self.Panel_speed_item,v)
        end

        ---容量
        if attConfig.attributeId == tab[3] then
            self:updateAttrItem(self.Panel_capacity_item,v)
        end

        local index = table.indexOf(tab,attConfig.attributeId)
        if attConfig.isShow and index == -1 then
            table.insert(self.attrData_,v)
        end

    end

    table.sort(self.attrData_,function(a, b)
        local cfga = self.attributeCfgs[a.attrId]
        local cfgb = self.attributeCfgs[b.attrId]
        return cfga.order < cfgb.order
    end)
    self.TableView_attr:reloadData()

    self.roomType = self.roomType or ShipRoomType.WEAPON
    self:showEquip()
end

function ExploreMainView:registerEvents()

    EventMgr:addEventListener(self, EV_EXPLORE_SHIPATTR, handler(self.updateShipAttr, self))
    EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.updateRedTip, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onUpdateBagItem, self))
    EventMgr:addEventListener(self, EV_RECONECT_EVENT, handler(self.onReconect, self))
    EventMgr:addEventListener(self, EC_GET_EXPLORE_AWARD, handler(self.onGetExploreAward, self))
    EventMgr:addEventListener(self, EV_EXPLORE_FIGHTBOSS, handler(self.enterBossFight, self))
    EventMgr:addEventListener(self, EV_FINISH_EXPLORE_DOT, handler(self.finishExploreDot, self))
    EventMgr:addEventListener(self, EV_EXPLORE_ACTIVITY, handler(self.updateExploreInfo, self))
    EventMgr:addEventListener(self, EV_EXPLORE_JUMPCITY, handler(self.onUpdateJmupCity, self))
    EventMgr:addEventListener(self, EV_EXPLORE_REMOVE_EVENT, handler(self.onRemoveEvent, self))

    local function scrollCallback(target, offsetRate, customOffsetRate, index)
        local h = self.Panel_nationItem:getContentSize().height/2
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            local rCustomRate = 1 - customRate
            item:setOpacity(255 * rrate)
            item:setZOrder(rrate * 100)
            if i ~= index then
                local z = math.abs(index - i) % 2 == 0 and h + 80 or h + 120
                item:setPositionY(z)
            else
                item:setPositionY(h+100)
            end
            local Panel_big = TFDirector:getChildByPath(item,"Panel_big")
            local Image_small = TFDirector:getChildByPath(item,"Image_small")
            Panel_big:setVisible(index == i)
            Image_small:setVisible(index ~= i)

        end
    end
    self.TurnView_worldMap:registerScrollCallback(scrollCallback)
    self.TurnView_worldMap:registerSelectCallback(handler(self.onTurnViewSelect, self))

    self.Button_exit:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {2466})
    end)

    self.Button_ship:onClick(function ()
        -- body
        Utils:openView("explore.FlyShipMainView")
    end)

    self.Button_map:onClick(function()
        Utils:openView("explore.ExploreCountryView")
    end)

    self.Button_detail:onClick(function()
        --ExploreDataMgr:Send_ExploreTechInfos()
        Utils:openView("explore.CountryDetailsView",self.selectNationId)
    end)

    self.Button_random:onClick(function()
        self.Panel_randomDrop:show()
        self:showRandomDropAward()
    end)

    self.Button_closeDropPL:onClick(function()
        self.Panel_randomDrop:hide()
    end)

    self.Panel_randomDrop:onClick(function()
        self.Panel_randomDrop:hide()
    end)

    self.Image_terrain_bg:onClick(function()
        local visible = self.Image_terrain_tip_bg:isVisible()
        self.Image_terrain_tip_bg:setVisible(not visible)
    end)

    self.Panel_close_terrain_bg:onClick(function()
        self.Image_terrain_tip_bg:setVisible(false)
    end)

    self.Button_enter:onClick(function()
        self:enterNation()
    end)

    self.Button_back:onClick(function()
        self:updateScreenInfo(false,true)
    end)

    self.Panel_Box:onClick(function()
        Utils:openView("explore.ExploreAwardView")
    end)

    self.Button_quick:onClick(function()
        self:quickExplore()
    end)

    self.Panel_guide:setSwallowTouch(false)
    self.Panel_guide:onClick(function()
        GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    self.Panel_cityZone:onClick(function()
        print("xxxx")
    end)

    for k,v in ipairs(self.worldMapItem_) do
        v.root:onClick(function()
            local selectIndex = self.TurnView_worldMap:getSelectIndex()
            if k == selectIndex then
                self:enterNation()
            else
                self.TurnView_worldMap:scrollToItem(k)
            end
        end)
    end

    self.Button_attr:onClick(function()
        self.Panel_attr:hide()
    end)

    self.Button_change:onClick(function()
        self:changeEquip()
    end)

    self.Panel_closeAttrTip:onClick(function()
        self.tip_bg:hide()
    end)
end

return ExploreMainView

