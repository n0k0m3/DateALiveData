
local FubenSpriteView = class("FubenSpriteView", BaseLayer)

function FubenSpriteView:initData(chapterCid)
    self.chapterCid_ = chapterCid
    self.chapterCfg_ = FubenDataMgr:getChapterCfg(self.chapterCid_)

    self:updateSpriteData()

    local diffData = {
        [1] = {
            color = ccc3(162, 202, 130),
            name = 2106056,
        },
        [2] = {
            color = ccc3(134, 190, 238),
            name = 2106057,
        },
        [3] = {
            color = ccc3(253, 146, 179),
            name = 2106058,
        },
    }
    self.diffData_ = diffData[self.curLevelIndex_]
end

function FubenSpriteView:getClosingStateParams()
    return {FubenDataMgr.selectChapter_}
end

function FubenSpriteView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenSpriteView")
end

function FubenSpriteView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_title = TFDirector:getChildByPath(self.Panel_root, "Image_title")
    self.Label_time_title = TFDirector:getChildByPath(Image_title, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(Image_title, "Label_time")
    self.Panel_model = TFDirector:getChildByPath(self.Panel_root, "Panel_model")
    local Image_hero = TFDirector:getChildByPath(self.Panel_root, "Image_hero")
    self.Label_hero_name = TFDirector:getChildByPath(Image_hero, "Label_hero_name")
    self.Image_time = TFDirector:getChildByPath(Image_hero, "Image_time")
    self.Label_cizhui = TFDirector:getChildByPath(Image_hero, "Label_cizhui")
    local Image_reward = TFDirector:getChildByPath(self.Panel_root, "Image_reward")
    self.Label_reward = TFDirector:getChildByPath(Image_reward, "Label_reward")
    local ScrollView_reward = TFDirector:getChildByPath(Image_reward, "ScrollView_reward")
    self.ListView_reward = UIListView:create(ScrollView_reward)
    self.ListView_reward:setItemsMargin(5)
    self.Button_ready = TFDirector:getChildByPath(self.Panel_root, "Button_ready")
    self.Label_ready = TFDirector:getChildByPath(self.Button_ready, "Label_ready")
    self.LoadingBar_progress = TFDirector:getChildByPath(self.Panel_root, "Image_progress.LoadingBar_progress")

    self.Panel_sprite = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_root, "Panel_sprite_" .. i)
        item.Image_cur = TFDirector:getChildByPath(item.root, "Image_cur"):hide()
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select"):hide()
        item.ClippingNode_icon = TFDirector:getChildByPath(item.root, "ClippingNode_icon"):hide()
        item.Image_sprite_icon = TFDirector:getChildByPath(item.ClippingNode_icon, "Image_sprite_icon")
        item.Image_unknown = TFDirector:getChildByPath(item.root, "Image_unknown"):hide()
        self.Panel_sprite[i] = item
    end
    self.Panel_pass_reward = TFDirector:getChildByPath(self.Panel_root, "Panel_pass_reward")
    self.Button_get_reward = TFDirector:getChildByPath(self.Panel_pass_reward, "Button_get_reward")
    self.Spine_reward_effect = TFDirector:getChildByPath(self.Panel_pass_reward, "Spine_reward_effect"):hide()

    local Panel_strategy = TFDirector:getChildByPath(self.Panel_root, "Panel_strategy")
    self.Label_diff = TFDirector:getChildByPath(self.Panel_root, "Label_diff")
    self.Image_help = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_root, "Image_help_" .. i)
        item.Label_help = TFDirector:getChildByPath(item.root, "Label_help")
        self.Image_help[i] = item
    end
    
    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")
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
    


    self:refreshView()
end

