
local EquipConvertChooseCondition = class("EquipConvertChooseCondition", BaseLayer)

function EquipConvertChooseCondition:initData()
    self.tabIdx = 1
    local equipRandom = TabDataMgr:getData("EquipmentRandom")
    local attrs = {}
    self.wordsData = {}
    local attrIds = TabDataMgr:getData("DiscreteData",52002).data.attributeId
    for k, v in pairs(attrIds) do
        local cfg = equipRandom[v]
        if not attrs[cfg.superType] then
            attrs[cfg.superType] = true
            local desc = TextDataMgr:getText(tonumber(cfg.des))
            desc = string.gsub(desc,"+","")
            desc = string.gsub(desc,"-","")
            desc = string.gsub(desc,"%%","")
            desc = string.gsub(desc,".2f","")
            table.insert(self.wordsData,{id = cfg.superType, name = desc})
        end
    end
    table.sort(self.wordsData,function(a,b)
        return a.id < b.id
    end)
    self.starData = {{id = 1, name = "一星"},{id = 2, name = "二星"},{id = 3, name = "三星"},{id = 4, name = "四星"},{id = 5, name = "五星"}}
    self.suitData = {{id = 1, name = "单件"},{id = 2, name = "套装"}}
    self.colorData = {{id = 1, name = "绿色词缀"},{id = 2, name = "蓝色词缀"},{id = 3, name = "紫色词缀"},{id = 4, name = "橙色词缀"},{id = 5, name = "红色词缀"}}
    self.selectStar = {}
    self.selectSuit = {}
    self.selectColor = {}
    self.selectWord = {}
end

function EquipConvertChooseCondition:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.Equip.EquipConvertChooseCondition")
end

function EquipConvertChooseCondition:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self:showTopBar()

    self.Panel_item = TFDirector:getChildByPath(ui, "Panel_item")
    self.Panel_btns = TFDirector:getChildByPath(ui, "Panel_btns")

    self.Button_ok = TFDirector:getChildByPath(ui, "Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self.Button_reset = TFDirector:getChildByPath(ui, "Button_reset")

    self.Button_base = TFDirector:getChildByPath(self.Panel_btns, "Button_base")
    self.Button_word = TFDirector:getChildByPath(self.Panel_btns, "Button_word")
    self.Panel_scroll_base = TFDirector:getChildByPath(ui, "Panel_scroll_base")
    self.Panel_scroll_word = TFDirector:getChildByPath(ui, "Panel_scroll_word")
    self.btn_list = {base = self.Button_base,words = self.Button_word}

    self.GridView_star = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_star"))
    self.GridView_suit = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_suit"))
    self.GridView_color = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_color"))
    self.GridView_word = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_word"))

    self.GridView_star:setItemModel(self.Panel_item)
    self.GridView_star:setColumn(2)
    self.GridView_star:setColumnMargin(5)
    self.GridView_star:setRowMargin(5)

    self.GridView_suit:setItemModel(self.Panel_item)
    self.GridView_suit:setColumn(2)
    self.GridView_suit:setColumnMargin(5)
    self.GridView_suit:setRowMargin(5)

    self.GridView_color:setItemModel(self.Panel_item)
    self.GridView_color:setColumn(2)
    self.GridView_color:setColumnMargin(5)
    self.GridView_color:setRowMargin(5)

    self.GridView_word:setItemModel(self.Panel_item)
    self.GridView_word:setColumn(2)
    self.GridView_word:setColumnMargin(5)
    self.GridView_word:setRowMargin(5)

    self:initPanelItems()
    self:changeBtnSelStatus("base")
end

function EquipConvertChooseCondition:initPanelItems()
    self.starItems = {}
    self.suitItems = {}
    self.colorItems = {}
    self.wordsItems = {}
    for i, v in ipairs(self.starData) do
        local item = self.Panel_item:clone()
        TFDirector:getChildByPath(item,"Label_item_name"):setText(v.name)
        self.GridView_star:pushBackCustomItem(item)
        self.starItems[i] = item
    end
    for i, v in ipairs(self.suitData) do
        local item = self.Panel_item:clone()
        TFDirector:getChildByPath(item,"Label_item_name"):setText(v.name)
        self.GridView_suit:pushBackCustomItem(item)
        self.suitItems[i] = item
    end
    for i, v in ipairs(self.colorData) do
        local item = self.Panel_item:clone()
        TFDirector:getChildByPath(item,"Label_item_name"):setText(v.name)
        local Image_flag = TFDirector:getChildByPath(item,"Image_flag"):show()
        Image_flag:setTexture(self:getColorImage(self.colorData[i].id))
        self.GridView_color:pushBackCustomItem(item)
        self.colorItems[i] = item
    end
    for i, v in ipairs(self.wordsData) do
        local item = self.Panel_item:clone()
        TFDirector:getChildByPath(item,"Label_item_name"):setText(v.name)
        self.GridView_word:pushBackCustomItem(item)
        self.wordsItems[i] = item
    end
end

function EquipConvertChooseCondition:getColorImage(color)
    if color == 1 then
        return "ui/Equipment/new_ui/new_23.png"
    elseif color == 2 then
        return "ui/Equipment/new_ui/new_19.png"
    elseif color == 3 then
        return "ui/Equipment/new_ui/new_18.png"
    elseif color == 4 then
        return "ui/Equipment/new_ui/new_21.png"
    elseif color == 5 then
        return "ui/Equipment/new_ui/new_20.png"
    end
end

function EquipConvertChooseCondition:refreshPanelItems()
    if self.tabIdx == 1 then
        self.Panel_scroll_word:hide()
        self.Panel_scroll_base:show()
        self:updateStarItms()
        self:updateSuitItems()
    else
        self.Panel_scroll_word:show()
        self.Panel_scroll_base:hide()
        self:updateColorItms()
        self:updateWordItems()
    end 
end

function EquipConvertChooseCondition:updateStarItms()
    for i, item in ipairs(self.starItems) do
        TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_1.png")
        TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(162,164,200))
        if self.selectStar[i] then
            TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_2.png")
            TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(255,255,255))
        end
        item:setTouchEnabled(true)
        item:onClick(function()
            if self.selectStar[i] then
                self.selectStar[i] = nil
            else
                self.selectStar[i] = true
            end
            self:updateStarItms()
        end)
    end
