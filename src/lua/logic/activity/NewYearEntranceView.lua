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
* 新年活动主入口
]]

local NewYearEntranceView = class("NewYearEntranceView",BaseLayer)
local UserDefalt = CCUserDefault:sharedUserDefault()

function NewYearEntranceView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self:init("lua.uiconfig.activity.NewYearEntranceView")
end

function NewYearEntranceView:initUI( ui )
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

function NewYearEntranceView:updateActivity( )
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	-- self.image_title:setTexture(activityInfo.showIcon)
	local startDate = Utils:getLocalDate(activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.label_activityTime:setTextById(800041, startDateStr, endDateStr)
    self.label_Des:setText(activityInfo.extendData.desc or "")

    local cg_cfg = TabDataMgr:getData("Cg")[activityInfo.extendData.cg]
    local layer = require("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil,false,function ()
           
        end)

    if not self.panel_cg.cg then
	    local parentSize = self.panel_cg:Size()
	    local scaleX = parentSize.width/1368
	    local scaleY = parentSize.height/640
	    layer:setScale(math.max(scaleX,scaleY))
	    self.panel_cg:addChild(layer)
	    self.panel_cg.cg = layer
	end
end

function NewYearEntranceView:registerEvents()
	self.super.registerEvents(self)
	self.btn_go:onClick(function ( ... )
		self:jumpFunc()
	end)
end

function NewYearEntranceView:jumpFunc( ) 
	local playerId = MainPlayer:getPlayerId()
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local stageData = activityInfo.extendData.stageDesc[activityInfo.extendData.stage]
	if not stageData then
		Utils:showTips(303064)
		return
	end
	local datingId = stageData.datingId
    local isFirstOpen = UserDefalt:getStringForKey("isFirstPlayDating"..playerId.."-"..datingId)
    if isFirstOpen == "" then
        FunctionDataMgr:jStartDating(datingId)
        UserDefalt:setStringForKey("isFirstPlayDating"..playerId.."-"..datingId,"FALSE")
    end
	Utils:openView("activity.ActivityCAEMainView",self.activityId)
end

return NewYearEntranceView