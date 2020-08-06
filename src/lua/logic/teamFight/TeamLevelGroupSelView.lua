local TeamLevelGroupSelView = class("TeamLevelGroupSelView",BaseLayer)

function TeamLevelGroupSelView:initData(chapterId)
	self.levelsGroup = TabDataMgr:getData("ChasmDungeonGroup")
	self.groupListCfg = {}
	for k,v in pairs(self.levelsGroup) do
		self.groupListCfg[#self.groupListCfg +1] = v
	end
	table.sort( self.groupListCfg, function(a,b)
		return a.id < b.id
	end )
	self.chapterId = chapterId

	FubenDataMgr:cacheSelectChapter(EC_ActivityFubenType.TEAM)
	FubenDataMgr:cacheSelectFubenType(EC_FBType.ACTIVITY)
end

function TeamLevelGroupSelView:getClosingStateParams()
    return {self.chapterId}
end
function TeamLevelGroupSelView:ctor( ... )
	self.super.ctor(self)
	self:initData(...)
	self:init("lua.uiconfig.teamFight.teamLevelGroupSelView")
end

function TeamLevelGroupSelView:initUI(ui)
	self.super.initUI(self,ui)
	self.root_panel = TFDirector:getChildByPath(ui,"Panel_root")
end

function TeamLevelGroupSelView:onShow()
	self.super.onShow(self)
	self:refreshView()
end

function TeamLevelGroupSelView:refreshView()
	for i,v in ipairs(self.groupListCfg) do
		local tmGroupStat =  TeamFightDataMgr:getGroupStatus(v.id)
		local groupItem = self.root_panel:getChildByName("Panel_group_"..i)
		local panel_card = groupItem:getChildByName("Panel_card")
		local bottom_img = groupItem:getChildByName("Image_bottom")
		local card_img = panel_card:getChildByName("Image_bg")
		local front_img = panel_card:getChildByName("Image_front")
		local unlock_img = panel_card:getChildByName("Image_unlock")
		local lock_img = panel_card:getChildByName("Image_lock")
		local title_img = panel_card:getChildByName("Image_title"):show()
		local lv_limit_txt = title_img:getChildByName("Label_lv_limit")
		local open_desc_txt = panel_card:getChildByName("Label_open"):show()

		card_img:setTexture("ui/onlineteam/"..v.bgPic)
		title_img:setTexture("ui/onlineteam/"..v.NamePic)
		open_desc_txt:setTextById(v.TimeDesc)
		lv_limit_txt:setSkewX(15)
		lv_limit_txt:setTextById(v.LevelDesc)
		if not lv_limit_txt._initPos then 
			lv_limit_txt._initPos = true
			if v.pos then
				local position = lv_limit_txt:getPosition()
				position.x = position.x +  v.pos.x
				position.y = position.y +  v.pos.y
				lv_limit_txt:setPosition(position)
			end
		end
		bottom_img:setTexture("ui/onlineteam/"..v.mapPic)
		bottom_img:setScaleX(0.35)
		bottom_img:setScaleY(0.25)
		-- bottom_img:setRotation3D(30,0,0)
		if tmGroupStat then
			lock_img:setVisible(not tmGroupStat.open)
			unlock_img:setVisible(tmGroupStat.open)
			card_img.gid = v.id
			card_img:onClick(function( ... )
				if tmGroupStat.open == false then
					Utils:showError(2100098)
					return
				end

				if tmGroupStat.lvok == false then
					Utils:showError(2100100)
					return
				end
				Utils:openView("teamFight.TeamLevelSelView",card_img.gid)
			end)
		end
	end
end

function TeamLevelGroupSelView:registerEvents()
	EventMgr:addEventListener(self, EV_TEAM_FIGHT_LEVEL_STAT_LIST, handler(self.onUpdateLevelStat, self))
end

function TeamLevelGroupSelView:onUpdateLevelStat()
	self:refreshView()
end

return TeamLevelGroupSelView