--

local TanghuluPopView = class("TanghuluPopView", BaseLayer)

function TanghuluPopView:initData(data)
   self.rewardData = data
end

function TanghuluPopView:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.activity.tanghuluPopView")
end

function TanghuluPopView:initUI(ui)
    self.super.initUI(self, ui)
    self.view = UIListView:create(self._ui.scrollView)
    self.view:setItemsMargin(10)

    if not self.rewardData then
        return
    end
    self.view:removeAllItems()
    for i, v in ipairs(self.rewardData) do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:setScale(0.7)
        PrefabDataMgr:setInfo(goods,v[1],v[2])
        self.view:pushBackCustomItem(goods)
    end
    Utils:setAliginCenterByListView(self.view, true)
end

function TanghuluPopView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)
end

return TanghuluPopView