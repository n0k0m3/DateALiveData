local FubenTheaterContor = class("FubenTheaterContor")
local ExtraTrigger = TabDataMgr:getData("ExtraTrigger")
local enum       = import("lua.logic.battle.enum")

function FubenTheaterContor:ctor( ... )
    self:init(...)
    EventMgr:addEventListener(self,EV_FUBEN_THEATER_CONTRO_PROCESS,function ( ... )
        if not self.isActioning then
            if not self:checkProcess() then
                self.logic.playPreAni()
            end
        end
    end)

    EventMgr:addEventListener(self,enum.eEvent.EVENT_SHOW__STACE_CLEAR,function ( ... )
        if self.dungeonChapter then
            self:saveStep(self.stepId,self.dungeonChapter)
            self:checkProcess()
            self.dungeonChapter = nil
        end
    end)
    
    EventMgr:addEventListener(self,EV_DATING_EVENT.closeSriptView,function ( event )
        if self.datingChapter then 
            self:saveStep(self.stepId,self.datingChapter)
            self:checkProcess()
            self.datingChapter = nil
        end
    end)
    
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_LIMITHERO, handler(self.onLimitHeroEvent, self))
end

function FubenTheaterContor:init( logic, chapterId, stage)
    self.logic = logic
    self.chapterId = chapterId
    self.stage = stage
    self:checkProcess()
end



function FubenTheaterContor:distory()
    EventMgr:removeEventListenerByTarget(self)
end

function FubenTheaterContor:onShow( )
    self:checkProcess()
end

function FubenTheaterContor:onLimitHeroEvent()

    local levelFormation =  FubenDataMgr:getLevelFormation(self.dungeonId)
    if not levelFormation then
        return
    end

    local formationData_ = FubenDataMgr:getInitFormation(self.dungeonId)
    if formationData_ then
        HeroDataMgr:changeDataByFuben(self.dungeonId, formationData_)
    end

    local heros = {}
    for i, v in ipairs(formationData_) do
        table.insert(heros, {limitType = v.type, limitCid = v.id})
    end

    FubenDataMgr:setFormation(levelFormation)
    self:saveStep(self.stepId,self.chapterId)
    local battleController = require("lua.logic.battle.BattleController")
    battleController.enterBattle(
            {
                levelCid = self.dungeonId,
                limitHeros = heros,
                isDuelMod = false,
            },
            EC_BattleType.COMMON
    )
end

function FubenTheaterContor:getFirstStepId()
    local firstStepId = nil
    for k,v in pairs(ExtraTrigger) do
        if self.chapterId == v.chapterId and v.isFirst then
            firstStepId = k
        end
    end
    return firstStepId
end

function FubenTheaterContor:checkProcess() -- 进入流程或者等待服务器返回数据就进入流程
    if self.isActioning then return true end
    local firstStepId = self:getFirstStepId()
    if not firstStepId then return false end -- 当前章节没有流程控制 
    local stepId = FubenDataMgr:getTheaterContorProcess(self.chapterId)
    if stepId == 0 then
        stepId = firstStepId
    end

    if stepId == -10 then -- 没有获取到章节数据
        return true
    end

    if stepId ~= self.stepId then
        local v = ExtraTrigger[stepId]
        if v and self:isPassCond(v.trigger) then
            self.stepId = stepId
            self:actionStep(v)
        else
            return false -- 当前流程不满足条件不进入流程
        end 
    end
    return true
end

function FubenTheaterContor:isPassCond( conds )
    local isPass = true
    if conds then
        for k,cond in pairs(conds) do
            local predungeonIsUnlock = true
            if cond.predungeon then
                for i, v in ipairs(cond.predungeon) do
                    if not FubenDataMgr:isPassTheaterLevel(v) then
                        predungeonIsUnlock = false
                        break
                    end
                end
            end

            local predatingIsUnlock = true
            if cond.predating then
                for i, v in ipairs(cond.predating) do
                    if not FubenDataMgr:isPassTheaterLevel(v) then
                        predatingIsUnlock = false
                        break
                    end
                end
            end

            local predungeonIsNotPass = true
            if cond.notPass then
                for i, v in ipairs(cond.notPass) do
                    if FubenDataMgr:isPassTheaterLevel(v) then
                        predungeonIsNotPass = false
                        break
                    end
                end
            end

            local predungeonResultPass = true
            if cond.predungeonResult then
                for i, v in ipairs(cond.predungeonResult) do
                    if not FubenDataMgr:judgeStarIsActive(v.id,v.star) then
                        predungeonResultPass = false
                        break
                    end
                end
            end

            local isOnStage = true
            if cond.stage then
                if self.stage ~= cond.stage then
                    isOnStage = false
                end
            end

            local isCountEnought = true
            if cond.countEnd then
                local passCount = 0
                for k,v in pairs(cond.countEnd.predungeonList) do
                    if FubenDataMgr:isPassTheaterLevel(v) then
                        passCount = passCount + 1
                    end
                end
                isCountEnought = cond.countEnd.count == passCount
            end

            isPass = predungeonIsUnlock and predatingIsUnlock and predungeonIsNotPass and predungeonResultPass and isOnStage and isCountEnought
            if isPass then break end
        end
    end
    return isPass
end

function FubenTheaterContor:actionStep( step )
    self.isActioning = true
    for k,v in pairs(step.execute) do
        if k == "dungeonLevelId" then
            self.dungeonId = v
            self.dungeonChapter = self.chapterId
            FubenDataMgr:send_DUNGEON_LIMIT_HERO_DUNGEON(self.dungeonId)
            return
        elseif k == "preViewAni" then
            self.logic.playPreAni()
        elseif k == "cameraFocus" then
            self.logic:moveToLevel(nil,v.levelId)
        elseif k == "datingId" then
            self.datingId = v
            self.datingChapter = self.chapterId
            FunctionDataMgr:jStartDating(v)
            return
        elseif k == "dialog" then
            self.dialogChapter = self.chapterId
            local function callback()
                KabalaTreeDataMgr:playStory(1, v,function ()
                                                EventMgr:dispatchEvent(EV_CG_END, function()
                                                    self:saveStep(step.id,self.dialogChapter)
                                                    self:checkProcess()
                                                end)
                end)
            end
            KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg", callback)
            return
        elseif k == "video" then
            self.videoChapter = self.chapterId
            local video = Utils:openView("common.VideoView", v)
            video:bindEndCallBack(function()
                self:saveStep(step.id,self.videoChapter)
                self:checkProcess()
            end)
            return
        end
    end
    self:saveStep(self.stepId,self.chapterId)
    self:checkProcess()
end

function FubenTheaterContor:saveStep( id, chapterId ) -- 保存下一步的id 
    id = ExtraTrigger[id].nextStep
    self.isActioning = false
    FubenDataMgr:saveTheaterContorProcess(chapterId,id)
end


local FubenTheaterLevelView = class("FubenTheaterLevelView", BaseLayer)


function FubenTheaterLevelView:getClosingStateParams()
    local selectChapter = FubenDataMgr:getCacheSelectChapter()
    local selectLevelCid = FubenDataMgr:getCacheSelectLevel()
    return {selectChapter, selectLevelCid, self.exChapterId or 0, self.ishardLevel or false}
end

