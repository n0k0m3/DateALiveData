local RoleTeachFuncLayer = class("RoleTeachFuncLayer",BaseLayer)
local RoleTachMacro = require("lua.logic.datingPhone.RoleTachMacro")

function RoleTeachFuncLayer:ctor(roleId,pageIdx,chooseType, ...)
    self.super.ctor(self)
    self:initData(roleId,pageIdx,chooseType, ...)
    self:setUsepreProcesUI()
    if pageIdx == RoleTachMacro.PAGETYPE.ACHIEVE then
        self.__cname = "RoleTachAchieve"
    elseif pageIdx == RoleTachMacro.PAGETYPE.TEACH then
        self.__cname = "RoleTach"
        -- RoleTeachDataMgr:SendIssueReques() -- 暂时不要问题池
    elseif pageIdx == RoleTachMacro.PAGETYPE.RANK then
        self.__cname = "RoleTachRank"
        RoleTeachDataMgr:SendRankRequest(RoleTachMacro.RANK.WeekRank)
        RoleTeachDataMgr:SendRankRequest(RoleTachMacro.RANK.SumRank)
    end
    self:init("lua.uiconfig.iphone.roleTeachLayer")
end

function RoleTeachFuncLayer:initData(roleId,pageIdx,chooseType, ...)
    self.roleId = roleId or 101
    self.pageIdx = pageIdx or 1
    self.chooseType = chooseType or 1
    self.checkType  = 1
    self.dataTab = {...}
    self.taskItems = {}
    self.fellIds = {}
end

function RoleTeachFuncLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.PageUI = {
        [RoleTachMacro.PAGETYPE.ACHIEVE] = self._ui.pannel_Achieve,
        [RoleTachMacro.PAGETYPE.TEACH] = self._ui.pannel_Teach,
        [RoleTachMacro.PAGETYPE.RANK] = self._ui.pannel_Rank
    }

    self.achieveGetView = UIListView:create(self._ui.achieveGetView)
    self.achieveGetView:setItemsMargin(0)
    self.labView = UIListView:create(self._ui.labView)
    self._ui.labAchieveInfoDescInput:retain()
    self._ui.labAchieveInfoDescInput:removeFromParent()
    self.labView:pushBackCustomItem(self._ui.labAchieveInfoDescInput)

    self.touchIssueView = UIListView:create(self._ui.touchIssueView)
    self.touchIssueView:setItemsMargin(0)

    self.scrollCheckView = UIListView:create(self._ui.scrollCheckView)
    self.scrollCheckView:setItemsMargin(0)

    self.rankTableView = Utils:scrollView2TableView(self._ui.rankView)
    self.rankTableView:setZOrder(1000)

    self:refreshView()
    self:refreshRed()
end

function RoleTeachFuncLayer:registerEvents()

    -- 二级页签按钮
    for _, page in ipairs(self.PageUI) do
       for _, btn in ipairs(page:getChildByName("chooseBtns"):getChildren()) do
            local n = string.gsub(btn:getName(),"btn_","")
            n = tonumber(n)
            btn:onClick(function()
                if n == RoleTachMacro.TEACH.CHECK then
                    RoleTeachDataMgr:SendCheckReques(0)
                    RoleTeachDataMgr:SendCheckReques(1)
                    RoleTeachDataMgr:SendCheckReques(2)
                end
                self:ChoosePageDetailFunc(tonumber(n))
            end)
       end
    end

    -- 审核状态选择按钮(三级页签)
    for _, btn in ipairs(self._ui.checkBtns:getChildren()) do
        local i = string.gsub(btn:getName(),"btnCheck_","")
        i = tonumber(i)
        btn:onClick(function()
            self:teachCheckControl(i)
        end)
    end

    -- 调教的4个单选框按钮
    for i = 1, 4 do
        local _img = self._ui[string.format("imgCheck_%d",i)]
        _img:setTouchEnabled(true)
        _img:setTag(i)
        _img:onClick(function()
            self:teachCheckBtnChoose(i)
        end)
    end

    -- 攻略按钮
    self._ui.btnTeachSelfGo:onClick(function()
        Utils:openView("datingPhone.AiLabshowView",2,14240016)
    end)

    -- 提交调教
    self._ui.btnTeachSelfComplete:onClick(function()
        self:teachSelfCompleteFunc()
    end)
    -- tableview
    self.rankTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.rankTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.rankTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))

    -- self.rankTableView:addMEListener(TFTABLEVIEW_SCROLL, handler(self.tableScroll,self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, handler(self.onTaskUpdateEvent, self))
    EventMgr:addEventListener(self, EV_ROLETEACH_SUBNUM, handler(self.onRefreshSubNum, self))
    EventMgr:addEventListener(self, EV_KEYBOARD_UP, handler(self.onRecvKeyBoard, self))

    -- 问题
    local function onTextFieldAttachAcc(input)
        self:setInputQuesText(input:getText())
    end
    local function onTextFieldChangedHandleAcc(input)
        self:setInputQuesText(input:getText())
    end
    self._ui.fieldTeachQues:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc)
    self._ui.fieldTeachQues:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc)
    -- 回答
    local function onTextFieldAttachAcc1(input)
        self:setInputAnwsText(input:getText())
    end
    local function onTextFieldChangedHandleAcc1(input)
        self:setInputAnwsText(input:getText())
    end
    self._ui.fieldTeachAnws:addMEListener(TFTEXTFIELD_ATTACH, onTextFieldAttachAcc1)
    self._ui.fieldTeachAnws:addMEListener(TFTEXTFIELD_TEXTCHANGE, onTextFieldChangedHandleAcc1)

    EventMgr:addEventListener(self,EV_ROLETEACHCURLAYER_REFRESH,handler(self.onRefreshCurLayer, self))
    EventMgr:addEventListener(self,EV_ROLETEACHRED_REFRESH,handler(self.refreshRed, self))
