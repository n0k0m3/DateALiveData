
local Node = class("Node",function()
    return TFPanel:create()
end)

function Node:ctor(host,prefab)
    -- self.targetPos = me.p(0,0)
    -- self:setBackGroundColor(ccc3(42,40,71))
    self.node = prefab:clone():show()
    self.host = host
    self.size  = self.node:getSize()
    self:setSize(self.size)
    self.node:setPosition(ccp(self.size.width/2,self.size.height/2))
    self:addChild(self.node )

    self.imageIcon = TFDirector:getChildByPath(self.node, "Image_icon")
    self.textNum   = TFDirector:getChildByPath(self.node, "Label_num")
    self.image_time= TFDirector:getChildByPath(self.node, "Image_time")
    self.imageIcon:setTexture(self.host:getData().icon)
    self.imageIcon:setScale(0.46)
    --更新次数
    self:setNum(self.host:getAddTimes())
    --检查是到了倒计时阶段
    if self.host:isTwinkleTime() then
        self:twinkle(falgtrue)
    end
    --永久
    if self.host:isForever() then
        self.image_time:show()
    else
        self.image_time:hide()
    end
end

function Node:setNum(num)
    num = num or self.host:getAddTimes()
    if num > 1 then
        self.textNum:show()
        self.textNum:setText(tostring(num))
    else
        self.textNum:hide()
    end
end

--icon 闪烁
function Node:twinkle(falg)
    self.imageIcon:stopAllActions()
    if falg then
        local actions = {
            FadeIn:create(0.4),
            FadeOut:create(0.4)
        }
        local repeatAction = RepeatForever:create(Sequence:create(actions))
        self.imageIcon:runAction(repeatAction)
    else
        self.imageIcon:setOpacity(255)
    end
end

function Node:showAction()
    local orbitFront = CCOrbitCamera:create(0.2,1,0,0,-360,0,0)
    self.imageIcon:runAction(orbitFront) 
end

--移动到指定位置
function Node:moveToPos(pos)
    local curPosX = self:getPositionX()
    self:stopAllActions()
    if curPosX ~= pos.x then
        self:moveTo(0.2,pos.x,0)
    end

end



local IconListView = class("IconListView",function ( )
    return CCNode:create()
end)

function IconListView:ctor()
    self.itemList = {}
    self.bLayout  = false
end

function IconListView:createItem(host,bAction,prefab)
    local item = self:findItem(host)
    if item then
        item:setNum(host:getAddTimes())
        return
    end
    local item = Node:create(host,prefab)
    self:addItem(item)
    if bAction then
        item:showAction()
    end
end


function IconListView:addItem(item,bAction)
    table.insert(self.itemList,1,item)
    self:addChild(item)
    --TODO 计算位置 
    local posx = 0
    for index , item in ipairs(self.itemList) do
        posx = (index- 1) *30 
        if bAction then
            item:moveToPos(me.p(posx,0))
        else
            item:stopAllActions()
            item:setPosition(me.p(posx,0))
        end
    end
end


-- function IconListView:doLayout()
--     if not self.bLayout then
--         self.bLayout = true
--     end
-- end

--删除一个节点
function IconListView:findItem(host)
    for index , item in ipairs(self.itemList) do
       if item.host == host then
            return item
       end
    end
end

--更新(次数)
function IconListView:refresh(host)
    local item = self:findItem(host)
    if item then
        item:setNum(host:getAddTimes())
    end
end

--节点闪烁
function IconListView:twinkle(host)
    local item = self:findItem(host)
    if item then
        item:twinkle(host:isTwinkleTime())
    end
end

--删除一个节点
function IconListView:removeItem(host)
    local item = self:findItem(host)
    if not item then
        return
    end

    for index , item in ipairs(self.itemList) do
        if item.host == host then
            table.remove(self.itemList,index)
            item:removeFromParent()
            break
        end
    end
    local posx = 0
    for index , item in ipairs(self.itemList) do
        posx = (index- 1) *30 
        item:moveToPos(me.p(posx,0))
    end
end

--删除所有节点
function IconListView:removeAllItem()
    for index , item in ipairs(self.itemList) do
       item:removeFromParent()
    end
    self.itemList = {}
end

function IconListView:reload(hero,bAction,prefab)
    self:removeAllItem()
    local list = hero:getEffectingBufferEffect()  
    for i, bufferEffect in ipairs(list) do
        if bufferEffect:isShowIcon() then
            self:createItem(bufferEffect,bAction,prefab)
        end
    end 
end

return IconListView