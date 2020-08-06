local KabalaTreeState = class("KabalaTreeState", BaseLayer)

function KabalaTreeState:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData()
    self:init("lua.uiconfig.kabalaTree.kabalaTreeState")
end

function KabalaTreeState:initData()
    
end

function KabalaTreeState:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")

    self.chooseBtn = {}
    local Image_left = TFDirector:getChildByPath(self.ui, "Image_left")
    for i=1,2 do
        local btn = TFDirector:getChildByPath(Image_left, "Button_item_"..i)
        local btnName1 = TFDirector:getChildByPath(btn, "Label_btn_1")
        local btnTextId = i == 1 and 3004039 or 3004040
        btnName1:setTextById(btnTextId)
        local btnName2 = TFDirector:getChildByPath(btn, "Label_btn_2")
        local btnStr2 = i == 1 and "Gain usage" or "Permanent gain"
        btnName2:setText(btnStr2)
        self.chooseBtn[i] = btn
        if i==2 then
            btn:setVisible(false)
        end
    end

    local ScrollView_kabalaTreeList = TFDirector:getChildByPath(self.ui, "ScrollView_kabalaTreeList")
    self.ListView_buffState = UIListView:create(ScrollView_kabalaTreeList)
    self.ListView_buffState:setItemsMargin(10)

    self.Panel_buffItemCell = TFDirector:getChildByPath(self.ui, "Panel_buffItem_1")
    self.Panel_buffEffectCell = TFDirector:getChildByPath(self.ui, "Panel_buffItem_2")
    self:initUIInfo()
end

function KabalaTreeState:initUIInfo()

    self.Label_title:setTextById(3004041)
    self:chooseList(1)
end

function KabalaTreeState:chooseList(listId)

    for i=1,2 do
        if listId == i then
            self.chooseBtn[i]:setTextureNormal("ui/setting/uires/002.png")
        else
            self.chooseBtn[i]:setTextureNormal("")
        end
    end
    self:updateBuffList(listId)
end

function KabalaTreeState:updateBuffList(listId)

    self.listId = listId
    if listId == 1 then
        self:updateUsageItem()
    elseif listId == 2 then
        self:updatePermanent()
    end
end

--优先显示生效中的buff,再显示buffItem
function KabalaTreeState:updateUsageItem()

    self.ListView_buffState:removeAllItems()
    self.buffItem = {}
    local kabalaBg = KabalaTreeDataMgr:getBag()
    for k,v in ipairs(kabalaBg) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.itemId)
        local itemType = itemCfg.subType
        if (itemType == Enum_KabalaItemType.ItemType_Buff or itemType == Enum_KabalaItemType.ItemType_BuffItem) and not itemCfg.autoUse then
            table.insert(self.buffItem,v)
        end
    end

    local timeBuffs = KabalaTreeDataMgr:getTimeBuffs()
    for k,v in ipairs(timeBuffs) do
        local item = self.Panel_buffEffectCell:clone()
        self.ListView_buffState:pushBackCustomItem(item)
        self:addBuffItem(item,v,true)
    end

    table.sort(self.buffItem,function(a,b)

        local couldUseA = 0
        local couldUseB = 0
        local itemCfg = GoodsDataMgr:getItemCfg(a.itemId)
        if itemCfg then
            local buffId = itemCfg.useProfit.fix.items[1].id
            couldUseA = self:isUsed(buffId)
        end
        local itemCfg = GoodsDataMgr:getItemCfg(b.itemId)
        if itemCfg then
            local buffId = itemCfg.useProfit.fix.items[1].id
            couldUseB = self:isUsed(buffId)
        end

        return couldUseA < couldUseB
    end)


    for k,v in ipairs(self.buffItem) do
        local item = self.Panel_buffItemCell:clone()
        self.ListView_buffState:pushBackCustomItem(item)
        self:addBuffItem(item,v,false)
    end

end

function KabalaTreeState:isUsed(buffId)
    local couldUse = 0
    local timeBuffs = KabalaTreeDataMgr:getTimeBuffs()
    for k,v in ipairs(timeBuffs) do
        if v.itemId == buffId then
            couldUse = 1
            break
        end
    end

    return couldUse
