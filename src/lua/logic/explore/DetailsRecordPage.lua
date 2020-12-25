local DetailsRecordPage = class("DetailsRecordPage", BaseLayer)


function DetailsRecordPage:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.explore.detailsRecordPage")
end

function DetailsRecordPage:initData()
    self.nationCid = ExploreDataMgr:getCurNation()
end

function DetailsRecordPage:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui


    self.Panel_root = TFDirector:getChildByPath(self.ui,"Panel_root")
    
    self.Label_record = TFDirector:getChildByPath(self.Panel_root,"Label_record")
    self.Label_cnt = TFDirector:getChildByPath(self.Panel_root,"Label_cnt")

    self.Panel_item = TFDirector:getChildByPath(self.Panel_root,"Panel_item")
    local ScrollView_item = TFDirector:getChildByPath(self.Panel_root,"ScrollView_item")
    self.TableView_record = Utils:scrollView2TableView(ScrollView_item)
    Public:bindScrollFun(self.TableView_record)
    self.TableView_record:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSizeForTable, self))
    self.TableView_record:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex, self))
    self.TableView_record:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCellsInTableView, self))

    local text = {13321001,13321002,13321003}
    self.checkBox_ = {}
    for i=1,3 do
        local btn = TFDirector:getChildByPath(self.Panel_root,"Button_check"..i)
        local select = TFDirector:getChildByPath(btn,"Image_select")
        local Label_btn = TFDirector:getChildByPath(btn,"Label_btn")
        local Image_icon = TFDirector:getChildByPath(btn,"Image_icon")
        Label_btn:setTextById(text[i])
        table.insert(self.checkBox_,{btn = btn, select = select, Label_btn = Label_btn, icon = Image_icon})
    end
    self:updateBaseInfo()
end

function DetailsRecordPage:updateBaseInfo()
    self.statisticsInfo = {}
    self:updateTotal()
    self:chooseRecordType(1)
end

function DetailsRecordPage:updateTotal()

    local statisticsInfo = ExploreDataMgr:getAfkCountCfg(self.nationCid) or {}
    local finishCount,totalCount = 0,0
    for itemType,data in ipairs(statisticsInfo) do
        for k,v in ipairs(data) do
            local isFinish = ExploreDataMgr:isFinishExploreCount(self.nationCid,v)
            if isFinish == 1 then
                finishCount = finishCount + 1
            end
        end
        totalCount = totalCount + #data
    end
    local percent = finishCount/totalCount * 100
    percent = math.min(percent,100)
    percent = string.format("%.2f",percent)
    self.Label_record:setTextById(13322002,percent)
end

function DetailsRecordPage:chooseRecordType(itemType)

    for k,v in ipairs(self.checkBox_) do
        v.select:setVisible(k == itemType)
        local color = k == itemType and ccc3(39,114,190) or ccc3(75,78,134)
        v.Label_btn:setColor(color)
        local posY = k == itemType and 9 or 3
        v.icon:setPositionY(posY)
        local fntSize = k == itemType and 25 or 23
        v.Label_btn:setFontSize(fntSize)
    end


    self.statisticsInfo = ExploreDataMgr:getAfkCountCfg(self.nationCid,itemType) or {}
    table.sort(self.statisticsInfo,function(a,b)

        local isFinishiA = ExploreDataMgr:isFinishExploreCount(self.nationCid,a)
        local isFinishiB = ExploreDataMgr:isFinishExploreCount(self.nationCid,b)
        if isFinishiA == isFinishiB then
            return a.order < b.order
        else
            return isFinishiA < isFinishiB
        end
    end)
    local finishCount,totalCount = 0,#self.statisticsInfo
    for k,v in ipairs(self.statisticsInfo) do
        local isFinish = ExploreDataMgr:isFinishExploreCount(self.nationCid,v)
        if isFinish == 1 then
            finishCount = finishCount + 1
        end
    end
    self.Label_cnt:setTextById(13322003,finishCount .. "/"..totalCount)
    self.TableView_record:reloadData()
end


function DetailsRecordPage:cellSizeForTable()
    local size = self.Panel_item:getSize()
    return size.height, size.width
end

