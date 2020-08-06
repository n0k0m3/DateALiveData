local UserDefault = CCUserDefault:sharedUserDefault()
local FubenHalloweenLevelView = class("FubenHalloweenLevelView", BaseLayer)


function FubenHalloweenLevelView:checkPlotLevelEnabled(levelId)
	local enabled = false
    if self.levelPassState_[levelId] then
        enabled = true
    else
        local levelCfg = FubenDataMgr:getLevelCfg(levelId)
        preIsOpen = true
        local preLevelId = levelCfg.preLevelId
        for i, v in ipairs(preLevelId) do
            preIsOpen = preIsOpen and self.levelPassState_[v]
            if not preIsOpen then
                break
            end
        end
        levelIsOpen = MainPlayer:getPlayerLv() >= levelCfg.playerLv
        enabled = preIsOpen and levelIsOpen
    end
    return enabled
end

function FubenHalloweenLevelView:initData()
    self.chapterCid_ = EC_ActivityFubenType.HALLOWEEN
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)
    self.levelGroup_ = FubenDataMgr:getLevelGroup(self.chapterCid_)
	
	self.levelPassState_ = {}

	self.levelState_ = {}
	
	self.maxCount_ = 0
	self.passCount_ = 0
	self.taskGet_ = false
	self.gameGet_ = false
	
	local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
	if #activity > 0 then
		self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
		print("--------------------------------------------------------------------------------------------FubenHalloweenLevelView:initData")
		-- dump(self.activityInfo_)

		--统计关卡条目
		for i, v in ipairs(self.activityInfo_.items) do
			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
			if itemInfo.subType == EC_Activity_Assist_Subtype.LEVEL then
				local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
				local levelCid = itemInfo.extendData.jumpInterface 
				print("levelCid=" .. levelCid)
				self.maxCount_ = self.maxCount_ + 1
				if progressInfo.status == 1 then
					self.passCount_ = self.passCount_ + 1
				end
				--table.insert(self.level_, levelCid)
				self.levelPassState_[levelCid] = (progressInfo.status == 1)
				self.levelState_[levelCid] = progressInfo.status
				--Box(progressInfo.status)
			elseif itemInfo.subType == EC_Activity_Assist_Subtype.TASK then
				--table.insert(self.task_, v)
				print("TASK=" .. v)
			end
		end
		
		--统计任务完成
		for i, v in pairs(self.activityInfo_.extendData.sendDayAwardList) do
			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
			local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
			if not progressInfo.extend.rFlag and progressInfo.status == EC_TaskStatus.GET then
				--table.insert(self.task_, itemInfo)
				self.taskGet_ = true
				break
			end
		end	
		
		--统计小游戏
		for k,v in pairs(self.activityInfo_.extendData.speedLinkList) do
			local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType,v)
			local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
			--table.insert(self.boxTask,itemInfo)
			if  progressInfo.status == EC_TaskStatus.GET then
				--table.insert(self.task_, itemInfo)
				self.gameGet_ = true
				break
			end
		end
		
    else
        Utils:showTips(219007)
        --return
    end


    self.diffData_ = {
        [1] = {
            diff = EC_FBDiff.SIMPLE,
            color = ccc3(255, 255, 255),
            name = 300120,
            background = "ui/fuben/linkage/checkpoint/021.png",
            lineTextIds ={[1]=12030004,[12]=12030005,[18]=12030006,[26]=12030007},
            animation= "lanse"
        },
    }
	

    self.level_ = {}
    for _, levelGroupCid in ipairs(self.levelGroup_) do
        local diffLevel = self.level_[levelGroupCid] or {}
        for _, diffData in ipairs(self.diffData_) do
			local tbs =FubenDataMgr:getLevel(levelGroupCid, diffData.diff)
			table.sort(tbs, function ( a,b )
				return a < b
			end)
			diffLevel[diffData.diff] = tbs
        end

	
		
        self.level_[levelGroupCid] = diffLevel
    end
	
	print("level_==============================")
	-- dump(self.level_)
    self.linkageData  = clone(TabDataMgr:getData("DiscreteData",90003).data[3001])
    local t = self.linkageData.duration
    self.linkageData.sTime = os.time({year =t[1],month=t[2],day  =t[3], hour =t[4], min  =t[5],  sec  = 0})
    self.linkageData.eTime = os.time({year =t[6],month=t[7],day  =t[8], hour =t[9], min  =t[10],  sec  = 0})
end



function FubenHalloweenLevelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenHalloweenLevelView")
end

