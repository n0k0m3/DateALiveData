local ExtAssetsDownloadView = class("ExtAssetsDownloadView",BaseLayer)
local asserManager = import('LuaScript.TFAssetsManager')
function ExtAssetsDownloadView:ctor()
	self.super.ctor(self)
	self:init("lua.uiconfig.common.extAssetsDownloadView")
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
end

function ExtAssetsDownloadView:registerEvents()
	EventMgr:addEventListener(self, EV_EXT_ASSET_DOWNLOAD_VIEW_CLOSE, handler(self.onCloseUI, self))
	self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))
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
	local currentScene = Public:currentScene()
    if currentScene.__cname == "LoginScene" then
    	self:dispose()
    	self:removeFromParent()
    else
    	AlertManager:closeLayer(self)
    end
end

return ExtAssetsDownloadView