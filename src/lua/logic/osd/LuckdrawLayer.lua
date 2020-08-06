require "lua.public.ScrollMenu"
local LuckdrawLayer = class("LuckdrawLayer", BaseLayer)
local function _Random()
    local t = {1,2,3,4,5,6,7,8,9}
    return function ()
        local index = math.random(1,#t)
        local v = t[index]
        table.remove(t,index)
        return v
    end
end

function LuckdrawLayer:ctor(params)
    self.super.ctor(self)
    self.loop        = false
    self.nTime       = 0
    self.nCount      = 0 
    self.nMaxStep    = 0
    self.nFocusIndex = 0

    self.highBox = {}
    local kvpData  = Utils:getKVP(81024).box or {}
    for k,highData in ipairs(kvpData) do
        self.highBox[k] = {}
        local info = {}
        for _,id in ipairs(highData) do
            info[id] = 1
        end
        self.highBox[k] = info
    end
    self:init("lua.uiconfig.osd.Luckdraw")
end


function LuckdrawLayer:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    -- --关闭按钮
    self.btn_xb1   = TFDirector:getChildByPath(ui, "Button_xb1")
    self.text_xb1  = self.btn_xb1:getChildByName("Label_title")
    self.btn_xb2   = TFDirector:getChildByPath(ui, "Button_xb2")
    self.text_xb2  = self.btn_xb2:getChildByName("Label_title")
    self.btn_help  = TFDirector:getChildByPath(ui, "Button_help")
    self.btn_reset = TFDirector:getChildByPath(ui, "Button_reset")

    --
    self.image_arrow1 = TFDirector:getChildByPath(ui, "Image_arrow1")
    self.image_arrow2 = TFDirector:getChildByPath(ui, "Image_arrow2")
    self.image_box    = TFDirector:getChildByPath(ui, "Image_box")
    self.Image_box_spine = TFDirector:getChildByPath(ui, "Image_box_spine"):hide()

    --奖励
    self.image_award1 = TFDirector:getChildByPath(ui, "Image_award1")
    self.image_award2 = TFDirector:getChildByPath(ui, "Image_award2")
    self.image_award3 = TFDirector:getChildByPath(ui, "Image_award3")


    self.targetItems = {}  
    for index = 1 , 3 do
        self.targetItems[index] = TFDirector:getChildByPath(ui, "Image_award"..tostring(index))
    end

    --寻宝一次消耗
    self.text_consume1 = TFDirector:getChildByPath(ui, "Label_consume1")
    --寻宝十次消耗
    self.text_consume2 = TFDirector:getChildByPath(ui, "Label_consume2")
    
    self.image_icon1 = TFDirector:getChildByPath(ui, "Image_icon1")
    self.image_icon2 = TFDirector:getChildByPath(ui, "Image_icon2")

    self.widgetInfo = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.ui, "Button_xb"..i)
        tab.btnTx = TFDirector:getChildByPath(tab.btn, "Label_title")
        tab.costNumTx = TFDirector:getChildByPath(self.ui, "Label_consume"..i)
        tab.costIcon = TFDirector:getChildByPath(self.ui, "Image_icon"..i)
        table.insert(self.widgetInfo,tab)
    end

    --旋转
    self.image_disk_turn = TFDirector:getChildByPath(ui, "Image_disk_turn")
    self.selectItems = {}

    --奖项
    local Panel_prize = TFDirector:getChildByPath(ui, "Panel_prize")
    for index = 1 , 10 do
        -- print(i)
        self.selectItems[index]           = TFDirector:getChildByPath(Panel_prize, "Image_prize_"..tostring(index))
        self.selectItems[index].focusNode = self.selectItems[index]:getChildByName("Image_select")
        self.selectItems[index].spine = self.selectItems[index]:getChildByName("Spine_select")
    end
    ------------------------------------------------------------------
    self.teamSummonInfo = {}
    self.summon_ = SummonDataMgr:getTeamSummon()
    for k,v in ipairs(self.summon_) do
        for i,info in ipairs(v) do
            table.insert(self.teamSummonInfo,info)
        end
    end

    self.Panel_touch = TFDirector:getChildByPath(self.ui, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_touch:setSwallowTouch(false)

    self:updateRandomTarget()
    self:updateSummonInfo()
    --TODO 测试
    --self:randomTarget()
end

function LuckdrawLayer:updateSummonInfo()
    self.costItem_ = {}
    for k,btnInfo in ipairs(self.widgetInfo) do
        local summonCfgInfo =  self.teamSummonInfo[k]
        if not summonCfgInfo then
            btnInfo.btn:setVisible(false)
        else

            local summonCfg = SummonDataMgr:getSummonCfg(summonCfgInfo.id)
            if not summonCfg then
                return
            end
            btnInfo.btn:setVisible(true)
            btnInfo.btnTx:setTextById(303035, summonCfg.cardCount)

            for j, cost in ipairs(summonCfg.cost) do
                local costIndex = j
                local costId, costNum
                for id, num in pairs(cost) do
                    costId = id
                    costNum = num
                    break
                end

                local ownNum = GoodsDataMgr:getItemCount(costId)
                local costCfg = GoodsDataMgr:getItemCfg(costId)

                btnInfo.costIcon:setTexture(costCfg.icon)
                btnInfo.costIcon:setTouchEnabled(true)
                btnInfo.costIcon:onClick(function()
                    Utils:showInfo(costId)
                end)
                if costNum > ownNum then
                    btnInfo.costNumTx:setTextById("r151006", tostring(ownNum), tostring(costNum))
                else
                    btnInfo.costNumTx:setTextById("r151005", tostring(ownNum), tostring(costNum))
                end
                print(costId)
                self.costItem_[k] = {
                    id = costId,
                    num = costNum,
                    index = costIndex,
                }
                if GoodsDataMgr:currencyIsEnough(costId, costNum) then
                    break
                end
            end
        end
    end
end


function LuckdrawLayer:playCircleAni()

    local activeIds = SummonDataMgr:getActiveIds()
    if not activeIds or not next(activeIds) then
        return
    end

    self.Panel_touch:setVisible(true)
    for i, v in ipairs(self.widgetInfo) do
        v.btn:setTouchEnabled(false)
        v.btn:setGrayEnabled(true)
    end
    self:start(activeIds)
end

function LuckdrawLayer:onRecvRandomTarget()
    local isExsitActive = false
    local randomTarget = SummonDataMgr:getTargetCombination()
    for k,v in ipairs(randomTarget) do
        if v.isActive then
            isExsitActive = true
            break
        end
    end
    if not isExsitActive then
        self:updateRandomTarget()
        --清除转盘焦点
        for index, node in ipairs(self.selectItems) do
            node.focusNode:hide()
        end
    end
end

function LuckdrawLayer:updateRandomTarget()

    local targetIndex = 1
    local awardCnt = 0
    local randomTarget = SummonDataMgr:getTargetCombination()
    local isHigh = self:isHighBox(randomTarget)
    local bosRes = isHigh and "ui/osd/luckdraw/d034.png" or "ui/osd/luckdraw/d029.png"
    self.image_box:setTexture(bosRes)
    for k,v in ipairs(randomTarget) do
        local targetItem =  self.targetItems[targetIndex]
        if targetItem then
            targetItem:removeAllChildren()
            local node     = self.selectItems[v.id]:clone()
            node:setScale(0.8)
            node.focusNode = node:getChildByName("Image_select")
            node.focusNode:setVisible(v.isActive)
            if v.isActive then
                local spineName = v.id == 1 and "fuhao" or "fuhao"..v.id
                node.spine = node:getChildByName("Spine_select")
                node.spine:play(spineName,false)
                node.spine:setVisible(true)
                node.spine:addMEListener(TFARMATURE_COMPLETE,function()
                    self:timeOut(function()
                        if node and node.spine then
                            node.spine:removeMEListener(TFARMATURE_COMPLETE)
                            node.spine:setVisible(false)
                        end                       
                    end, 0)
                end)
            end
            node:setPosition(ccp(0,0))
            targetItem.node       = node
            targetItem.bindIndex  = v.id
            targetItem:addChild(node)
            if v.isActive then
                awardCnt = awardCnt + 1
            end
        end
        targetIndex = targetIndex + 1
    end

    self.image_arrow2:setVisible(awardCnt >= #randomTarget)
    self.Image_box_spine:setVisible(awardCnt >= #randomTarget)
end

function LuckdrawLayer:isHighBox(randomTarget)

    local isHigh = false
    for id,highData in ipairs(self.highBox) do
        local count = 0
        for _,v in ipairs(randomTarget) do
            if highData[v.id] then
                count = count + 1
            end
        end

        if count >= 3 then
            isHigh = true
            break
        end
    end

    return isHigh
end

function LuckdrawLayer:onItemUpdateEvent()
    self:updateSummonInfo()
end

function LuckdrawLayer:onSummonResultEvent(reward)

    self.reward = reward or {}
    self:playCircleAni()
end

--随机中将项目
function LuckdrawLayer:randomTarget()
    local func_random = _Random()
    for i, targetItem in ipairs(self.targetItems) do
        targetItem:removeAllChildren()
        local index = func_random()
        local node     = self.selectItems[index]:clone()
        node:setScale(0.8)
        node.focusNode = node:getChildByName("Image_select")
        node.focusNode:hide()
        node:setPosition(ccp(0,0))
        targetItem.node       = node
        targetItem.bindIndex  = index
        targetItem:addChild(node)
    end
end

function LuckdrawLayer:start(stopIdxs)
    self.selectIdxs = stopIdxs
    dump(stopIdxs)
    local stopIdx   = self.selectIdxs[math.random(1,#self.selectIdxs)]
    -- Box("stopIdx:"..tostring(stopIdx))
    self.loop   = true
    self.nCount = 0 
    local focusIndex  = self.nFocusIndex
    if focusIndex < 1 then
        focusIndex = 10
    end
    
    local offset = stopIdx - focusIndex
    self.nMaxStep = offset + 30
    if self.nMaxStep > 30  then 
        self.nMaxStep = self.nMaxStep -10
    end

    --清除转盘焦点
    for index, node in ipairs(self.selectItems) do
        node.focusNode:hide()
    end
     -- dump(self.steps)
     -- Box("d")
end

function LuckdrawLayer:onStop()
    --显示抽个奖结果
    self.loop = false

    self.Panel_touch:setVisible(false)
    self:showSelects()
    --TODO 服务器需要保存已中 和当前中的  
    for i, targetItem in ipairs(self.targetItems) do
       if table.find(self.selectIdxs,targetItem.bindIndex) ~= -1 then
            targetItem.node.focusNode:show()
       end
    end

    for i, v in ipairs(self.widgetInfo) do
        v.btn:setTouchEnabled(true)
        v.btn:setGrayEnabled(false)
    end

    self:updateRandomTarget()
    SummonDataMgr:setActiveIds()
    self:timeOut(function()
        Utils:showReward(self.reward)
    end,0.5)
end

function LuckdrawLayer:intervalTime() 
    if self.nMaxStep - self.nCount <= 5 then
        return (6- (self.nMaxStep - self.nCount)) *100  
    end
    if self.nCount < 5 then 
        return 500 - self.nCount *100 
    end
    return 100        
end

function LuckdrawLayer:showSelects()
    for index, node in ipairs(self.selectItems) do
        node.focusNode:setVisible(false)
    end
    for i, idx in ipairs(self.selectIdxs) do
        self.selectItems[idx].focusNode:show()
        self.selectItems[idx].spine:show()
        self.selectItems[idx].spine:play("effect_highteam_04",false)
        self.selectItems[idx].spine:addMEListener(TFARMATURE_COMPLETE,function()
            self:timeOut(function()
                self.selectItems[idx].spine:removeMEListener(TFARMATURE_COMPLETE)
                self.selectItems[idx].spine:setVisible(false)
            end, 0)
        end)
    end

end



function LuckdrawLayer:update(o,dt) 
    if self.loop  then 
        self.nTime = self.nTime + dt*1000
        if self.nCount < self.nMaxStep  then 
            if self.nTime > self:intervalTime() then 
                -- print("self.nFocusIndex:",self.nFocusIndex ,self.nCount ,self.nMaxStep, self:intervalTime())
                self.nTime       = 0
                self.nCount      = self.nCount + 1
                self.nFocusIndex = self.nFocusIndex + 1
                if self.nFocusIndex > 10 then 
                    self.nFocusIndex = 1
                end
                self.image_disk_turn:setRotation((self.nFocusIndex-1)*36)
                -- for index, node in ipairs(self.selectItems) do
                --     -- node.focusNode:setVisible(index == self.nFocusIndex)
                -- end                
            end
        else
            self:onStop()
        end
    end
end

function LuckdrawLayer:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView", historyData,14110006)
end

function LuckdrawLayer:onHide()
    self.super.onHide(self)
end

function LuckdrawLayer:removeUI()
    self.super.removeUI(self)
    --测试移除 lua
    -- local TFUILoadManager       = require('TFFramework.client.manager.TFUILoadManager')
    -- TFUILoadManager:unLoadModule("lua.logic.osd.LuckdrawLayer")
end

function LuckdrawLayer:registerEvents()
    self:addMEListener(TFWIDGET_ENTERFRAME, handler(self.update, self))
    EventMgr:addEventListener(self, EV_BW_SUMMON_ACTIVE, handler(self.updateSelectIdxs, self))
    EventMgr:addEventListener(self, EV_BW_RANDOM_TARGET, handler(self.onRecvRandomTarget, self))
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))

    self.image_box:setTouchEnabled(true)
    self.image_box:onClick(function()
        SummonDataMgr:send_GetNwTargetAward()
    end)

    self.btn_help:onClick(function()
        local summonCfg = SummonDataMgr:getSummonCfg(self.teamSummonInfo[1].id)
        Utils:openView("summon.SummonPreviewView", summonCfg.groupId,14110005)
    end)
    self.btn_reset:onClick(function()
        --Utils:openView("summon.SummonHistoryView",{{records={}}},14110006)
        local summonCfg = SummonDataMgr:getSummonCfg(self.teamSummonInfo[1].id)
        SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({summonCfg.groupId})
    end)

    self.Panel_touch:onClick(function()
        while self.nCount < self.nMaxStep do
            self.nCount = self.nCount + 1
            self.nFocusIndex = self.nFocusIndex + 1
            if self.nFocusIndex > 10 then
                self.nFocusIndex = 1
            end
        end
        self.image_disk_turn:setRotation((self.nFocusIndex-1)*36)
        self:onStop()
    end)

    for i, v in ipairs(self.widgetInfo) do
        v.btn:onClick(function()
            local cost = self.costItem_[i]
            local summonCfgInfo =  self.teamSummonInfo[i]
            if not summonCfgInfo then
                return
            end
            if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
                local function reaSummon()
                    SummonDataMgr:send_SUMMON_SUMMON(summonCfgInfo.id, cost.index)
                end
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_TeamSummon) then
                    reaSummon()
                else
                    local rstr = TextDataMgr:getTextAttr(303002 + i -1)
                    local formatStr = rstr and rstr.text or ""
                    local content = string.format(formatStr, cost.num, TabDataMgr:getData("Item", cost.id).icon)
                    local tipsId
                    local activeCnt = 0
                    local randomTarget = SummonDataMgr:getTargetCombination()
                    for k,v in ipairs(randomTarget) do
                        if v.isActive then
                            activeCnt = activeCnt + 1
                        end
                    end
                    if activeCnt == 3 then
                        tipsId = 14110305
                    end
                    Utils:openView("common.ReConfirmTipsView", {tittle = 303001,tips = tipsId, content = content, reType = EC_OneLoginStatusType.ReConfirm_TeamSummon, confirmCall = reaSummon})
                end
            else
                Utils:showTips(303046)
            end
        end)
    end
end

function LuckdrawLayer:onShow()
    self.super.onShow(self)
end

return LuckdrawLayer;
