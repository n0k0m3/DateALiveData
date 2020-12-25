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
local FlyShipMainView = class("FlyShipMainView",BaseLayer)

function FlyShipMainView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:init("lua.uiconfig.explore.flyShipMainLayer")
end

function FlyShipMainView:initUI(ui)
	-- body
	self.super.initUI(self,ui)
	self.Button_return = TFDirector:getChildByPath(ui,"Button_return")
	self.Button_attrList = TFDirector:getChildByPath(ui,"Button_attrList")
	self.Label_fightPower = TFDirector:getChildByPath(ui,"Label_fightPower")
	self.Button_explore = TFDirector:getChildByPath(ui,"Button_explore")
	self.Image_explore = TFDirector:getChildByPath(self.Button_explore ,"Image_explore")
	self.Label_styleText = TFDirector:getChildByPath(ui,"Label_styleText")
	self.Spine_flyShip = TFDirector:getChildByPath(ui,"Spine_flyShip")
	self.Spine_flyShip.keepPos = self.Spine_flyShip:getPosition()
	self.Spine_flyShip:setupPoseWhenPlay(false)
	self.Spine_flyShip1 = TFDirector:getChildByPath(ui,"Spine_flyShip1")
	self.Panel_backEffect = TFDirector:getChildByPath(ui,"Panel_back"):hide()
	self.Spine_bg = TFDirector:getChildByPath(ui,"Spine_bg")
	self.Spine_chuxian = TFDirector:getChildByPath(ui,"Spine_chuxian")
	self.Spine_chuxian:setupPoseWhenPlay(false)
	self.Panel_show = TFDirector:getChildByPath(ui,"Panel_show")
	self.Panel_top = TFDirector:getChildByPath(ui,"Panel_top")
	self.Panel_buttom = TFDirector:getChildByPath(ui,"Panel_buttom")
	self.Panel_touch = TFDirector:getChildByPath(ui,"Panel_touch")
	self.Panel_touch:setSwallowTouch(false)
	self.Panel_touch:setSize(GameConfig.WS)
	self.Button_rank = TFDirector:getChildByPath(ui,"Button_rank"):hide()

	self.Image_style_shadow = TFDirector:getChildByPath(ui,"Image_style_shadow")

	local ScrollView_cabin = TFDirector:getChildByPath(ui,"ScrollView_cabin")
	self.uiList_cabin = UIListView:create(ScrollView_cabin)

	self.Panel_cabinItem = TFDirector:getChildByPath(ui,"Panel_cabinItem")
	self.Panel_attrItem = TFDirector:getChildByPath(ui,"Panel_attrItem")
	self.Button_hide = TFDirector:getChildByPath(ui,"Button_hide")
	self.Button_bag = TFDirector:getChildByPath(ui,"Button_bag")
	
	self.Button_skin = TFDirector:getChildByPath(ui,"Button_skin")
	local isOpen = FunctionDataMgr:isOpen(160)
	self.Button_skin:setVisible(isOpen)

	self.lab_topEn = TFDirector:getChildByPath(self.Panel_top,"img_top.lab_topEn")
	self.lab_topCh = TFDirector:getChildByPath(self.Panel_top,"img_top.lab_topCh")

	local ScrollView_attr = TFDirector:getChildByPath(ui,"ScrollView_attr")
	self.uiList_attr = UIListView:create(ScrollView_attr)
	self.uiList_attr:setItemsMargin(15)

	self:preLoadExploreRes()
	self:refreshView()
	self:updateActivityRank()
	ExploreDataMgr:Send_EXPLORE_REQ_EXPLORE_TASK_PLAN()
end

function FlyShipMainView:preLoadExploreRes()

	local nationInfo = ExploreDataMgr:getCurActivityInfoById(EC_AfkActivityID.Main)
	if nationInfo then
		local nationCfg = ExploreDataMgr:getAfkNationCfg(nationInfo.localNation)
		if nationCfg then
			local uiMap = require("lua.uiconfig.explore."..nationCfg.mapLayout)
			for k, texture in pairs(uiMap.respaths.textures) do
				me.TextureCache:addImage(texture)
			end
		end
	end

	me.TextureCache:addImage("ui/explore/console/tai1.png")
	me.TextureCache:addImage("ui/explore/console/tai2.png")
	me.TextureCache:addImage("effect/effect_afk/effects_afk_changemap.png")
	me.TextureCache:addImage("effect/afk_kaijipingmu/afk_kaijipingmu.png")
	me.TextureCache:addImage("effect/afk_kaijiqidong/afk_kaijiqidong.png")
	me.TextureCache:addImage("effect/effects_feichuan/effects_feichuan.png")

