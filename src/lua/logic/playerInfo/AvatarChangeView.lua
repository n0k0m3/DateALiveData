local AvatarChangeView = class("AvatarChangeView", BaseLayer)

function AvatarChangeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.avatarChangeView")
end

function AvatarChangeView:initData(...)
    self.m_avatars = {}
    self.m_frames = {}
    self.m_bubbles = {}
    self.m_items = {}
    self.m_frame_items = {}
    self.m_bubble_items = {}
    self.selectIdx_ = nil
    self.lastSelectBtn = nil
    self.classify_name = {
    TextDataMgr:getText(100000070), 
    TextDataMgr:getText(100000118)
    }
    
end

function AvatarChangeView:initUI(ui)
    self.super.initUI(self, ui)
    self.ui = ui

    self.Panel_prefab = TFDirector:getChildByPath(self.ui, "Panel_prefab")
    self.Panel_class = TFDirector:getChildByPath(self.Panel_prefab, "Panel_class")
    self.Panel_avatar_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_avatar_item")
    self.Panel_frame_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_frame_item")
    self.Panel_chatBubble_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_chatBubble_item")

    self.Panel_avatars = TFDirector:getChildByPath(self.ui,"Panel_avatars")
    self.Button_close = TFDirector:getChildByPath(self.Panel_avatars,"Button_close")
    self.Label_title = TFDirector:getChildByPath(self.Panel_avatars, "Label_title")
    self.Label_sub_title = TFDirector:getChildByPath(self.Label_title, "Label_sub_title")
    self.Image_avatar = TFDirector:getChildByPath(self.Panel_avatars, "Image_avatar")
    self.Label_name = TFDirector:getChildByPath(self.Panel_avatars, "Label_name")
    self.Label_desc = TFDirector:getChildByPath(self.Panel_avatars, "Label_desc")
    self.Button_use = TFDirector:getChildByPath(self.Panel_avatars, "Button_use")
    self.Label_use = TFDirector:getChildByPath(self.Button_use, "Label_use")
    self.Image_cover_frame = TFDirector:getChildByPath(self.Panel_avatars, "Image_cover_frame")
    self.Button_use_frame = TFDirector:getChildByPath(self.Panel_avatars, "Button_use_frame")
    self.Label_use_frame = TFDirector:getChildByPath(self.Button_use_frame, "Label_use_frame")
    self.panel_head = TFDirector:getChildByPath(self.Panel_avatars, "panel_head")

    self.pannel_chatBubble = TFDirector:getChildByPath(self.Panel_avatars, "pannel_chatBubble")
    self.img_bubble = TFDirector:getChildByPath(self.Panel_avatars, "img_bubble")

    self.Button_avatar = TFDirector:getChildByPath(self.Panel_avatars, "Button_avatar")
    self.Button_avatar:getChildByName("Label_Txt"):setColor(ccc3(71,81,119))
    self.Button_avatar:getChildByName("Label_Txt_tip"):setColor(ccc3(71,81,119))

    self.Button_frame = TFDirector:getChildByPath(self.Panel_avatars, "Button_frame")
    self.Button_frame:getChildByName("Label_Txt"):setColor(ccc3(71,81,119))
    self.Button_frame:getChildByName("Label_Txt_tip"):setColor(ccc3(71,81,119))

    self.Button_chatBubble = TFDirector:getChildByPath(self.Panel_avatars, "Button_chatBubble")
    self.Button_chatBubble:getChildByName("Label_Txt"):setColor(ccc3(71,81,119))
    self.Button_chatBubble:getChildByName("Label_Txt_tip"):setColor(ccc3(71,81,119))

    local ScrollView_list = TFDirector:getChildByPath(self.Panel_avatars, "ScrollView_list")
    self.ScrollView_list = UIListView:create(ScrollView_list)
    self.ScrollView_list:setItemsMargin(0)

    local ScrollView_list_frame = TFDirector:getChildByPath(self.Panel_avatars, "ScrollView_list_frame")
    self.ScrollView_list_frame = UIListView:create(ScrollView_list_frame)
    self.ScrollView_list_frame:setItemsMargin(0)

    local Image_scrollBarModel = TFDirector:getChildByPath(self.Panel_avatars, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ScrollView_list:setScrollBar(scrollBar)
    self.avatat_bar = scrollBar

    local scrollBarModel = TFDirector:getChildByPath(self.Panel_avatars, "Image_scrollBarModel1")
    local scrollBarInner = TFDirector:getChildByPath(scrollBarModel, "Image_scrollBarInner")
    local scrollBar1 = UIScrollBar:create(scrollBarModel, scrollBarInner)
    self.ScrollView_list_frame:setScrollBar(scrollBar1)
    self.frame_bar = scrollBar1

    -- 聊天气泡选择ui
    local ScrollView_list_chatBubble = TFDirector:getChildByPath(self.Panel_avatars, "ScrollView_list_chatBubble")
    self.ScrollView_list_chatBubble = UIListView:create(ScrollView_list_chatBubble)
    self.ScrollView_list_chatBubble:setItemsMargin(0)
    local scrollBarModel2 = TFDirector:getChildByPath(self.Panel_avatars, "Image_scrollBarModel2")
    local scrollBarInner2 = TFDirector:getChildByPath(scrollBarModel2, "Image_scrollBarInner")
    local scrollBar2 = UIScrollBar:create(scrollBarModel2, scrollBarInner2)
    self.ScrollView_list_chatBubble:setScrollBar(scrollBar2)
    self.ScrollView_list_chatBubble:setVisible(false)
    self.chat_bar = scrollBar2

    self:selectTabBtn(1, self.Button_avatar)
end

function AvatarChangeView:selectTabBtn(idx, sender)
    if self.selectIdx_ == idx then
        return
    end
    self.selectIdx_ = idx or 1
    
    AvatarDataMgr:sendReqCancelRedpoint(self.selectIdx_)

    local function BtnUIChange()
        local Image_btn = sender:getChildByName("Image_btn") 
        local Label_Txt = sender:getChildByName("Label_Txt")
        local Label_Txt_tip = sender:getChildByName("Label_Txt_tip")
        Image_btn:setVisible(true)
        Label_Txt:setColor(ccc3(255,255,255))
        Label_Txt_tip:setColor(ccc3(255,255,255))
        if self.lastSelectBtn then
            self.lastSelectBtn:getChildByName("Image_btn"):setVisible(false)
            self.lastSelectBtn:getChildByName("Label_Txt"):setColor(ccc3(71,81,119))
            self.lastSelectBtn:getChildByName("Label_Txt_tip"):setColor(ccc3(71,81,119))
        end
    end
    BtnUIChange()

    local function viewChoose()
        self.ScrollView_list:setVisible(self.selectIdx_ == 1)
        self.avatat_bar:setVisible(self.selectIdx_ == 1)

        self.ScrollView_list_frame:setVisible(self.selectIdx_ == 2)
        self.frame_bar:setVisible(self.selectIdx_ == 2)

        self.ScrollView_list_chatBubble:setVisible(self.selectIdx_ == 3)
        self.chat_bar:setVisible(self.selectIdx_ == 3)

        self.pannel_chatBubble:setVisible(self.selectIdx_ == 3)
        self.panel_head:setVisible(not self.pannel_chatBubble:isVisible())

    end
    viewChoose()

    if self.selectIdx_ == 1 then
        self.select_frame_cid = nil
        self.select_bubble_cid = nil
        self:refreshAvatarView()
    elseif self.selectIdx_ == 2 then
        self.select_cid = nil
        self.select_bubble_cid = nil
        self:refreshFrameView()
    elseif self.selectIdx_ == 3 then
        self.select_cid = nil
        self.select_frame_cid = nil
        self:refreshChatBubble()
    end

    self.lastSelectBtn = sender
end

function AvatarChangeView:refreshAvatarView()
    self.m_avatars = AvatarDataMgr:getAvatarCfgArrayData(1)
    local curCid = AvatarDataMgr:getCurUsingCid()
    local selectCfg
    if self.select_cid then
        selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_cid)
    elseif curCid > 0 then
        selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
    else
        for i,info in ipairs(self.m_avatars) do
            for j,v in ipairs(info.cfgs) do
                selectCfg = v
                break
            end
            if selectCfg then
                break
            end
        end
    end
    self:updateSelectAvatar(selectCfg)
    if #self.m_items > 0 then
        self:updateAvatarItems()
        return
    end
    self.m_items = {}

    for i, info in ipairs(self.m_avatars) do
        local panel = self.Panel_class:clone()
        local Label_type = TFDirector:getChildByPath(panel, "Label_type")
        Label_type:setText(self.classify_name[info.classify])
        local totalHeight = 45
        local row = 1
        local col = 1
        for i,cfg in ipairs(info.cfgs) do
            row = math.ceil(i / 5)
            col = (i - 1) % 5 + 1
            local item = self.Panel_avatar_item:clone()
            local size = item:getContentSize()
            item:setPosition(ccp(col * size.width - size.width / 2 - (col - 1) * 2, - 45 - row * size.height + size.height / 2 - (row - 1) * 10))
            panel:addChild(item, 5)
            self:updateAvatarItem(item, cfg)
            table.insert(self.m_items, item)
            if col == 1 then
                totalHeight = totalHeight + size.height
            end
        end
        totalHeight = totalHeight + row * 10
        panel:setSize(CCSizeMake(panel:getContentSize().width, totalHeight))
        self.ScrollView_list:pushBackCustomItem(panel)
    end
