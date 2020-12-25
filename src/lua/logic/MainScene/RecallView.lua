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
* 周年庆回忆界面
* 
]]

local RecallView = class("RecallView", BaseLayer)

function RecallView:ctor(data)
	self.super.ctor(self,data)
	self:init("lua.uiconfig.MainScene.RecallView")
end

function RecallView:initUI(ui)
	self.super.initUI(self,ui)

	self.spine_bg = TFDirector:getChildByPath(ui, "spine_bg")
	self.panel_content = TFDirector:getChildByPath(ui, "panel_content"):hide()
	self.close_btn = TFDirector:getChildByPath(ui, "close_btn")
	self.go_btn = TFDirector:getChildByPath(ui, "go_btn")
	self.txt_title = TFDirector:getChildByPath(ui, "txt_title")
	self.txt_content = TFDirector:getChildByPath(ui, "txt_content")
	self.scroll_view = TFDirector:getChildByPath(ui, "scroll_view")

	self.txt_title:setTextById(23031)
	self.txt_content:setTextById(23032)
	self.txt_content:setLineHeight(40)

	local scrollSize = self.scroll_view:getContentSize()
	local txtHeight = self.txt_content:getContentSize().height
	if txtHeight > scrollSize.height then
		scrollSize.height = txtHeight
	end
	self.scroll_view:setInnerContainerSize(scrollSize)

	self.spine_bg:play("2ndxinfeng_all", false)
    self.spine_bg:addMEListener(TFARMATURE_COMPLETE, function()
        self.spine_bg:removeMEListener(TFARMATURE_COMPLETE)
        self:showAnim()
    end)
end

function RecallView:showAnim()
	self.panel_content:show()
	self.panel_content:setOpacity(0)
	self.panel_content:runAction(CCFadeIn:create(1))
end

function RecallView:registerEvents()
	self.close_btn:onClick(function()
        AlertManager:closeLayer(self)
    end)

	self.go_btn:onClick(function()
        FunctionDataMgr:jWorldRoom()
        AlertManager:closeLayer(self)
    end)
end

return RecallView