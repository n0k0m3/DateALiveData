local PhoneMainView = class("PhoneMainView", BaseLayer)

function PhoneMainView:ctor(datingRuleId,datingTimeFrame)
	self.super.ctor(self)
	self:initData(datingRuleId,datingTimeFrame)
	self:init("lua.uiconfig.iphone.PhoneMainView")
    self:showPopAnim(true)
end

function PhoneMainView:initData(datingRuleId,datingTimeFrame)
    --datingRuleId = 2301002
    --datingTimeFrame = {"12","0","13","0","17","0","22","0"}
    DatingPhoneDataMgr:initUserLocalData()
    DatingPhoneDataMgr:initUserOldLocalData()
    self.datingRuleId = datingRuleId
    self.datingTimeFrame = datingTimeFrame
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

end

function PhoneMainView:initUI(ui)
	self.super.initUI(self,ui)
	self.ui = ui

    self.phoneBg = TFDirector:getChildByPath(self.ui,"Panel_iPhoneX")
    self.Button_close = TFDirector:getChildByPath(self.ui,"Button_close")
    self.Button_back = TFDirector:getChildByPath(self.ui,"Button_back")
    self.Label_page_name = TFDirector:getChildByPath(self.ui,"Label_page_name")

    self.Panel_touch = TFDirector:getChildByPath(self.ui,"Panel_touch")

    self.phonePL = {}
    self.Panel_contacts_View = TFDirector:getChildByPath(self.ui,"Panel_contacts_View")
    self.Panel_chat_view = TFDirector:getChildByPath(self.ui,"Panel_chat_view")
    self.phonePL[1] = self.Panel_contacts_View
    self.phonePL[2] = self.Panel_chat_view
    self.ScrollView_contacts = TFDirector:getChildByPath(self.Panel_contacts_View,"ScrollView_contacts")
    self.contactsListView = UIListView:create(self.ScrollView_contacts)
    self.contactsListView:setItemsMargin(5)
    self.Panel_subfield = TFDirector:getChildByPath(self.ui,"Panel_subfield")
    self.Panel_contact_cell = TFDirector:getChildByPath(self.ui,"Panel_contact_cell")

    --聊天界面
    self.ScrollView_chat = TFDirector:getChildByPath(self.Panel_chat_view,"ScrollView_chat")
    self.ScrollView_chat:setSwallowTouch(false)
    self.chatListView = UIListView:create(self.ScrollView_chat)
    self.chatListView:setItemsMargin(5)
    self.giftCell = TFDirector:getChildByPath(self.Panel_chat_view,"Panel_drop_gift")

    --option界面
    self.Panel_option_view = TFDirector:getChildByPath(self.ui,"Panel_option_view")
    self.Image_option = TFDirector:getChildByPath(self.Panel_option_view,"Image_option")
    self.Image_optionDarkBg = TFDirector:getChildByPath(self.Panel_option_view,"Image_optionDarkBg")
    self.Image_optionListbg = TFDirector:getChildByPath(self.Panel_option_view,"Image_optionListbg")
    self.ScrollView_option = TFDirector:getChildByPath(self.Image_optionListbg,"ScrollView_option")
    self.optionListView = UIListView:create(self.ScrollView_option)
    self.optionListView:setItemsMargin(8)
    self.Label_frameTime = TFDirector:getChildByPath(self.Panel_option_view,"Label_frameTime")

    self.Panel_prefab = TFDirector:getChildByPath(self.ui,"Panel_prefab")
    self.leftCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_lcell")
    self.rightCell = TFDirector:getChildByPath(self.Panel_prefab,"Panel_contact_rcell")
    self.Panel_optionItem = TFDirector:getChildByPath(self.Panel_prefab,"Panel_optionItem")
    self.Panel_award_item = TFDirector:getChildByPath(self.Panel_prefab,"Panel_award_item")
    self.Panel_award_attr = TFDirector:getChildByPath(self.Panel_prefab,"Panel_award_attr")
    self.Panel_outTime = TFDirector:getChildByPath(self.Panel_prefab,"Panel_outTime")
    self.Panel_normalText = TFDirector:getChildByPath(self.Panel_prefab,"Panel_normalText")
    --show界面
    -- local action = MoveTo:create(0.1,ccp(681,0))
    -- self.phoneBg:runAction(action)
    self:showDetailUI(1)

    local isFirstVersionTip = DatingPhoneDataMgr:isFisrtVersionTip()
    if not isFirstVersionTip then
        Utils:showTips(100000122)
        DatingPhoneDataMgr:setFirstVersionTip()
    end
