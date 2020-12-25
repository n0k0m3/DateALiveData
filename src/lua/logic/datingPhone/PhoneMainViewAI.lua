local PhoneMainViewAI = class("PhoneMainViewAI", BaseLayer)
local Panel_Type = {
    Main = 1,          --通讯录
    Chat = 2,          --聊天
}
function PhoneMainViewAI:ctor(data)
    self.super.ctor(self)
    --self:showPopAnim(true)
    self:initData(data)
    self:init("lua.uiconfig.iphone.PhoneMainViewAI")
end

function PhoneMainViewAI:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui
    self.Panel_PhoneMain = TFDirector:getChildByPath(self.ui,"Panel_PhoneMain")
    self.Image_bg = TFDirector:getChildByPath(self.Panel_PhoneMain,"Image_bg")
    self.Image_titleBg = TFDirector:getChildByPath(self.Panel_PhoneMain,"Image_titleBg")
    self.Button_close = TFDirector:getChildByPath(self.Panel_PhoneMain,"Button_close")
    self.Button_back = TFDirector:getChildByPath(self.Panel_PhoneMain,"Button_back")
    self.Panel_wifi = TFDirector:getChildByPath(self.Panel_PhoneMain,"Panel_wifi")
    self.winSize = me.Director:getVisibleSize()
    self.Label_pageName = TFDirector:getChildByPath(self.Panel_PhoneMain,"Label_pageName")

    self.phonePL = {}
    self.Panel_contacts_View = TFDirector:getChildByPath(self.ui,"Panel_contacts_View")
    self.Panel_chat_view = TFDirector:getChildByPath(self.ui,"Panel_chat_view")
    self.phonePL[1] = self.Panel_contacts_View
    self.phonePL[2] = self.Panel_chat_view
    self.ScrollView_contacts = TFDirector:getChildByPath(self.Panel_contacts_View,"ScrollView_contacts")
    self.contactsListView = UIListView:create(self.ScrollView_contacts)
    self.contactsListView:setItemsMargin(8)
    self.centerPos = self.Image_bg:convertToNodeSpaceAR(ccp(0,0))
    self.titleBgSize = self.Image_titleBg:getContentSize().height/2
    print(self.centerPos.y,self.winSize.height/2)
    self.Image_titleBg:setPositionY(self.centerPos.y + self.winSize.height/2 + self.titleBgSize)
    self.contactPLsize = self.winSize.height - self.titleBgSize
    self.Panel_contacts_View:setPositionY(self.centerPos.y + self.winSize.height/2 - self.titleBgSize)
    self.contactsListView:setContentSize(CCSizeMake(640, self.contactPLsize - self.titleBgSize))

    --聊天界面、
    self.ScrollView_chat = TFDirector:getChildByPath(self.Panel_chat_view,"ScrollView_chat")
    self.ScrollView_chat:setSwallowTouch(false)
    self.chatListView = UIListView:create(self.ScrollView_chat)
    self.chatListView:setItemsMargin(15)
    self.Panel_chat_view:setPositionY(self.centerPos.y + self.winSize.height/2 - self.titleBgSize)

    --option界面
    self.Panel_option_view = TFDirector:getChildByPath(self.ui,"Panel_option_view"):hide()
    self.ScrollView_option = TFDirector:getChildByPath(self.Panel_option_view,"ScrollView_option")
    self.optionListView = UIListView:create(self.ScrollView_option)
    self.optionListView:setItemsMargin(8)
    self.Label_frameTime = TFDirector:getChildByPath(self.Panel_option_view,"Label_frameTime")
    self.Panel_option_view:setPositionY(self.centerPos.y - self.winSize.height/2 + 550)

    --输入界面
    self.Panel_input_view = TFDirector:getChildByPath(self.ui,"Panel_input_view"):hide()
    self.tf_input = TFDirector:getChildByPath(self.ui,"TextField_input")
    self.showFacePosY = self.centerPos.y - self.winSize.height/2 + 488
    self.hideFacePosY = self.centerPos.y - self.winSize.height/2 + 100
    self.realPLHeight = self.hideFacePosY
    self.Button_send = TFDirector:getChildByPath(self.ui,"Button_send")
    self.Label_cd = TFDirector:getChildByPath(self.ui,"Label_cd")
    self.Label_cd:setText("")
    self.Button_camera = TFDirector:getChildByPath(self.ui,"Button_camera")
    self.Button_face = TFDirector:getChildByPath(self.ui,"Button_face")
    self.Image_face_bg = TFDirector:getChildByPath(self.ui,"Image_face_bg")
    local ScrollView_expression = TFDirector:getChildByPath(self.ui,"ScrollView_expression")
    self.expressionListView = UIListView:create(ScrollView_expression)
    self.Image_textbg = TFDirector:getChildByPath(self.ui,"Image_textbg")
    self.Image_input_bg = TFDirector:getChildByPath(self.Panel_input_view,"Image_bg")
    self.ScrollView_inputText = TFDirector:getChildByPath(self.Panel_input_view, "ScrollView_inputText")
    self.ListView_input = UIListView:create(self.ScrollView_inputText)
    self.ListView_input:setItemsMargin(5)
    self.Panel_inputMask = TFDirector:getChildByPath(self.Panel_input_view, "Panel_inputMask")
    self.ScrollView_inputText:setSwallowTouch(false)
    self.Label_tip = TFDirector:getChildByPath(self.Panel_input_view, "Label_tip")

    --道具购买提示框
    self.Panel_buyTip = TFDirector:getChildByPath(self.ui,"Panel_buyTip"):hide()
    self.Label_itemdesc = TFDirector:getChildByPath(self.Panel_buyTip,"Label_itemdesc")
    self.Image_item_frame = TFDirector:getChildByPath(self.Panel_buyTip,"Image_item_frame")
    self.Label_item_name = TFDirector:getChildByPath(self.Panel_buyTip,"Label_item_name")
    self.Label_item_owncnt = TFDirector:getChildByPath(self.Panel_buyTip,"Label_item_owncnt")
    self.Button_useItem = TFDirector:getChildByPath(self.Panel_buyTip,"Button_useItem")
    self.Button_refuse = TFDirector:getChildByPath(self.Panel_buyTip,"Button_refuse")
    self.Panel_noItem = TFDirector:getChildByPath(self.ui,"Panel_noItem"):hide()
    self.Label_noitemdesc = TFDirector:getChildByPath(self.Panel_noItem,"Label_noitemdesc")
    self.Label_itemdesc:setTextById(901180)
    self.Label_noitemdesc:setTextById(901182)
    self.Button_jump = TFDirector:getChildByPath(self.Panel_noItem,"Button_jump")

    --LIVE2D
    self.Panel_PhoneLive2D = TFDirector:getChildByPath(self.ui,"Panel_PhoneLive2D"):hide()
    self.Image_Live2DtitleBg = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Image_titleBg")
    self.Button_Live2Dclose = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Button_close")
    self.Button_Live2Dback = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Button_back")
    self.Image_Live2Dwifi = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Image_wifi")
    self.winSize = me.Director:getVisibleSize()
    local pos = self.Image_titleBg:convertToNodeSpaceAR(ccp(0,0))
    --self.Image_Live2Dwifi:setPositionX(pos.x-self.winSize.width/2+20)
    self.Label_Live2DName = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Label_pageName")
    self.Image_live2D = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Image_live2D")
    self.Button_voice = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Button_voice")
    self.LoadingBar_voice = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"LoadingBar_voice")
    self.LoadingBar_voice:setPercent(0)
    self.Label_voice = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Label_voice")
    self.Label_voice:setTextById(901179)
    self.Image_Live2dTalk = TFDirector:getChildByPath(self.Panel_PhoneLive2D,"Image_Live2dTalk"):hide()
    self.Label_talk = TFDirector:getChildByPath(self.Image_Live2dTalk,"Label_talk")
    self.Label_talk:setText("")

    --wifi
    self.Label_Phone_time = TFDirector:getChildByPath(self.Panel_wifi,"Label_Phone_time")

    local LoadingBar_battery = TFDirector:getChildByPath(self.Panel_wifi,"LoadingBar_battery")
    LoadingBar_battery:setPercent(TFDeviceInfo:getBatteryLevel())
    
    --预制
    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.Panel_subfield = TFDirector:getChildByPath(self.Panel_prefab,"Panel_subfield")
    self.Panel_contact_cell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_cell")
    self.leftCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_lcell")
    self.rightCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_rcell")
    self.Panel_optionItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_optionItem")
    self.Panel_award_item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_award_item")
    self.Panel_award_attr = TFDirector:getChildByPath(self.Panel_prefab,"Panel_award_attr")
    self.Panel_outTime = TFDirector:getChildByPath(self.Panel_prefab,"Panel_outTime")
    self.Panel_normalText = TFDirector:getChildByPath(self.Panel_prefab,"Panel_normalText")
    self.Panel_face_item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_face_item")
    self.Panel_voice_lcell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_voice_lcell")
    if CC_TARGET_PLATFORM ~= CC_PLATFORM_ANDROID then
        self.ui:setOpacity(0)
        self.ui:runAction(CCFadeIn:create(0.5))
    end

    self:openPL()
