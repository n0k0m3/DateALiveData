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
* -- 追猎计划奖励预览
]]

local Tips_String_ids = 
{ 
    3300019, --首通奖励提示
    3300020,  --击杀奖励提示
	3300052  --击杀奖励提示
}

local LeagueHunterRewardView = class("LeagueHunterRewardView",BaseLayer)

function LeagueHunterRewardView:ctor( data )
	self.super.ctor(self,data)
	local curDungeon = LeagueDataMgr:getHuntingDungeonInfo().curBoss.curDungeon
	self.bossCfg = TabDataMgr:getData("HuntingLevel",curDungeon)
	self.chooseIndex = 1
   	self:showPopAnim(true)
	self:init("lua.uiconfig.league.leagueHunterRewardView")
end

function LeagueHunterRewardView:initUI( ui )
	self.super.initUI(self,ui)
	-- self.ScrollView_items = TFDirector:getChildByPath(ui,"ScrollView_items")
	local panel_ScrollView = TFDirector:getChildByPath(ui,"panel_ScrollView")

	self.listView = TFTableView:create()
    self.listView:setTableViewSize(panel_ScrollView:getContentSize())
    self.listView:setDirection(TFTableView.TFSCROLLVERTICAL)
    --列表设置为从小到大显示，及idx从0开始
    self.listView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

	self.listView:onNumberOfCells(handler(self.tableNumberOfCells,self))
	self.listView:onCellSize(handler(self.tableSizeOfCell,self))
	self.listView:onCellAtIndex(handler(self.tableCellAtIndex,self))
    panel_ScrollView:addChild(self.listView,200)
    self.listView.logic = self
	-- self.uilistView   = UIListView:create(self.ScrollView_items)
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_first = TFDirector:getChildByPath(ui,"Button_first")
	self.Button_kill  = TFDirector:getChildByPath(ui,"Button_kill")
	self.Button_hurt  = TFDirector:getChildByPath(ui,"Button_hurt")

	self.tabs = {}
	self.tabs[1]           = self.Button_first
	self.tabs[2]           = self.Button_kill
	self.tabs[3]		   = self.Button_hurt
	self.label_tip         = TFDirector:getChildByPath(ui,"label_tip")
	self.Panel_reward_Item = TFDirector:getChildByPath(ui,"Panel_reward_Item")
	self:setSelect(1,true)
end

function LeagueHunterRewardView:tableNumberOfCells( table )
	return #self.rewardList
end

function LeagueHunterRewardView:tableSizeOfCell( table ,idx)
	local size = self.Panel_reward_Item:getContentSize()
	return size.height,size.width
end

function LeagueHunterRewardView:tableCellAtIndex( table ,idx )
	local cell = table:dequeueCell()
   	if nil == cell then
	  	table.cells = table.cells or {}
        cell = TFTableViewCell:create()
   		local parentNode = self.Panel_reward_Item:clone()
   		parentNode:setVisible(true)
   		parentNode:setAnchorPoint(ccp(0,0))
   		parentNode:setPosition(ccp(0,0))
	    cell:addChild(parentNode)
	    cell.node = parentNode
		table.cells[cell] = true
    end

    local itemNode = cell.node

	self:updateRewardItem(itemNode,self.rewardList[idx + 1],self.chooseIndex )

    return cell
end

function LeagueHunterRewardView:setSelect(index,force)
    if self.chooseIndex ~= index  or force then
        self.chooseIndex = index
        self.label_tip:setTextById(Tips_String_ids[index])
        for k , tab in ipairs(self.tabs) do
			local select = tab:getChildByName("Image_select")
			select:setVisible(k == self.chooseIndex)
			tab:setTouchEnabled(k ~= self.chooseIndex)
        end
		if self.chooseIndex == 1 then --首通奖励
			self.rewardList = self:getFDAward()
		elseif self.chooseIndex == 2 then --首通奖励
			self.rewardList = self:getPassAward()
		elseif self.chooseIndex == 3 then --伤害奖励
			self.rewardList = LeagueDataMgr:getHurtRewardList()
		end
    	self.listView:reloadData()

    	if index == 3 then
	    	local awardIndex
			for k,v in ipairs(self.rewardList) do
				if v.status == 2 then
					awardIndex = k
					break
				end
			end
			if awardIndex then
				awardIndex = awardIndex < 3 and 3 or awardIndex
				awardIndex = #self.rewardList - awardIndex + 1
				local cellHeight = self.Panel_reward_Item:getContentSize().height
			    local posY =  -((awardIndex-1) * cellHeight)
			    self.listView:setContentOffset(ccp(0,posY) , 0)
			end
		end

    end

