
local PackBranchLayer = class("PackBranchLayer", BaseLayer)

function PackBranchLayer:ctor( )
    self.super.ctor(self)
    self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
    self:init("lua.uiconfig.common.FirstExtAssetsDownLayer")

    TFAssetsManager:init(0)
    TFAssetsManager:runManager()

    self.firstShow = true
end

function PackBranchLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.label_title = TFDirector:getChildByPath(ui,"label_title")
    self.label_title:setText(self.strCfg[190000138].text)

    local img_bg = TFDirector:getChildByPath(ui,"img_bg")
    local path,desc = Utils:randomAD(3)
    img_bg:setTexture(path)

    local pDirector = CCDirector:sharedDirector()
    local frameSize = pDirector:getOpenGLView():getFrameSize()
    local baseSize = CCSize(1136 , 640)
    local realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height)

    local size = img_bg:getSize();
    if realSize.width > 1386 and size.width == 1386 and size.height == 640 then
        img_bg:setSize(realSize)
    elseif realSize.width > 1386 and size.width == 1386 then
        img_bg:setSize(CCSizeMake(realSize.width, size.height))
    end
end

function PackBranchLayer:registerEvents()
    if EX_ASSETS_ENABLE then
        EventMgr:addEventListener(self, EV_EXT_ASSET_DOWNLOAD_EXTLIST, handler(self.downLoadExtListFileSuc, self))
    end
end

function PackBranchLayer:removeEvents()
    
end

function PackBranchLayer:onShow()
    self.super.onShow(self)

    if not self.firstShow then return end
    self.firstShow = false

    if EX_ASSETS_ENABLE then return end
    DelayCall(function()
        restartLuaEngine("checkPackBranchComplte")
    end,1)
end

function PackBranchLayer:onExit()
 
end

function PackBranchLayer:dispose()
  
end

--[[
    根据语言获得小包资源配置ID
]]
function PackBranchLayer:getFuncIDByLangCode(langCode)
    local funcID = 46
    if (langCode == cc.SIMPLIFIED_CHINESE) then
        funcID = 41
    elseif (langCode == cc.GERMAN) then
        funcID = 42
    elseif (langCode == cc.SPANISH) then
        funcID = 43
    elseif (langCode == cc.FRENCH) then
        funcID = 44
    elseif (langCode == cc.INDONESIAN) then
        funcID = 45
    elseif (langCode == cc.ENGLISH) then
        funcID = 46
    elseif (langCode == cc.KOREAN) then
        funcID = 47
    elseif (langCode == cc.THAI) then
        funcID = 48
    elseif (langCode == cc.TRADITIONAL_CHINESE) then
        funcID = 49
    end
    return funcID
end

function PackBranchLayer:downLoadExtListFileSuc()
    --官网3，亚马逊4，谷歌小包5 ，华为小包 6
    if HeitaoSdk then
        local checkExtId = self:getFuncIDByLangCode(TFLanguageMgr:getUsingLanguage())
        if (checkExtId) then
            TFAssetsManager:downloadAssetsOfFunc(checkExtId, function()
                restartLuaEngine("checkPackBranchComplte")
            end, false)
        end
        return 
    end
end

return PackBranchLayer