
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

    self.loadingBgImg = TFDirector:getChildByPath(ui,"img_loadingbg") 
    self.loadingBgImg:hide()

    self.processLoadingBar = TFDirector:getChildByPath(ui,"loadingBar_process") 
    self.processLoadingBar:hide()
end

function PackBranchLayer:registerEvents()
    if EX_ASSETS_ENABLE then
        EventMgr:addEventListener(self, EV_EXT_ASSET_DOWNLOAD_EXTLIST, handler(self.downLoadExtListFileSuc, self))
    end
end

function PackBranchLayer:removeEvents()
    self:stopTimer()
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
    self:stopTimer()
end

function PackBranchLayer:dispose()
    self:stopTimer()
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
                self:startUnCompressAwb(function(  )
                    restartLuaEngine("checkPackBranchComplte")
                end)
            end, false)
        end
        return 
    end
end

function PackBranchLayer:unCompressAwbStart( )
    self.label_title:setText("资源解压中，首次解压耗时较久，请耐心等待，中途请勿退出游戏")
end

function PackBranchLayer:unCompressAwbing( curNum, allNum)
    --self.label_title:setText(self.strCfg[190000885].text)
    local remaindNum = (allNum - curNum) + 1
    self.label_title:setText(remaindNum .."/" ..allNum .."   资源解压中，首次解压耗时较久，请耐心等待，中途请勿退出游戏")
    self.loadingBgImg:show()
    self.processLoadingBar:show()
    self.processLoadingBar:setPercent(remaindNum/allNum*100)
end

function PackBranchLayer:unCompressAwbFailed( )
    --self.label_title:setText(self.strCfg[190000886].text)
    self.label_title:setText("解压失败，请重启游戏")
end

function PackBranchLayer:unCompressAwbComplete( )
    --self.label_title:setText(self.strCfg[190000887].text)
    self.label_title:setText("解压完成")
end

function PackBranchLayer:startUnCompressAwb( callBack )
    if TFClientAwbBundle == nil then 
        if callBack then callBack() end
        return
    end
    local downLoadedAwbFiles = TFAssetsManager:getDownLoadedAwbFiles()
    if #downLoadedAwbFiles <= 0 then 
        if callBack then callBack() end
        return
    end
    local allNeedUnZipNum = #downLoadedAwbFiles

    local status = 0
    local update = function( dt )
        if status == 0 then --开始解压
            status = 1
            self:unCompressAwbStart()

            local awbId = downLoadedAwbFiles[1]
            if TFClientAwbBundle and awbId then
                TFClientAwbBundle:defaultAwbBundle():setUnzipAwbCompleteHandler(function( filePath )
                    print("TFClientAwbBundle unzipFiles  success!!!! ")
                    TFClientAwbBundle:defaultAwbBundle():removeUnzipAwbCompleteHandler()
                    TFClientAwbBundle:defaultAwbBundle():removeUnZipAwbFailedHandler()
                    if TFFileUtil:existFile(filePath) then
                        os.remove(filePath)
                    end
                    status = 2
                end)
                TFClientAwbBundle:defaultAwbBundle():setUnZipAwbFailedHandler(function( status )
                    print("TFClientAwbBundle unzipFiles  failed!!!! ")
                    TFClientAwbBundle:defaultAwbBundle():removeUnzipAwbCompleteHandler()
                    TFClientAwbBundle:defaultAwbBundle():removeUnZipAwbFailedHandler()
                    status = 3
                end)
                TFClientAwbBundle:defaultAwbBundle():unzipFiles(awbId ..".awb")
            end
        elseif status == 1 then --解压进行中
            self:unCompressAwbing(#downLoadedAwbFiles, allNeedUnZipNum)
        elseif status == 2 then --解压完成
            table.remove(downLoadedAwbFiles, 1)
            if #downLoadedAwbFiles <= 0 then
                status = 4 
            else
                status = 0
            end
        elseif status == 3 then
            self:unCompressAwbFailed( )
            status = 5
        elseif status == 4 then --解压所有awb完成
            self:unCompressAwbComplete()
            status = 5
        elseif status == 5 then
            self:stopTimer()
            if callBack then callBack() end
        end
    end
    self:stopTimer()
    self:startTimer(update)
end

function PackBranchLayer:startTimer( update )
    self:stopTimer()
    self.timer = TFDirector:addTimer(1000,-1,nil,function( )
        update()
    end)
end

function PackBranchLayer:stopTimer( )
    if self.timer then 
        TFDirector:removeTimer(self.timer)
    end
    self.timer = nil
end


return PackBranchLayer