end

--
function PhoneMainView:showDetailUI(typeId,chatType,roleId,outTimeRuleId)

    local pageName = ""
    if typeId == 1 then
        self:updateGroupInfo()
        pageName = TextDataMgr:getText(304019)
    elseif typeId == 2 then
        pageName = TextDataMgr:getText(304020)
        self.chatListView:setContentSize(CCSizeMake(340, 520))
        self.chatListView:jumpToBottom()
        if chatType == "person" then            
            self:initChatInfo(roleId,outTimeRuleId)
            if self.datingRuleId and roleId == self.phoneRole then
                --表示在约会时段阶段
                self:showDationInfo(self.startID)
            end
        else
            self.chatListView:removeAllItems()
        end
    end

    if self.curPannelId then 
        self.phonePL[self.curPannelId]:setVisible(false)
    end

    self.Label_page_name:setText(pageName)
    self.curPannelId = typeId
    self.phonePL[typeId]:setVisible(true)
    self.Button_back:setVisible(typeId ~= 1)
end

function PhoneMainView:backPhonePL()

    if not self.curPannelId or self.curPannelId == 1 then
        return
    end

    self.Panel_option_view:setVisible(false)

    local chatItems = self.chatListView:getItems()    
    if #chatItems == 0 then
        self.phonePL[self.curPannelId]:setVisible(false)
        self:showDetailUI(1)
        return
    end

    local curPhonePL = self.phonePL[self.curPannelId]
    local hideAni = Sequence:create{
        Spawn:create{
            MoveBy:create(0.2,ccp(300,0)),
            FadeIn:create(0.2)
        },
        CallFunc:create(function ()
            curPhonePL:setVisible(false)
            local curPosX = curPhonePL:getPositionX()
            curPhonePL:setPositionX(curPosX-300)
            self:showDetailUI(1)
        end)
    }
    self.phonePL[self.curPannelId]:runAction(hideAni)
end

--群组界面
function PhoneMainView:updateGroupInfo()

    self.contactsListView:removeAllItems()
    
    local head = self.Panel_subfield:clone()
    head:setVisible(true)
    local headNameTx = head:getChildByName("Label_title")
    headNameTx:setTextById(304021)
    local Imagesymbol = head:getChildByName("Imagesymbol")
    Imagesymbol:setTexture("ui/iphoneX/symbol_group.png")
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
            self:setItemInfo(groupItem,v,tipRoleId)
            self.contactsListView:pushBackCustomItem(groupItem)
            groupItem:onClick(function()
                self:showDetailUI(2,"group")
            end)
        end
    end
    
    local head = self.Panel_subfield:clone()
    head:setVisible(true)
    local headNameTx = head:getChildByName("Label_title")
    headNameTx:setTextById(304022)
    local Imagesymbol = head:getChildByName("Imagesymbol")
    Imagesymbol:setTexture("ui/iphoneX/symbol_friend.png")
    self.contactsListView:pushBackCustomItem(head)

    local friendCfg = DatingPhoneDataMgr:getFriendCfg()
    for k,v in ipairs(friendCfg) do
        if v.open then
            local roleId = v.openType["roleCids"][1]
            local isHave = RoleDataMgr:getIsHave(roleId)
            if isHave then

                local chatRoleItem = self.Panel_contact_cell:clone()
                chatRoleItem:setVisible(true)

                --约会提示
                local Image_new = TFDirector:getChildByPath(chatRoleItem,"Image_new")
                Image_new:setVisible(roleId == self.phoneRole)
                local Image_newDating = TFDirector:getChildByPath(chatRoleItem,"Image_newDating")

                --接受约会
                local isAccept = DatingDataMgr:isAcceptPhoneRole(roleId)
                --Image_newDating:setVisible(tobool(isAccept))
                Image_newDating:setVisible(false)

                --过期约会提示
                local outTimeRuleId = DatingPhoneDataMgr:getOutTimePhoneRuleId(roleId)
                if outTimeRuleId then
                    Image_new:setVisible(true)
                end

                self:setItemInfo(chatRoleItem,v)
                self.contactsListView:pushBackCustomItem(chatRoleItem)
                chatRoleItem:onClick(function()
                    
                    --清空过期约会提示
                    DatingPhoneDataMgr:saveOutTimePhoneRuleId(roleId,"")

                    self:removeCountDownTimer()
                    if roleId == self.phoneRole then
                        DatingDataMgr:sendGetSciptMsg(EC_DatingScriptType.PHONE_SCRIPT,self.phoneRole,nil,self.phoneScript,nil,nil)
                    else
                       self:showDetailUI(2,"person",roleId,outTimeRuleId) 
                    end
                end)
            end
        end
    end
