local ResLoader = require("lua.logic.battle.ResLoader")
local AffixPreviewLayer = class("AffixPreviewLayer", BaseLayer)

function AffixPreviewLayer:ctor(affixIds)
    self.super.ctor(self)
    self.affixIds = affixIds
    self:showPopAnim(true)
    self:init("lua.uiconfig.osd.AffixPreviewView")
end

function AffixPreviewLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local ScrollView = TFDirector:getChildByPath(ui, "ScrollView")
    self.Panel_item = TFDirector:getChildByPath(ui, "Panel_item"):hide()
    self.listView = UIListView:create(ScrollView)
    --关闭按钮
    self.btn_close = TFDirector:getChildByPath(self.panel_root, "Button_close")
    for i, affixId in ipairs(self.affixIds) do
        local affixData = TabDataMgr:getData("MonsterAffix",affixId)
        if affixData then
            for k, v in ipairs(affixData.affixName) do
                local affixIcon  = affixData["affixIcon"..tostring(k)] 
                    if ResLoader.isValid(affixIcon) then 
                    local panelItem  = self.Panel_item:clone():show()
                    local imageAffix = TFDirector:getChildByPath(panelItem, "Image_affix")
                    local image_icon = TFDirector:getChildByPath(imageAffix, "Image_icon")
                    local label_name = TFDirector:getChildByPath(imageAffix, "Label_name")
                    local label_desc = TFDirector:getChildByPath(imageAffix, "Label_desc")
                    image_icon:setTexture(affixIcon)
                    label_name:setTextById(v)
                    label_desc:setTextById(affixData.affixDesc[k])
                    self.listView:pushBackCustomItem(panelItem)
                end 
            end
        end
    end
end

function AffixPreviewLayer:registerEvents()
    self.btn_close:onClick(function()
        AlertManager:closeLayer(self)
        end)

end


function AffixPreviewLayer:removeUI()
    self.super.removeUI(self)
    -- --测试移除 lua
    -- local TFUILoadManager       = require('TFFramework.client.manager.TFUILoadManager')
    -- TFUILoadManager:unLoadModule("lua.logic.osd.TaskLayer")
end


return AffixPreviewLayer
