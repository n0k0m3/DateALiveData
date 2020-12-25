--[[黑与白主界面]]
local BlackAndWhiteMainView = class("BlackAndWhiteMainView", BaseLayer)

--[[ctor]]
function BlackAndWhiteMainView:ctor(...)
    self.super.ctor(self)
	self:initData(...)
    self:init("lua.uiconfig.blackAndWhite.BlackAndWhiteMainView")

end

function BlackAndWhiteMainView:initData(data)

	self._dayTime = data.dayTimes	
	
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BLACK_WHITE)
	
    --self.activityId_ = activity[1]
    if #activity > 0 then
		 self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
		print("--------------------------------------------------------------------------------------------BlackAndWhiteMainView:initData")
		dump(self.activityInfo_)
    else
        Utils:showTips(219007)
        return
    end
end

--[[初始化UI]]
function BlackAndWhiteMainView:initUI(ui)
	self.super.initUI(self, ui)
	--[[排行榜按钮和任务按钮]]
	local uiRoot = TFDirector:getChildByPath(ui, "Panel_root")
	local imagebg = TFDirector:getChildByPath(uiRoot, "Image_bg")
	self._rankBtn = TFDirector:getChildByPath(imagebg,"Button_rank"):hide()
	self._taskBtn = TFDirector:getChildByPath(imagebg,"Button_task")
	self._taskNewTips = TFDirector:getChildByPath(self._taskBtn,"Image_newTips")
	
	self._label_desc1 = TFDirector:getChildByPath(imagebg,"Label_desc1")
	self._label_desc2 = TFDirector:getChildByPath(imagebg,"Label_desc2")
	
	self._startTime = TFDirector:getChildByPath(imagebg,"Label_StartTime")
	self._endTime = TFDirector:getChildByPath(imagebg,"Label_EndTime")
	
	--[[三个副本信息组件]]
	self._uis = {}
	for i = 1, 3 do
		local lvbg = TFDirector:getChildByPath(imagebg,"Image_lvbg" .. i)
		local other = TFDirector:getChildByPath(imagebg,"Image_other" .. i)
		local uis = {}
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Label_level"))
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Image_icon1"))
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Image_icon2"))
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Image_icon3"))
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Image_icon4"))
		
		table.insert(uis, TFDirector:getChildByPath(other,"Image_icon"))
		table.insert(uis, TFDirector:getChildByPath(other,"Label_count2"))
		
		ScrollView_Items = TFDirector:getChildByPath(other,"ScrollView_Items")
		table.insert(uis, UIListView:create(ScrollView_Items))
		--table.insert(uis, TFDirector:getChildByPath(other,"Image_cc1"))
		--table.insert(uis, TFDirector:getChildByPath(other,"Image_cc2"))
		--table.insert(uis, TFDirector:getChildByPath(other,"Image_cc3"))
		--table.insert(uis, TFDirector:getChildByPath(other,"Image_cc4"))
		
		table.insert(uis, TFDirector:getChildByPath(imagebg,"Image_bg" .. (5 + i)))
		table.insert(uis, TFDirector:getChildByPath(lvbg,"Image_Lock"))
		
		table.insert(self._uis, uis)
	end
	
	self:refreshView()
	if self.activityId_ then
		self:onUpdateProgressEvent()
		dump(self.activityInfo_)
		local year, month, day = Utils:getDate(self.activityInfo_.startTime, true)
		local hour, min = Utils:getTime(self.activityInfo_.startTime, true)
		self._startTime:setText(year.. "." .. month .. "." .. day .. "-")
		
		local year, month, day = Utils:getDate(self.activityInfo_.endTime, true)
		local hour, min = Utils:getTime(self.activityInfo_.endTime, true)
		self._endTime:setText("-" .. year.. "." .. month.. "." .. day)
	else
		self._startTime:hide()
		self._endTime:hide()
	end
end

