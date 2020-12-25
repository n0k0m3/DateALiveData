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

local FortReadyTip = class("FortReadyTip",BaseLayer)

function FortReadyTip:ctor( data)
	-- body
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(data)
	self:init("lua.uiconfig.activity.fortReadyTip")
end

function FortReadyTip:initData(data)
	-- body
	self.fortData = data
	self.curSelectedPage = self.curSelectedPage or 1
	self.fortCfg = TabDataMgr:getData("HangupEvtFort",data.id)
	self.showFlagState = 1
	self.tmpRoleList = {}
end

function FortReadyTip:getRoleLists( )
	-- body
	local roleList = {}
	if self.curSelectedPage == 1 then

		if self.roleList then return self.roleList end

		local roles = TabDataMgr:getData("HangupEvtRole")

		local roleIds = table.keys(roles)

		table.sort(roleIds,function ( a, b)
			-- body
			return a < b
		end)

		for k, v in ipairs(roleIds) do
			local roleData = {}
			roleData.role = {roleId = v}
			roleData.isExplore = DuanwuHangUpDataMgr:checkRoleInExplore(v)
			table.insert(roleList,roleData)
		end
		self.roleList = roleList
	else
		roleList = DuanwuHangUpDataMgr:getOtherSupportRoleList()
	end
	return roleList
end

function FortReadyTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	
	self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
	self.Image_cg = TFDirector:getChildByPath(ui,"Image_cg")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Panel_sit = TFDirector:getChildByPath(ui,"Panel_sit")
	self.Panel_own = TFDirector:getChildByPath(ui,"Panel_own")
	self.Button_own = TFDirector:getChildByPath(self.Panel_own,"Button_normal")
	self.Button_sel_own = TFDirector:getChildByPath(self.Panel_own,"Button_sel")
	self.Panel_assistant = TFDirector:getChildByPath(ui,"Panel_assistant")
	self.Button_assistant = TFDirector:getChildByPath(self.Panel_assistant,"Button_normal")
	self.Button_sel_assistant = TFDirector:getChildByPath(self.Panel_assistant,"Button_sel")

	self.ScrollView_reward1 = TFDirector:getChildByPath(ui,"ScrollView_reward1")

	self.ScrollView_reward2 = TFDirector:getChildByPath(ui,"ScrollView_reward2")

	self.Label_progress = TFDirector:getChildByPath(ui,"Label_progress")
	self.LoadingBar_progress = TFDirector:getChildByPath(ui,"LoadingBar_progress")

	self.Label_time = TFDirector:getChildByPath(ui,"Label_time")
	self.Button_explore = TFDirector:getChildByPath(ui,"Button_explore")

	self.Panel_sitItem = TFDirector:getChildByPath(ui,"Panel_sitItem")
	self.Panel_roleItem = TFDirector:getChildByPath(ui,"Panel_roleItem")
	self.Panel_des = TFDirector:getChildByPath(ui,"Panel_des")

	local ScrollView_des = TFDirector:getChildByPath(ui,"ScrollView_des")
	self.uiList_des = UIListView:create(ScrollView_des)

	local ScrollView_role = TFDirector:getChildByPath(ui,"ScrollView_role")
	self.uiGrid_role = UIGridView:create(ScrollView_role)
	self.uiGrid_role:setItemModel(self.Panel_roleItem)
	self.uiGrid_role:setColumn(3)
	self.uiGrid_role:setColumnMargin(15)
	self.uiGrid_role:setRowMargin(10)

	
    self.Image_cg:setTexture(self.fortCfg.showPic)


	local label_assistant = TFDirector:getChildByPath(self.Button_assistant,"Label_normal")
	local label_assistant1 = TFDirector:getChildByPath(self.Button_sel_assistant,"Label_sel")

	local _,activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo()

	local assistanting = DuanwuHangUpDataMgr:hasSupportRoleInExplore()
	local useSupportCount = DuanwuHangUpDataMgr.useSupTimes
	local notAssistantCount = activityInfo.extendData.supUseLimit <= useSupportCount
	useSupportCount = activityInfo.extendData.supUseLimit - useSupportCount

	if assistanting then -- 支援中
		label_assistant:setTextById(13200901)
		label_assistant1:setTextById(13200901)
		self.Button_assistant:setTouchEnabled(false)
	elseif notAssistantCount then -- 次数用尽
		label_assistant:setTextById(13200902)
		label_assistant1:setTextById(13200902)
		self.Button_assistant:setTouchEnabled(false)
	else -- 正常支援
		label_assistant:setTextById(13200903,useSupportCount,activityInfo.extendData.supUseLimit)
		label_assistant1:setTextById(13200903,useSupportCount,activityInfo.extendData.supUseLimit)
	end

	self:updateBtnState()
	self:updateRoleList()
	self:updateFortInfo()
	self:updateSitList()

	DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SUPPORT_LIST()
