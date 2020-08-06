
local BattleUtils = import(".BattleUtils")
local BattleConfig = import(".BattleConfig")
local BattleController  = import(".BattleController")

--组队测试界面
local TeamView = class("TeamView", BaseLayer)

function TeamView:ctor(...)
    self.super.ctor(self, ...)
    self:init("lua.uiconfig.battle.teamView")
end

-- function TeamView:removeEvents()
--     self:removeMEListener(TFWIDGET_ENTERFRAME)
-- end

function TeamView:registerEvents()
    self.button_back:onClick(function()
            AlertManager:close()
        end)
end

function TeamView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root  = TFDirector:getChildByPath(ui, "Panel_root")
    self.button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")
    self.panel_heros = {}
    for index = 1 ,3 do
        local node = self.Panel_root:getChildByName("Panel_heroItem"..index)
        node.image_level = TFDirector:getChildByPath(node, "Image_level")--:hide()
        node.label_level = TFDirector:getChildByPath(node.image_level, "Label_level")
        node.image_name  = TFDirector:getChildByPath(node, "Image_name") --:hide()
        node.Label_name  = TFDirector:getChildByPath(node.image_name, "Label_name")
        node.image_diban = TFDirector:getChildByPath(node, "Image_diban")
        self.panel_heros[index] = node
    end
end




return TeamView
