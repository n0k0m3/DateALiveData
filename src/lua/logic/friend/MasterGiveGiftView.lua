--[[
    @师傅赠礼界面
]]
local MasterGiveGiftView = class("MasterGiveGiftView", BaseLayer)

-- 一个cell的item数量
local LineCellItemNum = 6

function MasterGiveGiftView:initData()

    self.SortBtns = {     -- 排序用
        "sum",
    }

    self.DataType = {
        sum = TextDataMgr:getText(1340071),
    }

    self.orderText = {301018, 301019}
    self.selectOrderIndex = 1

    self.LimitMaxGive = Utils:getKVP(90023, "quantityDonation")

    self.disCreteData = Utils:getKVP(90024)
    for key, value in pairs(self.disCreteData) do
        table.insert(self.SortBtns, key)
        if not self.DataType[key] then
            self.DataType[key] = value.name
        end
    end

    self.AllData = FriendDataMgr:getMasterCanGiveData()
    -- 默认类型
    self.curChooseType = "sum"
    -- 当前可以选择的数据(默认)
    self.canBeGivenData = self.AllData[self.curChooseType]
    -- 已经选择的右边view数据
    self.hadChooseData = {}
    -- 统计配置的各个类型选中个数
    self.curChooseNum = {}
    for key, _ in pairs(self.DataType) do
        if not self.curChooseNum[key] then
            self.curChooseNum[key] = 0
        end
    end

    self.isFlyOver = true
    self:refeshSortData()
end

function MasterGiveGiftView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.friend.masterGiveGiftView")
end

function MasterGiveGiftView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui 
    self.chooseTableView = Utils:scrollView2TableView(self._ui.chooseTableView)

    self._ui.panel_top:setZOrder(999)
    
    self.sureGiveView = UIGridView:create(self._ui.sureGiveView)
    self.sureGiveView:setItemModel(self._ui.Panel_headItem)
    self.sureGiveView:setColumn(4)
    self.sureGiveView:setColumnMargin(-3)
    self.sureGiveView:setRowMargin(-5)

    self._ui.Panel_sortRule:hide()
    self._ui.Panel_order:hide()
    self._ui.Button_rule:hide()

    self:initSortType()
    self:refreshLab()
end

function MasterGiveGiftView:initSortType()
    self._ui.Label_sortRule:setText(self.DataType[self.curChooseType])
    local pos_1 = self._ui.Button_rule:getPosition()
    for i, _type in ipairs(self.SortBtns) do
        local size  = self._ui.Button_rule:getSize()
        local Button_rule = self._ui.Button_rule:clone()
        self._ui.Panel_sortRule:addChild(Button_rule)
        Button_rule:setPosition(ccp(pos_1.x, pos_1.y - size.height*(i - 1)))
        local Label_nameSelect = TFDirector:getChildByPath(Button_rule, "Label_nameSelect")
        Label_nameSelect:setText(self.DataType[_type])
        Button_rule:show()
        Button_rule:onClick(function()
            self.curChooseType = _type
            self:btnRuleType(_type)
        end)
    end

    self._ui.Label_order_name:setTextById(self.orderText[self.selectOrderIndex])
    for i = 1, table.count(self.orderText) do
        local Label_order = self._ui[string.format("Label_order_%s",i)]
        Label_order:setTextById(self.orderText[i])
        local btn = self._ui[string.format("Button_order_%s",i)]
        btn:onClick(function()
            self._ui.Image_order_icon:setFlipY(self.selectOrderIndex ~= 1)
            self.selectOrderIndex = i
            self:btnRuleType(self.curChooseType)
        end)
    end
end

function MasterGiveGiftView:btnRuleType(_type)
    self._ui.Panel_sortRule:setVisible(false)
    self._ui.Panel_order:setVisible(false)
    self.canBeGivenData = self:filterHadSelect(self.AllData[_type])
    self:refeshSortData()
    self._ui.Label_sortRule:setText(self.DataType[self.curChooseType])
    self._ui.Label_order_name:setTextById(self.orderText[self.selectOrderIndex])
    self.chooseTableView:reloadData()
