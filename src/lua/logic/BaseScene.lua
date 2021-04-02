--[[
    场景基础类  处理场景切换时lua资源的释放

    --By: haidong.gan
    --2013/11/11
]]

local BaseScene = class("BaseScene", function(isPhysics)
    if isPhysics then
        return CCScene:createWithPhysics() 
    else
        return CCScene:create();
    end
end)

-- 构造方法
function BaseScene:ctor(data)
    self.data            = data;
    self.mainLayer       = TFLayer:create();
    self.baseLayer       = BaseLayer:new();

    self.sceneEnterEventFunc  = function()
        self:onEnter();
        AlertManager:onEnter();
        LoadingLayer:onEnter();
    end;
    self:addMEListener(TFWIDGET_AFTER_ENTER, self.sceneEnterEventFunc);

    self.sceneExitEventFunc  = function()
        self:onExit();
        AlertManager:onExit();
    end;
    self:addMEListener(TFWIDGET_EXIT, self.sceneExitEventFunc);


    self:addChild(self.mainLayer);
    self.mainLayer:addChild(self.baseLayer);
    self:addTouchEffectLayer()

    self:updateUIUserInterfaceStyle()
end

function BaseScene:updateUIUserInterfaceStyle( )
    -- body
    if self.darkPanel then   
        self.darkPanel:removeFromParent()
        self.darkPanel = nil
    end

    if SettingDataMgr:getDarkModel() == 3 then return end--长关
    if (HeitaoSdk and HeitaoSdk.getUIUserInterfaceStyleDark() == "1") or SettingDataMgr:getDarkModel() == 2 then
        self.darkPanel = TFPanel:create()
        self.darkPanel:setSize(GameConfig.WS)
        self.darkPanel:setTouchEnabled(false)
        self.darkPanel:setBackGroundColorType(TF_LAYOUT_COLOR_SOLID)
        self.darkPanel:setBackGroundColorOpacity(150)
        self.darkPanel:setBackGroundColor(ccc3(0, 0, 0))
        self:addChild(self.darkPanel, 1000)
    end
end

function BaseScene:addTouchEffectLayer()
    if self:getChildByName("TouchEffectLayer") == nil then
        local touchLayer =  TFLayer:create()
        touchLayer:setTouchEnabled(true)
        touchLayer:setSwallowTouch(false)
        touchLayer:setName("TouchEffectLayer")
        touchLayer:setZOrder(99999)
        touchLayer:setSize(GameConfig.WS);
        self:addChild(touchLayer)

        local effectParticle = TFParticle:create("particles/flower.plist")

        if effectParticle ~= nil then
            effectParticle:setVisible(true)
            effectParticle:stopSystem()
            touchLayer.effectParticle = effectParticle
            touchLayer:addChild(effectParticle)
        else
            return
        end
        local touchBegan = function( sender )
            if TFDirectorModel.bPause == true then
                if sender.effectParticle:isVisible() then
                    sender.effectParticle:setVisible(false)
                end
                return
            end

            local pos = sender:getTouchStartPos()
            sender.effectParticle:setVisible(true)
            sender.effectParticle:setPosition(pos)
            sender.effectParticle:resetSystem();
        end
        touchLayer:addMEListener(TFWIDGET_TOUCHBEGAN, touchBegan);

        local touchMove = function( sender )
            if TFDirectorModel.bPause == true then
                if sender.effectParticle:isVisible() then
                    sender.effectParticle:setVisible(false)
                end
                return
            end

            local pos = sender:getTouchMovePos()
            sender.effectParticle:setPosition(pos)
        end

        touchLayer:addMEListener(TFWIDGET_TOUCHMOVED, touchMove);

        local touchEnd = function( sender )
            if TFDirectorModel.bPause == true then
                if sender.effectParticle:isVisible() then
                    sender.effectParticle:setVisible(false)
                end
                return
            end

            local pos = sender:getTouchMovePos()
            sender.effectParticle:setVisible(true)
            sender.effectParticle:setPosition(pos)
            sender.effectParticle:stopSystem()
        end

        touchLayer:addMEListener(TFWIDGET_TOUCHENDED, touchEnd);
    end
end

-- 构造方法之后调用
function BaseScene:enter()
    self.baseLayer:enter();
end

-- 每次c++调用onEnter之后调用
function BaseScene:onEnter()
    self.baseLayer:onEnter();
end

-- 每次c++调用onExit之后调用
function BaseScene:onExit()
    if self.baseLayer then
        self.baseLayer:onExit()
    end
end

function BaseScene:onShow()
    self.baseLayer:onShow();
end

-- 添加子panel
function BaseScene:addLayer(layer, zorder)
    self.baseLayer:addLayer(layer, zorder);
end

-- 删除子panel
function BaseScene:removeLayer(layer, isDispose)
    self.baseLayer:removeLayer(layer, isDispose);
end

function BaseScene:getBaseLayer()
    return self.baseLayer;
end
function BaseScene:getButtomLayer()
    if self.baseLayer ~= nil then
        return self.baseLayer.childArr:front()
    end
end
function BaseScene:getTopLayer()
    if self.baseLayer == nil then
        return nil
    end

    local index = self.baseLayer.childArr:length()
    while index >= 1 do
        local topLayer = self.baseLayer.childArr:objectAt(index)
        local filterList = {
            "ToastMessage",
            "NotifyMessageLayer",
            "LoadingLayer",
            "ToastPowerChange",
            "GuideView"
        }

        if topLayer ~= nil and topLayer.__cname ~= nil then
            local bcheck = false
            for k,v in pairs(filterList) do
                if topLayer.__cname == v then
                     bcheck = true
                     break
                end
            end
            if bcheck == false then
                return topLayer
            end
            index = index - 1
        else
            index = index - 1
        end
    end
    return nil
end

-- 场景销毁时调用（replace or pop）
function BaseScene:leave(...)
    self:onExit()
    AlertManager:closeAllAtCurrentScene();
    LoadingLayer:clearForCuurentScene();
    self:unregisterScriptHandler();
    self.sceneEventFunc = nil;
    if self.baseLayer then
        self.baseLayer:dispose();
    end

    self.baseLayer   = nil;

    self.data        = nil;
    self.mainLayer   = nil;
    if self.testView then
        self.testView:removeAll()
    end
end

function BaseScene:onRunning()

end

function BaseScene:onKeyBack()

end

return BaseScene;
