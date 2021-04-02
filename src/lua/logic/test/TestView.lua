
local TestView = class("TestView", BaseLayer)

function TestView:ctor(...)
    self.super.ctor(self, ...)
    self:init("lua.uiconfig.test.testView")
end

function TestView:initUI(ui)
    self.super.initUI(self,ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Label_fps_value = TFDirector:getChildByPath(ui, "Label_fps_value")
    self.Label_sys_name_value = TFDirector:getChildByPath(ui, "Label_sys_name_value")
    self.Label_textureCache_value = TFDirector:getChildByPath(ui, "Label_textureCache_value")
    self.Label_texture_count_value = TFDirector:getChildByPath(ui, "Label_texture_count_value")
    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")
    self:refreshView()
end

function TestView:refreshView()
    self.Label_sys_name_value:setString(TFDeviceInfo:getSystemVersion() or "win32")
    local mpfCnt = me.Director:getAnimationInterval()
    local nFPS = 0
    local function updateTexture()
        local keys = me.TextureCache:textureKeys()
        local nLen = keys:size()

        local nUsed = 0
        local nVisited = 0
        local nMem = 0
        local nUsedMem = 0
        local nVisitedMem = 0
        local newVersion = false
        if Texture2D.getBitsPerPixelForFormat then 
            newVersion = true
        end 
        for i = 0, nLen - 1 do 
            local name = keys:at(i)
            local tex = me.TextureCache:textureForKey(name:getCString())
            local bpp = newVersion and tex:getBitsPerPixelForFormat() or tex:bitsPerPixelForFormat()
            local bytes = tex:getPixelsWide() * tex:getPixelsHigh() * bpp / 8 / 1024
            nMem = nMem + bytes

            local isVisiting = true
            if tex.isVisiting then 
                isVisiting = tex:isVisiting()
            else 
                isVisiting = tex:retainCount() > 1
            end

            if isVisiting then 
                nVisited = nVisited + 1
                nVisitedMem = nVisitedMem + bytes
            end

            if tex:retainCount() > 1 then 
                nUsed = nUsed + 1 
                nUsedMem = nUsedMem + bytes
            end
        end
        self.Label_fps_value:setString(string.format('%.1f/%.3f', nFPS, mpfCnt))
        self.Label_textureCache_value:setString(string.format("%.2fM", nUsedMem/1024))
        self.Label_texture_count_value:setString(string.format('%d', nUsed))
    end

    local nFrameRate = 0
    self.nDebugUpdateTID = TFDirector:addTimer(1000, -1, nil, function(dt)
        updateTexture()
    end)

    local nFrameRate = 0
    local nFrameDelta = 0
    self.nDebugFrameTID = TFDirector:addTimer(0, -1, nil, function(dt)
        nFrameRate = nFrameRate + 1
        nFrameDelta = nFrameDelta + dt
        if nFrameDelta > 0.2 then 
            nFPS = nFrameRate / nFrameDelta
            nFrameRate = 0
            nFrameDelta = 0
        end
    end)
end

function TestView:registerEvents()
    self.Button_close:onClick(function()
        self:removeAll()
        self:setVisible(false)
    end)
end

function TestView:removeAll()
    if self.nDebugUpdateTID then
        TFDirector:removeTimer(self.nDebugUpdateTID)
        TFDirector:removeTimer(self.nDebugFrameTID)
        self.nDebugUpdateTID = nil
        self.nDebugFrameTID = nil
    end
end

return TestView
