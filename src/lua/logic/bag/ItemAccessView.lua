
local ItemAccessView = class("ItemAccessView", BaseLayer)

function ItemAccessView:initData(itemCid)
    dump(itemCid)
    self.itemCid_ = itemCid
    self.itemCfg_ = GoodsDataMgr:getItemCfg(self.itemCid_)
    self.access_ = FunctionDataMgr:getAccess(itemCid)
end

function ItemAccessView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.bag.itemAccessView")
end

function ItemAccessView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_accessItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_accessItem")
    self.Panel_unlockAccessItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_unlockAccessItem")
    self.Panel_lockAccessItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_lockAccessItem")

    local Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Panel_head = TFDirector:getChildByPath(Image_bg, "Panel_head")
    self.Button_close = TFDirector:getChildByPath(Image_bg, "Button_close")
    self.Label_title = TFDirector:getChildByPath(Image_bg, "Label_title")
    self.Image_split = TFDirector:getChildByPath(self.Label_title, "Image_split")
    self.Label_name = TFDirector:getChildByPath(Image_bg, "Label_name")
    self.Label_empty = TFDirector:getChildByPath(Image_bg, "Label_empty")
    local Image_scrollBar = TFDirector:getChildByPath(Image_bg, "Image_scrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    local ScrollView_access = TFDirector:getChildByPath(Image_bg, "ScrollView_access")
    self.ListView_access = UIListView:create(ScrollView_access)
    self.ListView_access:setScrollBar(scrollBar)


    self:refreshView()
end

function ItemAccessView:refreshView()
    self.Label_title:setTextById(1420001)
    local size = self.Label_title:Size()
    self.Label_name:setTextById(self.itemCfg_.nameTextId)

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:AddTo(self.Panel_head)
    Panel_goodsItem:Pos(0, 0)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.itemCid_)

    self.Label_empty:setVisible(#self.access_ == 0)
    self.Label_empty:setTextById(1409001)

    for i, v in ipairs(self.access_) do
        local item
        local isJumpFuncOutTime = false
        if v.open then
            item = self.Panel_unlockAccessItem:clone()
            if v.startTime and v.endTime and v.startTime ~= "" and v.endTime ~= "" then
                local curTime = ServerDataMgr:getServerTime()
                local _, startTime = Utils:changStrToDate(v.startTime)
                local _, endTime = Utils:changStrToDate(v.endTime)
                if curTime < startTime or curTime > endTime then
                    isJumpFuncOutTime = true
                end
            end
        else
            item = self.Panel_lockAccessItem:clone()
        end
        local Label_desc = TFDirector:getChildByPath(item, "Label_desc")
        Label_desc:setText(v.desc)

        local Button_goto = TFDirector:getChildByPath(item, "Button_goto")
        Button_goto:setGrayEnabled(isJumpFuncOutTime)
        Button_goto:setTouchEnabled(v.open)
        Button_goto:onClick(function()
            if isJumpFuncOutTime then
                Button_goto:setGrayEnabled(true)
                Utils:showTips(219007)
                return
            end
            FunctionDataMgr:enterByFuncId(v.jumpId, unpack(v.args))
        end)
        self.ListView_access:pushBackCustomItem(item)
    end
end

function ItemAccessView:registerEvents()
    self.Button_close:onClick(
        function()
            AlertManager:closeLayer(self)
        end,
        EC_BTN.CLOSE)
end

return ItemAccessView
