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
*-- 弹幕通用蒙版
* 
]]

local DanmuMark = class("DanmuMark",BaseLayer)

function DanmuMark:ctor(data)
	-- body
	self.super.ctor(self,data)
	self.danmuData = data
	self.danmuId = data.id
	self:init("lua.uiconfig.common.danmuMark")
end

function DanmuMark:initUI(ui)
	self.super.initUI(self,ui)

	local panel_danmu = TFDirector:getChildByPath(ui,"panel_danmu")

	panel_danmu:setSize(CCSizeMake(GameConfig.WS.width,self.danmuData.danmuHeight))

	panel_danmu:setPositionY(GameConfig.WS.height - self.danmuData.offset - self.danmuData.danmuHeight)

	self.input = TFDirector:getChildByPath(ui,"Text_input")

	self.Button_talk = TFDirector:getChildByPath(ui,"Button_talk")
	self.Button_switch = TFDirector:getChildByPath(ui,"Button_switch")
	self.Button_skip = TFDirector:getChildByPath(ui,"Button_skip")
	self.Label_tip2 = TFDirector:getChildByPath(ui,"Label_tip2")
	self.Label_tip1 = TFDirector:getChildByPath(ui,"Label_tip1")

	self.Label_tip2:setSkewX(10)
	self.Label_tip1:setSkewX(10)
	local maxLength = Utils:getKVP(81026,"textNum",30)
	self.input:setMaxLength(maxLength)
	local pram = {
	    parent = panel_danmu,
	    type = self.danmuId,
	    autoRun = self.danmuData.autoRun,
	    row =  self.danmuData.rowNum,
	    speed = 150    
	}

	
	self.danmuFrame = Utils:createDanmuFrame(pram)

 	

	TFDirector:send(c2s.CHAT_REQ_BULLET_INFO,{self.danmuId})
end

function DanmuMark:onCloseInputLayer()
    self.input:closeIME()
    self.input:setText("")
end

function DanmuMark:registerEvents()
	self.super.registerEvents(self)
	local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.inputLayer:show()
        self.inputLayer:listener(input:getText())
        -- EventMgr:dispatchEvent(PlayerInfoConfig.EV_INPUT)
    end

	self.input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_switch:onClick(function ( ... )
    	local isVisible = self.danmuFrame:isVisible()
    	self.danmuFrame:setVisible(not isVisible)
    	local texture = "ui/danmu/004.png"
    	if not isVisible then
    		texture = "ui/danmu/003.png"
    	end
    	self.Button_switch:setTextureNormal(texture)
    end)

    self.Button_skip:onClick(function ( ... )
    	if self.skipCallFunc then
    		self.skipCallFunc()
    	end
    end)

    self.Button_talk:onClick(function (  )
		local coldTime = TabDataMgr:getData("Barrage",self.danmuId).coolTime
		local lastSendTime = DanmuDataMgr:getLastSendTimeByType(self.danmuId)
		local remandTime = lastSendTime - ServerDataMgr:getServerTime() + coldTime
		if remandTime > 0 then
	    	local day,hour, min, sec = Utils:getDHMS(remandTime, true)
			Utils:showTips(14210173,hour, min, sec)
			return
		end
		if not self.inputLayer	then
			local params = {
		        _type = EC_InputLayerType.SEND,
		        buttonCallback = function()
		        	local text = self.input:getText()
		        	if text ~= "" then
			            DanmuDataMgr:sendDanmu(self.danmuId, text)
			        end
		        end,
		        closeCallback = function()
		        	self:onCloseInputLayer()
		        end
		    }

			self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
			AlertManager:addLayer(self.inputLayer,AlertManager.NONE)
			AlertManager:show()
		end

		self.input:openIME()
	end)
end

function DanmuMark:removeEvents()
	self.super.removeEvents(self)
	self.danmuFrame:removeEvents()
	AlertManager:closeLayer(self.inputLayer)
end

return DanmuMark