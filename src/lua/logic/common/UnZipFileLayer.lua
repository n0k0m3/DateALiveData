
local UnZipFileLayer = class("UnZipFileLayer", BaseLayer)

function UnZipFileLayer:ctor( callBack )
    self.super.ctor(self)
    self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
    self:init("lua.uiconfig.common.unZipFileLayer")
    self.callBack = callBack
    self.status = 0
    self.downLoadedAwbFiles = {}
    self.allNeedUnZipNum = 0
end

function UnZipFileLayer:initUI(ui)
    self.super.initUI(self, ui)

    self.label_title = TFDirector:getChildByPath(ui,"label_title")
    local text = ""
    if self.strCfg[190000885] then
        text = self.strCfg[190000885].text
    else
        text = "no string id 190000885 "
    end
    self.label_title:setText(text)

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

    local update = function( dt )
        if self.status == 0 then
            self.downLoadedAwbFiles = TFAssetsManager:getDownLoadedAwbFiles()
            if #self.downLoadedAwbFiles <= 0 then 
                self.status = 5
            else
                self.allNeedUnZipNum = #self.downLoadedAwbFiles
                self.status = 1
            end
            self:unCompressAwbStart(#self.downLoadedAwbFiles)
        elseif self.status == 1 then --开始解压
            self.status = 2
            local awbId = self.downLoadedAwbFiles[1]
            if TFClientAwbBundle and awbId then
                TFClientAwbBundle:defaultAwbBundle():setUnzipAwbCompleteHandler(function( filePath )
                    print("TFClientAwbBundle unzipFiles  success!!!! ")
                    TFClientAwbBundle:defaultAwbBundle():removeUnzipAwbCompleteHandler()
                    TFClientAwbBundle:defaultAwbBundle():removeUnZipAwbFailedHandler()
                    if TFFileUtil:existFile(filePath) then
                        os.remove(filePath)
                    end
                    self.status = 3
                end)
                TFClientAwbBundle:defaultAwbBundle():setUnZipAwbFailedHandler(function( status )
                    print("TFClientAwbBundle unzipFiles  failed!!!! ")
                    TFClientAwbBundle:defaultAwbBundle():removeUnzipAwbCompleteHandler()
                    TFClientAwbBundle:defaultAwbBundle():removeUnZipAwbFailedHandler()
                    self.status = 4
                end)
                TFClientAwbBundle:defaultAwbBundle():unzipFiles(awbId ..".awb")
            end
        elseif self.status == 2 then --解压进行中
        elseif self.status == 3 then --解压完成
            self:unCompressAwbing(#self.downLoadedAwbFiles, self.allNeedUnZipNum)
            table.remove(self.downLoadedAwbFiles, 1)
            if #self.downLoadedAwbFiles <= 0 then
                self.status = 5 
            else
                self.status = 1
            end
        elseif self.status == 4 then
            self:unCompressAwbFailed( )
            self.status = 6
        elseif self.status == 5 then --解压所有awb完成
            self:unCompressAwbComplete()
            self.status = 6
        elseif self.status == 6 then
            self.status = -100
            self:stopTimer()
            if self.callBack then self.callBack() end
            --self:dispose()
            --self:removeFromParent()
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