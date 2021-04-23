
local FriendView = class("FriendView", BaseLayer)
local ScrollBar = require("lua.logic.chat.ScrollBar")

function FriendView:initData(selectIndex)
    self.tabData_ = {
        {
            text = 700001,
            title = 700006,
            heading = 700005,
            icon = "ui/friend/016.png",
            bIcon = "icon/system/044.png",
            type_ = EC_Friend.FRIEND,
        },
        {
            text = 700002,
            title = 700006,
            heading = 700022,
            icon = "ui/friend/017.png",
            bIcon = "icon/system/044.png",
            type_ = EC_Friend.APPLY,
        },
        --{
        --    text = 263106,
        --    title = 700006,
        --    heading = 700023,
        --    icon = "ui/friend/invite/001.png",
        --    bIcon = "icon/system/044.png",
        --    type_ = EC_Friend.INVITE,
        --},
        {
            text = 700003,
            title = 700006,
            heading = 700023,
            icon = "ui/friend/018.png",
            bIcon = "icon/system/044.png",
            type_ = EC_Friend.ADD,
        },
        {
            text = 700004,
            title = 700031,
            heading = 700004,
            icon = "ui/friend/019.png",
            bIcon = "icon/system/045.png",
            type_ = EC_Friend.SHIELDING,
        }
    }

    -- TOOD CLOSE
    -- 屏蔽师徒系统
    -- if Utils:getKVP(90023,"open") == 1 and MainPlayer:getPlayerLv() >= Utils:getKVP(90023, "openinglevel") then
    --     table.insert(self.tabData_,{
    --         text = 1340000,
    --         title = 700031,
    --         heading = 700004,
    --         icon = "ui/friend/master/icon.png",
    --         bIcon = "icon/system/045.png",
    --         type_ = EC_Friend.MASTER,
    --     })
    -- end
    
    self.ruleText_ = {700057, 700058, 700060, 700061}

    self.tabBtn_ = {}
    self.defaultSelectIndex_ = 1
    if selectIndex and selectIndex <= #self.tabData_ then
        self.defaultSelectIndex_ = selectIndex
    end

    self.curIndex = EC_FriendMaster.Master    -- 师徒顶部选中按钮 

    self.lastSelectIndex = self.defaultSelectIndex_
    self.friendItem_ = {}
    self.defaultSelectRuleIndex_ = 1
    self.selectRuleIndex_ = 1

    self.friend_ = {}
    self.applyFriend_ = {}
    self.addFriend_ = {}
    self.shieldingFriend_ = {}
    self.deletPlayerCids = {}
    self.delectState = false

    self.maxFriendsNum_ = FriendDataMgr:getMaxFriendNum()
    self.maxReceiveCount_ = FriendDataMgr:getMaxReceiveCount()
end

function FriendView:getClosingStateParams()
    return {self.selectIndex_}
end

function FriendView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.friend.friendView")
end

function FriendView:onShow()
    self.super.onShow(self)
    if self.tabData_[self.selectIndex_].type_ ~= EC_Friend.INVITE then
        FriendDataMgr:send_FRIEND_REQ_GET_FRIEND_INVITE_INFO()
    end
    self:refreshBtnsRed()
end

