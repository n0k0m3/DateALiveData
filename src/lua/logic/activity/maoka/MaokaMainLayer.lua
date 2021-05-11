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
local ResLoader = require("lua.logic.battle.ResLoader")
local MaokaMainLayer = class("MaokaMainLayer",BaseLayer)

function MaokaMainLayer:ctor( ... )
	-- body
	self.super.ctor(self, ...)
	self:init("lua.uiconfig.activity.maokaMainLayer")
	self:loadMap()
    WorldRoomDataMgr:getCurControl():setView(self)
end

function MaokaMainLayer:initUI(ui)
	self.super.initUI(self, ui)

	self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
	self.uiPanel = TFDirector:getChildByPath(ui, "panel_ui")
    self.uiPanel:setCameraMask(32)
  
	self.mapPanel = TFDirector:getChildByPath(self.rootPanel, "panel_map")
	self.returnBtn = TFDirector:getChildByPath(self.uiPanel, "Button_return")
	self.Button_hideUI = TFDirector:getChildByPath(self.uiPanel, "Button_hideUI")
    self.Button_help = TFDirector:getChildByPath(self.uiPanel, "Button_help")

    self.Label_roomId = TFDirector:getChildByPath(self.uiPanel, "Label_roomId")
    self.Label_roomId:setText(WorldRoomDataMgr:getRoomID())

    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()
    self.Button_showUI = TFDirector:getChildByPath(self.Panel_touch, "Button_showUI"):hide()


    self.Panel_toy = TFDirector:getChildByPath(self.uiPanel, "Panel_toy")

	self.Button_gongshi = TFDirector:getChildByPath(ui, "Button_gongshi")
	self.red_gongshi = TFDirector:getChildByPath(self.Button_gongshi, "Image_red")
	self.Button_maoshe = TFDirector:getChildByPath(ui, "Button_maoshe")
	self.red_maoshe  = TFDirector:getChildByPath(self.Button_maoshe, "Image_red")
	self.Button_adventure = TFDirector:getChildByPath(ui, "Button_adventure")
	self.red_adventure = TFDirector:getChildByPath(self.Button_adventure, "Image_red")
	self.Button_task = TFDirector:getChildByPath(ui, "Button_task")
	self.red_task = TFDirector:getChildByPath(self.Button_task, "Image_red")
	self.Button_shop = TFDirector:getChildByPath(ui, "Button_shop")
	self.red_shop = TFDirector:getChildByPath(self.Button_shop, "Image_red")
	self.Button_make = TFDirector:getChildByPath(ui, "Button_make")
	self.red_make    = TFDirector:getChildByPath(self.Button_make, "Image_red")
	self.Button_nvpu = TFDirector:getChildByPath(ui, "Button_nvpu")
	self.red_nvpu    = TFDirector:getChildByPath(self.Button_nvpu, "Image_red")
    self.Button_btnCg = TFDirector:getChildByPath(ui, "Button_btnCg")

	self:upadteBtnState()
	self:updateToyPanel()
end

