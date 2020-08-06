--[[
*                       .::::.
*                     .::::::::.
*                    :::::::::::
*                 ..:::::::::::'
*              '::::::::::::'
*                .::::::::::
*           '::::::::::::::..
*                ..::::::::::::.
*              ``::::::::::::::::
*               ::::``:::::::::'        .:::.
*              ::::'   ':::::'       .::::::::.
*            .::::'      ::::     .:::::::'::::.
*           .:::'       :::::  .:::::::::' ':::::.
*          .::'        :::::.:::::::::'      ':::::.
*         .::'         ::::::::::::::'         ``::::.
*     ...:::           ::::::::::::'              ``::.
*    ```` ':.          ':::::::::'                  ::::..
*                       '.:::::'                    ':'````..
*
*  
* 
]]

local CrazyDiamondMainLayer = class("CrazyDiamondMainLayer", BaseLayer)

function CrazyDiamondMainLayer:ctor( activityId )
    self.super.ctor(self, activityId)
    self:initData(activityId)
    self:init("lua.uiconfig.activity.crazyDiamondMainLayer")
end

function CrazyDiamondMainLayer:initData( activityId )
    self.activityId = activityId
    self.logLabelT = {}
    self.logLabelModelT = {}
    self.lightSpineT = {}
    self.boxT = {}
    self.logIndex = 0
    self.playStatus = false
end

function CrazyDiamondMainLayer:initUI( ui )
    self.super.initUI(self, ui)

    self.rootPanel = TFDirector:getChildByPath(ui, "panel_root")
    self.leftTimeLabel = TFDirector:getChildByPath(self.rootPanel, "label_leftTime")
    self.logPanel = TFDirector:getChildByPath(self.rootPanel, "panel_log")     
    self.getDiamondLabel = TFDirector:getChildByPath(self.rootPanel, "label_getDiamond")
    self.costLabel = TFDirector:getChildByPath(self.rootPanel, "label_cost")
    self.startBtn = TFDirector:getChildByPath(self.rootPanel, "btn_start")
    self.tipLabel = TFDirector:getChildByPath(self.rootPanel, "label_tip")
    self.recordBtn = TFDirector:getChildByPath(self.rootPanel, "btn_record")
    self.actionPanel = TFDirector:getChildByPath(self.rootPanel, "panel_action") 
    self.progressBarImg = TFDirector:getChildByPath(self.rootPanel, "img_active_progress")
    self.progressLoadingBar = TFDirector:getChildByPath(self.progressBarImg, "loadingBar_activeProgress")
    self.dotSpine = TFDirector:getChildByPath(self.rootPanel, "spine_dot")
    self.dotSpine:hide()
    self.reqLabel = TFDirector:getChildByPath(self.rootPanel, "label_req")

    for i=1,3 do
        local boxPanel = TFDirector:getChildByPath(self.rootPanel, "panel_activeItem" ..i) 
        boxPanel.getedPanel = TFDirector:getChildByPath(boxPanel, "panel_geted") 
        boxPanel.getedPanel.getedBtn = TFDirector:getChildByPath(boxPanel.getedPanel, "btn_geted")
        boxPanel.canGetPanel = TFDirector:getChildByPath(boxPanel, "panel_canGet") 
        boxPanel.canGetPanel.canGetBtn = TFDirector:getChildByPath(boxPanel.canGetPanel, "btn_canGet")
        boxPanel.notGetPanel = TFDirector:getChildByPath(boxPanel, "panel_notGet") 
        boxPanel.notGetPanel.notGetBtn = TFDirector:getChildByPath(boxPanel.notGetPanel, "btn_notGet")
        boxPanel.getValueLabel = TFDirector:getChildByPath(boxPanel, "label_getValue") 
        table.insert(self.boxT, boxPanel)
    end

    for i=1,7 do
        local label = TFDirector:getChildByPath(self.logPanel, "label_log_" ..i)       
        label:setText("")
        table.insert(self.logLabelT, label)
    end

    for i=1,7 do
        local label = TFDirector:getChildByPath(self.logPanel, "label_log_model_" ..i)    
        label:hide()
        label:setText("")
        table.insert(self.logLabelModelT, label)
    end

    self.lightSpine = TFDirector:getChildByPath(self.rootPanel, "spine_light")
    self.lightSpine:playByIndex(0,-1,-1,1)

    for i=5,1,-1 do
        local numPanel = TFDirector:getChildByPath(self.rootPanel, "panel_" ..i)    
        local numSpine = TFDirector:getChildByPath(numPanel, "spine_num")  
        table.insert(self.lightSpineT, numSpine) 
    end
    self:playLightShowAni()

    local itemCfgList = {}
    local logList = CrazyDiamondDataMgr:getAllCrazyDiamondRank(self.activityId)
    for i,_log in ipairs(logList) do
        itemCfgList[_log.itemId] = GoodsDataMgr:getItemCfg(_log.itemId) 
    end
    self:startLogAnimation(logList, itemCfgList)

    self:updateUI()
