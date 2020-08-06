local AgoraLotteryPreviewView = class("AgoraLotteryPreviewView", BaseLayer)

function AgoraLotteryPreviewView:ctor()
    self.super.ctor(self)
    self:initData()
    self:showPopAnim(true)
    self:init("lua.uiconfig.agora.agoraLotteryPreviewView")
end

function AgoraLotteryPreviewView:initData(openWorldId)

end

function AgoraLotteryPreviewView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")

    self:initUiInfo()
end

function AgoraLotteryPreviewView:initUiInfo()

end

function AgoraLotteryPreviewView:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

end

return AgoraLotteryPreviewView