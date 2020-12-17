local WhiteQueenLeagueScoreView = class("WhiteQueenLeagueScoreView", BaseLayer)

function WhiteQueenLeagueScoreView:initData(activityId)
    self.activityId_ = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.ONLINE_SCORE_REWARD)[1]
    self:updateActivityData()
end

function WhiteQueenLeagueScoreView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.whiteQueenLeagueScoreView")
end

function WhiteQueenLeagueScoreView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")


    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    
    self.Label_timing = TFDirector:getChildByPath(ui , "Label_timing")

   

    self.Label_allScore = TFDirector:getChildByPath(ui , "Label_all_score")


    self.ListView_des = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_reward"))
    self.Panel_des_item = TFDirector:getChildByPath(ui , "Panel_reward_item")


    self.Panel_scorll_item = TFDirector:getChildByPath(ui , "Panel_des")


    self.Button_get = TFDirector:getChildByPath(self.Panel_root,"Button_get")

    self.list_for_des = UIListView:create(TFDirector:getChildByPath(self.Panel_root, "ScrollView_des"))


   


    self.league_scroll_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.Panel_no_league = TFDirector:getChildByPath(self.Panel_root , "Panel_no_league")


    self.Panel_no_league:getChildByName("Label_no_league"):setTextById(190000431)
    
    self:refreshView()
end

function WhiteQueenLeagueScoreView:updateActivityData()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function WhiteQueenLeagueScoreView:updateActivity()

        local taskData = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 2040) or {}

        local items = self.ListView_des:getItems()
        local gap = #items - math.ceil(#taskData / 2)
        for i = 1, math.abs(gap) do
            if gap > 0 then
                local item = self.ListView_des:getItem(1)
                self.ListView_des:removeItem(1)
            else
              local item = self.Panel_des_item:clone()
              item.panel_reward = {}
              for i=1,2 do
                  local panel_reward = item:getChildByName("Panel_reward_"..i)
                  item.panel_reward[i] = panel_reward
                  panel_reward:setTouchEnabled(true)
                  panel_reward:onClick(function(sender)
                      --点击领取
                      ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, sender.id)
                  end)

                  local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                  Panel_goodsItem:setTouchEnabled(false)
                  Panel_goodsItem:Pos(0, 0)
                  Panel_goodsItem:setScale(0.9)
                  Panel_goodsItem:AddTo(panel_reward:getChildByName("image_icon"))
                  panel_reward.Panel_goodsItem = Panel_goodsItem
                  panel_reward.Label_title = panel_reward:getChildByName("Label_title")
                  panel_reward.label_get = panel_reward:getChildByName("Label_get")
                  panel_reward.img_geted = panel_reward:getChildByName("img_geted")
              end
              self.ListView_des:pushBackCustomItem(item)
            end
        end
        for i, v in ipairs(self.ListView_des:getItems()) do
            self:updatePaneItem(v , taskData , i)
        end

        if LeagueDataMgr:checkSelfInUnion() then
            self.Label_allScore:setTextById(190000419 , self.totalPoint or 0)
        else
            self.Label_allScore:setTextById(190000430)
        end

        self.list_for_des:removeAllItems()

        local Panel_scorll_item = self.Panel_scorll_item:clone()
        Panel_scorll_item.Label_title = Panel_scorll_item:getChildByName("Label_title")
        local leagueActivityInfo =  ActivityDataMgr2:getActivityInfo(ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.LEAGUE_SCORE_ASSIT)[1])
        Panel_scorll_item.Label_title:setText(Utils:splitLanguageStringByTag(leagueActivityInfo.activityTitle))
        Panel_scorll_item:setContentSize(Panel_scorll_item.Label_title:getContentSize())

        self.list_for_des:pushBackCustomItem(Panel_scorll_item)
    
end

