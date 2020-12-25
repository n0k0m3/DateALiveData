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
*-- 挂机精灵培养界面
* 
]]
local HangUpSpriteTrainView = class("HangUpSpriteTrainView", BaseLayer)

function HangUpSpriteTrainView:ctor( ... )
	-- body
	self.super.ctor(self,...)
	self:initData(...)
	self:showPopAnim(true)
	self:init("lua.uiconfig.activity.spriteTrainView")
end

function HangUpSpriteTrainView:initData( activityId )
	-- body
	self.activityId = activityId
	self.activityInfo = ActivityDataMgr2:getActivityInfo(activityId)
end

function HangUpSpriteTrainView:initUI( ui )
	-- body
	self.super.initUI(self, ui)
	self.Image_sprite_paint = TFDirector:getChildByPath(ui,"Image_sprite_paint")
	self.Button_action = TFDirector:getChildByPath(ui,"Button_action")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Label_des = TFDirector:getChildByPath(ui,"Label_des")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Label_lv = TFDirector:getChildByPath(ui,"Label_lv")
	self.Label_cur = TFDirector:getChildByPath(ui,"Label_cur")
	self.Label_late = TFDirector:getChildByPath(ui,"Label_late")
	self.Image_6 = TFDirector:getChildByPath(ui,"Image_6")
	self.Label_max = TFDirector:getChildByPath(ui,"Label_max")
	self.Image_cost_icon = TFDirector:getChildByPath(ui,"Image_cost_icon")
	self.label_cost_num = TFDirector:getChildByPath(ui,"label_cost_num")
	self.Panel_spriteItem = TFDirector:getChildByPath(ui,"Panel_spriteItem")
	self.Spine_levelUp = TFDirector:getChildByPath(ui,"Spine_levelUp"):hide()


	local ScrollView_sprite = TFDirector:getChildByPath(ui,"ScrollView_sprite")
	self.roleList = UIGridView:create(ScrollView_sprite)
  	self.roleList:setItemModel(self.Panel_spriteItem)
	self.roleList:setColumn(2)
    self.roleList:setColumnMargin(3)
    self.roleList:setRowMargin(3)
	self:selectRole(1)
end

function HangUpSpriteTrainView:registerEvents(  )
	-- body
	self.super.registerEvents(self)
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_HANGUP_ROLEINFO, handler(self.updateContent, self))

	self.Button_action:onClick(function ( ... )
		-- body
		ActivityDataMgr2:send_ACTIVITY_REQ_UP_HANG_UP_ROLE_LEVEL(self.activityId, self.curRole.roleId)
	end)

	EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
	    		if self.activityId == activityId then
	    			AlertManager:closeLayer(self)
	    		end
	    	end)
	
	EventMgr:addEventListener(self, EV_ACTIVITY_HANGUP_ROLE_LEVELUP, function ( ... )
		self.Spine_levelUp:show()
		self.Spine_levelUp:addMEListener(
	        TFARMATURE_COMPLETE,
	        function(skeletonNode)
	            self.Spine_levelUp:removeMEListener(TFARMATURE_COMPLETE)
	            self.Spine_levelUp:hide()
	        end
	    )
	    self.Spine_levelUp:playByIndex(0,-1,-1,0)
	end)



	self.Button_close:onClick(function ( ... )
		-- body

		AlertManager:closeLayer(self)
	end)

end

function HangUpSpriteTrainView:updateContent( ... )
	-- body
	self.curRole = self.activityInfo.data.hangUpRoleInfo[self.curIdx]
	self:updateRoleInfo()
	self:updateRoleList()
end

function HangUpSpriteTrainView:selectRole( idx )
	-- body
	if self.curIdx == idx then return end
	self.curIdx = idx
	self:updateContent()
end

function HangUpSpriteTrainView:updateRoleList(  )
	-- body
	local roleList = self.activityInfo.data.hangUpRoleInfo or {}
	local items = self.roleList:getItems()
	local gap = #items - #roleList
    for i = 1, math.abs(gap) do
        if gap > 0 then
            self.roleList:removeItem(1)
        else
            self.roleList:pushBackDefaultItem()
        end
    end
	for k,v in ipairs(roleList) do
		local item = self.roleList:getItem(k)

		local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
		local Label_lv = TFDirector:getChildByPath(item,"Label_lv")
		local Image_sel = TFDirector:getChildByPath(item,"Image_sel")

		local spriteCfg = TabDataMgr:getData("HangUpRole",v.roleId)
		Image_icon:setTexture(spriteCfg.icon)
		Label_lv:setText("Lv."..v.level)
		Image_sel:setVisible(v.roleId == self.curRole.roleId)

		item:setTouchEnabled(true)
		item:onClick(function ( ... )
			self:selectRole(k)
		end)
	end
end

function HangUpSpriteTrainView:updateRoleInfo(  )
	-- body
	local spriteCfg = TabDataMgr:getData("HangUpRole",self.curRole.roleId)
	local curLevelCfg = TabDataMgr:getData("HangUpRoleLevel",self.curRole.level)

	local lateLevelCfg = TabDataMgr:getData("HangUpRoleLevel",math.min(self.curRole.level + 1,self.activityInfo.extendData.maxLevel))
	self.Label_name:setTextById(spriteCfg.name)
	self.Label_lv:setText("Lv."..self.curRole.level)
	self.Label_des:setTextById(spriteCfg.describe)
	local value = curLevelCfg.lvAddition/100
	self.Label_cur:setText(value.."%") 
	self.Label_max:setText(value.."%")
	value = lateLevelCfg.lvAddition/100
	self.Label_late:setText(value.."%")
	local isMax = self.curRole.level == self.activityInfo.extendData.maxLevel
	self.Button_action:setGrayEnabled(isMax)
	self.Button_action:setTouchEnabled(not isMax)

	self.Label_max:setVisible(isMax)
	self.Image_6:setVisible(not isMax)
	local costId,costNum = next(lateLevelCfg.cost)
	self.Image_cost_icon:setTexture(GoodsDataMgr:getItemCfg(costId).icon)
	self.label_cost_num:setText(GoodsDataMgr:getItemCount(costId).."/"..costNum)

	if GoodsDataMgr:getItemCount(costId) < costNum then
		self.label_cost_num:setColor(ccc3(255,0,0))
	else
		self.label_cost_num:setColor(ccc3(255,255,255))
	end

	self.Image_sprite_paint:setTexture(spriteCfg.roleModel)

	self.Image_cost_icon:setTouchEnabled(true)
	self.Image_cost_icon:onClick(function ( ... )
		Utils:showInfo(costId)
	end)
end

return HangUpSpriteTrainView