end

function MasterGiveGiftView:refeshSortData()
    local isUp = self.selectOrderIndex == 2 and true or false 
    table.sort(self.canBeGivenData, function(a, b)
        local cfgA = GoodsDataMgr:getItemCfg(a.cid)
        local cfgB = GoodsDataMgr:getItemCfg(b.cid)
        local ause = (EquipmentDataMgr:checkGemInUse(a.id) == true and 1 or 0)
        local buse = (EquipmentDataMgr:checkGemInUse(b.id) == true and 1 or 0)

        -- TODO
        if cfgA.type and cfgB.type then  --baoshi ?
            if cfgA.type == cfgB.type then
                if ause == buse then
                    if cfgA.quality == cfgB.quality then
                        if cfgA.heroId == cfgB.heroId then
                            return cfgA.id < cfgB.id
                        end
                        return cfgA.heroId < cfgB.heroId
                    else
                        if not isUp then
                            return cfgA.quality > cfgB.quality
                        else
                            return cfgA.quality < cfgB.quality
                        end
                    end
            else
                    return ause < buse
            end
            else
                return cfgA.type < cfgB.type
            end
        elseif cfgA.quality and cfgB.quality then -- tupo ?
            if cfgA.quality == cfgB.quality then
                return cfgA.id < cfgB.id
            else
                if not isUp then
                    return cfgA.quality > cfgB.quality
                else
                    return cfgA.quality < cfgB.quality
                end
            end
        end 

        -- if isUp then
        --     return a.cid < b.cid
        -- else
        --     return a.cid > b.cid
        -- end
    end)
end

-- 剔除当前可赠送材料已选择了的
function MasterGiveGiftView:filterHadSelect(data)
    local tmp = {}
    for i, v in ipairs(data) do
        local _tmpData = v
        for j, hadSelectData in ipairs(self.hadChooseData) do
            if v.cid == hadSelectData.cid then
                if v.num and v.num ~= hadSelectData.num then  -- 有材料数量的情况
                    _tmpData.num = v.num - hadSelectData.num
                else
                    _tmpData = nil
                end
            end
        end

        if _tmpData then
            table.insert(tmp, _tmpData)
        end
    end
    return tmp
end

function MasterGiveGiftView:refreshLab()
    self._ui.lab_giveGiftNum:setText(self.curChooseNum["sum"].."/"..self.LimitMaxGive)
end

-- 获取选中材料隶属类型
function MasterGiveGiftView:getTypeByCid(_cid)
    for key, value in pairs(self.disCreteData) do
        local data = self.AllData[key]
        for i, v in ipairs(data) do
            if v.cid == _cid then
                return key
            end
        end
    end
end

function MasterGiveGiftView:registerEvents()

    EventMgr:addEventListener(self,EV_FREND_MASTERGIVEGIFT_UPDATE, function()
        AlertManager:close(self)
    end)

    self._ui.Button_sortRule:onClick(function()
        self._ui.Panel_sortRule:setVisible(not self._ui.Panel_sortRule:isVisible())
    end)
    
    self._ui.Button_sort_order:onClick(function()
        self._ui.Panel_order:setVisible(not self._ui.Panel_order:isVisible())
    end)

    self.chooseTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.getCellSize,self))
    self.chooseTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.getNumberOfCells,self))
    self.chooseTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.cellAtIndex,self))
    self.chooseTableView:reloadData()
    
    self._ui.btn_sureGive:onClick(function()
        local data = {}
        for i, v in ipairs(self.hadChooseData) do 
            table.insert(data, {v.cid, v.num or 1})
        end
        if table.count(data) == 0 then
            Utils:showTips(1340010)
            return
        end
        FriendDataMgr:send_APPRENTICE_REQ_SEND_GIFT(data)
    end)
end

