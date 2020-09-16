
local FubenLevelView = class("FubenLevelView", BaseLayer)

function FubenLevelView:initData(chapterCid, levelCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)
    self.levelGroup_ = FubenDataMgr:getLevelGroup(chapterCid)

    self.rowNum_ = 5
    self.colNum_ = 13
    self.colMargin_ = 90
    self.rowMarin_ = 90
    self.middleLineRow_ = 3
    self.levelSite_ = {}
    self.middleLine_ = {}

    self.diffData_ = {
        [1] = {
            diff = EC_FBDiff.SIMPLE,
            color = ccc3(255, 255, 255),
            name = 300120,
        },
        [2] = {
            diff = EC_FBDiff.HARD,
            color = ccc3(112, 143, 255),
            name = 300121,
        },
        [3] = {
            diff = EC_FBDiff.LIMBO,
            color = ccc3(255, 120, 113),
            name = 300122,
        },
    }

    self.specialLineImg_ = {
        -- 左边分叉线段
        [1] = {
            "ui/fuben/line_s_1.png",
            "ui/fuben/line_sgray_1.png",
        },
        -- 右边分叉线段
        [2] = {
            "ui/fuben/line_s_2.png",
            "ui/fuben/line_sgray_2.png",
        },
        -- 末尾线段
        [3] = {
            "ui/fuben/line_s_1.png",
            "ui/fuben/line_sgray_1.png",
        },
        -- 开始线段
        [4] = {
            "ui/fuben/line_s_2.png",
            "ui/fuben/line_sgray_2.png",
        },
    }

    self.levelTypeData_ = {
        [EC_FBLevelType.FIGHTING] = {
            icon = "ui/fuben/fighting_paly.png",
            star = "ui/fuben/fightingStar.png",
            gray_star = "ui/fuben/fightStar_gray.png",
        },
        [EC_FBLevelType.DATING] = {
            icon = "ui/fuben/dating_play.png",
            star = "ui/fuben/datingStar.png",
            gray_star = "ui/fuben/datingStar_gray.png",
        },
        [EC_FBLevelType.CITYDATING] = {
            icon = "ui/fuben/dating_play.png",
            star = "ui/fuben/datingStar.png",
            gray_star = "ui/fuben/datingStar_gray.png",
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
    for _, diffLevel in pairs(self.level_) do
        for _, level in pairs(diffLevel) do
            table.sort(level, function(a, b)
                           local cfgA = FubenDataMgr:getLevelCfg(a)
                           local cfgB = FubenDataMgr:getLevelCfg(b)
                           local colA = math.mod(cfgA.positionOrder[1], self.colNum_)
                           local colB = math.mod(cfgB.positionOrder[1], self.colNum_)
                           return colA > colB
            end)
        end
    end

    if levelCid then
        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
        local diff = levelCfg.difficulty
        local levelGroupCid = levelCfg.levelGroupId

        self.selectLevelGroupIndex_ = 1
        for i, v in ipairs(self.levelGroup_) do
            if levelGroupCid == v then
                self.selectLevelGroupIndex_ = i
                break
            end
        end

        self.defaultSelectDiffIndex_ = 1
        for i, v in ipairs(self.diffData_) do
            if diff == v.diff then
                self.defaultSelectDiffIndex_ = i
                break
            end
        end

        -- local level = self.level_[levelGroupCid][diff]
        local _levelGroupCid = self.level_[levelGroupCid] or {}
        local level = _levelGroupCid[diff]
        self.selectLevelIndex_ = 1
        if level then
            for i, v in ipairs(level) do
                if v == levelCid then
                    self.selectLevelIndex_ = #level - i + 1
                    break
                end
            end
        end
        self.fixSelectLevelGroupIndex_ = self.selectLevelGroupIndex_
        self.fixSelectDiffIndex_ = self.defaultSelectDiffIndex_
        self.fixSelectLevelIndex_ = self.selectLevelIndex_
    else
        -- 获取缓存难度
        local selectDiff = FubenDataMgr:getCacheSelectDiff()
        self.defaultSelectDiffIndex_ = 1
        local enabled = FubenDataMgr:checkPlotChapterEnabled(self.chapterCid_, selectDiff)
        if not enabled then
            selectDiff = EC_FBDiff.SIMPLE
        end
        if selectDiff then
            for i, v in ipairs(self.diffData_) do
                if v.diff == selectDiff then
                    self.defaultSelectDiffIndex_ = i
                    break
                end
            end
        end
    end

    self.waveItem_ = {}
    self.middleLine_ = {}
    self.levelItem_ = {}
    self.lineItem_ = {}
end

function FubenLevelView:getClosingStateParams()
    return {FubenDataMgr.selectChapter_, FubenDataMgr.selectLevel_}
end

function FubenLevelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenLevelView")
end

function FubenLevelView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_lineItem = {}
    for i = 1, 22 do
        self.Panel_lineItem[i] = TFDirector:getChildByPath(self.Panel_prefab, "Panel_lineItem" .. i)
    end
    self.Panel_levelItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_levelItem")
    self.Panel_waveItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_waveItem")

    self.Panel_beginSite = TFDirector:getChildByPath(self.Panel_root, "Panel_site.Panel_beginSite")
    self.Panel_beginSite:setBackGroundColorType(0)
    local ScrollView_wave = TFDirector:getChildByPath(self.Panel_root, "ScrollView_wave")
    self.ListView_wave = UIListView:create(ScrollView_wave)

    local Image_star = TFDirector:getChildByPath(self.Panel_root, "Image_star"):hide()
    self.Label_fighting_starnum = TFDirector:getChildByPath(Image_star, "Label_fighting_starnum")
    self.Label_dating_starnum = TFDirector:getChildByPath(Image_star, "Label_dating_starnum")

    local Panel_starReward = TFDirector:getChildByPath(self.Panel_root, "Panel_starReward")
    self.Image_teaching = TFDirector:getChildByPath(Panel_starReward, "Image_teaching")
    self.Label_teaching_talk = TFDirector:getChildByPath(self.Image_teaching, "Image_teaching_bubble.Label_teaching_talk")
    self.Image_teaching_arrow = TFDirector:getChildByPath(self.Image_teaching, "Image_teaching_arrow")
    local Image_star_new = TFDirector:getChildByPath(Panel_starReward, "Image_star_new")
    self.Label_total_starnum = TFDirector:getChildByPath(Image_star_new, "Label_total_starnum")
    self.Label_get_starnum = TFDirector:getChildByPath(Image_star_new, "Label_get_starnum")
    self.Label_slash = TFDirector:getChildByPath(Image_star_new, "Label_slash")
    self.Button_reward_receive = TFDirector:getChildByPath(Panel_starReward, "Button_reward_receive")
    self.Spine_reward_receive = TFDirector:getChildByPath(self.Button_reward_receive, "Spine_reward_receive")
    self.Image_reward_redpoint = TFDirector:getChildByPath(self.Button_reward_receive, "Image_reward_redpoint")
    self.Button_reward_geted = TFDirector:getChildByPath(Panel_starReward, "Button_reward_geted")

    local Image_chapterInfo = TFDirector:getChildByPath(self.Panel_root, "Image_chapterInfo")
    self.Label_chapterOrder = TFDirector:getChildByPath(Image_chapterInfo, "Label_chapterOrder")
    self.Label_chapterName = TFDirector:getChildByPath(Image_chapterInfo, "Label_chapterName")

    self.Button_diff_select = TFDirector:getChildByPath(self.Panel_root, "Button_diff_select")
    self.Label_diff_select = TFDirector:getChildByPath(self.Button_diff_select, "Label_diff_select")
    self.Panel_diff = TFDirector:getChildByPath(self.Panel_root, "Panel_diff"):hide()
    self.Button_diff = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_diff, "Button_diff_" .. i)
        item.Label_diff = TFDirector:getChildByPath(item.root, "Label_diff")
        self.Button_diff[i] = item
    end
    self.Button_review = TFDirector:getChildByPath(self.Panel_root, "Button_review")
    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")

    self:refreshView()
end

function FubenLevelView:calLevelSite()
    local pos = self.Panel_beginSite:getPosition()
    for row = 1, self.rowNum_ do
        for col = 1, self.colNum_ do
            local index = (row - 1) * self.colNum_ + col
            local x = pos.x + self.colMargin_ * (col - 1)
            local y = pos.y - self.rowMarin_ * (row - 1)
            self.levelSite_[index] = ccp(x, y)
        end
    end
    self.Panel_beginSite = nil
end

function FubenLevelView:convertSiteToMiddleLine(site)
    local index = math.mod(site, self.colNum_)
    index = index == 0 and self.colNum_ or index
    local site = (self.middleLineRow_ - 1) * self.colNum_ + index
    return site
end

function FubenLevelView:updateDiffShowInfo()
    for i, v in ipairs(self.Button_diff) do
        local diffData = self.diffData_[i]
        local text = TextDataMgr:getText(diffData.name)
        v.Label_diff:setTextById(300123, text)
        v.Label_diff:setFontColor(diffData.color)
    end
end

function FubenLevelView:refreshView()
    self.Label_slash:setTextById(800039)
    ViewAnimationHelper.doMoveUpAndDown(self.Image_teaching_arrow, 0.7, 5)

    self:updateDiffShowInfo()
    self:calLevelSite()
    self:showLevelGroup()

    local orderName = FubenDataMgr:getChapterOrderName(self.chapterCid_)
    self.Label_chapterOrder:setText(orderName)
    local name = FubenDataMgr:getChapterName(self.chapterCid_)
    self.Label_chapterName:setText(name)
    self.Button_review:setVisible(self.chapterCfg_.video ~= 0)

    self:showPopView()
end

function FubenLevelView:updateStartRewardState()
    local diffData = self.diffData_[self.selectDiffIndex_]
    local isNewPlayer = MainPlayer:getPlayerLv() <= 10
    local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(self.chapterCid_, diffData.diff)

    self.Image_reward_redpoint:setVisible(isCanReceive)
    self.Spine_reward_receive:setVisible(isCanReceive)
    self.Image_teaching:setVisible(isNewPlayer and isCanReceive)
    self.Button_reward_geted:setVisible(not isCanReceive and isReceiveAll)
    self.Button_reward_receive:setVisible(isCanReceive or not isReceiveAll)
end

function FubenLevelView:showPopView()
    -- self:timeOut(function()
    --         local chapterCid = FubenDataMgr:getUnlockNextChapterCid()
    --         local view = AlertManager:getStashView("lua.logic.common.LevelUpView")
    --         dump(tobool(view))
    --         if view then
    --             AlertManager:showStashView("lua.logic.common.LevelUpView")
    --         else
    --             FunctionDataMgr:showOpenFunc()
    --         end
    --         if chapterCid then
    --             Utils:openView("fuben.FubenChapterPassView", chapterCid)
    --             FubenDataMgr:setUnlockNextChapterCid(nil)
    --         end
    -- end, 0)
end

function FubenLevelView:selectDiff(index)
    local diffData = self.diffData_[index]
    local enabled = FubenDataMgr:checkPlotChapterEnabled(self.chapterCid_, diffData.diff)
    if not enabled then
        local firstLevelCid = FubenDataMgr:getChapterFirstLevel(self.chapterCid_, diffData.diff)
        local firstLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCid)
        local count = #firstLevelCfg.preLevelId
        if count == 1 then
            local levelName = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[1])
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[1])
            local diffData = self:getDiffData(preLevelCfg.difficulty)
            local diffName = TextDataMgr:getText(diffData.name)
            Utils:showTips(300004, diffName .. levelName)
        elseif count == 2 then
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[1])
            local diffData = self:getDiffData(preLevelCfg.difficulty)
            local diffName = TextDataMgr:getText(diffData.name)
            local levelName1 = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[1])
            levelName1 = diffName .. levelName1
            local preLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCfg.preLevelId[2])
            local diffData = self:getDiffData(preLevelCfg.difficulty)
            local diffName = TextDataMgr:getText(diffData.name)
            local levelName2 = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[2])
            levelName2 = diffName .. levelName2
            Utils:showTips(300005, levelName1, levelName2)
        end
        return
    end

    if self.selectDiffIndex_ == index then return end
    self.selectDiffIndex_ = index
    FubenDataMgr:cacheSelectDiff(diffData.diff)

    local text = TextDataMgr:getText(diffData.name)
    self.Label_diff_select:setTextById(300123, text)
    self.Label_diff_select:setFontColor(diffData.color)

    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(self.chapterCid_, diffData.diff)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(self.chapterCid_, diffData.diff)
    -- self.Label_fighting_starnum:setTextById(800005, fightStarNum, totalFightStarNum)
    -- self.Label_dating_starnum:setTextById(800005, datingStarNum, totalDatingStarNum)
    self.Label_total_starnum:setText(totalFightStarNum)
    self.Label_get_starnum:setText(fightStarNum)

    for i, v in ipairs(self.levelGroup_) do
        self:updateWaveItem(i)
    end

    if self.fixSelectDiffIndex_ == index then
        self.selectLevelGroupIndex_ = self.fixSelectLevelGroupIndex_
        self.selectLevelIndex_ = self.fixSelectLevelIndex_
    else
        self.selectLevelGroupIndex_ = 1
        self.selectLevelIndex_ = 1
        local isBreak = false
        for i = #self.levelGroup_, 1, -1 do
            local levelGroupCid = self.levelGroup_[i]
            local level = self.level_[levelGroupCid][diffData.diff]
            for j, levelCid in ipairs(level) do
                local enabled = FubenDataMgr:checkPlotLevelEnabled(levelCid)
                if enabled then
                    self.selectLevelGroupIndex_ = i
                    self.selectLevelIndex_ = #level - j + 1
                    isBreak = true
                    break
                end
            end
            if isBreak then
                break
            end
        end
    end

    if self.selectLevelIndex_ then
        self:jumpToCacheLevel()
    end

    self:updateStartRewardState()