end

function PhoneMainView:afterGetScript()
    self:showDetailUI(2,"person",self.phoneRole) 
end

function PhoneMainView:setItemInfo(item,info,tipRoleId)

    if not info then
        return
    end

    local Image_head = TFDirector:getChildByPath(item,"Image_head")
    Image_head:setTexture(info.icon)
    local Label_name = TFDirector:getChildByPath(item,"Label_name")
    Label_name:setTextById(info.nameId)
    
end

--聊天界面
function PhoneMainView:initChatInfo(roleId,outTimeRuleId)

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
                self:updateItemInfo(datingInfo)
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
                self:updateItemInfo(datingInfo)
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

function PhoneMainView:updateItemInfo(datingInfo)

    local headIcon = datingInfo.headIcon
    local cell = headIcon ~= "1" and self.leftCell:clone() or self.rightCell:clone()
    cell:setVisible(true)
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if headIcon ~= "1" then
        Image_head:setTexture(headIcon)
    end
    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg")
    local textStr =  string.gsub(datingInfo.text, "%%s", MainPlayer:getPlayerName())
    TextArea_msg:setText(textStr)
    TextArea_msg:setDimensions(210, 0)
    local size = TextArea_msg:getContentSize()
    local newHight = size.height < 70 and 70 or (size.height + 10)
    local Image_msg = TFDirector:getChildByPath(cell,"Image_msg")
    Image_msg:setContentSize(CCSizeMake(243, newHight))
    cell:setContentSize(CCSizeMake(340, newHight))
    self.chatListView:pushBackCustomItem(cell)

end

function PhoneMainView:updateChatInfo(datingInfo,jumpInfo)

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
    local Image_head = TFDirector:getChildByPath(cell,"Image_head")
    if headIcon ~= "1" then
        Image_head:setTexture(headIcon)
    end
    local TextArea_msg = TFDirector:getChildByPath(cell,"TextArea_msg")
    local textStr =  string.gsub(datingInfo.text, "%%s", MainPlayer:getPlayerName())
    TextArea_msg:setText(textStr)
    self.chatListView:pushBackCustomItem(cell)
    self.chatListView:jumpToBottom()

    if next(jumpInfo) then    
        DatingPhoneDataMgr:addDatingInfo(self.datingRuleId,datingInfo.id)
    end

end

--option界面
function PhoneMainView:updateOptionListInfo(jumpInfo)

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
            self.chatListView:setContentSize(CCSizeMake(340, 520))
            self.chatListView:jumpToBottom()
            DatingDataMgr:sendDialogueMsg(self.curDatingId, datingId, EC_DatingScriptType.PHONE_SCRIPT, self.phoneRole)
            self:showDationInfo(datingId)
        end)
    end
end

--datingId:PhoneDating配置ID
function PhoneMainView:showDationInfo(datingId)

    local datingInfo = DatingPhoneDataMgr:getDatingCfgById(datingId)
    if not datingInfo then
        self:updateDaingText("wrong datingId:"..tostring(datingId))
        return
    end
    print(datingInfo.text)
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
        print("ssssssssssssssss")
        self.nextDatingId = jumpInfo[1]
        self.Panel_option_view:setVisible(false)
        self.Panel_chat_view:setTouchEnabled(true)
    else
        self:removeCountDownTimer()
        self.chatListView:setContentSize(CCSizeMake(340, 320))
        self.chatListView:jumpToBottom()

        self.Label_frameTime:setText(self.frameStr)
        self.Panel_option_view:setVisible(true)
        self:updateOptionListInfo(datingInfo.jump)
        self.Panel_chat_view:setTouchEnabled(false)
    end

