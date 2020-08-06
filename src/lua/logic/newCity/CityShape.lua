local CityShape = class("CityShape", function ( )
    return CCNode:create()
end)
local E_ShapeDir = {
    E_Left = 1,
    E_Right = 2,
}
--模型层级
local E_CityModelZorder = {
    E_Prop = 1,
    E_Npc = 50,
    E_Fair = 51,
}

function CityShape:ctor(conf)
    self.cityLevel = EC_NewCityLevel.NewCity_Fore
    self.cityShapeScale = 0.3
    self.roomShapeScale = 0.9
    self.moveSpeed = 80
    self.isSleep = false
    self.isTalking = false
    self.isClickEnable = true

    self.bid = 0
    self.resPath = conf.path
    self.mid = conf.mid
    self.rid = conf.rid
    self.aiword = clone(conf.word)
    -- dump(self.aiword, "self.aiword")
    self.iconPos = clone(conf.iconpos)
    self.isFlip = conf.isflip
    self.curAnim = ""
    self.curRealAnim = ""
    self.state = nil

    self.shapeIcons = {}
    self.clickFunc = nil
    self.isSpecialModel = not self.isFlip
    self.controller = conf.controller or cityController
    self:initRole(conf.path, conf.stype)
    self:addMEListener(TFWIDGET_EXIT,handler(self.onExit,self))
    --local drawnode = DrawNode:create()
    ---- drawnode:drawLine(me.p(-120 , 0), me.p(120 , 0), ccc4(0,0,255,200))
    --drawnode:drawDot(me.p(0,0),3,ccc4(1,1,0,1))
    --self:addChild(drawnode)

end

function CityShape:getAnimWithPrefix(anim)
    if self.isSpecialModel == true then
        if self.shapeDir == E_ShapeDir.E_Left then
            anim = "l_"..anim
        else
            anim = "r_"..anim
        end
    end
    return anim
end

function CityShape:setShapeBornPos(pos, bid)
    self.bid = bid
    self:setPosition(pos)
    self.shapeAnim:setScaleX(math.abs(self.shapeAnim:getScaleX()))
    self.shapeDir = E_ShapeDir.E_Right
    self:playAnim("idle", -1)
    self.oldPos = pos

    if self.shapeEmojExtAnim then
        self.shapeEmojExtAnim:setCameraMask(self:getCameraMask())
    end
    self.shapeAnim:setCameraMask(self:getCameraMask())
    self:stopAllActions()
    if self.aiModel then
        self.aiModel:reportBornPos(pos)
        self.aiModel:setAIEnabled(true)
    end
    local talknode = self:getChildByName("talkNode")
    if not tolua.isnull(talknode) then
        talknode:stopAllActions()
        talknode:removeFromParent()
    end
end

function CityShape:setCityScale()
    self.shapeAnim:setScale(self.cityShapeScale)
    return self
end

function CityShape:setRoomScale()
    self.shapeAnim:setScale(self.roomShapeScale)
    return self
end

function CityShape:getNodePos(pnode)
    local wp = self:convertToWorldSpace(ccp(0, 0))
    local np = pnode:convertToNodeSpace(wp)
    return np
end

function CityShape:initRole(path, stype)
    self.shapeType = stype
    if self.shapeType == EC_NewCityModelType.NewCity_Fair then
        if NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update then
            self.state = RoleDataMgr:getElvesShowState(self.rid)
        end
        self:setZOrder(E_CityModelZorder.E_Fair)
        self.aiModel = requireNew("lua.logic.newCity.RoleBehave"):new({tarNode = self,objId = 1,controller = self.controller})
        self.shapeEmojExtAnim = SkeletonAnimation:create("modle/citymodle/wenhao/wenhao")
        self.shapeEmojExtAnim:setAnimationFps(GameConfig.ANIM_FPS)
        self.shapeEmojExtAnim:addMEListener(TFARMATURE_COMPLETE,function(sklete)
            self.shapeEmojExtAnim:setVisible(false)
        end)
        self:addChild(self.shapeEmojExtAnim)
        self.shapeEmojExtAnim:setVisible(false)
    elseif self.shapeType == EC_NewCityModelType.NewCity_Npc then
        self:setZOrder(E_CityModelZorder.E_Npc)
        self.aiModel = requireNew("lua.logic.newCity.NpcBehave"):new({tarNode = self,objId = 1,controller = self.controller})
    end
    self.shapeAnim = SkeletonAnimation:create(path)--TODO 要还原代码
    self.shapeAnim:setAnimationFps(GameConfig.ANIM_FPS)
    self:playAnim("idle", -1)
    self:addChild(self.shapeAnim)
    --self.shapeAnim:setHitType(TFTYPE_POINT)
    self.shapeAnim:setTouchEnabled(true)
    self.shapeAnim:onClick(function()
        self:shapeClick()
    end)
    
    self.shapeDir = E_ShapeDir.E_Right
