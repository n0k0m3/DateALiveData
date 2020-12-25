
local DfwAutumnCardView = class("DfwAutumnCardView", BaseLayer)

function DfwAutumnCardView:initData()
    local buffCfgs = DfwDataMgr:getChessesBuff()
    self.buffData_ = {}
    local cellInfo = DfwDataMgr:getCellInfo()
    cellInfo.list = cellInfo.list or {}
    cellInfo.list.buffId = cellInfo.list.buffId or {}
    for k,v in pairs(buffCfgs) do
        local count = GoodsDataMgr:getItemCount(v)
        if count > 0 or table.find(cellInfo.list.buffId,v) ~= -1 then
            table.insert(self.buffData_,v)
        end
    end



    table.sort(self.buffData_,function ( v1,v2 )
        local isHaveBuff1 = table.find(cellInfo.buffIds or {}, v1) ~= -1
        local isHaveBuff2 = table.find(cellInfo.buffIds or {}, v2) ~= -1

        local count1 = GoodsDataMgr:getItemCount(v1)
        local count2 = GoodsDataMgr:getItemCount(v2)

        if isHaveBuff1 and not isHaveBuff2 then
            return true
        elseif not isHaveBuff1 and  isHaveBuff2 then
            return false
        elseif count1 == 0 and count2 > 0 then
            return false
        elseif count2 == 0 and count1 > 0 then 
            return true
        else
            return v1 < v2
        end
    end)

    self.defaultSelectIndex_ = 1
end

function DfwAutumnCardView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dafuwong.dfwAutumnCardView")
end

function DfwAutumnCardView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Label_empty = TFDirector:getChildByPath(ui, "Label_empty")

    local ScrollView_card = TFDirector:getChildByPath(ui, "ScrollView_card")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_card = TFDirector:getChildByPath(self.Panel_prefab, "Panel_card") 

    self.ScrollView_card = UIGridView:create(ScrollView_card)
    self.ScrollView_card:setItemModel(self.Panel_card)
    self.ScrollView_card:setColumn(4)
    self.ScrollView_card:setColumnMargin(5)
    self.ScrollView_card:setRowMargin(10)
   
    self:refreshView()
end

function DfwAutumnCardView:refreshView()

    self.Label_empty:setVisible(#self.buffData_ == 0)
    if #self.buffData_ > 0 then
        self.ScrollView_card.scrollView_:show()
    else
        self.ScrollView_card.scrollView_:hide()
        return
    end
    local num = #self.ScrollView_card:getItems() - #self.buffData_

    for i = 1,math.abs(num) do
        if num > 0 then
            self.ScrollView_card:removeItem(1)
        else
            self.ScrollView_card:pushBackDefaultItem()
        end
    end

    for i, buffCid in ipairs(self.buffData_) do
        local item = self.ScrollView_card:getItem(i)
        self:updateItem( item ,buffCid)
    end

    self:selectCard(self.defaultSelectIndex_)
end

function DfwAutumnCardView:updateItem( item, buffCid )
    -- body
    item.Image_select = TFDirector:getChildByPath(item, "Image_select")
    item.Button_card = TFDirector:getChildByPath(item, "Button_card")
    item.Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    item.Label_num = TFDirector:getChildByPath(item, "Label_num")
    item.Label_desc = TFDirector:getChildByPath(item, "Label_desc")
    item.Button_use = TFDirector:getChildByPath(item, "Button_use")
    item.Label_use = TFDirector:getChildByPath(item.Button_use, "Label_use")
    item.Label_effect = TFDirector:getChildByPath(item, "Label_effect"):hide()
    item.Label_effect:setTextById(13210019)
    item.Spine_effect = TFDirector:getChildByPath(item, "Spine_effect")

    if not item.isEffect then
        item.Spine_effect:playByIndex(0,-1,-1,1)
        item.isEffect = true
    end

    local buffCfg = DfwDataMgr:getChessesBuffCfg(buffCid)
    local count = GoodsDataMgr:getItemCount(buffCid)
    local itemCfg = GoodsDataMgr:getItemCfg(buffCid)

    item.titleTx = TFDirector:getChildByPath(item.Button_card, "Label_title")
    item.Label_desc:setTextById(buffCfg.buffDes)
    item.Label_num:setTextById(800005, count, itemCfg.totalMax)
    item.Image_icon:setTexture(buffCfg.buffCard)
    item.Image_icon:setTouchEnabled(true)
    item.Image_icon:onClick(function ( ... )
        Utils:showInfo(buffCid)
    end)
    item.titleTx:setTextById(buffCfg.title)

    local cellInfo = DfwDataMgr:getCellInfo()
    local isHaveBuff = table.find(cellInfo.buffIds or {}, buffCid) ~= -1

    item.Label_effect:setVisible(isHaveBuff)
    item.Spine_effect:setVisible(isHaveBuff)
    item.Button_card:setTouchEnabled(not isHaveBuff and count > 0)
    item:setGrayEnabled(not isHaveBuff and count <= 0)

end


function DfwAutumnCardView:selectCard(index)
    if  self.selectIndex_ == index then return end

    if self.selectIndex_ then
        Utils:playSound(5005)
    end

    self.selectIndex_ = index


    local buffCid = self.buffData_[index]
    local count = GoodsDataMgr:getItemCount(buffCid)
    local cellInfo = DfwDataMgr:getCellInfo()
    local isHaveBuff = table.find(cellInfo.buffIds or {}, buffCid) ~= -1

    for i, v in ipairs(self.ScrollView_card:getItems()) do
        local isSelect = i == index
        v.Image_select:setVisible(isSelect and count > 0 and not isHaveBuff)
    end
end

function DfwAutumnCardView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_UPDATE_BUFF, handler(self.onUpdateBuffEvent, self))

    for i, v in ipairs(self.ScrollView_card:getItems()) do
        local buffCid = self.buffData_[i]

        v.Button_card:onClick(function()
                self:selectCard(i)
        end)

        v.Button_use:onClick(function()
                local buffCfg = DfwDataMgr:getChessesBuffCfg(buffCid)
                if buffCfg.specialUse then
                    DfwDataMgr:setUseItemStatus(buffCid)
                    AlertManager:closeLayer(self)
                    return
                end
                DfwDataMgr:send_SACRIFICE_REQ_ADD_BUFF(buffCid)
        end)
    end

    self.Button_close:onClick(function ( ... )
        AlertManager:closeLayer(self)
    end)
end

function DfwAutumnCardView:onUpdateBuffEvent()
    AlertManager:closeLayer(self)
end

return DfwAutumnCardView
