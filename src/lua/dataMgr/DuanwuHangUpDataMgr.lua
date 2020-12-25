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
* -- 端午挂机活动数据管理器 
]]

local DuanwuHangUpDataMgr = class("DuanwuHangUpDataMgr",BaseDataMgr)

function DuanwuHangUpDataMgr:ctor(  )
	-- body
	TFDirector:addProto(s2c.HANGUP_ACT_RES_ACT_INFO, self, self.onRecvActInfo)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_HERO_EXPLORE, self, self.onRecvHeroExplore)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_START_EXPLORE, self, self.onRecvStartExplore)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_DEAL_EVENT, self, self.onRecvDealEvent)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_SUPPORT_LIST, self, self.onRecvSupportList)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_SET_SUPPORT_ROLE, self, self.onRecvSetSupportRole)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_SUBMIT_TASK, self, self.onRecvSubmit_task)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_GET_SUPPORT_AWARD, self, self.onRecvGetSupportAward)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_GET_EXPLORE_AWARD, self, self.onRecvGetExploreAward)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_EFFECT_BUFF, self, self.onRecvEffectBuff)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_STRONGHOLD_INFO, self, self.onRecvFortInfo)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_REFRESH_STRONGHOLD, self, self.onRecvFortRefresh)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_STOP_STRONGHOLD, self, self.onRecvFortInfo)
	TFDirector:addProto(s2c.HANGUP_ACT_RES_MY_SUPPORT_INFO, self, self.onRecvOwnSupportInfo)
	TFDirector:addProto(s2c.HANGUP_ACT_PUSH_DUAN_WU_ACT_INFO, self, self.onRecvActDataRefresh)

end

function DuanwuHangUpDataMgr:onLogin( ... )
	-- body
	self:sendHANGUP_ACT_REQ_ACT_INFO( )
	return {s2c.HANGUP_ACT_RES_ACT_INFO}
end

function DuanwuHangUpDataMgr:reset( ... )
	-- body
	self.supportRole = {}
	self.stronghold = {}
	self.otherSupportRole = {}
	self.lastRequireSupportTime = 0
end



function DuanwuHangUpDataMgr:onRecvActInfo( event )
	-- body
	local data = event.data
	if not data then return end
	self.supportRole = data.supportRole
	self.stronghold = data.stronghold
	self.refreshTimes = data.refreshTimes
	self.refreshTime = data.refreshTime
	self.supAwardTimes = data.supAwardTimes or 0
	self.supAwardTime = data.supAwardTime or 0
	self.completeStronghold = data.completeStronghold
	self.useSupTimes = data.useSupTimes
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT)
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_SUPPORTROLE)
end

function DuanwuHangUpDataMgr:onRecvHeroExplore( event )
	-- body
end

function DuanwuHangUpDataMgr:updateFortData( fortData )
	-- body
	for k,v in ipairs(self.stronghold) do
		if v.id == fortData.id then
			for _k,_v in pairs(v) do
				fortData[_k] = _v
			end
		end
	end
end

function DuanwuHangUpDataMgr:onRecvStartExplore( event )
	-- body
	local data = event.data
	if not data then return end
	for k,v in pairs(self.stronghold) do
		if v.id == data.stronghold.id then
			self.stronghold[k] = data.stronghold
		end
	end
	self.useSupTimes = data.useSupTimes
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT)
end

function DuanwuHangUpDataMgr:onRecvFortInfo( event )
	-- body
	local data = event.data
	if not data then return end
	for k,v in pairs(self.stronghold) do
		if v.id == data.stronghold.id then
			self.stronghold[k] = data.stronghold
		end
	end
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT)
end

function DuanwuHangUpDataMgr:onRecvOwnSupportInfo( event )
	-- body
	local data = event.data
	if not data then return end
	self.supportRole = data.supportRole
end

function DuanwuHangUpDataMgr:onRecvActDataRefresh( event )
	-- body
	local data = event.data
	if not data then return end
	self.refreshTimes = data.refreshTimes
	self.refreshTime = data.refreshTime
	self.supAwardTimes = data.supAwardTimes or 0
	self.supAwardTime = data.supAwardTime or 0
	self.completeStronghold = data.completeStronghold
	self.useSupTimes = data.useSupTimes
