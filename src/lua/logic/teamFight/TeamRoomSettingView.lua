local TeamRoomSettingView = class("TeamRoomSettingView",BaseLayer)

local enum_visi_type = {
    all = 0,                    --所有人可见
    friendAndMember = 1,        --仅好友和成员可见
    hide = 2                    --都不可见
}

function TeamRoomSettingView:ctor(isCreateRoom,teamType,confirmCallBack)
    self.super.ctor(self)
    self:initData(isCreateRoom,teamType,confirmCallBack)
    self:showPopAnim(true)
    self:init("lua.uiconfig.teamFight.teamRoomSettingView")
end

function TeamRoomSettingView:initData(isCreateRoom,teamType,confirmCallBack)

    self.maxWaitingTime = Utils:getKVP(17001,"time")
    self.createTeamWaitTime = Utils:getKVP(21005,"time")

    self.isCreateRoom = isCreateRoom
    self.maxLevel_ =  MainPlayer:getMaxPlayerLevel() or 100
    self.curLimitLevel = 1
    self.defaultLevel = 1
    self.teamType = teamType
    self.confirmCallBack = confirmCallBack
    self.isOpenAutoMatch = false

    local mypid = MainPlayer:getPlayerId()
    self.isTeamLeader = (mypid == TeamFightDataMgr:getLeaderId())

    self.showType = {enum_visi_type.all, enum_visi_type.friendAndMember, enum_visi_type.hide}
end

function TeamRoomSettingView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")
    self.Button_ok = TFDirector:getChildByPath(self.Panel_root, "Button_ok")

    local Panel_top = TFDirector:getChildByPath(self.Panel_root, "Panel_top")

    self.roomVisibleHandle = {}
    for i=1,3 do
        local Image_room_visible = TFDirector:getChildByPath(Panel_top, "Image_room_visible_"..i)
        Image_room_visible:setTouchEnabled(true)
        local btn = TFDirector:getChildByPath(Image_room_visible, "Button_visible"):hide()
        local Label_visible = TFDirector:getChildByPath(Image_room_visible, "Label_visible")
        self.roomVisibleHandle[i] = {bg = Image_room_visible, btn = btn, lable = Label_visible, visibleType = self.showType[i]}
    end

    ---自动匹配
    self.Image_auto_match = TFDirector:getChildByPath(Panel_top, "Image_auto_match"):hide()
    self.Image_auto_bg = TFDirector:getChildByPath(self.Image_auto_match, "Image_auto_bg")
    self.Image_auto_handle = TFDirector:getChildByPath(self.Image_auto_match, "Image_on")

    ---队友特效
    self.Image_player_effect = TFDirector:getChildByPath(Panel_top, "Image_player_effect"):hide()
    self.Image_effect_bg = TFDirector:getChildByPath(self.Image_player_effect, "Image_auto_bg")
    self.Image_effect_handle = TFDirector:getChildByPath(self.Image_player_effect, "Image_on")

    ---等级限制
    self.Panel_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_mask"):hide()
    self.Panel_limit_level = TFDirector:getChildByPath(self.Panel_root, "Panel_limit_level"):hide()
    self.Label_join_tip = TFDirector:getChildByPath(self.Panel_limit_level, "Label_join_tip")
    self.Button_del = TFDirector:getChildByPath(self.Panel_limit_level, "Button_del")
    self.Button_add = TFDirector:getChildByPath(self.Panel_limit_level, "Button_add")
    self.Slider_limitLv = TFDirector:getChildByPath(self.Panel_limit_level, "Slider_limitLv")

    self:refreshView()

end

function TeamRoomSettingView:refreshView()


    if self.isCreateRoom then
        self:createInfo()
    else
        self:settingInfo()
    end

    self.Image_auto_match:setVisible(true)
end

function TeamRoomSettingView:createInfo()

    self.Panel_limit_level:show()

    self:updateLimiteLevel(self.defaultLevel)
    self:hanleRoomVisible(enum_visi_type.all)

    self:handleAutoMatch(false)
end

function TeamRoomSettingView:settingInfo()

    self.Image_player_effect:show()

    local visibleType = TeamFightDataMgr:getTeamRoomVisibleType()
    self.initVisibleType = visibleType
    self:hanleRoomVisible(visibleType)

    local isAutoMatch = TeamFightDataMgr:isAutoMatching()
    self.initAutoMatch = isAutoMatch
    self:handleAutoMatch(isAutoMatch)

    local status = SettingDataMgr:getAttactEffect()
    self:handleEffect(status)

end

function TeamRoomSettingView:handleEffect(status)
    self.effectState = status
    local posX = status == 1 and -22 or 22
    self.Image_effect_handle:setPositionX(posX)
end

function TeamRoomSettingView:updateLimiteLevel(newLimitLevel)

    self.curLimitLevel = newLimitLevel
    self.Button_add:setTouchEnabled(self.curLimitLevel < self.maxLevel_)
    self.Button_add:setGrayEnabled(self.curLimitLevel >= self.maxLevel_)

    self.Button_del:setTouchEnabled(self.curLimitLevel > self.defaultLevel)
    self.Button_del:setGrayEnabled(self.curLimitLevel <= self.defaultLevel)

    local percent = math.floor(self.curLimitLevel/self.maxLevel_ *100)
    self.Slider_limitLv:setPercent(percent)
    self.Label_join_tip:setTextById(14300325,self.curLimitLevel)
end

function TeamRoomSettingView:changeLevel(deltaLevel)
    local newLimitLevel = self.curLimitLevel + deltaLevel
    self:updateLimiteLevel(newLimitLevel)
end

