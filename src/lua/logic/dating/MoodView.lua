local MoodView = class("MoodView",BaseLayer)

function MoodView:initData(data)
    data = data or {}
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    self.isHide = data.isHide
    self.pos = data.pos
end

function MoodView:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)
    self:init("lua.uiconfig.dating.moodView")
end

function MoodView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:refreshInfo()

    if self.isHide then
        self.moodBtn:setOpacity(0)
    end
end

function MoodView:refreshInfo()
    self.useId = RoleDataMgr:getCurId()
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    self.moodBtn = TFDirector:getChildByPath(self.ui,"Image_mood")
    self.moodBtn:Pos(self.pos or self.moodBtn:Pos())
    self.moodBtn.savePos = self.moodBtn:getPosition()
    self.moodBtn:setTouchEnabled(true)
    -- self.moodBtn:onClick(handler(self.moodBtnClickHandle,self))
    self.addMoodValuesLabel = TFDirector:getChildByPath(self.ui,"Label_addMoodValues")
    self.addMoodValuesLabel:setOpacity(0)
    self.addMoodValuesLabel.savePos = self.addMoodValuesLabel:getPosition()
    self.Image_moodLast = TFDirector:getChildByPath(self.ui,"Image_moodLast"):hide()
    self.Image_moodLast:setOpacity(0)
    self.Image_moodUp = TFDirector:getChildByPath(self.ui,"Image_moodUp")
    self.Image_moodUp:setOpacity(0)
    local moodIconPath = self.useRoleInfo.moodPath
    local moodIconName = string.format("%s%s.png",moodIconPath,tostring(self.useRoleInfo.moodLevel))
    self.moodBtn.iconName = moodIconName
    self.moodBtn:setTexture(moodIconName)
end

function MoodView:addMoodValue(value)
    print("addMoodValue ",value)

    local addMoodAnim = function ()
        local str = "+" .. value
        self.addMoodValuesLabel:setText(str)

        local moodIconPath = self.useRoleInfo.moodPath
        local moodIconName = string.format("%s%s.png",moodIconPath,tostring(self.useRoleInfo.moodLevel))
        if self.moodBtn.iconName == moodIconName then

        else
            self.Image_moodLast:setTexture(self.moodBtn.iconName)
            self.ui:runAnimation("Action1",1);
        end

        self.moodBtn:setTexture(moodIconName)
        self.moodBtn.iconName = moodIconName

        self.ui:runAnimation("Action0",1);
    end

    if self.isHide then
        self:showMood(0.1, addMoodAnim)
        self:timeOut(function() self:hideMood(0.1) end, 2.0)
    end
end

function MoodView:showMood(time, animcall)
    self:stopAllActions()
    self.moodBtn:stopAllActions()
    self.moodBtn:setOpacity(0)
    local fadein = FadeTo:create(time, 255)
    local delay = CCDelayTime:create(0.1)
	local callfunc = CCCallFunc:create(animcall)
	self.moodBtn:runAction(CCSequence:create({fadein, delay, callfunc}))
    -- self.moodBtn:fadeIn(time)
end

function MoodView:hideMood(time)
    self.moodBtn:stopAllActions()
    self.moodBtn:setOpacity(255)
    local fadeout = FadeTo:create(time, 0)
    self.moodBtn:runAction(fadeout)
end

function MoodView:onClose()
    self.super.onClose(self)
end


-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function MoodView:onShow()
    self.super.onShow(self)
    self:enterAction()
end

function MoodView:enterAction()
end

function MoodView:moodBtnClickHandle(btn)
    local data = {}
    data.value = self.useRoleInfo.mood
    self.moodLayer = require("lua.logic.dating.MoodLayer"):new(data)
    -- AlertManager:addLayer(moodLayer,AlertManager.BLOCK_CLOSE,AlertManager.TWEEN_NONE)
    -- AlertManager:show()
    self:addLayer(self.moodLayer,999)
end

function MoodView:onRefreshKanBanNiangEvent()
    local lastMood = self.useRoleInfo.mood
    self.useRoleInfo = clone(RoleDataMgr:getRoleInfo(self.useId))
    local addMoodValue = self.useRoleInfo.mood - lastMood

    if addMoodValue ~= 0 then
        self:addMoodValue(addMoodValue)
    end
end

--注册事件
function MoodView:registerEvents()
    self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_DATING_EVENT.refreshRole, handler(self.onRefreshKanBanNiangEvent, self))
end

return MoodView;
