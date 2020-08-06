--情报站
local InfoStationLayer = class("InfoStationLayer", BaseLayer)

local TRUN_TYPE = {
	UP = 0,
	DOWN = 1,
}

function InfoStationLayer:ctor(data)
    self.super.ctor(self,data)
    self:init("lua.uiconfig.infoStation.infoStationLayer")
end

function InfoStationLayer:initUI(ui)
	self.super.initUI(self,ui)

	self.stationUpImage = TFDirector:getChildByPath(ui,"img_up")
	self.stationUpImage:setVisible(false)

	self.stationDownImage = TFDirector:getChildByPath(ui,"img_down")
	self.stationDownImage:setVisible(false)

	self.stationLineImg = TFDirector:getChildByPath(ui,"img_line")

	self.infoScrollView = TFDirector:getChildByPath(ui,"scrollView_station")
	
	self.backBtn = TFDirector:getChildByPath(ui,"btn_back")

	self.stationNodeList = {}
end

function InfoStationLayer:onShow()
	self.super.onShow(self)

	if self.firstShow == nil then
		self:initData()
		self:initScrollView()
		self:drawScrollViewLine()
	end
	self.firstShow = false
end

function InfoStationLayer:registerEvents()
	self.backBtn:onClick(function()
    	AlertManager:closeLayer(self)
	end)
end

function InfoStationLayer:removeEvents()
    self.super.removeEvents(self)
end

function InfoStationLayer:onHide()
	self.super.onHide(self)
end

function InfoStationLayer:removeUI()
	self.super.removeUI(self)
	self.firstShow = nil
end

function InfoStationLayer:updateStationToDown( cell, index )
	local infoStationList = self:getStationData()
	local infoStation = infoStationList[index]
	if infoStation == nil then return end

	cell:setTexture(infoStation.linePic)
	cell:setVisible(true)

	local iconBtn = TFDirector:getChildByPath(cell,"btn_icon")
	iconBtn:setTextureNormal(infoStation.namePic)
	iconBtn:onClick(function( )
		if infoStation.title <= 0 then 
			Utils:showTips(264999)
			return 
		end
		Utils:showWebView(infoStation.web)
	end)

	local infoLabel = TFDirector:getChildByPath(cell,"label_info")
	infoLabel:setString(TextDataMgr:getText(infoStation.title))
	infoLabel:setVisible(infoStation.title > 0)

	local textBgImg = TFDirector:getChildByPath(cell,"img_text_bg")
	local infoLabelSize = infoLabel:getContentSize()
	textBgImg:setContentSize(CCSizeMake(infoLabelSize.width + 70, textBgImg:getContentSize().height))
	textBgImg:setVisible(infoStation.title > 0)

	local dateLabel = TFDirector:getChildByPath(cell,"label_date")
	dateLabel:setString(TextDataMgr:getText(infoStation.time))

	local tipLabel = TFDirector:getChildByPath(cell,"label_tip")
	tipLabel:setVisible(infoStation.title <= 0)
end

function InfoStationLayer:updateStationToUp( cell, index )
	local infoStationList = self:getStationData()
	local infoStation = infoStationList[index]
	if infoStation == nil then return end

	cell:setTexture(infoStation.linePic)
	cell:setVisible(true)

	local iconBtn = TFDirector:getChildByPath(cell,"btn_icon")
	iconBtn:setTextureNormal(infoStation.namePic)
	iconBtn:onClick(function( )
		if infoStation.title <= 0 then 
			Utils:showTips(264999)
			return 
		end
		Utils:showWebView(infoStation.web)
	end)

	local infoLabel = TFDirector:getChildByPath(cell,"label_info")
	infoLabel:setString(TextDataMgr:getText(infoStation.title))
	infoLabel:setVisible(infoStation.title > 0)

	local textBgImg = TFDirector:getChildByPath(cell,"img_text_bg")
	local infoLabelSize = infoLabel:getContentSize()
	textBgImg:setContentSize(CCSizeMake(infoLabelSize.width + 70, textBgImg:getContentSize().height))
	textBgImg:setVisible(infoStation.title > 0)

	local dateLabel = TFDirector:getChildByPath(cell,"label_date")
	dateLabel:setString(TextDataMgr:getText(infoStation.time))

	local tipLabel = TFDirector:getChildByPath(cell,"label_tip")
	tipLabel:setVisible(infoStation.title <= 0)
end

function InfoStationLayer:updateStationUI( cell, index )
	local infoStationList = self:getStationData()
	local infoStation = infoStationList[index]
	if infoStation == nil then return end

	local positionOrder = infoStation.positionOrder[2]
	if positionOrder == TRUN_TYPE.UP then
		self:updateStationToUp(cell, index)
	end

	if positionOrder == TRUN_TYPE.DOWN then
		self:updateStationToDown(cell, index) 
	end