end

function PhoneMainViewAI:openPL()

    local curTime = TFDate(ServerDataMgr:getServerTime()):tolocal()
    local hour,min = curTime:gettime()
    local timeStr = string.format("%02d:%02d",hour,min)
    self.Label_Phone_time:setText(timeStr)

    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            local curTime = TFDate(ServerDataMgr:getServerTime()):tolocal()
            local hour,min = curTime:gettime()
            local timeStr = string.format("%02d:%02d",hour,min)
            self.Label_Phone_time:setText(timeStr)
        end)
    })
    local repeatAct = CCRepeatForever:create(seqact)
    self.Label_Phone_time:runAction(repeatAct)

    if self.clickRole then
        self:showDetailUI(Panel_Type.Chat,"person",self.clickRole)
    else
        self:showDetailUI(Panel_Type.Main)
    end
end

function PhoneMainViewAI:onShow()
    self.super.onShow(self)
end

function PhoneMainViewAI:initData(data)

    local datingRuleId,datingTimeFrame = data.ruleId,data.timeFrame
    -- datingRuleId = 2303003
    -- datingTimeFrame = {"12","0","13","0","17","0","22","0"}
    DatingPhoneDataMgr:initUserLocalData()
    DatingPhoneDataMgr:initUserOldLocalData()
    self.datingRuleId = datingRuleId
    self.datingTimeFrame = datingTimeFrame
    self.clickRole = data.clickRole
    self.timer = 0
    self.totalTime = math.random(2,5)
    self.frameStr = ""
    self.buildName = ""
    --self.datingRuleId 有值代表正处于约会时段
    local ruleCfg = TabDataMgr:getData("DatingRule")[self.datingRuleId]
    if ruleCfg then
        self.enter_condition = ruleCfg.enter_condition
        self.phoneRole = ruleCfg.phoneRole
        self.phoneScript = ruleCfg.phoneScript
        self.startID = ruleCfg.startID
        local cfg = TabDataMgr:getData("DatingRule")[self.phoneScript]
        self.phoneEnd = cfg.phoneEnd
        local buildingCid = self.enter_condition.buildingCid
        local buildInfo = TabDataMgr:getData("NewBuild")[buildingCid]
        self.buildNameId =  buildInfo.nameId

        local buildNameStr = TextDataMgr:getText(self.buildNameId)
        local timeStr = ""
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[1]) .. ":"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[2]) .. "-"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[3]) .. ":"
        timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[4]) .. ""
        self.datingTime = timeStr
        self.chooseTime = self.datingTime
        self.frameStr = buildNameStr.." "..timeStr
        self.buildName = buildNameStr
        local firstTime = string.format("%02d",self.datingTimeFrame[1]) .. ":"..string.format("%02d",self.datingTimeFrame[2])
        --判断是否有第二个时间断
        if self.datingTimeFrame[5] then
            local timeStr = ""
            timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[5]) .. ":"
            timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[6]) .. "-"
            timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[7]) .. ":"
            timeStr = timeStr .. string.format("%02d",self.datingTimeFrame[8]) .. ""
            local lastTime = string.format("%02d",self.datingTimeFrame[7]) .. ":"..string.format("%02d",self.datingTimeFrame[8])
            self.datingTime2 = timeStr
            self.frameStr = buildNameStr.." "..firstTime.."-"..lastTime
        end

        self.phoneAward = {}
        for k,v in pairs(self.phoneEnd) do
            for id,award in pairs(v) do
                self.phoneAward[id] = award
            end
        end
        DatingPhoneDataMgr:saveRoleScript(self.phoneRole,self.datingRuleId)
    end
    self.keyboardHeight = 0
    self.faceEmotionCfg = DatingPhoneDataMgr:getFaceEmotion()
    self.cd = 10


    local itemCost = Utils:getKVP(20008)
    for k,v in pairs(itemCost) do
        self.costItemId = k
        self.costItemNum = v
    end
end

function PhoneMainViewAI:initBuyPL()

    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, self.costItemId)
    Panel_goodsItem:Pos(0,0):AddTo(self.Image_item_frame)

    local cfg = GoodsDataMgr:getItemCfg(self.costItemId)
    if not cfg then
        return
    end

    self.Label_item_name:setTextById(cfg.nameTextId)

    local own = GoodsDataMgr:getItemCount(self.costItemId)
    self.Label_item_owncnt:setText(own)

end

--返回按钮
function PhoneMainViewAI:backPhonePL()

    if not self.curPannelId or self.curPannelId == 1 then
        return
    end
    self.Panel_option_view:setVisible(false)
    local chatItems = self.chatListView:getItems()
    if #chatItems == 0 then
        self.phonePL[self.curPannelId]:setVisible(false)
        self:showDetailUI(Panel_Type.Main)
        return
    end
    local curPhonePL = self.phonePL[self.curPannelId]
    local hideAni = Sequence:create{
        Spawn:create{
            MoveBy:create(0.2,ccp(-600,0)),
            FadeIn:create(0.2)
        },
        CallFunc:create(function ()
            curPhonePL:setVisible(false)
            local curPosX = curPhonePL:getPositionX()
            curPhonePL:setPositionX(curPosX+600)
            self:showDetailUI(Panel_Type.Main)
        end)
    }
    self.phonePL[self.curPannelId]:runAction(hideAni)
    self:setInputText("")
    self.originalInputText = ""
    self.tf_input:setText("")
    self.tf_input:closeIME()
    self.Label_tip:setVisible(true)
end

