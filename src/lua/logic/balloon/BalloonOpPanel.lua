--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 取消交易的弹框
* 
]]

local BalloonOpPanel = class("BalloonOpPanel", BaseLayer)

function BalloonOpPanel:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.BalloonOpPanel")
end

function BalloonOpPanel:initData(data)
    self.friendId = data
end

function BalloonOpPanel:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")
    self.btn_sure = TFDirector:getChildByPath(ui, "btn_sure")
    self.btn_cancel = TFDirector:getChildByPath(ui, "btn_cancel")

    local txt_desc = TFDirector:getChildByPath(ui, "txt_desc")
    txt_desc:setTextById(13317042)

    local label_title = TFDirector:getChildByPath(ui, "label_title")
    label_title:setTextById(13317057)
end

function BalloonOpPanel:registerEvents()
    self.super.registerEvents(self)

	self.btn_close:onClick(handler(self.closeHandle, self))
	self.btn_cancel:onClick(handler(self.closeHandle, self))
	self.btn_sure:onClick(handler(self.onSureHandle, self))

	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_CANCEL, handler(self.closeHandle, self))
	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_RESULT, handler(self.closeHandle, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.closeHandle, self))
end

function BalloonOpPanel:onSureHandle()
	ActivityDataMgr2:sendReqCancelBalloonTrade(self.friendId)
end

function BalloonOpPanel:closeHandle()
	AlertManager:closeLayer(self)
end

return BalloonOpPanel
