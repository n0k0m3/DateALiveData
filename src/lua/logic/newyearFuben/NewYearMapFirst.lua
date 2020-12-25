local NewYearMapFirst = class("NewYearMapFirst",BaseLayer)


function NewYearMapFirst:initData()

end

function NewYearMapFirst:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.linkageHwx.linkageHwxFirstMap")
end

function NewYearMapFirst:initUI(ui)
    self.super.initUI(self, ui)
    self.ScrollView_map = TFDirector:getChildByPath(ui,"ScrollView_map")
    self.ScrollView_map:setContentSize(GameConfig.WS)
    self.ScrollView_map:setPositionX(-GameConfig.WS.width/2)
    self.Panel_map = TFDirector:getChildByPath(ui,"Panel_map")
    self.ScrollView_map:setInnerContainerSize(CCSizeMake(self.Panel_map:getSize()))
    self.Button_fly = TFDirector:getChildByPath(ui,"Button_fly"):hide()
    self.Label_fly_name = TFDirector:getChildByPath(self.Button_fly,"Label_name")
    self.Image_fly_name = TFDirector:getChildByPath(self.Button_fly,"Image_name")
end

function NewYearMapFirst:createMapItem(point)
    self.Panel_map:addChild(point)
end

function NewYearMapFirst:focusMap(position, isDelay)
    local innerContainer = self.ScrollView_map:getInnerContainer()
    innerContainer:stopAllActions()
    local innerSize = innerContainer:getSize()
    local offset = self.ScrollView_map:getContentOffset()
    local posX = -(position.x - 1136 / 2)
    local posY = -(position.y - 640 / 2)
    local maxX = 0
    local maxY = 0
    local minX = 1136 - innerSize.width
    local minY = 640 - innerSize.height
    posX = posX > maxX and maxX or posX
    posX = posX < minX and minX or posX
    posY = posY > maxY and maxY or posY
    posY = posY < minY and minY or posY
    local distancX = math.abs(posX - offset.x)
    local distancY = math.abs(posY - offset.y)
    local distance = math.max(distancX, distancY)
    local time = distance / 1000

    if isDelay then
        local offsetStr = CCUserDefault:sharedUserDefault():getStringForKey(MainPlayer:getPlayerId().."mojinmapoffset")
        if offsetStr and offsetStr ~= "" then
            local vector = string.split(offsetStr,"|")
            self.ScrollView_map:setContentOffset(ccp(vector[1],vector[2]))
        end
        self.ScrollView_map:setContentOffset(ccp(posX,posY), time)
    else
        self.ScrollView_map:setContentOffset(ccp(posX,posY), time)
    end
end

function NewYearMapFirst:setFlyBtnInfo(name)
    self.Label_fly_name:setTextById(name)
    local w = self.Label_fly_name:getContentSize().width
    self.Image_fly_name:setContentSize(CCSizeMake(w+42,36))
end

function NewYearMapFirst:showFlyBtn()
    self.Button_fly:show()
end

function NewYearMapFirst:registerEvents(  )
    self.Button_fly:onClick(function()
        LinkageHwxDataMgr:Send_changeMap()
    end)
end
return NewYearMapFirst