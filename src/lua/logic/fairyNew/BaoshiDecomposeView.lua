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
* -- 宝石分解界面
]]

local BaoshiDecomposeView = class("BaoshiDecomposeView",BaseLayer)

function BaoshiDecomposeView:ctor( data )
	-- body
	self.super.ctor(self,data)
	self:initData(data)
	self:init("lua.uiconfig.fairyNew.baoshiDecomposeView")
end

function BaoshiDecomposeView:initData( data )
	self.curTab = 1
	self.selectNum = 0
	self.deComposeIdList = {}
end

function BaoshiDecomposeView:initUI( ui )
	self.super.initUI(self,ui)
	self.btn_tab1 = TFDirector:getChildByPath(ui,"btn_tab1")
	self.btn_tab2 = TFDirector:getChildByPath(ui,"btn_tab2")

	self.btn_decompose = TFDirector:getChildByPath(ui,"btn_decompose")
	self.btn_choose = TFDirector:getChildByPath(ui,"btn_choose")
	self.btn_close = TFDirector:getChildByPath(ui,"btn_close")
	self.Label_nilTips = TFDirector:getChildByPath(ui,"Label_nilTips")

	self.Panel_baoshi = TFDirector:getChildByPath(ui,"Panel_baoshi")
	self.Panel_tuzhi = TFDirector:getChildByPath(ui,"Panel_tuzhi")

	self.Panel_baoshi_item = TFDirector:getChildByPath(ui,"Panel_baoshi_item")

	local Scrollview_baoshi = TFDirector:getChildByPath(self.Panel_baoshi,"Scrollview_baoshi")
	self.uiGrid_baoshi = UIGridView:create(Scrollview_baoshi)
  	self.uiGrid_baoshi:setItemModel(self.Panel_baoshi_item)
  	self.uiGrid_baoshi:setColumn(3)

  	local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_baoshi, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.uiGrid_baoshi:setScrollBar(scrollBar)

	local Scrollview_material = TFDirector:getChildByPath(self.Panel_baoshi,"Scrollview_material")
	self.uiGrid_material = UIGridView:create(Scrollview_material)
	local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	goodsItem:setScale(0.75)
  	self.uiGrid_material:setItemModel(goodsItem)
  	self.uiGrid_material:setColumn(4)

  	local Scrollview_tuzhi = TFDirector:getChildByPath(self.Panel_tuzhi,"Scrollview_baoshi")
	self.uiGrid_tuzhi = UIGridView:create(Scrollview_tuzhi)
  	self.uiGrid_tuzhi:setItemModel(self.Panel_baoshi_item)
  	self.uiGrid_tuzhi:setColumn(3)

  	local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_tuzhi, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.uiGrid_tuzhi:setScrollBar(scrollBar)

	local Scrollview_material1 = TFDirector:getChildByPath(self.Panel_tuzhi,"Scrollview_material")
	self.uiGrid_material1 = UIGridView:create(Scrollview_material1)
	local goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
	goodsItem:setScale(0.75)
  	self.uiGrid_material1:setItemModel(goodsItem)
  	self.uiGrid_material1:setColumn(4)

	local Scrollview_decompose = TFDirector:getChildByPath(self.Panel_tuzhi,"Scrollview_decompose")
	self.uiGrid_decompose = UIGridView:create(Scrollview_decompose)
  	self.uiGrid_decompose:setItemModel(self.Panel_baoshi_item)
  	self.uiGrid_decompose:setColumn(3)

  	self.Button_up = TFDirector:getChildByPath(self.Panel_tuzhi,"Button_up")
  	self.Button_down = TFDirector:getChildByPath(self.Panel_tuzhi,"Button_down")
  	self.Button_max = TFDirector:getChildByPath(self.Panel_tuzhi,"Button_max")
  	self.selectNumLab = TFDirector:getChildByPath(self.Panel_tuzhi,"Label_num")

  	self:updateView()
end

