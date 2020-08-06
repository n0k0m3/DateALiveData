
local TurntableMainLayer = class("TurntableMainLayer", BaseLayer)

function TurntableMainLayer:initData(activityId)
    self.loop        = false
    self.nTime       = 0
    self.nCount      = 0 
    self.nMaxStep    = 0
    self.nFocusIndex = 1
    self.nAlllCount  = 12  --总数量
    
    self.activityId_ = activityId
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.turntableReward = {}
end

function TurntableMainLayer:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.turntableMainLayer")
end

function TurntableMainLayer:initUI(ui)
    self.super.initUI(self, ui)


    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    
    self.panel_prize = TFDirector:getChildByPath(ui , self.panel_prize)

    self.pirze_list = {}
    for i=1,12 do
        self.pirze_list[i] = TFDirector:getChildByPath(self.panel_prize , "panel_prize_"..i)
        self.pirze_list[i].label_num = self.pirze_list[i]:getChildByName("lanel_num")
        self.pirze_list[i].img_bg = self.pirze_list[i]:getChildByName("img_bg")
        self.pirze_list[i].Image_prize = self.pirze_list[i]:getChildByName("Image_prize")
        self.pirze_list[i].Spine_over = self.pirze_list[i]:getChildByName("Spine_over")
        self.pirze_list[i].Spine_select = self.pirze_list[i]:getChildByName("Spine_select")
        self.pirze_list[i].Spine_over:hide()
        self.pirze_list[i].Spine_select:hide()
    end

    self.btn_buy = {}
    for i=1,2 do
        self.btn_buy[i] = TFDirector:getChildByPath(ui , "Button_buy"..i)
        self.btn_buy[i].idx = i
    end

    self.img_arrow_normal = TFDirector:getChildByPath(ui , "Image_pointer_normal")
    self.img_arrow_move = TFDirector:getChildByPath(ui , "Image_pointer_move")
    self.img_arrow_move:hide()
    self.img_arrow_normal:setRotation(0)
    self.Image_pointer_di = TFDirector:getChildByPath(ui , "Image_pointer_di")

    self.Button_help = TFDirector:getChildByPath(ui , "Button_help")


    self.ListView_task = UIListView:create(TFDirector:getChildByPath(ui, "ScrollView_task"))
    self.ListView_task:setItemsMargin(0)

    self.Panel_taskItem = TFDirector:getChildByPath(ui , "Panel_taskItem")

    self.Image_select_di = TFDirector:getChildByPath(ui , "Image_select_di")
    self.Image_select_di.tips = TFDirector:getChildByPath(ui , "Image_select")
    self.Image_select_di.tips:hide()
    self.panel_touch = TFDirector:getChildByPath(ui , "Panel_touch")
    self.panel_touch:hide()

    local Panel_accumulate = TFDirector:getChildByPath(ui , "Panel_accumulate")
    self.label_tips = TFDirector:getChildByPath(Panel_accumulate ,"Label_tips")
    self:updateActivity()
end


function TurntableMainLayer:onShow( )
    self.super.onShow(self)
end

