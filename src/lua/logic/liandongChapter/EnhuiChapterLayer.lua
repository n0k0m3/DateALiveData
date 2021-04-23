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

local EnhuiChapterLayer = class("EnhuiChapterLayer",BaseLayer)

function EnhuiChapterLayer:ctor(groupId, goodId)
	-- body
	self.super.ctor(self)
	self.groupId = groupId
	self.levelIds = FubenDataMgr:getLevel(groupId,1)
	self:init("lua.uiconfig.activity.enhuiChapterLayer")
end

function EnhuiChapterLayer:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Panel_model = TFDirector:getChildByPath(ui,"Panel_model")
	self.Button_help1 = TFDirector:getChildByPath(ui,"Button_help1")
	self.Label_diff = TFDirector:getChildByPath(ui,"Label_diff")
	local ScrollView_chapter = TFDirector:getChildByPath(ui,"ScrollView_chapter")
	self.uiList_level = UIListView:create(ScrollView_chapter)
	self.uiList_level:setItemsMargin(20)



	self.Label_baseNum = TFDirector:getChildByPath(ui,"Label_baseNum")

	self.sits = {}
	for i = 1,3 do
		self.sits[i] = TFDirector:getChildByPath(ui,"Panel_sit"..i)
	end

	self.Button_ready = TFDirector:getChildByPath(ui,"Button_ready")
	self.Button_ready_gray = TFDirector:getChildByPath(ui,"Button_ready_gray"):hide()
	self.Label_cost = TFDirector:getChildByPath(ui,"Label_cost")
	self.Image_cost = TFDirector:getChildByPath(ui,"Image_cost")
	self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")

	self.Label_limitLevel = TFDirector:getChildByPath(ui,"Label_limitLevel")
	self.Button_help2 = TFDirector:getChildByPath(ui,"Button_help2")

	local  limitLevel = 0
	for i = 1,#TabDataMgr:getData("Grace") do
		if not FubenDataMgr:isUnlockGraceLevel(i) then
			limitLevel = i - 1
			break
		end
	end
	self.Label_limitLevel:setText(limitLevel)


	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")

	local groupCfg = FubenDataMgr:getLevelGroupCfg(self.groupId)
	local ext = groupCfg.ext
	self.baseValue = ext.baseDrop
    local modelImage = TFImage:create(ext.modelImage)
    modelImage:setScale(0.5)
    self.Panel_model:addChild(modelImage)
	self:updateContent()
	self:updateLevelList()
	self:updateSits()
end

function EnhuiChapterLayer:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_LINKAGE_HERO_UPDATE, handler(self.updateSits, self))


    EventMgr:addEventListener(self, EV_LINKAGE_ATTR_LEVELUP, function ( ... )
        -- body
        local attrData = FubenDataMgr:getShowAttrUpData()
        Utils:openView("liandongChapter.AttrUpViewTip",attrData)
        FubenDataMgr:clearAttrUpData()
    end)

	self.Button_ready:onClick(function ( ... )
		-- body

		local enable = FubenDataMgr:checkPlotLevelEnabled(self.curLevelId)

		if not enable then
			Utils:showTips(16000501)
			return
		end
		
		Utils:openView("liandongChapter.EnhuiSquadView", self.groupId,self.curLevelId)

	end)

	self.Button_help1:onClick(function ( ... )
		-- body
		Utils:openView("liandongChapter.LevelUnlockTip",self.groupId)
	end)

	self.Button_help2:onClick(function ( ... )
		-- body
		Utils:openView("liandongChapter.GraceLevelUnlockTip")
	end)
end

function EnhuiChapterLayer:updateLevelList( )
	-- body
	for k,v in ipairs(self.levelIds) do
		local item = self.uiList_level:getItem(k)
		if not item then
			item = self.Panel_levelItem:clone()
			self.uiList_level:pushBackCustomItem(item)
		end

		self:updateLevelItem(item,v)
	end
end

function EnhuiChapterLayer:updateLevelItem(item,levelId)
	-- body
	local Image_pass = TFDirector:getChildByPath(item,"Image_pass")
	local Image_normal = TFDirector:getChildByPath(item,"Image_normal")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
	local Spine_select = TFDirector:getChildByPath(item,"Spine_select")
	local Spine_lock = TFDirector:getChildByPath(item,"Spine_lock"):hide()

	local preEnable = FubenDataMgr:checkPreFramePlotLevelEnabled(levelId)
	local enable = FubenDataMgr:checkPlotLevelEnabled(levelId)
	local isPass = FubenDataMgr:isPassPlotLevel(levelId)

	Spine_select:setVisible(levelId == self.curLevelId)
	Spine_select:play("animation",true)

	Image_pass:setVisible(isPass)
	Image_normal:setVisible(not isPass)
	Image_lock:setVisible(not enable)

	 if not preEnable and enable then -- 当帧解锁
        Image_lock:setVisible(true)
        Image_normal:setVisible(false)
        Image_pass:setVisible(false)
        Spine_lock:setVisible(true)
        Spine_lock:play("3",false)
        Spine_lock:addMEListener(TFARMATURE_COMPLETE, function(...)
                Spine_lock:removeMEListener(TFARMATURE_COMPLETE)
                Spine_lock:hide()
                Image_lock:setVisible(false)
                Image_normal:setVisible(enable and not isPass)
                Image_pass:setVisible(isPass)
            end)
    end

	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if self.curLevelId == levelId then return end
		self.curLevelId = levelId
		self:updateContent()
		self:updateLevelList()
	end)
