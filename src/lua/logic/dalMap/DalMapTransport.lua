local DalMapTransport = class("DalMapTransport", BaseLayer)

function DalMapTransport:ctor(targetTable,textTable)
    self.super.ctor(self)
    self:initData(targetTable,textTable)
    self:showPopAnim(true)
    self:init("lua.uiconfig.dls.dalMapTransport")
end

function DalMapTransport:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    EventMgr:addEventListener(self,EV_DAL_MAP.Transfer,handler(self.onRecvTransport, self))
end

function DalMapTransport:initData(targetTable,textTable)

    self.targetTable = targetTable
    self.textTable = textTable
end

function DalMapTransport:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")

    local ScrollView_Place = TFDirector:getChildByPath(self.ui, "ScrollView_Place")
    self.ListView = UIListView:create(ScrollView_Place)
    self.ListView:setItemsMargin(5)

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.listItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_placeItem")

    self:updateList()
end

function DalMapTransport:updateList()

    self.ListView:removeAllItems()
    for k,v in pairs(self.targetTable) do
        local placeItem = self.listItem:clone()
        local Label_placeName = TFDirector:getChildByPath(placeItem, "Label_placeName")
        Label_placeName:setTextById(self.textTable[k])
        local transportBtn = TFDirector:getChildByPath(placeItem, "Button_transfor")
        transportBtn:onClick(function ()
            self:timeOut(function()
                self:onTransport(v)
            end,0.1)
        end)
        self.ListView:pushBackCustomItem(placeItem)
    end
end

function DalMapTransport:onTransport(gid)

    local desPosMN = DalMapDataMgr:getTilePosByGid(EC_DalEventLayerGid.Tile_TransportTarget,gid)
    if not desPosMN then
        return
    end

    local msg = {
        desPosMN.x,
        desPosMN.y
    }
    TFDirector:send(c2s.OFFICE_EXPLORE_OFFICE_TRANSFORM, msg)
end

function DalMapTransport:onRecvTransport()
    AlertManager:closeLayer(self)
end

return DalMapTransport