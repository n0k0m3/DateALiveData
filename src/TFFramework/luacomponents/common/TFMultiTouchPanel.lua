TFMultiTouchPanel = class("TFMultiTouchPanel", function(size, innerSize)
    local panel = TFPanel:create():Size(size)
    panel.node = CCNode:create():AddTo(panel)
    -- panel.touchNodeMask = CCNode:create():AddTo(panel)
    panel.touchNode = CCNode:create():AddTo(panel)
    -- local panel = TFScrollView:create()
    return panel
end)

function TFMultiTouchPanel:ctor(size, innerSize)
    self.size = size or me.winSize
    self.innerSize = innerSize or size or me.winSize
    self.innerSize.width = math.max(self.size.width, self.innerSize.width)
    self.innerSize.height = math.max(self.size.height, self.innerSize.height)
    self.scaleRate = 70

    self:setSize(self.size)
    self.touchNode:setTouchEnabled(true)
    self.touchNode:setSwallowTouch(false)
    self.touchNode:setSize(self.size)
    self:setTouchEnabled(true)
    -- self:setMultiTouchEnabled(true)
    -- self:setDirection(SCROLLVIEW_DIR_BOTH)
    self:initInnerNode(innerSize)
    self:initEvents()
    self:reCalcScaleBoundBySize()
end

function TFMultiTouchPanel:SetScaleRate(rate)
    rate = clamp(rate or 70, 5, 500)
    self.scaleRate = rate
end

function TFMultiTouchPanel:addChild(ch, zo)
    self.node:addChild(ch, zo or 0)
    -- ch:setCheckChildInfoEnabled(true)
end

function TFMultiTouchPanel:removeAllChildren()
    self.node:removeAllChildren()
end

function TFMultiTouchPanel:removeAllChildrenWithCleanup(clean)
    if clean == nil then clean = true end
    self.node:removeAllChildrenWithCleanup(clean)
end

function TFMultiTouchPanel:SetInnerSize(innerSize)
    self.innerSize = innerSize or self.size or me.winSize
    self.innerSize.width = math.max(self.size.width, self.innerSize.width)
    self.innerSize.height = math.max(self.size.height, self.innerSize.height)
    self.node:setSize(self.innerSize)
    self:reCalcScaleBoundBySize()
end

function TFMultiTouchPanel:reCalcScaleBoundBySize()
    local sx = self.size.width / self.innerSize.width
    local sy = self.size.height / self.innerSize.height

    self.minScale = math.max(sx, sy)
    self.maxScale = 2
end

function TFMultiTouchPanel:initInnerNode(innerSize)
    -- self.node = self:getInnerContainer()
    -- function self.node.setSize(innerNode, size)
    --     self:setInnerContainerSize(size)
    -- end
    -- function self.node.getSize(innerNode)
    --     self:getInnerContainerSize()
    -- end
    -- self.touchNodeMask:setTouchEnabled(false)
    
    self.touchNode:setTouchEnabled(true)
    -- self.touchNode:setMultiTouchEnabled(true)
    -- self:setCheckChildInfoEnabled(true)
    -- self.node:setCheckChildInfoEnabled(true)

    self.node:setSize(innerSize)
    self.node:Pos(0, 0)
end

function TFMultiTouchPanel:initEvents()
    self:initTouchEvents()
    -- self:OnFrame(function(sender, dt)
    --     sender:onFrame(dt)
    -- end)
end


