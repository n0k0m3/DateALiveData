
local WelfareRecordView = class("WelfareRecordView", BaseLayer)

function WelfareRecordView:initData(historyData,titleId)

    self.historyData_ = historyData[1].records
    self.titleId = titleId
    self.cardTypeImg = {"ui/activity/oneYear/card/pop/005.png","ui/activity/oneYear/card/pop/007.png","ui/activity/oneYear/card/pop/006.png"}
end

function WelfareRecordView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.oneYear.welfareRecordView")
end

function WelfareRecordView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_historyItem1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_historyItem1")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Label_tilte = TFDirector:getChildByPath(Image_content, "Label_tilte")

    self.Image_filed = TFDirector:getChildByPath(Image_content, "Image_filed")
    self.Label_filed_date = TFDirector:getChildByPath(self.Image_filed, "Label_filed_date")
    self.Label_filed_result = TFDirector:getChildByPath(self.Image_filed, "Label_filed_result")
    local ScrollView_history = TFDirector:getChildByPath(Image_content, "ScrollView_history")
    self.ListView_history = UIListView:create(ScrollView_history)
    self.ListView_history:setItemsMargin(4)
    self:refreshView()
end

function WelfareRecordView:refreshView()

    self.Label_tilte:setTextById(63618)
    self.Label_filed_date:setTextById(1214301)
    self.Label_filed_result:setTextById(63619)

    if not self.historyData_ then
        return
    end

    for i=1,10 do
        local data = self.historyData_[i]
        if data then
            local item = self.Panel_historyItem1:clone()
            self.ListView_history:pushBackCustomItem(item)
            local Label_time = TFDirector:getChildByPath(item, "Label_time")
            local Label_name = TFDirector:getChildByPath(item, "Label_name")

            local Image_quality = TFDirector:getChildByPath(item, "Image_quality")
            local year, month, day = Utils:getDate(data.time, true)
            local hour, min, sec = Utils:getTime(data.time, true)
            local date = TFDate(data.time):tolocal()
            Label_time:setTextById(800049, year, month, day, hour, min)
            local itemCfg = GoodsDataMgr:getItemCfg(data.itemId)
            Label_name:setTextById(800037, TextDataMgr:getText(itemCfg.nameTextId), data.itemNum)
            Label_name:setColor(EC_ItemQualityColor[itemCfg.quality])

            local poolQuality = SummonDataMgr:getCelebrationPoolQuality(data.itemId,data.itemNum)
            Image_quality:setTexture(self.cardTypeImg[poolQuality])

            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            PrefabDataMgr:setInfo(Panel_goodsItem, data.itemId, data.itemNum)
            Panel_goodsItem:setScale(0.4)
            Panel_goodsItem:setPosition(ccp(-60,0))
            local Label_count = TFDirector:getChildByPath(Panel_goodsItem, "Label_count"):hide()
            item:addChild(Panel_goodsItem)
        end
    end

    --for i, v in ipairs(self.historyData_) do
    --    local item = self.Panel_historyItem1:clone()
    --    self.ListView_history:pushBackCustomItem(item)
    --    local Label_time = TFDirector:getChildByPath(item, "Label_time")
    --    local Label_name = TFDirector:getChildByPath(item, "Label_name")
    --
    --    local Image_quality = TFDirector:getChildByPath(item, "Image_quality")
    --    local year, month, day = Utils:getDate(v.time, true)
    --    local hour, min, sec = Utils:getTime(v.time, true)
    --    local date = TFDate(v.time):tolocal()
    --    Label_time:setTextById(800049, year, month, day, hour, min)
    --    local itemCfg = GoodsDataMgr:getItemCfg(v.itemId)
    --    Label_name:setTextById(800037, TextDataMgr:getText(itemCfg.nameTextId), v.itemNum)
    --    Label_name:setColor(EC_ItemQualityColor[itemCfg.quality])
    --
    --    local poolQuality = SummonDataMgr:getCelebrationPoolQuality(v.itemId,v.itemNum)
    --    Image_quality:setTexture(self.cardTypeImg[poolQuality])
    --
    --    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    --    PrefabDataMgr:setInfo(Panel_goodsItem, v.itemId, v.itemNum)
    --    Panel_goodsItem:setScale(0.4)
    --    Panel_goodsItem:setPosition(ccp(-60,0))
    --    local Label_count = TFDirector:getChildByPath(Panel_goodsItem, "Label_count"):hide()
    --    item:addChild(Panel_goodsItem)
    --end
end

function WelfareRecordView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:close()
    end)
end

return WelfareRecordView
