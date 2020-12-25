
local DfwAutumnHandAccountView = class("DfwAutumnHandAccountView", BaseLayer)

function DfwAutumnHandAccountView:initData()
    self.handAccount_ = DfwDataMgr:getHandAccount(EC_HadleAccountType.AUTUMN)
    dump(self.handAccount_)

    self.tabItems_ = {}
    self.contentItems_ = {}
    self.defaultSelectTabIndex_ = 1
    self.tabLeb = 1
end

function DfwAutumnHandAccountView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dafuwong.dfwAutumnHandAccountView")
end

function DfwAutumnHandAccountView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_pageItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_pageItem")
    self.Panel_pointItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_pointItem")
    self.Panel_contentItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_contentItem")

    local ScrollView_tab = TFDirector:getChildByPath(self.Panel_root, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)
    self.Image_chunriji = TFDirector:getChildByPath(self.Panel_root, "Image_chunriji")
    self.Label_name = TFDirector:getChildByPath(self.Image_chunriji, "Label_name")
    self.Button_left = TFDirector:getChildByPath(self.Image_chunriji, "Button_left")
    self.Button_right = TFDirector:getChildByPath(self.Image_chunriji, "Button_right")
    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")

    self:refreshView()
end

function DfwAutumnHandAccountView:refreshView()
    for i=1,self.tabLeb do
        local foo = {}
        foo.root = self.Panel_tabItem:clone()
        foo.Button_normal = TFDirector:getChildByPath(foo.root, "Button_normal")
        foo.Label_name_normal = TFDirector:getChildByPath(foo.Button_normal, "Label_name_normal")
        foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
        foo.Label_name_select = TFDirector:getChildByPath(foo.Image_select, "Label_name_select")
        self.tabItems_[foo.root] = foo
        self.ListView_tab:pushBackCustomItem(foo.root)
    end

    self:selectTab(self.defaultSelectTabIndex_)
end

function DfwAutumnHandAccountView:selectTab(index)
    if self.selectTabIndex_ == index then return end

    self.selectTabIndex_ = index
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local foo = self.tabItems_[v]
        local isSelect = (i == index)
        foo.Button_normal:setVisible(not isSelect)
        foo.Image_select:setVisible(isSelect)
    end

    if not self.contentItems_[index] then
        self:addContentItem(index)
    end

    self:updateTab(index)
end

function DfwAutumnHandAccountView:addContentItem(index)
    local handAccount = self.handAccount_
    local foo = {}
    foo.root = self.Panel_contentItem:clone()
    foo.root:Pos(0, 0):AddTo(self.Panel_content)
    local Image_content = TFDirector:getChildByPath(foo.root, "Image_content")
    foo.Label_name = TFDirector:getChildByPath(Image_content, "Label_name")
    foo.Button_left = TFDirector:getChildByPath(Image_content, "Button_left")
    foo.Button_right = TFDirector:getChildByPath(Image_content, "Button_right")
    foo.PageView_cg = TFDirector:getChildByPath(Image_content, "PageView_cg")
    local ScrollView_point = TFDirector:getChildByPath(Image_content, "ScrollView_point")
    foo.ListView_point = UIListView:create(ScrollView_point)
    foo.ListView_point:setItemsMargin(10)
    foo.pageItems_ = {}
    for i, v in ipairs(handAccount) do
        local Panel_pageItem = self.Panel_pageItem:clone()
        foo.PageView_cg:addPage(Panel_pageItem)
        local bar = {}
        bar.root = Panel_pageItem
        bar.Button_dating = TFDirector:getChildByPath(bar.root, "Button_dating"):hide()
        bar.Image_cg = TFDirector:getChildByPath(bar.root, "Image_cg")
        bar.Label_dating = TFDirector:getChildByPath(bar.Button_dating, "Label_dating")
        bar.Panel_mask = TFDirector:getChildByPath(bar.root, "Panel_mask")
        bar.Image_mask = {}
        for j = 1, 24 do
            bar.Image_mask[j] = TFDirector:getChildByPath(bar.Panel_mask, "Image_mask_" .. j)
        end
        foo.pageItems_[i] = bar
    end

    foo.pointItems_ = {}
    for i, v in ipairs(handAccount) do
        local bar = {}
        bar.root = self.Panel_pointItem:clone()
        foo.ListView_point:pushBackCustomItem(bar.root)
        bar.Image_normal = TFDirector:getChildByPath(bar.root, "Image_normal")
        bar.Image_select = TFDirector:getChildByPath(bar.root, "Image_select")
        foo.pointItems_[i] = bar
    end
    Utils:setAliginCenterByListView(foo.ListView_point, true)

    self.contentItems_[index] = foo

    foo.Button_left:onClick(function()
            local curPageIndex = foo.PageView_cg:getCurPageIndex()
            local count = foo.PageView_cg:getPageCount()
            foo.PageView_cg:scrollToPage(curPageIndex - 1)
    end)

    foo.Button_right:onClick(function()
            local curPageIndex = foo.PageView_cg:getCurPageIndex()
            local count = foo.PageView_cg:getPageCount()
            foo.PageView_cg:scrollToPage(curPageIndex + 1)
    end)

    local function updatePageState()
        local curPageIndex = foo.PageView_cg:getCurPageIndex()
        local count = foo.PageView_cg:getPageCount()
        foo.Button_left:setVisible(curPageIndex > 0)
        foo.Button_right:setVisible(curPageIndex < count - 1)
        local realIndex = curPageIndex + 1
        local cfg = DfwDataMgr:getHandAccountCfg(handAccount[realIndex])
        foo.Label_name:setTextById(cfg.pageName)

        for i, bar in ipairs(foo.pointItems_) do
            bar.Image_normal:setVisible(i ~= realIndex)
            bar.Image_select:setVisible(i == realIndex)
        end
    end

    foo.PageView_cg:addMEListener(TFPAGEVIEW_CHANGED, function()
                                      updatePageState()
    end)

    foo.PageView_cg:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
            local index = foo.PageView_cg:getCurPageIndex()
            local page = foo.PageView_cg:getPage(index)
            page:setClippingEnabled(false)
            page:setClippingEnabled(true)
    end)

    updatePageState()
end

function DfwAutumnHandAccountView:registerEvents()

end

function DfwAutumnHandAccountView:updateTab(index)
    local handAccount = self.handAccount_
    local foo = self.contentItems_[index]
    for i, v in ipairs(handAccount) do
        local cfg = DfwDataMgr:getHandAccountCfg(v)
        local bar = foo.pageItems_[i]
        bar.Image_cg:setTexture(cfg.cg)
        bar.Image_cg:setPosition(cfg.position)
        bar.Image_cg:setScale(cfg.size)
        local count = GoodsDataMgr:getItemCount(cfg.piece[1])
        for j, Image_mask in ipairs(bar.Image_mask) do
            Image_mask:setVisible(j > count)
        end
        bar.Button_dating:setVisible(count >= #bar.Image_mask)
        if bar.Button_dating:isVisible() then
            bar.Button_dating:onClick(function()
                    FunctionDataMgr:jStartDating(cfg.dating)
            end)
        end
    end
end

return DfwAutumnHandAccountView