function TFMultiTouchPanel:initTouchEvents()
    local scene =  me.Director:getRunningScene()
    self.isMulTouch = false
    self.touch1 = nil
    self.touch2 = nil
    self.lastDis = 0
    self.touchNode:OnBegan(function(sender, pos)
        self.touch1 = pos
        if self.touchNode2  == nil then
            self.touchNode2 = CCNode:create()
            -- self.touchNode2:setSize(self.touchNode:getSize())
            -- self.touchNode:getParent():addChild(self.touchNode2, 999999)
            -- self.touchNode2:setPosition(self.touchNode:getPosition())
            self.touchNode2:setSize(me.winSize)
            scene:addChild(self.touchNode2)
            self.touchNode2:setPosition(self.touchNode:convertToWorldSpace(ccp(0, 0)))

            self.touchNode2:OnBegan(function(sender, pos)
                if self.touch1 == nil then
                    return
                end
                self.touch2 = pos
                self.lastDis = math.sqrt(math.pow((pos.x - self.touch1.x),2) + math.pow((pos.y - self.touch1.y),2))
                self.isMulTouch = true
                if self.touchNode3 == nil then
                    self.touchNode3 = CCNode:create()
                    self.touchNode3:setSize(me.winSize)
                    scene:addChild(self.touchNode3)
                    self.touchNode3:setPosition(self.touchNode:convertToWorldSpace(ccp(0, 0)))
                    
                    self.touchNode3:OnBegan(function(sender, pos)
                        print('touchnode3 onbegin..........................')
                        return true
                    end)
                end
                return true
            end)
            self.touchNode2:OnMoved(function(sender, pos)
                if self.touch1 == nil then
                    return
                end
                self.touch2 = pos
                if self.isMulTouch  and self.touch1 ~= nil then
                    local curDis = math.sqrt(math.pow((pos.x - self.touch1.x),2) + math.pow((pos.y - self.touch1.y),2))
                    local scale = (curDis - self.lastDis) / self.scaleRate
                    self.lastDis = curDis
                    local center = ccp((pos.x + self.touch1.x) / 2, (pos.y + self.touch1.y) / 2)
                    self:onNodeScaleToCenter(scale + self.node:getScale(), center)
                end
            end)
            self.touchNode2:OnEnded(function(sender, pos)
                self.touch2 = nil
                self.isMulTouch = false
            end)
        end
    end)
    self.touchNode:OnMoved(function(sender, pos)
        if not self.isMulTouch and self.touch1 ~= nil then
            self:onNodeMoved(nil, pos, self.touch1)
        end
        self.touch1 = pos        
    end)

    self.touchNode:OnEnded(function(sender, pos)
        self.touch1 = nil
        self.isMulTouch = false
        if self.touchNode2 then
            self.touchNode2:removeFromParent(true)
            self.touchNode2 = nil
        end
        if self.touchNode3 then
            self.touchNode3:removeFromParent(true)
            self.touchNode3 = nil
        end
    end)

    self.touchNode:OnExit(function(sender)
        if not tolua.isnull(self.touchNode2)  then
            self.touchNode2:removeFromParent(true)
            self.touchNode2 = nil
            self.isMulTouch = false
        end

        if not tolua.isnull(self.touchnode3)  then
            self.touchNode3:removeFromParent(true)
            self.touchNode3 = nil
        end
    end)
end


