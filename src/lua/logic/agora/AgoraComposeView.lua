local AgoraComposeView = class("AgoraComposeView", BaseLayer)

function AgoraComposeView:ctor()
    self.super.ctor(self)
    self:initData()
    self:init("lua.uiconfig.agora.agoraComposeView")
end

function AgoraComposeView:onClose()
    self:stopTimer()
    self.super.onClose(self)
end

function AgoraComposeView:registerEvents()
    EventMgr:addEventListener(self, EV_AGORA.ComposeStatusUpdate, handler(self.onComposeStatusUpdate, self))
end

function AgoraComposeView:removeEvents()
    for k, v in pairs(self.composeCountdownTimers) do
        TFDirector:removeTimer(v)
    end
    self.composeCountdownTimers = {}
end

function AgoraComposeView:initData()
    self.timer = nil
    self.materialIds = {500034, 500035, 500036}
    self.materialList = {}
    self.composeCountdownTimers = {}
    ------测试代码
    --AgoraDataMgr:onRespAgoraComposeMain({data={composeInfo={}}})
    --AgoraDataMgr:onRespAgoraComposeMain({data={composeInfo={{id=3, count=2, countDown=1200}}}})
    ------测试代码
end

function AgoraComposeView:initUI(ui)
    self.super.initUI(self, ui)

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_item = Panel_prefab:getChild("Panel_Item")

    local ScrollView_compose = TFDirector:getChildByPath(ui, "ScrollView_compose")
    self.ListView_compose = UIListView:create(ScrollView_compose)
    self.ListView_compose:setItemModel(self.Panel_item)

    self:onComposeStatusUpdate()

    AgoraDataMgr:sendGetAgoraComposeData()
end

function AgoraComposeView:updateMaterial()
    -- for i, v in ipairs(self.materialIds) do
    --     local tb = self.materialList[i]
    --     local itemcfg = GoodsDataMgr:getItemCfg(v)
    --     if itemcfg then
    --         tb.icon:setTexture(itemcfg.icon)
    --         tb.label:setText(GoodsDataMgr:getItemCount(v, true))
    --     end
    -- end
end

function AgoraComposeView:holdDownAction(isAddOp, target)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:updateUI(1, target)
            else
                self:updateUI(-1, target)
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function AgoraComposeView:updateUI(num, target)
    local selectItem = self.ListView_compose:getItem(target.index)
    if not selectItem then
        return
    end
    local newcount = 0
    if num > 0 then
        newcount = math.min(selectItem.count + 1, selectItem.maxCount)
    elseif num < 0 then
        newcount = math.max(selectItem.count - 1, 1)
    end
    if selectItem.count == newcount then
        return
    end
    selectItem.count = newcount

    self:updateComposeNeedTime(selectItem)

    local perCost1, perCost2 = AgoraDataMgr:getComposeCost(selectItem.id)
    -- selectItem.labelCost1:setText(tostring(perCost1*selectItem.count))
    -- selectItem.labelCost2:setText(tostring(perCost2*selectItem.count))
    selectItem.labelItem1:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151005"), tostring(selectItem.labelItem1.ownCount), tostring(perCost1*newcount)))
    selectItem.labelItem2:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151005"), tostring(selectItem.labelItem2.ownCount), tostring(perCost2*newcount)))
    selectItem.labelTargetNum:setText(tostring(newcount))
end

function AgoraComposeView:stopTimer()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil;
    end
end

function AgoraComposeView:startComposeCountdown(item, countdown)
    local id = item.id
    self:stopComposeCountdown(id)
    local function perCountDown()
        countdown = countdown - 1
        if countdown < 0 then
            countdown = 0
            self:stopComposeCountdown(id)
        end
        AgoraDataMgr:setComposeCountDown(id, countdown)
        local h = math.floor(countdown / 3600)
        local m = math.floor(countdown % 3600 / 60)
        local s = math.floor(countdown % 60)
        local time = string.format("%02d:%02d:%02d", h, m, s)
        item.labelCountDown:setTextById(303025, time)
        item.loadingBarCountdown:setPercent(100 - math.floor(countdown / (item.needTime*item.count) * 100))
    end
    perCountDown()
    self.composeCountdownTimers[id] = TFDirector:addTimer(1000, -1, nil, perCountDown)
end

