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

local GraceLevelUnlockTip = class("GraceLevelUnlockTip",BaseLayer)

function GraceLevelUnlockTip:ctor(  )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self:init("lua.uiconfig.activity.graceLevelUnlockTip")
end

function GraceLevelUnlockTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	
	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")

	local ScrollView_level = TFDirector:getChildByPath(ui,"ScrollView_level")

	self.uiList_level = UIListView:create(ScrollView_level)
		
	self:updateLevelList()
end

function GraceLevelUnlockTip:updateLevelList( ... )
	-- body
	self.uiList_level:removeAllItems()
	for k,v in ipairs (TabDataMgr:getData("Grace")) do
		if table.count(v.levelUnlockCond) > 0 then
			local item = self.Panel_levelItem:clone()
			self:updateLevelItem(item, v)
			self.uiList_level:pushBackCustomItem(item)
		end
	end
end

function GraceLevelUnlockTip:updateLevelItem( item, graceCfg )
	-- body
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	
	Label_name:setTextById(graceCfg.unlockName)
	Label_des:setTextById(graceCfg.unlockDesc)
end


function GraceLevelUnlockTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return GraceLevelUnlockTip