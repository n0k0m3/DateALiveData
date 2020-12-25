
local t = {
    --分辨率
    {{1024, 768},{1280, 720},{2436 , 1125},{1136, 640},{960, 640},{2048 , 1536 },{2400,1080},{1600,720}},
    --货币
    {500001,500002,500003,500004,500005,500018,500019,500020,500021,500022,500023,500024,500025},
    --经验卡
    {510101,510102,510103,510104,510105},
    --聚合晶石
    {555010,555011,555012,555013,555014},
    --突破道具
    {510201,510202,510203,510204,510205,510206,510207,510208,510209,510210,510211,510212,510213,510214,510215,510216,510217,510218,510219,510220,510221,510222,510223,510224,510225,510226,510227,510228,510229,510230,510231,510232,510233,510234,510235,510236,510237,510238,510239,510240},
    --碎片
    {510301,510302,510303,510304,510306,510307,510308,510309,510310,510311,510312,510313,510314,510315,510316,510317},
    --材料
    {532101,532102,532103,532104,532105,532106,532107,532108,532109,532201,532202,532203,532204,532205,532206,532301,532302,532303,533101,533102,533103,533104,533105,533106,533107,533108,533109,533201,533202,533203,533204,533205,533206,533301,533302,533303},
    --食物
    {534011,534012,534013,534021,534022,534023,534031,534032,534033,534042,534043,534044,534052,534053,534054,534062,534063,534064,534073,534074,534075,534083,534084,534085,534093,534094,534095,534101,534102,534103,534111,534112,534113,534121,534122,534123,534132,534133,534134,534142,534143,534144,534152,534153,534154,534163,534164,534165,534173,534174,534175,534183,534184,534185,534191,534192,534193,534201,534202,534203,534211,534212,534213,534222,534223,534224,534232,534233,534234,534242,534243,534244,534253,534254,534255,534263,534264,534265,534273,534274,534275},
    --礼物
    {535011,535012,535013,535021,535022,535023,535031,535032,535033,535042,535043,535044,535052,535053,535054,535062,535063,535064,535073,535074,535075,535083,535084,535085,535093,535094,535095,535101,535102,535103,535111,535112,535113,535121,535122,535123,535132,535133,535134,535142,535143,535144,535152,535153,535154,535163,535164,535165,535173,535174,535175,535183,535184,535185,535191,535192,535193,535201,535202,535203,535211,535212,535213,535222,535223,535224,535232,535233,535234,535242,535243,535244,535253,535254,535255,535263,535264,535265,535273,535274,535275},
    --兑换
    {570001,570002,570003,570004,570005,570006,570007,570008,570009,570010,570011,570012,570013,570014,570015,570016,570017,570018,570019,570020,570021,570022,570023,570024,570025,570026,570027,570028,570029,570031,570032,570033,570101,570102,570103,570104,570105,570106,570107,570108,570109,570110,570111},
    --灵装

}

local headName = {
    "分辨率",
    "货币",
    "经验卡",
    "聚合晶石",
    "突破道具",
    "碎片",
    "材料",
    "食物",
    "礼物",
    "兑换",
    --"灵装"
}

local TestType = {
    Normal = 1,
    Summon = 2,
}

local selectnum = 1;
local Concent = t[selectnum];

local GMView = class("GMView", BaseLayer)

function GMView:initData()

end

function GMView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.test.gmView")

    TFDirector:addProto(274, self, self.recvHeartBeatEvent)
end

function GMView:recvHeartBeatEvent(event)
    dump(event);
end