function FubenHalloweenLevelView:initUI(ui)
    self.super.initUI(self, ui)


    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_bg   = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Image_dot  = TFDirector:getChildByPath(self.Image_bg, "Image_dot")


    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.prefab_Item1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item")
    self.prefab_Item2 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item")
    self.prefab_Item3 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item")
    self.panel_page_controller  = TFDirector:getChildByPath(self.Panel_root, "Panel_page_controller")
 

    


    self.scrollView_wave = TFDirector:getChildByPath(self.Panel_root, "ScrollView_wave")

    local Panel_starReward = TFDirector:getChildByPath(self.Panel_root, "Panel_starReward")
    local Image_star_new = TFDirector:getChildByPath(Panel_starReward, "Image_star_new")
    self.Label_total_starnum = TFDirector:getChildByPath(Image_star_new, "Label_total_starnum")
    self.Label_get_starnum = TFDirector:getChildByPath(Image_star_new, "Label_get_starnum")
    self.Button_reward_receive = TFDirector:getChildByPath(Panel_starReward, "Button_reward_receive")

    self.Image_reward_redpoint = TFDirector:getChildByPath(self.Button_reward_receive, "Image_reward_redpoint")
    self.Button_reward_geted = TFDirector:getChildByPath(Panel_starReward, "Button_reward_geted")
    --章节名称
    local Image_chapterInfo = TFDirector:getChildByPath(self.Panel_root, "Image_chapterInfo")
    self.Label_chapterOrder = TFDirector:getChildByPath(Image_chapterInfo, "Label_chapterOrder")

    --难度选择
    self.Button_diff_select = TFDirector:getChildByPath(self.Panel_root, "Button_diff_select")
    self.Label_diff_select = TFDirector:getChildByPath(self.Button_diff_select, "Label_diff_select")
	
	
	
	
	self.Button_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(self.Panel_root, "Button_FubenHalloweenLevelView_1")
	self.Button_FubenHalloweenLevelView_2 = TFDirector:getChildByPath(self.Panel_root, "Button_FubenHalloweenLevelView_2")
	self.Button_FubenHalloweenLevelView_4 = TFDirector:getChildByPath(self.Panel_root, "Button_FubenHalloweenLevelView_4")
	self.Button_FubenHalloweenLevelView_5 = TFDirector:getChildByPath(self.Panel_root, "Button_FubenHalloweenLevelView_5")
	self.Button_FubenHalloweenLevelView_6 = TFDirector:getChildByPath(self.Panel_root, "Button_FubenHalloweenLevelView_6")
	
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_5, "Image_FubenHalloweenLevelView_1")
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1_Label_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1, "Label_FubenHalloweenLevelView_1")
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1_Label_FubenHalloweenLevelView_1:setTextById(12101040)
	
	
	self.Button_FubenHalloweenLevelView_1_Image_FubenHalloweenLevelView_tips = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_1, "Image_FubenHalloweenLevelView_tips")
	self.Button_FubenHalloweenLevelView_2_Image_FubenHalloweenLevelView_tips = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_2, "Image_FubenHalloweenLevelView_tips")
	self.Button_FubenHalloweenLevelView_4_Image_FubenHalloweenLevelView_tips = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_4, "Image_FubenHalloweenLevelView_tips")
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_tips = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_5, "Image_FubenHalloweenLevelView_tips")
	self.Button_FubenHalloweenLevelView_6_Image_FubenHalloweenLevelView_tips = TFDirector:getChildByPath(self.Button_FubenHalloweenLevelView_6, "Image_FubenHalloweenLevelView_tips")


	self.Label_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(self.Panel_root, "Label_FubenHalloweenLevelView_1")
	
	local Image_FubenHalloweenLevelView_3 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_3")
	self.Image_FubenHalloweenLevelView_3_Image_FubenHalloweenLevelView_4 = TFDirector:getChildByPath(Image_FubenHalloweenLevelView_3, "Image_FubenHalloweenLevelView_4")
	self.Image_FubenHalloweenLevelView_3_Label_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(Image_FubenHalloweenLevelView_3, "Label_FubenHalloweenLevelView_1")
	
	local Image_FubenHalloweenLevelView_4 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_4")
	self.Image_FubenHalloweenLevelView_4_Image_FubenHalloweenLevelView_4 = TFDirector:getChildByPath(Image_FubenHalloweenLevelView_4, "Image_FubenHalloweenLevelView_4_1")
	self.Image_FubenHalloweenLevelView_4_Label_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(Image_FubenHalloweenLevelView_4, "Label_FubenHalloweenLevelView_1")

	local Image_FubenHalloweenLevelView_5 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_5")
	local Image_FubenHalloweenLevelView_5_Label_FubenHalloweenLevelView_2 = TFDirector:getChildByPath(Image_FubenHalloweenLevelView_5, "Label_FubenHalloweenLevelView_2")
	Image_FubenHalloweenLevelView_5_Label_FubenHalloweenLevelView_2:setText(self.passCount_ .. "/" .. self.maxCount_)
	
	
	self. Image_FubenHalloweenLevelView_7 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_7")
	self.Image_FubenHalloweenLevelView_7_Label_FubenHalloweenLevelView_2 = TFDirector:getChildByPath(self.Image_FubenHalloweenLevelView_7, "Label_FubenHalloweenLevelView_2")
	
	self. Image_FubenHalloweenLevelView_6 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_6")
	self.Image_FubenHalloweenLevelView_6_Label_FubenHalloweenLevelView_2 = TFDirector:getChildByPath(self.Image_FubenHalloweenLevelView_6, "Label_FubenHalloweenLevelView_2")
	
	
	self.Image_FubenHalloweenLevelView_8 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_8")
	self.Image_FubenHalloweenLevelView_9 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_9")
	self.Image_FubenHalloweenLevelView_10 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_10")
	self.Image_FubenHalloweenLevelView_11 = TFDirector:getChildByPath(self.Panel_root, "Image_FubenHalloweenLevelView_11")
	
	
	
	self.Label_FubenHalloweenLevelView_1:setSkewX(15)
	self.Image_FubenHalloweenLevelView_3_Label_FubenHalloweenLevelView_1:setSkewX(15)
	self.Image_FubenHalloweenLevelView_4_Label_FubenHalloweenLevelView_1:setSkewX(15)
	self.Image_FubenHalloweenLevelView_7_Label_FubenHalloweenLevelView_2:setSkewX(15)
	self.Image_FubenHalloweenLevelView_6_Label_FubenHalloweenLevelView_2:setSkewX(15)
	Image_FubenHalloweenLevelView_5_Label_FubenHalloweenLevelView_2:setSkewX(15)
	
	
	self.newData_ = {
		[1] = {
            ui = self.Image_FubenHalloweenLevelView_8,
            levels = {[1] = 278101, [2] = 278102},
        },
		[2] = {
            ui = self.Image_FubenHalloweenLevelView_9,
            levels = {[1] = 278301, [2] = 278302, [3] = 278303, [4] = 278304},
        },
		[3] = {
            ui = self.Image_FubenHalloweenLevelView_10,
            levels = {[1] = 278401, [2] = 278402, [3] = 278403, [4] = 278404, [5] = 278405, [6] = 278406},
        },
		[4] = {
            ui = self.Image_FubenHalloweenLevelView_11,
            levels = {[1] = 278201, [2] = 278202, [3] = 278203},
        },
	}
	
	for i, v in ipairs(self.newData_) do
		local visible = false
		for ii, vv in ipairs(v.levels) do
			if self:checkPlotLevelEnabled(vv) and not self.levelPassState_[vv] then
				visible = true 
				break
			end
		end
		
		v.ui:setVisible(false)
	end
	
	

	ActivityDataMgr2:send_ACTIVITY_REQ_ACTIVITY_RANK(self.activityId_)
	
    self.diff_panels = {}
    for index = 1,1 do
        local checkpoint   = createUIByLuaNew("lua.uiconfig.fuben.Halloween_linkage_chapter")
        local Panel_lines  = TFDirector:getChildByPath(checkpoint, "Panel_lines")
        local Panel_levels = TFDirector:getChildByPath(checkpoint, "Panel_levels")
        checkpoint.levelNodes = {}
        checkpoint.lineNodes  = {}
        local nums = 16
        local diffData = self.diffData_[index]
        for i = 1 ,nums do
			
            local Panel_level = TFDirector:getChildByPath(Panel_levels, "Panel_level_"..i)
            Panel_level:setBackGroundColorType(TF_LAYOUT_COLOR_NONE)
            local node = self:createItem(Panel_level)
            checkpoint.levelNodes[i] = node
            local Image_line = TFDirector:getChildByPath(Panel_lines, "Image_line_"..i)
            if Image_line then
                --checkpoint.lineNodes[i] = Image_line:getChildByName("Image_active"):hide()
				checkpoint.lineNodes[i] = Image_line
            end
			
			
			--[[
            if diffData.lineTextIds[i] then 
                local Label_name = Panel_levels:getChildByName("Label_name_"..i)
                Label_name:setTextById(diffData.lineTextIds[i])
                local Label_lock = Label_name:getChildByName("Label_lock") --TODO 文字填充？
                node.LineNameLock= Label_lock  --直接在node 上存放引用方便更新锁定状态
            end
			]]
			
        end
        self.diff_panels[index] = checkpoint
        --添加
        self.scrollView_wave:addChild(checkpoint)
        local size = checkpoint:getSize() 
    	self.scrollView_wave:setInnerContainerSize(size)
    end

    local selectIndex = FubenHalloweenLevelView:getCacheSelectDiff()
    selectIndex = tonumber(selectIndex) or 1
    local lastPos = FubenDataMgr.__lastPos  --上一次停留的位置
    self:selectDiff(selectIndex,lastPos)
    self:refreshView()
	
	--print("self.activityInfo_.speedLinkOpen=" .. self.activityInfo_.extendData.speedLinkOpen)
	--print("self.activityInfo_.speedLinkOpen=" .. self.levelPassState_[self.activityInfo_.extendData.speedLinkOpen])
	dump(self.levelPassState_)
	local speedLinkOpen = self.activityInfo_.extendData.speedLinkOpen
	--local isOpen = self.levelPassState_[speedLinkOpen] and self.levelPassState_[speedLinkOpen] or false
	--print(tostring(self.levelPassState_[speedLinkOpen]))
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1:setVisible(false)
	
	--self.scrollView_wave:on
	----self.scrollView_wave:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_BOTH, 0.2, true, 50, 50)
	--self.scrollView_wave:scrollTo({x=-505,y=-405})
	--self:moveToLevel(1)
	

