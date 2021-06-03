local UserDefault = CCUserDefault:sharedUserDefault()
local LinkageView = class("LinkageView", BaseLayer)

function LinkageView:initData(chapterCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)
    self.levelGroup_ = FubenDataMgr:getLevelGroup(self.chapterCid_)

--[[    dump(self.chapterCfg_)
    dump(self.levelGroup_)--]]
    self.diffData_ = {
        [1] = {
            diff = EC_FBDiff.SIMPLE,
            color = ccc3(255, 255, 255),
            name = 300120,
            background = "ui/fuben/linkage/checkpoint/021.png",
            lineTextIds ={[1]=12030004,[12]=12030005,[18]=12030006,[26]=12030007},
            animation= "lanse"
        },
        [2] = {
            diff  = EC_FBDiff.HARD,
            color =  ccc3(112, 143, 255),
            name  = 300121,
            background = "ui/fuben/linkage/checkpoint/022.png",
            lineTextIds={[1]=12030008},
            animation= "zise"
        },
    }

    self.level_ = {}
    for _, levelGroupCid in ipairs(self.levelGroup_) do
        local diffLevel = self.level_[levelGroupCid] or {}
        for _, diffData in ipairs(self.diffData_) do
            diffLevel[diffData.diff] = FubenDataMgr:getLevel(levelGroupCid, diffData.diff)
        end
        self.level_[levelGroupCid] = diffLevel
    end
    self.linkageData  = clone(TabDataMgr:getData("DiscreteData",90003).data[3001])
    local t = self.linkageData.duration
    self.linkageData.sTime = os.time({year =t[1],month=t[2],day  =t[3], hour =t[4], min  =t[5],  sec  = 0})
    self.linkageData.eTime = os.time({year =t[6],month=t[7],day  =t[8], hour =t[9], min  =t[10],  sec  = 0})
end



function LinkageView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.linkageView")
end