function FubenTheaterLevelView:initData(chapterCid, levelCid, exChapterId, ishardLevel)
    if chapterCid == 0 then chapterCid = nil end
    if levelCid == 0 then levelCid = nil end
    if exChapterId == 0 then exChapterId = nil end

    self.selectLevelCid_ = levelCid
    self.chapter_, self.exChapterId = FubenDataMgr:getTheaterChapter(exChapterId)
    self.ishardLevel = ishardLevel
    if ishardLevel then
        self.chapter_, self.exChapterId = FubenDataMgr:getTheaterHardChapter(exChapterId)
    end

    FubenDataMgr:cacheExtraChapterId(self.exChapterId)

    self.exChapterCfg = TabDataMgr:getData("ExtraChapter",self.exChapterId)
    self.defaultSelectChapterIndex_ = 1
    for i, v in ipairs(self.chapter_) do
        if v == chapterCid then
            local enabled, condEnabled, timeEnabled, levelEnabeld = FubenDataMgr:checkTheaterChapterEnabled(chapterCid)
            if levelEnabeld and condEnabled then
                self.defaultSelectChapterIndex_ = i
                break
            end
        end
    end
    self.chapterCid = chapterCid

    self.chapterItems_ = {}
    self.contentItems_ = {}
    self.contentMaps_ = {}
    self.levelItems_ = {}
    self.lastLevelCid_ = {}
    self.aniGroupIndex_ = {}

    self.levelTypeCreator_ = {
        [EC_TheaterLevelType.MAIN_DATING] = handler(self.addDatingMainItem, self),
        [EC_TheaterLevelType.MAIN_FIGHTING] = handler(self.addFightingMainItem, self),
        [EC_TheaterLevelType.BRANCH_DATING] = handler(self.addDatingBranchItem, self),
        [EC_TheaterLevelType.BRANCH_FIGHTING] = handler(self.addFightingBranchItem, self),
        [EC_TheaterLevelType.OPTION] = handler(self.addOptionItem, self),
        [EC_TheaterLevelType.CG_DATING] = handler(self.addDatingCgItem, self),
        [EC_TheaterLevelType.CONDITION] = handler(self.addConditionItem, self),
        [EC_TheaterLevelType.FIGHTRESULT] = handler(self.addFightResultItem, self),
        [EC_TheaterLevelType.LAST_FIGHTING] = handler(self.addLastFightingItem, self),
        [EC_TheaterLevelType.BOSS_ENTANCE] = handler(self.addBossItem, self),
        [EC_TheaterLevelType.BOSS_FIGHT] = handler(self.addBossFightItem, self),
        [EC_TheaterLevelType.BOSS_FIGHT1] = handler(self.addBossItem, self),
        [EC_TheaterLevelType.BOSS_JUNAI] = handler(self.addJuNaiBossItem, self),
        [EC_TheaterLevelType.LAST_DATING] = handler(self.addDatingMainItem, self),
    }
    self.levelTypeUpdator_ = {
        [EC_TheaterLevelType.MAIN_DATING] = handler(self.updateDatingMainItem, self),
        [EC_TheaterLevelType.MAIN_FIGHTING] = handler(self.updateFightingMainItem, self),
        [EC_TheaterLevelType.BRANCH_DATING] = handler(self.updateDatingBranchItem, self),
        [EC_TheaterLevelType.BRANCH_FIGHTING] = handler(self.updateFightingBranchItem, self),
        [EC_TheaterLevelType.OPTION] = handler(self.updateOptionItem, self),
        [EC_TheaterLevelType.CG_DATING] = handler(self.updateDatingCgItem, self),
        [EC_TheaterLevelType.CONDITION] = handler(self.updateConditionItem, self),
        [EC_TheaterLevelType.FIGHTRESULT] = handler(self.updateFightResultItem, self),
        [EC_TheaterLevelType.LAST_FIGHTING] = handler(self.updateLastFightingItem, self),
        [EC_TheaterLevelType.BOSS_ENTANCE] = handler(self.updateBossItem, self),
        [EC_TheaterLevelType.BOSS_FIGHT] = handler(self.updateBossFightItem, self),
        [EC_TheaterLevelType.BOSS_FIGHT1] = handler(self.updateBossItem1, self),
        [EC_TheaterLevelType.BOSS_JUNAI] = handler(self.updateJuNaiBossItem, self),
        [EC_TheaterLevelType.LAST_DATING] = handler(self.updateDatingMainItem, self),
    }

end

function FubenTheaterLevelView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self.processContro = FubenTheaterContor:new()
    self:init("lua.uiconfig.fuben.fubenTheaterLevelView")
end

function FubenTheaterLevelView:onShow()
    self.super.onShow(self)
    self.processContro:onShow()
    if not self.isFirst then
        self:refreshView()
        self.isFirst = true
    end
end

function FubenTheaterLevelView:removeUI()
    self.super.removeUI(self)
    self.processContro:distory()
    self.processContro = nil
end