end


function FubenHalloweenLevelView:updateTips()
	self.Button_FubenHalloweenLevelView_1_Image_FubenHalloweenLevelView_tips:setVisible(self.taskGet_)
	self.Button_FubenHalloweenLevelView_2_Image_FubenHalloweenLevelView_tips:Hide()
	--self.Button_FubenHalloweenLevelView_3_Image_FubenHalloweenLevelView_tips:Hide()
	self.Button_FubenHalloweenLevelView_4_Image_FubenHalloweenLevelView_tips:Hide()
	self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_tips:setVisible(self.gameGet_ or GoodsDataMgr:getItemCount(501004, false) > 0)
	self.Button_FubenHalloweenLevelView_6_Image_FubenHalloweenLevelView_tips:Hide()
	
	
	
	
	
	
end


function FubenHalloweenLevelView:moveToLevel(index)
    --index = index or self.selectChapterIndex_
    local levelItem = self.selectPanel.levelNodes[index]
    if not levelItem then return end
    local ScrollView_content = self.scrollView_wave
    local innerContainer = ScrollView_content:getInnerContainer()

    local anchorPoint = ScrollView_content:getAnchorPoint()
    local innerSize = innerContainer:getSize()
	
    local contentSize = ScrollView_content:getSize()
    local center = ccp(contentSize.width * 0.5, contentSize.height * 0.5)
    local innerPos = innerContainer:getPosition()
    -- local minY = contentSize.height - innerSize.height
    local y_offset = math.min(0,contentSize.height - innerSize.height)
    local w_offset = math.min(0,contentSize.width - innerSize.width)

    local position = levelItem:getPosition()
    local wp = levelItem:getParent():convertToWorldSpaceAR(position)
    local np = innerContainer:convertToNodeSpaceAR(wp)
    -- local foo = ccpSub(innerPos, np)
    local dis = ccpSub(center , np)
    local percentX = 0
    if w_offset ~= 0 then
        percentX = dis.x * 100 / w_offset
    end
    local percentY = 0
    if y_offset ~= 0 then
        percentY = (100 - dis.y * 100 / y_offset)
    end
    percentX = math.max(0,percentX)
    percentX = math.min(100,percentX)
    percentY = math.max(0,percentY)
    percentY = math.min(100,percentY)
    ScrollView_content:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_BOTH, 0.2, true, percentX, percentY)
