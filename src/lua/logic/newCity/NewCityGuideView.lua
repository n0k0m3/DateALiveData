local NewCityGuideView = class("NewCityGuideView", BaseLayer)

function NewCityGuideView:ctor(widgttb, rectsize, touchCallBack)
    self.super.ctor(self)
    self:initData(widgttb, rectsize, touchCallBack)
    self:init("lua.uiconfig.newCity.newCityGuideView")
end

function NewCityGuideView:registerEvents()
    self.Button_skip:onClick(function()
        if self.touchCallBack then
            self.touchCallBack()
        end
        AlertManager:closeLayer(self)
    end)
end

function NewCityGuideView:onClose()
    self:stopAllActions()

    self.super.onClose(self)
end

function NewCityGuideView:initData(widgttb, rectsize, touchCallBack)
    self.widgttb = widgttb
    self.rectSize = rectsize
    self.touchCallBack = touchCallBack
end

function NewCityGuideView:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    --self.ui:Touchable(true)
    --self.ui:onClick(function()
    --    AlertManager:closeLayer(self)
    --end)

    self.Panel_touch = TFDirector:getChildByPath(ui, "Panel_touch")
    self.Image_arrow = TFDirector:getChildByPath(ui, "Image_arrow")

    self.Panel_skip = TFDirector:getChildByPath(ui, "Panel_skip")
    self.Button_skip = self.Panel_skip:getChild("Button_skip")

    self:showGuide()
end

function NewCityGuideView:showGuide()
    if self.rectSize then
        self.Panel_touch:setSize(self.rectSize)
    else
        local size = self.widgttb.node:getSize()
        self.Panel_touch:setSize(me.size(size.width*0.8, size.height*0.8))
    end

    local convertp = self.widgttb.convertp or me.p(0, 0)
    local wp = self.widgttb.node:convertToWorldSpace(convertp)
    local np = self.Panel_touch:getParent():convertToNodeSpace(wp)
    self.Panel_touch:setPosition(np)
    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:onClick(function()
        if self.touchCallBack then
            self.touchCallBack()
        end
        AlertManager:closeLayer(self)
    end)

    self.Image_arrow:stopAllActions()
    self.Image_arrow:setPosition(me.p(np.x, np.y + self.Panel_touch:getSize().height*0.2))
    local actions =
    {
        CCMoveBy:create(0.5, me.p(0, -20)),
        CCMoveBy:create(0.5, me.p(0, 20))
    }
    local move = CCRepeatForever:create(Sequence:create(actions))
    self.Image_arrow:runAction(move)

    self:stopAllActions()
    self:timeOut(function()
        Utils:openView("common.FunctionTipsView", {960010, 960011}, function()
            if not tolua.isnull(self) then
                self.Panel_skip:show()
            end
        end)
    end, 5.0)
end

function NewCityGuideView:specialKeyBackLogic( )
    return true
end

return NewCityGuideView