end

function InfoStationLayer:initScrollView( )
	local infoScrollViewSize = 0
	local infoStationList = self:getStationData()
	if #infoStationList <= 0 then return end
	infoScrollViewSize = math.max(GameConfig.WS.width, infoStationList[#infoStationList].positionOrder[1] + self.stationDownImage:getContentSize().width)
	self.infoScrollView:setInnerContainerSize(CCSizeMake(infoScrollViewSize, self.infoScrollView:getContentSize().height))
	self.infoScrollView:setContentSize(CCSizeMake(GameConfig.WS.width, self.infoScrollView:getContentSize().height))

	for _index,_info in ipairs(infoStationList) do
		local infoCell = self:crateStation(_index)
		infoCell:setZOrder(20 - _index)
		infoCell:setPosition(ccp(infoStationList[_index].positionOrder[1], self.infoScrollView:getContentSize().height/2))
		self.infoScrollView:addChild(infoCell)
		self:updateStationUI(infoCell, _index)
		table.insert(self.stationNodeList, infoCell)
	end
end

function InfoStationLayer:initData()
	self.stationList = {}

	local intelligenceCfg = TabDataMgr:getData("Intelligence")
	for _,_info in pairs(intelligenceCfg) do
		table.insert(self.stationList, _info)
	end

	--按id降序排序
	table.sort(self.stationList, function( a, b )
		if a.id < b.id then
			return true
		else
			return false
		end
	end)
end

function InfoStationLayer:getStationData( )
	if self.stationList == nil then
		self.stationList = {}
	end
	return self.stationList
end

function InfoStationLayer:crateStation( index )
	local infoStationList = self:getStationData()
	if #infoStationList <= 0 then return end
	if infoStationList[index] == nil then return nil end

	local positionOrder = infoStationList[index].positionOrder[2]
	if positionOrder == TRUN_TYPE.UP then
		return self:crateStationUp()
	end

	if positionOrder == TRUN_TYPE.DOWN then
		return self:crateStationDown()
	end
end

function InfoStationLayer:crateStationUp( )
	local infoCell = self.stationUpImage:clone()
	infoCell:setVisible(true)
	return infoCell
end

function InfoStationLayer:crateStationDown( )
	local infoCell = self.stationDownImage:clone()
	infoCell:setVisible(true)
	return infoCell
end

function InfoStationLayer:drawScrollViewLine( )
	local infoStationList = self:getStationData()

	local beginDis = 0
	if not(infoStationList[1] == nil) then
		beginDis = infoStationList[1].positionOrder[1]
	end
	if beginDis > 0 then
		local lineImage = self.stationLineImg:clone()
		lineImage:setContentSize(CCSizeMake(beginDis, lineImage:getContentSize().height))
		lineImage:setVisible(true)
		lineImage:setPosition(ccp(0, self.infoScrollView:getContentSize().height/2))
		self.infoScrollView:addChild(lineImage)
	end

	for _index, _station in ipairs(infoStationList) do
		if not(self.stationNodeList[_index + 1] == nil) then
			local lastPosX = _station.positionOrder[1]
			local nextPosX = infoStationList[_index + 1].positionOrder[1]
			local dis = math.max(0, nextPosX - lastPosX - self.stationNodeList[_index]:getContentSize().width)
			local lineImage = self.stationLineImg:clone()
			lineImage:setContentSize(CCSizeMake(dis, lineImage:getContentSize().height))
			lineImage:setVisible(true)
			lineImage:setPosition(ccp(lastPosX + self.stationNodeList[_index]:getContentSize().width, self.infoScrollView:getContentSize().height/2))
			self.infoScrollView:addChild(lineImage)
		end
	end
	local infoScrollViewSize = 0
	if #infoStationList > 0 then 
		infoScrollViewSize = math.max(GameConfig.DESIGN_SIZE.width, infoStationList[#infoStationList].positionOrder[1] + self.stationDownImage:getContentSize().width)
	end

	local endDis = 0
	local endNode = self.stationNodeList[#self.stationNodeList]
	if not(endNode == nil) then
		endDis = infoScrollViewSize - endNode:getPositionX() + endNode:getContentSize().width
	end
	if endDis > 0 then
		local lineImage = self.stationLineImg:clone()
		lineImage:setContentSize(CCSizeMake(endDis, lineImage:getContentSize().height))
		lineImage:setVisible(true)
		lineImage:setPosition(ccp(endNode:getPositionX() + endNode:getContentSize().width, self.infoScrollView:getContentSize().height/2))
		self.infoScrollView:addChild(lineImage)
	end
end

return InfoStationLayer