function AgoraComposeView:updateComposeNeedTime(item)
    local needtime = item.count * item.needTime
    local h = math.floor(needtime / 3600)
    local m = math.floor(needtime % 3600 / 60)
    local s = math.floor(needtime % 60)
    local timestr = string.format("%02d:%02d:%02d", h, m, s)
    item.labelTimeNeed:setTextById(303026, timestr)
end

function AgoraComposeView:stopComposeCountdown(id)
    if self.composeCountdownTimers[id] then
        TFDirector:removeTimer(self.composeCountdownTimers[id])
        self.composeCountdownTimers[id] = nil
    end
end

function AgoraComposeView:setItem(item, itemdata)
    if not itemdata then
        return
    end

    item.count = itemdata.count
    item.status = itemdata.status
    local cost1 = itemdata.needItem[1][2]
    local cost2 = itemdata.needItem[2][2]
    local curCount1 = GoodsDataMgr:getItemCount(itemdata.needItem[1][1])
    local curCount2 = GoodsDataMgr:getItemCount(itemdata.needItem[2][1])
    local perCount1 = math.floor(curCount1 / cost1)
    local perCount2 = math.floor( curCount2 / cost2)
    item.maxCount = perCount1
    if perCount1 > perCount2 then
        item.maxCount = perCount2
    end
    item.maxCount = (item.maxCount > 0 and item.maxCount or 1)
    -- item.labelCost1:setText(tostring(itemdata.needItem[1][2]))
    -- item.labelCost2:setText(tostring(itemdata.needItem[2][2]))
    -- item.labelCur1:setText("/"..curCount1)
    -- item.labelCur2:setText("/"..curCount2)
    if curCount1 >= cost1 then
        item.labelItem1:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151005"), tostring(curCount1), tostring(cost1*item.count)))
    else
        item.labelItem1:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151006"), tostring(curCount1), tostring(cost1*item.count)))
    end
    if curCount2 >= cost2 then
        item.labelItem2:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151005"), tostring(curCount2), tostring(cost2*item.count)))
    else
        item.labelItem2:Text(TextDataMgr:getFormatText(TextDataMgr:getTextAttr("r151006"), tostring(curCount2), tostring(cost2*item.count)))
    end
    item.labelItem1.ownCount = curCount1
    item.labelItem2.ownCount = curCount2

    -- item:stopAllActions()
    self:stopComposeCountdown(item.id)
    PrefabDataMgr:setInfo(item.goods1, itemdata.needItem[1][1])
    PrefabDataMgr:setInfo(item.goods2, itemdata.needItem[2][1])
    PrefabDataMgr:setInfo(item.goods3, itemdata.targetItem)
    item.labelTarName:setTextById(TabDataMgr:getData("Item", itemdata.targetItem).nameTextId)
    item.btSub:show()
    item.btAdd:show()
    item.btCompose:show()
    item.imgContdownBar:hide()
    item.btGet:hide()
    item.imgCountDown:hide()
    item.imgTimeNeed:show()
    item.imgFinish:hide()
    item.btCompose:setTouchEnabled(true)
    self:updateComposeNeedTime(item)
    if itemdata.status == EC_AgoraComposeStatus.CountDown then
        item.btSub:hide()
        item.btAdd:hide()
        item.imgCountDown:show()
        item.imgTimeNeed:hide()
        item.imgFinish:hide()
        self:startComposeCountdown(item, itemdata.countDown)
        -- item:runAction(CCRepeatForever:create(Sequence:create({
        --     CallFunc:create(function()
        --         itemdata.countDown = itemdata.countDown - 1
        --         if itemdata.countDown < 0 then
        --             itemdata.countDown = 0
        --             item:stopAllActions()
        --         end
        --         local h = math.floor(itemdata.countDown / 3600)
        --         local m = math.floor(itemdata.countDown % 3600 / 60)
        --         local s = math.floor(itemdata.countDown % 60)
        --         local time = string.format("%02d:%02d:%02d", h, m, s)
        --         item.labelCountDown:setText("剩余时间："..time)
        --     end),
        --     DelayTime:create(1)
        --     })
        -- ))
        item.btCompose:setTouchEnabled(false)
        item.btCompose:show()

        -- TODO CLOSE 隐藏进度
        --item.imgContdownBar:show()
        item.btGet:hide()
    elseif itemdata.status == EC_AgoraComposeStatus.CanGet then
        item.imgCountDown:hide()
        item.imgTimeNeed:hide()
        item.imgFinish:show()
        item.btSub:hide()
        item.btAdd:hide()
        item.btCompose:hide()
        item.btGet:show()
    end
    item.labelTargetNum:setText(tostring(item.count))