-- @desc:当type为sum时，要自己再判断一下子属类型
function MasterGiveGiftView:setChooseTypeNum(cid, num)
    local _type = self:getTypeByCid(cid)
    self.curChooseNum[_type] = self.curChooseNum[_type] + num
    self.curChooseNum["sum"] = self.curChooseNum["sum"] + num
end

function MasterGiveGiftView:getCellSize()
    local size = self._ui.Panel_cellHeadItem:getSize()
    return size.height - 10 , size.width - 5
end

function MasterGiveGiftView:getNumberOfCells()
    local num = math.ceil(table.count(self.canBeGivenData) / LineCellItemNum)
    return num
end

function MasterGiveGiftView:cellAtIndex(tableView, idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.Panel_cellHeadItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshCellItem(item,index)
    return cell
end

function MasterGiveGiftView:refreshCellItem(item, idx)
    for i, _item in ipairs(item:getChildren()) do
        local index = (idx - 1)*LineCellItemNum + i
        local data  = self.canBeGivenData[index]
        if data then
            self:updateGoodsItem(_item, index, true)
            _item:show()
        else
            _item:hide()
        end
    end
end

--[[
	--@isGive: 是否划到赠送 
]]
function MasterGiveGiftView:chooseItem(item, index, isGive)
    local data,endPos
    if isGive then
        data = self.canBeGivenData[index]
        endPos = self._ui.sureGiveView:convertToWorldSpace(self._ui.sureGiveView:getPosition())

        local chooseType = self:getTypeByCid(data.cid)
        if self.curChooseNum["sum"] >= self.LimitMaxGive then
            Utils:showTips(1340011)
            return
        elseif self.curChooseNum[chooseType] >= self.disCreteData[chooseType].amount then
            Utils:showTips(TextDataMgr:getText(1340012, self.DataType[chooseType]))
            return
        end
    else
        data = self.hadChooseData[index]
        endPos = self.chooseTableView:convertToWorldSpace(self.chooseTableView:getPosition())
    end

    -- 数量为1 直接飞过去
    if data.superType == EC_ResourceType.SPIRIT or data.superType == EC_ResourceType.BAOSHI or data.num == 1 then
        self.isFlyOver = false
        item:hide()
        local item_ = item:clone()
        item_:show()
        item_:retain()
        self.ui:addChild(item_, 99)
        item_:setPosition(item:convertToWorldSpace(item:getPosition()))

        local function endFunc()
            item_:removeFromParent()
            if not data.num then 
                if isGive then
                    table.insert(self.hadChooseData, data)
                    self:setChooseTypeNum(data.cid ,1)
                    table.remove(self.canBeGivenData, index)
                    self:updateGoodsItem(item_, table.count(self.hadChooseData), false)
                    self.sureGiveView:pushBackCustomItem(item_)
                else
                    table.insert(self.canBeGivenData, data)
                    table.remove(self.hadChooseData, index)
                    self:setChooseTypeNum(data.cid, -1)
                    self.sureGiveView:removeLastItem()
                    for i, item in pairs(self.sureGiveView:getItems()) do
                        item:show()
                        self:updateGoodsItem(item, i, false)
                    end
                end
                self.chooseTableView:reloadData()
                self:refreshLab()
            else
                self:popChooseCloseCallFunc(data, 1, isGive, index)
            end
            item_:release()
            self.isFlyOver = true
        end
        endFunc()
        -- self:itemFlyToPos(item_,endPos,endFunc)
    else
        local maxNum 
        if isGive then
            local chooseType = self:getTypeByCid(data.cid)
            local maxNum1 = self.disCreteData[chooseType].amount - self.curChooseNum[chooseType]
            local maxNum2 = self.LimitMaxGive - self.curChooseNum["sum"]
            maxNum =  math.min(maxNum1, maxNum2)
            maxNum = math.min(maxNum, data.num)
        else
            maxNum = data.num
        end
        Utils:openView("friend.MasterSelectPopView",data, maxNum, isGive, index, handler(self.popChooseCloseCallFunc, self))
    end
end

function MasterGiveGiftView:popChooseCloseCallFunc(chooseData, selectNum, isGive, index)
    -- dump(chooseData)
    chooseData.num = chooseData.num - selectNum

    local function dealDataFunc(tmpData, isNeedPushItem)
        local isExist = true
        for i, v in ipairs(tmpData) do
            if v.id == chooseData.id then
                v.num = v.num + selectNum
                isExist = false
            end
        end
        if isExist then
            local _data = clone(chooseData)
            _data.num = selectNum
            table.insert(tmpData, _data)
            if isNeedPushItem then
                self.sureGiveView:pushBackDefaultItem()
            end
        end
    end

    if isGive then
        dealDataFunc(self.hadChooseData,true)
        self:setChooseTypeNum(chooseData.cid, selectNum)
        if chooseData.num <= 0 then
            chooseData = nil
            table.remove(self.canBeGivenData, index)
        end
    else
        dealDataFunc(self.canBeGivenData, false)
        self:setChooseTypeNum(chooseData.cid, -selectNum)
        if chooseData.num <= 0 then
            chooseData = nil
            self.sureGiveView:removeLastItem()
            table.remove(self.hadChooseData, index)
        end
    end

    self.chooseTableView:reloadData()
    for i, item in pairs(self.sureGiveView:getItems()) do
        item:show()
        self:updateGoodsItem(item, i, false)
    end
    self:refreshLab()
end

function MasterGiveGiftView:isHaveInGridView()
    
end

function MasterGiveGiftView:itemFlyToPos(item_, endPos, endFunc)
    local action = Sequence:create({
        MoveBy:create(0.2,endPos),
        CallFunc:create(function()
            if endFunc then
                endFunc()
            end
        end)
    })
    item_:runAction(action)
end

function MasterGiveGiftView:updateGoodsItem(_item, index, isGive)
    local data
    if isGive then
        data = self.canBeGivenData[index]
    else
        data = self.hadChooseData[index]
    end

    local Panel_head   = TFDirector:getChildByPath(_item, "Panel_head")
    local Image_carry  = TFDirector:getChildByPath(_item, "Image_carry")
    local Panel_pos    = TFDirector:getChildByPath(_item, "Panel_pos")
    local Image_select = TFDirector:getChildByPath(_item, "Image_select"):hide()

    if not Panel_head.item then
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Pos(0, 0)
        Panel_goodsItem:AddTo(Panel_head)
        Panel_head.item = Panel_goodsItem
    end
    if Panel_head.item.ListView_star then
        Panel_head.item.ListView_star:removeAllItems()
    end
    Panel_head.item.ListView_star   = nil
    PrefabDataMgr:setInfo(Panel_head.item, data.id, data.num)

    -- 是否装备
    local isCarry = false
    if data.superType == EC_ResourceType.SPIRIT then
        isCarry = EquipmentDataMgr:isUesing(data.id)
        Image_carry:setVisible(isCarry)
    elseif data.superType == EC_ResourceType.BAOSHI then
        isCarry = EquipmentDataMgr:checkGemInUse(data.id)
        Image_carry:setVisible(isCarry)
    else
        Image_carry:hide()
    end

    Panel_head.item:setTouchEnabled(true)
    Panel_head.item:onClick(function()
        if self.isFlyOver then
            if isCarry and isGive then -- 赠送已穿戴
                local args = {
		            tittle = 2107025,
		            content = TextDataMgr:getText(1340052),
		            confirmCall = function()
                        -- self:chooseItem(_item, index, isGive)
                    end,
		        }
		        Utils:showReConfirm(args)
            else
                self:chooseItem(_item, index, isGive)
            end
        end
    end)

    if data.superType == EC_ResourceType.BAOSHI then
        Panel_pos:show()
        TFDirector:getChildByPath(Panel_pos, "Image_pos_bg"):setTexture(EquipmentDataMgr:getGemPosBg(data.quality))
        for i = 1, 4 do
            TFDirector:getChildByPath(Panel_pos, "Image_pos"..i):setTexture(data.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
        end
    else
        Panel_pos:hide()
    end

end

return MasterGiveGiftView
