local ZnqPersonInfoView = class("ZnqPersonInfoView", BaseLayer)

function ZnqPersonInfoView:initData()
	self.selectSkin = nil
	self.selectEffectId = nil
end

function ZnqPersonInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.znq_personinfo")
end

function ZnqPersonInfoView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_skinItem = TFDirector:getChildByPath(Panel_prefab, "Panel_skinItem")


    self.Button_change = TFDirector:getChildByPath(self.Panel_root , "Button_change")
    self.Spine_model = TFDirector:getChildByPath(self.Panel_root , "Spine_model")
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root , "Panel_content"):show()
    self.Panel_skin = TFDirector:getChildByPath(self.Panel_root , "Panel_skin"):hide()
    self.Button_openSkin = TFDirector:getChildByPath(self.Panel_root , "Button_openSkin")
    self.Button_closeSkin = TFDirector:getChildByPath(self.Panel_root , "Button_closeSkin")
    self.Label_roomId = TFDirector:getChildByPath(self.Panel_root , "Label_roomId")
    if WorldRoomDataMgr:getRoomType() == WorldRoomType.ZNQ_WORLD then
    	self.Label_roomId:setTextById(13202018, WorldRoomDataMgr:getRoomID())
    elseif WorldRoomDataMgr:getRoomType() == WorldRoomType.ZNQ_UNION then
    	self.Label_roomId:setTextById(13202019)
    end

    local ScrollView_skin = TFDirector:getChildByPath(self.Panel_skin,"ScrollView_skin")

    self.tableView_skin = Utils:scrollView2TableView(ScrollView_skin)
   	self.tableView_skin:setDirection(TFTableView.TFSCROLLVERTICAL)
	self.tableView_skin:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.tableCellSize,self))
    self.tableView_skin:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView_skin:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))



    self.Button_role_n = TFDirector:getChildByPath(self.Panel_skin,"Button_role_n")
    self.Image_role_s = TFDirector:getChildByPath(self.Panel_skin,"Image_role_s")
    self.Button_effect_n = TFDirector:getChildByPath(self.Panel_skin,"Button_effect_n")
    self.Image_effect_s = TFDirector:getChildByPath(self.Panel_skin,"Image_effect_s")

    self:updatePlayerInfo()
    self:updateSkinPanel()
    self:updateModel()
end

function ZnqPersonInfoView:updatePlayerInfo( ... )
	-- body
	local Label_name = TFDirector:getChildByPath(self.Panel_content,"Label_name")
	local Label_lv = TFDirector:getChildByPath(self.Panel_content,"Label_lv")
	local Label_union = TFDirector:getChildByPath(self.Panel_content,"Label_union")
	local Label_corn = TFDirector:getChildByPath(self.Panel_content,"Label_corn")

	local name_switch = TFDirector:getChildByPath(self.Panel_content,"Image_showName.Panel_switch")
	local effect_switch = TFDirector:getChildByPath(self.Panel_content,"Image_showEffect.Panel_switch")
	local invite_switch = TFDirector:getChildByPath(self.Panel_content,"Image_invite.Panel_switch")
	local Label_tip = TFDirector:getChildByPath(self.Panel_content, "Image_invite.Label_tip")
	Label_tip:setTextById(13317064)

	Label_name:setText(MainPlayer:getPlayerName())
	Label_lv:setText(PrivilegeDataMgr:getWishTreeLv())
	Label_union:setText(PrivilegeDataMgr:getCurClubWishLv())
	Label_corn:setText(GoodsDataMgr:getItemCount(570078))

	function changeNameSwitch( ... )
		-- body
		local showOtherName = SettingDataMgr:getWorldShowName()

	 	local movepos = me.p(-30,0)
	    if showOtherName then
	        movepos = me.p(30,0)
	    end

	    local light = TFDirector:getChildByPath(name_switch,"Image_light")
	    light:setPosition(movepos)
	end

	function changeEffectSwitch( ... )
		-- body
	 	local showOtherEffect = SettingDataMgr:getWorldShowEffect()
		local movepos = me.p(-30,0)
	    if showOtherEffect then
	        movepos = me.p(30,0)
	    end
	    light = TFDirector:getChildByPath(effect_switch,"Image_light")
	    light:setPosition(movepos)
	end

	changeNameSwitch()
	changeEffectSwitch()
	self:updateInviteSwitch()

	name_switch:onClick(function ( ... )
		-- body
		local showOtherName = SettingDataMgr:getWorldShowName()
	 	local value = showOtherName and "FALSE" or "TRUE" 
	 	SettingDataMgr:setWorldShowName(value)
		changeNameSwitch()
	end)

	effect_switch:onClick(function ( ... )
		-- body
	 	local showOtherEffect = SettingDataMgr:getWorldShowEffect()
	 	local value = showOtherEffect and "FALSE" or "TRUE" 
	 	SettingDataMgr:setWorldShowEffect(value)
		changeEffectSwitch()
	end)

	invite_switch:onClick(function ()
		local switchValue = MainPlayer:getSwitchByType(EC_SWITCH_TYPE.EXCHANGE_INVITE)
		local nextValue = 1
		if switchValue == 0 then
			nextValue = 1
		else
			nextValue = 0
		end
		local switch = {EC_SWITCH_TYPE.EXCHANGE_INVITE, nextValue}
		MainPlayer:sendReqChangeSwitch({switch})
	end)
