
local SummonContractResult = class("SummonContractResult", BaseLayer)

function SummonContractResult:ctor(callBack)
    self.super.ctor(self)
    self.callBack = callBack
    self:init("lua.uiconfig.summon.summonContractResult")
end

function SummonContractResult:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui;
    self.ui:setTouchEnabled(true);

    self.desc0 = TFDirector:getChildByPath(ui, "desc0")
    self.desc1 = TFDirector:getChildByPath(ui, "desc1")
    self.desc2 = TFDirector:getChildByPath(ui, "desc2")
    self.desc4 = TFDirector:getChildByPath(ui, "desc4")
    self.spine_title = TFDirector:getChildByPath(ui, "spine_title")

    local canBuy,cfg = SummonDataMgr:getCanBuildContract()

    self.desc4:setTextById(1325322);
    self.desc0:setTextById(cfg.AccountInterface[1],cfg.Price);
    self.desc1:setTextById(cfg.AccountInterface[2]);
    self.desc2:setTextById(cfg.AccountInterface[3]);
end

function SummonContractResult:removeUI(  )
    -- body
    self.callBack()
    self.super.removeUI(self)
end

function SummonContractResult:onShow(  )
    -- body
    self.super.onShow(self)
    self.spine_title:addMEListener(TFARMATURE_COMPLETE,function()
                        self.spine_title:removeMEListener(TFARMATURE_COMPLETE)
                        self.spine_title:play("xunhuan",1)
                end)
    self.spine_title:play("ALL",0)
end

function SummonContractResult:registerEvents()
    self.ui:onClick(function()
            AlertManager:closeLayer(self);
        end)

end

return SummonContractResult