end

function EnhuiChapterLayer:onShow( ... )
	-- body
	self.super.onShow(self)

    local attrUpData = FubenDataMgr:getShowAttrUpData()
    if attrUpData then
        FubenDataMgr:clearAttrUpData()
        Utils:openView("liandongChapter.AttrUpViewTip",attrUpData)
    end
end

function EnhuiChapterLayer:getNewLevelId( ... )
	-- body
	local levelId = 0
	for k,v in ipairs(self.levelIds) do
		local enable = FubenDataMgr:checkPlotLevelEnabled(v) 
		if enable then
			levelId = v
		end
	end
	return levelId
end

function EnhuiChapterLayer:updateContent(  )
	-- body
	self.curLevelId = self.curLevelId or self:getNewLevelId()
	local levelCfg = FubenDataMgr:getLevelCfg(self.curLevelId)
	local index = table.find(self.levelIds, self.curLevelId)
	self.Label_diff:setText(index)

	self.Label_baseNum:setText(self.baseValue[self.curLevelId])

	local cost = levelCfg.cost[1]
    if cost then
        self.Image_cost:show()
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_cost:setText(cost[2])
    else
        self.Image_cost:hide()
    end

end

function EnhuiChapterLayer:updateSits(  )
	-- body
	self.hasEnableLinkAgeHero = false
	local linkageHeros = FubenDataMgr:getLinkAgeHeros()
	self.sitHeros = {}
	for k,v in ipairs(linkageHeros) do
		self.sitHeros[v.index] = v
	end

	for i = 1,3 do
		local item = self.sits[i]
		self:updateSit(item, i)
	end
end

function EnhuiChapterLayer:updateSit( item, index)
	-- body
	local sitData = self.sitHeros[index]
	local Image_add = TFDirector:getChildByPath(item,"Image_add")
	local LoadingBar_progress = TFDirector:getChildByPath(item,"LoadingBar_progress")
	local Label_lv = TFDirector:getChildByPath(item,"Label_lv")
	local Label_progress = TFDirector:getChildByPath(item,"Label_progress")
	local Label_fightPower = TFDirector:getChildByPath(item,"Label_fightPower")
	local sprite_icon = TFDirector:getChildByPath(item,"sprite_icon")
	local Image_lock = TFDirector:getChildByPath(item,"Image_lock")
	local sprite_frame = TFDirector:getChildByPath(item,"sprite_frame")

	Image_add:setVisible(not sitData)
	sprite_frame:setVisible(sitData)
	local isLock,desId = FubenDataMgr:checkSitIsLock(self.groupId,index)

	local maxExp = 0
	Image_lock:setVisible(isLock)
	if sitData then
		maxExp = FubenDataMgr:getGraceMaxExp(sitData.level)
		LoadingBar_progress:setPercent(sitData.exp*100/maxExp)
		Label_fightPower:setText(HeroDataMgr:getHeroPower(sitData.heroId))
		sprite_icon:setTexture(HeroDataMgr:getIconPathById(sitData.heroId))
		Label_progress:setText(sitData.exp.."/"..maxExp)
		Label_lv:setText("Lv."..sitData.level - 1)
		if maxExp == 1 then
			Label_progress:setText("MAX")
		end
	else
		LoadingBar_progress:setPercent(0)
		Label_fightPower:setText(0)
		Label_progress:setText("0/"..maxExp)
		Label_lv:setText("Lv.0")
	end

	self.hasEnableLinkAgeHero = self.hasEnableLinkAgeHero or (not isLock and sitData)

	local lockTipIds = {0,16000503,16000504}
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if isLock then
			Utils:showTips(lockTipIds[index])
			return
		end

		local ingoreHeros = {}
		for k,v in pairs(self.sitHeros) do
			table.insert(ingoreHeros, v.heroId)
		end
		Utils:openView("liandongChapter.HeroChoiceLayer",function ( heroId )
			-- body
			local function sendMsg( ... )
				-- body
    			AlertManager:closeLayerByName("HeroChoiceLayer")
				FubenDataMgr:SEND_DUNGEON_REQ_SET_LINK_AGE_HERO(index,heroId)
			end

			if sitData then
				local args = {
		            tittle = 2107025,
		            reType = "dicuoDesire",
		            content = TextDataMgr:getText(16000510),
		            confirmCall = sendMsg,
		            showCancle = true,
		            uiPath = "lua.uiconfig.activity.diCuoReConfirmTipsView",
		        }
		        Utils:showReConfirm(args)
			else
				sendMsg()
			end
		end, ingoreHeros)
	end)
end

return EnhuiChapterLayer