end

function RoleTeachFuncLayer:setInputQuesText(inputText)
    self._ui.labFiledTeachQuesShow:setVisible(false)
    if not self.richInputQues then
        self.richInputQues = TFRichText:create(ccs(460, 30))
        self.richInputQues:AnchorPoint(me.p(0, 1))
        local _pos = self._ui.fieldTeachQues:getPosition()
        self.richInputQues:AddTo(self._ui.fieldTeachQues:getParent(),999):Pos(_pos)
    end 

    self._ui.fieldTeachQues:setText(inputText)
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.conversioncode,v.convermotion)
    end
    self.richInputQues:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301012"), inputText))
    self:refreshKeboardShow(inputText)
end

function RoleTeachFuncLayer:setInputAnwsText(inputText)
    self._ui.labFiledTeachAnwsShow:setVisible(false)
    if not self.richInputAnws then
        self.richInputAnws = TFRichText:create(ccs(460, 30))
        self.richInputAnws:AnchorPoint(me.p(0, 1))
        local _pos = self._ui.fieldTeachAnws:getPosition()
        self.richInputAnws:AddTo(self._ui.fieldTeachAnws:getParent(),999):Pos(_pos)
    end 

    self._ui.fieldTeachAnws:setText(inputText)
    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        inputText = string.gsub(inputText,v.conversioncode,v.convermotion)
    end
    self.richInputAnws:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301013"), inputText))
    self:refreshKeboardShow(inputText)
end