end

function AgoraComposeView:onComposeStatusUpdate()
    local composedata = AgoraDataMgr:getComposeData()
    local curItems = self.ListView_compose:getItems()
    if #curItems <= 0 then
        local itemPrefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
        for i, v in ipairs(composedata) do
            local composeitem = self.Panel_item:clone():show()
            composeitem.needTime = TabDataMgr:getData("ChristmasCompose", v.id).needTime
            composeitem.id = v.id
            composeitem.count = 1
            composeitem.maxCount = 0
            for i = 1, 2 do
                composeitem["labelItem"..i] = TFDirector:getChildByPath(composeitem, "RichText_item"..i)
            end
            composeitem.labelTarName = TFDirector:getChildByPath(composeitem, "Label_tarName")
            composeitem.labelTargetNum = composeitem:getChild("Label_targetCount")
            composeitem.imgCountDown = TFDirector:getChildByPath(composeitem, "Image_timeCount")
            composeitem.labelCountDown = TFDirector:getChildByPath(composeitem, "Label_countDown")
            composeitem.imgTimeNeed = TFDirector:getChildByPath(composeitem, "Image_timeNeed")
            composeitem.labelTimeNeed = TFDirector:getChildByPath(composeitem, "Label_timeNeed")
            composeitem.imgFinish = TFDirector:getChildByPath(composeitem, "Image_finish")
            composeitem.panelControl = composeitem:getChild("Panel_control")
            composeitem.imgContdownBar = TFDirector:getChildByPath(composeitem, "Image_bar")
            composeitem.loadingBarCountdown = TFDirector:getChildByPath(composeitem, "LoadingBar_countDown")
            composeitem.btSub = composeitem.panelControl:getChild("Button_sub")
            composeitem.btAdd = composeitem.panelControl:getChild("Button_add")
            composeitem.btGet = composeitem:getChild("Button_get")
            composeitem.btCompose = composeitem:getChild("Button_compose")
            composeitem.goods1 = itemPrefab:clone():Pos(0, 0):AddTo(composeitem:getChild("Panel_item1"))
            composeitem.goods2 = itemPrefab:clone():Pos(0, 0):AddTo(composeitem:getChild("Panel_item2"))
            composeitem.goods3 = itemPrefab:clone():Pos(0, 0):AddTo(composeitem.panelControl)
            composeitem.btSub.index = i
            composeitem.btAdd.index = i
            composeitem.btGet.index = i
            composeitem.btCompose.index = i
            composeitem.btSub:onTouch(function(event)
                if event.name == "began" then
                    self:holdDownAction(false, event.target)
                    self:updateUI(-1, event.target)
                elseif event.name == "ended" then
                    self:stopTimer()
                end
            end)
            composeitem.btAdd:onTouch(function(event)
                if event.name == "began" then
                    self:holdDownAction(true, event.target)
                    self:updateUI(1, event.target)
                elseif event.name == "ended" then
                       self:stopTimer()
                end
            end)
            composeitem.btGet:onClick(function(sender)
                local curitem = self.ListView_compose:getItem(sender.index)
                if curitem then
                    AgoraDataMgr:sendGetAgoraComposeReward(curitem.id)
                end
            end)
            composeitem.btCompose:onClick(function(sender)
                local curitem = self.ListView_compose:getItem(sender.index)
                if curitem then
                    AgoraDataMgr:sendStartAgoraCompose(curitem.id, curitem.count)
                    -- if curitem.status == EC_AgoraComposeStatus.CanCompose then
                    --     AgoraDataMgr:sendStartAgoraCompose(curitem.id, curitem.count)
                    -- elseif curitem.status == EC_AgoraComposeStatus.CantCompose then
                    --     Utils:showTips("材料不足")
                    -- end
                end
            end)
            self:setItem(composeitem, v)
            self.ListView_compose:pushBackCustomItem(composeitem)
        end
    else
        for i, v in ipairs(composedata) do
            local curitem = self.ListView_compose:getItem(i)
            if curitem then
                self:setItem(curitem, v)
            end
        end
    end
end

return AgoraComposeView