local NoticeView = class("NoticeView", BaseLayer)

function NoticeView:ctor()
    self.super.ctor(self)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.MainScene.noticeView")
end

function NoticeView:registerEvents()
    -- EventMgr:addEventListener(self, EV_NOTICE_UPDATE, handler(self.onRefreshNotice, self))

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function NoticeView:initData()
    --TaskDataMgr:setTempValue(false)
    
    self.curTabType = EC_NoticeType.GAME
    self.tabInfos = nil
    self.curSelectItem = nil
end

function NoticeView:initUI(ui)
    self.super.initUI(self,ui)

    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    self.Panel_container = TFDirector:getChildByPath(self.ui, "Panel_container")

    self.Panel_contentCloneObj = TFDirector:getChildByPath(self.ui, "Panel_contentCloneObj")
    self.ScrollView_list = TFDirector:getChildByPath(self.ui, "ScrollView_list")
    self.Button_item = TFDirector:getChildByPath(self.ui, "Button_item")
    self.ScrollView_list = UIListView:create(self.ScrollView_list)
    self.ScrollView_list:setItemsMargin(10)

    self.Panel_itemCloneObj = TFDirector:getChildByPath(self.ui, "Panel_itemCloneObj")
    self.Label_tittleCloneObj = TFDirector:getChildByPath(self.ui, "Label_tittleCloneObj")
    self.Label_desCloneObj = TFDirector:getChildByPath(self.ui, "Label_desCloneObj")
    self.contentPosy = self.Panel_container:getPositionY()
    self.Image_imgCloneObj = TFDirector:getChildByPath(self.ui, "Image_imgCloneObj")
    self.Panel_detailCloneObj = TFDirector:getChildByPath(self.ui, "Panel_detailCloneObj")

    self:onRefreshNotice()
end

function NoticeView:onRefreshNotice()
    self.ScrollView_list:removeAllItems()
    self.Panel_container:Hide()
   local noticedata = NoticeDataMgr:getNoticeDataList()
   for i,v in ipairs(noticedata) do
        local Button_item = self.Button_item:clone()
        local Image_name_bg = Button_item:getChild("Image_name_bg")
        local Label_name = Button_item:getChild("Label_name")
        local Label_type_name = Button_item:getChild("Label_type_name")
        if v.type == EC_NoticeType.ACTIVE then
            Button_item:setTextureNormal("ui/notice/ui_07.png")
            Label_type_name:setTextById(800098)
        else
            Button_item:setTextureNormal("ui/notice/ui_08.png")
            Label_type_name:setTextById(800099)
        end
        Button_item.Image_select = Button_item:getChild("Image_select")
        Label_name:setText(v.title)
        self.ScrollView_list:pushBackCustomItem(Button_item)
        Button_item:onClick(function(sender)
            if self.curSelectItem then
                self:updateCurButtonItem(false)
            end
            self.curSelectItem = Button_item
            self:updateCurButtonItem(true)
            self:refreshContentPanel(v)
        end)
        if i == 1 then
            self.curSelectItem = Button_item
            self:updateCurButtonItem(true)
            self:refreshContentPanel(v)
        end
   end
    -- self.tabInfos = {}
    -- self.Panel_container:removeAllChildren()
    -- local typeButtonName = {"Button_active", "Button_game"}
    -- for i=EC_NoticeType.GAME,EC_NoticeType.GAME do
    --     self.tabInfos[i] = {}
    --     self.tabInfos[i].tabButton = TFDirector:getChildByPath(self.ui, typeButtonName[i])
    --     self.tabInfos[i].tabContent = self:createTabContent()
    --     self.tabInfos[i].contentInit = false
    --     self.tabInfos[i].curSelItem = nil
    --     self.tabInfos[i].tabButton:onClick(function(sender)
    --         self:switchTab(i)
    --     end)
    -- end
    
    -- self:switchTab(EC_NoticeType.GAME)
end

function NoticeView:updateCurButtonItem(isSelect)
    if isSelect then
        self.curSelectItem.Image_select:Show()
    else
        self.curSelectItem.Image_select:Hide()
    end
end

