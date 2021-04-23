TeamPveLevelPreview = class("TeamPveLevelPreview",BaseLayer)

function TeamPveLevelPreview:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.teamFight.teamLevelPreview")
end

function TeamPveLevelPreview:initData(data)
    self.maxWaitingTime = Utils:getKVP(17001,"time")
    self.createTeamWaitTime = Utils:getKVP(21005,"time")
    self.matchingStat = 0 --0未匹配，1匹配中,2开房中
    self.requireClose = false --是否点了关闭界面按钮
    self.curCostStat = data.costData
    self.curLevelCfg = data.levelCfg
    self.remainCnt = data.remainCnt

end

function TeamPveLevelPreview:initUI(ui)
    self.super.initUI(self, ui)
    local root_panel= TFDirector:getChildByPath(ui,"Panel_root")
    self.levelPreviewPanel = TFDirector:getChildByPath(root_panel, "Panel_level_preview")

    local Panel_common = self.levelPreviewPanel:getChildByName("Panel_common"):show()
    local Panel_custom1 = self.levelPreviewPanel:getChildByName("Panel_custom1"):hide()

    self:handleLevelPreviewUI()
    self:refreshView()
end

function TeamPveLevelPreview:onShow()
    self.super.onShow(self)
    self:refreshView()
end

function TeamPveLevelPreview:handleLevelPreviewUI()
    self.levelPreviewNodes = {}
    local img_pad = self.levelPreviewPanel:getChildByName("Image_pad")
    local function onClickClose()
        if self.matchingStat == 1 then
            local alertparams = clone(EC_GameAlertParams)
            alertparams.msg = 2100057
            alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
            showGameAlert(alertparams)
            self.requireClose = true
        else
            --关闭界面
            AlertManager:closeLayer(self)
        end
    end
    self.levelPreviewPanel:getChildByName("Panel_black"):onClick(onClickClose)
    img_pad:getChildByName("Button_close"):onClick(onClickClose)

    local Button_add_count = img_pad:getChildByName("Button_add_count")
    Button_add_count:setVisible(false)

    self.levelPreviewNodes["level_title"] = img_pad:getChildByName("Label_title")

    img_pad:getChildByName("Image_level_desc"):getChildByName("Label_title"):setTextById(300826,TextDataMgr:getText(300833))
    img_pad:getChildByName("Image_level_goal"):getChildByName("Label_title"):setTextById(300826,TextDataMgr:getText(2100049))
    img_pad:getChildByName("Label_reward_title"):setTextById(300826,TextDataMgr:getText(300837))
    self.levelPreviewNodes["level_desc"] = img_pad:getChildByName("TextArea_level_desc")
    self.levelPreviewNodes["level_goal"] = img_pad:getChildByName("TextArea_level_goal")

    local dropScrollView = img_pad:getChildByName("ScrollView_drop")
    local GridView_drop = UIGridView:create(dropScrollView)
    GridView_drop:setColumn(2)
    GridView_drop:setColumnMargin(10)
    GridView_drop:setRowMargin(10)
    local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
    Panel_dropGoodsItem:Scale(0.65)
    GridView_drop:setItemModel(Panel_dropGoodsItem)
    self.levelPreviewNodes["drop_gridview"] = GridView_drop
    --底部

    img_pad:getChildByName("Label_residue"):setTextById(2100046)
    self.levelPreviewNodes["times_value"] = img_pad:getChildByName("Label_residue_value")
    self.levelPreviewNodes["Panel_cost"] = img_pad:getChildByName("Panel_cost")
    self.levelPreviewNodes["auto_match_btn"] = img_pad:getChildByName("Button_auto_match")
    self.levelPreviewNodes["open_house_btn"] = img_pad:getChildByName("Button_open_house")
    self.levelPreviewNodes["auto_match_btn"]:getChildByName("Label_title"):setTextById(2100052)
    self.levelPreviewNodes["open_house_btn"]:getChildByName("Label_title"):setTextById(2100051)
    self.levelPreviewNodes["auto_match_btn"]:onClick(function()
        if self.matchingStat == 0 then
            self:runSingleMatching()
        elseif self.matchingStat == 1 then

            local alertparams = clone(EC_GameAlertParams)
            alertparams.msg = 2100057
            alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
            showGameAlert(alertparams)
        else

        end
    end)

    self.panelTouchFunc = function ( ... )
        if self.matchingStat == 0 then
            AlertManager:closeLayer(self)
        elseif self.matchingStat == 1 then

            local alertparams = clone(EC_GameAlertParams)
            alertparams.msg = 2100057
            alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
            showGameAlert(alertparams)
        else

        end
    end
    
    self.levelPreviewNodes["open_house_btn"]:onClick(function()
        if self.matchingStat == 0 then
            local callback = function(visibleType,limitLv,isAutoMatch)
                self.matchingStat = 2
                self:refreshView()
                local selLevelCfg = self.curLevelCfg
                TeamFightDataMgr:requestCreateTeam( EC_NetTeamType.High,selLevelCfg.id,visibleType,limitLv,isAutoMatch)
            end
            Utils:openView("teamFight.TeamRoomSettingView",true,EC_NetTeamType.High,callback)

        end
    end)
