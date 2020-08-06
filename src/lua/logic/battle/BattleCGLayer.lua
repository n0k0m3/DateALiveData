local BattleCGLayer = class("BattleCGLayer",BaseLayer)

function BattleCGLayer:ctor(param)
	self.super.ctor(self)
	self.cfgData = param
	self:init("lua.uiconfig.battle.battleCGLayer")
end

function BattleCGLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.cg_root = ui:getChildByName("Panel_root")
	self:playCG(self.cfgData)
end

function BattleCGLayer:registerEvents()

end

function BattleCGLayer:playCG(param)
	local cgid = param.cgid
    self.cg_root:removeAllChildren()
    local cgtb = TabDataMgr:getData("Cg")
    for k,v in pairs(cgtb) do
        if k == cgid then
            local layer = require("lua.logic.common.CgView"):new(v.cg, v.backGround, true, nil,true,handler(self.onCGComplete,self))
            layer:setPosition(ccp(0, 0))
            self.cg_root:addChild(layer)
            break
        end
    end
end

function BattleCGLayer:onCGComplete()
	if self.cfgData.callback then
        self.cfgData.callback()
    end
    AlertManager:closeLayer(self)
end
return BattleCGLayer