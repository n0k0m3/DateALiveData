
local BingoMainViewNew = class("BingoMainViewNew", BaseLayer)

EC_GameState = {
    Random = 1,
    Award = 2,
}

function BingoMainViewNew:initData()
    self.deltaStep = -1
    self.stopGroupId = 1
    self.showItemCnt = {}
    self.turnNo = {}
    self.animateInfo = {}
    self.animateInfo[1] = {time = 0,oldtime = 0,posTab = {0,0,0}}
    self.animateInfo[2] = {time = 2,oldtime = 2,posTab = {-165,0,165}}
    self.animateInfo[3] = {time = 2,oldtime = 2,posTab = {-239,0,239}}
    self.animateInfo[4] = {time = 2,oldtime = 2,posTab = {-325,0,325}}
    self.arrowStep = 1
    self.arrowMoving = false
    self.finishIndex = nil
    self.summonPoolTypeTab = BingoDataMgr:getBingoSummonPoolType()
    table.sort(self.summonPoolTypeTab,function(a,b)
        return a < b
    end)

    self.arrowMovePos = {ccp(-17,392),ccp(-107,283),ccp(-146,191),ccp(-186,102)}
    self.arrowPos = {}
    self.arrowPos[4] = {-186,-140,-59,26,106,153}
    self.arrowPos[3] = {-146,-97,-17,63,112}
    self.arrowPos[2] = {-107,-59,26,72}
    self.arrowPos[1] = {-17,-17}

    self.arrowAnimateState = {false,false,false,false}

    self.spinebgRes = {"bg","bg2","bg1","bg1"}
    self.bgSpineStop = true

    self.Spine_luckyInfo = {}
    self.Spine_luckyInfo[4] = {pos = ccp(-17,102),name = "awardLow_1"}
    self.Spine_luckyInfo[3] = {pos = ccp(-17,190),name = "awardLow_2"}
    self.Spine_luckyInfo[2] = {pos = ccp(-17,282),name = "awardLow_3"}
    self.Spine_luckyInfo[1] = {pos = ccp(-21,390),name = "evt_effect_awardHigh"}

    self.sound = {5010,5009,5008,5008}

    self.moveGroupId = {}

    self.isFinish = false

    self.isSummoning = false
    self.costItem_ = {}
    self.stopFloor = {}
end

function BingoMainViewNew:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoMainViewNew")
end

