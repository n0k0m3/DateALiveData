local SkyLadderEndView = class("SkyLadderEndView", BaseLayer)

function SkyLadderEndView:ctor()
    self.super.ctor(self)
    self:initData()
    --self:showPopAnim(true)
    self:init("lua.uiconfig.skyladder.skyladderEndView")
end

function SkyLadderEndView:initData()

    self.maxActionId = 3
    self.actionId = 0
end

function SkyLadderEndView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch")
    self.Panel_touch:setContentSize(GameConfig.WS)

    self.Panel_score = TFDirector:getChildByPath(self.ui, "Panel_score")
    self.Image_content = TFDirector:getChildByPath(self.Panel_score, "Image_content")
    self.Image_content:setScaleY(0)

    self.Panel_delta_score = TFDirector:getChildByPath(self.Panel_score, "Panel_delta_score")
    self.Panel_delta_score:setOpacity(0)

    self.Image_medal = TFDirector:getChildByPath(self.Panel_score, "Image_medal")
    self.Image_medal:setPositionY(0)
    self.Image_medal:setOpacity(0)
    self.Image_medal_icon = TFDirector:getChildByPath(self.Image_medal, "Image_medal_icon")
    self.Label_stage_name_score = TFDirector:getChildByPath(self.Panel_score, "Label_stage_name")
    self.Label_rank = TFDirector:getChildByPath(self.Panel_score, "Label_rank")
    self.Label_score = TFDirector:getChildByPath(self.Panel_score, "Label_score")
    self.Spine_first = TFDirector:getChildByPath(self.Panel_score, "Spine_first"):hide()
    self.Image_deltabg = TFDirector:getChildByPath(self.Panel_score, "Image_deltabg")
    self.Image_deltabg:setScaleY(0)

    self.Panel_up = TFDirector:getChildByPath(self.ui, "Panel_up")
    self.Spine_title_up = TFDirector:getChildByPath(self.Panel_up, "Spine_title_up")
    self.Image_medal_up = TFDirector:getChildByPath(self.Panel_up, "Image_medal_up")
    self.Image_medal_up:setOpacity(0)
    self.Image_medal_up:setScale(2)
    self.Label_stage_name = TFDirector:getChildByPath(self.Panel_up, "Label_stage_name")
    self.Label_stage_name:setOpacity(0)
    self.Image_content_up = TFDirector:getChildByPath(self.Panel_up, "Image_content_up")
    self.Image_content_up:setScaleY(0)

    self.Panel_new_turn = TFDirector:getChildByPath(self.ui, "Panel_new_turn")
    self.Label_my_score = TFDirector:getChildByPath(self.Panel_new_turn, "Label_my_score")
    self.Label_my_score:setSkewX(15)
    self.Label_stage_name_new = TFDirector:getChildByPath(self.Panel_new_turn, "Label_stage_name_new")
    self.Image_medal_new = TFDirector:getChildByPath(self.Panel_new_turn, "Image_medal_new")
    self.Spine_new_turn = TFDirector:getChildByPath(self.Panel_new_turn, "Spine_new_turn")
    self.Image_content_new = TFDirector:getChildByPath(self.Panel_new_turn, "Image_content_new")
    self.Image_content_new:setScaleY(0)
    self.Image_content_new:setOpacity(0)
    self.Panel_turn_info = TFDirector:getChildByPath(self.Panel_new_turn, "Panel_turn_info")
    self.Panel_turn_info:setOpacity(0)

    self.panelInfo = {}
    self.panelInfo[1] = self.Panel_score
    self.panelInfo[2] = self.Panel_up
    self.panelInfo[3] = self.Panel_new_turn

    self.Label_clicktip = TFDirector:getChildByPath(self.ui, "Label_clicktip")
    ViewAnimationHelper.doflashAction(self.Label_clicktip, 0.5, 0)

    self:setData()
end