function GMView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.TextField_cmd = TFDirector:getChildByPath(self.Panel_root, "TextField_cmd")
    self.Button_send = TFDirector:getChildByPath(self.Panel_root, "Button_send")
    self.Panel_head     = TFDirector:getChildByPath(self.Panel_root,"Panel_head");
    self.Panel_content  = TFDirector:getChildByPath(self.Panel_root,"Panel_content")
    self.Panel_item     = TFDirector:getChildByPath(self.Panel_root,"Panel_item")
    self.Panel_head_item = TFDirector:getChildByPath(self.Panel_root,"Panel_head_item");

    self.Panel_quick = TFDirector:getChildByPath(self.Panel_root, "Panel_quick")
    self.Button_addItem = TFDirector:getChildByPath(self.Panel_quick, "Button_addItem")
    self.TextField_addItem = TFDirector:getChildByPath(self.Panel_quick, "Panel_addItem.TextField_addItem")
    self.Button_favor = TFDirector:getChildByPath(self.Panel_quick, "Button_favor")
    self.Button_getDate = TFDirector:getChildByPath(self.Panel_quick, "Button_getDate")
    self.Button_closeSocket = TFDirector:getChildByPath(self.Panel_quick, "Button_closeSocket")

    self.btn_demo = TFDirector:getChildByPath(ui, "btn_demo"):hide()
    self.Button_funTest = TFDirector:getChildByPath(self.Panel_quick, "Button_funTest")
    local btn_list = TFDirector:getChildByPath(self.Panel_quick, "btn_list"):hide()
    self.btnList = UIListView:create(btn_list)
    self.btnList:setItemsMargin(1)
    self:addFunBtn("特权")
    self:addFunBtn("个人特权")
    self:addFunBtn("时装活动")
    self:addFunBtn("周年庆商店")
    self:addFunBtn("气球活动")
    self:addFunBtn("进入周年庆大世界")
    self:addFunBtn("新补给站")
    self:addFunBtn("模拟召唤")
    self:addFunBtn("周年庆活动")

    self.Panel_summon =  TFDirector:getChildByPath(self.Panel_root, "Panel_summon")
    self.TextField_PoolId = TFDirector:getChildByPath(self.Panel_summon, "TextField_PoolId")
    self.TextField_summonCnt = TFDirector:getChildByPath(self.Panel_summon, "TextField_summonCnt")
    self.Button_startSummon = TFDirector:getChildByPath(self.Panel_summon, "Button_startSummon")
    self.Button_save = TFDirector:getChildByPath(self.Panel_summon, "Button_save")
    local ScrollView_summon_result = TFDirector:getChildByPath(self.Panel_summon, "ScrollView_summon_result")
    self.ListView_summon_result  = UIListView:create(ScrollView_summon_result)
    self.Panel_summom_item = TFDirector:getChildByPath(self.Panel_summon, "Panel_summom_item"):hide()
    self.Label_poolId =TFDirector:getChildByPath(self.Panel_summon, "Label_poolId")
    self.Label_summonCnt =TFDirector:getChildByPath(self.Panel_summon, "Label_summonCnt")
    self.Label_openTime =TFDirector:getChildByPath(self.Panel_summon, "Label_openTime")
    self.Label_closeTime =TFDirector:getChildByPath(self.Panel_summon, "Label_closeTime")
    self.Label_poolId:setText("召唤ID：")
    self.Label_summonCnt:setText("模拟次数：")
    self.Label_openTime:setText("开始时间：")
    self.Label_closeTime:setText("输出结果：")

    self.Panel_unlockFB = {}
    for i = 1, 4 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_quick, "Panel_unlockFB_" .. i)
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.TextField_input = TFDirector:getChildByPath(item.root, "Panel_input.TextField_input")
        item.Button_unlock = TFDirector:getChildByPath(item.root, "Button_unlock")
        self.Panel_unlockFB[i] = item
    end

    self.chooseTab = {}
    for i=1,2 do
        local btn = TFDirector:getChildByPath(self.Panel_root, "Button_tab_" .. i)
        local select = TFDirector:getChildByPath(btn, "Image_select")
        local Label_btn = TFDirector:getChildByPath(btn, "Label_btn")
        table.insert(self.chooseTab,{btn = btn, select = select, btnTx = Label_btn})
    end

    self.Button_close = TFDirector:getChildByPath(self.Panel_root, "Button_close")

    self:initHeadTableView();
    self:initConcentTableView();
    self:refreshView()

    self.tableView:reloadData();
    self.ContentTableView:reloadData();

    self:chooseTestType(TestType.Normal)