end

function FortReadyTip:updateBtnState( ... )
	-- body

	self.Button_own:setVisible(self.curSelectedPage == 2)
	self.Button_sel_own:setVisible(self.curSelectedPage == 1)

	self.Button_assistant:setVisible(self.curSelectedPage == 1)
	self.Button_sel_assistant:setVisible(self.curSelectedPage == 2)
end

function FortReadyTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_BUFFS, handler(self.onRecvBuffDataEvent, self))
	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_SUPPORTROLELIST, handler(self.updateRoleList, self))
	
	self.Button_own:onClick(function ( ... )
		-- body
		self.curSelectedPage = 1
		self:updateBtnState()
		self:updateRoleList()
	end)

	self.Button_assistant:onClick(function ( ... )
		-- body
		if not LeagueDataMgr:checkSelfInUnion() then
			Utils:showTips(13200921)
			return
		end
		self.curSelectedPage = 2
		self:updateBtnState()
		self:updateRoleList()
	end)

	self.Button_explore:onClick(function ( ... )
		-- body
		local supportRole = {}
		local roles = {}

		if #self.tmpRoleList < self.fortCfg.minTeamSize then 
			return
		end
		local _supportRole
		for k,v in ipairs(self.tmpRoleList) do
			if v.playerId then
				_supportRole = v
				table.insert(supportRole,{v.playerId,v.role.roleId})
			else
				table.insert(roles,v.role.roleId)
			end
		end

		if _supportRole then
			Utils:openView("duanwu_hangup.DuanwuUseAssistantRole",_supportRole, function ( ... )
			-- body
				local _,activityInfo = DuanwuHangUpDataMgr:getDuanwuActivityInfo( )
				local id,num = next(activityInfo.extendData.supChrCost)

				if GoodsDataMgr:currencyIsEnough(tonumber(id),num) then
					DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_HERO_EXPLORE(self.fortData.id,roles,supportRole)
					AlertManager:closeLayer(self)
				else
					local itemCfg = GoodsDataMgr:getItemCfg(tonumber(id))
			        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
			            Utils:openView("common.BuyResourceView", tonumber(id))
			        else
			            Utils:showTips(800021)
			        end
				end

			end)
			return
		end
		DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_HERO_EXPLORE(self.fortData.id,roles,supportRole)
		AlertManager:closeLayer(self)
	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
 	self:addCountDownTimer()
end

function FortReadyTip:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function FortReadyTip:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(3000, 1, nil, handler(self.onCountDownPer, self))
    end
end

function FortReadyTip:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:stopTimer(self.countDownTimer_)
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function FortReadyTip:onCountDownPer()
	self:removeCountDownTimer()
	self.showFlagState = self.showFlagState + 1
	self.showFlagState = self.showFlagState%3
	self.showFlagState = math.max(self.showFlagState,1)
	self:updateSitList()
	self:addCountDownTimer()
end

function FortReadyTip:checkRoleInTmpSit( roleId, checkAssistant )
	-- body
	for k,v in ipairs(self.tmpRoleList) do
		if v.role.roleId == roleId and (checkAssistant or not v.playerId) then
			return true
		end
	end
	return false
end

function FortReadyTip:checkBuffActive( buffData )
	-- body
	local buffCfg = TabDataMgr:getData("HangupEvtBuff",buffData.buffId)
	local isActive = true
	for k,v in pairs(buffCfg.buffActvCond) do
		if buffCfg.fortTarget ~= 0 and buffCfg.fortTarget ~= self.fortData.id then return false end

		if k == "limitParty" then
			if #v ~= #self.tmpRoleList then
				isActive = false
			else
				for _k,_v in ipairs(v) do
					if not self:checkRoleInTmpSit(_v) then
						isActive = false
					end
				end
			end
		elseif k == "openParty" then
			local inListNum = 0
			for _k,_v in ipairs(v) do
				if self:checkRoleInTmpSit(_v) then
					inListNum = inListNum + 1
				end
			end

			if inListNum < buffCfg.buffActvCond.anyMebr then
				isActive = false
			end
		end
	end
	return isActive
end

function FortReadyTip:onRecvBuffDataEvent( buffDatas )
	-- body
	self.buffData = buffDatas

	for k,v in ipairs(self.tmpRoleList) do -- 加入支援角色的buff
		if v.playerId then
			if v.buff then
				for _,_v in ipairs(v.buff) do
					table.insert(buffDatas, _v)
				end
			end
		end
	end

	for i = #self.buffData,1,-1 do
		if not self:checkBuffActive(self.buffData[i]) then
			table.remove(self.buffData,i)
		end
	end

	self:updateDesList()
	self:updateSitList()
end

function FortReadyTip:checkBuffList( role )
	-- body
	local roleList = {}

	for k,v in ipairs(self.tmpRoleList) do
		if not v.playerId then
			table.insert(roleList, v.role.roleId)
		end
	end

	if #roleList > 0 then
		DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_EFFECT_BUFF(roleList)
	elseif #self.tmpRoleList > 0 then
		self:onRecvBuffDataEvent({})
	else
		self:updateSitList()
		self.uiList_des:removeAllItems()
	end
end

function FortReadyTip:updateSitList( ... )
	-- body
	local maxSit = 3
	for i = 1,maxSit do
		local sit = TFDirector:getChildByPath(self.Panel_sit,"sit"..i)
		if not sit then
			sit = self.Panel_sitItem:clone()
			sit:setName("sit"..i)
			sit:setPosition(ccp(60+(i-1)*110,0))
			self.Panel_sit:addChild(sit)
		end

		local Panel_pos = TFDirector:getChildByPath(sit,"Panel_pos")
		local Image_empty = TFDirector:getChildByPath(sit,"Image_empty")

		if not Panel_pos.roleItem then
			Panel_pos.roleItem = self.Panel_roleItem:clone()
			Panel_pos.roleItem:setPosition(ccp(0,0))
			Panel_pos:addChild(Panel_pos.roleItem)
		end
		local role = self.tmpRoleList[i]
		Panel_pos:setVisible(role)
		Image_empty:setVisible(not role)
		if role then
			self:updateRoleItem(Panel_pos.roleItem, role, true)
		end
	end
	self.Button_explore:setTouchEnabled(#self.tmpRoleList > 0)
	self.Button_explore:setGrayEnabled(#self.tmpRoleList == 0)
end
function FortReadyTip:checkJiBan( roleCfg )
	-- body
	if not self.buffData then return false end
	local hasJiBan = false
	for k,v in ipairs(roleCfg.partyBuffList) do
		local buffData
		for _k,_v in ipairs(self.buffData) do
			if _v.buffId == v then
				buffData = _v
			end
		end

		if buffData and self:checkBuffActive(buffData) then
			hasJiBan = true
		end
	end
	return hasJiBan
end

function FortReadyTip:checkJiaChen( roleCfg )
	-- body
	local hasJiaChen = false
	for k,v in ipairs(roleCfg.roleBuffList) do
		if DuanwuHangUpDataMgr:getBuffData(v) then
			local buffCfg = TabDataMgr:getData("HangupEvtBuff",v)
			if buffCfg.fortTarget == self.fortData.id then
				hasJiaChen = true
			end
			break;	
		end
	end
	return hasJiaChen
end

function FortReadyTip:updateRoleItem( item , roleData , inSit )
	-- body
	local role = roleData.role
	local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
	local Image_jiban = TFDirector:getChildByPath(item, "Image_jiban")
	local Image_assistant = TFDirector:getChildByPath(item, "Image_assistant")
	local Label_assistant = TFDirector:getChildByPath(Image_assistant, "Label_assistant")

	local Image_jiachen = TFDirector:getChildByPath(item, "Image_jiachen")
	local Image_exploring = TFDirector:getChildByPath(item, "Image_exploring")
	local Image_selected = TFDirector:getChildByPath(item, "Image_selected")

	local roleCfg = TabDataMgr:getData("HangupEvtRole",role.roleId)
	Image_icon:setTexture(roleCfg.icon)

	local hasJiBan = self:checkJiBan(roleCfg)
	local hasJiaChen = self:checkJiaChen(roleCfg)

	if roleData.playerName then
		Label_assistant:setText(roleData.playerName)
	end
	Image_jiban:setVisible(false)
	Image_assistant:setVisible(roleData.playerId)
	Image_jiachen:setVisible(hasJiaChen and not roleData.playerId)
	Image_exploring:setVisible(roleData.isExplore)
	Image_selected:setVisible(table.find(self.tmpRoleList,roleData) ~= -1 )
	item:setTouchEnabled(not inSit)

	if inSit then
		Image_assistant:setVisible(roleData.playerId and self.showFlagState == 2)
		Image_jiban:setVisible(self.showFlagState == 2 and hasJiBan)
		Image_jiachen:setVisible(self.showFlagState == 1 and hasJiaChen)
		Image_exploring:setVisible(false)
		Image_selected:setVisible(false)
	end

	if roleData.playerId then
		local hasAssistant = false
		for k,v in ipairs(self.tmpRoleList) do
			if v.playerId then
				hasAssistant = true
				break
			end
		end

		item:setTouchEnabled(not inSit and (not hasAssistant or table.find(self.tmpRoleList,roleData) ~= -1))
	end

	if not inSit then
		local function clickFunc( ... )
			-- body
			if roleData.isExplore then return end
			local index = table.find(self.tmpRoleList, roleData)
			if index == -1 and #self.tmpRoleList < self.fortCfg.maxTeamSize then
				if roleData.playerId then
					if self:checkRoleInTmpSit(roleData.role.roleId ,true) then
						Utils:showTips(13200919)
						return 
					end
					table.insert(self.tmpRoleList, roleData)
					self:checkBuffList()
					self:updateSitList()
					self:updateRoleList()
				else
					if self:checkRoleInTmpSit(roleData.role.roleId, true) then
						Utils:showTips(13200919)
						return 
					end
					table.insert(self.tmpRoleList, roleData)
				end
			else
				table.remove(self.tmpRoleList, index)
			end
			self:checkBuffList()
			self:updateSitList()
			self:updateRoleList()
		end

		local function holdAction( ... )
			-- body
			self.clickTimer = TFDirector:addTimer(1000,1,nil,function ( ... )
				-- body
				self.openInfoView = true
				Utils:openView("duanwu_hangup.SpriteInfoTip", roleData)
			end)
		end


		item:onTouch(function(event)
	        if event.name == "ended" then
	        	TFDirector:stopTimer(self.clickTimer)
	        	TFDirector:removeTimer(self.clickTimer)
	        	self.clickTimer = nil
	        	local target = event.target
	        	local startPos = target:getTouchStartPos()
	        	local endPos = target:getTouchEndPos()
	        	if ccpDistance(startPos,endPos) > 5 then return end
	        	if not self.openInfoView  then
		            clickFunc()
		        end
				self.openInfoView = false
	        end

	        if event.name == "began" then
	        	if self.clickTimer then
		        	TFDirector:stopTimer(self.clickTimer)
		        	TFDirector:removeTimer(self.clickTimer)
		        	self.clickTimer = nil
		        end
	        	holdAction()
	        end
	    end)
		
	end
end

function FortReadyTip:updateRoleList( ... )
	-- body
	local roles = self:getRoleLists()
	if #self.uiGrid_role:getItems() > #roles then
		for i = #self.uiGrid_role:getItems(),#roles,-1 do
			self.uiGrid_role:removeItem(i)
		end
	end

	for k,v in ipairs(roles) do
		local item = self.uiGrid_role:getItem(k)
		if not item then
			item = self.Panel_roleItem:clone()
			self.uiGrid_role:pushBackCustomItem(item)
		end
		self:updateRoleItem(item,v)
	end
end

function FortReadyTip:updateFortInfo( ... )
	-- body
	self.Label_title:setTextById(self.fortCfg.name)
	self.Label_progress:setTextById(13200900,self.fortData.progress*100/self.fortCfg.finishProg)
	self.LoadingBar_progress:setPercent(self.fortData.progress*100/self.fortCfg.finishProg)
	self.Label_time:setText(Utils:getTimeCountDownString(ServerDataMgr:getServerTime() + self.fortCfg.hangupTime,1))

	Utils:createRewardListHor(self.ScrollView_reward1,self.fortCfg.rewardShow)
	Utils:createRewardListHor(self.ScrollView_reward2,self.fortCfg.finishRwardShow)

	self:updateDesList()
end

function FortReadyTip:updateDesList(  )
	self.uiList_des:removeAllItems()
	if not self.buffData then return end
	for k,v in ipairs(self.buffData) do
		local buffCfg = TabDataMgr:getData("HangupEvtBuff",v.buffId)
		local desItem = self.Panel_des:clone()
		local Label_des1 = TFDirector:getChildByPath(desItem,"Label_des1")
		local Label_des2 = TFDirector:getChildByPath(desItem,"Label_des2")
		Label_des1:setText(TextDataMgr:getText(buffCfg.name))
		if Label_des2.richText then
			Label_des2.richText:removeFromParent()
		end
		local width = Label_des2:getDimensions().width
		local richText = TFRichText:create(ccs(width,0))
		richText:setAnchorPoint(Label_des2:getAnchorPoint())
		Label_des2:addChild(richText)
		Label_des2.richText = richText
		Label_des2.richText:Text(DuanwuHangUpDataMgr:getRStringText(v,true))
		local height = math.max(Label_des1:getContentSize().height,Label_des2.richText:getContentSize().height)
		desItem:setContentSize(CCSizeMake(desItem:getContentSize().width,height + 10))
		self.uiList_des:pushBackCustomItem(desItem)
	end
end


return FortReadyTip