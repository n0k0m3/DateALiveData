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
* -- 弹幕流显示
]]
local DanmuFrame = class("DanmuFrame",BaseLayer)

function DanmuFrame:ctor( data )
	self.super.ctor(self,data)
	self.parent = data.parent
	self.type = data.type
	self.maxFrontSize = 0
	self.moveSpeed = data.speed or 80
	self.rowNum = data.row or 99
	self.autoRun = data.autoRun
	self.resetIndex = data.resetIndex or false
	self:init("lua.uiconfig.common.danmuFrame")
end

function DanmuFrame:initUI( ui )
	self.super.initUI(self,ui)
	self.contentSize = self.parent:getContentSize()
	self.ui:setContentSize(self.contentSize)
	self:setAnchorPoint(self.parent:getAnchorPoint())
	self:setPosition(ccp(0,0))
	self.parent:addChild(self)
	self.modelItems = {}
	local panel_model = TFDirector:getChildByPath(ui,"panel_model")
	local childrenArr = panel_model:getChildren()
	for i=0,childrenArr:count()-1 do
       local child = childrenArr:objectAtIndex(i)
       self.modelItems[child:getName()] = child
       self.maxFrontSize = math.max(self.maxFrontSize,child:getContentSize().height + 15)
   end

   self.rowNum = math.min(self.rowNum, math.floor((self.contentSize.height - 20)/self.maxFrontSize))
   self.offsetY = self.contentSize.height - self.rowNum*self.maxFrontSize

   self.inScreenDanmu = {}
   for i = 1,self.rowNum do
   		self.inScreenDanmu[i] = {}
   end

   if self.autoRun then
		self:play()
   end
end

function DanmuFrame:getDanmu()
	local row,posX,posY = self:calcStartPosition()
	if posX > self.contentSize.width + 300 then
		return
	end
	DanmuDataMgr:getDanmu(self.type)
end

function DanmuFrame:removeEvents(  )
	self.super.removeEvents(self)
	if self.runTimer then
		TFDirector:stopTimer(self.runTimer)
		TFDirector:removeTimer(self.runTimer)
		self.runTimer = nil
	end

	if self.resetIndex then
		DanmuDataMgr.index[self.type] = nil
	end
end

function DanmuFrame:play(  )
	if not self.runTimer then
		self.runTimer = TFDirector:addTimer(100,-1,nil,function ( ... )
			if not self.getDanmu then
				if self.runTimer then
					TFDirector:removeTimer(self.runTimer)
					self.runTimer = nil
				end
				return
			end
			self:getDanmu()
		end)
	end
end

function DanmuFrame:stop(  )
	if self.runTimer then
		TFDirector:stopTimer(self.runTimer)
	end
end

function DanmuFrame:resume(  )
	if self.runTimer then
		TFDirector:resumeTimer(self.runTimer)
	end
end

function DanmuFrame:registerEvents()
	self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_DANMU_DISPACTH, function ( type, data )
    	if type == self.type then
	    	self:createDanmuAndPlay(data)
	    end
    end)
end

function DanmuFrame:createDanmuAndPlay( data )
	local showType = data.showType or 1
	local item = self.modelItems["danmu_itemType_"..showType]:clone()
	if self["updateDanmuItem"..showType] then
		self["updateDanmuItem"..showType](self,item,data)
	else
		self:updateDanmuItemDefault(self,item,data)
	end
	local row,posX,posY = self:calcStartPosition()
	item:setPosition(ccp(posX,posY))
	self.ui:addChild(item)
	table.insert(self.inScreenDanmu[row],item)

	local distance = posX + item:getContentSize().width
	local time = distance/self.moveSpeed
	local moveAni = CCMoveTo:create(time,ccp(-item:getContentSize().width,posY))

	local callFun = CallFunc:create(function()
										self:clearDanmu(row,item)
									end)
	local arr = {}
    table.insert(arr,moveAni)
    table.insert(arr,callFun)
    item:runAction(CCSequence:create(arr))
end

function DanmuFrame:clearDanmu( row, item)
    table.removeItem(self.inScreenDanmu[row],item)
	item:removeFromParent(true)
end

function DanmuFrame:calcStartPosition()
	local tmpOffsetX = 9999
	local row = self.rowNum
	local posX = 0
    for i = 1, self.rowNum do
		local arr = self.inScreenDanmu[i] or {}
		local maxOffsetX = 0
    	for k,item in pairs(arr) do
	    	local offsetX = item:getPositionX() + item:getContentSize().width
	    	maxOffsetX = math.max(offsetX,maxOffsetX)
	    end

	    if tmpOffsetX >= maxOffsetX then
    		tmpOffsetX = maxOffsetX
    		row = i
    		posX = math.max(self.contentSize.width, tmpOffsetX)
    	end
    end
	posX = math.max(self.contentSize.width, posX) + math.random(100,300)
    posY = self.offsetY + self.maxFrontSize*row - self.maxFrontSize/2
    return	row,posX,posY
