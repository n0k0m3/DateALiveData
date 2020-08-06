local GuideMgr = require("lua.logic.guide.GuideMgr")
local enum = require("lua.logic.battle.enum")
local eEvent = enum.eEvent

local BattleMgr   = require("lua.logic.battle.BattleMgr")
local obstacleMgr = BattleMgr.getObstacleMgr()
local GuideView  = class("GuideView", BaseLayer)

--蒙版类型
local eStencilType =
{
    NONE   = 0 ,  --无
    CIRCLE = 1 ,  --圆
    RECT   = 2 ,  --矩形
}
function GuideView.getGuideInfo(stepId)
    return TabDataMgr:getData("BattleGuide",stepId)
end
function GuideView:ctor()
    self.super.ctor(self)
    self:init("lua.uiconfig.guide.guideView")
end
function GuideView:initUI(ui)
    self.super.initUI(self,ui)
    self.panel_root     = TFDirector:getChildByPath(ui,"Panel_root")

    -- self.effectNode = CCNode:create()
    -- self.panel_root:addChild(self.effectNode,1000)
    self.frameNode      = TFDirector:getChildByPath(ui,"Panel_frame")
    self.panel_effect   = TFDirector:getChildByPath(ui,"Panel_effect")
    self.panel_effect._size = self.panel_effect:getSize()
    self.panel_effect._skeletonNode = self.panel_effect:getChildByName("Spine_effect")

    self.panel_effect:retain()
self.panel_effect:removeFromParent()
self:addChild(self.panel_effect)
self.panel_effect:release()

    self.panel_tip      = TFDirector:getChildByPath(ui,"Panel_tip")
    self.label_tip      = self.panel_tip:getChildByName("Label_tip")
    self.image_role_r   = self.panel_tip:getChildByName("Image_role_r")
    self.image_role_l   = self.panel_tip:getChildByName("Image_role_l")
    self.button_skip    = TFDirector:getChildByPath(ui,"Button_skip")
    self.image_continue = TFDirector:getChildByPath(ui,"Label_continue")
    self.label_skip     = self.button_skip:getChildByName("Label_skip")
    self.label_skip:setTouchEnabled(true)
    Utils:blinkRepeatAni(self.image_continue)

    self.stencilCircle    = CCSprite:create("ui/057.png")
    self.panel_root:addChild(self.stencilCircle)
    self.stencilCircle:hide()

    self.stencilRect    = CCSprite:create("ui/020.png")
    self.panel_root:addChild(self.stencilRect)
    self.stencilRect:hide()


    local  rootSize    = self.panel_root:getSize()
    -- local size   = me.size(me.EGLView:getDesignResolutionSize())
    -- local size = self.frameNode:getSize()
    -- self.renderTexture = CCRenderTexture:create(size.width, size.height, kCCTexture2DPixelFormat_RGBA8888)
    -- self.renderTexture:setPosition(ccp(size.width/2, size.height/2))


    local visibleSize = me.Director:getVisibleSize();
    local origin = me.Director:getVisibleOrigin();
    self.visibleSize = visibleSize;
    self.renderTexture = CCRenderTexture:create(visibleSize.width, visibleSize.height, kCCTexture2DPixelFormat_RGBA8888);
    self.renderTexture:setPosition(ccp(visibleSize.width / 2, visibleSize.height / 2));
    self:addChild(self.renderTexture)




    -- self.frameNode:addChild(self.renderTexture)
    -- self:setHighLightRect(CCRectMake(200,200,300,300))
    self.frameNode:setTouchEnabled(true)
    self.frameNode:onTouch(function(event)
        self:onTouch(event)
    end)
    --点击跳过
    self.button_skip:onClick(function()
        GuideMgr:onStepSkip()
        self:forceClose()
   end)
    self.label_skip:onClick(function()
        GuideMgr:onStepSkip()
        self:forceClose()
   end)
    self.touchRect = me.rect(50,50,300,300)
    self.nTime = 0
end


function GuideView:setStencilType(stencilType)
    -- Box("stencilType:"..tostring(stencilType))
    if stencilType == eStencilType.CIRCLE then --圆形
        self.stencil = self.stencilCircle
    elseif stencilType == eStencilType.RECT then --矩形
        self.stencil = self.stencilRect
    else
        self.stencil = nil
    end
