ScrollMenu = ScrollMenu or class("ScrollMenu", function()
        return TFPanel:create();
    end );

local WinSize = GameConfig.WS

--[[
params = {
    ["cellCount"]           = 0;
    ["numberInView"]        = 0,            视图中显示的数量，单数
    ["upItem"]              = upItem,       上部分显示底图
    ["downItem"]            = downItem,     下部分显示底图
    ["selItem"]             = selItem,      当前选择底图
    ["offsetX"]             = 0,            X轴偏移
    ["isLoop"]              = false,        是否循环
    ["size"]                = CCSizeMake(1001,100),    
    ["updateCellInfo"]      = nil,    =>    updateCellInfo(cell,cellIdx)
    ["selCallback"]         = nil,    =>    selCallback(cell,cellIdx)
    ["isFlippingX"]         = nil,   =>     isFlippingX --翻转X
}
]]

function ScrollMenu:ctor(data)
    self:init(data);
end

function ScrollMenu:init(params)
    self.cellCount              = params.cellCount;
    self.numberInView           = params.numberInView or 5
    self.upItem                 = params.upItem;
    self.downItem               = params.downItem;
    self.selItem                = params.selItem;
    self.isLoop                 = params.isLoop;
    self.size                   = params.size;
    self.cellWidth              = (params.selItem:getContentSize()).width;
    self.cellHeight             = self.size.height / self.numberInView--(params.selItem:getContentSize()).height - 20;
    self.triggerLen             = self.size.height;--self.cellHeight * 5;
    self.maxOffsetX             = params.offsetX * 8 or 400;
    self.offsetX                = params.offsetX;
    self.updateCellInfo         = params.updateCellInfo or function(cell) print("enter cell: %s", cell); end;
    self.selCallback            = params.selCallback or function(cell) print("enter cell: %s", cell); end;
    self.isFlippingX            = params.isFlippingX
    self.isFromFairy            = params.isFromFairy
    self.selCell                = nil;
    self.isMoving               = false;
    self.selIndex               = 0;
    self.elements               = {};
    self.isDrag                 = true;
    self.callTouchBeganBack     = params.callTouchBeganBack
    self.callTouchEndBack       = params.callTouchEndBack
    self.selItem:retain()
    self.upItem:retain()                 
    self.downItem:retain()

    if self.offsetX + self.cellWidth > self.size.width then
        self.size.width = self.offsetX + self.cellWidth
    end

    local downPosX;
    local downPosY;

    local function in2Value(value, minValue, maxValue)
        return value >= minValue and value <= maxValue;
    end

    local function isTouchRect(touchPoint)
        local worldPoint = self:convertToWorldSpace(ccp(0, 0));
        return in2Value(touchPoint.y, worldPoint.y, worldPoint.y + self.cellHeight);
    end

    local function onTouchUp(sender)
        if not self:isDragEnabeled() then
            return ;
        end
        self:onTouchUp(sender);
        self.isMoving = false
        if self.callTouchEndBack then
            self.callTouchEndBack()
        end
    end

    local function onTouchBegan(sender)
        if not self:isDragEnabeled() then
            return ;
        end

        self.isMoving = true
        local touchPoint = sender:getTouchStartPos();
        downPosX = touchPoint.x;
        downPosY = touchPoint.y;
        if self.callTouchBeganBack then
            self.callTouchBeganBack()
        end
    end

    local function onTouchMoved(sender)
        if not self:isDragEnabeled() then
            return ;
        end

        local touchPoint = sender:getTouchMovePos();

        if self.timer then
            TFDirector:removeTimer(self.timer)
            self.timer = nil
        end

        local moveY = touchPoint.y - downPosY;


        if self.isMoving and moveY > self.cellHeight / 2 then
            moveY = self.cellHeight / 2
        end

        if self.isMoving and moveY < -self.cellHeight / 2 then
            moveY = -self.cellHeight / 2
        end

        if not self.isLoop and moveY > 0 and self.selIndex == self:getCellCount() then
            return;
        end

        if not self.isLoop and moveY < 0 and self.selIndex == 1 then
            return
        end


        self:moveCells(moveY * 0.5);
        downPosX = touchPoint.x;
        downPosY = touchPoint.y;
    end
    --    touch 响应层.
    self.touchLayer =  TFLayer:create()
    self.touchLayer:setTouchEnabled(true)
    self.touchLayer:setSize(GameConfig.WS);
    self.touchLayer:setContentSize(self.size);
    self.touchLayer:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan);
    self.touchLayer:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMoved);
    self.touchLayer:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);
    self.touchLayer:setSwallowTouch(false);
    self:addChild(self.touchLayer, 1);

    self.contentLayer = TFPanel:create();
    self.contentLayer:setContentSize(self.size);
    self.contentLayer:setClippingEnabled(true)
    self:addChild(self.contentLayer)

    -- self.contentLayer:setBackGroundColorType(1);
    -- self.contentLayer:setBackGroundColor(ccc3(0,0,0))
    -- self.contentLayer:setBackGroundColorOpacity(100)

    self.contentLayer:setPosition(0,0)
    print("create create")

    self:addCells();
    self:OnExit(function ()
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end)
end

