--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  全家福
* 
]]

local CollectFamilyLayer = class("CollectFamilyLayer", BaseLayer)

function CollectFamilyLayer:ctor( data )
    self.super.ctor(self, data)
    self:initData(data)
    self:init("lua.uiconfig.collect.collectFamilyLayer")
end

function CollectFamilyLayer:initData( data )
    self.isShowTopBar = false
end

function CollectFamilyLayer:initUI( ui )
	self.super.initUI(self, ui)
    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.animationPanel = TFDirector:getChildByPath(self.rootPanel, "panel_animation")

    self.shareBtn = TFDirector:getChildByPath(self.rootPanel, "btn_share")

    self.bg_bottom = TFDirector:getChildByPath(self.rootPanel , "img_bg_2")

    self.panel_touch = TFDirector:getChildByPath(self.rootPanel , "panel_touch")
    self.panel_touch:setSwallowTouch(false)
    self.panel_touch:setTouchEnabled(false)
     self.panel_touch:onClick(function( ... )
        self.isShowTopBar = not self.isShowTopBar
        self:playAction()
     end)

    self:updateUI()
    
end

function CollectFamilyLayer:playAction()
    if self.isShowTopBar == false then
        local act1 = CCMoveTo:create(0.6, ccp(self.topLayer:getPositionX(), -120))
        local act2 = CCCallFunc:create(function ( ... )
            self.panel_touch:setTouchEnabled(true)
        end)
        self.topLayer:runAction(CCSequence:create({act1 , act2} ))
        self.bg_bottom:runAction(CCMoveTo:create(0.6, ccp(0, -540)))
    else
        local act1 = CCMoveTo:create(0.5, ccp(self.topLayer:getPositionX(), -320))
        local act2 = CCCallFunc:create(function ( ... )
           self.panel_touch:setTouchEnabled(true)
        end)
        self.topLayer:runAction(CCSequence:create({act1 , act2} ))
        self.bg_bottom:runAction(CCMoveTo:create(0.5, ccp(0, -340)))
    end
    self.panel_touch:setTouchEnabled(false)
end

function CollectFamilyLayer:onShow( )
    self.super.onShow(self)
    if not self.first then
        self:playAction()
        self.first = true
    end
end

function CollectFamilyLayer:registerEvents( )
	self.super.registerEvents(self)

    self.shareBtn:onClick(function(sender)
        self.shareBtn:hide()
        self:timeOut(function()
           Utils:gameShare()
        end,1)
        self:timeOut(function()
            self.shareBtn:show()
            self.isShowTopBar = true
            self:playAction()
        end,2)

        self.isShowTopBar = false
        self:playAction()
    end)
end

function CollectFamilyLayer:removeEvents( )
    self.super.removeEvents(self)
end

function CollectFamilyLayer:updateUI( )
    local familyIdList = FamilyDataMgr:getFamilyaListId( )
    for i,_heroid in ipairs(familyIdList) do
        FamilyDataMgr:createAnimation(_heroid, self.animationPanel)     
    end

    self.shareBtn:show()
    if FamilyDataMgr:getIsFriendFamily() then
        self.shareBtn:hide()
    end
    

    -- local delayAni1 = DelayTime:create(0.03)
    -- local callFun1 = CallFunc:create(function()
    --     local heroid = familyList[1]
    --     local animation = self:createHeroModel(heroid, self.animationPanel, 0.3)
    --     animation:setPosition(pos[1])
    --     animation:setColor(ccc3(10,10,10))

    --     table.remove(familyList, 1)
    --     table.remove(pos, 1)
    -- end)
   
    -- local arr = {}
    -- table.insert(arr,callFun1)
    -- table.insert(arr,delayAni1)
    -- local seq = CCSequence:create(arr)                                            
    -- self:runAction(CCRepeat:create(seq, #familyList))   
end

return CollectFamilyLayer