end
function GuideView:getTopLayer()
    local currentScene = Public:currentScene()
    if currentScene ~= nil and currentScene.getTopLayer then
        return currentScene:getTopLayer()
    else
        return nil
    end
end
function GuideView:getWidget(widget)
    local topLayer = self:getTopLayer()
    if topLayer and topLayer.getWidget then
        return topLayer:getWidget(widget)
    end
end
--根据控件计算位置
function GuideView:_rect(node)
     local pos    = node:convertToWorldSpace(ccp(0,0))  --  node:getPosition()
    if node.xxxx then
        pos = node:getParent():convertToWorldSpace(node:getPosition())  --  node:getPosition()
    elseif node.xxxxx then
        pos = node:getPosition()
    end
    -- Box("["..pos.x..","..pos.y.."]")
    local size   = node:getSize()
    local anchor = node:getAnchorPoint()
    return me.rect(pos.x -size.width*anchor.x ,pos.y -size.height*anchor.y,size.width,size.height)
end

local function _rectPercent(rect,percent)
    local origin = rect.origin
    local size   = rect.size
    return me.rect(origin.x + size.width*(1 - percent*0.01)/2,
                   origin.y + size.height*(1 - percent*0.01)/2,
                   size.width*percent*0.01,
                   size.height*percent*0.01)
end
function GuideView:stepEnd()
    if self.guideInfo then
        local guideInfo = self.guideInfo
        if guideInfo.nextStep == 0 then
            GuideMgr:setGuideLayer(nil)
            AlertManager:closeLayer(self)
        end
        self.guideInfo  = nil
        EventMgr:dispatchEvent(eEvent.EVENT_GUIDE_END,guideInfo)
    end
end

function GuideView:forceClose()
    GuideMgr:setGuideLayer(nil)
    AlertManager:closeLayer(self)
end

function GuideView:doStepWithStep(stepId)
    local guideInfo = self:getGuideInfo(stepId)
    self:doStep(guideInfo)
end

function GuideView:doStep(guideInfo)
    -- self:clearGuideInfo()
    self.guideInfo    = guideInfo
    EventMgr:dispatchEvent(eEvent.EVENT_GUIDE_TRIGGER,guideInfo)

    self.panel_root:setTouchEnabled(guideInfo.swallow)
    if guideInfo.des ~="" then
        self.panel_tip:show()
    else
        self.panel_tip:hide()
    end
    self.label_tip:setString(guideInfo.des)
    self.button_skip:setVisible(guideInfo.showSkip)
    self.button_skip:setTouchEnabled(guideInfo.showSkip)
    self.image_continue:setVisible(guideInfo.showContinue)
    self:setStencilType(guideInfo.stencilType)
    -- if not guideInfo.showContinue then  --点击继续没有蒙版
    if guideInfo.widget ~= "" then
        local widget = self:getWidget(guideInfo.widget)
        if widget then
            self.touchRect   = self:_rect(widget)
            local touchArea  = guideInfo.touchArea
            self.touchRectEx = _rectPercent(self.touchRect,touchArea)
        else
            Box("无法找到控件"..guideInfo.widget)
        end
    else
        self.touchRect = nil
    end
    -- else
    --     self.touchRect = nil
    -- end
    if self.guideInfo.showMask then
        self:showMask()
    else
        self.renderTexture:clear(0,0,0,0)
    end
    self:showEffect(self.guideInfo.effect)
    self.nTime = 0
end

-- function GuideView:doNextStep()
--     if self.guideInfo then
--         if self.guideInfo.nextStep > 0 then
--             local guideInfo =  GuideView.getGuideInfo(self.guideInfo.nextStep)
--             if guideInfo then
--                 self:doStep(guideInfo)
--             else
--                 Box("没有更多引导了")
--             end
--         else
--             -- Box("没有了关闭自己")
--             -- self.guideInfo = nil
--             self:stepEnd()
--             -- AlertManager:close()
--             AlertManager:closeLayer(self)
--         end
--     end

-- end
--跳过
function GuideView:onSkip()
    -- Box("点击跳过")
