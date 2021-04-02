local NewRoleShowView = class("NewRoleShowView", BaseLayer)
require "lua.public.ScrollMenu"
local dressTable = TabDataMgr:getData("Dress")
local iTable = TabDataMgr:getData("Interaction")
local triggerEvent = TabDataMgr:getData("TriggerEvent")
function NewRoleShowView:initData(roleId, dressId)
    self.model = nil
    self.modelId = nil
    self.useId = RoleDataMgr:getUseId()
    self.curId = roleId or self.useId
    self.paramsDressId_ = dressId
    self.sendMsgType = 0 --1切换看板娘，2换装，3切换看板同时换装,4设置时装组
    self:refreshData()
    self.dressDatingEvent_ = self:getDressDatingEvent()
    self.roleList = RoleDataMgr:getRoleIdList()
    self.unInfoListItems = {}
    self.dressItemsList = {}
	self.DressOffsetX = {}
    self.selectDIdx = self:findDressIdx()
    self.selectIdx = -1
	self.selectLeftListIdx = 1
	self.isChangeRole = true	--是否切换了角色
    self.isFirst = true
    self.btnType_ = {
        dressType = 1,
        unInfoType = 2,
        infoType = 3,
		dressSetting = 4
    }
	self.firstIn = true
	RoleSwitchDataMgr:initAllHighDress()
end

function NewRoleShowView:getDressDatingEvent()
    local dressDatingEvent = {}
    for k, v in pairs(triggerEvent) do
        local params = v.params
        local result = v.result
        if params.dressId and result.data.scriptId then
            dressDatingEvent[params.dressId] = result.data.scriptId
        end
    end
    return dressDatingEvent
end

function NewRoleShowView:refreshData()
    self.curRoleFavor = RoleDataMgr:getFavorLevel(self.curId)
    self.dressId_ = RoleDataMgr:getDressIdList(self.curId)
	dump(self.dressId_)

    self.curRoleInfo = RoleDataMgr:getRoleInfo(self.curId)
    self.useDressId = self.curRoleInfo.dressId or self.curRoleInfo.roleModel
    --if self.Panel_base then
    --    self.Panel_base:timeOut(function()
    --        self.selectDIdx = self:findDressIdx()
    --    end,0.2)
    --end
    self.selectDIdx = self:findDressIdx()
    self:showUnInfoList()
    self.list_ = RoleDataMgr:getTriggerDatingList(self.curId) or {}
    self:resetList()
end

function NewRoleShowView:findUseDressId(roleInfo)	
	return RoleDataMgr:getDressGroupSelect(roleInfo.groupId, dressid)
end

function NewRoleShowView:resetList()
    local list = {}
    for i,v in ipairs(self.list_) do
        if 2 == DatingDataMgr:getDatingRuleData(v.datingRuleCid).item_type then
            table.insert(list,v)
        end
    end
    return list
end

function NewRoleShowView:findDressIdx()
    for i, v in ipairs(self.dressId_) do
        if RoleDataMgr:checkDressUseState(v, self.useDressId) then
            return i
        end
    end

	return 1
end

function NewRoleShowView:ctor(roleId, dressId)
    self.super.ctor(self)

    self:initData(roleId, dressId)

    self:init("lua.uiconfig.role.newRoleShowView")
end

function NewRoleShowView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(self.ui, "Panel_base")
    self.Image_roleInfoBg = TFDirector:getChildByPath(self.ui, "Image_roleInfoBg")
    self.Image_bg2 = TFDirector:getChildByPath(self.ui, "Image_bg2"):hide()
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")
    self.Panel_black = TFDirector:getChildByPath(self.ui, "Panel_black")

    self.Button_switch = TFDirector:getChildByPath(self.ui, "Button_switch")
    self.Button_switch_set = TFDirector:getChildByPath(self.ui, "Button_switch_set")
    self.Label_change = TFDirector:getChildByPath(self.Button_switch, "Label_change")
    self.Panel_play = TFDirector:getChildByPath(self.Button_switch, "Panel_play")
    self.Image_notplay = TFDirector:getChildByPath(self.Button_switch, "Image_notplay")
    self.Image_circle = TFDirector:getChildByPath(self.Button_switch, "Image_circle")
	self.NpcEffect = TFDirector:getChildByPath(self.ui, "NpcEffect")

    if self.Spine_effectHB then
        self.Spine_effectHB:hide()
    end

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)

    self:initLeft()
    self:initRight()
    self:initMid()
    --self:enterAction()

    self:initTopLayer()

    self:showRoleList()

    --self:tableCellTouched(true)
	self:selectDefaultDress(true)

    self:updateSwitchState()
end

--[[
    fix 超框问题
    单独更新topLayer
]]
function NewRoleShowView:initTopLayer()
    local langCode = TFLanguageMgr:getUsingLanguage()
    if (langCode == cc.GERMAN) then
        local topLayer = self.topLayer
        if(topLayer) then
            local title1 = TFDirector:getChildByPath(topLayer, "TextArea_title")
            local title2 = TFDirector:getChildByPath(topLayer, "TextArea_title_1")
            
            if (title1) then
                local pos = title1:getPosition()
                title1:setPosition(ccp(pos.x + 100, pos.y))
            end

            if (title2) then
                local pos = title2:getPosition()
                title2:setPosition(ccp(pos.x + 100, pos.y))
            end
        end
    end
end

function NewRoleShowView:selectDefaultDress(dontNeedResetScroll)
	ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
	ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
	self:selectOne(self.selectIdx, self.btnType_.dressType, dontNeedResetScroll)
end

function NewRoleShowView:initMid()
    self.Panel_mid = TFDirector:getChildByPath(self.ui, "Panel_mid"):hide()
    self.Label_role_name = TFDirector:getChildByPath(self.Panel_mid, "Label_role_name")
    self.Label_enName = TFDirector:getChildByPath(self.Panel_mid, "Label_enName")
    self.Label_enName2 = TFDirector:getChildByPath(self.Panel_mid, "Label_enName2")

    self:initFavorAndMood()
end

function NewRoleShowView:refreshMid()
    self.Panel_right:show()
    self.Panel_mid:show()

    self.Label_role_name:setString(RoleDataMgr:getName(self.curId))
    self.Label_enName:setString(RoleDataMgr:getEnName(self.curId))
    self.Label_enName2:setString(RoleDataMgr:getEnName2(self.curId))
    self:refreshFavorAndMood()
end

function NewRoleShowView:initFavorAndMood()
    self.Image_favorAndMood = TFDirector:getChildByPath(self.Panel_mid, "Image_favorAndMood"):hide()
    self.Label_favor = TFDirector:getChildByPath(self.Image_favorAndMood, "Label_favor")
    self.Label_mood = TFDirector:getChildByPath(self.Image_favorAndMood, "Label_mood")
end

function NewRoleShowView:refreshFavorAndMood()
    local ishave = RoleDataMgr:getIsHave(self.curId)
    --self.Image_favorAndMood:setVisible(ishave)
    self.Image_favorAndMood:hide() --暂时调整为不显示
    local favor = RoleDataMgr:getFavorLevel(self.curId)
    self.Label_favor:setText("Lv." .. favor)
    local mood = RoleDataMgr:getMood(self.curId)
    self.Label_mood:setText(mood)
end

function NewRoleShowView:initLeft()
    self.Panel_left = TFDirector:getChildByPath(self.ui, "Panel_left")
    self.Panel_role_item_s = TFDirector:getChildByPath(self.ui, "Panel_role_item_s")
    self.Panel_role_item_uns = TFDirector:getChildByPath(self.ui, "Panel_role_item_uns")
    self.Panel_roleList = TFDirector:getChildByPath(self.Panel_left, "Panel_roleList")
end

