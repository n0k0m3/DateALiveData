local EliminationGame = class("EliminationGame",BaseLayer)

function EliminationGame:initData(data)
    self.eData_ = {}

    for i=1,6 do
        local iconPath = string.format("icon/item/battledrop/%d.png",i)
        self.eData_[i] = {}
        self.eData_[i].iconPath = iconPath
    end

    self.allItem_ = {}
    self.generateItem_ = {} --当前生成
    self.eliminateItem_ = {} --当前消除
end

function EliminationGame:ctor(data)
    self.super.ctor(self,data)

    self:initData(data)

    self:init("lua.uiconfig.smallGame.eliminationGame")
end

function EliminationGame:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self:initPerfab()
    self:initLeft()
    self:initMiddle()

    -- self:loadItems()

    self:createWorld()
end


function EliminationGame:createWorld()
    local worldLayer = require("lua.logic.smallGame.World"):new()
    self:addChild(worldLayer,100)
end

function EliminationGame:initLeft()
    self.Panel_left = TFDirector:getChildByPath(self.ui,"Panel_left")

    self.Label_score = TFDirector:getChildByPath(self.Panel_left,"Label_score")
    self.Label_score:setText(0)
end

function EliminationGame:refreshLeft()
    self:refreshScore()
end

function EliminationGame:refreshScore(score)
    self.Label_score:setText(score)
end

function EliminationGame:initMiddle()
    self.Panel_middle = TFDirector:getChildByPath(self.ui,"Panel_middle")
    self.Panel_elimination = TFDirector:getChildByPath(self.Panel_middle,"Panel_elimination")
    self.Panel_elimination.size = self.Panel_elimination:Size()
end

function EliminationGame:initPerfab()
    local Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")

    self.Panel_eliminationItem = TFDirector:getChildByPath(Panel_prefab,"Panel_eliminationItem")
    self.Panel_eliminationItem.size = self.Panel_eliminationItem:Size()
end

function EliminationGame:loadItems()
    local rowNum = math.ceil(self.Panel_elimination.size.height/self.Panel_eliminationItem.size.height)
    local colNum = math.ceil(self.Panel_elimination.size.width/self.Panel_eliminationItem.size.width)

    local x = -self.Panel_elimination.size.width/2
    local y = self.Panel_elimination.size.height/2
    print("self.Panel_elimination.size.height ",self.Panel_elimination.size.height)
    for r=1,rowNum do
        for c=1,colNum do
            local item = self.Panel_eliminationItem:clone()
            self:updateItem(item)
            item:Pos(x+self.Panel_eliminationItem.size.width*(c-1),y+self.Panel_eliminationItem.size.height*(r-1))
            self.Panel_elimination:addChild(item)
            table.insert(self.allItem_,item)
        end
    end
end

function EliminationGame:updateItem(item)
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local randIndex = math.random(1,#self.eData_)
    Image_icon:setTexture(self.eData_[randIndex].iconPath)
    item.type = randIndex
end

function EliminationGame:enterAction()
    self:dropItems(self.allItem_)
end

function EliminationGame:dropItems(items)
    local speedTime = 0.1
    local disTime = 0.1
    for i,v in ipairs(items) do
        local item = v
        self:dropItem(item,speedTime,disTime*i)
    end
end

function EliminationGame:dropItem(item,speedTime,disTime)
    item:timeOut(function()
        item:moveBy(speedTime,0,-self.Panel_elimination.size.height)
        end,disTime)
end

function EliminationGame:listenElimination()
    local interval= 0.1
    self.timerID_ = TFDirector:addTimer(interval, -1, nil, handler(self.update, self))
end

function EliminationGame:removelistenElimination()
    if self.timerID_ then
        TFDirector:removeTimer(self.timerID_)
        self.timerID_ = nil
    end
end

function EliminationGame:update(delta)
    self:checkElimaination()
end

function EliminationGame:checkElimaination()

end

function EliminationGame:onShow()
    self.super.onShow(self)
    -- self:enterAction()
end

function EliminationGame:registerEvents()

end

return EliminationGame