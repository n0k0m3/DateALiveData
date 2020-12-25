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
*-- 游乐园主页 
]]

local RokerView = import("lua.logic.osd.RokerView")
local ResLoader = require("lua.logic.battle.ResLoader")
local AmusementPackMainView = class("AmusementPackMainView",BaseLayer)

function AmusementPackMainView:ctor( ... )
	-- body
	self.super.ctor(self, ...)
	self:init("lua.uiconfig.activity.znq_yly_maplayer")
	self:loadMap()
    WorldRoomDataMgr:getCurControl():setView(self)
end

function AmusementPackMainView:initUI(ui)
	self.super.initUI(self, ui)

	self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
	self.uiPanel = TFDirector:getChildByPath(ui, "panel_ui")
  
  
	self.mapPanel = TFDirector:getChildByPath(self.rootPanel, "panel_map")
	self.returnBtn = TFDirector:getChildByPath(self.uiPanel, "Button_return")
	self.Button_hideUI = TFDirector:getChildByPath(self.uiPanel, "Button_hideUI")

    self.Button_chat = TFDirector:getChildByPath(self.uiPanel, "Button_chat")
    self.Button_emoji = TFDirector:getChildByPath(self.uiPanel, "Button_emoji")

    self.Panel_emoji = TFDirector:getChildByPath(self.uiPanel, "Panel_emoji"):hide()

    self.Panel_miniMap = TFDirector:getChildByPath(self.uiPanel, "Panel_miniMap")

    self.Panel_action = TFDirector:getChildByPath(self.uiPanel, "Panel_action")

	self.rokerPanel = TFDirector:getChildByPath(self.uiPanel, "panel_roker")

    self.Panel_message = TFDirector:getChildByPath(self.uiPanel, "Panel_message"):hide()

    self.Label_roomId = TFDirector:getChildByPath(self.uiPanel, "Label_roomId")
    self.Label_roomId:setText(WorldRoomDataMgr:getRoomID())

    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()
    self.Button_showUI = TFDirector:getChildByPath(self.Panel_touch, "Button_showUI"):hide()
    --摇杆
	self.rokerView = RokerView:new(self.rokerPanel)


    local prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.Panel_actionItem = TFDirector:getChildByPath(prefab, "Panel_actionItem")
    self.Panel_emojiItem = TFDirector:getChildByPath(prefab, "Panel_emojiItem")



    local ScrollView_emoji = TFDirector:getChildByPath(self.Panel_emoji,"ScrollView_emoji")
    self.gridView_emoji = UIGridView:create(ScrollView_emoji)
    self.gridView_emoji:setItemModel(self.Panel_emojiItem)
    self.gridView_emoji:setColumn(3)
    self.gridView_emoji:setRowMargin(2)
    self.gridView_emoji:setColumnMargin(2)

    self.Button_ani_n = TFDirector:getChildByPath(self.Panel_emoji,"Button_ani_n")
    self.Image_ani_s = TFDirector:getChildByPath(self.Panel_emoji,"Image_ani_s")
    self.Button_emoji_n = TFDirector:getChildByPath(self.Panel_emoji,"Button_emoji_n")
    self.Image_emoji_s = TFDirector:getChildByPath(self.Panel_emoji,"Image_emoji_s")
end

