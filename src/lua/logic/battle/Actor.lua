local BattleUtils  = import(".BattleUtils")
local BattleConfig = import(".BattleConfig")
local ResLoader    = import(".ResLoader")
local BattleMgr    = import(".BattleMgr")
local ActionMgr    = import(".ActionMgr")
local enum         = import(".enum")
local eDir         = enum.eDir
local eCameraFlag  = enum.eCameraFlag
local eEvent       = enum.eEvent
local eFallType    = enum.eFallType
local eAnimation   = enum.eAnimation
local eRoleType    = enum.eRoleType
local eVKeyCode    = enum.eVKeyCode
local eMonsterType = enum.eMonsterType
local eColorType   = enum.eColorType
local eFlag        = enum.eFlag
local eAttrType    = enum.eAttrType
local eSkillType   = enum.eSkillType 
local designSize   = me.size(me.EGLView:getDesignResolutionSize())
local defaultZEye  = me.Director:getZEye()

local debug_attrs =  {    
                    eAttrType.ATTR_ATK,  
                    eAttrType.ATTR_DEF,
                    eAttrType.ATTR_NOW_AGR,
                    eAttrType.ATTR_MAX_AGR,
                    eAttrType.ATTR_DMADD,
                    eAttrType.ATTR_DMSUB,
                    eAttrType.ATTR_HADD_PER,
                    eAttrType.ATTR_HSUB_PER,
                    eAttrType.ATTR_DMADD_PER,
                    eAttrType.ATTR_DMSUB_PER,
                    eAttrType.ATTR_PREICE_PER,             -- 穿透率
                    eAttrType.ATTR_PARRY_PER ,             -- 格挡率
                    eAttrType.ATTR_HIT_PER ,             -- 命中率
                    eAttrType.ATTR_DODGE_PE,             -- 闪避率
                    eAttrType.ATTR_CRIT_PER,             -- 暴击率 (通用)
                    eAttrType.ATTR_UNCRIT_P,             -- 抗暴率
                }
local Actor = class("Actor",function (hero)
    local node = CCNode:create()
    BattleMgr.bindActionMgr(node)
    return node
end)

local function createTitleNode( titleId )
    local titleCfg = TitleDataMgr:getTitleCfg(titleId)
    if titleCfg then
        local skeletonTitleNode = SkeletonAnimation:create(titleCfg.showEffect)
        skeletonTitleNode:play("animation", true)
        skeletonTitleNode:setPosition(ccp(0,0))
        skeletonTitleNode:setAnchorPoint(ccp(0,0))
        return skeletonTitleNode
    end
end

function Actor:ctor(hero)
    self.skeletonNodePosition = ccp(0,0)
    self.skeletonNodeRotation = 0
    self.skeletonNodeScale = 1
    self.particleNodes = {}
    self.effectList  = {}
    self.hero        = hero
    self.eventsIndex = {}
    self.infoNodeShow = true
    self.groundNode = CCNode:create()
    self:addChild(self.groundNode)


    -- self:createSkeletonNode()


