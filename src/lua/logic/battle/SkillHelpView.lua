local SkillHelpView = class("SkillHelpView",BaseLayer)
local enum          = import(".enum")
local eEvent        = enum.eEvent
function SkillHelpView:initData(herocid)
	self.herocid = herocid
	self.heroSkillMixCfg = TabDataMgr:getData("HeroSkillMix")
	self.curSkillMixCfg = {}
	self.skill_logo_img = {
		["A"] = "ui/battle/skillhelp/skill_logo_A.png",
		["B"] = "ui/battle/skillhelp/skill_logo_B.png",
	}
	for k,v in pairs(self.heroSkillMixCfg) do
		if v.rolecid == self.herocid then
			self.curSkillMixCfg[#self.curSkillMixCfg + 1] = v
		end
	end
	table.sort( self.curSkillMixCfg, function(a,b)
		return a.id < b.id
	end )
end

function SkillHelpView:ctor( ... )
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.battle.skillHelpView")
end

function SkillHelpView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = TFDirector:getChildByPath(ui,"Panel_root")
	local page_title = TFDirector:getChildByPath(self.root_panel,"Label_pad_title")
	page_title:setTextById(224013)
	self.btn_close = TFDirector:getChildByPath(self.root_panel,"Button_close")
	local group_ScrollView = TFDirector:getChildByPath(self.root_panel,"ScrollView_list")
	local group_cell = group_ScrollView:getChildByName("Panel_cell")
	local group_logo_scrollView = group_cell:getChildByName("ScrollView_skillList")
	local group_logo_cell = group_logo_scrollView:getChildByName("Panel_skill")
	self.skill_logo_size = group_logo_cell:getContentSize()
	self.group_listView = UIListView:create(group_ScrollView)
	self.group_listView:setItemModel(group_cell)
end

function SkillHelpView:refreshView()
	self.group_listView:removeAllItems()
	for k,v in ipairs(self.curSkillMixCfg) do
		local groupItem = self.group_listView:pushBackDefaultItem()
		groupItem:setVisible(true)
		groupItem:getChildByName("Label_group_name"):setTextById(v.mixName)
		local group_logo_scrollView = groupItem:getChildByName("ScrollView_skillList")
		local group_logo_cell = group_logo_scrollView:getChildByName("Panel_skill")
		groupItem.skill_listView = UIListView:create(group_logo_scrollView)
		groupItem.skill_listView:setItemModel(group_logo_cell)
		groupItem.skill_listView:removeAllItems()
		local skillCount = 0
		for s,t in ipairs(v.skillMix) do
			local skill_logo_item = groupItem.skill_listView:pushBackDefaultItem()
			skill_logo_item:setVisible(true)
			skill_logo_item:getChildByName("Image_skill"):setTexture(self.skill_logo_img[t])
			skillCount = skillCount + 1
		end
		groupItem.skill_listView:setContentSize(me.size(self.skill_logo_size.width * skillCount,self.skill_logo_size.height))
	end
end

function SkillHelpView:onShow()
	self:refreshView()
end

function SkillHelpView:registerEvents()
	self.root_panel:onClick(function( ... )
		EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
		AlertManager:closeLayer(self)
	end)
	self.btn_close:onClick(function( ... )
		EventMgr:dispatchEvent(eEvent.EVENT_RESUME)
		AlertManager:closeLayer(self)
	end)
	
end

return SkillHelpView