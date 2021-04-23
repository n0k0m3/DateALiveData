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
* 交易邀请确定界面
* 
]]

local BalloonInviteView = class("BalloonInviteView", BaseLayer)

function BalloonInviteView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:init("lua.uiconfig.activity.BalloonInviteView")
end

function BalloonInviteView:initData(data)
    self.info = data
end

function BalloonInviteView:initUI(ui)
    self.super.initUI(self, ui)

    self.btn_close = TFDirector:getChildByPath(ui, "btn_close")
    self.btn_access = TFDirector:getChildByPath(ui, "btn_access")
    self.btn_refuse = TFDirector:getChildByPath(ui, "btn_refuse")
    self.check_one = TFDirector:getChildByPath(ui, "check_one")
    self.check_all = TFDirector:getChildByPath(ui, "check_all")
    self.txt_desc = TFDirector:getChildByPath(ui, "txt_desc")
    self.txt_desc:setTextById(18000006,self.info.friendName)
    self.txt_timer = TFDirector:getChildByPath(ui, "txt_timer")

    local label_title = TFDirector:getChildByPath(ui, "label_title")
    label_title:setTextById(18000015)

    local label_btn = TFDirector:getChildByPath(self.check_one, "label_btn")
    label_btn:setTextById(13317032)
    label_btn = TFDirector:getChildByPath(self.check_all, "label_btn")
    label_btn:setTextById(13317033)

    self:startTimer()
    self:updateTimeTxt()
end

function BalloonInviteView:startTimer()
	if not self.timer then
        self.timer = TFDirector:addTimer(1000, -1, nil, handler(self.updateTimeTxt, self))
    end
end

function BalloonInviteView:updateTimeTxt()
	local endTime = self.info.timeout/1000
    local serverTime = ServerDataMgr:getServerTime()
    local diffTime = endTime - serverTime
    if diffTime < 0 then
    	diffTime = 0
    	self:removeTimer()
    	self:closeHandle()
        return
    end 
    self.txt_timer:setTextById(13317058, math.floor(diffTime))
end

function BalloonInviteView:removeTimer()
    if self.timer then
        TFDirector:stopTimer(self.timer)
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

-- 是否接受 true 接受 false 拒绝
function BalloonInviteView:respHandle(accept)
    if not self.info then return end
    local oneChoose = self.check_one:getSelectedState()
    local allChoose = self.check_all:getSelectedState()
    local otherOption = 0 
    if oneChoose and allChoose then
        otherOption = 3
    else
        if oneChoose then
            otherOption = 1
        elseif allChoose then
            otherOption = 2
        end
    end
    ActivityDataMgr2:sendReqDealFriendExchangeApply(self.info.friendId, accept, otherOption)
end

function BalloonInviteView:registerEvents()
    self.super.registerEvents(self)

    self.btn_close:onClick(function()
		self:respHandle(false)
	end)

	self.btn_access:onClick(function()
		self:respHandle(true)
	end)

	self.btn_refuse:onClick(function()
		self:respHandle(false)
	end)

    EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_CANCEL, handler(self.closeHandle, self))
	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_REPLY, handler(self.closeHandle, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.closeHandle, self))
end

function BalloonInviteView:closeHandle()
	AlertManager:closeLayer(self)
end

function BalloonInviteView:removeEvents()
	self.super.removeEvents(self)
	self:removeTimer()
end

return BalloonInviteView