--检查词缀是否带光环
    --TODO 临时增加缀光环

    local affixDatas = self.hero:getAffixData()
    local affixData
    if affixDatas and #affixDatas > 0 then
        affixData = affixDatas[1]
        if ResLoader.isValid(affixData.resource) then
            local skeletonNode = ResLoader.createEffect(affixData.resource)
            skeletonNode:play(affixData.action, 1)
            self.groundNode:addChild(skeletonNode)
        end
    end

    if self.hero.data.monsterColor and #self.hero.data.monsterColor > 2 then 
        local colorValue  = self.hero.data.monsterColor
        self.defaultColor = me.c3b(colorValue[1],colorValue[2],colorValue[3])
    else
        self.defaultColor =  me.WHITE
    end

    self.colorList = {}
    --是否显示外发光
    self.bShine = false
    self:debugNode()


    self.loadBar = battleController.view:cloneLoadBar()
    self.loadBar:setPosition(0,0)
    self.loadBar.imageBubble = self.loadBar:getChildByName("Image_bubble"):hide() --气泡框
    self.loadBar.labelBubble = self.loadBar.imageBubble:getChildByName("Label_bubble")--气泡文字
    self.loadBar.image_leader = self.loadBar:getChildByName("Image_leader") --队长标识
    self.loadBar.image_leader:hide()
    self.loadBar.imageNameBg = self.loadBar:getChildByName("Image_name_bg"):hide() --精英标识
    self.loadBar.labelName = self.loadBar:getChildByName("Label_name") --名字
    self.loadBar.labelEffectName = self.loadBar:getChildByName("Label_buff_effect") --名字
    self.loadBar.labelEffectName:setSkewX(15)
    --帮会名称
    self.loadBar.label_guild = self.loadBar:getChildByName("Label_guild") --名字
    self.loadBar.label_guild:hide()
    self.loadBar.imageSign = self.loadBar:getChildByName("Image_sign") --精英标识
    self.loadBar.nodeSP    = self.loadBar:getChildByName("Image_loadbar") --血量和护盾值
    self.loadBar.nodeBT    = self.loadBar:getChildByName("Image_loadbar_bt") --霸体
    -- self.loadBar.nodeGT    = self.loadBar:getChildByName("Image_loadbar_gt") --蓄力
    self.loadBar.loadbarHP = self.loadBar.nodeSP:getChildByName("LoadingBar_hp")
    self.loadBar.loadbarSP = self.loadBar.nodeSP:getChildByName("LoadingBar_sp")
    self.loadBar.loadbarBT = self.loadBar.nodeBT:getChildByName("LoadingBar_bt")

    --创建克制icon
    local startPos = self.loadBar.nodeSP:getPosition() + ccp(75 , 0)
    self.loadBar.panel_element = Utils:createElementPanel(self.loadBar , 1 , startPos , nil , 0.5)
    self.loadBar.panel_element:hide()

    -- self.loadBar.loadbarGT = self.loadBar.nodeGT:getChildByName("LoadingBar_gt")
    self.loadBar.imageGuard = self.loadBar:getChildByName("Image_guard") --精英标识
    self.loadBar.imageGuard:hide()
    self.loadBar.imageAffixs ={}
    for index =1,4 do
        self.loadBar.imageAffixs[index] = self.loadBar:getChildByName("Image_affix"..index) --词缀
        self.loadBar.imageAffixs[index]:hide()
    end
    if affixData then
    -- Box("Actor Affix:"..tostring(affixData.affixIcon))
        local icons = self.hero:getAffixDataIcons()
        for index , imageAffix in ipairs(self.loadBar.imageAffixs) do
            local affixIcon = icons[index]
            if ResLoader.isValid(affixIcon) then 
                imageAffix:show()
                imageAffix:setTexture(affixIcon)
                imageAffix:setScale(0.3)
            else
                break
            end
        end
    end
    --血量
    self.loadBar.setHPPercent = function(self,value)
        self.loadbarHP:setPercent(value)
    end 
    --护盾
    self.loadBar.setSPPercent = function(self,value)
        self.loadbarSP:setPercent(value)
    end
    --霸体 
    self.loadBar.setBTPercent = function(self,value)
        self.nodeBT:setVisible((value > 0) and self.nodeSP:isVisible())
        self.loadbarBT:setPercent(value)
    end 
    --蓄力值
    -- self.loadBar.setGTPercent = function(self,value)
    --     self.nodeGT:setVisible(value > 0)
    --     self.loadbarGT:setPercent(value)
    -- end 
    self:addChild(self.loadBar)
    self.infoNode = self.loadBar

    local data = self.hero:getData()
    local roleType = self.hero:getRoleType()
    -- self.infoNode.nodeGT:hide() 
    self.infoNode.labelEffectName:hide()
    if roleType == eRoleType.Hero then
        self.infoNode.nodeSP:hide()
        self.infoNode.nodeBT:hide()
        self.infoNode.labelName:hide()
        self.infoNode.imageSign:hide()
        self.infoNode.labelEffectName:setPosition(self.infoNode.nodeSP:getPosition())
    elseif roleType == eRoleType.Assist then
        self.infoNode.nodeSP:show()
        --助战队友显示绿色血条
        self.loadBar.loadbarHP:setTexture("ui/battle/029_1.png")  
        self.infoNode.nodeBT:hide()
        self.infoNode.labelName:hide()
        self.infoNode.imageSign:hide()
        self.infoNode.labelEffectName:setPosition(self.infoNode.labelName:getPosition())
    elseif roleType == eRoleType.Team then
        self.infoNode.nodeBT:hide()
        self.infoNode.imageSign:hide()
        if data.pid == MainPlayer:getPlayerId() then
            self.infoNode.nodeSP:show()
            self.loadBar.loadbarHP:setTexture("ui/battle/029_1.png")
            self.infoNode.imageNameBg:hide()
            self.infoNode.labelName:setText(tostring(data.pname))
            self.infoNode.labelName:enableStroke(ccc4(0XFD,0X38,0X70,0XFF),1)
            self.infoNode.labelName:show()
            local position = self.infoNode.labelName:getPosition() + ccp(0,15)
            if data.titleId and data.titleId > 0 then 
                self.infoNode.titleEffect = createTitleNode(data.titleId)
                if self.infoNode.titleEffect then 
                    self.infoNode.titleEffect:setPosition(position + ccp(0,18))
                    self.infoNode:addChild(self.infoNode.titleEffect)  
                    position = position + ccp(0,40)     
                end
            end 
            position = self.infoNode.labelName:getPosition()
            position.x = - self.infoNode.labelName:getSize().width/2 - 20
            self.infoNode.image_leader:setPosition(position)
            
        else
            self.infoNode.nodeSP:show()
            --组队队友显示绿色血条
            self.loadBar.loadbarHP:setTexture("ui/battle/029_1.png")
            self.infoNode.imageNameBg:hide()
            self.infoNode.labelName:setText(tostring(data.pname))
            self.infoNode.labelName:enableStroke(ccc4(0X49,0X55,0X7F,0XFF),1)
            self.infoNode.labelName:show()
            local position = self.infoNode.labelName:getPosition()  + ccp(0,15)
            if data.titleId and data.titleId > 0 then 
                self.infoNode.titleEffect = createTitleNode(data.titleId)
                if self.infoNode.titleEffect then 
                    self.infoNode.titleEffect:setPosition(position + ccp(0,18) )
                    self.infoNode:addChild(self.infoNode.titleEffect) 
                     position = position + ccp(0,26)     
                end
            end   
            position = self.infoNode.labelName:getPosition()
            position.x = - self.infoNode.labelName:getSize().width/2 - 40
            self.infoNode.image_leader:setPosition(position)
        end

    elseif roleType == eRoleType.Monster then
        self.loadBar.panel_element:show()
        if data.healthBar > 0 then
            self.infoNode.nodeSP:show()
            if data.healthColor == 2 then --1 红色(默认) 2 绿色
                self.loadBar.loadbarHP:setTexture("ui/battle/029_1.png")
            end
            self.infoNode.nodeBT:hide()
            self.infoNode.labelName:hide()
            local iconId = hero:getMonsterIcon()
            if iconId  then 
                self.infoNode.imageSign:show()
                self.infoNode.imageSign:setTexture(string.format("icon/monsterType/%s.png",iconId))
                self.infoNode.imageSign:setSize(me.size(32,32))
            else
                self.infoNode.imageSign:hide()
            end
        else
            self.infoNode.nodeBT:hide()
            self.infoNode.labelName:hide()
            self.infoNode.imageSign:hide()
            self.infoNode.nodeSP:hide()
        end
        --守护怪标识
        local monsterType = self.hero:getMonsterType()
        if monsterType == eMonsterType.MT_GUARD then --守护对象不显示位置的标识
            self.loadBar.imageGuard:show()
            self.infoNode.imageSign:hide()
        else
            --怪物才有位置标识显示
            self.posPrompt = TFImage:create("ui/battle/025.png")
            self.posPrompt:hide()
            self:addChild(self.posPrompt)
            
            if ResLoader.isValid(data.headlinemark) then
                self.loadBar.imageSign:hide()
                self.loadBar.imageGuard:setTexture(data.headlinemark) 
                self.loadBar.imageGuard:setSize(me.size(32,32))
                self.loadBar.imageGuard:show()
            else
                self.loadBar.imageGuard:hide()
            end
        end
        if data.layer == 2 then --1根据Y轴排序2最上3最下
            self.getSortY = function()
                return 0
            end
        elseif data.layer == 3 then
            self.getSortY = function()
                return 640
            end
        end
        self.infoNode.labelEffectName:setPosition(self.infoNode.labelName:getPosition()+ccp(0,-5)) 
    end
    if data.shadow ~= 2 then --1显示影子 2不显示影子
        --创建影子
        self.shadow = TFImage:create("ui/battle/shadow.png")
        self.shadow:setOpacity(0)
        self.groundNode:addChild(self.shadow)
        if roleType == eRoleType.Team then --组队光圈显示
            if data.pid == MainPlayer:getPlayerId() then
                self.focusNode = ResLoader.createEffect("effect_teamNew3",1) 
                self.focusNode:playByIndex(1,1)
                self.focusNode:setPosition(ccp(0,10))
                self.groundNode:addChild(self.focusNode)  
            end
        end
    end

    self.elementCfg = TabDataMgr:getData("Restrain")