function FubenTheaterLevelView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")
    self.bg_spine = TFDirector:getChildByPath(self.Image_bg, "Spine_fubenTheaterLevelView_1")

    self.Panel_chapter_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_chapter_item")
    self.Panel_datingCg_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_datingCg_item")
    self.Panel_option_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_option_item")
    self.Panel_fighting_main_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fighting_main_item")
    self.Panel_dating_main_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dating_main_item")
    self.Panel_fighting_branch_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fighting_branch_item")
    self.Panel_dating_branch_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dating_branch_item")
    self.Panel_condition_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_condition_item")
    self.ScrollView_content_item = TFDirector:getChildByPath(self.Panel_prefab, "ScrollView_content_item")
    self.Panel_content_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_content_item")
    self.Panel_fightresult_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fightresult_item")
    self.Panel_fighting_item1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fighting_item1")
    self.Panel_boss_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_boss_item")
    self.Panel_boss_fight_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_boss_fight_item")
    self.Panel_dating_item1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dating_item1")

    -- 鞠奈
    self.Panel_fighting_branch_itemHuoShou = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fighting_branch_itemHuoShou")
    self.Panel_dating_branch_itemHuoShou = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dating_branch_itemHuoShou")
    self.Panel_fighting_boss_itemHuoShou = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fighting_boss_itemHuoShou")
    

    local ScrollView_chapter = TFDirector:getChildByPath(self.Panel_root, "ScrollView_chapter")
    self.ListView_chapter = UIListView:create(ScrollView_chapter)
    self.Image_chapter = TFDirector:getChildByPath(self.Panel_root, "Image_chapter")
    self.Label_chapter_order = TFDirector:getChildByPath(self.Image_chapter, "Label_chapter_order")
    self.Label_chapter_name = TFDirector:getChildByPath(self.Image_chapter, "Label_chapter_name")

    self.Button_buffTip = TFDirector:getChildByPath(self.Image_chapter, "Button_buffTip")
    self.content_tip = TFDirector:getChildByPath(self.Image_chapter, "content_tip")
    self.buffTip_txt = TFDirector:getChildByPath(self.Image_chapter, "txt_content")

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")

    self.Image_theater_info = TFDirector:getChildByPath(self.Panel_root, "Image_theater_info"):hide()
    self.Label_theater_name = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_name")
    self.Label_theater_name:setTextById(300968)
    self.Image_theater_progress = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_progress")
    self.LoadingBar_lingbo = TFDirector:getChildByPath(self.Image_theater_progress, "LoadingBar_lingbo")
    self.Image_percent_tag = {}
    for i = 1, 3 do
        self.Image_percent_tag[i] = TFDirector:getChildByPath(self.LoadingBar_lingbo, "Image_percent_tag_" .. i)
    end
    self.Label_theater_tips_1 = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_tips_1")
    self.Label_theater_tips_2 = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_tips_2")
    self.Label_theater_noOpen = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_noOpen")
    self.Label_theater_noOpen:setTextById(300970)
    self.Button_theater_challenge = TFDirector:getChildByPath(self.Image_theater_info, "Button_theater_challenge")
    self.Label_theater_challenge = TFDirector:getChildByPath(self.Button_theater_challenge, "Label_theater_challenge")
    self.Button_collapse = TFDirector:getChildByPath(self.Image_theater_info, "Button_collapse"):hide()
    self.Button_expand = TFDirector:getChildByPath(self.Image_theater_info, "Button_expand"):show()
    self.Image_theater_icon = {}
    for i = 1, 3 do
        self.Image_theater_icon[i] = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_icon_" .. i):hide()
    end
    self.Image_theater_icon_boss = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_icon_boss"):hide()

    self.Panel_starReward = TFDirector:getChildByPath(self.Panel_root, "Panel_starReward")
    self.Image_teaching = TFDirector:getChildByPath(self.Panel_starReward, "Image_teaching")
    self.Label_teaching_talk = TFDirector:getChildByPath(self.Image_teaching, "Image_teaching_bubble.Label_teaching_talk")
    self.Image_teaching_arrow = TFDirector:getChildByPath(self.Image_teaching, "Image_teaching_arrow")
    local Image_star_new = TFDirector:getChildByPath(self.Panel_starReward, "Image_star_new")
    self.Label_total_starnum = TFDirector:getChildByPath(Image_star_new, "Label_total_starnum")
    self.Label_get_starnum = TFDirector:getChildByPath(Image_star_new, "Label_get_starnum")
    self.Label_slash = TFDirector:getChildByPath(Image_star_new, "Label_slash")
    self.Button_reward_receive = TFDirector:getChildByPath(self.Panel_starReward, "Button_reward_receive")
    self.Spine_reward_receive = TFDirector:getChildByPath(self.Button_reward_receive, "Spine_reward_receive")
    self.Image_reward_redpoint = TFDirector:getChildByPath(self.Button_reward_receive, "Image_reward_redpoint")
    self.Button_reward_geted = TFDirector:getChildByPath(self.Panel_starReward, "Button_reward_geted")

    self.Button_hard = TFDirector:getChildByPath(self.Panel_root, "Button_hard")
    self.Label_hard = TFDirector:getChildByPath(self.Button_hard, "Label_hard")


    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")
    local Image_newPlayerBG = TFDirector:getChildByPath(self.Button_newPlayer, "Image_newPlayerBG")
    self.Label_newPlayerNumExp = TFDirector:getChildByPath(Image_newPlayerBG, "Label_newPlayerNumExp")
    self.Label_newPlayerNumCoin = TFDirector:getChildByPath(Image_newPlayerBG, "Label_newPlayerNumCoin")
    self.Image_newPlayerEXP = TFDirector:getChildByPath(Image_newPlayerBG, "Image_newPlayerEXP")
    self.Image_newPlayerCoin = TFDirector:getChildByPath(Image_newPlayerBG, "Image_newPlayerCoin")

    local size = self.Panel_root:getSize()
    local infoSize = self.Image_theater_info:getSize()
    local offsetX = (GameConfig.WS.width - size.width) * 0.5
    self.collapseX_ = size.width * 0.5 + offsetX
    self.expandX_ = self.collapseX_ - infoSize.width
    self.Image_theater_info:PosX(self.collapseX_)

end

function FubenTheaterLevelView:refreshView()
    self.Label_slash:setTextById(800039)
    self.Label_hard:setTextById(300996)
    ViewAnimationHelper.doMoveUpAndDown(self.Image_teaching_arrow, 0.7, 5)

    if not self.ishardLevel then
        local chapter = FubenDataMgr:getTheaterHardChapter(self.exChapterId)
        if #chapter > 0 then
            local enabled, condEnabled = FubenDataMgr:checkTheaterChapterEnabled(chapter[1])
            self.Button_hard:setVisible(condEnabled)
        else
            self.Button_hard:setVisible(false)
        end
    else
        self.Button_hard:setVisible(false)
    end

    if #self.chapter_ > 1 then
        self.ListView_chapter.scrollView_:show()   
        for i, v in ipairs(self.chapter_) do
            self:addChapterItem()
            self:updateChapterItem(i)
            self.aniGroupIndex_[i] = 1
        end
    else
        self.ListView_chapter.scrollView_:hide()
        self.Image_chapter:setPositionX(-568)
        self.Panel_starReward:setPositionX(-568)
        self.aniGroupIndex_[1] = 1  
    end

    self:updateTheaterInfo()
    self:updateNewPlayer()

    self:selectChapter(self.defaultSelectChapterIndex_)
end

function FubenTheaterLevelView:updateStartRewardState()
    local chapterCid = self.chapter_[self.selectChapterIndex_]
    local diff = EC_FBDiff.SIMPLE
    local isCanReceive, isReceiveAll = FubenDataMgr:checkChapterStarRewardCanReceive(chapterCid, diff)

    self.Image_reward_redpoint:setVisible(isCanReceive)
    self.Spine_reward_receive:setVisible(isCanReceive)
    self.Image_teaching:hide()
    self.Button_reward_geted:setVisible(not isCanReceive and isReceiveAll)
    self.Button_reward_receive:setVisible(isCanReceive or not isReceiveAll)
end

function FubenTheaterLevelView:updateNewPlayer()
    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    local newbleCfg = TabDataMgr:getData("NewbleAdd")
    local number = newbleCfg[351].number
    local isShow = #activitys >= 1 and #number > 0
    self.Button_newPlayer:setVisible(isShow)

    if self.Button_newPlayer:isVisible() then
        self.Button_newPlayer:setVisible(true)
        self.Button_newPlayer:setTouchEnabled(false)
        local newbleCfg = TabDataMgr:getData("NewbleAdd")
        local number = newbleCfg[351].number
        if number[1] then
            self.Label_newPlayerNumExp:setText(number[1] .. "%")
        end
        if number[2] then
            self.Label_newPlayerNumCoin:setText(number[2] .. "%")
        end

        self.Image_newPlayerEXP:setVisible(number[1])
        self.Image_newPlayerCoin:setVisible(number[2])
        self.Label_newPlayerNumExp:setVisible(number[1])
        self.Label_newPlayerNumCoin:setVisible(number[2])
    end
end

