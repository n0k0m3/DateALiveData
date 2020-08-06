local DatingTestView = class("DatingTestView",BaseLayer)

local DatingScriptConfig = require("lua.logic.dating.DatingScriptConfig")

function DatingTestView:initData(...)
    self.datingTableConfigList = DatingScriptConfig.tableConfig
    self.selectTypeList = DatingScriptConfig.selectType
    self.curDatingTableName = ""
    self.selectItemList = {}
end

function DatingTestView:ctor(...)
    self.super.ctor(self)

    self:initData(...)

    self:init("lua.uiconfig.dating.datingTestView")
end

function DatingTestView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Button_back = TFDirector:getChildByPath(self.ui, "Button_back"):hide()
    self.Button_cgEdit = TFDirector:getChildByPath(self.ui, "Button_cgEdit")

    self:initPanelQuick()
    self:initSelectListView()

    self:hideSelectListView()

    -- local params = {
    --     _type = EC_InputLayerType.SEND,
    --     buttonCallback = function()
    --         self:onTouchSendBtn()
    --     end,
    --     closeCallback = function()
    --         self:onCloseInputLayer()
    --     end
    -- }
    -- self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    -- self:addLayer(self.inputLayer,1000);
end

function DatingTestView:initPanelQuick()
    self.Panel_quick = TFDirector:getChildByPath(self.ui, "Panel_quick")

    self.Button_Item = TFDirector:getChildByPath(self.ui, "Button_Item")

    self.TextField_tableNameItem = TFDirector:getChildByPath(self.Panel_quick,"TextField_tableNameItem")
    self.TextField_input1 = TFDirector:getChildByPath(self.Panel_quick,"TextField_input1")
    self.TextField_input2 = TFDirector:getChildByPath(self.Panel_quick,"TextField_input2")

    self.Button_selectTable = TFDirector:getChildByPath(self.Panel_quick,"Button_selectTable")
    self.Button_selectScript = TFDirector:getChildByPath(self.Panel_quick,"Button_selectScript")
    self.Button_enter = TFDirector:getChildByPath(self.ui, "Button_enter")
end

function DatingTestView:setTextField(textField, text, stype)
    if stype == self.selectTypeList.DatingName then
        self.curDatingTableName = text
    end

    textField:setText(text)
end

function DatingTestView:initSelectListView()
    self.Panel_selectView = TFDirector:getChildByPath(self.ui, "Panel_selectView")
    local ScrollView_select = TFDirector:getChildByPath(self.Panel_selectView, "ScrollView_select")
    self.selectListView = UIGridView:create(ScrollView_select)
    self.selectListView:setItemModel(self.Button_Item)
    self.selectListView:setColumn(3)
    self.selectListView:setColumnMargin(15)
    self.selectListView:setRowMargin(15)
end

function DatingTestView:showSelectListView(selectType)
    if selectType == self.selectTypeList.ScriptId and self.curDatingTableName == "" then
        Utils:showTips(100000030)
        return
    end
    self.Panel_selectView:setVisible(true)
    self:updateSelectListView(selectType)
end

function DatingTestView:hideSelectListView()
    self.Panel_selectView:setVisible(false)
    self.selectListView:removeAllItems()
    self.selectItemList = {}
end

function DatingTestView:updateSelectListView(selectType)
    if selectType == self.selectTypeList.ScriptId then
        if self.curDatingTableName ~= "" and self.datingTableConfigList[self.curDatingTableName] then
            local scriptIdList = self.datingTableConfigList[self.curDatingTableName].scriptIdList
            for i,v in ipairs(scriptIdList) do
                local item = self.selectListView:pushBackDefaultItem()
                item.type = selectType
                self:initScriptIdItem(item,v)
            end
        end
    elseif selectType == self.selectTypeList.DatingName then
        for k,v in pairs(self.datingTableConfigList) do

            local item = self.selectListView:pushBackDefaultItem()
            item.type = selectType
            self:initTableNameItem(item,v.name)
        end
    end

end

function DatingTestView:initTableNameItem(item,name)
    local Label_tableName = TFDirector:getChildByPath(item, "Label_tableName")
    Label_tableName:setText(name)
    item:Pos(item.pos)
    item.name = name

    item:onClick(function()
            self:onClickItem(item)
        end)
end

function DatingTestView:initScriptIdItem(item,name)
    local Label_tableName = TFDirector:getChildByPath(item, "Label_tableName")
    Label_tableName:setText(name)
    item:Pos(item.pos)
    item.name = name

    item:onClick(function()
            self:onClickItem(item)
        end)
end

