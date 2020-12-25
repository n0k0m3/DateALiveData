--[[
    @desc:2020年春节活动-好友寄语界面
]]
local FriendSendWordView = class("FriendSendWordView", BaseLayer)

function FriendSendWordView:initData(...)
    self.activityId = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.FRIEND_BLESS)[1]
    self.activityCfgs = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.activityInfo = self.activityCfgs.extendData   
end

function FriendSendWordView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.friendSendWordView")
end

function FriendSendWordView:initUI(ui)
    self.super.initUI(self, ui)
    self.wordList = UIListView:create(self._ui.wordList)
    self.wordList:setItemModel(self._ui.Panel_Item)
    self.bar = UIScrollBar:create(self._ui.Image_scrollBarModel, self._ui.Image_scrollBarInner)
    self.bar:setVisible(false)
    self.wordList:setScrollBar(self.bar)
    -- self.wordList:setItemsMargin(5)
    self:updateView()
    self:refreshUI()
    self._ui.lab_giftDesc:setTextById(12103024)
end

function FriendSendWordView:registerEvents()
    self._ui.btn_preview:onClick(function()
        Utils:openView("activity.FrendWordTaskView")
    end)

    self._ui.btn_giveWord:onClick(function()
        Utils:openView("friend.FriendView")
    end)

    self._ui.btn_getAll:onClick(function()
        if FriendDataMgr:isBlessWordNoRead() then
            FriendDataMgr:send_SPRING_WISH_REQ_READ_ALL_SPRING_WISH()
        else
            Utils:showTips(12103029)
        end
    end)

    EventMgr:addEventListener(self, EV_FRIEND_WISHWORD_UPDATE,function()
        self:updateView()
        self:refreshUI()
    end)
end

function FriendSendWordView:updateView()
    local words = FriendDataMgr:getFriendWishWordDec()
    self._ui.img_noData:setVisible(#words == 0)
    self.wordList:setVisible(not self._ui.img_noData:isVisible())
    self.bar:setVisible(not self._ui.img_noData:isVisible())
    if #words == 0 then
        return
    end

    local items = self.wordList:getItems()
    local rowNum = math.ceil(#words / 3)
    local gap = rowNum - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.wordList:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.wordList:removeItem(1)
        end
    end

    local items = self.wordList:getItems()
    for i, v in ipairs(items) do
        for j = 1, 3 do
            local item = v:getChildByName("bag_"..j)
            local data = words[(i-1) * 3 + j]
            if data then
                item:setVisible(true)
                self:updateItem(item, data)
            else
                item:setVisible(false)
            end
        end
    end
end

function FriendSendWordView:updateItem(item,data)
    local pannel_showWord = item:getChildByName("pannel_showWord")
    local lab_playerName  = pannel_showWord:getChildByName("lab_playerName")
    local lab_words       = pannel_showWord:getChildByName("lab_words")
    local btn_delete      = pannel_showWord:getChildByName("btn_delete")

    local pannel_hideWord = item:getChildByName("pannel_hideWord")
    local btn_read        = pannel_hideWord:getChildByName("btn_read")
    local eff_spine       = pannel_hideWord:getChildByName("eff_spine")
    eff_spine:show()
    eff_spine:play("xunhuan",true)

    pannel_showWord:setVisible(data.read)
    pannel_hideWord:setVisible(not data.read)
    lab_playerName:setText(data.senderName)
    lab_words:setText(data.content)

    btn_read:onClick(function()
        eff_spine:play("fankai",false)
        eff_spine:addMEListener(TFARMATURE_COMPLETE,function(sklete)
            sklete:removeMEListener(TFARMATURE_COMPLETE)
            FriendDataMgr:send_SPRING_WISH_REQ_READ_SPRING_WISH(data.id)
        end)
    end)
    btn_delete:onClick(function()
        Utils:openView("chronoCross.ChronoTaskConfirmView",{titleStrId = 1702395,tipStrId = 12103030,},function()
            FriendDataMgr:send_SPRING_WISH_REQ_DELETE_SPRING_WISH(data.id)
        end)
    end)

end

function FriendSendWordView:refreshUI()
    local data = FriendDataMgr:getFriendWishWordData()
    if data then
        local lastNum = data.dayReceiveCount > self.activityInfo.sendLimit and self.activityInfo.sendLimit or data.dayReceiveCount
        self._ui.lab_lastNum:setText(lastNum.."/"..self.activityInfo.sendLimit)
        self._ui.lab_numSumWords:setText(data.totalReceiveCount)
        -- local nowCanGive = self.activityInfo.receiveLimit - data.daySendCount
        -- self._ui.lab_nowCanGive:setText(nowCanGive < 0 and 0 or nowCanGive)
        self._ui.lab_nowCanGive:setText(data.daySendCount)
        self._ui.lab_nowCanGive:setVisible(not ActivityDataMgr2:isEnd(self.activityId))
        self._ui.lab_lastNum:setVisible(self._ui.lab_nowCanGive:isVisible())
    end
    self._ui.lab_lastTime:setText(Utils:getActivityDateString(self.activityCfgs.startTime, self.activityCfgs.endTime))
end

return FriendSendWordView