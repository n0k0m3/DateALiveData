
local LevelUpView = class("LevelUpView", BaseLayer)

function LevelUpView:initData(preLevel, nowLevel)
    self.preLevel_ = preLevel
    self.nowLevel_ = nowLevel
end

function LevelUpView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.common.levelUpView")
end

function LevelUpView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch"):hide()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_level = TFDirector:getChildByPath(self.Panel_content, "Panel_level")
    self.Label_level_pre = TFDirector:getChildByPath(self.Panel_content, "Label_level_pre")
    self.Label_level_now = TFDirector:getChildByPath(self.Panel_content, "Label_level_now")
    self.Label_openFuncTips = TFDirector:getChildByPath(self.Panel_content, "Label_openFuncTips")
    self.Spine_levelUp = TFDirector:getChildByPath(self.Panel_content, "Spine_levelUp")

    self.Panel_attr = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_content, "Panel_attr_" .. i)
        item.Label_title = TFDirector:getChildByPath(item.root, "Label_title")
        item.Label_value_pre = TFDirector:getChildByPath(item.root, "Label_value_pre")
        item.Label_value_now = TFDirector:getChildByPath(item.root, "Label_value_now")
        item.Image_arrow = TFDirector:getChildByPath(item.root, "Image_arrow")
        self.Panel_attr[i] = item
    end

    self:refreshView()
end

function LevelUpView:refreshView()
    self.Spine_levelUp:play("chuxian", 0)

    local preLevelUpCfg = TabDataMgr:getData("LevelUp", self.preLevel_)
    local nowLevelUpCfg = TabDataMgr:getData("LevelUp", self.nowLevel_)

    self.Label_level_pre:setText(self.preLevel_)
    self.Label_level_now:setText(self.nowLevel_)
    local power = self.Panel_attr[1]
    power.Label_title:setTextById(800012)
    power.Label_value_pre:setText(preLevelUpCfg.maxEnergy)
    power.Label_value_now:setText(nowLevelUpCfg.maxEnergy)

    local addPower = self.Panel_attr[2]
    addPower.Image_arrow:hide()
    addPower.Label_value_now:hide()
    addPower.Label_title:setTextById(800013)
    local powerValue = 0
    for i = self.preLevel_, self.nowLevel_ - 1 do
        local levelUpCfg = TabDataMgr:getData("LevelUp", i)
        powerValue = powerValue + levelUpCfg.recovery
    end
    addPower.Label_value_pre:setText(powerValue)
end

function LevelUpView:registerEvents()
    self.Spine_levelUp:addMEListener(
        TFARMATURE_COMPLETE,
        function(skeletonNode)
            self.Spine_levelUp:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_levelUp:play("xunhuan", 1)
            self.Panel_touch:show()
        end
    )
    
    self.panelTouchFunc = function()
            AlertManager:closeLayer(self)
            FunctionDataMgr:showOpenFunc()
    end

    self:timeOut(function()
        self.Panel_touch:onClick(self.panelTouchFunc)
    end, 1)
end

function LevelUpView:specialKeyBackLogic( )
    self:panelTouchFunc()
    return true
end

return LevelUpView
