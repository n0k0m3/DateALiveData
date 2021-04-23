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
* -- 挂机活动主界面
]]
local ChapterMapContor = class("ChapterMapContor")
local ExtraTrigger = TabDataMgr:getData("DicuoProcess")
local enum       = import("lua.logic.battle.enum")

function ChapterMapContor:ctor( ... )
    self:init(...)
   
    EventMgr:addEventListener(self,enum.eEvent.EVENT_SHOW__STACE_CLEAR,function ( ... )
        if self.dungeonChapter then
            self:saveStep(self.stepId)
            self:checkProcess()
            self.dungeonChapter = nil
        end
    end)
    
    EventMgr:addEventListener(self,EV_DATING_EVENT.closeSriptView,function ( event )
        if self.datingChapter then 
            self:saveStep(self.stepId)
            self:checkProcess()
            self.datingChapter = nil
        end
    end)
    
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
end

function ChapterMapContor:init( logic, chapterId, stage)
    self.logic = logic
    self.chapterId = chapterId
    self.stage = stage
end



function ChapterMapContor:distory()
    EventMgr:removeEventListenerByTarget(self)
end

function ChapterMapContor:onShow( )
    self:checkProcess()
end

function ChapterMapContor:getFirstStepId()
    local firstStepId = nil
    for k,v in pairs(ExtraTrigger) do
        if self.chapterId == v.chapterId and v.isFirst then
            firstStepId = k
        end
    end
    return firstStepId
end

function ChapterMapContor:checkProcess() -- 进入流程或者等待服务器返回数据就进入流程
    if self.isActioning then return true end
    for k,v in ipairs(ExtraTrigger) do
        if v.id ~= self.stepId then
            local hasTrigger = false
            if v.flag and v.flag ~="" then
                hasTrigger = Utils:getLocalSettingValue(v.flag) == "TRUE"
            end
            if v and self:isPassCond(v.trigger) and not hasTrigger then
                self.stepId = v.id
                self:actionStep(v)
                return true
            end 
        end
    end
    return false
end

function ChapterMapContor:isPassCond( conds )
    local isPass = true
    if conds then
        for k,cond in pairs(conds) do
            local predungeonIsUnlock = true
            if cond.predungeon then
                for i, v in ipairs(cond.predungeon) do
                    if not FubenDataMgr:isPassTheaterLevel(v) then
                        predungeonIsUnlock = false
                        break
                    end
                end
            end

            local predatingIsUnlock = true
            if cond.predating then
                for i, v in ipairs(cond.predating) do
                    if not FubenDataMgr:isPassTheaterLevel(v) then
                        predatingIsUnlock = false
                        break
                    end
                end
            end

            local predungeonIsNotPass = true
            if cond.notPass then
                for i, v in ipairs(cond.notPass) do
                    if FubenDataMgr:isPassTheaterLevel(v) then
                        predungeonIsNotPass = false
                        break
                    end
                end
            end

            local predungeonResultPass = true
            if cond.predungeonResult then
                for i, v in ipairs(cond.predungeonResult) do
                    if not FubenDataMgr:judgeStarIsActive(v.id,v.star) then
                        predungeonResultPass = false
                        break
                    end
                end
            end

            local isOnStage = true
            if cond.stage then
                if self.stage ~= cond.stage then
                    isOnStage = false
                end
            end

            local isCountEnought = true
            if cond.countEnd then
                local passCount = 0
                for k,v in pairs(cond.countEnd.predungeonList) do
                    if FubenDataMgr:isPassPlotLevel(v) then
                        passCount = passCount + 1
                    end
                end
                isCountEnought = cond.countEnd.count == passCount
            end

            isPass = predungeonIsUnlock and predatingIsUnlock and predungeonIsNotPass and predungeonResultPass and isOnStage and isCountEnought
            if isPass then break end
        end
    end
    return isPass
end

