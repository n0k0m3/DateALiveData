--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local Enum_Reward_Type = {
    Person = 1,
    Server = 2
}

local Enum_Btn_Status = {
    UnLock = 1,
    UnClaime = 2,
    Claimed = 3
}

local ScoreOnlineRewardView = class("ScoreOnlineRewardView", BaseLayer)

function ScoreOnlineRewardView:ctor(activityid)
    self.super.ctor(self, activityid)

    self.curSelect = nil

    self.activityid = activityid
    self.serverScore = 0
    self.selfScore = GoodsDataMgr:getItemCount(500091) or 0

    self:init("lua.uiconfig.activity.scoreOnlineRewardView")

    EventMgr:addEventListener(self, EV_ACTIVITY_OVER_SERVER_SCORE, handler(self.onGetServerScore, self))

    self:getServerScore()

    
end


function ScoreOnlineRewardView:initUI(ui)
    self.super.initUI(self,ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    local giftList = self.Panel_root:getChildByName("ScrollView_gift")
    self.giftList = UIListView:create(giftList)

    self.prefab = TFDirector:getChildByPath(ui, "prefeb_Gift")
    self.prefab:setVisible(false)

    self.label_score = TFDirector:getChildByPath(self.Panel_root, "scorebg.label_score")
    self.label_score_tittle = TFDirector:getChildByPath(self.Panel_root, "scorebg.label_score_tittle")

    self.button_allserver = TFDirector:getChildByPath(self.Panel_root, "scorebg.button_allserver")
    self.button_allserver:onClick(function()
        self:showRewardInfo(Enum_Reward_Type.Person)
    end)
    self.button_person = TFDirector:getChildByPath(self.Panel_root, "scorebg.button_person")
    self.button_person:onClick(function()
       self:showRewardInfo(Enum_Reward_Type.Server)
    end)

    --self:showRewardInfo(Enum_Reward_Type.Person)
end

function ScoreOnlineRewardView:showDefault()
    self:showRewardInfo(self.curSelect or Enum_Reward_Type.Person)
end

function ScoreOnlineRewardView:showRewardInfo(etype)

    local switch = {
        [Enum_Reward_Type.Person] = 
            function()
                self.label_score_tittle:setTextById(14300088)
                self.button_allserver:setVisible(false)
                self.button_person:setVisible(true)

                self.selfScore = GoodsDataMgr:getItemCount(500091)
                self.label_score:setText(self.selfScore)

                
                self.curSelect = Enum_Reward_Type.Person
                self:updateActivity(self.listData, self.selfScore)
            end,
        [Enum_Reward_Type.Server] = 
            function()
                self.label_score_tittle:setTextById(14300089)
                self.button_allserver:setVisible(true)
                self.button_person:setVisible(false)
                self.label_score:setText(self.serverScore)
                
                self:getServerScore()
                self.curSelect = Enum_Reward_Type.Server

                self:updateActivity(self.listData, self.serverScore)
            end
    }
   
   switch[etype]()  
end

function ScoreOnlineRewardView:updateActivity(data,score)
    self.listData = data
    if data == nil  then
        return
    end
    local listData = {person = {},  server = {}}
    for i = 1, #data do
       local tempData = ActivityDataMgr2:getItemInfo(EC_ActivityType2.ONLINE_SCORE_REWARD, data[i])
       if  tempData.subType == 2003 then
           table.insert(listData.person, tempData)
       elseif tempData.subType == 2014 then
           table.insert(listData.server, tempData)
       end
    end

    local list = nil
    local targetScore = 0
    
    if  self.curSelect == Enum_Reward_Type.Person then
        list = listData.person
        targetScore = self.selfScore       
    elseif self.curSelect == Enum_Reward_Type.Server then
        list = listData.server
        targetScore = self.serverScore
    end

    

    self.giftList:removeAllItems()
    for i = 1, #list do
        local item = self.prefab:clone()
        item:setVisible(true)
        item.index = i
        item.data = ActivityDataMgr2:getItemInfo(EC_ActivityType2.ONLINE_SCORE_REWARD, list[i].id)
        item.activitEntryId = list[i].id

        local curProgress = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.ONLINE_SCORE_REWARD, list[i].id)

        self:initItem(item, curProgress)
        self.giftList:pushBackCustomItem(item)
    end
end

function ScoreOnlineRewardView:initItem(item, progress)
    local itemData = item.data
    local giftbg        = item:getChildByName("giftbg")
    local btn_get       = item:getChildByName("btn_get")
    local label_need    = item:getChildByName("label_need")
    local des           = item:getChildByName("des")
    local icon          = item:getChildByName("giftbg")
    icon.reward = {}
    for k,v in pairs(itemData.reward) do
        table.insert(icon.reward, {id = k, num=v})
    end
    icon:setTouchEnabled(true)
    icon:addMEListener(TFWIDGET_TOUCHENDED, function(sender)
        Utils:previewReward(nil, sender.reward)
    end);

    des:setText(itemData.extendData.des2)
    label_need:setText(itemData.target)
    btn_get:onClick(function(sender)
        if sender.status == EC_TaskStatus.ING then
            Utils:showTips("进行中...");
        elseif sender.status == EC_TaskStatus.GETED then
            Utils:showTips("奖励已经领取");
        elseif sender.status == EC_TaskStatus.GET then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityid, item.activitEntryId)
        end
        self:getServerScore()
    end)

    btn_get.status = progress.status

    self:setBtnStatus(btn_get)


end


function ScoreOnlineRewardView:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
end


function ScoreOnlineRewardView:getServerScore()
     ActivityDataMgr2:request_ACTIVITY_REQ_ALL_ACTIVITY_ITEM(self.activityid)
end

function ScoreOnlineRewardView:setBtnStatus(btn)
    local switch = {
        [EC_TaskStatus.ING] = function ()
                btn:setTextureNormal("ui/score/lock.png")
            end,
        [EC_TaskStatus.GET] = function ()
                btn:setTextureNormal("ui/score/get.png")
            end,
        [EC_TaskStatus.GETED] = function ()
                btn:setTextureNormal("ui/score/got.png")
            end,
    }
    switch[btn.status]()
end


function ScoreOnlineRewardView:onGetServerScore(score)  
    self.serverScore = score
    if self.curSelect == Enum_Reward_Type.Server then
        self.label_score:setText(self.serverScore)
    end
end

function ScoreOnlineRewardView:onUpdateProgressEvent(args)
    Utils:showTips("进度更新");
end




return ScoreOnlineRewardView
--endregion
