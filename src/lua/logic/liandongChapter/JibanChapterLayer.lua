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

local JibanChapterLayer = class("JibanChapterLayer",BaseLayer)

function JibanChapterLayer:ctor(groupId, goodId)
	-- body
	self.super.ctor(self)
	self.groupId = groupId
	self.goodId = goodId
	self.levelIds = FubenDataMgr:getLevel(groupId,1)
	self:init("lua.uiconfig.activity.jibanChapterLayer")
end

function JibanChapterLayer:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Panel_model = TFDirector:getChildByPath(ui,"Panel_model")
	self.Button_help1 = TFDirector:getChildByPath(ui,"Button_help1")
	self.Button_help2 = TFDirector:getChildByPath(ui,"Button_help2")
	self.Label_diff = TFDirector:getChildByPath(ui,"Label_diff")
	local ScrollView_chapter = TFDirector:getChildByPath(ui,"ScrollView_chapter")
	self.uiList_level = UIListView:create(ScrollView_chapter)
	self.uiList_level:setItemsMargin(20)


	self.Label_texin = TFDirector:getChildByPath(ui,"Label_texin")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	local Image_icon = TFDirector:getChildByPath(ui,"Image_icon")

	Image_icon:setTexture(GoodsDataMgr:getItemCfg(self.goodId).icon)

	
	self.ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")

	self.Button_ready = TFDirector:getChildByPath(ui,"Button_ready")
	self.Label_value = TFDirector:getChildByPath(ui,"Label_value")
	self.Label_cost = TFDirector:getChildByPath(ui,"Label_cost")
	self.Image_cost = TFDirector:getChildByPath(ui,"Image_cost")
	self.Image_costIcon = TFDirector:getChildByPath(ui,"Image_costIcon")

	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")

	self.spriteNodes = {}
	for i = 1,3 do
		self.spriteNodes[i] = TFDirector:getChildByPath(ui,"sprite_frame"..i)
	end

	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")

	local groupCfg = FubenDataMgr:getLevelGroupCfg(self.groupId)
	local ext = groupCfg.ext
    Utils:createHeroModel(ext.model[1], self.Panel_model, 0.5, ext.model[2])
	self:updateContent()
	self:updateLevelList()
	self:updateSpriteList()
end

function JibanChapterLayer:updateLevelList( )
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

function JibanChapterLayer:updateLevelItem(item,levelId)
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

function JibanChapterLayer:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_ready:onClick(function ( ... )
		-- body 
		local enable = FubenDataMgr:checkPlotLevelEnabled(self.curLevelId)

		if not enable then
			Utils:showTips(16000501)
			return
		end

        local fubenType_ = FubenDataMgr:getFubenType(self.curLevelId)
        Utils:openView("fuben.FubenSquadView", fubenType_ ,self.curLevelId, false, 0)

	end)

	self.Button_help1:onClick(function ( ... )
		-- body
		Utils:openView("liandongChapter.LevelUnlockTip",self.groupId)
	end)

	self.Button_help2:onClick(function ( ... )
		-- body
		Utils:showTips(16000495)
	end)
end

function JibanChapterLayer:getNewLevelId( ... )
	
	for k,v in ipairs(self.levelIds) do
		local enable = FubenDataMgr:checkPlotLevelEnabled(v) 
		if enable then
			levelId = v
		end
	end
	return levelId
end

function JibanChapterLayer:updateContent(  )
	-- body
	self.curLevelId = self.curLevelId or self:getNewLevelId()
	local levelCfg = FubenDataMgr:getLevelCfg(self.curLevelId)
	local index = table.find(self.levelIds, self.curLevelId)
    self.Label_diff:setText(index)

	local cost = levelCfg.cost[1]
    if cost then
        self.Image_cost:show()
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_cost:setText(cost[2])
    else
        self.Image_cost:hide()
    end
	self.Label_value:setText(GoodsDataMgr:getItemCount(self.goodId))
	self.Label_texin:setTextById(levelCfg.plotBrief)
	self.Label_des:setTextById(levelCfg.victoryTypeDescribe[1])
    Utils:createRewardListHor(self.ScrollView_reward,levelCfg.rewardShow)

end

function JibanChapterLayer:updateSpriteList( ... )
	-- body
	local heros = FubenDataMgr:getJiBanHero()
	for k,v in ipairs(self.spriteNodes) do
		if heros[k] then
			local icon = TFDirector:getChildByPath(v,"sprite_icon")
			icon:setTexture(HeroDataMgr:getIconPathById(heros[k]))
		else
			v:hide()
		end
	end
end


return JibanChapterLayer