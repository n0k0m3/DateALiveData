
local PersonInfoBase = class("PersonInfoBase", BaseLayer)
function PersonInfoBase:initData(selectIndex)
    self.defaultSelectIndex = selectIndex
    self.tabItem_ = {}
    self.loadedModel_ = {}
    self.funcList_ = {}
    table.insert(self.funcList_,{nameCN= 15010115 ,nameEN = 13202011,model = requireNew("lua.logic.activity.twoyear.ZnqMiniMapView")})
    table.insert(self.funcList_,{nameCN= 15010116 ,nameEN = 13202012,model = requireNew("lua.logic.activity.twoyear.ZnqPersonInfoView")})
    --table.insert(self.funcList_,{nameCN= 15010117 ,nameEN = 13202013,model = requireNew("lua.logic.privilege.PrivilegeUpView")})
    table.insert(self.funcList_,{nameCN= 15010118 ,nameEN = 13202014,model = requireNew("lua.logic.activity.twoyear.ZnqHelpView")})
end


function PersonInfoBase:ctor(...)
    self.super.ctor(self)
    self.block = AlertManager.BLOCK
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.znq_yly_info")
end

function PersonInfoBase:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_base")


    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    
    self:refreshView()
end

function PersonInfoBase:refreshView()
    self:LoadContent()
    self:updateAllRedTip()
end

function PersonInfoBase:LoadContent()

    for k,v in ipairs(self.funcList_) do
        self:addTabItem(v)
    end

    for i, v in ipairs(self.funcList_) do
        self:updateTabItem(i)
    end

    -- 选中
    if self.selectIndex_ then
        if self.selectIndex_ > #self.funcList_ then
            self:selectTabItem(#self.funcList_, true)
        else
            self:selectTabItem(self.selectIndex_, true)
        end
    else
        local index = 1
        if self.defaultSelectIndex then
            index = math.min(self.defaultSelectIndex, #self.funcList_)
        end
        self:selectTabItem(index, true)
    end
end

function PersonInfoBase:addTabItem()
    local Panel_tabItem = self.Panel_tabItem:clone()
    local foo = {}
    foo.root = Panel_tabItem
    foo.Image_normal = TFDirector:getChildByPath(foo.root, "Image_normal")
    foo.select = TFDirector:getChildByPath(foo.root, "select")
    foo.Label_cn = TFDirector:getChildByPath(foo.Image_normal, "Label_cn")
    foo.Label_cn_s = TFDirector:getChildByPath(foo.select, "Label_cn")
    foo.Label_en = TFDirector:getChildByPath(foo.root, "Label_en")
    foo.redTip = TFDirector:getChildByPath(foo.root, "Image_red_tip"):hide()
    self.tabItem_[foo.root] = foo
    self.ListView_tab:pushBackCustomItem(foo.root)
end

function PersonInfoBase:updateTabItem(index)

    local info = self.funcList_[index]
    local item = self.ListView_tab:getItem(index)
    local foo = self.tabItem_[item]
    foo.Label_cn:setTextById(info.nameCN)
    foo.Label_cn_s:setTextById(info.nameCN)
    foo.Label_en:setTextById(info.nameEN)
    
    foo.root:onClick(function()
        self:selectTabItem(index)
    end)
    
end

function PersonInfoBase:selectTabItem(index, force)
    if #self.funcList_ == 0 then return end
    if self.selectIndex_ == index and not force then return end
    self.selectIndex_ = index

    for i, v in ipairs(self.ListView_tab:getItems()) do
        local isSelect = i == index
        local foo = self.tabItem_[v]
        foo.select:setVisible(isSelect)
        foo.Image_normal:setVisible(not isSelect)
    end

    local model = self.loadedModel_[index]
    if not model then
        model = self:addModelItem(index)
        self.loadedModel_[index] = model
    end

    for k, v in pairs(self.loadedModel_) do
        v:setVisible(index == k)
    end
end


function PersonInfoBase:addModelItem(index)

    if not self.funcList_[index] then
        return
    end

    local modelClass = self.funcList_[index].model
    if modelClass then
        local model = modelClass:new(self)
        self:addLayerToNode(model, self.Panel_content)
        if self:getParent() then
            model:onShow()
        end
        return model
    end
end

function PersonInfoBase:updateAllRedTip()

    for k,v in ipairs(self.funcList_) do
        if k == 3 then
            local canUp = PrivilegeDataMgr:isWishTreeCanUp()
            self:updateRedTip(k,canUp)
        elseif k == 1 then
            local canUp = ActivityDataMgr2:isBalloonTip() or TurnTabletMgr:isTurnTabletRedShow() or ActivityDataMgr2:isShowRedPointInMainView(7)
            self:updateRedTip(k,canUp)
        end
    end
end


function PersonInfoBase:updateRedTip(index,visible)

    local item = self.ListView_tab:getItem(index)
    local foo = self.tabItem_[item]
    foo.redTip:setVisible(visible)
end

function PersonInfoBase:registerEvents()

    EventMgr:addEventListener(self, EV_UPDATE_WISHTREE_LV, handler(self.updateAllRedTip, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateAllRedTip, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    EventMgr:addEventListener(self, EV_WORLD_CLOSE_BASE_INFO, function ( ... )
        -- body
        AlertManager:closeLayer(self)
    end)

end


return PersonInfoBase