function LinkageView:initUI(ui)
    self.super.initUI(self, ui)
    -- self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Image_bg   = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.Image_dot  = TFDirector:getChildByPath(self.Image_bg, "Image_dot")
    self.spine_back_effect  = TFDirector:getChildByPath(self.Panel_root, "Spine_back_effect")


    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.spine_select = TFDirector:getChildByPath(self.Panel_prefab, "Spine_select")

    self.prefab_Item1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item1")
    self.prefab_Item2 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item2")
    self.prefab_Item3 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_Item3")
    self.panel_page_controller  = TFDirector:getChildByPath(self.Panel_root, "Panel_page_controller")

    self.pageNodes = {}
    for i=1,4 do
        self.pageNodes[i] = TFDirector:getChildByPath(self.panel_page_controller, "Image_page"..i)
        self.pageNodes[i].Image_select = TFDirector:getChildByPath(self.pageNodes[i], "Image_select")
        self.pageNodes[i].index_ = i
    end 
 
    self.Panel_role   = TFDirector:getChildByPath(self.Panel_root, "Panel_role")
    self.Image_roles  = {} 
    for i=1,2 do
        self.Image_roles[i] = TFDirector:getChildByPath(self.Panel_role, "Image_role"..i):hide()
    end
    
    self.Image_role2   = TFDirector:getChildByPath(self.Panel_role, "Image_role2"):hide()
    -- local act1 =  FadeIn:create(0.5)
    -- local act2 = FadeOut:create(0.5)
    self.Panel_role:runAction(RepeatForever:create(CCSequence:create({FadeIn:create(2), FadeOut:create(2)})))

    self.scrollView_wave = TFDirector:getChildByPath(self.Panel_root, "ScrollView_wave")

    local Panel_starReward = TFDirector:getChildByPath(self.Panel_root, "Panel_starReward")
    local Image_star_new = TFDirector:getChildByPath(Panel_starReward, "Image_star_new")
    self.Label_total_starnum = TFDirector:getChildByPath(Image_star_new, "Label_total_starnum")
    self.Label_get_starnum = TFDirector:getChildByPath(Image_star_new, "Label_get_starnum")
    self.Label_slash = TFDirector:getChildByPath(Image_star_new, "Label_slash")
    self.Label_slash:setTextById(800039)
    self.Button_reward_receive = TFDirector:getChildByPath(Panel_starReward, "Button_reward_receive")
    -- self.Spine_reward_receive = TFDirector:getChildByPath(self.Button_reward_receive, "Spine_reward_receive")
    self.Image_reward_redpoint = TFDirector:getChildByPath(self.Button_reward_receive, "Image_reward_redpoint")
    self.Button_reward_geted = TFDirector:getChildByPath(Panel_starReward, "Button_reward_geted")
    --章节名称
    local Image_chapterInfo = TFDirector:getChildByPath(self.Panel_root, "Image_chapterInfo")
    self.Label_chapterOrder = TFDirector:getChildByPath(Image_chapterInfo, "Label_chapterOrder")
    self.Label_chapterName = TFDirector:getChildByPath(Image_chapterInfo, "Label_chapterName")

    self.Label_chapterOrder:setTextById(300200 , TextDataMgr:getText(300201))
    --章节名称
    self.Label_chapterName:setTextById(tonumber(self.chapterCfg_.name))

    --难度选择
    self.Button_diff_select = TFDirector:getChildByPath(self.Panel_root, "Button_diff_select")
    self.Label_diff_select = TFDirector:getChildByPath(self.Button_diff_select, "Label_diff_select")
    self.Panel_diff = TFDirector:getChildByPath(self.Panel_root, "Panel_diff"):hide()
    self.Button_diff = {}
    for i = 1, 3 do
        local diffData = self.diffData_[i]
        local item = {}
        item.root       = TFDirector:getChildByPath(self.Panel_diff, "Button_diff_" .. i)
        item.Label_diff = TFDirector:getChildByPath(item.root, "Label_diff")
        if diffData then 
            item.root:show()
            local text = TextDataMgr:getText(diffData.name)
            item.Label_diff:setTextById(300123, text)
            item.Label_diff:setFontColor(diffData.color)
            self.Button_diff[i] = item
        else
            item.root:hide()
        end
    end

    self.Button_review = TFDirector:getChildByPath(self.Panel_root, "Button_review")
    self.Button_review:setPositionX(self.Button_review:getPositionX() + 50)
    -- self:refreshView()

    self.diff_panels = {}
    for index = 1,2 do
        local checkpoint   = createUIByLuaNew("lua.uiconfig.fuben.linkage_chapter_"..index)
        local Panel_lines  = TFDirector:getChildByPath(checkpoint, "Panel_lines")
        local Panel_levels = TFDirector:getChildByPath(checkpoint, "Panel_levels")
        checkpoint.levelNodes = {}
        checkpoint.lineNodes  = {}
        local nums = index == 1 and 36 or 9 --
        local diffData = self.diffData_[index]
        for i = 1 ,nums do
            local Panel_level = TFDirector:getChildByPath(Panel_levels, "Panel_level_"..i)
            Panel_level:setBackGroundColorType(TF_LAYOUT_COLOR_NONE)
            local node = self:createItem(Panel_level)
            checkpoint.levelNodes[i] = node
            local Image_line = TFDirector:getChildByPath(Panel_lines, "Image_line_"..i)
            if Image_line then
                checkpoint.lineNodes[i] = Image_line:getChildByName("Image_active"):hide()
            end
            if diffData.lineTextIds[i] then 
                local Label_name = Panel_levels:getChildByName("Label_name_"..i)
                Label_name:setTextById(diffData.lineTextIds[i])
                local Label_lock = Label_name:getChildByName("Label_lock") --TODO 文字填充？
                -- local Image_lock = Label_lock:getChildByName("Image_lock")
                node.LineNameLock= Label_lock  --直接在node 上存放引用方便更新锁定状态
            end
        end
        self.diff_panels[index] = checkpoint
        --添加
        self.scrollView_wave:addChild(checkpoint)
    end

    local selectIndex = LinkageView:getCacheSelectDiff()
    selectIndex = tonumber(selectIndex) or 1
    local lastPos = FubenDataMgr._lastPos  --上一次停留的位置
    self:selectDiff(selectIndex,lastPos)
    self:refreshView()
end
function LinkageView:refreshPageControl()
    
end

function LinkageView:refreshView()
    local ispass = FubenDataMgr:isPassPlotChapter(self.chapterCid_)
    self.Button_review:setVisible(ispass)