end


function FubenHalloweenLevelView:refreshPageControl()
    
end

function FubenHalloweenLevelView:refreshView()
    local ispass = FubenDataMgr:isPassPlotChapter(self.chapterCid_)
   -- self.Button_review:setVisible(ispass)

	--刷新道具
	local itemcfg = TabDataMgr:getData("Item", 501003)
	self.Image_FubenHalloweenLevelView_3_Image_FubenHalloweenLevelView_4:setTexture(itemcfg.icon)
	self.Image_FubenHalloweenLevelView_3_Label_FubenHalloweenLevelView_1:setText(GoodsDataMgr:getItemCount(501003, false))
	
	local itemcfg = TabDataMgr:getData("Item", 501002)
	self.Image_FubenHalloweenLevelView_4_Image_FubenHalloweenLevelView_4:setTexture(itemcfg.icon)
	self.Image_FubenHalloweenLevelView_4_Label_FubenHalloweenLevelView_1:setText(GoodsDataMgr:getItemCount(501002, false))
	
	--刷新剩余时间
	self:onCountDownPer()
	self:updateTips()
end
function FubenHalloweenLevelView:createItem(parent)
    local size = parent:getSize()
    local showSelect 
	--[[
    local prefab
    if size.height < 100 then 
        prefab = self.prefab_Item3
    elseif size.height > 200 then 
        prefab = self.prefab_Item2
    else
        prefab = self.prefab_Item1
        showSelect = true
    end
	]]

	local prefab = self.prefab_Item1
	
    local node = prefab:clone()
    node.showSelect = showSelect
	
    -----node.Panel_Item      = TFDirector:getChildByPath(node,"Panel_Item")
    -----node.Image_icon      = TFDirector:getChildByPath(node.Panel_Item,"Image_icon")
    -----node.Label_name      = TFDirector:getChildByPath(node.Panel_Item,"Label_name")
    -----node.Image_mask1     = TFDirector:getChildByPath(node,"Image_mask1")
    -----node.Image_star_actives = {}
    -----for i=1,3 do
    -----    node.Image_star_actives[i] = TFDirector:getChildByPath(node.Image_mask1,"Image_star_"..i..".Image_active")
    -----end
    -----node.Image_mask2     = TFDirector:getChildByPath(node,"Image_mask2")
    -----node.Image_star_active  = TFDirector:getChildByPath(node.Image_mask2,"Image_active")
    -----node.Image_lock_mask = TFDirector:getChildByPath(node,"Image_lock_mask")
	
	node.Image_FubenHalloweenLevelView_1      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_1")
	node.Image_FubenHalloweenLevelView_2      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_2")
	node.Image_FubenHalloweenLevelView_3      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_3")
	node.Image_FubenHalloweenLevelView_4      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_4")
	node.Image_FubenHalloweenLevelView_5      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_5")
	node.Image_FubenHalloweenLevelView_6      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_6")
	node.Image_FubenHalloweenLevelView_7      = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_7")
	node.Image_FubenHalloweenLevelView_8	  = TFDirector:getChildByPath(node,"Image_FubenHalloweenLevelView_8")
	node.Image_FubenHalloweenLevelView_8_Label_FubenHalloweenLevelView_1	  = TFDirector:getChildByPath(node.Image_FubenHalloweenLevelView_8,"Label_FubenHalloweenLevelView_1")
	
	node.Spine_FubenHalloweenLevelView_1 = TFDirector:getChildByPath(node,"Spine_FubenHalloweenLevelView_1")
	
	
    node:setPosition(ccp(size.width/2,size.height/2))
    parent:addChild(node)

    return node