end

function EquipConvertChooseCondition:updateSuitItems()
    for i, item in ipairs(self.suitItems) do
        TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_1.png")
        TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(162,164,200))
        if self.selectSuit[i] then
            TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_2.png")
            TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(255,255,255))
        end
        item:setTouchEnabled(true)
        item:onClick(function()
            if self.selectSuit[i] then
                self.selectSuit[i] = nil
            else
                self.selectSuit[i] = true
            end
            self:updateSuitItems()
        end)
    end
end

function EquipConvertChooseCondition:updateColorItms()
    for i, item in ipairs(self.colorItems) do
        TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_1.png")
        TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(162,164,200))
        if self.selectColor[i] then
            TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_2.png")
            TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(255,255,255))
        end
        item:setTouchEnabled(true)
        item:onClick(function()
            if self.selectColor[i] then
                self.selectColor[i] = nil
            else
                self.selectColor[i] = true
            end
            self:updateColorItms()
        end)
    end
end

function EquipConvertChooseCondition:updateWordItems()
    for i, item in ipairs(self.wordsItems) do
        TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_1.png")
        TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(162,164,200))
        if self.selectWord[i] then
            TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_2.png")
            TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(255,255,255))
        end
        item:setTouchEnabled(true)
        item:onClick(function()
            if self.selectWord[i] then
                self.selectWord[i] = nil
            else
                self.selectWord[i] = true
            end
            self:updateWordItems()
        end)
    end
end

function EquipConvertChooseCondition:changeBtnSelStatus(selname)
    for k,v in pairs(self.btn_list) do
        if k == selname then
            v:setTextureNormal("ui/setting/uires/002.png")
        else
            v:setTextureNormal("")
        end
    end
    self:refreshPanelItems()
end

function EquipConvertChooseCondition:registerEvents()
    self.Button_ok:onClick(function ()
        local starId = {}
        local suitId = {}
        local colorId = {}
        local wordsId = {}
        for k, v in pairs(self.selectStar) do
            table.insert(starId, self.starData[k].id)
        end

        for k, v in pairs(self.selectSuit) do
            table.insert(suitId, self.suitData[k].id)
        end
        for k, v in pairs(self.selectColor) do
            table.insert(colorId, self.colorData[k].id)
        end
        for k, v in pairs(self.selectWord) do
            table.insert(wordsId, self.wordsData[k].id)
        end
        EventMgr:dispatchEvent(EQUIPMENT_CONVERT_CHOOSE_CONDITION,{star = starId,suit = suitId,color = colorId,word = wordsId})
        AlertManager:close(self)
    end)

    self.Button_reset:onClick(function()
        self.selectStar = {}
        self.selectSuit = {}
        self.selectColor = {}
        self.selectWord = {}
        self:refreshPanelItems()
    end)

    self.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    self.Button_base:onClick(function()
        self.tabIdx = 1
        self:changeBtnSelStatus("base")
    end)

    self.Button_word:onClick(function()
        self.tabIdx = 2
        self:changeBtnSelStatus("words")
    end)
end

function EquipConvertChooseCondition:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function EquipConvertChooseCondition:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function EquipConvertChooseCondition:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

return EquipConvertChooseCondition
