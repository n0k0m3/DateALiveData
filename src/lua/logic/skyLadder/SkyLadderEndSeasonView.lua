local SkyLadderEndSeasonView = class("SkyLadderEndSeasonView", BaseLayer)

function SkyLadderEndSeasonView:ctor()
    self.super.ctor(self)
    self:initData()
    --self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderSeasonEndView")
end

function SkyLadderEndSeasonView:initData()

    self.maxActionId = 3
    self.actionId = 0
end

function SkyLadderEndSeasonView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Panel_touch:setContentSize(GameConfig.WS)

    self.Panel_grade = TFDirector:getChildByPath(self.ui, "Panel_grade")
    self.Image_grade_bg = TFDirector:getChildByPath(self.Panel_grade, "Image_grade_bg")
    self.Image_grade_bg:setScaleY(0)
    self.Image_grade_bg:setOpacity(0)
    self.LabelBMFont_num = TFDirector:getChildByPath(self.Panel_grade, "LabelBMFont_num")
    self.Panel_grade_info = TFDirector:getChildByPath(self.Panel_grade, "Panel_grade_info")
    self.Panel_grade_info:setOpacity(0)
    self.Label_stage_name = TFDirector:getChildByPath(self.Panel_grade, "Label_stage_name")
    self.Image_medal_grade = TFDirector:getChildByPath(self.Panel_grade, "Image_medal_grade")
    self.Label_my_score = TFDirector:getChildByPath(self.Panel_grade, "Label_my_score")

    self.Panel_award = TFDirector:getChildByPath(self.ui, "Panel_award")
    self.Panel_award_info = TFDirector:getChildByPath(self.Panel_award, "Panel_award_info")
    self.Panel_award_info:setOpacity(0)
    self.Panel_item_content = TFDirector:getChildByPath(self.Panel_award_info, "Panel_item_content")
    self.Button_get = TFDirector:getChildByPath(self.Panel_award_info, "Button_get")
    self.Image_award_bg = TFDirector:getChildByPath(self.Panel_award, "Image_award_bg")
    self.Image_award_bg:setScaleY(0)
    self.Image_award_bg:setOpacity(0)
    self.LabelBMFont_num_award = TFDirector:getChildByPath(self.Panel_award, "LabelBMFont_num")

    self.Panel_new_season = TFDirector:getChildByPath(self.ui, "Panel_new_season")
    self.Image_content_new = TFDirector:getChildByPath(self.Panel_new_season, "Image_content_new")
    self.Image_content_new:setScaleY(0)
    self.Image_content_new:setOpacity(0)
    self.Panel_turn_info = TFDirector:getChildByPath(self.Panel_new_season, "Panel_turn_info")
    self.Panel_turn_info:setOpacity(0)
    self.LabelBMFont_num_season = TFDirector:getChildByPath(self.Panel_new_season, "LabelBMFont_num")
    self.Label_my_score_new = TFDirector:getChildByPath(self.Panel_new_season, "Label_my_score_new")
    self.Label_my_score_new:setSkewX(15)
    self.Image_medal_new = TFDirector:getChildByPath(self.Panel_new_season, "Image_medal_new")
    self.Label_stage_name_new = TFDirector:getChildByPath(self.Panel_new_season, "Label_stage_name_new")
    self.Label_season_time = TFDirector:getChildByPath(self.Panel_new_season, "Label_season_time")

    self.panelInfo = {}
    self.panelInfo[1] = self.Panel_grade
    self.panelInfo[2] = self.Panel_award
    self.panelInfo[3] = self.Panel_new_season

    self.Label_clicktip = TFDirector:getChildByPath(self.ui, "Label_clicktip")
    ViewAnimationHelper.doflashAction(self.Label_clicktip, 0.5, 0)

    self:initUIData()

end

