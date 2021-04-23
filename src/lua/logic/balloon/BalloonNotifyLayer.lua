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
* 气球交易提醒界面
* 
]]

local BalloonNotifyLayer = class("BalloonNotifyLayer", BaseLayer)

function BalloonNotifyLayer:ctor(data)
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.activity.BalloonNotifyLayer")
end

function BalloonNotifyLayer:initData(data)
    self.info = data
end

function BalloonNotifyLayer:initUI(ui)
	self.super.initUI(self, ui)

	self.img_bg = TFDirector:getChildByPath(ui, "img_bg")
	self.txt_name = TFDirector:getChildByPath(ui, "txt_name")
	self.txt_desc = TFDirector:getChildByPath(ui, "txt_desc")
	self.txt_time = TFDirector:getChildByPath(ui, "txt_time")
	self.txt_desc:setTextById(18000010)
	self.txt_name:setText(self.info.friendName)
	self.img_bg:setTouchEnabled(true)

	self:startTimer()
	self:updateTimeTxt()
	self:playAni()
end

function BalloonNotifyLayer:startTimer()
	if not self.timer then
        self.timer = TFDirector:addTimer(1000, -1, nil, handler(self.updateTimeTxt, self))
    end
end

function BalloonNotifyLayer:updateTimeTxt()
	local endTime = self.info.timeout/1000
    local serverTime = ServerDataMgr:getServerTime()
    local diffTime = math.floor(endTime - serverTime)
    if diffTime < 0 then
    	diffTime = 0
    	self:removeTimer()
    	self:timeOut()
        return
    end 
    self.txt_time:setTextById(13317058, diffTime)
end

function BalloonNotifyLayer:timeOut()
	self.img_bg:setTouchEnabled(false)
	local spawnAct = CCSpawn:create({
        CCFadeOut:create(0.5),
        CCMoveBy:create(0.5, ccp(0, 100)),
    })
    local seqAct = Sequence:create({
        spawnAct,
        CCCallFunc:create(function()
        	self:closeHandle()
        end)
    })
    self.img_bg:runAction(seqAct)
end

function BalloonNotifyLayer:removeTimer()
    if self.timer then
        TFDirector:stopTimer(self.timer)
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function BalloonNotifyLayer:playAni()
	self.img_bg:setPositionY(self.img_bg:getPositionY() + 100) 
	self.img_bg:stopAllActions()
    self.img_bg:setVisible(true)
    self.img_bg:setOpacity(0)
    local spawnAct = CCSpawn:create({
        CCFadeIn:create(0.5),
        CCMoveBy:create(0.5, ccp(0, -100)),
    })
    self.img_bg:runAction(spawnAct)
end

function BalloonNotifyLayer:registerEvents()
    self.super.registerEvents(self)

     self.img_bg:onClick(function()
     	self.img_bg:setTouchEnabled(false)
        self.img_bg:stopAllActions()
        local spawnAct = CCSpawn:create({
            CCFadeOut:create(0.5),
            CCMoveBy:create(0.5, ccp(0, 100)),
        })

        local seqAct = Sequence:create({spawnAct,
        	CCCallFunc:create(function()
                self:closeHandle()
            end)
        })
        self.img_bg:runAction(seqAct)
        Utils:openView("balloon.BalloonInviteView", self.info)
    end)

    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))
 	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_CANCEL, handler(self.closeHandle, self))
	EventMgr:addEventListener(self, EV_BALLOON_EXCHANGE_REPLY, handler(self.closeHandle, self))
    EventMgr:addEventListener(self, EV_OFFLINE_EVENT, handler(self.closeHandle, self))
end

function BalloonNotifyLayer:closeHandle()
	self:removeTimer()
	self:removeFromParent()
end

function BalloonNotifyLayer:removeEvents()
	self.super.removeEvents(self)
	self:removeTimer()
end

function BalloonNotifyLayer:_onExit()
    self:removeTimer()
end

return BalloonNotifyLayer
