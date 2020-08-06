local CollectScenePreView = class("CollectScenePreView",BaseLayer)

function CollectScenePreView:initData(sceneCid)

    self.sceneCid = sceneCid
end

function CollectScenePreView:ctor(sceneCid)
    self.super.ctor(self)
    self:initData(sceneCid)
    self:init("lua.uiconfig.collect.collectScenePreView")
end

function CollectScenePreView:initUI(ui)
    self.super.initUI(self,ui)
    self.root_panel = ui:getChildByName("Panel_root")
    self.Image_bg = self.root_panel:getChildByName("Image_bg")
    self.Button_back = self.root_panel:getChildByName("Button_back")
    self.Label_desc = self.root_panel:getChildByName("Label_desc")
    self.top_part1 = self.root_panel:getChildByName("top_part1")
    local sceneCfg = CollectDataMgr:getSceneChangeCfg(self.sceneCid)
    if sceneCfg then
        self:refreshBg(self.Image_bg,sceneCfg.background)
        self.Label_desc:setTextById(sceneCfg.describe)
    end

end

function CollectScenePreView:refreshBg(imageBg, bgPath)
    if bgPath then
        imageBg:setTexture(bgPath)
    end
    local height = imageBg:Size().height
    local width = imageBg:Size().width
    local scaleDisH = GameConfig.WS.height / height
    local scaleDisW = GameConfig.WS.width / width
    local scale = scaleDisH < scaleDisW and scaleDisW or scaleDisH
    local newWidth = width * scale
    local newHeigth = height * scale
    imageBg.disScale = scale
    imageBg.disSize = imageBg:Size()
    imageBg:setContentSize(CCSizeMake(newWidth, newHeigth))
end

function CollectScenePreView:registerEvents()
    self.Button_back:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Image_bg:onClick(function()
        local visible = self.top_part1:isVisible()
        self.top_part1:setVisible(not visible)
    end)

end

return CollectScenePreView