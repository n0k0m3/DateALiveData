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
* -- 福利登陆活动
]]

local WelfareSignView = class("WelfareSignView",BaseLayer)

function WelfareSignView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self.datItem_ = {}
	self.countPage_ = 7
	self.activityId = data
	self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
	self.isScrollType = tonumber(self.activityInfo.extendData.isScrollType)		---1:用滑动表现形式 其他用翻页表现形式
	self.SevenItemType = tonumber(self.activityInfo.extendData.SevenItemType) or 1		---1：横放的 2:斜着的
	local uiName = self.activityInfo.extendData.uiName or "welfareSignView"
	self.curResFileName = "style2"
	print(self.activityInfo.extendData)
	dump(uiName,"uiName")
	self:init("lua.uiconfig.activity."..uiName)
end

function WelfareSignView:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
	self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
	self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")

	self.Label_time_tip = TFDirector:getChildByPath(self.Panel_root, "Label_time_tip")
	self.Label_time_begin = TFDirector:getChildByPath(self.Panel_root, "Label_time_begin")
	self.Label_time_end = TFDirector:getChildByPath(self.Panel_root, "Label_time_end")
	self.Label_time_begin:setSkewX(10)
	self.Label_time_end:setSkewX(10)
	self.Label_time_tip:setSkewX(10)
	self.Label_time_tip:setTextById( 1710002)

	self.btn_Last_ = TFDirector:getChildByPath(ui, "Button_last"):hide()
	self.btn_Next_ = TFDirector:getChildByPath(ui, "Button_next"):hide()


	self.Panel_page = TFDirector:getChildByPath(ui, "Panel_page")


	self.pos = {}
	for i = 1, self.countPage_ do
		local node = TFDirector:getChildByPath(self.Panel_page, "Image_node" .. i)
		self.pos[i] = node:Pos()
	end

	self.Panel_sevenItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_sevenItem")
	self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")

	local Panel_sevenItem1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_sevenItem1")
	Panel_sevenItem1:getChildByName("Image_border"):show()
	if self.isScrollType == 1 then
		self.Panel_sevenItem = Panel_sevenItem1
	end

	if self.SevenItemType == 1 then
		self.Panel_sevenItem = Panel_sevenItem1
	end

	local ScrollView_item = TFDirector:getChildByPath(ui, "ScrollView_item")
	self.GridView_award = UIGridView:create(ScrollView_item)
	self.GridView_award:setColumn(2)
	self.GridView_award:setColumnMargin(10)
	self.GridView_award:setRowMargin(10)
	self.GridView_award:setItemModel(self.Panel_sevenItem)
	self:intUILogic()

end

function WelfareSignView:intUILogic()

	if self.activityInfo then
		local startDate = Utils:getUTCDate(self.activityInfo.startTime, GV_UTC_TIME_ZONE)
		local startDateStr = startDate:fmt("%Y.%m.%d")
		local endDate = Utils:getUTCDate(self.activityInfo.endTime , GV_UTC_TIME_ZONE)
		local endDateStr = endDate:fmt("%Y.%m.%d")
		self.Label_time_begin:setText(startDateStr)
		self.Label_time_end:setText(endDateStr..GV_UTC_TIME_STRING)

		--针对反十活动修改字体颜色
		-- self.Label_time_begin:setFontColor(ccc3(235 , 149 , 245))
		-- self.Label_time_end:setFontColor(ccc3(235 , 149 , 245))
		-- self.Label_time_tip:setFontColor(ccc3(235 , 149 , 245))
		-- self.Label_time_begin:enableOutline(ccc3(148,14 ,166) , 1)
		-- self.Label_time_end:enableOutline(ccc3(148,14 ,166) , 1)
		-- self.Label_time_tip:enableOutline(ccc3(148,14 ,166) , 1)
	end

	self.signItems_ = {}
	self.items_ = ActivityDataMgr2:getItems(self.activityId)	--所有的子项
	self.Panel_page:setVisible(self.isScrollType ~= 1)
	self.GridView_award:s():setVisible(self.isScrollType == 1)
	if self.isScrollType == 1 then
		self:initGridData()
	else
		self:initPageTypeData()
	end
	self:refreshView()
