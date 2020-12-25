
local FubenReadyView = class("FubenReadyView", BaseLayer)

function FubenReadyView:initData(levelCid,paramData)
    self.levelCid_ = levelCid
    self.levelCfg_ = FubenDataMgr:getLevelCfg(levelCid)
    self.levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(self.levelCfg_.levelGroupId)
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.levelGroupCfg_.dungeonChapterId)
    self.challengeCount_ = 0
    self.fubenType_ = FubenDataMgr:getFubenType(self.levelCid_)
    local cost = self.levelCfg_.cost
    if cost then
        self.costCid_ = cost[1]
        self.costNum_ = cost[2]
    end
    self.earningsCostCid_, self.earningsCostNum_ = next(self.levelCfg_.duelModCost)
    self.paramData = paramData
    FubenDataMgr:cacheSelectFubenType(self.chapterCfg_.type)
    FubenDataMgr:cacheSelectLevelGroup(self.levelCfg_.levelGroupId)
    FubenDataMgr:cacheSelectChapter(self.levelGroupCfg_.dungeonChapterId)
    FubenDataMgr:cacheSelectLevel(self.levelCid_)

    local cardPrivilegeFreeNum = FubenDataMgr:getFreePrivilegeNumById(levelCid)
    self.cfgFightCount = self.levelCfg_.fightCount + cardPrivilegeFreeNum
end

function FubenReadyView:ctor(levelCid,paramData)
    self.super.ctor(self)
    self:initData(levelCid,paramData)
    self:showPopAnim(true)

    if self.fubenType_ == EC_FBType.HWX_FUBEN then
        self:init("lua.uiconfig.linkageHwx.fubenReadyView")
    else
        self:init("lua.uiconfig.fuben.fubenReadyView")
    end

end

