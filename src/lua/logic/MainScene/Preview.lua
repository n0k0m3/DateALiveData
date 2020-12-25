local Preview = class("Preview", BaseLayer)

function Preview:ctor()
    self.super.ctor(self)
    self:showPopAnim(true)
    self:init("lua.uiconfig.MainScene.preview")
end

function Preview:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Button_preview = TFDirector:getChildByPath(self.ui, "Button_preview")
    self._ui.Spine_preview_1:setupPoseWhenPlay(false)
end

function Preview:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_preview:onClick(function()
        local info = FunctionDataMgr:getMainFuncInfo(EC_MainFuncType.PREVIEW)
        Box(info.welfareUrl)
        -- Utils:showWebView(info.welfareUrl)
        TFDeviceInfo:openUrl(info.welfareUrl)
    end)
end

return Preview