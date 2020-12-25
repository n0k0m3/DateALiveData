local json = require("LuaScript.extends.json")
local DownLoadingTips = class("DownLoadingTips", BaseLayer)

function DownLoadingTips:ctor(data)
    self.super.ctor(self,data)
	self.strCfg = TFGlobalUtils:requireGlobalFile("lua.table.StartString")
    self.params = data;
    self:init("lua.uiconfig.loginScene.downLoadingTips")
end

function DownLoadingTips:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui
	DownLoadingTips.ui = ui

	self.tipTitleLabel = TFDirector:getChildByPath(ui,"Label_Title");
	self.tipTitleLabel:setText(self.strCfg[190000139].text)

	self.Label_englishName = TFDirector:getChildByPath(ui,"Label_englishName")
	self.Label_englishName:setText(self.strCfg[190000140].text)

	self.size_text	   	= TFDirector:getChildByPath(ui,"size_text");
	self.Button_ok		= TFDirector:getChildByPath(ui,"Button_ok");
	self.Button_close	= TFDirector:getChildByPath(ui,"Button_close");
	self.Panel_down		= TFDirector:getChildByPath(ui,"Panel_down");
	self.sizeTip_text	= TFDirector:getChildByPath(self.Panel_down,"text")
	self.sizeTip_text:setText(self.strCfg[190000143].text)
	self.Panel_error	= TFDirector:getChildByPath(ui,"Panel_error");
	self.Panel_errorTipLabel = TFDirector:getChildByPath(self.Panel_error,"text")
	self.Panel_errorTipLabel:setText(self.strCfg[190000145].text)

	self.text_version	= TFDirector:getChildByPath(ui,"text_version");
	self.text_version:setText(self.strCfg[190000144].text)
	
	local ScrollView_downLoadingTips	= TFDirector:getChildByPath(ui,"ScrollView_downLoadingTips");
	self.ListView_desc = UIListView:create(ScrollView_downLoadingTips)
    self.Label_updateItem = TFDirector:getChildByPath(ui, "Label_updateItem")

	self.Panel_down:setVisible(self.params._type == 1);
	self.Panel_error:setVisible(self.params._type ~= 1);

	self.Button_close:setGrayEnabled(true);

	if self.params._type == 1 then
		Utils:sendHttpLog("update_aquire_D")
		self.size_text:setText(self.params.sizeDesc);
		--local wifiType = TFDeviceInfo:getNetWorkType()
		local version = self.params.LatestVersion
		self.text_version:setText(string.format(self.strCfg[100000067].text, version))
		self:setUpdateText()
	else
		Utils:sendHttpLog("update_break_E")
		self.Button_ok:getChildByName("Label_downLoadingTips_1"):setText(self.strCfg[190000142].text);
		self.Button_close:getChildByName("Label_downLoadingTips_1"):setText(self.strCfg[190000141].text);
	end

	self.Button_ok:addMEListener(TFWIDGET_CLICK,function()
			self.params.callfunc();
			AlertManager:close();
		end) 

	self.Button_close:addMEListener(TFWIDGET_CLICK,function()
			me.Director:endToLua()
		end) 
	
end

function DownLoadingTips:setUpdateText()
	local content = self.params.Content
	local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_updateItem:clone():Show()
	Label_content:setDimensions(size.width, 0)
    Label_content:setText(content)
    self.ListView_desc:pushBackCustomItem(Label_content)
end

return DownLoadingTips;
