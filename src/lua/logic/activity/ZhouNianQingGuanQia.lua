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
* -- 周年庆回忆活动关卡
]]

local ZhouNianQingGuanQia = class("ZhouNianQingGuanQia",BaseLayer)

function ZhouNianQingGuanQia:ctor(activityId, data, levelId)
	self.super.ctor(self,data)
	self.itemInfo = data
    self.levelCid_ = levelId
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.chapterDetailView")
end

function ZhouNianQingGuanQia:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Panel_titleName = TFDirector:getChildByPath(ui,"Panel_titleName")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_fight = TFDirector:getChildByPath(ui,"Button_fight")
    self.Button_dating = TFDirector:getChildByPath(ui,"Button_dating")

	self.chapter_des = TFDirector:getChildByPath(ui,"chapter_des")
	local ScrollView_chapter = TFDirector:getChildByPath(ui,"ScrollView_chapter")
	self.chapterList = UIListView:create(ScrollView_chapter);


	local ScrollView_reward = TFDirector:getChildByPath(ui,"ScrollView_reward")
	self.rewardList = UIListView:create(ScrollView_reward);
	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")
	self.Panel_line = TFDirector:getChildByPath(ui,"Panel_line")
    self:choiceChapter(self.levelCid_ or self.itemInfo.extendData.dungeonidList[1])
    self:updateChapterList()
end

function ZhouNianQingGuanQia:getClosingStateParams()
    return {activityId, self.itemInfo, self.levelCid_}
end

function ZhouNianQingGuanQia:registerEvents( )
	-- body
	self.super.registerEvents(self)

    EventMgr:addEventListener(self, EV_FUBEN_LEVELINFOUPDATE, function ( ... )
        self:updateChapterList()
        self:choiceChapter(self.levelCid_)
    end)

    self.Button_close:onClick(function ( ... )
        AlertManager:closeLayer(self)
    end)

    self.Button_fight:onClick(function ( ... )
        local isCanFighting = true
        local cost = self.levelCfg_.cost[1]
        if cost then
            local challengeCount = 1
            isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * challengeCount)
        end

        if not isCanFighting then
            local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
            local name = TextDataMgr:getText(goodsCfg.nameTextId)
            Utils:showTips(2100034, name)
            return
        end
            local levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(self.levelCfg_.levelGroupId)
            local chapterCfg_ = FubenDataMgr:getChapterCfg(levelGroupCfg_.dungeonChapterId)
            local fubenType_ = FubenDataMgr:getFubenType(self.levelCid_)
            Utils:openView("fuben.FubenSquadView", fubenType_ ,self.levelCid_, false, 1)
        end)
    self.Button_dating:onClick(function ( ... )
            FubenDataMgr:send_DUNGEON_FIGHT_START(self.levelCid_)
        end)
end

function ZhouNianQingGuanQia:updateChapterList(  )
	-- body
    local pos = self.chapterList.scrollView_:getContentOffset()
    self.chapterList:removeAllItems()
	for k,v in ipairs(self.itemInfo.extendData.dungeonidList) do
		if k ~= 1 then
			local line = self.Panel_line:clone()
			local image_line = TFDirector:getChildByPath(line,"Image_line")
            local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(v)
			image_line:setTexture(enabled and "ui/activity/znq_huigu/tip/002.png" or "ui/activity/znq_huigu/tip/003.png")
			self.chapterList:pushBackCustomItem(line)
		end

		local chapterItem = self.Panel_levelItem:clone()
		self:updateLevelItem(chapterItem,v)
		self.chapterList:pushBackCustomItem(chapterItem)
	end
    self.chapterList:setCenterArrange()
    self.chapterList.scrollView_:setContentOffset(pos)
end

function ZhouNianQingGuanQia:updateLevelItem(item, levelCid)
	local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)
    local levelInfo = FubenDataMgr:getLevelInfo(levelCid)
    local Button_level = TFDirector:getChildByPath(item, "Button_level")
    local Label_name = TFDirector:getChildByPath(Button_level, "Label_name")
    local Image_type = TFDirector:getChildByPath(Button_level, "Image_type")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_lock_pre = TFDirector:getChildByPath(item, "Image_lock_pre"):hide()
    local Image_select = TFDirector:getChildByPath(item, "Image_select")

    if not enabled then
        Image_lock_pre:show()
    end
    local levelType = {
        [EC_FBLevelType.FIGHTING] = {
            icon = "ui/fuben/fighting_paly.png",
        },
        [EC_FBLevelType.DATING] = {
            icon = "ui/fuben/dating_play.png",
        },
        [EC_FBLevelType.CITYDATING] = {
            icon = "ui/fuben/dating_play.png",
        },
    }
    local levelTypeData = levelType[levelCfg.dungeonType]
    Image_type:setTexture(levelTypeData.icon)
    Image_select:setVisible(levelCid == self.levelCid_)
    Button_level:setTouchEnabled(enabled)
    Label_name:setTextById(levelCfg.name)
    Button_level:setTextureNormal(levelCfg.icon)

    Button_level:onClick(function()
        self:choiceChapter(levelCid)
        self:updateChapterList()
    end)
end

function ZhouNianQingGuanQia:choiceChapter( levelCid )
	-- body
	self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    self.levelCid_ = levelCid
	-- self.Label_name:setTextById(self.levelCfg_.name)
 --    self.Panel_titleName:setPositionX(self.Label_name:getPositionX() + self.Label_name:getSize().width)
	self.chapter_des:setTextById(self.levelCfg_.plotBrief)
    self.rewardList:removeAllItems()
    for k,v in pairs(self.levelCfg_.firstDropShow) do  
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:setScale(0.6)
        local flag = 0
        if FubenDataMgr:isPassPlotLevel(self.levelCid_) then
            flag = bit.bor(flag, EC_DropShowType.DATING_GETED)
        end
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v},flag)
        self.rewardList:pushBackCustomItem(Panel_dropGoodsItem)
    end

    if self.levelCfg_.dungeonType == EC_FBLevelType.FIGHTING then
        self.Button_fight:show()
        self.Button_dating:hide()
    elseif self.levelCfg_.dungeonType == EC_FBLevelType.DATING then
        self.Button_fight:hide()
        self.Button_dating:show()
    end
end

return ZhouNianQingGuanQia