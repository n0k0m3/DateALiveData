
local SisinaiChapterTipsView = class("SisinaiChapterTipsView", BaseLayer)

function SisinaiChapterTipsView:ctor(...)
    self.super.ctor(self, ...)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.fuben.sisinaiChapterTips")
end

function SisinaiChapterTipsView:initData(...)

end

function SisinaiChapterTipsView:initUI(ui)
    self.super.initUI(self, ui)

    local panel_root = ui:getChildByName("Panel_root")
    local Button_ok = panel_root:getChildByName("Button_ok")
    Button_ok:onClick(function(sender)  --进入四糸乃章节
    	 AlertManager:closeLayerByName("FubenLevelView")
    	 local function toOpenLevelView()
                        FubenDataMgr:cacheSelectFubenType(1)
                        FubenDataMgr:cacheSelectChapter(2)
                        Utils:openView("fuben.FubenLevelView", 2)
                        AlertManager:closeLayer(self)
          end
         TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                 toOpenLevelView()
          end,true)
    end)
end

return SisinaiChapterTipsView