function TeamRoomSettingView:hanleRoomVisible(visibleType)

    for k,v in ipairs(self.roomVisibleHandle) do
        v.btn:setVisible(visibleType == v.visibleType)
    end
    self.culVisibleType = visibleType

end

function TeamRoomSettingView:handleAutoMatch(isOpenAutoMatch)
    self.isOpenAutoMatch = isOpenAutoMatch
    local posX = self.isOpenAutoMatch and -22 or 22
    self.Image_auto_handle:setPositionX(posX)
end

---中途改变队长位置
function TeamRoomSettingView:onHandleTeamData()
    local mypid = MainPlayer:getPlayerId()
    self.isTeamLeader = (mypid == TeamFightDataMgr:getLeaderId())

    local curVisible = TeamFightDataMgr:getTeamRoomVisibleType()
    self.initVisibleType = curVisible
    self:hanleRoomVisible(curVisible)
end

function TeamRoomSettingView:onCreatingTeam()
    self:stopMatchingAction()
    AlertManager:closeLayer(self)
end

function TeamRoomSettingView:changeHandleState(isForbid)
    self.Button_ok:setTouchEnabled(not isForbid)
    self.Button_ok:setGrayEnabled(isForbid)
    --self.Button_close:setVisible(not isForbid)
    self.Image_auto_bg:setTouchEnabled(not isForbid)
    self.Panel_mask:setVisible(isForbid)
    self.Image_effect_bg:setTouchEnabled(not isForbid)
    for k,v in ipairs(self.roomVisibleHandle) do
        v.bg:setTouchEnabled(not isForbid)
    end
end

function TeamRoomSettingView:onSingleMatchCancel()
    self:stopMatchingAction()
    self:changeHandleState(false)
    AlertManager:closeLayer(self)
end

function TeamRoomSettingView:onCreateTeamFail()
    Utils:showError(TextDataMgr:getText(240014))
    self:stopMatchingAction()
    self:changeHandleState(false)
end

function TeamRoomSettingView:onSingleMatchTimeout()
    self:changeHandleState(false)
    self:stopMatchingAction()

    local alertparams = clone(EC_GameAlertParams)
    alertparams.msg = 2100058
    alertparams.confirm_title = 2100059
    alertparams.cancel_title = 2100060
    alertparams.comfirmCallback = handler(self.runSingleMatching,self)
    showGameAlert(alertparams)
end


function TeamRoomSettingView:runMatchingAction()

    self:changeHandleState(true)

    if self.waitingLayer == nil then
        self.waitingLayer = require("lua.logic.teamFight.TeamWaitingTimer"):new({maxtime = self.createTeamWaitTime,callback = handler(self.onCreateTeamFail,self)})
        self.Panel_root:addChild(self.waitingLayer,999)
    end
end

function TeamRoomSettingView:stopMatchingAction()
    if self.waitingLayer ~= nil then
        self.waitingLayer:removeFromParent()
        self.waitingLayer = nil
    end
end

---中途改变状态
function TeamRoomSettingView:changeAllState()

    self:changeHandleState(true)

    SettingDataMgr:setAttactEffect(self.effectState)

    if self.isTeamLeader then

        local hideLayer = true
        if self.initAutoMatch ~= self.isOpenAutoMatch then
            local handleId = self.isOpenAutoMatch and 2 or 1
            TeamFightDataMgr:requestChangeTeamStatus(handleId)
            hideLayer = false
        end

        if self.initVisibleType ~= self.culVisibleType then
            TeamFightDataMgr:Send_ChangeTeamShowType(self.culVisibleType)
            hideLayer = false
        end

        ---没有任何操作变化，直接关闭界面
        if hideLayer then
            AlertManager:closeLayer(self)
        end
    else
        AlertManager:closeLayer(self)
    end

end

function TeamRoomSettingView:registerEvents()

    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onHandleTeamData, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_TEAM_DATA, handler(self.onCreatingTeam, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_MATCH_TIME_OUT, handler(self.onSingleMatchTimeout, self))
    EventMgr:addEventListener(self, EV_TEAM_FIGHT_CANCEL_MATCH, handler(self.onSingleMatchCancel, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_ok:onClick(function()
        if self.isCreateRoom then
            if self.confirmCallBack then
                self:runMatchingAction()
                self.confirmCallBack(self.culVisibleType,self.curLimitLevel,self.isOpenAutoMatch)
            end
        else
            self:changeAllState()
        end
    end)

    self.Slider_limitLv:addMEListener(
            TFSLIDER_CHANGED,
            function(...)
                local percent = self.Slider_limitLv:getPercent()
                local level = math.floor(self.maxLevel_ * percent / 100)
                local newLimitLevel = clamp(level, self.defaultLevel, self.maxLevel_)
                self:updateLimiteLevel(newLimitLevel)
            end
    )

    self.Button_add:onClick(function ()
        self:changeLevel(1)
    end)

    self.Button_del:onClick(function()
        self:changeLevel(-1)
    end)

    for k,v in ipairs(self.roomVisibleHandle) do
        v.bg:onClick(function()
            if not self.isCreateRoom and (not self.isTeamLeader) then
                return
            end

            self:hanleRoomVisible(v.visibleType)
        end)
    end

    self.Image_auto_bg:onClick(function()

        if not self.isCreateRoom and not self.isTeamLeader then
            Utils:showTips(2100096)
            return
        end
        self:handleAutoMatch(not self.isOpenAutoMatch)
    end)

    self.Image_effect_bg:onClick(function()
        local newState = self.effectState == 1 and 2 or 1
        self:handleEffect(newState)
    end)


end

return TeamRoomSettingView