end

--点击继续
function GuideView:onContinue()
    -- Box("下一步")
    -- print("onContinue...........",self.nTime , self.guideInfo)
    if self.guideInfo and self.guideInfo.showContinue then
            -- print("onContinue...........11",self.nTime , self.guideInfo)
        if self.nTime > 300 then
            self:stepEnd()
        end
    end
end

--摇杆操作
function GuideView:onTouch(event)
    print("GuideView:onTouch....")
    local name   = event.name
    local sender = event.target
    local point
    if event.name=="began" then
        point = sender:getTouchStartPos()
        self:onTouchBegan(sender, point)
    elseif event.name=="moved" then
        point = sender:getTouchMovePos()
        self:onTouchMoved(sender, point)
    elseif event.name=="ended" then
        point = sender:getTouchEndPos()
        self:onTouchEnded(sender, point)
    end
end


function GuideView:onTouchBegan(sender, point)
    if not self.touchRect then
        self.frameNode:setSwallowTouch(true)
        self.bContains = false
        return
    end
    self.bContains = me.rectContainsPoint(self.touchRectEx, point)
    if self.bContains then
        self.frameNode:setSwallowTouch(false)
    else
        self.frameNode:setSwallowTouch(true)
    end

end

function GuideView:onTouchMoved(sender, point)

end

function GuideView:onTouchEnded(sender, point)
    if not self.bContains then
        self:onContinue()
    end
end


function GuideView:showMask()
    local blend = ccBlendFunc()
    blend.src = GL_ZERO
    blend.dst = GL_ONE_MINUS_SRC_ALPHA

    self.renderTexture:clear(0,0,0,0.4)
    self.renderTexture:begin()
    if self.touchRect and self.stencil then
        -- Box(tostring())
        local rect = self.touchRect
        local maskSize = self.stencil:getSize()
        self.stencil:setBlendFunc(blend)
        self.stencil:setPosition(ccp(rect.origin.x,rect.origin.y))
        self.stencil:setAnchorPoint(ccp(0,0))
        self.stencil:setScaleX(rect.size.width/maskSize.width)
        self.stencil:setScaleY(rect.size.height/maskSize.height)
        self.stencil:show()
        self.stencil:visit()
        self.stencil:hide()
    end
    self.renderTexture:endToLua()
end
function GuideView:_onEnter()
    GuideMgr:setGuideLayer(self)
end

function GuideView:_onExit()
    GuideMgr:setGuideLayer(nil)
end




--显示特效
function GuideView:showEffect(action)
    -- self.effectNode:removeAllChildren()
    if not self.touchRect or action == 0 then
        self.panel_effect:hide()
        return
    end
    self.panel_effect:show()
    action = action - 1
    local size       = self.touchRect.size
    local origin     = self.touchRect.origin
    local effectSize = self.panel_effect._size
    if size.width < size.height then
        self.panel_effect:setScale(size.width/effectSize.width)
    else
        self.panel_effect:setScale(size.height/effectSize.height)
    end
    self.panel_effect._skeletonNode:playByIndex(action,1)
    self.panel_effect:setPosition(me.p(origin.x+ size.width/2,origin.y+ size.height/2))



end

function GuideView:hideMask()
    if self.frameNode then
        self.frameNode:setVisible(false)
    end
end


function GuideView:registerEvents()
    -- EventMgr:addEventListener(self,EV_RES_LOAD_STATUS, handler(self.onStatusChange, self))
    -- EventMgr:addEventListener(self,EV_RES_LOAD_CREATE_MODEL, handler(self.onCrarteModel, self))

    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
        self:addMEListener(TFWIDGET_EXIT,  handler(self._onExit,self))
    self:addMEListener(TFWIDGET_ENTER, handler(self._onEnter,self))
end


function GuideView:update(object,dt)
    -- print("delta",dt)
    dt = dt*1000
    self.nTime = self.nTime + dt
    -- print("delta",dt, self.guideInfo~=nil)
    if self.guideInfo and self.guideInfo.autoNext then
        if self.nTime > self.guideInfo.delayTime then
            self:stepEnd()
        end
    end
end

function GuideView:removeEvents()

end
return GuideView
