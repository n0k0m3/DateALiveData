--[[
    @desc：FanShiAwardPopView
    @date: 2020-12-29 17:42:10
]]

local FanShiAwardPopView = class("FanShiAwardPopView",BaseLayer)

function FanShiAwardPopView:initData(awardData)
    self.awardData = awardData
end

function FanShiAwardPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    -- self:showPopAnim(true)
    self:init("lua.uiconfig.activity.fanShiAwardPopView")
end

function FanShiAwardPopView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.lab_desc:setTextById(63860)
    self._ui.lab_rule:setTextById(63861)

    self.ScrollView_award = UIListView:create(self._ui.ScrollView_award)
    self.ScrollView_award:removeAllItems()
    for i, v in pairs(self.awardData or {}) do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:setScale(0.8)
        PrefabDataMgr:setInfo(goods, v.id, v.num)
        self.ScrollView_award:pushBackCustomItem(goods)
    end
    self.ScrollView_award:setCenterArrange()
end

function FanShiAwardPopView:registerEvents()
    self._ui.Button_get:onClick(function()
        ActivityDataMgr2:SEND_ACTIVITY2_REQ_REVERSE_TEN_REWARD()
        AlertManager:close(self)
    end)
end

return FanShiAwardPopView