function NewRoleShowView:selectBtn(type)
	if self.dressSettingSelect and type == self.btnType_.dressType then					--预览未解锁的时装修改了 Dress展示列表，现在策划要求 回到展示panel要变回来
		local cfg = TabDataMgr:getData("Dress", self.dressId_[self.selectDIdx])
		local selectid = RoleDataMgr:getDressGroupSelect(cfg.groupId, cfg.id)
		self.dressId_[self.selectDIdx] = selectid
		self.dressItemsList[self.selectDIdx].root.id = selectid
		self:updateRoleInfo()
		self:updateRoleModel(self.dressItemsList[self.selectDIdx].root.modelId)
		self:updateDressItem(self.selectDIdx)

		self:refreshDressSettingView()
	end
	    		
	self:changeBtnState(type)

	self.selectType = type
end

function NewRoleShowView:changeBtnState(type)
	self.Panel_dress:setVisible(type == self.btnType_.dressType)
	self.Panel_dress_settting:setVisible(type == self.btnType_.dressSetting)
    self.Panel_info:setVisible(type == self.btnType_.infoType)
    self.Panel_unInfo:setVisible(type == self.btnType_.unInfoType)

    self.Button_dress.select:setVisible(type == self.btnType_.dressType)
	self.Button_dress_set.select:setVisible(type == self.btnType_.dressSetting)
    self.Button_info.select:setVisible(type == self.btnType_.infoType)
    self.Button_unInfo.select:setVisible(type == self.btnType_.unInfoType)

    self.Button_dress:setTouchEnabled(type ~= self.btnType_.dressType)
	self.Button_dress_set:setTouchEnabled(type ~= self.btnType_.dressSetting)
    self.Button_info:setTouchEnabled(type ~= self.btnType_.infoType)
    self.Button_unInfo:setTouchEnabled(type ~= self.btnType_.unInfoType)
end

function NewRoleShowView:initRight()
    self.Panel_right = TFDirector:getChildByPath(self.ui, "Panel_right"):hide()

    self.Button_change = TFDirector:getChildByPath(self.ui, "Button_change")
    self.Button_huigu = TFDirector:getChildByPath(self.ui, "Button_huigu")
    self.Button_changeScene = TFDirector:getChildByPath(self.ui, "Button_changeScene")

    self.Button_dress = TFDirector:getChildByPath(self.Panel_right, "Button_dress")
    self.Button_dress.select = TFDirector:getChildByPath(self.Button_dress, "Image_select")
	self.Button_dress.originX = self.Button_dress:getPositionX()

	self.Button_dress_set = TFDirector:getChildByPath(self.Panel_right, "Button_dress_set"):hide()
    self.Button_dress_set.select = TFDirector:getChildByPath(self.Button_dress_set, "Image_select")
	self.Button_dress_set.originX = self.Button_dress_set:getPositionX()

    self.Button_unInfo = TFDirector:getChildByPath(self.Panel_right, "Button_unInfo")
    self.Button_unInfo.select = TFDirector:getChildByPath(self.Button_unInfo, "Image_select")
	self.Button_unInfo.originX = self.Button_unInfo:getPositionX()


    self.Button_info = TFDirector:getChildByPath(self.Panel_right, "Button_info")
    self.Button_info.select = TFDirector:getChildByPath(self.Button_info, "Image_select")
	self.Button_info.originX = self.Button_info:getPositionX()

    self.Panel_info = TFDirector:getChildByPath(self.Panel_right, "Panel_info")
    self.Panel_dress = TFDirector:getChildByPath(self.Panel_right, "Panel_dress")
	self.Panel_dress_settting = TFDirector:getChildByPath(self.Panel_right, "Panel_dress_settting"):hide()
    self.Panel_unInfo = TFDirector:getChildByPath(self.Panel_right, "Panel_unInfo")

    self:initPanelDress()
    self:initPanelUnInfo()
	self:initDressSettingView()
end

function NewRoleShowView:initDressSettingView()
	self.Panel_dress_settting.Button_change = TFDirector:getChildByPath(self.Panel_dress_settting, "Button_change")
	self.Panel_dress_settting.Button_change:onClick(function()
		local dressid = self.dressSettingData.group[self.dressSettingSelect]
		if GoodsDataMgr:getDress(dressid) == nil then
            local str = TextDataMgr:getText(304001)
            toastMessage(str)
        else
			self:onBtnChange()
        end
	end)
	self.Panel_dress_settting.Button_changeScene = TFDirector:getChildByPath(self.Panel_dress_settting, "Button_changeScene")
	self.dressSettingPrefab = TFDirector:getChildByPath(self.ui, "Panel_dress_setting_item")
	self.dressSettingPrefab.property = TFDirector:getChildByPath(self.dressSettingPrefab, "property")
	self.dressSettingPrefab.table = TFDirector:getChildByPath(self.dressSettingPrefab, "table")
	self.dressSettingPrefab.dressitem = TFDirector:getChildByPath(self.dressSettingPrefab, "dressitem")

	self.Panel_dress_settting.listView = UIListView:create(TFDirector:getChildByPath(self.Panel_dress_settting, "ScrollView_dressSetList"))
end