end

function FubenLevelView:addWaveItem()
    local Panel_waveItem = self.Panel_waveItem:clone()
    local foo = {}
    foo.root = Panel_waveItem
    foo.Panel_line = TFDirector:getChildByPath(foo.root, "Panel_line")
    foo.Panel_level = TFDirector:getChildByPath(foo.root, "Panel_level")
    self.waveItem_[Panel_waveItem] = foo
    self.ListView_wave:pushBackCustomItem(Panel_waveItem)
    return Panel_waveItem
end

function FubenLevelView:updateWaveItem(index)
    local Panel_waveItem = self.ListView_wave:getItem(index)
    local foo = self.waveItem_[Panel_waveItem]
    foo.Panel_line:removeAllChildren()
    foo.Panel_level:removeAllChildren()

    local diffData = self.diffData_[self.selectDiffIndex_]
    local level = self.level_[self.levelGroup_[index]][diffData.diff]

    -- 添加中间的线
    local beginIndex = (self.middleLineRow_ - 1) * self.colNum_ + 1
    local endIndex = beginIndex + self.colNum_ - 1
    self.middleLine_[index] = {}
    local middleLine = {}
    local order = 1
    for i = beginIndex, endIndex do
        local type_ = 8
        if index == 1 and i == beginIndex then
            type_ = 11
        elseif index == #self.levelGroup_ and i == endIndex then
            type_ = 22
        else
            if i == beginIndex then
                type_ = 21
            elseif i == endIndex then
                type_ = 20
            end
        end

        local Panel_lineItem = self.Panel_lineItem[type_]:clone()
        local pos = self.levelSite_[i]
        Panel_lineItem:Pos(pos):AddTo(foo.Panel_line)
        local foo = {}
        foo.root = Panel_lineItem
        foo.Image_high = TFDirector:getChildByPath(foo.root, "Image_high"):hide()
        foo.Image_gray = TFDirector:getChildByPath(foo.root, "Image_gray"):show()
        middleLine[order] = foo
        order = order + 1
    end
    self.middleLine_[index] = middleLine

    -- 创建关卡和连接线
    self.levelItem_[index] = {}
    self.lineItem_[index] = {}
    local line_7 = {}
    for i, v in ipairs(level) do
        local levelCfg = FubenDataMgr:getLevelCfg(v)
        local enabled = FubenDataMgr:checkPlotLevelEnabled(v)
        local site = levelCfg.positionOrder[1]
        local line = levelCfg.positionOrder[2] or {}
        local sitePos = self.levelSite_[site]
        -- 关卡
        local orderIndex = #level - i + 1
        local Panel_levelItem = self.Panel_levelItem:clone()
        Panel_levelItem:AddTo(foo.Panel_level):Pos(sitePos)
        self.levelItem_[index][orderIndex] = Panel_levelItem
        self:updateLevelItem(Panel_levelItem, v)
        Panel_levelItem.levelCid = v
        -- 连接线
        for i, type_ in ipairs(line) do
            local Panel_lineItem
            if type_ == 7 then
                local middleSite = self:convertSiteToMiddleLine(site)
                local col = math.mod(site, self.colNum_)
                local pos = self.levelSite_[middleSite]
                Panel_lineItem = line_7[col]
                if not Panel_lineItem then
                    Panel_lineItem = self.Panel_lineItem[type_]:clone()
                    line_7[col] = Panel_lineItem
                    Panel_lineItem:AddTo(foo.Panel_line):Pos(pos)
                    middleLine[col].root:hide()
                end
            elseif type_ == 3 or type_ == 4 then
                local middleSite = self:convertSiteToMiddleLine(site)
                local col = math.mod(site, self.colNum_)
                local pos = self.levelSite_[middleSite]
                Panel_lineItem = self.Panel_lineItem[type_]:clone()
                Panel_lineItem:AddTo(foo.Panel_line):Pos(pos)
                middleLine[col].root:hide()
            else
                local pos = self.levelSite_[site]
                Panel_lineItem = self.Panel_lineItem[type_]:clone()
                Panel_lineItem:AddTo(foo.Panel_line):Pos(pos)
                if type_ == 1 or type_ == 2 or type_ == 5 or type_ == 6 then
                    local col = math.mod(site, self.colNum_)
                    if type_ == 1 or type_ == 5 then
                        local Image_high = middleLine[col - 1].Image_high
                        local Image_gray = middleLine[col - 1].Image_gray
                        Image_high:setTexture(self.specialLineImg_[1][1])
                        Image_gray:setTexture(self.specialLineImg_[1][2])
                    else
                        local Image_high = middleLine[col + 1].Image_high
                        local Image_gray = middleLine[col + 1].Image_gray
                        Image_high:setTexture(self.specialLineImg_[2][1])
                        Image_gray:setTexture(self.specialLineImg_[2][2])
                    end
                    middleLine[col].root:hide()
                end
            end
            local Image_high = TFDirector:getChildByPath(Panel_lineItem, "Image_high")
            local Image_gray = TFDirector:getChildByPath(Panel_lineItem, "Image_gray")
            Image_high:setVisible(enabled)
            Image_gray:setVisible(not enabled)
            table.insert(self.lineItem_[index], Panel_lineItem)
        end
    end

    -- 判断解锁关卡
    local isPass = FubenDataMgr:isPassPlotLevelGroup(self.levelGroup_[index], diffData.diff)
    if isPass then
        for i, v in ipairs(self.middleLine_[index]) do
            middleLine[i].Image_high:show()
            middleLine[i].Image_gray:hide()
        end
    else
        for _, v in ipairs(level) do
            local enabled = FubenDataMgr:checkPlotLevelEnabled(v)
            local levelCfg = FubenDataMgr:getLevelCfg(v)
            local site = levelCfg.positionOrder[1]
            local col = math.mod(levelCfg.positionOrder[1], self.colNum_)
            for i = 1, col do
                local middleLine = self.middleLine_[index][i]
                middleLine.Image_high:setVisible(enabled)
                middleLine.Image_gray:setVisible(not enabled)
            end
        end
    end
