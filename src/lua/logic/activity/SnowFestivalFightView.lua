--[[
    @desc：SnowFestivalFightView
    @date: 2020-11-27 15:37:00
]]

local SnowFestivalFightView = class("SnowFestivalFightView",BaseLayer)

function SnowFestivalFightView:initData(activityId)

    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.dungeonByCond = self.activityInfo_.extendData.dungeonByCond

    self.chooseItems = {}
    self.curChooseIdx = nil
    self.keepCostLab = {}

    self.maxWaitingTime = Utils:getKVP(21004, "time")
	self.createTeamWaitTime = Utils:getKVP(21005, "time")
    self.matchingStat = 0 --0,未匹配，1匹配中,2开房中

    self.DungeonWithCombatModuleCfg = TabDataMgr:getData("DungeonWithCombatModule")
    
    dump(self.activityInfo_)
end

function SnowFestivalFightView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.snowFestivalFightView")
end

function SnowFestivalFightView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.Panel_modelChoose:hide()
    self._ui.Panel_snowFestivalTouch:hide()

    local year, month, day = Utils:getDate(self.activityInfo_.showStartTime or 0)
	self._ui.act_timeStart:setTextById(1410001,year, month, day)
	year, month, day = Utils:getDate(self.activityInfo_.endTime or 0)
    self._ui.act_timeEnd:setTextById(1410001,year, month, day)

    self.ScrollView_award = UIListView:create(self._ui.ScrollView_award)
    
    self:initPanelChoose()
    local value = Utils:getLocalSettingValue("SnowFestivalFightView_selectIdx")
    local idx = string.isNullOrEmpty(value) and 1 or value
    self:chooseModelFunc(idx)
end