function BaoshiDecomposeView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function BaoshiDecomposeView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function BaoshiDecomposeView:updateBatchPanel(num)
	local offsetNum = self.selectNum
    self.selectNum = self.selectNum + num;
    if self.selectNum <= 0 then
        self.selectNum = 0;
    end

    local maxCnt = self:getMaxCnt()
    if self.selectNum >= maxCnt then
        self.selectNum = maxCnt
    end

    offsetNum = self.selectNum - offsetNum
    self.selectNumLab:setString(self.selectNum)
    
    if offsetNum ~= 0 and self.selectedTuzhi then
	    local isHave = false
	   	for k,v in pairs(self.deComposeIdList) do
	   		if v.id == self.selectedTuzhi.data.id then
	   			isHave = true
	   			v.num = self.selectNum
	   			v.tmpNum = v.num
	   			self.selectedTuzhi.data.tmpNum = self.selectedTuzhi.data.tmpNum - offsetNum
	   			self.selectedTuzhi.data.tmpNum = math.max(0,self.selectedTuzhi.data.tmpNum)
	   			self.selectedTuzhi.data.tmpNum = math.min(self.selectedTuzhi.data.num,self.selectedTuzhi.data.tmpNum)
	   			self.selectedTuzhi.label_num:setString(self.selectedTuzhi.data.tmpNum)
	   			if v.num <= 0 then
	   				table.removeItem(self.deComposeIdList,v)
	   				break
	   			end
	   		end
	   	end
	   	if not isHave and self.selectNum > 0 then
			self.selectedTuzhi.data.tmpNum = self.selectedTuzhi.data.tmpNum - offsetNum
			self.selectedTuzhi.data.tmpNum = math.max(0,self.selectedTuzhi.data.tmpNum)
			self.selectedTuzhi.data.tmpNum = math.min(self.selectedTuzhi.data.num,self.selectedTuzhi.data.tmpNum)
	   		self.selectedTuzhi.label_num:setString(self.selectedTuzhi.data.tmpNum)
	   		table.insert(self.deComposeIdList,{id = self.selectedTuzhi.data.id, num = self.selectNum, cid = self.selectedTuzhi.data.cid })
	   	end
	   	self:updateDecomposeList()
	   	self:updateMaterialList()
   	end
end

-- function BaoshiDecomposeView:updateSelectedTuzhiData(v)
-- 	for k,v in pairs(self.deComposeIdList) do
--    		if v.id = self.selectedTuzhi.data.id then
--    			v.num = v.num + num
--    			self.selectedTuzhi.data.num = self.selectedTuzhi.data.num - num
--    			self.selectedTuzhi.label_num:setString(self.selectedTuzhi.data.num)
--    		end
--    	end
-- end

function BaoshiDecomposeView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end


function BaoshiDecomposeView:removeEvents()
	self.super.removeEvents(self)
	if self.timer then
		TFDirector:stopTimer(self.timer)
		TFDirector:removeTimer(self.timer)
		self.timer = nil
	end
end

function BaoshiDecomposeView:registerEvents()
	-- body
	self.super.registerEvents(self)
	self.btn_tab1:onClick(function ( ... )
		self.curTab = 1
		self.deComposeIdList = {}
		self:updateView()
	end)

	self.btn_tab2:onClick(function ( ... )
		self.curTab = 2
		self.deComposeIdList = {}
		self:updateView()
	end)

	self.btn_close:onClick(function ( ... )
		AlertManager:closeLayer(self)
	end)

	self.btn_choose:onClick(function ( ... )
		Utils:openView("fairyNew.BaoshiTuzhiSortView",{decompose = true, isTuZhi = self.curTab == 2})
	end)

	self.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
            if not self.selectedTuzhi then
				Utils:showTips(494008);
				return;
			end
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self.Button_down:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
            if not self.selectedTuzhi then
				Utils:showTips(494008);
				return;
			end
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonDown()
            self:holdDownAction(false);
        end
    end)

    self.Button_max:onClick(function()
		if not self.selectedTuzhi then
			Utils:showTips(494008);
			return;
		end
        
        local maxCnt = self:getMaxCnt()
        self.selectNum = 0
        self:updateBatchPanel(maxCnt)
    end)

	self.btn_decompose:onClick(function ( ... )
		if #self.deComposeIdList > 0 then
			
			local args = {
	            tittle = 2107025,
	            reType = "decomposeShowtip",
	            content = TextDataMgr:getText(1100055),
	            confirmCall = function ( ... )
	            	if self.curTab == 1 then
						local msg = {}
						for k,v in pairs(self.deComposeIdList) do
							table.insert(msg,v.id)
						end
						EquipmentDataMgr:reqDecomposeGem(msg)
					else
						local msg = {}
						for k,v in pairs(self.deComposeIdList) do
							table.insert(msg,{v.id, v.num})
						end
						EquipmentDataMgr:reqDecomposeGemSigns(msg)
					end
	            end,
	        }
	        Utils:showReConfirm(args)

			
		else
			Utils:showTips(1100044)
		end
	end)
	EventMgr:addEventListener(self,EQUIPMENT_GEM_TUZHI_SORT,handler(self.onChooseCallBack, self))
	EventMgr:addEventListener(self,EQUIPMENT_GEM_DECOMPOSE_GEM,function ( data )
		-- body
		Utils:showReward(data.items)
		self.deComposeIdList = {}
		self:updateView()
	end)
	
