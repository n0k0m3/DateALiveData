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

local FortInfoTip = class("FortInfoTip",BaseLayer)

function FortInfoTip:ctor( data )
	-- body
	self.super.ctor(self)
	self:initData(data)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.fortInfoTip")
end

function FortInfoTip:initData(data)
	-- body
	self.fortData = data
	self.fortCfg = TabDataMgr:getData("HangupEvtFort",data.id)
end

function FortInfoTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Label_timing = TFDirector:getChildByPath(ui,"Label_timing")
	self.panel_cg = TFDirector:getChildByPath(ui,"panel_cg")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_show1 = TFDirector:getChildByPath(ui,"Panel_show1")
	self.Panel_show2 = TFDirector:getChildByPath(ui,"Panel_show2")
	self.Panel_rewardItem = TFDirector:getChildByPath(ui,"Panel_rewardItem")
	self.Button_retire = TFDirector:getChildByPath(self.Panel_show1,"Button_retire")
	self.Button_finish = TFDirector:getChildByPath(self.Panel_show1,"Button_finish")

	local ScrollView_reward = TFDirector:getChildByPath(self.Panel_show1,"ScrollView_reward")
	self.uiGrid_reward = UIGridView:create(ScrollView_reward)
	self.uiGrid_reward:setItemModel(self.Panel_rewardItem)
	self.uiGrid_reward:setColumn(4)
	self.uiGrid_reward:setColumnMargin(5)
	self.uiGrid_reward:setRowMargin(10)

	self.Button_enter = TFDirector:getChildByPath(self.Panel_show2,"Button_enter")
	self.Button_ingore = TFDirector:getChildByPath(self.Panel_show2,"Button_ingore")
	self.Panel_reward = TFDirector:getChildByPath(self.Panel_show2,"Panel_reward")
	self.Label_event_des = TFDirector:getChildByPath(self.Panel_show2,"Label_des")
	self.ScrollView_des = TFDirector:getChildByPath(self.Panel_show2,"ScrollView_des")
	self.Label_tip2 = TFDirector:getChildByPath(self.Button_retire,"Label_tip2")
	local cg_cfg = TabDataMgr:getData("Cg",self.fortCfg.showCG)
    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           self.panel_cg.cg:playEffect()
        end)
    layer:setAnchorPoint(ccp(0.5,0.5))
    self.panel_cg:addChild(layer)
    self.panel_cg.cg = layer
    
	self:updateRoleList()
	self:refreshView()
	self:onCountDownPer()
end

function FortInfoTip:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function FortInfoTip:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function FortInfoTip:onCountDownPer()
	local showEvent = self.fortData.event and self.fortData.event[1].state == 0 and ServerDataMgr:getServerTime() >= self.fortData.event[1].startTime
	self.Panel_show2:setVisible(showEvent)
	self.Panel_show1:setVisible(not showEvent)
	if self.fortData.state == 1 or (self.fortData.endTime >= ServerDataMgr:getServerTime() and (not self.fortData.event or self.fortData.event[1].state == 2))  then
		self.Label_timing:setText(Utils:getTimeCountDownString(self.fortData.endTime,2))
	elseif self.fortData.event and self.fortData.event[1] and self.fortData.event[1].state == 5 then
		self.Label_timing:setTextById(13200905)
	else
		self.Label_timing:setTextById(13200904)
	end
	if not showEvent then
		self:updatePanelShow1()
	end
end

function FortInfoTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_FORT, handler(self.refreshView, self))
	EventMgr:addEventListener(self, EV_DUANWU_HANGUP_RECV_FORT_FINISH, handler(self.showFinishPop, self))
	
	self.Button_finish:onClick(function ( ... )
		-- body
		DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_GET_EXPLORE_AWARD(self.fortData.id)
		AlertManager:closeLayer(self)
	end)

	self.Button_retire:onClick(function ( ... )
		-- body
		local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(13200610),
            showCancle = true,
            confirmCall = function ( ... )
				DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_STOP_STRONGHOLD(self.fortData.id)
				AlertManager:closeLayer(self)
            end,
        }
        Utils:showReConfirm(args)
	end)

	self.Button_enter:onClick(function ( ... )
		-- body
		self:enterEvent()
	end)

	self.Button_ingore:onClick(function ( ... )
		-- body
		local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(13200611),
            showCancle = true,
            confirmCall = function ( ... )
            	DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_DEAL_EVENT(self.fortData.id,self.fortData.event[1].id, true)
            end,
        }
        Utils:showReConfirm(args)
	end)
	
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
	self:addCountDownTimer()
end

function FortInfoTip:enterEvent( ... )
	-- body
	local eventCfg = TabDataMgr:getData("HangupEvtEvent",self.fortData.event[1].id)
	if eventCfg.evtType == 1 then
		FunctionDataMgr:jStartDating(eventCfg.relatId)
	elseif eventCfg.evtType == 2 then
		FubenDataMgr:enterMusicGameLevel({id = self.fortData.id, eventid = self.fortData.event[1].id, levelCid = eventCfg.relatId} )
	end
end

function FortInfoTip:removeEvents()
	self.super.removeEvents(self)
	self:removeCountDownTimer()
end

function FortInfoTip:showFinishPop( preFortData, fortData, reward )
	-- body
	Utils:openView("duanwu_hangup.DuanwuPopProgressView", preFortData, fortData, reward)
