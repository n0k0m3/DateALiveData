local CollectSceneView = class("CollectSceneView",BaseLayer)

function CollectSceneView:initData()
    self.pageUICfg = {}
    local tmPageUIcfg = CollectDataMgr:getPageUICfg(EC_CollectPage.SCENE)
    for k,v in pairs(tmPageUIcfg) do
        table.insert(self.pageUICfg,v)
    end
    table.sort( self.pageUICfg, function(a,b)
        return a.order < b.order
    end )
    self.isActivityCG = false
end

function CollectSceneView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.collect.collectSceneView")
end

function CollectSceneView:initUI(ui)
    self.super.initUI(self,ui)
    self.root_panel = ui:getChildByName("Panel_root")
    self.Panel_cgRoot = ui:getChildByName("Panel_cgShow")
    local base_panel = self.root_panel:getChildByName("Panel_base")
    self.collectBaseView = require("lua.logic.collect.CollectBaseView"):new()
    base_panel:addChild(self.collectBaseView)
    self.childArr:push(self.collectBaseView)

    self.baseCell = self.root_panel:getChildByName("Panel_base_cell")
    self.baseModel = self.root_panel:getChildByName("Panel_scene_item")
    local scroll_list = self.root_panel:getChildByName("ScrollView_list")
    self.list_view = UIListView:create(scroll_list)
    self.list_view:setScrollBar(self.collectBaseView.scrollBar)
    self:initBaseUI()
end

function CollectSceneView:initBaseUI()
    local callbackCfg = {tabSelCallback = handler(self.onSelTab,self),filtSelCallback = handler(self.onSelFiltTab,self)}
    self.collectBaseView:registCallback(callbackCfg)
    self.collectBaseView:makeLeftBar(self.pageUICfg)
end

function CollectSceneView:onSelTab(tabInfo)
    self.isActivityCG = (tabInfo.id == 105003)
end

function CollectSceneView:onSelFiltTab(filtInfo,filtKey)
    self.filtInfo = filtInfo
    self:updateInfoPage(filtInfo)
end

function CollectSceneView:updatePage()
    self.collectBaseView:updateTrophy(EC_CollectPage.SCENE)
    CollectDataMgr:clearRedShow(EC_CollectPage.SCENE)
end

function CollectSceneView:updateInfoPage(filtInfo)
    self.list_view:removeAllItems()
    self:updateCommonCGPage(filtInfo)
end

function CollectSceneView:updateCommonCGPage(filtInfo)

    local collectCount = table.count(filtInfo)
    if collectCount >= 2 then
        table.sort( filtInfo, function(a,b)
            return a.order < b.order
        end )
    end
    if collectCount <= 0 then
        return
    end
    local curDayCid,curNightCid = SceneSoundDataMgr:getCurSceneCid()
    local cellCount = math.ceil(collectCount/2)
    for i=1,cellCount do
        local itemCell = self.baseCell:clone()
        self.list_view:pushBackCustomItem(itemCell)
        itemCell:setVisible(true)
        for j = 1,2 do
            local sceneInfo = filtInfo[2*(i-1)+j]
            if sceneInfo == nil then
                return
            end
            local itemCard = self.baseModel:clone()
            itemCard:setPosition(me.p(0,0))
            itemCell:getChildByName("Panel_kidcell_"..j):addChild(itemCard)
            itemCard:setVisible(true)
            local isunclock = CollectDataMgr:isCollectItemExist(sceneInfo.collecttype,sceneInfo.id)
            itemCard:getChildByName("Image_lock"):setVisible(not isunclock)
            itemCard:getChildByName("Image_dayIcon"):setVisible(false)
            itemCard:getChildByName("Image_nightIcon"):setVisible(false)
            local sceneCfg = CollectDataMgr:getSceneChangeCfg(sceneInfo.id)
            itemCard:getChildByName("Image_ground"):setTexture(sceneCfg.icon)
            itemCard:getChildByName("Button_detail"):setOpacity(153)
            itemCard:getChildByName("Label_name"):setTextById(sceneCfg.name)
            if isunclock then
                itemCard:getChildByName("Image_sceneTip"):setVisible(sceneCfg.sortForMainScene > 0 )
            else
                itemCard:getChildByName("Image_sceneTip"):setVisible(false)
            end
            itemCard:getChildByName("Button_detail"):onClick(function()
                Utils:showTips(sceneCfg.unlockHint)
            end)

            itemCard:onClick(function()
                if not isunclock then
                    return
                end
                Utils:openView("collect.CollectScenePreView",sceneInfo.id)
            end)
        end
    end

end

function CollectSceneView:onShow()
    self.super.onShow(self)
    self:updatePage()
end

function CollectSceneView:refreshView()
    self:updatePage()
    self:updateInfoPage(self.filtInfo)
end

function CollectSceneView:registerEvents()
    EventMgr:addEventListener(self,EV_COLLECT_UPDATE_INFO,handler(self.refreshView, self))
end

return CollectSceneView