function ScrollMenu:destroy()

end

function ScrollMenu:onTouchUp()
    self:jumpAction();
end

function ScrollMenu:moveCells(offsetY)
    for i = 1, self:getCellCount() do
        self:updatePositionByIndex(i,offsetY);
    end -- for.
end

local function in2Value(value, minValue, maxValue)
    return value >= minValue and value <= maxValue;
end

function ScrollMenu:isInCenter(posy)
    posy = posy + self.cellHeight / 2;
    local maxY = self.triggerLen / 2 + self.cellHeight / 2;
    local minY = self.triggerLen / 2 - self.cellHeight / 2;
    return in2Value(posy, minY, maxY);
end

function ScrollMenu:isInView(posy)
    return posy < self.triggerLen and posy + self.cellHeight > 0
end

function ScrollMenu:updatePositionByIndex(idx,offsetY)
    local cell = self:getCellByIndex(idx);
    local curPos = cell:getPosition();
    local posy = curPos.y + (offsetY or 0);
    local posx = self.maxOffsetX;

    if self.isLoop then
        if posy + self.cellHeight <= 0 then
            posy = posy + self.cellHeight * self:getCellCount()
        elseif posy > self.triggerLen then
            posy = posy - self.cellHeight * self:getCellCount()
        end
    end

    if posy > self.triggerLen / 2 then
        posx = (self.triggerLen - posy - self.cellHeight) / self.triggerLen / 2 * self.maxOffsetX;
    elseif posy < self.triggerLen / 2 then
        posx = posy / self.triggerLen / 2 * self.maxOffsetX;
    end

    if posx >= self.offsetX then
        posx = self.offsetX
    end

    --X翻转
    if self.isFlippingX then
        posx = - posx + self.size.width - self.cellWidth
    end

    cell:setPosition(ccp(posx,posy))

    local ischange = false;
    local changeType = ""
    if self:isInView(posy) and (not self:isInCenter(posy) and posy < self.triggerLen / 2) then
        ischange = self:updateOne(cell,"down");
        changeType = "down"
    elseif self:isInView(posy) and (not self:isInCenter(posy) and posy > self.triggerLen / 2) then
        ischange = self:updateOne(cell,"up");
        changeType = "up"
    elseif self:isInView(posy) then
        ischange = self:updateOne(cell,"sel");
        changeType = "sel"
        self.selCell = cell;
    end

    if ischange == true and self.updateCellInfo then
        self.updateCellInfo(cell,idx);
    end

    if ischange and changeType == "sel" then
        self.selIndex = idx;
        if self.selCallback then
            self.selCallback(cell,idx);
        end
    end

    --精灵界面的特殊需求，如果选的是当前选中的，x方向不做移动
    if (not ischange) and changeType == "sel" and self.selIndex == idx and self.isFromFairy then
        cell:setPosition(ccp(curPos.x, posy))
    end
end

function ScrollMenu:updateOne(cell,_type)
    local ischange = false
    if cell._type == _type then
        return ischange
    end

    ischange = true
    cell._type = _type;

    local child = cell:getChildByName("item")
    if child then
        cell:removeChild(child);
    end

    local cellContent = nil;
    if _type == "down" then
        cellContent = cell.downItem;
    elseif _type == "up" then
        cellContent = cell.upItem;
    else
        cellContent = cell.selItem;
    end
    cell:addChild(cellContent);
    local anchorPoint = cellContent:getAnchorPoint();
    local size = cellContent:Size();
    cellContent:setPositionX(self.cellWidth / 2 - size.width * (0.5 - anchorPoint.x))
    cellContent:setPositionY(self.cellHeight / 2 - size.height * (0.5 - anchorPoint.y))

    if self.numberInView == 5  then
        local offsetY = self.cellHeight / 2 - size.height / 2 - 8--(8空白像素)
        if _type == "down" then
            cellContent:setPositionY(self.cellHeight / 2 - size.height * (0.5 - anchorPoint.y) + offsetY)
        elseif _type == "up" then
            cellContent:setPositionY(self.cellHeight / 2 - size.height * (0.5 - anchorPoint.y) - offsetY)
        end
    end

    cellContent:setName("item");

    return ischange;
end

