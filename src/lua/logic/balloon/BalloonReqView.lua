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
* 邀请别人等待界面
* 
]]

local BalloonReqView = class("BalloonReqView", BaseLayer)

function BalloonReqView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.BalloonReqView")
end

function BalloonReqView:initData(data)
    self.info = data
end

function BalloonReqView:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")
    self.btn_cancel = TFDirector:getChildByPath(ui, "btn_cancel")
    self.txt_desc = TFDirector:getChildByPath(ui, "txt_desc")

    local label_title = TFDirector:getChildByPath(ui, "label_title")
    label_title:setTextById(13317055)

    self:startTimer()
    self:updateTimeTxt()
end

function BalloonReqView:startTimer()
	if not self.timer then
        self.timer = TFDirector:addTimer(1000, -1, nil, handler(self.updateTimeTxt, self))
    end
end

function BalloonReqView:updateTimeTxt()
	local endTime = self.info.timeout/1000
    local serverTime = ServerDataMgr:getServerTime()
    local diffTime = endTime - serverTime
    if diffTime < 0 then
    	diffTime = 0
    	self:removeTimer()
    	self:closeHandle()
        return
    end 
    self.txt_desc:setTextById(13317035, self.info.friendName, diffTime)
end

function BalloonReqView:removeTimer()
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
	end
end

function BalloonReqView:cancelReq()
    if not self.info then return end
    ActivityDataMgr2:sendReqExchangeApply(self.info.friendId, 2)
end

function BalloonReqView:registerEvents()
    self.super.registerEvents(self)

	self.btn_close:onClick(handler(self.cancelReq, self))
	self.btn_cancel:onClick(handler(self.cancelReq, self))

	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_CANCEL, handler(self.closeHandle, self))
	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_NOTIFY, handler(self.closeHandle, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.closeHandle, self))
end

function BalloonReqView:closeHandle()
	AlertManager:closeLayer(self)
end

function BalloonReqView:removeEvents()
	self.super.removeEvents(self)
	self:removeTimer()
end

return BalloonReqView