function SkyLadderEndSeasonView:initUIData()

    local lastSeasonData = SkyLadderDataMgr:getLastSeasonData()
    if not lastSeasonData then
        return
    end

    local segment = lastSeasonData.segment
    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(segment)
    if not rankMatchCfg then
        return
    end
    local rankId = rankMatchCfg.rankID
    local clientSeason = lastSeasonData.clientSeason
    local laderScore = lastSeasonData.laderScore
    self.lastRewards = lastSeasonData.rewards or {}

    self.LabelBMFont_num:setText("S"..clientSeason)
    self.Label_stage_name:setTextById(rankMatchCfg.rankName)
    self.Image_medal_grade:setTexture(EC_SkyLadderMedal[rankId])
    self.Label_my_score:setText(laderScore)

    self.LabelBMFont_num_award:setText("S"..clientSeason)

    local curSeasonNum = SkyLadderDataMgr:getCurSeasonNum()
    self.LabelBMFont_num_season:setText("S"..curSeasonNum)

    local curCircleInfo = SkyLadderDataMgr:getCurCircleInfo()
    if not curCircleInfo then
        return
    end
    local curRankCfg = SkyLadderDataMgr:getRankMatchCfg(curCircleInfo.segment)
    if not curRankCfg then
        return
    end
    local curRankId = curRankCfg.rankID

    self.Label_my_score_new:setText(curCircleInfo.laderScore)
    self.Image_medal_new:setTexture(EC_SkyLadderMedal[curRankId])
    self.Label_stage_name_new:setTextById(curRankCfg.rankName)

    local raceEndTime = SkyLadderDataMgr:getRaceEndTime()
    --local endTime = Utils:getTimeData(raceEndTime)
    local year , month , day = Utils:getUTCDateYMD(raceEndTime)
    local endTime = {year = year , month = month , day = day}
    self.Label_season_time:setText( TextDataMgr:getText(3203009, endTime.Year, endTime.Month, endTime.Day)..GV_UTC_TIME_STRING)

    self:playAction()
end

function SkyLadderEndSeasonView:playFirstAction()

    local action = CCSequence:create({
        CCSpawn:create({ CCFadeIn:create(0.2), CCScaleTo:create(0.2,1,0.7)}),
        CCCallFunc:create(function()
            self.Panel_grade_info:runAction(CCFadeIn:create(0.5))
        end)
    })

    self.Image_grade_bg:runAction(action)

end

function SkyLadderEndSeasonView:playSecondAction()

    local newSize = CCSizeMake(#self.lastRewards*110 + (#self.lastRewards-1)*10,100)
    self.Panel_item_content:setContentSize(newSize)
    self.Panel_item_content:setPositionX(0)
    local firstPosX = -newSize.width/2+55
    for k,v in ipairs(self.lastRewards) do
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(Panel_goodsItem,v.id,v.num)
        Panel_goodsItem:setPosition(ccp(0,0))
        Panel_goodsItem:setPositionX(firstPosX + (k-1)*120)
        self.Panel_item_content:addChild(Panel_goodsItem)
    end

    local action = CCSequence:create({
        CCSpawn:create({ CCFadeIn:create(0.2), CCScaleTo:create(0.2,1,0.7)}),
        CCCallFunc:create(function()
            self.Panel_award_info:runAction(CCFadeIn:create(0.5))
        end)
    })

    self.Image_award_bg:runAction(action)
end

function SkyLadderEndSeasonView:playThirdAction()


    local action = CCSequence:create({
        CCSpawn:create({ CCFadeIn:create(0.2), CCScaleTo:create(0.2,1,0.7)}),
        CCCallFunc:create(function()
            self.Panel_turn_info:runAction(CCFadeIn:create(0.5))
        end)
    })

    self.Image_content_new:runAction(action)
end

function SkyLadderEndSeasonView:playAction()
    self.actionId = self.actionId + 1

    if self.actionId > self.maxActionId then
        AlertManager:closeLayer(self)
        return
    end

    for k,v in ipairs(self.panelInfo) do
        if self.actionId == k then
            self.panelInfo[k]:setVisible(true)
        else
            self.panelInfo[k]:setVisible(false)
        end
    end

    self.Label_clicktip:setVisible(true)
    if self.actionId == 1 then
        self:playFirstAction()
    elseif self.actionId == 2 then
        self.Label_clicktip:setVisible(false)
        if self.lastRewards and next(self.lastRewards) then
            self:playSecondAction()
        else
            self:playAction()
        end
    elseif self.actionId == 3 then
        self:playThirdAction()
    end
end

function SkyLadderEndSeasonView:registerEvents()

    self.Panel_touch:onClick(function()
        self:playAction()
    end)

    self.Button_get:onClick(function()
        self:playAction()
    end)
end

return SkyLadderEndSeasonView