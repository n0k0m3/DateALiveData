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
	self.activityId = data
    self.activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)
    local uiName = self.activityInfo.extendData.uiName or "welfareSignView"
    if self.activityInfo.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
        uiName = "fanshiAssistSignView"
    end
    self:init("lua.uiconfig.activity."..uiName)
end

function WelfareSignView:initUI(ui)
	self.super.initUI(self,ui)
	self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")
    self.label_time = TFDirector:getChildByPath(ui, "label_time")
    --self.label_date = TFDirector:getChildByPath(ui, "label_date")
    self.Image_bg = TFDirector:getChildByPath(ui, "Image_bg")

	self.btn_Last_ = TFDirector:getChildByPath(ui, "Button_last")
	self.btn_Next_ = TFDirector:getChildByPath(ui, "Button_next")
	
	
	self.Panel_welfareSignView_1 = TFDirector:getChildByPath(ui, "Panel_welfareSignView_1")
	
	
    --self.label_date:setSkewX(10)

    self.label_time:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime, self.activityInfo.extendData.dateStyle))


    --if self.activityInfo.extendData.bgPath then 
    --    self.Image_bg:setTexture(self.activityInfo.extendData.bgPath)
    --end
    self.Panel_sevenItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_sevenItem")
    self.Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    --local ScrollView_reward = TFDirector:getChildByPath(self.Image_bg, "ScrollView_reward")
    --self.ListView_reward = UIListView:create(ScrollView_reward)
    --self.ListView_reward:setItemsMargin(5)
	  									--当前选择的页数
	self.items_ = ActivityDataMgr2:getItems(self.activityId)	--所有的子项
	self.countPage_ = 7											--一页的数量
	print("-----------------------------------------" .. #self.items_)
	self.maxPage = math.ceil(#self.items_ / self.countPage_)    --最大页数

	self.selectPage_ = self.maxPage  

	self.signItems_ = {}  					--对应的七个子项
	
	self.pos = {}
	for i = 1, self.countPage_ do
		self.pos[i] = TFDirector:getChildByPath(ui, "Image_node" .. i)
	end
		
	self:addSignItem()

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
	
    self:refreshView()
	self.btn_Last_:onClick(function ( ... )
		self.selectPage_ = self.selectPage_ - 1
		self:updateByPage()
	end)
	
	self.btn_Next_:onClick(function ( ... )
		self.selectPage_ = self.selectPage_ + 1
		self:updateByPage()
	end)
end

--[[根据所选页数刷新页面]]
function WelfareSignView:updateByPage()
	--设置背景图
	if self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 6 then
	elseif self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
	else
		self.Image_bg:setTexture("ui/activity/activityStyle/wefareSignActivity/styleCur/bg"..self.selectPage_.. ".png")
	end

	
	
	--设置上一页下一页的按钮显示
	self.btn_Last_:setVisible(self.selectPage_ > 1)
	self.btn_Next_:setVisible(self.selectPage_ < self.maxPage)
	
	--设置列表内容
	--self.ListView_reward:removeAllItems()
    
	local _start = (self.selectPage_ - 1) * self.countPage_
	
	for i = 1, self.countPage_ do
		local _index = _start + i
		local _foo = self.signItems_[i]
		if _index > #self.items_ then
			_foo.root:hide()
		else
			_foo.root:show()
			
			--设置相关的数据
			local _itemId = self.items_[_index]
			local _itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo.activityType, _itemId)
			--dump(_itemInfo)
			local _progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo.activityType, _itemId)
       
			local id, num = next(_itemInfo.reward)
			local itemCfg = GoodsDataMgr:getItemCfg(id)
			print("itemCfg.icon=" .. itemCfg.icon)
			_foo.ItemIcon:setTexture(itemCfg.icon)
			_foo.label_num:setText("X" ..num)
			--_foo.label_num:hide()
			_foo.Label_day:setTextById(tonumber(_itemInfo.details))
			--dump(itemCfg)
			if _foo.Image_iconbg then
				_foo.Image_iconbg:setTexture("ui/fairy_particle/" .. itemCfg.quality .. ".png")
				_foo.Image_iconbg:setScale(0.65)
				_foo.Image_iconbg:show()
			end
			
			--设置领取状态背景
			if self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == 6 then
				local pic_path = "ui/activity/assist/kuangsan/sign_00".._index..".png"
				_foo.Image_border:setTexture(pic_path)
			elseif self.activityInfo.extendData.activityShowType and self.activityInfo.extendData.activityShowType == EC_ActivityType2.FANSHI_ASSIST then
				local pic_path = "ui/activity/fanshiAssist/signView/sign_00".._index..".png"
				_foo.Image_border:setTexture(pic_path)
			else
				if _progressInfo.status ~= EC_TaskStatus.ING  then
					_foo.Image_border:setTexture("ui/activity/welfareSign/004_n.png")
				else
					_foo.Image_border:setTexture("ui/activity/welfareSign/003_n.png")
				end	
			end
			--Image_border
			
			--_foo.Image_get:setVisible(_progressInfo.status == EC_TaskStatus.GET)
			--_foo.Label_day:setVisible(_progressInfo.status ~= EC_TaskStatus.GETED)
			if _foo.Image_getted then
				_foo.Image_getted:setVisible(_progressInfo.status == EC_TaskStatus.GETED)
			end
			if _foo.Image_getted1 then
				_foo.Image_getted1:setVisible(_progressInfo.status == EC_TaskStatus.GET)
			end
			_foo.root:setTouchEnabled(_progressInfo.status ~= EC_TaskStatus.GETED)
			if _foo.Spine_welfareSignView_1 then
				_foo.Spine_welfareSignView_1:setVisible(_progressInfo.status == EC_TaskStatus.GET)
			end
			if _foo.Spine_welfareSignView_2 then
				_foo.Spine_welfareSignView_2:setVisible(_progressInfo.status == EC_TaskStatus.GET)
			end
			
			_foo.label_getted:setVisible(_progressInfo.status == EC_TaskStatus.GETED)
			_foo.root:onClick(function ( ... )
				if _progressInfo.status == EC_TaskStatus.GET then
					ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, _itemId)
				else
					Utils:showInfo(id)
				end
			end)
			
		end
	end
	
	--local _end = self.selectPage_ * self.countPage_
	--_end = _end > #self.items_ and #self.items_ or _end
	
    --self:updateAllSignItem()
	
	