function NewRoleShowView:initDressSettingTurnView(item)
	if item.turnView ~= nil then
		item.turnView:removeAllItems()
		item.turnView = nil
	end
	item.name = TFDirector:getChildByPath(item, "dressname")
	item.desc = TFDirector:getChildByPath(item, "desc")
	item.turnView = UITurnView:create(TFDirector:getChildByPath(item, "listScrollView"))
	item.turnView:setItemModel(self.dressSettingPrefab.dressitem:clone())

	local unlock_1 = GoodsDataMgr:getDress(self.dressSettingData.group[1])

	local offsetX = {}
	
	local function scrollCallback(target, offsetRate, customOffsetRate)
		item.turnView.isScrolling = true
		local items = target:getItem()
		local cameraNearPlane = 10
		local cameraFieldOfView_half = 60 / 2
		local Pi_const = 3.1415926
		for i, item in ipairs(items) do
		    local rate = offsetRate[i]
		    if rate then
		        local rrate = 1 - rate
		        local customRate = customOffsetRate[i]
		        --item.mask:setOpacity(255 * rrate)
		        if customRate then
					local z = -customRate * 100
		            item:setPositionZ(z)
					if offsetX[i] then						
						item:setPositionX(offsetX[i] + 5 * (-z) * math.tan(cameraFieldOfView_half / Pi_const))
					end
		        end
		        item:setZOrder(rrate * 100)
			end
		end
	end

	local function completeCallBack(target,selectIdx)
		if self.dressSettingSelect == selectIdx then
			return
		end
		local curSelectId = self.dressSettingData.group[selectIdx]
		if curSelectId ==nil then
			return
		end

		if self.dressSettingSelect then
			self.dressSettingTable[self.dressSettingSelect].button_touch:hide()
		end
		self.dressSettingTable[selectIdx].button_touch:show()

		if self.dressSettingTable[selectIdx].unlock and self.dressSettingTable[1].unlock then
			self.dressSettingTable[selectIdx].mask:hide()
		end
	
		local cfg = dressTable[curSelectId]
		item.name:setTextById(cfg.skinSettingTitle)
		item.desc:setTextById(cfg.skinSettingDesc)

		local unlock = GoodsDataMgr:getDress(curSelectId)
		local using = false
		if RoleDataMgr:checkGroupSelect(curSelectId) then
			using = true
		end
		self.Panel_dress_settting.Button_change:setGrayEnabled(not unlock_1 or not unlock or using)
		self.Panel_dress_settting.Button_change:setTouchEnabled(not unlock_1 and unlock and not using)

		self.dressId_[self.selectDIdx] = curSelectId
		self:refreshDressScroll(curSelectId,true)

		self:updateDressSetProperties(curSelectId)
		
		self.dressSettingSelect = selectIdx

		if next(offsetX) ==nil then
			for i=1,#self.dressSettingTable do
				table.insert(offsetX, self.dressSettingTable[i]:getPositionX())
			end
		end
	end

	item.turnView:registerScrollCallback(scrollCallback)
	item.turnView:registerSelectCallback(completeCallBack)

	self.dressSettingTable = {}
	local useIdx = 1
	local bool = true
	for i=1, #self.dressSettingData.group do
		local turnItem = item.turnView:pushBackItem()
		local cfg = dressTable[self.dressSettingData.group[i]]
		local unlock = GoodsDataMgr:getDress(self.dressSettingData.group[i])
		turnItem.unlock = unlock
		turnItem.posx = turnItem:getPositionX()

		turnItem.bg = TFDirector:getChildByPath(turnItem, "bg")
		turnItem.bg:setTouchEnabled(true)
		turnItem.bg:setSwallowTouch(true)

		turnItem.lock = TFDirector:getChildByPath(turnItem, "lock"):hide()
		turnItem.lock:setVisible(not unlock or not unlock_1)

		turnItem.select = TFDirector:getChildByPath(turnItem, "select"):hide()
		if unlock_1 and self.dressSettingData.group[i] == RoleDataMgr:getDressGroupSelect(cfg.groupId, cfg.id) then
			turnItem.select:show()
			turnItem.lock:hide()
		end

		turnItem.button_touch = TFDirector:getChildByPath(turnItem, "button_touch")
		turnItem.button_touch:hide()
		turnItem.button_touch:onClick(function()
			if not unlock_1 then
				if unlock then
					Utils:showTips(13203056)
				else
					Utils:showInfo(self.dressSettingData.group[i],nil, not unlock, true)
				end						
				return 
			elseif not unlock then			
				Utils:showInfo(self.dressSettingData.group[i],nil, not unlock, true)
				return		
			end

			if RoleDataMgr:checkGroupSelect(self.dressSettingData.group[i]) then
				return
			end
			self.dressId_[self.selectDIdx] = self.dressSettingData.group[i]	--改变列表信息需要写在设置请求发送之前,不能写在请求的回调里, 因为原有逻useDress方法在发送请求之前用到了列表信息时装self.dressId_

			self:onBtnDressSet(self.dressSettingData.group[i])					
		end)

		

		turnItem.ImageLock = TFDirector:getChildByPath(turnItem, "ImageLock"):hide()
		turnItem.ImageLock:setVisible(not unlock or not unlock_1)

		turnItem.mask = TFDirector:getChildByPath(turnItem, "mask"):show():hide()
		turnItem.mask:setVisible(not unlock or not unlock_1)

		turnItem.nodeDress = TFDirector:getChildByPath(turnItem, "nodeDress")
		turnItem.nodeDress:setTexture(cfg.skinSettingIcon)
		turnItem.nodeDress:setTouchEnabled(true)
		turnItem.nodeDress:setSwallowTouch(true)
		turnItem.nodeDress:addMEListener(TFWIDGET_CLICK,function()
			item.turnView:scrollToItem(i)
		end)
	
		if unlock_1 and unlock and bool then
			useIdx = i
			bool = false
		end

		if unlock_1 and RoleDataMgr:checkGroupSelect(self.dressSettingData.group[i]) then
			useIdx = i
			turnItem.select:show()
		end	

		table.insert(self.dressSettingTable, turnItem)
	end
	item.turnView:scrollToItem(useIdx)
end

function NewRoleShowView:updateDressSetProperties(selectId)
	self.dressSetPropertiesItems = self.dressSetPropertiesItems or{}
	for i=#self.dressSetPropertiesItems + 1,2, -1 do
		self.Panel_dress_settting.listView:removeItem(i)
	end

	self.dressSetPropertiesItems = {}

	local dressCfg = dressTable[selectId]

	for i = 1, #dressCfg.exActionList do
		local prefab = self.dressSettingPrefab.property:clone()
		self.Panel_dress_settting.listView:pushBackCustomItem(prefab)

		local interactionId = dressCfg.exActionList[i]
		local name = TFDirector:getChildByPath(prefab, "itemname"):show()
		local lock = TFDirector:getChildByPath(prefab, "lock"):hide()
		local unlock = TFDirector:getChildByPath(prefab, "unlock"):hide()		

		local icfg = iTable[interactionId]
		name:setTextById(icfg.exActionSettingTitle)

		local enough = GoodsDataMgr:isGoodsEnough(icfg.conditionEx.ownItems)
		if enough then
			unlock:show()
			lock:hide()
		else
			unlock:hide()
			lock:show()
		end	

		local touchArea = TFDirector:getChildByPath(prefab, "button_touch")
		touchArea:onClick(function()
			local itemId;
			for k, v in pairs( icfg.conditionEx.ownItems or {}) do
				itemId = k
				break
			end
			if itemId then
				Utils:showInfo(itemId,nil, true, true)
			end
		end)

		table.insert(self.dressSetPropertiesItems, prefab)	
	end
end


function NewRoleShowView:onBtnDressSet(id)
	if table.indexOf(self.dressSettingData.group, self.curUseDressId) ~= -1 then--如果当前使用的dressID存在于 当前的时装组中，直接请求更换	
		--if RoleDataMgr:checkDressUseState(id, self.useDressId) and RoleDataMgr:checkRoleUseState(self.curId) then--如果当前使用的时装就是选中的，暂不处理

		--else
			self.sendDressGroupType = 1			--1直接更换时装,2只设置时装组
			TFDirector:send(c2s.ROLE_REQ_SET_DRESS_GROUP, {id})	--请求设置			
		--end
	else
		self.sendDressGroupType = 2	--1直接更换时装,2只设置时装组
		TFDirector:send(c2s.ROLE_REQ_SET_DRESS_GROUP, {id})	--请求设置
	end		
end

function NewRoleShowView:refreshDressScroll(id, bChange)	
	if bChange then
		local cfg = dressTable[id]
		local index = self.selectDIdx
		for k, val in ipairs (self.dressItemsList) do
			if cfg.groupId == val.root.data.groupId then
				index = k
				break;
			end
		end
		print("------------------"..index.. "--------------")
--		self.dressItemsList[index].root.data = cfg
		self.dressItemsList[index].root.id = id		--修改外面的dresslist为时装组中选中的时装
		
		for i, v in ipairs(self.dressId_) do
			self:updateDressItem(i)
		end
		self:updateRoleModel(self.dressItemsList[index].root.modelId)
	else
		self:updateRoleModel(self.dressItemsList[self.selectDIdx].root.modelId)
	end
	self:updateRoleInfo()
end

function NewRoleShowView:refreshDressSettingView()
	if table.count(self.dressSettingData.group) < 2 then
		return
	end
	self.dressSettingSelect = nil		--清除当前选中的时装组序号
	self.Panel_dress_settting.listView:removeAllItems()
	local prefab = self.dressSettingPrefab.table:clone()
	self.Panel_dress_settting.listView:pushBackCustomItem(prefab)
	self:initDressSettingTurnView(prefab)
end

function NewRoleShowView:showDressSettingBtn(data)
	local show = false
	if data and data.skinGroup and table.count(data.skinGroup) > 0 then
		show = true
	end
	self.dressSettingData = {}
	self.dressSettingData.id = data.id
	self.dressSettingData.properties = data.exActionList or {}
	self.dressSettingData.group = data.skinGroup or {}

	self.Button_dress_set:setVisible(show)
	self.Button_dress_set:setTouchEnabled(true)
	self.Button_dress_set:setTextureNormal("ui/dresssetting/1.png")
	self.Button_dress_set.select:setTexture("ui/dresssetting/2.png")
	local x0 = self.Button_dress.originX - 20
	local step = 113
	if show then
		self.Button_dress:setTextureNormal("ui/dresssetting/1.png")
		self.Button_dress.select:setTexture("ui/dresssetting/2.png")
		self.Button_dress:setPositionX(x0)

		self.Button_dress_set:setPositionX(x0 + step * 2)

		self.Button_info:setTextureNormal("ui/dresssetting/1.png")
		self.Button_info.select:setTexture("ui/dresssetting/2.png")
		self.Button_info:setPositionX(x0 + step)

		self.Button_unInfo:setTextureNormal("ui/dresssetting/1.png")
		self.Button_unInfo.select:setTexture("ui/dresssetting/2.png")
		self.Button_unInfo:setPositionX(x0 + step * 3)

		self:refreshDressSettingView()
	else
		self.Button_dress:setTextureNormal("ui/newCity/build/5.png")
		self.Button_dress.select:setTexture("ui/newCity/build/18.png")
		self.Button_dress:setPositionX(self.Button_dress.originX)

		self.Button_info:setTextureNormal("ui/newCity/build/5.png")
		self.Button_info.select:setTexture("ui/newCity/build/18.png")
		self.Button_info:setPositionX(self.Button_info.originX)

		self.Button_unInfo:setTextureNormal("ui/newCity/build/5.png")
		self.Button_unInfo.select:setTexture("ui/newCity/build/18.png")
		self.Button_unInfo:setPositionX(self.Button_unInfo.originX)
		self.dressSettingSelect = nil		--清除当前选中的时装组序号
		self.Panel_dress_settting.listView:removeAllItems()
	end