function FubenReadyView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    self.Image_title_line = TFDirector:getChildByPath(Image_content, "Image_title_line")
    self.Label_englishName = TFDirector:getChildByPath(Image_content, "Label_englishName")

    self.Panel_fighting = TFDirector:getChildByPath(Image_content, "Panel_fighting"):hide()
    local Image_cond = TFDirector:getChildByPath(self.Panel_fighting, "Image_cond")
    self.Label_condTitle = TFDirector:getChildByPath(Image_cond, "Label_condTitle")
    self.Label_condTitle2 = TFDirector:getChildByPath(Image_cond, "Label_condTitle2")
    self.Label_cond = TFDirector:getChildByPath(Image_cond, "Label_cond")
    local Image_target = TFDirector:getChildByPath(self.Panel_fighting, "Image_target")
    self.Image_target = Image_target
    self.Label_targetTitle = TFDirector:getChildByPath(Image_target, "Label_targetTitle")
    self.Label_targetTitle2 = TFDirector:getChildByPath(Image_target, "Label_targetTitle2")
    self.Panel_target = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(Image_target, "Panel_target_" .. i)
        item.Image_star = TFDirector:getChildByPath(item.root, "Image_star")
        item.Image_star_gray = TFDirector:getChildByPath(item.root, "Image_star_gray")
        item.Label_target = TFDirector:getChildByPath(item.root, "Label_target")
        item.Label_target_gray = TFDirector:getChildByPath(item.root, "Label_target_gray")
        item.Image_line = TFDirector:getChildByPath(item.root, "Image_line")
        item.Image_multiple = TFDirector:getChildByPath(item.root, "Image_multiple"):hide()
        item.Label_multiple = TFDirector:getChildByPath(item.Image_multiple, "Label_multiple")
        self.Panel_target[i] = item
    end
    self.Image_fight_info = TFDirector:getChildByPath(self.Panel_fighting, "Image_fight_info"):hide()
    self.Button_buyCount = TFDirector:getChildByPath(self.Image_fight_info, "Button_buyCount")
    self.Label_remainCount = TFDirector:getChildByPath(self.Image_fight_info, "Label_remainCount")
    self.Label_count = TFDirector:getChildByPath(self.Image_fight_info, "Label_count")
    self.Label_fighting_reward = TFDirector:getChildByPath(self.Panel_fighting, "Label_fighting_reward")
    self.Button_ready = TFDirector:getChildByPath(self.Panel_fighting, "Button_ready")
    self.Label_ready = TFDirector:getChildByPath(self.Button_ready, "Label_ready")
    self.Panel_buffer = TFDirector:getChildByPath(self.Panel_fighting, "Panel_buffer"):hide()
    self.Label_buffer = TFDirector:getChildByPath(self.Panel_buffer, "Label_buffer")
    self.Panel_earnings = TFDirector:getChildByPath(self.Panel_fighting, "Panel_earnings"):hide()
    self.CheckBox_earnings = TFDirector:getChildByPath(self.Panel_earnings, "CheckBox_earnings")
    self.Label_earnings_mode = TFDirector:getChildByPath(self.Panel_earnings, "Label_earnings_mode")
    local Image_earnings_cost = TFDirector:getChildByPath(self.Panel_earnings, "Image_earnings_cost")
    self.Image_earnings_costIcon = TFDirector:getChildByPath(Image_earnings_cost, "Image_earnings_costIcon")
    self.Label_earnings_costCount = TFDirector:getChildByPath(Image_earnings_cost, "Label_earnings_costCount")
    self.Image_multiple_reward = TFDirector:getChildByPath(self.Panel_fighting, "Image_multiple_reward"):hide()
    self.Label_multiple_reward = TFDirector:getChildByPath(self.Image_multiple_reward, "Label_multiple_reward")
    self.Label_multiple_desc = TFDirector:getChildByPath(self.Image_multiple_reward, "Label_multiple_desc")
    self.Button_select = TFDirector:getChildByPath(self.Panel_fighting, "Button_select"):hide()

    self.Panel_dating = TFDirector:getChildByPath(Image_content, "Panel_dating"):hide()
    local Image_datingDesc = TFDirector:getChildByPath(self.Panel_dating, "Image_datingDesc")
    self.Label_datingDescTitle = TFDirector:getChildByPath(Image_datingDesc, "Label_datingDescTitle")
    self.Label_datingDescTitle2 = TFDirector:getChildByPath(Image_datingDesc, "Label_datingDescTitle2")
    self.Label_datingDesc = TFDirector:getChildByPath(Image_datingDesc, "Label_datingDesc")
    local Image_datingTarget = TFDirector:getChildByPath(self.Panel_dating, "Image_datingTarget")
    self.Label_datingTargetTitle = TFDirector:getChildByPath(Image_datingTarget, "Label_datingTargetTitle")
    self.Label_datingTargetTitle2 = TFDirector:getChildByPath(Image_datingTarget, "Label_datingTargetTitle2")
    self.Label_datingTarget = TFDirector:getChildByPath(Image_datingTarget, "Label_datingTarget")
    self.Label_datingTarget_gray = TFDirector:getChildByPath(Image_datingTarget, "Label_datingTarget_gray")
    self.Image_datingStar = TFDirector:getChildByPath(Image_datingTarget, "Image_datingStar")
    self.Image_datingStar_gray = TFDirector:getChildByPath(Image_datingTarget, "Image_datingStar_gray")
    self.Label_dating_reward = TFDirector:getChildByPath(self.Panel_dating, "Label_dating_reward")
    self.Button_dating = TFDirector:getChildByPath(self.Panel_dating, "Button_dating")
    self.Label_dating = TFDirector:getChildByPath(self.Button_dating, "Label_dating")

    self.Button_cost = TFDirector:getChildByPath(Image_content, "Button_cost"):hide()
    self.Panel_costPos = TFDirector:getChildByPath(Image_content, "Panel_costPos"):hide()
    self.Label_costNum = TFDirector:getChildByPath(self.Button_cost, "Label_costNum")
    self.Image_costIcon = TFDirector:getChildByPath(self.Button_cost, "Image_costIcon")
    self.Label_cost = TFDirector:getChildByPath(self.Button_cost, "Label_cost")
    self.Panel_reward = TFDirector:getChildByPath(Image_content, "Panel_reward")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_reward, "ScrollView_reward")
    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setColumn(2)
    self.GridView_reward:setColumnMargin(10)
    self.GridView_reward:setRowMargin(10)
    local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
    Panel_dropGoodsItem:Scale(0.65)
    self.GridView_reward:setItemModel(Panel_dropGoodsItem)
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")
    self.Image_earnings_multiple = TFDirector:getChildByPath(self.Panel_reward, "Image_earnings_multiple"):hide()
    self.Label_earnings_multiple = TFDirector:getChildByPath(self.Image_earnings_multiple, "Label_earnings_multiple")

    self.Image_earnings_multiple = TFDirector:getChildByPath(self.Panel_reward, "Image_earnings_multiple"):hide()
    --模拟试炼关卡描述
    self.Image_target_desc = TFDirector:getChildByPath(self.Panel_fighting, "Image_target_desc"):hide()
    self.Image_target_desc.Label_plot_des = TFDirector:getChildByPath(self.Image_target_desc, "Label_plot_des")
    TFDirector:getChildByPath(self.Image_target_desc, "Label_targetDescTitle"):setTextById(2108057)
    TFDirector:getChildByPath(self.Image_target_desc, "Label_targetDescTitle2"):setTextById(2108058)

    --创建克制icon
    -- local startPos = self.Image_multiple_reward:getPosition() + ccp(220 , 0)
    -- self.panel_elements = Utils:createElementPanel( self.Panel_fighting ,3 , startPos , 55 )
    
    self:refreshView()