end
function LinkageView:createItem(parent)
    local size = parent:getSize()
    -- dump(size)
    local showSelect 
    local prefab
    if size.height < 100 then 
        prefab = self.prefab_Item3
    elseif size.height > 200 then 
        prefab = self.prefab_Item2
    else
        prefab = self.prefab_Item1
        showSelect = true
    end
    local node = prefab:clone()
    node.showSelect = showSelect
    node.Panel_Item      = TFDirector:getChildByPath(node,"Panel_Item")
    node.Image_icon      = TFDirector:getChildByPath(node.Panel_Item,"Image_icon")
    node.Label_name      = TFDirector:getChildByPath(node.Panel_Item,"Label_name")
    node.Image_mask1     = TFDirector:getChildByPath(node,"Image_mask1")
    node.Image_star_actives = {}
    for i=1,3 do
        node.Image_star_actives[i] = TFDirector:getChildByPath(node.Image_mask1,"Image_star_"..i..".Image_active")
    end
    node.Image_mask2     = TFDirector:getChildByPath(node,"Image_mask2")
    node.Image_star_active  = TFDirector:getChildByPath(node.Image_mask2,"Image_active")
    node.Image_lock_mask = TFDirector:getChildByPath(node,"Image_lock_mask")
    node:setPosition(ccp(size.width/2,size.height/2))
    parent:addChild(node)

    return node
end

function LinkageView:onShow()
    self.super.onShow(self)
    local lingageInfo = FubenDataMgr:getLinkageInfo()
    if lingageInfo then
        if not lingageInfo.CGCids or table.indexOf(lingageInfo.CGCids,self.chapterCid_) == -1 then 
            FunctionDataMgr:jStartDating(4101)
            FubenDataMgr:sendLinkageCG(self.chapterCid_)
        end
    end
end
function LinkageView:updateDiffShowInfo()
    for i, v in ipairs(self.Button_diff) do
        local diffData = self.diffData_[i]
        local text = TextDataMgr:getText(diffData.name)
        v.Label_diff:setTextById(300123, text)
        v.Label_diff:setFontColor(diffData.color)
    end
end

function LinkageView:updateStartRewardState()
    local diffData = self.diffData_[self.selectDiffIndex_]
    local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(self.chapterCid_, diffData.diff)
    self.Image_reward_redpoint:setVisible(isCanReceive)
    self.Button_reward_geted:setVisible(not isCanReceive and isReceiveAll)
    self.Button_reward_receive:setVisible(isCanReceive or not isReceiveAll)
end

-- function FubenLevelView:showPopView()
--     -- self:timeOut(function()
--     --         local chapterCid = FubenDataMgr:getUnlockNextChapterCid()
--     --         local view = AlertManager:getStashView("lua.logic.common.LevelUpView")
--     --         dump(tobool(view))
--     --         if view then
--     --             AlertManager:showStashView("lua.logic.common.LevelUpView")
--     --         else
--     --             FunctionDataMgr:showOpenFunc()
--     --         end
--     --         if chapterCid then
--     --             Utils:openView("fuben.FubenChapterPassView", chapterCid)
--     --             FubenDataMgr:setUnlockNextChapterCid(nil)
--     --         end
--     -- end, 0)
-- end

function LinkageView:selectDiff(index,lastPos)
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
    --ZB
    if self.selectDiffIndex_ then
        local _diffData = self.diffData_[self.selectDiffIndex_]
        if _diffData then 
            self.Image_dot:setTexture(_diffData.background)
            self.Image_dot:setOpacity(255)
        end
    end
    self.Image_dot:fadeOut(0.5)
    self.selectDiffIndex_ = index
    self.panel_page_controller:setVisible(index == 1)
    self:cacheSelectDiff(self.selectDiffIndex_)
    local diffData = self.diffData_[self.selectDiffIndex_]
    local text = TextDataMgr:getText(diffData.name)
    self.Label_diff_select:setTextById(300123, text)
    self.Label_diff_select:setFontColor(diffData.color)
    self.Image_bg:setTexture(diffData.background)
    self.spine_back_effect:play(diffData.animation,1)
    --立绘刷新
    for i,Image_role in ipairs(self.Image_roles) do
      Image_role:setVisible(i == self.selectDiffIndex_)
    end
    -- 通关星数
    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(self.chapterCid_, diffData.diff)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(self.chapterCid_, diffData.diff)
    self.Label_total_starnum:setText(totalFightStarNum)
    self.Label_get_starnum:setText(fightStarNum)
    self:updateStartRewardState()
    -- 关卡刷新
    for i, panel in ipairs(self.diff_panels) do
        panel:setVisible(i== self.selectDiffIndex_)
    end
    self.selectPanel =self.diff_panels[self.selectDiffIndex_]
    local size = self.scrollView_wave:getInnerContainerSize()
    size.width = self.selectPanel:getSize().width 
    self.scrollView_wave:setInnerContainerSize(size)

    -- local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(self.chapterCid_, diffData.diff)

    local levels = self.level_[self.levelGroup_[1]][self.selectDiffIndex_]
    -- dump(levels)
    self.spine_select:hide()
    for i, v in ipairs(levels) do
        self:updateLevelItem(i,v)
    end
    --滚动到指定位置
    self:autoScroll(lastPos)
    self:onScrollingEvent()
