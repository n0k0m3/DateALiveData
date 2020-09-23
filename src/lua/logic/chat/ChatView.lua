local ScrollBar = import(".ScrollBar")
local ResLoader      = require("lua.logic.battle.ResLoader")
local ChatView = class("ChatView", BaseLayer)

local isSelfInfoSpe = true         --自己信息需要特殊处理设置为true

local COLOR_SELECLT = me.c3b(255,255,255)
local COLOR_NORMAL  = me.c3b(0,0,0)

-- 表情类型
local EmotionType = {
    Small = 1,
    Big   = 2
}

function ChatView:initData(params)
    -- -- 1.公共,2.私聊;3.帮派
    -- EC_ChatType = {
    --     WORLD   = 1,    -- 公共
    --     PRIVATE = 2,    -- 私聊
    --     GUILD   = 3,    -- 帮派
    --     SYSTEM  = 4,    -- 系统消息
    -- }
    self.btnConfig_ = {
        [1] = {
            txt = 600001,
            chat = EC_ChatType.PRIVATE,
            itemName = "Panel_item"
        },
        [2] = {
            txt = 600003,
            chat = EC_ChatType.SYSTEM,
            itemName = "Panel_system_item"
        },
        [3] = {
            txt = 600038,
            chat = EC_ChatType.TEAM_YQ,
            itemName = "Panel_item"
        },
        --[4] = {
        --    txt = 13311241,
        --    chat = EC_ChatType.COURAGE,
        --    itemName = "Panel_item"
        --},
        [4] = {
            txt = 600004,
            chat = EC_ChatType.WORLD,
            itemName = "Panel_item"
        },
    }

    if params.showBigWorld then 
        --显示大世界
        self.btnConfig_[#self.btnConfig_+1] =  
        {
            txt = 600039,
            chat = EC_ChatType.BIG_WORLD,
            itemName = "Panel_item"
        }
    end

    self.isUnLockSendInfo = true
    self.selectIndex_ = nil
    self.isTouchMove = false
    self.listViewHeight = 0
    self.pId = nil
    self.isTouch = true
    self.pListData = {}
    self.isRefreshChat = false
    self.disHeight = 0
    -- ChatDataMgr:sendBlockList()
    self.inputTextField = nil
    self.isTouchClose = true
    self.nTeamId = nil
    self.nTeamBattleId = nil
    self.isTeam = params.isTeam
    self.isNewMsg = false
    self.isTeamShow = (TeamFightDataMgr:getTeamId() ~= "")
    if self.isTeamShow and self.isTeam then
        self.btnConfig_[#self.btnConfig_ + 1] = {
            txt = 600011,
            chat = EC_ChatType.TEAM,
            itemName = "Panel_item"
        }
    end
    if LeagueDataMgr:checkSelfInUnion() then
        table.insert(self.btnConfig_, 2, {
           txt = 600002,
           chat = EC_ChatType.GUILD,
           itemName = "Panel_item"
        })
    end
    self.mainPageIdx = 0
    self.mainPageOptionList = {}
    self.indexOfScrollT = {
        [0] = 1,
        [1] = 2,
        [2] = 3,
        [3] = 4
    }
    self.douTuIdx_ = -1
    self.douTuData1 = {1,2,3,4}
    self.douTuData2 = {1,2,3,4,5,6,7,8,9,10}
    self.douTuItems = {}

    self.defaultSelectIndex_ = params.defaultIndex or table.count(self.btnConfig_)

    self.currSelectEmotion = nil

    --难度选择
    self.difficultySelects = SettingDataMgr:getDifficultyChoice()
	self.BlackAndWhiteDifficultySelects = SettingDataMgr:getBlackAndWhiteDifficultyChoice()
end

function ChatView:ctor(params)
    self.super.ctor(self)

    self:initData(params)
    self:init("lua.uiconfig.chat.chatView")
    self.name = "ChatView"
end

function ChatView:initUI(ui)
    self.super.initUI(self,ui)
    self.panel_close = ui
    self.panel_close:setTouchEnabled(true)
    self.panel_chat  = TFDirector:getChildByPath(ui,"Panel_chat")
    self.panel_chat:setTouchEnabled(true)
    self.panel_chat:hide()
    self.panel_chat:setPositionX(-self.panel_chat:getSize().width)
    self.scrollBar = ScrollBar:new(ScrollBar.Direction.Vertical)
    self.scrollBar:setContentSize(me.size(5,500))
    self.scrollBar:setPosition(me.p(565,360))
    self.panel_chat:addChild(self.scrollBar,100)

    --添加空状态显示
    self.label_empyTetx = TFLabel:create()
    self.label_empyTetx:setFontName("font/MFLiHei_Noncommercial.ttf")
    self.label_empyTetx:setFontSize(22)
    self.label_empyTetx:setTextAreaSize(CCSize(400 , 0))
    self.label_empyTetx:setAnchorPoint(ccp(0.5 , 1))
    self.label_empyTetx:setPosition(312 , 326)
    self.label_empyTetx:setTextById(190000172)
    --self.label_empyTetx:enableOutline(ccc4(0,0,0,255), 1)
    self.panel_chat:addChild(self.label_empyTetx , 1)

    self.Panel_base = TFDirector:getChildByPath(ui, "Panel_base")

    -- 表情ui块
    self.panel_send = TFDirector:getChildByPath(self.panel_chat, "panel_send")
    self.panel_send.oldPos = ccp(self.panel_send:getPosition())
    self.panel_send:setZOrder(999)
    self.Button_filter = TFDirector:getChildByPath(self.panel_send, "Button_filter"):hide()
    local Label_filter = TFDirector:getChildByPath(self.Button_filter, "Label_filter")
    Label_filter:setTextById(2100170)
    self.btn_SEmotion = TFDirector:getChildByPath(self.panel_send, "btn_SEmotion")
    self.btn_BEmotion = TFDirector:getChildByPath(self.panel_send, "btn_BEmotion")
    self.img_selectEmotion = TFDirector:getChildByPath(self.panel_send, "img_selectEmotion")
    self.panel_emotion = TFDirector:getChildByPath(self.panel_send,"panel_emotion")
    self.image_scrollBarModel = TFDirector:getChildByPath(self.panel_emotion, "image_scrollBarModel")
    self.image_scrollBarInner = TFDirector:getChildByPath(self.image_scrollBarModel, "image_scrollBarInner")
    self.emotionList = UIListView:create(TFDirector:getChildByPath(self.panel_send,"emotionList"))
    self.panel_emotionCell = TFDirector:getChildByPath(ui,"panel_emotionCell")
    self.panel_SemotionCell = TFDirector:getChildByPath(ui, "panel_SemotionCell")
    local scrollEmotionBar = UIScrollBar:create(self.image_scrollBarModel, self.image_scrollBarInner)
    self.emotionList:setScrollBar(scrollEmotionBar)

    self.scrollView_content = TFDirector:getChildByPath(ui,"ScrollView_content")
    self.TextButton_input = TFDirector:getChildByPath(ui, "TextButton_input")
    self.tf_input  = TFDirector:getChildByPath(ui,"TextField_input")
    self.tf_input.type = "tf_input"
    self.tf_input:hide()
    self.btn_send  = TFDirector:getChildByPath(ui,"Button_send")
    --self.btn_send:hide()
    self.Button_share = TFDirector:getChildByPath(ui,"Button_share")

    self.tableView = Utils:scrollView2TableView(self.scrollView_content )
    self.tableView:setZOrder(100)
    self.tableView:setBounceable(true)
    --TODO 然而并没有卵用
    self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLBOTTOMUP)
    -- self.tableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
    self.tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.cellSize,self))
    self.tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    self.tableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))
    self.tableView:addMEListener(TFWIDGET_TOUCHBEGAN, handler(self.tableCellTouchBegan,self))
    self.tableView:addMEListener(TFWIDGET_TOUCHENDED, handler(self.tableCellTouched,self))
    self.tableView.oldPos = self.tableView:getPositionY()

    self.Button_teamRoom = TFDirector:getChildByPath(self.ui,"Button_teamRoom")

    self:refreshPrefabe()

    self.Image_room = TFDirector:getChildByPath(self.ui,"Image_room")
    self.Image_room:hide()
    self.Label_roomId = TFDirector:getChildByPath(self.Image_room,"Label_roomId")
    self.TextField_roomId = TFDirector:getChildByPath(self.Image_room,"TextField_roomId")
    self.TextField_roomId.type = "TextField_roomId"
    self.Panel_roomTouch = TFDirector:getChildByPath(self.Image_room, "Panel_roomTouch")
    self.Button_refresh = TFDirector:getChildByPath(self.Image_room,"Button_refresh")

    self.Panel_union = TFDirector:getChildByPath(self.ui,"Panel_union")
    self.Button_red_pack = TFDirector:getChildByPath(self.Panel_union,"Button_red_pack")
    self.Label_online_num = TFDirector:getChildByPath(self.Panel_union,"Label_online_num")



    self:initPanelPrivate()
    self:initScrollTab()

    local params = {
        _type = EC_InputLayerType.SEND,
        buttonCallback = function()
            self:onTouchSendBtn()
        end,
        closeCallback = function()
            self:onCloseInputLayer()
        end
    }
    self.inputLayer = require("lua.logic.common.InputLayer"):new(params);
    self:addLayer(self.inputLayer,1000);

    self.panel_chat:show()
    self.panel_chat:moveTo(0.2,0,0)





    self:initDouTu()

    self:refreshEmotionSelect(EmotionType.Small)
end

function ChatView:initDouTu()
    self.Button_douTu = TFDirector:getChildByPath(self.ui, "Button_douTu")
    self.Button_douTu.isShow = false
    self.Image_douTuBottom = TFDirector:getChildByPath(self.ui, "Image_douTuBottom")
    self.Image_douTuBottom:setZOrder(1000)
    self.Button_1 = TFDirector:getChildByPath(self.Image_douTuBottom, "Button_1")
    self.Button_2 = TFDirector:getChildByPath(self.Image_douTuBottom, "Button_2")
    local Panel_effect = TFDirector:getChildByPath(self.Image_douTuBottom , "Panel_effect")

    self.pageView = TFDirector:getChildByPath(Panel_effect, "PageView_datingLetter")
    self:initOptionList()

    self:hideDouTu()
