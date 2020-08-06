local EquipmentRecycleConfirm = class("EquipmentRecycleConfirm", BaseLayer)


function EquipmentRecycleConfirm:ctor(recycleType,showId,info)
    self.super.ctor(self)
    self.recycleType = recycleType
    self.showId = showId
    self.info = info or {}

    self:init("lua.uiconfig.Equip.EquipRecycleConfirm")
end

function EquipmentRecycleConfirm:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Label_content = TFDirector:getChildByPath(ui,"Label_content")
    local ScrollView_EquipRecycleConfirm = TFDirector:getChildByPath(ui,"ScrollView_EquipRecycleConfirm")
    self.ListView_items = UIListView:create(ScrollView_EquipRecycleConfirm)

    self.Button_ok = TFDirector:getChildByPath(ui,"Button_ok")
    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self:updateRecycleItems()
end

function EquipmentRecycleConfirm:updateRecycleItems()

    self.ListView_items:removeAllItems()
    local info = self.info
    if not info[self.recycleType] then
        return
    end
    local returnItem = info[self.recycleType].returnItem or {}
    for k, v in ipairs(returnItem) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, v.id, v.num)
        self.ListView_items:pushBackCustomItem(Panel_goodsItem)
    end

    if self.recycleType == 1 then
        self.Label_content:setTextById(491009)
    else
        self.Label_content:setTextById(491010,info[2].costItem[1].num)
    end

end

function EquipmentRecycleConfirm:onRecvResults()
    AlertManager:closeLayer(self)
end

function EquipmentRecycleConfirm:registerEvents()

    EventMgr:addEventListener(self,EQUIPMENT_RECYCLERESULTS,handler(self.onRecvResults, self))

    self.Button_ok:onClick(function()
        TFDirector:send(c2s.EQUIPMENT_REQ_EQUIP_RECYCLE,{self.recycleType,tostring(self.showId)});
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

return EquipmentRecycleConfirm;
