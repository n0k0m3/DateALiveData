
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
    self.starData = Utils:getKVP(90019,"starData")
    self.suitData = Utils:getKVP(90019,"suitData")
    self.colorData = Utils:getKVP(90019,"colorData")
    self.typeData = Utils:getKVP(90019,"typeData")
    self.selectType = {}
    self.selectType[1] = true
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

    self.GridView_type = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_type"))
    self.GridView_star = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_star"))
    self.GridView_suit = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_suit"))
    self.GridView_color = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_color"))
    self.GridView_word = UIGridView:create(TFDirector:getChildByPath(ui, "ScrollView_word"))

    self.GridView_type:setItemModel(self.Panel_item)
    self.GridView_type:setColumn(2)
    self.GridView_type:setColumnMargin(5)
    self.GridView_type:setRowMargin(5)

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
    self.typeItems = {}
    for i, v in ipairs(self.typeData) do
        local item = self.Panel_item:clone()
        TFDirector:getChildByPath(item,"Label_item_name"):setText(v.name)
        self.GridView_type:pushBackCustomItem(item)
        self.typeItems[i] = item
    end
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
        self:updateTypeItems()
        self:updateStarItms()
        self:updateSuitItems()
    else
        self.Panel_scroll_word:show()
        self.Panel_scroll_base:hide()
        self:updateColorItms()
        self:updateWordItems()
    end 
end

function EquipConvertChooseCondition:updateTypeItems()
    for i, item in ipairs(self.typeItems) do
        TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_1.png")
        TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(162,164,200))
        if self.selectType[i] then
            TFDirector:getChildByPath(item,"Image_bg"):setTexture("ui/Equipment/new_ui/shaixuan/JLXL_bg_7_2.png")
            TFDirector:getChildByPath(item,"Label_item_name"):setColor(ccc3(255,255,255))
        end
        item:setTouchEnabled(true)
        item:onClick(function()
            if not self.selectType[i] then
                self.selectType = {}
                self.selectType[i] = true
            end
            self:updateTypeItems()
        end)
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
        local isRevert = self.selectType[2] -- 反向选择
        local starId = {}
        local suitId = {}
        local colorId = {}
        local wordsId = {}

        local isRevert = false -- 反向逻辑放到外部出来 此处强制为false
        if isRevert then
            for k,v in pairs (self.starData) do
                table.insert(starId, v.id)
            end

            for k,v in pairs (self.suitData) do
                table.insert(suitId, v.id)
            end

            for k,v in pairs (self.colorData) do
                table.insert(colorId, v.id)
            end

            for k,v in pairs (self.wordsData) do
                table.insert(wordsId, v.id)
            end
        end

        local function removeObject( tab, obj )
            -- body
            for k,v in pairs(tab) do
                if v == obj then
                    table.remove(tab,k)
                end
            end
        end

        for k, v in pairs(self.selectStar) do
            if isRevert then
                removeObject(starId,self.starData[k].id)
            else
                table.insert(starId, self.starData[k].id)
            end
        end

        for k, v in pairs(self.selectSuit) do
            if isRevert then
                removeObject(suitId,self.suitData[k].id)
            else
                table.insert(suitId, self.suitData[k].id)
            end
        end
        for k, v in pairs(self.selectColor) do
            if isRevert then
                removeObject(colorId, self.colorData[k].id)
            else
                table.insert(colorId, self.colorData[k].id)
            end
        end
        for k, v in pairs(self.selectWord) do
            if isRevert then
                removeObject(wordsId, self.wordsData[k].id)
            else
                table.insert(wordsId, self.wordsData[k].id)
            end
        end
        EventMgr:dispatchEvent(EQUIPMENT_CONVERT_CHOOSE_CONDITION,{isRevert = self.selectType[2] ,star = starId,suit = suitId,color = colorId,word = wordsId})
        AlertManager:closeLayer(self)
    end)

    self.Button_reset:onClick(function()
        self.selectStar = {}
        self.selectSuit = {}
        self.selectColor = {}
        self.selectWord = {}
        self:refreshPanelItems()
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
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