function PhoneMainViewAI:showDetailUI(typeId,chatType,roleId,outTimeRuleId)

    self.Panel_input_view:setVisible(false)
    local pageNameId = ""
    if typeId == Panel_Type.Main then
        self:updateGroupInfo()
        --self.Panel_input_view:setVisible(false)
        self.Label_pageName:setTextById(304019)
    elseif typeId == Panel_Type.Chat then
        self.Label_pageName:setTextById(304020)
        self.chatListView:removeAllItems()
        self.chatListView:setContentSize(CCSizeMake(640,self.contactPLsize))
        self.chatListView:jumpToBottom()
        if chatType == "person" then
            --处于过期约会或者约会状态
            if outTimeRuleId or self.phoneRole then

                --表示在约会时段阶段
                if self.datingRuleId and roleId == self.phoneRole then
                    self.isAiChat = false
                    self:initChatInfo(roleId,outTimeRuleId)
                    self:showDationInfo(self.startID)
                else
                    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(roleId)
                    if roleInfo and roleInfo.openAI then
                        self.Label_pageName:setTextById(roleInfo.nameId)
                        -- 屏蔽聊天
                        -- self:showDialogeAI(roleId)
                    end
                end
            else
                local roleInfo = DatingPhoneDataMgr:getRoleInfoById(roleId)
                if roleInfo and roleInfo.openAI then
                    self.Label_pageName:setTextById(roleInfo.nameId)
                    -- self:showDialogeAI(roleId)
                end
            end
        else
            self.chatListView:removeAllItems()
        end
    end

    if self.curPannelId then
        self.phonePL[self.curPannelId]:setVisible(false)
    end

    self.curPannelId = typeId
    self.phonePL[typeId]:setVisible(true)
    self.Button_back:setVisible(typeId ~= Panel_Type.Main)
end

--联系人列表
function PhoneMainViewAI:updateGroupInfo()

    self.contactsListView:removeAllItems()
    --[[local head = self.Panel_subfield:clone()
    head:setVisible(true)
    local headNameTx = head:getChildByName("Label_title")
    headNameTx:setTextById(304021)
    local Image_symbol = head:getChildByName("Image_symbol")
    Image_symbol:setTexture("ui/iphoneX/new/005.png")
    self.contactsListView:pushBackCustomItem(head)

    local groupCfg = DatingPhoneDataMgr:getGroupCfg()
    for k,v in ipairs(groupCfg) do
        if v.open then

            local groupItem = self.Panel_contact_cell:clone()
            groupItem:setVisible(true)
            local Image_new = TFDirector:getChildByPath(groupItem,"Image_new")
            Image_new:setVisible(false)
            local Image_newDating = TFDirector:getChildByPath(groupItem,"Image_newDating")
            Image_newDating:setVisible(false)
            local Image_head_bord = TFDirector:getChildByPath(groupItem,"Image_head_bord")
            Image_head_bord:setTexture("ui/iphoneX/new/007.png")
            self:setGroupItemInfo(groupItem,v,tipRoleId)
            self.contactsListView:pushBackCustomItem(groupItem)
            groupItem:onClick(function()
                self:showDetailUI(2,"group")
            end)
        end
    end]]

    local head = self.Panel_subfield:clone()
    head:setVisible(true)
    local headNameTx = head:getChildByName("Label_title")
    headNameTx:setTextById(901178)
    local Image_symbol = head:getChildByName("Image_symbol")
    Image_symbol:setTexture("ui/iphoneX/new/008.png")
    self.contactsListView:pushBackCustomItem(head)

    local friendCfg = DatingPhoneDataMgr:getFriendCfg()
    for k,v in ipairs(friendCfg) do
        if v.open then
            local roleId = v.openType["roleCids"][1]
            local isHave = RoleDataMgr:getIsHave(roleId)
            if isHave then

                local chatRoleItem = self.Panel_contact_cell:clone()
                chatRoleItem:setVisible(true)

                local Image_head_bord = TFDirector:getChildByPath(chatRoleItem,"Image_head_bord")
                Image_head_bord:setTexture("ui/iphoneX/new/010.png")

                --约会提示
                local Image_new = TFDirector:getChildByPath(chatRoleItem,"Image_new")
                Image_new:setVisible(roleId == self.phoneRole)

                -- (屏蔽)
                -- local isUsed = DatingPhoneDataMgr:isUsedPhoneAi()
                -- if not isUsed and roleId == 101 then
                --     Image_new:setVisible(true)
                -- end

                ---ai 打招呼 (屏蔽)
                -- local messageRoleId = DatingPhoneDataMgr:getMessageRoleId()
                -- if messageRoleId == roleId then
                --     Image_new:setVisible(true)
                -- end

                --接受约会
                local Image_newDating = TFDirector:getChildByPath(chatRoleItem,"Image_newDating")
                local isAccept = DatingDataMgr:isAcceptPhoneRole(roleId)
                --Image_newDating:setVisible(tobool(isAccept))
                Image_newDating:setVisible(false)

                --过期约会提示
                local outTimeRuleId = DatingPhoneDataMgr:getOutTimePhoneRuleId(roleId)
                if outTimeRuleId then
                    --Image_new:setVisible(true)
                end

                self:setGroupItemInfo(chatRoleItem,v)
                self.contactsListView:pushBackCustomItem(chatRoleItem)
                chatRoleItem:onClick(function()
                    --清空过期约会提示
                    DatingPhoneDataMgr:saveOutTimePhoneRuleId(roleId,"")
                    self:removeCountDownTimer()
                    if roleId == self.phoneRole then
                        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.PHONE_SCRIPT,self.phoneRole,nil,self.phoneScript,nil,nil)
                    else
                        self:showDetailUI(Panel_Type.Chat,"person",roleId,outTimeRuleId)
                    end
                end)
            end
        end
    end
end

function PhoneMainViewAI:setGroupItemInfo(item,info,tipRoleId)

    if not info then
        return
    end
    local Image_head = TFDirector:getChildByPath(item,"Image_head")
    Image_head:setTexture(info.icon)
    local Label_name = TFDirector:getChildByPath(item,"Label_title")
    Label_name:setTextById(info.nameId)

end

--初始本地聊天记录
function PhoneMainViewAI:initChatInfo(roleId,outTimeRuleId)

    local ruleId = self.datingRuleId or outTimeRuleId
    self.chatListView:removeAllItems()
    if roleId ~= self.phoneRole  then
        ruleId = DatingPhoneDataMgr:getRoleScript(roleId)
    end

    local datingRule = TabDataMgr:getData("DatingRule")[ruleId]
    if not datingRule then
        return
    end

    DatingPhoneDataMgr:setDatingScript(datingRule.callTableName)

    --old记录
    local userOldDatingInfo = DatingPhoneDataMgr:getDaingUserOldInfo(ruleId)
    for k,v in ipairs(userOldDatingInfo) do
        local saveType = tonumber(v.saveType)
        local content = v.content
        if saveType == Enum_PhoneSaveType.SaveType_DaingId then
            local datingId = tonumber(content)
            local datingInfo = DatingPhoneDataMgr:getDatingCfgById(datingId)
            if datingInfo then
                self:updateChatItemInfo(datingInfo)
            end
        elseif saveType == Enum_PhoneSaveType.SaveType_Award then
            self:updateOutTimeAward(content)
        elseif saveType == Enum_PhoneSaveType.SaveType_OutTime then
            self:updateOutTimeText(ruleId,content)
        elseif saveType == Enum_PhoneSaveType.SaveType_DatingInfo then
            self:updateDatingPlace(content)
        end
    end

    local isPlayed = false
    local userDatingInfo = DatingPhoneDataMgr:getDaingUserInfo(ruleId)
    for k,v in ipairs(userDatingInfo) do
        local saveType = tonumber(v.saveType)
        local content = v.content
        if saveType == Enum_PhoneSaveType.SaveType_DaingId then
            local datingId = tonumber(content)
            local datingInfo = DatingPhoneDataMgr:getDatingCfgById(datingId)
            if datingInfo then
                self:updateChatItemInfo(datingInfo)
                lastDaingId = datingId
                if not isPlayed then
                    if self.startID == datingId then
                        isPlayed = true
                    end
                end
            end
        elseif saveType == Enum_PhoneSaveType.SaveType_Award then
            self:updateOutTimeAward(content)
        elseif saveType == Enum_PhoneSaveType.SaveType_OutTime then
            self:updateOutTimeText(ruleId,content)
        elseif saveType == Enum_PhoneSaveType.SaveType_DatingInfo then
            self:updateDatingPlace(content)
        end
    end

    self.chatListView:jumpToBottom()
    if isPlayed then
        self.startID = lastDaingId or self.startID
        local datingInfo = DatingPhoneDataMgr:getDatingCfgById(self.startID)
        if datingInfo then
            local jump = datingInfo.jump
            if #jump == 1 then
                self.startID = jump[1]
            end
        end
    end
