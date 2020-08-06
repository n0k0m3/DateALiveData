local KabalaTreeRadarView = class("KabalaTreeRadarView", BaseLayer)

function KabalaTreeRadarView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeRadarView")
end

function KabalaTreeRadarView:initData()

    local radarLocation = Utils:getKVP(19001, "radarLocation")
    for k,v in pairs(radarLocation) do
        self.costItemId = k
        self.costItemNum = v
    end
end

function KabalaTreeRadarView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")

    self.Label_portDesc = TFDirector:getChildByPath(self.ui, "Label_portDesc")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_effect = TFDirector:getChildByPath(self.ui, "Button_effect")
    self.Label_cost = TFDirector:getChildByPath(self.Button_effect, "Label_cost")
    self.Label_text = TFDirector:getChildByPath(self.Button_effect, "Label_text")
    self.Image_cost = TFDirector:getChildByPath(self.Button_effect, "Image_cost")

    self:initUIInfo()
end

function KabalaTreeRadarView:initUIInfo()

    self.Label_title:setTextById(3004044)
    self.Label_text:setTextById(3004045)
    self.Label_portDesc:setTextById(3004110)

    if self.costItemId and self.costItemNum then
        local itemCfg = GoodsDataMgr:getItemCfg(self.costItemId)
        if not itemCfg then
            return
        end
        self.Image_cost:setTexture(itemCfg.icon)
        self.Label_cost:setText(self.costItemNum)
    end
end


function KabalaTreeRadarView:registerEvents()

    self.Button_ok:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_effect:onClick(function()
        TFDirector:send(c2s.QLIPHOTH_TASK_EVENT_DISCOVER, {})
        AlertManager:closeLayer(self)
    end)
end

return KabalaTreeRadarView