end

function FlyShipMainView:updateActivityRank()

    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.EXPLORE)[1]
    if activityId then
        local isOpen = ActivityDataMgr2:isInShowTime(activityId)
        self.Button_rank:setVisible(isOpen)
    end
end

function FlyShipMainView:onShow( ... )
	-- body
	self.super.onShow(self)

	TFDirector:send(c2s.EXPLORE_REQ_REFRESH_FIGHT_POWER, {})

	SafeAudioExchangePlay().playBGM(self, true)
	
	if not self.isInitView then
		self.isInitView = true
		self.Panel_show:hide()
		self.ui:timeOut(function ( ... )
			self.Spine_flyShip1:hide()
			self.Spine_flyShip:hide()
			self.Spine_chuxian:addMEListener(TFARMATURE_EVENT,
		            function()
							self.Spine_chuxian:removeMEListener(TFARMATURE_EVENT)
							self:showAnim()
		            	end)


			self.Spine_chuxian:addMEListener(TFARMATURE_COMPLETE,function ( ... )
					self.Spine_chuxian:removeMEListener(TFARMATURE_COMPLETE)
					self.Panel_backEffect:show()
			end)
			self.Spine_chuxian:play("animation3-1",false)
		end)
	else
		ViewAnimationHelper.doMoveFadeInAction(self.Panel_top, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2})
		ViewAnimationHelper.doMoveFadeInAction(self.Panel_buttom, {direction = 4, distance = 0, ease = 2, delay = 0.1, time = 0.2})
		GameGuide:checkGuide(self);
	end
end

function FlyShipMainView:showAnim( ... )
	-- body
	self.Spine_flyShip1:show()
	local cfg = ExploreDataMgr:getShipCfg()
	self.Spine_flyShip1:addMEListener(TFARMATURE_EVENT,function ( ... )
		self.Spine_flyShip1:removeMEListener(TFARMATURE_EVENT)
		self.Spine_flyShip:show()
		self.Spine_flyShip:play(cfg.showAction,true)
	end)
	self.Spine_flyShip1:addMEListener(TFARMATURE_COMPLETE,
            function()
					self.Spine_flyShip1:removeMEListener(TFARMATURE_COMPLETE)
            		self.Spine_flyShip1:hide()
					self.Panel_show:show()
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_top, {direction = 1, distance = 0, ease = 2, delay = 0.1, time = 0.2})
					ViewAnimationHelper.doMoveFadeInAction(self.Panel_buttom, {direction = 4, distance = 0, ease = 2, delay = 0.1, time = 0.2})
  					GameGuide:checkGuide(self);
				end)
	self.Spine_flyShip1:play(cfg.appearAction,false)
end