function MaokaMainLayer:updateToyPanel( ... )
	-- body
	if not self.initToyPanel then
		self.initToyPanel = true
		self.showPanel = TFDirector:getChildByPath(self.Panel_toy,"Image_di")
		self.Button_show = TFDirector:getChildByPath(self.Panel_toy,"Button_show")
		self.Button_hide = TFDirector:getChildByPath(self.Panel_toy,"Button_hide")
		self.Panel_upItem = TFDirector:getChildByPath(self.Panel_toy,"Panel_upItem")
        self.Label_addTip = TFDirector:getChildByPath(self.Panel_toy,"Label_addTip")
		self.Button_fangzhi = TFDirector:getChildByPath(self.Panel_toy,"Button_fangzhi")
		local ScrollView_toy = TFDirector:getChildByPath(self.Panel_toy,"ScrollView_toy")
        self.Label_target = TFDirector:getChildByPath(self.Panel_toy,"Label_target")
        self.Label_totalSpeed = TFDirector:getChildByPath(self.Panel_toy,"Label_totalSpeed")
		self.uiList_toy = UIListView:create(ScrollView_toy)
		self.uiList_toy:setItemsMargin(5)

		self.Button_show:onClick(function ( ... )
			-- body
			self.Button_show:hide()
			self.showPanel:show()
            self:updateToyPanel()
		end)

		self.Button_hide:onClick(function ( ... )
			-- body
			self.Button_show:show()
			self.showPanel:hide()
		end)

		self.Button_fangzhi:onClick(function ( ... )
			-- body
            if not self.curChoiseToy then 
                Utils:showTips(13316870)
                return 
            end


            local toyInfo = MaokaActivityMgr:getToyInfo(self.curChoiseToy)
            local curTime = ServerDataMgr:getServerTime()
            local inScene = toyInfo and toyInfo.etime > curTime

            if inScene then
                Utils:showTips(13316854)
                return
            end

            if GoodsDataMgr:getItemCount(self.curChoiseToy) <= 0 then
                Utils:showTips(13316855)
                return
            end

            MaokaActivityMgr:SEND_ACTIVITY_REQ_USEING_TOY(self.curChoiseToy)
            self.curChoiseToy = nil
		end)
	end
	local toys = MaokaActivityMgr:getToyIdList()
	for k,v in ipairs(toys) do
		local item = self.uiList_toy:getItem(k)
		if not item then
			item = self.Panel_upItem:clone()
			self.uiList_toy:pushBackCustomItem(item)
		end
		self:updateToyItem(item,v)
	end
    if self.curChoiseToy then
        local addValue = GoodsDataMgr:getItemCfg(self.curChoiseToy).useProfit.timeBenefit
        self.Label_addTip:setTextById(13316795,addValue)
    else
        self.Label_addTip:setTextById(13316797)
    end

    self.Label_target:setText(MaokaActivityMgr:getTarget())
    self.Label_totalSpeed:setTextById(13316714,MaokaActivityMgr:getTotalSpeed())
end

function MaokaMainLayer:updateToyItem( item, data )
	-- body
	local Image_itemIcon =TFDirector:getChildByPath(item,"Image_itemIcon")
	local Image_select =TFDirector:getChildByPath(item,"Image_select")
	local Label_name =TFDirector:getChildByPath(item,"Label_name")
	local Image_noHave =TFDirector:getChildByPath(item,"Image_noHave")
	local Image_inScene =TFDirector:getChildByPath(item,"Image_inScene")
	local LoadingBar_time =TFDirector:getChildByPath(item,"LoadingBar_time")
    local Label_num =TFDirector:getChildByPath(item,"Label_num")

	local itemCfg = GoodsDataMgr:getItemCfg(data)
	Image_itemIcon:setTexture(itemCfg.icon)
	Label_name:setTextById(itemCfg.nameTextId)
	local toyInfo = MaokaActivityMgr:getToyInfo(data)
	local curTime = ServerDataMgr:getServerTime()
	local inScene = toyInfo and toyInfo.etime > curTime
    Label_num:setText("x"..GoodsDataMgr:getItemCount(data))
	Image_noHave:setVisible(GoodsDataMgr:getItemCount(data) == 0 and not inScene)
	Image_inScene:setVisible(inScene)
	local percent = toyInfo and 100 - math.max(toyInfo.etime - curTime,0)*100/itemCfg.useProfit.duration or 0 
	LoadingBar_time:setPercent(percent)

	Image_select:setVisible(self.curChoiseToy == data)

    item:setTouchEnabled(true)
    item:onClick(function ( ... )
        -- body
        if self.curChoiseToy == data then return end
        self.curChoiseToy = data
        self:updateToyPanel()
    end)
end

