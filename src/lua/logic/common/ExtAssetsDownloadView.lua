local ExtAssetsDownloadView = class("ExtAssetsDownloadView",BaseLayer)
local asserManager = import('LuaScript.TFAssetsManager')
function ExtAssetsDownloadView:ctor()
	self.super.ctor(self)
	self.strCfg = require("lua.table.String" ..GAME_LANGUAGE_VAR)
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

	self.tipLabel:setSystemFontText(self.strCfg[190000146].text)
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
function ExtAssetsDownloadView:onCloseUI()
	EventMgr:removeEventListenerByTarget(self)
	local currentScene = Public:currentScene()
    if currentScene.__cname == "LoginScene" then
    	self:dispose()
    	self:removeFromParent()
    else
    	AlertManager:closeLayer(self)
    end
end

function ExtAssetsDownloadView:removeUI()
	self.super.removeUI(self)
	self:removeMEListener(TFWIDGET_ENTERFRAME)
	TFDirector:send(c2s.SHARE_REQ_INTO_PANEL, {1000})
end

return ExtAssetsDownloadView