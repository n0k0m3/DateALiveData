--[[
    @desc：ChangeMainUIPopView
    @date: 2021-01-22 18:08:56
]]

local ChangeMainUIPopView = class("ChangeMainUIPopView",BaseLayer)

function ChangeMainUIPopView:initData(info)
    self.data = info
    self.jsonData = Json.decode(info.data)
    MainUISettingMgr:setfestivalInfoStateNil()
    self.isClickYes = false
end

function ChangeMainUIPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.MainScene.changeMainUIPopView")
end

function ChangeMainUIPopView:initUI(ui)
    self.super.initUI(self,ui)
    self._ui.lab_desc:setLineHeight(40)
    self._ui.lab_desc:setTextById(self.jsonData.stringId)
    self._ui.img_show:setTexture(self.jsonData.picUrl)
end

function ChangeMainUIPopView:registerEvents()
    self._ui.btn_yes:onClick(function()
        self.isClickYes = true
        MainUISettingMgr:send_PLAYER_REQ_SET_UI_CHANGE(self.data.id, 1)
        AlertManager:close(self)
    end)
    self._ui.btn_no:onClick(function()
        AlertManager:close(self)
    end)
    self._ui.btn_close:onClick(function()
        AlertManager:close(self)
    end)
end

function ChangeMainUIPopView:onClose()
    self.super.onClose(self)
    if not self.isClickYes then
        MainUISettingMgr:send_PLAYER_REQ_SET_UI_CHANGE(self.data.id, 0)
    end
end

return ChangeMainUIPopView