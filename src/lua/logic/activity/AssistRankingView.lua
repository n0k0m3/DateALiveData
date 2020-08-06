local AssistRankingView = class("AssistRankingView", BaseLayer)

function AssistRankingView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.activity.assistRankingView")
end

function AssistRankingView:initData(data, myScore, scoreTitle, formatScoreFunc)
    myScore = myScore or data.myScore
    self.myScore_ = math.max(0, myScore)
    self.scoreTitle_ = scoreTitle
    self.formatScoreFunc_ = formatScoreFunc or function(score) return tostring(score) end
    self.ranking_data = data
end

function AssistRankingView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_rank_item = TFDirector:getChildByPath(ui, "Panel_rank_item")

    local Label_tittle = TFDirector:getChildByPath(ui, "Label_tittle")
    self.Label_tips1 = TFDirector:getChildByPath(ui, "Label_tips1")
    self.Label_tips2 = TFDirector:getChildByPath(ui, "Label_tips2")
    Label_tittle:setTextById(263001)
    self.Label_tips1:setTextById(263008)

    self.Label_my_rank = TFDirector:getChildByPath(ui, "Label_my_rank")
    self.Label_my_name = TFDirector:getChildByPath(ui, "Label_my_name")
    self.Label_my_value = TFDirector:getChildByPath(ui, "Label_my_value")
    self.Image_rank = TFDirector:getChildByPath(ui, "Image_rank")
    self.Label_assist = TFDirector:getChildByPath(ui, "Label_assist")

    self.Button_close = TFDirector:getChildByPath(ui, "Button_close")

    self.Button_close:onClick(function()
        AlertManager:closeLayer(self)
    end)

    local ScrollView_ranking = TFDirector:getChildByPath(ui, "ScrollView_ranking")
    self.ScrollView_ranking = UIListView:create(ScrollView_ranking)
    self.ScrollView_ranking:setItemsMargin(2)

    local Image_scrollBarModel = TFDirector:getChildByPath(ui, "Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    local scrollBar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
    self.ScrollView_ranking:setScrollBar(scrollBar)

    self:refreshView()
end

function AssistRankingView:refreshView()
    if self.ranking_data.myRank < 1 then
        self.Image_rank:setVisible(false)
        self.Label_my_rank:setVisible(true)
        self.Label_my_rank:setTextById(263009)
    elseif self.ranking_data.myRank <= 3 then
        self.Image_rank:setVisible(true)
        self.Label_my_rank:setVisible(false)
        local num = 37 + self.ranking_data.myRank
        self.Image_rank:setTexture("ui/activity/assist/0"..num..".png")
    else
        local rankStr = tostring("NO."..self.ranking_data.myRank)
        if self.ranking_data.myRank > 10000 then
            rankStr = ">10000"
        end
        self.Label_my_rank:setText(rankStr)
        self.Image_rank:setVisible(false)
        self.Label_my_rank:setVisible(true)
    end

    self.Label_assist:setTextById(self.scoreTitle_)
    self.Label_my_name:setText(MainPlayer:getPlayerName())
    self.Label_my_value:setText(self.formatScoreFunc_(self.myScore_))

    local activityInfo = ActivityDataMgr2:getActivityInfo(self.ranking_data.activityId)
    local serverTime = ServerDataMgr:getServerTime()
    local remainTime = math.max(0, activityInfo.endTime - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    self.Label_tips2:setTextById(263010, day, hour)

    if not self.ranking_data.ranks then
        return
    end
    for i,v in ipairs(self.ranking_data.ranks) do
        local item = self.Panel_rank_item:clone()
        local Image_bg = TFDirector:getChildByPath(item, "Image_bg")
        local Image_rank = TFDirector:getChildByPath(item, "Image_rank")
        local Label_rank = TFDirector:getChildByPath(item, "Label_rank")
        local Label_player_name = TFDirector:getChildByPath(item, "Label_player_name")
        local Label_value = TFDirector:getChildByPath(item, "Label_value")
        if i %2 == 0 then
            Image_bg:setTexture("ui/activity/assist/044.png")
        else
            Image_bg:setTexture("ui/activity/assist/043.png")
        end
        if v.rank <= 3 then
            Label_rank:setVisible(false)
            Image_rank:setVisible(true)
            local num = 37 + v.rank
            Image_rank:setTexture("ui/activity/assist/0"..num..".png")
        else
            Label_rank:setVisible(true)
            Image_rank:setVisible(false)
        end

        Label_rank:setText(tostring("NO."..v.rank))
        Label_player_name:setText(v.playerName)
        local score = self.formatScoreFunc_(v.score)
        Label_value:setText(score)

        local Panel_info = TFDirector:getChildByPath(item, "Panel_info")
        Panel_info:setTouchEnabled(true)
        Panel_info:onClick(function()
            local msg = {v.playerId}
            TFDirector:send(c2s.PLAYER_REQ_TARGET_PLAYER_INFO,msg)
        end)

        self.ScrollView_ranking:pushBackCustomItem(item)
    end
end
function AssistRankingView:registerEvents()
    EventMgr:addEventListener(self,EV_RECV_PLAYERINFO, handler(self.onShowPlayerInfoView, self))
end

function AssistRankingView:onShowPlayerInfoView(playerInfo)
    local view = AlertManager:getLayer(-1)
    if view.__cname == self.__cname then
        Utils:openView("chat.PlayerInfoView", playerInfo)
    end
end


return AssistRankingView