function FlyShipMainView:registerEvents(ui)
	-- body
	self.super.registerEvents(self,ui)
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_REFRESH, handler(self.refreshView, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_EQUIP_UPDATE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_TASK_REFRESH, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_CABIN_TECH_REFRESH, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_BAG_EXPLORE_TREATURE_UPDATE, handler(self.checkRedPoint, self))
    EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.checkRedPoint, self))
	EventMgr:addEventListener(self, EV_EXPLORE_CABIN_EQUIP_REFRESH, handler(self.checkRedPoint, self))
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.checkRedPoint, self))
	EventMgr:addEventListener(self, EV_EXPLORE_TASK_RED_POINT, handler(self.checkRedPoint, self))

	

    EventMgr:addEventListener(self, EV_EXPLORE_SHIP_REFRESH, handler(self.updateShipAttrList, self))
	EventMgr:addEventListener(self, EV_EXPLORE_JUMPCITY, handler(self.updateSetNationCid, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateActivityRank, self))

	EventMgr:addEventListener(self, EV_EXPLORE_SKINCHANGE, handler(self.refreshSkinRes,self))

	self.Button_bag:onClick(function ( ... )
		Utils:openView("explore.ShipBagView")
		Utils:playSound(5048)
		return true
	end)

	self.Button_skin:onClick(function()
		-- ViewAnimationHelper.doMoveFadeInAction(self.Panel_top, {direction = 1, distance = 0, ease = 2, delay = 0.5, time = 0.2})
		-- ViewAnimationHelper.doMoveFadeInAction(self.Panel_buttom, {direction = 4, distance = 0, ease = 2, delay = 0.5, time = 0.2})
		-- local actions = Spawn:create({
		-- 	ScaleTo:create(0.4, 0.4),
		-- 	MoveTo:create(0.4,ccp(324,254)),
		-- })
		-- self.Spine_flyShip:runAction(Sequence:create({actions, CallFunc:create(function()
			Utils:openView("explore.ExploreSkinView", handler(self.closeSkinViewFunc, self))
			Utils:playSound(5048)
		-- 	self.Spine_flyShip:setPosition(self.Spine_flyShip.keepPos)
		-- 	self.Spine_flyShip:setScale(0.7)
		-- end)}))
		return true
	end)

	self.Button_return:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
		Utils:playSound(5048)
		return true
	end)

	self.Button_attrList:onClick(function ( ... )
		-- body
		if not self.showAttr then
			self.showAttr = true
			self.ui:runAnimation("Action0",1)
		else
			self.ui:runAnimation("Action1",1)
			self.showAttr = false
		end
		Utils:playSound(5048)
		return true
	end)

	self.Panel_touch:onClick(function ( ... )
		-- body
		if self.showAttr then
			self.ui:runAnimation("Action1",1)
			self.showAttr = false
		end
	end)

	self.Button_hide:onClick(function ( ... )
		-- body
		self.ui:runAnimation("Action1",1)
		self.showAttr = false
		Utils:playSound(5048)
		return true
	end)

	self.Button_explore:onClick(function ( ... ) -- 打开探索界面
		AlertManager:closeLayer(self)
		Utils:playSound(5048)
		return true
	end)

	self.Button_rank:onClick(function()
		ExploreDataMgr:Send_GetActivityRank()
	end)

end

function FlyShipMainView:closeSkinViewFunc()
end

function FlyShipMainView:updateSetNationCid()
	local nationCid = ExploreDataMgr:getCurNation()
	if not nationCid then
		local nationInfo = ExploreDataMgr:getCurActivityInfoById(EC_AfkActivityID.Main)
		if nationInfo then
			nationCid = nationInfo.localNation
		end
	end
	local nationCfg = ExploreDataMgr:getAfkNationCfg(nationCid)
	if nationCfg then
		self.Image_explore:setTexture(nationCfg.mainIcon)
	end
end

function FlyShipMainView:refreshView( ... )
	-- body
	self:updateCabinList()
	self:updateShipAttrList()
	self:updateSetNationCid()
	self:refreshSkinRes()
	self:checkRedPoint()
end

function FlyShipMainView:refreshSkinRes()
	if self.shipSkinId ~= ExploreDataMgr:getCurShipSkinId() then
		self.shipSkinId = ExploreDataMgr:getCurShipSkinId()
		local cfg = ExploreDataMgr:getShipCfg()
		self.Spine_flyShip1:setFile(string.format("effect/exploreSkinEffects/%s/%s",cfg.id,cfg.appearResource))
		self.Spine_flyShip:setFile(string.format("effect/exploreSkinEffects/%s/%s",cfg.id,cfg.showResource))
		local ani = cfg.showAction or "animation"
		self.Spine_flyShip:setScale(cfg.showSize)
		self.Spine_flyShip1:setScale(cfg.showSize)
		self.Spine_flyShip:setPosition(cfg.showSite)
		self.Spine_flyShip1:setPosition(cfg.showSite)

		if self.isInitView then
			self.Spine_flyShip:show()
			self.Spine_flyShip:play(cfg.showAction,true)
		end

		self.lab_topEn:setText(cfg.nameEn)
		self.lab_topCh:setText(cfg.nameCn)
	end
end