end

function NewRoleShowView:initPanelDress()
    self:initDressScroll()
end

function NewRoleShowView:initPanelUnInfo()
    self:initUnInfoScroll()
end

function NewRoleShowView:initUnInfoScroll()
    self.Panel_unInfoItem = TFDirector:getChildByPath(self.ui, "Panel_unInfoItem")
    local ScrollView_unInfo = TFDirector:getChildByPath(self.Panel_unInfo, "ScrollView_unInfo")
    self.unInfoListView = UIListView:create(ScrollView_unInfo)
    self.unInfoListView:setItemsMargin(10)

    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_unInfo, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(self.Panel_unInfo, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.unInfoListView:setScrollBar(scrollBar)

    self:showUnInfoList()
end

function NewRoleShowView:showUnInfoList()
    if not self.unInfoListView then
        return
    end
    self.unInfoListView:removeAllItems()

    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]
    if not data then
        self.unInfoIdList = {}
    else
        self.unInfoIdList = data.playAction or {}
    end

    for i, v in ipairs(self.unInfoIdList) do
		local item = self.Panel_unInfoItem:clone()
		self:initUnInfoItem(item,i)
		table.insert(self.unInfoListItems, item)
		self.unInfoListView:pushBackCustomItem(item)
    end

	local dressCfg = TabDataMgr:getData("Dress", selectId)
	for i, v in ipairs (dressCfg.exActionList) do
		local cfg = iTable[v]
		local enough = GoodsDataMgr:isGoodsEnough(cfg.conditionEx.ownItems)
		if enough then
			local item = self.Panel_unInfoItem:clone()
			self:initUnInfoExItem(item, i, v)
			table.insert(self.unInfoListItems, item)
			self.unInfoListView:pushBackCustomItem(item)		
		end
	end
end


function NewRoleShowView:initUnInfoExItem(item,idx, actionId)
	local data = iTable[actionId]
    item.desTime = 0
    for i, v in ipairs(data.lineShow) do
        local time = data.lineStop[i]
        if time then
            item.desTime = item.desTime + time
        end
    end
	idx = idx + #self.unInfoIdList
    local selectId = self.dressId_[self.selectDIdx]
    local dressData = dressTable[selectId]
    local Label_des = TFDirector:getChildByPath(item, "Label_des"):show()
    Label_des:setTextById(dressData.playWord[idx])

    local Label_lockDes = TFDirector:getChildByPath(item, "Label_lockDes"):hide()
    Label_lockDes:setTextById(dressData.playWord[idx])

    local Panel_unLockT = TFDirector:getChildByPath(item, "Panel_unLockT"):hide()

    local Label_unLockTDes = TFDirector:getChildByPath(Panel_unLockT, "Label_unLockTDes")
    local Button_c = TFDirector:getChildByPath(item, "Button_c"):show()
    local ishave = RoleDataMgr:getIsHave(self.curId)

    local defaultFont = 18
    if dressData.wordSize and #dressData.wordSize > 0 then
        defaultFont = dressData.wordSize[idx] or 18
    end
    Label_des:setFontSize(defaultFont)
    Label_lockDes:setFontSize(defaultFont)

    item.Button_c = Button_c
    Button_c:onClick(function()	
        self:updateAllUnInfoItemsState(true)
        item.Button_c:timeOut(function()
            self:updateAllUnInfoItemsState(false)			
        end,item.desTime + 1.5)

        if self.model then
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
                self.voiceHandle = nil
            end

            local delayTime = 0
			table.walk(data.lineStop, function(k,val)
				delayTime = delayTime + val
            end)
            
            local isPlayOk = self.model:newStartAction(data.action1, EC_PRIORITY.FORCE, delayTime, data.idleTo, data.idleToLoopDuration,0,true)
            if isPlayOk ~= -1  then
            	self.roleAnimationEffect = self.roleAnimationEffect or {}
				for k, v in pairs(self.roleAnimationEffect) do
					v:removeFromParent()
					self.roleAnimationEffect[k] = nil
				end
                self.model:showKanbanLines(data,ccp(360,100))
				self:refreshAnimationEffect(data["kanbanEffect"])
				self:refreshAnimationEffect(data["backgroundEffect"], true)
            end
        end
    end)
end

function NewRoleShowView:initUnInfoItem(item,idx)
    local data = iTable[self.unInfoIdList[idx]]
    item.data = data
    item.desTime = 0
    for i, v in ipairs(data.lineShow) do
        local time = data.lineStop[i]
        if time then
            item.desTime = item.desTime + time
        end
    end

    local selectId = self.dressId_[self.selectDIdx]
    local dressData = dressTable[selectId]
    local Label_des = TFDirector:getChildByPath(item, "Label_des"):hide()
    Label_des:setTextById(dressData.playWord[idx])
    local Label_lockDes = TFDirector:getChildByPath(item, "Label_lockDes"):hide()
    Label_lockDes:setTextById(dressData.playWord[idx])
    local Panel_unLockT = TFDirector:getChildByPath(item, "Panel_unLockT"):hide()
    item.Panel_unLockT = Panel_unLockT
    local Label_unLockTDes = TFDirector:getChildByPath(Panel_unLockT, "Label_unLockTDes")
    local Button_c = TFDirector:getChildByPath(item, "Button_c"):hide()
    local ishave = RoleDataMgr:getIsHave(self.curId)

    local defaultFont = 18
    if dressData.wordSize and #dressData.wordSize > 0 then
        defaultFont = dressData.wordSize[idx] or 18
    end
    Label_des:setFontSize(defaultFont)
    Label_lockDes:setFontSize(defaultFont)

	local condition1 = data.idleFrom ~= "" and self.model and self.model:getIdleStatus() == data.idleFrom
	local condition2 = data.idleFrom == ""
    if self.curRoleFavor >= data.favor and ishave and (condition1 or condition2) then
        Button_c:show()
        Label_des:show()
    elseif not condition1 then
        Button_c:setGrayEnabled(true)
        Button_c:setTouchEnabled(false)
        Button_c:show()
        Label_des:show()
    else
        Label_lockDes:show()
        Panel_unLockT:show()
        Label_unLockTDes:setText("Lv." .. data.favor)
    end
    item.Button_c = Button_c
    Button_c:onClick(function()
        self:updateAllUnInfoItemsState(true)
        item.Button_c:timeOut(function()
            self:updateAllUnInfoItemsState(false)
        end,item.desTime + 1.5)
        if self.model then
            --兼容双人看板，只能点击好感等级低的
            local realFavorLv = RoleDataMgr:getRoleFavorLv(self.curId)
            if data.favor > realFavorLv then
                Utils:showTips(13400301)
                return
            end
            if self.voiceHandle then
                TFAudio.stopEffect(self.voiceHandle)
                self.voiceHandle = nil
            end
            
            local delayTime = 0
			table.walk(data.lineStop, function(k,val)
				delayTime = delayTime + val
            end)
			
            local isPlayOk = self.model:newStartAction(data.action1, EC_PRIORITY.FORCE,delayTime,data.idleTo, data.idleToLoopDuration,0,true)
            if isPlayOk ~= -1  then
            	self.roleAnimationEffect = self.roleAnimationEffect or {}
				for k, v in pairs(self.roleAnimationEffect) do
					v:removeFromParent()
					self.roleAnimationEffect[k] = nil
				end
                self.model:showKanbanLines(data,ccp(360,100))
				self:refreshAnimationEffect(data["kanbanEffect"])
				self:refreshAnimationEffect(data["backgroundEffect"], true)
            end
        end
    end)