function FriendView:initUI(ui)
    self.super.initUI(self, ui)
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_friend = TFDirector:getChildByPath(self.Panel_root, "Panel_friend")
    local Image_friendScrollBar = TFDirector:getChildByPath(self.Panel_friend, "Image_friendScrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_friendScrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_friendScrollBar, Image_scrollBarInner)
    local ScrollView_friend = TFDirector:getChildByPath(self.Panel_friend, "ScrollView_friend")
    self.ListView_friend = UIListView:create(ScrollView_friend)
    self.ListView_friend:setScrollBar(scrollBar)
    self.ListView_friend:setItemsMargin(5)
    self.ListView_friend.scrollView = ScrollView_friend
    self.Panel_friend_sort = TFDirector:getChildByPath(self.Panel_friend, "Panel_friend_sort")
    self.Button_sortRule = TFDirector:getChildByPath(self.Panel_friend_sort, "Button_sortRule")
    self.Label_sortRule = TFDirector:getChildByPath(self.Button_sortRule, "Label_sortRule")
    self.Panel_sortRule = TFDirector:getChildByPath(self.Panel_friend_sort, "Panel_sortRule")
    self.Button_rule = {}
    for i = 1, 4 do
        local Button_rule = TFDirector:getChildByPath(self.Panel_sortRule, "Button_rule_" .. i)
        TFDirector:getChildByPath(Button_rule, "Label_nameSelect"):setTextById(self.ruleText_[i])
        self.Button_rule[i] = Button_rule
    end

    --添加空文本显示
    self.label_empyTetx_friend = TFLabel:create()
    self.label_empyTetx_friend:setFontName("font/MFLiHei_Noncommercial.ttf")
    self.label_empyTetx_friend:setFontSize(22)
    self.label_empyTetx_friend:setTextAreaSize(CCSize(800 , 0))
    self.label_empyTetx_friend:setAnchorPoint(ccp(0.5 , 1))
    self.label_empyTetx_friend:setPosition(57 , -30)
    self.label_empyTetx_friend:setTextById(190000173)
    --self.label_empyTetx:enableOutline(ccc4(0,0,0,255), 1)
    self.Panel_friend:addChild(self.label_empyTetx_friend)

    self.Button_receive = TFDirector:getChildByPath(self.Panel_friend, "Button_receive")
    self.Label_receive = TFDirector:getChildByPath(self.Button_receive, "Label_receive")
    self.Button_giving = TFDirector:getChildByPath(self.Panel_friend, "Button_giving")
    self.Label_giving = TFDirector:getChildByPath(self.Button_giving, "Label_giving")
    self.Image_givingCount = TFDirector:getChildByPath(self.Panel_friend, "Image_givingCount")
    self.Label_givingCountTitle = TFDirector:getChildByPath(self.Image_givingCount, "Label_givingCountTitle")
    self.Label_givingCount = TFDirector:getChildByPath(self.Image_givingCount, "Label_givingCount")
    self.Label_friendView_delet_tips = TFDirector:getChildByPath(self.Panel_friend, "Label_friendView_delet_tips")
    self.Label_friendDotTitle = TFDirector:getChildByPath(self.Panel_friend, "Label_friendDotTitle")
    self.Image_friendIcon = TFDirector:getChildByPath(self.Panel_friend, "Image_friendIcon")
    self.Label_friendDotCount = TFDirector:getChildByPath(self.Panel_friend, "Label_friendDotCount")
    self.Button_delet_all = TFDirector:getChildByPath(self.Panel_friend, "Button_delet_all")
    self.Button_delet_sure = TFDirector:getChildByPath(self.Panel_friend, "Button_delet_sure")
    self.Button_delet_cancel = TFDirector:getChildByPath(self.Panel_friend, "Button_delet_cancel")

    self.Panel_apply = TFDirector:getChildByPath(self.Panel_root, "Panel_apply")
    local Image_applyScrollBar = TFDirector:getChildByPath(self.Panel_apply, "Image_applyScrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_applyScrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_applyScrollBar, Image_scrollBarInner)
    local ScrollView_apply = TFDirector:getChildByPath(self.Panel_apply, "ScrollView_apply")
    self.ListView_apply = UIListView:create(ScrollView_apply)
    self.ListView_apply:setItemsMargin(5)
    self.ListView_apply:setScrollBar(scrollBar)
    self.ListView_apply.scrollView = ScrollView_apply
    self.Button_agree = TFDirector:getChildByPath(self.Panel_root, "Button_agree")
    self.Label_agree = TFDirector:getChildByPath(self.Button_agree, "Label_agree")
    self.Button_reject = TFDirector:getChildByPath(self.Panel_root, "Button_reject")
    self.Label_reject = TFDirector:getChildByPath(self.Button_reject, "Label_reject")
     --添加空文本显示
    self.label_empyTetx_apply = TFLabel:create()
    self.label_empyTetx_apply:setFontName("font/MFLiHei_Noncommercial.ttf")
    self.label_empyTetx_apply:setFontSize(22)
    self.label_empyTetx_apply:setTextAreaSize(CCSize(800 , 0))
    self.label_empyTetx_apply:setAnchorPoint(ccp(0.5 , 1))
    self.label_empyTetx_apply:setPosition(57 , -30)
    self.label_empyTetx_apply:setTextById(190000174)
    --self.label_empyTetx:enableOutline(ccc4(0,0,0,255), 1)
    self.Panel_apply:addChild(self.label_empyTetx_apply)

    self.Panel_add = TFDirector:getChildByPath(self.Panel_root, "Panel_add")
    local Image_addScrollBar = TFDirector:getChildByPath(self.Panel_add, "Image_addScrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_addScrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_addScrollBar, Image_scrollBarInner)
    local ScrollView_add = TFDirector:getChildByPath(self.Panel_add, "ScrollView_add")
    self.ListView_add = UIListView:create(ScrollView_add)
    self.ListView_add:setItemsMargin(5)
    self.ListView_add:setScrollBar(scrollBar)
    self.ListView_add.scrollView = ScrollView_add
    self.Button_refresh = TFDirector:getChildByPath(self.Panel_root, "Button_refresh")
    self.Image_refresh = TFDirector:getChildByPath(self.Button_refresh, "Image_refresh"):show()
    self.Label_refresh_timing = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh_timing"):hide()
    self.Button_add = TFDirector:getChildByPath(self.Panel_root, "Button_add")
    self.Label_add = TFDirector:getChildByPath(self.Button_add, "Label_add")
    local Panel_find = TFDirector:getChildByPath(self.Panel_add, "Panel_find")
    self.Button_find = TFDirector:getChildByPath(Panel_find, "Button_find")
    self.TextField_find = TFDirector:getChildByPath(Panel_find, "TextField_find")
    self.Label_recommendTitle = TFDirector:getChildByPath(Panel_find, "Label_recommendTitle")

    --羁友页面
    self.Panel_invite = TFDirector:getChildByPath(self.Panel_root, "Panel_invite")
    -- self.Panel_invite:getChild("Label_tips"):setTextById(263199)
    local Image_inviteScrollBar = TFDirector:getChildByPath(self.Panel_invite, "Image_inviteScrollBar")
    local Image_inviteScrollBarInner = TFDirector:getChildByPath(Image_inviteScrollBar, "Image_scrollBarInner")
    local ScrollView_invite = TFDirector:getChildByPath(self.Panel_invite, "ScrollView_inviteReward")
    self.ListView_invite = UIListView:create(ScrollView_invite)
    self.ListView_invite:setItemsMargin(5)
    self.ListView_invite:setScrollBar(UIScrollBar:create(Image_inviteScrollBar, Image_inviteScrollBarInner))
    --羁友邀请开放未开放
    self.Panel_inviteClose = self.Panel_invite:getChild("Panel_inviteClose")
    self.Image_bindBg = self.Panel_invite:getChild("Image_bindBg")
    self.Label_bindCode = self.Image_bindBg:getChild("Label_bindCode")
    self.Image_codeInputBg = self.Panel_invite:getChild("Image_inputBg")
    self.TextField_inputCode = self.Image_codeInputBg:getChild("TextField_inputCode")
    self.Button_invite = self.Panel_inviteClose:getChild("Button_invite")
    self.Button_invite:onClick(function()
        local code = self.TextField_inputCode:getText()
        if string.len(code) > 0 then
            FriendDataMgr:send_FRIEND_REQ_BIND_INVITE_CODE(code)
        else
            Utils:showTips(263104)
        end
    end)
    --
    self.Panel_inviteOpen = self.Panel_invite:getChild("Panel_inviteOpen")
    self.Label_selfCode = self.Panel_inviteOpen:getChild("Label_selfCode")
    self.Label_inviteNum = self.Panel_inviteOpen:getChild("Label_inviteNum")
    local Button_copy = self.Panel_inviteOpen:getChild("Button_copy")
    Button_copy:onClick(function()
        TFDeviceInfo:copyToPasteBord(self.Label_selfCode:getString())
        Utils:showTips(600010)
    end)

    self.Panel_shielding = TFDirector:getChildByPath(self.Panel_root, "Panel_shielding")
    local Image_shieldingScrollBar = TFDirector:getChildByPath(self.Panel_shielding, "Image_shieldingScrollBar")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_shieldingScrollBar, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_shieldingScrollBar, Image_scrollBarInner)
    local ScrollView_shielding = TFDirector:getChildByPath(self.Panel_shielding, "ScrollView_shielding")
    self.ListView_shielding = UIListView:create(ScrollView_shielding)
    self.ListView_shielding:setItemsMargin(5)
    self.ListView_shielding:setScrollBar(scrollBar)
    self.ListView_shielding.scrollView = ScrollView_shielding

     --添加空文本显示
    self.label_empyTetx_shielding = TFLabel:create()
    self.label_empyTetx_shielding:setFontName("font/MFLiHei_Noncommercial.ttf")
    self.label_empyTetx_shielding:setFontSize(22)
    self.label_empyTetx_shielding:setTextAreaSize(CCSize(800 , 0))
    self.label_empyTetx_shielding:setAnchorPoint(ccp(0.5 , 1))
    self.label_empyTetx_shielding:setPosition(57 , -30)
    self.label_empyTetx_shielding:setTextById(190000176)
    --self.label_empyTetx:enableOutline(ccc4(0,0,0,255), 1)
    self.Panel_shielding:addChild(self.label_empyTetx_shielding)


    -- 师徒
    self.Panel_master              = TFDirector:getChildByPath(self.Panel_root, "Panel_master")
    local masterTableview          = TFDirector:getChildByPath(self.Panel_root, "ScrollView_master")
    self.masterTableview           = Utils:scrollView2TableView(masterTableview):hide()
    local Image_shieldingScrollBar = TFDirector:getChildByPath(self.Panel_master, "Image_shieldingScrollBar")
    local Image_scrollBarInner      = TFDirector:getChildByPath(Image_shieldingScrollBar, "Image_scrollBarInner")
    self.scrollBar                 = UIScrollBar:create(Image_shieldingScrollBar, Image_scrollBarInner)
    self.lab_masterIsData          = TFDirector:getChildByPath(self.Panel_master, "lab_masterIsData")
    self.lab_masterTxt             = TFDirector:getChildByPath(self.lab_masterIsData, "lab_masterTxt")
    self.Panel_masterBtns          = TFDirector:getChildByPath(self.Panel_master, "Panel_masterBtns")
    self.btn_masterSpec            = TFDirector:getChildByPath(self.Panel_master, "btn_masterSpec")
    self.btn_task                  = TFDirector:getChildByPath(self.Panel_master, "btn_task")
    self.btn_apply                 = TFDirector:getChildByPath(self.Panel_master, "btn_apply")
    self.btn_askMaster             = TFDirector:getChildByPath(self.Panel_master, "btn_askMaster"):show()
    self.btn_getApprentice         = TFDirector:getChildByPath(self.Panel_master, "btn_getApprentice"):show()
    self.Panel_masterItem          = TFDirector:getChildByPath(self.Panel_prefab, "Panel_masterItem")
    TFDirector:getChildByPath(self.Panel_masterBtns, "btn_1.txt"):setTextById(1340023)
    TFDirector:getChildByPath(self.Panel_masterBtns, "btn_2.txt"):setTextById(1340024)
    TFDirector:getChildByPath(self.btn_masterSpec, "txt"):setTextById(1340026)
    TFDirector:getChildByPath(self.btn_task, "txt"):setTextById(1340025)
    TFDirector:getChildByPath(self.btn_apply, "txt"):setTextById(1340020)
    TFDirector:getChildByPath(self.btn_askMaster, "txt"):setTextById(1340021)
    TFDirector:getChildByPath(self.btn_getApprentice, "txt"):setTextById(1340022)
    -- 师徒相关红点
    self.btn_masterSpecRed         = TFDirector:getChildByPath(self.btn_masterSpec, "Image_redtip")
    self.btn_taskRed               = TFDirector:getChildByPath(self.btn_task, "Image_redtip")
    self.btn_applyRed              = TFDirector:getChildByPath(self.btn_apply, "Image_redtip")

    self.Panel_top = TFDirector:getChildByPath(self.Panel_root, "Panel_top")
    local Panel_left = TFDirector:getChildByPath(self.Panel_root, "Panel_left")
    self.Label_count = TFDirector:getChildByPath(self.Panel_top, "Label_count")
    local ScrollView_tab = TFDirector:getChildByPath(Panel_left, "ScrollView_tab")
    self.ListView_tab = UIListView:create(ScrollView_tab)

    self.Panel_tabItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tabItem")
    self.Panel_friendItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_friendItem")
    self.Panel_inviteReward = TFDirector:getChildByPath(self.Panel_prefab, "Panel_inviteReward")
    self.Label_friendView_delet_tips:setTextById(700056)
    --self.Label_titleName = TFDirector:getChildByPath(Image_bottom, "Image_titleName.Label_titleName")
    --self.Image_titleIcon = TFDirector:getChildByPath(Image_bottom, "Image_titleIcon")
    --self.Label_heading = TFDirector:getChildByPath(Image_bottom, "Image_heading.Label_heading")

    self:refreshView()
end


function FriendView:refreshView()
    self:initTabBtn()

    local params = {
        _type = EC_InputLayerType.OK,
        buttonCallback = function()
        end,
        closeCallback = function()

        end
    }
    self.inputLayer_ = requireNew("lua.logic.common.InputLayer"):new(params)
    self:addLayer(self.inputLayer_, 1000)

    self.Label_friendDotTitle:setTextById(700017)
    local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.FRIENDSHIP)
    self.Image_friendIcon:setTexture(itemCfg.icon)
    self.Label_givingCountTitle:setTextById(700009)
    self.Label_recommendTitle:setTextById(700041)
    local placeHolder = TextDataMgr:getText(700025)
    self.TextField_find:setPlaceHolder(placeHolder)

    self:selectTab(self.defaultSelectIndex_)
end

function FriendView:refreshMasterBtns()
    local btnAskMasterBool = false
    local isHadMaster, isHadApprentice = FriendDataMgr:isHaveMasterApprentice()
    local isOutMaster = FriendDataMgr:isApprenticeFinished()
    local limitLv  = Utils:getKVP(90023, "apprenticeClass")
    local playerLv = MainPlayer:getPlayerLv()
    if limitLv[1] <= playerLv and playerLv <= limitLv[2] then
        btnAskMasterBool = true
    end
    if isHadMaster and not isOutMaster then
        btnAskMasterBool = true
    end
    self.btn_askMaster:setVisible(btnAskMasterBool)
    self.btn_getApprentice:setVisible(not btnAskMasterBool)
    self.btn_askMaster:setGrayEnabled(not FriendDataMgr:isCanApplyMater())
    self.btn_getApprentice:setGrayEnabled(not FriendDataMgr:isCanGetApprentice())
end

function FriendView:initTabBtn()
    for i, v in ipairs(self.tabData_) do
        local Panel_tabItem= self.Panel_tabItem:clone()
        local item = {}
        item.root = Panel_tabItem
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
        item.Image_tips = TFDirector:getChildByPath(item.root, "Image_tips")
        self.tabBtn_[item.root] = item
        self:updateTabItem(Panel_tabItem, i)
        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function FriendView:insertTabBtn(tabconf)
    local isHave = false
    for i = #self.tabData_, 1, -1 do
        local tabdata = self.tabData_[i]
        if tabdata.type_ == tabconf.type_ then
            isHave = true
            break
        end
    end
    if not isHave then
        table.insert(self.tabData_, tabconf)
        local Panel_tabItem= self.Panel_tabItem:clone()
        local item = {}
        item.root = Panel_tabItem
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
        item.Image_tips = TFDirector:getChildByPath(item.root, "Image_tips")
        self.tabBtn_[item.root] = item
        self:updateTabItem(Panel_tabItem, #self.tabData_)
        self.ListView_tab:pushBackCustomItem(Panel_tabItem)
    end
end

function FriendView:updateTabItem(Panel_tabItem, index)
    local tabData = self.tabData_[index]
    local item = self.tabBtn_[Panel_tabItem]
    item.Label_name:setTextById(tabData.text)
    item.Image_icon:setTexture(tabData.icon)
    item.root:onClick(function()
        self:selectTab(index)
    end)
end

function FriendView:updateRedPointStatus()
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabBtn_[v]
        local tabData = self.tabData_[i]
        if tabData.type_ ~= EC_Friend.INVITE then
            local isCanReceive = false
            if tabData.type_ == EC_Friend.FRIEND then
                isCanReceive = FriendDataMgr:isCanRecvFriendShip()
            elseif tabData.type_ == EC_Friend.APPLY then
                isCanReceive = FriendDataMgr:isHaveFriendRequest()
            elseif tabData.type_ == EC_Friend.MASTER then
                isCanReceive = FriendDataMgr:isMasterRelationShow()
            end
            item.Image_tips:setVisible(isCanReceive)
        end
    end
end

function FriendView:updateSelectTab()
    local tabData = self.tabData_[self.selectIndex_]
    self.delectState = false
    if tabData.type_ == EC_Friend.FRIEND then
        self:updateFriendBtnState()
    elseif tabData.type_ == EC_Friend.APPLY then
        self:showApply()
    elseif tabData.type_ == EC_Friend.ADD then
        self:showAdd()
    elseif tabData.type_ == EC_Friend.SHIELDING then
        self:showShielding()
    elseif tabData.type_ == EC_Friend.INVITE then
        self:showInvite()
    elseif tabData.type_ == EC_Friend.MASTER then
        self:refreshMasterBtns()
        self:showMaster()
    end

    self:updateRedPointStatus()
end

function FriendView:selectTab(index)
    if self.selectIndex_ == index then return end
    if self.selectIndex_ then
        self.lastSelectIndex = self.selectIndex_
    end
    self.selectIndex_ = index

    local tabData = self.tabData_[index]
    self.Panel_friend:setVisible(tabData.type_ == EC_Friend.FRIEND)
    self.Panel_apply:setVisible(tabData.type_ == EC_Friend.APPLY)
    self.Panel_add:setVisible(tabData.type_ == EC_Friend.ADD)
    self.Panel_invite:setVisible(tabData.type_ == EC_Friend.INVITE)
    self.Panel_shielding:setVisible(tabData.type_ == EC_Friend.SHIELDING)
    self.Panel_master:setVisible(tabData.type_ == EC_Friend.MASTER) 

    self.Panel_top:setVisible(tabData.type_ ~= EC_Friend.INVITE and tabData.type_ ~= EC_Friend.MASTER)

    for i, v in ipairs(self.ListView_tab:getItems()) do
        local item = self.tabBtn_[v]
        item.Image_select:setVisible(i == index)
    end

    self:updateSelectTab()
end

function FriendView:showFriend()
    self:selectSortRule(self.selectRuleIndex_)
end

function FriendView:updateFriendBtnState()
    if self.delectState then
        self.Button_giving:setVisible(false)
        self.Button_receive:setVisible(false)
        self.Button_delet_all:setVisible(false)
        self.Button_delet_cancel:setVisible(true)
        self.Button_delet_sure:setVisible(true)
        self.Button_delet_sure:setTouchEnabled(false)
        self.Button_delet_sure:setGrayEnabled(true)
        self.Image_givingCount:setVisible(false)
        self.Label_friendView_delet_tips:setVisible(true)
        self.Panel_friend_sort:hide()
    else
        self.Panel_friend_sort:show()
        self.Button_giving:setVisible(true)
        self.Button_receive:setVisible(true)
        self.Button_delet_all:setVisible(true)
        self.Button_delet_cancel:setVisible(false)
        self.Button_delet_sure:setVisible(false)
        self.Image_givingCount:setVisible(true)
        self.Label_friendView_delet_tips:setVisible(false)
        if #self.friend_ > 0 then
            self.Button_delet_all:setTouchEnabled(true)
            self.Button_delet_all:setGrayEnabled(false)
        else
            self.Button_delet_all:setTouchEnabled(false)
            self.Button_delet_all:setGrayEnabled(true)
        end
    end
    self.deletPlayerCids = {}
    self:showFriend()
    self:updateItemSelectState()
end

function FriendView:showApply()
    self:updateFriendListByType(EC_Friend.APPLY)
    self.Label_count:setTextById(800005, #self.friend_, self.maxFriendsNum_)
end

function FriendView:showAdd()
    self.addFriend_ = FriendDataMgr:getFriend(EC_Friend.ADD)
    if #self.addFriend_ == 0 then
        FriendDataMgr:send_FRIEND_REQ_RECOMMEND_FRIENDS()
    else
        self:updateFriendListByType(EC_Friend.ADD)
    end
    self.Label_count:setTextById(800005, #self.friend_, self.maxFriendsNum_)
end

function FriendView:showShielding()
    self:updateFriendListByType(EC_Friend.SHIELDING)
    self.Label_count:setTextById(800005, #self.shieldingFriend_, self.maxFriendsNum_)
end

function FriendView:showInvite()
    self.Panel_invite:hide()
    FriendDataMgr:send_FRIEND_REQ_GET_FRIEND_INVITE_INFO()
    -- self:onFriendInviteUpdateEvent()
end

function FriendView:showMaster()
    self:selectMaterByIndex(self.curIndex)
end

function FriendView:addFriendItem(itemCell)
    local Panel_friendItem = itemCell or self.Panel_friendItem:clone()

    local item = {}
    item.root = Panel_friendItem
    item.Image_diban = TFDirector:getChildByPath(item.root, "Image_diban")
    item.Image_head = TFDirector:getChildByPath(item.Image_diban, "Image_head")
    item.Image_icon = TFDirector:getChildByPath(item.Image_diban, "Image_icon")
    item.Image_icon_cover_frame = TFDirector:getChildByPath(item.Image_diban, "Image_icon_cover_frame")
    item.Image_quality = TFDirector:getChildByPath(item.Image_diban, "Image_quality")
    item.Label_nameTitle = TFDirector:getChildByPath(item.Image_diban, "Label_nameTitle")
    item.Label_powerTitle = TFDirector:getChildByPath(item.Image_diban, "Label_powerTitle")
    item.Label_name = TFDirector:getChildByPath(item.Image_diban, "Label_name")
    item.Label_power = TFDirector:getChildByPath(item.Image_diban, "Label_power")
    item.Label_level = TFDirector:getChildByPath(item.Image_diban, "Label_level")
    item.Label_recentLogin = TFDirector:getChildByPath(item.Image_diban, "Label_recentLogin")
    item.Button_receive = TFDirector:getChildByPath(item.Image_diban, "Button_receive")
    item.Label_receiveTxt = TFDirector:getChildByPath(item.Button_receive, "Label_receiveTxt")
    -- item.Label_receiveTxt:setTextById(700013)
    item.Button_giving = TFDirector:getChildByPath(item.Image_diban, "Button_giving")
    item.Label_givingTxt = TFDirector:getChildByPath(item.Button_giving, "Label_givingTxt")
    -- Label_givingTxt:setTextById(700014)
    item.Button_agree = TFDirector:getChildByPath(item.Image_diban, "Button_agree")
    local Label_agreeTxt = TFDirector:getChildByPath(item.Button_agree, "Label_agreeTxt")
    
    item.Button_reject = TFDirector:getChildByPath(item.Image_diban, "Button_reject")
    local Label_rejectTxt = TFDirector:getChildByPath(item.Button_reject, "Label_rejectTxt")
    
    item.Button_add = TFDirector:getChildByPath(item.Image_diban, "Button_add")
    local Label_addTxt = TFDirector:getChildByPath(item.Button_add, "Label_addTxt")
   
    item.Button_shielding = TFDirector:getChildByPath(item.Image_diban, "Button_shielding")
    local Label_shieldingTxt = TFDirector:getChildByPath(item.Button_shielding, "Label_shieldingTxt")

    item.img_relation = TFDirector:getChildByPath(item.Image_diban, "img_relation")
    
    if not itemCell then
        Label_agreeTxt:setTextById(700018)
        Label_rejectTxt:setTextById(700019)
        Label_addTxt:setTextById(700003)
        Label_shieldingTxt:setTextById(700030)
    end
    -- 寄语按钮
    item.Button_sendBless = TFDirector:getChildByPath(item.Image_diban, "Button_sendBless")

    item.Panel_friendView_gray = TFDirector:getChildByPath(item.Image_diban, "Panel_friendView_gray")
    item.Image_friendView_select = TFDirector:getChildByPath(item.Image_diban, "Image_friendView_select")

    -- 师徒item
    item.btn_masterDelete   = TFDirector:getChildByPath(item.Image_diban, "btn_masterDelete")
    item.btn_masterGiveGift = TFDirector:getChildByPath(item.Image_diban, "btn_masterGiveGift")
    item.btn_masterGetGift  = TFDirector:getChildByPath(item.Image_diban, "btn_masterGetGift")
    item.img_masterRelation = TFDirector:getChildByPath(item.Image_diban, "img_masterRelation")
    item.img_apprienceState = TFDirector:getChildByPath(item.Image_diban, "img_apprienceState")

    if not itemCell then
        self.friendItem_[Panel_friendItem] = item
    end
    return Panel_friendItem, item
end

function FriendView:updateFriendListByType(type_)
    local listView, data
    if type_ == EC_Friend.FRIEND then
        listView = self.ListView_friend
        self.friend_ = FriendDataMgr:getFriend(EC_Friend.FRIEND)
        if self.selectRuleIndex_ == 1 then
            table.sort(self.friend_, function(a, b)
                local infoA = FriendDataMgr:getFriendInfo(a)
                local infoB = FriendDataMgr:getFriendInfo(b)
                if infoA.lvl == infoB.lvl then
                    return infoA.pid < infoB.pid
                end
                return infoA.lvl > infoB.lvl
            end)
        elseif self.selectRuleIndex_ == 2 then
            table.sort(self.friend_, function(a, b)
                local infoA = FriendDataMgr:getFriendInfo(a)
                local infoB = FriendDataMgr:getFriendInfo(b)
                if infoA.fightPower == infoB.fightPower then
                    return infoA.pid < infoB.pid
                end
                return infoA.fightPower > infoB.fightPower
            end)
        elseif self.selectRuleIndex_ == 3 then
            table.sort(self.friend_, function(a, b)
                local infoA = FriendDataMgr:getFriendInfo(a)
                local infoB = FriendDataMgr:getFriendInfo(b)
                if infoA.lastLoginTime == infoB.lastLoginTime then
                    return infoA.pid < infoB.pid
                end
                return infoA.lastLoginTime > infoB.lastLoginTime
            end)
        elseif self.selectRuleIndex_ == 4 then
            table.sort(self.friend_, function(a, b)
                           local infoA = FriendDataMgr:getFriendInfo(a)
                           local infoB = FriendDataMgr:getFriendInfo(b)
                           if infoA.lastLoginTime == infoB.lastLoginTime then
                               return infoA.pid < infoB.pid
                           end
                           return infoA.lastLoginTime < infoB.lastLoginTime
            end)
        end
        data = self.friend_
        if #data > 0 then
            self.label_empyTetx_friend:hide()
        else
            self.label_empyTetx_friend:show()
        end
    elseif type_ == EC_Friend.APPLY then
        listView = self.ListView_apply
        self.applyFriend_ = FriendDataMgr:getFriend(EC_Friend.APPLY)
        data = self.applyFriend_
        if #data > 0 then
            self.label_empyTetx_apply:hide()
        else
            self.label_empyTetx_apply:show()
        end
    elseif type_ == EC_Friend.ADD then
        listView = self.ListView_add
        self.addFriend_ = FriendDataMgr:getFriend(EC_Friend.ADD)
        data = self.addFriend_
    elseif type_ == EC_Friend.SHIELDING then
        listView = self.ListView_shielding
        self.shieldingFriend_ = FriendDataMgr:getFriend(EC_Friend.SHIELDING)
        data = self.shieldingFriend_
        if #data > 0 then
            self.label_empyTetx_shielding:hide()
        else
            self.label_empyTetx_shielding:show()
        end
    end
    listView:AsyncUpdateItem(data,function()
        local Panel_friendItem = self:addFriendItem()
        return Panel_friendItem
    end,
    function (v,info)
        local friendInfo
        if type_ == EC_Friend.ADD then
            friendInfo = info
        else
            local pid = info
            friendInfo = FriendDataMgr:getFriendInfo(pid)
        end
        local item = self.friendItem_[v]
        item.Button_receive:setVisible(type_ == EC_Friend.FRIEND and not self.delectState)
        item.Button_giving:setVisible(type_ == EC_Friend.FRIEND and not self.delectState)
        item.Button_agree:setVisible(type_ == EC_Friend.APPLY)
        item.Button_reject:setVisible(type_ == EC_Friend.APPLY)
        item.Button_add:setVisible(type_ == EC_Friend.ADD)
        item.Button_shielding:setVisible(type_ == EC_Friend.SHIELDING)
        item.Button_sendBless:setVisible(type_ == EC_Friend.FRIEND)

        self:setFriendInfo(item, friendInfo)
    end)



    -- local items = listView:getItems()
    -- local gap = #data - #items
    -- local offset
    -- if gap > 0 then
    --     for i = 1, math.abs(gap) do
    --         local Panel_friendItem = self:addFriendItem()
    --         listView:pushBackCustomItem(Panel_friendItem)
    --     end
    --     offset = listView.scrollView:getContentOffset()
    -- else
    --     offset = listView.scrollView:getContentOffset()
    --     for i = 1, math.abs(gap) do
    --         listView:removeItem(1)
    --     end
    -- end
    -- items = listView:getItems()
    -- for i, v in ipairs(items) do
    --     local friendInfo
    --     if type_ == EC_Friend.ADD then
    --         friendInfo = data[i]
    --     else
    --         local pid = data[i]
    --         friendInfo = FriendDataMgr:getFriendInfo(pid)
    --     end
    --     local item = self.friendItem_[v]
    --     item.Button_receive:setVisible(type_ == EC_Friend.FRIEND and not self.delectState)
    --     item.Button_giving:setVisible(type_ == EC_Friend.FRIEND and not self.delectState)
    --     item.Button_agree:setVisible(type_ == EC_Friend.APPLY)
    --     item.Button_reject:setVisible(type_ == EC_Friend.APPLY)
    --     item.Button_add:setVisible(type_ == EC_Friend.ADD)
    --     item.Button_shielding:setVisible(type_ == EC_Friend.SHIELDING)
    --     item.Button_sendBless:setVisible(type_ == EC_Friend.FRIEND)

    --     self:setFriendInfo(item, friendInfo)
    -- end
    -- local posy = math.abs(offset.y) - listView:getInnerContainerSize().height + listView.scrollView:getSize().height
    -- listView:scrollTo(posy)
end

function FriendView:updateFriendListByIndex(index)
    local tabData = self.tabData_[index]
    self:updateFriendListByType(tabData.type_)
end

function FriendView:setFriendInfo(item, friendInfo)
    local portraitCid = friendInfo.portraitCid
    if friendInfo.leaderCid then
        local heroCfg = TabDataMgr:getData("Hero", friendInfo.leaderCid)
        item.Image_quality:setTexture(EC_HeroQualitySmallPic[heroCfg.rarity])
        portraitCid = friendInfo.portraitCid > 0 and friendInfo.portraitCid or friendInfo.leaderCid
    end

    local icon = AvatarDataMgr:getAvatarIconPath(portraitCid)
    item.Image_icon:setTexture(icon)
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(friendInfo.portraitFrameCid)
    item.Image_icon_cover_frame:setTexture(avatarFrameIcon)
    local headFrameEffect = item.Image_icon_cover_frame:getChildByName("headFrameEffect")
    if headFrameEffect then
        headFrameEffect:removeFromParent()
    end
    if avatarFrameEffect ~= "" then
        headFrameEffect = SkeletonAnimation:create(avatarFrameEffect)
        headFrameEffect:setAnchorPoint(ccp(0,0))
        headFrameEffect:setPosition(ccp(0,0))
        headFrameEffect:play("animation", true)
        headFrameEffect:setName("headFrameEffect")
        item.Image_icon_cover_frame:addChild(headFrameEffect, 1)
    end
    
    local name,_count = TFGlobalUtils:checkPlayerProvision(friendInfo.name)
    item.Label_level:setTextById(800006, friendInfo.lvl)
    if _count > 0 then
        item.Label_level:setText(name)
    end
    item.Label_name:setText(name)
    item.Label_power:setText(friendInfo.fightPower)
    if _count > 0 then
        item.Label_power:setText(name)
    end
    if friendInfo.online then
        item.Label_recentLogin:setTextById(700037)
    else
        local nowDate = Utils:getUTCDate(ServerDataMgr:getServerTime())
        local lastLoginDate = Utils:getUTCDate(friendInfo.lastLoginTime)
        local diffDate = TFDate.diff(nowDate, lastLoginDate)
        local day = diffDate:spandays()
        local hour = diffDate:spanhours()
        local min = diffDate:spanminutes()
        if day >= 1 then
            item.Label_recentLogin:setTextById(700036, math.floor(day))
        elseif hour >= 1 then
            item.Label_recentLogin:setTextById(700035, math.floor(hour))
    else
            item.Label_recentLogin:setTextById(700010, math.max(1, math.floor(min)))
        end
    end

    item.Image_icon:onClick(function()
        MainPlayer:sendPlayerId(friendInfo.pid)
    end)

    -- Panel_masterItem 师徒
    if item.btn_masterDelete then
        item.btn_masterGiveGift:setVisible(friendInfo.type == EC_FriendMasterType.Apprentice and not friendInfo.finished and friendInfo.hasGift)
        item.btn_masterGetGift:setVisible(friendInfo.type == EC_FriendMasterType.Master and friendInfo.hasGift)

        local src = nil
        if friendInfo.type == EC_FriendMasterType.Master then
            src = EC_MasterTagImgSrc.Master
        elseif friendInfo.type == EC_FriendMasterType.SameGate then
            src = EC_MasterTagImgSrc.SameGate
        elseif friendInfo.type == EC_FriendMasterType.Apprentice then
            src = EC_MasterTagImgSrc.Apprentice
        end
        item.img_masterRelation:setVisible(nil ~= src)
        if src then
            item.img_masterRelation:setTexture(src)
        end


        if friendInfo.type ~= EC_FriendMasterType.Master and friendInfo.finished then
            item.img_apprienceState:setTexture(EC_MasterTagImgSrc.OutMaster)
            item.img_apprienceState:show()
        else
            item.img_apprienceState:hide()
        end

        -- 不让解除同门关系
        item.btn_masterDelete:setVisible(friendInfo.type ~= EC_FriendMasterType.SameGate)
        -- 解除师徒关系
        item.btn_masterDelete:onClick(function()
            local args = {
                tittle = 2107025,
                content = TextDataMgr:getText(1340051),
                confirmCall = function()
                    local type = FriendDataMgr:getMasterTypeById(friendInfo.pid)
                    local tag
                    if type == EC_FriendMaster.Master then
                        tag = 7
                    end
                    if type == EC_FriendMaster.Apprentice then
                        tag = 8
                    end
                    FriendDataMgr:send_APPRENTICE_REQ_HANDLE_APPRENTICE(tag, friendInfo.pid)
                end,
            }
            Utils:showReConfirm(args)
        end)

        item.btn_masterGiveGift:onClick(function()
            Utils:openView("friend.MasterGiveGiftView")
        end)

        item.btn_masterGetGift:onClick(function()
            FriendDataMgr:send_APPRENTICE_REQ_FETCH_GIFT()
        end)
    end

    -- Panel_friendItem  
    if item.Button_receive then

        local _src = nil
        if friendInfo.type == 1 then
            _src = EC_MasterTagImgSrc.Master
        elseif friendInfo.type == 2 then
            _src = EC_MasterTagImgSrc.Apprentice
        end
        item.img_relation:setVisible(friendInfo.type == 1 or friendInfo.type == 2)
        if _src then
            item.img_relation:setTexture(_src)
        end

        item.Button_receive:onClick(function()
            local receiveCount = FriendDataMgr:getReceiveCount()
            local remainReceiveCount = math.max(0, self.maxReceiveCount_ - receiveCount)
            if remainReceiveCount > 0 then
                FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.RECEIVE_GIFT, {friendInfo.pid})
            else
                Utils:showTips(700054)
            end
        end)
        item.Button_giving:onClick(function()
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.GIVE_GIFT, {friendInfo.pid})
        end)
        item.Button_agree:onClick(function()
            if #self.friend_ < self.maxFriendsNum_ then
                FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.AGREE_APPLY, {friendInfo.pid})
            else
                Utils:showTips(210005)
            end
        end)
        item.Button_reject:onClick(function()
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.REFUSE_APPLY, {friendInfo.pid})
        end)
        item.Button_add:onClick(function()
            FriendDataMgr:addFriend(friendInfo.pid)
        end)
        item.Button_shielding:onClick(function()
            local view = Utils:openView("common.ConfirmBoxView")
            view:setCallback(function()
                FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.LIFTED_SHIELD, {friendInfo.pid})
            end)
            local content = TextDataMgr:getText(700039)
            view:setContent(content)
        end)
        item.Button_sendBless:onClick(function()
            Utils:openView("activity.EditBlessView",friendInfo.pid)
        end)
        item.Panel_friendView_gray:setVisible(false)
        item.Image_friendView_select:setVisible(false)
        item.Image_diban:onClick(function()
            if self.deletPlayerCids[item] then
                self.deletPlayerCids[item] = nil
                item.Image_friendView_select:setVisible(false)
                item.Panel_friendView_gray:setVisible(false)
            else
                self.deletPlayerCids[item] = friendInfo.pid
                item.Image_friendView_select:setVisible(true)
                item.Panel_friendView_gray:setVisible(true)
            end
            if table.count(self.deletPlayerCids) > 0 then
                self.Button_delet_sure:setTouchEnabled(true)
                self.Button_delet_sure:setGrayEnabled(false)
            else
                self.Button_delet_sure:setTouchEnabled(false)
                self.Button_delet_sure:setGrayEnabled(true)
            end
        end)
        local isCanGiven = FriendDataMgr:isCanGiven(friendInfo.pid)
        item.Button_giving:setTouchEnabled(isCanGiven)
        item.Button_giving:setGrayEnabled(not isCanGiven)
        if isCanGiven then
            item.Label_givingTxt:setTextById(700014)
        else
            item.Label_givingTxt:setTextById(700032)
        end
        local isCanReceive = FriendDataMgr:isCanReceive(friendInfo.pid)
        item.Button_receive:setVisible(isCanReceive and not self.delectState)
        item.Button_sendBless:setVisible(FriendDataMgr:isWishBtnShow(friendInfo.pid))
        if not item.Button_receive:isVisible() then
            item.Button_sendBless:setPosition(item.Button_receive:Pos())
        end
    end