end

function TeamPveLevelPreview:refreshView()
    self:refreshLevelPreviewUI()
end

function TeamPveLevelPreview:refreshLevelPreviewUI()
    local selLevelCfg = self.curLevelCfg
    self.levelPreviewNodes["level_title"]:setTextById(selLevelCfg.levelName)
    local costitemCfg = GoodsDataMgr:getItemCfg(self.curCostStat.id)


    self.levelPreviewNodes["level_desc"]:setTextById(selLevelCfg.LevelDesc)
    self.levelPreviewNodes["level_goal"]:setTextById(selLevelCfg.levelTarget)
    self.levelPreviewNodes["Panel_cost"]:getChildByName("Image_item_icon"):setTexture(costitemCfg.icon)
    self.levelPreviewNodes["Panel_cost"]:getChildByName("Image_item_icon"):setSize(me.size(40,40))
    self.levelPreviewNodes["Panel_cost"]:getChildByName("Label_cost_value"):setString(tostring(self.curCostStat.num))
    self.levelPreviewNodes["Panel_cost"]:getChildByName("Label_cost_value"):setGrayEnabled(self.curCostStat.hasnum <self.curCostStat.num )
    self.levelPreviewNodes["Panel_cost"]:setVisible(self.curCostStat.num > 0)

    local cnt = self.remainCnt
    if cnt < 0 then
        cnt = 0
    end

    self.levelPreviewNodes["times_value"]:setString(tostring(cnt))
    self.levelPreviewNodes["drop_gridview"]:removeAllItems()

    local levelCfg_ = TabDataMgr:getData("DungeonLevel", selLevelCfg.id)

    local showReward = {}
    if ActivityDataMgr2:isOpen(EC_ActivityType2.DROP) then
        local dropCfg = TabDataMgr:getData("Drop", levelCfg_.reward)
        table.insertTo(showReward, dropCfg.activityDropShow)
    end

    if self.remainCnt > 0 then
        table.insertTo(showReward, levelCfg_.firstDropShow)
    else
        table.insertTo(showReward, levelCfg_.dropShow)
    end

    local dropCid = self.curLevelCfg.reward[1]
    local multipleReward, extraReward, allMultiple = ActivityDataMgr2:getDropReward(dropCid)
    -- 掉落活动额外掉落
    for i, v in ipairs(extraReward) do
        local Panel_dropGoodsItem = self.levelPreviewNodes["drop_gridview"]:pushBackDefaultItem()
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

        local Panel_dropGoodsItem = self.levelPreviewNodes["drop_gridview"]:pushBackDefaultItem()
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v}, flag, arg)
    end

    if self.matchingStat == 0 then
        self.levelPreviewNodes["auto_match_btn"]:getChildByName("Label_title"):setTextById(2100052)
        self.levelPreviewNodes["auto_match_btn"]:setTouchEnabled(true)
        self.levelPreviewNodes["auto_match_btn"]:setGrayEnabled(false)
        self.levelPreviewNodes["open_house_btn"]:setTouchEnabled(true)
        self.levelPreviewNodes["open_house_btn"]:setGrayEnabled(false)
        self:stopMatchingAction()
    elseif self.matchingStat == 1 then
        self.levelPreviewNodes["auto_match_btn"]:getChildByName("Label_title"):setTextById(2100053)
        self.levelPreviewNodes["auto_match_btn"]:setTouchEnabled(true)
        self.levelPreviewNodes["auto_match_btn"]:setGrayEnabled(false)
        self.levelPreviewNodes["open_house_btn"]:setTouchEnabled(false)
        self.levelPreviewNodes["open_house_btn"]:setGrayEnabled(true)
        self:runMatchingAction()

    elseif self.matchingStat == 2 then
        self.levelPreviewNodes["auto_match_btn"]:setTouchEnabled(false)
        self.levelPreviewNodes["auto_match_btn"]:setGrayEnabled(true)
        self.levelPreviewNodes["open_house_btn"]:setTouchEnabled(false)
        self.levelPreviewNodes["open_house_btn"]:setGrayEnabled(true)

        self:runMatchingAction()
    else
        self.levelPreviewNodes["auto_match_btn"]:setTouchEnabled(false)
        self.levelPreviewNodes["auto_match_btn"]:setGrayEnabled(true)
        self.levelPreviewNodes["open_house_btn"]:setTouchEnabled(false)
        self.levelPreviewNodes["open_house_btn"]:setGrayEnabled(true)
        self:runMatchingAction()
    end