end

function KabalaTreeState:updatePermanent()
    self.ListView_buffState:removeAllItems()
    local permanentBuffs = KabalaTreeDataMgr:getPermanentBuffs()
    dump(permanentBuffs)
    for k,v in ipairs(permanentBuffs) do
        local item = self.Panel_buffEffectCell:clone()
        self.ListView_buffState:pushBackCustomItem(item)
        self:addBuffItem(item,v,true)
    end
end

function KabalaTreeState:addBuffItem(itemWidget,itemInfo,isEffect)

    local itemCfg = GoodsDataMgr:getItemCfg(itemInfo.itemId)
    if not itemCfg then
        return
    end

    --是否是持续生效
    local isPermanent = itemCfg.autoUse

    local Image_buff_frame = TFDirector:getChildByPath(itemWidget, "Image_buff_frame")
    local frameImg = Enum_KabalaItemFrame[itemCfg.quality]
    if not frameImg then
        frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
    end
    Image_buff_frame:setTexture(frameImg)

    local Image_buff_icon = TFDirector:getChildByPath(itemWidget, "Image_buff_icon")
    Image_buff_icon:setTexture(itemCfg.icon)

    local Label_buff_name = TFDirector:getChildByPath(itemWidget, "Label_buff_name")
    Label_buff_name:setTextById(itemCfg.nameTextId)

    local Label_buff_desc = TFDirector:getChildByPath(itemWidget, "Label_buff_desc")
    Label_buff_desc:setTextById(itemCfg.desTextId)

    local Label_buff_own = TFDirector:getChildByPath(itemWidget, "Label_buff_own")
    local str = TextDataMgr:getText(3005031,itemInfo.itemNum)
    Label_buff_own:setText(str)
    Label_buff_own:setVisible(not isPermanent)

    local buffId
    local Label_buff_effect = TFDirector:getChildByPath(itemWidget, "Label_buff_effect")
    --isEffect：false 特指buff道具,true特质buff
    if not isEffect then
        if itemCfg.useProfit.fix then
            buffId = itemCfg.useProfit.fix.items[1].id
            local buffInfo = KabalaTreeDataMgr:getBuffCfgInfo(buffId)
            if buffInfo then
                local str = TextDataMgr:getText(3004043,buffInfo.timerTypeParam)
                Label_buff_effect:setText(str)
            end
        end
    else
        local buffInfo = KabalaTreeDataMgr:getBuffCfgInfo(itemInfo.itemId)
        if buffInfo.timerType == 2 then
            local str = TextDataMgr:getText(3004043,itemInfo.itemNum)
            Label_buff_effect:setText(str)
        else
            Label_buff_effect:setTextById(3004042)
        end
    end

    local Button_use = TFDirector:getChildByPath(itemWidget, "Button_use")
    Button_use:setVisible(not isEffect)
    Button_use:onClick(function()

        if not buffId then
            return
        end

        local couldUse = true
        local timeBuffs = KabalaTreeDataMgr:getTimeBuffs()
        for k,v in ipairs(timeBuffs) do
            if v.itemId == buffId then
                couldUse = false
                break
            end
        end

        if not couldUse then
            Utils:showTips(3005058)
            return
        end
        local msg = {
            itemInfo.itemId,
            1,
            ""
        }
        TFDirector:send(c2s.QLIPHOTH_USE_ITEM, msg)
    end)

end

function KabalaTreeState:onRecvUseBuffItem(ct)

    self.listId = self.listId or 1
    self:updateBuffList(self.listId)

    if ct == 1 then
        Utils:showTips(3005057)
        KabalaTreeDataMgr:clearNewBuffs()
    end
end

function KabalaTreeState:registerEvents()

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for i=1,2 do
        self.chooseBtn[i]:onClick(function()
            self:chooseList(i)
        end)
    end
    EventMgr:addEventListener(self,EV_UPDATE_KABALABAG,handler(self.onRecvUseBuffItem, self))
    EventMgr:addEventListener(self,EV_UPDATE_KABALABUFF,handler(self.onRecvUseBuffItem, self))
end

return KabalaTreeState