end

function FriendView:updateItemSelectState()
    local items = self.ListView_friend:getItems()
    for i, v in ipairs(items) do
        local item = self.friendItem_[v]
        if self.delectState then
            item.Image_diban:setTouchEnabled(true)
        else
            item.Image_diban:setTouchEnabled(false)
        end
        if self.deletPlayerCids[item] then
            item.Image_friendView_select:setVisible(true)
            item.Panel_friendView_gray:setVisible(true)
        else
            item.Image_friendView_select:setVisible(false)
            item.Panel_friendView_gray:setVisible(false)
        end
    end
end

function FriendView:registerEvents()
    EventMgr:addEventListener(self, EV_FRIEND_RECOMMENDFRIEND, handler(self.onRecommendFriendEvent, self))
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onQueryFriendEvent, self))
    EventMgr:addEventListener(self, EV_FRIEND_REMOVEADDFRIEND, handler(self.onRemoveAddFriendEvent, self))
    EventMgr:addEventListener(self, EV_FRIEND_OPERATEFRIEND, handler(self.onOperateFriendEvent, self))
    EventMgr:addEventListener(self, EV_FRIEND_UPDATE, handler(self.onFriendUpdateEvent, self))
    EventMgr:addEventListener(self, EV_FRIEND_INVITE_UPDATE, handler(self.onFriendInviteUpdateEvent, self))
    
    EventMgr:addEventListener(self, EV_FRIEND_MASTER_UPDATE, handler(self.onRefreshMasterList, self))
    EventMgr:addEventListener(self, EV_FRIEND_MASTERAPPLYLIST_UPDATE, handler(self.refreshBtnsRed, self))
    EventMgr:addEventListener(self, EV_FREND_MASTERGITGIFT_UPDATE, handler(self.refreshBtnsRed, self))

    self.TextField_find:addMEListener(TFTEXTFIELD_DETACH, function(input)
        self.inputLayer_:listener(input:getText())
    end)
    self.TextField_find:addMEListener(TFTEXTFIELD_ATTACH, function(input)
        self.inputLayer_:show()
        self.inputLayer_:listener(input:getText())
    end)
    self.TextField_find:addMEListener(TFTEXTFIELD_TEXTCHANGE, function(input)
        self.inputLayer_:listener(input:getText())
    end)

    self.TextField_inputCode:addMEListener(TFTEXTFIELD_DETACH, function(input)
        local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.inputLayer_:listener(new_text)
    end)
    self.TextField_inputCode:addMEListener(TFTEXTFIELD_ATTACH, function(input)
        self.inputLayer_:show()
        self.inputLayer_:listener(input:getText())
    end)
    self.TextField_inputCode:addMEListener(TFTEXTFIELD_TEXTCHANGE, function(input)
        local text = input:getText()
        local new_text = string.gsub(text, "[^a-zA-Z0-9]", "")
        input:setText(new_text)
        self.inputLayer_:listener(new_text)
    end)

    self.Button_receive:onClick(function()
        local playerId = {}
        for i, v in ipairs(self.friend_) do
            local isCanReceive = FriendDataMgr:isCanReceive(v)
            if isCanReceive then
                table.insert(playerId, v)
            end
        end
        if #playerId > 0 then
            local receiveCount = FriendDataMgr:getReceiveCount()
            local remainReceiveCount = math.max(0, self.maxReceiveCount_ - receiveCount)
            if remainReceiveCount > 0 then
                FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.RECEIVE_GIFT, playerId)
                Utils:showTips(700043)
            else
                Utils:showTips(700054)
            end

        else
            Utils:showTips(700045)
        end
    end)

    self.Button_giving:onClick(function()
        local playerId = {}
        for i, v in ipairs(self.friend_) do
            local isCanGiven = FriendDataMgr:isCanGiven(v)
            if isCanGiven then
                table.insert(playerId, v)
            end
        end
        if #playerId > 0 then
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.GIVE_GIFT, playerId)
            Utils:showTips(700044)
        else
            Utils:showTips(700046)
        end
    end)


    self.Button_delet_all:onClick(function()
        if #self.friend_ > 0 then
            self.delectState = true
        else
            self.delectState = false
        end
        self:updateFriendBtnState()
    end)
    self.Button_delet_sure:onClick(function()
        local view = Utils:openView("common.ConfirmBoxView")
        view:setCallback(function()
            local pids = {}
            for k, v in pairs(self.deletPlayerCids) do
                pids[#pids + 1] = v
            end
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.DELETE_FRIEND, pids)
            AlertManager:closeLayer(view)
            self.delectState = false
            self:updateFriendBtnState()
        end)
        local content = TextDataMgr:getText(700040)
        view:setContent(content)
    end)
    self.Button_delet_cancel:onClick(function()
        self.delectState = false
        self:updateFriendBtnState()
    end)

    self.Button_agree:onClick(function()
        local playerId = {}
        for i, v in ipairs(self.applyFriend_) do
            local friendInfo = FriendDataMgr:getFriendInfo(v)
            if friendInfo then
                table.insert(playerId, friendInfo.pid)
            end
        end
        if #playerId > 0 then
            local remainCount = self.maxFriendsNum_ - #self.friend_
            if remainCount > 0 then
                Utils:showTips(700048)
            else
                Utils:showTips(210005)
            end
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.AGREE_APPLY, playerId)
        else
            Utils:showTips(700050)
        end
    end)

    self.Button_reject:onClick(function()
        local playerId = {}
        for i, v in ipairs(self.applyFriend_) do
            local friendInfo = FriendDataMgr:getFriendInfo(v)
            table.insert(playerId, friendInfo.pid)
        end
        if #playerId > 0 then
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.REFUSE_APPLY, playerId)
            Utils:showTips(700049)
        else
            Utils:showTips(700050)
        end
    end)

    self.Button_refresh:onClick(function()
        FriendDataMgr:send_FRIEND_REQ_RECOMMEND_FRIENDS()
        Utils:showTips(700052)
        local cdTime = Utils:getKVP(7001).refreshCd / 1000
        self.Button_refresh:setTouchEnabled(false)
        self.Button_refresh:setGrayEnabled(true)
        self.Label_refresh_timing:show()
        self.Image_refresh:hide()
        self.Label_refresh_timing:setTextById(800040, cdTime)
        self.refreshTimerId_ = TFDirector:addTimer(
                1000,
                cdTime,
                function()
                    self.Button_refresh:setTouchEnabled(true)
                    self.Button_refresh:setGrayEnabled(false)
                    self.Label_refresh_timing:hide()
                    self.Image_refresh:show()
                    self.refreshTimerId_ = nil
                end,
                function()
                    cdTime = cdTime - 1
                    self.Label_refresh_timing:setTextById(800040, cdTime)
                end
        )
    end)

    self.Button_add:onClick(function()
        local playerId = {}
        for i, v in ipairs(self.addFriend_) do
            table.insert(playerId, v.pid)
        end
        for i, v in ipairs(playerId) do
            FriendDataMgr:removeRecommendFriend(v)
        end
        if #playerId > 0 then
            FriendDataMgr:send_FRIEND_REQ_OPERATE(EC_FriendOp.APPLY_FRIEND, playerId)
        else
            Utils:showTips(700051)
        end
    end)

    self.Button_find:onClick(function()
        local pidStr = self.TextField_find:getText()
        local pid = tonumber(pidStr)
        if pid then
            MainPlayer:sendPlayerId(pid)
        else
            Utils:showTips(700025)
        end
    end)

    self.Button_sortRule:onClick(function()
        self:setSortRuleVisible()
    end)

    for i, v in ipairs(self.Button_rule) do
        v:onClick(function()
            self:selectSortRule(i)
        end)
    end

    for i, btn in ipairs(self.Panel_masterBtns:getChildren()) do
        local index = string.gsub(btn:getName(), "btn_", "")
        index = tonumber(index)
        btn:onClick(function()
            self:selectMaterByIndex(index)
        end)

        -- 不能收徒前不需要展示徒弟页签
        if index == EC_FriendMaster.Apprentice then
            local limitLv  = Utils:getKVP(90023, "apprenticeClass")
            local playerLv = MainPlayer:getPlayerLv()
            if  playerLv <= limitLv[2] then
                btn:hide()
            end
        end
    end

    self.btn_masterSpec:onClick(function()
        Utils:openView("friend.MasterPrivilegeView")
    end)  

    self.btn_task:onClick(function()
        local state1, state2 = FriendDataMgr:isHaveMasterApprentice()
        if (state1 or state2) and not FriendDataMgr:isApprenticeFinished() then
            Utils:openView("friend.MasterTaskView", EC_FriendMasterApply.ApplyList)
        else
            local limitLv  = Utils:getKVP(90023, "apprenticeLevel")
            local playerLv = MainPlayer:getPlayerLv()
            if FriendDataMgr:isApprenticeFinished() then
                Utils:showTips(1340054)
                return
            end
            if limitLv[1] <= playerLv and playerLv <= limitLv[2] then
                Utils:showTips(1340004)
            else
                Utils:showTips(1340005) 
            end 
        end
    end)        

    local isHadMaster, isHadApprentice = FriendDataMgr:isHaveMasterApprentice()
    self.btn_apply:onClick(function()
        Utils:openView("friend.MasterList", EC_FriendMasterApply.ApplyList)
    end)    
    
    self.btn_askMaster:onClick(function()
        if FriendDataMgr:isCanApplyMater() then
            Utils:openView("friend.MasterList", EC_FriendMasterApply.ApplyMaster)
        else
            local isOutMaster = FriendDataMgr:isApprenticeFinished()
            if FriendDataMgr:getIsInCD() then
                Utils:showTips(1340007)
            elseif isHadMaster and not isOutMaster then
                Utils:showTips(1340006)
            elseif isOutMaster then
                Utils:showTips(1340003)
            end
        end
        self:refreshMasterBtns()
    end)          

    self.btn_getApprentice:onClick(function()
        if FriendDataMgr:isCanGetApprentice() then
            Utils:openView("friend.MasterList", EC_FriendMasterApply.GetApprentice)
        else
            if FriendDataMgr:getIsInCD() then
                Utils:showTips(1340009)
            elseif isHadApprentice then
                Utils:showTips(1340008)
            end
        end
        self:refreshMasterBtns()
    end) 

    self.masterTableview:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.masterCellSize,self))
    self.masterTableview:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.masterNumberOfCells,self))
    self.masterTableview:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.masterCellAtIndex,self))
    self.masterTableview:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))
