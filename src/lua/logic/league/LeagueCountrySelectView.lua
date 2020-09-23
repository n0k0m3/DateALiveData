local LeagueCountrySelectView = class("LeagueCountrySelectView",BaseLayer)

function LeagueCountrySelectView:initData(data)
    self.callback = data
end

function LeagueCountrySelectView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.league.leagueCountrySelect")
end

function LeagueCountrySelectView:initUI(ui)
    self.super.initUI(self, ui)

    self.dataTableView = Utils:scrollView2TableView(self._ui.dataView)
    self.dataTableView.oldPos = self.dataTableView:getPosition()
    self.dataTableView.oldSize = self.dataTableView:getViewSize()

    self.Button_close = TFDirector:getChildByPath(ui , "Button_close")
    self.Button_ok = TFDirector:getChildByPath(ui , "Button_ok")

    self.country_item = {}
    self.countryData = TabDataMgr:getData("ClubCountry")
    self.selectIndex = LeagueDataMgr:getUnionCountryName()
end

function LeagueCountrySelectView:registerEvents()


    self.Button_close:onClick(function ( ... )
        AlertManager:closeLayer(self)
    end)

     self.Button_ok:onClick(function ( ... )
        if self.callback then
            self.callback(self.selectIndex)
        else
            LeagueDataMgr:UpdateUnionInfo(EC_UNION_EDIT_Type.CHANGE_COUNTRY , tostring(self.selectIndex))
        end
        AlertManager:closeLayer(self)
    end)
    
    -- tableview
    self.dataTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.dataTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.dataTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    --

    
end

function LeagueCountrySelectView:rankCellSize(tableView, idx)
    local size = self._ui.dataRankItem:getSize()
    return size.height + 5, size.width
end

function LeagueCountrySelectView:numberOfCells(tableView)
    -- local data = self.rankData[self.chooseCamp] 
    -- data = data and data.innerRank
    -- local num = data and #data or 0
    return #self.countryData
end

function LeagueCountrySelectView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.dataRankItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
        item:setTouchEnabled(true)
        item:onClick(function( clickItem )
            self:selectItem(clickItem.idx)
        end)
        table.insert(self.country_item , item)
    else
        item = cell.item
    end

    self:refreshCellItem(item,index)
    return cell
end

function LeagueCountrySelectView:refreshCellItem(item,idx)
    item.idx = idx
    if self.selectIndex == idx  then
        item:getChildByName("Image_select"):show()
    else
        item:getChildByName("Image_select"):hide()
    end
    local data = self.countryData[idx]
    item:getChildByName("Label_name_1"):setText(data.Countryabbreviations)
    item:getChildByName("Label_name_2"):setText(data.country)
end

function LeagueCountrySelectView:selectItem(idx)
    if idx == self.selectIndex then
        self.selectIndex = 0
    else
        self.selectIndex = idx
    end
    for k ,v in pairs(self.country_item) do
        if v.idx == self.selectIndex then
            v:getChildByName("Image_select"):show()
        else
            v:getChildByName("Image_select"):hide()
        end
    end
end

function LeagueCountrySelectView:onShow( ... )
    self.super.onShow(self)
    self.dataTableView:reloadData()

    self:selectItem(0)
end


return LeagueCountrySelectView