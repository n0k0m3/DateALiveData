local AgoraLotteryHistoryView = class("AgoraLotteryHistoryView", BaseLayer)

function AgoraLotteryHistoryView:ctor(historyData)
    self.super.ctor(self)
    self:initData(historyData)
    self:showPopAnim(true)
    self:init("lua.uiconfig.agora.agoraLotteryHistoryView")
end

function AgoraLotteryHistoryView:initData(historyData)
    self.historyData_ = historyData[1].records
end

function AgoraLotteryHistoryView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_historyItem1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_historyItem1")
    self.Panel_historyItem2 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_historyItem2")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_tilte = TFDirector:getChildByPath(Image_content, "Label_tilte")
    self.Label_englishTitle = TFDirector:getChildByPath(Image_content, "Label_englishTitle")

    self.Image_filed = TFDirector:getChildByPath(Image_content, "Image_filed")
    self.Label_filed_date = TFDirector:getChildByPath(self.Image_filed, "Label_filed_date")
    self.Label_filed_result = TFDirector:getChildByPath(self.Image_filed, "Label_filed_result")
    local ScrollView_history = TFDirector:getChildByPath(Image_content, "ScrollView_history")
    self.ListView_history = UIListView:create(ScrollView_history)

    self:initUiInfo()
end

function AgoraLotteryHistoryView:initUiInfo()

    self.Label_filed_date:setTextById(1214301)
    self.Label_filed_result:setTextById(1214302)

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

function AgoraLotteryHistoryView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return AgoraLotteryHistoryView