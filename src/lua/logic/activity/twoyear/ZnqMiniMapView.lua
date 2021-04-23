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
local ZnqMiniMapView = class("ZnqMiniMapView", BaseLayer)

function ZnqMiniMapView:ctor(...)
    self.super.ctor(self)
    self:init("lua.uiconfig.activity.znq_miniMap")
end

function ZnqMiniMapView:initUI(ui)
	self.super.initUI(self,ui)
	self.btns = {}
	for i = 1,8 do
		self.btns[i] = TFDirector:getChildByPath(ui, "btn_room_"..i)
		local redPoint = TFDirector:getChildByPath(self.btns[i], "Image_red_tip")
		redPoint:setVisible(self:getRedPointState(i))
	end
	self:updateRedTip()
end

function ZnqMiniMapView:updateRedTip()
	for i = 1,8 do
		local redPoint = TFDirector:getChildByPath(self.btns[i], "Image_red_tip")
		redPoint:setVisible(self:getRedPointState(i))
	end
end

function ZnqMiniMapView:getRedPointState( index )
	-- body
	if index == 7 then
		return ActivityDataMgr2:isBalloonTip()
	elseif index == 5 then
		return ActivityDataMgr2:isShowRedPointInMainView(7)
	elseif index == 8 then -- 年兽界面红点逻辑
		return GoodsDataMgr:getItemCount(665105) > 0 and not FubenDataMgr.enterNianshouChanllenge
	elseif index == 9 then
		return TurnTabletMgr:isTurnTabletRedShow()
	end
	return false
end

function ZnqMiniMapView:registerEvents()
	self.super.registerEvents(self)
	EventMgr:addEventListener(self, EV_UPDATE_WISHTREE_LV, handler(self.updateRedTip, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.updateRedTip, self))
	EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateRedTip, self))
	-- body
	for k,v in ipairs(self.btns) do
		v:onClick(function ( ... )
			-- body
			WorldRoomDataMgr:getCurControl():changeMainHeroToBornPos(k)
			EventMgr:dispatchEvent(EV_WORLD_CLOSE_BASE_INFO)
		end)
	end
end

return ZnqMiniMapView