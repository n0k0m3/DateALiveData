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
* 委托活动主入口
]]

local EntrustEntranceView = class("EntrustEntranceView",BaseLayer)

function EntrustEntranceView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self:init("lua.uiconfig.activity.EntrustEntranceView")
end

function EntrustEntranceView:initUI( ui )
	self.super.initUI(self,ui)
	self.image_bg = TFDirector:getChildByPath(ui, "image_bg")
	self.panel_cg = TFDirector:getChildByPath(ui, "panel_cg")
	self.label_tip1 = TFDirector:getChildByPath(ui, "label_tip1")
	self.label_activityTime = TFDirector:getChildByPath(ui, "label_activityTime")
	self.image_title = TFDirector:getChildByPath(ui, "image_title")
	self.label_Des = TFDirector:getChildByPath(ui, "label_Des")
	self.btn_go = TFDirector:getChildByPath(ui, "btn_go")

	self:updateActivity()
end

function EntrustEntranceView:updateActivity( )
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.image_title:setTexture(activityInfo.extendData.nameIcon)
	self.image_bg:setTexture(activityInfo.extendData.bgIcon)
	local startDate = Utils:getLocalDate(activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.label_activityTime:setTextById(800041, startDateStr, endDateStr)
    self.label_Des:setText(activityInfo.extendData.des2 or "")

    local cg_cfg = TabDataMgr:getData("Cg")[activityInfo.extendData.cg]
    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           
        end)

    if not self.panel_cg.cg then
	    local parentSize = self.panel_cg:Size()
	    local scaleX = parentSize.width/layer:Size().width
	    local scaleY = parentSize.height/layer:Size().height
	    layer:setScale(math.max(scaleX,scaleY))
	    self.panel_cg:addChild(layer)
	    self.panel_cg.cg = layer
	end
end

function EntrustEntranceView:registerEvents()
	self.super.registerEvents(self)
	self.btn_go:onClick(function ( ... )
		self:jumpFunc()
	end)
end

function EntrustEntranceView:jumpFunc( ) 
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	if activityInfo.activityType == EC_ActivityType2.ENTRUST then 
		Utils:openView("activity.ActivityEntrustView",self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.CGCOLLECTED then
		Utils:openView("activity.ActivitySpecialCgView",self.activityId)
	elseif activityInfo.activityType == EC_ActivityType2.WELFARE_TASK then
		Utils:openView("activity.WelfareTaskView",self.activityId)
	elseif activityInfo.extendData.jumpInterface  then
		FunctionDataMgr:enterByFuncId(activityInfo.extendData.jumpInterface, activityInfo.extendData.jumpParamters)
	end
end

return EntrustEntranceView