function NoticeView:refreshContentPanel(data)
    self.Panel_container:Show()
    self.Label_tittleCloneObj:setText(data.title)
    self.Label_desCloneObj:setText(data.content)
    if data.contextImg and string.len(data.contextImg) > 0 then
        self.Image_imgCloneObj:Show()
        self.Image_imgCloneObj:setTexture(data.contextImg)
        self.Panel_container:setPositionY(self.contentPosy)
    else
        self.Image_imgCloneObj:Hide()
        self.Panel_container:setPositionY(self.contentPosy + 131)
    end
end

function NoticeView:createTabContent()
    local panel = self.Panel_contentCloneObj:clone():Hide()
    panel.itemListView = UIListView:create(panel:getChild("ScrollView_list"))
    panel.itemListView:setItemsMargin(-4)
    panel.contentListView = UIListView:create(panel:getChild("ScrollView_content"))
    panel.contentListView:setGravity(UIListView.Gravity.LEFT)
    panel.contentListView:setItemsMargin(4)
    self.Panel_container:Add(panel)
    return panel
end

function NoticeView:switchTab(tabtype)
    local curInfo = self.tabInfos[self.curTabType]
    curInfo.tabButton:setGrayEnabled(false)
    curInfo.tabButton:setTouchEnabled(true)
    curInfo.tabContent:Hide()

    local newInfo = self.tabInfos[tabtype]
    newInfo.tabButton:setGrayEnabled(true)
    newInfo.tabButton:setTouchEnabled(false)
    newInfo.tabContent:Show()

    if not newInfo.contentInit then
        newInfo.contentInit = true
        self.tabInfos[tabtype] = self:infoInit(newInfo, tabtype)
    end

    self.curTabType = tabtype
end

function NoticeView:infoInit(info, tabtype)
    local noticedata = NoticeDataMgr:getNoticeDataByType(tabtype)
    for i,v in ipairs(noticedata) do
        local tabItem = self.Panel_itemCloneObj:clone():Show()
        local tabButton = tabItem:getChild("Button_item")
        tabButton.imgSelected = tabButton:getChild("Image_select")
        tabButton:getChild("Label_name"):setText(v.title)
        info.tabContent.itemListView:pushBackCustomItem(tabItem)
        tabButton:onClick(function(sender)
            if info.curSelItem then
                self:itemButtonUpdate(info.curSelItem, false)
            end
            info.curSelItem = tabButton
            self:itemButtonUpdate(info.curSelItem, true)
            info.tabContent.contentListView = self:freshContentDes(info.tabContent.contentListView, v)
        end)
        if i == 1 then
            info.curSelItem = tabButton
            self:itemButtonUpdate(info.curSelItem, true)
            info.tabContent.contentListView = self:freshContentDes(info.tabContent.contentListView, v)
        end
    end
    return info
end

function NoticeView:freshContentDes(view, data)
    view:removeAllItems()
    if data.contextImg and string.len(data.contextImg) > 0 then
        local imgObj = self.Image_imgCloneObj:clone():Show()
        imgObj:setTexture(data.contextImg)
        view:pushBackCustomItem(imgObj)
    end
    local tittleObj = self.Label_tittleCloneObj:clone():Show()
    tittleObj:setText(data.title)
    view:pushBackCustomItem(tittleObj)
    local lineObj = self.Image_imgCloneObj:clone():Show()
    lineObj:setTexture("ui/1067.png")
    view:pushBackCustomItem(lineObj)
    local desObj = self.Label_desCloneObj:clone():Show()
    desObj:setText(data.content)
    desObj:setTextHorizontalAlignment(0)
    desObj:setDimensions(view:getContentSize().width, 0)
    view:pushBackCustomItem(desObj)
    return view
end

function NoticeView:itemButtonUpdate(itembt, bselect)
    if bselect then
        itembt:setTextureNormal("ui/1065.png")
        itembt:setTouchEnabled(false)
        itembt.imgSelected:Show()
    else
        itembt:setTextureNormal("ui/1068.png")
        itembt:setTouchEnabled(true)
        itembt.imgSelected:Hide()
    end
end

return NoticeView