end

function DuanwuHangUpDataMgr:onRecvFortRefresh( event )
	-- body
	local data = event.data
	if not data then return end

	self.stronghold = data.stronghold
	self.refreshTimes = data.refreshTimes
	self.refreshTime = data.refreshTime
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT)
end



function DuanwuHangUpDataMgr:onRecvDealEvent( event )
	-- body
end

function DuanwuHangUpDataMgr:onRecvSupportList( event )
	-- body
	local data = event.data
	if not data then return end

	self.otherSupportRole = data.role
	self.lastRequireSupportTime = data.lastReqTime
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_SUPPORTROLELIST)
end

function DuanwuHangUpDataMgr:onRecvSetSupportRole( event )
	-- body
	local data = event.data
	if not data then return end
	self.supportRole = data.supportRole
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_SUPPORTROLE)
end

function DuanwuHangUpDataMgr:onRecvSubmit_task( event )
	-- body
	Utils:showTips(13200915)
end

function DuanwuHangUpDataMgr:onRecvGetSupportAward( event )
	-- body
	local data = event.data
	if not data then return end

	if data.reward then
		Utils:showReward(data.reward)
	end
end

function DuanwuHangUpDataMgr:onRecvGetExploreAward( event )

	local data = event.data
	if not data then return end
	self.completeStronghold = data.completeStronghold
	local preFortData = nil
	for k,v in pairs(self.stronghold) do
		if v.id == data.stronghold.id then
			preFortData = v
			self.stronghold[k] = data.stronghold
		end
	end
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT)
	EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_FORT_FINISH,preFortData,data.stronghold,data.reward)
end

function DuanwuHangUpDataMgr:onRecvEffectBuff( event )
	-- body
	local data = event.data
	if not data then return end
	if data.buff then
		if self.isCheckingAllRoleBuff then
			self.isCheckingAllRoleBuff = false
			self.allRoleBuff = data.buff
		else
			EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_BUFFS,data.buff)
		end
	else
		EventMgr:dispatchEvent(EV_DUANWU_HANGUP_RECV_BUFFS,{})
	end
end

function DuanwuHangUpDataMgr:getCurSupportRole( ... )
	-- body
	return self.supportRole or {}
end

function DuanwuHangUpDataMgr:getFortList( ... )
	-- body
	return self.stronghold or {}
end

function DuanwuHangUpDataMgr:getOtherSupportRoleList( ... )
	-- body
	return self.otherSupportRole or {}
end

function DuanwuHangUpDataMgr:getDuanwuActivityInfo( ... )
	-- body
	local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_HANGUP)[1]
	local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	return activityId,activityInfo
end

