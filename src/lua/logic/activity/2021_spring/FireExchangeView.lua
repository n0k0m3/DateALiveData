--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local FireExchangeView = class("FireExchangeView", BaseLayer)
function FireExchangeView:ctor(...)
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.activity.fireExchangeView")
end


function FireExchangeView:initData()
	self.bagOrigin = {[500096] = 5,[510206] = 5,[510209] = 5,[510208] = 5,[510207] = 5,[555014] = 5,[555013] = 5,[555012] = 5,[555011] = 5,[555010] = 5,[555009] = 5,[555008] = 5,[555007] = 5,[555006] = 5,[555005] = 5,[555004] = 5, [555003] = 5, [555002] = 5}

	self.bag = {}
	for k, v in pairs(self.bagOrigin) do
		table.insert(self.bag,  {itemId = k, num=v})
	end

	self.itemExchangeSelf = {}
	self.itemExchangeOther = {}
	self.bagItems = {}
end


function FireExchangeView:initUI(ui)
	self.super.initUI(self, ui)

	self.Panel_root							= TFDirector:getChildByPath(ui,"Panel_root");	
	self.Panel_left							= TFDirector:getChildByPath(ui,"Panel_left");
	self.Panel_left.ScrollView				= TFDirector:getChildByPath(self.Panel_left, "ScrollView");
	self.Panel_left.ScrollView.hCounts		= 3

	self.Panel_right						= TFDirector:getChildByPath(ui,"Panel_right");
	self.Panel_self							= TFDirector:getChildByPath(self.Panel_right, "Panel_self");
	self.Panel_self.ScrollView				= TFDirector:getChildByPath(self.Panel_self,  "ScrollView");
	self.Panel_self.ScrollView.hCounts		= 4
	self.Panel_self.Label_num_self			= TFDirector:getChildByPath(self.Panel_self,  "Label_num_self");
	self.Panel_self.Button_comfirm_self		= TFDirector:getChildByPath(self.Panel_self,  "Button_comfirm_self");

	self.Panel_other						= TFDirector:getChildByPath(self.Panel_right, "Panel_other");
	self.Panel_other.ScrollView				= TFDirector:getChildByPath(self.Panel_other, "ScrollView");
	self.Panel_other.ScrollView.hCounts		= 4
	self.Panel_other.Label_num_other		= TFDirector:getChildByPath(self.Panel_other, "Label_num_other");
	self.Panel_other.Button_comfirm_other	= TFDirector:getChildByPath(self.Panel_other, "Button_comfirm_other");

	self.Button_close						= TFDirector:getChildByPath(self.ui, "Button_close");

	self.Panel_prefab						= TFDirector:getChildByPath(self.ui, "Panel_prefab");

	self:refreshView()
end

function FireExchangeView:registerEvents()
	self.super.registerEvents(self)

	self.Button_close:onClick(function() AlertManager:closeLayer(self) end)
	self.Panel_self.Button_comfirm_self:onClick(function() 
		--todo
	end)

	self.Panel_other.Button_comfirm_other:onClick(function() 
		--todo
	end)
end

function FireExchangeView:refreshView()
	self:initBag()
	self.Panel_left.ScrollView:scrollToTop()
end

function FireExchangeView:resetInnerContainerSize(scrollview, maxRows)
	local container = scrollview:getInnerContainer()
	local originSize = container:getSize()
	local prefabSize = self.Panel_prefab:getSize()
	scrollview:setInnerContainerSize(ccs(originSize.width, prefabSize.height * maxRows))
end