function AmusementPackMainView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	if self.rokerView then
		self.rokerView:registerEvents()
	end

	self.returnBtn:onClick(function()
        local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(14110234),
            reType = EC_OneLoginStatusType.ReConfirm_ExitTeamScene,
            confirmCall = function()
                AlertManager:changeScene(SceneType.MainScene)
            end,
        }
        Utils:showReConfirm(args)
    end)
    
    self.Button_hideUI:onClick(function()
        self:hideOrShowUI(false)
    end)
    
    self.Button_showUI:onClick(function ( ... )
        -- body
        self.Button_showUI:hide()
        self:hideOrShowUI(true)
    end)

    self.Panel_touch:onClick(function()
        self.Button_showUI:setVisible(not self.uiPanel:isVisible())
        self.Button_showUI:setZOrder(100)

        if not self.hideTimer then
            self.hideTimer = TFDirector:addTimer(3000,1,nil,function ( ... )
                -- body
                self.hideTimer = nil
                local arr = {
                    FadeOut:create(0.5),
                     CallFunc:create(function ( ... )
                         -- body
                         self.Button_showUI:hide()
                         self.Button_showUI:setOpacity(255)
                     end)
                }
                self.Button_showUI:runAction(Sequence:create(arr))
            end)
        end
    end)

    self.Button_chat:onClick(function ( ... )
        -- body
        local ChatView = require("lua.logic.chat.ChatView")
        ChatView.show(function ( )

        end,nil, nil , true, nil) 

        self.chatView = ChatView
    end)

    self.Button_emoji:onClick(function ( ... )
        -- body
        self:updateEmojiPanel()
        self.Panel_emoji:setVisible(not self.Panel_emoji:isVisible())
    end)

    self.Button_emoji_n:onClick(function ( ... )
        -- body
        self.showEmojiPanel = true
        self:updateEmojiPanel()
    end)

    self.Button_ani_n:onClick(function ( ... )
        -- body
        self.showEmojiPanel = false
        self:updateEmojiPanel()
    end)

    self.Panel_miniMap:setTouchEnabled(true)
    self.Panel_miniMap:onClick(function ( ... )
        -- body 
        FunctionDataMgr:jPersonInfoBase(1)
    end)

    self:addMEListener(TFWIDGET_ENTERFRAME, self.update)
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))
    EventMgr:addEventListener(self, EV_OSD.EV_REFRESH_OSDROOM, handler(self.updateRoom, self))
    EventMgr:addEventListener(self, EV_OSD.EV_LEAVE, handler(self.onLeave, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.onLeave, self))
    EventMgr:addEventListener(self, EV_OSD.CHATINFO_ADD, handler(self.onRecvChatMsg, self))
    EventMgr:addEventListener(self, EV_WORLD_ROOM_SETTING_CHANGE, function ( ... )
        -- body
        if WorldRoomDataMgr:getCurControl().updateActorHideNode then
            WorldRoomDataMgr:getCurControl():updateActorHideNode()
        end
    end)

    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId, extendData )
        -- body
        if extendData and extendData.isWorldRoom then
            Utils:showTips(extendData.activityEndTip)
            self:onLeave()
        end
    end)

    EventMgr:addEventListener(self, EV_WORLD_ROKER_VIEW_SHOW,   function ( show )
        -- body
        self.rokerPanel:setVisible(show)
    end)

end

function AmusementPackMainView:onRecvChatMsg(chatInfo)
    --显示气泡
    WorldRoomDataMgr:getCurControl():heroTalk(chatInfo)
end

function AmusementPackMainView:_onExit( ... )
	-- body
    WorldRoomDataMgr:exitRoom()
    self:removeAllChildren()
    ResLoader.clean()
    if ResLoader.cacheSpine then
        for k,v in pairs(ResLoader.cacheSpine) do
            for _k,_v in ipairs(v) do
                _v:release()
            end
        end
        ResLoader.cacheSpine = {}
    end
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused()

end

--离开大世界
function AmusementPackMainView:onLeave()

    local currentScene = Public:currentScene();
    if currentScene.__cname == "AmusementPackScene" then
        AlertManager:changeScene(SceneType.MainScene)
    end
end

