
local ChangeAssistView = class("ChangeAssistView", BaseLayer)

local PlayerInfoConfig = require("lua.logic.playerInfo.PlayerInfoConfig")

function ChangeAssistView:ctor(data)
    self.super.ctor(self)

    self.showCount = HeroDataMgr:getShowCount()

    self.showid = MainPlayer:getAssistId()

    self.showidx = HeroDataMgr:getShowIdxById(self.showid)

    self.curAssistIdx = self.showidx

    self.firstTouchIn = false

    self:init("lua.uiconfig.playerInfo.changeAssistView")
end

function ChangeAssistView:initUI(ui)
    self.super.initUI(self, ui)

    self.Button_change = TFDirector:getChildByPath(self.ui,"Button_change")
    self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")

    self:initHeroList()
    self:initHeroInfo()

    self:refreshTableView()
    self:refreshHeroInfo()
end

function ChangeAssistView:initHeroList()
    self.Panel_hero_list = TFDirector:getChildByPath(self.ui,"Panel_hero_list")

    self:initItem()
    self:initTableView()
end

function ChangeAssistView:initItem()
    self.Panel_item = TFDirector:getChildByPath(self.ui,"Panel_item")
end

function ChangeAssistView:initTableView()
    tableView = TFTableView:create()
    tableView:setTableViewSize(self.Panel_hero_list:getContentSize())
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)

    Public:bindScrollFun(tableView)

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, ChangeAssistView.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, ChangeAssistView.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, ChangeAssistView.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, ChangeAssistView.numberOfCellsInTableView)

    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, ChangeAssistView.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, ChangeAssistView.cellEnd)

    self.Panel_hero_list:addChild(tableView)

    self.tableView = tableView
    self.tableView.logic = self
end

function ChangeAssistView:refreshTableView()
    if self.tableView then
        print("self.tableView:reloadData()")
        self.tableView:reloadData()
    end
end

function ChangeAssistView.tableCellTouched(table,cell)
    local self = cell.logic

    if self.showidx ~= cell.idx then
        self.showidx = cell.idx
        self.firstTouchIn  = true
    end
    self.showid = HeroDataMgr:changeShowOne(cell.idx,self.firstTouchIn)
    self.firstTouchIn = false

    self:refreshHeroInfo()
    self:refreshTableView()
end

function ChangeAssistView.tableCellAtIndex(tab, idx)
    local self = tab.logic
    local cell = tab:dequeueCell()
    idx = idx + 1
    if cell == nil then
        tab.cells = tab.cells or {}
        cell = TFTableViewCell:create()
        local item = self.Panel_item:clone()
        item:setAnchorPoint(ccp(0, 0))
        item:setPosition(ccp(0, 0))
        cell:addChild(item)
        cell.item = item
    end

    if cell.item then
        local heroId = HeroDataMgr:getSelectedHeroId(idx)
        local skinId = HeroDataMgr:getCurSkin(heroId)
        local data = TabDataMgr:getData("HeroSkin", skinId)

        local Image_assist   = TFDirector:getChildByPath(cell.item,"Image_assist")
        --Image_assist:setVisible(idx == self.curAssistIdx)
        local Label_level = TFDirector:getChildByPath(cell.item,"Label_level")
        --Label_level:setText("Lv.".. HeroDataMgr:getLv(heroId))
        local icon = TFDirector:getChildByPath(cell.item,"Image_hero");
        icon:setTexture(data.skinImg);
        icon:setSize(ccs(140,245))
        local Image_di = TFDirector:getChildByPath(cell.item, "Image_di")
        Image_di:setTexture(data.backdrop)
        Image_di:setSize(ccs(140,245))
        local name = TFDirector:getChildByPath(cell.item,"Label_name");
        name:setLineHeight(22)
        name:setTextById(HeroDataMgr:getNameStrId(heroId));
        local Image_select = TFDirector:getChildByPath(cell.item,"Image_select");
        Image_select:setVisible(self.showidx == idx)

        local jobIcon = TFDirector:getChildByPath(cell.item,"Image_duty");
        local iconpath = HeroDataMgr:getHeroJobIconPath(heroId);    
        jobIcon:setVisible(iconpath ~= "")
        jobIcon:setTexture(iconpath)

        --等级
        local heroLv = HeroDataMgr:getLv(heroId)
        local Label_level       = TFDirector:getChildByPath(cell.item,"Label_level")
        Label_level:setText("Lv."..heroLv)

        --是否助战
        local assitance = HeroDataMgr:getIsAssist(heroId)
        local Image_assistant   = TFDirector:getChildByPath(cell.item,"Image_assistant");
        Image_assistant:setVisible(assitance)
    
        if self.showidx == idx then
            Image_select:show()
        else
            Image_select:hide()
        end


    end

    cell.idx = idx
    cell.logic = self
    return cell