end

function DanmuFrame:updateDanmuItemDefault(item, data)
	item:setText(string.format("[%s]:%s",data.playerName,data.content))
end

function DanmuFrame:updateDanmuItem1(item, data)
	item:setText(string.format("[%s]:%s",data.playerName,data.content))
end

function DanmuFrame:updateDanmuItem2(item, data)
	item:setText(string.format("[%s]:%s",data.playerName,data.content))
end

function DanmuFrame:updateDanmuItem3(item, data)
	item:setText(string.format("[%s]:%s",data.playerName,data.content))
end

function DanmuFrame:updateDanmuItem4(item, data)
	item:setText(string.format("[%s]:%s",data.playerName,data.content))
end

function DanmuFrame:updateDanmuItem5(item, data)
	item:setText(string.format("%s",data.content))
end

function DanmuFrame:updateDanmuItem6(item, data)
	item:setText(string.format("%s",data.content))
end

function DanmuFrame:updateDanmuItem7(item, data)
	item:setText(string.format("%s",data.content))
	local Image_frame = TFDirector:getChildByPath(item,"Image_frame")
	Image_frame:setContentSize(CCSizeMake(item:getContentSize().width,40))
end

function DanmuFrame:updateDanmuItem8(item, data)
	item:setText(string.format("%s",data.content))
end

function DanmuFrame:updateDanmuItem9(item, data)
	-- body
	local bg = TFDirector:getChildByPath(item,"bg")
	local bg1 = TFDirector:getChildByPath(item,"bg1")
	local Label_content = TFDirector:getChildByPath(item,"Label_content")
	local unprise = TFDirector:getChildByPath(item,"unprise")
	local prised = TFDirector:getChildByPath(item,"prised")
	Label_content:setText(data.content)
	local width = Label_content:getContentSize().width
	local posX = Label_content:getPositionX()
	local allItemWidth = posX + width + bg1:getContentSize().width + 7
	bg1:setPositionX(allItemWidth - 7)
	local defaultHeight = bg:getContentSize().height
	local itemHeight = item:getContentSize().height
	bg:setContentSize(CCSizeMake(allItemWidth,defaultHeight))
	item:setContentSize(CCSizeMake(allItemWidth,itemHeight))
	unprise:setVisible(not data.hasPrise)
	prised:setVisible(data.hasPrise)

	if data.hasPrise then
		TFDirector:getChildByPath(prised,"upNum"):setText(data.prise)
	else
		TFDirector:getChildByPath(unprise,"upNum"):setText(data.prise)
	end
end

function DanmuFrame:updateDanmuItem10(item, data)
	-- body
	local bg = TFDirector:getChildByPath(item,"bg")
	local bg1 = TFDirector:getChildByPath(item,"bg1")
	local Label_content = TFDirector:getChildByPath(item,"Label_content")
	local unprise = TFDirector:getChildByPath(item,"unprise")
	local prised = TFDirector:getChildByPath(item,"prised")
	Label_content:setText(data.content)
	local width = Label_content:getContentSize().width
	local posX = Label_content:getPositionX()
	local allItemWidth = posX + width + bg1:getContentSize().width + 7
	bg1:setPositionX(allItemWidth - 7)
	local defaultHeight = bg:getContentSize().height
	local itemHeight = item:getContentSize().height
	bg:setContentSize(CCSizeMake(allItemWidth,defaultHeight))
	item:setContentSize(CCSizeMake(allItemWidth,itemHeight))
	unprise:setVisible(not data.hasPrise)
	prised:setVisible(data.hasPrise)

	if data.hasPrise then
		TFDirector:getChildByPath(prised,"upNum"):setText(data.prise)
	else
		TFDirector:getChildByPath(unprise,"upNum"):setText(data.prise)
	end
end

function DanmuFrame:onUpdate()
	self:deformation()
end

function DanmuFrame:deformation( )
	-- body
	if self.deformationImage then self.deformationImage:removeFromParent(true) end
	self.ui:show()
	local tx = CCRenderTexture:create(self.contentSize.width,self.contentSize.height)
	tx:begin()
	self:visit()
	tx:endToLua()


    self.deformationImage = Sprite:createWithTexture(tx:getSprite():getTexture())
    self.deformationImage:setShaderProgram("Deformation")
  	local _GLProgramState = self.deformationImage:getGLProgramState()
    _GLProgramState:setUniformFloat("lD", 0)
    _GLProgramState:setUniformFloat("rD", 0)
    _GLProgramState:setUniformFloat("lT", 0)
    _GLProgramState:setUniformFloat("rT", 0)
    self.deformationImage:setScaleY(-1)
    self:setAnchorPoint(ccp(0.5,0.5))
    self:setPosition(ccp(self.contentSize.width/2,self.contentSize.height/2))
    self:addChild(self.deformationImage)

    self.deformationImage:getTexture():setAliasTexParameters()

	self.ui:hide()
end


return DanmuFrame