end

function CityShape:playEmojExtAnim()
    self.shapeEmojExtAnim:setVisible(true)
    if self.shapeDir == E_ShapeDir.E_Left then
        self.shapeEmojExtAnim:play("wenhaoB",0)
    else
        self.shapeEmojExtAnim:play("wenhaoA",0)
    end
end

function CityShape:addIcon(icon)
    icon:setCameraMask(self:getCameraMask())
    self:addChild(icon)
    table.insert(self.shapeIcons, icon)
    if self.bid > 0 then
        self:setIconPos()
    end
end

function CityShape:setIconPos()
    local curscale = self.cityShapeScale
    if self.bid >= 100 then
        curscale = self.roomShapeScale
    end
    for i, v in ipairs(self.shapeIcons) do
        v:setPosition(me.p(self.iconPos.x*curscale, self.iconPos.y*curscale))
    end
end

function CityShape:setClickEnabled(enable)
    self.isClickEnable = tobool(enable)
    self.shapeAnim:setTouchEnabled(self.isClickEnable)
end

function CityShape:setClickFunc(clickfunc)
    self.clickFunc = nil
    self.clickFunc = clickfunc
end

function CityShape:getClickFunc()
    return self.clickFunc or function() end
end

function CityShape:shapeClick()
    if self.controller and self.controller.isRoomScrolling then
        return
    end
    if self.clickFunc then
        self.clickFunc()
        return
    end
    if self.shapeType == EC_NewCityModelType.NewCity_Fair and (NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Normal or NewCityDataMgr.curCityType == EC_NewCityType.NewCity_Update) then
        self.aiModel:onRoleClicked()
        RoleDataMgr:enterDatingToElvesState(self.rid,self.bid, self)
    else
        self:showClickTalk()
    end
end

function CityShape:setDirect(dir)
    dir = dir or E_ShapeDir.E_Right
    if self.shapeDir ~= dir then

        self.shapeDir = dir
        if self.shapeDir == E_ShapeDir.E_Right then
            self.shapeAnim:setScaleX(math.abs(self.shapeAnim:getScaleX()))
        else
            self.shapeAnim:setScaleX(-math.abs(self.shapeAnim:getScaleX()))
        end
        self:playAnim(self.curAnim)
    end
end