function FlyShipMainView:updateCabinList( ... )
	-- body
	local cabins = TabDataMgr:getData("ExploreCabinUi")
	for i = 1,#cabins do
		local roomCfg, roomDetailCfg,roomStageCfg = ExploreDataMgr:getCabinCfg(i)
		local item = self.uiList_cabin:getItem(i)
		if not item then
			item = self.Panel_cabinItem:clone()
			self.uiList_cabin:pushBackCustomItem(item)
			item:setName("shipRoom"..i)
		end
		local Panel_normal = TFDirector:getChildByPath(item,"Panel_normal")
		local Panel_lock = TFDirector:getChildByPath(item,"Panel_lock")

		local btn = TFDirector:getChildByPath(Panel_normal,"Button_cabin")
		local Label_name = TFDirector:getChildByPath(Panel_normal,"Label_name")
		local Label_level = TFDirector:getChildByPath(Panel_normal,"Label_level")
		local Image_redTip = TFDirector:getChildByPath(Panel_normal,"Image_redTip")
		btn:setTextureNormal(roomCfg.mainIcon)
		Label_name:setText(roomDetailCfg.name)
		Label_level:setText("Lv."..roomDetailCfg.level)
		Label_level:setVisible(roomCfg.showLevel)


		local Button_lock = TFDirector:getChildByPath(Panel_lock,"Button_lock")
		local Label_name1 = TFDirector:getChildByPath(Panel_lock,"Label_name")
		local Label_unlock_level = TFDirector:getChildByPath(Panel_lock,"Label_unlock_level")
		Label_name1:setText(roomDetailCfg.name)
		Label_unlock_level:setText(roomCfg.unlockDes)

		local function checkUnlock( ... ) -- 策划说的只添加前端的舱室解锁逻辑
			-- body
			local unlock = true
			if roomCfg.unlockCondition then

				for k,v in pairs(roomCfg.unlockCondition) do
					local _cfg, detailCfg = ExploreDataMgr:getCabinCfg(k)
					if detailCfg.level < v then
						unlock = false
						break;
					end
				end
			end
			return unlock
		end

		Panel_normal:setVisible(checkUnlock(roomCfg))
		Panel_lock:setVisible(not checkUnlock(roomCfg))



		btn:onClick(function ( ... )
			local realFileName = "explore."..roomCfg.pageUi[1].fileName
			Utils:openView(realFileName, roomCfg.type, 1, roomCfg.pageUi[1].pageIndex)
			Utils:playSound(5048)
			return true
		end)

		Button_lock:onClick(function ( ... )
			Utils:showTips(13311264)
		end)
	end
end

function FlyShipMainView:checkRedPoint()
	-- body

	local cabins = TabDataMgr:getData("ExploreCabinUi")
	for i = 1,#cabins do
		local roomCfg = cabins[i]
		local item = self.uiList_cabin:getItem(i)
		local Panel_normal = TFDirector:getChildByPath(item,"Panel_normal")
		local Image_redTip = TFDirector:getChildByPath(Panel_normal,"Image_redTip")

		local showRedPoint = false
		for k,v in pairs(roomCfg.pageUi) do
			showRedPoint = ExploreDataMgr:checkRedPoint(roomCfg.type,v.fileName,v.pageIndex)
			if showRedPoint then break end
		end

		Image_redTip:setVisible(showRedPoint)
	end
end

function FlyShipMainView:updateShipAttrList()
	if not ExploreDataMgr.shipInfo then return end
	local attr = ExploreDataMgr.shipInfo.attr or {}
	if #attr <= 0 then return end

	self.uiList_attr:removeAllItems()
	self.Label_fightPower:setText(attr[1].fightPower)

	local num = #self.uiList_attr:getItems() - (#attr - 1)
	for i = 1, math.abs(num) do
		if num > 0 then
			self.uiList_attr:removeItem(1)
		else
			local item = self.Panel_attrItem:clone()
			self.uiList_attr:pushBackCustomItem(item)
		end
	end
 
	local startId = 13311314
	for k = 1, (#attr - 1) do
		local item = self.uiList_attr:getItem(k)
		local Label_attrName = TFDirector:getChildByPath(item,"Label_attrName")
		local Label_value = TFDirector:getChildByPath(item,"Label_value")
		local data = attr[k + 1]
		Label_attrName:setTextById(startId + k -1)
		Label_value:setText("+" .. data.fightPower)
	end
	self.Label_styleText:setTextById(13311310 + ExploreDataMgr.shipInfo.shape)
	self.Image_style_shadow:setTexture("ui/explore/main/stype"..ExploreDataMgr.shipInfo.shape..".png")
end

function FlyShipMainView:removeEvents()
	self.super.removeEvents(self)
end

return FlyShipMainView