end

function FubenLevelView:updateLevelItem(item, levelCid)
    local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(levelCid)
    local levelInfo = FubenDataMgr:getLevelInfo(levelCid)
    local levelTypeData = self.levelTypeData_[levelCfg.dungeonType]
    local Button_level = TFDirector:getChildByPath(item, "Button_level")
    local Image_type = TFDirector:getChildByPath(Button_level, "Image_type")
    local Label_name = TFDirector:getChildByPath(Button_level, "Label_name")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_lock_pre = TFDirector:getChildByPath(item, "Image_lock_pre"):hide()
    local Image_lock_level = TFDirector:getChildByPath(item, "Image_lock_level"):hide()
    local Label_lock_level = TFDirector:getChildByPath(Image_lock_level, "Label_lock_level")
    local Image_star = {}
    for i = 1, 3 do
        Image_star[i] = TFDirector:getChildByPath(item, "Image_star_" .. i):hide()
    end

    Image_type:setTexture(levelTypeData.icon)
    if enabled then
        local starNum = FubenDataMgr:getStarNum(levelCid)
        if levelCfg.dungeonType == EC_FBLevelType.FIGHTING then
            for i, v in ipairs(Image_star) do
                v:show()
                if i <= starNum then
                    v:setTexture(levelTypeData.star)
                else
                    v:setTexture(levelTypeData.gray_star)
                end
            end
        else
            for i, v in ipairs(Image_star) do
                v:setVisible(i == 2)
                if i == 2 then
                    if starNum == 1 then
                        v:setTexture(levelTypeData.star)
                    else
                        v:setTexture(levelTypeData.gray_star)
                    end
                end
            end
        end
    else
        if not levelIsOpen then
            Image_lock_level:show()
            Label_lock_level:setTextById(800003, levelCfg.playerLv)
        else
            Image_lock_pre:show()
        end
    end
    Button_level:setTouchEnabled(enabled)
    local name = FubenDataMgr:getLevelName(levelCid)
    Label_name:setText(name)
    Button_level:setTextureNormal(levelCfg.icon)

    Button_level:onClick(function()
            local levelGroupCid = levelCfg.levelGroupId
            local levelGroupIndex = table.indexOf(self.levelGroup_, levelGroupCid)
            FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
            FubenDataMgr:cacheSelectLevel(levelCid)
            Utils:openView("fuben.FubenReadyView", levelCid)
            if self.guideFuncId then
                GameGuide:checkGuideEnd(self.guideFuncId)
            end
    end)