end

function NewRoleShowView:removeKanbanEffects()
	self.roleAnimationEffect = self.roleAnimationEffect or  {}
	for i=1,#self.roleAnimationEffect do
		self.roleAnimationEffect[i]:hide()
		self.roleAnimationEffect[i]:removeFromParent()
		self.roleAnimationEffect[i] = nil
	end
end

function NewRoleShowView:refreshAnimationEffect(effectIds, isBgEffect)
	if effectIds == nil or #effectIds == 0 then
		return;
	end

	local prefab = nil
    if not isBgEffect then
        prefab = self.Spine_sceneEffect
    else
        prefab = self.Spine_effectHB
    end
	
    for k,effectId in pairs(effectIds) do
        local effect, cfg = Utils:createEffectByEffectId(effectId)
        if effect then			
			local x = (cfg["offset"]["x"] or 0)
			local y = (cfg["offset"]["y"] or 0)
			effect:setPosition(ccp(prefab:getPositionX() + x, prefab:getPositionY() + y))
			prefab:getParent():addChild(effect)
			table.insert(self.roleAnimationEffect, effect)
        end
    end
end

function NewRoleShowView:updateAllUnInfoItemsState(isGay)
    for i, v in ipairs(self.unInfoListItems) do
        local item = v
        if item.Button_c then
            item.Button_c:setGrayEnabled(isGay)
            item.Button_c:setTouchEnabled(not isGay)
        end
    end
end

function NewRoleShowView:initItem(item,idx)
    item.Image_bottomNormal = TFDirector:getChildByPath(item, "Image_bottomNormal"):show()
    item.Image_bottomSelect = TFDirector:getChildByPath(item, "Image_bottomSelect"):hide()
    self:updateCellInfo(item,idx)
end

function NewRoleShowView:initDressScroll()
    self.Panel_dress_item = TFDirector:getChildByPath(self.ui, "Panel_dress_item")
    local ScrollView_dressList = TFDirector:getChildByPath(self.Panel_right, "ScrollView_dressList")
    self.TurnView_dressList = UITurnView:create(ScrollView_dressList)
    self.TurnView_dressList:setItemModel(self.Panel_dress_item)

    self:showDressScroll()
end

function NewRoleShowView:showDressScroll()
    self.TurnView_dressList:removeAllItems()
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
    
    --self.selectDIdx = self:findDressIdx()
    self.dressItemsList = {}
    for i, v in ipairs(self.dressId_) do
        if not self.dressItemsList[i] then
            self:addDressItem(i)
        end

        self:updateDressItem(i)
    end

    local realIdx = 1
    if self.firstIn and self.paramsDressId_ then
        for i, v in ipairs(self.dressId_) do
			local cfg = dressTable[v]
            if tonumber(v) == self.paramsDressId_  or table.indexOf(cfg.skinGroup, self.paramsDressId_) ~= -1 then
                realIdx = i
                self.paramsDressId_ = nil
                break
            end
        end
    end
	self.firstIn = false
    self.TurnView_dressList:jumpToItem(realIdx)
    self.selectDIdx = realIdx

    
    --self.TurnView_dressList:jumpToItem(self.selectDIdx)

    --local ScrollView_dressList = TFDirector:getChildByPath(self.Panel_right, "ScrollView_dressList")
    --ScrollView_dressList:hide()
    --ScrollView_dressList:timeOut(function()
    --    ScrollView_dressList:show()
    --end,0.3)
end

function NewRoleShowView:onPlotTurnViewSelect(target, selectIndex)
    self.TurnView_dressList.isScrolling = false
	if not self.isChangeRole and self.selectDIdx == selectIndex then
		return
	end
	self.isChangeRole = false
    local foo = self.dressItemsList[selectIndex]
    if not foo then
        return
    end
    local item = foo.root

    --if item.modelId == self.modelId then
    --    return
    --end

	self:removeKanbanEffects()
    self.selectDIdx = selectIndex

    self:updateRoleModel(self.dressItemsList[self.selectDIdx].root.modelId)

	self.paramsDressId_ = item.id
    --self:updateRoleModel(item.modelId)

	self:updateDressListItem()

	--todo 展示服装设置按钮
	self:showDressSettingBtn(item.data)

	
	if next(self.DressOffsetX) ==nil then
		for i=1,#self.dressItemsList do
			table.insert(self.DressOffsetX, self.dressItemsList[i].root:getPositionX())
		end
	end
end

function NewRoleShowView:updateDressListItem()
	local selectId
	local cfg = TabDataMgr:getData("Dress", self.dressId_[self.selectDIdx])
	if table.count( cfg.skinGroup) < 2 then
		selectId = cfg.id
	else
		selectId = RoleDataMgr:getDressGroupSelect(cfg.groupId, cfg.id)			
	end
	
	--把当前是时装组中正在使用的作为玩家时装设置项
	local useId
	for i = 1,#cfg.skinGroup do
		if RoleDataMgr:checkDressUseState(cfg.skinGroup[i], self.useDressId) and RoleDataMgr:checkRoleUseState(self.curId) then
			useId = cfg.skinGroup[i]
			break;
		end
	end
	if useId then
		selectId = useId
	end
	self.dressId_[self.selectDIdx] = selectId

	self:refreshDressScroll(self.dressId_[self.selectDIdx])

end

function NewRoleShowView:addDressItem(idx)
    local item = self.TurnView_dressList:pushBackItem()
    item.id = self.dressId_[idx]
    item.idx = idx
    item.Image_dressBottom = TFDirector:getChildByPath(item, "Image_dressBottom")
    item.Image_dress = TFDirector:getChildByPath(item, "Image_dress")
    item.Image_lockBottom = TFDirector:getChildByPath(item, "Image_lockBottom")
    item.Image_useBottom = TFDirector:getChildByPath(item, "Image_useBottom")
    item.Label_name = TFDirector:getChildByPath(item, "Label_name")
    item.Panel_touch = TFDirector:getChildByPath(item, "Panel_touch")
    item.Button_detail = TFDirector:getChildByPath(item, "Button_detail")
    item.Image_switchBpttom = TFDirector:getChildByPath(item, "Image_switchBpttom"):hide()
    item.Button_switch = TFDirector:getChildByPath(item, "Button_switch")
    item.Image_ok = TFDirector:getChildByPath(item, "Image_ok")
    item.Button_detail:onClick(function()
        --Box("item.id " .. tostring(item.id))
        Utils:showInfo(item.id, nil, not item.isUnlock, true)
    end)
    item.Panel_touch:onClick(function()
        self.TurnView_dressList:scrollToItem(idx)
        self.selectDIdx = idx
        --self:updateRoleModel(item.modelId)
    end)
    local foo = {}
    foo.root = item

    item.Button_switch:onClick(function()
        RoleSwitchDataMgr:handleSwitchList(item.id)
    end)

    self.dressItemsList[idx] = foo
    return foo.root
end