end

--显示气泡
function Actor:showBubble(textId,colors)
    if not colors or #colors < 3 then 
        colors = {125,125,125}
    end
    self.loadBar.labelBubble:setFontColor(me.c3b(colors[1],colors[2],colors[3]))
    self.loadBar.labelBubble:setTextById(textId)
    self.loadBar.imageBubble:stopAllActions()
    self.loadBar.imageBubble:setScale(0.2)
    self.loadBar.imageBubble:show()
    local actions = 
    {   
        ScaleTo:create(0.2,1),
        DelayTime:create(2),
        ScaleTo:create(0.2,0.1),
        Hide:create()
    }
    self.loadBar.imageBubble:runAction(Sequence:create(actions))
end


--指定义模型缩放比
function Actor:setSkeletonNodeScale(scale)
    if self.skeletonNodeScale ~= scale then  
        self.skeletonNodeScale = scale
        if self.skeletonNode then 
            local scale = self._scale * self.skeletonNodeScale
            self.skeletonNode:setScale(scale)
            self:setDir(self:getDir())
        end
    end
end

function Actor:getSkeletonNodeScale()
    return self.skeletonNodeScale
end

function Actor:createParticle(particleIds)
    for index , node in ipairs(self.particleNodes) do
        node:removeFromParent()
    end
    self.particleNodes = {}
    for index ,particleId in ipairs(particleIds) do
        -- Box("data.resource:"..tostring(data.resource))
        local particleNode = BattleUtils.createParticle(particleId)
        particleNode:hide()
        local data = particleNode._data
        --特效层级(0在所有角色下层，1在所有人物上层，2根据地图Y值排序)
        if data.zorder == 0 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,1)
        elseif data.zorder == 1 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,3)
        elseif data.zorder == 2 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
        else
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
            Box("粒子Zorder配置错误:"..tostring(particleId))
        end
        table.insert(self.particleNodes,particleNode)
    end
   
end

--清除动作粒子特效
function Actor:clearActionParticle()
    if self.actionParticleNodes then 
        for index , node in ipairs(self.actionParticleNodes) do
            node:removeFromParent()
        end
    end
    self.actionParticleNodes = nil
end 
--创建绑定动作的特效
function Actor:createActionParticle(particleIds)
    if self.actionParticleNodes then 
        for index , node in ipairs(self.actionParticleNodes) do
            node:removeFromParent()
        end
    end
    self.actionParticleNodes = {}
    for index ,particleId in ipairs(particleIds) do
        -- Box("data.resource:"..tostring(data.resource))
        local particleNode = BattleUtils.createParticle(particleId)
        particleNode:hide()
        local data = particleNode._data
        --特效层级(0在所有角色下层，1在所有人物上层，2根据地图Y值排序)
        if data.zorder == 0 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,1)
        elseif data.zorder == 1 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,3)
        elseif data.zorder == 2 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
        else
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
            Box("粒子Zorder配置错误:"..tostring(particleId))
        end
        table.insert(self.actionParticleNodes,particleNode)
    end
end

--更新粒子位置
function Actor:updateParticle()
    for index ,particleNode in ipairs(self.particleNodes) do
        if self:isVisible() then 
            particleNode:setVisible(true)
            local data     = particleNode._data
            local position = self:getBonePosition(data.mount)
            particleNode:setPosition(position)
            local dir = self:getDir()
            particleNode:_setDir(dir)
        else
            particleNode:setVisible(false)
        end
    end
    if self.actionParticleNodes then
        for index ,particleNode in ipairs(self.actionParticleNodes) do
            if self:isVisible() then 
                particleNode:setVisible(true)
                local data     = particleNode._data
                local position = self:getBonePosition(data.mount)
                particleNode:setPosition(position)
                local dir = self:getDir()
                particleNode:_setDir(dir)
            else
                particleNode:setVisible(false)
            end
        end
    end
end

    -- newData.healthBar   = newData.healthBar or 1 --血条数量
    -- newData.healthColor = newData.healthColor or 1 --1 红色 2 绿色
    -- newData.layer  = newData.layer or 1   --1根据Y轴排序2最上3最下
    -- newData.shadow = newData.shadow or 1 --1显示影子 2不显示影子

--1 绿色2 红色
function Actor:showBufferEffectName(colorType,text)
    self.infoNode.labelEffectName:stopAllActions()
    self.infoNode.labelEffectName:show()
    local effectName = "battle_buff_hint1"
    if colorType == 1 then
        self.infoNode.labelEffectName:setColor(me.GREEN)
        effectName = "battle_buff_hint1"
    else
        self.infoNode.labelEffectName:setColor(me.RED)
        effectName = "battle_buff_hint2"
    end
    if (type(text) == "number") or tonumber(text) then
        self.infoNode.labelEffectName:setTextById(text)
    else
        self.infoNode.labelEffectName:setText(text)
    end

    local actions = 
    {
        DelayTime:create(2),
        Hide:create()
    }
    self.infoNode.labelEffectName:runAction(Sequence:create(actions))
    --播放特效
    -- local skeletonNode = ResLoader.createEffect(effectName)
    -- skeletonNode:play("chuxianlizi", 0)
    -- skeletonNode:setPosition(self.infoNode.labelEffectName:getPosition())
    -- skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
    --         skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    --         end)
    -- self.infoNode:addChild(skeletonNode)
end
--场下获得Buff在切换入场的时候隐藏
function Actor:reset()
    self.infoNode.labelEffectName:hide()