end

function FubenLevelView:showLevelGroup()
    for i, v in ipairs(self.levelGroup_) do
        self:addWaveItem()
    end
    self:selectDiff(self.defaultSelectDiffIndex_)

end

function FubenLevelView:jumpToCacheLevel()
    local item = self.levelItem_[self.selectLevelGroupIndex_][self.selectLevelIndex_]
    local pos = item:getPosition()
    local size = self.ListView_wave:getContentSize()

    local offset = math.max(0, pos.x)
    if self.selectLevelGroupIndex_ > 1 then
        offset = pos.x
    end
    offset = size.width * (self.selectLevelGroupIndex_ - 1) + offset

    self.ListView_wave:jumpTo(offset)
end

function FubenLevelView:onShow()
    self.super.onShow(self)
    self:removeLockLayer()
    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    if #activitys < 1 then
        self.Button_newPlayer:setVisible(false)
    else
        self.Button_newPlayer:setVisible(true)
        self.Button_newPlayer:setTouchEnabled(false)
        self.Label_newPlayerNumExp = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumExp")
        self.Label_newPlayerNumCoin = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumCoin")
        local newbleCfg = TabDataMgr:getData("NewbleAdd")
        local number = newbleCfg[201].number
        if number[1] then
            self.Label_newPlayerNumExp:setText(number[1] .. "%")
        end
        if number[2] then
            self.Label_newPlayerNumCoin:setText(number[2] .. "%")
        end
        self.Image_newPlayerEXP = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerEXP")
        self.Image_newPlayerCoin = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerCoin")

        self.Image_newPlayerEXP:setVisible(number[1])
        self.Image_newPlayerCoin:setVisible(number[2])
        self.Label_newPlayerNumExp:setVisible(number[1])
        self.Label_newPlayerNumCoin:setVisible(number[2])
    end
    self:timeOut(function()
            GameGuide:checkGuide(self)
    end, 0.1)

    if FubenDataMgr:checkIsAllChapterPassWin() then   --按需求要弹出四糸乃跳转提示
        local mainFuncInfo = FunctionDataMgr:getMainFuncInfo(217)
        if mainFuncInfo and tobool(mainFuncInfo.openWelfare) then
            Utils:openView("fuben.SisinaiChapterTipsView")
        end
    end
