local MovieScene = class("MovieScene", function()
    return CCScene:create()
end)

function MovieScene:ctor(params)
    params = params or {}
    params.scene = self
	local layer = require("lua.logic.movie.MovieLayer"):new(params)
    self:addChild(layer)
    self:retain()
    DelayCall(function()
        me.Director:setTopScene(self)
        self:release()
    end)

    self.layer = layer

    self:updateUIUserInterfaceStyle()
end

function MovieScene:updateUIUserInterfaceStyle( )
    -- body
    if self.darkPanel then   
        self.darkPanel:removeFromParent()
        self.darkPanel = nil
    end
    if SettingDataMgr:getDarkModel() == 3 then return end--长关
    if (HeitaoSdk and HeitaoSdk.getUIUserInterfaceStyleDark() == "1") or SettingDataMgr:getDarkModel() == 2 then
        self.darkPanel = TFPanel:create()
        self.darkPanel:setSize(GameConfig.WS)
        self.darkPanel:setTouchEnabled(false)
        self.darkPanel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
        self.darkPanel:setBackGroundColorOpacity(150)
        self.darkPanel:setBackGroundColor(ccc3(0, 0, 0))
        self:addChild(self.darkPanel, 1000)
    end
end

function MovieScene:play(loop)
    self.layer.video:play(loop)
end

function MovieScene:setFile(path)
    self.layer.video:setFile(path)
end

function MovieScene:showShare()
    self.layer.video:showShare();
end

function MovieScene:showSkip(isShow)
    self.layer.video:showSkip(isShow);
end

function MovieScene:addLayer(layer)
    self.layer.video:addChild(layer)
end

function MovieScene:addLoadingLayer(layer)
     self.layer.video:addChild(layer,999)
     layer:setPosition(ccp(0,-layer:getSize().height / 2))
end

function MovieScene:addCustomLayer(layer)
     self.layer.video:addChild(layer,998)
     layer:setPosition(ccp(0,0))
end

function MovieScene:dispose()
    self.layer:dispose()
end

return MovieScene