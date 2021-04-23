local SendWishView = class("SendWishView",BaseLayer)

function SendWishView:ctor( data )
    -- body
    self.super.ctor(self,data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.NewYear.sendWishView")
end

function SendWishView:initData( data )
    self.danmuId = data
end

function SendWishView:initUI( ui )
    self.super.initUI(self,ui)

    self.Button_close = TFDirector:getChildByPath(ui,"Button_close")

    self.TextField_detail = TFDirector:getChildByPath(ui,"TextField_detail")
    local maxLength = Utils:getKVP(81026,"textNum",30)
    self.TextField_detail:setMaxLength(maxLength)

    self.Image_head = TFDirector:getChildByPath(ui,"Image_head")
    self.Image_head_cover_frame = TFDirector:getChildByPath(ui,"Image_head_cover_frame")

    self.Label_sendWishView_tip = TFDirector:getChildByPath(ui,"Label_sendWishView_tip")
    self.Label_sendWishView_tip:setTextById(13205002)

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);

    self.Button_sendWish = TFDirector:getChildByPath(ui,"Button_sendWish")

    self.Image_head:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self.Image_head_cover_frame:setTexture(avatarFrameIcon)
    if avatarFrameEffect ~= "" then
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
        if not self.HeadFrameEffect then
            self.HeadFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
            self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
            self.HeadFrameEffect:setPosition(ccp(0,0))
            self.HeadFrameEffect:play("animation", true)
            self.Image_head_cover_frame:addChild(self.HeadFrameEffect, 1)
        end
    else
        if self.HeadFrameEffect then
            self.HeadFrameEffect:removeFromParent()
            self.HeadFrameEffect = nil
        end
    end

    local Label_name = TFDirector:getChildByPath(ui,"Label_name")
    Label_name:setText(MainPlayer:getPlayerName())
end

function SendWishView:onTouchSendBtn()

end

function SendWishView:onCloseInputLayer()

end

function SendWishView:updateAfterSend(danmuId)

    print(self.danmuId,danmuId)
    if self.danmuId ~= danmuId then
        return
    end
    local text = self.TextField_detail:getText()
    TFDirector:send(c2s.ACTIVITY2_REQ_SEND_SPRING_WITH_TREE,{text})
    AlertManager:closeLayer(self)
end

function SendWishView:registerEvents( )

    EventMgr:addEventListener(self, EV_DANMU_AFTER_SEND, handler(self.updateAfterSend, self))


    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText());
        self.Label_sendWishView_tip:setVisible(input:getText() == "")
    end

    local function onTextFieldAttachAcc(input)
        self.inputTextField = input
        self.inputLayer:show();
        self.inputLayer:listener(input:getText());

        self.Label_sendWishView_tip:setVisible(input:getText() == "")
    end

    self.TextField_detail:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_detail:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_detail:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_sendWish:onClick(function()
        if not  self.danmuId then
            return
        end
        local text = self.TextField_detail:getText()
        if text ~= "" then
            DanmuDataMgr:sendDanmu(self.danmuId, text)
        else
            Utils:showTips(13205004)
        end
    end)
end

return SendWishView