end

function GMView:addFunBtn(name)
    local btnItem = self.btn_demo:clone()
    btnItem:show()
    local btn_label = TFDirector:getChildByPath(btnItem, "btn_label")
    btn_label:setText(name)
    self.btnList:pushBackCustomItem(btnItem)
end

function GMView:initHeadTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("Head")
    local tableViewSize = self.Panel_head:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLHORIZONTAL)
    tableView:setPosition(self.Panel_head:getPosition())
    tableView:setAnchorPoint(self.Panel_head:getAnchorPoint());
    self.tableView = tableView

    self.tableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, GMView.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, GMView.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, GMView.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, GMView.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, GMView.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, GMView.cellEnd)


    self.Panel_head:getParent():addChild(self.tableView,10)
end


function GMView:initConcentTableView()
    local  tableView =  TFTableView:create()
    tableView:setName("Concent")
    local tableViewSize = self.Panel_content:getContentSize()
    tableView:setTableViewSize(CCSizeMake(tableViewSize.width, tableViewSize.height))
    tableView:setDirection(TFTableView.TFSCROLLVERTICAL)
    tableView:setPosition(self.Panel_content:getPosition())
    tableView:setAnchorPoint(self.Panel_content:getAnchorPoint());
    self.ContentTableView = tableView

    self.ContentTableView.logic = self

    tableView:addMEListener(TFTABLEVIEW_TOUCHED, GMView.tableCellTouched)
    tableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, GMView.cellSizeForTable)
    tableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, GMView.tableCellAtIndex)
    tableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, GMView.numberOfCellsInTableView)


    tableView:addMEListener(TFTABLEVIEW_CELLISBEGIN, GMView.cellBegin)
    tableView:addMEListener(TFTABLEVIEW_CELLISEND, GMView.cellEnd)


    self.Panel_content:getParent():addChild(self.ContentTableView,10)
end


function GMView.tableCellTouched(table,cell)
    local self = cell.logic
    local name = table:getName();
    if name == "Head" then
        local idx = cell.idx;
        selectnum = idx
        Concent = t[idx];
        self.ContentTableView:reloadData();
    end
end