end

function AvatarChangeView:updateAvatarItem(item, cfg)
    if not cfg then
        return
    end
    local curCid = AvatarDataMgr:getCurUsingCid()
    local data = AvatarDataMgr:getAvatarInfoById(cfg.cid)
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Image_cover = TFDirector:getChildByPath(item, "Image_cover")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_using = TFDirector:getChildByPath(item, "Image_using")
    Image_icon:setTexture(cfg.icon)
    Image_icon:setSize(CCSizeMake(94, 94))
    Image_cover:setVisible(not data)
    Image_lock:setVisible(not data)
    Image_using:setVisible(cfg.cid == curCid)
    if cfg.cid == self.select_cid then
        if self.selectedImg then
            self.selectedImg:setVisible(false)
        end
        self.selectedImg = Image_select
    end
    Image_select:setVisible(cfg.cid == self.select_cid)
    
    Image_icon:setSize(CCSizeMake(94, 94))
    Image_icon:setTouchEnabled(true)
    Image_icon:onClick(function()
        self:updateSelectAvatar(cfg)
        if self.selectedImg then
            self.selectedImg:setVisible(false)
        end
        self.selectedImg = Image_select
        self.selectedImg:setVisible(true)
    end)
end

function AvatarChangeView:refreshFrameView()
    self.m_frames = AvatarDataMgr:getAvatarCfgArrayData(2)
    local curCid = AvatarDataMgr:getCurUsingFrameCid()
    local selectCfg
    if self.select_frame_cid then
        selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_frame_cid)
    elseif curCid > 0 then
        selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
    else
        for i,info in ipairs(self.m_frames) do
            for j,v in ipairs(info.cfgs) do
                selectCfg = v
                break
            end
            if selectCfg then
                break
            end
        end
    end
    self:updateSelectAvatar(selectCfg)
    if #self.m_frame_items > 0 then
        self:updateFrameItems()
        return
    end
    self.m_frame_items = {}

    for i, info in ipairs(self.m_frames) do
        local panel = self.Panel_class:clone()
        local Label_type = TFDirector:getChildByPath(panel, "Label_type")
        Label_type:setText(self.classify_name[info.classify])
        local totalHeight = 45
        local row = 1
        local col = 1
        for i,cfg in ipairs(info.cfgs) do
            row = math.ceil(i / 3)
            col = (i - 1) % 3 + 1
            local item = self.Panel_frame_item:clone()
            local size = item:getContentSize()
            item:setPosition(ccp(col * size.width - size.width / 2 + (col - 1) * 20, - 45 - row * size.height + size.height / 2 - (row - 1) * 10))
            panel:addChild(item, 5)
            self:updateFrameItem(item, cfg)
            table.insert(self.m_frame_items, item)
            if col == 1 then
                totalHeight = totalHeight + size.height
            end
        end
        totalHeight = totalHeight + row * 10
        panel:setSize(CCSizeMake(panel:getContentSize().width, totalHeight))
        self.ScrollView_list_frame:pushBackCustomItem(panel)
    end
