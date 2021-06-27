local ExtAssetsDownloadView = class("ExtAssetsDownloadView",BaseLayer)
local asserManager = import('LuaScript.TFAssetsManager')
function ExtAssetsDownloadView:ctor()
	self.super.ctor(self)
	self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
	self:init("lua.uiconfig.common.extAssetsDownloadView")

	self:onEnterSend()
end

function ExtAssetsDownloadView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = TFDirector:getChildByPath(ui,"Panel_root")
	local img_bg = TFDirector:getChildByPath(self.root_panel,"Image_bg")
	local path,desc = Utils:randomAD(3);
	img_bg:setTexture(path);
	
	local pDirector = CCDirector:sharedDirector();
    local frameSize = pDirector:getOpenGLView():getFrameSize();
    local baseSize = CCSize(1136 , 640);
    self.realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);
	local size = img_bg:getSize();
    if self.realSize.width > 1386 and size.width == 1386 and size.height == 640 then
        img_bg:setSize(self.realSize)
    elseif self.realSize.width > 1386 and size.width == 1386 then
        img_bg:setSize(CCSizeMake(self.realSize.width,size.height))
    end

	self.loadingbar = TFDirector:getChildByPath(self.root_panel,"LoadingBar_process")
	self.txt_speed = TFDirector:getChildByPath(self.root_panel,"Label_speed")
	self.txt_fileSize = TFDirector:getChildByPath(self.root_panel,"Label_filesize")
	self.tipLabel = TFDirector:getChildByPath(self.root_panel,"Label_title")
	self.tipLabel:setText(self.strCfg[190000146].text)
	self.closed = true
end

function ExtAssetsDownloadView:onShow()
	self:onEnterSend()
end

function ExtAssetsDownloadView:onEnterSend()
	if CommonManager:getConnectionStatus() == true then
		TFDirector:send(c2s.SHARE_REQ_INTO_PANEL, {999})
	end
end

function ExtAssetsDownloadView:registerEvents()
	EventMgr:addEventListener(self, EV_RECONECT_EVENT, handler(self.onReconnect, self))
	EventMgr:addEventListener(self, EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE, handler(self.onCloseUI, self))
	self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
end

function ExtAssetsDownloadView:onReconnect()
	self:onEnterSend()
end

function ExtAssetsDownloadView:update(target , dt)
	local downloadInfo = asserManager:getDownloading()
	self.txt_speed:setString(self:transNetSpeed(downloadInfo.speed))
	local totalsize = downloadInfo.totalsize
	local curSize = downloadInfo.completeSize + downloadInfo.cursize
	local totalSizeStr = TFAssetsManager:tranFileSize(totalsize)
	local curSizeStr = TFAssetsManager:tranFileSize(curSize)
	self.txt_fileSize:setString(curSizeStr.." / "..totalSizeStr)
	self.loadingbar:setPercent(curSize/totalsize *100)

	self.tipLabel:setText(self.strCfg[190000146].text)
	self.tipLabel:show()
	self.txt_fileSize:show()
	self.txt_speed:show()
end

function ExtAssetsDownloadView:transNetSpeed(speed)
	local speedstr = "0b/s"
	if speed < 1024 then
		speedstr = string.format("%.2fkb/s",speed)
	else
		speedstr = string.format("%.2fMb/s",speed/1024)
	end
	return speedstr
end

function ExtAssetsDownloadView:unCompressAwbing( )
	self.tipLabel:setText("资源解压中，首次解压耗时较久，请耐心等待，中途请勿退出游戏")
	--self.tipLabel:setText(self.strCfg[190000885].text)
	self.tipLabel:show()
	self.txt_fileSize:hide()
	self.txt_speed:hide()
end

function ExtAssetsDownloadView:unCompressAwbFailed( )
	--self.tipLabel:setText(self.strCfg[190000886].text)
	self.tipLabel:setText("解压失败，请重启游戏")
	self.tipLabel:show()
	self.txt_fileSize:hide()
	self.txt_speed:hide()
end

function ExtAssetsDownloadView:unCompressAwbComplete( )
	--self.tipLabel:setText(self.strCfg[190000887].text)
	self.tipLabel:setText("解压完成")
	self.tipLabel:show()
	self.txt_fileSize:hide()
	self.txt_speed:hide()
end

function ExtAssetsDownloadView:onCloseUI()
	if not self.closed  then
		return
	end
	self.closed = false
	self:removeMEListener(TFWIDGET_ENTERFRAME)
	EventMgr:removeEventListenerByTarget(self)

	self:startUnCompressAwb(function( )
		local currentScene = Public:currentScene()
	    if currentScene.__cname == "LoginScene" then
	    	self:dispose()
	    	self:removeFromParent()
	    else
	    	AlertManager:closeLayer(self)
	    end
	end)
end

function ExtAssetsDownloadView:removeUI()
	self.super.removeUI(self)
	if CommonManager:getConnectionStatus() == true then
		TFDirector:send(c2s.SHARE_REQ_INTO_PANEL, {1000})
	end
	self:stopTimer()
end

function ExtAssetsDownloadView:startUnCompressAwb( callBack )
	if TFClientAwbBundle == nil then 
		if callBack then callBack() end
		return
	end
	local downLoadedAwbFiles = TFAssetsManager:getDownLoadedAwbFiles()
	if #downLoadedAwbFiles <= 0 then 
		if callBack then callBack() end
		return
	end

    local status = 0
	local update = function( dt )
		if status == 0 then --开始解压
			status = 1
			self:unCompressAwbing()

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

function ExtAssetsDownloadView:startTimer( update )
	self:stopTimer()
	self.timer = TFDirector:addTimer(1000,-1,nil,function( )
        update()
    end)
end

function ExtAssetsDownloadView:stopTimer( )
	if self.timer then 
    	TFDirector:removeTimer(self.timer)
    end
    self.timer = nil
end


return ExtAssetsDownloadView