function FubenTheaterLevelView:selectChapter(index)
    if self.selectChapterIndex_ == index then return end

    local chapterCid = self.chapter_[index]
    self.chapterCid = chapterCid
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    local enabled, condEnabled, timeEnabled, levelEnabeld = FubenDataMgr:checkTheaterChapterEnabled(chapterCid)
    if not timeEnabled then
        if index == 2 then
            Utils:showTips(12010139)
        elseif index == 3 then
            Utils:showTips(12010140)
        elseif index == 4 then
            Utils:showTips(12010141)
        end
        return
    end

    if not levelEnabeld then
        Utils:showTips(12010142, chapterCfg.unlockLevel)
        return
    end

    if not condEnabled and self.exChapterCfg.lockTips > 0 then
        Utils:showTips(self.exChapterCfg.lockTips, index - 1)
        return
    end


    self.selectChapterIndex_ = index

    if not self.contentItems_[index] then
        self:addContent(index)
    end
    self:updateContent(index)

    if chapterCfg.chapterBuffHint then
        self.Button_buffTip:setVisible(chapterCfg.chapterBuffHint ~= 0)
    end
    self.content_tip:hide()
    self.buffTip_txt:setTextById(chapterCfg.chapterBuffHint)

    local hight = self.buffTip_txt:getContentSize().height

    self.content_tip:setContentSize(CCSizeMake(self.content_tip:getContentSize().width,hight + 40))

    for i, v in ipairs(self.ListView_chapter:getItems()) do
        local isSelect = (i == index)
        local foo = self.chapterItems_[v]
        local isLock = foo.Image_cond_lock:isVisible() or foo.Image_time_lock:isVisible()
        foo.Image_select:setVisible(isSelect)

        foo.Button_chapter:setTouchEnabled(not isSelect)
        if isSelect then
            foo.Button_chapter:setOpacity(255)
            foo.Label_unselect_order:hide()
        else
            foo.Button_chapter:setOpacity(127)
            foo.Label_unselect_order:setVisible(not isLock)
        end

        local content = self.contentItems_[i]
        if content then
            content.root:setVisible(isSelect)
        end
    end

    self.playPreAni = function ( ... )
        local lastLevelCid = self.lastLevelCid_[index]
        if FubenDataMgr:getTheaterLevelAni(self.exChapterId,index) then
            if self.selectLevelCid_ then
                self:moveToLevel(index, self.selectLevelCid_)
                self.selectLevelCid_ = nil
            else
                if lastLevelCid then
                    self.lastLevelCid_[index] = nil
                    self:moveToLevel(index, lastLevelCid)
                end
            end
            self.processContro:init(self,self.chapterCid,3)
        else
            FubenDataMgr:setTheaterLevelAni(self.exChapterId, index)
            local action1,action2 = self:getUIActionName(index)
            local contentMap = self.contentMaps_[index]
            if action1 and contentMap.root.animationModel__.actions[action1] then
                contentMap.root:setAnimationCallBack(action1,TFANIMATION_END, function()
                        local delay = self:playLevelAni(index)
                        local aniSeq = Sequence:create({
                                        DelayTime:create(delay),
                                        CallFunc:create(function ( ... )
                                            contentMap.root:runAnimation(action2,1)
                                        end)
                                })
                        self:runAction(aniSeq)
                    end)
                    contentMap.root:runAnimation(action1,1)
            else
                self:playLevelAni(index)
            end
        end
        self.processContro:init(self,self.chapterCid,2)
    end

    self.processContro:init(self,self.chapterCid,1)
    if not self.processContro:checkProcess() then
        self.playPreAni()
    end

    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(chapterCid, EC_FBDiff.SIMPLE)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(chapterCid, EC_FBDiff.SIMPLE)
    self.Label_total_starnum:setText(totalFightStarNum)
    self.Label_get_starnum:setText(fightStarNum)
    self.Panel_starReward:setVisible(totalFightStarNum > 0)

    local orderName = FubenDataMgr:getChapterOrderName(chapterCid)
    self.Label_chapter_order:setText(orderName)
    local name = FubenDataMgr:getChapterName(chapterCid)
    self.Label_chapter_name:setText(name)

    self:updateStartRewardState()
end

function FubenTheaterLevelView:getUIActionName(index)
    local chapterCid =  self.chapter_[index]
    local groupLevels = FubenDataMgr:getTheaterGroupLevels(chapterCid)

    local baseLevelCid = 0
    for index = 1,#groupLevels do
        local levels = clone(groupLevels[index])
        if levels then
            table.sort(levels, function(a, b)
                           local levelCfgA = FubenDataMgr:getTheaterDungeonLevelCfg(a)
                           local levelCfgB = FubenDataMgr:getTheaterDungeonLevelCfg(b)
                           return levelCfgA.sortShow < levelCfgB.sortShow
            end)
            local enabled = false
            for _, levelCid in ipairs(levels) do
                if FubenDataMgr:isPassTheaterLevel(levelCid) or FubenDataMgr:getTheaterDungeonLevelCfg(levelCid) then
                   local levelCfgA = FubenDataMgr:getTheaterDungeonLevelCfg(baseLevelCid)
                   local levelCfgB = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
                   local actionName1 = nil
                   if levelCfgA then actionName1 = levelCfgA.previewAni[1] end
                   local actionName2 = levelCfgB.previewAni[1]
                    if not actionName1 then -- 取最外围的关卡ui动作
                        baseLevelCid = levelCid
                    elseif actionName2 then
                        local num1 = tonumber(string.split(actionName1,"_")[2])
                        local num2 = tonumber(string.split(actionName2,"_")[2])
                        if num1 < num2 then
                            baseLevelCid = levelCid
                        end
                    end
                end 
            end
        end
    end
    if baseLevelCid ~= 0 then
        local levelCfgA = FubenDataMgr:getTheaterDungeonLevelCfg(baseLevelCid)
        local actions = levelCfgA.previewAni
        if actions then
            return actions[1],actions[2]
        end
    end
    return
end

function FubenTheaterLevelView:parseMap(mapName)
    local moduleName = string.format("lua.uiconfig.fuben.%s", mapName)
    local ui = createUIByLuaNew(moduleName)

    local contentMap = {level = {}, line = {}, root = ui}
    local Panel_level = TFDirector:getChildByPath(ui, "Panel_level")
    for i, v in ipairs(Panel_level:getChildren()) do
        v:setBackGroundColorType(0)
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        contentMap.level[id] = v
    end

    local Panel_line = TFDirector:getChildByPath(ui, "Panel_line")
    for i, v in ipairs(Panel_line:getChildren()) do
        local name = v:getName()
        local prefix, id = string.match(name, "(.*)_(.*)")
        contentMap.line[id] = v
    end

    return contentMap
end

function FubenTheaterLevelView:addContent(index)
    local chapterCid = self.chapter_[index]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    local Panel_content_item = self.Panel_content_item:clone()
    local ScrollView_content = TFDirector:getChildByPath(Panel_content_item, "ScrollView_content")
    Panel_content_item:setPosition(0, 0)

    if not self.ListView_chapter.scrollView_:isVisible() then
        ScrollView_content:setContentSize(CCSizeMake(GameConfig.WS.width,ScrollView_content:getContentSize().height))
        self.Panel_content:setPositionX(-GameConfig.WS.width/2)
    end

    local contentSize = ScrollView_content:getSize()
    self.Panel_content:addChild(Panel_content_item)
    local contentMap = self:parseMap(chapterCfg.map)
    local size = contentMap.root:Size()
    ScrollView_content:setInnerContainerSize(size)

    ScrollView_content:setBounceEnabled(true)
    contentMap.root:setPosition(ccp(size.width*contentMap.root:getAnchorPoint().x, size.height * contentMap.root:getAnchorPoint().y))
    ScrollView_content:addChild(contentMap.root)


    local foo = {}
    foo.root = Panel_content_item
    foo.ScrollView_content = ScrollView_content
    contentMap.defaultPos = contentMap.root:getPosition()
    self.contentItems_[index] = foo
    self.contentMaps_[index] = contentMap
end

