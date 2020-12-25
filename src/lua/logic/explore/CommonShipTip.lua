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
local CommonShipTip = class("CommonShipTip",BaseLayer)

function CommonShipTip:ctor( nameText , roleId, checkStateFunc,callBack)
	-- body
	self.super.ctor(self)
	self.callBack = callBack
	self.curRoleId = roleId
	self.checkStateFunc = checkStateFunc
	self:showPopAnim(true)
	self.nameText = nameText
	self.selectedRole = roleId or self:getRoleList()[1]
	self:init("lua.uiconfig.explore.commonShipTip")
end

function CommonShipTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Label_power = TFDirector:getChildByPath(ui, "Label_power")
	self.Label_title = TFDirector:getChildByPath(ui, "Label_title")
	self.Button_pullDown = TFDirector:getChildByPath(ui, "Button_pullDown")
	self.Button_pullUp = TFDirector:getChildByPath(ui, "Button_pullUp")
	self.Button_cover = TFDirector:getChildByPath(ui, "Button_cover")
	self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

	self.Label_empty = TFDirector:getChildByPath(ui,"Label_empty")

	self.Panel_roleItem = TFDirector:getChildByPath(ui, "Panel_roleItem")
	local ScrollView_roleList = TFDirector:getChildByPath(ui, "ScrollView_roleList")

	self.Label_title:setText(self.nameText)
	self.uiGrid_role = UIGridView:create(ScrollView_roleList)
	self.uiGrid_role:setItemModel(self.Panel_roleItem)
	self.uiGrid_role:setColumn(6)
	self:refreshView()
end

function CommonShipTip:onShow( ... )
	self.super.onShow(self)
  	GameGuide:checkGuide(self)
end

function CommonShipTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_EXPLORE_SHIP_CLOSE, function ( ... )
    	-- body
    	AlertManager:closeLayer(self)
    end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_pullUp:onClick(function ( ... )
		-- body
		if self.selectedRole == self.curRoleId then
			AlertManager:closeLayer(self)
			return
		end

		if self.callBack then
			self.callBack(true, self.selectedRole)
		end
		-- AlertManager:closeLayer(self)
	end)

	self.Button_cover:onClick(function ( ... )
		-- body
		if self.selectedRole == self.curRoleId then
			AlertManager:closeLayer(self)
			return
		end

		if self.callBack then
			self.callBack(true, self.selectedRole)
		end
		-- AlertManager:closeLayer(self)
	end)

	self.Button_pullDown:onClick(function ( ... )
		-- body
		if not self.checkStateFunc(self.selectedRole) then
			return
		end
		if self.callBack then
			self.callBack(false, self.selectedRole)
		end
		-- AlertManager:closeLayer(self)
	end)

end

function CommonShipTip:refreshView( ... )
	-- body
	if self.selectedRole then
		self.Label_power:setText(HeroDataMgr:getHeroPower(self.selectedRole))
	else
		self.Label_power:setText(0)
	end
	self:updateRoleList()
	self.Button_pullUp:setVisible(not self.curRoleId)
	self.Button_pullDown:setVisible(self.checkStateFunc(self.selectedRole))
	self.Button_cover:setVisible(self.curRoleId and self.selectedRole ~= self.curRoleId)
end

function CommonShipTip:getRoleList( ... )
	-- body
	local roleList = HeroDataMgr:getShowList(true)
	local count = HeroDataMgr:getShowCount()

	local roleListId = {}
	for i = 1,count do
		local heroId = HeroDataMgr:getSelectedHeroId(i)
		if self.checkStateFunc(heroId) ~= self.nameText or heroId == self.curRoleId then
			table.insert(roleListId,heroId)
		end
	end
	return roleListId
end

function CommonShipTip:updateRoleList( ... )
	local roleList = self:getRoleList()
	self.Label_empty:setVisible(#roleList == 0)

	for i = 1,#roleList do
		local heroId = roleList[i]
		local item = self.uiGrid_role:getItem(i)
		if not item then
			item = self.Panel_roleItem:clone()
			self.uiGrid_role:pushBackCustomItem(item)
			item:setName("roleItem"..i)
		end
		local Image_border = TFDirector:getChildByPath(item,"Image_border")
		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Image_cur = TFDirector:getChildByPath(item,"Image_cur")
		local Image_working = TFDirector:getChildByPath(item,"Image_working")
		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Label_working = TFDirector:getChildByPath(item,"Label_working")
		local Label_cur = TFDirector:getChildByPath(item,"Label_cur")
		local Image_11 = TFDirector:getChildByPath(item,"Image_11")
		local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
		Label_cur:setSkewX(15)
		Label_working:setSkewX(15)

		local isCur = heroId == self.curRoleId
		local stateText = self.checkStateFunc(heroId)
		local isSelected = self.selectedRole == heroId
		Image_icon:setTexture(HeroDataMgr:getIconPathById(heroId))
		Image_quality:setTexture(HeroDataMgr:getQualityPic(heroId))
		Image_cur:setVisible(isCur)
		Image_working:setVisible(not isCur and stateText)
		Label_working:setText(stateText)

		Image_select:setVisible(isSelected)
		Image_border:setTouchEnabled(true)
		Image_border:onClick(function ( ... )
			-- body
			self.selectedRole = heroId
			self:refreshView()
		end)
	end
	self.uiGrid_role:doLayout()
end

return CommonShipTip