end

function ChatView:refreshEmotionSelect(index)
    index = index or 1
    if self.currSelectEmotion and self.currSelectEmotion == index then
        return
    end

    self.emotionList:removeAllItems()

    local data = ChatDataMgr:getEmotionDataByIndex(index)
    local profebCell  = index == EmotionType.Small and self.panel_SemotionCell or self.panel_emotionCell
    local count = #TFDirector:getChildByPath(profebCell, "items"):getChildren()
    local row = math.ceil(#data / count)

    for i = 1, row do
        local cell = profebCell:clone()
        cell:setVisible(true)
        self.emotionList:pushBackCustomItem(cell)

        local items = TFDirector:getChildByPath(cell, "items"):getChildren()
        for j = 1 , #items do
            local itemIndex = (i-1) * #items + j
            if data[itemIndex] then
                items[j]:setVisible(true)
                items[j]:Touchable(true)
                
                items[j]:setTexture(data[itemIndex].respath)

                local itemTxt = items[j]:getChildByName("txt")
                if itemTxt and data[itemIndex].emotionname ~="" then
                    itemTxt:setText(data[itemIndex].emotionname)
                end
                
                items[j]:onClick(function()

                    -- 转义字体超出 表情点击无效
                    if Utils:getCharLength(self.tf_input:getText()) + Utils:getCharLength(data[itemIndex].converstr) >= 50 then
                        return
                    end

                    if not ChatDataMgr:getSendInfoUnLockState() then
                        Utils:showTips(600020)
                        return
                    end

                    if not self.comeFromEmotion then
                        self.comeFromEmotion = true
                    end

                    self.tf_input:setText(self.tf_input:getText()..data[itemIndex].converstr)

                    -- 精灵表情 直接发送
                    if self.currSelectEmotion == EmotionType.Big then 
                        self:onTouchSendBtn()
                        return
                    end
                    self.TextButton_input:hide()
                    self.tf_input:setVisible(true)
                end)
            else
                items[j]:setVisible(false)
            end
        end
    end

    self.currSelectEmotion = index
end

function ChatView:refreshDouTuPageContent()
    local data = {}
    if self.douTuIdx_ == 1 then
        data = self.douTuData1
    else
        data = self.douTuData2
    end

    local ndx = 0
    for i, v in ipairs(self.mainPageOptionList) do
        local Panel_page = TFDirector:getChildByPath(self.Image_douTuBottom, "Panel_" ..i)
        for idx = 1, 8 do
            ndx = ndx + 1
            local Image_bottom = TFDirector:getChildByPath(Panel_page, "Image_bottom" .. idx)
            local Image_icon = Image_bottom:getChildByName("Image_icon")
            if ndx <= #data then
                Image_icon:setTexture("icon/item/gift/530122.png")
            else
                Image_icon:setTexture("")
            end

            Image_icon:Touchable(true)
            Image_icon:onClick(function()
                ChatDataMgr:sendChatInfo(self.chatType,"icon/item/gift/530122.png",self.pId,EC_ChatState.TEAM)
                self:hideDouTu()
            end)
        end
    end
end

function ChatView:initOptionList()
    self.Panel_optionList = TFDirector:getChildByPath(self.ui, "Panel_optionList")

    local idx = 0
    while(true)do
        idx = idx + 1
        local Image_option = TFDirector:getChildByPath(self.Panel_optionList, "Image_option"..idx)
        if not Image_option then
            break
        end

        Image_option.select = TFDirector:getChildByPath(Image_option, "Image_select")
        table.insert(self.mainPageOptionList, Image_option)
    end
end

function ChatView:selectMainPage(pageIdx)
    if self.mainPageIdx ~= pageIdx then
        self.mainPageIdx = pageIdx
        --self:refreshMainView()

        for i, v in ipairs(self.mainPageOptionList) do
            if pageIdx == i then
                v.select:show()
            else
                v.select:hide()
            end
        end

        self.pageView:scrollToPage(pageIdx-1,0);
    end
end

function ChatView:pageViewChanged()
    local index = self.pageView:getCurPageIndex()
    local curIdx = self.indexOfScrollT[index]
    self.mainPageIdx = curIdx
    for i, v in ipairs(self.mainPageOptionList) do
        if curIdx == i then
            v.select:show()
        else
            v.select:hide()
        end
    end
end

function ChatView:showDouTu(idx)
    if self.douTuIdx_ ~= idx then
        self.douTuIdx_ = idx
    else
        return
    end

    local Image_select1 = TFDirector:getChildByPath(self.Button_1, "Image_select")
    local Image_select2 = TFDirector:getChildByPath(self.Button_2, "Image_select")

    if idx == 1 then
        Image_select1:show()
        Image_select2:hide()
    elseif idx == 2 then
        Image_select2:show()
        Image_select1:hide()
    end

    self.Image_douTuBottom:show()

    self:refreshDouTuPageContent()
    self:selectMainPage(1)

    self.Button_douTu.isShow = true
end

function ChatView:hideDouTu()
    self.Image_douTuBottom:hide()
    self.Button_douTu.isShow = false
    self.douTuIdx_ = -1
end

function ChatView:refreshPrefabe()

    local index = self.selectIndex_ or self.defaultSelectIndex_

    print("index ",index)

    self.prefabe  = TFDirector:getChildByPath(self.ui,self.btnConfig_[index].itemName)
    self.prefabe.Panel_otherItem = TFDirector:getChildByPath(self.prefabe, "Panel_otherItem")
    self.prefabe.Panel_selfItem = TFDirector:getChildByPath(self.prefabe, "Panel_selfItem")
    self.prefabe.panelNameSize = TFDirector:getChildByPath(self.prefabe, "Image_name"):getSize()
    self.prefabe.playerHead    = TFDirector:getChildByPath(self.prefabe, "Image_playerHead")
    self.prefabe.Panel_aiItem = TFDirector:getChildByPath(self.prefabe, "Panel_aiItem")

    --self:clippingIcon(self.prefabe.Panel_otherItem)
    --self:clippingIcon(self.prefabe.Panel_selfItem)

    self.prefabe.maxWidth      = self.prefabe:getSize().width - 100
    self.prefabe.panel_content = TFDirector:getChildByPath(self.prefabe, "Panel_content")
    self.prefabe.lab_content   = TFDirector:getChildByPath(self.prefabe, "Label_content")
    self.prefabe.bottomSpace   = 5
    self.prefabe.space         = 5
    self.prefabe.textMaxWidth = self.prefabe:getSize().width - 140
end

function ChatView:clippingIcon(item)
    if not item then
        return
    end
    local playerHead = TFDirector:getChildByPath(item, "Image_playerHead")
    if not playerHead then
        return
    end

    local Image_icon = playerHead:getChildByName("Image_icon")
    local clippingNode = CCClippingNode:create()
    local stencil = Sprite:create("ui/chat/stencil.png")
    clippingNode:setStencil(stencil)
    clippingNode:setAlphaThreshold(0.05)
    Image_icon:retain()
    Image_icon:removeFromParent()
    clippingNode:addChild(Image_icon)
    Image_icon:release()
    playerHead:addChild(clippingNode, 1)
end

function ChatView:initPanelPrivate()
    self.Panel_private = TFDirector:getChildByPath(self.ui, "Panel_private")
    self.Panel_private:setZOrder(200)
    self.Panel_private:hide()
    self.Panel_list    = TFDirector:getChildByPath(self.ui, "Panel_list")
    self.Panel_listView = TFDirector:getChildByPath(self.Panel_list, "Panel_listView")
    -- self.Panel_listView:hide()
    self.Panel_listView:Pos(self.Panel_listView:Pos().x,self.Panel_listView:Pos().y + 400)
    self.Panel_listView.normalPos = self.Panel_listView:Pos()
    self.Panel_top_option = TFDirector:getChildByPath(self.Panel_list, "Panel_top_option")
    self.Panel_top_option:Pos(self.Panel_top_option:Pos().x,self.Panel_top_option:Pos().y + 180)
    self.Panel_top_option.normalPos = self.Panel_top_option:Pos()
    self.Image_top2 = TFDirector:getChildByPath(self.Panel_list, "Image_top2")
    self.Image_top2:Pos(self.Image_top2:Pos().x,self.Image_top2:Pos().y + 100)
    self.Image_top2.normalPos = self.Image_top2:Pos()
    self.Image_top2.downArrow = self.Image_top2:getChildByName("Button_down_arrow")
    self.Image_top2.downArrow:onClick(function()
        if self.isTouch == false then
            return
        end
        self:refreshPanelPrivate(nil,true)
    end)
    self.Image_top2.upArrow = self.Image_top2:getChildByName("Button_up_arrow"):hide()
    self.Image_top2.upArrow:onClick(function()
        if self.isTouch == false then
            return
        end
        self:refreshPanelPrivate()
    end)
    self.Image_top2.openList = self.Image_top2:getChildByName("Label_open_list")

    self.Button_private_item = TFDirector:getChildByPath(self.ui,"Button_private_item")

    self:initPrivateListView()
end

function ChatView:initPrivateListView()
    self.ScrollView_list = TFDirector:getChildByPath(self.Panel_listView, "ScrollView_list")
    self.privateListView = UIListView:create(self.ScrollView_list)
end

function ChatView:refreshPrivateListItems()
    self.pListData = ChatDataMgr:getPrivateList()

    self.privateListView:removeAllItems()

    for i,v in ipairs(self.pListData) do
        local item = self.Button_private_item:clone()
        item.pName = TFDirector:getChildByPath(item,"Label_pName")
        item.pId = TFDirector:getChildByPath(item, "Label_pId")

        item.playerId = v.playerId
        item.palyerName = v.palyerName

        item.pName:setText(item.palyerName)
        item.pId:setText("ID:" .. tostring(item.playerId))

        item:onClick(function()
            if self.isTouch == false then
                return
            end
            self:switchPListItem(item)
        end)
        self.privateListView:pushBackCustomItem(item)
    end
end

function ChatView:switchPListItem(sender)
    if sender then
        ChatDataMgr:getPlistDatas(sender.playerId)
        ChatDataMgr:setCurPrPlayerId(sender.playerId)
    end
    self:refreshPanelPrivate(sender)
    self:reloadData()
end

function ChatView:refreshPanelPrivate(sender,isShowList,isSelect)
    self.Panel_private:show()

    -- self.Panel_listView:setVisible(isShowList)
    -- self.Panel_top_option:setVisible(not isShowList)

    self.isTouch = false
    local disTime = 0
    local time = 0.3
    if isShowList == true then
        disTime = time
        self.Panel_top_option:moveTo(time,self.Panel_top_option.normalPos.x,self.Panel_top_option.normalPos.y)
        self.Image_top2:moveTo(time,self.Image_top2.normalPos.x,self.Image_top2.normalPos.y)
        self.Panel_listView:Pos(self.Panel_listView.normalPos.x,self.Panel_listView.normalPos.y)
        self.Panel_top_option:timeOut(function()
                self.Panel_listView:moveTo(time,self.Panel_listView.normalPos.x,self.Panel_listView.normalPos.y-400)
                self.Image_top2:moveTo(time,self.Image_top2.normalPos.x,self.Image_top2.normalPos.y-400)
            end,disTime+0.1)
    else
        if isSelect and isSelect == true then
            self.Panel_listView:Pos(self.Panel_listView.normalPos.x,self.Panel_listView.normalPos.y)
            self.Image_top2:Pos(self.Image_top2.normalPos.x,self.Image_top2.normalPos.y)
        else
            disTime = time
            self.Panel_listView:moveTo(time,self.Panel_listView.normalPos.x,self.Panel_listView.normalPos.y)
            self.Image_top2:moveTo(time,self.Image_top2.normalPos.x,self.Image_top2.normalPos.y)
        end
        self.Panel_top_option:Pos(self.Panel_top_option.normalPos.x,self.Panel_top_option.normalPos.y)
        self.Panel_listView:timeOut(function()
                self.Panel_top_option:moveTo(time,self.Panel_top_option.normalPos.x,self.Panel_top_option.normalPos.y-180)
                self.Image_top2:moveTo(time,self.Image_top2.normalPos.x,self.Panel_top_option.normalPos.y-180)
            end,disTime+0.1)
    end

    self:timeOut(function()
            self.isTouch = true
        end,2*disTime+0.1)

    if sender == nil and table.count(self.pListData) ~= 0 then
        sender = {}
        sender.playerId = self.pListData[#self.pListData].playerId
        sender.palyerName = self.pListData[#self.pListData].palyerName
    end
    if table.count(self.pListData) == 0 then
        self.Image_top2:hide()
    else
        --self.Image_top2:show() --屏蔽箭头
    end
    self.Image_top2:timeOut(function()
            if table.count(self.pListData) == 0 then

            elseif isShowList and isShowList == true then
                self.Image_top2.downArrow:hide()
                self.Image_top2.openList:hide()
                self.Image_top2.upArrow:show()
            else
                self.Image_top2.downArrow:show()
                self.Image_top2.openList:show()
                self.Image_top2.upArrow:hide()
            end
        end,0)
    local y = self.Image_top2.normalPos.y
    if isShowList == true then
        -- y = y - self.Panel_listView:Size().height
    elseif self:refreshTopOption(sender) == true then
        -- y = y - self.Panel_top_option:Size().height
    end
    -- self.Image_top2:Pos(self.Image_top2.normalPos.x,y)

    if sender then
        self.pId = sender.playerId
    end
end

function ChatView:refreshTopOption(sender)
    if table.count(self.pListData) == 0 or sender then
        self.Panel_top_option:show()
        local Label_request = TFDirector:getChildByPath(self.Panel_top_option, "Label_request")
        local Image_tips = TFDirector:getChildByPath(self.Panel_top_option, "Image_tips")
        local Label_request2 = TFDirector:getChildByPath(self.Panel_top_option, "Label_request2")
        local Image_private_obj = TFDirector:getChildByPath(self.Panel_top_option, "Image_private_obj")
        local Panel_pTouch = TFDirector:getChildByPath(Image_private_obj, "Panel_pTouch")
        local Image_down = TFDirector:getChildByPath(Image_private_obj, "Image_down"):show()
        local Image_up = TFDirector:getChildByPath(Image_private_obj, "Image_up"):hide()

        Panel_pTouch:onClick(function()
            if self.isTouch == false then
                return
            end
            self:refreshPanelPrivate(nil,true)

            Image_down:setVisible(not Panel_pTouch.isShowList)
            --Image_up:setVisible(Panel_pTouch.isShowList)
        end)

        if sender then
            Label_request:hide()
            Image_tips:hide()
            Label_request2:hide()
            Image_private_obj:show()
            local Label_pName = TFDirector:getChildByPath(Image_private_obj, "Label_pName")
            Label_pName:setText(sender.palyerName)
            local Label_pId = TFDirector:getChildByPath(Image_private_obj, "Label_pId")
            Label_pId:setText("ID:" .. tostring(sender.playerId))
        else
            Label_request:show()
            Image_tips:show()
            Label_request2:show()
            Image_private_obj:hide()
        end

        return true
    else
        self.Panel_top_option:show()
        return false
    end
end

function ChatView:initScrollTab()

    self.normalTab = TFDirector:getChildByPath(self.ui,"Image_tab_normal")
    self.selectTab = TFDirector:getChildByPath(self.ui,"Panel_tab_select")

    self.listViewHeight = self.normalTab:Size().height*(#self.btnConfig_ - 1) + self.selectTab:Size().height

    local ScrollView_tab = TFDirector:getChildByPath(self.ui, "ScrollView_tab")

    if self.listViewHeight < ScrollView_tab:Size().height then
        ScrollView_tab:Size(ScrollView_tab:Size().width,self.listViewHeight)
    end

    self.ListView_tab = UIListView:create(ScrollView_tab)

    self:refreshView(self.defaultSelectIndex_)
end

function ChatView:refreshView(selectIndex)
    self:initTabBtn(selectIndex)

    self.ListView_tab:jumpToBottom()

    for i, v in ipairs(self.tabBtn_) do
        v:setTouchEnabled(true)
        v:onClick(function()
                self:selectTabBtn(i)
        end)
    end

    self:onRedPointUpdate()
end

function ChatView:initTabBtn(selectIndex)
    self.tabBtnNormal_ = {}
    self.tabBtnSelect_ = {}
    self.tabBtn_ = {}

    local function setRoom(obj,chanel)
        if obj.chanel == nil then
            return nil
        end
        local chanel = tostring(chanel)
        while #chanel < 3 do
            chanel = "0"..chanel
        end
        obj.chanel:setText(chanel)

        return chanel
    end

    self.ListView_tab:removeAllItems()

    for i, v in ipairs(self.btnConfig_) do
        self.tabBtnNormal_[i] = self.normalTab:clone()
        self.tabBtnNormal_[i].name = TFDirector:getChildByPath(self.tabBtnNormal_[i], "Label_name")
        self.tabBtnNormal_[i].redPoint = TFDirector:getChildByPath(self.tabBtnNormal_[i], "Image_redPoint")
        self.tabBtnNormal_[i].name:setTextById(v.txt)

        self.tabBtnSelect_[i] = self.selectTab:clone()
        self.tabBtnSelect_[i].name = TFDirector:getChildByPath(self.tabBtnSelect_[i], "Label_name")
        self.tabBtnSelect_[i].chanel = TFDirector:getChildByPath(self.tabBtnSelect_[i], "Label_chanel")
        self.tabBtnSelect_[i].name:setTextById(v.txt)

        local roomId = nil
        if selectIndex == i then
            self.tabBtn_[i] = self.tabBtnSelect_[i]
            if v.chat == EC_ChatType.WORLD then
                roomId = ChatDataMgr:getWorldRoomId()
                self.tabBtnSelect_[i].chanel:show()
            else
                self.tabBtnSelect_[i].chanel:hide()
            end
        else
            self.tabBtn_[i] = self.tabBtnNormal_[i]
        end
        self.tabBtn_[i].chatType   = v.chat
        self.tabBtn_[i].setRoom  = setRoom
        self.tabBtn_[i].room = self.tabBtn_[i]:setRoom(roomId)

        self.ListView_tab:pushBackCustomItem(self.tabBtn_[i])
    end

    self:selectTabBtn(selectIndex)
end

function ChatView:selectTabBtn(index)
    if self.selectIndex_ == index then return end

    self.ui:stopAllActions()
    self.isTouchMove = false

    self.selectIndex_ = index

    self:refreshPrefabe()

    self:hideEmotionList()

    self.Button_teamRoom:setVisible(self.tabBtn_[index].chatType == EC_ChatType.TEAM_YQ)

    for i, v in ipairs(self.tabBtnNormal_) do

    end
    for i, v in ipairs(self.tabBtnSelect_) do

    end

    if self.tabBtn_[index].chatType == EC_ChatType.SYSTEM
    or self.tabBtn_[index].chatType == EC_ChatType.TEAM_YQ then
        self.TextButton_input:Touchable(false)
        self.btn_send:Touchable(false)
        self.btn_send:setGrayEnabled(true)
    else
        self.TextButton_input:Touchable(true)
        self.btn_send:Touchable(true)
        self.btn_send:setGrayEnabled(false)
    end
    if self.tabBtn_[index].chatType == EC_ChatType.SYSTEM or self.tabBtn_[index].chatType == EC_ChatType.TEAM_YQ then
        self.TextButton_input:hide()
    else
        self.TextButton_input:show()
    end

    self:refreshView(self.selectIndex_)
    self.Label_roomId:setText(tostring(self.tabBtn_[index].room))
    self.TextField_roomId:setText(tostring(self.tabBtn_[index].room))
    self.TextField_roomId.lastText = self.TextField_roomId:getText()
    self:setSelectChanel(self.tabBtn_[index].chatType)
    self:refreshPrivateListItems()
end

-- function ChatView:onShow()
--     self.panel_chat:show()
--     self.panel_chat:moveTo(0.2,0,0)
-- end

function ChatView:tryClose()
    print("tryClose")
    if self.willClose or not self.isTouchClose then
        return
    end
    self.willClose = true
    self.panel_chat:stopAllActions()
    local callback = CallFunc:create(function()
         AlertManager:closeLayer(self)
    end)
    local actions = {
        MoveTo:create(0.4, me.p(-self.panel_chat:getSize().width - 500,0)),
        DelayTime:create(0.05),
        callback
    }

    if self.closeListener then
        self.closeListener()
    end
    self.panel_chat:runAction(Sequence:create(actions))
end

function ChatView:onClose()
    print("ChatView:onClose")
end

function ChatView:tableScroll(tableView)
    local contentOffset = tableView:getContentOffset()
    local contentSize   = tableView:getContentSize()
    local size          = tableView:getSize()
    local length        = contentSize.height - size.height
    local percent       = -contentOffset.y/length
    -- local scale = size.height/contentSize.height*100
    -- self.scrollBar:setBarLengthPercent(scale)
    percent = percent <= 1 and percent or 1
    self.scrollBar:setPercent(math.floor(percent*100))

end

function ChatView:tableCellTouchBegan()
    self.ui:stopAllActions()
    self.isTouchMove = true

    self:hideEmotionList()
end

function ChatView:tableCellTouched()
    self:playWaitUpdateInfo()
end

function ChatView:playWaitUpdateInfo()
    self.ui:stopAllActions()
    self.isNewMsg = false
    local action = Sequence:create({
        DelayTime:create(5),
        CallFunc:create(function()
            if self.isNewMsg then
                local contentSize   = self.tableView:getContentSize()
                local size          = self.tableView:getSize()
                local length        = contentSize.height - size.height
                if length < 0 then
                    self.tableView:setContentOffset(ccp(0, 0),0)
                    -- self.tableView:setTouchEnabled(false)
                else
                    self.tableView:setContentOffset(ccp(0, 0), 0.3)
                    -- self.tableView:setTouchEnabled(true)
                end
            end
            self.isTouchMove = false
        end)
    })

    self.ui:runAction(action)
end

function ChatView:playWaitSendInfo()
    self.Panel_base:stopAllActions()
    local action = Sequence:create({
        DelayTime:create(20),
        CallFunc:create(function()
            self.isUnLockSendInfo = true
        end)
    })

    self.Panel_base:runAction(action)
end

function ChatView:cellSize(tableView,idx)
    return self:calcuCellSize(idx+1)
end

function ChatView:numberOfCells(tableView)
    local chatInfoList = self:getChatInfoList()
    if chatInfoList == nil then
        return 0
    end
    return #chatInfoList
end

function ChatView:tableCellAtIndex(tableView, idx)
    local cell = tableView:dequeueCell()
    if cell == nil or cell.item.prefabeType ~= self.selectIndex_ then
        cell = TFTableViewCell:create()
        cell:setSize(me.size(510,100))
        local item = self.prefabe:clone():show()
        item.prefabeType = self.selectIndex_
        item:setPosition(0,0)
        cell:addChild(item)
        cell.item = item
    end
    local height = self:updateItem(cell.item,self:getChatInfo(idx+1))
    return cell
end


function ChatView:updateItem(item, chatInfo)
    if not chatInfo then
        return
    end
    local name          = chatInfo.pname .. ":"
    local id            = chatInfo.pid
    local content       = chatInfo.content
    local heroCid       = chatInfo.helpFightHeroCid
    local portraitCid = chatInfo.portraitCid
    local portraitFrameCid = chatInfo.portraitFrameCid
    local chatFrameCid = chatInfo.chatFrameCid
    
    if chatInfo.fun == EC_ChatState.AI_ROBOT then
        chatFrameCid = 0
    end

    if not chatFrameCid or chatFrameCid ==0 then
        chatFrameCid = 20000
    end
    local bubbleCfg = ChatDataMgr:getBubbleConfigById(chatFrameCid )
    local fontcolor = AvatarDataMgr:getBubbleFontColor(chatFrameCid)
    local aiName = TextDataMgr:getText(14240019)
    local aiHeadStr = "icon/hero/aichat/110101.png"
    if chatInfo.fun and (chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM) then
        local phoneBaseCfg = DatingPhoneDataMgr:getPhoneBaseCfg(portraitCid)
        if phoneBaseCfg then
            aiName = TextDataMgr:getText(phoneBaseCfg.aiNameId)
            aiHeadStr = phoneBaseCfg.cheek
        end
    end

    local level         = chatInfo.lvl
    local isFuText      = false
    local battlename = nil
    local levellimit = nil
    local icon_path
    local frame_path,headFrameEffect
    local isRedPack = false
    local isHuntingInvitation = false
    local nTeamType = 1
    local Panel_otherItem = TFDirector:getChildByPath(item, "Panel_otherItem")
    local Panel_selfItem = TFDirector:getChildByPath(item, "Panel_selfItem")
    local Panel_aiItem = TFDirector:getChildByPath(item, "Panel_aiItem")
    if Panel_aiItem then
        Panel_aiItem:hide()
    end

    local isSelf = false

    if Panel_otherItem and Panel_selfItem then
        Panel_otherItem:hide()
        Panel_selfItem:hide()
        isSelf = (id == MainPlayer:getPlayerId() and isSelfInfoSpe) and true or false
        if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM or chatInfo.fun == EC_ChatState.RED_PACK_RECORD then
            --组队信息和红包记录不区别自己和别人
            isSelf = false
        end
        item = isSelf and Panel_selfItem or Panel_otherItem
        item:show()
    end

    if Panel_aiItem and chatInfo.fun and (chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM) then
        Panel_otherItem:hide()
        Panel_selfItem:hide()
        isSelf = false
        item = Panel_aiItem
        item:show()
    end

    local image_name    = item:getChildByName("Image_name")
    local panel_content = item:getChildByName("Panel_content"):show()
    local lab_name      = image_name:getChildByName("Label_name")
    local lab_level     = image_name:getChildByName("Label_level")
    local img_content   = panel_content:getChildByName("img_content")
    if img_content then 
        img_content:setVisible(true)
    end
    -- local lab_content   = panel_content:getChildByName("Label_content")
    panel_content:getChildByName("Label_content"):setVisible(false)

    local lab_content = panel_content:getChildByName("lab_content")
    if not lab_content then
        lab_content = TFRichText:create(ccs(self.prefabe.textMaxWidth, 0))
        lab_content:AddTo(panel_content, 999)
        lab_content:setName("lab_content")
    end

    if isSelf then
        lab_content:AnchorPoint(me.p(1, 0))
        lab_content:setPosition(ccp(-15, 10))
    else
        lab_content:AnchorPoint(me.p(0, 0))
        if GAME_LANGUAGE_VAR == "" then
            lab_content:setPosition(ccp(15, 10))
        else
            lab_content:setPosition(ccp(25, 10))
        end
    end

    local image_head    = item:getChildByName("Image_playerHead")
    local Image_dIcon   = item:getChildByName("Image_dIcon")
    local Image_zhudui = TFDirector:getChildByPath(item,"Image_zhudui")
    local Image_red_pack = TFDirector:getChildByPath(item,"Image_red_pack")
    local Panel_redPack_record = TFDirector:getChildByPath(item,"Panel_redPack_record")
    local Panel_hunting_invitation = TFDirector:getChildByPath(item,"Panel_hunting_invitation")
    panel_content:show()
    image_name:show()
    if Image_zhudui then
        Image_zhudui:hide()
    end
    if Image_red_pack then
        Image_red_pack:hide()
    end
    if Panel_redPack_record then
        Panel_redPack_record:hide()
    end
    if Image_dIcon then
        Image_dIcon:hide()
        Image_dIcon.isShow = false
    end

    if Panel_hunting_invitation then
        Panel_hunting_invitation:hide()
    end
    
    if chatInfo.fun and (chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM) then
        isFuText = true
    end

    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
        local lastContent = content
        content = json.decode(content)
        if content then
            if chatInfo.timelong then
                local time = chatInfo.timelong
                print("chatInfo.timelong ",chatInfo.timelong)
                print("time ",time)
                item:runAction(Sequence:create({DelayTime:create(time),CallFunc:create(function()
                      self:onRefreshScroll()
                end)}))
            end
            if Image_zhudui then
                Image_zhudui:show()
                img_content:setVisible(false)
            end
            isFuText = true
            self.nTeamId = content.teamid
            self.nTeamBattleId = content.battleid
            battlename = content.battlename
            levellimit = content.levellimit
            nTeamType = content.nTeamType

            if not battlename then
                Box("battlename为空")
            end
            if not levellimit then
                Box("levellimit为空")
            end
			print("self.nTeamBattleId==========================" .. self.nTeamBattleId)
            local battlecfg = TeamFightDataMgr:getTeamLevelCfg(nTeamType,self.nTeamBattleId)
            if battlecfg.allowInvitation then
                isFuText = false
                isHuntingInvitation = true
                panel_content:hide()
                Panel_hunting_invitation:show()

                local image_head = TFDirector:getChildByPath(Panel_hunting_invitation,"image_head")
                local image_hard = TFDirector:getChildByPath(Panel_hunting_invitation,"image_hard")
                local label_level = TFDirector:getChildByPath(Panel_hunting_invitation,"label_level")
                local label_name = TFDirector:getChildByPath(Panel_hunting_invitation,"label_name")
				local Image_chatView_1 = TFDirector:getChildByPath(Panel_hunting_invitation,"Image_chatView_1.Image_chatView_2")
				local Image_chatView = TFDirector:getChildByPath(Panel_hunting_invitation,"Image_chatView_1")

                local affixData
                if content.affixID and content.affixID > 0 then 
                    affixData = TabDataMgr:getData("MonsterAffix",content.affixID)
                end 
                for index = 1, 4 do
                    local imageAffix = TFDirector:getChildByPath(Panel_hunting_invitation,"Image_affix"..tostring(index))
                    if affixData then
                        local affixIcon  = affixData["affixIcon"..tostring(index)] 
                         if ResLoader.isValid(affixIcon) then 
                            imageAffix:show()
                            imageAffix:setScale(0.3)
                            imageAffix:setTexture(affixIcon)
                         else
                            imageAffix:hide()
                         end
                    else
                        imageAffix:hide()
                    end
                end
			
                image_head:setTexture(battlecfg.bossicon)
				if nTeamType == 6 then
					local icon = TabDataMgr:getData("DiscreteData",81028).data[self.nTeamBattleId]
					
					image_hard:setTexture(icon)
					Image_chatView:setTexture("ui/BlackAndWhite/Box/002.png")
					Image_chatView_1:hide()
					image_head:hide()
				else	
					Image_chatView_1:show()
					Image_chatView:setTexture("ui/teampve/huntingInvitation/004.png")
					image_hard:setTexture(battlecfg.levelIcon)
					image_head:show()
				end
                label_name:setTextById(battlecfg.levelName)
                label_level:setTextById(battlecfg.LevelDesc)

                Panel_hunting_invitation:setTouchEnabled(true)
                Panel_hunting_invitation:onClick(function ( ... )
                    print("请求加入队伍:"..content.teamid,content.nTeamType)
                    TeamFightDataMgr:requestJoinTeam(content.teamid,content.battleid,content.nTeamType)
                end)
            end


        elseif Image_dIcon then
            content = lastContent
            panel_content:hide()
            Image_dIcon:show()
            Image_dIcon.isShow = true
            Image_dIcon:setTexture(content)
        end
    end

    if chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK then
        isRedPack = true
        panel_content:hide()
        local lastContent = content
        content = json.decode(content)
        if content then
            if Image_red_pack then
                Image_red_pack:show()
            end
            local Label_zhufuyu = TFDirector:getChildByPath(Image_red_pack,"Label_zhufuyu")
            local Image_res = TFDirector:getChildByPath(Image_red_pack,"Image_res")
            local Panel_cover = TFDirector:getChildByPath(Image_red_pack,"Panel_cover")
            local Label_check = TFDirector:getChildByPath(Image_red_pack,"Label_check")
            Label_zhufuyu:setText(content.bless)
            local packetCfg = LeagueDataMgr:getPacketCfgById(content.cid)
            if packetCfg.type == 1 then
                Image_res:setTexture("icon/system/003.png")
            else
                Image_res:setTexture("icon/system/005.png")
            end
            local info = ChatDataMgr:getRedPacketStatus(id, content.time)
            if info.count <= 0 then
                Panel_cover:setVisible(true)
                Label_check:setTextById(270492)
            elseif info.status == 1 then
                Panel_cover:setVisible(true)
                Label_check:setTextById(270491)
            else
                Panel_cover:setVisible(false)
                Label_check:setTextById(270493)
            end
            Image_red_pack:Touchable(true)
            Image_red_pack:onClick(function()
                LeagueDataMgr:ReqRedPacket(content.cid, id, content.time)
            end)
        elseif Image_dIcon then
            content = lastContent
            Image_dIcon:show()
            Image_dIcon.isShow = true
            Image_dIcon:setTexture(content)
        end
    end

    if chatInfo.fun and chatInfo.fun == EC_ChatState.HERO_SHARE then
        local lastContent = json.decode(content)
        if lastContent then
            content = lastContent.heroName
            fontcolor = "#FF7995"
            local heroId = tonumber(lastContent.heroId)
            img_content:setTouchEnabled(true)
            img_content:onClick(function()
                if id == MainPlayer:getPlayerId() then
                    return
                end
                self.checkingShareHero = true
                self.shareHeroId = heroId
                MainPlayer:sendPlayerId(id)
            end)
        end
    end

    if id == MainPlayer:getPlayerId() then
        name = MainPlayer:getPlayerName()
        heroCid = MainPlayer:getAssistId()
        portraitCid = AvatarDataMgr:getCurUsingCid()
        portraitFrameCid = AvatarDataMgr:getCurUsingFrameCid()
        level = MainPlayer:getPlayerLv()
        icon_path = AvatarDataMgr:getSelfAvatarIconPath()
        frame_path,headFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    elseif heroCid then
        portraitCid = portraitCid > 0 and portraitCid or heroCid
        icon_path =  AvatarDataMgr:getAvatarIconPath(portraitCid)
        frame_path,headFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(portraitFrameCid)
    end

    -- dump(chatInfo)

    if chatInfo.fun and (chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM) then
        image_head:setTexture(aiHeadStr)
        img_content:setTexture("ui/chat/ai_bg.png")
        --portraitCid
        image_head:setTouchEnabled(true)
        image_head:onClick(function()
            if chatInfo.portraitCid and DatingPhoneDataMgr:getRoleInfoById(chatInfo.portraitCid).openAI then
                Utils:openView("datingPhone.SceondAIChatView", chatInfo.portraitCid)
            end
        end)
    else
        if image_head and heroCid and heroCid ~= 0 then
            local headIcon    = image_head:getChildByName("Image_icon")
            local Image_head_cover_frame    = image_head:getChildByName("Image_head_cover_frame")
            headIcon:setTexture(icon_path)
            Image_head_cover_frame:setTexture(frame_path)
            local headFrameEffectAnimation = Image_head_cover_frame:getChildByName("headFrameeffect")
            if headFrameEffectAnimation then
                headFrameEffectAnimation:removeFromParent()
            end
            if headFrameEffect ~= "" then
                headFrameEffectAnimation = SkeletonAnimation:create(headFrameEffect)
                headFrameEffectAnimation:setAnchorPoint(ccp(0,0))
                headFrameEffectAnimation:setPosition(ccp(0,0))
                headFrameEffectAnimation:play("animation", true)
                headFrameEffectAnimation:setName("headFrameeffect")
                Image_head_cover_frame:addChild(headFrameEffectAnimation, 1)
            end
            image_head:Touchable(true)
            image_head:onClick(function()
                if id == MainPlayer:getPlayerId() then
                    return
                end

                MainPlayer:sendPlayerId(id)
            end)
            -- local fontName = AvatarDataMgr:getCustomFontName(portraitCid)
            -- lab_content:setFontName(fontName)
            -- local color = AvatarDataMgr:getCustomFontColor(portraitCid)
            -- lab_content:setFontColor(color)
            -- local bgName = AvatarDataMgr:getChatCustomContentFrame(portraitCid, id == MainPlayer:getPlayerId())
            
            -- 气泡需要翻转
            if bubbleCfg.overturnType == 1 then
                if isSelf then
                    img_content:setTexture(bubbleCfg.icon)
                else
                    img_content:setScaleX(-1)
                    img_content:setTexture(bubbleCfg.icon)
                end
            else
                if isSelf then
                    img_content:setTexture(bubbleCfg.icon)
                else
                    img_content:setScaleX(1)
                    img_content:setTexture(bubbleCfg.othericon)
                end
            end
            -- panel_content:setBackGroundImage(bgName)
        end
    end

    if image_head and image_head:isVisible() == true then
        --if chatInfo.pid == MainPlayer:getPlayerId() or (chatInfo.as and chatInfo.as == MainPlayer:getAs()) then
        --    image_head:setTexture("ui/mainLayer/057.png")
        --    --image_name:setTexture("ui/mainLayer/056.png")
        --    lab_name:FontColor(ccc3(255,255,255))
        --else
        --    image_head:setTexture("ui/mainLayer/053.png")
        --    --image_name:setTexture("ui/mainLayer/054.png")
        --    lab_name:FontColor(ccc3(0,0,0))
        --end
    end

    --等级
    if level and level ~= 0 and lab_level then
        lab_level:setText(string.format("Lv.%d",level))
    end

    --名字处理
    if chatInfo.fun and (chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM) then
        lab_name:setText(aiName)
    else
        lab_name:setText(name)
    end

    local panelNameSize   = image_name:getSize()
    local childSize   = lab_name:getSize()
    local posX        = lab_name:getPositionX()
    panelNameSize.width   = childSize.width + posX + 28
    image_name:setSize(panelNameSize)

    local Image_title = item:getChildByName("Image_title")
    if Image_title then
        Image_title:hide()
        if chatInfo.titleId and chatInfo.titleId > 0 then
            local titleCfg = TitleDataMgr:getTitleCfg(chatInfo.titleId)
            if titleCfg.chatShow then
                Image_title:show()
                Image_title:removeAllChildren()
                local skeletonTitleNode = TitleDataMgr:getTitleEffectSkeletonModle(chatInfo.titleId, 1)
                Image_title:addChild(skeletonTitleNode,10)
            end
        end
        Image_title:setScale(0.6)
    end

    --消息
    local maxWidth    = self.prefabe.maxWidth
    local bottomSpace = self.prefabe.bottomSpace
    local space       = self.prefabe.space
    posX     = lab_content:getPositionX()
    local maxTextWidth = self.prefabe.textMaxWidth
    -- lab_content:ignoreContentAdaptWithSize(true)
    local labCopy = nil
    -- if lab_content.labCopy then
    --     lab_content.labCopy:removeFromParent()
    --     lab_content.labCopy = nil
    -- end

    if isFuText then
        -- lab_content:setWidth(maxTextWidth-50)
        lab_content:hide()
        if chatInfo.fun == EC_ChatState.AI_ROBOT or chatInfo.fun == EC_ChatState.SYSTEM then
            space = 10
            local inputText = string.htmlspecialchars(content)
            local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
            local matchCnt,cnt = 0,0
            for k,v in ipairs(faceCfg) do
                inputText,cnt = string.gsub(inputText,v.specialcode,v.convermotion)
                if matchCnt == 0 then
                    matchCnt = cnt
                end
            end
            local textAttr = TextDataMgr:getTextAttr("r301009")
            inputText = string.gsub(inputText, "\n", "<br/>")
            local palyerName = string.htmlspecialchars(chatInfo.pname)
            local text = TextDataMgr:getFormatText(textAttr,palyerName,inputText)
            if not lab_content.labCopy then
                lab_content.labCopy = TFRichText:create(ccs(maxTextWidth-5, 0)):Text(text):AddTo(lab_content:getParent()):AnchorPoint(lab_content:AnchorPoint()):Pos(lab_content:Pos())
            else
                lab_content.labCopy:setSize(ccs(maxTextWidth-5, 0))
                lab_content.labCopy:Text(text)
            end
        else
            local textAttr = TextDataMgr:getTextAttr("r60001")
            local text = TextDataMgr:getFormatText(textAttr,levellimit,battlename)
            if nTeamType == 2 then
                textAttr = TextDataMgr:getTextAttr("r60002")
                text = TextDataMgr:getFormatText(textAttr,battlename)
            end
            if not lab_content.labCopy then
                lab_content.labCopy = TFRichText:create(ccs(maxTextWidth-50, 0)):Text(text):AddTo(lab_content:getParent()):AnchorPoint(lab_content:AnchorPoint()):Pos(lab_content:Pos())
            else
                lab_content.labCopy:setSize(ccs(maxTextWidth-50, 0))
                lab_content.labCopy:Text(text)
            end
            --if id ~= MainPlayer:getPlayerId() then
            --    labCopy:setTouchEnabled(true)
            --    labCopy.nTeamId = content.teamid
            --    labCopy:addMEListener(TFRICHTEXT_CLICK, handler(self.onTfrichTextClick,self))
            --end

            if Image_zhudui and id ~= MainPlayer:getPlayerId() then
                local Button_zhudui = Image_zhudui:getChildByName("Button_zhudui")
                Button_zhudui:onClick(function()
                    print("请求加入队伍:"..content.teamid,content.nTeamType)
                    TeamFightDataMgr:requestJoinTeam(content.teamid,content.battleid,content.nTeamType)
                end)
                Image_zhudui:Touchable(true)
                Image_zhudui:onClick(function()
                    print("请求加入队伍:"..content.teamid,content.nTeamType)
                    TeamFightDataMgr:requestJoinTeam(content.teamid,content.battleid,content.nTeamType)
                end)
            end
        end
        -- lab_content.labCopy = labCopy
        labCopy = lab_content.labCopy

    elseif isRedPack then
        -- lab_content:setWidth(maxTextWidth-50)
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK_RECORD then
        panel_content:hide()
        image_name:hide()
        Image_red_pack:hide()
        Panel_redPack_record:show()
        content = json.decode(content)
        if content then
            local Label_record = TFDirector:getChildByPath(Panel_redPack_record,"Label_record")
            local itemCfg = GoodsDataMgr:getItemCfg(content.itemId)
            local itemName = TextDataMgr:getText(itemCfg.nameTextId)
            Label_record:setTextById("r301006", content.recver,tostring(content.num),itemName)
            Label_record.__richText:setScale(0.9)
        end
    else
        lab_content:show()
        -- lab_content:setWidth(0)
        -- lab_content:setText(content)
        self:setRichContent(lab_content,content,fontcolor,isSelf)
        childSize = lab_content:getSize()
    end

    local panelSize   = panel_content:getSize()

    if isFuText then
        childSize = labCopy:getSize()
        panelSize.width  = maxWidth

        panelSize.height = childSize.height + space*2 + bottomSpace
        labCopy:setPosition(ccp(0,37))
        panel_content:setSize(panelSize)
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK_RECORD then
        childSize.width = 420
        childSize.height = 50
        panelSize.width  = maxWidth

        panelSize.height = childSize.height + space*2 + bottomSpace
        panel_content:setSize(panelSize)
    elseif isRedPack then
        panelSize.width  = maxWidth
        panelSize.height = 150 + space*2 + bottomSpace
        panel_content:setSize(panelSize)
    elseif isHuntingInvitation then
        panelSize.width  = maxWidth
        panelSize.height = Panel_hunting_invitation:getSize().height + space*2 + bottomSpace
        panel_content:setSize(panelSize)
    elseif childSize.width > maxTextWidth then
        print("childSize.width ",childSize.width)
        print("maxTextWidth ",maxTextWidth)
        -- lab_content:setTextAreaSize(me.size(maxTextWidth,0))
        -- lab_content:setText(content)
        self:setRichContent(lab_content,content,fontcolor,isSelf)
        childSize = lab_content:getSize()
        panelSize.width  = maxWidth

        panelSize.height = childSize.height + space*2 + bottomSpace
        -- lab_content:setPositionY((panelSize.height -bottomSpace )/2+bottomSpace - 2)
        panel_content:setSize(panelSize)
    else
        panelSize.width  = childSize.width + 60
        if panelSize.width < maxWidth/2 then
          panelSize.width = maxWidth/2
        end
        panelSize.height = childSize.height + space*2 + bottomSpace
        -- lab_content:setPositionY((panelSize.height - bottomSpace )/2+bottomSpace - 2)
        panel_content:setSize(panelSize)
    end

    if isSelf then
        -- lab_content:PosX(-panelSize.width + 20)
    end
    if lab_content.labCopy then
        lab_content.labCopy:Pos(lab_content:Pos().x - 5,lab_content.labCopy:Pos().y - 25)
    end

    -- 气泡大小位置的固定调整
    if img_content then
        
        local width = panel_content:getSize().height + 35
        img_content:setSize(ccs(panel_content:getSize().width + 40, width < 72 and 72 or width))

        if isSelf then
            img_content:setPosition(ccp(10, -15))
        else
            if bubbleCfg.overturnType == 1 then
                img_content:setPosition(ccp(-15 + img_content:getSize().width, -15))
            else
                img_content:setPosition(ccp(-20, -15))
            end
        end

        if width < 72 then
            local dis = 72 - width
            img_content:setPositionY(img_content:getPositionY() - dis)
            lab_content:setPositionY(lab_content:getPositionY() - dis)
        end
    end

    --修正名字位置
    image_name:setPositionY(panel_content:Pos().y + panelSize.height)
    local itemSize  = item:getSize()

    if self.prefabe.playerHead then
        itemSize.height = panelSize.height + self.prefabe.playerHead:Size().height + space
    else
        itemSize.height = panelSize.height + space + 60
    end
    itemSize.height = itemSize.height - 10
    itemSize.width = itemSize.width
    item:setSize(itemSize)
    return itemSize.height
end

-- 转换富文本
function ChatView:setRichContent(lab_content,str,fontColor,isSelf)

    if type(str) == 'table' then
        return
    end

    str = string.htmlspecialchars(str)
    local dicts = ChatDataMgr:getRichtextImgDict()
    local parent = lab_content:getParent()
    local strdata = nil
    for _str, value in pairs(dicts) do
        if string.find(str, _str) then
            strdata = value
            if value.type == EmotionType.Small then
                str = string.gsub(str, _str, value.emotionres)
            elseif value.type == EmotionType.Big then
                break
            end
        end
    end
    str = string.gsub(str, "\n", "<br/>")
    fontColor = fontColor or "#FFFFFF"
    
    -- 富文本模拟配置
    local richData =  {
        {
            baseName = "fangzheng_zhunyuan",
            name = "font/fangzheng_zhunyuan.ttf",
            color = fontColor,
            text = "%s",
            clickId = "",
            size = 22,
        },
        align = "left",
    }
    lab_content:Text(TextDataMgr:getFormatText(richData,str))
    lab_content:setVisible(true)
    --[[彻底屏蔽精灵表情
        -- 未找到gif纹理的复用方法 暂时直接移除
        if parent and parent:getChildByName("gif") then
            parent:getChildByName("gif"):removeFromParent()
        end

        -- 动态gif
        if strdata and strdata.type == EmotionType.Big then
            lab_content:setVisible(false)
            -- 动画高度 
            lab_content:setContentSize(ccs(0,100))
            if parent then
                local gif = CacheGif:create(strdata.emotionres)
                -- local gif = InstantGif:create(strdata.emotionres)
                if not gif then
                    Box("Gif Create Fail!!!")
                    return
                end
                -- gif:play(100)
                gif:setScale(0.5)
                -- gif 相对位置
                if isSelf then
                    gif:setPosition(ccp(-70, 40))
                else
                    gif:setPosition(ccp(70, 40))
                end
                gif:setName("gif")
                gif:AddTo(lab_content:getParent())

                parent:getChildByName("img_content"):setVisible(false)
            end
        end
    ]]--
end

function ChatView:onTfrichTextClick(...)
    local data = {...}
    local obj = data[1]
    local clickId = data[2]
    if clickId == 1001 and obj.nTeamId then
        print("请求加入队伍:"..obj.nTeamId)
    	TeamFightDataMgr:requestJoinTeam(obj.nTeamId,obj.nTeamBattleId)
    end
end

function ChatView:calcuCellSize(idx)
    local chatInfo      = self:getChatInfo(idx)
    if not chatInfo then
        return -20, 0
    end
    local content       = chatInfo.content
    local panelNameSize = self.prefabe.panelNameSize
    local fontcolor
    -- local lab_content   = self.prefabe.lab_content
    -- local lab_content = self.prefabe.panel_content:getChildByName("lab_content")
    -- if not lab_content then
    local lab_content = TFRichText:create(ccs(self.prefabe.textMaxWidth, 0))
    -- lab_content:AddTo(self.prefabe.panel_content)
    --     lab_content:setName("lab_content")
    -- end
    local panel_content = self.prefabe.panel_content
    local image_name    = self.prefabe:getChildByName("Image_name")
    local Image_dIcon   = self.prefabe:getChildByName("Image_dIcon")
    local Image_red_pack = self.prefabe:getChildByName("Image_red_pack")
    local Panel_hunting_invitation = self.prefabe:getChildByName("Panel_hunting_invitation")
    
    if Image_dIcon then
        Image_dIcon.isShow = false
    end
    --消息
    local maxWidth    = self.prefabe.maxWidth
    local bottomSpace = self.prefabe.bottomSpace
    local space       = self.prefabe.space
    local isFuText    = false
    local isRedPack = false
    local isHuntingInvitation = false
    local battlename = nil
    local levellimit = nil
    local nTeamType = 1
    if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
        content = json.decode(content)
        if content then
            isFuText = true
            self.nTeamId = content.teamid
            self.nTeamBattleId = content.battleid
            battlename = content.battlename
            levellimit = content.levellimit
            nTeamType = content.nTeamType
            if not battlename then
                Box("battlename为空")
            end
            if not levellimit then
                Box("levellimit为空")
            end

            local battlecfg = TeamFightDataMgr:getTeamLevelCfg(nTeamType,self.nTeamBattleId)

            if battlecfg.allowInvitation then
                isHuntingInvitation = true
                isFuText = false
            end

        elseif Image_dIcon then
            Image_dIcon.isShow = true
        end
    end
    if chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK then
        isRedPack = true
        local lastContent = content
        content = json.decode(content)
    end

    if chatInfo.fun and chatInfo.fun == EC_ChatState.HERO_SHARE then
        local lastContent = json.decode(content)
        if lastContent then
            content = lastContent.heroName
            fontcolor = "#FF7995"
        end
    end

    posX     = lab_content:getPositionX()
    local maxTextWidth = self.prefabe.textMaxWidth
    -- lab_content:ignoreContentAdaptWithSize(true)
    if lab_content.labCopy2 then
        lab_content.labCopy2:removeFromParent()
        lab_content.labCopy2 = nil
    end

    if isFuText then
        -- lab_content:setWidth(maxTextWidth)
        labCopy2 = self.prefabe.lab_content:setTextById("r60001", levellimit,battlename)
        if nTeamType == 2 then
            labCopy2 = self.prefabe.lab_content:setTextById("r60001", levellimit,battlename)
        end
        labCopy2:hide()
    elseif isRedPack then
        -- lab_content:setWidth(maxTextWidth)
    else
        -- lab_content:setText(content)
        self:setRichContent(lab_content, content,fontcolor)
    end

    local panelSize   = panel_content:getSize()
    local childSize   = lab_content:getSize()

    if isFuText then
        childSize = labCopy2:getSize()
        panelSize.height = childSize.height + space*2 + bottomSpace + 15
    elseif isRedPack then
        panelSize.height = Image_red_pack:Size().height + space*2 + bottomSpace
    elseif chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK_RECORD then
        panelSize.height = 30 + space*2 + bottomSpace
    elseif isHuntingInvitation then
        panelSize.height = Panel_hunting_invitation:getSize().height + space*2 + bottomSpace
    elseif childSize.width > maxTextWidth then
        -- lab_content:ignoreContentAdaptWithSize(false)
        -- lab_content:setTextAreaSize(me.size(maxTextWidth,0))
        -- lab_content:setText(content)
        self:setRichContent(lab_content, content)
        childSize = lab_content:getSize()
        panelSize.height = childSize.height + space*2 + bottomSpace
    else
        panelSize.height = childSize.height + space*2 + bottomSpace
    end
    local height
    if self.prefabe.playerHead then
        if chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK then
            height = panelSize.height + self.prefabe.playerHead:Size().height + space
        else
            height = panelSize.height + self.prefabe.playerHead:Size().height + space
        end
    else
        height = panelSize.height + space + 60
    end
    if chatInfo.fun and chatInfo.fun == EC_ChatState.RED_PACK_RECORD then
        height = 80
    end
    if chatInfo.titleId and chatInfo.titleId > 0 then
        local titleCfg = TitleDataMgr:getTitleCfg(chatInfo.titleId)
        if titleCfg.chatShow then
            height = height + 10
        end
    end

    return  height - 10, maxWidth
end

function ChatView:getChatInfoList()
    local datas = ChatDataMgr:getChatList(self.chatType)
	-- print("=================================self.chatType=" .. self.chatType)
	if datas then
		-- print("datas=" .. #datas)
	end	
    if self.chatType == EC_ChatType.TEAM_YQ then
        local _datas = {}
        for i,chatInfo in ipairs(datas) do
            if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM then
                local content = json.decode(chatInfo.content)
				print("---------------------------------------------------content.nTeamType=" .. content.nTeamType)
				
                if content and (content.nTeamType == 4 or content.nTeamType == 6) then 
                    local battlecfg = TeamFightDataMgr:getTeamLevelCfg(content.nTeamType,content.battleid)
                    if battlecfg then
						--print("---------------------------------------------------content.BlackAndWhiteDifficultySelects=" .. self.BlackAndWhiteDifficultySelects[battlecfg.challangeLevel])
                        if content.nTeamType == 4 and self.difficultySelects[battlecfg.challangeLevel] == "1" then 
                            table.insert(_datas,chatInfo)
						elseif 	content.nTeamType == 6 then
							local battleLevel = TabDataMgr:getData("DiscreteData",81030).data[content.battleid]
							if self.BlackAndWhiteDifficultySelects[battleLevel] == "1" then
								table.insert(_datas,chatInfo)
							end
                        end
                    else
                        table.insert(_datas,chatInfo)
                    end
                else
                    table.insert(_datas,chatInfo)
                end
            end
        end
        _datas = datas or {}
        if #_datas >0 then
            self.label_empyTetx:hide()
        else
            self.label_empyTetx:show()
        end
        return _datas
    else
        datas  = datas or {}
        if #datas >0 then
            self.label_empyTetx:hide()
        else
            self.label_empyTetx:show()
        end
        return datas
    end
end


function ChatView:getChatInfo(idx)
    local chatInfoList = self:getChatInfoList()
    return chatInfoList[idx]
end

function ChatView:onSwitchPrivate()
    self:selectTabBtn(1)
end

function ChatView:onTouchSendRoomBtn()
    if not self.inputTextField then
        -- toastMessage("发送内容不能为空")
         Utils:showTips(800104)
    elseif self.inputTextField.type == "TextField_roomId" then
        local content = self.TextField_roomId:getText()
        if content and #content > 0 then
            local roomId = tonumber(content)

            if roomId and roomId < 2000 and roomId > 0 and math.floor(roomId) == roomId then
                ChatDataMgr:sendChangeRoom(roomId)
            else
                -- toastMessage("房间号为1-1999，请输入正确的房间号")
                Utils:showTips(600019)
            end
        else
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        end
    end
end

function ChatView:onTouchSendBtn()

    self.tf_input:hide()
    self.TextButton_input:show()
    if not self.inputTextField and not self.comeFromEmotion then
        -- toastMessage("发送内容不能为空")
        Utils:showTips(800104)
    elseif self.inputTextField and self.inputTextField.type == "TextField_roomId" then
        local content = self.TextField_roomId:getText()
        if content and #content > 0 then
            local roomId = tonumber(content)

            if roomId and roomId < 2000 and roomId > 0 and math.floor(roomId) == roomId then
                ChatDataMgr:sendChangeRoom(roomId)
            else
                -- toastMessage("房间号为1-1999，请输入正确的房间号")
                Utils:showTips(600019)
            end
        else
            -- toastMessage("发送内容不能为空")
            Utils:showTips(800104)
        end
    elseif self.inputTextField and self.inputTextField.type == "tf_input" or self.comeFromEmotion then
        if self.chatType == EC_ChatType.WORLD or self.chatType == EC_ChatType.GUILD or self.chatType == EC_ChatType.PRIVATE or self.chatType == EC_ChatType.TEAM  
            or self.chatType == EC_ChatType.BIG_WORLD or self.chatType == EC_ChatType.COURAGE  then
            local content = self.tf_input:getText()
            if content and #content > 0 then
                if not ChatDataMgr:getSendInfoUnLockState() then
                    Utils:showTips(600020)
                    return
                end
                ChatDataMgr:setSendInfoUnLockState(false)
                ChatDataMgr:playWaitSendInfo()
                ChatDataMgr:sendChatInfo(self.chatType,content,self.pId)
                --DatingPhoneDataMgr:sendAiDialogue(EC_PhoneChatType.Normal, content, 101)
                self.tf_input:setText("")
            else
                -- toastMessage("发送内容不能为空")
                Utils:showTips(800104)
            end
        else
            -- toastMessage("不能在系统频道发言")
            Utils:showTips(800105)
        end
    end
    self:hideEmotionList()
end

function ChatView:onRefreshRoom()
    self:reloadData()
    self:refreshView(self.selectIndex_)
    local function setRoom(obj,chanel)
        if obj.chanel == nil then
            return nil
        end
        local chanel = tostring(chanel)
        while #chanel < 3 do
            chanel = "0"..chanel
        end
        obj.chanel:setText(chanel)

        return chanel
    end
    self.Label_roomId:setText(string.format("%03d",ChatDataMgr:getWorldRoomId()))
    self.TextField_roomId:setText(string.format("%03d",ChatDataMgr:getWorldRoomId()))
    self.TextField_roomId.lastText = self.TextField_roomId:getText()
end

function ChatView:onQuitUnionBack()
    AlertManager:closeAll()
    AlertManager:changeScene(SceneType.MainScene)
end

--难度变更
function ChatView:onDifficultyChange()
    if self.chatType == EC_ChatType.TEAM_YQ then
        self:reloadData()
    end
end

function ChatView:registerEvents()
    EventMgr:addEventListener(self,EV_DIFFICULTY_CHANGE, handler(self.onDifficultyChange, self))
    EventMgr:addEventListener(self,EV_RECV_CHATINFO, handler(self.onAddMessage, self))
    EventMgr:addEventListener(self,EV_RED_POINT_UPDATE_CHAT, handler(self.onRedPointUpdate, self))
    EventMgr:addEventListener(self,EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))
    EventMgr:addEventListener(self,EV_SWITCH_PRIVATE, handler(self.onSwitchPrivate, self))
    EventMgr:addEventListener(self,EV_REFRESH_WORLDROOM, handler(self.onRefreshRoom, self))
    EventMgr:addEventListener(self,EV_EV_REFRESH_TEAMYQ, handler(self.onRefreshScroll, self))
    EventMgr:addEventListener(self,EV_FRIEND_OPERATEFRIEND, handler(self.onRefreshScroll, self))
    EventMgr:addEventListener(self,EV_UNION_REDPACKET_INFO, handler(self.onRefreshScroll, self))
    EventMgr:addEventListener(self,EV_CHAT_UPDATE_TEAM_INVITE, handler(self.onRefreshScroll, self))
    EventMgr:addEventListener(self,EV_UNION_QUIT_UNION, handler(self.onQuitUnionBack, self))
    --EventMgr:addEventListener(self,EV_DATING_EVENT.robotDialogue, handler(self.onRecvRobotDialogue, self))
    self.Button_filter:onClick(function() 
        Utils:openView("chat.DifficultyChoice")
    end)
    -- 发送消息
    self.btn_send:onClick(function ()
        self:onTouchSendBtn();
    end)

    self.TextButton_input:onClick(function()
        if not RELEASE_TEST and not FunctionDataMgr:checkFuncOpen(42) then return end
        self.tf_input:openIME()
        self.btn_send:show()
        self.TextButton_input:hide()
        end)
    -- 关闭
    self.panel_close:onClick(function()
        self:tryClose()
    end)

    self.Button_refresh:onClick(function()
        ChatDataMgr:sendChangeRoom()
        end)

    local function onTextFieldChangedHandleAcc(input)
        self.inputLayer:listener(input:getText());
    end

    local function onTextFieldAttachAcc(input)
        self.inputTextField = input
        self.inputLayer:show();
        self.inputLayer:listener(input:getText());
    end

    self.tf_input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.tf_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.tf_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.TextField_roomId:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.TextField_roomId:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.TextField_roomId:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Panel_roomTouch:onClick(function()
        self.TextField_roomId:openIME()
    end)

    for i, v in ipairs(self.mainPageOptionList) do
        v:Touchable(true)
        v:onClick(function()
            self:selectMainPage(i)
        end)
    end

    self.pageView:addMEListener(TFPAGEVIEW_CHANGED, function ()
        self:pageViewChanged();
    end)

    self.Button_douTu:onClick(function(sender)
        if not FunctionDataMgr:checkFuncOpen(42) then
            return 
       end
       if self.Button_douTu.isShow then
           self:hideEmotionList()
       else
           self:showEmotionList()
       end
    end)

    self.Button_1:onClick(function()
        self:showDouTu(1)
    end)

    self.Button_2:onClick(function()
        self:showDouTu(2)
    end)

    self.Button_red_pack:onClick(function()
        Utils:openView("league.LeagueSendRedPacketView")
    end)

    -- 表情框列表选择
    self.btn_SEmotion:onClick(function()
        self:refreshEmotionSelect(EmotionType.Small)
        self.img_selectEmotion:setPositionX(self.btn_SEmotion:getPositionX())
    end)

    -- 精灵暂时表情隐藏
    self.btn_BEmotion:hide()
    self.btn_BEmotion:onClick(function()
        self:refreshEmotionSelect(EmotionType.Big)
        self.img_selectEmotion:setPositionX(self.btn_BEmotion:getPositionX())
    end)

    self.Button_share:onClick(function()
        Utils:openView("fairyNew.FairyMainLayer",{fromChatShare = true})
    end)

    self.Button_teamRoom:onClick(function()
        Utils:openView("teamPve.TeamRoomView")
    end)
end

function ChatView:hideEmotionList()
    local pos = self.panel_send.oldPos
    self.panel_send:runAction(Sequence:create({
        MoveTo:create(0.2, pos),
        CallFunc:create(function()
            self.Button_douTu.isShow = false
            self.panel_send:setPosition(pos)
            self.tableView:setPositionY( self.tableView.oldPos)
        end)
    }))
end

function ChatView:showEmotionList()
    local pos = me.p(self.panel_send.oldPos.x, self.panel_send.oldPos.y + self.panel_emotion:getContentSize().height)
    self.panel_send:runAction(Sequence:create({
        MoveTo:create(0.2, pos),
        CallFunc:create(function()
            self.Button_douTu.isShow = true
            self.panel_send:setPosition(pos)
            self.tableView:setPositionY( self.tableView.oldPos + self.panel_emotion:getContentSize().height)
        end)
    }))
end

function ChatView:setSelectChanel(chatType)
    dump({self.chatType,chatType})
    self.Panel_union:hide()
    if chatType == EC_ChatType.PRIVATE then
        self:refreshPanelPrivate(nil,nil,true)
        self.Image_room:hide()
    elseif chatType == EC_ChatType.GUILD then
        self.Image_room:hide()
        self.Panel_union:show()
        local totalCount = LeagueDataMgr:getUnionMemberCount()
        local onlineCount = LeagueDataMgr:getUnionMemberOnlineCount()
        self.Label_online_num:setText(onlineCount.."/"..totalCount)
    else
        self.Panel_private:hide()
        if chatType == EC_ChatType.WORLD then
            self.Image_room:show()
        else
            self.Image_room:hide()
        end
        self.pId = nil
    end
    if self.chatType  ~= chatType then
        self.chatType = chatType
        self:reloadData()
    end

    if self.chatType == EC_ChatType.TEAM_YQ then
        self.Button_filter:show()
    else
        self.Button_filter:hide()
    end
end

--接收到新的聊天消息
function ChatView:onAddMessage(chatInfo)
    if not chatInfo then
        return
    end
    --if chatInfo.fun and chatInfo.fun == EC_ChatState.TEAM and chatInfo.chatType ~= EC_ChatType.TEAM_YQ then
    --    return
    --end

    if chatInfo.chatType ~= self.chatType then
        return
    end
    -- dump(chatInfo)
    self.isNewMsg = true
    self.isRefreshChat = true
    self:reloadData(chatInfo)
end

function ChatView:onRecvRobotDialogue(data)

    if not data then
        return
    end

    if not data.returnMsg then
        return
    end

    if data.type ~= EC_PhoneChatType.Normal then
        return
    end

    local contentStr = {}
    for k,jsonMessage in ipairs(data.returnMsg) do
        local message = json.decode(jsonMessage)
        local messageContent = self:transformDigueStr(message.content)
        local content = string.htmlspecialchars(messageContent)
        local moodid = message.moodid                   ---表情代码
        local faceNum = message.num                     ---表情数量
        local fileName = message.file_name or ""        ---语音文件文件名
        local faceInfo = DatingPhoneDataMgr:getFaceInfoById(moodid)
        if faceInfo then
            for i=1,faceNum do
                content = content..faceInfo.sourcecode
            end
        end
        content = self:transformDigueStr(content)
        table.insert(contentStr,{content = content,type = EC_PhoneContentType.Normal,fileName = fileName})
    end

    -- dump(contentStr[1].content)

    local name = ""
    local phoneBaseCfg = DatingPhoneDataMgr:getPhoneBaseCfg(101)
    if phoneBaseCfg then
        name = TextDataMgr:getText(phoneBaseCfg.aiNameId)
    end

    local chatInfo = {
        channel = EC_ChatType.WORLD,
        content = contentStr[1].content,
        fun = EC_ChatState.AI_ROBOT,
        pname = name,
        pid = 0,
        helpFightHeroCid = 0,
        portraitCid = 1013,
        portraitFrameCid = 1000
    }

    local event = {}
    event.data = chatInfo
    ChatDataMgr:onRecvChatInfo(event)

end

function ChatView:transformDigueStr(inputStr)

    local faceEmotionCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceEmotionCfg) do
        inputStr = string.gsub(inputStr,v.conversioncode,v.specialcode)
    end

    return inputStr
end

--聊天小红点更新
function ChatView:onRedPointUpdate()
    for key ,tab in ipairs(self.tabBtn_) do
        if tab.redPoint then
            local readState = ChatDataMgr:getReadState(tab.chatType)
            if tab.chatType == EC_ChatType.GUILD and readState then
                readState = not ChatDataMgr:getUnionRedPacketReadState()
            end
            tab.redPoint:setVisible(not readState)
        end
    end
end

--玩家信息
function ChatView:onShowPlayerInfoView(playerInfo)
    if not self.checkingShareHero then
        local PlayerInfoView = require("lua.logic.chat.PlayerInfoView"):new(playerInfo)
        AlertManager:addLayer(PlayerInfoView,AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    else
        HeroDataMgr:changeDataToFriend()
        HeroDataMgr.showid = self.shareHeroId
        Utils:openView("fairyNew.FairyDetailsLayer", {showid=self.shareHeroId, friend=true, fromChatShare = true})
        self.checkingShareHero = false
    end
end

function ChatView:onRefreshScroll()
    self:reloadData()
end

function ChatView:reloadData(chatInfo)
    local contentOffset = self.tableView:getContentOffset()
    if self.isRefreshChat == true then
        local height,width = self:calcuCellSize(#self:getChatInfoList())
        self.disHeight = height
    end
    self.tableView:reloadData()
    contentOffset.y = contentOffset.y - self.disHeight
    self.tableView:setContentOffset(contentOffset)
    --更新滚动条的大小
    local contentSize   = self.tableView:getContentSize()
    local size          = self.tableView:getSize()
    local length        = contentSize.height - size.height
    local scale         = size.height/contentSize.height*100

    if contentSize.height < size.height then
        self.tableView:setContentSize(CCSizeMake(contentSize.width,size.height));
    end

    if chatInfo and not self.isTouchMove then
        if length < 0 then
            self.tableView:setContentOffset(ccp(0, 0),0)
            -- self.tableView:setTouchEnabled(false)
        else
            self.tableView:setContentOffset(ccp(0, 0), 0.3)
            -- self.tableView:setTouchEnabled(true)
        end
    end

    self.scrollBar:setBarLengthPercent(scale)
    --设置当前盘频道消息已读
    ChatDataMgr:setReadState(self.chatType,true)
    self.isRefreshChat = false
    self.disHeight = 0
end

function ChatView:setCloseListener(listener)
    self.closeListener = listener
end

function ChatView:removeEvents()
    --UI销毁时强制关闭键盘
    if self.tf_input then 
        self.tf_input:closeIME()
    end
end

function ChatView:onCloseInputLayer()
    if self.inputTextField and self.inputTextField.type == "TextField_roomId" then
        self.TextField_roomId:closeIME()
        self.TextField_roomId:setText(self.TextField_roomId.lastText)
    elseif self.inputTextField and self.inputTextField.type == "tf_input" then
        self.tf_input:closeIME()
        --self.tf_input:setText("")
    end

    if self.tf_input:getText() == "" then
        self.TextButton_input:show()
    else
        self.tf_input:show()
    end
end

function ChatView.show(closeListener,isOpenInput,isTeam,showBigWorld,defaultIndex)
    local params = { 
        isTeam = isTeam,
        showBigWorld = showBigWorld,
        defaultIndex = defaultIndex
    }
    local chatView = ChatView:new(params)
    chatView:setCloseListener(closeListener)
    AlertManager:addLayer(chatView,AlertManager.NONE)
    AlertManager:show()
    chatView.isTouchClose = false
    chatView:timeOut(function()
          chatView.isTouchClose = true
        end,0.3)
    if isOpenInput then
        -- chatView.tf_input:openIME()
        -- chatView.tf_input:show()
        -- chatView.btn_send:show()
        -- chatView.TextButton_input:hide()
        chatView:onSwitchPrivate()
    end

    return chatView
end
return ChatView
