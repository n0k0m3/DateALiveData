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

local ActivityDetailTip = class("ActivityDetailTip",BaseLayer)

function ActivityDetailTip:ctor( content )
	-- body
	self.super.ctor(self)
	self.content = content
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.activityDetailTip")
end

function ActivityDetailTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)

	local Label_des = TFDirector:getChildByPath(ui,"Label_des")
	local ScrollView_buff = TFDirector:getChildByPath(ui,"ScrollView_buff")
	local Panel_item = TFDirector:getChildByPath(ui,"Panel_item")

	local uiList_content = UIListView:create(ScrollView_buff)

	Label_des:setTextById(self.content.title)

	for k,v in ipairs(self.content.showContent) do
		local item = Panel_item:clone()
		local Image_contentDi = TFDirector:getChildByPath(item,"Image_contentDi")
		local Label_title = TFDirector:getChildByPath(item,"Label_title")
		local Label_content = TFDirector:getChildByPath(item,"Label_content")

		Label_title:setTextById(v.title)
		Label_content:setTextById(v.content)

		local height = math.max(Label_content:getContentSize().height + 37+15, 100)
		Image_contentDi:setContentSize(CCSizeMake(Image_contentDi:getContentSize().width,height))

		item:setContentSize(Image_contentDi:getContentSize())
		uiList_content:pushBackCustomItem(item)
	end
end

return ActivityDetailTip