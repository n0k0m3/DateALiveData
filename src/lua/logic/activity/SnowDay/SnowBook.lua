--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local SnowBook = class("SnowBook", BaseLayer)
local ColorSelect = ccc3(241, 221, 130)

function SnowBook:ctor(...)
	self.super.ctor(self)
	self:showPopAnim(true)
	self:initData(...)
		
	self:init("lua.uiconfig.activity.snowBook")
	self:runAction(Sequence:create({DelayTime:create(0.3), CallFunc:create( function() Utils:playSound(8123,false) end)}))
end

function SnowBook:initData(activityId)
	self.activityId = activityId
	self.activityData = ActivityDataMgr2:getActivityInfo(activityId)

	self.data = {
					[1]={name=13202401, des=153017, lv="snowFesFightLv"},
					[2]={name=13202402, des=153018, lv="snowFesMemoryLv"},
					[3]={name=13202404, des=153019, lv="snowFesTaskLv"},				 
					[4]={name=13202403, des=153020, lv="snowFesAchiveLv"},
					[5]={name=13202405, des=153021, lv="snowFesStoreLv"},	
				}
	self.cfg = TabDataMgr:getData("EventMemshipOption")

	self.tabArray = {}

	self.snowBookData = ActivityDataMgr2:getSnowBookData()
	self.cfgOption = TabDataMgr:getData("EventMembership", self.snowBookData.pamphletLevel or 1) or {}

	self.snowBuffInfo = ActivityDataMgr2:getSnowBuffInfo() or {}
	self.curTab = nil
	self.touchTab = false
end

function SnowBook:initUI(ui)
	self.super.initUI(self, ui)
	TFDirector:getChildByPath(ui,"Button_close"):onClick(function() AlertManager:closeLayer(self) end)
	TFDirector:getChildByPath(ui,"Image_content"):setTouchEnabled(true)
	TFDirector:getChildByPath(ui,"Image_content"):setSwallowTouch(true)
	self.ScrollExplain = UIListView:create(TFDirector:getChildByPath(ui, "ScrollExplain"))
	self.ScrollExplain.scrollView_:addMEListener(TFSCROLLVIEW_SCROLLING, handler(self.onScrollingEvent, self))
	self.ScrollExplain.scrollView_:addMEListener(TFWIDGET_COMPLETED, handler(self.onCompletedEvent, self))
	self.ScrollTab = UIListView:create(TFDirector:getChildByPath(ui, "ScrollTab"))

	self.Label_welcome = TFDirector:getChildByPath(ui, "Label_welcome")
	self.Label_welcome:setTextById(13202308)

	self.PrefabTab = TFDirector:getChildByPath(ui, "Prefab")

	self.PrefabContent = TFDirector:getChildByPath(ui, "PrefabContent")

	local LevelBg = TFDirector:getChildByPath(ui,"LevelBg")
	LevelBg:setTouchEnabled(false)
	LevelBg:onClick(function()
		--self.ScrollExplain:scrollToItem(1)		
	end)

	local Label_lv = TFDirector:getChildByPath(LevelBg,"Label_lv")
	Label_lv:setTextById(13202020, self.snowBookData.pamphletLevel or 0)

	local cfgLastOption = TabDataMgr:getData("EventMembership", (self.snowBookData.pamphletLevel - 1) or 0) or {}
	cfgLastOption.costToNext = cfgLastOption.costToNext or 0

	local nextExp = 0
	if self.snowBookData.pamphletLevel ==  1 then
		nextExp = self.cfgOption.costToNext
	elseif self.snowBookData.pamphletLevel == self.activityData.extendData.maxLevel then
		nextExp = 0
	else
		nextExp = (self.cfgOption.costToNext or 0) - (cfgLastOption.costToNext or 0)
	end

	local Label_nextLv = TFDirector:getChildByPath(LevelBg,"Label_nextLv")
	Label_nextLv:setText(math.max(nextExp, 0))

	self:initView()
end

function SnowBook:initView()
	self:addContent({des=153016})
	for i=1, #self.data do
		self:addTab(self.data[i], i)
	end
end

function SnowBook:selectBtn(index)
	if self.curTab then
		self.curTab.Label:setColor(ccWHITE)
		self.curTab.Label_lv:setColor(ccWHITE)
	end

	local tab = self.tabArray[index]
	tab.Label:setColor(ColorSelect)
	tab.Label_lv:setColor(ColorSelect)

	self.touchTab = true

	self.ScrollExplain:scrollToItem(index + 1)	
	
	self.curTab = tab
end

function SnowBook:addTab(data, index)

	local tab = self.PrefabTab:clone()
	tab.Label = tab:getChildByName("Label")
	tab.Label:setTextById(data.name)
	tab:onClick(function()
		self:selectBtn(index)			
	end)
	self.ScrollTab:pushBackCustomItem(tab)

	if index == #self.data then
		tab:getChildByName("Image"):hide()
	end

	tab.Label_lv = tab:getChildByName("Label_lv"):setTextById(13202020, self.snowBuffInfo[data.lv] or 1)


	table.insert(self.tabArray, tab)

	self:addContent(data, index)
end

function SnowBook:addContent(data, index)
	local content = self.PrefabContent:clone()
	local rich = content:setTextById("r"..data.des)		
	rich:setContentSize(ccs(content:getContentSize().width + 20, rich:getContentSize().height))
	rich.index = index
	self.ScrollExplain:pushBackCustomItem(rich)
end

function SnowBook:onScrollingEvent()
	if self.touchTab then
		return
	end
	local size = self.ScrollExplain:getContentSize()
	local innerContainer = self.ScrollExplain.scrollView_:getInnerContainer()
	local innerContainerPosY = innerContainer:getPositionY()
	local items = self.ScrollExplain:getItems()
	for k,val in ipairs(items) do
		local h = innerContainerPosY + val:getPositionY()
		if h > size.height * 0.25 and h < size.height *0.75 then
			print(k)
			for i,j in ipairs(self.tabArray) do
				if i == k-1 then
					j.Label:setColor(ColorSelect)
					j.Label_lv:setColor(ColorSelect)
					self.ScrollTab:scrollToItem(i)
					self.curTab = j
				else
					j.Label:setColor(ccWHITE)
					j.Label_lv:setColor(ccWHITE)
				end
			end
			break
		end
	end
end

function SnowBook:onCompletedEvent()
	self.touchTab = false
end

return SnowBook

--endregion