function GMView.tableCellAtIndex(tab, idx)
    local name = tab:getName();

    print("name = " .. name );
    local cellItem = nil;
    if name == "Head" then
        idx = idx + 1
        cellItem = self.Panel_head_item;
    else
        cellItem = self.Panel_item;
        idx = math.abs(#Concent - idx);
    end


    local self = tab.logic
    local cell = tab:dequeueCell();
    if cell == nil then
        tab.cells = tab.cells or {}
        cell = TFTableViewCell:create();
        local item = cellItem:clone();
        item:setAnchorPoint(CCPointMake(0,0))
        item:setPosition(CCPointMake(0, 0))
        cell:addChild(item);
        cell.item = item;
    end

    if cell.item then
        if name == "Head" then
            local name = TFDirector:getChildByPath(cell.item,"Label_name")
            name:setString(headName[idx]);
        else
            local nameLab = TFDirector:getChildByPath(cell.item,"Label_name")
            local input = TFDirector:getChildByPath(cell.item,"TextField_number");
            local okBtn = TFDirector:getChildByPath(cell.item,"Button_ok");
            if selectnum == 1 then
                nameLab:setString(Concent[idx][1].."x"..Concent[idx][2]);
                input:hide();
                okBtn:getChildByName("Label_name"):setString("设置");
            else
                input:show();
                nameLab:setTextById(TabDataMgr:getData("Item",Concent[idx]).nameTextId);
            end


            okBtn:onClick(function()

                    if selectnum == 1 then
                        self:setFarmeSize(idx);
                        return;
                    end

                    local num = input:getText();
                    print("num = "..num);
                    if num == "" then
                        num = 1;
                    else
                        num = tonumber(num);
                    end

                    local cmd = self:getCmd(Concent[idx],num);
                    local chatState = EC_ChatState.CHAT
                    TFDirector:send(c2s.CHAT_CHAT, {1,chatState,cmd})

                    --TFDirector:send(274,{1})
                end)
        end
    end

    cell.idx = idx
    cell.logic = self;
    return cell;
end

function GMView:setFarmeSize(idx)
    local pDirector = CCDirector:sharedDirector();
    local width = Concent[idx][1];
    local height = Concent[idx][2];

    if width > 1440 then
        width = width * 0.6;
        height = height * 0.6
    end

    CCUserDefault:sharedUserDefault():setIntegerForKey("fenbianlvX",width)
    CCUserDefault:sharedUserDefault():setIntegerForKey("fenbianlvY",height)
    TFDirector:dispatchGlobalEventWith("Engine_Will_Restart", {})
    restartLuaEngine("");
    -- pDirector:getOpenGLView():setFrameSize(width, height);
    -- local frameSize = pDirector:getOpenGLView():getFrameSize();
    -- local baseSize = CCSize(1136 , 640);

    --  local realSize = CCSize(math.ceil(frameSize.width * baseSize.height / frameSize.height) , baseSize.height);

    -- -- if (realSize.width >= 1136)  then
    -- --    --背景图片最长为1136，所以设置上限
    -- --    pDirector:getOpenGLView():setDesignResolutionSize(1136, realSize.height, kResolutionShowAll);
    -- if (realSize.width >= baseSize.width) then
    --     --960 - 1136，通过对齐等方案，实现适配
    --     pDirector:getOpenGLView():setDesignResolutionSize(realSize.width, realSize.height, kResolutionShowAll);
    -- else
    --     -- realSize = CCSize(baseSize.width, math.ceil(frameSize.height * baseSize.width / frameSize.width));
    --     -- pDirector:getOpenGLView():setDesignResolutionSize(realSize.width, realSize.height, kResolutionShowAll);

    --     --UI制作安全大小为960，所以设置下限
    --     pDirector:getOpenGLView():setDesignResolutionSize(baseSize.width, realSize.height, kResolutionShowAll);
    -- end
end

function GMView.numberOfCellsInTableView(table)
    local self = table.logic
    local name = table:getName();
    if name == "Head" then
        return #t
    else
        return #Concent
    end
end

function GMView.cellBegin(table)
    local self = table.logic
end

function GMView.cellEnd(table)
    local self = table.logic
end

function GMView.cellSizeForTable(table,idx)
    self = table.logic
    local name = table:getName();
    if name == "Head" then
        return self.Panel_head_item:getSize().height,self.Panel_head_item:getSize().width
    else
        return self.Panel_item:getSize().height,self.Panel_item:getSize().width
    end
end

function GMView:refreshView()

end

function GMView:getCmd(itemId, itemNum)
    return string.format("./addItems %s %s", itemId, itemNum)
end


function GMView:chooseTestType(chooseId)

    for k,v in ipairs(self.chooseTab) do
        v.select:setVisible(chooseId == k)
        local color = chooseId == k and me.WHITE or me.BLACK
        v.btnTx:setColor(color)
    end

    self.Panel_quick:setVisible(chooseId == TestType.Normal)
    self.Panel_summon:setVisible(chooseId == TestType.Summon)
end

function GMView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_UPDATEMAINLINEPROGRESS, handler(self.onUpdateMainLineProgressEvent, self))
    EventMgr:addEventListener(self, EV_GM_FIGHTSTART, handler(self.onFightStartEvent, self))
    EventMgr:addEventListener(self, EV_GM_FIGHTOVER, handler(self.onFightOverEvent, self))
    EventMgr:addEventListener(self, EV_GM_SUMMON_RESULT, handler(self.onRecvGMSummon, self))

    self.Button_addItem:onClick(function()
            local strCid = self.TextField_addItem:getText()
            local info = string.split(strCid, ":")
            local cid = tonumber(info[1])
            local num = tonumber(info[2] or 1)
            if cid then
                local cmd = self:getCmd(cid, num)
                local chatState = EC_ChatState.CHAT
				print("=================================cmd=" .. cmd)
                TFDirector:send(c2s.CHAT_CHAT, {1,chatState,cmd})
            else
                Utils:showTips("道具ID不合法")
            end
    end)

    self.Button_favor:onClick(function()
        AlertManager:closeLayer(self)
        local view = requireNew("lua.logic.newCity.NewCityFavorTestView"):new()
        AlertManager:addLayer(view, AlertManager.BLOCK_AND_GRAY_CLOSE)
        AlertManager:show()
    end)

    self.Button_send:onClick(function()
            local cmd = self.TextField_cmd:getText()
            local chatState = EC_ChatState.CHAT
            if #cmd > 0 then
                local args = {
                    1,
                    chatState,
                    cmd
                }

                TFDirector:send(c2s.CHAT_CHAT,args)
            end
            AlertManager:close()
    end)

    for i, v in ipairs(self.Panel_unlockFB) do
        v.Button_unlock:onClick(function()
                local content = v.TextField_input:getText()
                if #content > 0 then
                    if i == 1 then
                        self:unlockChapter(content)
                    elseif i == 2 then
                        self:unlockLevel(content)
                    elseif i == 3 then
                        local levelCid = tonumber(content)
                        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
                        if levelCfg then
                            local levelName = FubenDataMgr:getLevelName(levelCid)
                            local diffName = TextDataMgr:getText(EC_FBDiffName[levelCfg.difficulty])
                            Utils:showTips(string.format("%s难度：%s", diffName, levelName))
                        else
                            Utils:showTips("请输入正确的关卡id")
                        end
                    elseif i == 4 then
                        local allLevelName = FubenDataMgr:getAllLevelName()
                        local levelId = {}
                        for k, v in pairs(allLevelName) do
                            if v == content then
                                table.insert(levelId, k)
                            end
                        end
                        if #levelId > 0 then
                            table.sort(levelId, function(a, b)
                                           local cfgA = FubenDataMgr:getLevelCfg(a)
                                           local cfgB = FubenDataMgr:getLevelCfg(b)
                                           return cfgA.difficulty < cfgB.difficulty
                            end)
                            local str = table.concat(levelId, " - ")
                            Utils:showTips("关卡ID：" .. str)
                        else
                            Utils:showTips("关卡名不存在")
                        end
                    end
                else
                    Utils:showTips("请输入正确的id")
                end
        end)
    end

    self.Button_getDate:onClick(function()
            local serverTime = ServerDataMgr:getServerTime()
            local date = TFDate(serverTime):tolocal()
            Utils:showTips(date:fmt())
    end)

    for k,v in ipairs(self.chooseTab) do
        v.btn:onClick(function()
            if k == self.chooseId then
                return
            end
            self:chooseTestType(k)
        end)
    end

    self.Button_startSummon:onClick(function()
        self:startTestSummmon()
    end)

    self.Button_save:onClick(function()
        self:saveSummonResult()
    end)

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_closeSocket:onClick(function()
        TFDirector:closeSocket()
    end)

    for k, v in ipairs(self.btnList:getItems()) do
        v:onClick(function()
            self:runFunTest(k)
        end)
    end

    self.Button_funTest:onClick(function()
        self.btnList:setVisible(not self.btnList:s():isVisible())
    end)
