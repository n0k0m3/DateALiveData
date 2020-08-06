local BattleUtils = import(".BattleUtils")
local MemberList = class("MemberList")
local clickTime  = 0
-- 点击CD 0.5 秒CD
local function canClick()
    local curTime = math.floor(socket.gettime()*1000)
    if curTime - clickTime < 500 then
        return
    end 
    clickTime = curTime
    return true
end


function MemberList:ctor(root) 
    self.rootNode  = root 
    self.roleNodes = self.rootNode.roleNodes
    self.roleNodes[1]:onClick(handler(self.onClick,self))
    self.roleNodes[2]:onClick(handler(self.onClick,self))
end

function MemberList:onClick(target)
    if canClick() then
        if self.selelctCallback then
            self.selelctCallback(target)
        end
    end
end

function MemberList:setVisible(visible)
    self.rootNode:setVisible(visible)
end

function MemberList:isVisible()
    return self.rootNode:isVisible()
end
function MemberList:doLayout()
    local heros = battleController.getBench() --我方队伍替补成员
    table.sort( heros, function(a,b)
        return a.headShowIndex < b.headShowIndex
    end )
    local roleNodes = self.roleNodes
    local index = 0
    roleNodes[1]:hide()
    roleNodes[2]:hide()
    for i , hero in ipairs(heros) do
        if battleController.getCaptain() ~= hero then
            index = index + 1
            if index < 3 then
                local roleNode = roleNodes[index]
                roleNode:show()
                self:resetItem(roleNode ,hero)
            end
        end
    end
    self:setVisible(#heros>1)
end

--刷新item
function MemberList:resetItem(roleNode ,hero)
    roleNode.hero  = hero --hero绑定到控件
    local progress = hero:getProgress()
    roleNode.loadingBar_hp:setPercent(BattleUtils.fixPercent(hero:getHpPercent()*0.01))
    roleNode.image_mask:setVisible(progress > 0)    
    roleNode.label_cdTime:setText(tostring(hero:getRemainTime()))  
    roleNode.image_dead:setVisible(hero:isDead())  

    local resPath = hero:getData().fightIcon
    if roleNode.image_head._resPath ~= resPath then
        roleNode.image_head:setTexture(resPath)
        roleNode.image_head._resPath = resPath
    end

    if  hero:isDead() or progress > 0 then
        roleNode:setTouchEnabled(false)
    else
        roleNode:setTouchEnabled(true)
    end
end

function MemberList:refreshItem(_hero)
    for i, roleNode in ipairs(self.roleNodes) do
        local hero     = roleNode.hero
        if hero then
            if _hero == nil  or _hero == hero then
                local progress = hero:getProgress()
                roleNode.image_mask:setVisible(progress > 0)    
                roleNode.label_cdTime:setText(tostring(hero:getRemainTime()))  
                roleNode.loadingBar_hp:setPercent(hero:getHpPercent()*0.01)
                roleNode.image_mask:setVisible(progress > 0)    
                roleNode.label_cdTime:setText(tostring(hero:getRemainTime()))  
                roleNode.image_dead:setVisible(hero:isDead())  
                if  hero:isDead() or progress > 0 then
                    roleNode:setTouchEnabled(false)
                else
                    roleNode:setTouchEnabled(true)
                end
            end
        end
    end
end


function MemberList:setSelectListener(callfunc)
    self.selelctCallback = callfunc
end


return MemberList