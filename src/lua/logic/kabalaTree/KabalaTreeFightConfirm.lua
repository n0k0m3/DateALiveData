local KabalaTreeFightConfirm = class("KabalaTreeFightConfirm", BaseLayer)

function KabalaTreeFightConfirm:ctor(_type,ambushId,costEnergy)
    self.super.ctor(self)
    self:initData(_type,ambushId,costEnergy)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeFightConfirm")
end

function KabalaTreeFightConfirm:registerEvents()

    self.Button_ok:onClick(function()

        if self.ambushId == 0 then
            Utils:showTips(3005003)
        else
            Utils:openView("kabalaTree.KabalaTreeFight",self.ambushId,self.costEnergy)
        end
    
        KabalaTreeDataMgr:setRandomFightFlag(false)
        AlertManager:closeLayer(self)
    end)

    self.Button_cancle:onClick(function()
        KabalaTreeDataMgr:setRandomFightFlag(false)
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreeFightConfirm:initData(_type,ambushId,costEnergy)
    self.ambushId = ambushId
    self.costEnergy = costEnergy
    self._type = _type
end

function KabalaTreeFightConfirm:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_ok = TFDirector:getChildByPath(self.ui, "Button_ok")
    self.Button_cancle = TFDirector:getChildByPath(self.ui, "Button_cancle")
    self.Image_tipbg = TFDirector:getChildByPath(self.ui, "Image_tipbg")
    self.ImageTip = TFDirector:getChildByPath(self.Image_tipbg, "Label_tip")
    self.ImageTip:setTextById(3004036)
    self.Image_tipbg:setVisible(self._type == 1)

    self.Image_Bosstipbg = TFDirector:getChildByPath(self.ui, "Image_Bosstipbg")
    self.ImageBossTip = TFDirector:getChildByPath(self.Image_Bosstipbg, "Label_tip")
    self.ImageBossTip:setTextById(3005026)
    self.Image_Bosstipbg:setVisible(self._type == 2)

end

return KabalaTreeFightConfirm