function ScrollMenu:appendCell(index)

    local cell = TFPanel:create();
    cell:setContentSize(CCSizeMake(self.cellWidth,self.cellHeight));
    -- cell:setBackGroundColorType(1);
    -- cell:setBackGroundColor(ccc3(math.random(255),math.random(255),math.random(255)))
    -- cell:setBackGroundColorOpacity(255)

    cell.upItem     = self.upItem:clone();
    cell.downItem   = self.downItem:clone();
    cell.selItem    = self.selItem:clone();
    cell.upItem:retain();  
    cell.downItem:retain();
    cell.selItem:retain(); 

    local curCount = self:getCellCount();
    self.selCell = self.selCell or cell;
    self.contentLayer:addChild(cell);
    table.insert(self.elements, cell);
    cell:setName("cell"..index)

    local posy = self.triggerLen - (curCount + 1) * self.cellHeight
    local posx = self.maxOffsetX;

    if posy > self.triggerLen / 2 then
        posx = (self.triggerLen - posy - self.cellHeight) / self.triggerLen / 2 * self.maxOffsetX;
    elseif posy < self.triggerLen / 2 then
        posx = posy / self.triggerLen / 2 * self.maxOffsetX;
    end

    if posx >= self.offsetX then
        posx = self.offsetX
    end

    --X翻转
    if self.isFlippingX then
        posx = - posx + self.size.width - self.cellWidth
    end

    cell:setPosition(ccp(posx,posy));

    if posy + self.cellHeight / 2 < self.triggerLen / 2 then
        self:updateOne(cell,"down");
    elseif posy + self.cellHeight / 2 > self.triggerLen / 2 then
        self:updateOne(cell,"up");
    else
        self:updateOne(cell,"sel")
    end
   
    cell:setTouchEnabled(true);
    local idx = self:getCellCount();
    local startpos = nil;
    local endpos   = nil;
    cell:addMEListener(TFWIDGET_TOUCHBEGAN, function(sender)
            startpos = sender:convertToWorldSpace(sender:getTouchStartPos()); 
        end);
    cell:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
        endpos = sender:convertToWorldSpace(sender:getTouchEndPos());
        if math.abs(startpos.y - endpos.y) < 5 then
            self:scrollTo(idx);
            --self:jumpTo(idx);
        end
    end)

    if self.updateCellInfo then
        self.updateCellInfo(cell,index);
    end

    -- if idx == self.cellCount then
    --     self:jumpTo(1);
    -- end
end

function ScrollMenu:addCells()
    for i=1,self.cellCount do
        self:appendCell(i);
    end
end


function ScrollMenu:setContentPosition(ccp)
    self.contentLayer:setPosition(ccp);
    self.touchLayer:setPosition(ccp);
end

function ScrollMenu:removeCell(idx, isCleanup)
    local cell = self:getCellByIndex(idx);
    cell:removeFromParentAndCleanup(isCleanup);
    table.remove(self.elements, idx);
end

function ScrollMenu:scrollToAction()
    if not self.selCell then
        return;
    end

    local cellpos = self.selCell:getPosition();
    local offsetY = self.triggerLen / 2 - cellpos.y - self.cellHeight / 2;

    local speed = 800;
    local _time = 0;
    local function animation(dt)
        _time = _time + dt * speed;
        if _time >= math.abs(offsetY) then
            self:jumpAction();
            TFDirector:removeTimer(self.timer)
            self.timer = nil
            return;
        end
        if tolua.isnull(self) or _time > 300 then
            TFDirector:removeTimer(self.timer)
            self.timer = nil
            return
        end
        if offsetY < 0 then
            self:moveCells(-dt * speed);
        else
            self:moveCells(dt * speed);
        end
    end
    TFDirector:removeTimer(self.timer)
    self.timer = TFDirector:addTimer(0, -1, nil, animation)
end

function ScrollMenu:scrollTo(idx)
    self.selCell = self:getCellByIndex(idx);
    self:scrollToAction();
end

function ScrollMenu:jumpAction(isJumpTo)
    if self.selCell ~= nil then
        local cellpos = self.selCell:getPosition();
        local offsetY = self.triggerLen / 2 - cellpos.y - self.cellHeight / 2;
        if offsetY == 0 and isJumpTo then
            if self.selCell and self.selCallback then
                self.selCallback(self.selCell,self.__selIdx);
            end
        else
            self:moveCells(offsetY);
        end
    end
end

function ScrollMenu:jumpTo(idx)
    self.__selIdx = idx
    self.selCell = self:getCellByIndex(idx);
    self:jumpAction(true);
    --self:jumpAction();
end

function ScrollMenu:getCellCount()
    return #(self.elements);
end

function ScrollMenu:getSelCell()
    return self.selCell;
end

function ScrollMenu:getCellByIndex(idx)
    return self.elements[idx];
end

function ScrollMenu:getSelIndex()
    return self.selIndex;
end

function ScrollMenu:setDragEnabeled(isDrag)
    self.isDrag = isDrag;
end

function ScrollMenu:isDragEnabeled()
    return self.isDrag;
end