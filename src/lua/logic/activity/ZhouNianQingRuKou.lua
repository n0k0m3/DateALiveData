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
* -- 周年庆回忆活动入口
]]

local ZhouNianQingRuKou = class("ZhouNianQingRuKou",BaseLayer)

local AnniversaryMonthBgTab = TabDataMgr:getData("AnniversarymonthBg")
function ZhouNianQingRuKou:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.activity.znqEntranceView")
end

function ZhouNianQingRuKou:initData( data )
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId) or self.activityInfo
	self.monthBgData = AnniversaryMonthBgTab[self.activityInfo.extendData.yearMonth] -- 活动底部事件组配置信息
end

function ZhouNianQingRuKou:initUI( ui )
	self.super.initUI(self,ui)
	self.Panel_danmu = TFDirector:getChildByPath(ui,"Panel_danmu")
	self.Panel_cg = TFDirector:getChildByPath(ui,"Panel_cg")
	self.Button_huigu = TFDirector:getChildByPath(ui,"Button_huigu")
	self.Button_shop = TFDirector:getChildByPath(ui,"Button_shop")
	self.Button_zhaohuan = TFDirector:getChildByPath(ui,"Button_zhaohuan")
	self.Button_fsdm = TFDirector:getChildByPath(ui,"Button_fsdm")
	self.Button_go = TFDirector:getChildByPath(ui,"Button_go")

	self.label_activityTime = TFDirector:getChildByPath(ui,"label_activityTime")
	self.label_curStageTime = TFDirector:getChildByPath(ui,"label_curStageTime")

	self.label_activityTime:setSkewX(15)
	self.label_curStageTime:setSkewX(15)

	self.label_activityTimeTip = TFDirector:getChildByPath(ui,"label_activityTimeTip")
	self.label_curStageTip = TFDirector:getChildByPath(ui,"label_curStageTip")
	self.label_activityTimeTip:setSkewX(15)
	self.label_curStageTip:setSkewX(15)
	
	self.cgIds = Utils:getKVP(81027,"cg")
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
	    type = EC_DanmuType.ZNQ,
	    autoRun = true,
	    rowNum = 6,    
	}

	
	self.danmuFrame = Utils:createDanmuFrame(pram)

 	local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
        	local text = self.input:getText()
        	if text ~= "" then
	            DanmuDataMgr:sendDanmu(EC_DanmuType.ZNQ, text)
	        end
        end,
        closeCallback = function()
        	self:onCloseInputLayer()
        end
    }


	self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
	self:addLayer(self.inputLayer,1000);
	-- self.inputLayer:setPositionX((GameConfig.WS.width - 1386) / 2);
	self:updateView()
end

function ZhouNianQingRuKou:updateView( ... )
	self:initData(self.activityId)
    self.label_activityTime:setText(ActivityDataMgr2:getTimeString(self.activityId))
    self.label_curStageTime:setText(self.monthBgData.date)
end

function ZhouNianQingRuKou:onShow()
	self.super.onShow(self)
end

function ZhouNianQingRuKou:onCloseInputLayer()
    self.input:closeIME()
    self.input:setText("")
end

function ZhouNianQingRuKou:removeEvents( )
	self.super.removeEvents(self)
	self.danmuFrame:removeEvents()
end

function ZhouNianQingRuKou:registerEvents( )
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
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.updateActivity, self))

	self.input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
    self.Button_huigu:onClick(function ( ... )
    	-- body
		Utils:openView("activity.ZhouNianQingHuiGu",self.activityId)
    end)

    self.Button_shop:onClick(function ( ... )
    	FunctionDataMgr:jStore(storeCid,EC_StoreType.ZNQ)
    end)

    self.Button_zhaohuan:onClick(function ( ... )
    	-- body
    	SimulationSummonDataMgr:reqSimulateSummonInfo() 
    end)

    self.Button_go:onClick(function ( ... )
    	-- body
		if ActivityDataMgr2:checkYearActivityCurMonthStatus(self.activityId,self.activityInfo.extendData.yearMonth) then
			Utils:showTips(self.monthBgData.tips)
		else
    		Utils:openView("activity.ZhouNianQingMain",{activityId = self.activityId})
    	end
    end)
end

function ZhouNianQingRuKou:updateActivity(  )
	self:updateView( )
end

return ZhouNianQingRuKou