end

function FubenLevelView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))

    self.Button_diff_select:onClick(function()
            local visible = self.Panel_diff:isVisible()
            self.Panel_diff:setVisible(not visible)
    end)

    self.Button_reward_receive:onClick(function()
            local diffData = self.diffData_[self.selectDiffIndex_]
            local levelGroupCid = self.levelGroup_[self.selectLevelGroupIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)

    self.Button_reward_geted:onClick(function()
            local diffData = self.diffData_[self.selectDiffIndex_]
            local levelGroupCid = self.levelGroup_[self.selectLevelGroupIndex_]
            Utils:openView("fuben.FubenStarRewardView", self.levelGroup_[1], diffData.diff)
    end)

    self.Button_review:onClick(function()
            TFAudio.stopAllEffects()
            local videoCfg = TabDataMgr:getData("Video", self.chapterCfg_.video)
            Utils:openView("common.VideoView", videoCfg.path)
    end)

    for i, v in ipairs(self.Button_diff) do
        v.root:onClick(function()
                self:selectDiff(i)
                self.Panel_diff:hide()
        end)
    end
end

---------------------------guide------------------------------

--引导第二关
function FubenLevelView:excuteGuideFunc3002(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101102 then
            targetNode = v
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 16))
end

--引导第三关
function FubenLevelView:excuteGuideFunc3003(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101103 then
            targetNode = v
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 16))
end

