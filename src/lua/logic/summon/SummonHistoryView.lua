
local SummonHistoryView = class("SummonHistoryView", BaseLayer)

function SummonHistoryView:initData(historyData,titleId)

    self.historyData_ = historyData[1].records
    self.titleId = titleId

end

function SummonHistoryView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.summon.summonHistoryView")
end

function SummonHistoryView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_historyItem1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_historyItem1")
    self.Panel_historyItem2 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_historyItem2")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_tilte = TFDirector:getChildByPath(Image_content, "Label_tilte")
    self.Image_line = TFDirector:getChildByPath(Image_content, "Image_line")
    self.Label_englishTitle = TFDirector:getChildByPath(Image_content, "Label_englishTitle")
 
    self.Image_filed = TFDirector:getChildByPath(Image_content, "Image_filed")
    self.Label_filed_date = TFDirector:getChildByPath(self.Image_filed, "Label_filed_date")
    self.Label_filed_result = TFDirector:getChildByPath(self.Image_filed, "Label_filed_result")
    local ScrollView_history = TFDirector:getChildByPath(Image_content, "ScrollView_history")
    self.ListView_history = UIListView:create(ScrollView_history)

    self:refreshView()
end

function SummonHistoryView:refreshView()

    self.titleId = self.titleId or 1214300
    self.Label_tilte:setTextById(self.titleId)

    local width = self.Label_tilte:getContentSize().width
    self.Image_line:setPositionX(-389 + width + 5)
    self.Label_englishTitle:setPositionX(-389 + width + 5 + 5)

    self.Label_filed_date:setTextById(1214301)

    if self.titleId and self.titleId == 303033 then
        self.Label_filed_result:setTextById(303036)
    elseif self.titleId and self.titleId == 14110006 then
        self.Label_filed_result:setTextById(14110007)
    else
        self.Label_filed_result:setTextById(1214302)
    end

    if not self.historyData_ then
        return
    end
    for i, v in ipairs(self.historyData_) do
        local item
        if math.mod(i, 2) == 1 then
            item = self.Panel_historyItem1:clone()
        else
            item = self.Panel_historyItem2:clone()
        end
        self.ListView_history:pushBackCustomItem(item)
        local Label_time = TFDirector:getChildByPath(item, "Label_time")
        local Label_name = TFDirector:getChildByPath(item, "Label_name")

        local year, month, day = Utils:getDate(v.time, true)
        local hour, min, sec = Utils:getTime(v.time, true)
        local date = TFDate(v.time):tolocal()
        Label_time:setTextById(800049, year, month, day, hour, min)
        local itemCfg = GoodsDataMgr:getItemCfg(v.itemId)
        Label_name:setTextById(800037, TextDataMgr:getText(itemCfg.nameTextId), v.itemNum)
        Label_name:setColor(EC_ItemQualityColor[itemCfg.quality])
    end
end

function SummonHistoryView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

return SummonHistoryView
