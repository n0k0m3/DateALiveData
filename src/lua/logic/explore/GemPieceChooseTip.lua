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
local GemPieceChooseTip = class("GemPieceChooseTip",BaseLayer)

function GemPieceChooseTip:ctor( quality, ingoreItem, needNum ,callBackFunc)
	-- body
	self.super.ctor(self)
    self.quality = quality
    self.needNum = needNum
    self.ingoreItem = ingoreItem
    self.selectList = {}
    self.callBackFunc = callBackFunc
    self:showPopAnim(true)
    self.showLists = self:getShowList()
    self.curPieceCid = self.showLists[1] and self.showLists[1].cid
	self:init("lua.uiconfig.explore.gemPieceChooseTip")
end

function GemPieceChooseTip:getShowList( ... )
    -- body
    local allPiece = GoodsDataMgr:getItemsBySuperTyper(EC_ResourceType.EXPLORE_TREASUREPIECE)
    local showLists = {}
    for k,v in pairs(allPiece) do
        local itemCfg = GoodsDataMgr:getItemCfg(v.cid)
        if itemCfg.quality == self.quality and table.find(self.ingoreItem, v.cid) == -1 then
            table.insert(showLists, v)
        end
    end
    return showLists
end

function GemPieceChooseTip:initUI( ui )
	-- body
	self.super.initUI(self,ui)
	self.Image_icon = TFDirector:getChildByPath(ui,"Image_icon")
    self.Image_icon:setTexture("ui/explore/growup/common/quality_di_"..self.quality..".png")
	self.Label_allnum = TFDirector:getChildByPath(ui,"Label_allnum")
    self.Image_man = TFDirector:getChildByPath(ui,"Image_man")
	self.Label_name = TFDirector:getChildByPath(ui,"Label_name")
	self.Button_down = TFDirector:getChildByPath(ui,"Button_down")
	self.Button_up = TFDirector:getChildByPath(ui,"Button_up")
	self.Button_max = TFDirector:getChildByPath(ui,"Button_max")
	self.Label_num = TFDirector:getChildByPath(ui,"Label_num")
	self.Button_sure = TFDirector:getChildByPath(ui,"Button_sure")
	self.Button_close = TFDirector:getChildByPath(ui,"Button_close")
	self.Panel_goodItem = TFDirector:getChildByPath(ui,"Panel_goodItem")
    
    self.Label_empty = TFDirector:getChildByPath(ui,"Label_empty")

    self.Label_empty:setVisible(#self.showLists == 0)

	local ScrollView_List = TFDirector:getChildByPath(ui,"ScrollView_List")
	self.uiGrid_list = UIGridView:create(ScrollView_List)
    self.uiGrid_list:setItemModel(self.Panel_goodItem)
	self.uiGrid_list:setColumn(7)
    self.uiGrid_list:setColumnMargin(-5)

    self:refreshView()
end

function GemPieceChooseTip:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

    self.Button_close:onClick(function ( ... )
        -- body
        AlertManager:closeLayer(self)
    end)

    self.Button_sure:onClick(function ( ... )
        -- body
        local num = self.needNum - self:getCurChooseAllNum() 
        if num > 0 then
            Utils:showTips(13311262,num)
            return
        end

        if self.callBackFunc then
            self.callBackFunc(self.quality, self.selectList)
        end
        AlertManager:closeLayer(self)
    end)

	self.Button_up:onTouch(function(event)
            if event.name == "ended" then
                if self.inTiming then
                    self.inTiming = false
                    self:onTouchButtonUp();
                end
                TFDirector:removeTimer(self.timer)
                self.timer = nil;
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:onTouchButtonUp();
                self:holdDownAction(true)
            end
        end)

    self.Button_down:onTouch(function(event)
            if event.name == "ended" then
                if self.inTiming then
                    self.inTiming = false
                    self:onTouchButtonDown();
                end
                TFDirector:removeTimer(self.timer)
                self.timer = nil;
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:onTouchButtonDown()
                self:holdDownAction(false);
            end
        end)

    self.Button_max:onClick(function()
            local count = self.needNum - self:getCurChooseAllNum()
            self:updateBatchPanel(count)
    end)
end

function GemPieceChooseTip:refreshView( ... )
	-- body
	self:updatePieceList()
    self:updateBatchPanel(0)
end

function GemPieceChooseTip:getCurChooseAllNum( ... )
    -- body
    local allNum = 0

    for k,v in pairs(self.selectList) do
        allNum = allNum + v
    end
    return allNum
end

function GemPieceChooseTip:updateInfo( ... )
	-- body
    local allNum = self:getCurChooseAllNum()
    local color = allNum >= self.needNum and ccc3(48,84,143) or ccc3(231,61,101)
	self.Label_allnum:setText(string.format("%d/%d",allNum,self.needNum))
    self.Label_allnum:setColor(color)
    self.Image_man:setVisible(allNum >= self.needNum)

    if self.curPieceCid then
        local itemCfg = GoodsDataMgr:getItemCfg(self.curPieceCid)
	   self.Label_name:setTextById(itemCfg.nameTextId)
    else
       self.Label_name:setText("")
    end
	
end

function GemPieceChooseTip:updatePieceList( ... )
	-- body
	for k,v in pairs(self.showLists) do
		local item = self.uiGrid_list:getItem(k)
		if not item then
			item = self.Panel_goodItem:clone()
			self.uiGrid_list:pushBackCustomItem(item)
		end

		local Image_select = TFDirector:getChildByPath(item,"Image_select")
		local Image_selected = TFDirector:getChildByPath(item,"Image_selected")
        local Image_gemPiece = TFDirector:getChildByPath(item,"Image_gemPiece")
        local isSelected = self.selectList[v.cid] and self.selectList[v.cid] > 0
        local isSelect = self.curPieceCid == v.cid

        Image_select:setVisible(isSelect)
        Image_selected:setVisible(isSelected and not isSelect)

        if not item.goodItem then
            local panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            panel_goodsItem:setPosition(ccp(0,0))
            panel_goodsItem:setScale(0.9)
            item:addChild(panel_goodsItem)
            item.goodItem = panel_goodsItem
        end
        local chooseNum = self.selectList[v.cid] or 0
        local count = GoodsDataMgr:getItemCount(v.cid) - chooseNum
        PrefabDataMgr:setInfo(item.goodItem, v.cid, count)
        --item:setGrayEnabled(count <=0)
        local opacity = count <=0 and 120 or 255
        Image_gemPiece:setOpacity(opacity)
        item.goodItem:setOpacity(opacity)
        item.goodItem:setTouchEnabled(false)
        item:setTouchEnabled(true)
        item:onClick(function ( ... )
            -- body
            self.curPieceCid = v.cid
            self:refreshView()
        end)
	end
end

function GemPieceChooseTip:removeEvents()
    if self.itemInfo_ then
        self:removeCountDownTimer()
    end
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function GemPieceChooseTip:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        self.inTiming = true
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

    self.timer = TFDirector:addTimer(100, -1, nil, action)
end

function GemPieceChooseTip:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function GemPieceChooseTip:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function GemPieceChooseTip:updateBatchPanel(num)
    local num = math.min(self.needNum - self:getCurChooseAllNum(), num)
    if self.curPieceCid then 
        self.selectList[self.curPieceCid] = self.selectList[self.curPieceCid] or 0
        self.selectList[self.curPieceCid] = self.selectList[self.curPieceCid] + num;

        self.selectList[self.curPieceCid] = math.max(0, self.selectList[self.curPieceCid])
        self.selectList[self.curPieceCid] = math.min(GoodsDataMgr:getItemCount(self.curPieceCid), self.selectList[self.curPieceCid])
        
        self.Label_num:setString(GoodsDataMgr:getItemCount(self.curPieceCid).."/"..self.selectList[self.curPieceCid]);
    else
        self.Label_num:setString(0);
    end
    if not self.inTiming then
        self:updatePieceList()
    end
    self:updateInfo()
end


return GemPieceChooseTip