end

function ChangeAssistView.numberOfCellsInTableView(tab)
    return table.count(HeroDataMgr:getShowList(true))
end

function ChangeAssistView.cellBegin(table)
end

function ChangeAssistView.cellEnd(table)
end

function ChangeAssistView.cellSizeForTable(table,idx)
    self = table.logic
    return self.Panel_item:getSize().height,self.Panel_item:getSize().width
end

function ChangeAssistView:initHeroInfo()
    self.Panel_info = TFDirector:getChildByPath(self.ui,"Panel_info")

    self.qualityImg         = TFDirector:getChildByPath(self.Panel_info,"Image_hero_puality");
    self.qualityImg:setScale(0.2);
    self.titleLabel         = TFDirector:getChildByPath(self.Panel_info,"Label_name_title");
    self.Label_power        = TFDirector:getChildByPath(self.Panel_info,"Label_power");
    self.moodValue			= TFDirector:getChildByPath(self.Panel_info,"moodValue");
    self.Image_head			= TFDirector:getChildByPath(self.Panel_info,"Image_head");
    self.moodValueDesc		= TFDirector:getChildByPath(self.Panel_info,"moodValueDesc");
    self.Image_back2 = TFDirector:getChildByPath(self.Panel_info, "Image_back2")

    self:initModelList()
end

function ChangeAssistView:refreshHeroInfo()
    self.titleLabel:setTextById(HeroDataMgr:getTitleStrId(self.showid));
    self.qualityImg:setTexture(HeroDataMgr:getQualityPic(self.showid));
    self.Label_power:setString(math.floor(HeroDataMgr:getHeroPower(self.showid)));

    local roleid = HeroDataMgr:getHeroRoleId(self.showid);
    local isHaveRole = RoleDataMgr:getIsHave(roleid)
    self.Image_back2:setVisible(isHaveRole)
    if isHaveRole then
        self.moodValue:setString(RoleDataMgr:getMood(roleid));
        self.Image_head:setTexture(RoleDataMgr:getMoodIcon(roleid));
        self.moodValueDesc:setString(RoleDataMgr:getMoodDes(roleid))
    end

    self:refreshModelList()
end

function ChangeAssistView:initModelList()

    self.modelList = {}
    for i=1,4 do
        local model = TFDirector:getChildByPath(self.Panel_info,string.format("Panel_spriteIcon_%d",i))
        table.insert(self.modelList,model)
    end
end

function ChangeAssistView:refreshModelList()
    for i,_model in ipairs(self.modelList) do
        local Image_select = TFDirector:getChildByPath(_model,"Image_select")
        local Image_normal = TFDirector:getChildByPath(_model,"Image_normal")
        local Image_head = TFDirector:getChildByPath(_model,"Image_head")
        if i > HeroDataMgr:getShowOneCount(self.showidx) then
            _model:hide()
            _model:setTouchEnabled(false)
        else
            _model:show()
            if HeroDataMgr:isSelected(self.showidx,i) then
                Image_select:show()
                Image_normal:hide()
            else
                Image_select:hide()
                Image_normal:show()
            end
            local heroid = HeroDataMgr:getHeroId(self.showidx,i)
            print("HeroDataMgr:getSmallIconPathById(heroid)    " .. HeroDataMgr:getSmallIconPathById(heroid))
            Image_head:setTexture(HeroDataMgr:getSmallIconPathById(heroid))
            Image_head:show()
            _model:setTouchEnabled(true)
        end
    end
end


function ChangeAssistView:registerEvents()
    self.Button_change:onClick(function()
        local sid = HeroDataMgr:getHeroSid(self.showid)
        MainPlayer:setAssist(sid)
        AlertManager:close()
    end)

    self.Button_close:onClick(function()

        AlertManager:close()
    end,
    EC_BTN.CLOSE)

    for i,_model in ipairs(self.modelList) do
        _model.logic = i

        _model:onClick(function()
            local idx = _model.logic
            HeroDataMgr:setSelectState(self.showidx,idx)
            local heroId = HeroDataMgr:getSelectedHeroId(self.showidx)
            self.showid = heroId

            self:refreshTableView()
            self:refreshHeroInfo()
        end)
    end
end

return ChangeAssistView