function FubenTheaterLevelView:updateContent(index)
    local contentMap = self.contentMaps_[index]
    local chapterCid = self.chapter_[index]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    if chapterCfg.bottomPic then
        self.Image_bg:setTexture(chapterCfg.bottomPic)
    end
    if chapterCfg.bottomEffect then
        self.bg_spine:setFile(chapterCfg.bottomEffect)
        self.bg_spine:playByIndex(0,-1,-1,1)
    end
    local levels = FubenDataMgr:getTheaterDungeonLevel(chapterCid)
    local lastLevelCid
    local lastPositionX = 0
    local lastPositionY = 0

    local minPositionX = 0
    local minPositionY = 0
    for _, levelCid in ipairs(levels) do
        local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
        local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
        local locked = FubenDataMgr:checkTheaterLevelLocked(levelCid)
        if enabled then
            if #levelCfg.levelSite > 0 then
                local levelSite = contentMap.level
                local id = string.format("%03d", levelCfg.levelSite)
                if not self.levelItems_[levelCid] then
                    local createor = self.levelTypeCreator_[levelCfg.storydungeonType]
                    if levelSite[id] then
                        local foo = createor()
                        foo.root:Pos(0, 0):AddTo(levelSite[id])
                        self.levelItems_[levelCid] = foo
                    else
                        print("=======找不到ui控件========",id)
                    end
                end
                local updator = self.levelTypeUpdator_[levelCfg.storydungeonType]
                updator(levelCid)
                if FubenDataMgr:getTheaterLevelAni(self.exChapterId,index) then
                    self.levelItems_[levelCid].root:setVisible(enabled)
                else
                    self.levelItems_[levelCid].root:hide()
                end

                local isPass = FubenDataMgr:isPassTheaterLevel(levelCid)
                
                if self.levelItems_[levelCid].effect_hint then
                    self.levelItems_[levelCid].effect_hint:setVisible(levelCfg.isHint and not locked and not isPass )
                end

                if locked and not isPass then
                    -- 锁定
                    self.levelItems_[levelCid].root:setGrayEnabled(true)
                    if self.levelItems_[levelCid].btn then
                        self.levelItems_[levelCid].btn:setTouchEnabled(false)
                    end
                    if self.levelItems_[levelCid].panel_lock then
                        self.levelItems_[levelCid].panel_lock:show()
                    end

                    if self.levelItems_[levelCid].panel_unlock then
                        self.levelItems_[levelCid].panel_unlock:hide()
                    end
                else
                    self.levelItems_[levelCid].root:setGrayEnabled(false)
                    if self.levelItems_[levelCid].btn then
                        self.levelItems_[levelCid].btn:setTouchEnabled(true)
                    end

                    if self.levelItems_[levelCid].panel_lock then
                        self.levelItems_[levelCid].panel_lock:hide()
                    end

                    if self.levelItems_[levelCid].panel_unlock then
                        self.levelItems_[levelCid].panel_unlock:setVisible(not isPass)
                    end
                end

                if lastLevelCid then
                    local lastLevelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(lastLevelCid)
                    if levelCfg.sort > lastLevelCfg.sort then
                        lastLevelCid = levelCid
                    end
                else
                    lastLevelCid = levelCid
                end
                local x = levelSite[id]:PosX()
                lastPositionX = math.max(lastPositionX, x)
                lastPositionY = math.max(lastPositionY, levelSite[id]:PosY())

                minPositionX = math.min(minPositionX,x)
                minPositionY = math.min(minPositionY,levelSite[id]:PosY())
            end
        end

        for i, v in ipairs(levelCfg.lineSite) do
            local id = string.format("%03d", v)
            local line = contentMap.line[id]
            if line then
                local lineEnabled = FubenDataMgr:judgeTheaterCondIsEstablish(levelCid, i)
                if FubenDataMgr:getTheaterLevelAni(self.exChapterId,index) then
                    line:setVisible(lineEnabled)
                else
                    line:hide()
                end
            else
                print("=======找不到ui控件========",id)
            end
        end

        for i, v in ipairs(levelCfg.lineSite1) do
            local id = string.format("%03d", v)
            local line = contentMap.line[id]
            if line then
                local lineEnabled = FubenDataMgr:isPassTheaterLevel(levelCid)
                if FubenDataMgr:getTheaterLevelAni(self.exChapterId,index) then
                    line:setVisible(lineEnabled)
                else
                    line:hide()
                end
            end
        end
    end
    self.lastLevelCid_[index] = lastLevelCid
    if lastLevelCid then
        local contentItem = self.contentItems_[index]
        local size = contentItem.ScrollView_content:getSize()
        local innerSize = contentItem.ScrollView_content:getInnerContainer():getSize()
        if minPositionX < 0 then minPositionX = minPositionX - 170 end

        if contentMap.root:getAnchorPoint().x == 0.5 then
            minPositionX = math.min(-size.width/2,minPositionX)
        end

        local width = lastPositionX + 170 - minPositionX
        local height = lastPositionY + 160 - minPositionY
        -- -- contentMap.root:setSize(size)
        if contentMap.root:getAnchorPoint().x == 0.5 then width = width + 170 end
        -- if contentMap.root:getAnchorPoint().y == 0.5 then height = height*2 end
        width = math.max(size.width, width)
        height = math.max(size.height, height)
        contentItem.ScrollView_content:setInnerContainerSize(CCSizeMake(width,height))

        contentMap.root:setPositionX(- minPositionX )
        contentMap.root:setPositionY(math.max(size.height*(contentMap.root:getAnchorPoint().y),-minPositionY + 80))
    end
end

function FubenTheaterLevelView:moveToLevel(index, levelCid)
    index = index or self.selectChapterIndex_
    local levelItem = self.levelItems_[levelCid]
    if not levelItem then return end
    local ScrollView_content = self.contentItems_[index].ScrollView_content
    local innerContainer = ScrollView_content:getInnerContainer()

    local anchorPoint = ScrollView_content:getAnchorPoint()
    local innerSize = innerContainer:getSize()
    local contentSize = ScrollView_content:getSize()
    local center = ccp(contentSize.width * 0.5, contentSize.height * 0.5)
    local innerPos = innerContainer:getPosition()
    -- local minY = contentSize.height - innerSize.height
    local y_offset = math.min(0,contentSize.height - innerSize.height)
    local w_offset = math.min(0,contentSize.width - innerSize.width)

    local position = levelItem.root:getPosition()
    local wp = levelItem.root:getParent():convertToWorldSpaceAR(position)
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

function FubenTheaterLevelView:updateChapterItem(index)
    local chapterCid = self.chapter_[index]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
    local enabled, condEnabled, timeEnabled, levelEnabeld = FubenDataMgr:checkTheaterChapterEnabled(chapterCid)
    local item = self.ListView_chapter:getItem(index)
    local foo = self.chapterItems_[item]

    if not enabled then
        if not timeEnabled then
            foo.Image_time_lock:show()
            foo.Image_cond_lock:hide()
        elseif not levelEnabeld then
            foo.Image_cond_lock:show()
            foo.Image_time_lock:hide()
        elseif not condEnabled then
            foo.Image_cond_lock:show()
            foo.Image_time_lock:hide()
        end
    end
    foo.Label_select_order:setTextById(300971, chapterCfg.order)
    foo.Label_unselect_order:setText(chapterCfg.order)
    foo.Button_chapter:setTextureNormal(chapterCfg.pictureIcon)

    foo.Button_chapter:onClick(function()
            self:selectChapter(index)
    end)

end

function FubenTheaterLevelView:addChapterItem()
    local Panel_chapter_item = self.Panel_chapter_item:clone()
    local foo = {}
    foo.root = Panel_chapter_item
    foo.Button_chapter = TFDirector:getChildByPath(foo.root, "Button_chapter")
    foo.Label_unselect_order = TFDirector:getChildByPath(foo.root, "Label_unselect_order")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Label_select_order = TFDirector:getChildByPath(foo.Image_select, "Label_select_order")
    foo.Image_cond_lock = TFDirector:getChildByPath(foo.root, "Image_cond_lock"):hide()
    foo.Image_time_lock = TFDirector:getChildByPath(foo.root, "Image_time_lock"):hide()
    local Label_time_lock = TFDirector:getChildByPath(foo.Image_time_lock, "Label_time_lock")
    Label_time_lock:setTextById(300995)
    self.chapterItems_[foo.root] = foo
    self.ListView_chapter:pushBackCustomItem(Panel_chapter_item)
end

