--[[
    @desc:通用文本提示窗
]]

local TxtRuleContentShowView = class("TxtRuleContentShowView", BaseLayer)

function TxtRuleContentShowView:initData(txtContentId, lin)
    self.txtContentId = txtContentId
end

function TxtRuleContentShowView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.txtRuleContentShowView")
end

function TxtRuleContentShowView:initUI(ui)
    self.super.initUI(self,ui)

    self._ui.labContent:setLineHeight(45)
    self._ui.labContent:hide()
    local listView = UIListView:create(self._ui.scrollView)
    for k, v in ipairs(self.txtContentId) do
        local txt_rule = self._ui.labContent:clone()
        txt_rule:show()
        txt_rule:setTextById(v)
        listView:pushBackCustomItem(txt_rule)
    end
end

function TxtRuleContentShowView:registerEvents()
    self._ui.btn_Close:onClick(function()
        AlertManager:close(self)
    end)
end 

return TxtRuleContentShowView