end

--选项界面
function PhoneMainViewAI:updateOptionListInfo(jumpInfo)

    --说明剧情结束
    if not next(jumpInfo) then
        return
    end
    self.optionListView:removeAllItems()
    for k,v in ipairs(jumpInfo) do

        local datingId = v
        local optionItem = self.Panel_optionItem:clone()
        optionItem:setVisible(true)
        local TextArea_option = optionItem:getChildByName("TextArea_option")
        local datingInfo = DatingPhoneDataMgr:getDatingCfgById(datingId)
        if datingInfo then

            if self.datingTime2 then
                if k==1 then
                    TextArea_option:setText(self.datingTime.." "..datingInfo.text)
                elseif k==2 then
                    TextArea_option:setText(self.datingTime2.." "..datingInfo.text)
                else
                    TextArea_option:setText(datingInfo.text)
                end
            else
                TextArea_option:setText(datingInfo.text)
            end
        end
        self.optionListView:pushBackCustomItem(optionItem)
        optionItem:onClick(function()
            if k== 2 and  self.datingTime2 then
                self.chooseTime = self.datingTime2
            end
            self:removeCountDownTimer()
            self.Panel_option_view:setVisible(false)
            self.chatListView:setContentSize(CCSizeMake(640,self.contactPLsize))
            self.chatListView:jumpToBottom()
            DatingDataMgr:sendDialogueMsg(self.curDatingId, datingId, EC_DatingScriptType.PHONE_SCRIPT, self.phoneRole)
            self:showDationInfo(datingId)
        end)
    end
end

function PhoneMainViewAI:showDationInfo(datingId)

    --ai聊天点击无响应
    if self.isAiChat then
        return
    end

    local datingInfo = DatingPhoneDataMgr:getDatingCfgById(datingId)
    if not datingInfo then
        self:updateDaingText("wrong datingId:"..tostring(datingId))
        return
    end

    local jumpInfo = datingInfo.jump

    self:updateChatInfo(datingInfo,jumpInfo)
    self.curDatingId =  datingId

    --是否是最后的剧情
    if not next(jumpInfo) then
        local isUserDating = DatingPhoneDataMgr:isDatingUserInfo(self.datingRuleId,datingId)
        if isUserDating then
            return
        end
        self.lastDatingId = datingId
        DatingDataMgr:sendDialogueMsg(self.curDatingId, nil, EC_DatingScriptType.PHONE_SCRIPT, self.phoneRole)
        return
    end

    self:addCountDownTimer()

    --跳转面板
    if #jumpInfo == 1 then
        self.nextDatingId = jumpInfo[1]
        self.Panel_option_view:setVisible(false)
        self.Panel_chat_view:setTouchEnabled(true)
    else

        self:removeCountDownTimer()
        self.chatListView:setContentSize(CCSizeMake(640,self.contactPLsize - 550))
        self.chatListView:jumpToBottom()

        self.Label_frameTime:setText(self.frameStr)
        self.Panel_option_view:setVisible(true)
        self:updateOptionListInfo(datingInfo.jump)
        self.Panel_chat_view:setTouchEnabled(false)
    end
end

-----计时器-----
function PhoneMainViewAI:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function PhoneMainViewAI:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function PhoneMainViewAI:removeEvents()
    self:removeCountDownTimer()
end

function PhoneMainViewAI:onCountDownPer()

    if not self.nextDatingId then
        return
    end
    self.timer = self.timer + 1
    if self.timer >= self.totalTime then
        local datingInfo = DatingPhoneDataMgr:getDatingCfgById(self.nextDatingId)
        if datingInfo and datingInfo.headIcon ~= "1" then
            self:showDationInfo(self.nextDatingId)
            self.timer = 0
            self.totalTime = math.random(2,5)
        end
    end
end

----聊天历史Item
function PhoneMainViewAI:updateChatItemInfo(datingInfo)

    local headIcon = datingInfo.headIcon
    local cell = headIcon ~= "1" and self.leftCell:clone() or self.rightCell:clone()
    cell:setVisible(true)
    local ClippingNode_player = TFDirector:getChildByPath(cell,"ClippingNode_player")
    ClippingNode_player:setVisible(headIcon ~= "1")
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if headIcon ~= "1" then
        Image_head:setTexture(headIcon)
    end

    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg")
    local textStr =  string.gsub(datingInfo.text, "%%s", MainPlayer:getPlayerName())
    TextArea_msg:setText(textStr)
    TextArea_msg:setDimensions(360, 0)
    local size = TextArea_msg:getContentSize()
    local newHight = size.height < 110 and 110 or (size.height + 10)
    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    Image_msg:setContentSize(CCSizeMake(420, newHight+20))
    cell:setContentSize(CCSizeMake(606,newHight+20))
    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()
end

----过期约会的奖励显示
function PhoneMainViewAI:updateOutTimeAward(awardContent)
    if not awardContent then
        return
    end
    local awardTab = string.split(awardContent,"~")
    for k,singleAward in ipairs(awardTab) do
        local singleInfo = string.split(singleAward,",")
        if #singleInfo == 2 then
            local awardId,awardNum = tonumber(singleInfo[1]),tonumber(singleInfo[2])
            if awardId == 500007 or awardId == 500008 then
                self:updateDaingAttr(awardId,awardNum)
            end
        end
    end
end

----更新属性显示
function PhoneMainViewAI:updateDaingAttr(itemId,itemNum)

    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    if not itemCfg then
        return
    end

    local cloneItem = self.Panel_award_attr:clone()

    local TextArea_name = cloneItem:getChildByName("TextArea_name")
    TextArea_name:setTextById(itemCfg.nameTextId)

    local Image_icon = cloneItem:getChildByName("Image_icon")
    local res = itemId == 500007 and "ui/iphoneX/face.png" or "ui/iphoneX/heart.png"
    Image_icon:setTexture(res)

    local TextArea_value = cloneItem:getChildByName("TextArea_value")
    TextArea_value:setSkewX(15)
    TextArea_value:setText(itemNum)

    self.chatListView:pushBackCustomItem(cloneItem)
