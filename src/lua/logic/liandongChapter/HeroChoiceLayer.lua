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
local HeroChoiceLayer = class("HeroChoiceLayer",BaseLayer)

function HeroChoiceLayer:ctor(callBack,ingoreHeros)
	-- body
	self.super.ctor(self)
    self.name = "HeroChoiceLayer"
    self:showPopAnim(true)
    local showList = clone(HeroDataMgr:resetShowList(true))
    self.showHeroIds = {}
    for k,v in ipairs(showList) do
        local showIndex = HeroDataMgr:getSelectedHeroIdx(v);
        local heroid = HeroDataMgr:getSelectedHeroId(showIndex)
        -- todo 屏蔽已选择精灵
        if table.find(ingoreHeros or {}, heroid) == -1 then
	        table.insert(self.showHeroIds,heroid)
	    end
    end

    table.sort(self.showHeroIds,function (a,b)
    	-- body
    	local powerA = HeroDataMgr:getHeroPower(a)
    	local powerB = HeroDataMgr:getHeroPower(b)

    	if powerA == powerB then
    		return a < b
		else
    		return powerA > powerB
    	end
    end)
    self.callBack = callBack
	self:init("lua.uiconfig.activity.heroChoiceLayer")
end

function HeroChoiceLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.tableView          = TFDirector:getChildByPath(ui,"tableView")
    self.panel_item			= TFDirector:getChildByPath(ui,"Panel_item");
    self.Button_ok		= TFDirector:getChildByPath(ui,"Button_ok");
    self.Button_cancel		= TFDirector:getChildByPath(ui,"Button_cancel");

    self.qualityImg			= TFDirector:getChildByPath(ui,"Image_hero_puality");
    self.qualityImg:setScale(0.2);

    self.titleLabel			= TFDirector:getChildByPath(ui,"Label_name_title");
    self.Label_power		= TFDirector:getChildByPath(ui,"Label_power");


    self.tableViewNew = TFTableView:create()
    self.tableViewNew:setTableViewSize(self.tableView:getContentSize())
    self.tableViewNew:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    self.tableViewNew:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)

    self.tableViewNew:addMEListener(TFTABLEVIEW_SIZEFORINDEX, self.cellSizeForTable)
    self.tableViewNew:addMEListener(TFTABLEVIEW_SIZEATINDEX, self.tableCellAtIndex)
    self.tableViewNew:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, self.numberOfCellsInTableView)

    self.tableViewNew.logic = self
    self.tableView:addChild(self.tableViewNew)

    self:updateBaseInfo()
    self.tableViewNew:reloadData()
end

function HeroChoiceLayer:registerEvents( ... )
	-- body
	self.super.registerEvents(self)

	self.Button_ok:onClick(function ( ... )
		-- body
        if self.callBack and self.showid then
            self.callBack(self.showid)
        end
	end)

	self.Button_cancel:onClick(function ( ... )
		-- body
		self.showid = nil
		AlertManager:closeLayer(self)
	end)
end

function HeroChoiceLayer.cellSizeForTable(table, idx)
    local self = table.logic
    local size = self.panel_item:getContentSize() 
    return size.height, size.width
end

function HeroChoiceLayer.tableCellAtIndex(table, idx)
    local self = table.logic
    local cell = table:dequeueCell()
    if nil == cell then
        table.cells = table.cells or {}
        cell = TFTableViewCell:create()
        local parentNode = self.panel_item:clone()
        parentNode:setVisible(true)
        parentNode:setPosition(ccp(0,0))
        cell:addChild(parentNode)
        cell.node = parentNode
        table.cells[cell] = true
    end
    local itemNode = cell.node
    self:updateOneHead(itemNode, idx + 1)
    return cell
end

function HeroChoiceLayer:onClose(  )
	-- body
	self.super.onClose(self)
end

function HeroChoiceLayer.numberOfCellsInTableView(table)
    local self = table.logic
    return #self.showHeroIds
end

function HeroChoiceLayer:updateUI()
    self.selectImg = nil;
    self.tableViewNew:reloadData()
end

function HeroChoiceLayer:updateBaseInfo( ... )
    -- body
    self.titleLabel:setText("");
    self.Label_power:setString(0);
    self.Button_ok:setGrayEnabled(not self.showid)
    self.Button_ok:setTouchEnabled(self.showid)
    if not self.showid then return end
    self.titleLabel:setTextById(HeroDataMgr:getTitleStrId(self.showid));
    self.qualityImg:setTexture(HeroDataMgr:getQualityPic(self.showid));
    self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)));

end

function HeroChoiceLayer:updateOneHead(cell,idx,isChange)
    cell:setTouchEnabled(true);
    cell:onClick(function()
        if self.showidx ~= idx then
            self.showidx = idx
            self.firstTouchIn  = true;
        end
        self.showid = self.showHeroIds[self.showidx]
        self.firstTouchIn  = false;
        self.tableViewNew:reloadData();
        self:updateBaseInfo()

    end)
    local heroid = self.showHeroIds[idx]
    local skinid = HeroDataMgr:getCurSkin(heroid);
    local data = TabDataMgr:getData("HeroSkin", skinid)

    local Panel_mask = TFDirector:getChildByPath(cell, "Panel_mask")
    local Image_diban = TFDirector:getChildByPath(Panel_mask, "Image_diban")
    local Panel_model = TFDirector:getChildByPath(Panel_mask, "Panel_model")
    Panel_model:setBackGroundColorType(0)
    local Image_hero = TFDirector:getChildByPath(cell, "Image_hero")
    Image_diban:setTexture(data.backdrop)


    if Panel_model.model then
        Panel_model.model:removeFromParent()
        Panel_model.model = nil
    end
    
    local heroImg = Utils:getHeroModelImgSrc(heroid, skinid)
    if heroImg then
        Image_hero:setTexture(heroImg)
    else
        local model = Utils:createHeroModel(heroid, Panel_model, 0.45, skinid,true)
        model:update(0.1)
        model:stop()
    end
    
    --等级
    local heroLv = HeroDataMgr:getLv(heroid)
    local Image_levelbg = TFDirector:getChildByPath(cell, "Image_levelbg")
    local Label_level 		= TFDirector:getChildByPath(Image_levelbg,"Label_level")
    Label_level:setText("Lv."..heroLv)



    local name = TFDirector:getChildByPath(cell,"Label_name");
    name:setLineHeight(22)
    name:setTextById(HeroDataMgr:getNameStrId(heroid));


    local Image_select = TFDirector:getChildByPath(cell,"Image_select");
    Image_select:setVisible(self.showidx == idx)
    if Image_select:isVisible() then
        self.selectImg = Image_select;
    end

end

return HeroChoiceLayer