function BingoMainViewNew:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_task = TFDirector:getChildByPath(self.Panel_root, "Button_task")
    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Button_callback = TFDirector:getChildByPath(self.Panel_root, "Button_callback")
    self.Button_turnplate = TFDirector:getChildByPath(self.Panel_root, "Button_turnplate")
    self.Button_divination = TFDirector:getChildByPath(self.Panel_root, "Button_divination")
    self.Button_dice = TFDirector:getChildByPath(self.Panel_root, "Button_dice")
    TFDirector:getChildByPath(self.Button_dice, "Label_btn"):setSkewX(15)
    TFDirector:getChildByPath(self.Button_dice, "Label_btn_en"):setSkewX(15)

    self.Button_do = TFDirector:getChildByPath(self.Panel_root, "Button_do")
    self.Image_cost = TFDirector:getChildByPath(self.Button_do, "Image_cost")
    self.Label_cost = TFDirector:getChildByPath(self.Button_do, "Label_cost")

    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)

    self.Button_summonall = TFDirector:getChildByPath(self.Panel_root, "Button_summonall")
    self.Button_summonall:setTouchEnabled(false)
    self.Button_summonall:setGrayEnabled(true)
    self.Label_summonALL = TFDirector:getChildByPath(self.Panel_root, "Label_summonALL")
    self.Label_summonALL:setTextById(13310201)

    self.Image_role = TFDirector:getChildByPath(self.Panel_root, "Image_role")

    self.Image_unlock_tip = TFDirector:getChildByPath(self.Panel_root, "Image_unlock_tip")
    self.Label_lock_tip = TFDirector:getChildByPath(self.Panel_root, "Label_lock_tip")
    self.Label_lock_tip:setTextById(13310202)

    self.Panel_Right = TFDirector:getChildByPath(self.Panel_root, "Panel_Right")
    self.Image_arrow = TFDirector:getChildByPath(self.Panel_root, "Image_arrow")
    self.Image_arrow:setOpacity(0)

    self.Spine_bg = TFDirector:getChildByPath(self.Panel_root, "Spine_bg")
    self.Spine_lucky = TFDirector:getChildByPath(self.Panel_root, "Spine_lucky")

    self.itemMoveList = {}
    self.listPanelInfo = {}
    self.arrowImg = {}
    for id = 1,4 do
        self.itemMoveList[id] = {}
        local itemList = TFDirector:getChildByPath(self.Panel_root, "Panel_itemlist_"..id)
        local Image_listbg1 = TFDirector:getChildByPath(self.Panel_root, "Image_listbgtop_"..id)
        Image_listbg1:setOpacity(0)

        local Image_arrow = TFDirector:getChildByPath(self.Panel_root, "Image_arrow_"..id)
        Image_arrow:setOpacity(0)
        self.arrowImg[id] = Image_arrow
        self.listPanelInfo[id] = {pos = itemList:getPosition(),select = Image_listbg1}
        self.turnNo[id] = 1
        for i=1,2 do
            local tab = {}
            tab = TFDirector:getChildByPath(itemList, "Panel_group"..i)
            if tab then
                tab.itemInfo = {}
                for j=1,id do
                    local itemBg = TFDirector:getChildByPath(tab, "Image_item_bg"..j)
                    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                    Panel_goodsItem:AddTo(itemBg)
                    Panel_goodsItem:Pos(0, 0)
                    table.insert(tab.itemInfo,{bg = itemBg,item = Panel_goodsItem,itemId = 0,id = 0})
                    if id == 1 then
                        local Image_frame = TFDirector:getChildByPath(Panel_goodsItem, "Image_frame")
                        Image_frame:setVisible(false)
                        Panel_goodsItem:setScale(1)
                    else
                        Panel_goodsItem:setScale(0.52)
                    end

                end
                tab.curId = i+1
                table.insert(self.itemMoveList[id],tab)
            end
        end
    end

    self.selectScaleParam = {0.25,0.5,0.75,1}

    self.Button_TypeTab = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_type"..i)
        tab.lock = TFDirector:getChildByPath(tab.btn, "Image_lock"):hide()
        tab.select = TFDirector:getChildByPath(tab.btn, "Image_select")
        tab.Label_btn = TFDirector:getChildByPath(tab.btn, "Label_btn")
        tab.Label_btn:setSkewX(-5)
        tab.poolType = self.summonPoolTypeTab[i]
        self.Button_TypeTab[i] = tab
    end

    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab")

    self.bingoSummon = {}
    self.summon_ = SummonDataMgr:getBingoSummon()
    for k,v in ipairs(self.summon_) do
        for i,info in ipairs(v) do
            local summonCfg = SummonDataMgr:getSummonCfg(info.id)
            self.bingoSummon[summonCfg.poolType] = info
        end
    end


    self:showModelInfo()
    self:initPoolItem()
    self:updateBtnType()
    self:clickPoolType(1)
    self:playBgSpine(1)

end

function BingoMainViewNew:playBgSpine(floorId)

    if not self.luckyfloorId then
        floorId = 1
    end

    if not self.bgSpineStop then
        return
    end
    self.bgSpineStop = false
    local name = self.spinebgRes[floorId]
    self.Spine_bg:play(name,false)
    self.Spine_bg:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_bg:removeMEListener(TFARMATURE_COMPLETE)
        self.bgSpineStop = true
        self:playBgSpine(self.curFloorId)
    end)
end

function BingoMainViewNew:showModelInfo()
    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[411308]
    if data and data.type and data.type == 2 then
        self.model = ElvesNpcTable:createLive2dNpcID(data.highRoleModel,false,false,nil,true).live2d
        self.Image_role:addChild(self.model,1)
        self.model:setScale(0.7); --缩放
        local pos = ccp(330,0)
        self.model:setPosition(pos);--位置
        --self.model:playMoveRightIn(0.3)
    end

end

