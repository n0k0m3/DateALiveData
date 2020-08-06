local CourageSbView = class("CourageSbView", BaseLayer)

function CourageSbView:initData()

end

function CourageSbView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.courage.courageSbView")
end

function CourageSbView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_start = TFDirector:getChildByPath(self.Panel_root, "Panel_start"):hide()
    self:initUILogic()

end

function CourageSbView:initUILogic()

    local isNewChapter = CourageDataMgr:isNewOpenChapter()
    self.Panel_start:setVisible(isNewChapter)
    if isNewChapter then

        local chapterId,areaId = CourageDataMgr:getCurLocation()
        local cfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
        if chapterId and cfg and cfg.startDating ~= 0 then
            self:playDating(cfg.startDating)
        end

        local act = CCSequence:create({
            CCDelayTime:create(1),
            --CCFadeOut:create(2),
            CCCallFunc:create(function()
                CourageDataMgr:setNewChapterFlage(false)
                AlertManager:closeLayer(self)
            end)
        })
        self.Panel_start:runAction(act)
    else
        self:timeOut(function()
            self.Panel_start:setVisible(true)
            CourageDataMgr:setNewChapterFlage(false)
            AlertManager:closeLayer(self)
        end,0.1)
    end
end

function CourageSbView:playDating(datingRuleId)
    if datingRuleId == 0 then
        return
    end
    FunctionDataMgr:jStartDating(datingRuleId)
end

function CourageSbView:onCompleteStartDating()
    CourageDataMgr:setNewChapterFlage(false)
    AlertManager:closeLayer(self)
end

function CourageSbView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_PHASECOMPLETE, handler(self.onCompleteStartDating, self))
end


return CourageSbView