end
--调试节点
function Actor:debugNode()
    if BattleConfig.SHOW_ATK_RECT then
        local drawNode = TFDrawNode:create()
        --角色位置标识
        drawNode:drawSolidCircle(me.p(0,0), 5, 360, 36, ccc4(1, 1, 0, 1))
        --jue
        local rect = self.hero.atkRect
        -- drawNode:drawSolidRect(rect.origin , rect.origin + ccp(rect.size.width,rect.size.height) , ccc4(0 , 0.2, 0, 0.8))
        self:addChild(drawNode,-999)

        local textPos = TFLabel:create()
        textPos:setText("[100,100]")
        textPos:setFontSize(18)
        textPos:setPosition(ccp(0,-20))
        textPos:setAnchorPoint(ccp(0.5,0))
        textPos:setFontColor(ccc3(0,255,0))
        self.textPos = textPos
        drawNode:addChild(textPos)
    end
    if BattleConfig.SHOW_ATTRS then
        local textAttrs = TFLabel:create()
        textAttrs:setText("[100,100]")
        textAttrs:setFontSize(18)
        textAttrs:setPosition(ccp(0,-40))
        textAttrs:setAnchorPoint(ccp(0.5,0))
        textAttrs:setFontColor(ccc3(225,0,0))
        self.textAttrs = textAttrs
        self:addChild(textAttrs,-998)
    end
end

function Actor:setShine(visible)
    self.bShine = visible
end

function Actor:setVisible(visible)
    CCNode.setVisible(self,visible)
    self.groundNode:setVisible(visible) 
    if self.posPrompt then
        if not visible then
            self.posPrompt:setVisible(false)
        end
    end
    self.infoNode:setVisible(visible)
end

function Actor:setVisibleInfo(visible)
    self.loadingBarHp:setVisible(visible)
end

function Actor:showInfoNode(isShow)
    self.infoNode:setVisible(isShow)
end

function Actor:bonePos(boneName)
    local  pos    = self.skeletonNode:getBonePosition(boneName)
    local scaleX  = self.skeletonNode:getScaleX()
    local scaleY  = self.skeletonNode:getScaleY()
    pos.x = pos.x*scaleX
    pos.y = pos.y*scaleY 
    local _pos = self:getPosition() 
    self.xxx = self.xxx  or  0
    if self.xxx < 20 then
    self.xxx  = self.xxx  + 1  
        print(tostring(self.hero.id).."||||||||||"..tostring(math.floor(_pos.y)) ..">"..tostring(math.floor(pos.y))..">"..tostring(math.floor(self.skeletonNodePosition.y))..">"..self:getAnimation()) 
    end
    pos.x = pos.x + _pos.x
    pos.y = pos.y + _pos.y  +   self.skeletonNodePosition.y
    return pos
end

--影子处理
function Actor:update(dt)
    self:updateActorElement()
    -- self.skeletonNode:update(dt*0.001)
    self:updateSkeletonNode(dt*0.001)
   
    if self:isVisible() then
        if self.hero:isLeader() then 
            self.infoNode.image_leader:setVisible(true)
        else
            self.infoNode.image_leader:setVisible(false)
        end
        local position3D = self.hero.position3D
        local pos = self:getBonePosition("body")
        if self.shadow then
            local high    = pos.y - position3D.y
            local scale   = math.min(0.8,math.max(0,high)*0.001)
            local opacity = 255 - scale*200
            self.shadow:setScale(1 + scale)
            self.shadow:setOpacity(opacity)
        end
        self.groundNode:setPosition(pos.x,position3D.y)
        --HP条
        self.infoNode:setPosition(pos.x,pos.y + 95)
        --蓄力条|主动检查更新
        -- self.infoNode:setGTPercent(self.hero:getGatherValue())
        --怪物在屏幕外的时候显示的标识
        if self.posPrompt then
            local cameraPos3D = battleController.cameraPos3D
            if cameraPos3D then
                local width = designSize.width*cameraPos3D.z/defaultZEye
                local pos   = self.hero.position3D
                if pos.x < cameraPos3D.x - width/2 -30 then --左边
                    self.posPrompt:setPosition(me.p(30,pos.y))
                    self.posPrompt:setVisible(true)
                    self.posPrompt:setScaleX(-1)
                elseif pos.x > cameraPos3D.x + width/2 + 30 then
                    self.posPrompt:setPosition(me.p(designSize.width-30,pos.y))
                    self.posPrompt:setVisible(true)
                    self.posPrompt:setScaleX(1)
                else
                    self.posPrompt:setVisible(false)
                end
            end
        end
    end
    self:updateParticle()
    self:bufferEffectUpdate()
    if BattleConfig.SHOW_ATK_RECT then
        if self.textPos then
            self.textPos:setText(string.format("[%s,%s]",math.floor(self.hero.position3D.x),math.floor(self.hero.position3D.y)))
        end
    end
    if BattleConfig.SHOW_ATTRS then 
        local srcProperty  = self.hero:getProperty()
        local text =""
        for i,v in ipairs(debug_attrs) do
            text= text..string.format("[%s:%s]",v,math.floor(srcProperty:getValue(v)))
        end
        if self.textAttrs then
            self.textAttrs:setText(text)
        end
    end
end

-- function Actor:setPosition(...)
--     CCNode.setPosition(self,...)
-- end

local function _addChild(parent,child,index)
    if child:getParent() then
        child:retain()
        child:removeFromParent()
        parent:addObject(child,index)
        child:release()
    else
        parent:addObject(child,index)
    end
end
function Actor:addTo(panel)
    if self.hero:getData().layerSign == 3 then --boss层(地表层以下)
        _addChild(panel,self,-1)      
    else
        _addChild(panel,self,2) 
    end
    _addChild(panel,self.groundNode,1)  --最下层
    _addChild(panel,self.infoNode,3)--最上层
    -- _addChild(panel,self.posPrompt,3)--最上层
    --小箭头
    if self.posPrompt then
        EventMgr:dispatchEvent(eEvent.EVENT_ADD_PROMPT,self.posPrompt)
    end
    for i,particleNode in ipairs(self.particleNodes) do

        particleNode:retain()
        particleNode:removeFromParent()
        local data = particleNode._data
        --特效层级(0在所有角色下层，1在所有人物上层，2根据地图Y值排序)
        if data.zorder == 0 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,1)
        elseif data.zorder == 1 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,3)
        elseif data.zorder == 2 then 
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode)
        else
            EventMgr:dispatchEvent(eEvent.EVENT_EFFECT_ADD_TO_LAYER,particleNode ,3)
            Box("配置错误")
        end
        particleNode:resetSystem() 
        particleNode:release()
    end