end

function AvatarChangeView:refreshChatBubble()
    self.m_bubbles = AvatarDataMgr:getAvatarCfgArrayData(3)
    local curCid = AvatarDataMgr:getCurUsingBubbleCid()
    local selectCfg
    if self.select_bubble_cid then
        selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_bubble_cid)
    elseif curCid > 0 then
        selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
    else
        for i,info in ipairs(self.m_bubbles) do
            for j,v in ipairs(info.cfgs) do
                selectCfg = v
                break
            end
            if selectCfg then
                break
            end
        end
    end
    self:updateSelectAvatar(selectCfg)
    if #self.m_bubble_items > 0 then
        self:updateBubbleItems()
        return
    end
    self.m_bubble_items = {}

    for i, info in ipairs(self.m_bubbles) do
        local panel = self.Panel_class:clone()
        local Label_type = TFDirector:getChildByPath(panel, "Label_type")
        Label_type:setText(self.classify_name[info.classify])
        local totalHeight = 45
        local row = 1
        local col = 1
        for i,cfg in ipairs(info.cfgs) do
            row = math.ceil(i / 3)
            col = (i - 1) % 3 + 1
            local item = self.Panel_chatBubble_item:clone()
            local size = item:getContentSize()
            item:setPosition(ccp(col * size.width - size.width / 2 + (col - 1) * 20, - 45 - row * size.height + size.height / 2 - (row - 1) * 10))
            panel:addChild(item, 5)
            self:updateBubbleitem(item, cfg)
            table.insert(self.m_bubble_items, item)
            if col == 1 then
                totalHeight = totalHeight + size.height
            end
        end
        totalHeight = totalHeight + row * 10
        panel:setSize(CCSizeMake(panel:getContentSize().width, totalHeight))
        self.ScrollView_list_chatBubble:pushBackCustomItem(panel)
    end
    