function FireExchangeView:initBag()
	self.bagItems = {}
	local scrollView = self.Panel_left.ScrollView
	local row = math.ceil( #self.bag / scrollView.hCounts)
	self:resetInnerContainerSize(scrollView, row)	
	for i=1, row do
		for j=1,scrollView.hCounts do
			local index = (i - 1) * scrollView.hCounts + j
			local data = self.bag[index]
			if data then
				local item = self.Panel_prefab:clone()
				local labelNum = TFDirector:getChildByPath(item, "labelNum");
				labelNum:setText(data.num)
				local touch = TFPanel:create()
				touch:setAnchorPoint(ccp(0.5,0.5))
				touch:setPosition(ccp(0,0))
				touch:setContentSize(item:getSize())
				touch:setTouchEnabled(true)
				touch:setSwallowTouch(true)
				touch:addMEListener(TFWIDGET_CLICK,function()					
					if data.num > 0 then
						self:addToList("SELF", data)
						self:deleteFromList("BAG", data)
					end
				end)
				item:addChild(touch)
				scrollView:getInnerContainer():addChild(item)
				local pos = self:getItemPos(index, scrollView)
				item:setPosition(pos)

				table.insert(self.bagItems, {item=item, itemId=data.itemId, num=data.num, texture="", labelNum=labelNum})
			end
		end
	end
end

function FireExchangeView:getItemPos(index, scrollView)
	local container = scrollView:getInnerContainer()
	local prefabSize = self.Panel_prefab:getSize()
	local row = math.ceil( index / scrollView.hCounts)
	local col = (index - 1) % scrollView.hCounts
	return ccp(prefabSize.width * (col) + 40, container:getSize().height - prefabSize.height * (row - 0.5))
end

function FireExchangeView:updateSelf()
	
end

function FireExchangeView:updateOther()
	
end

function FireExchangeView:changeSelfList()
	
end

function FireExchangeView:changeOtherList()
	
end

function FireExchangeView:addToList(type, data)
	local list,scrollView = self:getWidgetByType(type)
	
	local index = -1
	for k,v in ipairs(list) do
		if data.itemId == v.itemId then
			index = k
			break;
		end
	end

	if index ~= -1 then
		list[index].num = list[index].num  + 1
		list[index].labelNum:setText(list[index].num)
	else
		index = #list + 1
		local row = math.ceil( index / scrollView.hCounts)

		self:resetInnerContainerSize(scrollView, row)	

		local item = self.Panel_prefab:clone()
		local labelNum = TFDirector:getChildByPath(item, "labelNum");
		labelNum:setText(1)
		local touch = TFPanel:create()
		touch:setAnchorPoint(ccp(0.5,0.5))
		touch:setPosition(ccp(0,0))
		touch:setContentSize(item:getSize())
		touch:setTouchEnabled(true)
		touch:setSwallowTouch(true)
		touch:addMEListener(TFWIDGET_CLICK,function()
			self:onClickItem(type, data)
		end)
		item:addChild(touch)
		scrollView:getInnerContainer():addChild(item)

		for i=1,#list do
			local pos = self:getItemPos(i, scrollView)
			list[i].item:setPosition(pos)
		end
		local pos = self:getItemPos(index, scrollView)
		item:setPosition(pos)
		scrollView:scrollToBottom()
		table.insert(list, index, {item=item, itemId=data.itemId, num=1, texture="", labelNum=labelNum})
	end
end

function FireExchangeView:onClickItem(type, data)
	if type == "SELF" then
		self:deleteFromList("SELF", data)
		self:addToList("BAG", data) 
	elseif type == "BAG" then
		self:deleteFromList("BAG", data)
		self:addToList("SELF", data) 
	else
		self:deleteFromList("OTHER", data)
		self:addToList("OTHER", data) 
	end
end

function FireExchangeView:getWidgetByType(type)
	local list,scrollView
	if type == "SELF" then
		list = self.itemExchangeSelf
		scrollView = self.Panel_self.ScrollView
	elseif type == "BAG" then
		list = self.bagItems
		scrollView = self.Panel_left.ScrollView
	elseif type == "OTHER" then
		list = self.itemExchangeOther
		scrollView = self.Panel_other.ScrollView	
	end
	return list, scrollView
end

function FireExchangeView:deleteFromList(type, data)
	local list,scrollView = self:getWidgetByType(type)

	local index = -1
	for k,v in ipairs(list) do
		if data.itemId == v.itemId then
			index = k
			break;
		end
	end
	if index ~= -1 then
		list[index].num = list[index].num - 1
		list[index].labelNum:setText(list[index].num)
		if list[index].num <= 0 then
			list[index].item:removeFromParent(true)
			table.remove(list, index)
			
			local row = math.ceil( #list / scrollView.hCounts)
			self:resetInnerContainerSize(scrollView, row)
			for i=1,#list do
				local pos = self:getItemPos(i, scrollView)
				list[i].item:setPosition(pos)
			end
		end	
	end
end



return FireExchangeView

--endregion