end

function Actor:getSortY()
    if self.fixZOrder == -1 then
        return 640
    elseif self.fixZOrder == 1 then
        return 0
    else
        return self.hero.position3D.y
    end
end


function Actor:refresh()
    if self.hero then
        if self.hero:getData().roleType == eRoleType.Hero then
        else
            self.infoNode:setHPPercent(BattleUtils.fixPercent(self.hero:getHpPercent()*0.01))
            self.infoNode:setSPPercent(BattleUtils.fixPercent(self.hero:getShieldPercent()*0.01))

            if self.hero:isRecoverRst() then
                self.infoNode:setBTPercent(BattleUtils.fixPercent(self.hero:getResistPercent()*0.01))
            else
                self.infoNode:setBTPercent(BattleUtils.fixPercent(self.hero:getResistPercent()*0.01))
            end
        end
        
    end
end

function Actor:setName(name)
    -- textName:setText(name)
end
function Actor:getDir()
    return self.dir
end
function Actor:setDir(dir)
    if dir == eDir.LEFT then
        self:setFlipX(true)
    elseif dir == eDir.RIGHT then
        self:setFlipX(false)
    end
    self.dir =  dir
end

function Actor:updateDir(targetPos)
    local pos = self:getPosition()
    if targetPos.x < pos.x then
        self.hero:setDir(eDir.LEFT)
    elseif targetPos.x > pos.x then
        self.hero:setDir(eDir.RIGHT)
    else
        --保持原朝向
    end

end
function Actor:getHero()
    return self.hero
end

function Actor:setTimeScale(scale)
    if self.skeletonNode then
        self.skeletonNode:setTimeScale(scale)
    end
end

function Actor:getTimeScale()
    if self.skeletonNode then
        return self.skeletonNode:getTimeScale()
    end
    return 1
end

function Actor:releaseSkeletonNode()
    if self.skeletonNode then
        self.skeletonNode:removeMEListener(TFARMATURE_EVENT)
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        self.skeletonNode:removeFromParent()
        self.skeletonNode = nil
    end
end

--模糊
function Actor:setShaderVague()
    self.skeletonNode:setShaderProgram("DalFWhite", true)
    local glstate = self.skeletonNode:getGLProgramState()
    glstate:setUniformFloat("speed", 1)
    glstate:setUniformVec3("u_color", Vec3(1,0, 1))

end
--还原
function Actor:setShaderDefault()
    self:setShaderProgramDefault(true)
end

--设置动画旋转角度
function Actor:setRotation(rotation)
    self.skeletonNodeRotation = rotation
    if self.skeletonNode then 
        self:setFlipX(self:getFlipX())
    end
end
function Actor:setSkeletonNodePosition(position)
    self.skeletonNodePosition.x = position.x
    self.skeletonNodePosition.y = position.y
    if self.skeletonNode then 
        self.skeletonNode:setPosition(self.skeletonNodePosition)
    end
end
function Actor:createSkeletonNode()
    local model = self.hero.curForm:getData().model
    local scale = self.hero.curForm:getData().modelSize*BattleConfig.MODAL_SCALE
    self.skeletonNodePosition.y = self.hero.data.zPos or 0
    local opacity = (self.hero.data.transparency or 100)*0.01*255
    if self.skeletonNode then
        --如果 模型和缩放比相同
        if self._model == model and self._scale == scale then
            self.skeletonNode:setPosition(self.skeletonNodePosition)
            return 
        end
    end
    self:releaseSkeletonNode()
    self.animation = nil
    self._model = model 
    self._scale = scale 
    print("createSkeletonNode",model ,scale,self.skeletonNodeScale )
    self.skeletonNode = ResLoader.createRole(self._model , self._scale*self.skeletonNodeScale )
    self.skeletonNode:setScheduleUpdateWhenEnter(false)
    self.skeletonNode:show() --TODO 显示/隐藏
    self.skeletonNode:setPosition(self.skeletonNodePosition)
    self:addChild(self.skeletonNode)
    self.skeletonNode:setCameraMask(self:getCameraMask())
    self.skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent,self))
    self:setDir(self:getDir())
    self.skeletonNode:setOpacity(opacity)
    --清空颜色列表
    self.colorList = {}
    --设置模型颜色
    self:_setColor()
    -- self.skeletonNode:setRotation(60)
    -- self:setDir(eDir.LEFT)

    --TODO 不你直接这么干
    -- if self.animation then 
    --     self:playAni(self.animation,self.loop)
    -- end
end

function Actor:reloadSkeletonNode(aniId,scale)
    self:releaseSkeletonNode()
    scale = scale*BattleConfig.MODAL_SCALE
    self.skeletonNode = ResLoader.createRole(aniId,scale)
    --
    self.skeletonNode:setScheduleUpdateWhenEnter(false)
    self.skeletonNode:hide()
    -- self.skeletonNode:addMEListener(TFWIDGET_AFTER_ENTER, function ()
    --     self.skeletonNode:unscheduleUpdate()
    --  end);

    self:addChild(self.skeletonNode)
    self.skeletonNode:addMEListener(TFARMATURE_EVENT,handler(self.onArmtureEvent,self))

end


function Actor:updateSkeletonNode(dt)
    if self.bShine then
        local size = me.size(800,1600)
        if not self.texture  then
            self.texture = CCRenderTexture:create(size.width,size.height)
            self.texture:setCameraMask(self:getCameraMask())
            self.texture:setShaderProgram("GlowEX_NoFragColor", true)
            -- self.texture:setShaderProgram("GlowEX", true)
            local glstate = self.texture:getGLProgramState()
            glstate:setUniformVec3("GlowColor", Vec3(1, 0, 0))
            glstate:setUniformVec2("TextureSize", ccp(1/size.width, 1/size.height))
            glstate:setUniformFloat("GlowRange", 5)
            glstate:setUniformFloat("GlowExpand", 1.5)
            self:addChild(self.texture)
        end
        local scalex  = self.skeletonNode:getScaleX()
        local scaley  = self.skeletonNode:getScaleY()
        self.texture:beginWithClear(0,0,0,0)
        self.texture:setScale(1,1)
        self.skeletonNode:show()

        self.skeletonNode:setPosition(size.width/2,size.height/2)
        self.skeletonNode:update(dt)
        self.skeletonNode:setScaleX(scalex/math.abs(scalex))
        self.skeletonNode:setScaleY(1)
        self.skeletonNode:visit()
        self.texture:endToLua()
        --还原数据
        self.skeletonNode:setPosition(0,0)
        self.skeletonNode:hide()
        self.skeletonNode:setScaleX(scalex)
        self.skeletonNode:setScaleY(scaley)
        self.texture:setScale(math.abs(scalex))
    else
        self.skeletonNode:update(dt)
    end
