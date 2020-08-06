local KsOutRankView = class("KsOutRankView",BaseLayer)

function KsOutRankView:initData()
    self.rankData = {}
    self.rewardsData = {[1] = {},[2] = {}}
    local activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)[1]
    local data = ActivityDataMgr2:getActivityInfo(activityId) or {}

    local dataRank = data.historyRank or {}  
    for i, v in ipairs(dataRank) do
        if v.camp then
            self.rankData[v.camp] = v or {}
        end
    end

    local tab = {rankStr = nil,awards = nil}
    local rewardData = data.extendData.top100Reward or {}
    local _idx = 0
    for i = 1, #rewardData do
        _idx = _idx + 1
        if _idx <= 2 then
            local dis
            if type(rewardData[i]) == "number" then
                tab.rankStr = "1"
                if i ~= 1 then 
                    dis = rewardData[i] - rewardData[i - 2]
                    tab.rankStr = dis == 1 and rewardData[i] or (rewardData[i - 2] + 1).."~"..rewardData[i]
                end
                tab.awards = rewardData[i+1]
            end

            if _idx == 2 and tab.rankStr then
                table.insert( self.rewardsData[1],tab)
                tab = {rankStr = nil,awards = nil}
                _idx = 0
            end
        end
    end
    
    local rewardCapmData = data.extendData.campReward or {}
    for i, v in ipairs(rewardCapmData) do
        local rewardCapmTab = {rankStr = nil,awards = nil}
        rewardCapmTab.rankStr = i
        rewardCapmTab.awards = v
        table.insert(self.rewardsData[2], rewardCapmTab)
    end

    self.chooseCamp = 1

    for camp = 1 ,2 do
        if self.rankData[camp] and self.rankData[camp].innerRank then
            table.sort(self.rankData[camp].innerRank, function(a,b)
                return a.rank < b.rank
            end)
        end
    end
end

function KsOutRankView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:setUsepreProcesUI()
    self:init("lua.uiconfig.activity.rankPopView")
end

function KsOutRankView:initUI(ui)
    self.super.initUI(self, ui)

    self.dataTableView = Utils:scrollView2TableView(self._ui.dataView)
    self.dataTableView.oldPos = self.dataTableView:getPosition()
    self.dataTableView.oldSize = self.dataTableView:getViewSize()

    self.rewardView1 = UIListView:create(self._ui.rewardView1)
    self.rewardView1:setItemsMargin(5)
    self.rewardView2 = UIListView:create(self._ui.rewardView2)
    self.rewardView2:setItemsMargin(5)

    self._ui.labTopTip:setTextById(12032035)

    self:chooseView(1)
    self:rewardRefresh(1)
end

function KsOutRankView:registerEvents()
    EventMgr:addEventListener(self, EV_RECV_PLAYERINFO, handler(self.onGetPlayInfoEvent, self))
    EventMgr:addEventListener(self, EV_KUANGSAN_FUBEN_RANKS,function()
        self:initData()
        self:campRefrehsh(self.chooseCamp)
    end)

    self._ui.btnClose:onClick(function()
        AlertManager:closeLayer(self)
    end)

    for _, btn in ipairs(self._ui.chooseRightBtns:getChildren()) do
        local n = string.gsub(btn:getName(),"btn","")
        n = tonumber(n)
        btn:setTouchEnabled(true)
        btn:onClick(function()
            self:chooseView(n)
        end)
    end

    -- 阵营
    for _,campBtn in ipairs(self._ui.campBtns:getChildren()) do
        local idx = string.gsub(campBtn:getName(),"campImg","")
        idx = tonumber(idx)
        campBtn:setTouchEnabled(true)
        campBtn:onClick(function()
            self:campRefrehsh(idx)
        end)
    end

    -- 奖励
    for _, rewardBtn in ipairs(self._ui.rewardBtns:getChildren()) do
        local idx = string.gsub(rewardBtn:getName(),"img","")
        idx = tonumber(idx)
        rewardBtn:setTouchEnabled(true)
        rewardBtn:onClick(function()
            self:rewardRefresh(idx)
        end)
    end

    -- tableview
    self.dataTableView:addMEListener(TFTABLEVIEW_SIZEFORINDEX, handler(self.rankCellSize,self))
    self.dataTableView:addMEListener(TFTABLEVIEW_NUMOFCELLSINTABLEVIEW, handler(self.numberOfCells,self))
    self.dataTableView:addMEListener(TFTABLEVIEW_SIZEATINDEX, handler(self.tableCellAtIndex,self))
    --
    self:campRefrehsh(1)