function DetailsRecordPage:numberOfCellsInTableView()
    return #self.statisticsInfo
end

function DetailsRecordPage:tableCellAtIndex(tab, idx)
    local cell = tab:dequeueCell()
    idx = idx + 1
    if not cell then
        cell = TFTableViewCell:create()
        local item = self.Panel_item:clone():show()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))

        cell:addChild(item)
        cell.item = item
    end
    cell.idx = idx

    if cell.item then
        self:updateRecordItem(cell, idx)
    end
    return cell
end

function DetailsRecordPage:updateRecordItem(cell,idx)

    local data = self.statisticsInfo[idx]
    if not data then
        return
    end

    local Image_icon = TFDirector:getChildByPath(cell,"Image_icon")
    local Label_type = TFDirector:getChildByPath(cell,"Label_type")
    local Label_desc = TFDirector:getChildByPath(cell,"Label_desc")
    local Image_finish = TFDirector:getChildByPath(cell,"Image_finish")
    local Label_name = TFDirector:getChildByPath(cell,"Label_name")
    local Label_progress = TFDirector:getChildByPath(cell,"Label_progress")
    local Button_jump = TFDirector:getChildByPath(cell,"Button_jump")
    local Spine_btn = TFDirector:getChildByPath(Button_jump,"Spine_btn")
    Spine_btn:play("animation2",true)
    local iconRes,typeStr,name,award,cityId = self:getCfgInfo(data.itemType,data.itemParam)
    Image_icon:setTexture(iconRes)
    Label_type:setTextById(typeStr)
    Label_name:setTextById(name)
    Label_desc:setText(data.des)
    local curProgress = ExploreDataMgr:getCurProgress(self.nationCid,data.itemType,data.itemParam)
    Label_progress:setText(curProgress.."/"..data.count)

    local isFinish = ExploreDataMgr:isFinishExploreCount(self.nationCid,data)
    Image_finish:setVisible(isFinish == 1)

    Image_icon:setTouchEnabled(data.itemType == 3)
    if data.itemType == 3 then
        Image_icon:onClick(function()
            if data.itemParam and #data.itemParam > 0 then
                Utils:showInfo(data.itemParam[1], nil, true)
            end
        end)
    end

    Button_jump:setVisible(data.itemType == 1 and isFinish ~= 1)
    if data.itemType == 1 and cityId then
        Button_jump:onClick(function()
            Utils:openView("explore.ExploreCountryView",cityId)
        end)
    end

    for i=1,3 do
        local Image_item_bg = TFDirector:getChildByPath(cell,"Image_item_"..i):hide()
    end
    award = award or {}
    local index = 0
    for k,v in pairs(award) do
        index = index + 1
        local Image_item_bg = TFDirector:getChildByPath(cell,"Image_item_"..index)
        Image_item_bg:show()
        local Panel_goodsItem = Image_item_bg:getChildByName("Panel_goodsItem")
        if not Panel_goodsItem then
            Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:AddTo(Image_item_bg):Pos(0, 0)
            Panel_goodsItem:setScale(0.4)
        end
        PrefabDataMgr:setInfo(Panel_goodsItem, k, v)
    end



end

function DetailsRecordPage:getCfgInfo(itemType,itemParamTab)
    local itemParam = itemParamTab[1]
    if itemType == 1 then
        local cfg = ExploreDataMgr:getAfkEventCfg(itemParam)
        if not cfg then
            return "",13321001,""
        end
        return cfg.icon2,13321001,cfg.name,cfg.award,cfg.city
    elseif itemType == 2 then
        local knowledgeTab = ExploreDataMgr:getNationKnowledge(self.nationCid,itemParam) or {}
        local cfg = knowledgeTab[1]
        if not cfg then
            return "",13321002,""
        end
        return cfg.icon,13321002,cfg.name
    elseif itemType == 3 then
        local cfg =GoodsDataMgr:getItemCfg(itemParam)
        return cfg.icon,13321003,cfg.nameTextId
    end
end

function DetailsRecordPage:registerEvents()

    for k,v in ipairs(self.checkBox_) do
        v.btn:OnClick(function()
            self:chooseRecordType(k)
        end)
    end

end

return DetailsRecordPage