end

function Actor:setFlipX(flipX)
    local scaleX = self.skeletonNode:getScaleX()
    local rotation = self.skeletonNodeRotation
    if flipX then
        scaleX= -math.abs(scaleX)
        rotation = -self.skeletonNodeRotation
    else
        scaleX= math.abs(scaleX)
        rotation = self.skeletonNodeRotation
    end
    self.skeletonNode:setScaleX(scaleX)
    self.skeletonNode:setRotation(rotation)
end

function Actor:getFlipX()
    local scaleX = self.skeletonNode:getScaleX()
    return scaleX < 0
end

function Actor:playAni(action, loop, completeCallback,realAction)
    if not self.skeletonNode then return end
    self.animation = action --记录程序定义动作名称
    self.loop = loop
    self.hero:setRoleAction(nil)
    if not realAction then
        local data = self.hero:getRoleAction(action)
        if data then
            action = data.realAction
            --save current roleAction
            self.hero:setRoleAction(data)
        end
    end
    loop = not (not loop)
    local l = loop and 1 or 0
    self.skeletonNode:play(action, l)
    if completeCallback and l == 0 then
        self.skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(skeletonNode)
                skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
                    completeCallback(skeletonNode)
                end)
    else
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    end
    --切换动画 清零
    self.eventsIndex = {}
    self.bFix = false
    --处理其实动作起始特效触发
    self.hero:handleEffectEvent(0)
end


function Actor:playMove()
    --TODO 行加入了跑 需要判断速度的大小
    local moveSpeed = self.hero:getMoveSpeed()
    if moveSpeed > 0 then
        local baseVale = self.hero:getRealMoveSpeed()
        if moveSpeed/baseVale*100 < 30  then
            if self.animation ~= eAnimation.WALK then
                self:playAni(eAnimation.WALK, true)
            end
        else
            if self.animation ~= eAnimation.MOVE then
                self:playAni(eAnimation.MOVE, true)
            end
        end
    elseif moveSpeed < 0 then
        if self.animation ~= eAnimation.RETREAT then
            self:playAni(eAnimation.RETREAT, true) --后退
        end
    else
        --走动动画
        if self.animation ~= eAnimation.MOVE then
            self:playAni(eAnimation.MOVE, true)
        end
    end
end

function Actor:playHurt(callback)
    self.nHurtCount = self.nHurtCount or 0
    self.nHurtCount = self.nHurtCount + 1
    if self.nHurtCount%2 == 0 then
        self:playAni(eAnimation.HURT1, false,callback)
    else
        self:playAni(eAnimation.HURT2, false,callback)
    end
    self:flashRed()
end

-- me.c3b(0xBB,0XFF,0XFF) 冰冻效果
-- 255,210~255,0~255 (保护效果)
function Actor:setColor(color,colorType)
    colorType = colorType or eColorType.Default
    self.colorList[colorType] = color
    --     print("setColor",colorType ,color)
    -- dump(self.colorList)
    self:_setColor()
end

function Actor:_setColor()
    local color     = self.defaultColor
    local colorType = 0 
    for k,v in pairs(self.colorList) do
        if k > colorType then
            color =  v
        end
    end
    -- print("_setColor",color)
    self.skeletonNode:setColor(color)
end


--闪红
function Actor:flashRed()
    self:setColor(me.RED , eColorType.Hit)
    self.skeletonNode:stopAllActions()
    local actions = {
        DelayTime:create(0.2),
        CallFunc:create(function()
            self:setColor(nil , eColorType.Hit)
        end)
    }
   self.skeletonNode:runAction(Sequence:create(actions))
end

local exclude_Animations = {}
-- exclude_Animations[eAnimation.FALL]  = true
exclude_Animations[eAnimation.FLOAT] = true
exclude_Animations[eAnimation.VERTIGO]  = true
exclude_Animations[eAnimation.FLOOR] = true

--冻结
local colorFrzen = me.c3b(0xBB,0XFF,0XFF)
function Actor:playFrozen()
    self:setColor(colorFrzen,eColorType.Frozen)
    self:playAni(eAnimation.FROZEN, true)
end
function Actor:playParalysis()
    self:playAni(eAnimation.STAND, true)
end
function Actor:playWin(callback)
    self:playAni(eAnimation.WIN, false,callback)
end
--复活
function Actor:playRelive(callback)
    self:show()
    self:playAni(eAnimation.RELIVE, false,callback)
end

function Actor:playDie(callback)
    if exclude_Animations[self:getFixAnimation()] then
        --检查是否有DIE3死亡动作
        -- if self.hero:isCustumActionName(eAnimation.DIE3) then
        --     self:playAni(eAnimation.DIE3, false,callback)
        -- else
            -- callback()
        -- end
        callback()
    else
        self:playAni(eAnimation.DIE, false,callback)
    end
end
--瘫痪(眩晕)
function Actor:playVertigo(animation)
    animation  = animation or eAnimation.VERTIGO
    local loop = animation == eAnimation.VERTIGO
    self:playAni(animation, loop)
end
--出生
function Actor:playBorn(callback)
    self:playAni(eAnimation.BORN,false, callback)
    self.skeletonNode:update(0.016) -- 解决出生动作闪一帧的问题
end
--进场
function Actor:playEntrance(callback)
    self:playAni(eAnimation.ENTRANCE, false,callback)
end
--离开
function Actor:playDeparture(callback)
    self:playAni(eAnimation.DEPARTURE, false,callback)
end

--浮空
function Actor:playFloat()
    self:playAni(eAnimation.FLOATHURT,false,function( ... )
        self:playAni(eAnimation.FLOAT,true)
    end)
    self:flashRed()
end

--抓取
function Actor:playGrasp(animation)
    --TODO 先用浮空受击动作
    animation = animation or eAnimation.FLOATHUR
    self:playAni(eAnimation.FLOATHURT,false)
end
--待机
function Actor:playStand()  
    if self.animation ~= eAnimation.STAND then
        self:playAni(eAnimation.STAND,true)
    end
