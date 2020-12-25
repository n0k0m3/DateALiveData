local CountryDetailsView = class("CountryDetailsView", BaseLayer)


function CountryDetailsView:ctor(nationCid)
    self.super.ctor(self)
    self:initData(nationCid)
    self:init("lua.uiconfig.explore.countryDetailsView")
end

function CountryDetailsView:initData(nationCid)

    self.tab_ = {}

    self.baseInfo = { 13322006,13322007,13322008 }
    self.panelInfo = {}

    self.loadFunc = {
        self.LoadBossPage,
        self.LoadKnowledgePage,
        self.LoadRecordPage
    }

    self.nationCid = ExploreDataMgr:getCurNation()
end

function CountryDetailsView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Panel_root = TFDirector:getChildByPath(ui,"Panel_root")

    self.Button_back = TFDirector:getChildByPath(self.Panel_root,"Button_back")
    self.Button_help = TFDirector:getChildByPath(self.Panel_root,"Button_help")

    self.Label_countryName = TFDirector:getChildByPath(self.Panel_root,"Label_countryName")
    self.Label_countryName:setSkewX(15)

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root,"ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)

    self.panelInfo[1] = TFDirector:getChildByPath(self.Panel_root,"Panel_boss")
    self.panelInfo[2] = TFDirector:getChildByPath(self.Panel_root,"Panel_knowledge")
    self.panelInfo[3] = TFDirector:getChildByPath(self.Panel_root,"Panel_record")

    self.Panel_prefab = TFDirector:getChildByPath(ui,"Panel_prefab")
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_tabItem")

    self:initUILogic()
end

function CountryDetailsView:initUILogic()

    local nationCfg = ExploreDataMgr:getAfkNationCfg(self.nationCid)
    if nationCfg then
        self.Label_countryName:setTextById(nationCfg.name)
    end

    ---添加页签
    self:loadTab()
    self:updateRedTip()
end

function CountryDetailsView:LoadBossPage()
    local DetailsBossPage = self.panelInfo[1]:getChildByName("DetailsBossPage")
    if not DetailsBossPage then
        DetailsBossPage = requireNew("lua.logic.explore.DetailsBossPage"):new(self.nationCid)
        DetailsBossPage:setName("DetailsBossPage")
        self.panelInfo[1]:addChild(DetailsBossPage)
    end

end

function CountryDetailsView:LoadKnowledgePage()
    local DetailsKnowledgePage = self.panelInfo[2]:getChildByName("DetailsKnowledgePage")
    if not DetailsKnowledgePage then
        DetailsKnowledgePage = requireNew("lua.logic.explore.DetailsKnowledgePage"):new()
        DetailsKnowledgePage:setName("DetailsKnowledgePage")
        self.panelInfo[2]:addChild(DetailsKnowledgePage)
    end
end

function CountryDetailsView:LoadRecordPage()

    local DetailsRecordPage = self.panelInfo[3]:getChildByName("DetailsRecordPage")
    if not DetailsRecordPage then
        DetailsRecordPage = requireNew("lua.logic.explore.DetailsRecordPage"):new()
        DetailsRecordPage:setName("DetailsRecordPage")
        self.panelInfo[3]:addChild(DetailsRecordPage)
    else
        DetailsRecordPage:updateBaseInfo()
    end
end

function CountryDetailsView:loadTab()
    self.ListView_tab:removeAllItems()
    for k,v in ipairs(self.baseInfo) do
        self:addItem()
        self:updateTabItem(k,v)
    end
    self:chooseTabItem(1)
end

function CountryDetailsView:updateRedTip()

    local showRedTip = false
    local cityGroup =  ExploreDataMgr:getAfkCityGroup(self.nationCid)
    for k,v in ipairs(cityGroup) do
        local foundEventData = ExploreDataMgr:getFoundEventData(v.cityBoss)
        if foundEventData then
            showRedTip = true
            break
        end
    end
    self.tab_[1].redTip:setVisible(showRedTip)

    showRedTip = false
    local knowledgeData = ExploreDataMgr:getKnowledgeState(0)
    for k,v in pairs(knowledgeData) do
        if v == 0 then
            local cfg = ExploreDataMgr:getKnowledgeCfg(k)
            if cfg and cfg.chapterID == self.nationCid then
                local costId,costNum
                for id,num in pairs(cfg.cost) do
                    costId,costNum = id,num
                    break
                end

                if costId and costNum then
                    local ownCount = GoodsDataMgr:getItemCount(costId)
                    if ownCount >= costNum then
                        showRedTip = true
                        break
                    end
                end
            end
        end
    end
    self.tab_[2].redTip:setVisible(showRedTip)
end

function CountryDetailsView:addItem()
    local tabItem = self.Panel_tabItem:clone()
    self.ListView_tab:pushBackCustomItem(tabItem)
    local Image_select = TFDirector:getChildByPath(tabItem,"Image_select")
    local Label_name = TFDirector:getChildByPath(tabItem,"Label_name")
    local Image_red_tip = TFDirector:getChildByPath(tabItem,"Image_red_tip"):hide()
    table.insert(self.tab_,{root = tabItem, select = Image_select,name = Label_name,redTip = Image_red_tip})
end

function CountryDetailsView:updateTabItem(index,name)
    local tab = self.tab_[index]
    if not tab then
        return
    end
    tab.name:setTextById(name)
    tab.root:onClick(function()
        self:chooseTabItem(index)
    end)
end

function CountryDetailsView:chooseTabItem(tabIndex)

    for k,v in ipairs(self.tab_) do
        v.select:setVisible(k == tabIndex)
    end

    for k,v in ipairs(self.panelInfo) do
        v:setVisible(k == tabIndex)
    end

    self.loadFunc[tabIndex](self)
end


function CountryDetailsView:registerEvents()

    EventMgr:addEventListener(self, EV_EXPLORE_UPGRADE_KNOWLEDGE, handler(self.updateRedTip, self))

    self.Button_back:onClick(function()
        AlertManager:closeLayer(self)
    end)
    self.Button_help:onClick(function()
        Utils:openView("common.HelpView", {2465})
    end)
end

return CountryDetailsView
