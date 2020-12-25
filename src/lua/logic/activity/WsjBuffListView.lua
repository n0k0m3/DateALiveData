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

local WsjBuffListView = class("WsjBuffListView",BaseLayer)
local ghostChatper = TabDataMgr:getData("GhostChapter")

function WsjBuffListView:ctor( activityId )
	-- body
	self.super.ctor(self)
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.buffListView")
end

function WsjBuffListView:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	self.title = TFDirector:getChildByPath(ui,"title")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	local ScrollView_buff = TFDirector:getChildByPath(ui,"ScrollView_buff")

	self.tip = TFDirector:getChildByPath(ui,"Button_close")

	self.Panel_buff_item = TFDirector:getChildByPath(ui,"Panel_buff_item")
	self.uiGrid_buff = UIGridView:create(ScrollView_buff)

    self.uiGrid_buff:setItemModel(self.Panel_buff_item)
    self.uiGrid_buff:setColumn(3)
    self.uiGrid_buff:setColumnMargin(5)
    self.uiGrid_buff:setRowMargin(8)

	ActivityDataMgr2:reqHalloweenPass()
end

function WsjBuffListView:registerEvents( ... )
	-- body
    EventMgr:addEventListener(self, EV_ACTIVITY_HALLOWEEN_PASS_RSP, handler(self.updateBuffList, self))
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

function WsjBuffListView:updateBuffList( ... )
	-- body
	local index = 1
	for k,v in ipairs(self.activityInfo.extendData.chapterIdList) do  -- 异闻id同章节id相同
		local cfg = ghostChatper[v]
		if cfg then
			local item = self.uiGrid_buff:getItem(index)
			if not item then
				item = self.Panel_buff_item:clone()
				self.uiGrid_buff:pushBackCustomItem(item)
			end
			self:updateBuffItem(item, cfg)
		end
		index = index + 1
	end
end

function WsjBuffListView:removeEvents( ... )
	-- body
end

function WsjBuffListView:updateBuffItem( item, cfg )
	-- body
	local Panel_finish = TFDirector:getChildByPath(item,"Panel_finish"):hide()
	local Panel_progress = TFDirector:getChildByPath(item,"Panel_progress"):hide()

	local curPorgress = ActivityDataMgr2:getDungeonPassCount(cfg.progressLevel)
	local node = curPorgress >= cfg.progressAmount and Panel_finish or Panel_progress
	node:show()
	local Label_des = TFDirector:getChildByPath(node,"Label_des")
	Label_des:setTextById(cfg.des)

	local LoadingBar_progress = TFDirector:getChildByPath(node,"LoadingBar_progress")
	if LoadingBar_progress then
		LoadingBar_progress:setPercent(math.min(100,curPorgress*100/cfg.progressAmount))
	end

	local Label_progress = TFDirector:getChildByPath(node,"Label_progress")
	if Label_progress then
		Label_progress:setText(curPorgress.."/"..cfg.progressAmount)
	end

	local Label_name = TFDirector:getChildByPath(node,"Label_name")
	if Label_name then
		Label_name:setTextById(cfg.name1)
		local Label_subName = TFDirector:getChildByPath(Label_name,"Label_subName")
		Label_subName:setTextById(cfg.name2)
	end
end

return WsjBuffListView