function SnowFestivalFightView:registerEvents()
    self._ui.img_modelChoose:setTouchEnabled(true)
    self._ui.img_modelChoose:onClick(handler(self.imgModelClickFun, self))
    self._ui.Panel_snowFestivalTouch:onClick(handler(self.imgModelClickFun, self))

    self._ui.btn_battlePrepare:onClick(function()
        self:requestByCostEnough(function()
            local curChooseData = self.dungeonByCond[tostring(self.curChooseIdx)]
            Utils:openView("fuben.FubenSquadView", EC_FBType.ACTIVITY, EC_ActivityFubenType.SNOW_FESVITAL, curChooseData.dungeonId, self.keepDungeonBg)
        end)
    end)

    self._ui.btn_createRoom:onClick(function()
        self:createRoomClickFunc()
    end)
    
    self._ui.btn_randMatch:onClick(function()
        self:randMatchClickFunc()
    end)

    EventMgr:addEventListener(self, EV_TEAM_FIGHT_AUTO_JOIN, handler(self.onSingleMatching, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_CANCEL_FAIL, handler(self.onSingleMatchCancelFail, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onUpdateOpenHouse, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CREAT_TEAM, handler(self.onCreatingTeam, self))

    EventMgr:addEventListener(self, EV_ICE_SNOW_BOOK_DATA, handler(self.updatePanelChoose, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE,  handler(self.updateCostLab, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, function(_bool)
        if not _bool then
            self:stopMatchingAction()
        end
    end) 
end

function SnowFestivalFightView:createRoomClickFunc()
    if self.matchingStat == 0 then
        self:requestByCostEnough(handler(self.createRoomMatching, self))
    end
end

function SnowFestivalFightView:imgModelClickFun()
    self._ui.Panel_modelChoose:setVisible(not self._ui.Panel_modelChoose:isVisible())
    self._ui.Panel_snowFestivalTouch:setVisible(self._ui.Panel_modelChoose:isVisible())
    local isUp = self._ui.Panel_modelChoose:isVisible() and -1 or 1
    self._ui.img_tagUpDown:setScaleY(isUp)
end

function SnowFestivalFightView:randMatchClickFunc()
    if self.matchingStat == 0 then
        self:requestByCostEnough(handler(self.runSingleMatching, self))
    elseif self.matchingStat == 1 then
        local alertparams = clone(EC_GameAlertParams)
        alertparams.msg = 2100057
        alertparams.comfirmCallback = handler(self.stopSingleMatching,self)
        showGameAlert(alertparams)
    end
end

function SnowFestivalFightView:createRoomMatching()
    local curChooseData = self.dungeonByCond[tostring(self.curChooseIdx)] 
    local levelCfg = self.DungeonWithCombatModuleCfg[curChooseData.dungeonId]
    local callback = function(visibleType,limitLv,isAutoMatch)
        TeamFightDataMgr:requestCreateTeam(levelCfg.type, levelCfg.id, visibleType, limitLv, isAutoMatch)
    end
    Utils:openView("teamFight.TeamRoomSettingView", true, levelCfg.type, callback)
end

function SnowFestivalFightView:runSingleMatching()
    local curChooseData = self.dungeonByCond[tostring(self.curChooseIdx)] 
    local levelCfg = self.DungeonWithCombatModuleCfg[curChooseData.dungeonId]
    TeamFightDataMgr:requestMatchTeam(levelCfg.type, levelCfg.id)
end

function SnowFestivalFightView:requestByCostEnough(func)
    if not func then
        return
    end

    local args = {
        tittle = 1702395,
        content = "",
        tips = 13202312,
        reType = "SnowFestivalFightView",
        confirmCall = function()
            func()
        end,
        uiPath = "lua.uiconfig.common.reConfirmTipsView1"
    }

    local chooseData = self.dungeonByCond[tostring(self.curChooseIdx)]
    local costId, costNum
    local isLvEnough = true
    if chooseData.type == 1 then
        local levelCfg = FubenDataMgr:getLevelCfg(chooseData.dungeonId)
        local cost = levelCfg.cost[1]
        if cost then 
            costId = cost[1]
            costNum = cost[2]
        end
    elseif chooseData.type == 2 then
        local levelCfg = self.DungeonWithCombatModuleCfg[chooseData.dungeonId]
        local _bool = levelCfg.fightCost and table.count(levelCfg.fightCost) > 0
        if _bool then
            costId, costNum = next(levelCfg.fightCost)
        end
        isLvEnough =  MainPlayer:getPlayerLv() >= levelCfg.lvlLimit[1]
    elseif chooseData.type == 3 then
        local levelCfg = self.DungeonWithCombatModuleCfg[chooseData.dungeonId]
        isLvEnough =  MainPlayer:getPlayerLv() >= levelCfg.lvlLimit[1]
    end

    if not isLvEnough then
        Utils:showTips(202007)
        return
    end
    
    if costId and costNum and not GoodsDataMgr:currencyIsEnough(costId, costNum) then
      Utils:showReConfirm(args)
    else
        func()
    end
    Utils:setLocalSettingValue("SnowFestivalFightView_selectIdx", self.curChooseIdx)
end

function SnowFestivalFightView:stopSingleMatching()
    TeamFightDataMgr:requestCancelMatchTeam()
end

function SnowFestivalFightView:onSingleMatching()
    self.matchingStat = 1
    self:refreshViewUI()
end

function SnowFestivalFightView:onSingleMatchCancel()
    self.matchingStat = 0
    self:refreshViewUI()
end

function SnowFestivalFightView:initPanelChoose()
    self._ui.Panel_modelChoose:removeAllChildren()

    local itemHight = self._ui.Panel_modelItem:getSize().height
    for i, v in pairs(self.dungeonByCond) do
        local item = self._ui.Panel_modelItem:clone()
        item.lab_modelItemText = TFDirector:getChildByPath(item, "lab_modelItemText")
        item.img_hadChooseItem = TFDirector:getChildByPath(item, "img_hadChooseItem")
        item.img_lock = TFDirector:getChildByPath(item, "img_lock")

        item.lab_modelItemText:setText(v.title)
        item:AddTo(self._ui.Panel_modelChoose)
        item:Pos(ccp(0, (i - 1) * itemHight))

        self.chooseItems[i] =  item
    end
    self:updatePanelChoose()
    local _width = self._ui.Panel_modelChoose:getSize().width
    self._ui.Panel_modelChoose:setSize(ccs(_width, itemHight* table.count(self.dungeonByCond)))
end

function SnowFestivalFightView:updatePanelChoose()
    local curSnowFesFightLv = ActivityDataMgr2:getSnowAchive("snowFesFightLv") or 1
    for i, item in pairs(self.chooseItems) do
        local snowFesFightLv = self.dungeonByCond[tostring(i)].snowFesFightLv
        item.img_lock:setVisible(curSnowFesFightLv < snowFesFightLv)
        item:setTouchEnabled(true)
        item:onClick(function()
            if curSnowFesFightLv >= snowFesFightLv then
                self:chooseModelFunc(i)
            else
                Utils:showTips(13202318, snowFesFightLv)
            end
        end)
    end
end

function SnowFestivalFightView:chooseModelFunc(idx)
    if self.curChooseIdx and self.curChooseIdx == idx then
        return
    end

    self.ScrollView_award:removeAllItems()

    local chooseData = self.dungeonByCond[tostring(idx)]
    for i, v in pairs(self.chooseItems) do
        v.img_hadChooseItem:setVisible(tonumber(idx) == tonumber(i))
    end
    self._ui.Panel_single:setVisible(chooseData.type == 1)
    self._ui.Panel_multi:setVisible(chooseData.type ~= 1)
    self._ui.lab_modelText:setText(chooseData.title)
    self.curChooseIdx = idx

    if not string.isNullOrEmpty(chooseData.coverBg) then
        self._ui.Image_diban:setTexture(chooseData.coverBg)
    end

    if not string.isNullOrEmpty(chooseData.coverEffect) then
        self._ui.Spine_bg:setFile(chooseData.coverEffect)
        self._ui.Spine_bg:play("animation", true)
        self._ui.Spine_bg:show()
    else
        self._ui.Spine_bg:hide()
    end
    self._ui.Spine_main:setVisible(not self._ui.Spine_bg:isVisible())

    self.keepDungeonBg = chooseData.dungeonBg

    local costItem, costId, costNum, costLab, awards
    if chooseData.type == 1 then
        local levelCfg = FubenDataMgr:getLevelCfg(chooseData.dungeonId)
        local cost = levelCfg.cost[1]
        local singleCostImg = self._ui.Panel_single:getChildByName("img_costBg") 
        if not cost then 
            singleCostImg:hide()
            return 
        else
            singleCostImg:show()
            costItem = singleCostImg
            costId = cost[1]
            costNum = cost[2]
        end
        local lab_costLab = singleCostImg:getChildByName("lab_costLab")
        local lab_Name = singleCostImg:getChildByName("lab_Name")
        local img_cost = singleCostImg:getChildByName("img_cost")
        lab_Name:setTextById(GoodsDataMgr:getItemCfg(cost[1]).nameTextId)
        img_cost:setTexture(GoodsDataMgr:getItemCfg(cost[1]).icon)
        costLab = lab_costLab
        awards = levelCfg.rewardShow
    else
        local levelCfg = self.DungeonWithCombatModuleCfg[chooseData.dungeonId]
        local multiCostImg = self._ui.Panel_multi:getChildByName("img_costBg")
        local _bool = levelCfg.fightCost and table.count(levelCfg.fightCost) > 0
        multiCostImg:setVisible(_bool)
        if _bool then
            local id, num = next(levelCfg.fightCost)
            local lab_costLab = multiCostImg:getChildByName("lab_costLab")
            local lab_Name = multiCostImg:getChildByName("lab_Name")
            local img_cost = multiCostImg:getChildByName("img_cost")
            lab_Name:setTextById(GoodsDataMgr:getItemCfg(id).nameTextId)
            img_cost:setTexture(GoodsDataMgr:getItemCfg(id).icon)
            costItem = multiCostImg
            costId = id
            costNum = num
            costLab = lab_costLab
        end
        awards = levelCfg.rewardShow
    end

    for goodsId, num in pairs(awards or {}) do
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_dropGoodsItem:Scale(0.85)
        PrefabDataMgr:setInfo(Panel_dropGoodsItem, goodsId, num)
        self.ScrollView_award:pushBackCustomItem(Panel_dropGoodsItem)
    end 

    if costLab and costId and costNum then
        self.keepCostLab[chooseData.type] = {lab = costLab, num = costNum, id = costId}
    end
    self:updateCostLab()

    if costItem and costId then
        costItem:setTouchEnabled(true)
        costItem:onClick(function()
            Utils:showInfo(costId, nil, true)
        end)
    end

    self:imgModelClickFun()

end

function SnowFestivalFightView:updateCostLab()
    for i, v in pairs(self.keepCostLab) do
        v.lab:setTextById(800005, v.num, GoodsDataMgr:getItemCount(v.id))
    end
end

function SnowFestivalFightView:refreshViewUI()
    if self.matchingStat == 0 then
        self._ui.btn_randMatch:getChildByName("txt"):setTextById(2100052)
        self._ui.btn_randMatch:setTouchEnabled(true)
        self._ui.btn_randMatch:setGrayEnabled(false)
        self._ui.btn_createRoom:setTouchEnabled(true)
        self._ui.btn_createRoom:setGrayEnabled(false)
        self:stopMatchingAction()
    elseif self.matchingStat == 1 then
        self._ui.btn_randMatch:getChildByName("txt"):setTextById(2100053)
        self._ui.btn_randMatch:setTouchEnabled(true)
        self._ui.btn_randMatch:setGrayEnabled(false)
        self._ui.btn_createRoom:setTouchEnabled(false)
        self._ui.btn_createRoom:setGrayEnabled(true)
        self:runMatchingAction()
    elseif self.matchingStat == 2 then
        self._ui.btn_randMatch:setTouchEnabled(false)
        self._ui.btn_randMatch:setGrayEnabled(true)
        self._ui.btn_createRoom:setTouchEnabled(false)
        self._ui.btn_createRoom:setGrayEnabled(true)
        self:runMatchingAction()
    else
        self.btn_randMatch:setTouchEnabled(false)
        self.btn_randMatch:setGrayEnabled(true)
        self._ui.btn_createRoom:setTouchEnabled(false)
        self._ui.btn_createRoom:setGrayEnabled(true)
        self:runMatchingAction()
    end
end

function SnowFestivalFightView:runMatchingAction()
    local function matchFunc(btn, _maxTime, funcName)
        self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = _maxTime,callback = handler(funcName, self)})
        local visibleSize = me.Director:getVisibleSize()
        local maskRender = CCRenderTexture:create(visibleSize.width, visibleSize.height, kCCTexture2DPixelFormat_RGBA8888)
        maskRender:setPosition(ccp(visibleSize.width / 2, visibleSize.height / 2))

        self.waitingLayer:setPosition(ccp(-visibleSize.width / 2, -visibleSize.height / 2))
        local activityMainViewLayer = AlertManager:getTopLayer()
        if activityMainViewLayer then
            activityMainViewLayer:addChild(self.waitingLayer, 1000)
        else
            return
        end
        self.waitingLayer:addChild(maskRender)

        self._ui.img_btnRandMatchMask:show()
        local blend = ccBlendFunc()
        blend.src = GL_ZERO
        blend.dst = GL_ONE_MINUS_SRC_ALPHA
        self._ui.img_btnRandMatchMask:setBlendFunc(blend)
        local wPos = btn:getParent():convertToWorldSpaceAR(btn:getPosition())
        local size = btn:getContentSize()
        self._ui.img_btnRandMatchMask:setPosition(wPos)

        maskRender:clear(0,0,0,0.5)
        maskRender:begin()
        self._ui.img_btnRandMatchMask:visit()
        self._ui.img_btnRandMatchMask:hide()
        maskRender:endToLua()

        self.waitingLayer:setTouchEnabled(true)
        self.waitingLayer:setSwallowTouch(true)
        self.waitingLayer:onClick(function(sender)
            local startPoint = sender:getTouchStartPos()
            local rect = CCRectMake(wPos.x - size.width / 2, wPos.y - size.height / 2, size.width, size.height)
            if me.rectContainsPoint(rect, startPoint) then
                self:randMatchClickFunc()
            end
        end)
    end

    if self.waitingLayer == nil then
        if self.matchingStat == 1 then
            matchFunc(self._ui.btn_randMatch, self.maxWaitingTime, self.onSingleMatchTimeout)
        elseif self.matchingStat == 2 then
            matchFunc(self._ui.btn_createRoom, self.createTeamWaitTime, self.onCreateTeamFail)
		end
	end
end

function SnowFestivalFightView:updateActivity()
    self._ui.Panel_modelChoose:hide()
    self._ui.Panel_snowFestivalTouch:hide()
end

function SnowFestivalFightView:stopMatchingAction()
	if self.waitingLayer ~= nil then
		self.waitingLayer:removeFromParent()
        self.waitingLayer = nil
	end
    if self.matchingStat == 1 then
        self:stopSingleMatching()
    end
end

function SnowFestivalFightView:onCreateTeamFail()
	self.matchingStat = 0
	self:refreshViewUI()
	Utils:showError(TextDataMgr:getText(240014))
end

function SnowFestivalFightView:onSingleMatchTimeout()
	self.matchingStat = 0
	self:refreshViewUI()
	local alertparams = clone(EC_GameAlertParams)
	alertparams.msg = 2100058
	alertparams.confirm_title = 2100059
	alertparams.cancel_title = 2100060
    alertparams.comfirmCallback = handler(self.runSingleMatching, self)
	showGameAlert(alertparams)
end

function SnowFestivalFightView:onCreateTeamFail()
	self.matchingStat = 0
	self:refreshViewUI()
	Utils:showError(TextDataMgr:getText(240014))
end

function SnowFestivalFightView:onSingleMatchCancelFail()
	Utils:showError(TextDataMgr:getText(240015))
end

function SnowFestivalFightView:onUpdateOpenHouse()
	self.matchingStat = 0
	self:refreshViewUI()
end

function SnowFestivalFightView:onCreatingTeam()
    self.matchingStat = 2
	self:refreshViewUI()
end

function SnowFestivalFightView:onClose()
    self.super.onClose(self)
    -- self:stopSingleMatching()
end

return SnowFestivalFightView