function NewRoleShowView:updateDressItem(idx)
	if (idx == 1 )then
		local aaaa = 1
		local bbb = 1
	end

    local foo = self.dressItemsList[idx]
    local item = foo.root
    local idx = item.idx
    local id = item.id
    local data = dressTable[id]
    if not data then
        Box("数据为空，id: ".. id)
        return
    end
    item.modelId = data.roleModel
    item.isUnlock = GoodsDataMgr:getDress(id)
    item.isSelect = idx == self.selectDIdx
    item.data = data

    item.Image_dress:setTexture(data.dressImg)
    item.Image_lockBottom:setVisible(not item.isUnlock)
    item.Image_useBottom:hide()
    item.Label_name:setTextById(data.nameTextId)
    local ishave = RoleDataMgr:getIsHave(self.curId)
    local switchState = RoleSwitchDataMgr:getSwitchState()
    item.Button_switch:setVisible(ishave and data.type == 2 and item.isUnlock and switchState)
    if data.type == 2 then
        local isInSwitch = RoleSwitchDataMgr:isInSwitchList(id)
        item.Image_ok:setVisible(isInSwitch)
        item.Image_switchBpttom:setVisible(ishave and item.isUnlock and switchState and isInSwitch)
    end

    if RoleDataMgr:checkDressUseState(item.id, self.useDressId) and RoleDataMgr:checkRoleUseState(self.curId) then
        item.Image_useBottom:show()
		self.curUseDressId = item.id
    end
end

function NewRoleShowView:onOk()
    self:useDress()
end

function NewRoleShowView:useDress()
    local selectId = self.dressId_[self.selectDIdx]
	print("使用时装",selectId)
    if selectId and self.curRoleInfo.sid then
        if GoodsDataMgr:getDress(selectId) == nil then
            local str = TextDataMgr:getText(304001)
            toastMessage(str)
        else
            RoleDataMgr:sendDress(self.curRoleInfo.sid,selectId)
        end
    end
end

function NewRoleShowView:showRoleList()
    local params = {
        ["upItem"]                  = self.Panel_role_item_uns,
        ["downItem"]                = self.Panel_role_item_uns,
        ["selItem"]                 = self.Panel_role_item_s,
        ["offsetX"]                 = 0,
        ["updateCellInfo"]          = handler(self.updateCellInfo,self),
        ["selCallback"]             = handler(self.selCallback,self),
        ["cellCount"]               = RoleDataMgr:getRoleCount(),
        ["isLoop"]                  = true,
        ["size"]                    = self.Panel_roleList:getContentSize(),
        ["isFromFairy"]             = true,
        ["callTouchBeganBack"]      = handler(self.tableCellTouchBegan,self),
        ["callTouchEndBack"]        = handler(self.tableCellTouched,self)
    }
    local scrollMenu = ScrollMenu:create(params);
    scrollMenu:setPosition(self.Panel_roleList:getPosition())
    self.Panel_roleList:getParent():removeChild(self.Panel_roleList:getParent():getChildByName("roleHeads"))
    self.Panel_roleList:getParent():addChild(scrollMenu,10)
    scrollMenu:setName("roleHeads")
    local jumpTo = RoleDataMgr:getRoleIdx(self.curId)
    scrollMenu:jumpTo(jumpTo);
    self.scrollMenu = scrollMenu
end

function NewRoleShowView:tableCellTouchBegan()
	self.isChangeRole = true
	self:selectBtn(self.btnType_.dressType)
end

function NewRoleShowView:tableCellTouched(isFirst)
    self.ui:timeOut(function()
        if self.selectIdx ~= -1 or isFirst then
            self.firstIn = isFirst
            ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
            self:selectOne(self.selectIdx, self.btnType_.dressType)
            print("tableCellTouched self.selectIdx ",self.selectIdx)
            self.selectIdx = -1
        end
    end,isFirst and 0 or 0.35)
end

function NewRoleShowView:initItem(item,idx)
    item.Image_bottomNormal = TFDirector:getChildByPath(item, "Image_bottomNormal"):show()
    item.Image_bottomSelect = TFDirector:getChildByPath(item, "Image_bottomSelect"):hide()
    self:updateCellInfo(item,idx)
end

function NewRoleShowView:enterAction()

end

function NewRoleShowView:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))
end

function NewRoleShowView:updateRoleModel(modelId)
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]
    local curModelId = modelId or RoleDataMgr:getModel(self.curId)                                                
    local isHModel = false
    if data and data.type and data.type == 2 then
        curModelId = data.highRoleModel
        isHModel = true
    end
    if self.modelId == curModelId then
        return
    end

    local curDayCid,curNightCid = SceneSoundDataMgr:getTempSceneCid()
    local sceneDayCfg = SceneSoundDataMgr:getMainSceneChange(curDayCid)
    local sceneNightCfg = SceneSoundDataMgr:getMainSceneChange(curNightCid)
    local hour = Utils:getTime(ServerDataMgr:getServerTime())
    local bgRes = "ui/mainLayer/new_ui/bg_morning.png"
    if hour <= 18 and hour >= 6 then
        if sceneDayCfg and sceneDayCfg.background then
            bgRes = sceneDayCfg.background
        end
    else
        if sceneNightCfg and sceneNightCfg.background then
            bgRes = sceneNightCfg.background
        end
    end
    self:refreshBg(self.Image_bg,bgRes)
    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

    local isShowHuigu = self:findDressDatingTrigger()
    self.Button_huigu:setVisible(isShowHuigu)

    self.modelId = curModelId

    if self.model then
        if self.model.effectHandle then
            TFAudio.stopEffect(self.model.effectHandle)
            self.model.effectHandle = nil
        end
        self.model:removeFromParent()       
    end
	print("model",self.modelId)
    self.model = ElvesNpcTable:createLive2dNpcID(self.modelId,false,false,nil,true).live2d:hide()
    self.Panel_base:addChild(self.model,1)
    self.model:setScale(0.7); --缩放
    local pos = ccp(410,-100)
    self.model:setPosition(pos);--位置
    self.effectSK = self.effectSK or {}
    for k,v in pairs(self.effectSK) do
        v:removeFromParent()
        self.effectSK[k] = nil      
    end
    self.effectSKB = self.effectSKB or {}
    for k,v in pairs(self.effectSKB) do
        v:removeFromParent()
        self.effectSKB[k] = nil
    end

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()

    local offPos = data.offSet
    if offPos and offPos.x and offPos.x ~= 0 and offPos.y and offPos.y ~= 0 then
        if data and data.type and data.type == 2 then
            self.model:setPosition(pos + ccp(offPos.x,offPos.y))
        else
            self.model:setPosition(pos + ccp(offPos.x-50,offPos.y))
        end
    end
    self.Panel_black:hide()

    if data.background and #data.background ~= 0 then
        if self.notFirst then
            self.Panel_black:show()
            self.Panel_black:setOpacity(255)
            self.Panel_black:runAction(CCFadeOut:create(0.5))
        end
        self.notFirst = true
        self.Image_bg2:show()
        self.Image_bg2:setTexture(data.background)
    else
        if self.Image_bg2:isVisible() then
            self.Panel_black:show()
            self.Panel_black:setOpacity(255)
            self.Panel_black:runAction(CCFadeOut:create(0.5))
            self.Image_bg2:hide()
        end
    end

    if data.backgroundEffect and #data.backgroundEffect ~= 0 then
        self:refreshEffect(data.backgroundEffect,true)
    end

    if data.kanbanEffect and #data.kanbanEffect ~= 0 then
        self:refreshEffect(data.kanbanEffect)
    end

    self:playBgm()
    self.model:show()

    if data and data.type and data.type == 2 then
        return
    end
    self.model:playMoveRightIn(0.3)
    --self.model:setZOrder(-1)
    --self.ui:timeOut(function()
    --    self.model:setZOrder(1)
    --    self.model:playMoveRightIn(0.3)
    --end,0.1)
end

function NewRoleShowView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.NpcEffect
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end
    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

     for k,effectId in pairs(effectIds) do
        local effect, cfg = Utils:createEffectByEffectId(effectId)
        if effect then			
			local x = (cfg["offset"]["x"] or 0)
			local y = (cfg["offset"]["y"] or 0)
			effect:setPosition(ccp(prefab:getPositionX() + x, prefab:getPositionY() + y))
			prefab:getParent():addChild(effect)
			table.insert(mgrTab, effect)
        end
    end