end

--取消自动播放
function PhoneMainView:removeEvents()
    self:removeCountDownTimer()
end

function PhoneMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function PhoneMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function PhoneMainView:onCountDownPer()

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

function PhoneMainView:onCompletePhoneDating(accept)

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
    --self:showDitingEndAward()
    self.datingRuleId = nil
    self.phoneRole = nil
    self.chatListView:jumpToBottom()
end

function PhoneMainView:onShowPhoneAward(flag,ruleId,award)

    if flag then
        return
    end

    if not award then
        return
    end

    for k,v in pairs(award) do

        if v.id == 500007 or v.id == 500008 then
            self:updateDaingAttr(v.id,v.num)
        else
            self:updateDaingAwardItem(v.id,v.num)
        end

    end
    self.chatListView:jumpToBottom()
    self.Panel_option_view:setVisible(false)

end
function PhoneMainView:showDitingEndAward()
    
    local datingAward = self.phoneAward[self.lastDatingId]
    if not datingAward then
        return
    end

    for k,v in pairs(datingAward) do

        if k == 500007 or k == 500008 then
            self:updateDaingAttr(k,v)
        else
            self:updateDaingAwardItem(k,v)
        end
        
    end
    self.chatListView:jumpToBottom()
    self.Panel_option_view:setVisible(false)
end

function PhoneMainView:updateDaingAttr(itemId,itemNum)

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
    TextArea_value:setText(itemNum)

    self.chatListView:pushBackCustomItem(cloneItem)
end

function PhoneMainView:updateDaingAwardItem(itemId,itemNum)

    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    if not itemCfg then
        return
    end
    
    local cloneItem = self.Panel_award_item:clone()

    local Panel_goodsItem= PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, itemId)
    Panel_goodsItem:setPosition(ccp(-95,2))
    Panel_goodsItem:setScale(0.8)
    cloneItem:addChild(Panel_goodsItem)

    local TextArea_name = cloneItem:getChildByName("TextArea_name")
    TextArea_name:setTextById(itemCfg.nameTextId)

    local TextArea_value = cloneItem:getChildByName("TextArea_value")
    TextArea_value:setText(itemNum)

    self.chatListView:pushBackCustomItem(cloneItem)
end

function PhoneMainView:updateDaingText(text)

    local cloneItem = self.Panel_outTime:clone()
    local TextArea_name = cloneItem:getChildByName("TextArea_name")
    TextArea_name:setString(text)

    self.chatListView:pushBackCustomItem(cloneItem)
end

function PhoneMainView:updateNormalText(text)

    local cloneItem = self.Panel_normalText:clone()
    local TextArea_name = cloneItem:getChildByName("Label_text")
    TextArea_name:setString(text)

    self.chatListView:pushBackCustomItem(cloneItem)
end

function PhoneMainView:updateDatingPlace(placeInfo)

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

function PhoneMainView:updateOutTimeAward(awardContent)
 
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
            else
                self:updateDaingAwardItem(awardId,awardNum)
            end
        end
    end
end 

function PhoneMainView:updateOutTimeText(datingRuleId,outTime)

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

function PhoneMainView:registerEvents()
    EventMgr:addEventListener(self,EV_DATING_EVENT.phoneDating, handler(self.afterGetScript, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.acceptPhoneDating, handler(self.onCompletePhoneDating, self))
    EventMgr:addEventListener(self,EV_DATING_EVENT.triggerPhoneDating, handler(self.onShowPhoneAward, self))

    self.Button_close:onClick(function()
        DatingPhoneDataMgr:saveLocalData()
        AlertManager:closeLayer(self)
    end)

    self.Button_back:onClick(function()
        self:removeCountDownTimer()
        DatingPhoneDataMgr:saveLocalData()
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

    self.Panel_touch:onClick(function()
        DatingPhoneDataMgr:saveLocalData()
        AlertManager:closeLayer(self)
    end)
end
return PhoneMainView