end

function PhoneMainViewAI:updateDaingText(text)

    local cloneItem = self.Panel_outTime:clone()
    local TextArea_name = cloneItem:getChildByName("TextArea_name")
    TextArea_name:setString(text)

    self.chatListView:pushBackCustomItem(cloneItem)
end

----过期约会时间显示
function PhoneMainViewAI:updateOutTimeText(datingRuleId,outTime)

    if not outTime then
        return
    end

    local ruleCfg = TabDataMgr:getData("DatingRule")[datingRuleId]
    if not ruleCfg then
        return
    end
    local phoneRole = ruleCfg.phoneRole
    local name = ""
    local phoneBaseCfg = DatingPhoneDataMgr:getPhoneBaseCfg(phoneRole)
    if phoneBaseCfg then
        name = TextDataMgr:getText(phoneBaseCfg.nameId)
    end

    local timeData = Utils:getTimeData(outTime)
    local hour, min, sec = Utils:getTime(outTime, true)
    local timeStr = timeData.Year.."-"..string.format("%.2d", timeData.Month).."-"..string.format("%.2d", timeData.Day).." "
    timeStr = timeStr..string.format("%.2d", timeData.Hour)..":"..string.format("%.2d", timeData.Minute)..":"..string.format("%.2d", timeData.Second)

    local cfg = TabDataMgr:getData("DatingRule")[ruleCfg.phoneScript]

    local outTimeStr = TextDataMgr:getText(cfg.missDating, timeStr, name)

    self:updateDaingText(outTimeStr)
end

----刷新约会地点
function PhoneMainViewAI:updateDatingPlace(placeInfo)

    if not placeInfo then
        return
    end
    local singleInfo = string.split(placeInfo,",")
    if #singleInfo ~= 2 then
        return
    end
    local buildNameId,timeframeStr = tonumber(singleInfo[1]),singleInfo[2]
    local buildNameStr = TextDataMgr:getText(buildNameId)
    self:updateNormalText(buildNameStr.." "..timeframeStr)
end

function PhoneMainViewAI:updateNormalText(text)

    local cloneItem = self.Panel_normalText:clone()
    local TextArea_name = cloneItem:getChildByName("Label_text")
    TextArea_name:setString(text)
    self.chatListView:pushBackCustomItem(cloneItem)
end

----更新约会中的聊天列表
function PhoneMainViewAI:updateChatInfo(datingInfo,jumpInfo)

    if not datingInfo then
        return
    end

    local isUserDating = DatingPhoneDataMgr:isDatingUserInfo(self.datingRuleId,datingInfo.id)
    if isUserDating then
        return
    end

    local headIcon = datingInfo.headIcon
    local cell = headIcon ~= "1" and self.leftCell:clone() or self.rightCell:clone()
    cell:setVisible(true)
    local ClippingNode_player = TFDirector:getChildByPath(cell,"ClippingNode_player")
    ClippingNode_player:setVisible(headIcon ~= "1")
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if headIcon ~= "1" then
        Image_head:setTexture(headIcon)
    end
    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg")
    local textStr =  string.gsub(datingInfo.text, "%%s", MainPlayer:getPlayerName())
    TextArea_msg:setText(textStr)
    TextArea_msg:setDimensions(360, 0)
    local size = TextArea_msg:getContentSize()
    local newHight = size.height < 110 and 110 or (size.height + 10)
    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    Image_msg:setContentSize(CCSizeMake(420, newHight+20))
    cell:setContentSize(CCSizeMake(606,newHight+20))
    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()

    if next(jumpInfo) then
        DatingPhoneDataMgr:addDatingInfo(self.datingRuleId,datingInfo.id)
    end

end

----机器人对话
function PhoneMainViewAI:showDialogeAI(roleId)

    local isUsed = DatingPhoneDataMgr:isUsedPhoneAi()
    if  not isUsed then
        local helloStr = TextDataMgr:getText(901177)
        helloStr = "2"..helloStr
        DatingPhoneDataMgr:insertDialogue(roleId,helloStr)
        DatingPhoneDataMgr:setUsedAi()
    end

    local messageRoleId = DatingPhoneDataMgr:getMessageRoleId()
    if messageRoleId and messageRoleId == roleId then
        DatingPhoneDataMgr:Send_ClearAiMessageRedPoint()
    end

    self.isAiChat = true
    self:removeCountDownTimer()
    self.timer = 0

    ---显示表情
    self:showExpressionPL()
    self:hideFacePL(0,true)
    self.dialogeRoleId = roleId
    self:createLive2d()
    self.chatListView:removeAllItems()
    local localDialogue = DatingPhoneDataMgr:getLocalDialogue()
    if not localDialogue then
        return
    end

    local dialogue = localDialogue[roleId]
    if not dialogue then
        return
    end

    for k,v in ipairs(dialogue) do
        local dialogueStr = string.sub(v,2,-1)
        local identityId  = tonumber(v[1])
        if identityId == 0 then
            self:updateVoice(false,dialogueStr,false,true)
        else
            dialogueStr = self:transformDigueStr(dialogueStr)
            self:updateDialogue(tonumber(identityId) == 1,dialogueStr)
        end

    end
    self.chatListView:jumpToBottom()

end

function PhoneMainViewAI:showExpressionPL()
    self.expressionListView:removeAllItems()
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    local maxHorizatal = math.ceil(#faceCfg/7)
    for i=1,maxHorizatal do
        self.faceItem = self.Panel_face_item:clone()
        self.expressionListView:pushBackCustomItem(self.faceItem)
        for j=1,7 do
            local btnFace = self.faceItem:getChildByName("Button_face_"..j)
            local faceIcon  = btnFace:getChildByName("icon_face")
            local faceId = (i-1)*7+j
            local faceInfo = faceCfg[faceId]
            if not faceInfo then
                btnFace:setVisible(false)
            else
                btnFace:setVisible(true)
                faceIcon:setTexture(faceInfo.motion)
                btnFace:onClick(function()
                    self:insertFace(faceInfo.sourcecode)
                end)
            end
        end
    end
end

----AI语音
function PhoneMainViewAI:updateVoice(isSelf,fileName,isNew,isPlayed)

    if not fileName or fileName == "" then
        return
    end

    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(self.dialogeRoleId)
    local headIcon = roleInfo.icon
    local cell = isSelf and self.Panel_voice_lcell:clone() or self.Panel_voice_lcell:clone()
    cell:setVisible(true)
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if not isSelf then
        Image_head:setTexture(headIcon)
    end

    local Image_voice_flag = TFDirector:getChildByPath(cell,"Image_voice_flag")
    Image_voice_flag:setVisible(not isPlayed)

    local Label_voice_time = TFDirector:getChildByPath(cell,"Label_voice_time")
    Label_voice_time:setVisible(false)

    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    Image_msg:onClick(function ()
        local voiceInfo =  DatingPhoneDataMgr:getVoiceByName(fileName)
        if voiceInfo then
            Image_voice_flag:setVisible(false)
            self.voiceHandle = TFAudio.playSound(voiceInfo.conversionvoice)
        end
    end)

    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()

    if isNew then
        local savefileName = EC_PhoneSaveType.voice..fileName
        DatingPhoneDataMgr:insertDialogue(self.dialogeRoleId,savefileName)
    end
end

----AI对话
function PhoneMainViewAI:updateDialogue(isSelf,dialogueStr,isNew)

    if not dialogueStr or dialogueStr == "" then
        return
    end
    dump(dialogueStr)
    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(self.dialogeRoleId)
    local headIcon = roleInfo.icon
    local cell = isSelf and self.rightCell:clone() or self.leftCell:clone()
    cell:setVisible(true)
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if not isSelf then
        Image_head:setTexture(headIcon)

        Image_head:setTouchEnabled(true)
        Image_head:onClick(function()
            Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
            Utils:openView("datingPhone.SceondAIChatView",self.dialogeRoleId, true)
        end)

    end

    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg"):hide()
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    local inputText = dialogueStr
    dump(dialogueStr)
    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.specialcode,v.convermotion)
    end
    dump(inputText)
    inputText = string.gsub(inputText, "\n", "<br/>")

    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    local rightText = TFRichText:create(ccs(442, 0))

    local pos = isSelf and ccp(-10,-12) or ccp(10,-12)
    if isSelf then
        rightText:AnchorPoint(me.p(1, 1))
    else
        rightText:AnchorPoint(me.p(0, 1))
    end
    rightText:setPosition(pos)
    rightText:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301005"),inputText))
    Image_msg:addChild(rightText)

    local size = rightText:getSize()
    dump(size)
    local newHight = size.height <= 34 and 34 or size.height
    Image_msg:setContentSize(CCSizeMake(size.width+20, newHight+24))
    cell:setContentSize(CCSizeMake(606,newHight+34))
    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()

    if isNew then
        if isSelf then
            dialogueStr = EC_PhoneSaveType.oneself..dialogueStr
        else
            dialogueStr = EC_PhoneSaveType.robot..dialogueStr
        end
        DatingPhoneDataMgr:insertDialogue(self.dialogeRoleId,dialogueStr)
    end