end

function FubenHalloweenLevelView:onShow()
    self.super.onShow(self)
	--[[
    local lingageInfo = FubenDataMgr:getLinkageInfo()
    if lingageInfo then
        if not lingageInfo.CGCids or table.indexOf(lingageInfo.CGCids,self.chapterCid_) == -1 then 
            FunctionDataMgr:jStartDating(4101)
            FubenDataMgr:sendLinkageCG(self.chapterCid_)
        end
    end
	]]
	--Box("123")
	self:addCountDownTimer()
	self:initData()
	-- self:updateTips()
	self:refreshView()
end

function FubenHalloweenLevelView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenHalloweenLevelView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
		self.countDownTimer_ = nil
    end
end

function FubenHalloweenLevelView:onCountDownPer()
    --print("刷新倒计时")
	local serverTime = ServerDataMgr:getServerTime()
	local endTime = self.activityInfo_.showEndTime
	local remaining = endTime - serverTime
	local day,hour,min,sec = Utils:getTimeDHMZ( remaining > 0 and remaining or 0)
	--dump(self.activityInfo_.showEndTime)
	
	self.Label_FubenHalloweenLevelView_1:setText("剩余" .. day .. "天" .. hour .. "时")
	
end

function FubenHalloweenLevelView:updateDiffShowInfo()
    for i, v in ipairs(self.Button_diff) do
        local diffData = self.diffData_[i]
        local text = TextDataMgr:getText(diffData.name)
        v.Label_diff:setTextById(300123, text)
        v.Label_diff:setFontColor(diffData.color)
    end
end

function FubenHalloweenLevelView:updateStartRewardState()
    local diffData = self.diffData_[self.selectDiffIndex_]
    local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(self.chapterCid_, diffData.diff)
end