end

function FriendView:masterCellSize()
    local size = self.Panel_masterItem:getSize()
    return size.height + 5, size.width
end

function FriendView:masterNumberOfCells()
    return table.count(FriendDataMgr:getMasterDataByType(self.curIndex))
end

function FriendView:masterCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self.Panel_masterItem:clone()

        if item == nil then
            return
        end
        item:setPosition(ccp(0,0))
        cell:addChild(item)
        cell.item = item
    else
        item = cell.item
    end

    self:refreshCellItem(item,index)
    return cell
end

function FriendView:refreshCellItem(itemCell, index)
    if not itemCell.item then
        local _, _item = self:addFriendItem(itemCell)
        itemCell.item  = _item
    end
    local info = FriendDataMgr:getMasterDataByType(self.curIndex)[index]
    -- 匹配以前的变量（相同数据 服务器给的名字不一样）
    info["portraitCid"] = info.portraitCId
    info["portraitFrameCid"] = info.portraitFrameCId
    info["lvl"] = info.level
    info["pid"] = info.playerId
    self:setFriendInfo(itemCell.item, info)
end

function FriendView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = -contentOffset.y/length
    percent = percent <= 1 and percent or 1
    self.scrollBar:setPercent(percent)
end

function FriendView:setSortRuleVisible(visible)
    if visible or self.Panel_sortRule:isVisible() then
        self.Panel_sortRule:hide()
    else
        self.Panel_sortRule:show()
    end
    local ruleText = self.ruleText_[self.selectRuleIndex_]
    self.Label_sortRule:setTextById(ruleText)