end

--语音聊天
function PhoneMainViewAI:updateRecVoice(emotionState,msg)
    --emotionState:表情ID
    self.Image_Live2dTalk:setVisible(true)
    local btnPosX = self.Button_voice:getPositionX()
    self.Label_talk:setText(msg)
    self.Label_talk:setDimensions(480, 0)
    local size = self.Label_talk:getContentSize()
    self.Image_Live2dTalk:setContentSize(CCSizeMake(500, size.height+20))
    self.Image_Live2dTalk:setPositionX(btnPosX - 50 - (size.height+20))

    self:updateLive2dAction(emotionState)
end

function PhoneMainViewAI:onTouchSendBtn()

    self.tf_input:setText("")
    self.Label_tip:setVisible(true)
    if self.originalInputText and #self.originalInputText > 0 then
        DatingPhoneDataMgr:sendAiDialogue(EC_PhoneChatType.Normal, self.originalInputText, self.dialogeRoleId)
        self.tf_input:setText("")
        self:setInputText("")
        self.originalInputText = ""
        --self:sendBtnCd()

        self.Image_textbg:setContentSize(CCSize(422,62))
        self.Image_input_bg:setContentSize(CCSize(640,100))
        --self.Panel_input_view:setContentSize(CCSize(640,488))
        self:setChatListViewSize()
    else
        local str = TextDataMgr:getText(800104)
        --toastMessage(str,ccp(self.winSize.width/2,self.winSize.height/2))
        Utils:showTips(800104)
    end
end

function PhoneMainViewAI:insertFace(faceStr)
    self.Label_tip:setVisible(false)
    local newInputStr = faceStr
    dump(self.originalInputText)
    if self.originalInputText then
        newInputStr = self.originalInputText..faceStr
    end
    self:setInputText(newInputStr)

end

function PhoneMainViewAI:setInputText(inputText)

    print(inputText)
    local maxHeight = 180
    if not self.richInput then
        self.richInput = TFRichText:create(ccs(405, 32))
        self.richInput:AnchorPoint(me.p(0, 0))
        --self.richInput:setPosition(ccp(-200,0))
        self.ListView_input:pushBackCustomItem(self.richInput)
    end

    self.originalInputText = inputText
    self.tf_input:setText(self.originalInputText)
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.conversioncode,v.convermotion)
    end
    self.richInput:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301005"),inputText))

    local size = self.richInput:getSize()
    local newWidth = size.width
    local newHeight = size.height
    if newWidth < 400 then
        newWidth = 400
    end

    local richTextPosX = 2
    if newHeight < 52 then
        newHeight = 52
        richTextPosX = 5
    else
        newHeight = size.height+40
    end

    if newHeight > maxHeight then
        newHeight = maxHeight
    end
    print(self.richInput:getPositionX())
    self.ListView_input:setContentSize(CCSize(newWidth+20,newHeight))
    self.Panel_inputMask:setContentSize(CCSize(newWidth+20,newHeight+10))
    self.Image_textbg:setContentSize(CCSize(newWidth+20,newHeight+10))
    self.Image_input_bg:setContentSize(CCSize(640,newHeight + 40))

    self.ListView_input:doLayout()
    self.ListView_input:jumpToBottom()
    self.richInput:setPositionX(richTextPosX)
    print(self.richInput:getPositionX())
    --self.Panel_input_view:setContentSize(CCSize(640,newHeight + 40 + 388))
    self:setChatListViewSize()
end

--发送按钮cd
function PhoneMainViewAI:sendBtnCd()

    self.tick = 0
    self.Button_send:setTouchEnabled(false)
    self.Button_send:setGrayEnabled(true)
    self.Label_cd:setText(self.cd)
    self.Button_send:setTextureNormal("ui/iphoneX/new/039.png")
    local seqact = Sequence:create({
        DelayTime:create(1),
        CallFunc:create(function()
            self.tick = self.tick + 1
            local coolTime = self.cd-self.tick
            self.Label_cd:setText(coolTime)
            if coolTime <= 0 then
                self.Button_send:setTouchEnabled(true)
                self.Button_send:setGrayEnabled(false)
                self.Label_cd:stopAllActions()
                self.Label_cd:setText("")
                self.Button_send:setTextureNormal("ui/iphoneX/new/038.png")
            end
        end)
    })
    self.Label_cd:runAction(CCRepeatForever:create(seqact))
end

--显示live2d界面
function PhoneMainViewAI:showLive2dView()

    self.Panel_PhoneLive2D:setVisible(true)
    self.Image_Live2dTalk:setVisible(false)
    local roleInfo = DatingPhoneDataMgr:getRoleInfoById(self.dialogeRoleId)
    self.Label_Live2DName:setTextById(roleInfo.nameId)

    EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)
    --self.Image_live2D:setVisible(true)
    self:timeOut(function ()
        self.Image_live2D:setVisible(true)
    end,0.2)

end

function PhoneMainViewAI:createLive2d()

    local modelId = RoleDataMgr:getModel(self.dialogeRoleId)
    if not modelId then
        Box("wrong modelId")
    end
    if self.elvesNpc then
        pos = self.elvesNpc:getPosition();
        self.elvesNpc:removeFromParent();
        self.elvesNpc = nil;
    end

    self.roleEmotionInfo = DatingPhoneDataMgr:getRoleEmotionInfo(modelId)
    if not self.roleEmotionInfo then
        return
    end

    local showModelId = self.roleEmotionInfo.ModelId
    self.elvesNpc = ElvesNpcTable:createLive2dNpcID(showModelId).live2d

    self.elvesNpc:registerEvents()

    self.elvesNpc:setScale(0.3); --缩放
    self.Image_live2D:addChild(self.elvesNpc)
    self.Image_live2D:setVisible(false)
    self.elvesNpc:setPosition(ccp(0,-150));--位置
    --self.elvesNpc:newStartAction("id_idle",EC_PRIORITY.FORCE)
