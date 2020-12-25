local GuideMain = class("GuideMain", BaseLayer)

function GuideMain:ctor(data)
	self.super.ctor(self,data)
    self.widget         = data.widget;
    self.cfg            = data.cfg;
    self.targetUI       = data.ui;
    self.adjustPos = data.pos
    self.rect = CCRectMake(0, 0, 1, 1)
    self:init("lua.uiconfig.guide.guideMain")
end

function GuideMain:initUI(ui)
	self.super.initUI(self,ui)
	self.isShowHand = self.cfg.showContinue
    local visibleSize = me.Director:getVisibleSize()
    local origin = me.Director:getVisibleOrigin()
    self.visibleSize = visibleSize
    self.m_pTarget = CCRenderTexture:create(visibleSize.width, visibleSize.height, kCCTexture2DPixelFormat_RGBA8888)
    self.m_pTarget:setPosition(ccp(visibleSize.width / 2, visibleSize.height / 2))
    self:addChild(self.m_pTarget)
    self.widthTemp = (1136 - visibleSize.width) / 2

    self.Image_quan = TFDirector:getChildByPath(ui,"Image_quan")
    self.Panel_animation = TFDirector:getChildByPath(ui,"Panel_animation")
    self.Spine_guidequan = TFDirector:getChildByPath(ui,"Spine_guidequan")
    self.Panel_flag = TFDirector:getChildByPath(ui,"Panel_flag")
    self.Panel_talk = TFDirector:getChildByPath(ui,"Panel_talk")
    self.Panel_modle = TFDirector:getChildByPath(ui,"Panel_modle")
    self.Image_talk_bg = TFDirector:getChildByPath(ui,"Image_talk_bg")
    self.Image_di    = TFDirector:getChildByPath(ui,"Image_di")
    self.Label_title = TFDirector:getChildByPath(ui,"Label_title")
    Public:BlinkAction(self.Label_title);
    self.Panel_skip  = TFDirector:getChildByPath(ui,"Panel_skip")
    self.Panel_skip:setTouchEnabled(true);
    self.Panel_skip:onClick(function()
        local view = Utils:openView("common.ConfirmBoxView")
        view:setCallback(function()
            GameGuide:skipGuide(GuideDataMgr:isInNewGuide())
        end)
        view:setContent(TextDataMgr:getText(800082))            
    end)
    self.Panel_skip:setVisible(false)
    self:timeOut(function()
        self.Panel_skip:setVisible(true)
    end, 5)

    self.panel_base = TFDirector:getChildByPath(ui,"Panel_base")
    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.maskFlag = false
    if self.isShowHand or self.cfg.uiType ~= 0 or self.widget then
        self.maskFlag = true
    end
    if GuideDataMgr:checkEnableControl(self.cfg) then
        self.panel_base:setTouchEnabled(true)
    end
    local startPoint
    local function onTouchBegan(sender)
        startPoint = sender:getTouchStartPos()
        if self.isShowHand and self.rect then
            if not self.isPlayingWord and me.rectContainsPoint(self.rect,startPoint) then
                self.panel_base:setSwallowTouch(false)
            else
                self.panel_base:setSwallowTouch(true)
            end
        end
    end
    self.panel_base:addMEListener(TFWIDGET_TOUCHBEGAN, onTouchBegan)


    local function onTouchMove(sender)
        local movePoint = sender:getTouchMovePos()
        if math.abs(startPoint.x - movePoint.x) > 5 or math.abs(startPoint.y - movePoint.y) > 5 then
            self.panel_base:setSwallowTouch(true)
        end
    end
    if GuideDataMgr:isInNewGuide() then
        self.panel_base:addMEListener(TFWIDGET_TOUCHMOVED, onTouchMove)
    end
    
    local function onTouchUp(sender)
        if self.isPlayingWord then
            self.Label_talk:stopAllActions()
            self.Label_talk:setString(self.cfg.des)
            self:timeOut(function()
                self.isPlayingWord = false
                if self.maskFlag and self.cfg.uiType ~= 0 then
                    self:showMaskView()
                end
            end, 0.01)
        end
        if not self.isShowHand and self.cfg.uiEffect == "" then
            if not self.isPlayingWord then
                GameGuide:doNextGuide()
            end
        else
            if self.Panel_animation:isVisible() and not self.isPlayingAnim then
                self.isPlayingAnim = true
                self.Spine_guidequan:stop()
                self.Spine_guidequan:play("shengcheng",false)
                self:timeOut(function()
                    self.isPlayingAnim = false
                    self.Spine_guidequan:play("xunhuan",true)
                end, 0.6)
            end
        end
    end
    self.panel_base:addMEListener(TFWIDGET_TOUCHENDED, onTouchUp);
    self.Panel_animation:setVisible(false)
    self.Image_quan:setVisible(false)
    
    self.Label_title:setVisible(not self.maskFlag)
    self.Panel_flag:setVisible(false)

    self.Label_talk = TFDirector:getChildByPath(ui,"Label_talk")
    self.Label_talk:setDimensions(250, 0)
    self.Label_talk:setString(self.cfg.des)
    local talkHeight = self.Label_talk:getContentSize().height
    self.Image_talk_bg:setSize(CCSizeMake(288, math.max(60, talkHeight + 50)))
    self.Label_flag_desc = TFDirector:getChildByPath(ui,"Label_flag_desc")
    self.Label_flag_desc:setString(self.cfg.des)


    if self.cfg.des == "" then
        self.Panel_talk:setVisible(false)
        self.Label_flag_desc:setVisible(false)
    elseif self.cfg.position ~= 0 then
        local elvesNpc = ElvesNpcTable:createLive2dNpcID(self.cfg.modelId,true,true,nil,false).live2d
        elvesNpc:setScale(0.35)
        elvesNpc:setPosition(ccp(0, -380))
        self.Panel_modle:addChild(elvesNpc, 1)
        elvesNpc:newStartAction(self.cfg.action,EC_PRIORITY.FORCE)

        self.Label_talk:setString("")
        local list, len = Public:stringSplit(self.cfg.des)
        local str = ""
        local time = 0.01
        self.isPlayingWord = true
        for i, v in ipairs(list) do
            str = str .. v
            local function displyWord()
                local conText = str
                local acc = {
                    CCDelayTime:create(time),
                    CCCallFunc:create(function()
                        if i == #list then
                            self.isPlayingWord = false
                            if self.maskFlag and self.cfg.uiType ~= 0 then
                                self:showMaskView()
                            end
                        end
                        self.Label_talk:setOpacity(255)
                        self.Label_talk:setText(conText)
                        end)
                }
                self.Label_talk:runAction(CCSequence:create(acc))
            end
            displyWord()
            time = time + 0.06
        end
    end
    local modelSize = self.Panel_talk:getContentSize()
    local winSize = me.Director:getWinSize()
    if self.cfg.position == 1 then
        self.Panel_talk:setPosition(ccp(25 + modelSize.width / 2, visibleSize.height - modelSize.height / 2 - 60))
    elseif self.cfg.position == 2 then
        self.Panel_talk:setPosition(ccp(25 + modelSize.width / 2, modelSize.height / 2 + talkHeight - 70))
    elseif self.cfg.position == 3 then
        self.Panel_talk:setPosition(ccp(1136 - 25 - modelSize.width / 2, visibleSize.height - modelSize.height / 2 - 100))
    elseif self.cfg.position == 4 then
        self.Panel_talk:setPosition(ccp(1136 - 25 - modelSize.width / 2, modelSize.height / 2 + talkHeight - 70))
    elseif self.cfg.position == 5 then
        self.Panel_talk:setPosition(ccp(1136 / 2, visibleSize.height / 2))
    end

    --ViewAnimationHelper.doMoveFadeInAction(self.Panel_talk, {direction = 1, distance = 350, time = 0.2, adjust = 30, ease = 2})

    self.m_pTarget:clear(0,0,0,0.5)
    if not self.widget then
        self.rect = CCRectMake(0, 0, 1, 1)
        return
    end

    local size = self.widget:getContentSize()
    local anchorPoint = self.widget:getAnchorPoint()
    local boundingBox = self.widget:boundingBox()
    local pos = self.widget:getPosition()
    if self.adjustPos then
        pos.x = pos.x + self.adjustPos.x
        pos.y = pos.y + self.adjustPos.y
    end
    pos = self.widget:getParent():convertToWorldSpaceAR(pos)

    pos.x = pos.x - size.width * anchorPoint.x
    pos.y = pos.y - size.height * anchorPoint.y
    self.rect = CCRectMake(pos.x,pos.y,size.width,size.height)
    if self.cfg.uiEffect ~= "" then
        self.Panel_flag:removeFromParent()
        self.widget:removeChildByTag(888, true)
        self.widget:addChild(self.Panel_flag, 999, 888)
        self.Panel_flag:setVisible(true)
        self.Panel_flag:setPosition(ccp(-size.width * anchorPoint.x + size.width / 2, -size.height * anchorPoint.y + size.height + 10))
        local seq = Sequence:create({
                MoveBy:create(0.2, ccp(0, 5)),
                MoveBy:create(0.2, ccp(0, -5)),
        })
        local action = RepeatForever:create(seq)
        self.Panel_flag:runAction(action)
    end
    if not self.isPlayingWord and self.maskFlag and self.cfg.uiType ~= 0 then
        self:showMaskView()
    end 

    if self.widget and self.widget.resetClickFunc then
        local widgetClickFunc =  self.widget:getMEListener(TFWIDGET_CLICK)
        self.widget:onClick(function ( sender )
            -- body
            GameGuide:checkGuideEnd(self.targetUI)
            widgetClickFunc(self.widget)
            sender:onClick(widgetClickFunc)
        end)
    end    
