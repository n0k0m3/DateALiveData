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

local LevelUnlockTip = class("LevelUnlockTip",BaseLayer)

function LevelUnlockTip:ctor( groupId )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self.levelIds = FubenDataMgr:getLevel(groupId,1)
	self:init("lua.uiconfig.activity.levelUnlockTip")
end

function LevelUnlockTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	
	self.Panel_levelItem = TFDirector:getChildByPath(ui,"Panel_levelItem")

	local ScrollView_level = TFDirector:getChildByPath(ui,"ScrollView_level")

	self.uiList_level = UIListView:create(ScrollView_level)
		
	self:updateLevelList()
end

function LevelUnlockTip:updateLevelList( ... )
	-- body
	self.uiList_level:removeAllItems()
	for k,v in ipairs (self.levelIds) do
		local item = self.Panel_levelItem:clone()
		self:updateLevelItem(item, v)
		self.uiList_level:pushBackCustomItem(item)
	end
end

function LevelUnlockTip:updateLevelItem( item, levelId )
	-- body
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	
	local levelCfg = FubenDataMgr:getLevelCfg(levelId)
	Label_name:setTextById(levelCfg.name)
	Label_des:setTextById(levelCfg.unlockBrief)
end


function LevelUnlockTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return LevelUnlockTip