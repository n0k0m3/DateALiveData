EC_TeamReviveParams = {
	["msg"] = 2100085, --提示的内容id
    ["title"] = 2100088, --面板标题id
    ["revive_title"] = 2100088, --复活按钮标题id
    ["reviveCallback"] = nil, --重生按钮点击回调
    ["closeCallback"] = nil, --关闭按钮点击回调
    ["cost_id"] = nil, --消耗物品id
    ["cost_count"] = 0, --消耗物品数量
    ["has_revive_times"] = 0, --剩余复活次数
}

function showTeamFightReviveView(params)
    local layer = require("lua.logic.battle.TeamFightReviveView"):new(params)
    AlertManager:addLayer(layer)
    AlertManager:show()
end

local TeamFightReviveView = class("TeamFightReviveView",BaseLayer)

CREATE_PANEL_FUN(TeamFightReviveView)

function TeamFightReviveView:ctor(data)
    self.super.ctor(self)
    self.params = data
    self:init("lua.uiconfig.battle.teamReviveView")
end

function TeamFightReviveView:initUI(ui)
    self.super.initUI(self,ui)
    self.root_panel = TFDirector:getChildByPath(ui,"Panel_root")
    local page_panel = self.root_panel:getChildByName("Panel_page")
    self.msg_label = page_panel:getChildByName("Label_revive_tip")
    self.alert_title = page_panel:getChildByName("Label_pad_title")
    self.revive_btn = page_panel:getChildByName("Button_revive")
    local revive_title = self.revive_btn:getChildByName("Label_title")
    revive_title:setTextById(self.params.revive_title)
    self.alert_title:setTextById(self.params.title)
    self.close_btn = page_panel:getChildByName("Button_close")
    if self.params.msg then
        self.msg_label:setTextById(self.params.msg)
    end
    page_panel:getChildByName("Label_revive_times"):setTextById(2100086)
    page_panel:getChildByName("Label_revive_value"):setString(tostring(self.params.has_revive_times))
    local free_panel = page_panel:getChildByName("Panel_free")
    free_panel:getChildByName("Label_free"):setTextById(2100087)
    local cost_panel = page_panel:getChildByName("Panel_cost")
    if self.params.cost_count == 0 then
        cost_panel:setVisible(false)
        free_panel:setVisible(true)
    else
        free_panel:setVisible(false)
        cost_panel:setVisible(true)
        local costitemCfg = GoodsDataMgr:getItemCfg(self.params.cost_id)
        cost_panel:getChildByName("Image_cost_icon"):setTexture(costitemCfg.icon)
        cost_panel:getChildByName("Label_cost_value"):setString(tostring(self.params.cost_count))
    end


end

function TeamFightReviveView:registerEvents()
    self.close_btn:onClick(function()
    	if self.params.closeCallback then
            self.params.closeCallback()
        end
        AlertManager:close()
    end)

    self.root_panel:onClick(function()
		if self.params.closeCallback then
            self.params.closeCallback()
        end
        AlertManager:close()
    end)

    self.revive_btn:onClick(function()
        if self.params.reviveCallback then
            self.params.reviveCallback()
        end
        AlertManager:close()
    end)
end

function TeamFightReviveView:removeUI()
    self.super.removeUI(self)
end

return TeamFightReviveView