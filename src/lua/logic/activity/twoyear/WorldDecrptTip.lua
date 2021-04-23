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

local WorldDecryptTip = class("WorldDecryptTip",BaseLayer)

function WorldDecryptTip:ctor(  )
	-- body
	self.super.ctor(self)
    self.block = AlertManager.BLOCK
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.decrptTip")
end

function WorldDecryptTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_base")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root, "Button_help")
    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Image_map = TFDirector:getChildByPath(self.Panel_root, "Image_map")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Label_des = TFDirector:getChildByPath(self.Panel_root, "Label_des")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self:refreshView()
end

function WorldDecryptTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

    EventMgr:addEventListener(self, EV_WORLD_ROOM_EXTDATA_RSP, function ( activityId, extendData )
        -- body
        self:refreshView()
    end)

    self.Button_help:onClick(function ( ... )
    	-- body
		Utils:openView("common.HelpView", {3127})
    end)

	self.timer = TFDirector:addTimer(1000,-1,nil,function ( ... )
		-- body
		self:onCountPer()
	end)
end

function WorldDecryptTip:removeEvents( ... )
	-- body
	self.super.removeEvents(self)
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
	end
end

function WorldDecryptTip:refreshView( ... )
	-- body
	local decrypts = WorldRoomDataMgr:getCurExtDataControl():getDecryptInfo()

	local num = #decrypts - #self.ListView_tab:getItems()

	if num < 0 then
		for i = 1,#math.abs(num) do
			self.ListView_tab:removeItem(1)
		end
	end

	if #decrypts == 0 then return end

	self.curDecrypt = self.curDecrypt or decrypts[1].decryptTeamId
	for k,v in ipairs(decrypts) do
		local item = self.ListView_tab:getItem(k)
		if not item then
			item = self.Panel_tabItem:clone()
			self.ListView_tab:pushBackCustomItem(item)
		end
		self:updateTabItem(item,v)
	end

	self:updateContent()
end

function WorldDecryptTip:updateContent( ... )
	-- body
	local decryptCfg = TabDataMgr:getData("DecryptTeam",self.curDecrypt)

	self.Image_map:setTexture(decryptCfg.icon)
	self.Label_des:setTextById(decryptCfg.stringId)
	local decryptInfo = WorldRoomDataMgr:getCurExtDataControl():getDecryptInfo(self.curDecrypt)

	if not decryptInfo then 
		self.Label_des:show()
		self.Label_time:hide()
		return 
	end

	self.Label_des:setVisible(not decryptInfo.success)
	self.Label_time:setVisible(decryptInfo.success)
	self:onCountPer()
end

function WorldDecryptTip:onCountPer( ... )
	-- body
	local decryptInfo = WorldRoomDataMgr:getCurExtDataControl():getDecryptInfo(self.curDecrypt)
	if not decryptInfo then return end
	self.Label_time:setText(Utils:getTimeCountDownString(decryptInfo.nextTriggerTime,2))
end

function WorldDecryptTip:updateTabItem( item, decryptInfo )
	-- body
	local Image_normal = TFDirector:getChildByPath(item,"Image_normal")
	local Label_cn = TFDirector:getChildByPath(Image_normal,"Label_cn")
	local Image_select = TFDirector:getChildByPath(item,"select")
	local Label_cn_s = TFDirector:getChildByPath(Image_select,"Label_cn")

	local decryptCfg = TabDataMgr:getData("DecryptTeam",decryptInfo.decryptTeamId)
	Label_cn:setTextById(decryptCfg.des)
	Label_cn_s:setTextById(decryptCfg.des)

	Image_select:setVisible(self.curDecrypt == decryptInfo.decryptTeamId)
	Image_normal:setVisible(self.curDecrypt ~= decryptInfo.decryptTeamId)
	item:setTouchEnabled(true)
	item:onClick(function ( ... )
		-- body
		if self.curDecrypt == decryptInfo.decryptTeamId then
			return
		end
		self.curDecrypt = decryptInfo.decryptTeamId
		self:refreshView()
	end)
end

return WorldDecryptTip