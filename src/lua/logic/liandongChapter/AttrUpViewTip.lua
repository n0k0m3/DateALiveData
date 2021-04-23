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

local AttrUpViewTip = class("AttrUpViewTip",BaseLayer)

function AttrUpViewTip:ctor( data )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
    self.changeAttrData = data
    local linkageHeros = FubenDataMgr:getLinkAgeHeros()

    for k,v in ipairs(linkageHeros) do
    	if v.heroId == self.changeAttrData.heroId then
    		self.changeHeroData = v
    	end
    end

	self:init("lua.uiconfig.activity.attrViewTip")
end

function AttrUpViewTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.sprite_icon = TFDirector:getChildByPath(ui,"sprite_icon")
	self.sprite_frame = TFDirector:getChildByPath(ui,"sprite_frame")
	self.Label_curLv = TFDirector:getChildByPath(ui,"Label_curLv")
	self.Label_lastLv = TFDirector:getChildByPath(ui,"Label_lastLv")
	self.LoadingBar_progress = TFDirector:getChildByPath(ui,"LoadingBar_progress")
	self.Label_progress = TFDirector:getChildByPath(ui,"Label_progress")

	self.Panel_attrItem = TFDirector:getChildByPath(ui,"Panel_attrItem")

	local ScrollView_attr = TFDirector:getChildByPath(ui,"ScrollView_attr")

	self.uiList_attr = UIListView:create(ScrollView_attr)
		
	self:updateBaseInfo()
	self:updateAttrList()
end

function AttrUpViewTip:updateBaseInfo( ... )
	-- body
	self.sprite_icon:setTexture(HeroDataMgr:getIconPathById(self.changeHeroData.heroId))
	self.Label_curLv:setText(self.changeAttrData.level - 1)
	self.Label_lastLv:setText(self.changeAttrData.lastLv - 1)
	local maxExp = FubenDataMgr:getGraceMaxExp(self.changeHeroData.level)
	self.Label_progress:setText(self.changeHeroData.exp.."/"..maxExp)
	self.LoadingBar_progress:setPercent(self.changeHeroData.exp*100/maxExp)
	if maxExp == 1 then
		self.Label_progress:setText("MAX")
	end
end

function AttrUpViewTip:updateAttrList( ... )
	-- body
	self.uiList_attr:removeAllItems()

	local attrs = FubenDataMgr:getLinkAgeHeroAttrs(self.changeHeroData)

	local lastLevelCfg = TabDataMgr:getData("Grace",self.changeAttrData.lastLv)
	local curLevelCfg = TabDataMgr:getData("Grace",self.changeAttrData.level)
	for k,v in ipairs (attrs) do
		local item = self.Panel_attrItem:clone()
		v.value = v.value
		v.up = curLevelCfg.updateAttrType[v.attributeId] - lastLevelCfg.updateAttrType[v.attributeId]
		self:updateAttrItem(item, v)
		self.uiList_attr:pushBackCustomItem(item)
	end
end

function AttrUpViewTip:updateAttrItem( item, attr )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Panel_desire = TFDirector:getChildByPath(item,"Panel_desire")
	local Panel_normal = TFDirector:getChildByPath(item,"Panel_normal")

	local isDesire = self.changeAttrData.attr.attributeId == attr.attributeId

	Panel_desire:setVisible(isDesire)
	Panel_normal:setVisible(not isDesire)
	local showNode = isDesire and Panel_desire or Panel_normal

	local Label_name = TFDirector:getChildByPath(showNode,"Label_name")
	local Label_attr = TFDirector:getChildByPath(showNode,"Label_attr")
	local Label_up = TFDirector:getChildByPath(showNode,"Label_up")
	local Label_desire_up = TFDirector:getChildByPath(showNode,"Label_desire_up")


    local attrCfg =HeroDataMgr:getAttributeConfig(attr.attributeId)
    Image_icon:setTexture(attrCfg.icon)
    Label_name:setTextById(attrCfg.name)
    Label_attr:setText("+"..string.format(attrCfg.displayFormat,attr.value))

	Label_up:setText(attr.up)
	if Label_desire_up then
		Label_desire_up:setText(self.changeAttrData.attr.value)
	end
end


function AttrUpViewTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	self.Button_sure:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)
end

return AttrUpViewTip