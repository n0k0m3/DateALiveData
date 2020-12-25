--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]

local CommandTaskSelectView = class("CommandTaskSelectView", BaseLayer)

function CommandTaskSelectView:ctor(curRoleId, excludeRoles)
	self.super.ctor(self)
	self.curRoleId = curRoleId
	self.selectedRole = curRoleId
	self.excludeRoles = excludeRoles or {}
	self:initData()
	self:showPopAnim(true)
	self:init("lua.uiconfig.explore.commonShipTip")
end

function CommandTaskSelectView:initData()
	self.showList = {}
	local roleList = HeroDataMgr:getShowList(true)
	local count = HeroDataMgr:getShowCount()
	for i = 1, count do
		local heroId = HeroDataMgr:getSelectedHeroId(i)
		local index = table.indexOf(self.excludeRoles, heroId)
		if not ExploreDataMgr:getRoleIsInTask(heroId) and index == -1 then
			table.insert(self.showList, heroId)
		end
	end
	if self.selectedRole then
		table.insert(self.showList, 1, self.selectedRole)
	end
	table.sort(self.showList, function(heroIdA, heroIdB)
		local powerA = HeroDataMgr:getHeroPower(heroIdA)
		local powerB = HeroDataMgr:getHeroPower(heroIdB)
		if powerA == powerB then
			return heroIdA < heroIdB
		else
			return powerA > powerB
		end
		return false
	end)
end

function CommandTaskSelectView:initUI(ui)
	self.super.initUI(self,ui)
	self.Label_power = TFDirector:getChildByPath(ui, "Label_power")
	self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
	self.Button_pullDown = TFDirector:getChildByPath(ui, "Button_pullDown")
	self.Button_pullUp = TFDirector:getChildByPath(ui, "Button_pullUp")
	self.Button_cover = TFDirector:getChildByPath(ui, "Button_cover"):hide()
	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
	self.Label_empty = TFDirector:getChildByPath(ui,"Label_empty"):hide()

	self.Panel_roleItem = TFDirector:getChildByPath(ui, "Panel_roleItem")
	local ScrollView_roleList = TFDirector:getChildByPath(ui, "ScrollView_roleList")

	self.Label_title:setTextById(13311334)
	self.uiGrid_role = UIGridView:create(ScrollView_roleList)
	self.uiGrid_role:setItemModel(self.Panel_roleItem)
	self.uiGrid_role:setColumn(6)
	self:refreshView()
end

function CommandTaskSelectView:onShow( ... )
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function CommandTaskSelectView:registerEvents()
	self.super.registerEvents(self)

	self.Button_close:onClick(function()
		AlertManager:closeLayer(self)
	end)

	self.Button_pullUp:onClick(function()
		EventMgr:dispatchEvent(EV_EXPLORE_CHOOSE_HERO, true, self.selectedRole, self.curRoleId)
		AlertManager:closeLayer(self)
	end)

	self.Button_pullDown:onClick(function()
		EventMgr:dispatchEvent(EV_EXPLORE_CHOOSE_HERO, false, self.selectedRole, self.curRoleId)
		AlertManager:closeLayer(self)
	end)

	self.Button_cover:onClick(function()
		EventMgr:dispatchEvent(EV_EXPLORE_CHOOSE_HERO, true, self.selectedRole, self.curRoleId)
		AlertManager:closeLayer(self)
	end)
end

function CommandTaskSelectView:refreshView()
	self.Button_pullUp:setVisible(not self.curRoleId)
	self.Label_power:setText(HeroDataMgr:getHeroPower(self.selectedRole))
	self:updateRoleList()

	self.Button_pullUp:setVisible(not self.curRoleId)
	self.Button_cover:setVisible(self.curRoleId and self.selectedRole ~= self.curRoleId)
	self.Button_pullDown:setVisible(self.curRoleId and self.curRoleId == self.selectedRole)
end

function CommandTaskSelectView:updateRoleList()
	for k, v in ipairs(self.showList) do
		local item = self.uiGrid_role:getItem(k)
		if not item then
			item = self.Panel_roleItem:clone()
			item:setName("roleItem"..k)
			self.uiGrid_role:pushBackCustomItem(item)
		end
		local Image_border = TFDirector:getChildByPath(item,"Image_border")
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Image_cur = TFDirector:getChildByPath(item,"Image_cur"):hide()
		local Image_working = TFDirector:getChildByPath(item,"Image_working"):hide()
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Label_working = TFDirector:getChildByPath(item,"Label_working")
		local Label_cur = TFDirector:getChildByPath(item,"Label_cur")
		local Image_quality = TFDirector:getChildByPath(item,"Image_quality"):show()
		Label_cur:setSkewX(15)
		Label_working:setSkewX(15)


		Image_icon:setTexture(HeroDataMgr:getIconPathById(v))
		Image_quality:setTexture(HeroDataMgr:getQualityPic(v))
		Image_cur:setVisible(self.curRoleId == v)
		Image_select:setVisible(self.selectedRole == v)
		Image_border:setTouchEnabled(true)
		Image_border:onClick(function()
			self.selectedRole = v
			self:refreshView()
		end)
	end
	self.Label_empty:setVisible(#self.showList <= 0)
	self.uiGrid_role:doLayout()
end

return CommandTaskSelectView