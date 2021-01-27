local WhiteQueenSendScoreView = class("WhiteQueenSendScoreView", BaseLayer)

function WhiteQueenSendScoreView:initData(activityId)
    self.activityId_ = activityId
    self:updateActivityData()
end

function WhiteQueenSendScoreView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.whiteQueenSendScoreView")
end

function WhiteQueenSendScoreView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")


    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    
    self.Label_timing = TFDirector:getChildByPath(ui , "Label_timing")

   

    self.Label_allScore = TFDirector:getChildByPath(ui , "Label_allScore")


    local Image_right = TFDirector:getChildByPath(ui , "Image_right")
    self.ListView_des = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_des"))
    self.Panel_des_item = TFDirector:getChildByPath(ui , "Panel_des")



    self.Image_right_items = {}

    for i=1,2 do
        local Image_reward = TFDirector:getChildByPath(Image_right , "panel_reward_"..i)
        Image_reward.image_icon = Image_reward:getChildByName("Image_icon")
        Image_reward.Label_title = Image_reward:getChildByName("Label_title")
        Image_reward.Label_count = Image_reward:getChildByName("Label_count")
        table.insert(self.Image_right_items , Image_reward)
    end


    self.Button_get = Image_right:getChildByName("Button_get")



    local Image_bottom = TFDirector:getChildByPath(ui , "Image_bottom")


    self.Button_rewards = {}

    for i=1,3 do
        local Button_reward = Image_bottom:getChildByName("Button_reward_"..i)
        Button_reward.Label_score =  Button_reward:getChildByName("Label_score")

        table.insert(self.Button_rewards , Button_reward)
    end

    ActivityDataMgr2:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(self.activityInfo_.id)
    self:refreshView()
end

function WhiteQueenSendScoreView:updateActivityData()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function WhiteQueenSendScoreView:updateActivity()

    local showIconIds = {}
    for k ,v in pairs(self.activityInfo_.extendData.donateItemRate) do
        table.insert(showIconIds , tonumber(k))
    end


    local record = self.activityInfo_.extendData.donateRecord
    for k ,v in pairs(self.Image_right_items) do
        local itemCfg = GoodsDataMgr:getItemCfg(showIconIds[k])

        v.image_icon:setTexture(itemCfg.icon)
        v.image_icon:setTouchEnabled(true)
        v.image_icon:onClick(function( ... )
            Utils:showInfo(itemCfg.id, nil, not(GuideDataMgr and GuideDataMgr:isInNewGuide() and  not isNotAccess))
        end)
        -- v.Label_title = Image_reward:getChildByName("Label_title")
        if record then
            if record[tostring(showIconIds[k])] then
                v.Label_count:setTextById(800007 , record[tostring(showIconIds[k])])
            else
                v.Label_count:setTextById(800007 , 0)
            end
        else
            v.Label_count:setTextById(800007 , 0)
        end
    end


     local allScore = self.totalPoint or 0

    self.Label_allScore:setTextById(14210001 , TextDataMgr:getText(14300089) , allScore)


    local taskData = ActivityDataMgr2:getActivityItemsInfoBySubType(self.activityInfo_.id, 2014)



    for i=1,#taskData do

        local data = taskData[i]
        
        self.Button_rewards[i]:onClick(function( ... )
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, data.id)
        end)
        

        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, data.id)
        self.Button_rewards[i].Label_score:setText(data.target)

        self.Button_rewards[i]:setTouchEnabled(false)

        if not self.Button_rewards[i].goodsItem then
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:Pos(0, 0)
            Panel_goodsItem:AddTo(self.Button_rewards[i]:getChildByName("Image_icon"))
            self.Button_rewards[i].goodsItem = Panel_goodsItem
            Panel_goodsItem:setScale(0.7)
            self.Button_rewards[i].goodsItem:setTouchEnabled(true)
            self.Button_rewards[i].goodsItem:getChildByName("Image_frame"):setVisible(false)
            
          end

          for rewardK , rewardV in pairs(data.reward) do
              PrefabDataMgr:setInfo(self.Button_rewards[i].goodsItem, rewardK )
              self.Button_rewards[i]:getChildByName("Label_num"):setTextById(800007 ,rewardV)
          end
          


        local img_lock = self.Button_rewards[i]:getChildByName("Image_lock")
        img_lock:hide()

        local lable_get = self.Button_rewards[i]:getChildByName("Label_get")
        lable_get:hide()

        local Image_geted = self.Button_rewards[i]:getChildByName("Image_geted")
        Image_geted:getChildByName("Label_geted"):setTextById(14220068)
        Image_geted:hide()

        self.Button_rewards[i].goodsItem:setTouchEnabled(true)
        if progressInfo.status == EC_TaskStatus.ING then
              img_lock:show()
         elseif progressInfo.status == EC_TaskStatus.GET then
            self.Button_rewards[i]:setTouchEnabled(true)
            self.Button_rewards[i].goodsItem:setTouchEnabled(false)
            lable_get:show()
         elseif progressInfo.status == EC_TaskStatus.GETED then
            Image_geted:show()
         end
    end


        self.ListView_des:removeAllItems()

        local Panel_des_item = self.Panel_des_item:clone()
        Panel_des_item.Label_title = Panel_des_item:getChildByName("Label_title")
        Panel_des_item.Label_title:setText(Utils:MultiLanguageStringDeal(self.activityInfo_.activityTitle))
        Panel_des_item:setContentSize(Panel_des_item.Label_title:getContentSize())

        self.ListView_des:pushBackCustomItem(Panel_des_item)
    
end

function WhiteQueenSendScoreView:refreshView()

end

function WhiteQueenSendScoreView:updateCountDonw()
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

function WhiteQueenSendScoreView:registerEvents()
     EventMgr:addEventListener(self, EV_ACTIVITY_RES_DONATE_ACTIVITY, handler(self.onSendGiftSuccess, self))
     EventMgr:addEventListener(self, EV_ACTIVITY_OVER_SERVER_SCORE, handler(self.updatePanelHead, self))
        
     self.Button_get:onClick(function()
        local sendList = {}
         for k ,v in pairs(self.activityInfo_.extendData.donateItemRate) do
             local key = tonumber(k)
             local number = GoodsDataMgr:getItemCount(key)
             if tonumber(number) > 0 then
                table.insert(sendList , { key , number})
             end
         end

         
         if #sendList >0 then
            ActivityDataMgr2:send_ACTIVITY_REQ_DONATE_ACTIVITY({self.activityInfo_.id ,sendList})
            ActivityDataMgr2:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(self.activityInfo_.id)
         else
            Utils:showTips(TextDataMgr:getText(190000358))
         end

     end)
end

function WhiteQueenSendScoreView:updatePanelHead( data )
    if data.activityId ~= self.activityInfo_.id then return end

    self.totalPoint = data.num
    self:updateActivity()
end

function WhiteQueenSendScoreView:onShow( ... )
    
end

function WhiteQueenSendScoreView:onSendGiftSuccess(data)
    
    self:updateActivityData()
    self:updateActivity()
end

function WhiteQueenSendScoreView:onUpdateProgressEvent()
    self:updateActivityData()
    self:updateActivity()
end

function WhiteQueenSendScoreView:onUpdateCountDownEvent()
    self:updateCountDonw()
end

function WhiteQueenSendScoreView:onSubmitSuccessEvent(activityID, Entry, reward)
  if activityID == self.activityInfo_.id then
      Utils:showReward(reward)
      self:updateActivity()
  end
end

return WhiteQueenSendScoreView
