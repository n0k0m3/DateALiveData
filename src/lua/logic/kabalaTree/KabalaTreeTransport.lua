local KabalaTreeTransport = class("KabalaTreeTransport", BaseLayer)

function KabalaTreeTransport:ctor(targetTable,textTable,callBack)    
    self.super.ctor(self)
    self:initData(targetTable,textTable,callBack)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeTransport")
end

function KabalaTreeTransport:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    EventMgr:addEventListener(self,EV_TRIGGER_TRANSPORT,handler(self.onRecvTransport, self))
end

function KabalaTreeTransport:initData(targetTable,textTable)

    self.targetTable = targetTable
    self.textTable = textTable
end

function KabalaTreeTransport:initUI(ui)
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

function KabalaTreeTransport:updateList()
    
    self.ListView:removeAllItems()
    for k,v in pairs(self.targetTable) do
        local placeItem = self.listItem:clone()
        local Label_placeName = TFDirector:getChildByPath(placeItem, "Label_placeName")
        Label_placeName:setTextById(self.textTable[k])
        local Image_placeIcon = TFDirector:getChildByPath(placeItem, "Image_placeIcon")
        Image_placeIcon:setTexture("ui/dalmap/event/tran_1.png")
        local transportBtn = TFDirector:getChildByPath(placeItem, "Button_transfor")
        transportBtn:onClick(function ()
            self:timeOut(function()
                self:onTransport(v)
            end,0.1)
        end)
        self.ListView:pushBackCustomItem(placeItem)
    end
end

function KabalaTreeTransport:onTransport(gid)

    local desPosMN = KabalaTreeDataMgr:getEventTilesByGid(EC_EventLayerGid.Tile_TransportTarget,gid)
    if not desPosMN then
        return
    end

    local msg = {
        desPosMN.x,
        desPosMN.y
    } 
    TFDirector:send(c2s.QLIPHOTH_WORLD_TRANSFORM, msg)
end

function KabalaTreeTransport:onRecvTransport()
    AlertManager:closeLayer(self)
end

return KabalaTreeTransport