function TurntableMainLayer:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    self.summonCid_ = self.activityInfo_.extendData.summonId
    local items = ActivityDataMgr2:getItems(self.activityId_)
    local taskItems = self.ListView_task:getItems()
    local oldcount = #taskItems
    local newcount =  #items
    if newcount >= oldcount then
        local addcount = newcount - oldcount
        for i = 1, addcount do
            local newitem = self.Panel_taskItem:clone():show()
            self.ListView_task:pushBackCustomItem(newitem)
        end
    else
        local removecount = oldcount - newcount
        for i = 1, removecount do
            self.ListView_task:removeLastItem()
        end
    end
    local curRecharge = 0
    for i, v in ipairs(items) do
        local progressInfo = ActivityDataMgr2:getProgressInfo(self.activityInfo_.activityType, v)
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
        if progressInfo.progress > curRecharge then
            curRecharge = progressInfo.progress
        end

        local item = self.ListView_task:getItem(i)
        local Panel_get = TFDirector:getChildByPath(item, "Panel_get"):hide()
        local Button_get = TFDirector:getChildByPath(Panel_get, "Button_get")
        local Spine_receive = TFDirector:getChildByPath(Panel_get, "Spine_receive")
        local Spine_receive1 = TFDirector:getChildByPath(Panel_get, "Spine_receive1")
        local Panel_notGet = TFDirector:getChildByPath(item, "Panel_notGet"):hide()
        local Image_notGet = TFDirector:getChildByPath(Panel_notGet, "Image_notGet")
        local Panel_geted = TFDirector:getChildByPath(item, "Panel_geted"):hide()
        local Image_geted = TFDirector:getChildByPath(Panel_geted, "Image_geted")
        if progressInfo.status == EC_TaskStatus.ING then
            Panel_notGet:show()
            Panel_notGet:getChild("Label_money"):setText(itemInfo.target)
        elseif progressInfo.status == EC_TaskStatus.GET then
            Panel_get:show()
            Spine_receive:play("animation", true)
            if Spine_receive1 then
                Spine_receive1:play("animation2", true)
            end
        elseif progressInfo.status ==  EC_TaskStatus.GETED then
            Panel_geted:show()
        end
        Button_get:onClick(function(sender)
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityInfo_.id, v)
        end)
        Image_notGet:onClick(function(sender)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self:showRewardPreview(sender, itemInfo.reward)
        end)
        Image_geted:onClick(function(sender)
            local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, v)
            self:showRewardPreview(sender, itemInfo.reward)
        end)
    end
   local rewardMap = self.activityInfo_.extendData.rewardMap;
   local idx = 1
   self.turntableReward = {}
   for k ,v in pairs(rewardMap) do
       local summonPoolCfg = SummonDataMgr:getSummonPoolMapCfgs(k)
       local pirze_info = self.pirze_list[idx]
       pirze_info.Image_prize:removeAllChildren()
       for itemId , itemNum in pairs(summonPoolCfg.itemMap) do  --目前仅有一个
            table.insert(self.turntableReward ,{id = itemId , num = itemNum})

            pirze_info.Image_prize:setTexture("")
                local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                Panel_goodsItem:setTouchEnabled(true)
                PrefabDataMgr:setInfo(Panel_goodsItem, itemId, itemNum)
                Panel_goodsItem:Pos(0, 0):AddTo(pirze_info.Image_prize)
                Panel_goodsItem:setScale(0.5)
                local image_frame = TFDirector:getChildByPath(Panel_goodsItem , "Image_frame")
                if summonPoolCfg.quality <= 2 then --蓝色
                    image_frame:setTexture(string.format("ui/activity/turtableActivity/%d.png" , 3))
                elseif summonPoolCfg.quality ==3 then  --红色
                    image_frame:setTexture(string.format("ui/activity/turtableActivity/%d.png" , 2))
                else  --黄色
                    image_frame:setTexture(string.format("ui/activity/turtableActivity/%d.png" , 1))
                end
                image_frame:setScale(2)
                pirze_info.img_bg:setTexture("")
                if summonPoolCfg.permanentRepeatNum > 0 then
                    pirze_info.label_num:show()
                    pirze_info.label_num:setTextById(100000316 , v , summonPoolCfg.permanentRepeatNum)
                else
                    pirze_info.label_num:hide()
                end
            if v >= summonPoolCfg.permanentRepeatNum and summonPoolCfg.permanentRepeatNum ~= 0 then  --如果可抽次数已满
                Panel_goodsItem:setGrayEnabled(true)
                
            end
            
        end
       idx = idx + 1
   end
   self.label_tips:setTextById(190000029 , SummonDataMgr:getSummonCount(self.summonCid_[1]) + SummonDataMgr:getSummonCount(self.summonCid_[2]))
end

function TurntableMainLayer:updatePanleInfo()

end


function TurntableMainLayer:startAnimation()
    self.panel_touch:show()  
    self.img_arrow_move:hide()
    self.img_arrow_normal:setRotation(0)

    --清除转盘焦点
    for index, node in ipairs(self.pirze_list) do
        node.Spine_over:hide()
        node.Spine_select:hide()
    end

    local stopIdxs = self.stopIdx_

    self:start(stopIdxs)
