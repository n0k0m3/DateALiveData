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
* -- 宝石重铸界面
]]
local BaoshiRecastView = class("BaoshiRecastView",BaseLayer)

function BaoshiRecastView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.fairyNew.baoshiRecastView")
end

function BaoshiRecastView:initData( data )
	self.gemInfo = EquipmentDataMgr:getGemInfo(data)
	for k,v in pairs(EquipmentDataMgr:getAllGemsData()) do
		if v.randSkillTemp then
			self.gemInfo = v
		end
	end
	self.cost =TabDataMgr:getData("DiscreteData",62001).data.cost
	self.currentChooseAttrIndex = not self.gemInfo.randSkillTemp and 1 or nil
end

function BaoshiRecastView:initUI( ui )
	self.super.initUI(self,ui)
	local Panel_left = TFDirector:getChildByPath(ui,"Panel_left")
	self.Panel_center = TFDirector:getChildByPath(Panel_left,"Panel_center")
	self.label_gemName = TFDirector:getChildByPath(Panel_left,"label_gemName")
	self.image_pos = TFDirector:getChildByPath(Panel_left,"image_pos")

	local Panel_right = TFDirector:getChildByPath(ui,"Panel_right")
  	self.btn_cancel = TFDirector:getChildByPath(Panel_right,"btn_cancel")
  	self.btn_recast = TFDirector:getChildByPath(Panel_right,"btn_recast")
  	self.btn_sure = TFDirector:getChildByPath(Panel_right,"btn_sure")

  	self.attrItem = {}
  	for i = 1,3 do
  		self.attrItem[i] = TFDirector:getChildByPath(Panel_right,"Panel_item"..i)
	end
	self.costItem = TFDirector:getChildByPath(Panel_right,"Panel_cost1")
	self.costItem.Image_res_icon = TFDirector:getChildByPath(self.costItem,"Image_res_icon") 
	self.costItem.Label_res_num = TFDirector:getChildByPath(self.costItem,"Label_res_num") 
  	
	self:updateLeft()
	self:updateRight()
end

function BaoshiRecastView:registerEvents(  )
	self.super.registerEvents(self)
	self.btn_sure:onClick(function ( ... )
		if self.gemInfo.randSkillTemp then
			EquipmentDataMgr:reqRemouldedGem(self.gemInfo.id,true)
		end
	end)

	self.btn_cancel:onClick(function ( ... )
		if self.gemInfo.randSkillTemp then
			EquipmentDataMgr:reqRemouldedGem(self.gemInfo.id,false)
		end
	end)

	self.btn_recast:onClick(function ( ... )
		local cost = self.cost[self.currentChooseAttrIndex]
		local isEnough = true

		for k,v in pairs(cost) do
			if not GoodsDataMgr:currencyIsEnough(k, v) then
				isEnough = false
			end
		end

		if isEnough then
			EquipmentDataMgr:reqRemouldGem(self.gemInfo.id,self.gemInfo.randSkill[self.currentChooseAttrIndex])
		else
			Utils:showTips(1100046)
		end
	end)

	EventMgr:addEventListener(self,EQUIPMENT_GEM_REMOULD_GEM,function ( ... )
		self.gemInfo = EquipmentDataMgr:getGemInfo(self.gemInfo.id)
		self:updateRight()
	end)

	EventMgr:addEventListener(self,EQUIPMENT_GEM_REMOULDED_GEM,function ( ... )
		self.gemInfo = EquipmentDataMgr:getGemInfo(self.gemInfo.id)
		self:updateLeft()
		self:updateRight()
	end)
	
end

function BaoshiRecastView:updateLeft( )
	self:updateBaoshiItem(self.Panel_center,self.gemInfo)
	local cfg = EquipmentDataMgr:getGemCfg(self.gemInfo.cid)
	self.label_gemName:setTextById(tonumber(cfg.nameTextId))
	self.image_pos:setTexture("ui/fairy/new_ui/baoshi/skillType_"..cfg.skillType..".png")
end

function BaoshiRecastView:updateBaoshiItem(item, data)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
    local Image_quality_bg = TFDirector:getChildByPath(item,"Image_quality_bg")
    local cfg = EquipmentDataMgr:getGemCfg(data.cid)
    Image_bg:setTexture(EquipmentDataMgr:getGemIconBg(cfg.quality))
    Image_icon:setTexture(cfg.icon)
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    Image_quality_bg:setTexture(EquipmentDataMgr:getGemQualityBg(cfg.quality))
end