end

function AvatarChangeView:updateBubbleitem(item, cfg)
    if not cfg then
        return
    end
    local curCid = AvatarDataMgr:getCurUsingBubbleCid()
    local data = AvatarDataMgr:getChatBubbleDataById(cfg.cid)
    local Img_bubble = TFDirector:getChildByPath(item, "Img_bubble")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Image_cover = TFDirector:getChildByPath(item, "Image_cover")
    local Image_using = TFDirector:getChildByPath(item, "Image_using")
    local Label_desc = TFDirector:getChildByPath(item, "Label_desc")

    Image_cover:setVisible(not data)
    Image_using:setVisible(cfg.cid == curCid)
    if cfg.cid == self.select_bubble_cid then
        if self.selectedBubble then
            self.selectedBubble:setVisible(false)
        end
        self.selectedBubble = Image_select
    end
    Image_select:setVisible(cfg.cid == self.select_bubble_cid)
    Img_bubble:setTexture(cfg.icon)
    Label_desc:setTextById(cfg.name)

    -- if #cfg.toggle > 0  then
    --     local extraData = AvatarDataMgr:getExtraData()
    --     local month = extraData.month or 1
    --     for k, v in pairs(cfg.toggle) do
    --         local months = v.month
    --         local month1 = months[1]
    --         local month2 = months[2]
    --         if month >= month1 and month <= month2 then
    --             Image_icon:setTexture(v.icon)
    --             Label_desc:setTextById(tonumber(v.name))
    --             break
    --         end
    --     end
    -- end

    -- Img_bubble:setSize(CCSizeMake(140, 140))
    Img_bubble:setTouchEnabled(true)
    Img_bubble:onClick(function()
        self:updateSelectAvatar(cfg)
        if self.selectedBubble then
            self.selectedBubble:setVisible(false)
        end
        self.selectedBubble = Image_select
        self.selectedBubble:setVisible(true)
    end)