end

function GMView:runFunTest(index)

    if index == 1 then
        Utils:openView("privilege.PrivilegeLeagueView")
    elseif index == 2 then
        Utils:openView("activity.twoyear.PersonInfoBase",3)
    elseif index == 3 then
        Utils:openView("activity.twoyear.FashionStore")
    elseif index == 4 then
        Utils:openView("activity.twoyear.StorePackMainView")
        --SimulationSummonDataMgr:reqSimulateSummonInfo()
    elseif index == 5 then
        Utils:openView("balloon.BalloonMainView")

    elseif index == 6 then
        TFDirector:send(c2s.NEW_WORLD_REQ_PRE_ENTER_NEW_WORLD,{3})
    elseif index == 7 then
        -- FunctionDataMgr:jTurnTable()
         Utils:openView("supplyNew.SupplyMainNewView")
    elseif index == 8 then
        SimulationSummonDataMgr:reqSimulateSummonInfo()
    elseif index == 9 then
        FunctionDataMgr:jActivity7()
    end
end

function GMView:onRecvGMSummon()
    self.summonResul = {}
    local poolId,poolCount,startTime,endTime = SummonDataMgr:getGmSummonResult()
    local startDate = Utils:getLocalDate(startTime)
    local startDateStr = startTime == 0 and "" or startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(endTime)
    local endDateStr = endTime == 0 and "" or endDate:fmt("%Y.%m.%d")

    local poolIdStr = "召唤ID："..poolId
    local poolCountStr = "模拟次数："..poolCount
    startDateStr = "开始时间："..startDateStr
    endDateStr = "输出结果："..endDateStr

    table.insert(self.summonResul,poolIdStr)
    table.insert(self.summonResul,poolCountStr)
    table.insert(self.summonResul,startDateStr)
    table.insert(self.summonResul,endDateStr)
    table.insert(self.summonResul,"输出结果")

    self.Label_poolId:setText(poolIdStr)
    self.Label_summonCnt:setText(poolCountStr)
    self.Label_openTime:setText(startDateStr)
    self.Label_closeTime:setText(endDateStr)

    self.ListView_summon_result:removeAllItems()
    local statistics = SummonDataMgr:getGmSummonStatistics()
    if statistics and next(statistics) then
        table.sort(statistics,function(a,b)
            return a.probability < b.probability
        end)

        for k,v in ipairs(statistics) do
            local itemCLone = self.Panel_summom_item:clone()
            itemCLone:setVisible(true)
            self.ListView_summon_result:pushBackCustomItem(itemCLone)
            local Label_itemId = itemCLone:getChildByName("Label_itemId")
            Label_itemId:setText(v.id)

            local itemCfg = GoodsDataMgr:getItemCfg(v.id)
            local name = TextDataMgr:getText(itemCfg.nameTextId)
            local Label_itemName = itemCLone:getChildByName("Label_itemName")
            Label_itemName:setText(name)

            local Label_itemCnt = itemCLone:getChildByName("Label_itemCnt")
            Label_itemCnt:setText(v.num)

            local Label_voteCnt = itemCLone:getChildByName("Label_voteCnt")
            Label_voteCnt:setText(v.count)

            local Label_probability = itemCLone:getChildByName("Label_probability")
            local percent = string.format("%.2f",v.probability/100)
            Label_probability:setText(percent.."%")

            local str = string.format("id = %d,name = %s, num = %d, voteNum = %d, percent = %s, original = %d",v.id,name,v.num,v.count,percent.."%",v.probability)
            table.insert(self.summonResul,str)
        end
    end

    self.TextField_PoolId:setText("")
    self.TextField_summonCnt:setText("")
