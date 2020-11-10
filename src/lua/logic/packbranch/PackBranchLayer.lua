
local PackBranchLayer = class("PackBranchLayer", BaseLayer)

function PackBranchLayer:ctor( )
    self.super.ctor(self)
    self.strCfg = require("lua.table.String" ..GAME_LANGUAGE_VAR)
    self:init("lua.uiconfig.common.FirstExtAssetsDownLayer")

    TFAssetsManager:init(0)
    TFAssetsManager:runManager()
end

function PackBranchLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.label_title = TFDirector:getChildByPath(ui,"label_title")
    self.label_title:setSystemFontText(self.strCfg[190000138].text)

    local img_bg = TFDirector:getChildByPath(ui,"img_bg")
    local path,desc = Utils:randomAD(3);
    img_bg:setTexture(path);
end

function PackBranchLayer:registerEvents()
    EventMgr:addEventListener(self, EV_EXT_ASSET_DOWNLOAD_EXTLIST, handler(self.downLoadExtListFileSuc, self))
end

function PackBranchLayer:removeEvents()
    
end

function PackBranchLayer:onShow()
    self.super.onShow(self)

    if EX_ASSETS_ENABLE ~= true then
        DelayCall(function()
            restartLuaEngine("checkPackBranchComplte")
        end,1)
        return
    end

    if not(TFAssetsManager:getRemoteListDict() == nil) then
        self:downLoadExtListFileSuc()
    end
end

function PackBranchLayer:onExit()
 
end

function PackBranchLayer:dispose()
  
end

function PackBranchLayer:downLoadExtListFileSuc()

    --官网3，亚马逊4，谷歌小包5 ，华为小包 6

    --非小包走这里
    if EX_ASSETS_ENABLE ~= true then
        restartLuaEngine("checkPackBranchComplte")
        return
    end
    
    --官网小包走这里
    if HeitaoSdk and (tonumber(HeitaoSdk.getplatformId()) == 3 or  tonumber(HeitaoSdk.getplatformId()) == 6) then
        restartLuaEngine("checkPackBranchComplte")
        return 
    end

    --谷歌小包逻辑走这里
    if HeitaoSdk and (tonumber(HeitaoSdk.getplatformId()) == 5 or tonumber(HeitaoSdk.getplatformId()) == 4 ) then
        local checkExtId = TFAssetsManager:getCheckInfo(12)
        if checkExtId then
            TFAssetsManager:downloadAssetsOfFunc(checkExtId, function()
                restartLuaEngine("checkPackBranchComplte")
            end, false)
        end
        return 
    end
end

return PackBranchLayer