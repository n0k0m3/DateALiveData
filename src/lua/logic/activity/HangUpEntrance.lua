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


local HangUpEntrance = class("HangUpEntrance",BaseLayer)

function HangUpEntrance:ctor( data, parentNode )
	-- body
	self.super.ctor(self,data)
	self:initData(data)
	self.parentNode = parentNode
	self:init("lua.uiconfig.activity.hangUpEntrance")
end

function HangUpEntrance:initData( data )
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	if not self.activityInfo.data then
		ActivityDataMgr2:send_ACTIVITY_REQ_GET_HANG_UP_INFO(self.activityId)
	end
end

function HangUpEntrance:initUI( ui )
	self.super.initUI(self,ui)
	self.Panel_danmu = TFDirector:getChildByPath(ui,"Panel_danmu")
	self.Panel_cg = TFDirector:getChildByPath(ui,"Panel_cg")
	self.Button_fsdm = TFDirector:getChildByPath(ui,"Button_fsdm")
	self.Button_jump = TFDirector:getChildByPath(ui,"Button_jump")
	self.label_jump = TFDirector:getChildByPath(ui,"label_jump")
	self.label_jump:setSkewX(15)
	

	self.label_time = TFDirector:getChildByPath(ui, "label_time")
	self.label_date = TFDirector:getChildByPath(ui, "label_date")

	self.label_date:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))


	self.Label_fsdm = TFDirector:getChildByPath(ui,"Label_fsdm")
	self.Label_fsdm:setSkewX(15)
	
	self.cgIds = self.activityInfo.extendData.cgIds
	self.cgIndex = 1

	local function circlePlayCg( )
		-- body
		if self.cgView then self.cgView:removeFromParent(true) end

		local cg_cfg = TabDataMgr:getData("Cg")[self.cgIds[self.cgIndex]]
		local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           circlePlayCg( )
        end)

	    local parentSize = self.Panel_cg:Size()
	    local scaleX = parentSize.width/layer:Size().width
	    local scaleY = parentSize.height/layer:Size().height
	    layer:setScale(math.max(scaleX,scaleY) + 0.2)
	    self.Panel_cg:addChild(layer)
	    self.cgView = layer
		self.cgIndex = self.cgIndex%#self.cgIds + 1
	end

	if #self.cgIds > 1 then
		circlePlayCg( )
	end

	self.input = TFDirector:getChildByPath(ui,"input")
	local maxLength = Utils:getKVP(81026,"textNum",30)
	self.input:setMaxLength(maxLength)
	local pram = {
	    parent = self.Panel_danmu,
	    type = self.activityInfo.extendData.danmuId,
	    autoRun = true,
	    rowNum = 6,    
	}
	self.danmuFrame = Utils:createDanmuFrame(pram)

	 if not self.inputLayer then
		local params = {
	        _type = EC_InputLayerType.SEND,
	        buttonCallback = function()
	        	local text = self.input:getText()
	        	if text ~= "" then
		            DanmuDataMgr:sendDanmu(self.activityInfo.extendData.danmuId, text)
		        end
	        end,
	        closeCallback = function()
	        	self:onCloseInputLayer()
	        end
	    }
		self.inputLayer = require("lua.logic.common.InputLayer"):new(params);

		self.parentNode = self.parentNode or self
		local anchorPos = self.parentNode:getAnchorPoint()
		 self.inputLayer:setAnchorPoint(anchorPos)
		self.parentNode:addChild(self.inputLayer,1000);
	end
end


function HangUpEntrance:onCloseInputLayer()
    self.input:closeIME()
    self.input:setText("")
end

function HangUpEntrance:removeEvents( )
	self.super.removeEvents(self)
	self.danmuFrame:removeEvents()
end

function HangUpEntrance:registerEvents( )
	-- body
	self.Button_fsdm:onClick(function (  )
		local codeTime = Utils:getKVP(81026,"barrageTime")
		local lastSendTime = DanmuDataMgr:getLastSendTimeByType(1)
		local remandTime = lastSendTime - ServerDataMgr:getServerTime() + codeTime
		if remandTime > 0 then
	    	local day,hour, min, sec = Utils:getFuzzyDHMS(remandTime, true)
			Utils:showTips(14210173,hour, min, sec)
			return
		end
		self.input:openIME()
	end)

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
    

    self.Button_jump:onClick(function ( ... )
    	-- body
    		Utils:openView("activity.HangUpMainView", self.activityId)
    end)
end

function HangUpEntrance:onUpdateCountDownEvent(  )
	local time = self.activityInfo.showEndTime or 0
	self.label_time:setText(Utils:getTimeCountDownString(time,1))
end

return HangUpEntrance