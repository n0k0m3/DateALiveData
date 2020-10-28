
local CrazyDiamondMainLayerNew = class("CrazyDiamondMainLayerNew", BaseLayer)

function CrazyDiamondMainLayerNew:initData(activityId)
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

function CrazyDiamondMainLayerNew:ctor(...)
    self.super.ctor(self)
    self:initData(...)    
    self:init("lua.uiconfig.activity.turntableMainLayerNew")
end

function CrazyDiamondMainLayerNew:initUI(ui)
    self.super.initUI(self, ui)


    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    
    self.panel_prize = TFDirector:getChildByPath(ui , self.panel_prize)

    self.leftTimeLabel = TFDirector:getChildByPath(ui, "label_leftTime")
    self.reqLabel = TFDirector:getChildByPath(ui, "label_req")
    self.getDiamondLabel = TFDirector:getChildByPath(ui, "label_getDiamond")

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

    self.startBtn = TFDirector:getChildByPath(ui , "Button_start")

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
    --英文版屏蔽ui
    self.Image_select_di:hide()
    self.panel_touch = TFDirector:getChildByPath(ui , "Panel_touch")
    self.panel_touch:hide()

    local Panel_accumulate = TFDirector:getChildByPath(ui , "Panel_accumulate")
    self.label_tips = TFDirector:getChildByPath(Panel_accumulate ,"Label_tips")
    self:updateActivity()
end


function CrazyDiamondMainLayerNew:onShow( )
    self.super.onShow(self)
end