function AmusementPackMainView:onShow()
    self.super.onShow(self)

    if Utils:getLocalSettingValue("enterWorldRoomFirst") == "" then
        FunctionDataMgr:jPersonInfoBase(4)
        Utils:setLocalSettingValue("enterWorldRoomFirst","true")
        return
    end

    DatingDataMgr:triggerDating(self.__cname, "onShow")
    local currentScene = Public:currentScene();
    if currentScene:getTopLayer() == self then
        SpineCache:getInstance():clearUnused();
        me.TextureCache:removeUnusedTextures();
    end

    if not self.isIning then
        WorldRoomDataMgr:setWorldRoomUpdateTotalDt(0)
        self.isIning = true
    end

    local bgm = WorldRoomDataMgr:getCurControl():getCurBgm()
    if bgm then
        SafeAudioExchangePlay().playBGM(self,true,bgm)
    end
end

function AmusementPackMainView:loadMap()
	self.baseMap = requireNew("lua.logic.2020ZNQ.AmusementPackMapView"):new()
	self.mapPanel:addChild(self.baseMap)

    local mainHero = WorldRoomDataMgr:getCurControl():getMainHero()
    self.rokerView:setDelegate(mainHero)
    self.rokerView:changeSynicTime(WorldRoomDataMgr:getCurControl():getSynPosTime())
end

function AmusementPackMainView:update(dt)
    local totalDt = WorldRoomDataMgr:getWorldRoomUpdateTotalDt()
    totalDt = totalDt + dt
    WorldRoomDataMgr:setWorldRoomUpdateTotalDt(totalDt)
	self.baseMap:update(dt)
    self.rokerView:update(dt)
    self:updateMiniMap(dt)
    self:updateTriggerList(dt)
    self.detailTime = self.detailTime or 0
    self.detailTime = dt + self.detailTime 
    if self.detailTime > 1 then
        self:checkMessageShow(  )
        if self.Panel_emoji:isVisible() then
            self:updateEmojiPanel()
        end
        self.detailTime = 0
    end
    -- 如果是模拟器则直接打开调试模式
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        self.Label_roomId:setText(WorldRoomDataMgr:getRoomID().."--"..WorldRoomDataMgr:getCurControl():getHeroList():length())
    else
        self.Label_roomId:hide()
    end
end

function AmusementPackMainView:removeEvents( ... )
    self.super.removeEvents(self)
    self:removeMEListener(TFWIDGET_ENTERFRAME)
    if self.rokerView then
        self.rokerView:removeEvents()
    end

    if self.hideTimer then
        TFDirector:stopTimer(self.hideTimer)
        TFDirector:removeTimer(self.hideTimer)
        self.hideTimer = nil
    end
end

function AmusementPackMainView:hideOrShowUI(uiVisible)
    self.uiPanel:setVisible(uiVisible)
    self.Panel_touch:setVisible(not uiVisible)
end

function AmusementPackMainView:updateMiniMap(  )
    -- body

    local miniMapShow = TFDirector:getChildByPath(self.Panel_miniMap, "Panel_area")
    local Image_light = TFDirector:getChildByPath(miniMapShow, "Image_light")

    local miniMapShowSize = miniMapShow:getContentSize()

    local mapSize,mainPos = self.baseMap:getMapInfoSizeAndPos()

    local miniPos = ccp(mainPos.x*miniMapShowSize.width/mapSize.width, mainPos.y*miniMapShowSize.height/mapSize.height)
    Image_light:setPosition(miniPos)
end

function AmusementPackMainView:getMotionCfg(  )
    -- body
    local page = self.showEmojiPanel and 1 or 2

    local motions = TabDataMgr:getData("CityRoleModelMotion")

    local showList = {}
    for  k,v in pairs(motions) do
        if v.page == page then
            table.insert(showList,v)
        end
    end
    table.sort( showList, function ( v1,v2 )
        -- body
        return v1.id < v2.id
    end )
    return showList
end

