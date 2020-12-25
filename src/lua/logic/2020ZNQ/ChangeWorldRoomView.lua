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

local ChangeWorldRoomView = class("ChangeWorldRoomView",BaseLayer)

function ChangeWorldRoomView:ctor( roomTypes )
	-- body
	self.super.ctor(self)
    self.leftRoomType = roomTypes[1]
    self.rightRoomType = roomTypes[2]
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.changeWorldRoomView")
end

function ChangeWorldRoomView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.btn_change_room   = TFDirector:getChildByPath(ui, "Button_room")
    self.label_roomNums   = TFDirector:getChildByPath(ui, "label_roomNums")
    local minRoomId, maxRoomId = WorldRoomDataMgr:getRoomIDRange(self.leftRoomType)
    self.label_roomNums:setText(minRoomId.." - "..maxRoomId)
    self.btn_gonghui       = TFDirector:getChildByPath(ui, "Button_gonghui")
    self.tf_input          = TFDirector:getChildByPath(ui, "TextField_input")
    self.tf_input:setText(WorldRoomDataMgr:getRoomID())
    self:initInpuLayer()
end

function ChangeWorldRoomView:initInpuLayer()
    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendRoomBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer, 1000)
end

function ChangeWorldRoomView:onTouchSendRoomBtn()
    local content = self.tf_input:getText()
    if content and #content > 0 and tonumber(content) then
        local roomId = math.floor(tonumber(content))
    	local minRoomId, maxRoomId = WorldRoomDataMgr:getRoomIDRange(self.leftRoomType)
        if roomId < minRoomId or roomId > maxRoomId then
            Utils:showTips(13202022)
            return
        end
        if roomId == tonumber(WorldRoomDataMgr:getRoomID()) then
            --已在当前频道
            Utils:showTips(240027)
        else
            WorldRoomDataMgr:sendChangeRoom(roomId,self.leftRoomType)
        end
    else
        Utils:showTips(800104)
    end
end

function ChangeWorldRoomView:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    self.tf_input:addMEListener(TFTEXTFIELD_DETACH, handler(self.onTextFieldChangedHandleAcc, self))
    self.tf_input:addMEListener(TFTEXTFIELD_ATTACH, handler(self.onTextFieldAttachAcc, self))
    self.tf_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, handler(self.onTextFieldChangedHandleAcc, self))

	self.btn_gonghui:onClick(function()
        self.tf_input:closeIME()
        --TODO 特殊房间号
        WorldRoomDataMgr:sendChangeRoomToUnion(self.rightRoomType)
    end)


    --打开输入框
    self.btn_change_room:onClick(function()
        -- 打开输入框
        self.tf_input:openIME()
    end)
end


function ChangeWorldRoomView:onCloseInputLayer()
    self.tf_input:closeIME()
end

function ChangeWorldRoomView:onTextFieldChangedHandleAcc(input)
    self.inputLayer:listener(input:getText())
end

function ChangeWorldRoomView:onTextFieldAttachAcc(input)
    self.inputLayer:show()
    self.inputLayer:visit()
    self.inputLayer:listener(input:getText())
end

return ChangeWorldRoomView