end

function WelfareSignView:initPageTypeData()

	self.maxPage = math.ceil(#self.items_ / self.countPage_)    --最大页数
	self.selectPage_ = self.maxPage

	local _start = 0
	for i = 1, #self.items_ do
		local _index = _start + i
		local _itemId = self.items_[_index]
		local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _itemId)
		local _progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, _itemId)
		if _progressInfo.status ~= EC_TaskStatus.GETED then
			self.selectPage_ = math.ceil(i / self.countPage_)
			break
		end
	end

	for i = 1, self.countPage_ do
		local foo = self:getSignItem()
		foo.root:setPosition(self.pos[i])
		self.Panel_page:addChild(foo.root)
		self.signItems_[i] = foo
	end

	--设置背景图
	if self.activityInfo.extendData.activityShowType and (self.activityInfo.extendData.activityShowType == 6 or self.activityInfo.extendData.activityShowType == 91) or self.activityInfo.extendData.uiName == "whiteQueenAssistSignView" then
	elseif self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
	else
		self.Image_bg:setTexture("ui/activity/activityStyle/wefareSignActivity/"..self.curResFileName.."/bg"..self.selectPage_.. ".png")
	end
end

function WelfareSignView:initGridData()

	self.GridView_award:removeAllItems()
	for k,v in ipairs(self.items_) do
		local foo = self:getSignItem()
		self.GridView_award:pushBackCustomItem(foo.root)
		self.signItems_[k] = foo
	end

end

function WelfareSignView:getSignItem()

	local Panel_sevenItem = self.Panel_sevenItem:clone()
	local foo = {}
	foo.root = Panel_sevenItem
	local Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
	foo.ItemIcon = TFDirector:getChildByPath(foo.root, "image_icon")
	foo.label_num = TFDirector:getChildByPath(foo.root, "label_num")
	foo.Image_border = TFDirector:getChildByPath(foo.root, "Image_border")
	foo.Label_day = TFDirector:getChildByPath(foo.root, "Label_day")
	foo.Spine_welfareSignView_1 = TFDirector:getChildByPath(foo.root, "Spine_welfareSignView_1")
	foo.Spine_welfareSignView_2 = TFDirector:getChildByPath(foo.root, "Spine_welfareSignView_2")

	if foo.Spine_welfareSignView_1 then

		if self.isScrollType == 1 then
			foo.Spine_welfareSignView_1:playByIndex(0,-1)
		else
			local index = self.SevenItemType == 1 and 0 or 1
			foo.Spine_welfareSignView_1:playByIndex(index,-1)
		end

	end
	if foo.Spine_welfareSignView_2 then
		foo.Spine_welfareSignView_2:playByIndex(0,-1)
	end

	foo.Image_getted= TFDirector:getChildByPath(foo.root, "Image_getted")
	foo.Image_iconbg= TFDirector:getChildByPath(foo.root, "Image_bg")
	foo.label_getted = TFDirector:getChildByPath(foo.root, "label_getted")
	foo.Image_getted1= TFDirector:getChildByPath(foo.root, "Image_getted1")

	foo.Image_border= TFDirector:getChildByPath(foo.root, "Image_border")

	return foo
end

function WelfareSignView:updateGridData()

	for k,v in ipairs(self.items_) do
		local _itemId = self.items_[k]
		if _itemId then
			self.signItems_[k].root:show()
			self:updateItem(self.signItems_[k],k)
		end
	end
end

function WelfareSignView:updateByPage()

	self.btn_Last_:setVisible(self.selectPage_ > 1)
	self.btn_Next_:setVisible(self.selectPage_ < self.maxPage)

	local _start = (self.selectPage_ - 1) * self.countPage_

	for i = 1, self.countPage_ do
		local _index = _start + i
		local foo = self.signItems_[i]
		if _index > #self.items_ then
			foo.root:hide()
		else
			self:updateItem(foo,_index)
		end
	end
end