function WhiteQueenLeagueScoreView:updatePaneItem( item , itemDatas ,index )
    
    for i=1,2 do
        local showIdx = (index - 1 )*2 + i
        local itemData = itemDatas[showIdx]
        local panel_reward = item.panel_reward[i]
        if itemData then
            panel_reward:show()
            panel_reward.Label_title:setText(itemData.target)
            for rewardK , rewardV in pairs(itemData.reward) do
                PrefabDataMgr:setInfo(panel_reward.Panel_goodsItem, rewardK, rewardV)
            end
            local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, itemData.id)
            panel_reward.id = itemData.id
            panel_reward:setTouchEnabled(false)

            panel_reward.label_get:hide()
            panel_reward.img_geted:hide()

            if progressInfo.status == EC_TaskStatus.ING then
                  panel_reward.Panel_goodsItem:setTouchEnabled(true)
             elseif progressInfo.status == EC_TaskStatus.GET then
                  panel_reward:setTouchEnabled(true)
                  panel_reward.Panel_goodsItem:setTouchEnabled(false)
                  panel_reward.label_get:show()
             elseif progressInfo.status == EC_TaskStatus.GETED then
                  panel_reward.img_geted:show()
                  panel_reward.Panel_goodsItem:setTouchEnabled(true)

             end
        else
            panel_reward:hide()
        end
        

    end

    
end

function WhiteQueenLeagueScoreView:refreshView()

end

function WhiteQueenLeagueScoreView:updateCountDonw()
    local isEnd = ActivityDataMgr2:isEnd(self.activityId_)
    local serverTime = ServerDataMgr:getServerTime()
    if isEnd then
        local remainTime = math.max(0, self.activityInfo_.showEndTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        self.Label_timing:setTextById(1890011, day, hour, min)
    else
        local remainTime = math.max(0, self.activityInfo_.endTime - serverTime)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        self.Label_timing:setTextById(1890011, day, hour, min)
    end
end

function WhiteQueenLeagueScoreView:registerEvents()
     EventMgr:addEventListener(self, EV_ACTIVITY_RES_DONATE_ACTIVITY, handler(self.onSendGiftSuccess, self))
     EventMgr:addEventListener(self, EV_ACTIVITY_RES_ACTIVITY_UNION_ITEM, handler(self.onUnionItemRes, self))

        
     self.Button_get:onClick(function()
            FunctionDataMgr:jActivityByType( EC_ActivityType2.LEAGUE_SCORE_RANK )

     end)

     self.Panel_no_league:getChildByName("Button_join_league"):onClick(function ( ... )
       -- body
       FunctionDataMgr:jUnion()
     end)
end


function WhiteQueenLeagueScoreView:onShow( ... )
    ActivityDataMgr2:request_ACTIVITY_REQ_ACTIVITY_UNION_ITEM(self.activityInfo_.id)
    self:checkLeagueStatus()
end

function WhiteQueenLeagueScoreView:checkLeagueStatus( ... )

    if LeagueDataMgr:checkSelfInUnion() then
        self.league_scroll_reward:show()
        self.Panel_no_league:hide()
    else
        self.league_scroll_reward:hide()
        self.Panel_no_league:show()
    end
end

function WhiteQueenLeagueScoreView:onSendGiftSuccess(data)
    
    self:updateActivityData()
    self:updateActivity()
end

function WhiteQueenLeagueScoreView:onUpdateProgressEvent()
    self:updateActivityData()
    self:updateActivity()
end

function WhiteQueenLeagueScoreView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function WhiteQueenLeagueScoreView:onUnionItemRes( data )
    if data.activityId ~= self.activityInfo_.id then return end
    
    self.totalPoint = data.num
    self:updateActivity()
end

function WhiteQueenLeagueScoreView:onSubmitSuccessEvent(activityID, Entry, reward)
  if activityID == self.activityInfo_.id then
      Utils:showReward(reward)
      self:updateActivity()
  end
end

return WhiteQueenLeagueScoreView