end

function GuideMain:showMaskView()
    if self.cfg.uiType == 1 then
        self.Panel_animation:setVisible(true)
        self.Image_quan:setVisible(false)
        self.Panel_animation:setPosition(ccp((self.rect.origin.x + self.rect.size.width / 2)  + self.widthTemp, self.rect.origin.y + self.rect.size.height / 2 - self.cfg.size * 10))
    else
        self.Panel_animation:setVisible(false)
        self.Image_quan:setVisible(true)
        self.Image_quan:setTexture(self:getFrameImgPath())
        self.Image_quan:setScale(self.cfg.size)
        self.Image_quan:setPosition(ccp((self.rect.origin.x + self.rect.size.width / 2)  + self.widthTemp, self.rect.origin.y + self.rect.size.height / 2))
    end

    local pMask = CCSprite:create(self:getMaskImgPath())
    local blend = ccBlendFunc()
    blend.src = GL_ZERO
    blend.dst = GL_ONE_MINUS_SRC_ALPHA
    pMask:setBlendFunc(blend)
    pMask:setScale(self.cfg.size)
    local adjHeight = 0
    if self.cfg.uiType == 1 then
        adjHeight = -10 * self.cfg.size
    end
    pMask:setPosition(ccp(self.rect.origin.x + self.rect.size.width / 2, self.rect.origin.y + self.rect.size.height / 2 + adjHeight))
    pMask:setAnchorPoint(ccp(0.5, 0.5))

    self.m_pTarget:clear(0,0,0,0.5)
    self.m_pTarget:begin()
    pMask:visit()
    self.m_pTarget:endToLua()

    if self.Image_quan:isVisible() then
        local function scaleOver()
            self.Image_quan:stopAllActions()
            ViewAnimationHelper.doflashAction(self.Image_quan, 0.5, 150)
        end
        self.Image_quan:setScale(self.cfg.size * 1.5)
        local act1 = CCScaleTo:create(0.2, self.cfg.size)
        local act2 = CCCallFunc:create(scaleOver)
        self.Image_quan:runAction(CCSequence:create({act1, act2}))
    end
    if self.Panel_animation:isVisible() then
        self.Panel_animation:setScale(self.cfg.size * 1.25)
        self.isPlayingAnim = true
        self.Spine_guidequan:play("shengcheng",false)
        self:timeOut(function()
            self.isPlayingAnim = false
            self.Spine_guidequan:play("xunhuan",true)
        end, 0.6)
    end
