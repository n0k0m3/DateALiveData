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

local MaokaComposeSuccessTip = class("MaokaComposeSuccessTip",BaseLayer)

function MaokaComposeSuccessTip:ctor( rewards )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self.rewards = rewards
	self:init("lua.uiconfig.activity.composSuccess")
end

function MaokaComposeSuccessTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Image_itemIcon = TFDirector:getChildByPath(ui,"Image_itemIcon")
	self.Label_num = TFDirector:getChildByPath(ui,"Label_num")
	if self.rewards then
		local itemId = self.rewards[1].id
		local num = self.rewards[1].num

		self.Image_itemIcon:setTexture(GoodsDataMgr:getItemCfg(itemId).icon)
		self.Label_num:setText("x"..num)
	else
		self.Image_itemIcon:hide()
		self.Label_num:hide()
	end
end

function MaokaComposeSuccessTip:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
	-- body
end
return MaokaComposeSuccessTip