function DuanwuHangUpDataMgr:getFortRefreshTime( ... )
	-- body
	return self.refreshTime or 0,self.refreshTimes or 0
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_ACT_INFO( )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_ACT_INFO,{})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_HERO_EXPLORE( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_HERO_EXPLORE,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_START_EXPLORE( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_START_EXPLORE,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_DEAL_EVENT( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_DEAL_EVENT,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SUPPORT_LIST( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_SUPPORT_LIST,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SET_SUPPORT_ROLE( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_SET_SUPPORT_ROLE,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_SUBMIT_TASK( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_SUBMIT_TASK,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_GET_SUPPORT_AWARD( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_GET_SUPPORT_AWARD,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_GET_EXPLORE_AWARD( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_GET_EXPLORE_AWARD,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_EFFECT_BUFF( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_EFFECT_BUFF,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_STRONGHOLD_INFO( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_STRONGHOLD_INFO,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_REFRESH_STRONGHOLD( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_REFRESH_STRONGHOLD,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_STOP_STRONGHOLD( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_STOP_STRONGHOLD,{...})
end

function DuanwuHangUpDataMgr:sendHANGUP_ACT_REQ_MY_SUPPORT_INFO( ... )
	-- body
	TFDirector:send(c2s.HANGUP_ACT_REQ_MY_SUPPORT_INFO,{...})
end

function DuanwuHangUpDataMgr:isCurSupportRole( roleId )
	-- body
	for k,v in ipairs(self:getCurSupportRole()) do
		if v.role.roleId == roleId then
			return true
		end
	end
	return false
end

function DuanwuHangUpDataMgr:checkAllRoleBuff(  )
	-- body
	self.isCheckingAllRoleBuff = true
	local roleList = table.keys(TabDataMgr:getData("HangupEvtRole"))

	self:sendHANGUP_ACT_REQ_EFFECT_BUFF(roleList)
end

function DuanwuHangUpDataMgr:getBuffData( buffId )
	-- body
	if not self.allRoleBuff then return nil end
	for k,v in ipairs(self.allRoleBuff) do
		if v.buffId == buffId then
			return v
		end
	end
	return nil
end

function DuanwuHangUpDataMgr:checkRoleInExplore( roleId )
	-- body
	for k,v in ipairs(self.stronghold) do
		if v.role then
			for _k,_v in ipairs(v.role) do
				if _v.roleId == roleId then
					return true
				end
			end
		end
	end

	return false
end

function DuanwuHangUpDataMgr:hasSupportRoleInExplore(  )
	-- body
	for k,v in ipairs(self.stronghold) do
		if v.supportRole and #v.supportRole > 0 then
			return true
		end
	end

	return false
end

function DuanwuHangUpDataMgr:getRStringText( buffData, isSample )
	-- body
	local buffCfg = TabDataMgr:getData("HangupEvtBuff",buffData.buffId)

	local function getParam(keys, params, buffData,isSample)
		local results = {}
		for k,v in ipairs(keys) do
			if v == "fortName" then
				if buffCfg.fortTarget ~= 0 then
					local fortCfg = TabDataMgr:getData("HangupEvtFort",buffCfg.fortTarget)
					local fortname = TextDataMgr:getText(fortCfg.name)
					table.insert(results,fortname)
				else
					table.insert(results,"")
				end
			elseif v == "heroName" then
				if buffCfg.reletHeroId ~= 0 then
					local rolename = HeroDataMgr:getName(buffCfg.reletHeroId)
					table.insert(results,rolename)
				else
					table.insert(results,"")
				end
			elseif v == "percent" then
				if type(params[k]) == "table" then
					if isSample then
						local percent = params[k][buffData.buffLv]
						table.insert(results,percent)
					else
						local text = ""
						for _k,_v in ipairs(params[k]) do
							if _v ~= "" then
								if _k < #params[k] then 
									_v = _v.."/"
								end
								if _k == buffData.buffLv then
									text = text..string.format([[<font face="fangzheng_zhunyuan20" color="#FF8352">%s</font>]],_v)
								else
									text = text..string.format([[<font face="fangzheng_zhunyuan20" color="#bb888c">%s</font>]],_v)
								end
							end
						end
						table.insert(results,text)
					end
				else
					local percent = params[k]
					table.insert(results,percent)
				end
			elseif v == "string" then
				if type(params[k]) == "table" then
					if isSample then
						local string = params[k][buffData.buffLv]
						table.insert(results,string)
					else
						local text = ""
						for _k,_v in ipairs(params[k]) do
							if _v ~= "" then
								if _k < #params[k] then _v = _v.."/" end

								if _k == buffData.buffLv then
									text = text..string.format([[<font face="fangzheng_zhunyuan20" color="#FF8352">%s</font>]],_v)
								else
									text = text..string.format([[<font face="fangzheng_zhunyuan20" color="#bb888c">%s</font>]],_v)
								end
							end
						end
						table.insert(results,text)
					end
				else
					local string = params[k]
					table.insert(results,string)
				end
			elseif v == "itemName" then
				local itemname = params[k]
				table.insert(results,itemname)
			end
		end
		return results
	end

	local rstring
	if isSample then
		rstring = TextDataMgr:getRText("r"..buffCfg.buffDescribe)
		local param = getParam(buffCfg.buffDesParmaKey,buffCfg.buffDesParmaVal, buffData,true)
		rstring = string.format(rstring,unpack(param))
	else
		rstring = TextDataMgr:getRText("r"..buffCfg.buffDetails)
		local param = getParam(buffCfg.buffDetlParamKey,buffCfg.buffDetailsVal,buffData)
		rstring = string.format(rstring,unpack(param))
	end

	return rstring
end

return DuanwuHangUpDataMgr:new()