
local UnZipFileLayer = class("UnZipFileLayer", BaseLayer)

function UnZipFileLayer:ctor( callBack )
    self.super.ctor(self)
    self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
    self:init("lua.uiconfig.common.unZipFileLayer")
    self.callBack = callBack
end

function UnZipFileLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.label_title = TFDirector:getChildByPath(ui,"label_title")
    self.label_title:setText("")

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

    self:startUnCompressAwb()
end

function UnZipFileLayer:registerEvents()
    self.super.registerEvents(self)
end

function UnZipFileLayer:removeEvents()
    self.super.removeEvents(self)
    self:stopTimer()
end

function UnZipFileLayer:onShow()
    self.super.onShow(self)
end

function UnZipFileLayer:onExit()
    self:stopTimer()
end

function UnZipFileLayer:dispose()
    self:stopTimer()
end

function UnZipFileLayer:unCompressAwbStart( allNum )
    local text = ""
    if self.strCfg[190000885] then
        text = self.strCfg[190000885].text
    else
        text = "no string id 190000885 "
    end
    self.label_title:setText(text .." (0/" ..allNum .. ")")
end

function UnZipFileLayer:unCompressAwbing( curNum, allNum)
    local text = ""
    if self.strCfg[190000885] then
        text = self.strCfg[190000885].text
    else
        text = "no string id 190000885 "
    end
    local remaindNum = (allNum - curNum) + 1
    self.label_title:setText(text .." (" ..remaindNum .."/" ..allNum ..")")
    self.loadingBgImg:show()
    self.processLoadingBar:show()
    self.processLoadingBar:setPercent(remaindNum/allNum*100)
end

function UnZipFileLayer:unCompressAwbFailed( )
    local text = ""
    if self.strCfg[190000886] then
        text = self.strCfg[190000886].text
    else
        text = "no string id 190000886 "
    end
    self.label_title:setText(text)
end

function UnZipFileLayer:unCompressAwbComplete( )
    local text = ""
    if self.strCfg[190000887] then
        text = self.strCfg[190000887].text
    else
        text = "no string id 190000887 "
    end
    self.label_title:setText(text)
end

function UnZipFileLayer:startUnCompressAwb( )
    if TFClientAwbBundle == nil then 
        if self.callBack then
            self.callBack() 
            AlertManager:closeLayer(self)
        end
        return
    end

    local downLoadedAwbFiles = TFAssetsManager:getDownLoadedAwbFiles()
    if #downLoadedAwbFiles <= 0 then 
        if self.callBack then
            self.callBack() 
            AlertManager:closeLayer(self)
        end
        return
    end
    local allNeedUnZipNum = #downLoadedAwbFiles
    self:unCompressAwbStart(allNeedUnZipNum)

    local status = 0
    local update = function( dt )
        if status == 0 then --开始解压
            status = 1
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
        elseif status == 2 then --解压完成
            self:unCompressAwbing(#downLoadedAwbFiles, allNeedUnZipNum)
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
            if self.callBack then self.callBack() end
            AlertManager:closeLayer(self)
        end
    end
    self:stopTimer()
    self:startTimer(update)
end

function UnZipFileLayer:startTimer( update )
    self:stopTimer()
    self.timer = TFDirector:addTimer(1000,-1,nil,function( )
        update()
    end)
end

function UnZipFileLayer:stopTimer( )
    if self.timer then 
        TFDirector:removeTimer(self.timer)
    end
    self.timer = nil
end


return UnZipFileLayer