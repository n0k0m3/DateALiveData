local KabalaTreeStatistics = class("KabalaTreeStatistics",BaseLayer)

function KabalaTreeStatistics:ctor(functype)
	self.super.ctor(self)
    self:initData(functype)
    self:showPopAnim(true)
	self:init("lua.uiconfig.kabalaTree.kabalaTreeStatistics")
end

function KabalaTreeStatistics:initData(functype)

    self.functype = functype or 1
    self.maxHorizontal = 5
end

function KabalaTreeStatistics:initUI(ui)
	self.super.initUI(self,ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Label_time = TFDirector:getChildByPath(self.ui, "Label_time")
    self.Label_timetip = TFDirector:getChildByPath(self.ui, "Label_timetip")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.item_clone = TFDirector:getChildByPath(self.Panel_prefab, "Panel_clone")

    local ScrollView_record = TFDirector:getChildByPath(self.ui, "ScrollView_record")
    self.ListView_record = UIListView:create(ScrollView_record)

    self:uiLogic()
end

function KabalaTreeStatistics:uiLogic()

    self.Label_title:setTextById(3003018)

    self:updateStatisticsData()
    self.Label_time:setText("")

    if self.functype == 2 then
        self.Label_timetip:setText("")
        return
    end
    self:updateRefreshTime()
    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            self:updateRefreshTime()
        end)
    })
    self.Label_time:runAction(CCRepeatForever:create(seqact))
end

function KabalaTreeStatistics:updateStatisticsData()

    local orderData = {}
    if self.functype == 1 then
        local statisticsData = KabalaTreeDataMgr:getStatisticsData()
        if statisticsData then
            for k,v in pairs(statisticsData) do
                if v.remainCount > 0 then
                    table.insert(orderData,v)
                end
            end
        end
    elseif self.functype == 2 then
        local statisticsData = DalMapDataMgr:getStatisticsData()
        if statisticsData then
            for k,v in pairs(statisticsData) do
                table.insert(orderData,v)
            end
        end
    end

    table.sort(orderData,function (a,b)
        return a.cfgData.order < b.cfgData.order
    end)

    self.ListView_record:removeAllItems()

    local maxHorizatal = math.ceil(#orderData/5)
    for i=1,maxHorizatal do
        self.listItem = self.item_clone:clone()
        self.ListView_record:pushBackCustomItem(self.listItem)
        for j=1,5 do
            local index = (i-1)*5+j
            local listInfo = orderData[index]
            if listInfo then
                self:updateListItem(listInfo,j)
            end
        end
    end

end

function KabalaTreeStatistics:updateListItem(data,itemIndex)

    if itemIndex > self.maxHorizontal then
        return
    end

    local Panel_item = TFDirector:getChildByPath(self.listItem, "Panel_item_"..itemIndex)
    local Image_inner = TFDirector:getChildByPath(Panel_item, "Image_inner")
    local Label_num = TFDirector:getChildByPath(Image_inner, "Label_num")
    local Image_icon = TFDirector:getChildByPath(Image_inner, "Image_icon")
    Image_inner:setVisible(true)

    print("Id",data.cfgData.eventID,data.res)

    local finishCnt = data.count - data.remainCount
    if finishCnt < 0 then
        finishCnt = 0
    end

    Panel_item:setVisible(finishCnt <= data.count)

    if data.isCount then
        Label_num:setText(finishCnt.."/"..data.count)
    else
        Label_num:setText(data.count)
    end

    Image_icon:setTexture(data.res)
    Image_icon:setPosition(ccp(data.cfgData.offset.x,data.cfgData.offset.y))
    Image_icon:setScale(data.cfgData.scale)
end

function KabalaTreeStatistics:updateRefreshTime()

    local refreshTime = KabalaTreeDataMgr:getEventRefreshTime()
    local leftTime = refreshTime - ServerDataMgr:getServerTime()
    self.Label_time:setText(self:formateTime(leftTime))
end


function KabalaTreeStatistics:formateTime(timeVal)
    if timeVal < 0 then
        timeVal = 0
    end
    local hour= math.floor(timeVal / 3600)
    local min = math.floor(timeVal % 86400 % 3600 / 60)
    local seconds = math.floor(timeVal % 86400 % 3600 % 60 / 1)

    return string.format("%02d:%02d:%02d", hour, min, seconds)
end

function KabalaTreeStatistics:registerEvents()
	
    EventMgr:addEventListener(self,EV_UPDATE_RANDOMEVENT,handler(self.updateStatisticsData, self))
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end


return KabalaTreeStatistics