function FubenTheaterLevelView:addDatingCgItem()

    local foo = {}
    foo.root = self.Panel_datingCg_item:clone()
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Button_dating = TFDirector:getChildByPath(foo.root, "ClippingNode_dating.Button_dating")
    foo.bg = TFDirector:getChildByPath(foo.root, "Image_bg")
    foo.cover = TFDirector:getChildByPath(foo.root, "Image_conver")
    local effect_hint = TFDirector:getChildByPath(foo.root, "effect_hint")
    effect_hint:playByIndex(0,-1,-1,1)
    foo.effect_hint = effect_hint
    foo.btn = foo.Button_dating
    return foo
end

function FubenTheaterLevelView:addLastFightingItem()
    local Panel_fighting_item1 = self.Panel_fighting_item1:clone()
    local foo = {}
    foo.root = Panel_fighting_item1
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Button_fight = TFDirector:getChildByPath(foo.root, "ClippingNode_fight.Button_fight")
    foo.Image_star = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_star_" .. i)
        bar.Image_star_light = TFDirector:getChildByPath(bar.root, "Image_star_light")
        foo.Image_star[i] = bar
    end
    local effect_hint = TFDirector:getChildByPath(foo.root, "effect_hint")
    effect_hint:playByIndex(0,-1,-1,1)
    foo.effect_hint = effect_hint
    foo.btn = foo.Button_fight
    return foo
end

function FubenTheaterLevelView:addOptionItem()
    local Panel_option_item = self.Panel_option_item:clone()
    local foo = {}
    foo.root = Panel_option_item
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Label_lock_option = TFDirector:getChildByPath(foo.Image_lock, "Label_lock_option")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Label_select_option = TFDirector:getChildByPath(foo.Image_select, "Label_select_option")

    return foo
end

function FubenTheaterLevelView:addConditionItem()
    local Panel_condition_item = self.Panel_condition_item:clone()
    local foo = {}
    foo.root = Panel_condition_item
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Label_lock_condition = TFDirector:getChildByPath(foo.Image_lock, "Label_lock_condition")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Label_select_condition = TFDirector:getChildByPath(foo.Image_select, "Label_select_condition")

    return foo
end

function FubenTheaterLevelView:addFightResultItem()
    local Panel_fightresult_item = self.Panel_fightresult_item:clone()
    local foo = {}
    foo.root = Panel_fightresult_item
    foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
    foo.Label_lock_condition = TFDirector:getChildByPath(foo.Image_lock, "Label_lock_condition")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Label_select_condition = TFDirector:getChildByPath(foo.Image_select, "Label_select_condition")

    return foo
end

function FubenTheaterLevelView:addFightingMainItem()
    local foo = {}
    foo.root = self.Panel_fighting_main_item:clone()
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Button_level = TFDirector:getChildByPath(foo.root, "Button_level")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_star = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_star_" .. i)
        bar.Image_star_light = TFDirector:getChildByPath(bar.root, "Image_star_light")
        foo.Image_star[i] = bar
    end
    local effect_hint = TFDirector:getChildByPath(foo.root, "effect_hint")
    effect_hint:playByIndex(0,-1,-1,1)
    foo.effect_hint = effect_hint
    foo.btn = foo.Button_level
    return foo
end

function FubenTheaterLevelView:addDatingMainItem()

    local foo = {}
    foo.root = self.Panel_dating_main_item:clone()
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Button_dating = TFDirector:getChildByPath(foo.root, "Button_dating")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_star = TFDirector:getChildByPath(foo.root, "Image_star")
    foo.Image_star_light = TFDirector:getChildByPath(foo.Image_star, "Image_star_light")
    local effect_hint = TFDirector:getChildByPath(foo.root, "effect_hint")
    effect_hint:playByIndex(0,-1,-1,1)
    foo.effect_hint = effect_hint
    foo.btn = foo.Button_dating
    return foo
end

function FubenTheaterLevelView:addBossItem()
    local Panel_boss_item = self.Panel_boss_item:clone()
    local foo = {}
    foo.root = Panel_boss_item
    foo.Button_boss = TFDirector:getChildByPath(foo.root, "Button_boss")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")

    foo.Image_star = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_star_" .. i)
        bar.Image_star_light = TFDirector:getChildByPath(bar.root, "Image_star_light")
        foo.Image_star[i] = bar
    end
    foo.btn = foo.Button_boss
    return foo
end

function FubenTheaterLevelView:addJuNaiBossItem()
    local Panel_fighting_boss_itemHuoShou = self.Panel_fighting_boss_itemHuoShou:clone()
    local foo = {}
    foo.root = Panel_fighting_boss_itemHuoShou
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Button_level = TFDirector:getChildByPath(foo.root, "Button_level")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_star = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_star_" .. i)
        bar.Image_star_light = TFDirector:getChildByPath(bar.root, "Image_star_light")
        foo.Image_star[i] = bar
    end
    local effect_hint = TFDirector:getChildByPath(foo.root, "effect_hint")
    effect_hint:playByIndex(0,-1,-1,1)
    foo.effect_hint = effect_hint
    foo.btn = foo.Button_level
    return foo
end

function FubenTheaterLevelView:addBossFightItem()
    local Panel_boss_item = self.Panel_boss_fight_item:clone()
    local foo = {}
    foo.root = Panel_boss_item
    foo.Button_boss = TFDirector:getChildByPath(foo.root, "Button_boss")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.btn = foo.Button_boss
    return foo
end

function FubenTheaterLevelView:addFightingBranchItem()
    local Panel_fighting_branch_item
    if self.exChapterId == EC_FUBENTHEATER_ID.JuNai then
        Panel_fighting_branch_item = self.Panel_fighting_branch_itemHuoShou:clone()
    else
        Panel_fighting_branch_item = self.Panel_fighting_branch_item:clone()
    end
    local foo = {}
    foo.root = Panel_fighting_branch_item
    foo.Button_level = TFDirector:getChildByPath(foo.root, "Button_level")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_star = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.root, "Image_star_" .. i)
        bar.Image_star_light = TFDirector:getChildByPath(bar.root, "Image_star_light")
        foo.Image_star[i] = bar
    end

    return foo
end

function FubenTheaterLevelView:addDatingBranchItem()
    local Panel_dating_branch_item
    if self.exChapterId == EC_FUBENTHEATER_ID.JuNai then
        Panel_dating_branch_item = self.Panel_dating_branch_itemHuoShou:clone()
    else
        Panel_dating_branch_item = self.Panel_dating_branch_item:clone()
    end
    local foo = {}
    foo.root = Panel_dating_branch_item
    foo.Button_dating = TFDirector:getChildByPath(foo.root, "Button_dating")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Image_star = TFDirector:getChildByPath(foo.root, "Image_star")
    foo.Image_star_light = TFDirector:getChildByPath(foo.Image_star, "Image_star_light")

    return foo
end

function FubenTheaterLevelView:updateDatingMainItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    foo.Image_icon:setTexture(levelCfg.icon)
    local starNum = FubenDataMgr:getStarNum(levelCid)
    foo.Image_star_light:setVisible(starNum == 1)

    if self.exChapterCfg.datingItemRes.bg then
        foo.Button_dating:setTextureNormal(self.exChapterCfg.datingItemRes.bg)
    end
    if self.exChapterCfg.datingItemRes.color then
        foo.Label_name:setColor(Utils:covertToColorRGB(self.exChapterCfg.datingItemRes.color))
    end

    foo.Button_dating:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end

function FubenTheaterLevelView:updateBossItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    foo.Button_boss:setTextureNormal(levelCfg.icon)
    foo.Image_star[1].root:hide()
    foo.Image_star[2].root:hide()
    foo.Image_star[3].root:hide()
    foo.Button_boss:onClick(function()
        Utils:openView("fuben.NewFubenTheaterHardLevelView", nil, nil,levelCfg.speTypeParam.chapterId,true)
    end)
