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
* -- 日常副本关卡开启简介
]]

local FubenDailyOpenRuleView = class("FubenDailyOpenRuleView",BaseLayer)

function FubenDailyOpenRuleView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:showPopAnim(true)
	self:init("lua.uiconfig.fuben.fubenDailyOpenRuleView")
end

function FubenDailyOpenRuleView:initUI( ui )
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.panel_content = TFDirector:getChildByPath(ui,"panel_content")
	self:refreshView(  )
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
end

function FubenDailyOpenRuleView:refreshView(  )
	-- body
	local data = FubenDataMgr:getChapter(EC_FBType.DAILY, true)
	local offsetY = 2
	for k,v in pairs(data) do
		local offsetX = 0
		local maxHeight = 0
		for i = 1,7 do
    		local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(v)
    		local path = levelGroupCfg.resIcon
    		if table.indexOf(levelGroupCfg.timeFrame, i%7 + 1) == -1 then
    			path = string.sub(path,0,-5).."_1.png"
    		end
    		local imageItem = TFImage:create(path)
    		imageItem:setAnchorPoint(ccp(0,1))
    		imageItem:setPosition(ccp(offsetX,- offsetY))
    		offsetX = imageItem:getContentSize().width+2 + offsetX
    		self.panel_content:addChild(imageItem)
    		maxHeight = math.max(maxHeight,imageItem:getContentSize().height)
		end
		offsetY = offsetY + maxHeight + 2
	end
end

return FubenDailyOpenRuleView