function ChapterMapContor:actionStep( step )
    self.isActioning = true
    for k,v in pairs(step.execute) do
        if k == "dungeonLevelId" then
            self.dungeonId = v
            self.dungeonChapter = true
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.dungeonId)
            return
        elseif k == "cameraFocus" then
            if v.levelId or v.pos then
                local pos = v.pos and ccp(v.pos[1],v.pos[2]) or nil
                self.logic:focusAndScaleByLevelId(v.levelId, pos, v.scale, v.moveTime/1000)
            elseif v.currentLevel== 1 then
                self.logic:focusAndScaleCurLevel(v.scale, v.moveTime/1000)
            end
        elseif k == "datingId" then
            self.datingId = v
            self.datingChapter = true
            FunctionDataMgr:jStartDating(v)
            return
        elseif k == "dialog" then
            self.dialogChapter = self.chapterId
            local function callback()
                KabalaTreeDataMgr:playStory(1, v,function ()
                                                EventMgr:dispatchEvent(EV_CG_END, function()
   													self:saveStep(step.id)
                                                    self:checkProcess()
                                                end)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg", callback)
            return
        elseif k == "video" then
            local video = Utils:openView("common.VideoView", v)
            video:bindEndCallBack(function()
   				self:saveStep(step.id)
                self:checkProcess()
            end)
            return
        elseif k == "loseCotrolTime" then
        	self.logic:lockUI(v/1000)
        elseif k == "hideVortex" then
            self.logic:hideVortex(v)
        end
    end
    self:saveStep(self.stepId)
end

function ChapterMapContor:onLimitHeroEvent()

    local levelFormation =  FubenDataMgr:getLevelFormation(self.dungeonId)
    if not levelFormation then
        return
    end

    local formationData_ = FubenDataMgr:getInitFormation(self.dungeonId)
    if formationData_ then
        HeroDataMgr:changeDataByFuben(self.dungeonId, formationData_)
    end

    local heros = {}
    for i, v in ipairs(formationData_) do
        table.insert(heros, {limitType = v.type, limitCid = v.id})
    end

    FubenDataMgr:setFormation(levelFormation)
    self:saveStep(self.stepId,self.chapterId)
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(
            {
                levelCid = self.dungeonId,
                limitHeros = heros,
                isDuelMod = false,
            },
            EC_BattleType.COMMON
    )
end

function ChapterMapContor:saveStep( id ) -- 保存下一步的id 
    if ExtraTrigger[id].flag then
        Utils:setLocalSettingValue(ExtraTrigger[id].flag,"TRUE")
    end
    self.isActioning = false
end

local ChapterMapLayer = class("ChapterMapLayer", BaseLayer)

function ChapterMapLayer:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
    self.processContro = ChapterMapContor:new()
	self:init("lua.uiconfig.activity.diCuoMainView")
end

function ChapterMapLayer:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self.levelItems = {}
	self.levelGroupItems = {}
end

function ChapterMapLayer:initUI( ui )
	-- body
	self.super.initUI(self, ui)
	local Panel_mapView = TFDirector:getChildByPath(ui,"Panel_mapView")
	self.mapBg = createUIByLuaNew("lua.uiconfig.activity.diCuoMap")

	self.Panel_touch = TFDirector:getChildByPath(ui,"Panel_touch"):hide()

	
	self.mapBg:setAnchorPoint(ccp(0,0))
	self.mapView = require("lua.public.ScrollAndZoomView"):new(Panel_mapView:getContentSize(),self.mapBg:getContentSize())
	self.mapView:addChild(self.mapBg)
	self.mapView:setMinScale(0.5)
	self.mapView:setMaxScale(1)
    me.Director:setSingleEnabled(false)
    Panel_mapView:addChild(self.mapView)

    self.mapView:setNodeScale(0.5)
    self.mapView:focus(ccp(self.mapBg:getContentSize().width/2,self.mapBg:getContentSize().height/2))


	self.Button_jiacheng = TFDirector:getChildByPath(ui,"Button_jiacheng")
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")

	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")
	self.Panel_levelGroup = TFDirector:getChildByPath(ui,"Panel_levelGroup")
    self.Label_time = TFDirector:getChildByPath(ui,"Label_time")
    self.Label_stage = TFDirector:getChildByPath(ui,"Label_stage")

    self.Spine_vortex = TFDirector:getChildByPath(self.mapBg,"Spine_vortex")

    local isDisapper = not FubenDataMgr:isPassPlotLevel(self.activityInfo.extendData.vortexDisappear)
    self.Spine_vortex:setVisible(isDisapper)
	self:updateMainLevel()
	self:updateGroupNode()
    self:onCountDownPer()
    self.processContro:init(self, nil, 1)
end

function ChapterMapLayer:onShow( ... )
	-- body
	self.super.onShow(self)
    self.processContro:onShow()
    FubenDataMgr:dasyncLevelInfo()
end

function ChapterMapLayer:removeUI()
    self.super.removeUI(self)
    self.processContro:distory()
    self.processContro = nil
end

function ChapterMapLayer:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function ChapterMapLayer:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function ChapterMapLayer:onCountDownPer()
    local curTime = ServerDataMgr:getServerTime()
    local stageTextId = 0
    local remainTime = 0
    local keys = table.keys(self.activityInfo.extendData.Stages)

    table.sort(keys, function ( a ,b)
        -- body
        return a < b
    end)
    stageTextId = self.activityInfo.extendData.Stages[keys[#keys]]
  	for k,v in ipairs(keys) do
        if curTime < tonumber(v) then
            stageTextId = self.activityInfo.extendData.Stages[v]
            remainTime = tonumber(v) - curTime
            break
        end
    end
    local day,hour,min,sec = Utils:getTimeDHMZ(math.max(remainTime,0),true)
    if remainTime < 60 and remainTime > 0 then
        min = 1
    end
    self.Label_time:setTextById(16000444,day,hour,min)
    self.Label_stage:setTextById(stageTextId)
    self:updateMainLevel()
    self:updateGroupNode()
end

function ChapterMapLayer:hideVortex( delayTime )
    -- body
    self.Spine_vortex:show()
    self.Spine_vortex:timeOut(function ( ... )
        self.Spine_vortex:play("xiaoshi",false)
        self.Spine_vortex:addMEListener(TFARMATURE_COMPLETE,function ( ... )
            -- body
           self.Spine_vortex:hide()
        end,delayTime/1000)
    end)
   
end

function ChapterMapLayer:registerEvents(  )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_FUBEN_LEVELINFOUPDATE, function ( ... )
    	-- body
    	self:updateMainLevel()
    	self:updateGroupNode()
    end)

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
    		if self.activityId == activityId then
    			AlertManager:closeLayer(self)
    			Utils:showTips(14110403)
    		end
    	end)
	self:addCountDownTimer()
	
	self.Button_jiacheng:onClick(function ( ... )
		-- body
        Utils:openView("liandongChapter.ActivityDetailTip",self.activityInfo.extendData.detailTips)
	end)

	self.Button_shop:onClick(function ( ... )
		-- body
        if self.activityInfo.extendData.jumpInterface then
            FunctionDataMgr:enterByFuncId(self.activityInfo.extendData.jumpInterface, unpack(self.activityInfo.extendData.jumpParamters or {}))
        end
	end)
end

function ChapterMapLayer:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
    me.Director:setSingleEnabled(true)
    self:removeCountDownTimer()
    self.mapView:removeEvents()
end

function ChapterMapLayer:refreshEventNode( ... )

end

function ChapterMapLayer:getLevelNodePos( levelId )
	-- body
	for k,v in ipairs(self.levelItems) do
		if v.levelIds and table.find(v.levelIds, levelId) ~= -1 then
			return v:getParent():Pos()
		end
	end

	for j,s in ipairs(self.levelGroupItems) do
		if s.levelIds and table.find(s.levelIds, levelId) ~= -1 then
			return s:getParent():Pos()
		end
	end

	return ccp(self.mapBg:getContentSize().width/2,self.mapBg:getContentSize().height/2)
end

function ChapterMapLayer:lockUI( time )
	-- body
	self.Panel_touch:setVisible(true)
	self.Panel_touch:timeOut(function ( ... )
		-- body
		self.Panel_touch:setVisible(false)
	end,time)
end

function ChapterMapLayer:focusAndScaleByLevelId(levelId, nodePos, scale, time)
	-- body
	if not nodePos and levelId then
		nodePos = self:getLevelNodePos(levelId)
	end
	self.mapView:focusAndScaleByTime(time,nodePos,scale)
end

function ChapterMapLayer:focusAndScaleCurLevel( scale,time )
    -- body
    self:focusAndScaleByLevelId(self.curLevelId, nil, scale, time)
end


function ChapterMapLayer:updateMainLevel(  )
	-- body
	local mainGroup = self.activityInfo.extendData.mainGroupId
	local levels = FubenDataMgr:getLevel(mainGroup, 1)
    self.curLevelId = levels[#levels]
	for k,v in ipairs(levels) do
		if not self.levelItems[k] then
			local levelItem = self.Panel_levelItem:clone()
			local pos = TFDirector:getChildByPath(self.mapBg, "Panel_level_pos_"..k)
			levelItem:setPosition(ccp(0,0))
			pos:addChild(levelItem)
			self.levelItems[k] = levelItem
		end
		self:updateLevelItem(self.levelItems[k],v, k)
	end
end

function ChapterMapLayer:updateLevelItem( item, levelId, index)
	-- body
	item.levelIds = {levelId}
	local levelCfg = FubenDataMgr:getLevelCfg(levelId)

    for i = 1,4 do
        panelStyle = TFDirector:getChildByPath(item,"Panel_style"..i):hide()
    end

	local panelStyle = TFDirector:getChildByPath(item,"Panel_style"..levelCfg.showStyle):show()
	local Image_normal = TFDirector:getChildByPath(panelStyle,"Image_normal")
	local Image_lock = TFDirector:getChildByPath(panelStyle,"Image_lock")
	local Image_flag = TFDirector:getChildByPath(panelStyle,"Image_flag")
	local Image_flagPass = TFDirector:getChildByPath(panelStyle,"Image_flagPass")
	local Label_name = TFDirector:getChildByPath(panelStyle,"Label_name")

	Label_name:setText(index)

	local enable = FubenDataMgr:checkPlotLevelEnabled(levelCfg.id)
	local isPass = FubenDataMgr:isPassPlotLevel(levelCfg.id)

	Image_lock:setVisible(not enable)
    Image_normal:setVisible(enable)

	Image_flagPass:setVisible(isPass)

    if enable then
        self.curLevelId = levelId
    end

	Image_normal:setTouchEnabled(true)
	Image_normal:onClick(function ( ... )
		-- body
        local levelGroupCid = levelCfg.levelGroupId
        FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
        FubenDataMgr:cacheSelectLevel(levelId)
        Utils:openView("liandongChapter.DicuoLevelReady", levelId)
	end)

    Image_lock:setTouchEnabled(true)
    Image_lock:onClick(function ( ... )
        -- body
        Utils:showTips(levelCfg.unlockBrief)
    end)
end

function ChapterMapLayer:updateGroupNode( )
	-- body
    local keys = {"enhuiGroupId","hualunGroupId","jibanGroupId"}
	for i = 1,3 do
		local groupId = self.activityInfo.extendData[keys[i]]
		if not self.levelGroupItems[i] then
			local groupItem = self.Panel_levelGroup:clone()
			groupItem:setPosition(ccp(0,0))
			local pos = TFDirector:getChildByPath(self.mapBg,"Panel_levelGroup_pos_"..i)
			pos:addChild(groupItem)
			self.levelGroupItems[i] = groupItem
		end
		self:updateLevelGroup(self.levelGroupItems[i],groupId, i)
	end
end

function ChapterMapLayer:updateLevelGroup( item, groupId, index)
	-- body
	local groupData = FubenDataMgr:getLevelGroupCfg(groupId)
    local effectName = {"huang","lan","hong"}
    for i = 1,3 do
        panelStyle = TFDirector:getChildByPath(item,"Panel_style"..i):hide()
    end

	local panelStyle = TFDirector:getChildByPath(item,"Panel_style"..index):show()

	local _Image_lock = TFDirector:getChildByPath(item,"Image_lock")
    local _Spine_lock = TFDirector:getChildByPath(item,"Spine_lock")

	local _Image_normal = TFDirector:getChildByPath(panelStyle,"Image_normal")
	local Label_name = TFDirector:getChildByPath(panelStyle,"Label_name")
	local Image_icon = TFDirector:getChildByPath(panelStyle,"Image_icon")
    local Spine_di = TFDirector:getChildByPath(panelStyle,"Spine_di")
    local Spine_effect1 = TFDirector:getChildByPath(panelStyle,"Spine_effect1")

    if not Spine_di.isPlayAction then
        Spine_di:play(effectName[index].."_di",true)
        Spine_effect1:play(effectName[index].."_particle",true)
        Spine_di.isPlayAction = true
    end

	local levels = FubenDataMgr:getLevel(groupId,1)

	item.levelIds = levels
	for i = 1,4 do
		local stateItem = TFDirector:getChildByPath(panelStyle,"Panel_level_state"..i)
		local Image_lock = TFDirector:getChildByPath(stateItem,"Image_lock")
		local Image_normal = TFDirector:getChildByPath(stateItem,"Image_normal")
		local Image_pass = TFDirector:getChildByPath(stateItem,"Image_pass")
        local Spine_lock = TFDirector:getChildByPath(stateItem,"Spine_lock"):hide()

		local levelId = levels[i]

        local preEnable = FubenDataMgr:checkPreFramePlotLevelEnabled(levelId)
		local enable = FubenDataMgr:checkPlotLevelEnabled(levelId)
		local isPass = FubenDataMgr:isPassPlotLevel(levelId)

		Image_lock:setVisible(not enable)
		Image_normal:setVisible(enable and not isPass)
		Image_pass:setVisible(isPass)

        if not preEnable and enable then -- 当帧解锁
            Image_lock:setVisible(true)
            Image_normal:setVisible(false)
            Image_pass:setVisible(false)
            Spine_lock:setVisible(true)
            Spine_lock:play("1",false)
            Spine_lock:addMEListener(TFARMATURE_COMPLETE, function(...)
                    Spine_lock:removeMEListener(TFARMATURE_COMPLETE)
                    Spine_lock:hide()
                    Image_lock:setVisible(false)
                    Image_normal:setVisible(enable and not isPass)
                    Image_pass:setVisible(isPass)
                end)
        end
	end

	local preEnable = FubenDataMgr:checkPreFrameGroupEnabled(groupId, 1)
    local enable = FubenDataMgr:checkGroupEnabled(groupId, 1)
    
	_Image_lock:setVisible(not enable)
    item:setGrayEnabled(not enable)
    if not preEnable and enable then
        _Image_lock:setVisible(true)
        _Spine_lock:setVisible(true)
        _Spine_lock:play("animation",false)
        _Spine_lock:addMEListener(TFARMATURE_EVENT, function(...)
                _Spine_lock:removeMEListener(TFARMATURE_EVENT)
                _Spine_lock:hide()
                _Image_lock:setVisible(false)
               item:setGrayEnabled(false)
            end)
    end

	Label_name:setTextById(groupData.name)
    Image_icon:setTexture(groupData.pictureIcon)
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
        if not enable then
            local levels = FubenDataMgr:getLevel(groupId,1)
            local firstLevelCfg = FubenDataMgr:getLevelCfg(levels[1])
            Utils:showTips(firstLevelCfg.unlockBrief)
            return
        end

        if index == 1 then
            Utils:openView("liandongChapter.EnhuiChapterLayer",groupId)
        elseif index == 2 then
            Utils:openView("liandongChapter.HualunChapterLayer",groupId,self.activityInfo.extendData.renkezhi)
        elseif index == 3 then
            Utils:openView("liandongChapter.JibanChapterLayer",groupId,self.activityInfo.extendData.jibanzhi)
        end
	end)
end

return ChapterMapLayer