end

function WelfareSignView:refreshView()
	
	self:updateByPage()
end

function WelfareSignView:onUpdateProgressEvent()
     self:refreshView()
end

function WelfareSignView:onUpdateActivityEvent()
    self:refreshView()
end

function WelfareSignView:onSubmitSuccessEvent(activitId, itemId, reward)
    if self.activityId ~= activitId then return end
    Utils:showReward(reward)
end

function WelfareSignView:addSignItem()
	self.signItems_ = {}
	
	for i = 1, self.countPage_ do
		
		local Panel_sevenItem = self.Panel_sevenItem:clone():Pos(self.pos[i]:Pos())--TFDirector:getChildByPath(self.Image_bg, "Panel_sevenItem" .. i)
		local foo = {}
		foo.root = Panel_sevenItem
		foo._root = self.pos[i]
		local Panel_reward = TFDirector:getChildByPath(foo.root, "Panel_reward")
		foo.ItemIcon = TFDirector:getChildByPath(Panel_reward, "image_icon")
		foo.label_num = TFDirector:getChildByPath(Panel_reward, "label_num")
		foo.Image_border = TFDirector:getChildByPath(foo.root, "Image_border")
		foo.Label_day = TFDirector:getChildByPath(foo.root, "Label_day")
		foo.Spine_welfareSignView_1 = TFDirector:getChildByPath(foo.root, "Spine_welfareSignView_1")
		foo.Spine_welfareSignView_2 = TFDirector:getChildByPath(foo.root, "Spine_welfareSignView_2")
		
		--local label = foo.Label_day:clone():Pos(0,0)
		--foo.Spine_welfareSignView_1:addChild(label)
		if foo.Spine_welfareSignView_1 then
			foo.Spine_welfareSignView_1:playByIndex(1,-1)
		end
		if foo.Spine_welfareSignView_2 then
			foo.Spine_welfareSignView_2:playByIndex(0,-1)
		end
		--local skillEff = SkeletonAnimation:create("effect/newLoading/effects_loading2")
		--skillEff:setPosition(ccp(GameConfig.WS.width/2, GameConfig.WS.height/2))
		--skillEff:setAnimationFps(GameConfig.ANIM_FPS)
		--skillEff:playByIndex(0, -1, -1, 1)
		--foo.Image_get = TFDirector:getChildByPath(foo.root, "Image_get")
		--foo.effect = TFDirector:getChildByPath(foo.Image_get, "effect")
		--if foo.effect then
		--    foo.effect:playByIndex(0,-1,-1,1)
		--end
		foo.Image_getted= TFDirector:getChildByPath(foo.root, "Image_getted")
		foo.Image_iconbg= TFDirector:getChildByPath(foo.root, "Image_bg")
		foo.label_getted = TFDirector:getChildByPath(foo.root, "label_getted")
		foo.Image_getted1= TFDirector:getChildByPath(foo.root, "Image_getted1")

		foo.Image_border= TFDirector:getChildByPath(foo.root, "Image_border")
		--self.ListView_reward:pushBackCustomItem(foo.root)
		self.Panel_welfareSignView_1:addChild(Panel_sevenItem)
		self.signItems_[i] = foo
	end	
end


return WelfareSignView