end

function BaoshiDecomposeView:onChooseCallBack( heroId, rarity, isDecompose )
	-- body
	if not isDecompose then return end
	for k,v in pairs(self.gemsData) do
		local cfg = EquipmentDataMgr:getGemCfg(v.cid)
		if not ((heroId and  heroId ~= cfg.heroId) or (rarity and rarity ~= cfg.rarity))  then

			for j,l in pairs(self.deComposeIdList) do
				if l.id == v.id then
					table.removeItem(self.deComposeIdList,l)
				end
			end

			if v.num then
				v.tmpNum = 0
			end
			local _v = clone(v)
			if v.num then
				_v.tmpNum = v.num
			end
			table.insert(self.deComposeIdList,_v)
		end
	end
	self:flushContent()
end

function BaoshiDecomposeView:updateView(  )
	-- body
	self.btn_tab1:setTouchEnabled(self.curTab ~= 1)
	self.btn_tab1:setTextureNormal(self.curTab == 1 and "ui/common/6.png" or "ui/common/7.png")
	self.btn_tab2:setTouchEnabled(self.curTab ~= 2)
	self.btn_tab2:setTextureNormal(self.curTab == 2 and "ui/common/6.png" or "ui/common/7.png")

	self.Panel_baoshi:setVisible(self.curTab == 1)
	self.Panel_tuzhi:setVisible(self.curTab == 2)

	if self.curTab == 1 then
		self.gemsData = EquipmentDataMgr:getCanDecomposeGemInfos()
	else
		self.gemsData = EquipmentDataMgr:getCanDecomposeTuzhi()
	end
	self:flushContent()
end

function BaoshiDecomposeView:flushContent()
	if self.curTab == 1 then
		self:updateBaoshiList()
	else
		self:updateTuzhiList()
		self:updateDecomposeList()
		self.selectNum = 0
		self.selectedTuzhi = nil
		self:updateBatchPanel(0)
	end
	self:updateMaterialList()
end

