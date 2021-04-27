
--[[
    页面逻辑处理 基础类

    --By: haidong.gan
    --2013/11/11
]]

-- 生成创建场景方法
function CREATE_SCENE_FUN(classObj)
    function classObj:scene()
        local layer = classObj:new()
        local baseScene = BaseScene:new()
        baseScene:addLayer(layer)
        return baseScene
    end
end

-- 生成创建UI方法，注意：用此方法创建UI，logic无法保存
function CREATE_PANEL_FUN(classObj)
    function classObj:panel()
        local layer = classObj:new()
        return layer
    end
end

local BaseLayer = class("BaseLayer", function(...)
                            local layer = TFPanel:create()
                            layer:setName("BaseLayer")
                            layer:setSize(GameConfig.WS)
                            return layer
end)

local LayerCreatNum = 0

-- 构造方法
function BaseLayer:ctor(data)
    -- print("BaseLayer:ctor")
    self.data              = data
    self.childArr          = TFArray:new()
    self.LayerCreatIndex   = LayerCreatNum
    self.popAnim           = false
    self.rclosing          = false
    self.disposed          = true
    LayerCreatNum          = LayerCreatNum + 1

    local pDirector = CCDirector:sharedDirector();
    local frameSize = pDirector:getOpenGLView():getFrameSize();
    local baseSize = CCSize(1136 , 640);
    self.realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);

     -- 用于保存所有的UI对象
     self._ui                  = {}
     self.tempRepeatUINameDict = {}
end

-- 构造方法之后调用
function BaseLayer:enter()
    -- print("BaseLayer:enter")
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.enter, layer)
    end
end

-- 每次c++调用onEnter之后调用
function BaseLayer:onEnter()
    -- print("BaseLayer:onEnter")
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.onEnter, layer)
    end
end

-- 每次c++调用onExit之后调用
function BaseLayer:onExit()
    -- print("BaseLayer:onExit")
    self:removeEvents()
    self:__removeEvents()
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.onExit, layer)
    end
end

-- 每次AlertManager:show()之后调用；子弹窗关闭时调用；断线重连时调用
function BaseLayer:onShow()
    -- print("BaseLayer:onShow")
    self.rclosing = false
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.onShow, layer)
    end
    if self.topLayer then
        SafeAudioExchangePlay().playBGM(self, true)
    end
end

-- 断线重连时调用
function BaseLayer:reShow()
    -- print("BaseLayer:reShow")
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.reShow, layer)
    end
end

-- 每次AlertManager:clode()\AlertManager:hide()之后调用
function BaseLayer:onHide()
    -- print("BaseLayer:onHide")
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.onHide, layer)
    end
end

function BaseLayer:hideUIWidget( )
    -- body
    if self.ui then
        self.ui.saveBeforeHide = self.ui.saveBeforeHide or self.ui:isVisible()
        self.ui:hide()
    end
    for layer in self.childArr:iterator() do
        if layer.ui then
            layer.ui.saveBeforeHide = layer.ui.saveBeforeHide or layer.ui:isVisible()
            layer.ui:hide()
        end
    end
end

function BaseLayer:showUIWidget( )
    -- body
    if self.ui then
        if self.ui.saveBeforeHide then
            self.ui:show()
        end
    end
    for layer in self.childArr:iterator() do
        if layer.ui then
            if layer.ui.saveBeforeHide then
                layer.ui:show()
            end
        end
    end
end

-- 每次AlertManager:clode()之后调用
function BaseLayer:onClose()
    -- print("BaseLayer:onClose")
    self.rclosing = true
    for layer in self.childArr:iterator() do
        TFFunction.call(layer.onClose, layer)
    end
end

-- 添加子panel，同时保存panel的lua对象
function BaseLayer:addLayer(layer,zorder)
    -- print("BaseLayer:addLayer")
    local _zorder = zorder or 0;

    if layer.parentPanel then
        self:addChild(layer.parentPanel,_zorder);
    else
        self:addChild(layer,_zorder);
    end

    self.childArr:push(layer)
end

 --添加子panel到节点
function BaseLayer:addLayerToNode(layer,node,zorder)
    local _zorder = zorder or 0;
    if node then
        node:addChild(layer, _zorder)
        self.childArr:push(layer,_zorder);
    end
end

function BaseLayer:removeLayerFromNode(layer, node, isDispose)
    if isDispose == true or isDispose == nil then
        TFFunction.call(layer.dispose, layer)
    end

    EventMgr:removeEventListenerByTarget(layer)
    self.childArr:removeObject(layer)

    node:removeChild(layer, isDispose)
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused()
end

-- 删除子panel，同时销毁panel的lua对象
function BaseLayer:removeLayer(layer, isDispose)
    if isDispose == true or isDispose == nil then
        TFFunction.call(layer.dispose, layer)
    end

    self.childArr:removeObject(layer)

    if layer.parentPanel then
        self:removeChild(layer.parentPanel, isDispose)
    else
        self:removeChild(layer, isDispose)
    end
    me.TextureCache:removeUnusedTextures()
    TFDirector:clearMovieClipCache()
    me.FrameCache:removeUnusedSpriteFrames()
    SpineCache:getInstance():clearUnused()
end

-- 根据ui文件路径，初始化生成ui对象
function BaseLayer:init(uiPath)
    
    local ui = createUIByLuaNew(uiPath)
    self.isNeedPreprocesUI = true
    self:initUI(ui)
    self:registerEvents(ui)

    return self
end

