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
* 时装召唤活动主入口
]]

local ClotheseSummonView = class("ClotheseSummonView",BaseLayer)

function ClotheseSummonView:ctor( data )
	self.super.ctor(self,data)
	self.activityId = data
	self:init("lua.uiconfig.activity.clotheseSummonView")
end

function ClotheseSummonView:initUI( ui )
	self.super.initUI(self,ui)
	self.image_bg = TFDirector:getChildByPath(ui, "image_bg")
	self.label_tip1 = TFDirector:getChildByPath(ui, "label_tip1")
	self.label_activityTime = TFDirector:getChildByPath(ui, "label_activityTime")
	self.label_Des = TFDirector:getChildByPath(ui, "label_Des")
	self.btn_go = TFDirector:getChildByPath(ui, "btn_go")

	self:updateActivity()
end

function ClotheseSummonView:updateActivity( )
	local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	local startDate = Utils:getLocalDate(activityInfo.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(activityInfo.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.label_activityTime:setTextById(800041, startDateStr, endDateStr)
    self.label_Des:setText(activityInfo.extendData.des2 or "")
end

function ClotheseSummonView:registerEvents()
	self.super.registerEvents(self)
	self.btn_go:onClick(function ( ... )
		self:jumpFunc()
	end)
end

function ClotheseSummonView:jumpFunc( ) 
	local jumpIndex
    local summon_ = SummonDataMgr:getSummon()
    if summon_ then
        for i, v in ipairs(summon_) do
            local summonCfg = SummonDataMgr:getSummonCfg(v[1].id)
            if summonCfg.summonType == EC_SummonType.CLOTHESE then
                jumpIndex = i
                break
            end
        end
    end

    FunctionDataMgr:jSummon(jumpIndex)
end

return ClotheseSummonView