end

function LeagueHunterRewardView:getFDAward()
	local huntingRewardList  = LeagueDataMgr:getHuntRewardList()
	local fdAward = huntingRewardList.fdAward
	fdAward = fdAward or {}
	if #fdAward == 0 then 
		fdAward[1] = {dungeon =self.bossCfg.id ,status = 1}
	end
	return fdAward
end

function LeagueHunterRewardView:getPassAward()
	local huntingRewardList  = LeagueDataMgr:getHuntRewardList()
	local passAward = huntingRewardList.passAward or {}
	if #passAward == 0  then
		local _passAward = {}
		local curBoss = LeagueDataMgr:getHuntingDungeonInfo().curBoss
		local bossCfg = TabDataMgr:getData("HuntingLevel",curBoss.curDungeon)
		if bossCfg.isLast and curBoss.dungeonHp >= 10000 then 
			_passAward[1] = {dungeon =bossCfg.id ,status = 4}
			bossCfg = TabDataMgr:getData("HuntingLevel",bossCfg.preLevel)
			_passAward[2] = {dungeon =bossCfg.id       ,status = 4}
			_passAward[3] = {dungeon =bossCfg.preLevel ,status = 4}
		else
			_passAward[1] = {dungeon =bossCfg.id ,status = 4}
		end
		return _passAward
	end
	return passAward
end


function LeagueHunterRewardView:refreshView()
	self:setSelect(self.chooseIndex,true) --因为使用了假数据刷新只能重先加载


	-- 刷新按钮状态
 --    local huntingRewardList  = LeagueDataMgr:getHuntRewardList()
	-- local rewardList
	-- if self.chooseIndex == 1 then --首通奖励
	-- 	rewardList = huntingRewardList.fdAward
	-- else --击杀奖励
	-- 	rewardList = huntingRewardList.passAward
	-- end
	-- if rewardList then
	-- 	local rewardMap = {}
	-- 	for k,v in pairs(rewardList) do
	-- 		rewardMap[v.dungeon] = v
	-- 	end
	-- 	local items = self.uilistView:getItems()
	-- 	for k, item in ipairs(items) do
	-- 		local reward  = rewardMap[item.dungeon]
	-- 		if reward then 
	-- 		-- ,1 未满足条件,2 可领取,3 已领取
	-- 		    if data.status == 2 then
	-- 		    	item.Button_get:show()
	-- 		    	item.Button_get:setTouchEnabled(true)
	-- 		    	item.Label_notReach:hide()
	-- 		    	item.Label_alreadyGet:hide()
	-- 		    elseif data.status == 3 then
	-- 		    	item.Label_alreadyGet:show()
	-- 		    	item.Button_get:hide()
	-- 		    	item.Button_get:setTouchEnabled(false)
	-- 		    	item.Label_notReach:hide()
	-- 		    else
	-- 		    	item.Button_get:hide()
	-- 		    	item.Button_get:setTouchEnabled(false)
	-- 		    	item.Label_alreadyGet:hide()
	-- 		    	item.Label_notReach:show()
	-- 		    end
	-- 		end
	-- 	end
	-- end

end

function LeagueHunterRewardView:registerEvents()
	self.super.registerEvents(self)
	--self.Button_first:onClick(function ( ... )
	--	self:setSelect(1)
	--end)
	--self.Button_kill:onClick(function ( ... )
	--	self:setSelect(2)
	--end)
	self.Button_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)
	EventMgr:addEventListener(self, EV_HUNTER_REWARDLIST_UPDATE, function ( ... )
		self:refreshView()
	end)

	for k,v in ipairs(self.tabs) do
		v:onClick(function()
			self:setSelect(k)
		end)
	end
