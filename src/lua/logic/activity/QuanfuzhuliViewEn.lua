local QuanfuzhuliViewEn = class("QuanfuzhuliViewEn", BaseLayer)

function QuanfuzhuliViewEn:initData(activityId)
    self.activityId_ = activityId
    self:updateActivityData()
end

function QuanfuzhuliViewEn:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.quanfuzhuliViewEn")
end

function QuanfuzhuliViewEn:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")


    self.Image_ad = TFDirector:getChildByPath(self.Panel_root, "Image_ad")
    
    self.Label_timing = TFDirector:getChildByPath(ui , "Label_timing")

   

    self.Label_allScore = TFDirector:getChildByPath(ui , "Label_allScore")


    local Image_right = TFDirector:getChildByPath(ui , "Image_right")
    self.ListView_des = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_des"))
    self.Panel_des_item = TFDirector:getChildByPath(ui , "Panel_des")



    self.Image_right_items = {}

    for i=1,4 do
        local Image_reward = TFDirector:getChildByPath(Image_right , "Image_reward_"..i)
        Image_reward.image_icon = Image_reward:getChildByName("Image_icon")
        Image_reward.Label_title = Image_reward:getChildByName("Label_title")
        Image_reward.Label_count = Image_reward:getChildByName("Label_count")
        table.insert(self.Image_right_items , Image_reward)
    end


    self.Button_get = Image_right:getChildByName("Button_get")



    local Image_bottom = TFDirector:getChildByPath(ui , "Image_bottom")

    self.LoadingBar_score = Image_bottom:getChildByName("LoadingBar_score")

    self.Button_rewards = {}

    for i=1,3 do
        local Button_reward = Image_bottom:getChildByName("Button_reward_"..i)
        Button_reward.Label_score =  Button_reward:getChildByName("Label_score")

        table.insert(self.Button_rewards , Button_reward)
    end

    ActivityDataMgr2:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(self.activityInfo_.id)
    self:refreshView()
end

function QuanfuzhuliViewEn:updateActivityData()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
end

function QuanfuzhuliViewEn:updateActivity()

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

    local scoreProgress = {}
    for k ,v in pairs(self.activityInfo_.extendData.shopItemList) do
        table.insert(scoreProgress , tonumber(v))
    end

    table.sort(scoreProgress, function( a , b )
        return a < b
    end)

     local allScore = self.totalPoint or 0

    self.Label_allScore:setTextById(14210001 , TextDataMgr:getText(14300089) , allScore)

    local showEuipId = {260103 ,  260104, 260105}
    for i=1,3 do
        self.Button_rewards[i].Label_score:setText(scoreProgress[i])
        self.Button_rewards[i]:onClick(function( ... )
            Utils:showInfo(showEuipId[i], nil, not(GuideDataMgr and GuideDataMgr:isInNewGuide() and  not isNotAccess))
        end)
        
        local image_lock = self.Button_rewards[i]:getChildByName("Image_lock")
        if allScore >= scoreProgress[i] then
            image_lock:hide()
        else
            image_lock:show()
        end
    end


        self.ListView_des:removeAllItems()

        local Panel_des_item = self.Panel_des_item:clone()
        Panel_des_item.Label_title = Panel_des_item:getChildByName("Label_title")
        Panel_des_item.Label_title:setText(Utils:MultiLanguageStringDeal(self.activityInfo_.activityTitle))
        Panel_des_item:setContentSize(Panel_des_item.Label_title:getContentSize())

        self.ListView_des:pushBackCustomItem(Panel_des_item)
    
    self.LoadingBar_score:setPercent(0)
end

function QuanfuzhuliViewEn:refreshView()

end

function QuanfuzhuliViewEn:updateCountDonw()
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

function QuanfuzhuliViewEn:registerEvents()
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

function QuanfuzhuliViewEn:updatePanelHead( data )
    if data.activityId ~= self.activityInfo_.id then return end
    if self.totalPoint then
        Utils:showTips(TextDataMgr:getText(190000362))
    end
    self.totalPoint = data.num
    self:updateActivity()
end

function QuanfuzhuliViewEn:onShow( ... )
    
end

function QuanfuzhuliViewEn:onSendGiftSuccess(data)
    
    self:updateActivityData()
    self:updateActivity()
end

function QuanfuzhuliViewEn:onUpdateProgressEvent()
    self:updateActivityData()
    self:updateActivity()
end

function QuanfuzhuliViewEn:onUpdateCountDownEvent()
    self:updateCountDonw()
end

return QuanfuzhuliViewEn