end

function CrazyDiamondMainLayer:startLogAnimation( logList, itemCfgList )
    for i,_logLabel in ipairs(self.logLabelT) do
        _logLabel:stopAllActions()       
        _logLabel:hide()
    end

    for i,_logModelLabel in ipairs(self.logLabelModelT) do
        _logModelLabel:hide()
    end
    self.actionPanel:stopAllActions()

    if #logList <= 4 then
        for i,_log in ipairs(logList) do
            local itemCfg = itemCfgList[_log.itemId]      
            self.logLabelModelT[i]:setTextById("r99990003", _log.playerName, itemCfg.icon, _log.itemNum)
            self.logLabelModelT[i]:show()
            self.logLabelT[i]:setPositionY(self.logLabelT[i]:getPositionY() - 48)
            self.logLabelT[i]:show()
        end
    else
        local action = function( index )
            local arr = {}       
            local callFun = CallFunc:create(function()          
                self.logLabelT[index]:setPosition(10, 20)
                self.logIndex = self.logIndex + 1
                if self.logIndex > #logList then
                    self.logIndex = 1
                end
                local itemCfg = itemCfgList[logList[self.logIndex].itemId]
                self.logLabelModelT[index]:setTextById("r99990003", logList[self.logIndex].playerName, itemCfg.icon, logList[self.logIndex].itemNum)
                self.logLabelModelT[index]:show()
                self.logLabelT[index]:show()
            end)
            table.insert(arr,callFun)
            local moveBy = CCMoveTo:create(3, ccp(10, 200))
            table.insert(arr,moveBy)  
            local delay = DelayTime:create(0.6)
            table.insert(arr,delay)
            local seq = CCSequence:create(arr)
            self.logLabelT[index]:runAction(CCRepeatForever:create(seq))
        end
        for i,_label in ipairs(self.logLabelT) do
            local seq = CCSequence:create({DelayTime:create(i*0.5), CallFunc:create(function()          
                action(i)
            end)})
            self.actionPanel:runAction(seq)
        end
    end
end

function CrazyDiamondMainLayer:onShow( )
    self.super.onShow(self)
end