end

function ZnqPersonInfoView:updateInviteSwitch()
	local invite_switch = TFDirector:getChildByPath(self.Panel_content, "Image_invite.Panel_switch")
	local switchValue = MainPlayer:getSwitchByType(EC_SWITCH_TYPE.EXCHANGE_INVITE)
	local isCanInvite = (switchValue == 0)
	local movepos = me.p(-30,0)
    if isCanInvite then
        movepos = me.p(30,0)
    end
    light = TFDirector:getChildByPath(invite_switch, "Image_light")
    light:setPosition(movepos)
end

function ZnqPersonInfoView:getShowList( ... )
	-- body
	if self.showEffectPanel then
		if not self.effectList then
			self.effectList = WorldRoomDataMgr:getCurControl():getAllShowEffectList()
		end
		return  self.effectList
	else
		if not self.roleList then
			self.roleList = WorldRoomDataMgr:getCurControl():getAllShowRoleList()
		end
		return self.roleList 
	end
end

function ZnqPersonInfoView:tableCellSize(tableView, idx)
	local size = self.Panel_skinItem:getSize()
    return size.height+2, (size.width + 2)*3
end

function ZnqPersonInfoView:numberOfCells(tableView)
	local size = math.ceil(#self:getShowList()/3)
    return size
end

function ZnqPersonInfoView:tableCellAtIndex(tableView,idx)
	local showList = self:getShowList()
    local cell = tableView:dequeueCell()
    local item = nil
    local itemSize = self.Panel_skinItem:getSize()
    if nil == cell then
        cell = TFTableViewCell:create()
        cell.items = {}
        for i = 1,3 do
	        item = self.Panel_skinItem:clone()
	        item:show()
	        item:setPosition(ccp((i-1)*(itemSize.width + 2) + itemSize.width*self.Panel_skinItem:getAnchorPoint().x,itemSize.height*self.Panel_skinItem:getAnchorPoint().y+1))
	        cell:addChild(item)
	        cell.items[i] = item
        end	
    end

    for i = 1,3 do
    	item = cell.items[i]
    	local data = showList[idx*3 + i]
    	if not data then 
    		item:hide()
    	else
    		item:show()
	    	if self.showEffectPanel then
				self:updateEffectItem(item, data)
	    	else
				self:updateRoleItem(item, data)
			end
		end
	end
    return cell
end

function ZnqPersonInfoView:updateSkinPanel( ... )
	-- body

    self.Button_effect_n:setVisible(not self.showEffectPanel)
    self.Image_role_s:setVisible(not self.showEffectPanel)
    self.Image_effect_s:setVisible(self.showEffectPanel)
    self.Button_role_n:setVisible(self.showEffectPanel)

	local control = WorldRoomDataMgr:getCurControl()
	self.actorData = control:getActorDataByPid(control:getMainHero():getPid())
   	self.tableView_skin:reloadData()
end

function ZnqPersonInfoView:registerEvents()
	self.super.registerEvents(self)

	self.Button_openSkin:onClick(function ( ... )
		-- body
		if not WorldRoomDataMgr:getCurControl():checkBuildFuncIsEnable(6) then
			Utils:showTips(13202017)
			return
		end
		self.Panel_content:hide()
		self.Panel_skin:show()
	end)

	self.Button_closeSkin:onClick(function ( ... )
		-- body
		self.Panel_content:show()
		self.Panel_skin:hide()
	end)

    self.Button_effect_n:onClick(function ( ... )
        -- body
        self.showEffectPanel = true
        self:updateSkinPanel()
    end)

    self.Button_role_n:onClick(function ( ... )
        -- body
        self.showEffectPanel = false
        self:updateSkinPanel()
    end)

    self.Button_change:onClick(function ( ... )
    	-- body 切换大世界房间
    	Utils:openView("2020ZNQ.ChangeWorldRoomView",{WorldRoomType.ZNQ_WORLD, WorldRoomType.ZNQ_UNION})
    end)

    
	EventMgr:addEventListener(self, EV_UPDATE_WISHTREE_LV, handler(self.updatePlayerInfo, self))
	EventMgr:addEventListener(self, EV_PLAYER_SWITCH_UPDATE, handler(self.updateInviteSwitch, self))
end

function ZnqPersonInfoView:updateRoleItem(item , data)
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_sel = TFDirector:getChildByPath(item,"Image_sel")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")

	local cfg = TabDataMgr:getData("CityRoleModel",data)
	Image_icon:setTexture(cfg.showPic)

	Label_name:setTextById(TabDataMgr:getData("Dress",data).nameTextId)
	local isUnLock = false
	for k,v in ipairs(cfg.sameModelId) do
		if GoodsDataMgr:getDress(v) then
			isUnLock = true
			break
		end
	end
	local isSel = (not self.selectSkin and self.actorData.skinCid == data) or self.selectSkin == data
	Image_lock:setVisible(not isUnLock)
	Image_sel:setVisible(isUnLock and isSel)
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if not isUnLock then
			Utils:showTips(13202015)
			return
		end
		self.selectSkin = data
		self:updateSkinPanel()
		self:updateModel()
	end)