--引导第四关
function FubenLevelView:excuteGuideFunc3004(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101104 then
            targetNode = v
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 16))
end

--引导第五关
function FubenLevelView:excuteGuideFunc3005(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101105 then
            targetNode = v
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 16))
end

--引导第六关
function FubenLevelView:excuteGuideFunc3006(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[2]) do
        if v.levelCid == 101206 then
            targetNode = v
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode, ccp(0, 16))
end

--非强制引导通关第四关
function FubenLevelView:excuteGuideFunc7004(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101104 then
            local pass = FubenDataMgr:isPassPlotLevel(v.levelCid)
            if pass then
                GameGuide:guideFuncDown(guideFuncId)
                return
            else
                targetNode = v
            end
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

--非强制引导通关第五关
function FubenLevelView:excuteGuideFunc7005(guideFuncId)
    local targetNode
    for k, v in pairs(self.levelItem_[1]) do
        if v.levelCid == 101105 then
            local pass = FubenDataMgr:isPassPlotLevel(v.levelCid)
            if pass then
                GameGuide:guideFuncDown(guideFuncId)
                return
            else
                targetNode = v
            end
        end
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function FubenLevelView:getDiffData(diff)
    local data
    for i, v in ipairs(self.diffData_) do
        if v.diff == diff then
            data = v
            break
        end
    end
    return data
end

function FubenLevelView:onGetLevelGroupRewardEvent()
    self:updateStartRewardState()
end

return FubenLevelView
