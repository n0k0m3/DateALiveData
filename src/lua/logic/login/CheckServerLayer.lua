local CheckServerLayer = class("CheckServerLayer", BaseLayer)

--[[
    服务器枚举
]]
local Servers = {
    ENG = 1,
    GLOBAL = 2
}

--[[
    构造函数
]]
function CheckServerLayer:ctor(callback)
    CheckServerLayer.super.ctor(self)

    self:initData(callback)
    self:init("lua.uiconfig.loginScene.checkServerLayer")
end

--[[
    初始化数据
]]
function CheckServerLayer:initData(callback)
    self.onCallback = callback
end

--[[
    初始化视图
]]
function CheckServerLayer:initUI(ui)
    CheckServerLayer.super.initUI(self, ui)

    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_gray_mask = TFDirector:getChildByPath(Panel_root, "Panel_gray_mask")

    self.Label_title = TFDirector:getChildByPath(Panel_root, "Label_title")

    self.Button_language = TFDirector:getChildByPath(Panel_root, "Button_eng"):hide()
    self.Button_global = TFDirector:getChildByPath(Panel_root, "Button_global"):hide()

    self:updateView()
end

--[[
    更新视图
]]
function CheckServerLayer:updateView()
    local enums = TFLanguageMgr:getLanguages()

    local winSize = me.Director:getWinSize()
    local spx = winSize.width/2 - 150
    local spy = winSize.height/2 + 120

    for k, val in ipairs(enums) do
        local px = spx + (k - 1)%2 * 300
        local py = spy - math.floor((k - 1) / 2) * 80

        local button = self.Button_language:clone()
        button:setVisible(true)
        button:setPosition(px, py)
        self:addChild(button)

        self:updateButtonView(button, val)
    end
end

--[[
    更新按钮
]]
function CheckServerLayer:updateButtonView(button, val)
    local txtID = TFLanguageMgr:getLanguageTextId(val)

    local Label_name = TFDirector:getChildByPath(button, "Label_name")
    Label_name:setTextById(txtID)

    button:onClick(function() self:setLanguage(val) end)
end

--[[
    响应事件
]]
function CheckServerLayer:registerEvents()
    self.Panel_gray_mask:onClick(function()
        if (self.onCallback) then
            self.onCallback()
        end
    end)
end

--[[
    选择登录服务器
]]
function CheckServerLayer:setLanguage(val)
    -- TO DO 记录玩家的选择
    TFLanguageMgr:setUsingLanguage(val)

    -- 重启客户端
    TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})
    restartLuaEngine("")
end

return CheckServerLayer