end
function TurntableMainLayer:start(stopIdxs)
    self.selectIdxs = stopIdxs

    local stopIdx   = self.selectIdxs[#self.selectIdxs]

    if self.Image_select_di.tips:isVisible() then  --是否跳过动画
        for index, node in ipairs(self.pirze_list) do
            if index == stopIdx then
                self.img_arrow_normal:setRotation((index -1 )* 30 + 15)
                node.Spine_select:show()
                node.Spine_select:playByIndex(0, -1, -1, 0)
            end
        end       
        self:showSelects()
        return
    end
    -- Box("stopIdx:"..tostring(stopIdx))
    self.loop   = true
    self.nCount = 0 
    self.nFocusIndex = 0
    local focusIndex  = self.nFocusIndex
    if focusIndex < 1 then
        focusIndex = self.nAlllCount
    end
    
    local offset = stopIdx - focusIndex
    self.nMaxStep = offset + self.nAlllCount*3
    if self.nMaxStep > self.nAlllCount*3  then 
        self.nMaxStep = self.nMaxStep -self.nAlllCount
    end
    
end

function TurntableMainLayer:onStop()
    --显示抽个奖结果
    self.loop = false

    self:showSelects()
    
    self:timeOut(function()--展示奖励
       -- Utils:showReward(self.reward)
    end,0.5)
end

function TurntableMainLayer:showSelects()
    self.img_arrow_move:show()
    for k , v in ipairs(self.selectIdxs) do
        local node = self.pirze_list[v]
        node.Spine_over:show()
        node.Spine_over:playByIndex(0, -1, -1, 0)
    end
    Utils:showReward(self.showReward)  
    self.panel_touch:hide()  
    self:updateActivity()     
end
function TurntableMainLayer:update(o,dt) 
    if self.loop  then 
        self.nTime = self.nTime + dt*2000
        if self.nCount < self.nMaxStep  then 
            if self.nTime > self:intervalTime() then 
                self.nTime       = 0
                self.nCount      = self.nCount + 1
                self.nFocusIndex = self.nFocusIndex + 1
                if self.nFocusIndex > self.nAlllCount then 
                    self.nFocusIndex = 1
                end
                for index, node in ipairs(self.pirze_list) do
                    if index == self.nFocusIndex then
                        self.img_arrow_normal:setRotation((index -1 )* 30 + 15)
                        self.Image_pointer_di:setRotation(self.Image_pointer_di:getRotation() - 1)
                        node.Spine_select:show()
                        node.Spine_select:playByIndex(0, -1, -1, 0)
                    end
                end                
            end
        else
            self:onStop()
        end
    end
end

function TurntableMainLayer:intervalTime() 
    if self.nMaxStep - self.nCount <= 5 then
        return (6- (self.nMaxStep - self.nCount)) *100  
    end
    if self.nCount < 5 then 
        return 500 - self.nCount *100 
    end
    return 100        
end
function TurntableMainLayer:registerEvents()
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_RES_DRAW_COMPASS, handler(self.onActivityResDrawComPass, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    
    for i=1,2 do
        self.btn_buy[i]:onClick(function( sender )
            if sender.idx == 1 then
                if (GoodsDataMgr:currencyIsEnough(566024, 1)) then
                    SummonDataMgr:send_SUMMON_SUMMON(self.summonCid_[1], 1)
                else
                    Utils:openView("bag.ItemAccessView", 566024)
                end
            else
                if (GoodsDataMgr:currencyIsEnough(566024, 10)) then
                    SummonDataMgr:send_SUMMON_SUMMON(self.summonCid_[2], 1)
                else
                    Utils:openView("bag.ItemAccessView", 566024)
                end
            end
        end)
    end
   
   self.Button_help:onClick(function( ... )
       SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({12000})
   end)

   self.Image_select_di:onClick(function( ... )
       self.Image_select_di.tips:setVisible(not self.Image_select_di.tips:isVisible())
   end)
end

function TurntableMainLayer:showRewardPreview(item, reward)
    -- self.Image_preview:AnchorPoint(ccp(0.5, 0))
    local format_reward = {}
    for k, v in pairs(reward) do
        local item = Utils:makeRewardItem(k, v)
        table.insert(format_reward, item)
    end

    local wp = item:convertToWorldSpaceAR(me.p(0, 0))
    local np = self.Panel_root:convertToNodeSpaceAR(wp)
    self.Image_preview = Utils:previewReward(self.Image_preview, format_reward, 0.6)
    -- self.Image_preview:Show():Pos(np)
end

function TurntableMainLayer:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
    --self:updateActivity()
end

function TurntableMainLayer:onUpdateProgressEvent()
    self:updateActivity()
end

function TurntableMainLayer:onUpdateCountDownEvent()
    self:updateCountDonw()
end


function TurntableMainLayer:onUpdateActivityEvent( ... )
    if not self.panel_touch:isVisible() then
        self:updateActivity()
    end
end

function TurntableMainLayer:onActivityResDrawComPass(data)
    if data.rewardNum then
        local rewardNum = data.rewardNum
        local showReward = {}
        self.stopIdx_ = {}
        local cacheIdx = {}
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local rewardMap = self.activityInfo_.extendData.rewardMap
        local reawrdIdx = 1
        for mapKey , mapNum in pairs(rewardMap) do
            for k,v in pairs(rewardNum) do
                if tonumber(mapKey) == tonumber(v.key) then
                    self.activityInfo_.extendData.rewardMap[mapKey] = v.value
                    if not cacheIdx[reawrdIdx] then
                        table.insert(self.stopIdx_ , reawrdIdx)
                        table.insert(cacheIdx , reawrdIdx , true)
                    end
                    local summonPoolCfg = SummonDataMgr:getSummonPoolMapCfgs(v.key)
                    for itemId , itemValue in pairs(summonPoolCfg.itemMap) do
                        table.insert(showReward, {id = itemId , num = itemValue})
                    end
                    
                end
            end
            reawrdIdx = reawrdIdx + 1
        end


        self.showReward = showReward
        self:startAnimation()

    end
    
end

function TurntableMainLayer:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView",historyData)
end

return TurntableMainLayer