function BaoshiDecomposeView:updateBaoshiList( )
    self.Label_nilTips:setVisible(#self.gemsData == 0)
    self.uiGrid_baoshi:removeAllItems()
    for k,v in pairs(self.gemsData) do
    	local item = self.uiGrid_baoshi:pushBackDefaultItem()
    	self:updateBaoshiItem(item,v)
    	item:setTouchEnabled(true)
	    item:onClick(function()
	       if self:isSelect(v) then
		       	for j,l in pairs(self.deComposeIdList) do
		       		if l.id == v.id then
		       			table.removeItem( self.deComposeIdList, l)
		       			break
		       		end
		       	end
	    		item.Image_select:setVisible(false)
	       else
		       	table.insert(self.deComposeIdList, clone(v))
	    		item.Image_select:setVisible(true)
		   end
	       self:updateMaterialList()
    	end)
    end
end

function BaoshiDecomposeView:updateTuzhiList( )
    self.Label_nilTips:setVisible(#self.gemsData == 0)
    self.uiGrid_tuzhi:removeAllItems()
    self.selectedTuzhi = nil
    for k,v in pairs(self.gemsData) do
    	local item = self.uiGrid_tuzhi:pushBackDefaultItem()
    	self:updateBaoshiItem(item, v, true)
    	item:setTouchEnabled(true)
	    item:onClick(function()
	    	if self.selectedTuzhi then
	    		self.selectedTuzhi.Image_select:hide()
	    	end
	       	self.selectedTuzhi = item
    		self.selectedTuzhi.Image_select:show()
    		self.selectNum = self:getSelectNum()
    		self:updateBatchPanel(0)
	    end)
    end
end

function BaoshiDecomposeView:updateMaterialList( )
	-- body
	local materials = {}

	for k,v in pairs(self.deComposeIdList) do
		local cfg = EquipmentDataMgr:getGemCfg(v.cid)
		if cfg.sellProfit2 then
			local time = v.num or 1
			for j,l in pairs(cfg.sellProfit2) do
				materials[l[1]] = materials[l[1]] or 0
				materials[l[1]] = materials[l[1]] + l[2]*time
			end
		end
	end
	local curView = nil
	if self.curTab == 1 then
		curView = self.uiGrid_material
	else
		curView = self.uiGrid_material1
	end
	curView:removeAllItems()
	for id, num in pairs(materials) do
		local item = curView:pushBackDefaultItem()
		PrefabDataMgr:setInfo(item,id,num)
	end
end

function BaoshiDecomposeView:cancelSelectedTuzhi(data)
	for k,v in pairs(self.gemsData) do
		if v.id == data.id then
			v.tmpNum = v.num
		end
	end
   	table.removeItem(self.deComposeIdList,data)
   	self:updateMaterialList()
   	self:updateDecomposeList()
   	self:updateTuzhiList()
end

function BaoshiDecomposeView:updateDecomposeList( )
	self.uiGrid_decompose:removeAllItems()
	for k, v in pairs(self.deComposeIdList) do
		local item = self.uiGrid_decompose:pushBackDefaultItem()
		self:updateBaoshiItem(item,v,true)
		item:setTouchEnabled(true)
	    item:onClick(function()
	    	self:cancelSelectedTuzhi(v)
	    end)
	end
end

function BaoshiDecomposeView:getMaxCnt()
	if self.selectedTuzhi then
		return self.selectedTuzhi.data.num
	end
	return 0
end

function BaoshiDecomposeView:getSelectNum()
	if self.selectedTuzhi then
		for k,v in pairs(self.deComposeIdList) do
			if v.id == self.selectedTuzhi.data.id then
				return v.num ;
			end
		end
	end
	return 0;
end

function BaoshiDecomposeView:isSelect( data )
	for k,v in pairs(self.deComposeIdList) do
		if v.id == data.id then
			return true
		end
	end
	return false
end

function BaoshiDecomposeView:updateBaoshiItem(item, data, noShowSelect)
    local Image_bg = TFDirector:getChildByPath(item,"Image_bg")
    local Image_icon = TFDirector:getChildByPath(item,"Image_icon")
    local Image_quality = TFDirector:getChildByPath(item,"Image_quality")
    local label_num = TFDirector:getChildByPath(item,"label_num"):hide()

    local Image_select = TFDirector:getChildByPath(item,"Image_select"):hide()
    local Image_pos_bg = TFDirector:getChildByPath(item,"Image_pos_bg")
    local btn_info = TFDirector:getChildByPath(item,"btn_info")

    btn_info:onClick(function ( ... )
    	if data.cid == data.id then
	    	Utils:showInfo(data.cid,nil,false)
    	else
	    	Utils:showInfo(data.cid,data.id,false)
	    end
    end)

    local cfg = EquipmentDataMgr:getGemCfg(data.cid)
    Image_bg:setTexture(EC_ItemIcon[cfg.quality])
    Image_icon:setTexture(cfg.icon)
    Image_quality:setTexture(EquipmentDataMgr:getGemRarityIcon(cfg.rarity))
    Image_pos_bg:setTexture(EquipmentDataMgr:getGemPosBg(cfg.quality))
    
	item.data = data
	item.Image_select = Image_select
	item.label_num = label_num
    for i=1,4 do
        local Image_pos = TFDirector:getChildByPath(item,"Image_pos"..i)
        Image_pos:setTexture(cfg.skillType == i and "ui/fairy/new_ui/baoshi/032.png" or "ui/fairy/new_ui/baoshi/031.png")
    end

    if data.num then
    	data.tmpNum = data.tmpNum or data.num
    	label_num:setText(data.tmpNum)
    	label_num:show()
    end
    Image_select:setVisible(self:isSelect(data) and not noShowSelect)
   
end

return BaoshiDecomposeView