end

function NewRoleShowView:updateRoleInfo()
    local Label_desc = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_desc")
    Label_desc:setString(RoleDataMgr:getDesc(self.curId))

    local curRoleInfo = RoleDataMgr:getRoleInfo(self.curId)
    --身高
    local Label_height = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_height")
    Label_height:setString(curRoleInfo.height)
    --三维
    local Label_threeDimensional = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_threeDimensional")
    Label_threeDimensional:setTextById(curRoleInfo.threeDimensional)
    --声优
    local Label_theme = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_theme")
    local akiraId = curRoleInfo.akiraId2 or curRoleInfo.akiraId
    Label_theme:setString(TextDataMgr:getText(akiraId))
    --生日
    local Label_birthday = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_birthday")
    Label_birthday:setTextById(curRoleInfo.birthday)
    --体重
    local Label_weight = TFDirector:getChildByPath(self.Image_roleInfoBg,"Label_weight")
    Label_weight:setTextById(curRoleInfo.weight)
end

function NewRoleShowView:updateCellInfo(cell,cellIdx)
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx);
    local ishave = RoleDataMgr:getIsHave(roleId)
    local icon = TFDirector:getChildByPath(cell,"Image_icon")
    icon:setTexture(RoleDataMgr:getHeadIconPath(roleId))
    local lock = TFDirector:getChildByPath(cell,"Image_lock")
    lock:setVisible(not ishave)
    local Image_use = TFDirector:getChildByPath(cell,"Image_use")
    Image_use:setVisible(RoleDataMgr:checkRoleUseState(roleId))	
end

function NewRoleShowView:selCallback(cell,cellIdx)
    --if self.isFirst then
    --    ViewAnimationHelper.doMoveFadeInAction(self.Panel_mid, {direction = 1, distance = 30, ease = 1})
    --    ViewAnimationHelper.doMoveFadeInAction(self.Panel_right, {direction = 2, distance = 30, ease = 1})
    --    self:selectOne(cellIdx)
    --    self.isFirst = false
    --end
    self.selectIdx = cellIdx
	self.selectLeftListIdx = cellIdx

    cell:runAction(CCMoveBy:create(0.2, ccp(15, 0)))
end

function NewRoleShowView:selectOne(cellIdx, btnType, dontNeedResetScroll)
	if self.selectType ~= self.btnType_.dressSetting then	--策划要求当前在时装设置界面 就不切换页签
		self:selectBtn(btnType)
	end
    local roleId = RoleDataMgr:getRoleIdByShowIdx(cellIdx)
    self.curId = roleId
    self:refreshData()
	if not dontNeedResetScroll then
		self:showDressScroll()
	end
    self:refreshMid()

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

    self:updateRoleInfo()
    self:updateRoleModel(self.dressItemsList[self.selectDIdx].root.modelId)

    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
    self.voiceHandle = VoiceDataMgr:playVoice("change_kanban",self.curId,self.dressId_[self.selectDIdx])

end

function NewRoleShowView:checkChangeOk()
    local dressId = self.dressId_[self.selectDIdx]
    local isUnlock = GoodsDataMgr:getDress(dressId)
    local ishave = RoleDataMgr:getIsHave(self.curId)

    local isOk = false
    local sendMsgType = 0
    if ishave then
        if self.curId ~= self.useId then
            sendMsgType = 3
            if not RoleDataMgr:checkRoleUseState(self.curId) then
                isOk = true
            end
        end
    end
    if isUnlock and ishave then
        if not RoleDataMgr:checkDressUseState(dressId, self.useDressId) then
            if sendMsgType == 0 then
                sendMsgType = 2
            else
                sendMsgType = 3
            end
            isOk = true
        end
    else
        isOk = false
    end
    self.sendMsgType = sendMsgType
    return isOk,isUnlock,ishave
end

function NewRoleShowView:changeShowOne()

    self:updateRoleInfo()
    self:updateRoleModel()
end

function NewRoleShowView:onSwitchRole()
    self.useId = RoleDataMgr:getUseId()
    --self:showRoleList()
    if self.scrollMenu.elements then
        for i, v in ipairs(self.scrollMenu.elements) do
            self:updateCellInfo(v,i)
        end
    end

    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

	--self:selectBtn(self.btnType_.dressType)
end

function NewRoleShowView:switchRole()
    RoleDataMgr:switchRole(self.curId)
end

function NewRoleShowView:onChangeDressOk()

    self:onSwitchRole()

    self.useDressId = self.curRoleInfo.dressId

    local data = dressTable[self.useDressId]
    if not data then
        Box("数据为空，id: ".. self.useDressId)
        return
    end
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
    local quality = data.quality
    if quality == 1 then
        self.voiceHandle = VoiceDataMgr:playVoice("dress_low",self.curId)
    elseif quality > 1 then
        self.voiceHandle = VoiceDataMgr:playVoice("dress_high",self.curId)
    end
    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end

    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)

    self:playBgm()

	local LastType = self.selectType

	self:selectOne(self.selectLeftListIdx, self.btnType_.dressType)	

	if RoleSwitchDataMgr:getSwitchState() then
		self:changeBtnState(self.btnType_.dressType)
		self:showDressSettingBtn(data)
	else
		if LastType == self.btnType_.dressSetting and table.count(self.dressSettingData.group) >= 2 then
			self:changeBtnState(LastType)
		else
			self:changeBtnState(self.btnType_.dressType)
			self:showDressSettingBtn(data)
		end
	end
end

function NewRoleShowView:onShow()
    self.super.onShow(self)
    self.list_ = RoleDataMgr:getTriggerDatingList(self.curId) or {}
    self:resetList()
    local isShowHuigu = self:findDressDatingTrigger()
    self.Button_huigu:setVisible(isShowHuigu)
    self:playBgm()
    if self.dressItemsList then
        for i, v in ipairs(self.dressItemsList) do
            self:updateDressItem(i)
        end
    end
    local isOk,isUnlock,ishave = self:checkChangeOk()
    self.Button_change:setGrayEnabled(not isOk)
    self.Button_change:setTouchEnabled(isOk)
    self.Button_changeScene:setVisible(isUnlock and ishave and not isOk)
    if self.model then
        self.model:show();
    end
end

function NewRoleShowView:onClose()
    self.super.onClose(self)
    if self.voiceHandle then
        TFAudio.stopEffect(self.voiceHandle)
    end
end

function NewRoleShowView:setBgm()
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]

    if data and data.type and data.type == 2 and data.kanbanBgmId then
        SceneSoundDataMgr:Send_SetBackGround(0,0,data.kanbanBgmId,data.kanbanBgmId)
    end
end

function NewRoleShowView:updateSwitchState()

    local isSwitch = RoleSwitchDataMgr:getSwitchState()
    self.Panel_play:setVisible(isSwitch)
    self.Image_notplay:setVisible(not isSwitch)
    local str = isSwitch and 111000105 or 111000104
    self.Label_change:setTextById(str)
    if not isSwitch then
        self.Image_circle:stopAllActions()
    else
        self.Image_circle:runAction(CCRepeatForever:create(CCRotateBy:create(3,360)))
    end

    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end
end

function NewRoleShowView:updateSwitchList()
    for i, v in ipairs(self.dressId_) do
        self:updateDressItem(i)
    end
end

function NewRoleShowView:updateRoleList()
    self:onSwitchRole()
    local jumpTo = RoleDataMgr:getRoleIdx(self.curId)
    self.scrollMenu:jumpTo(jumpTo)
    self.scrollMenu:doLayout()
end

