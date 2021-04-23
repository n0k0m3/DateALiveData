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
* 
]]

local MaokaNewsTip = class("MaokaNewsTip",BaseLayer)

function MaokaNewsTip:ctor( ... )
	-- body
	self.super.ctor(self,...)
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.newsTip")
end

function MaokaNewsTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	self.TextField_input = TFDirector:getChildByPath(ui,"TextField_input")
	self.Label_link = TFDirector:getChildByPath(ui,"Label_link")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    local params = {
		_type = EC_InputLayerType.OK
    }
    self.Label_link:setVisible(Utils:isOfficialChannel())
    if RELEASE_TEST then
        self.Label_link:show()
    end
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);
end

function MaokaNewsTip:registerEvents( ... )
	self.super.registerEvents(self)
	-- body

    -- 关闭
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_sure:onClick(function()
        local text = self.TextField_input:getText()
        if text == "" then
            Utils:showTips(800104)
            return 
        end
        local msg = {self.TextField_input:getText()}
        TFDirector:send(c2s.LOGIN_GIFT_CODE, msg)
    end)

    self.Label_link:onClick(function()
        local liveWeb = MaokaActivityMgr:getCatRoomUrlList()
        if liveWeb then
            TFDeviceInfo:openUrl(liveWeb)
        end
    end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText());
    end

    local function onTextFieldAttachAcc(input)
        self.inputTextField = input
        self.inputLayer:show();
        self.inputLayer:listener(input:getText());
    end

   EventMgr:addEventListener(self, EV_EXCHANGE_GIFT_CODE, handler(self.onExchangeGiftEvent, self))

    self.TextField_input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
end

function MaokaNewsTip:onExchangeGiftEvent(rewards)
    --礼包获取提示弹窗
    rewards = rewards or {}
    local gifts = {}
    for i,v in ipairs(rewards) do
        local gift = Utils:makeRewardItem(v.id, v.num)
        table.insert(gifts,gift)
    end
    Utils:showReward(gifts)
end

function MaokaNewsTip:onCloseInputLayer()
    self.TextField_input:closeIME()
end
return MaokaNewsTip