function BaoshiRecastView:updateRight( )
	local cfg = EquipmentDataMgr:getGemCfg(self.gemInfo.cid)
	local recastInfo = self.gemInfo.randSkillTemp
	for i = 1,3 do
		local skillId = self.gemInfo.randSkill[i]
		local item = self.attrItem[i]
		item:show()
		local Panel_normal = TFDirector:getChildByPath(item,"Panel_normal"):hide()
		local Panel_select = TFDirector:getChildByPath(item,"Panel_select"):hide()
		local parent = nil
		if self.currentChooseAttrIndex == i or (recastInfo and recastInfo.originalSkill == skillId) then -- 选中或者是重铸确认阶段直接定位选择位置
			self.currentChooseAttrIndex = i
			parent = Panel_select
		else
			parent = Panel_normal
		end

		parent:show()
		local image_icon = TFDirector:getChildByPath(parent,"image_icon")
		local label_skillName1 = TFDirector:getChildByPath(parent,"label_skillName1")
		local label_attrDes1 = TFDirector:getChildByPath(parent,"label_attrDes1")
		local label_skillName2 = TFDirector:getChildByPath(parent,"label_skillName2")
		local label_attrDes2 = TFDirector:getChildByPath(parent,"label_attrDes2")
		local label_unName = TFDirector:getChildByPath(parent,"label_unName")
		local image_3 = TFDirector:getChildByPath(parent,"image_3")

		local btn_tips = TFDirector:getChildByPath(parent,"btn_tips")
		btn_tips:onClick(function ( ... )
			-- body
            Utils:openView("fairyNew.BaoshiSkillShowView", i, self.gemInfo.cid)
		end)
		image_icon:setScale(0.65)
		if recastInfo and recastInfo.originalSkill == skillId then
			local oldSkillCfg = TabDataMgr:getData("PassiveSkills",recastInfo.originalSkill)
			image_icon:setTexture(oldSkillCfg.icon)
			label_skillName1:setTextById(tonumber(oldSkillCfg.name))
			local text = TextDataMgr:getText(tonumber(oldSkillCfg.des))
			text = string.gsub(text,'#',cfg.skillName)
			label_attrDes1:setText(text)

			local newSkillCfg = TabDataMgr:getData("PassiveSkills",recastInfo.newSkill)
			label_skillName2:setTextById(tonumber(newSkillCfg.name))
			local text = TextDataMgr:getText(tonumber(newSkillCfg.des))
			text = string.gsub(text,'#',cfg.skillName)
			label_attrDes2:setText(text)
			image_3:show()
			label_skillName2:show()
			label_attrDes2:show()
			label_unName:hide()
		elseif skillId then
			local oldSkillCfg = TabDataMgr:getData("PassiveSkills",skillId)
			image_icon:setTexture(oldSkillCfg.icon)
			label_skillName1:setTextById(tonumber(oldSkillCfg.name))
			local text = TextDataMgr:getText(tonumber(oldSkillCfg.des))
			text = string.gsub(text,"#",cfg.skillName)
			label_attrDes1:setText(text)
			parent:setTouchEnabled(not recastInfo)
			parent:onClick(function ( ... )
				self.currentChooseAttrIndex = i
				self:updateRight()
			end)
			if image_3 then image_3:hide() end
			if label_skillName2 then label_skillName2:hide() end
			if label_attrDes2 then label_attrDes2:hide() end
			label_unName:show()
		else
			item:hide()
		end
	end
	self.btn_recast:setTextureNormal(self.currentChooseAttrIndex and "ui/fairy/new_ui/baoshi/052.png" or "ui/fairy/new_ui/baoshi/055.png")
	self.btn_recast:setVisible(not recastInfo)
	self.btn_sure:setVisible(recastInfo)
	self.btn_cancel:setVisible(recastInfo)
	local cost = self.cost[self.currentChooseAttrIndex]
	for k,v in pairs(cost) do
		local cfg = GoodsDataMgr:getItemCfg(k)
		self.costItem.Image_res_icon:setTexture(cfg.icon)
		self.costItem.Label_res_num:setText(v)

		if not GoodsDataMgr:currencyIsEnough(k,v) then
			self.costItem.Label_res_num:setFontColor(ccc3(255,0,0))
		else
			self.costItem.Label_res_num:setFontColor(ccc3(255,255,255))
		end
		
		self.costItem:setTouchEnabled(true)
		self.costItem:onClick(function ( ... )
			Utils:showInfo(k)
		end)
	end

	self.costItem:setVisible(not recastInfo)
end

return BaoshiRecastView