end

function LeagueHunterRewardView:updateRewardItem( item ,data, chooseIndex )
	item.dungeon = data.dungeon -- 绑定ID
	item.Button_get        = TFDirector:getChildByPath(item,"Button_get"):hide()
	item.Label_alreadyGet  = TFDirector:getChildByPath(item,"Label_alreadyGet"):hide()
	item.Label_alreadyGet:setTextById(3300033)
	item.Label_notReach    = TFDirector:getChildByPath(item,"Label_notReach"):hide()
	local ScrollView_reward = TFDirector:getChildByPath(item,"ScrollView_reward")
	if item.uiList_scrollView then
		item.uiList_scrollView:removeAllItems()
	end
	item.uiList_scrollView = UIListView:create(ScrollView_reward)
	item.Label_pass        = TFDirector:getChildByPath(item,"Label_pass")
	item.Label_level_name  = TFDirector:getChildByPath(item,"Label_level_name")
	local bossCfg = {}
	if chooseIndex ~= 3 then
		bossCfg           = TabDataMgr:getData("HuntingLevel",data.dungeon)
		item.Label_level_name:setTextById(3300028,bossCfg.bossLevel)
	else
		local value = data.value*0.01
		value = string.format('%.2f%%',value)
		item.Label_level_name:setText("≥"..value)
	end
	dump(data)
	local tb = {}
	if chooseIndex == 1 then
		tb = bossCfg.firstDropShow
		item.Label_pass:setTextById(1701611)
	elseif chooseIndex == 2 then
		tb = bossCfg.dropShow
		item.Label_pass:setTextById(1701611)
	elseif chooseIndex == 3 then
		tb = data.award
		item.Label_pass:setTextById(3300053)
	end

	for i, v in pairs(tb) do
        local flag = 0
        local arg = {}
        local Panel_dropGoodsItem = PrefabDataMgr:getPrefab("Panel_dropGoodsItem"):clone()
    	Panel_dropGoodsItem:Scale(0.65)
    	if chooseIndex == 3 then
    		PrefabDataMgr:setInfo(Panel_dropGoodsItem, {v.id,v.num}, flag, arg)
    	else
    		PrefabDataMgr:setInfo(Panel_dropGoodsItem, {i,v}, flag, arg)
    	end
        item.uiList_scrollView:pushBackCustomItem(Panel_dropGoodsItem)
    end
-- ,1 未满足条件,2 可领取,3 已领取
    if data.status == 2 then
    	item.Button_get:show()
    	item.Button_get:setTouchEnabled(true)
    	item.Label_notReach:hide()
    	item.Label_alreadyGet:hide()
    elseif data.status == 3 then
    	item.Label_alreadyGet:show()
    	item.Button_get:hide()
    	item.Button_get:setTouchEnabled(false)
    	item.Label_notReach:hide()
    elseif data.status == 1 then
    	item.Button_get:hide()
    	item.Button_get:setTouchEnabled(false)
    	item.Label_alreadyGet:hide()
    	item.Label_notReach:setVisible(chooseIndex ~= 3)

    else
    	item.Button_get:hide()
    	item.Button_get:setTouchEnabled(false)
    	item.Label_alreadyGet:hide()
    	item.Label_notReach:hide()
    end

    item.Button_get:onClick(function ( ... )
    	--TODO 其他条件限制添加
    	if chooseIndex == 1 then
	    	TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_FDAWARD,{data.dungeon})
	    elseif chooseIndex == 2 then
	    	TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_PASS_AWARD,{data.dungeon})
		elseif chooseIndex == 3 then
			TFDirector:send(c2s.HUNTING_DUNGEON_REQ_HUNTING_DAMAGE_AWARD,{})
	    end
    end)
end

return LeagueHunterRewardView