end

function GMView:startTestSummmon()

    self.TextField_PoolId = TFDirector:getChildByPath(self.Panel_summon, "TextField_PoolId")
    self.TextField_summonCnt = TFDirector:getChildByPath(self.Panel_summon, "TextField_summonCnt")

    local summonCid = self.TextField_PoolId:getText()
    local summonCnt = self.TextField_summonCnt:getText()
    summonCid = tonumber(summonCid)
    summonCnt = tonumber(summonCnt)

    if not summonCid then
        Utils:showTips("召唤ID：nil")
        return
    end

    if not summonCnt then
        Utils:showTips("召唤次数：nil")
        return
    end

    local isExist = SummonDataMgr:getSummonCfg(summonCid)
    if not isExist then
        Utils:showTips("Summon 不存在召唤ID："..summonCid)
        return
    end

    --local isOpen = false
    --local summon = SummonDataMgr:getAllSummon()
    --for k,v in ipairs(summon) do
    --    for i=1,2 do
    --        if v[i] and v[i].id == summonCid and v[i].isOpen then
    --            isOpen = true
    --            break
    --        end
    --    end
    --end
    --
    --if not isOpen then
    --    Utils:showTips("召唤ID："..summonCid.." 未开启")
    --    return
    --end

    if summonCnt <= 0 then
        Utils:showTips("召唤次数太小")
        return
    end

    if summonCnt > 10000 then
        Utils:showTips("召唤次数太大")
        return
    end

    local cmd = string.format("./summon %s %s", summonCid,summonCnt)
    local chatState = EC_ChatState.CHAT
    TFDirector:send(c2s.CHAT_CHAT, {1, chatState,cmd})
