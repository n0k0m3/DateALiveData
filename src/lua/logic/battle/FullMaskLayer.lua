local FullMaskLayer = class("FullMaskLayer",BaseLayer)

function FullMaskLayer:ctor(param)
	self.super.ctor(self)
	self.cfgData = param
	self:init("lua.uiconfig.battle.fullMaskLayer")
end

function FullMaskLayer:initUI(ui)
	self.super.initUI(self,ui)
	self.mask_panel = ui:getChildByName("Panel_root")
	if self.cfgData.maskAction == 1 then
		self:doAction(self.cfgData)
	end
end

function FullMaskLayer:registerEvents()
	EventMgr:addEventListener(self, EV_BATTLE_SUPER_MASK, handler(self.fullMaskHandle, self))
end

function FullMaskLayer:fullMaskHandle(param)
	self.cfgData = param
	if self.cfgData.maskAction ~= 1 then
		self:doAction(self.cfgData)
	end
end

function FullMaskLayer:doAction(param)
	self.mask_panel:stopAllActions()
    local rgb = me.c3b(tonumber("0x"..string.sub(param.color,1,2)),tonumber("0x"..string.sub(param.color,3,4)),tonumber("0x"..string.sub(param.color,5,6)))
    self.mask_panel:setBackGroundColor(rgb)
    
    local actArr = {}
    if param.maskAction == 1 then
        actArr[#actArr + 1] = CallFunc:create(function()
            self.mask_panel:setOpacity(0)
            self.mask_panel:setVisible(true)
        end)
        local tmaction = FadeIn:create(param.duration/1000)
        actArr[#actArr + 1] = tmaction
    else
        local tmaction = FadeOut:create(param.duration/1000)
        actArr[#actArr + 1] = tmaction
        actArr[#actArr + 1] = CallFunc:create(function()
            self.mask_panel:setVisible(false)
        end)
    end
    local endCallback = CallFunc:create(function()
        if param.callback then
        	param.callback()
            param.callback = nil
        end
        if param.maskAction ~= 1 then
        	AlertManager:closeLayer(self)
        end
    end)
    actArr[#actArr + 1] = endCallback
    local actSeq = Sequence:create(actArr)
    self.mask_panel:runAction(actSeq)
end

return FullMaskLayer