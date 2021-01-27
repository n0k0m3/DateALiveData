local json = require("LuaScript.extends.json")

local AnnouncementLayer = class("AnnouncementLayer", BaseLayer)

function AnnouncementLayer:ctor(helpIds)
    self.super.ctor(self)
    self:initData(helpIds)
    self:showPopAnim(true)
    self:init("lua.uiconfig.common.announcementLayer")
end

function AnnouncementLayer:initData(helpIds)
    self.AdImageCnt = 5
    self.groupLimit = 8
    self.changeTime = 3.0
    self.panel_title_list = {}

    self.announcementUrl = URL_ANNOUNCEMENT
    self.data = {}
    self.urlIdx = 1
end

function AnnouncementLayer:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Button_close = TFDirector:getChildByPath(self.ui, "Button_close")
    
    self.Panel_PageView = TFDirector:getChildByPath(self.ui , "Panel_PageView")
    self.PageView_image = TFDirector:getChildByPath(self.Panel_PageView,"PageView_image")
    self.PageView_image:setDirection(1)
    self.PageView_image:addMEListener(TFPAGEVIEW_SCROLLENDED, function()
        self:pageScrollEnd()
    end)

    self.image_dot = {}

    for i=1,self.AdImageCnt do
       self.image_dot[i] = TFDirector:getChildByPath(self.Panel_PageView , "img_point_"..i)
    end

    local Panel_prefab = TFDirector:getChildByPath(self.ui , "Panel_prefab")
    self.Image_banner_item = TFDirector:getChildByPath(Panel_prefab , "Image_banner_item")

    self.panel_title_item = TFDirector:getChildByPath(Panel_prefab , "panel_title_item")
    self.panel_content = TFDirector:getChildByPath(Panel_prefab , "panel_content")

    self:initBannerPanel()

    self:updatePageView()

    self:pageScrollEnd()

    self:getAnnouncementInfo()

end

function AnnouncementLayer:setCloseCallBack( closeCallBack )
   self.closeCallBack = closeCallBack
end

function AnnouncementLayer:getAnnouncementInfo( ... )
    --print(self.announcementUrl[self.urlIdx])
    
    HttpHelper:get(self.announcementUrl[self.urlIdx],handler(self.updateNoticeData, self))
end