--[[ old
    self.touchinfo = {
        CurTouches = {},
        LastTouches = {}
    }
    self.touchNode:OnBegan(function(sender, poses)
        self:onTouchBegan(poses)

        if #poses >= 2 then self.touchNodeMask:setTouchEnabled(true) end

        print("OnBegan", #poses >= 2)
    end)
    self.touchNode:OnMoved(function(sender, poses)
        self:onTouchMoved(poses)
    end)
    self.touchNode:OnEnded(function(sender, poses)
        self:onTouchEnded(poses)
        if #poses < 2 then self.touchNodeMask:setTouchEnabled(false) end
        print("OnEnded", #poses < 2)
    end)
]]

    -- self:addMEListener(TFWIDGET_CHECK_CHILDINFO, function(sender, tp, pos)
    --     if tp == 0 then 
    --         self:onTouchBegan({pos})
    --     elseif tp == 1 then 
    --         self:onTouchMoved({pos})
    --     elseif tp == 2 then 
    --         self:onTouchEnded({pos})
    --     end
    -- end)


--[[
function TFMultiTouchPanel:convertTouches(ts, poses)
    ts = ts or {}
    for id, pos in pairs(poses) do 
        pos.id = id
        table.insert(ts, pos)
    end
    table.sort(ts, function(lhs, rhs)
        return lhs.id < rhs.id
    end)
    return ts
end

function TFMultiTouchPanel:onTouchBegan(poses)
    -- poses[1] = ccp(1800, 1000)
    self:convertTouches(self.touchinfo.CurTouches, poses)
    
        print("began", poses)
end

function TFMultiTouchPanel:onTouchMoved(poses)
    -- poses[1] = ccp(1800, 1000)
    self.touchinfo.LastTouches = self.touchinfo.CurTouches
    self.touchinfo.CurTouches = self:convertTouches({}, poses)

    self:judgeTouches()
end

function TFMultiTouchPanel:onTouchEnded(poses)
    -- for id, pos in pairs(poses) do 
    --     pos.id = id
    --     table.insert(ts, pos)
    -- end

        print("end", poses)

    self.touchinfo = {
        CurTouches = {},
        LastTouches = {}
    }
end

function TFMultiTouchPanel:judgeTouches()
    local CurTouches = self.touchinfo.CurTouches
    local LastTouches = self.touchinfo.LastTouches

    local CurLen = #CurTouches
    local LastLen = #LastTouches
    if CurLen == 0 or LastLen == 0 then return end

    if CurLen == 1 and LastLen == 1 then 
        local seek = CurTouches[1] - LastTouches[1]
        self:onNodeMoved(seek, CurTouches[1], LastTouches[1])
    elseif CurLen == 2 and LastLen == 2 then 
        local center = (CurTouches[1] + CurTouches[2]) / 2
        local CurDis = (CurTouches[1] - CurTouches[2]):length()
        local LastDis = (LastTouches[1] - LastTouches[2]):length()
        local scale = (CurDis - LastDis) / self.scaleRate
        self:onNodeScaleToCenter(scale + self.node:getScale(), center)
    end
end
]]

function TFMultiTouchPanel:onNodeMoved(seek, cpos, lpos)
    local wseek = self:convertToNodeSpace(cpos) - self:convertToNodeSpace(lpos)
    self.node:Pos(self.node:Pos() + wseek)
    --self:checkBoundBySeekPos(wseek)
end

-- function TFMultiTouchPanel:onNodeScaled(scale)
-- end

function TFMultiTouchPanel:onNodeScaleToCenter(scale, center)
    scale = clamp(scale, self.minScale, self.maxScale)

    local lc = self.node:convertToNodeSpace(center)
    self.node:setScale(scale)
    local wc = self.node:convertToWorldSpace(lc)
    
    local wseek = self:convertToNodeSpace(wc) - self:convertToNodeSpace(center)
    local seek = wc - center
    self.node:Pos(self.node:Pos() - wseek)
    self:checkBoundBySeekPos(ccp(0, 0)-wseek)
end

function TFMultiTouchPanel:checkBoundBySeekPos(seek)
    local pa = self:convertToWorldSpace(ccp(0, 0))
    local pc = self:convertToWorldSpace(ccp(self.size.width, self.size.height))

    local na = self.node:convertToWorldSpace(ccp(0, 0))
    local nc = self.node:convertToWorldSpace(ccp(self.innerSize.width, self.innerSize.height))

    if seek.x > 0 then 
        if na.x > pa.x then 
            self.node:PosX(0)
        end
    else 
        if nc.x < pc.x then 
            self.node:PosX(self.size.width - self.innerSize.width * self.node:getScale())
        end
    end
    
    if seek.y > 0 then 
        if na.y > pa.y then 
            self.node:PosY(0)
        end
    else 
        if nc.y < pc.y then 
            self.node:PosY(self.size.height - self.innerSize.height * self.node:getScale())
        end
    end
end

-- function TFMultiTouchPanel:onFrame(poses)
-- end


function TFMultiTouchPanel:setMulSwallowTouch(flag)
    if flag then
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(true)
    else
        self.touchNode:setTouchEnabled(true)
        self.touchNode:setSwallowTouch(false)
    end
end

return TFMultiTouchPanel