function FubenHalloweenLevelView:selectDiff(index,lastPos)
    local diffData = self.diffData_[index]
 
    local enabled = FubenDataMgr:checkPlotChapterEnabled(self.chapterCid_, diffData.diff)
    if not enabled then
        local firstLevelCid = FubenDataMgr:getChapterFirstLevel(self.chapterCid_, diffData.diff)
        local firstLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCid)
        local count = #firstLevelCfg.preLevelId
        if count == 1 then
            local levelName = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[1])
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[1])
            local diffData = self.diffData_[preLevelCfg.difficulty]
            local diffName = TextDataMgr:getText(diffData.name)
            Utils:showTips(300004, diffName .. levelName)
        elseif count == 2 then
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[1])
            local diffData = self.diffData_[preLevelCfg.difficulty]
            local diffName = TextDataMgr:getText(diffData.name)
            local levelName1 = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[1])
            levelName1 = diffName .. levelName1
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[2])
            local diffData = self.diffData_[preLevelCfg.difficulty]
            local diffName = TextDataMgr:getText(diffData.name)
            local levelName2 = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[2])
            levelName2 = diffName .. levelName2
            Utils:showTips(300005, levelName1, levelName2)
        end
        return
    end

    if self.selectDiffIndex_  == index then 
        return
    end
    if self.selectDiffIndex_ then
        local _diffData = self.diffData_[self.selectDiffIndex_]
        if _diffData then 
            self.Image_dot:setTexture(_diffData.background)
            self.Image_dot:setOpacity(255)
        end
    end
    self.Image_dot:fadeOut(0.5)
    self.selectDiffIndex_ = index
    self:cacheSelectDiff(self.selectDiffIndex_)
    local diffData = self.diffData_[self.selectDiffIndex_]
    local text = TextDataMgr:getText(diffData.name)
   -- self.Image_bg:setTexture(diffData.background)
   
    -- 通关星数
    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(self.chapterCid_, diffData.diff)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(self.chapterCid_, diffData.diff)
    
    self:updateStartRewardState()
    -- 关卡刷新
    for i, panel in ipairs(self.diff_panels) do
        panel:setVisible(i== self.selectDiffIndex_)
    end
    self.selectPanel =self.diff_panels[self.selectDiffIndex_]
	
	
	
    local size = self.scrollView_wave:getInnerContainerSize()
	if self.passCount_ == 0 then
		self.scrollView_wave:setInertiaScrollEnabled(false)
	else
		self.scrollView_wave:setInertiaScrollEnabled(true)
	end
    size.width = self.selectPanel:getSize().width 
    self.scrollView_wave:setInnerContainerSize(size)
	
	local _size =  self.scrollView_wave:getSize() 
	_size.width = GameConfig.WS.width 
	self.scrollView_wave:setSize(_size)
	self.scrollView_wave:setPositionX(-_size.width/2)
	--Box(_size.height)

    local levels = self.level_[self.levelGroup_[1]][self.selectDiffIndex_]
    -----self.spine_select:hide()

    for i, v in ipairs(levels) do		
        self:updateLevelItem(i,v)
    end
	
	
	--判断是否有需要聚焦的新解锁关卡
	local oldlevelPassState_ = FubenDataMgr.oldlevelPassState_
	local focusingLevelId = -1
	if oldlevelPassState_ then
		for k , v in pairs(self.levelPassState_) do
			if v ~= oldlevelPassState_[k] then
				local halloweendungeon = TabDataMgr:getData("HalloweenDungeon", k)
				if halloweendungeon.isFollow then
					focusingLevelId = k
					break
				end
			end
		end
	end
	
	--查找新解锁关卡对应的index
	local moveToLevel_ = 1
	for i, v in ipairs(levels) do		
		if v == focusingLevelId then
			--moveToLevel_ = i
			break
		end
    end
	
	
	
	
    --滚动到指定位置
	if lastPos then
		--Box("lastPos==")
		dump(lastPos)
		self:autoScroll(lastPos)
		-- Box("1")
	else
		--Box("moveToLevel_==")
		self:moveToLevel(moveToLevel_)
		-- Box("2")
	end

	FubenDataMgr.oldlevelPassState_ = self.levelPassState_
end

function FubenHalloweenLevelView:autoScroll(lastPos)
	if lastPos then
		self.scrollView_wave:setContentOffset(lastPos,0.5)
	end
end
local temp      = 0
local positon_x = {0 -temp , 1723 - 100 -temp,2863 -100 -temp ,3991 -100 -temp}
function FubenHalloweenLevelView:onScrollingEvent(event)
    local offset = self.scrollView_wave:getContentOffset()
	dump(offset)
    FubenDataMgr.__lastPos = offset
end

function FubenHalloweenLevelView:scrollTo(index)

    if self.pageIndex == index then
        return
    end
    self.pageIndex = index
    for i,node in ipairs(self.pageNodes) do
        node.Image_select:setVisible(node.index_ == index)
    end
    local width   = self.scrollView_wave:getInnerContainerSize().width
    width = width - self.scrollView_wave:getSize().width
    local percet = math.floor(positon_x[index]*100 / width)
    percet = math.max(math.min(percet,100),0)
    self.scrollView_wave:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0.5, true, -percet, 0)