function AnnouncementLayer:updateNoticeData( data )
    if not self.groupLimit then  return end
    
    if (data and data ~= "") then
        data = json.decode(data)
    end
    if data and data ~= "" then
        table.sort(data , function ( a , b )
            return a.group > b.group
        end)
        local newGroupLen =  math.min(data[1].group ,self.groupLimit)

        local titleShowList = {}
        local contentShowList = {}
        local titleHideList = {}
        local contentHideList = {}

        for _,_info in ipairs(data) do
            if _info.isHide <= 0 and _info.type == "title" then
                table.insert(titleShowList, _info)
            end
            if _info.isHide <= 0 and _info.type == "content" then
                table.insert(contentShowList, _info)
            end

            if _info.isHide > 0 and _info.type == "title" then
                table.insert(titleHideList, _info)
            end
            if _info.isHide > 0 and _info.type == "content" then
                table.insert(contentHideList, _info)
            end
        end

        if #titleShowList < newGroupLen then
            for i=1,(newGroupLen - #titleShowList) do
                if titleHideList[i] then
                    table.insert(titleShowList,titleHideList[i])
                end
            end
        end
        table.sort(titleShowList,function(a , b)
            return a.group > b.group
        end)

        if #contentShowList < newGroupLen then
            for i=1,(newGroupLen - #contentShowList) do
                if contentHideList[i] then
                    table.insert(contentShowList,contentHideList[i])
                end
            end
        end
        table.sort(contentShowList,function(a , b)
            return a.group > b.group
        end)

        local showList = {}
        for i=1,newGroupLen do
            if titleShowList[i] and contentShowList[i] then
                table.insert(showList, {titleShowList[i],contentShowList[i]})
            end
        end

        self.data = showList
        self.myData = {}

        for k ,v in ipairs(self.data) do
            local title = {}
            local content = {}
            local group = 0
           
            for key , data in pairs(v) do
                local textData = {
                    baseName = data.baseName,
                    name = data.name,
                    color = data.color,
                    text = data.text,
                    clickId = "",
                    size = data.size,
                    index = data.index
                    }
                if data.type == "title" then
                    table.insert(title , textData)
                else
                    table.insert(content , textData)
                end
                group = data.group
                --table.insert(group , data.group)
            end
            title.align = "left"
            table.sort(title ,function(a , b )
                return a.index < b.index
            end)
            content.align = "left"
            table.sort(content ,function(a , b )
                return a.index < b.index
            end)
            table.insert(self.myData , {title = title , content = content, group = group})
        end
        self:initScrollInfos()
    else   --如果没有数据
        self.urlIdx = self.urlIdx + 1 
        if self.urlIdx >= 3 then
            Utils:showTips(190000204)
            return
        end
        self:getAnnouncementInfo()
    end
end

function AnnouncementLayer:initScrollInfos( ... )
    local ScrollView_info = TFDirector:getChildByPath(self.ui, "ScrollView_info")
    self.ListView_info = UIListView:create(ScrollView_info)

    self.ListView_info:setItemsMargin(2)

    local Image_scrollBar = TFDirector:getChildByPath(self.ui , "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBar, Image_scrollBarInner)
    self.ListView_info:setScrollBar(scrollBar)

    local firstOpenItem = nil
    for i=1,#self.myData do
        local infos = self.myData[i]
        local panel_title_item = self.panel_title_item:clone()
        panel_title_item:setPosition(0 , 0)
        panel_title_item.index = i
        panel_title_item:setTouchEnabled(true)
        panel_title_item.img_arrow = panel_title_item:getChildByName("img_arrow")
        panel_title_item.label_title = panel_title_item:getChildByName("Label_des")
        table.insert(self.panel_title_list , panel_title_item)
        panel_title_item:onClick(handler(self.titleItemClick , self))
        self.ListView_info:pushBackCustomItem(panel_title_item)
        local titleData = infos.title
        panel_title_item.label_title:setTextByAttr(titleData)
        panel_title_item.infos = infos

        if #self.myData >= 1 and self.isNotFirst == nil and i == 1 then
            firstOpenItem = panel_title_item
            self.isNotFirst = false
        end
    end

    if firstOpenItem then
        self:titleItemClick(firstOpenItem)
    end
    
end

function AnnouncementLayer:titleItemClick( sender )
            if sender.idx then
                self:updateTitleItemIndex(sender.index , false)
                self.ListView_info:removeItem(sender.idx)
                sender.idx = nil
                sender.img_arrow:setTexture("ui/common/announcement/img_down.png")
                sender.label_des = nil
            else
                self:updateTitleItemIndex(sender.index , true)
                local panel_content = self.panel_content:clone()
                sender.label_des = panel_content:getChildByName("Label_des")
                sender.img_bg = panel_content:getChildByName("Image_bg")
                --sender.label_des:setTextAreaSize(CCSize(850 , 0))
                local content = sender.infos.content 
                sender.label_des:setTextByAttr(content)
                local index = sender.index
                local idx = index + 1
                panel_content:setContentSize(CCSize(panel_content:getContentSize().width , sender.label_des.__richText:getContentSize().height + 80))
                sender.img_bg:setContentSize(CCSize(sender.img_bg:getContentSize().width , sender.label_des.__richText:getContentSize().height + 80))
                self.ListView_info:insertCustomItem(panel_content, idx)
                sender.idx = idx 
                sender.img_arrow:setTexture("ui/common/announcement/img_up.png")
            end
end

function AnnouncementLayer:updateTitleItemIndex(index  , isAdd)
    for k , v in pairs(self.panel_title_list) do
        if index < v.index then
            if isAdd then
                v.index = v.index + 1
                if v.idx then
                    v.idx = v.idx + 1
                end
            else
                if v.idx then
                    v.idx = v.idx - 1
                end
                v.index = v.index - 1
            end
        end
    end
    
end

function AnnouncementLayer:initBannerPanel( ... )

    local bannerImg = {
        "ui/common/announcement/001.png",
        "ui/common/announcement/002.png",
        "ui/common/announcement/003.png",
        "ui/common/announcement/004.png",
        "ui/common/announcement/005.png",
    }
    for i=1,self.AdImageCnt do
        self:addBaner(bannerImg[i])
    end

    self.onActivity =  function()
        if tolua.isnull(self.PageView_image) then

            return
        end
        local curIndex = self.PageView_image:getCurPageIndex()
        curIndex = curIndex + 1
        if curIndex > self.AdImageCnt then
            curIndex = 0
        end
        self.PageView_image:scrollToPage(curIndex, 0)
    end
end

function AnnouncementLayer:updatePageView( ... )
    self.PageView_image:runAction(RepeatForever:create(Sequence:create({DelayTime:create(self.changeTime),CallFunc:create(function()
        self.onActivity()
    end)})))


    -- local size = self.Panel_PageView:Size()
    -- local beginPos, endPos = me.p(0, 0), me.p(0, 0)
    -- self.PageView_image:onTouch(function(event)
    --     if event.name == "began" then
    --         beginPos = event.target:getTouchStartPos()
    --         self.PageView_image:stopAllActions()
    --     elseif event.name == "moved" then

    --     elseif event.name == "ended" then
    --         endPos = event.target:getTouchEndPos()
    --         local offsetY = endPos.y - beginPos.y
    --         if math.abs(offsetY) > 20 then
    --             local curIndex = self.PageView_image:getCurPageIndex()

    --             if offsetY > 0 then
    --                 curIndex = curIndex + 1
    --                 if curIndex >= self.AdImageCnt then
    --                     curIndex = 0
    --                 end
    --             else
    --                 curIndex = curIndex - 1
    --                 if curIndex <= 0 then
    --                     curIndex = self.AdImageCnt
    --                 end
    --             end
    --             self.PageView_image:scrollToPage(curIndex, 0)
    --         end
    --         self.PageView_image:stopAllActions()
    --         self.PageView_image:runAction(RepeatForever:create(Sequence:create({DelayTime:create(self.changeTime),CallFunc:create(function()
    --             onActivityCountDownPer()
    --         end)})))
    --     end
    -- end)
end

function AnnouncementLayer:addBaner(bannerTexture)
    local layer = TFPanel:create()
    local activityImg = self.Image_banner_item:clone()
    activityImg:setTexture(bannerTexture)
    activityImg:setVisible(true)
    activityImg:setPosition(0 , 0)
    layer:addChild(activityImg , 1)

    self.PageView_image:addPage(layer)
end

function AnnouncementLayer:pageScrollEnd()

    self.curPageIndex = self.PageView_image:getCurPageIndex() + 1
    local str = nil
    for i = 1,self.AdImageCnt do
        if self.curPageIndex == i then
            str = "ui/common/announcement/img_point.png"
        else
            str = "ui/common/announcement/img_point_bottom.png"
        end
        self.image_dot[i]:setTexture(str)
    end

    self.PageView_image:stopAllActions()
    
    self.PageView_image:runAction(RepeatForever:create(Sequence:create({DelayTime:create(self.changeTime),CallFunc:create(function()
        self.onActivity()
    end)})))

end

function AnnouncementLayer:registerEvents()
    self.Button_close:onClick(function()
        if self.closeCallBack then
                self.closeCallBack()
        end
        AlertManager:closeLayer(self)
    end)

end



return AnnouncementLayer