end

function FubenTheaterLevelView:updateBossItem1(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    foo.Button_boss:setTextureNormal(levelCfg.icon)
    for i, v in ipairs(foo.Image_star) do
        local num = FubenDataMgr:getStarNum(levelCid)
        v.Image_star_light:setVisible(i<=num)
    end
    foo.Button_boss:onClick(function()
        local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
        if enabled then
            Utils:openView("fuben.FubenReadyView", levelCid)
        else
            dump(levelCid)
        end
    end)
end

function FubenTheaterLevelView:updateJuNaiBossItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Image_icon:setTexture(levelCfg.icon)
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    for i, v in ipairs(foo.Image_star) do
        local num = FubenDataMgr:getStarNum(levelCid)
        v.Image_star_light:setVisible(i<=num)
    end
    
    foo.Button_level:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end


function FubenTheaterLevelView:updateBossFightItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    foo.Button_boss:setTextureNormal(levelCfg.icon)

    foo.Button_boss:onClick(function()
        local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
        if enabled then
            Utils:openView("fuben.FubenReadyView", levelCid)
        else
            dump(levelCid)
        end
    end)
end

function FubenTheaterLevelView:updateFightingMainItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Image_icon:setTexture(levelCfg.icon)
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    local starNum = FubenDataMgr:getStarNum(levelCid)
    for i, v in ipairs(foo.Image_star) do
        v.Image_star_light:setVisible(i <= starNum)
    end
    if self.exChapterCfg.fightItemRes.bg then
        foo.Button_level:setTextureNormal(self.exChapterCfg.fightItemRes.bg)
    end 

    if self.exChapterCfg.fightItemRes.color then
        foo.Label_name:setColor(Utils:covertToColorRGB(self.exChapterCfg.fightItemRes.color))
    end 

    foo.Button_level:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end

function FubenTheaterLevelView:updateLastFightingItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Button_fight:setTextureNormal(levelCfg.icon)
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    for i, v in ipairs(foo.Image_star) do
        local num = FubenDataMgr:getStarNum(levelCid)
        v.Image_star_light:setVisible(i<=num)
    end

    foo.Button_fight:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end

function FubenTheaterLevelView:updateDatingBranchItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    local starNum = FubenDataMgr:getStarNum(levelCid)
    foo.Image_star_light:setVisible(starNum == 1)

    foo.Button_dating:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end



function FubenTheaterLevelView:updateFightingBranchItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    for i, v in ipairs(foo.Image_star) do
        local num = FubenDataMgr:getStarNum(levelCid)
        v.Image_star_light:setVisible(i<=num)
    end

    foo.Button_level:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else
                dump(levelCid)
            end
    end)
end

