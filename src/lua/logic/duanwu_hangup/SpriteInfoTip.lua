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
local SpriteInfoTip = class("SpriteInfoTip",BaseLayer)

function SpriteInfoTip:ctor( ... )
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.spriteInfoTip")
end

function SpriteInfoTip:initData( roleData )
	-- body
	self.roleLists = {}
	if roleData then
		table.insert( self.roleLists, roleData )
	else
		local roles = TabDataMgr:getData("HangupEvtRole")

		local roleIds = table.keys(roles)

		table.sort(roleIds,function ( a, b)
			-- body
			return a < b
		end)

		for k, v in ipairs(roleIds) do
			local roleData = {}
			roleData.role = {roleId = v, isExplore = DuanwuHangUpDataMgr:checkRoleInExplore(v)}
			table.insert(self.roleLists,roleData)
		end

	end
	
	self.curRole = self.roleLists[1]
	self.activityId,self.activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo()
end

function SpriteInfoTip:initUI( ui )
	self.super.initUI(self,ui)

	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

	self.Label_sprite_name = TFDirector:getChildByPath(ui,"Label_sprite_name")

	self.Panel_union_sprite = TFDirector:getChildByPath(ui,"Panel_union_sprite")
	self.Label_player = TFDirector:getChildByPath(ui,"Label_player")

	self.Panel_sprite_normal = TFDirector:getChildByPath(ui,"Panel_sprite_normal")
	self.Button_assistant = TFDirector:getChildByPath(self.Panel_sprite_normal,"Button_assistant")


	self.Panel_sprite_assistant = TFDirector:getChildByPath(ui,"Panel_sprite_assistant")
	self.assistant_time = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Label_time")
	self.reward_count = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Label_count")
	self.Button_getAward = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Button_getAward")

	

	self.Panel_des = TFDirector:getChildByPath(ui,"Panel_des")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")


	local ScrollView_role = TFDirector:getChildByPath(ui,"ScrollView_role")
	self.uigrid_role = UIGridView:create(ScrollView_role)
	self.uigrid_role:setItemModel(self.Panel_role)
   	self.uigrid_role:setColumn(2)
   	self.uigrid_role:setColumnMargin(0)

	local ScrollView_des = TFDirector:getChildByPath(ui,"ScrollView_des")
	self.uiList_des = UIListView:create(ScrollView_des)

	self.Panel_des = TFDirector:getChildByPath(ui,"Panel_des")

	self.Panel_role = TFDirector:getChildByPath(ui,"Panel_role")

	self.Button_sample = TFDirector:getChildByPath(ui,"Button_sample")
	self.Button_deal = TFDirector:getChildByPath(ui,"Button_deal")

	self.Button_sample:setVisible(not self.showSample)
	self.Button_deal:setVisible(self.showSample)
	self:updateRoleList()
	self:updateRightInfo()
end

function SpriteInfoTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_SUPPORTROLE, function ( ... )
		-- body
		self:updateRoleList()
		self:updateRightInfo()
	end)
	
	self.Button_assistant:onClick(function ( ... )
		-- body
		local callFunc = function ( ... )
			-- body
			DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SET_SUPPORT_ROLE({self.curRole.role.roleId})
		end

		local supportRole = DuanwuHangUpDataMgr:getCurSupportRole()[1]
		if not supportRole then
			Utils:openView("duanwu_hangup.DuanwuSetAssistantRole",self.curRole.role.roleId, callFunc)
		else
			if DuanwuHangUpDataMgr.supAwardTime + self.activityInfo.extendData.supGatherInterval > ServerDataMgr:getServerTime() then
				
				local timgString = Utils:getTimeCountDownString(DuanwuHangUpDataMgr.supAwardTime + self.activityInfo.extendData.supGatherInterval,1)
				Utils:showTips(13200918,timgString)
				return
			end
			Utils:openView("duanwu_hangup.DuanwuChangeAssistantRole",supportRole.role.roleId,self.curRole.role.roleId, callFunc)
		end
	end)

	self.Button_getAward:onClick(function ( ... )
		-- body
		if DuanwuHangUpDataMgr.supAwardTime + self.activityInfo.extendData.supGatherInterval > ServerDataMgr:getServerTime() then
			local timgString = Utils:getTimeCountDownString(DuanwuHangUpDataMgr.supAwardTime + self.activityInfo.extendData.supGatherInterval,1)
			Utils:showTips(13200918,timgString)
			return
		end
		DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_GET_SUPPORT_AWARD()
	end)

	self.Button_sample:onClick(function ( ... )
		-- body
		self.showSample = true
		self.Button_sample:hide()
		self.Button_deal:show()
		self:updateDesList()
	end)

	self.Button_deal:onClick(function ( ... )
		-- body
		self.showSample = false	
		self.Button_sample:show()
		self.Button_deal:hide()
		self:updateDesList()
	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

function SpriteInfoTip:updateRoleList()
	-- body
	for k,v in ipairs(self.roleLists) do
		local item = self.uigrid_role:getItem(k)
		if not item then
			item = self.Panel_role:clone()
			self.uigrid_role:pushBackCustomItem(item)
		end

		local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
		local roleCfg = TabDataMgr:getData("HangupEvtRole",v.role.roleId)
		local Image_select = TFDirector:getChildByPath(item, "Image_select")
		local Image_assistant = TFDirector:getChildByPath(item, "Image_assistant")

		Image_icon:setTexture(roleCfg.icon)
		Image_select:setVisible(self.curRole == v)

		local isAssistant = DuanwuHangUpDataMgr:isCurSupportRole(v.role.roleId)
		Image_assistant:setVisible(isAssistant)

		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			-- body
			if self.curRole == v then return end
			self.curRole = v
			self:updateRoleList()
			self:updateRightInfo()
		end)
	end