function AmusementPackMainView:updateEmojiPanel()
    -- body 
    local control =  WorldRoomDataMgr:getCurControl()
    local emojiFunEnable = control:checkBuildFuncIsEnable(4)
    local aniFunEnable = control:checkBuildFuncIsEnable(5)
    self.Button_ani_n:setTouchEnabled(aniFunEnable)
    if not aniFunEnable then
        self.Button_ani_n:setColor(ccc3(125,125,125))
    else
        self.Button_ani_n:setColor(ccc3(255,255,255))
    end

    self.Button_emoji_n:setTouchEnabled(emojiFunEnable)
    if not emojiFunEnable then
        self.Button_emoji_n:setColor(ccc3(125,125,125))
    else
        self.Button_emoji_n:setColor(ccc3(255,255,255))
    end

    if not aniFunEnable then
        self.showEmojiPanel = true
    end

    self.Button_emoji_n:setVisible(not self.showEmojiPanel)
    self.Image_ani_s:setVisible(not self.showEmojiPanel)
    self.Image_emoji_s:setVisible(self.showEmojiPanel)
    self.Button_ani_n:setVisible(self.showEmojiPanel)
   

    local showList = self:getMotionCfg()

    local delItem = #self.gridView_emoji:getItems() - #showList

    if delItem > 0 then
        for i = 1,delItem do
            self.gridView_emoji:removeItem(1)
        end
    end

    for k,v in ipairs(showList) do
        local item = self.gridView_emoji:getItem(k)
        if not item then
            item = self.Panel_emojiItem:clone()
            self.gridView_emoji:pushBackCustomItem(item)
        end

        self:updateEmojiItem(item, v)
    end

end

function AmusementPackMainView:updateEmojiItem( item, data )
    -- body
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    Image_icon:setTextureNormal(data.icon)
    Image_icon:onClick(function ( ... )
        -- body
        local realAction = data.actionId
        if data.playEffectByEquip then
            local mainHero = WorldRoomDataMgr:getCurControl():getMainHero()
            local mainActorData = mainHero:getActorData()
            if mainActorData.effectId then
                realAction = mainActorData.effectId*1000 + realAction
                if not TabDataMgr:getData("WorldObjectAction",realAction) then
                    realAction = data.actionId
                end
            end
        end
        WorldRoomDataMgr:getCurControl():operatePlayAction(realAction)
        self.Panel_emoji:hide()
    end)
end

function AmusementPackMainView:updateTriggerList( dt )
    -- body
    if not WorldRoomDataMgr:getCurControl().triggerChange then return end
    WorldRoomDataMgr:getCurControl().triggerChange = false
    
    self.actionItems = self.actionItems or {}
    for _k,item in ipairs(self.actionItems) do
        item:hide()
    end
    local showInterAction = {}
    if not WorldRoomDataMgr:getCurControl():mainHeroIsInBuilding() then
        local interAction = WorldRoomDataMgr:getCurControl():getFocusInterActionList()
        table.sort(interAction, function ( a, b )
            -- body

            local actionCfg1 = TabDataMgr:getData("WorldActionButton",a.interActionId)
            local actionCfg2 = TabDataMgr:getData("WorldActionButton",b.interActionId)

            return actionCfg1.id < actionCfg2.id

        end)
        for k,v in ipairs(interAction) do
            if not showInterAction[v.interActionId] then
                showInterAction[v.interActionId] = v
            end

            if table.count(showInterAction) >= WorldRoomDataMgr:getMaxInterButtonNum() then
                break
            end
        end
    else
        local actionList = WorldRoomDataMgr:getCurControl():getMainHeroIsInBuildingInterActionList()
        showInterAction = actionList
    end
    self:createActionButtonList(showInterAction)
end