function BingoMainViewNew:updateSummonInfo()

    if self.isSummoning then
        return
    end

    local summonCfgInfo =  self.bingoSummon[self.choosePoolType]
    if not summonCfgInfo then
        self.Button_do:setVisible(false)
    else
        local summonCfg = SummonDataMgr:getSummonCfg(summonCfgInfo.id)
        if not summonCfg then
            return
        end
        --self.Button_do:setVisible(true)
        self.Label_cost:setText("x"..summonCfg.cardCount)

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

            self.Image_cost:setTexture(costCfg.icon)

            self.Button_do:setTouchEnabled(ownNum >= costNum)
            self.Button_do:setGrayEnabled(ownNum < costNum)

            self.costItem_[self.choosePoolType] = {
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

function BingoMainViewNew:initPoolItem()

    self.poolItem = {}
    for k,poolType in ipairs(self.summonPoolTypeTab) do
        self.poolItem[poolType] = {}
        for i = 1,4 do
            local item = BingoDataMgr:getBingoSummonPool(poolType,i)
            self.poolItem[poolType][i] = item
        end
    end
end

function BingoMainViewNew:updateBtnType()
    for k,v in ipairs(self.Button_TypeTab) do
        local isOpen = BingoDataMgr:isOpenPool(v.poolType)
        if isOpen then
            v.lock:setVisible(false)
        else
            v.lock:setVisible(true)
        end

    end
end

function BingoMainViewNew:clickPoolType(btnIndex)

    if self.btnIndex == btnIndex then
        return
    end

    local poolType = self.Button_TypeTab[btnIndex].poolType
    self.btnIndex = btnIndex
    for k,v in ipairs(self.Button_TypeTab) do
        v.select:setVisible(k == btnIndex)
        local color = k==btnIndex and ccc3(255,255,255) or ccc3(211,161,190)
        v.Label_btn:setColor(color)
    end

    self:updateTower(poolType)
end

function BingoMainViewNew:updateTower(poolType)

    self.choosePoolType = poolType

    for i=1,4 do
        self.listPanelInfo[i].select:stopAllActions()
        self.listPanelInfo[i].select:setOpacity(0)
    end

    local poolItem = self.poolItem[poolType]
    for floorId = 1,4 do
        local item = poolItem[floorId]
        for groupId = 1,2 do
            local curPanel = self.itemMoveList[floorId][groupId]
            if not curPanel then
                return
            end

            local posX = self.animateInfo[floorId].posTab[groupId + 1]
            curPanel:setPositionX(posX)
            curPanel:stopAllActions()
            for j=1,floorId do
                if curPanel.itemInfo[j] then
                    if not self.showItemCnt[floorId] then
                        self.showItemCnt[floorId] = 0
                    end
                    self.showItemCnt[floorId] = self.showItemCnt[floorId] + 1
                    if self.showItemCnt[floorId] > #item then
                        self.showItemCnt[floorId] = 1
                    end
                    local itemIndex = self.showItemCnt[floorId]
                    curPanel.itemInfo[j].itemId = item[itemIndex].itemId
                    curPanel.itemInfo[j].id = item[itemIndex].id
                    local isWin = BingoDataMgr:summonItemIsWin(poolType,floorId,item[itemIndex].id)
                    curPanel.itemInfo[j].bg:setGrayEnabled(isWin)
                    local opacity =  isWin and 127 or 255
                    curPanel.itemInfo[j].bg:setOpacity(opacity)
                    PrefabDataMgr:setInfo(curPanel.itemInfo[j].item, item[itemIndex].itemId)
                    local Panel_level_star = curPanel.itemInfo[j].item.ListView_star
                    if Panel_level_star then
                        Panel_level_star:setVisible(false)
                    end
                end
            end
            curPanel.curId = groupId + 1
        end
    end

    local isOpen = BingoDataMgr:isOpenPool(poolType)
    if isOpen then
        self:updateSummonInfo()
        self.Image_unlock_tip:setVisible(false)
        self.Button_do:setVisible(true)
    else
        self.Button_do:setVisible(false)
        self.Image_unlock_tip:setVisible(true)
    end

    local isAllSummon = BingoDataMgr:isSummonAll(poolType)
    self.Button_summonall:setVisible(isAllSummon)
    self.Button_do:setVisible(not isAllSummon and isOpen)
    if not isAllSummon then
        self:playFloorAnimate(EC_GameState.Random)
    end
end

function BingoMainViewNew:shuffle(t)
    if type(t)~="table" then
        return
    end
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local tab={}
    local index=1
    while #t~=0 do
        local n=math.random(0,#t)
        if t[n]~=nil then
            tab[index]=t[n]
            table.remove(t,n)
            index=index+1
        end
    end
    return tab
end

function BingoMainViewNew:playFloorAnimate(state)

    self.gameState = state
    if state == EC_GameState.Random then
        math.randomseed(tostring(os.time()):reverse():sub(1, 6))

        local notSummAllFloor
        local randomFloorTab = self:shuffle({2,3,4})
        for k,v in ipairs(randomFloorTab) do
            local isSummonAll = BingoDataMgr:isSummonAll(self.choosePoolType,v)
            if not isSummonAll then
                notSummAllFloor = v
                break
            end
        end
        if notSummAllFloor then
            self.stopGroupId = 1
            self:selectAnimat(notSummAllFloor)
        end
    elseif state == EC_GameState.Award then
        self.nextId = self.nextId - 1
        if self.nextId <= 0 then
            self.nextId = 4
        end
        if self.luckyfloorId then
            if self.luckyfloorId <= self.nextId then
                self:selectAnimat(self.nextId)
            end
        else
            self:selectAnimat(self.nextId)
        end
    end
end


function BingoMainViewNew:selectAnimat(nextId)

    local time = 0.5
    local nextPos = self.listPanelInfo[nextId].pos
    local nextScale = self.selectScaleParam[nextId]
    if not nextPos or not nextScale then
        return
    end

    self.listPanelInfo[nextId].select:runAction(Sequence:create({
        CCFadeIn:create(time),
        CCDelayTime:create(0.5),
        CallFunc:create(function()
            self:playAnimate(nextId)
            self.listPanelInfo[nextId].select:stopAllActions()
        end)
    }))
end

function BingoMainViewNew:playAnimate(floorId)

    self.stopFloor[floorId] = false
    if self.stopGroupId == 1 then
        for i=1,2 do
            self:doAnimate(floorId,i)
        end
    elseif self.stopGroupId == 2 then
        for i=2,1,-1 do
            self:doAnimate(floorId,i)
        end
    end

    if self.luckyItem and not self.arrowAnimateState[floorId] then
        if self.arrowOldFloorId then
            self.arrowImg[self.arrowOldFloorId]:setOpacity(0)
            self.arrowImg[self.arrowOldFloorId]:stopAllActions()
            self.arrowImg[self.arrowOldFloorId]:setPositionX(self.arrowMovePos[self.arrowOldFloorId].x)
            self.arrowAnimateState[self.arrowOldFloorId] = false
        end
        self.arrowOldFloorId = floorId
        self:playArrow(floorId,2)
    end
end

function BingoMainViewNew:showReward(floorId)

    self.luckyItem = nil
    self.luckyfloorId = nil
    self.luckyPoolType = nil
    self.finishIndex = nil
    self.isFinish = false
    self.luckyId = nil

    self.isSummoning = false
    self:updateSummonInfo()

    local isOpen = BingoDataMgr:isOpenPool(self.choosePoolType)
    local isAllSummon = BingoDataMgr:isSummonAll(self.choosePoolType)
    self.Button_summonall:setVisible(isAllSummon)
    self.Button_do:setVisible(not isAllSummon and isOpen)

    for i=1,4 do
        self.listPanelInfo[i].select:stopAllActions()
        self.listPanelInfo[i].select:setOpacity(0)
        self:stopAnimate(i,self.moveGroupId[i])
    end

    if not next(self.reward) then
        return
    end

    Utils:playSound(self.sound[floorId], false)
    self.Spine_lucky:setVisible(true)
    self.Spine_lucky:play(self.Spine_luckyInfo[floorId].name,false)
    self.Spine_lucky:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_lucky:removeMEListener(TFARMATURE_COMPLETE)
        self.Spine_lucky:setVisible(false)
        self:timeOut(function ()
            self.arrowImg[floorId]:setPositionX(self.arrowMovePos[floorId].x)
            self.arrowImg[floorId]:setOpacity(0)
            self.Panel_touch:setVisible(false)
            Utils:showReward(self.reward)
            if not isAllSummon then
                self:playFloorAnimate(EC_GameState.Random)
            end
        end,0.2)
    end)
end

function BingoMainViewNew:playArrow(floorId,id)

    self.arrowAnimateState[floorId] = true

    local targetPosX = self.arrowPos[floorId][id]
    local t = 0.2
    if id == floorId + 2 then
        t = 0.1
    end

    local posY = self.arrowMovePos[floorId].y

    local act = Sequence:create({
        CCSpawn:create({
            CCMoveTo:create(t,ccp(targetPosX,posY)),
            CCFadeIn:create(t)
        }),
        CCCallFunc:create(function()
            if floorId ~= 1 then
                Utils:playSound(5016, false)
            end

            if self.luckyfloorId == floorId and self.finishIndex == id-1 then
                self.arrowImg[floorId]:stopAllActions()
                self.arrowAnimateState[floorId] = false

                local groupId = self.moveGroupId[floorId]
                local groupPanel = self.itemMoveList[floorId][groupId]
                self:timeOut(function ()
                    if floorId == 1 then
                        for i=1,2 do
                            local groupPanel = self.itemMoveList[floorId][i]
                            groupPanel.itemInfo[self.finishIndex].bg:setGrayEnabled(true)
                            groupPanel.itemInfo[self.finishIndex].bg:setOpacity(127)
                        end
                    else
                        groupPanel.itemInfo[self.finishIndex].bg:setGrayEnabled(true)
                        groupPanel.itemInfo[self.finishIndex].bg:setOpacity(127)
                    end
                    self:showReward(floorId)
                end,0.4)
            else
                local nextId = id + 1
                if nextId > #self.arrowPos[floorId] then
                    self.arrowImg[floorId]:setOpacity(0)
                    self.arrowImg[floorId]:setPositionX(self.arrowMovePos[floorId].x)
                    nextId = 2
                end
                self:playArrow(floorId,nextId)
            end

        end)
    })
    self.arrowImg[floorId]:runAction(act)

end

function BingoMainViewNew:stopAnimate(floorId,groupId)

    if self.stopFloor[floorId] then
        return
    end
    self.stopFloor[floorId] = true
    self.listPanelInfo[floorId].select:runAction(CCFadeOut:create(0.3))
    self.stopGroupId = groupId
    for i=1,2 do
        self.itemMoveList[floorId][i]:stopAllActions()
        if groupId == 1 then
            local posX = self.animateInfo[floorId].posTab[2]
            if i == 2 then
                posX = self.animateInfo[floorId].posTab[3]
            end
            self.itemMoveList[floorId][i]:setPositionX(posX)
            self.itemMoveList[floorId][i].curId = i+1
        elseif groupId == 2 then
            local posX = self.animateInfo[floorId].posTab[2]
            if i == 1 then
                posX = self.animateInfo[floorId].posTab[3]
                self.itemMoveList[floorId][i].curId = 3
            else
                self.itemMoveList[floorId][i].curId = 2
            end
            self.itemMoveList[floorId][i]:setPositionX(posX)
        end
    end

end


function BingoMainViewNew:doAnimate(floorId,groupId)


    local time = self.animateInfo[floorId].time
    local posTab = self.animateInfo[floorId].posTab

    local curId = self.itemMoveList[floorId][groupId].curId
    local preId = curId - 1

    if preId <= 0 then
        preId = 3
        time = 0
        self:loadItem(floorId,groupId)
    end

    local groupPanel = self.itemMoveList[floorId][groupId]
    if groupPanel.curId == 2 then

        for k,v in ipairs(groupPanel.itemInfo) do
            if v.id == self.luckyId then
                self.isFinish = true
                self.finishIndex = k
                BingoDataMgr:updateSummonItemState(self.choosePoolType,v.itemId)
                break
            end
        end

        self.moveGroupId[floorId] = groupId
    end

    self.curFloorId = floorId

    if self.isFinish then
        self:stopAnimate(floorId,groupId)
        return
    end

    local act = Sequence:create({
        MoveTo:create(time, ccp(posTab[preId],0)),
        CallFunc:create(function()
            local groupPanel = self.itemMoveList[floorId][groupId]
            groupPanel.curId = preId
            if self.luckyfloorId then
                if self.stopRunFloor then
                    self:stopAnimate(floorId,groupId)
                    self:playFloorAnimate(EC_GameState.Award)
                    self.stopRunFloor = false
                    return
                end

                if self.luckyfloorId == floorId then
                    self:doAnimate(floorId,groupId)
                else
                    if groupId == 1 and preId == 2 then
                        if self.isFinish then
                            self:stopAnimate(floorId,groupId)
                            return
                        end
                        self:doAnimate(floorId,groupId)
                        self:playFloorAnimate(EC_GameState.Award)
                    else
                        self:doAnimate(floorId,groupId)
                    end
                end
            else
                if groupId == 1 and preId == 2 then
                    self:stopAnimate(floorId,groupId)
                    self:playFloorAnimate(EC_GameState.Random)
                else
                    self:doAnimate(floorId,groupId)
                end
            end
        end),
    })
    self.itemMoveList[floorId][groupId]:runAction(act)
end

function BingoMainViewNew:loadItem(floorId,groupId)

    local poolItem = self.poolItem[self.choosePoolType]
    local curPanel = self.itemMoveList[floorId][groupId]
    if not curPanel then
        return
    end
    for i=1,floorId do
        local item = poolItem[floorId]
        if curPanel.itemInfo[i] then
            self.showItemCnt[floorId] = self.showItemCnt[floorId] + 1
            if self.showItemCnt[floorId] > #item then
                self.showItemCnt[floorId] = 1
            end
            local itemIndex = self.showItemCnt[floorId]
            curPanel.itemInfo[i].itemId = item[itemIndex].itemId
            curPanel.itemInfo[i].id = item[itemIndex].id
            local isWin = BingoDataMgr:summonItemIsWin(self.choosePoolType,floorId,item[itemIndex].id)
            curPanel.itemInfo[i].bg:setGrayEnabled(isWin)
            local opacity =  isWin and 127 or 255
            curPanel.itemInfo[i].bg:setOpacity(opacity)
            PrefabDataMgr:setInfo(curPanel.itemInfo[i].item, item[itemIndex].itemId)
            local Panel_level_star = curPanel.itemInfo[i].item.ListView_star
            if Panel_level_star then
                Panel_level_star:setVisible(false)
            end
        end
    end
end

function BingoMainViewNew:stopAllFloorAnimate()

end

function BingoMainViewNew:onAfterLottery(poolType,luckItemId,luckyId)

    self:updateBtnType()

    if not poolType or not luckItemId or not luckyId then
        return
    end

    local floorId = BingoDataMgr:getSummonFloorId(poolType,luckItemId)
    if not floorId then
        Box("can not find floorId: poolType = "..poolType..", itemId = "..luckItemId)
        return
    end

    ---停止当前移动的层
    self.stopRunFloor = true
    self.nextId = 0

    self.luckyItem = luckItemId
    self.luckyfloorId = floorId
    self.luckyPoolType = poolType
    self.luckyId = luckyId

    local pos = self.Spine_luckyInfo[floorId].pos
    self.Spine_lucky:setPosition(pos)

    --self.reward = {}
    --table.insert(self.reward,{id = luckItemId, num = 1})
    ---缩短滑到中奖道具的时间
    --self.animateInfo[floorId].time = 0

end

function BingoMainViewNew:onSummonResultEvent(reward)
    self.reward = reward or {}
end


function BingoMainViewNew:registerEvents()

    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.updateSummonInfo, self))
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self,EV_BINGOGAME_SUMMON,handler(self.onAfterLottery, self));

    self.Button_store:onClick(function ()
        FunctionDataMgr:jStore()
    end)

    self.Button_callback:onClick(function ()

        Utils:openView("bingo.BingoDatingView")
    end)

    self.Button_turnplate:onClick(function ()
        Utils:openView("bingo.BingoTurnPlateView")
    end)

    self.Button_divination:onClick(function ()
        Utils:openView("bingo.BingoDivinationView")
    end)

    self.Button_dice:onClick(function ()
        Utils:openView("bingo.BingoDiceView")
    end)

    self.Button_do:onClick(function ()

        local cost = self.costItem_[self.choosePoolType]
        local summonCfgInfo =  self.bingoSummon[self.choosePoolType]
        if not summonCfgInfo then
            return
        end

        if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
            local function reaSummon()

                self.isSummoning = true
                self.Button_do:setTouchEnabled(false)
                self.Button_do:setGrayEnabled(true)
                self.Panel_touch:setVisible(true)

                SummonDataMgr:send_SUMMON_SUMMON(summonCfgInfo.id, cost.index)
            end
            if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_BingoSummon) then
                reaSummon()
            else
                local rstr = TextDataMgr:getTextAttr(303002)
                local formatStr = rstr and rstr.text or ""
                local content = string.format(formatStr, cost.num, TabDataMgr:getData("Item", cost.id).icon)
                local tipsId = 14110305
                Utils:openView("common.ReConfirmTipsView", {tittle = 303001, content = content, reType = EC_OneLoginStatusType.ReConfirm_BingoSummon, confirmCall = reaSummon})
            end
        else
            Utils:showTips(303046)
        end
        --BingoDataMgr:setTypeTest()
        --BingoDataMgr:setTestParam(510212)
    end)

    for k,v in ipairs(self.Button_TypeTab) do
        v.btn:onClick(function()
            self:clickPoolType(k)
        end)
    end

    self:setBackBtnCallback(function ()
        if self.isSummoning then
            return
        end
        AlertManager:closeLayer(self)
    end)

    self:setMainBtnCallback(function ()
        if self.isSummoning then
            return
        end
        AlertManager:closeLayer(self)
    end)

    self.Button_task:onClick(function()
        Utils:openView("bingo.BingoTaskView")
    end)

end

return BingoMainViewNew
