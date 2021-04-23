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

local MaokaPaiqianTip = class("MaokaPaiqianTip",BaseLayer)
local CatListCfg = TabDataMgr:getData("CatList")

function MaokaPaiqianTip:ctor( taskId )
	-- body
	self.super.ctor(self)
    self:showPopAnim(true)
	self.taskInfo = MaokaActivityMgr:getActivityItemInfo(taskId)
	self.choiseList = {}
	self:init("lua.uiconfig.activity.paiqianTip")
end

function MaokaPaiqianTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_3 = TFDirector:getChildByPath(ui,"Image_3")
	self.Panel_right = TFDirector:getChildByPath(ui,"Image_2")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Button_auto = TFDirector:getChildByPath(ui,"Button_auto")
	self.Button_start = TFDirector:getChildByPath(ui,"Button_start")
	self.Panel_item = TFDirector:getChildByPath(ui,"Panel_item")
	self.Button_auto:setVisible(not self.taskInfo.extendData.catTaskList)
	self:updateRightPanel()
	self:updateLeftPanel()
end

function MaokaPaiqianTip:registerEvents( ... )
	self.super.registerEvents(self)
	-- body

	self.Button_close:onClick(function ( ... )
		-- body
		AlertManager:closeLayer(self)
	end)

	-- body
	self.Button_auto:onClick(function ( ... )
		-- body
		local catList = MaokaActivityMgr:getPaiQianCatList(self.taskInfo)
		self.choiseList = {}
		for k,v in ipairs(catList) do
			if v.isFirst then
				table.insert(self.choiseList, v.id)
			end
		end
		self:updateRightPanel()
		self:updateLeftPanel()
	end)

	-- body
	self.Button_start:onClick(function ( ... )
		-- body
		if #self.choiseList < self.taskInfo.extendData.catCount then
			Utils:showTips(13316784)
			return
		end
		MaokaActivityMgr:SEND_ACTIVITY_REQ_START_CAT_EXPLORE(self.taskInfo.id,self.choiseList)
		AlertManager:closeLayer(self)
	end)

end

function MaokaPaiqianTip:updateLeftPanel( ... )
	-- body
	if not self.initLeftPanel then
		self.initLeftPanel = true
		self.label_name = TFDirector:getChildByPath(self.Image_3,"Label_name")
		self.Image_icon = TFDirector:getChildByPath(self.Image_3,"Image_icon")
		self.Label_des = TFDirector:getChildByPath(self.Image_3,"Label_des")
		self.Label_attr1 = TFDirector:getChildByPath(self.Image_3,"Label_attr1")
		self.Label_attr2 = TFDirector:getChildByPath(self.Image_3,"Label_attr2")
	end

	if not self.choiseCat then return end

	local catInfo = MaokaActivityMgr:getCatInfo(self.choiseCat)
	local level = catInfo and catInfo.level or 1
	local catCfg = TabDataMgr:getData("CatList",self.choiseCat)
	self.label_name:setTextById(catCfg.nameTextId)
	self.Image_icon:setTexture(catCfg.icon)
	self.Label_des:setTextById(catCfg.des5)
	self.Label_attr1:setTextById(catCfg.des1, catCfg.attribute[level][2])
	self.Label_attr2:setTextById(catCfg.des3,catCfg.attribute[level][1])
end


function MaokaPaiqianTip:updateRightPanel( ... )
	-- body
	if not self.initRightPanel then
		self.initRightPanel = true
		self.pos = {}
		for i = 1,3 do
			self.pos[i] = TFDirector:getChildByPath(self.Panel_right,"Image_pos"..i)
			self.pos[i].Image_add = TFDirector:getChildByPath(self.pos[i],"Image_add")
			self.pos[i].Image_icon = TFDirector:getChildByPath(self.pos[i],"Image_icon")
			self.pos[i].Image_select = TFDirector:getChildByPath(self.pos[i],"Image_select")

		end

		local ScrollView_list = TFDirector:getChildByPath(self.Panel_right,"ScrollView_list")

		self.gridView_list = UIGridView:create(ScrollView_list)
		self.gridView_list:setItemModel(self.Panel_item)
		self.gridView_list:setColumn(5)
		self.gridView_list:setColumnMargin(0)
		self.gridView_list:setRowMargin(3)
	end

	local catList = MaokaActivityMgr:getPaiQianCatList(self.taskInfo)

	for i = #catList,1,-1 do
		local info = MaokaActivityMgr:getCatInfo(catList[i].id)
		if table.find(self.choiseList, catList[i].id) ~= -1 then -- 一键派遣出去把已上阵的猫丢弃
			table.remove(catList,i)
		end
	end

	local num = #catList - #self.gridView_list:getItems()

	if num < 0 then
		for i = 1,math.abs(num) do
			self.gridView_list:removeItem(1)
		end
	end

	for k,v in ipairs(catList) do
		local item = self.gridView_list:getItem(k)
		if not item then
			item = self.gridView_list:pushBackDefaultItem(item)
		end
		self:updateItem(item, v)
	end
	self.choiseCat = self.choiseCat or catList[1].id
	self:updatePosList()
end

function MaokaPaiqianTip:updatePosList( ... )
	-- body
	for i,v in ipairs(self.pos) do
		v:setVisible(i <= self.taskInfo.extendData.catCount)
		v.Image_add:setVisible(not self.choiseList[i])
		v.Image_icon:setVisible(self.choiseList[i])
		if self.choiseList[i] then
			v.Image_icon:setTexture(TabDataMgr:getData("CatList",self.choiseList[i]).icon)
		end
		v.Image_select:setVisible(self.choisePos == i)

		v:setTouchEnabled(true)
		v:onClick(function ( ... )
			-- body
			if self.choisePos == i then return end
			if self.choiseList[i] and self.choiseList[i] > 0 then
				self.choiseCat = self.choiseList[i]
				self:updateLeftPanel()
			end
			self.choisePos = i
			self:updatePosList()
		end)
	end
end

function MaokaPaiqianTip:updateItem( item, data )
	-- body
	local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
	local Image_tuijian = TFDirector:getChildByPath(item,"Image_tuijian")
	local Image_working = TFDirector:getChildByPath(item,"Image_working")
	local Label_exp = TFDirector:getChildByPath(item,"Label_exp")

	local catCfg = TabDataMgr:getData("CatList",data.id)
	local catInfo = MaokaActivityMgr:getCatInfo(data.id)
	local level = catInfo and catInfo.level or 1

	Label_exp:setTextById(catCfg.des3,catCfg.attribute[level][1])
	Image_icon:setTexture(catCfg.icon)
	Image_tuijian:setVisible(data.isFirst)
	Image_working:setVisible(catInfo and catInfo.taskId ~= 0)

	item:setTouchEnabled(catInfo)
	item:setGrayEnabled(not catInfo)

	item:onClick(function ()
			if self.choisePos and self.choisePos > 0 and self.choiseList[self.choisePos] ~= data.id then
				self.choiseList[self.choisePos] = data.id
				self.choisePos = 0
			else
				-- Utils:showTips(13316799)
				if self.choiseCat == data.id then return end
				self.choiseCat = data.id
			end

			self:updateLeftPanel()
			self:updateRightPanel()
		end)
end
return MaokaPaiqianTip