end

function TeamPveLevelPreview:runMatchingAction()
    if self.waitingLayer == nil then
        if self.matchingStat == 2 then
            self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.createTeamWaitTime,callback = handler(self.onCreateTeamFail,self)})
            self.levelPreviewPanel:addChild(self.waitingLayer,999)
        else
            self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.maxWaitingTime,callback = handler(self.onSingleMatchTimeout,self)})
            self.levelPreviewPanel:addChild(self.waitingLayer,999)
        end
    end
end

function TeamPveLevelPreview:stopMatchingAction()
    if self.waitingLayer ~= nil then
        self.waitingLayer:removeFromParent()
        self.waitingLayer = nil
    end
end

function TeamPveLevelPreview:registerEvents()
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_AUTO_JOIN, handler(self.onSingleMatching, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onUpdateOpenHouse, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CREAT_TEAM, handler(self.onCreatingTeam, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_CANCEL_FAIL, handler(self.onSingleMatchCancelFail, self))
    EventMgr:addEventListener(self, EV_FUNC_STATE_CHANGE,handler(self.funcCloseNotice,self))

end

function TeamPveLevelPreview:funcCloseNotice(data)
    if data.switchType == EC_FunctionEnum.TEAM_FIGHT and data.open == false then
        if self.matchingStat == 1 then
            TeamFightDataMgr:requestCancelMatchTeam()
        end
        AlertManager:closeLayer(self)
    end
end

function TeamPveLevelPreview:runSingleMatching()
    -- self.matchingStat = 1
    -- self:refreshView()
    --发送匹配请求
    local selLevelCfg = self.curLevelCfg
    TeamFightDataMgr:requestMatchTeam( 2, selLevelCfg.id)
end

function TeamPveLevelPreview:stopSingleMatching()
    TeamFightDataMgr:requestCancelMatchTeam()
end

function TeamPveLevelPreview:onCreatingTeam()
    self.matchingStat = 2
    self:refreshView()
end

function TeamPveLevelPreview:onSingleMatchTimeout()
    self.matchingStat = 0
    self:refreshView()
    local alertparams = clone(EC_GameAlertParams)
    alertparams.msg = 2100058
    alertparams.confirm_title = 2100059
    alertparams.cancel_title = 2100060
    alertparams.comfirmCallback = handler(self.runSingleMatching,self)
    showGameAlert(alertparams)
end

function TeamPveLevelPreview:onCreateTeamFail()
    self.matchingStat = 0
    self:refreshView()
    -- Utils:showError("创建队伍失败")
    Utils:showError(TextDataMgr:getText(240014))
end

function TeamPveLevelPreview:onSingleMatchCancelFail()
    -- Utils:showError("无法取消匹配")
    Utils:showError(TextDataMgr:getText(240015))
end

function TeamPveLevelPreview:onSingleMatchCancel()
    self.matchingStat = 0
    self:refreshView()
    if self.requireClose == true then
        AlertManager:closeLayer(self)
    end
end

function TeamPveLevelPreview:onSingleMatching()
    self.matchingStat = 1
    self:refreshView()
end

function TeamPveLevelPreview:onUpdateOpenHouse()
    self.matchingStat = 0
    self:refreshView()
end
function TeamPveLevelPreview:onSingleMatchComplete()
    self.matchingStat = 0
    self:refreshView()
end

function TeamPveLevelPreview:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

return TeamPveLevelPreview
