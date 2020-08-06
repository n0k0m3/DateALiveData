
local BattleConfig = import("..battle.BattleConfig")
local MainLineView = class("MainLineView", BaseLayer)

function MainLineView:onEnter()
    self:battleWin()
end

function MainLineView:initData()

end

function MainLineView:ctor(...)
    self.super.ctor(self, ...)
    self:initData()
    self:init("lua.uiconfig.fuben.mainLineView")
end

function MainLineView:initUI(ui)
	self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_chapter = TFDirector:getChildByPath(self.Panel_root, "Button_chapter")
    self.Label_chapter = TFDirector:getChildByPath(self.Button_chapter, "Label_chapter")
    self.Label_point = TFDirector:getChildByPath(self.Button_chapter, "Label_point")
    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")

    self:refreshView()
end

function MainLineView:updateData()
    self.attackId_ = FubenDataMgr:getWillAtackMainLine()
    self.attackPoint_ = FubenDataMgr:getMainLinePoint(self.attackId_)
    self.isPassAll_ = FubenDataMgr:isPassAllMainLine()
end

function MainLineView:updateChaterPoint()
    self.Label_chapter:setText(self.attackPoint_.chapterName)
    local _, pointIndex = FubenDataMgr:getMainLinePointIndex(self.attackId_)
    self.Label_point:setTextById(300164, pointIndex)

    if self.isPassAll_ then

    end
end

function MainLineView:refreshView()
    self:updateData()
    self:updateChaterPoint()
end

function MainLineView:cgComplete()
    AlertManager:close()
    if self.attackPoint_.pointId == 0 then
        FubenDataMgr:setPassMainLine(self.attackPoint_.id)
        self:updateData()
        self:updateChaterPoint()
        self:playCg()
    else
        local battleController = require("lua.logic.battle.BattleController")
        battleController:enterBattle(self.attackPoint_.pointId, BattleConfig.BT_MAINLINE, self.attackPoint_)
    end
end

function MainLineView:playCg()
    local callback = handler(self.cgComplete, self)
    local cgView = require("lua.logic.cg.CgView"):new(self.attackPoint_.cgId, callback)
    AlertManager:addLayer(cgView)
    AlertManager:show()
end

function MainLineView:registerEvents()
    self.super.registerEvents(self)

    self.Button_back:addMEListener(TFWIDGET_CLICK, function()
                                       AlertManager:close()
    end)

    self.Button_chapter:addMEListener(TFWIDGET_CLICK, function()
                                          self:playCg()
    end)
end

function MainLineView:battleWin()
    self:updateData()
    self:updateChaterPoint()
    self:playCg()
end

return MainLineView