end

function ZnqPersonInfoView:updateEffectItem(item , id)
	-- body
	local data = TabDataMgr:getData("CityRoleModelEffect",id)
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Image_sel = TFDirector:getChildByPath(item,"Image_sel")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")

	Image_icon:setTexture(data.iconShow)
	local isUnLock = GoodsDataMgr:getItem(data.id)
	local isSel = (not self.selectEffectId and self.actorData.effectId == data.id) or self.selectEffectId == data.id

	Label_name:setTextById(data.nameTextId)
	Image_lock:setVisible(not isUnLock)
	Image_sel:setVisible(isUnLock and isSel)
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if not isUnLock then
			Utils:showInfo(id)
			return
		end
		self.selectEffectId = data.id
		self:updateSkinPanel()
		self:updateModel()
	end)
end

function ZnqPersonInfoView:updateModel( ... )
	local control = WorldRoomDataMgr:getCurControl()
	self.actorData = control:getActorDataByPid(control:getMainHero():getPid())
	-- body
	local skinCid = self.selectSkin or self.actorData.skinCid
	local conf = TabDataMgr:getData("CityRoleModel",skinCid)
	self.Spine_model:setFile(conf.rolePath)
	if conf.flip then
		self.Spine_model:play("idle",true)
	else
		self.Spine_model:play("r_idle",true)
	end

	local effectCid = self.selectEffectId or self.actorData.effectId

	local effectCfg = TabDataMgr:getData("CityRoleModelEffect",effectCid)
	if effectCfg then
		local actionCfg = TabDataMgr:getData("WorldObjectAction",effectCfg.actionId)
		if not self.effectAni then
			self.effectAni = SkeletonAnimation:create(actionCfg.motionRecourse_1)
			self.Spine_model:addChild(self.effectAni)
		end
		self.effectAni:setScale(1)
		self.effectAni:setFile(actionCfg.motionRecourse_1)
		self.effectAni:setPosition(ccp(actionCfg.offSet.x*1.4,actionCfg.offSet.y*1.4))
		self.effectAni:play(actionCfg.motionAction_1,true)
		self.effectAni:setScale(1.4)
	elseif self.effectAni then
		self.effectAni:removeFromParent()
	end
end

function ZnqPersonInfoView:onClose( ... )
	-- body
	self.super.onClose(self)
	local control = WorldRoomDataMgr:getCurControl()
	if self.selectSkin and self.selectSkin ~= self.actorData.skinCid then
		control:operateChangeSkin(self.selectSkin)
	end

	if self.selectEffectId and self.selectEffectId ~= self.actorData.effectId then
		control:operateChangeEffect(self.selectEffectId)
	end
end


return ZnqPersonInfoView