function MaokaMainLayer:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.returnBtn:onClick(function()
        local args = {
            tittle = 2107025,
            content = TextDataMgr:getText(13316853),
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

    self.Button_help:onClick(function ( ... )
        -- body
        MaokaActivityMgr:showHelpView( )
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

    self:addMEListener(TFWIDGET_ENTERFRAME, self.update)
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))

    EventMgr:addEventListener(self, EV_MAOKA_ALLDATA_RSP, function ( activityId, extendData )
        -- body
        self:updateToyPanel()
    end)


    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.upadteBtnState, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.upadteBtnState, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function ( ... )
        -- body
        self:updateToyPanel()
        self:upadteBtnState()
    end)

    self.Button_nvpu:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaMaidListView")
    end)

    self.Button_gongshi:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaNewsTip")
    end)

    self.Button_maoshe:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaCatteryView")
    end)

    self.Button_adventure:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaAdventureView")
    end)

    self.Button_shop:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaStoreView",MaokaActivityMgr:getStoreIds(),true)
    end)

    self.Button_make:onClick(function ( ... )
    	-- body
    	Utils:openView("activity.maoka.MaokaFormulaListView")
    end)

    self.Button_task:onClick(function ( ... )
        -- body
        Utils:openView("activity.maoka.MaokaTaskView")
    end)

    self.Button_btnCg:onClick(function ( ... )
        -- body
        self.clickNum = self.clickNum or 1
        local value = Utils:getLocalSettingValue("secritCg")
        if value == "TRUE" or self.clickNum >= 10 then
            MaokaActivityMgr:playMaokaCg()
            Utils:setLocalSettingValue("secritCg","TRUE")
        end
        self.clickNum = self.clickNum + 1
    end)
end

function MaokaMainLayer:_onExit( ... )
	-- body
    WorldRoomDataMgr:exitRoom()
    self:removeAllChildren()
    ResLoader.clean()
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused()

end

--离开大世界
function MaokaMainLayer:onLeave()
    local currentScene = Public:currentScene();
    if currentScene.__cname == "AmusementPackScene" then
        AlertManager:changeScene(SceneType.MainScene)
    end
end

function MaokaMainLayer:onShow()
    self.super.onShow(self)

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

function MaokaMainLayer:loadMap()
	self.baseMap = requireNew("lua.logic.2020ZNQ.AmusementPackMapView"):new()
	self.mapPanel:addChild(self.baseMap)
end

function MaokaMainLayer:update(dt)
    local totalDt = WorldRoomDataMgr:getWorldRoomUpdateTotalDt()
    totalDt = totalDt + dt
    WorldRoomDataMgr:setWorldRoomUpdateTotalDt(totalDt)
	self.baseMap:update(dt)
    self:updateTriggerList(dt)
    self:upadteBtnState()
    -- 如果是模拟器则直接打开调试模式
    if CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 then
        self.Label_roomId:setText(WorldRoomDataMgr:getRoomID().."--"..WorldRoomDataMgr:getCurControl():getHeroList():length())
    else
        self.Label_roomId:hide()
    end
end

function MaokaMainLayer:upadteBtnState( ... )
	-- body
	self.red_adventure:setVisible(MaokaActivityMgr:checkCatTaskRedPoint())
	self.red_make:setVisible(false)
	self.red_maoshe:setVisible(MaokaActivityMgr:checkCatRecruitRedPoint())
	self.red_nvpu:setVisible(false)
	self.red_task:setVisible(MaokaActivityMgr:checkDailyTaskRedPoint())
	self.red_gongshi:setVisible(false)
	self.red_shop:setVisible(false)
end

function MaokaMainLayer:removeEvents( ... )
    self.super.removeEvents(self)
    self:removeMEListener(TFWIDGET_ENTERFRAME)
    
    if self.hideTimer then
        TFDirector:stopTimer(self.hideTimer)
        TFDirector:removeTimer(self.hideTimer)
        self.hideTimer = nil
    end
end

function MaokaMainLayer:hideOrShowUI(uiVisible)
    self.uiPanel:setVisible(uiVisible)
    self.Panel_touch:setVisible(not uiVisible)
end

function MaokaMainLayer:updateTriggerList( dt )
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

function  MaokaMainLayer:createActionButtonList( actionList )
    -- body
    
end

return MaokaMainLayer