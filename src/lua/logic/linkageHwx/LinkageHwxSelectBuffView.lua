local LinkageHwxSelectBuffView = class("LinkageHwxSelectBuffView",BaseLayer)
function LinkageHwxSelectBuffView:initData(floorId)
    
    self.buffItems_ = {}
    self.floorId = floorId
    self.buffData = LinkageHwxDataMgr:getUnActiveBuffInfo(floorId)
end

function LinkageHwxSelectBuffView:ctor(floorId)
    self.super.ctor(self)
    self:initData(floorId)
    self:showPopAnim(true)
    self:init("lua.uiconfig.linkageHwx.linkageHwxSelectBuffView")
end

function LinkageHwxSelectBuffView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_buff_item = TFDirector:getChildByPath(ui, "Panel_buff_item")
    local ScrollView_buff = TFDirector:getChildByPath(self.Panel_root, "ScrollView_buff")
    self.ListView_buff = UIListView:create(ScrollView_buff)
    self.ListView_buff:setItemModel(self.Panel_buff_item)
    self.ListView_buff:setItemsMargin(10)
    self:refreshView()
end

function LinkageHwxSelectBuffView:refreshView()

    for k,v in ipairs(self.buffData) do
        local item = self:addBuffItem(k)
        self:updateBuffItem(k, v)
    end
    Utils:setAliginCenterByListView(self.ListView_buff,true)
end

function LinkageHwxSelectBuffView:addBuffItem(index)

    local item = self.ListView_buff:pushBackDefaultItem()
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Label_buff_desc = TFDirector:getChildByPath(item, "Label_buff_desc")
    local Button_getBuff = TFDirector:getChildByPath(item, "Button_getBuff")
    self.buffItems_[index] = { root = item, icon = Image_icon,buffDesc = Label_buff_desc,
                               Button_getBuff = Button_getBuff}
    return item
end

function LinkageHwxSelectBuffView:updateBuffItem(index, buffCid)

    local buffItem = self.buffItems_[index]
    if not buffItem then
        return
    end

    local cfg = LinkageHwxDataMgr:getHwxBuffManageCfg(buffCid)
    if not cfg then
        return
    end

    buffItem.icon:setTexture(cfg.buffIcon)
    buffItem.buffDesc:setTextById(cfg.buffDescribe)
    buffItem.Button_getBuff:onClick(function()
        LinkageHwxDataMgr:Send_getBuff(self.floorId,buffCid)
    end)
end

function LinkageHwxSelectBuffView:onRecvGetBuff()
    Utils:showTips(12031187)
    AlertManager:closeLayer(self)
end

function LinkageHwxSelectBuffView:registerEvents()
    EventMgr:addEventListener(self, EV_UPDATE_LINKAGEHWX_BUFF, handler(self.onRecvGetBuff, self))
end

return LinkageHwxSelectBuffView