function BlackAndWhiteMainView:onUpdateProgressEvent()
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
	self._taskNewTips:hide()
	print("-----------------#itemIds=" .. #itemIds .. ",self.activityId_=" .. self.activityId_)
    for k,v in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
		dump(itemInfo)
		--if itemInfo.extendData.type == EC_ChronoCrossTaskType.Single then
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
            if progressInfo.status == EC_TaskStatus.GET then
                --table.insert(tab1,v)
				self._taskNewTips:show()
				break
            end
            if progressInfo.status == EC_TaskStatus.ING then
               --table.insert(tab2,v)
            end
            if progressInfo.status == EC_TaskStatus.GETED then
                --table.insert(tab3,v)
            end
        --end
	end
end

--[[注册事件]]
function BlackAndWhiteMainView:registerEvents()
	
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
	
	self._rankBtn:onClick(
		function()
			BlackAndWhiteDataMgr:send_NEW_WORLD_REQ_BLACK_WHITE_RANK()
		end)
		
	self._taskBtn:onClick(
		function()
			 Utils:openView("blackAndWhite.BlackAndWhiteTaskView")
		end)
	
	--[[请求排行榜成功]]
	EventMgr:addEventListener(self, EV_ACTIVITY_BLACKWHITE_RANKING, handler(self.onOpenBlackWhiteRanking, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_BLACKWHITE_Main_Update, handler(self.onOpenBlackWhiteMainUpdate, self))
end

--[[请求排行榜数据成功]]
function BlackAndWhiteMainView:onOpenBlackWhiteRanking(data)
 
   -- Utils:openView("blackAndWhite.BlackAndWhiteRankingView", data)
end

function BlackAndWhiteMainView:onOpenBlackWhiteMainUpdate(data)
	dump(data)
	self._dayTime = data.dayTimes	
	self:refreshDesc()
end

function BlackAndWhiteMainView:refreshDesc()
	self._label_desc1:setTextById(14110395)	
	local maxCount = TabDataMgr:getData("DiscreteData",81025).data.dayTime
	self._label_desc2:setTextById(14110396,self._dayTime,maxCount)
end

--[[ 刷新界面信息 ]]
function BlackAndWhiteMainView:refreshView()
	self:refreshDesc()
	local cfg = BlackAndWhiteDataMgr:getCfg()
	for k, v in ipairs(cfg) do
		self:updateHighTeamDungeonInfo(v)
	end
end

--[[ 刷新指定副本界面 ]]
function BlackAndWhiteMainView:updateHighTeamDungeonInfo(id)
	local cfg = TabDataMgr:getData("HighTeamDungeon", id)
	print("id = " .. id)
	print("index=" .. id % 10)
	local index = id % 10
	

	local costItemId = 0
	local costNum = 0
	--设置数据
	--print("cfg.LevelDesc=" .. cfg.LevelDesc)
	self._uis[index][1]:setTextById(cfg.LevelDesc)
	
	if #table.keys(cfg.joinCost) > 0  then
		local key = table.keys(cfg.joinCost)[1]
		local value = cfg.joinCost[key]
		costItemId = key
		costNum = value
		self._uis[index][6]:setTextureNormal(GoodsDataMgr:getItemCfg(key).icon)
		self._uis[index][6]:setScale(0.3)
		self._uis[index][7]:setText(value)
		 self._uis[index][6]:onClick(function()
                Utils:showInfo(key, nil, true)
        end)
	end
	
	--设置道具
	--local itemIndex = 0
	--self._uis[index][8]:removeAllChildren()
	for i = 1, #cfg.showReward do
		--for j = 1, 3 do
		--dump()
		--local posX = 38 + (i-1)*110*0.4
		local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Scale(0.4)
        --Panel_goodsItem:setPosition(ccp(posX,40))
        self._uis[index][8]:pushBackCustomItem(Panel_goodsItem)
        PrefabDataMgr:setInfo(Panel_goodsItem, cfg.showReward[i], nil)
		--if i > #cfg.showReward then
		--	self._uis[index][7 + i]:setVisible(false)
		--else
		--	self._uis[index][7 + i]:setVisible(true)
			
		--	local itemId = cfg.showReward[i]
			--local itemCfg = GoodsDataMgr:getItemCfg(itemId);
			--self._uis[index][7 + i]:setTexture(EC_ItemIcon[itemCfg.quality])
			--local Image_icon = TFDirector:getChildByPath(self._uis[index][7 + i],"Image_item1");
			--Image_icon:setTexture(itemCfg.icon);
			--Image_icon:setScale(1)
			--self._uis[index][7 + i]:setScale(0.3)
		--end
	end
	
	local affixData = nil
	if cfg.affixID and cfg.affixID > 0 then 
		affixData = TabDataMgr:getData("MonsterAffix",cfg.affixID)
		
		self._uis[index][5]:setVisible(true)
		self._uis[index][5]:onClick(function()
			--print("---------------------------------------------" .. index)
			Utils:openView("osd.AffixPreviewLayer",{cfg.affixID})
		end)
	else
		self._uis[index][5]:setVisible(false)
	end
	
	for i = 1, 3 do
		if affixData then
			local affixIcon  = affixData["affixIcon"..tostring(i)]
			if affixIcon ~= null and affixIcon ~= ""  then 
				self._uis[index][1 + i]:setVisible(true)
				self._uis[index][1 + i]:setTexture(affixIcon)
				self._uis[index][1 + i]:setScale(0.25)
			else
				self._uis[index][1 + i]:setVisible(false)
			end
			
		else
			self._uis[index][1 + i]:setVisible(false)
		end
	end
	

	local firstLevelCfg = FubenDataMgr:getLevelCfg(id)
	local isPass = true
	for i in ipairs(firstLevelCfg.preLevelId) do
		local levelInfo = FubenDataMgr:getLevelInfo(firstLevelCfg.preLevelId[i])
		if nil == levelInfo or not levelInfo.win then
			isPass = false
			break
		end
	end	
	--print("firstLevelCfg.preLevelId=" .. firstLevelCfg.preLevelId)
	
	
	
	self._uis[index][10]:setVisible(not isPass)
	
	
	self._uis[index][9]:onClick(function()
		local _items = GoodsDataMgr:getItem()
		for k, v in pairs(_items) do
			for kk, vv in pairs(v) do
				print("========================================k=" .. k .. ",n=" .. vv.num)
			end
		end
		if costItemId > 0 then
			if GoodsDataMgr:getItemCount(costItemId, false) < costNum then
				print("costItemId=" .. costItemId)
				Utils:showTips(14110405)
				return
			end
		end
		
		if not isPass then
			Utils:showTips(2101814)
			return
		end
		
		
		--Utils:showTips(2100091)
		local items = GoodsDataMgr:getItem(costItemId)
		local id = 0
		for k, v in pairs(items) do
			id = k
		end
		print("cfg.type=" .. cfg.type .. ",cfg.id=" .. cfg.id .. ",costItemId=" .. id)
		local callback = function(visibleType,limitLv,isAutoMatch)
			TeamFightDataMgr:requestCreateTeam( cfg.type,cfg.id,visibleType,limitLv,isAutoMatch,id)
		end
		Utils:openView("teamFight.TeamRoomSettingView",true,cfg.type,callback)
	end)
	
	
	
	
end



return BlackAndWhiteMainView