function  AmusementPackMainView:createActionButtonList( actionList )
    -- body
    local itemWidth = self.Panel_actionItem:getContentSize().width
    local basePoint = self.Panel_action:getContentSize().width - itemWidth*self.Panel_actionItem:getAnchorPoint().x
    local index = 1
    for k,v in pairs(actionList) do
        if not self.actionItems[index] then
            self.actionItems[index] = self.Panel_actionItem:clone()
            self.actionItems[index]:setPosition(ccp(basePoint-(index-1)*(itemWidth+20),0))
            self.Panel_action:addChild(self.actionItems[index])
        end
        local item = self.actionItems[index]
        item:show()
        local actionCfg = TabDataMgr:getData("WorldActionButton",v.interActionId)
        local btn_action = TFDirector:getChildByPath(item,"btn_action")
        local Image_flag = TFDirector:getChildByPath(item,"Image_flag"):hide()
        local Spine_effect = TFDirector:getChildByPath(item,"Spine_effect")

        if actionCfg.effectPath and actionCfg.effectPath ~= ""  then
            Spine_effect:show()
            if Spine_effect.curRes ~= actionCfg.effectPath then
                Spine_effect:setFile(actionCfg.effectPath)
                Spine_effect:play(actionCfg.effectAction,true)
                Spine_effect.curRes = actionCfg.effectPath
            end
        else
            Spine_effect:hide()
        end
        btn_action:setTextureNormal(actionCfg.actionButton)
        btn_action:onClick(function ( ... )
            -- body
            WorldRoomDataMgr:getCurControl():triggerNpcFunc(v)
        end)
        index = index + 1
    end
end

function AmusementPackMainView:checkMessageShow(  )
    -- body
    local showTimeInfo = WorldRoomDataMgr:getCurExtDataControl():getShowTimeInfo()

    local stime = showTimeInfo.stime or 0
    local etime = showTimeInfo.etime or 0
    local needToShow = showTimeInfo.needToShow or 0

    local curTime = ServerDataMgr:getServerTime()
    local remandTime = stime - curTime

    if stime == 0 or etime == 0 then
        self.Panel_message:hide()
        return
    end

    if curTime >= stime - needToShow and curTime < etime then
        self.Panel_message:show()
    end

    local cfg = TabDataMgr:getData("WorldObjectRefresher",showTimeInfo.decorateId)
    if not cfg or cfg.hintPreDes == 0 then 
        self.Panel_message:hide() 
        return 
    end

    local textId = cfg.hintPreDes
    if curTime >= stime then
        remandTime = etime - curTime
        textId = cfg.hintEventDes
    end

    if remandTime < 0 then 
        self.Panel_message:hide()  
        return
    end
    if curTime == stime then
        if not self.start_spine then
            self.start_spine = ResLoader.createSpine(cfg.hintStartEffect)
            self.Panel_message:addChild(self.start_spine)
            self.start_spine:setZOrder(10)
        end
        self.start_spine:show()
        self.start_spine:play("start",false)
         self.start_spine:addMEListener(TFARMATURE_COMPLETE,function ( ... )
            -- body
            self.start_spine:removeMEListener(TFARMATURE_COMPLETE)
            self.start_spine:hide()
        end)
        Utils:playSound(cfg.hintStartAudio,false)
    elseif curTime == etime then
        if not self.end_spine then
            self.end_spine = ResLoader.createSpine(cfg.hintEndEffect)
            self.Panel_message:addChild(self.end_spine)
        end
        self.end_spine:show()
        self.end_spine:play("ent",false)
        self.end_spine:addMEListener(TFARMATURE_COMPLETE,function ( ... )
            -- body
            self.end_spine:removeMEListener(TFARMATURE_COMPLETE)
            self.end_spine:hide()
        end)
        Utils:playSound(cfg.hintEndAudio,false)
    end

    local Label_message = TFDirector:getChildByPath(self.Panel_message,"Label_message")
    local day,hour,min,sec = Utils:getTimeDHMZ(remandTime)
    local strTime = ""
    if hour > 0 and sec > 0 then
        min = min + 1
        strTime = string.format("%.2d:%.2d",hour,min)
    else
        strTime = string.format("%.2d:%.2d",min,sec)
    end
    Label_message:setTextById("r"..textId,strTime)
end

return AmusementPackMainView