end

function PhoneMainViewAI:updateLive2dAction(emotionState)

    local actIds = self.roleEmotionInfo["emotions"..emotionState]
    if not actIds then
        Box("can't find emotions"..emotionState)
        return
    end

    local actIndex = math.random(1,#actIds)
    local actName = DatingPhoneDataMgr:getEmotionActionName(actIds[actIndex],self.roleEmotionInfo.ModelId)
    if not actName then
        return
    end
    self.elvesNpc:newStartAction(actName,EC_PRIORITY.NORMAL)--,2,"id_idle",1)
end

function PhoneMainViewAI:continueAction()

    self.Label_voice:setText("Loading")
    local cnt = 0
    local function action(dt)
        cnt = cnt + 0.1
        self.LoadingBar_voice:setPercent(math.floor(cnt/100*100))
    end
    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function PhoneMainViewAI:showFacePL(keyboardHeight,init)

    if keyboardHeight and keyboardHeight > 0 then
        self.realPLHeight = self.hideFacePosY + keyboardHeight
    else
        self.realPLHeight = self.showFacePosY
    end
    self.isShowFacePL = true
    if init then
        self.Panel_input_view:setPositionY(self.realPLHeight)
        self:setChatListViewSize()
    else
        self.Panel_input_view:runAction(CCMoveTo:create(0.15,ccp(0,self.realPLHeight)))
        self:setChatListViewSize()
    end
end

function PhoneMainViewAI:hideFacePL(keyboardHeight,init)

    dump(self.realPLHeight)
    self.realPLHeight = self.hideFacePosY
    self.isShowFacePL = false
    if init then
        self.Panel_input_view:setPositionY(self.realPLHeight)
        self:setChatListViewSize()
    else
        local action = Sequence:create({
            CCMoveTo:create(0.15,ccp(0,self.realPLHeight)),
            CallFunc:create(function()
                self:setChatListViewSize()
            end)
        })
        self.Panel_input_view:runAction(action)
    end
end

function PhoneMainViewAI:setChatListViewSize()
    dump(self.realPLHeight)
    local h = self.realPLHeight - (self.centerPos.y - self.winSize.height/2)
    local posY = h - 100
    local height = self.Image_input_bg:getContentSize().height + posY
    self.chatListView:setContentSize(CCSizeMake(640, self.contactPLsize - height ))
    self.chatListView:jumpToBottom()
    self.chatListView:doLayout()
end

---------------------------------------------反馈消息--------------------------------
function PhoneMainViewAI:afterGetScript()
    self:showDetailUI(Panel_Type.Chat,"person",self.phoneRole)
end

----完成约会
function PhoneMainViewAI:onCompletePhoneDating(accept)
    if self.lastDatingId then
        local datingInfo = DatingPhoneDataMgr:getDatingCfgById(self.lastDatingId)
        if datingInfo then
            DatingPhoneDataMgr:addDatingInfo(self.datingRuleId,datingInfo.id)
        end
    end

    if self.chooseTime and self.buildNameId then
        local str = self.buildNameId..","..self.chooseTime
        DatingPhoneDataMgr:addDatingInfo(self.datingRuleId,str,Enum_PhoneSaveType.SaveType_DatingInfo)
    end

    DatingPhoneDataMgr:saveLocalData()
    DatingPhoneDataMgr:addNewDating(self.datingRuleId)
    self:updateNormalText(self.buildName.." "..self.chooseTime)
    self.datingRuleId = nil
    self.phoneRole = nil
    self.chatListView:jumpToBottom()
end

----
function PhoneMainViewAI:onShowPhoneAward(flag,ruleId,award)

    if flag then
        return
    end

    if not award then
        return
    end

    for k,v in pairs(award) do

        if v.id == 500007 or v.id == 500008 then
            self:updateDaingAttr(v.id,v.num)
        end
    end
    self.chatListView:jumpToBottom()
    self.Panel_option_view:setVisible(false)
end

----发送消息的确认
function PhoneMainViewAI:onSendDialogue(data)

    if not data then
        return
    end
    dump(data)
    if data.datingType ~= 1 then
        return
    end
    local chatMsg = self:transformDigueStr(data.msg)
    self:updateDialogue(true,chatMsg,true)
end

----返回机器人对话
function PhoneMainViewAI:onRecvRobotDialogue(data)

    if not data then
        return
    end
    dump(data)

    self:timeOut(function()
        self:showRobotDialogue(data)
    end,1.5)
end

function PhoneMainViewAI:showRobotDialogue(data)
    dump(data)
    if not data.returnMsg then
        return
    end

    DatingPhoneDataMgr:setHeroForbidState(data.roleId,data.sealState)
    if data.type == EC_PhoneChatType.Normal then
        local contentStr = {}
        for k,jsonMessage in ipairs(data.returnMsg) do
            local message = json.decode(jsonMessage)
            local messageContent = self:transformDigueStr(message.content)
            local content = string.htmlspecialchars(messageContent)
            dump(content)
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
            dump(content)
            --[[语音分条显示
            if fileName ~= "" then
                table.insert(contentStr,{content = content,type = EC_PhoneContentType.Normal,fileName = ""})
                table.insert(contentStr,{content = content,type = EC_PhoneContentType.Voice,fileName = fileName})
            else
                table.insert(contentStr,{content = content,type = EC_PhoneContentType.Normal,fileName = fileName})
            end]]
            table.insert(contentStr,{content = content,type = EC_PhoneContentType.Normal,fileName = fileName})
        end

        local contentId = 1
        if contentStr[contentId].type ==  EC_PhoneContentType.Normal then
            local voiceInfo =  DatingPhoneDataMgr:getVoiceByName(contentStr[contentId].fileName)
            if voiceInfo then
                self.voiceHandle = TFAudio.playSound(voiceInfo.conversionvoice)
            end
            self:updateDialogue(false,contentStr[contentId].content,true)
        elseif contentStr[contentId].type ==  EC_PhoneContentType.Voice then
            self:updateVoice(false,contentStr[contentId].fileName,true,false)
        end

        if #contentStr > 1 then
            local seqact = Sequence:create({
                DelayTime:create(1.5),
                CallFunc:create(function()
                    contentId = contentId + 1

                    if contentStr[contentId].type ==  EC_PhoneContentType.Normal then
                        local voiceInfo =  DatingPhoneDataMgr:getVoiceByName(contentStr[contentId].fileName)
                        if voiceInfo then
                            self.voiceHandle = TFAudio.playSound(voiceInfo.conversionvoice)
                        end
                        self:updateDialogue(false,contentStr[contentId].content,true)
                    elseif contentStr[contentId].type ==  EC_PhoneContentType.Voice then
                        self:updateVoice(false,contentStr[contentId].fileName,true,false)
                    end

                    if contentId >= #contentStr then
                        self.Panel_PhoneMain:stopAllActions()
                    end
                end)
            })
            self.Panel_PhoneMain:runAction(CCRepeatForever:create(seqact))
        end

    elseif data.type == EC_PhoneChatType.Voice then
        for k,newMessage in ipairs(data.returnMsg) do
            --暂时屏蔽
            --self:updateRecVoice(data.state,newMessage)
        end
    end
end

