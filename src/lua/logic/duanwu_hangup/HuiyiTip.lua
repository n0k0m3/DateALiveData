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

local HuiyiTip = class("HuiyiTip",BaseLayer)

local COL_NUM = 4 -- 行数量

function HuiyiTip:initData(...)
	local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DUANWU_HANGUP)[1]
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self.data = self.activityInfo.extendData.pokedexDating
	table.sort(self.data, function(a, b)
		return a < b
	end)
	self.gridViewItems = {}
end

function HuiyiTip:ctor( ... )
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
	self:init("lua.uiconfig.activity.huiyiTip")
end

function HuiyiTip:initUI( ui )
	self.super.initUI(self,ui)

	self.gridView = UIGridView:create(self._ui.ScrollView_list)
	self.gridView:setItemModel(self._ui.Panel_item)
	self.gridView:setColumn(COL_NUM)
	local sumWidth = self._ui.ScrollView_list:getContentSize().width
	local needColMargin = (sumWidth - self._ui.Panel_item:getContentSize().width * COL_NUM) / (COL_NUM - 1)
    self.gridView:setColumnMargin(needColMargin)
	self.gridView:setRowMargin(needColMargin)

	local scrollBar = UIScrollBar:create(self._ui.Image_scrollBarModel, self._ui.Image_scrollBarInner)
	self.gridView:setScrollBar(scrollBar)
	
	self:updateGirdView()
end

function HuiyiTip:registerEvents()
	self._ui.Button_close:onClick(function()
		AlertManager:close(self)
	end)
end

function HuiyiTip:addGirdItem()
	local item = self.gridView:pushBackDefaultItem()
    local foo = {}
    foo.root = item
	foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
	foo.Image_lock = TFDirector:getChildByPath(foo.root, "Image_lock")
	foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    self.gridViewItems[item] = foo
end

function HuiyiTip:updateGirdView()
	local sumNum = #self.data - #self.gridView:getItems() 
	for i = 1, math.abs(sumNum) do
		if sumNum > 0 then
			self:addGirdItem()
		else
			self.gridView:removeItem(1)
		end
	end

	local _bool = self.activityInfo.extendData.eventEndingTimeStamp >= ServerDataMgr:getServerTime()
	for j, v in ipairs(self.gridView:getItems()) do
		local datingId = self.data[j]
		local cfg = DatingDataMgr:getDatingRuleData(datingId)
		local tab = self.gridViewItems[v]
		tab.Label_name:setTextById(cfg.datingContent) 
		if self.activityInfo.extendData.endOpenDating and table.find(self.activityInfo.extendData.endOpenDating,datingId) == -1 then
			tab.Image_lock:setVisible(not DatingDataMgr:checkScriptIdIsFinish(datingId))
		else
			tab.Image_lock:setVisible(not DatingDataMgr:checkScriptIdIsFinish(datingId) and _bool)
		end
		-- tab.Image_icon:setTexture(cfg.portail) 
		-- tab.Image_icon:setSize(CCSizeMake(90,90))
		tab.Image_icon:setTouchEnabled(not tab.Image_lock:isVisible())
		tab.Image_icon:onClick(function()
			DatingDataMgr:startDating(datingId)
		end)
	end

end

return HuiyiTip