function FubenSpriteView:refreshView()
    self.Panel_model:setBackGroundColorType(0)
    self.Label_reward:setTextById(2106003)
    self.Label_ready:setTextById(2100047)
    self.Label_time_title:setTextById(2106004)
    self.Label_time:setTextById(2106005)

    local cizhuiName = {}
    for i, v in ipairs(self.monsterCfg_.monsterAffix) do
        local monsterAffixCfg = TabDataMgr:getData("MonsterAffix", v)
        local name = TextDataMgr:getText(monsterAffixCfg.affixName[1])
        local formatName = TextDataMgr:getText(800054, name)
        table.insert(cizhuiName, formatName)
    end
    local name = table.concat(cizhuiName, "  ")
    self.Label_cizhui:setText(name)

    self.ListView_reward:removeAllItems()

    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(self.levelCfg_.reward)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, EC_DropShowType.ACTIVITY_EXTRA)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end
    -- 基础掉落
    for i, v in ipairs(self.levelCfg_.dropShow) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.9)
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
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
        self.ListView_reward:pushBackCustomItem(Panel_dropGoodsItem)
    end

    local spriteChallengeCfg = FubenDataMgr:getSpriteChallengeCfg(self.levelCid_)
    local heroCid = spriteChallengeCfg.heroID[1]
    local skinCid = spriteChallengeCfg.heroID[2]
    Utils:createHeroModel(heroCid, self.Panel_model, 0.5, skinCid)
    local heroCfg = TabDataMgr:getData("Hero", heroCid)
    local roleDescribeCfg = TabDataMgr:getData("RoleDescribe", heroCid)

    self.Label_hero_name:setTextById(heroCfg.name)
    self.Label_hero_name:setColor(self.diffData_.color)
    self.Label_diff:setTextById(self.diffData_.name)
    self.Image_time:setTexture(roleDescribeCfg.energyicon)
    local posX = self.Label_hero_name:Pos().x + self.Label_hero_name:Size().width + 10
    self.Image_time:PosX(posX)

    local levels = self.spriteChallengeInfo_.levels
    for i, v in ipairs(self.Panel_sprite) do
        local level = levels[i]
        local enabled = tobool(level)
        v.ClippingNode_icon:setVisible(enabled)
        v.Image_unknown:setVisible(not enabled)
        if enabled then
            local levelCfg = FubenDataMgr:getLevelCfg(level.levelCid)
            local spriteChallengeCfg = FubenDataMgr:getSpriteChallengeCfg(level.levelCid)
            v.Image_sprite_icon:setTexture(HeroDataMgr:getIconPathById(spriteChallengeCfg.heroID[1], spriteChallengeCfg.heroID[2]))
            local isCurLevel = level.levelCid == self.levelCid_
            local scale = isCurLevel and 1.2 or 1
            v.Image_cur:setVisible(isCurLevel)
            if level.status == 1 then
                v.Image_select:show()
                v.root:setColor(ccc3(125, 125, 125))
            else
                v.root:setColor(ccc3(255, 255, 255))
            end
        else
            v.root:setColor(ccc3(125, 125, 125))
        end
    end

    local helpStr = {2106053, 2106054, 2106055}
    for i, v in ipairs(self.Image_help) do
        v.Label_help:setTextById(helpStr[i])
    end

    local percent = 0
    local state = self.spriteChallengeInfo_.awardStatus
    if state == EC_TaskStatus.GET or state == EC_TaskStatus.GETED then
        percent = 100
    else
        local perPercent = 100 / 3
        for i = 1, self.curLevelIndex_ - 1 do
            percent = percent + perPercent
        end
    end
    self.LoadingBar_progress:setPercent(percent)

    self:updateRewardState()
end

function FubenSpriteView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_SPRITE_GET_REWARD, handler(self.onGetRewardEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_SPRITE_UPDATE_INFO, handler(self.onUpdatSrpiteInfoEvent, self))

    self.Button_ready:onClick(function()
            if FubenDataMgr:getSpriteChallengeIsOpen() then
                local remainCount = FubenDataMgr:getSpriteChallengeRemainCount()
                if remainCount > 0 then
                    Utils:openView("fuben.FubenSquadView", self.chapterCfg_.type, self.chapterCid_)
                else
                    Utils:showTips(202006)
                end
            else
                Utils:showTips(2106013)
            end
    end)

    self.Button_get_reward:onClick(function()
        if self.spriteChallengeInfo_.awardStatus == EC_TaskStatus.GET then
            FubenDataMgr:send_HERO_CHALLENGE_CHALLENGE_AWARD()
        elseif self.spriteChallengeInfo_.awardStatus == EC_TaskStatus.ING then
            Utils:openView("fuben.FubenSpriteRewardView")
        elseif self.spriteChallengeInfo_.awardStatus == EC_TaskStatus.GETED then
            Utils:showTips(2106062)
        end
    end)
end

function FubenSpriteView:updateRewardState()
    local state = self.spriteChallengeInfo_.awardStatus
    self.Spine_reward_effect:setVisible(state == EC_TaskStatus.GET)
    if state == EC_TaskStatus.GETED then
        self.Panel_pass_reward:setColor(ccc3(125, 125, 125))
    else
        self.Panel_pass_reward:setColor(ccc3(255, 255, 255))
    end
    if self.Spine_reward_effect:isVisible() then
        self.Spine_reward_effect:play("animation", 1)
    end

    if state == EC_TaskStatus.GET then
        self.Button_get_reward:setTextureNormal("ui/task/box_2.png")
    elseif state == EC_TaskStatus.ING then
        self.Button_get_reward:setTextureNormal("ui/task/box_1.png")
    elseif state == EC_TaskStatus.GETED then
        self.Button_get_reward:setTextureNormal("ui/task/box_3.png")
    end
end

function FubenSpriteView:updateSpriteData()
    self.spriteChallengeInfo_ = FubenDataMgr:getSpriteChallengeInfo()
    self.levelCid_, self.curLevelIndex_ = FubenDataMgr:getCurSpriteLevelCid()
    self.levelCfg_ = FubenDataMgr:getLevelCfg(self.levelCid_)

    local victoryParam = self.levelCfg_.victoryParam
    if self.levelCfg_.victoryType[1] == 3 then
        self.monsterCid_ = victoryParam[1][1]
        self.monsterCfg_ = TabDataMgr:getData("Monster", self.monsterCid_)
    else
        Utils:showTips(2106070)
    end
end

function FubenSpriteView:onGetRewardEvent(rewards)
    self.spriteChallengeInfo_ = FubenDataMgr:getSpriteChallengeInfo()
    self:updateRewardState()
    Utils:showReward(rewards)
end

function FubenSpriteView:onUpdatSrpiteInfoEvent()
    self:updateSpriteData()
    self:refreshView()
end

return FubenSpriteView
