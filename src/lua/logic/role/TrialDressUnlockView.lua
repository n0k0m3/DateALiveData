--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local TrialDressUnlockView = class("TrialDressUnlockView", BaseLayer)

function TrialDressUnlockView:ctor(...)
	self.super.ctor(self)

	self:initData(...)

	self:showPopAnim(true)
	
	self:init("lua.uiconfig.role.trialDressUnlockView")
end

function TrialDressUnlockView:initData(dressId)

	local arr = TabDataMgr:getData("DiscreteData", 90040).data	

	self.rechargeId = arr[dressId]
	
	self.rechargeData = RechargeDataMgr:getOneRechargeCfg(arr[dressId])

	self.dressId = dressId
end

function TrialDressUnlockView:initUI(ui)
	self.super.initUI(self,ui)

	local cfg = GoodsDataMgr:getItemCfg(self.dressId)
	if cfg then
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		PrefabDataMgr:setInfo(Panel_goodsItem, self.dressId, 1)
		Panel_goodsItem:setScale(1)
		Panel_goodsItem:Pos(0,0)
		TFDirector:getChildByPath(ui, "dressNode"):addChild(Panel_goodsItem)

		TFDirector:getChildByPath(self.ui, "dressName"):setTextById(cfg.nameTextId)
	end

	TFDirector:getChildByPath(self.ui, "Button_check"):onClick(function()
		local roleId
		local roleCfg = TabDataMgr:getData("Role")
		for k, v in pairs(roleCfg) do
		    if table.indexOf(v.dress, self.dressId) ~= -1 then
		        roleId = v.id
		        break
		    end
		end
		if roleId then
			Utils:openView("role.NewRoleShowView", roleId, self.dressId)
			AlertManager:closeLayer(self)
		end
	end)
end



return TrialDressUnlockView

--endregion