end

function FubenReadyView:refreshView()
    local levelType = self.levelCfg_.dungeonType
    self.Panel_dating:hide()
    if levelType == EC_FBLevelType.FIGHTING or levelType == EC_FBLevelType.THEATER_FIGHTING or levelType == EC_FBLevelType.HWX then
        self.Panel_fighting:show()
        self:updateFighting()
    elseif levelType == EC_FBLevelType.DATING or levelType == EC_FBLevelType.THEATER_DATING or levelType == EC_FBLevelType.CITYDATING then
        self.Panel_dating:show()
        self:updateDating()
    end

    local size = self.Label_name:Size()
    local position = self.Label_name:getPosition()
    local x = position.x + size.width + 5
    self.Image_title_line:PosX(x)
    x = x + 5
    self.Label_englishName:PosX(x)

    local flag = GlobalVarDataMgr:getValue(GV_FUBEN_PREPLOT_FLAG)
    if not flag and self.levelCfg_.preDialog ~= 0 and not FubenDataMgr:isPassPlotLevel(self.levelCid_) then
        GlobalVarDataMgr:setValue(GV_FUBEN_PREPLOT_FLAG, true)
        self.Panel_root:hide()
        self.Panel_root:timeOut(function()
                self:playPrePlot()
        end)
    end
end

function FubenReadyView:playPrePlot()
    local function callback()
        KabalaTreeDataMgr:playStory(1, self.levelCfg_.preDialog,function ()
                                        EventMgr:dispatchEvent(EV_CG_END, function()
                                                                   self.Panel_root:show()
                                        end)
        end)
    end
    KabalaTreeDataMgr:openCgView("kabalaTree.KabalaTreeCg", callback)
end

function FubenReadyView:updateFighting()
    local isPass = FubenDataMgr:isPassPlotLevel(self.levelCid_)
    self.Label_condTitle:setTextById(300826, TextDataMgr:getText(300822))
    local desc = ""
    for i, v in ipairs(self.levelCfg_.victoryType) do
        desc = desc .. FubenDataMgr:getPassCondDesc(self.levelCid_, i)
        if i < #self.levelCfg_.victoryType then
            desc = desc .. ", "
        end
    end
    self.Label_cond:setText(desc)
    self.Button_buyCount:setVisible(self.levelCfg_.isBuy)
