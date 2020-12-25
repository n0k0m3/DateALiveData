--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
* 
]]
local ZnqHelpView = class("ZnqHelpView", BaseLayer)

function ZnqHelpView:ctor(...)
    self.super.ctor(self)
    self:init("lua.uiconfig.activity.znq_help")
end

function ZnqHelpView:initUI(ui)
	self.super.initUI(self,ui)
	self.pageView = TFDirector:getChildByPath(ui,"PageView_help")
	self.Button_left = TFDirector:getChildByPath(ui,"Button_left"):hide()
	self.Button_right = TFDirector:getChildByPath(ui,"Button_right"):show()

	--TODO CLOSE 暂时屏蔽帮助为只有4个 原来有6个
	for i = 1,4 do
		local panel = TFPanel:create()
		panel:setAnchorPoint(ccp(0.5,0.5))
		local image = TFImage:create("ui/activity/znq_yly/help/00"..i..".png")
		panel:addChild(image)
		self.pageView:addPage(panel)
	end
end

function ZnqHelpView:updateView( ... )
	-- body
   	local curPageIndex = self.pageView:getCurPageIndex()
   	local pageCount = self.pageView:getPageCount()
	self.Button_left:setVisible(pageCount > 0 and curPageIndex ~= 0)
	self.Button_right:setVisible(pageCount > 0 and curPageIndex ~= pageCount - 1)
end

function ZnqHelpView:registerEvents()
	self.super.registerEvents(self)
	-- body
	self.Button_left:onClick(function ( ... )
	   	local curPageIndex = self.pageView:getCurPageIndex()
	   	local pageCount = self.pageView:getPageCount()
		local index = math.max(0,curPageIndex - 1)
		self.pageView:scrollToPage(index)
	end)

	self.Button_right:onClick(function ( ... )
			-- body
	   	local curPageIndex = self.pageView:getCurPageIndex()
	   	local pageCount = self.pageView:getPageCount()
		local index = math.min(pageCount - 1,curPageIndex + 1)
		self.pageView:scrollToPage(index)
	end)

	self.pageView:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
		self:updateView()
	end)
end

return ZnqHelpView