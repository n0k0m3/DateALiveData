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

local LevelDebuffTip = class("LevelDebuffTip",BaseLayer)

function LevelDebuffTip:ctor( levelCfg )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
    self.levelCfg = levelCfg
	self:init("lua.uiconfig.fuben.debuffTip")
end

function LevelDebuffTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	
	self.Panel_buffItem = TFDirector:getChildByPath(ui,"Panel_buffItem")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")

	local ScrollView_buff = TFDirector:getChildByPath(ui,"ScrollView_buff")

	self.uiList_buff = UIListView:create(ScrollView_buff)
		
	self.Label_des:setTextById(self.levelCfg.levelAffix.topDes)
	self:updateBuffList()
end

function LevelDebuffTip:updateBuffList( ... )
	-- body
	self.uiList_buff:removeAllItems()
	for k,v in ipairs (self.levelCfg.levelAffix.affixList) do
		local item = self.Panel_buffItem:clone()
		self:updateBuffItem(item, v)
		self.uiList_buff:pushBackCustomItem(item)
	end
end

function LevelDebuffTip:updateBuffItem( item, affixId )
	-- body
	local Label_name = TFDirector:getChildByPath(item,"Label_name")
	local Label_des = TFDirector:getChildByPath(item,"Label_des")
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local affixCfg = TabDataMgr:getData("MonsterAffix",affixId)
	Label_name:setTextById(affixCfg.affixName[1])
	Label_des:setTextById(affixCfg.affixDesc[1])
	Image_icon:setTexture(affixCfg.affixIcon1)
end


function LevelDebuffTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)
end

return LevelDebuffTip