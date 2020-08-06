local KabalaTreeStrongPoint = class("KabalaTreeStrongPoint", BaseLayer)

function KabalaTreeStrongPoint:ctor(ambushId,oilCost,portImg)
    self.super.ctor(self)
    self:initData(ambushId,oilCost,portImg)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeStrongPoint")
end


function KabalaTreeStrongPoint:initData(ambushId,oilCost,portImg)

    self.portImg = portImg
    self.ambushId = ambushId
    self.oilCost = oilCost

end

function KabalaTreeStrongPoint:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    self.Image_portIcon = TFDirector:getChildByPath(self.ui, "Image_portIcon")
    self.Label_portDesc = TFDirector:getChildByPath(self.ui, "Label_portDesc")
    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.okBtnTx = TFDirector:getChildByPath(self.Button_ok, "Label_btn")
    self.Button_cancle = TFDirector:getChildByPath(self.ui, "Button_cancle")
    self.cancleBtnTx = TFDirector:getChildByPath(self.Button_cancle, "Label_btn")

    self:initUIInfo()
end

function KabalaTreeStrongPoint:initUIInfo()

    self.Label_title:setTextById(3003007)
    self.Image_portIcon:setTexture("ui/kabalatree/event/floor_spot_1.png")

    self.Label_portDesc:setTextById(3004104)
    self.okBtnTx:setTextById(3005050)
    self.cancleBtnTx:setTextById(800029)
end

function KabalaTreeStrongPoint:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_cancle:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()        
        Utils:openView("kabalaTree.KabalaTreeFight",self.ambushId,self.oilCost)
        AlertManager:closeLayer(self)
    end)
end


return KabalaTreeStrongPoint