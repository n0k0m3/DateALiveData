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

local MaokaComposeRepeatTip = class("MaokaComposeRepeatTip",BaseLayer)

function MaokaComposeRepeatTip:ctor( rewards )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self.rewards = rewards
	self:init("lua.uiconfig.activity.composRepeat")
end

function MaokaComposeRepeatTip:initUI( ui )
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

function MaokaComposeRepeatTip:registerEvents( ... )
	self.super.registerEvents(self)
	-- body
	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end
return MaokaComposeRepeatTip