function NewRoleShowView:onBtnChange()

	local function callback()
        if self.sendMsgType == 1 then
            self:setBgm()
            self:switchRole()
        elseif self.sendMsgType == 2 then
            self:setBgm()
            self:onOk()
        elseif self.sendMsgType == 3 then
            self:setBgm()
            self:switchRole()
            self:onOk(0.2)
        end

        RoleSwitchDataMgr:Send_TurnSwitchState(false)
        -- self.sendMsgType = 0
    end

    local isSwitch = RoleSwitchDataMgr:getSwitchState()
    if not isSwitch then
        callback()
        return
    end

    if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_SwitchKanBanState) then
        callback()
    else
        local content = "更换看板会关闭轮播模式"
        Utils:openView("common.ReConfirmTipsView", {tittle = 310019, content = content, reType =EC_OneLoginStatusType.ReConfirm_SwitchKanBanState, confirmCall = callback})
    end

end

function NewRoleShowView:registerEvents()

    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_LIST,handler(self.updateSwitchList, self))
    EventMgr:addEventListener(self,EV_UPDATE_SWITCH_STATE,handler(self.updateSwitchState, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.switchRole, handler(self.onSwitchRole, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.changeDress, handler(self.onChangeDressOk, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.addRole, handler(self.updateRoleList, self))
	EventMgr:addEventListener(self,EV_DRESS_RECEVIE_GROUP, handler(self.onDressGroup, self))
	EventMgr:addEventListener(self,EV_DRESS_SET_SCUESS, handler(self.onDressSetSucess, self))

    local function scrollCallback(target, offsetRate, customOffsetRate)
        self.TurnView_dressList.isScrolling = true
		local items = target:getItem()
		local cameraNearPlane = 10
		local cameraFieldOfView_half = 60 / 2
		local Pi_const = 3.1415926
		for i, item in ipairs(items) do
		    local rate = offsetRate[i]
		    if rate then
		        local rrate = 1 - rate
		        local customRate = customOffsetRate[i]
		        if customRate then
					local z = -customRate * 100
		            item:setPositionZ(z)
					if self.DressOffsetX[i] then						
						item:setPositionX(self.DressOffsetX[i] + 5 * (-z) * math.tan(cameraFieldOfView_half / Pi_const))
					end
		        end
		        item:setZOrder(rrate * 100)
			end
		end
    end
    self.TurnView_dressList:registerScrollCallback(scrollCallback)
    self.TurnView_dressList:registerSelectCallback(handler(self.onPlotTurnViewSelect, self))

    self.Button_change:onClick(function()
		self:onBtnChange()     
    end)
	self.Button_dress_set:onClick(function()
        self:selectBtn(self.btnType_.dressSetting)
    end)

    self.Button_dress:onClick(function()
        self:selectBtn(self.btnType_.dressType)
    end)

    self.Button_info:onClick(function()
        self:selectBtn(self.btnType_.infoType)
    end)

    self.Button_unInfo:onClick(function()
        if self.TurnView_dressList.isScrolling then return end
        local dressId = self.dressId_[self.selectDIdx]
        local isUnlock = GoodsDataMgr:getDress(dressId)
        local ishave = RoleDataMgr:getIsHave(self.curId)
        if not isUnlock or not ishave then
            Utils:showTips(1701265)
            return
        end
        self:selectBtn(self.btnType_.unInfoType)
        self:showUnInfoList()
    end)

    self.Button_huigu:onClick(function ()
        local info = self:findDressDatingTrigger()
        if info then
            self.model:hide();
            DatingDataMgr:showDatingLayer(EC_DatingScriptType.SHOW_SCRIPT,info.currentNodeId,false,info.datingRuleCid)
        end
    end)

    self.Button_changeScene:onClick(function()
        AlertManager:closeLayer(self)
        Utils:openView("role.NewSceneShowView")
    end)

    self:setBackBtnCallback(function()
        local function confirmCallBack()
            local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
            local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
            SceneSoundDataMgr:Send_SetBackGround(tempDayCid,tempNightCid,tempDayBgmCid,tempNightBgmCid)
            AlertManager:closeLayer(self)
        end
        local function cancleCallBack()
            SceneSoundDataMgr:resetTempSaveData()
            AlertManager:closeLayer(self)
        end
        local haveChange = SceneSoundDataMgr:sceneIsChanged()
        if haveChange then
            Utils:openView("role.NewSceneChangeConfirm",confirmCallBack,cancleCallBack)
        else
            AlertManager:closeLayer(self)
        end
    end)

    self:setMainBtnCallback(function()
        local function confirmCallBack()
            local tempDayCid,tempNightCid = SceneSoundDataMgr:getTempSceneCid()
            local tempDayBgmCid,tempNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
            SceneSoundDataMgr:Send_SetBackGround(tempDayCid,tempNightCid,tempDayBgmCid,tempNightBgmCid)
            AlertManager:closeLayer(self)
        end
        local function cancleCallBack()
            SceneSoundDataMgr:resetTempSaveData()
            AlertManager:closeLayer(self)
        end
        local haveChange = SceneSoundDataMgr:sceneIsChanged()
        if haveChange then
            Utils:openView("role.NewSceneChangeConfirm",confirmCallBack,cancleCallBack)
        else
            AlertManager:closeLayer(self)
        end
        return true
    end)

    self.Button_switch:onClick(function()

        local isSwitch = RoleSwitchDataMgr:getSwitchState()
        if not isSwitch then
            local openState = RoleSwitchDataMgr:getOpenState()
            if openState == 0 then
                Utils:openView("role.RoleSwitchSettingView",1)
            else
                RoleSwitchDataMgr:Send_TurnSwitchState(not isSwitch)
            end
        else
            RoleSwitchDataMgr:Send_TurnSwitchState(not isSwitch)
        end

    end)

    self.Button_switch_set:onClick(function()
        Utils:openView("role.RoleSwitchSettingView",2)
    end)
end

function NewRoleShowView:findDressDatingTrigger()
    local dressId = self.dressId_[self.selectDIdx]
    local datingRuleCid = self.dressDatingEvent_[dressId]
    local info = nil

    for i, v in ipairs(self.list_) do
        if v.datingRuleCid == datingRuleCid then
            info = v
        end
    end
    return info
end

function NewRoleShowView:playBgm()
    local selectId = self.dressId_[self.selectDIdx]
    local data = dressTable[selectId]

    if RoleDataMgr:checkDressUseState(selectId, self.useDressId) and RoleDataMgr:checkRoleUseState(self.curId) then
        local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getTempBgmCid()
        local bgmCid
        local hour = Utils:getTime(ServerDataMgr:getServerTime())
        if hour <= 18 and hour >= 6 then
            bgmCid = curDayBgmCid
        else
            bgmCid = curNightBgmCid
        end
        local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(bgmCid)
        if soundCfg then
            AudioExchangePlay.playBGM(self, true,soundCfg.bgm)
        else
            AudioExchangePlay.playBGM(self, true,AudioExchangePlay.getDefaultBgm())
        end
    else
        if data and data.type and data.type == 2 and data.kanbanBgm and #data.kanbanBgm ~= 0 then
            AudioExchangePlay.playBGM(self, true,data.kanbanBgm)
        else
            local curDayBgmCid,curNightBgmCid = SceneSoundDataMgr:getCurSceneBgmId()
            local soundCfg = SceneSoundDataMgr:getSoundInfoByCid(curDayBgmCid)
            if soundCfg then
                AudioExchangePlay.playBGM(self, true,soundCfg.bgm)
            else
                AudioExchangePlay.playBGM(self, true,AudioExchangePlay.getDefaultBgm())
            end
        end
    end
end

function NewRoleShowView:onDressGroup(data)
	
end

function NewRoleShowView:onDressSetSucess(data)
	for k,v in ipairs (self.dressSettingData.group or {}) do
		self.dressSettingTable[k].select:hide()
		if RoleDataMgr:checkGroupSelect(v) then
			self.dressSettingTable[k].select:show()
		end
	end

	self:refreshDressScroll(data.dressId,true)

	if self.sendDressGroupType == 1 then
		if not RoleSwitchDataMgr:getSwitchState() then		
			self:onBtnChange()	--原有更换逻辑
		end
	end

	RoleSwitchDataMgr:insertSwitchList(data.dressId)
end

return NewRoleShowView