end

function FriendView:selectSortRule(index)
    self.selectRuleIndex_ = index or self.defaultSelectRuleIndex_
    self:setSortRuleVisible(true)
    
    self:updateFriendListByType(EC_Friend.FRIEND)

    local count = GoodsDataMgr:getItemCount(EC_SItemType.FRIENDSHIP)
    self.Label_friendDotCount:setText(count)
    local receiveCount = FriendDataMgr:getReceiveCount()
    local remainReceiveCount = math.max(0, self.maxReceiveCount_ - receiveCount)
    self.Label_givingCount:setTextById(800005, remainReceiveCount, self.maxReceiveCount_)

    self.Label_count:setTextById(800005, #self.friend_, self.maxFriendsNum_)
end

function FriendView:selectMaterByIndex(idx)
    for i, btn in ipairs(self.Panel_masterBtns:getChildren()) do
        if i == idx then
            btn:setTextureNormal("ui/friend/master/btn_2.png")
        else
            btn:setTextureNormal("ui/friend/master/btn_1.png")
        end
    end 

    self.curIndex = idx
    local _data = FriendDataMgr:getMasterDataByType(self.curIndex)
    if _data and table.count(_data) > 0 then
        self.masterTableview:reloadData()
        local innerSize   = self.masterTableview:getContentSize()
        local size          = self.masterTableview:getSize()
        local ratio =   size.height / innerSize.height
        ratio = ratio <= 1 and ratio or 1
        self.scrollBar:setRatio(ratio)
        self.scrollBar:setPercent(1)
        self.masterTableview:show()
    else
        self.masterTableview:hide()
    end
    self.lab_masterIsData:setVisible(not self.masterTableview:isVisible())
    local _txtId
    if self.curIndex == EC_FriendMaster.Master then
        _txtId = 1340018
    else
        _txtId = 1340019
    end
    TFDirector:getChildByPath("lab_masterTxt")
    self.lab_masterTxt:setTextById(_txtId)
end

function FriendView:onRecommendFriendEvent()
    self:showAdd()
end

function FriendView:onQueryFriendEvent(friendInfo)
    local view = requireNew("lua.logic.chat.PlayerInfoView"):new(friendInfo)
    AlertManager:addLayer(view,AlertManager.BLOCK_AND_GRAY_CLOSE)
    AlertManager:show()
end

function FriendView:onRemoveAddFriendEvent(index)
    if not index then return end
    self.addFriend_ = FriendDataMgr:getFriend(EC_Friend.ADD)
    self.ListView_add:removeItem(index)
    -- if #self.addFriend_ == 0 then
    --     FriendDataMgr:send_FRIEND_REQ_RECOMMEND_FRIENDS()
    -- end
end

function FriendView:onOperateFriendEvent(op, target)

end

function FriendView:onFriendUpdateEvent()
    self:updateSelectTab()
end

function FriendView:onFriendInviteUpdateEvent(inviteData)
    -- inviteData = {bShowCode=true, selfCode="WGSDAB", bindNum=1, maxBindNum=3, rewardList0={{cid=2,status=0}}, rewardList1={{cid=1,status=1}}, rewardList2={{cid=3,status=2}}}
    local isOpen = inviteData.bOpen
    if not isOpen then
        self.Panel_invite:hide()
        if self.tabData_[self.selectIndex_].type_ == EC_Friend.INVITE then
            Utils:showTips(2100109)
        end
        return
    end
    self:insertTabBtn({
        text = 263106,
        title = 700006,
        heading = 700023,
        icon = "ui/friend/invite/001.png",
        bIcon = "icon/system/044.png",
        type_ = EC_Friend.INVITE,
    })

    --红点
    for i, v in ipairs(self.ListView_tab:getItems()) do
        local tabData = self.tabData_[i]
        if tabData.type_ == EC_Friend.INVITE then
            local item = self.tabBtn_[v]
            local isCanReceive = #inviteData.rewardList1 > 0
            item.Image_tips:setVisible(isCanReceive)
            break
        end
    end

    if self.tabData_[self.selectIndex_].type_ ~= EC_Friend.INVITE then
        return
    end
    self.Panel_invite:show()
    local isShowCode = inviteData.bShowCode
    if isShowCode then
        self.Panel_inviteOpen:show()
        self.Panel_inviteClose:hide()
        self.Label_selfCode:setString(inviteData.selfCode)
        self.Label_inviteNum:setString(string.format("%d / %d", inviteData.bindNum, inviteData.maxBindNum))
    else
        self.Panel_inviteOpen:hide()
        self.Panel_inviteClose:show()
        local Label_closeTips = self.Panel_inviteClose:getChild("Label_closeTips")
        Label_closeTips:setTextById(263198, inviteData.limitLev)
        if inviteData.bindCode then
            self.Image_codeInputBg:hide()
            self.Button_invite:hide()
            self.Image_bindBg:show()
            self.Label_bindCode:setText(inviteData.bindCode)
        end
    end

    self.ListView_invite:removeAllItems()
    local allReward = {}
    for i1, v1 in ipairs(inviteData.rewardList1) do
        table.insert(allReward, v1)
    end
    for i2, v2 in ipairs(inviteData.rewardList0) do
        table.insert(allReward, v2)
    end
    for i3, v3 in ipairs(inviteData.rewardList2) do
        table.insert(allReward, v3)
    end
    for i, v in ipairs(allReward) do
        local rewardconf = TabDataMgr:getData("FriendRequest", v.cid)
        local rewardItem = self.Panel_inviteReward:clone():show()
        local Button_recieve = rewardItem:getChild("Button_recieve")
        local Button_recived = rewardItem:getChild("Button_recieved")
        local Label_name = rewardItem:getChild("Label_name")
        self.ListView_invite:pushBackCustomItem(rewardItem)

        Label_name:setText(rewardconf.des2)
        --领取状态（0-不可领取 1-可领取 2-已领取）
        if v.status == 0 then
            Button_recived:hide()
            Button_recieve:setTouchEnabled(false)
            Button_recieve:setGrayEnabled(true)
        elseif v.status == 1 then
            Button_recived:hide()
            Button_recieve:setTouchEnabled(true)
            Button_recieve:setGrayEnabled(false)
            Button_recieve:onClick(function()
                FriendDataMgr:send_FRIEND_REQ_REWARD_INVITE(v.cid)
            end)
        else
            Button_recived:setTouchEnabled(false)
            Button_recived:show()
            Button_recieve:hide()
        end
        for i = 1, 4 do
            local Image_reward = rewardItem:getChild("Image_reward_"..i)
            local reward = rewardconf.reward[i]
            if reward then
                Image_reward:show()
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                PrefabDataMgr:setInfo(Panel_goodsItem, reward[1], reward[2])
                Panel_goodsItem:AddTo(Image_reward):Pos(0, 0)
                Panel_goodsItem:setScale(0.8)
            else
                Image_reward:hide()
            end
        end
    end
end

function FriendView:onRefreshMasterList(type)
    if self.curIndex == type then
        self:selectMaterByIndex(self.curIndex)
    end
    self:refreshMasterBtns()
    self:refreshBtnsRed()
end

function FriendView:refreshBtnsRed()
    self.btn_masterSpecRed:setVisible(FriendDataMgr:isHaveMasterAwardsCanGet())
    self.btn_taskRed:setVisible(FriendDataMgr:isHaveMasterTaskAwardCanGet())  
    self.btn_applyRed:setVisible(FriendDataMgr:isApplyBtnRedShow()) 
    self:updateRedPointStatus()
end

function FriendView:removeEvents()
    if self.refreshTimerId_ then
        TFDirector:removeTimer(self.refreshTimerId_)
    end
end

return FriendView