end

function KsOutRankView:onGetPlayInfoEvent(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end

function KsOutRankView:chooseView(n)
    for _, btn in ipairs(self._ui.chooseRightBtns:getChildren()) do
        local i = string.gsub(btn:getName(),"btn","")
        i = tonumber(i)
        local imgSelect = btn:getChildByName("imgSelect")
        imgSelect:setVisible(n == i)
    end

    for _, pannel in ipairs(self._ui.pannleLeft:getChildren()) do
        local tag = string.gsub(pannel:getName(),"pannelLeft","")
        tag = tonumber(tag)
        pannel:setVisible(tag == n)
    end
end

function KsOutRankView:campRefrehsh(idx)
    self.chooseCamp = idx
    for _,campBtn in ipairs(self._ui.campBtns:getChildren()) do
        local _idx = string.gsub(campBtn:getName(),"campImg","")
        _idx = tonumber(_idx)
        if _idx == idx then
            campBtn:setTexture("ui/activity/kuangsan_fuben/pop/010.png")
            campBtn:setOpacity(255)
        else
            campBtn:setTexture("ui/activity/kuangsan_fuben/pop/009.png")
            campBtn:setOpacity(127)
        end
    end

    self:refreshMyRankData()
    self.dataTableView:reloadData()

    -- local pos = self.dataTableView:getContentOffset()
    local size = self.dataTableView:getContentSize()
    self.dataTableView:setContentOffsetInDuration(ccp(0,-size.height),0)
end

function KsOutRankView:refreshMyRankData()
    local data = self.rankData[self.chooseCamp]
    local myRankData = data and data.selfRank
    local isExistMyRank = nil ~= myRankData

    self._ui.imgMyData:setVisible(isExistMyRank)
    self._ui.imgRefreshBg:setVisible(isExistMyRank)
    local newPos = self._ui.imgMyData:getPosition()
    local addHeight = self._ui.imgMyData:getContentSize().height
    local viewSize = self.dataTableView.oldSize
    -- 
    -- if  data and data.innerRank and #data.innerRank > 3 then
    if self._ui.imgMyData:isVisible() then
        self.dataTableView:Pos(self.dataTableView.oldPos)
        self.dataTableView:setViewSize(viewSize)
    else
        self.dataTableView:Pos(ccp(newPos.x, newPos.y))
        self.dataTableView:setViewSize(ccs(viewSize.width,viewSize.height + addHeight))
    end
        -- self.dataTableView:AnchorPoint(ccp(0,0))
        -- self.dataTableView:setDirection(TFTableView.TFSCROLLVERTICAL)
    self.dataTableView:setVerticalFillOrder(TFTableView.TFTabViewFILLTOPDOWN)
    -- end

    if not isExistMyRank  then
        return
    end

    if myRankData.rank == 0 or myRankData.rank > 100 then
        self._ui.myDataRankNum:setTextById(14240013)
    else
        self._ui.myDataRankNum:setText(myRankData.rank)
    end
    self._ui.myDataRankNum:setSkewX(15)
    self._ui.myImage_head:setTexture(AvatarDataMgr:getSelfAvatarIconPath())
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath()
    self._ui.myImage_head_frame_cover:setTexture(avatarFrameIcon)
    self._ui.myName:setText(MainPlayer:getPlayerName())
    self._ui.myLv:setText("LV."..MainPlayer:getPlayerLv())
    self._ui.myTime:setSkewX(15)
    self._ui.myTime:setText(self:setTime(myRankData.bestTime))
end

function KsOutRankView:rewardRefresh(idx)
    for _, rewardBtn in ipairs(self._ui.rewardBtns:getChildren()) do
        local _idx = string.gsub(rewardBtn:getName(),"img","")
        _idx = tonumber(_idx)
        if _idx == idx then
            rewardBtn:setTexture("ui/activity/kuangsan_fuben/pop/019.png")
        else
            rewardBtn:setTexture("ui/activity/kuangsan_fuben/pop/020.png")
        end
    end

    self.rewardView1:setVisible(idx == 1)
    self.rewardView2:setVisible(idx == 2)
    if idx == 1 and #self.rewardView1:getItems() == 0 then
        self:updateRewardView(self.rewardView1,idx)
    elseif idx == 2 and #self.rewardView2:getItems() == 0 then
        self:updateRewardView(self.rewardView2,idx)
    end
end

function KsOutRankView:updateRewardView(view, i)
    local data = self.rewardsData[i]
    local num = #data
    view:removeAllItems()
    for j = 1, num do
        local item = self._ui.rewardRankItem:clone()
        local rewardBg = item:getChildByName("rewardBg")
        local labRewardNum = item:getChildByName("labRewardNum")
        labRewardNum:setSkewX(15)
        local rewardItems = item:getChildByName("rewardItems")
        if num % 2 == 0 then
            rewardBg:setTexture("ui/activity/kuangsan_fuben/pop/021.png")
        else
            rewardBg:setTexture("ui/activity/kuangsan_fuben/pop/022.png")
        end

        local idx = 1
        local maxNum = #rewardItems:getChildren()
        for id, value in pairs(data[j].awards) do
            if idx > maxNum then
                return
            end 
            local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            goods:setScale(0.6)
            PrefabDataMgr:setInfo(goods, tonumber(id), value)
            local parent = rewardItems:getChildByName(string.format("rewardPos%d", idx))
            goods:AddTo(parent):Pos(0,0)
            idx = idx + 1
        end
        labRewardNum:setText(data[j].rankStr)
        view:pushBackCustomItem(item)
    end
end

function KsOutRankView:rankCellSize(tableView, idx)
    local size = self._ui.dataRankItem:getSize()
    return size.height + 5, size.width
end

function KsOutRankView:numberOfCells(tableView)
    local data = self.rankData[self.chooseCamp] 
    data = data and data.innerRank
    local num = data and #data or 0
    return num
end

function KsOutRankView:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local index = idx + 1
    local item = nil

    if nil == cell then
        cell = TFTableViewCell:create()
        item = self._ui.dataRankItem:clone()

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

function KsOutRankView:refreshCellItem(item,idx)
    local data = self.rankData[self.chooseCamp].innerRank[idx] or {}

    local bg = TFDirector:getChildByPath(item,"dataItemBg")
    local dataRankItemIcon = TFDirector:getChildByPath(item,"dataRankItemIcon")
    local dataRankNum = TFDirector:getChildByPath(dataRankItemIcon,"dataRankNum")
    dataRankNum:setSkewX(15)
    local dataPlayerHead = TFDirector:getChildByPath(item,"dataPlayerHead")
    local Image_head = TFDirector:getChildByPath(dataPlayerHead,"Image_head")
    local Image_head_frame_cover = TFDirector:getChildByPath(dataPlayerHead,"Image_head_frame_cover")
    local playerName = TFDirector:getChildByPath(item,"playerName")
    local playerLv = TFDirector:getChildByPath(item,"playerLv")
    local useTime = TFDirector:getChildByPath(item,"useTime")
    useTime:setSkewX(15)

    if idx % 2 == 0 then
        bg:setTexture("ui/activity/kuangsan_fuben/pop/013.png")
    else
        bg:setTexture("ui/activity/kuangsan_fuben/pop/014.png")
    end

    dataRankNum:setText(data.rank)
    Image_head:setTexture(AvatarDataMgr:getAvatarIconPath(data.headId))
    local avatarFrameIcon,avatarFrameEffect = AvatarDataMgr:getSelfAvatarFrameIconPath(data.headFrame)
    Image_head_frame_cover:setTexture(avatarFrameIcon)
    playerName:setText(data.pName)
    playerLv:setText("LV."..data.level)
    useTime:setText(self:setTime(data.bestTime))

    Image_head:setTouchEnabled(true)
	Image_head:onClick(function ()
		if data.pid then
        	TFDirector:send(c2s.PLAYER_REQ_TARGET_PLAYER_INFO,{data.pid})
		end
	end)
end

function KsOutRankView:setTime(mTime)
    local timeTxt = ""
    local min = string.format( "%02d", math.floor(mTime / (60 * 1000)))
    local sec = string.format( "%02d", math.floor((mTime - min*60*1000) / 1000))
    local mSec = string.format( "%03d", mTime % 1000)
    timeTxt = min..":"..sec.."."..mSec
    return timeTxt
end

return KsOutRankView