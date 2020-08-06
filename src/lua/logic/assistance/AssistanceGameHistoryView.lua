
local AssistanceGameHistoryView = class("AssistanceGameHistoryView", BaseLayer)

function AssistanceGameHistoryView:initData(historyData,titleId)
    self.historyData_ = historyData.records
    self.titleId = titleId

end

function AssistanceGameHistoryView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.assistance.assistanceHistoryView")
end

function AssistanceGameHistoryView:initUI(ui)
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

function AssistanceGameHistoryView:refreshView()

    -- self.titleId = self.titleId or 1214300
    -- self.Label_tilte:setTextById(self.titleId)

    -- local width = self.Label_tilte:getContentSize().width
    -- self.Image_line:setPositionX(-389 + width + 5)
    -- self.Label_englishTitle:setPositionX(-389 + width + 5 + 5)

    -- self.Label_filed_date:setTextById(1214301)

    -- if self.titleId and self.titleId == 303033 then
    --     self.Label_filed_result:setTextById(303036)
    -- elseif self.titleId and self.titleId == 14110006 then
    --     self.Label_filed_result:setTextById(14110007)
    -- else
    --     self.Label_filed_result:setTextById(1214302)
    -- end

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
        local img_step = TFDirector:getChildByPath(item , "img_step")
        local time = v.time/1000
        local year, month, day = Utils:getDate(time, true)
        local hour, min, sec = Utils:getTime(time, true)
        local date = TFDate(time):tolocal()
        Label_time:setTextById(800049, year, month, day, hour, min)
        if not v.rewards then
            Label_name:setVisible(false)
        else
            Label_name:setVisible(true)
            local itemCfg = GoodsDataMgr:getItemCfg(v.rewards[1].id)
            Label_name:setTextById(800037, TextDataMgr:getText(itemCfg.nameTextId), v.rewards[1].num)
            Label_name:setColor(EC_ItemQualityColor[itemCfg.quality])
        end
        local img_path = {38 , 32 ,37 , 35 , 34}
        img_step:setTexture("ui/assistance/assistance_"..img_path[v.result]..".png")
    end
end

function AssistanceGameHistoryView:registerEvents()
    self.Button_close:onClick(function()
            AlertManager:close()
    end)
end

return AssistanceGameHistoryView