end
function FubenHalloweenLevelView:updateLevelItem(i, levelCid)
	--Box("i=" .. i .. ", levelCid=" .. levelCid)
	local cfg = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen = self:checkPlotLevelEnabled(levelCid)
	
	local node     = self.selectPanel.levelNodes[i]
	local lineNode = self.selectPanel.lineNodes[i]
	--是否解锁
	if not enabled then
		node:hide()
		if lineNode then
			lineNode:hide()
		end
	else
		--Box("i=" .. i .. ", levelCid=" .. levelCid)
		node:show()
		if lineNode then
			lineNode:show()
		end
		
		--是否完成
		node.Image_FubenHalloweenLevelView_7:setVisible(self.levelPassState_[levelCid])
		node.Image_FubenHalloweenLevelView_8_Label_FubenHalloweenLevelView_1:setTextById(cfg.name)
		
		node.Image_FubenHalloweenLevelView_3:setTexture(cfg.icon)
		node.Image_FubenHalloweenLevelView_6:Hide()
		
		local halloweendungeon = TabDataMgr:getData("HalloweenDungeon", levelCid)
		if halloweendungeon.icon2 ~= "" then
			--Box(halloweendungeon.icon2)
			node.Image_FubenHalloweenLevelView_5:Show()
			node.Image_FubenHalloweenLevelView_5:setTexture(halloweendungeon.icon2 .. ".png")
		else
			node.Image_FubenHalloweenLevelView_5:Hide()
		end	
		
		
		
		if self.levelState_[levelCid] == 0 then
			node.Spine_FubenHalloweenLevelView_1:Show()
			node.Spine_FubenHalloweenLevelView_1:play("playdown", -1)
		else
			node.Spine_FubenHalloweenLevelView_1:Hide()
		end
	
		
		--node.Image_FubenHalloweenLevelView_5:setTexture(halloweendungeon.unlockLine .. ".png")
		--node.Image_FubenHalloweenLevelView_6:Hide()
		--local icon = halloweendungeon.icon2
		--if icon and  string.find(icon, ".png") < 1 then
		--icon = icon .. ".png"
		--end
		--print("icon=" .. icon)
		
		--node.Image_FubenHalloweenLevelView_6:setTexture(icon)
		
		node:onClick(function()	
			print("cfg.enterConditon=" .. cfg.enterConditon[1])
			local enter_ = Utils:getTimeByDate(cfg.enterConditon[1])
			local server_ = ServerDataMgr:getServerTime()
			if enter_ <= server_ then
				Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_, levelCid, self.maxmyScore)
			else
				--local date_ = Utils:changStrToDate(cfg.enterConditon[1])
				Utils:showTips(12101061, cfg.enterConditon[1])
			end
			--cfg.enterConditon
			--dump(cfg)
			--Box("self.chapterCid_=" .. self.chapterCid_)
			--Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_, levelCid, self.maxmyScore)
			--if ServerDataMgr:getServerTime() < self.linkageData.eTime then 
			--    local levelCid = targetNode.levelId
			--    Utils:openView("fuben.FubenReadyView", levelCid)
			--else
			--    Utils:showTips(300877)
			--end 
		end)
	end	
	
	
	--node.Image_FubenHalloweenLevelView_3:setTexture(cfg.icon)
	--node.Image_FubenHalloweenLevelView_5:hide()
	--node.Image_FubenHalloweenLevelView_6:hide()
	--node.Image_FubenHalloweenLevelView_7:hide()
	
	
	--node:onClick(function()
		--Box("self.chapterCid_=" .. self.chapterCid_)
		--Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_, levelCid)
        --if ServerDataMgr:getServerTime() < self.linkageData.eTime then 
        --    local levelCid = targetNode.levelId
        --    Utils:openView("fuben.FubenReadyView", levelCid)
        --else
        --    Utils:showTips(300877)
        --end 
    --end)
	--[[
    local cfg = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)

    local levelInfo = FubenDataMgr:getLevelInfo(levelCid)
    local node     = self.selectPanel.levelNodes[i]
    local lineNode = self.selectPanel.lineNodes[i]
    node.Label_name:setTextById(cfg.name)
    node.levelId = levelCid
    if node.Image_icon then
        node.Image_icon:setTexture(cfg.icon)
    end
    local starNum = FubenDataMgr:getStarNum(levelCid)
    if cfg.dungeonType == 9 then --约会
        node.Image_mask2:show()
        node.Image_mask1:hide()

        if node.Image_star_active then
            node.Image_star_active:setVisible(starNum > 0) 
        end
    else
        node.Image_mask1:show()
        node.Image_mask2:hide()

        for i,v in ipairs(node.Image_star_actives) do
            v:setVisible(starNum >= i)
        end

    end
    --是否解锁

    if enabled then
        node.Panel_Item:setOpacity(255)
        node.Image_lock_mask:hide()
    else
        node.Panel_Item:setOpacity(200)
        node.Image_lock_mask:show()
    end
    if lineNode then 
        lineNode:setVisible(enabled)
    end
    if node.LineNameLock then 
        node.LineNameLock:setVisible(not enabled)
    end
    node:setTouchEnabled(enabled)
    node:onClick(function(targetNode)
        if ServerDataMgr:getServerTime() < self.linkageData.eTime then 
            local levelCid = targetNode.levelId
            Utils:openView("fuben.FubenReadyView", levelCid)
        else
            Utils:showTips(300877)
        end 
    end)
    if node.showSelect then 
        local pass = FubenDataMgr:isPassPlotLevel(levelCid)
        if enabled and not pass then 
            -----self.spine_select:retain()
            -----self.spine_select:removeFromParent()
            -----node:addChild(self.spine_select,-1)
			-----self.spine_select:setPosition(ccp(0,0))
            -----self.spine_select:release()
            -----self.spine_select:show()
        end
    end
    return enabled
	]]
end