function SkyLadderEndView:setData()

    local lastRankData = SkyLadderDataMgr:getLastCircleRankList()
    if not lastRankData then
        return
    end

    local myRankInfo = lastRankData.rank
    if not myRankInfo then
        return
    end

    local rankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(myRankInfo.segment)
    if not rankMatchCfg then
        return
    end

    local lastRankId = rankMatchCfg.rankID
    self.Image_medal_icon:setTexture(EC_SkyLadderMedal[lastRankId])
    self.Label_stage_name_score:setTextById(rankMatchCfg.rankName)
    if myRankInfo.rank == 0 then
        self.Label_rank:setTextById(263009)
    else
        self.Label_rank:setTextById(112000251, myRankInfo.rank)
    end

    local curCircleInfo = SkyLadderDataMgr:getCurCircleInfo()
    if not curCircleInfo then
        return
    end
    local deltaScore =  myRankInfo.ladderAddtion
    if deltaScore then
        if deltaScore > 0 then
            self.Label_score:setText("+"..deltaScore)
        else
            self.Label_score:setText(deltaScore)
        end
    else
        self.Label_score:setText("")
    end

    local curRankMatchCfg = SkyLadderDataMgr:getRankMatchCfg(curCircleInfo.segment)
    if not curRankMatchCfg then
        return
    end
    local curRankId = curRankMatchCfg.rankID

    self.isUpStage = curCircleInfo.segment > myRankInfo.segment
    if self.isUpStage then
        self.Image_medal_up:setTexture(EC_SkyLadderMedal[curRankId])
        self.Label_stage_name:setTextById(curRankMatchCfg.rankName)
    end

    self.Label_my_score:setText(curCircleInfo.laderScore)
    self.Label_stage_name_new:setTextById(curRankMatchCfg.rankName)
    self.Image_medal_new:setTexture(EC_SkyLadderMedal[curRankId])

    self:playAction()
end



function SkyLadderEndView:playFirstAction()

    local action = CCSequence:create({
        CCScaleTo:create(0.2, 1, 0.7),
        CCDelayTime:create(0.2),
        CCCallFunc:create(function()
            local action2 = CCSequence:create({
                CCFadeIn:create(1),
                CCDelayTime:create(0.5),
                CCCallFunc:create(function()
                    self.Image_medal:runAction(CCMoveTo:create(0.2,ccp(-127,-51)))
                    self.Image_content:runAction(CCSequence:create({
                        CCScaleTo:create(0.2, 1,1),
                        CCDelayTime:create(0.1),
                        CCCallFunc:create(function()
                            self.Spine_first:setVisible(true)
                            local act = CCSequence:create({
                                CCScaleTo:create(0.3, 1,1),
                                CCCallFunc:create(function()
                                    self.Panel_delta_score:runAction(CCSequence:create({
                                        CCFadeIn:create(0.3),
                                        CCCallFunc:create(function()
                                            self.Spine_first:play("flashing_1",false)
                                        end)
                                    }))
                                end)
                            })
                            self.Image_deltabg:runAction(act)
                        end)
                    }))
                end)
            })
            self.Image_medal:runAction(action2)
        end)
    })
    self.Image_content:runAction(action)

end

function SkyLadderEndView:playSecondAction()
    self.Spine_title_up:play("ALL",false)
    local action = CCSequence:create({
        CCSpawn:create({ CCFadeIn:create(0.2), CCScaleTo:create(0.2,1)}),
        CCCallFunc:create(function()
            self.Label_stage_name:runAction(CCFadeIn:create(0.5))
        end)
    })

    self.Image_medal_up:runAction(action)

    self.Image_content_up:runAction(CCScaleTo:create(0.2,1,0.7))
end

function SkyLadderEndView:playThirdAction()
    self.Spine_new_turn:play("ALL",false)
    local action = CCSequence:create({
        CCSpawn:create({ CCFadeIn:create(0.2), CCScaleTo:create(0.2,1,0.7)}),
        CCCallFunc:create(function()
           self.Panel_turn_info:runAction(CCFadeIn:create(0.5))
        end)
    })

    self.Image_content_new:runAction(action)
end

function SkyLadderEndView:playAction()
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

    if self.actionId == 1 then
        self:playFirstAction()
    elseif self.actionId == 2 then
        if self.isUpStage then
            self:playSecondAction()
        else
            self:playAction()
        end
    elseif self.actionId == 3 then
        self:playThirdAction()
    end
end

function SkyLadderEndView:registerEvents()

    self.Panel_touch:onClick(function()
        self:playAction()
    end)

end

return SkyLadderEndView