end

function LinkageView:autoScroll(lastPos)
    local levels = self.level_[self.levelGroup_[1]][self.selectDiffIndex_]
    local positon
    local levelCount = #levels
    for i,v in ipairs(levels) do
        local enable = FubenDataMgr:checkPlotLevelEnabled(v)
        local pass   = FubenDataMgr:isPassPlotLevel(v)
        -- if not positon then 
            if enable and not pass then 
                local node = self.selectPanel.levelNodes[i]
                positon = node:getParent():getPosition()
            end
        -- end
    end
    --自动跳转
    if positon then
        -- dump({"autoscroll",positon})
        local width   = self.scrollView_wave:getInnerContainerSize().width
        local width_  = self.scrollView_wave:getSize().width
        width = width - width_
        local percet = math.floor((positon.x + 50 - width_*0.5)*100 / width)
        percet = math.max(math.min(percet,100),0)
        -- dump({"percet",percet})
        -- self.scrollView_wave:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, 0, false, -percet, 0)
        self.scrollView_wave:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, -percet, 0)
    elseif lastPos then 
        self.scrollView_wave:setContentOffset(lastPos,0)
    end
end
local temp      = 0
local positon_x = {0 -temp , 1723 - 100 -temp,2863 -100 -temp ,3991 -100 -temp}
function LinkageView:onScrollingEvent(event)
    if not self.panel_page_controller:isVisible() then 
        return
    end
    local offset = self.scrollView_wave:getContentOffset()
    local selectIndex = 1
    for i = 4,1,-1 do
        local value = positon_x[i] -50
        if offset.x <= -value then 
            selectIndex = i
            break
        end
    end
    if self.pageIndex ~= selectIndex then
        for i,node in ipairs(self.pageNodes) do
            node.Image_select:setVisible(node.index_ == selectIndex)
        end
        self.pageIndex = selectIndex
    end
    FubenDataMgr._lastPos = offset
end

function LinkageView:scrollTo(index)
            -- Box("selecltIndex:"..tostring(target.index_))
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
function LinkageView:updateLevelItem(i, levelCid)
    local cfg = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)
    -- dump({levelCid,enabled, preIsOpen, levelIsOpen})
    local levelInfo = FubenDataMgr:getLevelInfo(levelCid)
    -- local levelTypeData = self.levelTypeData_[cfg.dungeonType]
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
        -- dump(targetNode.levelId)
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
            self.spine_select:retain()
            self.spine_select:removeFromParent()
            node:addChild(self.spine_select,-1)
            self.spine_select:setPosition(ccp(0,0))
            self.spine_select:release()
            self.spine_select:show()
        end
    end
    return enabled
end

function LinkageView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))
    self.scrollView_wave:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.onScrollingEvent, self))
    for i,node in ipairs(self.pageNodes) do
        node:setTouchEnabled(true)
        node:onClick(function(target)
                self:scrollTo(target.index_)
            end)
    end
    self.Button_diff_select:onClick(function()
            local visible = self.Panel_diff:isVisible()
            self.Panel_diff:setVisible(not visible)
    end)

    self.Button_reward_receive:onClick(function()
            local diffData = self.diffData_[self.selectDiffIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)

    self.Button_reward_geted:onClick(function()
            local diffData  = self.diffData_[self.selectDiffIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)

    self.Button_review:onClick(function()
        FunctionDataMgr:jStartDating(4110)
    end)

    for i, v in ipairs(self.Button_diff) do
        v.root:onClick(function()
                self:selectDiff(i)
                self.Panel_diff:hide()
        end)
    end
end

-- ---------------------------guide------------------------------
-- function FubenLevelView:getDiffData(diff)
--     local data
--     for i, v in ipairs(self.diffData_) do
--         if v.diff == diff then
--             data = v
--             break
--         end
--     end
--     return data
-- end

function LinkageView:onGetLevelGroupRewardEvent()
    self:updateStartRewardState()
end
local  key_linkage_select_diff = "key_%s_linkage_select_diff"
function LinkageView:cacheSelectDiff(diff)
    local key = string.format(key_linkage_select_diff, MainPlayer:getPlayerId())
    UserDefault:setStringForKey(key, tostring(diff))
    dump({"cache diff",diff})
end

function LinkageView:getCacheSelectDiff()
    local key = string.format(key_linkage_select_diff, MainPlayer:getPlayerId())
        dump({"get cache diff",UserDefault:getStringForKey(key)})
    return UserDefault:getStringForKey(key)
end

return LinkageView