end

function GMView:saveSummonResult()

    if not self.summonResul or not next(self.summonResul) then
        return
    end

    local fileName = "GMSummon"
    local filePath = me.FileUtils:getWritablePath() .. 'cacheData/testSummon/'
    if TFFileUtil:existFile(filePath) == false then
        TFFileUtil:createDir(filePath)
    end

    local path = string.format("%s/%s.lua", filePath,fileName)
    local fileInfo = {}
    if TFFileUtil:existFile(path) then
        fileInfo = Utils:readTable(path)
    end
    fileInfo = fileInfo or {}
    for k,v in ipairs(self.summonResul) do
        table.insert(fileInfo,v)
    end
    Utils:writeTable(fileInfo , path)
    Utils:showTips("结果已保存至："..path)
    self.summonResul = {}
end


function GMView:unlockChapter(content)
    local ids = string.split(content, ":")
    for i, v in ipairs(ids) do
        local chapterCid = tonumber(v)
        local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
        if chapterCfg then
            local levelGroup = FubenDataMgr:getLevelGroup(chapterCid)
            local level = FubenDataMgr:getLevel(levelGroup[1], EC_FBDiff.SIMPLE)
            local levelCfg = FubenDataMgr:getLevelCfg(level[1])
            local cmd = string.format("./passGroup %s", levelCfg.levelGroupServerID)
            local chatState = EC_ChatState.CHAT
            TFDirector:send(c2s.CHAT_CHAT, {1, chatState,cmd})
        else
            local tip = string.format("找不到id为%s的章节", chapterCid)
            Utils:showTips(tip)
        end
    end
end

function GMView:unlockLevel(content)
    local ids = string.split(content, ":")
    for i, v in ipairs(ids) do
        local levelCid = tonumber(v)
        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
        if levelCfg then
            local cmd = string.format("./pass %s", levelCid)
            local chatState = EC_ChatState.CHAT
            TFDirector:send(c2s.CHAT_CHAT, {1, chatState,cmd})
        else
            local tip = string.format("找不到id为%s的关卡", levelCid)
            Utils:showTips(tip)
        end
    end
end

function GMView:onFightStartEvent(levelId)
    FubenDataMgr:send_DUNGEON_FIGHT_OVER(levelId, true, {1, 2, 3}, 1, 1, 1, true)
end

function GMView:onFightOverEvent(event)
    if self.levelGroup_coco then
        coroutine.resume(self.levelGroup_coco)
    end
end

function GMView:onUpdateMainLineProgressEvent(event)
    if self.levelGroup_coco then
        coroutine.resume(self.levelGroup_coco)
    end
end

return GMView