function FubenHalloweenLevelView:removeEvents()
    self:removeCountDownTimer()
end

function FubenHalloweenLevelView:onSubmitSuccessEvent(activitId, itemId, reward)
    --local model = self.activityModel_[activitId]
    --if model and model.onSubmitSuccessEvent then
    --    model:onSubmitSuccessEvent(activitId, itemId, reward)
    --end
	if activitId == self.activityId_ then
		Utils:showReward(reward)
	end
end

function FubenHalloweenLevelView:registerEvents()
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, function ( ... )
			self:initData()
			self:updateTips()
		end)
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))
    self.scrollView_wave:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.onScrollingEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
	
	EventMgr:addEventListener(self, EV_ACTIVITY_MORE_RANK, function ( data )
		
		print("--------EV_ACTIVITY_MORE_RANK")
		-- dump(data)
		--Box("1")
    	--self.rankData = data
		--self:updateView()
		self.maxmyScore = data.myScore
		if data.myScore < 0 then
			self.Image_FubenHalloweenLevelView_6:Hide()
			self.Image_FubenHalloweenLevelView_7:Hide()
			return
		end
		
		self.Image_FubenHalloweenLevelView_6:Show()
		self.Image_FubenHalloweenLevelView_7:Show()
		if data.myScore < 0 then
			self.Image_FubenHalloweenLevelView_6_Label_FubenHalloweenLevelView_2:setText("100:34")
		else
			local d, hour, min, sec = Utils:getTimeDHMZ(data.myScore < 0 and 0 or data.myScore * 0.001,true)
			self.Image_FubenHalloweenLevelView_6_Label_FubenHalloweenLevelView_2:setText(min..":"..sec)
		end
		self.Image_FubenHalloweenLevelView_7_Label_FubenHalloweenLevelView_2:setText(data.myRank < 0 and "未上榜" or data.myRank)
    end)

	self.Button_FubenHalloweenLevelView_1:onClick(function()
		Utils:openView("halloween.HalloweenTaskView", self.activityId_)
    end)
	
	self.Button_FubenHalloweenLevelView_2:onClick(function()
		Utils:openView("halloween.HalloweenRankView", self.activityId_)
    end)
	
	self.Button_FubenHalloweenLevelView_4:onClick(function()
		Utils:openView("halloween.HalloweenBuffView", self.activityId_)
    end)
	
	self.Button_FubenHalloweenLevelView_5:onClick(function()
		if self.Button_FubenHalloweenLevelView_5_Image_FubenHalloweenLevelView_1:isVisible() then
			Utils:showTips(12101039)
		else
			Utils:openView("halloween.HalloweenGameView", self.activityId_)
		end
		
    end)
	
	self.Button_FubenHalloweenLevelView_6:onClick(function()
		--Utils:openView("halloween.HalloweenTaskView", self.activityId_)
		--FunctionDataMgr:jActivityByType(EC_ActivityType2.STORE)
		FunctionDataMgr:jActivity(10026)
    end)
	
	--[[
    for i,node in ipairs(self.pageNodes) do
        node:setTouchEnabled(true)
        node:onClick(function(target)
                self:scrollTo(target.index_)
            end)
    end
	]]
	--[[
    self.Button_diff_select:onClick(function()
            local visible = self.Panel_diff:isVisible()
            self.Panel_diff:setVisible(not visible)
    end)
	]]
	--[[
    self.Button_reward_receive:onClick(function()
            local diffData = self.diffData_[self.selectDiffIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)
	]]
	--[[
    self.Button_reward_geted:onClick(function()
            local diffData  = self.diffData_[self.selectDiffIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)
]]
--[[
    self.Button_review:onClick(function()
        FunctionDataMgr:jStartDating(4110)
    end)
	]]
--[[
    for i, v in ipairs(self.Button_diff) do
        v.root:onClick(function()
                self:selectDiff(i)
                self.Panel_diff:hide()
        end)
    end
	]]
	EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateTopbar, self))
    EventMgr:addEventListener(self, EV_UPDATE_RESOURCE, handler(self.updateTopbar, self))
end

function FubenHalloweenLevelView:updateItemCount()
	self:refreshView()
end

function FubenHalloweenLevelView:onGetLevelGroupRewardEvent()
    self:updateStartRewardState()
end
local  key_linkage_select_diff = "key_%s_linkage_select_diff_halloween"
function FubenHalloweenLevelView:cacheSelectDiff(diff)
    local key = string.format(key_linkage_select_diff, MainPlayer:getPlayerId())
    UserDefault:setStringForKey(key, tostring(diff))
    dump({"cache diff",diff})
end

function FubenHalloweenLevelView:getCacheSelectDiff()
    local key = string.format(key_linkage_select_diff, MainPlayer:getPlayerId())
        dump({"get cache diff",UserDefault:getStringForKey(key)})
    return UserDefault:getStringForKey(key)
end

return FubenHalloweenLevelView