-- Box("xx:"..tostring(self.levelCfg_.superType))


    if FubenDataMgr:isSimulationGroup(1,self.levelCfg_.levelGroupId) then
        self.Image_target:hide()
        self.Image_target_desc:show()
        self.Image_target_desc.Label_plot_des:setTextById(self.levelCfg_.plotBrief)
    elseif self.levelCfg_.isHideTarget then
        self.Image_target:hide()
        self.Image_target_desc:hide()
    else

        local starResLight,starResDark
        local isSimulation = FubenDataMgr:isSimulationGroup(2,self.levelCfg_.levelGroupId)
        if isSimulation then
            local simulationId = FubenDataMgr:getSelectSimulationHeroId()
            local cfg = FubenDataMgr:getSimulationTrialCfg(simulationId)
            if cfg then
                starResLight,starResDark = cfg.ready.starlight,cfg.ready.stardark
            end
        end

        self.Image_target:show()
        self.Image_target_desc:hide()
        self.Label_targetTitle:setTextById(300826, TextDataMgr:getText(300836))
        for i, v in ipairs(self.Panel_target) do
            local isReach = FubenDataMgr:judgeStarIsActive(self.levelCid_, i)
            local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, i)

            v.Label_target:setText(desc)
            v.Label_target_gray:setText(desc)
            v.Label_target:setVisible(isReach)
            v.Label_target_gray:setVisible(not isReach)
            v.Image_star:setVisible(isReach)
            v.Image_star_gray:setVisible(not isReach)
            if starResLight  then
                v.Image_star:setTexture(starResLight)
            end
            if starResDark  then
                v.Image_star_gray:setTexture(starResDark)
            end
            v.Image_line:setVisible(i < #self.Panel_target)

            if self.levelCfg_.dungeonType == EC_FBLevelType.HWX then
                local starParam = self.levelCfg_.starParam[i]
                if not starParam then
                    v.root:hide()
                end
            end
        end
    end
    self.Label_remainCount:setTextById(3004031)
    if self.cfgFightCount > 0 then
        self.Image_fight_info:show()
        local remainCount = FubenDataMgr:getPlotLevelRemainFightCount(self.levelCid_)
        self.Label_count:setTextById(800005, remainCount, self.cfgFightCount)
    end

    self.Button_cost:setTouchEnabled(false)
    local cost = self.levelCfg_.cost[1]
    if cost then
        local costItemCfg = GoodsDataMgr:getItemCfg(cost[1])
        self.Image_costIcon:setTexture(costItemCfg.icon)
        self.Label_costNum:setText(cost[2])
        self.Button_cost:show()
        self.Button_select:setVisible(#self.levelCfg_.quickBattleParameter > 0)
        if self.Button_select:isVisible() then
            self.Button_cost:Pos(self.Panel_costPos:Pos())
        end
    end
    self.Label_cost:setTextById(300020)

    local levelGroupType = self.levelGroupCfg_.dungeonType
    local showReward = {}
    local realDropCid
    local fbType = self.chapterCfg_.type
    local isFirstPass = false
    if fbType == EC_FBType.PLOT or fbType == EC_FBType.THEATER or fbType == EC_FBType.THEATER_HARD  or fbType == EC_FBType.LINKAGE
        or fbType == EC_FBType.HWX_FUBEN then
        local name = FubenDataMgr:getLevelName(self.levelCid_)
        self.Label_name:setText(name)
        local isRandomDrop = FubenDataMgr:isPassPlotLevel(self.levelCid_)
        if isRandomDrop then
            self.Label_fighting_reward:setTextById(300826, TextDataMgr:getText(300837))
            showReward = self.levelCfg_.dropShow
            realDropCid = self.levelCfg_.reward
        else
            self.Label_fighting_reward:setTextById(300826, TextDataMgr:getText(300127))
            showReward = self.levelCfg_.firstDropShow
            realDropCid = self.levelCfg_.firstReward
            isFirstPass = true
        end
        showReward = isRandomDrop and self.levelCfg_.dropShow or self.levelCfg_.firstDropShow
        if self.levelCfg_.isDuelMod and isPass then
            self.Panel_earnings:show()
            self.Label_earnings_mode:setTextById(350001)
            local costCfg = GoodsDataMgr:getItemCfg(self.earningsCostCid_)
            self.Image_earnings_costIcon:setTexture(costCfg.icon)
            self.Label_earnings_costCount:setTextById(800005, self.earningsCostNum_, GoodsDataMgr:getItemCount(self.earningsCostCid_))
            self.Image_earnings_costIcon:onClick(function()
                    Utils:showInfo(self.earningsCostCid_)
            end)
            local skillCfg = TabDataMgr:getData("PassiveSkills", self.levelCfg_.duelModSkills)
            self.Label_buffer:setTextById(skillCfg.des)
            local multiple = Utils:getKVP(11004, self.levelCfg_.difficulty)
            self.Label_earnings_multiple:setTextById(800007, multiple)
        end
    elseif fbType == EC_FBType.DAILY or fbType == EC_FBType.ACTIVITY  then

        self.Image_multiple_reward:show()
        self.Label_name:setTextById(self.levelCfg_.name)
        self.Label_fighting_reward:setTextById(300826, TextDataMgr:getText(300837))
        local txt = {350008, 350009, 350010}
        for i, v in ipairs(self.Panel_target) do
            --新模拟试炼第二章不显示
            if not FubenDataMgr:isSimulationGroup(2,self.levelCfg_.levelGroupId) then
                v.Image_multiple:setVisible(true)
            else
                v.Image_multiple:setVisible(false)
            end

            v.Label_multiple:setTextById(txt[i])
        end
        local multiple = FubenDataMgr:getDailyMultiple(self.levelCfg_.levelGroupId)
        self.Image_multiple_reward:setVisible(multiple ~= 1)
        if self.Image_multiple_reward:isVisible() then
            self.Label_multiple_reward:setText(multiple)
            self.Label_multiple_desc:setTextById(300957)
        end
        if FubenDataMgr:isSimulationGroup(nil,self.levelCfg_.levelGroupId) then
            isFirstPass = not FubenDataMgr:isPassPlotLevel(self.levelCid_)
            if isFirstPass then
                showReward  = self.levelCfg_.firstDropShow
                realDropCid = self.levelCfg_.firstReward
            else
                showReward  = self.levelCfg_.dropShow
                realDropCid = self.levelCfg_.dailyLevelReward[1]
            end
        else
            showReward = self.levelCfg_.dropShow
            realDropCid = self.levelCfg_.dailyLevelReward[1]
        end
    end

    self.GridView_reward:removeAllItems()

    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(realDropCid)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = self.GridView_reward:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
    end
    -- 基础掉落
    for i, v in ipairs(showReward) do
        local flag = 0
        local arg = {}
        local multiple = multipleReward[v]
        if multiple then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = multiple
        end
        if allMultiple > 0 then
            flag = bit.bor(flag, EC_DropShowType.ACTIVITY_MULTIPLE)
            arg.multiple = allMultiple
        end
        if isFirstPass then
            flag = bit.bor(flag, EC_DropShowType.FIRST_PASS)
        end
        local Panel_dropGoodsItem = self.GridView_reward:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
    end
    if #self.GridView_reward:getItems() < 1 then 
        --列表为空的时候显示已获得的首通奖励
        if FubenDataMgr:isSimulationGroup(2,self.levelCfg_.levelGroupId) then
            for i, v in ipairs(self.levelCfg_.firstDropShow) do
                local arg  = {}
                local flag = bit.bor(EC_DropShowType.FIRST_PASS, EC_DropShowType.DATING_GETED)
                local Panel_dropGoodsItem = self.GridView_reward:pushBackDefaultItem()
                PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
            end
        end
    end    
    local visible = self.Panel_buffer:isVisible()
    if not visible then
        if #self.levelCfg_.limitAttributesDescribe > 0 then
            self.Panel_buffer:show()
            self.Label_buffer:setTextById(self.levelCfg_.limitAttributesDescribe)
        end
    end

    -- --更新克制icon
    -- local levelMagic = self.levelCfg_.magicAttribute
    -- for k, v in pairs(self.panel_elements) do
    --     if levelMagic[k] then
    --         v:show()
    --         PrefabDataMgr:setInfo(v , levelMagic[k])
    --     else
    --         v:hide()
    --     end
        
    -- end
    
end

function FubenReadyView:updateDating()
    local name = FubenDataMgr:getLevelName(self.levelCid_)
    self.Label_name:setText(name)
    self.Label_datingDescTitle:setTextById(300826, TextDataMgr:getText(300827))
    self.Label_datingDesc:setTextById(self.levelCfg_.plotBrief)

    self.Label_datingTargetTitle:setTextById(300826, TextDataMgr:getText(300836))

    local isReach = FubenDataMgr:judgeStarIsActive(self.levelCid_, 1)
    local desc = FubenDataMgr:getStarRuleDesc(self.levelCid_, 1)
    self.Label_datingTarget:setText(desc)
    self.Label_datingTarget_gray:setText(desc)
    self.Label_datingTarget:setVisible(isReach)
    self.Label_datingTarget_gray:setVisible(not isReach)
    self.Image_datingStar:setVisible(isReach)
    self.Image_datingStar_gray:setVisible(not isReach)

    local isPass = FubenDataMgr:isPassPlotLevel(self.levelCid_)
    self.Label_dating_reward:setTextById(300826, TextDataMgr:getText(300127))
    for i, v in ipairs(self.levelCfg_.dropShow) do
        local Panel_dropGoodsItem = self.GridView_reward:pushBackDefaultItem()
        local flag = isPass and EC_DropShowType.DATING_GETED or 0
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag)
    end
end

function FubenReadyView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_UPDATE_CHALLENGE_COUNT, handler(self.onChallengeCountUpdateEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_PLOTLEVEL_BUY_COUNT, handler(self.onBuyCountEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_ENTER_DATING_LEVEL, handler(self.onEnterDatingLevelEvent, self))

    self.Button_close:onClick(function()
            AlertManager:close()
    end)


    self.Button_ready:onClick(function()
            -- 检查消耗
            local isCanFighting = true
            local cost = self.levelCfg_.cost[1]
            if cost then
                local challengeCount = math.max(1, self.challengeCount_)
                isCanFighting = GoodsDataMgr:currencyIsEnough(cost[1], cost[2] * challengeCount)
            end
            if not isCanFighting then
                local goodsCfg = GoodsDataMgr:getItemCfg(cost[1])
                local name = TextDataMgr:getText(goodsCfg.nameTextId)
                Utils:showTips(2100034, name)
                return
            end

            -- 检查剩余次数
            if self.fubenType_ == EC_FBType.DAILY then
                local remainCount = FubenDataMgr:getDailyRemainFightCount(self.levelCfg_.levelGroupId)
                if remainCount < 1 then
                    Utils:showTips(202006)
                    return
                end
            elseif self.fubenType_ == EC_FBType.PLOT then
                local remainCount = FubenDataMgr:getPlotLevelRemainFightCount(self.levelCid_)
                if remainCount < 1 then
                    Utils:showTips(202006)
                    return
                end
            end

            local isDuelMod = self.CheckBox_earnings:getSelectedState()
            if self.levelCfg_.fightingMode == 2 or self.levelCfg_.fightingMode == 3 then
                local view = requireNew("lua.logic.fuben.FubenFlightSquadView"):new(self.levelCid_, isDuelMod, self.challengeCount_)
                AlertManager:addLayer(view)
                AlertManager:show()
                AlertManager:closeLayer(self)
            else
                if self.fubenType_ == EC_FBType.ACTIVITY then --and self.chapterCfg_.id == EC_ActivityFubenType.SIMULATION_TRIAL then
                    Utils:openView("fuben.FubenSquadView", self.fubenType_ , self.chapterCfg_.id,self.levelCid_)
                    AlertManager:closeLayer(self)
                elseif self.fubenType_ == EC_FBType.HWX_FUBEN then
                    Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type , self.paramData,isDuelMod, self.challengeCount_)
                    AlertManager:closeLayer(self)
                else
                    local view = requireNew("lua.logic.fuben.FubenSquadView"):new(self.fubenType_, self.levelCid_, isDuelMod, self.challengeCount_)
                    AlertManager:addLayer(view)
                    AlertManager:show()
                    AlertManager:closeLayer(self)
                end

            end
            GameGuide:checkGuideEnd(self.guideFuncId)
    end)

    self.Button_dating:onClick(function()
            FubenDataMgr:send_DUNGEON_FIGHT_START(self.levelCid_)
            GameGuide:checkGuideEnd(self.guideFuncId)
            AlertManager:closeLayer(self)
    end)

    self.CheckBox_earnings:onEvent(function(event)
            if event.name == "selected" then
                self:updateEarningState(true)
            else
                self:updateEarningState(false)
            end
    end)

    self.Button_select:onClick(function()
            local view = requireNew("lua.logic.fuben.FubenSelectCountView"):new(self.levelCid_)
            AlertManager:addLayer(view, AlertManager.BLOCK_AND_GRAY_CLOSE)
            AlertManager:show()
    end)

    self.Button_buyCount:onClick(function()
            -- local fightCount = FubenDataMgr:getFightCount(self.levelCid_)
            -- local remainCount = math.max(0, self.cfgFightCount - fightCount)
            local remainCount = FubenDataMgr:getPlotLevelRemainFightCount(self.levelCid_)
            if remainCount < self.cfgFightCount then
                Utils:openView("fuben.FubenPlotBuyCountView", self.levelCid_)
            else
                Utils:showTips(300592)
            end
    end)
end

function FubenReadyView:onShow()
    self.super.onShow(self)
    self:removeLockLayer()
    self:timeOut(function()
        if GameGuide:checkGuide(self) then
            if self.blockUI then
                self.blockUI:setBackGroundColorOpacity(50)
            end
        end
    end, 0)
end

function FubenReadyView:updateEarningState(isSelect)
    if isSelect then
        local costNum = math.max(1, self.challengeCount_) * self.earningsCostNum_
        if GoodsDataMgr:currencyIsEnough(self.earningsCostCid_, costNum) then
            self.Panel_buffer:show()
            self.Image_earnings_multiple:show()
        else
            Utils:showTips(350002)
            self.CheckBox_earnings:setSelectedState(false)
        end
    else
        self.Image_earnings_multiple:hide()
        self.Panel_buffer:hide()
    end
end

function FubenReadyView:onChallengeCountUpdateEvent(count)
    local cost = self.levelCfg_.cost[1]
    self.challengeCount_ = count
    self.Label_costNum:setText(cost[2] * count)
    if self.levelCfg_.isDuelMod then
        self.CheckBox_earnings:setSelectedState(false)
        self:updateEarningState(false)
        local costNum = self.earningsCostNum_ * count
        self.Label_earnings_costCount:setTextById(800005, costNum, GoodsDataMgr:getItemCount(self.earningsCostCid_))
    end
end

function FubenReadyView:onBuyCountEvent()
    self:updateFighting()
end

function FubenReadyView:onEnterDatingLevelEvent()
    AlertManager:closeLayer(self)
end

---------------------------guide------------------------------

--介绍约会通关条件
function FubenReadyView:excuteGuideFunc4001(guideFuncId)
    local targetNode = self.Image_datingStar
    GameGuide:guideTargetNode(targetNode, ccp(30, 0))
end

--引导进入约会或准备
function FubenReadyView:excuteGuideFunc4002(guideFuncId)
    local isFighting = (self.levelCfg_.dungeonType == EC_FBLevelType.FIGHTING)
    local targetNode
    if isFighting then
        targetNode = self.Button_ready
    else
        targetNode = self.Button_dating
    end
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

return FubenReadyView