function CrazyDiamondMainLayer:updateUI( )
    local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId)
    local _,maxCount = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId)
    self.leftTimeLabel:setTextById("r99990004", (maxCount - #ownCrazyDiamondRank))
    local itemId,itemNum = CrazyDiamondDataMgr:getCost(self.activityId)
    local itemCfg = GoodsDataMgr:getItemCfg(itemId)
    self.costLabel:setTextById("r99990002", itemCfg.icon, itemNum)
    local minReward, maxReward = CrazyDiamondDataMgr:getminRewardAndMaxReward(self.activityId)
    local minRewardArray = string.split(minReward, ":")
    local maxRewardArray = string.split(maxReward, ":")
    self.getDiamondLabel:setTextById("r99990001", itemCfg.icon, minRewardArray[2], maxRewardArray[2])
    self.tipLabel:setTextById(100000331)
    local open = CrazyDiamondDataMgr:getOpen(self.activityId)
    local totalPayDiamond = RechargeDataMgr:getTotalPay()

    local payDiamond = math.max(0, (open*100 - totalPayDiamond)*0.01)
    self.reqLabel:setTextById(100000344, payDiamond)

    for i,_boxPanel in ipairs(self.boxT) do
        _boxPanel.getedPanel:hide()
        _boxPanel.canGetPanel:hide()
        _boxPanel.notGetPanel:hide()
        _boxPanel.getValueLabel:hide()
    end
    self.progressBarImg:hide()

    local maxNum = 0
    
    local items = ActivityDataMgr2:getItems(self.activityId)
    if #items > 0 then
        for _idx, itemId in ipairs(items) do
            local boxPanel = self.boxT[_idx]
            if boxPanel then            
                self:updateBoxPanel(boxPanel, self.activityId, itemId)
            end
            local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityId)     
            local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
            maxNum = math.max(itemInfo.target, maxNum)
        end
    end
    local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId)
    local curNum = #ownCrazyDiamondRank
    self.progressLoadingBar:setPercent(curNum/maxNum * 100)
    self.progressBarImg:show()

    local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId)
    local surplusDraw, maxDraw = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId)
    self.startBtn:setGrayEnabled((surplusDraw <= 9) and (maxDraw <= #ownCrazyDiamondRank))
    self.startBtn:setTouchEnabled(not((surplusDraw <= 9) and (maxDraw <= #ownCrazyDiamondRank)))
end

function CrazyDiamondMainLayer:updateBoxPanel( boxPanel, activityId, itemId )
    local activityInfo = ActivityDataMgr2:getActivityInfo(activityId)     
    local progressInfo = ActivityDataMgr2:getProgressInfo(activityInfo.activityType, itemId)
    local itemInfo = ActivityDataMgr2:getItemInfo(activityInfo.activityType, itemId)
    if progressInfo and progressInfo.status == EC_TaskStatus.GET then
        boxPanel.canGetPanel:show()
    elseif progressInfo and progressInfo.status == EC_TaskStatus.ING then
        boxPanel.notGetPanel:show()
    elseif progressInfo and progressInfo.status == EC_TaskStatus.GETED then
        boxPanel.getedPanel:show()
    end

    dump(itemInfo)
    boxPanel.getValueLabel:setTextById(itemInfo.extendData.des2)
    boxPanel.getValueLabel:show()

    boxPanel.canGetPanel.canGetBtn:onClick(function( )
        if progressInfo and progressInfo.status == EC_TaskStatus.GET then
            ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(activityId, itemId)        
        end
    end)
    boxPanel.notGetPanel.notGetBtn:onClick(function( )
        if progressInfo and progressInfo.status == EC_TaskStatus.ING then
            local reward = {}
            for _id,_num in pairs(itemInfo.reward) do
                table.insert(reward, {_id, _num})
            end
            Utils:previewReward(nil, reward)
        end
    end)
end

function CrazyDiamondMainLayer:registerEvents( )
    self.super.registerEvents(self)

    self.startBtn:onClick(function()
        if self.playStatus then return end
        local itemId,itemNum = CrazyDiamondDataMgr:getCost(self.activityId)
        if not GoodsDataMgr:currencyIsEnough(itemId, itemNum) then
            Utils:showAccess(itemId)
            return
        end

        local ownCrazyDiamondRank = CrazyDiamondDataMgr:getOwnCrazyDiamondRank(self.activityId)
        local surplusDraw, maxDraw = CrazyDiamondDataMgr:getSurplusAndMaxDraw(self.activityId)
        --还有累充次数
        if surplusDraw <= 0 and (maxDraw > #ownCrazyDiamondRank) then
            Utils:openView("activity.CrazyDiamondRechargeJumpView", self.activityId)
            return
        end
        --没有次数
        if surplusDraw <= 0 and (maxDraw <= #ownCrazyDiamondRank) then
            return
        end

        local function reaSummon( )
            self:playLightStartAni()       
            CrazyDiamondDataMgr:sendReqCrazyDiamondDraw(self.activityId, true)  
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
    self.recordBtn:onClick(function()
        Utils:openView("activity.CrazyDiamondLogLayer",self.activityId)
    end)

    EventMgr:addEventListener(self,EV_ACTIVITY_RESP_CRAZY_DIAMOND_DRAW, handler(self.onRespCrazyDiamondDrawRsp,self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onProgressUpdateEvent, self))
    EventMgr:addEventListener(self, EV_TRECHARGE_RES_TOTAL_PAY_REWARD_INFO, handler(self.onUpdateRecharge, self))
end

function CrazyDiamondMainLayer:removeEvents( )
    self.super.removeEvents(self)
end

function CrazyDiamondMainLayer:removeUI()
    self.super.removeUI(self)
end

function CrazyDiamondMainLayer:showReward( rewards )
    local itemNum = 0
    for i,_item in ipairs(rewards) do
        itemNum = itemNum + _item.num
    end

    local function showRewardsLayer( )
        Utils:showReward(rewards, nil, function( )
            self.dotSpine:show()
            self.dotSpine:playByIndex(0,-1,-1,0)
            Utils:playSound(5010)
            self.playStatus = false
        end)
        local itemCfgList = {}
        local logList = CrazyDiamondDataMgr:getAllCrazyDiamondRank(self.activityId)
        for i,_log in ipairs(logList) do
            itemCfgList[_log.itemId] = GoodsDataMgr:getItemCfg(_log.itemId) 
        end
        self:startLogAnimation(logList, itemCfgList)
    end

    self.ui:timeOut(function( )    
        self:playResultLightAni(itemNum, showRewardsLayer)
    end,2)

end

function CrazyDiamondMainLayer:onRespCrazyDiamondDrawRsp( data )
    if data.isDraw then
        self:showReward(data.rewards)
    end
    self:updateUI()
end

function CrazyDiamondMainLayer:playLightShowAni( )
    for i,_spine in ipairs(self.lightSpineT) do
        _spine:playByIndex(0,-1,-1,0)
    end
end

function CrazyDiamondMainLayer:playLightStartAni( )
    self.playStatus = true
    if self.numSoundHandler then
        TFAudio.stopEffect(self.numSoundHandler)
    end
    self.numSoundHandler = Utils:playSound(5007, true)
    for i,_spine in ipairs(self.lightSpineT) do
        _spine:playByIndex(10,-1,-1,0)
        self.lightSpine:playByIndex(2,-1,-1,0)
        _spine:addMEListener(TFARMATURE_COMPLETE,function()
            _spine:playByIndex(11,-1,-1,1)
            self.lightSpine:playByIndex(3,-1,-1,1)
            _spine:removeMEListener(TFARMATURE_COMPLETE)               
        end)
    end
end

function CrazyDiamondMainLayer:playResultLightAni( result, callBack )
    if self.numSoundHandler then
        TFAudio.stopEffect(self.numSoundHandler)
    end

    local resultIdxAni = {["0"] = 0,["1"] = 1,["2"] = 2,["3"] = 3,["4"] = 4,["5"] = 5,["6"] = 6,["7"] = 7,["8"] = 8,["9"] = 9,}
    local list, len = Public:stringSplit(result)
    local numList = {}
    for i=#list,1,-1 do
        table.insert(numList, list[i])
    end

    local playCount = #self.lightSpineT
    for i,_spine in ipairs(self.lightSpineT) do
        self.ui:timeOut(function( )     
            if numList[i] then
                _spine:playByIndex(resultIdxAni[numList[i]],-1,-1,0)
            else
                _spine:playByIndex(0,-1,-1,0)
            end
            Utils:playSound(5018)
            _spine:addMEListener(TFARMATURE_COMPLETE,function()
                _spine:removeMEListener(TFARMATURE_COMPLETE)    
                playCount = playCount - 1
                if playCount <= 0 then
                    callBack()
                end        
            end)
        end,i*0.5)
    end


    self.lightSpine:addMEListener(TFARMATURE_COMPLETE,function()
        self.lightSpine:playByIndex(0,-1,-1,1)         
        self.lightSpine:removeMEListener(TFARMATURE_COMPLETE)          
    end)
    self.lightSpine:playByIndex(1,-1,-1,0)
end

function CrazyDiamondMainLayer:onSubmitSuccessEvent(activitId, itemId, reward)
    Utils:showReward(reward)
end

function CrazyDiamondMainLayer:onProgressUpdateEvent( )
   self:updateUI()
end

function CrazyDiamondMainLayer:onUpdateRecharge( )
    print("CrazyDiamondMainLayer:onUpdateRecharge >>")
    self:updateUI()
end

return CrazyDiamondMainLayer