end

function GuideMain:setHighLightRect(rect)
    self.Image_quan:setScale(self.cfg.size)
    self.Image_quan:setPosition(ccp((rect.origin.x + rect.size.width / 2)  + self.widthTemp, rect.origin.y + rect.size.height / 2))
    self.Panel_animation:setPosition(ccp((rect.origin.x + rect.size.width / 2)  + self.widthTemp, rect.origin.y + rect.size.height / 2 - self.cfg.size * 10))
	local pMask = CCSprite:create(self:getMaskImgPath())
    local blend = ccBlendFunc()
    blend.src = GL_ZERO
    blend.dst = GL_ONE_MINUS_SRC_ALPHA
    pMask:setBlendFunc(blend)
    pMask:setScale(self.cfg.size)
    local adjHeight = 0
    if self.cfg.uiType == 1 then
        adjHeight = -10 * self.cfg.size
    end
    pMask:setPosition(ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2 + adjHeight))
    pMask:setAnchorPoint(ccp(0.5, 0.5))

    self.m_pTarget:clear(0,0,0,0.5)
    self.m_pTarget:begin()
    pMask:visit()
    self.m_pTarget:endToLua()
end

function GuideMain:removeUI()
	self.super.removeUI(self)
end

function GuideMain:onClose()
    self.panel_base:setTouchEnabled(false)
end

function GuideMain:getFrameImgPath()
    return "ui/guide/frame_" ..self.cfg.uiType ..".png"
end

function GuideMain:getMaskImgPath()
    return "ui/guide/mask_" ..self.cfg.uiType ..".png"
end

return GuideMain;
