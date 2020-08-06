local FavorView = class("FavorView",BaseLayer)

function FavorView:initData(data)
    data = data or {}
    self.addFavorDis = 0
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    self.currentStarLevel = self.useRoleInfo.favorLevel
    self.isHide = data.isHide
    self.pos = data.pos
    self.isShowFavorUp = data.isShowFavorUp or false
end

function FavorView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)

    self:init("lua.uiconfig.dating.favorView")
end

function FavorView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initGoodFeeling()
end

function FavorView:initGoodFeeling()
    self.Panel_goodFeeling = TFDirector:getChildByPath(self.ui, "Panel_goodFeeling")
    self.Panel_goodFeeling:setZOrder(300)
    self.Panel_goodFeeling:Pos(self.pos)
    self.Panel_fUp = TFDirector:getChildByPath(self.Panel_goodFeeling,"Panel_fUp"):hide()

    self.loadingBar_goodFeelingProgress = TFDirector:getChildByPath(self.Panel_goodFeeling, "LoadingBar_goodFeelingProgress")
    self.loadingBar_goodFeelingProgress:setAngle(75)
    self.Label_proValue = TFDirector:getChildByPath(self.Panel_goodFeeling,"Label_proValue")
    self.Panel_goodFeelingStar = TFDirector:getChildByPath(self.Panel_goodFeeling, "Panel_goodFeelingStar")
    self.label_goodFeelingText = TFDirector:getChildByPath(self.Panel_goodFeeling, "Label_goodFeelingText")

    if self.isHide then
        self.Panel_goodFeeling:setOpacity(0)
    end

    self:refreshInfo()
end

function FavorView:refreshInfo()
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    self.currentStarLevel = self.useRoleInfo.favorLevel
    self.Panel_fUp:setOpacity(0)
    self:refreshProgress()
    self:onRefreshFavorLevel(self.currentStarLevel)
end



function FavorView:refreshStar()

    local level = self.currentStarLevel
    self.currentStarLevel = self.useRoleInfo.favorLevel
    local str = ""
    local lastFavorId = 0
    local newFavorId = 0

    newFavorId = EC_FavorType[self.currentStarLevel]
    if self.currentStarLevel ~= 1 then
        lastFavorId = EC_FavorType[self.currentStarLevel - 1]
    end

    if self.currentStarLevel > level and lastFavorId ~= 0 and self.isShowFavorUp then
        local data = {}
        data.lastLevel = self.currentStarLevel - 1
        data.newLevel = self.currentStarLevel
        local favorUpgradeLayer = require("lua.logic.dating.FavorUpgradeLayer"):new(data)
        AlertManager:addLayer(favorUpgradeLayer,AlertManager.BLOCK,AlertManager.TWEEN_NONE)
        AlertManager:show()
    end
end

function FavorView:onRefreshFavorLevel(favorLevel)
    local favorStr = TextDataMgr:getText(EC_FavorType[favorLevel])
    self:refreshProgress()
    self.label_goodFeelingText:setString(favorStr)
end

function FavorView:refreshProgress()
    if self.addFavorDis == 0 then
        self:removeProgressTimer()
        self.loadingBar_goodFeelingProgress:setPercent(RoleDataMgr:getRoleInfo(self.useId).favorPercent)
        self.Label_proValue:setString(RoleDataMgr:getRoleInfo(self.useId).favor .. "/" .. RoleDataMgr:getRoleInfo(self.useId).curLvMaxFavor)
        return
    end
    self.addFavorDis = self.addFavorDis - 1
    self.loadingBar_goodFeelingProgress:setPercent(RoleDataMgr:getRoleInfo(self.useId).favorPercent - self.addFavorDis)
    self.Label_proValue:setString(RoleDataMgr:getRoleInfo(self.useId).favor .. "/" .. RoleDataMgr:getRoleInfo(self.useId).curLvMaxFavor)
end

function FavorView:addFavorValue(value)

    print("*******************************************FavorView addFavorValue ",value)

    local addFavorAnim = function()
        local fup = self.Panel_fUp:clone():show()
        local disH = self.loadingBar_goodFeelingProgress:Size().height/100
        -- fup:PosY(fup:PosY() + self.loadingBar_goodFeelingProgress:getPercent()*disH)
        self.Panel_fUp:getParent():addChild(fup)
        local goodFeelingValue = fup:getChildByName("Label_goodFeelingValue")
        local Panel_goodFeelingUp = fup:getChildByName("Panel_goodFeelingUp")
        fup:setOpacity(255)
        local str = "+" .. value
        goodFeelingValue:setText(str)
        local favorSpwanAc = {
            MoveBy:create(.5,ccp(0,100)),
            FadeOut:create(1.5)
        }
        local function funAc()
            fup:removeFromParent()
        end
        local favorAc = {
            Spawn:create(favorSpwanAc),
            CCCallFunc:create(funAc)
        }
        fup:runAction(CCSequence:create(favorAc))
        self:startProgressTimer(value)
    end

    if self.isHide then
        self:showFavor(0.1, addFavorAnim)
        self:timeOut(function() self:hideFavor(0.1) end, 2.0)
    else
        addFavorAnim()
    end
end

function FavorView:startProgressTimer(value)
    local interval= 10
    self.addFavorDis = value
    self:removeProgressTimer()
    self.timerID_ = TFDirector:addTimer(interval, value, nil, handler(self.updateProgress, self))
end

function FavorView:removeProgressTimer()
    if self.timerID_ then
        TFDirector:removeTimer(self.timerID_)
        self.timerID_ = nil
    end
end

function FavorView:updateProgress(delta)
    self:refreshProgress()
    self:refreshStar()
end

function FavorView:showFavor(time, animcall)
    self:stopAllActions()
    self.Panel_goodFeeling:stopAllActions()
    self.Panel_goodFeeling:setOpacity(0)
    local fadein = FadeTo:create(time, 255)
	local callfunc = CCCallFunc:create(animcall)
	self.Panel_goodFeeling:runAction(CCSequence:create({fadein, callfunc}))
    -- self.Panel_goodFeeling:fadeIn(time)
end

function FavorView:hideFavor(time)
    self.Panel_goodFeeling:stopAllActions()
    self.Panel_goodFeeling:setOpacity(255)
    local fadeout = FadeTo:create(time, 0)
    self.Panel_goodFeeling:runAction(fadeout)
end

function FavorView:onClose()
    self.super.onClose(self)
end

--移除事件
function FavorView:removeEvents()
    self.super.removeEvents(self)

    self:removeProgressTimer()
end


-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function FavorView:onShow()
    self.super.onShow(self)
    self:enterAction()
end

function FavorView:enterAction()
end

function FavorView:onRefreshKanBanNiangEvent()
    local lastFavor = self.useRoleInfo.favor
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    local addFavorValue = self.useRoleInfo.favor - lastFavor

    if addFavorValue ~= 0 then
        self:addFavorValue(addFavorValue)
    end
end

--注册事件
function FavorView:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshFavorLevel, handler(self.onRefreshFavorLevel, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRole, handler(self.onRefreshKanBanNiangEvent, self))
end

return FavorView;