function WelfareSignView:updateItem(foo,_index)

	foo.root:show()
	local _itemId = self.items_[_index]
	local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _itemId)
	local _progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, _itemId)

	local id, num = next(_itemInfo.reward)
	local itemCfg = GoodsDataMgr:getItemCfg(id)
	if not itemCfg then
		return
	end


	foo.Label_day:setTextById(tonumber(_itemInfo.details))
	if foo.Image_iconbg then
		foo.Image_iconbg:setTexture("ui/fairy_particle/" .. itemCfg.quality .. ".png")
		foo.Image_iconbg:setScale(0.65)
		foo.Image_iconbg:show()
	end

	foo.ItemIcon:setTexture(itemCfg.icon)
	foo.label_num:setText("X" ..num)

	--设置领取状态背景
	if self.isScrollType ~= 1 then
		if self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 6 then
			local pic_path = "ui/activity/assist/kuangsan/sign_00".._index..".png"
			foo.Image_border:setTexture(pic_path)
		else
			if _progressInfo.status ~= EC_TaskStatus.ING  then
				foo.Image_border:setTexture("ui/activity/activityStyle/wefareSignActivity/"..self.curResFileName.."/004_n.png")
			elseif self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
				local pic_path = "ui/activity/fanshiAssist/signView/sign_00".._index..".png"
				foo.Image_border:setTexture(pic_path)
			elseif self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 91 then
			else
				foo.Image_border:setTexture("ui/activity/activityStyle/wefareSignActivity/"..self.curResFileName.."/003_n.png")
			end
		end
	else
		local framImg = self:getFramBg(itemCfg)
		foo.Image_border:setTexture(framImg)
		--if not foo.Panel_goodsItem then
		--	foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
		--	foo.Panel_goodsItem:Pos(0, 0):AddTo(foo.ItemIcon)
		--end
		--PrefabDataMgr:setInfo(foo.Panel_goodsItem, id)
	end

	if foo.Image_getted then
		foo.Image_getted:setVisible(_progressInfo.status == EC_TaskStatus.GETED)
	end
	if foo.Image_getted1 then
		foo.Image_getted1:setVisible(_progressInfo.status == EC_TaskStatus.GET)
	end
	foo.root:setTouchEnabled(_progressInfo.status ~= EC_TaskStatus.GETED)
	if foo.Spine_welfareSignView_1 then
		foo.Spine_welfareSignView_1:setVisible(_progressInfo.status == EC_TaskStatus.GET)
	end

	if foo.Spine_welfareSignView_2 then
		foo.Spine_welfareSignView_2:setVisible(_progressInfo.status == EC_TaskStatus.GET)
	end

	foo.label_getted:setVisible(_progressInfo.status == EC_TaskStatus.GETED)
	foo.root:onClick(function ( ... )
		if _progressInfo.status == EC_TaskStatus.GET then
			ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, _itemId)
		else
			Utils:showInfo(id)
		end
	end)
end

function WelfareSignView:getFramBg(itemCfg)

	local frameImg = EC_ItemIcon[itemCfg.quality]
	if itemCfg.superType == EC_ResourceType.KABALA and
			(itemCfg.subType == Enum_KabalaItemType.ItemType_BuffItem or itemCfg.subType == Enum_KabalaItemType.ItemType_Buff)then
		if not frameImg then
			frameImg = Enum_KabalaItemFrame[Enum_KabalaItemQuality.blue]
		end
	end
	return frameImg
end

function WelfareSignView:refreshView()

	if self.isScrollType == 1 then
		self:updateGridData()
	else
		self:updateByPage()
	end
end

function WelfareSignView:onSubmitSuccessEvent(activitId, itemId, reward)
	if self.activityId ~= activitId then return end
	Utils:showReward(reward)
	local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType,itemId)
	if itemInfo and itemInfo.extendData.datingRuleId then
		FunctionDataMgr:jStartDating(itemInfo.extendData.datingRuleId)
	end
end


function WelfareSignView:onUpdateProgressEvent()
	self:refreshView()
end

function WelfareSignView:onUpdateActivityEvent()
	self:refreshView()
end

function WelfareSignView:registerEvents()

	self.btn_Last_:onClick(function ( ... )
		self.selectPage_ = self.selectPage_ - 1
		self:updateByPage()
	end)

	self.btn_Next_:onClick(function ( ... )
		self.selectPage_ = self.selectPage_ + 1
		self:updateByPage()
	end)

end

return WelfareSignView