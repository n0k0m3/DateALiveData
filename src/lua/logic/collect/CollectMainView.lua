local CollectMainView = class("CollectMainView",BaseLayer)

function CollectMainView:initData( ... )
	
end

function CollectMainView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.collect.collectMainView")
end

function CollectMainView:initUI(ui)
	self.super.initUI(self,ui)
	local root_panel = ui:getChildByName("Panel_root")
	self.collector_panel = root_panel:getChildByName("Panel_enter_collector")
	self.sprite_panel = root_panel:getChildByName("Panel_enter_sprite")
	self.equip_panel = root_panel:getChildByName("Panel_enter_equip")
	self.token_panel = root_panel:getChildByName("Panel_enter_token")
	self.cg_panel = root_panel:getChildByName("Panel_enter_cg")
	self.dress_panel = root_panel:getChildByName("Panel_enter_dress")
	self.bgm_panel = root_panel:getChildByName("Panel_enter_bgm")
	self.dating_panel = root_panel:getChildByName("Panel_enter_dating")
	self.portrait_panel = root_panel:getChildByName("Panel_enter_portrait")
	self.medal_panel = root_panel:getChildByName("Panel_enter_medal")
	self.Panel_enter_scene = root_panel:getChildByName("Panel_enter_scene")

	
end

function CollectMainView:commonUpdateInfo(tarnode,pageType)

	local param = CollectDataMgr:getCollectsProcessByPage(pageType)
	local isShowRed = CollectDataMgr:isPageShowRed(pageType)
	tarnode:getChildByName("Label_percent_value"):setString(tostring(param.percent))
	tarnode:getChildByName("Label_trophy_value"):setString(tostring(param.trophy))

	
	tarnode:getChildByName("Image_reddot"):setVisible(isShowRed)
end

function CollectMainView:updateCollectSprite() --角色

	self:commonUpdateInfo(self.sprite_panel,EC_CollectPage.SPRITE)
end

function CollectMainView:updateCollectCG() --CG播放
	
	self:commonUpdateInfo(self.cg_panel,EC_CollectPage.CG)
end

function CollectMainView:updateCollectDating() --约会结局
	
	self:commonUpdateInfo(self.dating_panel,EC_CollectPage.DATING)
end

function CollectMainView:updateCollectEquip() --质点
	
	self:commonUpdateInfo(self.equip_panel,EC_CollectPage.EQUIP)
end

function CollectMainView:updateCollectDress()--时装
	
	self:commonUpdateInfo(self.dress_panel,EC_CollectPage.DRESS)
end

function CollectMainView:updateCollectBGM() --音乐
	
	self:commonUpdateInfo(self.bgm_panel,EC_CollectPage.SOUND)
end

function CollectMainView:updateCollectPortrait() --头像
	
	self:commonUpdateInfo(self.portrait_panel,EC_CollectPage.PORTRAIT)
end

function CollectMainView:updateCollectMedal()--徽章
	
	self:commonUpdateInfo(self.medal_panel,EC_CollectPage.MEDAL)
end

function CollectMainView:updateCollectToken() --信物
	
	if GlobalFuncDataMgr:isOpen(8) then
		self:commonUpdateInfo(self.token_panel,EC_CollectPage.TOKEN)
		self.token_panel:show()
	else
		self.token_panel:hide()
		if not self.token_panel.img_notOpen then
			self.token_panel.img_notOpen = TFImage:create("ui/collect/TJ_EQUIP_NULL.png")
			self.token_panel:getParent():addChild(self.token_panel.img_notOpen , 1)
			self.token_panel.img_notOpen:setPosition(self.token_panel:getPosition())
		end
	end
end

function CollectMainView:updateCollectScene()  --场景
	self:commonUpdateInfo(self.Panel_enter_scene,EC_CollectPage.SCENE)
end

function CollectMainView:updateCollector() --收藏家
	local rankInfo = CollectDataMgr:getRankInfo()
	local rank_lb = self.collector_panel:getChildByName("Label_collector_rank")
	self.collector_panel:getChildByName("Label_player_name"):setString(CollectDataMgr:getPlayerName())
	self.collector_panel:getChildByName("Label_player_pid"):setString(tostring(CollectDataMgr:getPlayerId()))
	
	if rankInfo.rank == nil or rankInfo.rank == 0 then
		rank_lb:setTextById(263009)
		rank_lb:setFontSize(25)
	else
		rank_lb:setString(tostring(rankInfo.rank))
		rank_lb:setFontSize(46)
	end
	self.collector_panel:getChildByName("Label_total_trophy"):setString(tostring(rankInfo.trophy))
	local collectorInfo = CollectDataMgr:getCurCollectorTitle(rankInfo.trophy)
	self.collector_panel:getChildByName("Label_collector_title"):setTextById(collectorInfo.name)
	self.collector_panel:getChildByName("Image_collector_logo"):setTexture(collectorInfo.icon)
	
end
function CollectMainView:refreshView()
	self:updateCollector()
	self:updateCollectSprite()
	self:updateCollectEquip()
	self:updateCollectToken()
	self:updateCollectDress()
	self:updateCollectBGM()
	self:updateCollectCG()
	self:updateCollectPortrait()
	self:updateCollectDating()
	self:updateCollectMedal()
	self:updateCollectScene()
end

function CollectMainView:onShow()
	self.super.onShow(self)
	self:refreshView()

	SafeAudioExchangePlay().playBGM(self, true)
	
end

function CollectMainView:registerEvents()
	EventMgr:addEventListener(self,EV_COLLECT_UPDATE_INFO,handler(self.refreshView, self))
	
	self.collector_panel:onClick(function()
		-- Utils:openView("collect.CollectorView")
		FamilyDataMgr:openFamilyMainLayer( )
	end)
	self.medal_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.MEDAL) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectMedalView")
	end)
	self.sprite_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.SPRITE) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectSpriteView")
	end)
	self.token_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.TOKEN) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectTokenView")
	end)
	self.cg_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.CG) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectCGView")
	end)
	self.dress_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.DRESS) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectDressView")
	end)
	self.bgm_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.SOUND) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectBGMView")
	end)
	self.dating_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.DATING) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectDatingView")
	end)
	self.portrait_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.PORTRAIT) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectPortraitView")
	end)
	self.equip_panel:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.EQUIP) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectEquipView")
	end)
	self.Panel_enter_scene:onClick(function()
		if CollectDataMgr:checkPageCanEnter(EC_CollectPage.SCENE) == false then
			Utils:showTips(241009)
			return
		end
		Utils:openView("collect.CollectSceneView")
	end)
end

function CollectMainView:removeUI()
	self.super.removeUI(self)
	HeroDataMgr:changeDataToSelf()
	FamilyDataMgr:setIsFriendFamily(false)
end

return CollectMainView