function CityShape:showClickTalk()
    if self.isTalking then
        do return end
    end
    local talklist = nil
    if self.state and self.state > 0 then
        local words = self.aiword.state[self.state] or {}
        talklist = words[math.random(1, #words)]
    else
        local words = self.aiword.click or {}
        talklist = words[math.random(1, #words)]
    end
    if not talklist then
        self.isTalking = false
        do return end
    end
    local talknum = 1
    local function popTalk(talkId)
        local talknode = self:playTalk(talkId)
        talknode:setOpacity(0)
        local actionArr = {FadeIn:create(0.5),DelayTime:create(2),FadeOut:create(0.5),CallFunc:create(function()
            talknode:removeFromParent()
            talknum = talknum + 1
            if talklist[talknum] then
                popTalk(talklist[talknum])
            else
                self.isTalking = false
            end
        end)}
        talknode:runAction(Sequence:create(actionArr))
    end
    popTalk(talklist[talknum])
end

function CityShape:playTalk(talkid)
    self.isTalking = true
    local talkBg = TFImage:create("ui/newCity/city/48.png")
    local curscale = self.cityShapeScale
    if self.bid >= 100 then
        curscale = self.roomShapeScale
        talkBg:setScale(0.9)
    else
        talkBg:setScale(0.7)
    end
    talkBg:setCameraMask(self:getCameraMask())
    --talkBg:setScale9Enabled(true)
    --talkBg:setContentSize(CCSizeMake(140, 90))
    talkBg:setAnchorPoint(ccp(0.5,0))
    talkBg:setPosition(ccp(0,230*curscale))
    self:addChild(talkBg, 100)
    local talkArrow = TFImage:create("ui/newCity/city/50.png")
    talkArrow:setCameraMask(self:getCameraMask())
    talkArrow:setAnchorPoint(ccp(0.5,1))
    talkArrow:setPosition(ccp(0,0))
    talkBg:addChild(talkArrow)

    local talkLabel = TFLabel:create()
    talkLabel:setDimensions(130, 80)
    talkLabel:setCameraMask(self:getCameraMask())
    talkLabel:setTextById(talkid)
    talkLabel:setFontName("font/fangzheng_zhunyuan.ttf")
    talkLabel:setFontSize(15)
    talkLabel:setAnchorPoint(ccp(0.5,0.5))
    talkLabel:setPosition(me.p(0, talkBg:getSize().height*0.5))
    talkLabel:setFontColor(ccc3(48,53,74))
    talkBg:addChild(talkLabel)

    talkBg:setName("talkNode")
    return talkBg
end

function CityShape:playAnim(anim, loopcount, forceplay)
    self.curAnim = anim or "idle"
    local realanim = self:getAnimWithPrefix(anim)
    if self.curRealAnim == realanim and self.curAnim == "idle" then
        return
    end
    self.curRealAnim = realanim
    loopcount = loopcount or -1
    self.shapeAnim:play(self.curRealAnim, loopcount)
end

function CityShape:move(path, callback,mbehave)
    local function moveTo(dst)
        local curpos = self:getPosition()
        local newdir = E_ShapeDir.E_Right
        if curpos.x > dst.x then
            newdir = E_ShapeDir.E_Left
        end
        self:setDirect(newdir)
        self:playAnim("move", -1)
        local movetime = math.sqrt(math.pow((dst.x-curpos.x),2)+math.pow((dst.y-curpos.y),2)) / (self.moveSpeed *( math.abs(self.shapeAnim:getScale())+ 0.1))
        self:runAction(CCSequence:create({CCMoveTo:create(movetime, dst), CCCallFunc:create(function()
            table.remove(path, 1)
            self:move(path, callback,mbehave)
        end)}))
    end

    if #path > 0 then
        local pos = path[1]
        moveTo(pos)
    else
        if callback then
            if mbehave then
                -- local DirStr ={"向左","向右"}
                -- print(DirStr[mbehave.dir])
                self:setDirect(mbehave.dir)
            end
            callback(mbehave)
            -- print("移动完成")
        end
    end
end

function CityShape:update(dt)

    if tolua.isnull(self) then
        return
    end

    if self.isSleep or not self:isVisible() or not self:getParent():isVisible() then
        return
    end
 
    local curPos = self:getPosition()
    if curPos ~= self.oldPos then
        self.oldPos = curPos
        if self.posCallback then
            self.posCallback(curPos)
            -- print(string.format("Role Pos:(%f,%f)",curPos.x,curPos.y))
        end

        self.controller:reorderISOItem(self.bid)
    end
    if self.aiModel then
        self.aiModel:update(dt)
    end

end

function CityShape:registPosCallback(callback)
    self.posCallback = callback
end

function CityShape:onExit()
    self:stopAllActions()
    if self.aiModel then
        self.aiModel:setAIEnabled(false)
    end
end

function CityShape:awake(isguide)
    self.isSleep = false
    self:resumeSchedulerAndActions()
    if isguide then
        if self.aiModel then
            self.aiModel:setAIEnabled(true)
        end
    else
        self.shapeAnim:resume()
    end
end

function CityShape:sleep(isguide)
    self.isSleep = true
    self:pauseSchedulerAndActions()
    if isguide then
        if self.aiModel then
            self.aiModel:setAIEnabled(false)
        end
    else
        self.shapeAnim:stop()
    end
end

function CityShape:removeState()
    for i, v in ipairs(self.shapeIcons) do
        v:removeFromParent()
    end
    self.shapeIcons = {}
end

function CityShape:updateState()
    if self.shapeType == EC_NewCityModelType.NewCity_Fair then
        local newstate = RoleDataMgr:getElvesShowState(self.rid)
        if newstate ~= self.state then
            self.state = newstate
            --self:sleep()
            --self:awake()
            if self.aiModel then
                self:stopAllActions()
                self.aiModel:onBehaveComplete()
            end
        end
    end
end

function CityShape:removeSelf(breset)
    self:stopAllActions()
    if breset then
        self:removeState()
        self.clickFunc = nil
    end
    if self:getParent() then
        if self.aiModel then
            self.aiModel:setAIEnabled(false)
        end
        self:removeFromParent()
    end
end

function CityShape:setShapeLevel(level)
    level = level or EC_NewCityLevel.NewCity_Fore
    self.cityLevel = level
end

return CityShape