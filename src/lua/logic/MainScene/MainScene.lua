local MainScene = class("MainScene", BaseScene)
local TFClientUpdate =  TFClientResourceUpdate:GetClientResourceUpdate()
function MainScene:ctor(data)
	self.super.ctor(self,data)
    Bugly:SetUserId(MainPlayer:getPlayerId()..":"..TFClientUpdate:getCurVersion())

    if DEBUG == 1 then
        TFDirector:registerKeyDown(117, {nGap = 500}, function() -- 'F5'
            if TFDirector.EditorModel then
                --TFDirector.bIsEditorDebug = not TFDirector.bIsEditorDebug
                if TFDirector.bIsEditorDebug then
                    print("------------------------------------- open debug model ---------------------------------------")
                else
                    print("------------------------------------- close debug model ---------------------------------------")
                end
                return 
            end
            if me.platform == "win32" then
                if gmView then
                    AlertManager:closeLayer(gmView)
                    gmView = nil
                end
                gmView = requireNew("lua.logic.test.GMView"):new()
                AlertManager:addLayer(gmView)
                AlertManager:show()
            end
        end)
    end

    if not CUtils.getVersion or CUtils.getVersion() ~= "1.0.0" then
        me.Director:endToLua();
    end
end

function MainScene:onEnter()
	self.super.onEnter(self)

	TFAudio.stopMusic()
    HeroDataMgr:changeDataToSelf()

    if not FubenDataMgr:enterFirstPlotLevel() then
        if not self.___mainLayer then
            local layer = requireNew("lua.logic.MainScene.MainLayer"):new(MainUISettingMgr:getoldui() ~= MainUISettingMgr:getui())
            self:addLayer(layer)
            self.___mainLayer = layer;
            if self.___mainLayer.onShow and AlertManager:getMainSceneCacheLayerNum() > 0 then
                self.___mainLayer:onShow()
            end
            AlertManager:openMainSceneCacheLayer()
        end
    end

    SettingDataMgr:settingDataWork()
    CommonManager.checkTipEvent()
end

function MainScene:onKeyBack()
    local topLayer = AlertManager:getTopLayer()
    if topLayer then
        AlertManager:closeTopLayer()
    else
        if HeitaoSdk then
            HeitaoSdk.loginExit()
        else
            Box("真机上调用退出")
        end
    end
end

function MainScene:onExit()
	self.super.onExit(self)
end

return MainScene;