----语音SDK反馈
function PhoneMainViewAI:onRecvVoiceSdk(msg)
    dump(msg)
    self.Label_robot:setText(msg)
    local pos = self.Label_robot:getPosition()
    local size = self.Label_robot:getContentSize()
    local speed = 100
    if size.width > 340 then
        local moveDis = size.width
        local act = Sequence:create {
            MoveTo:create(moveDis/speed, ccp(pos.x - moveDis, pos.y)),
            CallFunc:create(function()
                self.Label_robot:setVisible(false)
                self.Label_robot:setPositionX(pos.x)
            end)
        }
        self.Label_robot:runAction(CCRepeatForever:create(act))
    end
    if self.dialogeRoleId then
        DatingPhoneDataMgr:sendAiDialogue(EC_PhoneChatType.Voice, msg, self.dialogeRoleId)
    end
end

function PhoneMainViewAI:transformDigueStr(inputStr)

    for k,v in ipairs(self.faceEmotionCfg) do
        inputStr = string.gsub(inputStr,v.conversioncode,v.specialcode)
    end

    return inputStr
end

function PhoneMainViewAI:onRecvKeyBoard(keyboardHeight)

    self.keyboardHeight = keyboardHeight
    self.Panel_input_view:stopAllActions()
    if keyboardHeight > 0 then
        self.Button_face:setVisible(false)
        self:showFacePL(keyboardHeight)
    else
        self.Button_face:setVisible(true)
        self:hideFacePL(keyboardHeight)
    end

end

function PhoneMainViewAI:onRecveRelieveForbid(roleId)

    if not roleId then
        return
    end
    local phoneBaseCfg = DatingPhoneDataMgr:getPhoneBaseCfg(phoneRole)
    if phoneBaseCfg then
        name = TextDataMgr:getText(phoneBaseCfg.nameId)
    end
    local roleInfo = DatingPhoneDataMgr:getPhoneBaseCfg(roleId)
    if not roleInfo then
        return
    end
    local nameStr = TextDataMgr:getText(roleInfo.nameId)
    local str = TextDataMgr:getText(901181,nameStr)
    self:updateDialogue(false,str,true)
end

function PhoneMainViewAI:resetInputPos()
    self.keyboardHeight = 0
    self.Panel_input_view:stopAllActions()
end

function PhoneMainViewAI:registerEvents()

    EventMgr:addEventListener(self,EV_DATING_EVENT.phoneDating, handler(self.afterGetScript, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.acceptPhoneDating, handler(self.onCompletePhoneDating, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.triggerPhoneDating, handler(self.onShowPhoneAward, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.checkSendDialogue, handler(self.onSendDialogue, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.robotDialogue, handler(self.onRecvRobotDialogue, self))
    EventMgr:addEventListener(self,EV_VOICE_SDK_BACK, handler(self.onRecvVoiceSdk, self))
    EventMgr:addEventListener(self,EV_KEYBOARD_UP, handler(self.onRecvKeyBoard, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.relieveForbid, handler(self.onRecveRelieveForbid, self))

    self.Button_close:onClick(function()
        DatingPhoneDataMgr:saveLocalData()
        DatingPhoneDataMgr:writeDialogue()
        self:close()
    end)

    self.Button_back:onClick(function()
        self:removeCountDownTimer()
        DatingPhoneDataMgr:saveLocalData()
        self.isAiChat = false
        self:backPhonePL()
    end)

    self.Panel_chat_view:onClick(function()
        local datingInfo = DatingPhoneDataMgr:getDatingCfgById(self.nextDatingId)
        if datingInfo and datingInfo.headIcon == "1" then
            self:removeCountDownTimer()
            self.timer = 0
            self.totalTime = math.random(2,5)
            self:showDationInfo(self.nextDatingId)
        end
    end)

    local function onTextFieldChangedHandleAcc(input)
        self:setInputText(input:getText())
    end

    local function onTextFieldAttachAcc(input)
        self.Label_tip:setVisible(false)
        self:setInputText(input:getText())
    end

    self.tf_input:addMEListener(TFTEXTFIELD_DETACH, onTextFieldChangedHandleAcc)
    self.tf_input:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self.tf_input:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)

    self.Button_send:onClick(function()
        local state = DatingPhoneDataMgr:getHeroForbidState(self.dialogeRoleId)
        dump(state)
        if state == Enum_PhoneRoleState.NORMAL then
            self:onTouchSendBtn()
        else
            self:initBuyPL()
            self.Panel_buyTip:setVisible(true)
        end
    end)

    self.Button_camera:onClick(function()
        self:showLive2dView()
    end)

    self.Button_Live2Dclose:onClick(function()
        DatingPhoneDataMgr:writeDialogue()
        self:close()
    end)

    self.Button_Live2Dback:onClick(function()
        self.Panel_PhoneLive2D:hide()
    end)

    self.Button_voice:onTouch(function(event)
        if event.name == "ended" then
            if HeitaoSdk then
                HeitaoSdk.luaToClient("TMGStopRecording","")
            end
            TFDirector:removeTimer(self.timer)
            self.timer = nil
            self.LoadingBar_voice:setPercent(0)
            self.Label_voice:setTextById(901179)
        end
        if event.name == "began" then
            if HeitaoSdk then
                HeitaoSdk.luaToClient("TMGStartRecording","")
            end
            self:continueAction()
        end
    end)

    self.Button_face:onClick(function()
        if self.isShowFacePL then
            self:hideFacePL()
        else
            self:showFacePL()
        end
    end)

    self.Button_useItem:onClick(function()

        self.Panel_buyTip:setVisible(false)
        local isEnough = GoodsDataMgr:currencyIsEnough(self.costItemId, self.costItemNum)
        if isEnough then
            TFDirector:send(c2s.DATING_REQ_RELIEVE_HEART_STATE, {self.dialogeRoleId})
        else
            self.Panel_noItem:setVisible(true)
        end
    end)

    self.Button_refuse:onClick(function()
        self.Panel_buyTip:setVisible(false)
    end)

    self.Button_jump:onClick(function()
        AlertManager:setOpenStore(true)
        self:close()
    end)

    self.Panel_buyTip:onClick(function()
        self.Panel_buyTip:setVisible(false)
    end)

    self.Panel_noItem:onClick(function()
        self.Panel_noItem:setVisible(false)
    end)
end

function PhoneMainViewAI:onHide()
    self.super.onHide(self)
end

function PhoneMainViewAI:onClose()
    self.super.onClose(self)
end

function PhoneMainViewAI:onExit()
    self.super.onExit(self)
    DatingPhoneDataMgr:writeDialogue()
end

function PhoneMainViewAI:close()
    self.Panel_noItem:setVisible(false)
    self.Panel_buyTip:setVisible(false)
    self.chatListView:removeAllItems()
    DatingPhoneDataMgr:setPhoneBackState(true)
    if CC_TARGET_PLATFORM ~= CC_PLATFORM_ANDROID then
        local seqAct = Sequence:create({
            CCFadeOut:create(0.5),
            CCCallFunc:create(function()
                self.super.onClose(self)
                Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
                AlertManager:changeScene(SceneType.MainScene)
            end)
        })
        self.ui:runAction(seqAct)
    else
        self.super.onClose(self)
        Utils:setScreenOrientation(SCREEN_ORIENTATION_LANDSCAPE)
        AlertManager:changeScene(SceneType.MainScene)
    end
end

return PhoneMainViewAI