end

function AvatarChangeView:updateFrameItem(item, cfg)
    if not cfg then
        return
    end
    local curCid = AvatarDataMgr:getCurUsingFrameCid()
    local data = AvatarDataMgr:getAvatarFrameInfoById(cfg.cid)
    local Image_icon = TFDirector:getChildByPath(item, "Image_icon")
    local Image_select = TFDirector:getChildByPath(item, "Image_select")
    local Image_cover = TFDirector:getChildByPath(item, "Image_cover")
    local Image_lock = TFDirector:getChildByPath(item, "Image_lock")
    local Image_using = TFDirector:getChildByPath(item, "Image_using")
    local Label_desc = TFDirector:getChildByPath(item, "Label_desc")

    Image_cover:setVisible(not data)
    Image_lock:setVisible(not data)
    Image_using:setVisible(cfg.cid == curCid)
    if cfg.cid == self.select_frame_cid then
        if self.selectedFrame then
            self.selectedFrame:setVisible(false)
        end
        self.selectedFrame = Image_select
    end
    Image_select:setVisible(cfg.cid == self.select_frame_cid)

    Image_icon:setTexture(cfg.icon)

    local effect = cfg.ShowEffect1 ~= "" and cfg.ShowEffect1 or cfg.ShowEffect2
    local headEffect = Image_icon:getChildByName("headEffect")
    if headEffect then
        headEffect:removeFromParent()
    end
    if effect ~= "" then
        headEffect = SkeletonAnimation:create(effect)
        headEffect:setAnchorPoint(ccp(0,0))
        headEffect:setName("headEffect")
        headEffect:setPosition(ccp(0,0))
        headEffect:play("animation", true)
        Image_icon:addChild(headEffect, 1)
    end

    Label_desc:setTextById(cfg.name)
    if #cfg.toggle > 0  then
        local extraData = AvatarDataMgr:getExtraData()
        local month = extraData.month or 1
        for k, v in pairs(cfg.toggle) do
            local months = v.month
            local month1 = months[1]
            local month2 = months[2]
            if month >= month1 and month <= month2 then
                Image_icon:setTexture(v.icon)
                Label_desc:setTextById(tonumber(v.name))
                break
            end
        end
    end

    Image_icon:setSize(CCSizeMake(140, 140))
    Image_icon:setTouchEnabled(true)
    Image_icon:onClick(function()
        self:updateSelectAvatar(cfg)
        if self.selectedFrame then
            self.selectedFrame:setVisible(false)
        end
        self.selectedFrame = Image_select
        self.selectedFrame:setVisible(true)
    end)
end