function CrazyDiamondMainLayerNew:updateActivity()
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
   local rewardMap = CrazyDiamondDataMgr:getDiamondRewardShow( self.activityId_  ,  self.oldRank)
   local idx = 1
   for k ,v in pairs(rewardMap) do
       local pirze_info = self.pirze_list[idx]
       pirze_info.Image_prize:removeAllChildren()
        pirze_info.Image_prize:setTexture("")
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setTouchEnabled(true)
        PrefabDataMgr:setInfo(Panel_goodsItem, 500002)
        Panel_goodsItem:Pos(0, 0):AddTo(pirze_info.Image_prize)
        Panel_goodsItem:setScale(0.7)
        local image_frame = TFDirector:getChildByPath(Panel_goodsItem , "Image_frame")
        image_frame:setTexture("")
        
        pirze_info.img_bg:setTexture("")
        
        pirze_info.label_num:show()
        pirze_info.label_num:setTextById(800007 , v)
        -- if v >= summonPoolCfg.permanentRepeatNum and summonPoolCfg.permanentRepeatNum ~= 0 then  --如果可抽次数已满
        --     Panel_goodsItem:setGrayEnabled(true)
        -- end
            
       idx = idx + 1
   end
   

    

   ---疯狂钻石代码
    local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId_)

     self.label_tips:setTextById(190000029 , #ownCrazyDiamondRank)
    local _,maxCount = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId_)
    self.leftTimeLabel:setTextById(100000316, maxCount-#ownCrazyDiamondRank , maxCount)
    local itemId,itemNum = CrazyDiamondDataMgr:getCost(self.activityId_)
    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    self.getDiamondLabel:setTextById("r99990001", itemCfg.icon,rewardMap[1] , rewardMap[#rewardMap])
    self.startBtn:getChildByName("Label_cost"):setTextById(800007, itemNum)
    self.startBtn:getChildByName("img_cost"):setTexture(itemCfg.icon)
    local minReward, maxReward = CrazyDiamondDataMgr:getminRewardAndMaxReward(self.activityId_)
    local open = CrazyDiamondDataMgr:getOpen(self.activityId_)
    local totalPayDiamond = CrazyDiamondDataMgr:getTotalPay(self.activityId_)

    local payDiamond = math.max(0, (open*100 - totalPayDiamond)*0.01)
    self.reqLabel:setTextById(100000344, payDiamond)
    
    local surplusDraw, maxDraw = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId_)
    self.startBtn:setGrayEnabled((surplusDraw <= 9) and (maxDraw <= #ownCrazyDiamondRank))
    self.startBtn:setTouchEnabled(not((surplusDraw <= 9) and (maxDraw <= #ownCrazyDiamondRank)))
end

function CrazyDiamondMainLayerNew:updatePanleInfo()

end


function CrazyDiamondMainLayerNew:startAnimation()
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
function CrazyDiamondMainLayerNew:start(stopIdxs)
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

function CrazyDiamondMainLayerNew:onStop()
    --显示抽个奖结果
    self.loop = false

    self:showSelects()
    
    self:timeOut(function()--展示奖励
       -- Utils:showReward(self.reward)
    end,0.5)
end

function CrazyDiamondMainLayerNew:showSelects()
    self.img_arrow_move:show()
    for k , v in ipairs(self.selectIdxs) do
        local node = self.pirze_list[v]
        node.Spine_over:show()
        node.Spine_over:playByIndex(0, -1, -1, 0)
    end
    Utils:showReward(self.showReward)  
    self.panel_touch:hide()  
    self.oldRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId_)
    self:updateActivity()     
end
function CrazyDiamondMainLayerNew:update(o,dt) 
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

function CrazyDiamondMainLayerNew:intervalTime() 
    if self.nMaxStep - self.nCount <= 5 then
        return (6- (self.nMaxStep - self.nCount)) *100  
    end
    if self.nCount < 5 then 
        return 500 - self.nCount *100 
    end
    return 100        
end
function CrazyDiamondMainLayerNew:registerEvents()
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    self.startBtn:onClick(function()
        if self.playStatus then return end
        local itemId,itemNum = CrazyDiamondDataMgr:getCost(self.activityId_)
        if not GoodsDataMgr:currencyIsEnough(itemId, itemNum) then
            Utils:showAccess(itemId)
            return
        end

        local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId_)
        local surplusDraw, maxDraw = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId_)
        --还有累充次数
        if surplusDraw <= 0 and (maxDraw > #ownCrazyDiamondRank) then
            Utils:openView("activity.CrazyDiamondRechargeJumpView", self.activityId_)
            return
        end
        --没有次数
        if surplusDraw <= 0 and (maxDraw <= #ownCrazyDiamondRank) then
            return
        end

        local function reaSummon( )
            self.oldRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId_)
            CrazyDiamondDataMgr:sendReqCrazyDiamondDraw(self.activityId_, true)  
        end

        if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_CrazyDiamond) then
            reaSummon()
            return
        end
        local rstr = TextDataMgr:getTextAttr(100000342)
        local formatStr = rstr and rstr.text or ""
        local content = string.format(formatStr, itemNum, TabDataMgr:getData("Item", itemId).icon)
        Utils:openView("common.ReConfirmTipsView", {tittle = 100000343, content = content, reType = EC_OneLoginStatusType.ReConfirm_CrazyDiamond, confirmCall = reaSummon})
    end)
       self.Button_help:onClick(function( ... )
           Utils:openView("activity.CrazyDiamondLogLayer",self.activityId_)
       end)

       self.Image_select_di:onClick(function( ... )
           self.Image_select_di.tips:setVisible(not self.Image_select_di.tips:isVisible())
       end)

    EventMgr:addEventListener(self,EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW, handler(self.onRespCrazyDiamondDrawRsp,self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onProgressUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TRECHARGE_RES_TOTAL_PAY_REWARD_INFO, handler(self.onUpdateRecharge, self))
end

function CrazyDiamondMainLayerNew:onRespCrazyDiamondDrawRsp( data )
    if data.isDraw then
        self:onActivityResDrawComPass(data.rewards)  --转盘开始
    end
end

function CrazyDiamondMainLayerNew:showRewardPreview(item, reward)
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

function CrazyDiamondMainLayerNew:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
    --self:updateActivity()
end


function CrazyDiamondMainLayerNew:onProgressUpdateEvent( )
   self:updateActivity()
end

function CrazyDiamondMainLayerNew:onUpdateRecharge( )
    print("CrazyDiamondMainLayerNew:onUpdateRecharge >>")
    self:updateActivity()
end


function CrazyDiamondMainLayerNew:onUpdateCountDownEvent()
    self:updateCountDonw()
end


function CrazyDiamondMainLayerNew:onUpdateActivityEvent( ... )
    if not self.panel_touch:isVisible() then
        self:updateActivity()
    end
end

function CrazyDiamondMainLayerNew:onActivityResDrawComPass(data)
    if data then
        local rewardNum = data
        local showReward = {}
        self.stopIdx_ = {}
        local cacheIdx = {}
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local rewardMap = CrazyDiamondDataMgr:getDiamondRewardShow( self.activityId_ , self.oldRank )
        local reawrdIdx = 1
        for mapKey , mapNum in pairs(rewardMap) do
            for k,v in pairs(rewardNum) do
                if tonumber(mapNum) == tonumber(v.num) then
                    if not cacheIdx[reawrdIdx] then
                        table.insert(self.stopIdx_ , reawrdIdx)
                        table.insert(cacheIdx , reawrdIdx , true)
                    end
                    table.insert(showReward, {id = v.id , num = v.num})
                end
            end
            reawrdIdx = reawrdIdx + 1
        end
        self.showReward = showReward
        self:startAnimation()

    end
    
end

function CrazyDiamondMainLayerNew:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView",historyData)
end

return CrazyDiamondMainLayerNew
