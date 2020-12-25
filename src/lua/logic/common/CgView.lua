local CgView = class("CgView",BaseLayer)

function CgView:initData(id,bgPath,islockTouch,closeListener,isTouchClose,finishCallback)
    self.id = id
    self.bgPath = bgPath
    self.islockTouch = islockTouch or false
    self.closeListener = closeListener
    self.isTouchClose = isTouchClose or false
    self.finishCallback = finishCallback
    self.isOver = false
    print("self.id ",self.id)
    print("self.bgPath ",self.bgPath)
    print("self.islockTouch ",self.islockTouch)
end

function CgView:ctor(id,bgPath,islockTouch,closeListener,isTouchClose,finishCallback)
    self.super.ctor(self)

    self:initData(id,bgPath,islockTouch,closeListener,isTouchClose,finishCallback)

    self:init("lua.uiconfig.common.cgView")
end

function CgView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Panel_base = TFDirector:getChildByPath(ui,"Panel_base")

    self.Image_bg = TFDirector:getChildByPath(self.Panel_base,"Image_bg")
    self.Panel_lockTouch = TFDirector:getChildByPath(self.Panel_base,"Panel_lockTouch")

    self:refreshUI()
    self:playEffect()

    self:initSkipBtn()

    local danmuId = Utils:getDanmuId(EC_DanmuType.CG,self.id)
    if danmuId then
        local param = {
            id = danmuId,
            offset = 60,
            danmuHeight = 580,
            autoRun = true,
            rowNum = 8
        }
        self.danmuMark = Utils:createDanmuMark(param)
        self.danmuMark:setZOrder(2)
        self:addChild(self.danmuMark)
    end
end

function CgView:initSkipBtn()
    if not self.islockTouch then
        return
    end
    self.skipBtn = TFImage:create("ui/dating/skipVideo.png")
    self.skipBtn:setAnchorPoint(ccp(1 , 0.5))
    self.skipBtn:Pos(self.Panel_base:Size().width/2 + GameConfig.WS.width/2,30)
    self:addChild(self.skipBtn, 100)
    self.skipBtn:Touchable(true)
    self.skipBtn:onClick(function()
        self.skipBtn:Touchable(false)
        self:removeFromParent()
    end)
    self.skipBtn:hide()
end

function CgView:refreshUI()
    self.Image_bg:setTexture(self.bgPath)
    self:setSize(GameConfig.WS)
    self.Panel_lockTouch:Touchable(self.islockTouch)
end

function CgView:playEffect()
    local callBack = function()
            self.isOver = true
            if self.finishCallback then
                self.finishCallback()
            end
        end

    if self.cgAnimation then
        self.cgAnimation:free()
    end
    self.cgAnimation = require("lua.logic.common.CgAnimation"):new(self.Panel_base,self.Image_bg,self.id)
    self.cgAnimation:start(callBack)
end

function CgView:stopEffect()
    self.cgAnimation:stop()
end

function CgView:registerEvents()
    self:addMEListener(TFWIDGET_EXIT, handler(self._onExit, self))
    self.Panel_lockTouch:onClick(function()
            if self.skipBtn then
                self.skipBtn:show()
            end
            if self.isTouchClose and self.isOver then
                self:removeFromParent()
            end
        end)
end

function CgView:_onExit()
    self:stopEffect()
    print("stopEffect")
    if self.closeListener then
        print("closeListener")
        self.closeListener()
    end

    if self.danmuMark then
        self.danmuMark:removeEvents()
    end

    me.TextureCache:removeUnusedTextures()
    SpineCache:getInstance():clearUnused()
end

return CgView