function AvatarChangeView:updateSelectAvatar(cfg)
    if not cfg then
        self.Image_avatar:setVisible(false)
        self.Label_name:setVisible(false)
        self.Label_desc:setVisible(false)
        self.Button_use:setVisible(false)
        self.Button_use_frame:setVisible(false)
        -- self.Image_cover_frame:setVisible(false)
        return
    else
        self.Image_avatar:setVisible(true)
        self.Label_name:setVisible(true)
        self.Label_desc:setVisible(true)
        self.Button_use:setVisible(true)
        self.Button_use_frame:setVisible(true)
        -- self.Image_cover_frame:setVisible(true)
    end

    if self.selectIdx_ == 1 then
        self.Button_use:setVisible(true)
        self.Button_use_frame:setVisible(false)
        self.Image_avatar:setTexture(cfg.icon)
        self.Label_name:setTextById(cfg.name)
        self.Label_desc:setTextById(cfg.accessdes)
        local curCid = AvatarDataMgr:getCurUsingCid()
        local data = AvatarDataMgr:getAvatarInfoById(cfg.cid)
        if cfg.cid ~= curCid and data then
            self.Button_use:setVisible(true)
        else
            self.Button_use:setVisible(false)
        end
        self.select_cid = cfg.cid
        local frameCid = self.select_frame_cid or AvatarDataMgr:getCurUsingFrameCid()
        local iconPath,effect = AvatarDataMgr:getSelfAvatarFrameIconPath(frameCid)
        self.Image_cover_frame:setTexture(iconPath)
        if effect ~= "" then
            if self.HeadFrameEffect then
                self.HeadFrameEffect:removeFromParent()
                self.HeadFrameEffect = nil
            end
            if not self.HeadFrameEffect then
                self.HeadFrameEffect = SkeletonAnimation:create(effect)
                self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
                self.HeadFrameEffect:setPosition(ccp(0,0))
                self.HeadFrameEffect:play("animation", true)
                self.Image_cover_frame:addChild(self.HeadFrameEffect, 1)
            end
        else
            if self.HeadFrameEffect then
                self.HeadFrameEffect:removeFromParent()
                self.HeadFrameEffect = nil
            end
        end

    elseif self.selectIdx_ == 2 then
        self.Button_use:setVisible(false)
        self.Button_use_frame:setVisible(true)
        self.Image_avatar:setTexture(AvatarDataMgr:getSelfAvatarIconPath())

        local effect = cfg.ShowEffect1 ~= "" and cfg.ShowEffect1 or cfg.ShowEffect2
        if effect ~= "" then
            if self.HeadFrameEffect then
                self.HeadFrameEffect:removeFromParent()
                self.HeadFrameEffect = nil
            end
            if not self.HeadFrameEffect then
                self.HeadFrameEffect = SkeletonAnimation:create(effect)
                self.HeadFrameEffect:setAnchorPoint(ccp(0,0))
                self.HeadFrameEffect:setPosition(ccp(0,0))
                self.HeadFrameEffect:play("animation", true)
                self.Image_cover_frame:addChild(self.HeadFrameEffect, 1)
            end
        else
            if self.HeadFrameEffect then
                self.HeadFrameEffect:removeFromParent()
                self.HeadFrameEffect = nil
            end
        end

        self.Image_cover_frame:setTexture(cfg.icon)
        self.Image_cover_frame:setSize(CCSizeMake(130, 130))
        self.Label_name:setTextById(cfg.name)
        self.Label_desc:setTextById(cfg.accessdes)
        if #cfg.toggle > 0  then
            local extraData = AvatarDataMgr:getExtraData()
            local month = extraData.month or 1
            for k, v in pairs(cfg.toggle) do
                local months = v.month
                local month1 = months[1]
                local month2 = months[2]
                if month >= month1 and month <= month2 then
                    self.Image_cover_frame:setTexture(v.icon)
                    self.Label_name:setTextById(tonumber(v.name))
                    self.Label_desc:setTextById(tonumber(v.describe))
                    break
                end
            end
        end

        local curCid = AvatarDataMgr:getCurUsingFrameCid()
        local data = AvatarDataMgr:getAvatarFrameInfoById(cfg.cid)
        if cfg.cid ~= curCid and data then
            self.Button_use_frame:setVisible(true)
        else
            self.Button_use_frame:setVisible(false)
        end
        self.select_frame_cid = cfg.cid
    elseif self.selectIdx_ == 3 then
        self.Button_use_frame:setVisible(false)
        self.img_bubble:setTexture(cfg.icon)
        self.Label_name:setTextById(cfg.name)
        self.Label_desc:setTextById(cfg.accessdes)

        if cfg.cid ~= AvatarDataMgr:getCurUsingBubbleCid() and  AvatarDataMgr:getChatBubbleDataById(cfg.cid) then
            self.Button_use:setVisible(true)
        else
            self.Button_use:setVisible(false)
        end

        self.select_bubble_cid = cfg.cid
    end
    
    self.Image_avatar:setSize(CCSizeMake(94, 94))
end

function AvatarChangeView:updateAvatarItems()
    self.m_avatars = AvatarDataMgr:getAvatarCfgArrayData(1)
    local num = 1
    for i, info in ipairs(self.m_avatars) do
        for i,cfg in ipairs(info.cfgs) do
            if num <= #self.m_items then
                local item = self.m_items[num]
                self:updateAvatarItem(item, cfg)
                num = num + 1
            end
        end
    end