end

function FortInfoTip:refreshView()
	-- body
	DuanwuHangUpDataMgr:updateFortData(self.fortData)
	self.Label_name:setTextById(self.fortCfg.name)
	self:updatePanelShow2()
	self:updatePanelShow1()
end

function FortInfoTip:getRewardList( ... )
	-- body
	local fortCfg = TabDataMgr:getData("HangupEvtFort",self.fortData.id)

	local showReward = {}

	local allTime = self.fortData.endTime - self.fortData.startTime
	if self.fortData.event then
		for k,v in ipairs(self.fortData.event) do
			if v.state == 2 then
				local eventCfg = TabDataMgr:getData("HangupEvtEvent",v.id)
				local reward = clone(eventCfg.rewardShow)
				reward.ext = true
				table.insert(showReward,reward)
			end
		end
	end
	local buff = self.fortData.buff or {}
	for k,v in ipairs(buff) do
		local buffCfg = TabDataMgr:getData("HangupEvtBuff",v.buffId)
		if buffCfg.rewardTime then
			for _timeRate,_reward in pairs(buffCfg.rewardTime) do
				if ServerDataMgr:getServerTime() >= self.fortData.startTime + math.ceil(allTime*_timeRate/100) then
					table.insert(showReward,_reward)
				end
			end
		end
	end

	for _timeRate,_reward in pairs(fortCfg.rewardTime) do
		if ServerDataMgr:getServerTime() >= self.fortData.startTime + math.ceil(allTime*_timeRate/100) then
			table.insert(showReward,_reward)
		end
	end

	return showReward
end

function FortInfoTip:updateRoleList(  )
	-- body
	for i = 1,4 do
		local uiNa = "Image_role"..i
		local role_icon = TFDirector:getChildByPath(self.ui,uiNa)
		role_icon:hide()
	end

	local role = {}

	if self.fortData.role then
		for k,v in ipairs(self.fortData.role) do
			table.insert(role,v)
		end
	end

	if self.fortData.supportRole then
		for k,v in ipairs(self.fortData.supportRole) do
			table.insert(role,v.role)
		end
	end

	for k,v in ipairs(role) do
		local roleCfg = TabDataMgr:getData("HangupEvtRole",v.roleId)
		local uiNa = "Image_role"..k
		local role_icon = TFDirector:getChildByPath(self.ui,uiNa)
		role_icon:show()
		local role_icon_head = TFDirector:getChildByPath(role_icon,"Image_role_head")
		role_icon_head:setTexture(roleCfg.moodPath.."3.png")
	end
end

function FortInfoTip:updatePanelShow1( )
	local rewards = self:getRewardList()
	if table.count(rewards) < #self.uiGrid_reward:getItems() then
		for _i = #self.uiGrid_reward:getItems(),table.count(rewards) do
			self.uiGrid_reward:removeItem(_i)
		end
	end

	local index = 1
	for i = 1,table.count(rewards) do
		local id,num = next(rewards[i])
		if id == "ext" then
			id,num = next(rewards[i],id)
		end
		local rewardItem = self.uiGrid_reward:getItem(index)
		if not rewardItem then
			rewardItem = self.Panel_rewardItem:clone()
			local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
			panel_goodsItem:Pos(0, 0)
			panel_goodsItem:setScale(0.8)
			rewardItem:addChild(panel_goodsItem)
			rewardItem.panel_goodsItem = panel_goodsItem
			self.uiGrid_reward:pushBackCustomItem(rewardItem)
		end

		local flag = TFDirector:getChildByPath(rewardItem,"Image_flag")
		flag:setVisible(rewards[i].ext)
		local panel_goodsItem = rewardItem.panel_goodsItem
		PrefabDataMgr:setInfo(panel_goodsItem, tonumber(id))
		index = index + 1
	end

	local isFinish = self.fortData.state == 2 or ServerDataMgr:getServerTime() >= self.fortData.endTime

	if self.fortData.event and self.fortData.event[1].state ~= 2 and self.fortData.event[1].state ~= 5 then
		isFinish = false
	end
	self.Label_tip2:hide()
	if isFinish then
		self.Label_tip2:show()
		self.Label_tip2:setTextById(13200911)
	elseif self.fortData.event[1].state == 5 then
		self.Label_tip2:show()
		self.Label_tip2:setTextById(13200912)
	end

	self.Button_finish:setVisible(isFinish)
	self.Button_retire:setVisible(not isFinish)
end

function FortInfoTip:updatePanelShow2( )
	if not self.fortData.event then return end
	-- body
	local eventCfg = TabDataMgr:getData("HangupEvtEvent",self.fortData.event[1].id)
	self.Label_event_des:setTextById(eventCfg.describe)
	self.ScrollView_des:setContentSize(self.Label_event_des:getContentSize())
	local k,v = next(eventCfg.rewardShow)
	local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	PrefabDataMgr:setInfo(panel_goodsItem, tonumber(k), v)
	panel_goodsItem:Pos(0, 0)
	panel_goodsItem:setScale(0.8)
	self.Panel_reward:addChild(panel_goodsItem)
	self.Button_ingore:setVisible(eventCfg.isIgnorable)
end

return FortInfoTip