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
* --  组队副本入口
]]

local OSDLevelEntranceView = class("OSDLevelEntranceView",BaseLayer)
function OSDLevelEntranceView:ctor( data )
	self.super.ctor(self,data)
	self.highTeamDungeonLevel = TabDataMgr:getData("HighTeamDungeonLevel")
	self:init("lua.uiconfig.osd.Entrance")
end

function OSDLevelEntranceView:removeUI( )
	if self.flushButtonTimer then
		TFDirector:stopTimer(self.flushButtonTimer)
		TFDirector:removeTimer(self.flushButtonTimer)
		self.flushButtonTimer = nil
	end

	if self.flushFirstRewardTimer then
		TFDirector:stopTimer(self.flushFirstRewardTimer)
		TFDirector:removeTimer(self.flushFirstRewardTimer)
		self.flushFirstRewardTimer = nil
	end

end

function OSDLevelEntranceView:initUI( ui )
	self.super.initUI(self,ui)
	self.title_des = TFDirector:getChildByPath(ui,"title_des")
	self.button_challenge = TFDirector:getChildByPath(ui,"button_challenge")
	self.btn_redTip = TFDirector:getChildByPath(self.button_challenge,"RedTip")
	self.label_time = TFDirector:getChildByPath(self.button_challenge,"label_time")
	self.label_firstRewardTime = TFDirector:getChildByPath(ui,"label_firstRewardTime")

	local function flushBtnState()
		local outTime
		local _showCardList = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.HUNTINGINVITATIONCARD)
		for k,v in pairs(_showCardList) do
			local vOutTime = v.outTime
			outTime = outTime or vOutTime
			if vOutTime then
				outTime = math.min(outTime,vOutTime)
			end
		end
		outTime = outTime or 0

    	local remainTime = math.max(0, outTime - ServerDataMgr:getServerTime())
	    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime)
    	if day == 0 and hour == 0 and min == 0 and sec > 0 then min = 1 end
		self.label_time:setTextById(14110136,day, hour, min)
		self.label_time:setVisible(remainTime > 0)
		self.btn_redTip:setVisible(remainTime > 0)
	end
	flushBtnState()

	local function flushFirstRewardTime()
		local outTime = OSDDataMgr:getDungeonFirtRewardFlushTime()

    	local remainTime = math.max(0, outTime - ServerDataMgr:getServerTime())
	    local day, hour, min, sec = Utils:getTimeDHMZ(remainTime)
    	if day == 0 and hour == 0 and min == 0 and sec > 0 then min = 1 end
		self.label_firstRewardTime:setTextById(14110377,day, hour, min)
	end
	flushFirstRewardTime()


	
	self.flushButtonTimer = TFDirector:addTimer(1000,-1,nil,flushBtnState)
	self.flushFirstRewardTimer = TFDirector:addTimer(1000,-1,nil,flushFirstRewardTime)

	self.title_des:setTextById(14110003)

	self.contentNode = {}

	for i = 1, 5 do
		local foo = {}
		local item = TFDirector:getChildByPath(ui,"point_"..i)
		foo.rootNode = item
		foo.lock = TFDirector:getChildByPath(item,"panel_lock")
		foo.unLock = TFDirector:getChildByPath(item,"panel_unLock")
		foo.lockIcon = TFDirector:getChildByPath(foo.lock,"item_icon")
		foo.icon = TFDirector:getChildByPath(foo.unLock,"item_icon")
		foo.name = TFDirector:getChildByPath(foo.unLock,"label_name")
		self.contentNode[i] = foo
	end
	self:refreshView()
end

function OSDLevelEntranceView:registerEvents()
	self.super.registerEvents(self)
	self.button_challenge:onClick(function ( ... )
		OSDDataMgr:sendEnterHuntingInvitation()
	end)
	EventMgr:addEventListener(self,EV_OSD.EV_REFRESH_CHAPTERINFO,handler(self.refreshView, self))
end

function OSDLevelEntranceView:refreshView(  )
	for i = 1,5 do
		self.contentNode[i].rootNode:hide()
	end
	local index = 1
	for k,v in ipairs(self.highTeamDungeonLevel) do
		if self.contentNode[index] then
			self.contentNode[index].rootNode:show()
			self:flushItemNode(index,v)
		end
		index = index + 1
	end
end

function OSDLevelEntranceView:flushItemNode( index, config)
	local foo = self.contentNode[index]

	local lock = not OSDDataMgr:getChapterInfo(config.id).isOpen
	foo.unLock:setVisible(not lock)
	foo.lock:setVisible(lock)

	local _string = config.pic
	_string = string.sub(_string,1,-5)
	_string = _string.."_1.png"
	foo.lockIcon:setTexture(_string)
	foo.icon:setTexture(config.pic)
	foo.name:setTextById(config.capter)
	foo.icon:setTouchEnabled(true)
	foo.icon:onClick(function ( ... )
		Utils:openView("osd.OSDLevelReadyView",config.id)
	end)

end

return OSDLevelEntranceView