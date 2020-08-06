local BaoshiSortChooseView = class("BaoshiSortChooseView", BaseLayer)

function BaoshiSortChooseView:ctor(raritys)
    self.super.ctor(self)
    self:initData(raritys)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fairyNew.baoshiSortChooseView")
end

function BaoshiSortChooseView:initData(raritys)
    self.paramRaritys = raritys
    self.rarity_ = {}
end

function BaoshiSortChooseView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.quality_items = {}
    for i = 1, 7 do
        local item = TFDirector:getChildByPath(ui, "Panel_quality_item"..i)
        table.insert(self.quality_items, item)
    end
    for i, item in ipairs(self.quality_items) do
        if table.indexOf(self.paramRaritys, i) ~= -1 then
            self:onItemClick(i, item)
        end
    end
    self:updateBtnState()
end

function BaoshiSortChooseView:onItemClick(rarity, item)
    local idx = table.indexOf(self.rarity_, rarity)
    if idx ~= -1 then
        table.remove(self.rarity_, idx)
    else
        table.insert(self.rarity_, rarity)
    end
    for i,item in ipairs(self.quality_items) do
        local Image_bg = TFDirector:getChildByPath(item, "Image_bg")
        if table.indexOf(self.rarity_, i) ~= -1 then
            Image_bg:setTexture("ui/fairy/new_ui/baoshi/024.png")
        else
            Image_bg:setTexture("ui/fairy/new_ui/baoshi/025.png")
        end
    end
    self:updateBtnState()
end

function BaoshiSortChooseView:updateBtnState()
    -- if #self.rarity_ > 0 then
    --     self.Button_ok:setTouchEnabled(true)
    --     self.Button_ok:setGrayEnabled(false)
    -- else
    --     self.Button_ok:setTouchEnabled(false)
    --     self.Button_ok:setGrayEnabled(true)
    -- end
end

function BaoshiSortChooseView:registerEvents()
    for i,item in ipairs(self.quality_items) do
        item:setTouchEnabled(true)
        item:onClick(function()
            self:onItemClick(i, item)
        end)
    end

    self.Button_ok:onClick(function()
        EventMgr:dispatchEvent(EQUIPMENT_GEM_QUALITY_SORT, self.rarity_)
        AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return BaoshiSortChooseView