--[[
- 追猎计划荣誉
]]
local LeagueHunterHonorView = class("LeagueHunterHonorView",BaseLayer)

--排名图标
local RankImages =
{
	"ui/activity/assist/038.png",
	"ui/activity/assist/039.png",
	"ui/activity/assist/040.png",
}

function LeagueHunterHonorView:ctor()
	self.super.ctor(self)
	self:initData()
   	self:showPopAnim(true)
	self:init("lua.uiconfig.league.leagueHunterHonorView")
end

function LeagueHunterHonorView:initData()
	-- local data           = LeagueDataMgr.huntingRankList
	-- self.honerList       = data.damages or {} -- 社团伤害排行
	-- self.playerHonerList = data.honors  or {} -- 玩家贡献列表
	-- self.selfHoner       = data.selfDamage -- 自己社团伤害数据
	-- self.selfPlayerHoner = data.selfHonor  -- 自己玩家贡献数据
	-- local function sortFunc(obj1,obj2)
	-- 	return obj1.rank < obj2.rank
	-- end
	-- table.sort( self.honerList, sortFunc )
	-- table.sort( self.playerHonerList, sortFunc )
end

function LeagueHunterHonorView:initUI( ui )
	self.super.initUI(self,ui)
	self.Panel_Item   = TFDirector:getChildByPath(ui,"Panel_Item")
	self.Button_close      = TFDirector:getChildByPath(ui,"Button_close")
	local Panel_top   = TFDirector:getChildByPath(ui,"Panel_top")
	local TitleTextIds = {3300045,3300046,3300047}
	for i = 1 , 3 do
		local Label_title = TFDirector:getChildByPath(Panel_top,"Label_title"..i)
		Label_title:setTextById(TitleTextIds[i])
	end
	local Label_name     = TFDirector:getChildByPath(ui,"Label_name")
	local Label_name_en  = TFDirector:getChildByPath(ui,"Label_name_en")
	local Label_tips     = TFDirector:getChildByPath(ui,"Label_tips")
	Label_name:setTextById(3300048)
	Label_name_en:setTextById(3300049)
	Label_tips:setTextById(3300044)
	local panel_ScrollView = TFDirector:getChildByPath(ui,"panel_ScrollView")
    self.listView = UIListView:create(panel_ScrollView)
    local datas = TabDataMgr:getData("DiscreteData",90004).data.list
    for i,data in ipairs(datas) do
    	local item = self.Panel_Item:clone()
		item:getChildByName("label_name"):setTextById(data.frameName)
		item:getChildByName("label_score"):setText(data.score)
		local image_head = item:getChildByName("image_head")
		image_head:setTexture(data.frame)
		image_head:setScale(0.55)
		local image_rank = item:getChildByName("image_rank")
		local label_rank = item:getChildByName("label_rank")
		if #data.rank  < 2 then
			local _rank = data.rank[1]
			if _rank < 4 then 
				image_rank:setTexture(RankImages[_rank])
			end
			image_rank:setVisible(_rank < 4)
			label_rank:setText(_rank)
		else 
			image_rank:hide()
			label_rank:setText(string.format("%s-%s",data.rank[1] ,data.rank[2]))
    	end
    	self.listView:pushBackCustomItem(item)
    end

  -- for i=1,10 do
  -- 	self.listView:pushBackCustomItem(self.Panel_Item:clone())
  -- end
end



function LeagueHunterHonorView:registerEvents()
	self.super.registerEvents(self)

	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
end

return LeagueHunterHonorView