function RoleTeachFuncLayer:teachSelfCompleteFunc()
    if not RoleTeachDataMgr:canTeachRole() then
        Utils:openView("datingPhone.JoinTipView")
        --[[Utils:openView("chronoCross.ChronoTaskConfirmView",
            {titleStrId = 100000148,tipStrId = 100000149,},
            function()
                if RoleTeachDataMgr:isHaveBoughtTeachCard() then
                    Utils:openView("datingPhone.TeachCardShowView")
                else
                    Utils:openView("datingPhone.RoleTeachBuyView")
                end
            end
        )--]]
        return
    end

    local quesTxt = self._ui.fieldTeachQues:getString()
    local anwsTxt = self._ui.fieldTeachAnws:getString()
    local ids  = {}
    if #self.fellIds == 0 then
        table.insert(ids, 0)
    else
        for _, tag in ipairs(self.fellIds) do
            table.insert( ids, tag - 1)
        end
    end

    local roleActId, tempTxtID
    local failKvpData    = Utils:getKVP(49006)
    roleActId = failKvpData.emotions[math.random(1,#failKvpData.emotions)]

    if not Utils:getTxtExistSpace(quesTxt,anwsTxt) then
        if  Utils:getCharLength(quesTxt) > 2 and Utils:getCharLength(anwsTxt) > 2 then
            local successKvpData = Utils:getKVP(49005)
            roleActId = successKvpData.emotions[math.random(1,#successKvpData.emotions)]
            tempTxtID = successKvpData.answer[math.random(1,#successKvpData.answer)]
            
            RoleTeachDataMgr:SendTeachCommit(self.Qid or 0, quesTxt, anwsTxt, ids, self.subType or 0)
            self._ui.fieldTeachQues:setString("")
            self:setInputQuesText("")
            self._ui.labFiledTeachQuesShow:setVisible(true)
            self._ui.fieldTeachAnws:setString("")
            self:setInputAnwsText("")
            self._ui.labFiledTeachAnwsShow:setVisible(true)
            self:teachCheckBtnChoose(1)
            self.Qid = nil
            self.subType = 0
        else
            tempTxtID = 14240004
        end
    else
        if Utils:getTxtExistSpace(quesTxt) and not Utils:getTxtExistSpace(anwsTxt) then 
            tempTxtID = 14240001
        elseif not Utils:getTxtExistSpace(quesTxt) and Utils:getTxtExistSpace(anwsTxt) then
            tempTxtID = 14240002
        else
            tempTxtID = 14240003
        end
    end
    self._ui.labRoleAnswer:setTextById(tempTxtID)
    self._ui.labRoleAnswer.keepShow = false
    self._ui.labRoleAnswer:setFontColor(ccc3(48,53,74))
    local actName = DatingPhoneDataMgr:getEmotionActionName(roleActId, self.modelId)
    self.roleLive2d:newStartAction(actName, EC_PRIORITY.NORMAL)
end

function RoleTeachFuncLayer:refreshKeboardShow(str)
    if not self.richInput1 then
        self.richInput1 = TFRichText:create(ccs(970, 24))
        self.richInput1:AnchorPoint(me.p(0, 0.5))
        self.richInput1:AddTo(self._ui.movePanel,999):Pos(self._ui.labKeboardShow:getPosition())
    end 

    local faceCfg = DatingPhoneDataMgr:getFaceEmotion()
    for k,v in ipairs(faceCfg) do
        str = string.gsub(str,v.conversioncode,v.convermotion)
    end
    self.richInput1:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r301011"), str))
end

function RoleTeachFuncLayer:rankCellSize(tableView, idx)
    local size = self._ui.rankItem:getSize()
    return size.height + 10, size.width
end

function RoleTeachFuncLayer:numberOfCells(tableView)
    return self.rankNum or 0 
end

function RoleTeachFuncLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.rankItem:clone()

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

function RoleTeachFuncLayer:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
end

function RoleTeachFuncLayer:onTaskUpdateEvent()
    self:achieveInfoControl()
end

function RoleTeachFuncLayer:onRefreshSubNum(num)
    self:timeOut(function()
        local txt = string.format(TextDataMgr:getText(14240022),num)
        self._ui.labRoleAnswer:setText(txt)
        self._ui.labRoleAnswer.keepShow = true
        self._ui.labRoleAnswer:setFontColor(ccc3(253,56,112))
    end,1.0)
end

function RoleTeachFuncLayer:onRecvKeyBoard(keyboardHeight)
    self:timeOut(function()
        local bool = false
        if keyboardHeight > 0 then
            bool = true
            self._ui.movePanel:setPositionY(keyboardHeight)
        end
        self._ui.movePanel:setVisible(bool)
    end, 0.1)
end

function RoleTeachFuncLayer:refreshCellItem(item, idx)
    local data = self.rankData[idx]
    local bgChange = item:getChildByName("bgChange")
    local spcBg = item:getChildByName("rankItemBg")
    local bgLine = item:getChildByName("rankItemLine") 
    local rankNum = item:getChildByName("rankNum")
    local Image_head = TFDirector:getChildByPath(item,"Image_head")
    local Image_head_cover_frame = TFDirector:getChildByPath(item,"Image_head_cover_frame")
    local playerName = item:getChildByName("playerName")
    local labChannel = item:getChildByName("labChannel")
    local playerTeachLv = item:getChildByName("playerTeachLv")
    local playerPassed = item:getChildByName("playerPassed")
    local playerPassedNum = item:getChildByName("playerPassedNum")
    spcBg:setVisible(true)
    bgLine:setVisible(false)
    if idx % 2 == 0 then
        bgChange:setTexture("ui/iphoneX/roleTeach/rank/004.png")
    else
        bgChange:setTexture("ui/iphoneX/roleTeach/rank/005.png")
    end 
    -- 排名前三背景处理
    if idx == 1 then
        spcBg:setTexture("ui/iphoneX/roleTeach/rank/006.png")
    elseif idx == 2 then
        spcBg:setTexture("ui/iphoneX/roleTeach/rank/007.png")
    elseif idx == 3 then
        spcBg:setTexture("ui/iphoneX/roleTeach/rank/008.png")
    else
        bgLine:setVisible(true)
        spcBg:setVisible(false)
    end
    rankNum:setText(data.rank)
    Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(data.headId))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getAvatarFrameIconPath(data.headFrame)
    Image_head_cover_frame:setTexture(avatarFrameIcon)
    playerName:setText(data.pName)
    local channelData = Utils:getKVP(49004,"ChannelIdList")
    local channelTxtID = channelData[data.gid]
    if channelTxtID then
        labChannel:setTextById(channelTxtID)
    else
        labChannel:setTextById(63640)
    end
    playerTeachLv:setText(data.trainLv)
    local pass = 0 
    if data.totalNum ~= 0 then
        pass = data.sucNum/data.totalNum * 100
        pass = pass > 100 and 100 or pass
        pass = string.format("%.2f", pass)
    end
    playerPassed:setText(pass.."%")
    playerPassedNum:setText(data.sucNum)
end

function RoleTeachFuncLayer:onRefreshCurLayer(oneIdx, secIdx, threeIdx)
    if oneIdx and secIdx and oneIdx == self.pageIdx  and secIdx == self.chooseType then
        self:ChoosePageShow(oneIdx)
        self:ChoosePageDetailFunc(secIdx)
    end

    if threeIdx and threeIdx == self.checkType then
        self:teachCheckControl(threeIdx)
    end
end

function RoleTeachFuncLayer:ChoosePageShow(index)
    for i, page in pairs(self.PageUI) do
        page:setVisible(i == index)
    end
end

function RoleTeachFuncLayer:ChoosePageDetailFunc(idx, dataTab)
    if idx == RoleTachMacro.TEACH.Issue then
        RoleTeachDataMgr:setCancnelTeachRed(idx)
        self:refreshRed()
    end

    local SwitchPageChooseFunc = {
        [RoleTachMacro.PAGETYPE.ACHIEVE] = function()
            if idx == RoleTachMacro.ACHIEVE.Info then
                RoleTeachDataMgr:SendTeachInfoRequest()
                self:achieveInfoControl()
            end
        end,
        [RoleTachMacro.PAGETYPE.TEACH] = function()
            if idx == RoleTachMacro.TEACH.Issue then
                self:teachIssueControl()
            elseif idx == RoleTachMacro.TEACH.TeachSelf then
                self:teachSelfControl(dataTab)
            elseif idx == RoleTachMacro.TEACH.CHECK then
                self:teachCheckControl(self.checkType)
            end
        end,
        [RoleTachMacro.PAGETYPE.RANK] = function()
            local txt,txt1
            if idx == RoleTachMacro.RANK.WeekRank then
                txt = 14240009
                txt1 = 14240010
            else
                txt = 14240011
                txt1 = 14240012
            end
            self._ui.labPassPercent:setTextById(txt)
            self._ui.labSumPassNum:setTextById(txt1)

            self:pannelRankControl(idx)
            self.rankData = RoleTeachDataMgr:getRankDataByTag(idx)
            if not self.rankData then
                self.rankNum = 0
            else
                self.rankNum = #self.rankData
            end
            self.rankTableView:reloadData()
        end
    }

    SwitchPageChooseFunc[self.pageIdx]()

    local btns = self.PageUI[self.pageIdx]:getChildByName("chooseBtns")
    for i, btn in ipairs(btns:getChildren()) do
        local selectImg = btn:getChildByName("img_btnChoose")
        if selectImg then
            selectImg:setVisible(i == idx)
        end
    end
    self.chooseType = idx
end

function RoleTeachFuncLayer:helpPannelShow(node, str)
    for i, child in ipairs(node:getChildren()) do
        if  child:getName() == str or child:getName() == "chooseBtns" then
            child:setVisible(true)
        else
            child:setVisible(false)
        end
    end
end

function RoleTeachFuncLayer:addDailyItem()
    local pannelItem = self._ui.achieveGetViewItem:clone()
    local tab = {}
    tab.rewards = {}
    tab.root = pannelItem
    tab.bg = pannelItem:getChildByName("bg")
    tab.bg1 = pannelItem:getChildByName("bg1")
    tab.itemawards = pannelItem:getChildByName("achieveGetViewItemAward")
    tab.achieveGetViewItemTitle = pannelItem:getChildByName("achieveGetViewItemTitle")
    tab.achieveGetViewItemDesc = pannelItem:getChildByName("achieveGetViewItemDesc")
    tab.btnGoTeach = pannelItem:getChildByName("btnAchieveGoTeach")
    tab.btnAchieveGetViewItemAward = pannelItem:getChildByName("btnAchieveGetViewItemAward")
    for i = 1, 3 do
        local foo = {}
        foo.goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.goodsItem:setScale(0.7)
        foo.goodsItem:AddTo(tab.itemawards:getChildByName(string.format("awardPos_%d",i))):Pos(0,0):ZO(1)
        tab.rewards[i] = foo
    end
    self.taskItems[tab.root] = tab
    return pannelItem
end

function RoleTeachFuncLayer:achieveInfoControl()
    self:helpPannelShow(self.PageUI[RoleTachMacro.PAGETYPE.ACHIEVE], "pannel_AchieveInfo")
    local basisData = RoleTeachDataMgr:getAchieveData()
    -- 成就列表
    local taskList = TaskDataMgr:getTask(EC_TaskType.ROLE_TEACH)
    local items = self.achieveGetView:getItems()
    local gap = #taskList - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local pannelItem = self:addDailyItem()
            pannelItem:setName("pannelItem"..i)
            self.achieveGetView:pushBackCustomItem(pannelItem)
        end
    else
        for i = 1, math.abs(gap) do
            self.achieveGetView:removeItem(1)
        end
    end
    for i, v in ipairs(self.achieveGetView:getItems()) do
        item = self.taskItems[v]
        if i % 2 == 0 then
            item.bg1:setTexture("ui/iphoneX/roleTeach/achieve/001.png")
        else
            item.bg1:setTexture("ui/iphoneX/roleTeach/achieve/002.png")
        end

        local taskCfg = TaskDataMgr:getTaskCfg(taskList[i])
        item.bg:setTexture("ui/iphoneX/roleTeach/achieve/005.png")
        item.achieveGetViewItemTitle:setTextById(taskCfg.name)
        item.achieveGetViewItemDesc:setTextById(taskCfg.des)
        local isBuy = RoleTeachDataMgr:isHaveBoughtTeachCard()
        if not isBuy then
            item.btnGoTeach:hide()
            item.btnAchieveGetViewItemAward:hide()
        else
            local taskInfo = TaskDataMgr:getTaskInfo(taskList[i])
            if taskInfo then
                if taskInfo.status == EC_TaskStatus.ING then
                    item.btnGoTeach:show()
                    item.btnAchieveGetViewItemAward:hide()
                    item.btnGoTeach:onClick(function()

                        local isCanTeach = RoleTeachDataMgr:canTeachRole()
                        if not isCanTeach then
                            Utils:openView("datingPhone.JoinTipView")
                            return
                        end

                        Utils:openView("datingPhone.RoleTeachFuncLayer", 
                            nil,
                            RoleTachMacro.PAGETYPE.TEACH,
                            RoleTachMacro.TEACH.TeachSelf
                        )
                    end)
                elseif taskInfo.status == EC_TaskStatus.GET then
                    item.bg:setTexture("ui/iphoneX/roleTeach/achieve/006.png")
                    item.btnAchieveGetViewItemAward:onClick(function()
                        TaskDataMgr:send_TASK_SUBMIT_TASK(taskList[i])
                        self.itemIdx = i
                    end)
                    item.btnGoTeach:hide()
                    item.btnAchieveGetViewItemAward:show()
                elseif taskInfo.status == EC_TaskStatus.GETED then
                    item.btnGoTeach:hide()
                    item.btnAchieveGetViewItemAward:hide()
                end
            end
        end
       
        for i, award in ipairs(item.rewards) do
            local cfg = taskCfg.reward[i]
            if cfg then
                PrefabDataMgr:setInfo(award.goodsItem, cfg[1], cfg[2])
                award.goodsItem:show()
            else
                award.goodsItem:hide()
            end
        end
    end
    -- 基础信息 
    self._ui.userName:setText(MainPlayer:getPlayerName()) 
    if nil == basisData then
        return
    end
    self._ui.labTeachLv:setText(basisData.level)
    self._ui.teachLvBar:setPercent(basisData.exp)
    self._ui.labTeachDay:setText(basisData.days)
    self._ui.labTeachNum:setText(basisData.sucNum)

    local bestQues = basisData.bestQuery or ""
    local bestAnws = basisData.bestReply or ""
    local txt = bestAnws
    if bestQues ~= "" or bestAnws ~= "" then
        txt = TextDataMgr:getText(14240020)..bestQues.."\n"..TextDataMgr:getText(14240021)..bestAnws
    end
    self._ui.labAchieveInfoDescInput:setWidth(300)
    self._ui.labAchieveInfoDescInput:setText(txt)
    self.labView:doLayout()

    local pass = 0 
    if basisData.totalNum ~= 0 then
        pass = basisData.sucNum/basisData.totalNum * 100
        pass = pass > 100 and 100 or pass
        pass = string.format("%.2f", pass)
    end
    self._ui.labSuccess:setText(pass)
end

function RoleTeachFuncLayer:teachIssueControl()
    self:helpPannelShow(self.PageUI[RoleTachMacro.PAGETYPE.TEACH], "pannel_TeachIssue")
    self.touchIssueView:removeAllItems()
    local teachData = RoleTeachDataMgr:getTeachDataByTag(RoleTachMacro.TEACH.Issue)
    if not teachData then
        self._ui.labNullShow:show()
        return  
    else
        self._ui.labNullShow:hide()
    end
   
    local listData  = json.decode(teachData.jsonList)
    if #listData == 0 then
        return
    end
    self._ui.labIssueNumPage1:setText(teachData.page)

    for i = 1, #listData do
        local item = self._ui.touchIssueViewItem:clone()
        item:setVisible(true)
        local input = item:getChildByName("touchIssueViewQuesInput")
        local answer = item:getChildByName("touchIssueViewAnswerInput")
        input:setText(listData[i].query)
        answer:setText(listData[i].reply)
        item:getChildByName("btntouchIssueViewItemGo"):onClick(function()
            if RoleTeachDataMgr:canTeachRole() then
                self:ChoosePageDetailFunc(RoleTachMacro.TEACH.TeachSelf, {input:getString(), answer:getString(),listData[i].id})
            else
                Utils:openView("datingPhone.JoinTipView")
                --[[Utils:openView("chronoCross.ChronoTaskConfirmView",
                    {titleStrId = 100000148,tipStrId = 100000149,},
                    function()
                        if RoleTeachDataMgr:isHaveBoughtTeachCard() then
                            Utils:openView("datingPhone.TeachCardShowView")
                        else
                            Utils:openView("datingPhone.RoleTeachBuyView")
                        end
                    end
                )--]]
            end
        end)
        -- ViewAnimationHelper.doMoveFadeInAction(item,{direction = 1, distance = (4 -i)*200, ease = 1,adjust = (4 -i)*200})
        self.touchIssueView:pushBackCustomItem(item)
    end
    ViewAnimationHelper.displayMoveNodes(self.touchIssueView:getItems(), {direction = 2, distance = 250, wait = 0, delay = 0.1, time = 0.1})
    
    self._ui.btnTeachIssueUp:onClick(function()
        if teachData.page == 1 then
            return
        end
        -- RoleTeachDataMgr:SendIssueReques(-1)
    end)
    self._ui.btnTeachIssueNext:onClick(function()
        -- RoleTeachDataMgr:SendIssueReques(1)
    end)
end

function RoleTeachFuncLayer:teachSelfControl(dataTab)
    self:helpPannelShow(self.PageUI[RoleTachMacro.PAGETYPE.TEACH], "pannel_Teachself")
    self._ui.movePanel:setVisible(false)
    if not self._ui.labRoleAnswer.keepShow then
        self._ui.labRoleAnswer:setTextById(14240015)
        self._ui.labRoleAnswer:setFontColor(ccc3(48,53,74))
    end
    if dataTab then
        -- 问题文本
        if dataTab[1] then
            self._ui.fieldTeachQues:setText(dataTab[1])
            self:setInputQuesText(dataTab[1])
        end
        -- 回答文本
        if dataTab[2] then
            self._ui.fieldTeachAnws:setText(dataTab[2])
            self:setInputAnwsText(dataTab[2])
        end
        -- 问题id
        self.Qid = dataTab[3] 
        -- 提交问题类型
        self.subType = dataTab[4]
    end
    
    -- 精灵live2d
    self.modelId = DatingPhoneDataMgr:getRoleEmotionInfo(self.roleId).ModelId
    if not self.roleLive2d then
        self.roleLive2d = ElvesNpcTable:createLive2dNpcID(self.modelId, false,false,nil,false).live2d
        self.roleLive2d:registerEvents()
        self.roleLive2d:setScale(0.9) 
        self._ui.rolePos:getParent():addChild(self.roleLive2d)
        self.roleLive2d:setPosition(self._ui.rolePos:getPosition())
    end
end

function RoleTeachFuncLayer:teachCheckControl(idx)
    self:helpPannelShow(self.PageUI[RoleTachMacro.PAGETYPE.TEACH], "pannel_Check")
    self._ui.labIssueNumPage:hide() --
    self.checkType = idx
    if idx == RoleTachMacro.CHECK.Failed or RoleTachMacro.CHECK.Success  then
        RoleTeachDataMgr:setCancnelTeachRed(RoleTachMacro.TEACH.CHECK,idx)
        self:refreshRed()
    end 
    
    self._ui.labCheckNumPage:setText("0")
    self.scrollCheckView:removeAllItems()
    for _, btn in ipairs(self._ui.checkBtns:getChildren()) do
        local i = string.gsub(btn:getName(),"btnCheck_","")
        local img = btn:getChildByName("selectImg") 
        img:setVisible(tonumber(i) == idx)
    end

    local data = RoleTeachDataMgr:getTeachDataByTag(RoleTachMacro.TEACH.CHECK,idx)
    if not data then
        return  
    end
    local listData = json.decode(data.jsonList)
    if #listData == 0 then
        return
    end
    local page = data.page.."/"..data.totlaPage
    self._ui.labCheckNumPage:setText(page)

    for i, itemData in ipairs(listData) do
        local item = self._ui.teachCheckViewItem:clone()
        item:setVisible(true)
        local onChecking = item:getChildByName("onChecking")
        local checkState = item:getChildByName("checkState")
        onChecking:setVisible(idx == RoleTachMacro.CHECK.Doing)
        checkState:setVisible(idx ~= RoleTachMacro.CHECK.Doing)
        local needItem = onChecking:isVisible() and onChecking or checkState
        local foldPannel = needItem:getChildByName("fold")
        local unfoldPannel = needItem:getChildByName("unfold")
        -- 共通ui
        local bg,bg2,btn_fold,unfoldQuesTxt,unfoldAnswerTxt,foldQuesTxt,foldAnswerTxt,labCheckResultInput
        if foldPannel and unfoldPannel then  
            foldPannel:setVisible(true)
            unfoldPannel:setVisible(false)
            -- ui
            bg2 = foldPannel:getChildByName("bg2")
            bg = foldPannel:getChildByName("bg")
            btn_fold = unfoldPannel:getChildByName("btn_fold")
            unfoldQuesTxt = TFDirector:getChildByPath(unfoldPannel, "quesTxt")
            unfoldAnswerTxt = TFDirector:getChildByPath(unfoldPannel, "answerInput")
            foldQuesTxt = TFDirector:getChildByPath(foldPannel, "quesTxt")
            foldAnswerTxt = TFDirector:getChildByPath(foldPannel, "answerInput")
            labCheckResultInput = TFDirector:getChildByPath(foldPannel, "labCheckResultInput")

            bg2:setTouchEnabled(true)
            foldPannel:getChildByName("labHadPassed"):setVisible(idx == RoleTachMacro.CHECK.Success)
            foldPannel:getChildByName("labCheckResultSuccess"):setVisible(idx == RoleTachMacro.CHECK.Success)
            foldPannel:getChildByName("labCheckResultFall"):setVisible(idx == RoleTachMacro.CHECK.Failed)
            foldPannel:getChildByName("btnTeachAgain"):setVisible(idx == RoleTachMacro.CHECK.Failed)

            -- bindData
            local ques = itemData.query
            local answer = itemData.reply
            unfoldQuesTxt:setText(ques)
            unfoldAnswerTxt:setText(answer)
            foldQuesTxt:setText(self:converStrLength(ques, 35))
            foldAnswerTxt:setText(self:converStrLength(answer, 60))
            labCheckResultInput:setText(itemData.reason)

            local function foldCallFuc()
                foldPannel:setVisible(not foldPannel:isVisible())
                unfoldPannel:setVisible(not unfoldPannel:isVisible())
            end
            bg2:onClick(function()
                foldCallFuc()
            end)
            btn_fold:onClick(function()
                foldCallFuc()
            end)
        end
        -- 
        if idx == RoleTachMacro.CHECK.Doing then
            local time = string.split(itemData.addTime, " ")
            TFDirector:getChildByPath(onChecking,"quesTxt"):setText(itemData.query)
            TFDirector:getChildByPath(onChecking,"answerInput"):setText(itemData.reply)
            TFDirector:getChildByPath(onChecking,"teachCheckCommitDate"):setText(time[1])
        elseif idx == RoleTachMacro.CHECK.Success then
            local time = string.split(itemData.auditTime, " ")
            TFDirector:getChildByPath(foldPannel,"teachCheckCommitDate"):setText(time[1])
            bg:setTexture("ui/iphoneX/roleTeach/teach/024.png")
            foldPannel:getChildByName("imgEmotion"):setTexture("ui/iphoneX/roleTeach/teach/eom5.png")
            unfoldPannel:getChildByName("imgEmotion"):setTexture("ui/iphoneX/roleTeach/teach/eom5.png")
        elseif idx == RoleTachMacro.CHECK.Failed then
            local time = string.split(itemData.auditTime, " ")
            TFDirector:getChildByPath(foldPannel,"teachCheckCommitDate"):setText(time[1])
            bg:setTexture("ui/iphoneX/roleTeach/teach/020.png")
            foldPannel:getChildByName("imgEmotion"):setTexture("ui/iphoneX/roleTeach/teach/eom1.png")
            unfoldPannel:getChildByName("imgEmotion"):setTexture("ui/iphoneX/roleTeach/teach/eom1.png")
        end

        local btnTeachAgain = item:getChildByName("btnTeachAgain")
        if btnTeachAgain then
            btnTeachAgain:onClick(function()
                self:ChoosePageDetailFunc(RoleTachMacro.TEACH.TeachSelf,{unfoldQuesTxt:getString()})
            end)
        end

        self.scrollCheckView:pushBackCustomItem(item)
        ViewAnimationHelper.displayMoveNodes(self.scrollCheckView:getItems(), {direction = 2, distance = 250, wait = 0, delay = 0.1, time = 0.1})
    end

    self._ui.btnCheckUp:onClick(function()
        if data.page == 1 then
            return
        end
        RoleTeachDataMgr:SendCheckReques(self.checkType - 1, -1)
    end)
    self._ui.btnCheckNext:onClick(function()
        RoleTeachDataMgr:SendCheckReques(self.checkType - 1, 1)
    end)
    
end

--
function RoleTeachFuncLayer:converStrLength(str, length)
    str = tostring(str)
    local len = string.len(str)
    local keepTxt = ""
    if len <= length then
        keepTxt = str
    else
        length = length - 2
        -- 最后一位为中文乱码去掉
        local ascll 
        while (length > 0) do
            ascll = string.byte(str, length + 1)
            if  ascll > 127 and ascll < 192 then
                length = length - 1
            else
                break
            end
        end
        keepTxt = string.sub(str, 1,length).."……"
    end
    return keepTxt
end

function RoleTeachFuncLayer:pannelRankControl(idx)
    self:helpPannelShow(self.PageUI[RoleTachMacro.PAGETYPE.RANK], "pannel_rankAll")
    local myRankData = RoleTeachDataMgr:getMyRankData(idx)

    if not myRankData then
        return
    end
    if myRankData.rank == 0 or myRankData.rank > 100 then
        self._ui.myrankNum:setTextById(14240013)
    else
        self._ui.myrankNum:setText(myRankData.rank)
    end
    self._ui.myHead:getChildByName("Image_head"):setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self._ui.myHead:getChildByName("Image_head_cover_frame"):setTexture(avatarFrameIcon)
    self._ui.myName:setText(MainPlayer:getPlayerName())
    local channelData = Utils:getKVP(49004,"ChannelIdList")
    local channelTxtID = channelData[myRankData.gid]
    if channelTxtID then
        self._ui.myChannel:setTextById(channelTxtID)
    else
        self._ui.myChannel:setTextById(63640)
    end
    self._ui.myTeachLv:setText(myRankData.trainLv)
    local pass = 0
    if myRankData.totalNum ~= 0 then
        pass = myRankData.sucNum/myRankData.totalNum * 100
        pass = pass > 100 and 100 or pass
        pass = string.format("%.2f", pass)
    end
    self._ui.myPassed:setText(pass.."%")
    self._ui.myPassedNum:setText(myRankData.sucNum)
end

function RoleTeachFuncLayer:teachCheckBtnChoose(idx)
    for i, img in ipairs(self._ui.checkboxList:getChildren()) do
        local selectImg = img:getChildByName("imgSelectCheckBox")
        if idx == 1 then -- 通用类型
            selectImg:setVisible(i == 1)
            self.fellIds = {}
        else
            if idx == i then
                local _exist
                for j, tag in ipairs(self.fellIds) do
                    if tag == idx then 
                        _exist = true 
                        table.remove(self.fellIds, j)
                    end
                end
                if not _exist then
                    table.insert(self.fellIds, idx)
                end
                selectImg:setVisible(i ~= 1 and not _exist)
                if #self.fellIds == 0 then
                    self:teachCheckBtnChoose(1)
                end
            elseif i == 1 then
                selectImg:setVisible(false)
            end
        end
    end
end

-- 刷新红点
function RoleTeachFuncLayer:refreshRed()
    -- 调教
    local redData = RoleTeachDataMgr:getTeachRedShow()
    for _, btn in ipairs(self._ui.pannel_Teach:getChildByName("chooseBtns"):getChildren()) do
        local redImg = btn:getChildByName("redNew")
        local n =  string.gsub(btn:getName(),"btn_","")
        n = tonumber(n)
        if redImg then
            if n == RoleTachMacro.TEACH.Issue then
                redImg:setVisible(redData[n])
            elseif n == RoleTachMacro.TEACH.CHECK then
                if redData[n][RoleTachMacro.CHECK.Success] or redData[n][RoleTachMacro.CHECK.Failed] then
                    redImg:setVisible(true)
                else
                    redImg:setVisible(false)
                end
            end
        end
    end
    for _, btn in ipairs(self._ui.checkBtns:getChildren()) do
        local redImg = btn:getChildByName("redNew")
        local n = string.gsub(btn:getName(),"btnCheck_","")
        n = tonumber(n)
        if redImg then
            if n == RoleTachMacro.CHECK.Success or n == RoleTachMacro.CHECK.Failed  then
                redImg:setVisible(redData[RoleTachMacro.TEACH.CHECK][n])
            end
        end
    end
end

-- 刷新界面 
function RoleTeachFuncLayer:refreshView()
    self:ChoosePageShow(self.pageIdx)
    self:ChoosePageDetailFunc(self.chooseType, self.dataTab)
end

return RoleTeachFuncLayer