end

function AvatarChangeView:updateFrameItems()
    self.m_frames = AvatarDataMgr:getAvatarCfgArrayData(2)
    local num = 1
    for i, info in ipairs(self.m_frames) do
        for i,cfg in ipairs(info.cfgs) do
            if num <= #self.m_frame_items then
                local item = self.m_frame_items[num]
                self:updateFrameItem(item, cfg)
                num = num + 1
            end
        end
    end
end

function AvatarChangeView:updateBubbleItems()
    self.m_bubbles = AvatarDataMgr:getAvatarCfgArrayData(3)
    local num = 1
    for i, info in ipairs(self.m_bubbles) do
        for i,cfg in ipairs(info.cfgs) do
            if num <= #self.m_bubble_items then
                local item = self.m_bubble_items[num]
                self:updateBubbleitem(item, cfg)
                num = num + 1
            end
        end
    end
end

function AvatarChangeView:onAvatarUpdata()
    
    local selectCfg
    local num = 1
    if self.selectIdx_ == 1 then
        self:updateAvatarItems()
        self.m_avatars = AvatarDataMgr:getAvatarCfgArrayData(1)
        local curCid = AvatarDataMgr:getCurUsingCid()
        if self.select_cid then
            selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_cid)
        elseif curCid > 0 then
            selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
        else
            for i,info in ipairs(self.m_avatars) do
                for j,v in ipairs(info.cfgs) do
                    selectCfg = v
                    break
                end
                if selectCfg then
                    break
                end
            end
        end
    elseif self.selectIdx_ == 2 then
        self:updateFrameItems()
        self.m_frames = AvatarDataMgr:getAvatarCfgArrayData(2)
        local curCid = AvatarDataMgr:getCurUsingFrameCid()
        if self.select_frame_cid then
            selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_frame_cid)
        elseif curCid > 0 then
            selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
        else
            for i,info in ipairs(self.m_frames) do
                for j,v in ipairs(info.cfgs) do
                    selectCfg = v
                    break
                end
                if selectCfg then
                    break
                end
            end
        end
    elseif self.selectIdx_ == 3 then
        self:updateBubbleItems()
        self.m_bubbles = AvatarDataMgr:getAvatarCfgArrayData(3)
        local curCid = AvatarDataMgr:getCurUsingBubbleCid()
        if self.select_bubble_cid then
            selectCfg = AvatarDataMgr:getAvatarCfgById(self.select_bubble_cid)
        elseif curCid > 0 then
            selectCfg = AvatarDataMgr:getAvatarCfgById(curCid)
        else
            for i,info in ipairs(self.m_bubbles) do
                for j,v in ipairs(info.cfgs) do
                    selectCfg = v
                    break
                end
                if selectCfg then
                    break
                end
            end
        end
    end
    
    self:updateSelectAvatar(selectCfg)
end

function AvatarChangeView:registerEvents()
    EventMgr:addEventListener(self, EV_AVATAR_UPDATE, handler(self.onAvatarUpdata, self))
    
    self.Button_use:onClick(function()
        if self.select_cid and self.selectIdx_ == 1 then
            AvatarDataMgr:sendReqUseAvatar(self.select_cid)
        elseif self.select_bubble_cid and self.selectIdx_ == 3 then
            AvatarDataMgr:sendReqUseAvatar(self.select_bubble_cid)
        end
    end)

    self.Button_use_frame:onClick(function()
        if self.select_frame_cid then
            AvatarDataMgr:sendReqUseAvatar(self.select_frame_cid)
        end
    end)

    self.Button_avatar:onClick(function(sender)
        self:selectTabBtn(1,sender)
    end)

    self.Button_frame:onClick(function(sender)
        self:selectTabBtn(2,sender)
    end)

    self.Button_chatBubble:onClick(function(sender)
        self:selectTabBtn(3,sender)
    end)

    self.Button_close:onClick(function()
        AlertManager:close()
    end, EC_BTN.CLOSE)
end

return AvatarChangeView