function DatingTestView:onClickItem(item)
    local textField = nil
    if item.type == self.selectTypeList.DatingName then
        self.TextField_tableNameItem:setText(item.name)
        self:refreshTextField()
        textField = self.TextField_tableNameItem
    elseif item.type == self.selectTypeList.ScriptId then
        self.TextField_input1:setText(item.name)
        textField = self.TextField_input1
    end

    self:setTextField(textField, item.name, item.type)
    if item.type == self.selectTypeList.ScriptId then
        print("self.curDatingTableName ",self.curDatingTableName)
        local data = self.datingTableConfigList[self.curDatingTableName].scriptIdList
        local is, idx = self:findScriptIdToTable(tonumber(item.name),data)
        local id = self.datingTableConfigList[self.curDatingTableName].startIdList[idx]
        if id then
            self:setTextField(self.TextField_input2,id,self.selectTypeList.ScriptId)
        end
    end
    self:hideSelectListView()
end

function DatingTestView:refreshTextField()
    self.TextField_input1:setText("")
    self.TextField_input2:setText("")
end

function DatingTestView:findIdToTable(id,data)
    for k,v in pairs(data) do
        if k == id then
            return true
        end
    end
    return false
end

function DatingTestView:findScriptIdToTable(scriptId,data)
    for i,v in ipairs(data) do
        if v == scriptId then
            return true,i
        end
    end
    return false
end

function DatingTestView:checkId(id)

    local data = TabDataMgr:getData(self.curDatingTableName)
    if not data then
        Utils:showTips(100000031)
        return false
    end
    if not self:findIdToTable(id,data) then
        -- Utils:showTips("剧情ID：".. id .. "不存在于" .. self.curDatingTableName .. "表中，请输入正确的剧情ID")
        Utils:showTips(100000032,id,self.curDatingTableName)

        return false
    end

    return true
end

function DatingTestView:onTouchSendBtn()
    local content
    if self.TextField_input2:getText() ~= "" then
        local scriptId = tonumber(self.TextField_input1:getText())
        if not self.datingTableConfigList[self.curDatingTableName] then
            Utils:showTips(100000031)
            return
        end

        if not self:findScriptIdToTable(scriptId,self.datingTableConfigList[self.curDatingTableName].scriptIdList) then
            -- Utils:showTips("剧本ID：".. scriptId .. "不存在于" .. self.curDatingTableName .. "表中，请输入正确的剧本ID")
             Utils:showTips(100000032,scriptId,self.curDatingTableName)
            return
        end
        local id = tonumber(self.TextField_input2:getText())
        if not self:checkId(id) then
            return
        end
        content = self.TextField_input2:getText()
    else
        local scriptId = tonumber(self.TextField_input1:getText())
        if not self.datingTableConfigList[self.curDatingTableName] then
            Utils:showTips(100000031)
            return
        end

        if not self:findScriptIdToTable(scriptId,self.datingTableConfigList[self.curDatingTableName].scriptIdList) then
            -- Utils:showTips("剧本ID：".. scriptId .. "不存在于" .. self.curDatingTableName .. "表中，请输入正确的剧本ID")
            Utils:showTips(100000032,scriptId,self.curDatingTableName)
        else
            local is, idx = self:findScriptIdToTable(scriptId,self.datingTableConfigList[self.curDatingTableName].scriptIdList)
            if idx and self.datingTableConfigList[self.curDatingTableName].startIdList[idx] then
                local id = self.datingTableConfigList[self.curDatingTableName].startIdList[idx]
                if not self:checkId(id) then
                    return
                end
                content = id
            end
        end
    end

    DatingDataMgr:setScriptTableName(self.curDatingTableName)
    DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,tonumber(content),nil,nil,true)
end

-- function DatingTestView:onCloseInputLayer()
--     self.TextField_id:closeIME()
--     self.TextField_id:setText("")
-- end

function DatingTestView:registerEvents()
    self.super.registerEvents(self)


    -- local function onTextFieldChangedHandleAcc(input)
    --     self.TextField_id:setText(input:getText())
    --     self.inputLayer:listener(input:getText())
    -- end

    -- local function onTextFieldAttachAcc(input)
    --     self.inputLayer:show();
    --     self.inputLayer:listener(input:getText())
    -- end

    -- self.TextField_id:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    -- self.TextField_id:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    -- self.TextField_id:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_selectTable:onClick(function()
            self:showSelectListView(self.selectTypeList.DatingName)
        end)

    self.Button_selectScript:onClick(function()
            self:showSelectListView(self.selectTypeList.ScriptId)
        end)

    self.Button_enter:onClick(function()
            self:onTouchSendBtn()
        end)


    self.Button_back:onClick(function()
            AlertManager:closeLayer(self)
        end)

    self.Button_cgEdit:onClick(function()
            local specialEffectsTestLayer = require("lua.logic.dating.SpecialEffectsTestLayer"):new()
            AlertManager:addLayer(specialEffectsTestLayer,AlertManager.BLOCK,AlertManager.TWEEN_NONE)
            AlertManager:show()
        end)

end

function DatingTestView:onClose()
    self.super.onClose(self)
end


return DatingTestView
