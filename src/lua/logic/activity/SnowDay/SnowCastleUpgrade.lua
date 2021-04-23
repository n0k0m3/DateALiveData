--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local  SnowCastleUpgrade = class("SnowCastleUpgrade", BaseLayer)
function SnowCastleUpgrade:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.snowCastleUpgrade")

	
end

function SnowCastleUpgrade:initData(activityId)
	self.activityId = activityId
	self.data = {}
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)

	self.snowBookData = ActivityDataMgr2:getSnowBookData()

	self.pamphletId = self.activityData.extendData.pamphletId

	local levelCfg
	local EventMembership = TabDataMgr:getData("EventMembership")
	for k,v in pairs(EventMembership) do
		if v.pamphletId == self.pamphletId and v.level == self.snowBookData.pamphletLevel then
			levelCfg = v
			break;
		end
	end

	local tab = {}
	local EventMemshipOption = TabDataMgr:getData("EventMemshipOption")
	for k,v in pairs(EventMemshipOption) do
		local index = table.indexOf(levelCfg.optionType, v.optionType)
		if index~= -1 then
			index = table.indexOf(self.snowBookData.finishedId or {}, v.id)
			if index == -1 then
				index = table.indexOf(self.activityData.extendData.defaultPamphletOption or {}, v.id)
				if index == -1 then
					table.insert(tab, v)
				end
			end
		end
	end
	
	for k,v in pairs(tab) do
		local condition = true
		for i,j in pairs(v.preOption) do
			local index = table.indexOf(self.snowBookData.finishedId or {}, j)
			if index == -1 then
				condition = false
				break;
			end
		end
		if condition then
			table.insert(self.data, v)
		end
	end


	table.sort(self.data, function(a,b)return a.id < b.id end)
end

function SnowCastleUpgrade:initUI(ui)
	self.super.initUI(self, ui)
	TFDirector:getChildByPath(ui,"Button_close"):onClick(function() AlertManager:closeLayer(self) end)
	TFDirector:getChildByPath(ui,"Image_content"):setTouchEnabled(true)
	TFDirector:getChildByPath(ui,"Image_content"):setSwallowTouch(true)
	self.PrefabItem = TFDirector:getChildByPath(ui, "PrefabItem")
	self.ScrollContent = UIListView:create( TFDirector:getChildByPath(ui, "ScrollContent"))

	self:initView()
end

function SnowCastleUpgrade:initView()
	self.ScrollContent:removeAllItems()	

	if #self.data == 0 then
		AlertManager:closeLayer(self)
		return
	end
	
	for i=1, #self.data do
		self:addTab(self.data[i])
	end
end

function SnowCastleUpgrade:addTab(data)
	local prefeb = self.PrefabItem:clone()
	
	prefeb.text_Des = TFDirector:getChildByPath(prefeb, "text_Des")
	prefeb.title = TFDirector:getChildByPath(prefeb, "title")
	prefeb.title:setText("")
	prefeb.ButtonUpgrade = TFDirector:getChildByPath(prefeb, "ButtonUpgrade"):hide()
	prefeb.Image_lockBlock = TFDirector:getChildByPath(prefeb, "Image_lockBlock"):hide()


	TFDirector:getChildByPath(prefeb, "ButtonUpgrade"):onClick(function()
		if not prefeb.statusLock then
			Utils:showTips("请升级上一等级")
			return
		end
		self.optionId = data.id
		Utils:openView("activity.SnowDay.SnowCastleUpgradeComfirm", data.id)
	end)

	self:initItem(prefeb, data)

	self.ScrollContent:pushBackCustomItem(prefeb)
end

function SnowCastleUpgrade:initItem(prefeb, data)
	local text = TextDataMgr:getText(data.optionTitle)
	local rich = TFRichText:create(ccs(500, 160))
	local str = string.format([[<font face="fangzheng_zhunyuan26" color="#1d4371">%s</font>]],text)
	rich:Text(str)
	rich:setPosition(ccp(0,0))
	rich:setAnchorPoint(ccp(0,0.5))
	prefeb.title:addChild(rich)

	prefeb.text_Des:setTextById(data.optionDes2)

	local condition = self.snowBookData.pamphletLevel >= data.limitPamphletLevel
	local index = table.indexOf(self.snowBookData.finishedId or {}, data.preOption[1])
	local statusLock = (index ~= -1)
	if data.preOption[1] == nil then
		statusLock =true
	end
	prefeb.statusLock = statusLock

	prefeb.ButtonUpgrade:setVisible(condition)
	prefeb.Image_lockBlock:setVisible(not condition)

--	local text = TextDataMgr:getText(data.optionLockTitle)
--	local rich = TFRichText:create(ccs(500, 160))
--	local str = string.format([[<font face="fangzheng_zhunyuan26" color="#1d4371">%s</font>]],text)
--	rich:Text(str)
--	prefeb.Desc_lock:addChild(rich)
--	prefeb.Desc_lock:setVisible(not condition)

	
end

function SnowCastleUpgrade:upgradeSucess()
	

	local path = "lua.logic.activity.SnowDay.SnowCastleUpgradeSuccess"
	TFDirector:unRequire(path);
	local view = require(path):new(self.optionId)
	view:setAnchorPoint(ccp(0.5,0.50))	
	view:closeCallback(function()
		self:initData(self.activityId)
		self:initView()
		local cfgOption = TabDataMgr:getData("EventMembership", self.snowBookData.pamphletLevel) or {}
		if self.snowBookData.exp < cfgOption.costToNext then
			AlertManager:closeLayer(self)
		end
	end)
	self:addChild(view,9999)

	self.optionId = nil
end

function SnowCastleUpgrade:registerEvents()
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_ICE_SNOW_UPGRADE, handler(self.upgradeSucess, self))
end


return SnowCastleUpgrade

--endregion