end

--倒地
function Actor:playFloor(callFunc,delayTime)
    delayTime = delayTime or 0.5
    delayTime = delayTime * (1 + RandomGenerator.random(-20,20) *0.01)
    self:playAni(eAnimation.FLOOR,false,function()
        self.hero:setFlag(eFlag.FALL)
        if delayTime > 0 then
            self.hero:stopAllActions()
            local delay = ActionMgr.createDelayAction()
            delay:start(self.hero,delayTime,callFunc)
        else
            callFunc()
        end
    end)

end


local function _symbol( value )
    if value == math.abs(value) then
        return 1
    end
    return -1
end
--释放技能
function Actor:playSkill(host , actionData,callback)
    self.hero:stopAllActions()
    local action      = actionData.action
    local loop        = actionData.loop
    local loopTime    = actionData.loopTime *0.001 
    local loopEndType = actionData.loopEndType  --循环结束时间判定（0根据动作循环时间，1位移结束）
    local actionSpeed   = actionData.actionSpeed*0.0001  --TODO 配置是万分比
    if actionData.speedAddition  then  --是否受攻速影响
        if self.hero:getSkillType() == eSkillType.GENERAL then
            actionSpeed = actionSpeed * self.hero:getAtkSpdNormal() *0.01 --TODO 配置的是百分比
        else
            actionSpeed = actionSpeed * self.hero:getAtkSpd()*0.01 --TODO 配置的是百分比
        end
    end
    self:setTimeScale(actionSpeed)
    local action      = actionData.action
    if actionData.checkDirect then
        if self.hero:isManual() then
            self.hero:checkManualDir()
        else
            self.hero:checkAIDir()
        end
    end

    local function actionOver()
        self:removeTFArmatureListener()
        self.hero:stopAllActions()
        if callback then
            callback()
        end
    end
    self:playAni(action,loop,actionOver,true)
-- 循环结束时间判定（0根据动作循环时间，1位移结束）

    -- print("loop",loop,"loopEndType",loopEndType ,"loopTime",loopTime)
    if loop then 
        if loopEndType == 0 then
            local delay = ActionMgr.createDelayAction()
            delay:start(self.hero , loopTime ,actionOver)
        else
            host:setActionOverFunc(actionOver)
        end
    end
end

--快速移动
function Actor:playQuickMove()
    self:playAni(eAnimation.QUICKMOVE,true)
end
--起身
function Actor:playStandUp(callback)
    self:playAni(eAnimation.STANDUP,false,callback)
end

function Actor:fadeOut(callFunc)
    local fade     = FadeOut:create(0.3)
    local callback = CallFunc:create(function()
         self:setOpacity(0xff)
         self:hide()
         if callFunc then
            callFunc()
         end
    end)
    local seq = Sequence:createWithTwoActions(fade, callback)
    self:runAction(seq)
end

function Actor:getCollisionWithName(boneName)
    local points = self.skeletonNode:getCollisionWithName(boneName)
    -- dump(points)
    return points
end

function Actor:getBoundingBox(boneName)
    local rect = self.skeletonNode:getBoundingBox2(boneName)
    if math.abs(rect.origin.x) > 8192
        or  math.abs(rect.origin.y) > 8192
        or  rect.size.width > 8192
        or  rect.size.height > 8192  then --非法碰撞框
        rect.size.width = 0
        rect.size.width = 0
        rect.origin.x   = 0
        rect.origin.y   = 0
    end
    local pos  = ccp(self:getPosition())
    rect.origin.x = rect.origin.x + pos.x
    rect.origin.y = rect.origin.y + pos.y
    return rect
end
function Actor:getRelativeBoundingBox(boneName)
    return self.skeletonNode:getBoundingBox2(boneName)
end
function Actor:getBonePosition(boneName)
    local pos    = self:getRelativeBonePosition(boneName)
    return me.pAdd(self:getPosition() , pos)
end

function Actor:getRelativeBonePosition(boneName)
    local  pos    = self.skeletonNode:getBonePosition(boneName)
    local scaleX  = self.skeletonNode:getScaleX()
    local scaleY  = self.skeletonNode:getScaleY()
    pos.x = pos.x*scaleX
    pos.y = pos.y*scaleY + self.skeletonNodePosition.y
    return pos
end


function Actor:clearEffect()
    for k , effect in ipairs(self.effectList) do
        effect:removeMEListener(TFARMATURE_COMPLETE)
        effect:removeFromParent()
    end
    self.effectList = {}
end


function Actor:playEffect(effectName,effectScale,actionName,callFunc)
    local skeletonNode = ResLoader.createEffect(effectName,effectScale)
    if actionName then
        skeletonNode:play(actionName, 0)
    else
        skeletonNode:playByIndex(0, 0)
    end
    skeletonNode:addMEListener(TFARMATURE_COMPLETE,function(_skeletonNode)
        _skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
        _skeletonNode:removeFromParent()
        if callFunc then
            callFunc(_skeletonNode)
        end
    end)
    skeletonNode:setCameraMask(self:getCameraMask())
    self:addChild(skeletonNode,2)
    return skeletonNode
end


-- function Actor:playEffectEx(effectName,effectScale)
--     local skeletonNode = ResLoader.createEffect(effectName,effectScale)
--     skeletonNode:playByIndex(0, 1)
--     skeletonNode:setCameraMask(self:getCameraMask())
--     if self.dir == eDir.LEFT then
--         local scaleX = skeletonNode:getScaleX()
--         skeletonNode:setScaleX(-math.abs(scaleX))
--     end
--     self:addChild(skeletonNode)
--     return skeletonNode
-- end



function Actor:playHitEffect(effectName,effectScale,hurtEffectAngle,actionName,zOrder,point)
    local skeletonNode = self:playEffect(effectName,effectScale,actionName)
    if hurtEffectAngle then
        skeletonNode:setRotation(hurtEffectAngle)
    end
    local position3D = self.hero:getPosition3D()
    local pos = me.p(position3D.x,position3D.z)
    pos = me.pSub(point,pos)                   
    skeletonNode:setPosition(pos)
    if zOrder then
        skeletonNode:setZOrder(zOrder)
    end
end

function Actor:addEffect(effectNode,zOrder)
    zOrder = zOrder or 1
    effectNode:setCameraMask(self:getCameraMask())
    self:addChild(effectNode,zOrder)
end



