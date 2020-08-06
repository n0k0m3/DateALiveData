local KabalaTreeMapInfo = class("KabalaTreeMapInfo", BaseLayer)

function KabalaTreeMapInfo:ctor(funtionType)
    self.super.ctor(self)
    self:initData(funtionType)
    self:showPopAnim(true)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeMapInfo")
end

function KabalaTreeMapInfo:registerEvents()
    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreeMapInfo:initData(funtionType)

    self.funtionType = funtionType

    if self.funtionType == 1 then
        local curWorldId = KabalaTreeDataMgr:getCurWorld()
        self.WorldCfg = TabDataMgr:getData("KabalaWorld")[curWorldId]
    elseif self.funtionType == 2 then
        local curWorldId = DalMapDataMgr:getCurWorld()
        self.WorldCfg = DalMapDataMgr:getDlsWorldCfg(curWorldId)
    end
end

function KabalaTreeMapInfo:initUI(ui)
    self.super.initUI(self, ui)

    self.ui = ui
    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Label_title = TFDirector:getChildByPath(self.ui, "Label_title")
    local ScrollView_desc = TFDirector:getChildByPath(self.ui, "ScrollView_desc")
    self.ListView_desc = UIListView:create(ScrollView_desc)

    self.Panel_root = TFDirector:getChildByPath(self.ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Image_mapItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_mapItem")
    self.Label_clone = TFDirector:getChildByPath(self.Panel_prefab, "Label_clone")
    
    local ScrollView_map = TFDirector:getChildByPath(self.Panel_root, "ScrollView_map")
    self.mapListView = UIListView:create(ScrollView_map)
    self.mapListView:setItemsMargin(5)

    self.award_tx = TFDirector:getChildByPath(self.ui, "award_tx")
 
    self:initUIInfo()
end

function KabalaTreeMapInfo:initUIInfo()

    self.Label_title:setTextById(3004012)
    self.award_tx:setTextById(3004002)

    local size = self.ListView_desc:getContentSize()
    local Label_content = self.Label_clone:clone():Show()
    Label_content:setTextById(3004102)
    Label_content:setDimensions(size.width, 0)
    self.ListView_desc:pushBackCustomItem(Label_content)

    local formCfg = clone(TabDataMgr:getData("Kabalaform"))
    if self.funtionType == 2 then
        formCfg = clone(TabDataMgr:getData("Dlsform"))
    end
    table.sort(formCfg,function(a,b)
        return a.order < b.order
    end)
    
    for k,v in ipairs(formCfg) do
        if v.isShow then
            local item = self.Image_mapItem:clone()
            local Label_mapName = TFDirector:getChildByPath(item, "Label_mapName")
            Label_mapName:setTextById(v.mapActorName)
            local mapIcon = TFDirector:getChildByPath(item, "Image_placeIcon")
            if v.mapActorIcon ~= '' then
                mapIcon:setScale(v.scale)
                if v.id == 9 and self.WorldCfg then
                    mapIcon:setTexture(self.WorldCfg.taskItemIcon)
                elseif v.id == 10 and self.WorldCfg then
                    mapIcon:setTexture(self.WorldCfg.npcIcon)
                else
                    mapIcon:setTexture(v.mapActorIcon)
                end  
            end
            self.mapListView:pushBackCustomItem(item)
        end
    end
end

return KabalaTreeMapInfo