end

function SpriteInfoTip:updateRightInfo( ... )
	-- body
	local roleCfg = TabDataMgr:getData("HangupEvtRole",self.curRole.role.roleId)

	self.Label_sprite_name:setTextById(roleCfg.nameId)

	self.Panel_sprite_assistant:hide()
	self.Panel_sprite_normal:hide()
	self.Panel_union_sprite:hide()
	self:updateDesList()
	local isAssistant = DuanwuHangUpDataMgr:isCurSupportRole(self.curRole.role.roleId)
	if self.curRole.playerId then
		self.Panel_union_sprite:show()
		self:updateUnionRole()
	elseif isAssistant then
		self.Panel_sprite_assistant:show()
		self:updateAssistantingRole()
	else
		self.Panel_sprite_normal:show()
		self:updateNormalRole()
	end
end

function SpriteInfoTip:updateNormalRole( ... )
	-- body
end

function SpriteInfoTip:updateDesList(  )
	local roleCfg = TabDataMgr:getData("HangupEvtRole",self.curRole.role.roleId)

	self.uiList_des:removeAllItems()
	for k,v in ipairs(roleCfg.roleBuffList) do
		
		self:addDesItem(v)
	end

	if not self.curRole.playerId then
		for k,v in ipairs(roleCfg.partyBuffList) do
			self:addDesItem(v)
		end
	end
end

function SpriteInfoTip:addDesItem( buffId )
	-- body
	local buffData = DuanwuHangUpDataMgr:getBuffData(buffId)
	if self.curRole.buff then
		for _k,_v in ipairs(self.curRole.buff) do
			if _v.buffId == buffId then
				buffData = _v
			end 
		end
	end
	local buffCfg = TabDataMgr:getData("HangupEvtBuff",buffId)
	if buffData or (not self.showSample) or buffCfg.buffActvType == 2 then
		buffData = buffData or {buffId = buffId,buffLv = 0}
		local desItem = self.Panel_des:clone()
		local Label_des1 = TFDirector:getChildByPath(desItem,"Label_des1")
		local Label_des2 = TFDirector:getChildByPath(desItem,"Label_des2")
		Label_des1:setText(TextDataMgr:getText(buffCfg.name))

		local width = Label_des2:getDimensions().width
		local richText = TFRichText:create(ccs(width,0))
		richText:setAnchorPoint(Label_des2:getAnchorPoint())
		Label_des2:addChild(richText)
		Label_des2.richText = richText
		Label_des2.richText:Text(DuanwuHangUpDataMgr:getRStringText(buffData,self.showSample))
		local height = math.max(Label_des1:getContentSize().height,Label_des2.richText:getContentSize().height)
		desItem:setContentSize(CCSizeMake(desItem:getContentSize().width,height + 10))
		self.uiList_des:pushBackCustomItem(desItem)
	end
end

function SpriteInfoTip:updateUnionRole( ... )
	-- body
	local Label_player = TFDirector:getChildByPath(self.Panel_union_sprite,"Label_player")
	Label_player:setText(self.curRole.playerName);
end

function SpriteInfoTip:updateAssistantingRole( ... )
	-- body
	local Label_time = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Label_time")
	local supportRole = DuanwuHangUpDataMgr:getCurSupportRole()[1]
	local curTime = math.min(ServerDataMgr:getServerTime(),self.activityInfo.extendData.eventEndingTimeStamp)
	local remandTime = math.max(0,curTime - supportRole.startTime)
	Label_time:setText(Utils:getTimeCountDownString(ServerDataMgr:getServerTime() + remandTime,1))


	local Image_icon = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Image_icon")
	local Label_count = TFDirector:getChildByPath(self.Panel_sprite_assistant,"Label_count")
	local id, count = next(self.activityInfo.extendData.supAwardPerMin)
	Image_icon:setTexture(GoodsDataMgr:getItemCfg(tonumber(id)).icon)
	Label_count:setText(count*math.floor(remandTime/60))
end

return SpriteInfoTip