-- 清理内存
function BaseLayer:dispose()
    -- print("BaseLayer dispose..")
    if not self.disposed then
        return
    end
    self.disposed = false
    self:__removeEvents()
    self:removeEvents()
    self:removeUI()

    for layer in self.childArr:iterator() do
        TFFunction.call(layer.dispose, layer)
    end
    self.childArr:clear()
end

function BaseLayer:initUI(ui)
    self.ui = ui
    self:addChild(ui)

    dump(self.__cname,"文件名")

    self.isNeedPreprocesUI = true
    if self.isNeedPreprocesUI then
        self:preprocessingUI()
        self.isNeedPreprocesUI = nil
    end
    --TOP
    if not TopDataMgr then
        return
    end
    local topBarFileName = self.topBarFileName or self.__cname
    if TopDataMgr:isShowTop(topBarFileName) then
        self.topLayer = require("lua.logic.common.TopBar"):new(TopDataMgr:getTopData(topBarFileName));
        self:addChild(self.topLayer,999);
        self.childArr:push(self.topLayer);
    end

    if TopDataMgr:isShowAnimBg(topBarFileName) then
        local Panel_animBg = TFDirector:getChildByPath(ui, "Panel_animBg")
        if Panel_animBg then
            local effect = SkeletonAnimation:create("effect/ui_bg/ui")
            effect:setAnimationFps(GameConfig.ANIM_FPS)
            effect:playByIndex(0, -1, -1, 1)
            Panel_animBg:addChild(effect)

            local framesize = me.EGLView:getFrameSize()
            local effectParticle = TFParticle:create("particles/jiemianlizi.plist")
            effectParticle:setPosition(-framesize.width * 0.5, -framesize.height * 0.5)
            Panel_animBg:addChild(effectParticle)
        end
    end


    self:ResolutionAdaptation()
end

--[[
    @desc: 设置启用启用预处理加载ui
]]
function BaseLayer:setUsepreProcesUI()
    self.isNeedPreprocesUI = true
end

--[[
    @desc: 预处理ui节点
]]
function BaseLayer:preprocessingUI()

    if self.__cname == "TopBar" then
        return
    end

    self:loadUIObjInTab(self.ui, self.ui)
    self:removeRepeatUIName()

    -- TODO (interface)
end

--[[
    @desc: 将所有的UI节点存放到self._ui
]]
function BaseLayer:loadUIObjInTab(parent, childNode)

    if nil == parent or nil == childNode then
        return
    end

    if parent ~= childNode then
        local objUIName = childNode:getName()
        if objUIName then
            if not self._ui[objUIName] then
                self._ui[objUIName] = childNode
            else
                if not self.tempRepeatUINameDict[objUIName] then
                    self.tempRepeatUINameDict[objUIName] = tostring(objUIName)
                end
            end
        end
    end

    local childs = childNode:getChildren()
    if #childs ~= 0 then
        for i, child in pairs(childs) do
            self:loadUIObjInTab(childNode, child)
        end
    end
end

--[[
    @desc: 移除重名的UI节点
]]
function BaseLayer:removeRepeatUIName()

    if next(self.tempRepeatUINameDict) == nil then
        return
    end
    -- dump(self.tempRepeatUINameDict)

    for _, uiName in pairs(self.tempRepeatUINameDict) do
        self._ui[uiName] = nil
    end
    self.tempRepeatUINameDict = nil
end

function BaseLayer:ResolutionAdaptation()
    local function __ResolutionAdaptation(node)
        local size = node:getSize();
        if self.realSize.width > 1386 and size.width == 1386 and size.height == 640 then
            node:setSize(self.realSize)
        elseif self.realSize.width > 1386 and size.width == 1386 then
            node:setSize(CCSizeMake(self.realSize.width,size.height))
        end

        local childs = node:getChildren()
        if #childs ~= 0 then
            for i, child in pairs(childs) do
                __ResolutionAdaptation(child)
            end
        end
    end

    __ResolutionAdaptation(self.ui)
end

function BaseLayer:setBackBtnCallback(call)
    if self.topLayer then
        self.topLayer:setBackBtnCallback(call);
    end
end

function BaseLayer:setMainBtnCallback(call)
    if self.topLayer then
        self.topLayer:setMainBtnCallback(call);
    end
end

function BaseLayer:setTopName(name)
    if self.topLayer then
        self.topLayer:setTopName(name);
    end
end 

function BaseLayer:removeUI()
    self.ui = nil
    self._ui = nil
end

function BaseLayer:registerEvents()

end

function BaseLayer:__removeEvents()
    EventMgr:removeEventListenerByTarget(self)
    for layer in self.childArr:iterator() do
        EventMgr:removeEventListenerByTarget(layer)
    end
end

function BaseLayer:removeEvents()

end

--显示顶部信息条，若以后存在不同类型增加枚举控制
function BaseLayer:showTopBar()
    if self.topLayer then
        self.topLayer:setVisible(true)
    end
end

function BaseLayer:hideTopBar()
    self.topLayer:setVisible(false)
end

function BaseLayer:showPopAnim(enable)
    self.popAnim = enable
end

function BaseLayer:addLockLayer()
    if not self.lockLayer then
        self.lockLayer = TFPanel:create()
        self.lockLayer:setSize(GameConfig.WS)
        self:addChild(self.lockLayer,1000)
        self.lockLayer:setTouchEnabled(true)
        self.lockLayer:setSwallowTouch(true)
    end
end

function BaseLayer:removeLockLayer()
    if self.lockLayer then
        self.lockLayer:removeFromParent()
        self.lockLayer = nil
    end
end

function BaseLayer:onKeyBack()

end

return BaseLayer