function FubenTheaterLevelView:updateOptionItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local isPass = FubenDataMgr:isPassTheaterLevel(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_lock_option:setTextById(levelCfg.storydungeonName)
    foo.Label_select_option:setTextById(levelCfg.storydungeonName)
    foo.Image_lock:setVisible(not isPass)
    foo.Image_select:setVisible(isPass)
end

function FubenTheaterLevelView:updateConditionItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local isPass = FubenDataMgr:isPassTheaterLevel(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_lock_condition:setTextById(levelCfg.storydungeonName)
    foo.Label_select_condition:setTextById(levelCfg.storydungeonName)
    foo.Image_lock:setVisible(not isPass)
    foo.Image_select:setVisible(isPass)
end

function FubenTheaterLevelView:updateFightResultItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local isPass = FubenDataMgr:condIsActivity(levelCfg.activeIf)
    local foo = self.levelItems_[levelCid]
    foo.Label_lock_condition:setTextById(levelCfg.storydungeonName)
    foo.Label_select_condition:setTextById(levelCfg.storydungeonName)
    foo.Image_lock:setVisible(not isPass)
    foo.Image_select:setVisible(isPass)
end

function FubenTheaterLevelView:updateDatingCgItem(levelCid)
    local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
    local foo = self.levelItems_[levelCid]
    foo.Label_name:setTextById(levelCfg.storydungeonName)
    foo.Button_dating:setTextureNormal(levelCfg.icon)

    foo.bg:setTexture(self.exChapterCfg.cgItemRes.bg)
    foo.cover:setTexture(self.exChapterCfg.cgItemRes.coverbg)
    
    foo.Button_dating:onClick(function()
            local enabled = FubenDataMgr:checkTheaterLevelEnabled(levelCid)
            if enabled then
                Utils:openView("fuben.FubenReadyView", levelCid)
            else

            end
    end)
end

function FubenTheaterLevelView:playTheaterInfoAni(isOpen)
    local x = isOpen and self.expandX_ or self.collapseX_
    local y = self.Image_theater_info:PosY()
    self.Button_expand:setVisible(not isOpen)
    self.Button_collapse:setVisible(isOpen)
    local action = Sequence:create({
            MoveTo:create(0.3, ccp(x, y)),
            CallFunc:create(function()
                    -- self.Button_expand:setVisible(not isOpen)
                    -- self.Button_collapse:setVisible(isOpen)
            end)
    })
    self.Image_theater_info:stopAllActions()
    self.Image_theater_info:runAction(action)
end

function FubenTheaterLevelView:updateTheaterInfo()
    if self.exChapterCfg.titlePlaneType ~= 2 then
        return
    end
    self.Image_theater_info:show()

    local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
    local levelCid = theaterBossInfo.bossDungeonId
    self.Label_theater_noOpen:hide()
    if theaterBossInfo.odeumType == EC_TheaterBossType.LINGBO  then
        local canChallenge = levelCid ~= 0
        self.Button_theater_challenge:setVisible(canChallenge)
        self.Label_theater_noOpen:setVisible(not canChallenge)
        local curLingbo = theaterBossInfo.lingbo
        local lingboGroup = theaterBossInfo.lingboGroup
        local maxLingbo = lingboGroup[#lingboGroup]
        if canChallenge then
            local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
            if theaterBossInfo.status == EC_TheaterStatus.ING then
                self.Label_theater_challenge:setTextById(300967)
                self.Label_theater_tips_1:show():setTextById(300973)
                self.Label_theater_tips_2:show()
            elseif theaterBossInfo.status == EC_TheaterStatus.CLEARING then
                self.Label_theater_challenge:setTextById(300992)
                self.Label_theater_tips_1:show():setTextById(300989)
                self.Label_theater_tips_2:hide()
            end
            self.Label_theater_name:setTextById(levelCfg.name)
            self:updateTheaterTiming()
            for i, v in ipairs(self.Image_theater_icon) do
                v:hide()
            end
            self.Image_theater_icon_boss:show()
        else
            self.Label_theater_challenge:setTextById(300967)
            local curStage
            local size = self.LoadingBar_lingbo:getSize()
            local anchorPointInPoints = self.LoadingBar_lingbo:getAnchorPointInPoints()
            for i, v in ipairs(self.Image_percent_tag) do
                if curStage then
                    if curLingbo > lingboGroup[i] then
                        curStage = i
                    end
                else
                    curStage = i
                end
                local lingbo = lingboGroup[i]
                v:setVisible(tobool(v))
                if lingbo then
                    local rate = lingbo / maxLingbo
                    local x = size.width * rate - size.width * 0.5
                    v:PosX(x)
                end
            end
            local nextStage = math.min(#lingboGroup, curStage + 1)
            for i, v in ipairs(self.Image_theater_icon) do
                v:setVisible(i == nextStage)
            end
            self.Image_theater_icon_boss:hide()
            local percent = math.min(1, curLingbo / lingboGroup[nextStage])
            self.Label_theater_tips_1:show():setTextById(300969)
            self.Label_theater_tips_2:show():setTextById("r301000", Utils:format_number_w(curLingbo),
                                                         Utils:format_number_w(lingboGroup[nextStage]),
                                                         string.format("%0.2f", percent * 100))
            self.Label_theater_noOpen:setTextById(300970)
            self.Label_theater_name:setTextById(300968)
        end
        local percent = curLingbo / maxLingbo
        self.LoadingBar_lingbo:setPercent(percent * 100)
        self.Image_theater_progress:show()
    else
        self.Label_theater_tips_1:show()
        self.Label_theater_tips_2:show()
        self.Button_theater_challenge:setVisible(theaterBossInfo.status ~= EC_TheaterStatus.CLOSING)
        self.Image_theater_progress:hide()
        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
        self.Label_theater_name:setTextById(levelCfg.name)
        for i, v in ipairs(self.Image_theater_icon) do
            v:hide()
        end
        self.Image_theater_icon_boss:show()

        if theaterBossInfo.status == EC_TheaterStatus.ING then
            self.Label_theater_tips_1:setTextById(12010164)
        elseif theaterBossInfo.status == EC_TheaterStatus.CLOSING then
            self.Label_theater_tips_1:setTextById(300969)
        elseif theaterBossInfo.status == EC_TheaterStatus.CLEARING then
            self.Label_theater_tips_1:setTextById(300989)
        end
        self:updateTheaterTiming()
    end
end

function FubenTheaterLevelView:updateTheaterTiming()
    local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
    local remainTime = math.max(0, theaterBossInfo.closeTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day ~= "00" then
        self.Label_theater_tips_2:setTextById(800044, day, hour, min)
    else
        self.Label_theater_tips_2:setTextById(800027, hour, min)
    end
end

function FubenTheaterLevelView:playLevelAni(index)
    local contentMap = self.contentMaps_[index]
    local contentItem = self.contentItems_[index]
    local chapterCid = self.chapter_[index]
    local groupLevels = FubenDataMgr:getTheaterGroupLevels(chapterCid)
    local enabled = false
    local groupIndex = self.aniGroupIndex_[index]
    local levels = clone(groupLevels[groupIndex])
    local delay = 0
    if levels then
        table.sort(levels, function(a, b)
                       local levelCfgA = FubenDataMgr:getTheaterDungeonLevelCfg(a)
                       local levelCfgB = FubenDataMgr:getTheaterDungeonLevelCfg(b)
                       return levelCfgA.sortShow < levelCfgB.sortShow
        end)
        local enabled = false
        for _, levelCid in ipairs(levels) do
            if self.levelItems_[levelCid] then
                enabled = true
                break
            end
        end
        if not enabled then return 0 end
        delay = 0
        for i, levelCid in ipairs(levels) do
            local levelCfg = FubenDataMgr:getTheaterDungeonLevelCfg(levelCid)
            local levelItem = self.levelItems_[levelCid]
            if levelItem then
                levelItem.root:setOpacity(0)
                local seq = {}
                if levelCfg.groupCenter == 1 then
                    delay = delay + 0.2
                    self:moveToLevel(index, levelCid)
                end
                local aniSeq = Sequence:create({
                        DelayTime:create(delay),
                        Show:create(),
                        FadeIn:create(0.2),
                })
                levelItem.root:runAction(aniSeq)

                for j, v in ipairs(levelCfg.lineSite) do
                    local id = string.format("%03d", v)
                    local line = contentMap.line[id]
                    local lineEnabled = FubenDataMgr:judgeTheaterCondIsEstablish(levelCid, j)
                    if line and lineEnabled then
                        line:setOpacity(0)
                        local aniSeq = Sequence:create({
                                DelayTime:create(delay),
                                Show:create(),
                                FadeIn:create(0.2),
                        })
                        line:runAction(aniSeq)
                    end
                end

                for j, v in ipairs(levelCfg.lineSite1) do
                    local id = string.format("%03d", v)
                    local line = contentMap.line[id]
                    local lineEnabled = FubenDataMgr:isPassTheaterLevel(levelCid)
                    if line and lineEnabled then
                        line:setOpacity(0)
                        local aniSeq = Sequence:create({
                                DelayTime:create(delay + 0.2),
                                Show:create(),
                                FadeIn:create(0.2),
                        })
                        line:runAction(aniSeq)
                    end
                end
                delay = delay + 0.1
            end
        end

        local newTime = delay
        local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
        if chapterCfg.isPlayAniSync then 
            newTime = 0
        end
        self:timeOut(
            function()
                self.aniGroupIndex_[index] = self.aniGroupIndex_[index] + 1
                self:playLevelAni(index)
            end,
            newTime
        )
    else
        self.processContro:init(self,self.chapterCid,3)
    end
    return delay 
end

function FubenTheaterLevelView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_BOSS_INFO, handler(self.onTheaterBossInfoEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_LEVELGROUPREWARD, handler(self.onGetLevelGroupRewardEvent, self))

    self.Button_hard:onClick(function()
            local chapter = FubenDataMgr:getTheaterHardChapter(self.exChapterId)
            local chapterCfg = FubenDataMgr:getChapterCfg(chapter[1])
            if MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel then
                Utils:openView("fuben.NewFubenTheaterHardLevelView",nil, nil,self.exChapterId,true)
            else
                Utils:showTips(12010142, chapterCfg.unlockLevel)
            end
    end)

    self.Button_collapse:onClick(function()
            self:playTheaterInfoAni(false)
    end)

    self.Button_expand:onClick(function()
            self:playTheaterInfoAni(true)
    end)

    self.Button_theater_challenge:onClick(function()
        --Utils:openView("fuben.FubenTheaterBossView")
        local chapter = FubenDataMgr:getChapter(EC_FBType.THEATER_HARD)
        local chapterCid = chapter[1]
        local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
        if MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel then
            local fubenCheckCfg = {[3] = {7,chapterCfg.id},[6] = {8,chapterCfg.id},[7] = {9,chapterCfg.id}}
            local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
            if fubenCheckParam then
                if DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.THEATER) then
                    return
                end
                local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
                if checkExtId then
                    TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                        Utils:openView("fuben.FubenTheaterBossView")
                    end,true)
                    return
                else
                    TFAssetsManager:downloadHeroAssets(function()
                        Utils:openView("fuben.FubenTheaterBossView")
                    end,true)
                end
            end
        else
            Utils:showTips(12010142, chapterCfg.unlockLevel)
        end
    end)

    self.Button_reward_receive:onClick(function()
            local chapterCid = self.chapter_[self.selectChapterIndex_]
            local levelGroup = FubenDataMgr:getLevelGroup(chapterCid)
            Utils:openView("fuben.FubenStarRewardView", levelGroup[1], EC_FBDiff.SIMPLE)
    end)

    self.Button_reward_geted:onClick(function()
            local chapterCid = self.chapter_[self.selectChapterIndex_]
            local levelGroup = FubenDataMgr:getLevelGroup(chapterCid)
            Utils:openView("fuben.FubenStarRewardView", levelGroup[1], EC_FBDiff.SIMPLE)
    end)

    self.Button_buffTip:onClick(function ( ... )
        self.content_tip:setVisible(not self.content_tip:isVisible())
    end)
end

function FubenTheaterLevelView:onTheaterBossInfoEvent(theaterInfo)
    self:updateTheaterInfo()
end

function FubenTheaterLevelView:onGetLevelGroupRewardEvent()
    self:updateStartRewardState()
end

return FubenTheaterLevelView