function Actor:pause()
    self.skeletonNode:stop()
    self:pauseSchedulerAndActions()
end

function Actor:resume()
    self.skeletonNode:resume()
    self:resumeSchedulerAndActions()
end

function Actor:removeFromParent_(cleanUp)
    self:clearActionParticle()
    self:removeFromParent()
    if cleanUp then
        if self.groundNode then
            self.groundNode:removeFromParent()
            self.groundNode = nil
        end
        if self.infoNode then
            self.infoNode:removeFromParent()
            self.infoNode = nil
        end
        if self.posPrompt then
            self.posPrompt:removeFromParent()
            self.posPrompt = nil
        end
        if self.roleParticle then 
            self.roleParticle:removeFromParent()
            self.roleParticle = nil
        end
        for i, particleNode in ipairs(self.particleNodes) do
            particleNode:removeFromParent()
        end
        self.particleNodes = {}
    else
        --休息时不做销毁处理
        if self.groundNode then
            self.groundNode:retain()
            self.groundNode:removeFromParent()
            self:addChild(self.groundNode)
            self.groundNode:release()
        end
        if self.infoNode then
            self.infoNode:retain()
            self.infoNode:removeFromParent()
            self:addChild(self.infoNode)
            self.infoNode:release()
        end
        if self.posPrompt then
            self.posPrompt:retain()
            self.posPrompt:removeFromParent()
            self:addChild(self.posPrompt)
            self.posPrompt:release()
        end
        if self.roleParticle then 
            self.roleParticle:retain()
            self.roleParticle:hide()
            self.roleParticle:removeFromParent()
            self:addChild(self.roleParticle)
            self.roleParticle:release()
        end

        for i, particleNode in ipairs(self.particleNodes) do
            particleNode:retain()
            particleNode:removeFromParent()
            self:addChild(particleNode)
            particleNode:release()
        end
    end
end



--获取当前播放的动画
function Actor:getAnimation()
    return self.skeletonNode:getAnimation()
end
--
function Actor:getFixAnimation()
    return self.animation or "NONE"
end
-- [u'move', u'die1', u'floor', u'die2', u'float', u'hurt', u'stand', u'standup', u'skillB', u'skillA']

function Actor:isInsertRect(rect)
    -- dump(rect,"rect")
    local pos = self:getPosition()
    -- return me.rectContainsPoint( rect, pos )
    local mRect = me.rect(pos.x-50,pos.y ,100,120)
    return me.rectIntersectsRect( rect, mRect )
    -- return false
end

--删除监听
function Actor:removeTFArmatureListener()
    if self.skeletonNode then
        self.skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    end
end
--动画帧事件

function Actor:onArmtureEvent(...)
    if self.hero then
        local event = BattleUtils.translateArmtureEventData(...)
        self.eventsIndex[event.name] = self.eventsIndex[event.name] or 0
        self.eventsIndex[event.name] = self.eventsIndex[event.name] + 1
        event.pramN = self.eventsIndex[event.name]
        self.hero:onArmtureEvent(event)
    end
end

--创建特效(播放完成后自动删除)
function Actor:createBufferEffects(effectIds)
    self.bufferEffects = self.bufferEffects or {}
    local cameraMask = self:getCameraMask()
    local scale = BattleConfig.MODAL_SCALE * self:getSkeletonNodeScale()
    for k , id in ipairs(effectIds) do
        local data = TabDataMgr:getData("BufferEffectList",id)
        if ResLoader.isValid(data.resource) then 
            local skeletonNode = ResLoader.createEffect(data.resource,scale)
            skeletonNode.mount = data.mount
            skeletonNode.effectsDir = data.effectsDir
            local scaleX = math.abs(skeletonNode:getScaleX())
            if skeletonNode.effectsDir == 1 then --固定向右
                skeletonNode:setScaleX(scaleX)
            elseif skeletonNode.effectsDir == 2 then --固定向左 
                skeletonNode:setScaleX(-scaleX)
            end
            skeletonNode:addMEListener(TFARMATURE_COMPLETE,handler(self.onSkeletonNodeComplete,self))
            skeletonNode:setCameraMask(cameraMask)
            self:addChild(skeletonNode,data.zorder)
            skeletonNode:play(data.action, 0)
            table.insert(self.bufferEffects,skeletonNode)
        end
    end
end

function Actor:bufferEffectUpdate()
    if self.bufferEffects then 
        for i, skeletonNode in ipairs(self.bufferEffects) do
            local pos = self:getRelativeBonePosition(skeletonNode.mount)
            skeletonNode:setPosition(pos)
            if skeletonNode.effectsDir == 0 then 
                local scaleX = skeletonNode:getScaleX()
                if self:getDir() == eDir.LEFT then
                    skeletonNode:setScaleX(-math.abs(scaleX))
                else
                    skeletonNode:setScaleX(math.abs(scaleX))
                end
            end
        end
    end
end




--buffer 特效播放完成
function Actor:onSkeletonNodeComplete(skeletonNode)
    if self.bufferEffects then 
        table.removeItem(self.bufferEffects,skeletonNode)
    end
    skeletonNode:removeMEListener(TFARMATURE_COMPLETE)
    skeletonNode:removeFromParent()
end

--更新克制icon 
function Actor:updateActorElement()
    local roleType = self.hero:getRoleType()
    if roleType == eRoleType.Monster and battleController:getCaptain() ~= self.lastCaptain then
        local heroDat = self.hero:getData()
        local playerHeroData = battleController:getCaptain():getData()
        local pElementCfg = self.elementCfg[playerHeroData.magicAttribute]
        local isRefrain = nil   --是否克制
        for k ,v in pairs(pElementCfg.Refrain) do
            if v == heroDat.magicAttribute then
                isRefrain = true
                break
            end
        end
        if not isRefrain then
            for k ,v in pairs(pElementCfg.underrestraint) do
                if v == heroDat.magicAttribute then
                    isRefrain = false
                    break
                end
            end
        end
        PrefabDataMgr:setInfo(self.loadBar.panel_element , heroDat.magicAttribute , isRefrain , false)
        self.lastCaptain = battleController:getCaptain()
    end
end


return Actor
--[[
我在凌晨三点
醒来的夜里
想起已失去的你
曾经说着永远一起
现在却不再联系

就算时间他模糊了很多的东西
我依然在深爱着你
如果当时的我们少一些固执
是否会有更好的结局


--]]