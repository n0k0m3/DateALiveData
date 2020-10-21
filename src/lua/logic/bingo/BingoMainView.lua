
local BingoMainView = class("BingoMainView", BaseLayer)

EC_GameState = {
    Random = 1,
    Award = 2,
}

function BingoMainView:initData()

    self.showItemCnt = {}
    self.summonPoolTypeTab = BingoDataMgr:getBingoSummonPoolType()
    table.sort(self.summonPoolTypeTab,function(a,b)
        return a < b
    end)

    self.arrowPos = {}
    self.arrowPos[4] = {-169,-123,-42,42,123,169}
    self.arrowPos[3] = {-129,-80,0,80,129}
    self.arrowPos[2] = {-89,-42,42,89}
    self.arrowPos[1] = {0,0}

    self.arrowParam = {}
    self.arrowParam[4] = {speed = 0.08,circleUp = 2,circleStop = 2,recordUp = 0,recordStop = 0}
    self.arrowParam[3] = {speed = 0.10,circleUp = 2,circleStop = 2,recordUp = 0,recordStop = 0}
    self.arrowParam[2] = {speed = 0.12,circleUp = 2,circleStop = 2,recordUp = 0,recordStop = 0}
    self.arrowParam[1] = {speed = 0.1,circleUp = 2,circleStop = 3,recordUp = 0,recordStop = 0}

    self.spinebgRes = {"bg2","bg2","bg1","bg1"}
    self.bgSpineStop = true

    self.Spine_luckyInfo = {}
    self.Spine_luckyInfo[4] = {pos = ccp(-17,102),name = "awardLow_1_2",di = "awardLow_1_1",up = "awardLow_1_0"}
    self.Spine_luckyInfo[3] = {pos = ccp(-17,190),name = "awardLow_2_2",di = "awardLow_2_1",up = "awardLow_2_0"}
    self.Spine_luckyInfo[2] = {pos = ccp(-17,282),name = "awardLow_3_2",di = "awardLow_3_1",up = "awardLow_3_0"}
    self.Spine_luckyInfo[1] = {pos = ccp(-21,390),name = "evt_effect_awardHigh",di = "",up = ""}

    self.sound = {5010,5009,5008,5008}

    self.listBgImg = {}
    self.listBgImg[1] = {bgRes = "m1.png",select = "m3.png",bgRes1 = "m1.png",select1 = "m3.png"}
    self.listBgImg[2] = {bgRes = "m7.png",select = "m9.png",bgRes1 = "m7_1.png",select1 = "m9_1.png"}
    self.listBgImg[3] = {bgRes = "m4.png",select = "m6.png",bgRes1 = "m4_1.png",select1 = "m6_1.png"}
    self.listBgImg[4] = {bgRes = "m1.png",select = "m3.png",bgRes1 = "m1_1.png",select1 = "m3_1.png"}

    self.isFinish = false
    self.isSummoning = false
    self.costItem_ = {}

    self.curFloorId = 4
end

function BingoMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.bingo.bingoMainView")
end

function BingoMainView:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    self.Button_help = TFDirector:getChildByPath(self.Panel_root, "Button_help")
    self.Button_main = TFDirector:getChildByPath(self.Panel_root, "Button_main")
    self.Button_back = TFDirector:getChildByPath(self.Panel_root, "Button_back")
    self.Button_task = TFDirector:getChildByPath(self.Panel_root, "Button_task")
    self.Image_red = TFDirector:getChildByPath(self.Button_task, "Image_red")
    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Button_callback = TFDirector:getChildByPath(self.Panel_root, "Button_callback")
    self.Button_turnplate = TFDirector:getChildByPath(self.Panel_root, "Button_turnplate")
    self.Button_divination = TFDirector:getChildByPath(self.Panel_root, "Button_divination")
    self.Button_dice = TFDirector:getChildByPath(self.Panel_root, "Button_dice")
    --TFDirector:getChildByPath(self.Button_dice, "Label_btn"):setSkewX(15)
    --TFDirector:getChildByPath(self.Button_dice, "Label_btn_en"):setSkewX(15)

    self.Spine_sceneEffect = TFDirector:getChildByPath(self.ui, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.ui, "Spine_effectHB")
    self.Image_bg = TFDirector:getChildByPath(self.ui, "Image_bg")
    self.resItemId = {500002,500067,500066}
    self.resInfo = {}
    for i=1,3 do
        local Image_res_bg = TFDirector:getChildByPath(self.Panel_root, "Image_res_bg"..i)
        local numTx = TFDirector:getChildByPath(Image_res_bg, "Label_num")
        local icon = TFDirector:getChildByPath(Image_res_bg, "Image_icon")
        local btn = TFDirector:getChildByPath(Image_res_bg, "Button_add")
        table.insert(self.resInfo,{numTx = numTx,icon = icon,btn = btn})
    end

    self.Label_name = TFDirector:getChildByPath(self.Panel_root, "Label_name")
    self.Label_name:setSkewX(15)
    self.Label_name:setTextById(13310229)
    self.Label_name_en = TFDirector:getChildByPath(self.Panel_root, "Label_name_en")
    self.Label_name_en:setSkewX(15)
    self.Label_name_en:setTextById(13310228)

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

    self.Spine_bg = TFDirector:getChildByPath(self.Panel_root, "Spine_bg")
    self.Spine_lucky = TFDirector:getChildByPath(self.Panel_root, "Spine_lucky")
    self.Panel_lucky = TFDirector:getChildByPath(self.Panel_root, "Panel_lucky"):hide()
    self.Spine_lucky_di = TFDirector:getChildByPath(self.Panel_root, "Spine_lucky_di")
    self.floorTab = {}
    self.arrowImg = {}
    for id = 1,4 do
        self.floorTab[id] = {}
        local floorTab = TFDirector:getChildByPath(self.Panel_root, "Panel_itemlist_"..id)
        local Image_listbg = TFDirector:getChildByPath(floorTab, "Image_listbg")
        local select = TFDirector:getChildByPath(floorTab, "Image_select")
        select:setOpacity(0)
        local Image_di = TFDirector:getChildByPath(floorTab, "Image_di"):hide()
        local Image_di_red = TFDirector:getChildByPath(floorTab, "Image_di_red"):hide()
        local Image_arrow = TFDirector:getChildByPath(floorTab, "Image_arrow")
        Image_arrow:setOpacity(0)
        local Spine_lucky_di = TFDirector:getChildByPath(floorTab, "Spine_lucky_di")
        if Spine_lucky_di then
            Spine_lucky_di:hide()
        end
        self.arrowImg[id] = Image_arrow
        local tab = {}
        for j=1,id do
            local itemBg = TFDirector:getChildByPath(floorTab, "Image_item_bg"..j)
            local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
            Panel_goodsItem:AddTo(itemBg)
            Panel_goodsItem:Pos(0, 0)

            if id == 1 then
                local Image_frame = TFDirector:getChildByPath(Panel_goodsItem, "Image_frame")
                Image_frame:setVisible(false)
                Panel_goodsItem:setScale(1)
            else
                Panel_goodsItem:setScale(0.52)
            end
            table.insert(tab,{bg = itemBg,item = Panel_goodsItem,itemId = 0,id = 0})
        end
        self.floorTab[id] = {item = tab,select = select,listbg = Image_listbg,spineDi = Spine_lucky_di,Image_di = Image_di,Image_di_red = Image_di_red}
    end

    self.Button_TypeTab = {}
    for i=1,2 do
        local tab = {}
        tab.btn = TFDirector:getChildByPath(self.Panel_root, "Button_type"..i)
        tab.lock = TFDirector:getChildByPath(tab.btn, "Image_lock"):hide()
        tab.select = TFDirector:getChildByPath(tab.btn, "Image_select")
        tab.Label_btn = TFDirector:getChildByPath(tab.btn, "Label_btn")
        --tab.Label_btn:setSkewX(-5)
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

    self:updateTaskRedPoint()
    self:hideTopBar()
    self:updateRes()
    self:showModelInfo()
    self:initPoolItem()
    self:updateBtnType()
    self:clickPoolType(1)
    self:playBgSpine(self.curFloorId)

end

function BingoMainView:onShow()
    self.super.onShow(self)
    for i = 1,4 do
        local floorInfo = self.floorTab[i]
        if floorInfo and floorInfo.Image_di then
            floorInfo.Image_di:setVisible(false)
            floorInfo.Image_di_red:setVisible(false)
        end
    end
end

function BingoMainView:updateRes()

    for i=1,3 do
        local itemId = self.resItemId[i]
        local itemCfg = GoodsDataMgr:getItemCfg(itemId)
        local itemNum = GoodsDataMgr:getItemCount(itemId)
        self.resInfo[i].numTx:setText(itemNum)
        self.resInfo[i].icon:setTexture(itemCfg.icon)
        self.resInfo[i].btn:setVisible(i~=3)
        self.resInfo[i].btn:onClick(function()
            if i == 1 then
                FunctionDataMgr:jPay()
            elseif i==2 then
                FunctionDataMgr:jStore(306000)
            end
        end)
    end

end

function BingoMainView:playBgSpine(floorId)

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

function BingoMainView:showModelInfo()
    local dressTable = TabDataMgr:getData("Dress")
    local data = dressTable[411308]
    if data and data.type and data.type == 2 then
        self.model = ElvesNpcTable:createLive2dNpcID(data.highRoleModel,false,false,nil,true).live2d
        self.Image_role:addChild(self.model,1)
        self.model:setScale(0.7); --缩放
        local pos = ccp(330,0)
        self.model:setPosition(pos);--位置
        if data.backgroundEffect and data.backgroundEffect ~= 0 then
            self:refreshEffect(data.backgroundEffect,true)
        end

        if data.kanbanEffect and data.kanbanEffect ~= 0 then
            self:refreshEffect(data.kanbanEffect)
        end
        self.sceneBg = data.background
        self.Image_bg:setTexture(self.sceneBg)
    end
end

function BingoMainView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_sceneEffect
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
    end
end

function BingoMainView:updateSummonInfo()

    self:updateRes()

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

function BingoMainView:initPoolItem()

    self.poolItem = {}
    for k,poolType in ipairs(self.summonPoolTypeTab) do
        self.poolItem[poolType] = {}
        for i = 1,4 do
            local item = BingoDataMgr:getBingoSummonPool(poolType,i)
            self.poolItem[poolType][i] = item
        end
    end
end

function BingoMainView:updateBtnType()
    for k,v in ipairs(self.Button_TypeTab) do
        local isOpen = BingoDataMgr:isOpenPool(v.poolType)
        if isOpen then
            v.lock:setVisible(false)
        else
            v.lock:setVisible(true)
        end

    end
end

function BingoMainView:clickPoolType(btnIndex)

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
    self.luckyfloorId = 2
    self:updateTower(poolType)
end

function BingoMainView:updateTower(poolType)

    self.choosePoolType = poolType

    local poolItem = self.poolItem[poolType]
    for floorId = 1,4 do
        local item = poolItem[floorId]
        local curPanel = self.floorTab[floorId].item
        if not curPanel then
            return
        end

        for j=1,floorId do
            if curPanel[j] then
                if not self.showItemCnt[floorId] then
                    self.showItemCnt[floorId] = 0
                end
                self.showItemCnt[floorId] = self.showItemCnt[floorId] + 1
                if self.showItemCnt[floorId] > #item then
                    self.showItemCnt[floorId] = 1
                end
                local itemIndex = self.showItemCnt[floorId]
                curPanel[j].itemId = item[itemIndex].itemId
                curPanel[j].id = item[itemIndex].id
                local isWin = BingoDataMgr:summonItemIsWin(poolType,floorId,item[itemIndex].id)
                curPanel[j].bg:setGrayEnabled(isWin)
                local opacity =  isWin and 127 or 255
                curPanel[j].bg:setOpacity(opacity)
                print(item[itemIndex].count)
                PrefabDataMgr:setInfo(curPanel[j].item, item[itemIndex].itemId,item[itemIndex].count)
                local Panel_level_star = curPanel[j].item.ListView_star
                if Panel_level_star then
                    Panel_level_star:setVisible(false)
                end
            end
        end

        local bgRes = poolType == 32 and self.listBgImg[floorId].bgRes or self.listBgImg[floorId].bgRes1
        local selectRes = poolType == 32 and self.listBgImg[floorId].select or self.listBgImg[floorId].select1

        self.floorTab[floorId].listbg:setTexture("ui/activity/bingoGame/main/"..bgRes)
        self.floorTab[floorId].select:setTexture("ui/activity/bingoGame/main/"..selectRes)
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

end

function BingoMainView:jumpToFloor(floorId)

    if self.floorTab[floorId].spineDi then
        self.floorTab[floorId].spineDi:setVisible(true)
        self.floorTab[floorId].spineDi:play(self.Spine_luckyInfo[floorId].up,false)
        self.floorTab[floorId].spineDi:addMEListener(TFARMATURE_COMPLETE,function()
            self.floorTab[floorId].spineDi:removeMEListener(TFARMATURE_COMPLETE)
            self.floorTab[floorId].spineDi:setVisible(false)
        end)
    end

    self:timeOut(function()
        self.curFloorId = floorId
        self.floorTab[floorId].select:runAction(CCFadeIn:create(0.2))
        self:playArrow(floorId,2)
    end,0.5)
end

function BingoMainView:playArrow(floorId,id)

    local targetPosX = self.arrowPos[floorId][id]
    local t = self.arrowParam[floorId].speed
    local act = Sequence:create({
        CCSpawn:create({
            CCMoveTo:create(t,ccp(targetPosX,0)),
            CCFadeIn:create(t)
        }),
        CCCallFunc:create(function()
            if floorId ~= 1 then
                Utils:playSound(5016, false)
            end

            local curItem = self.floorTab[floorId].item[id-1]
            if curItem and self.isFinish and self.luckyId == curItem.id then
                self.arrowImg[floorId]:stopAllActions()
                BingoDataMgr:updateSummonItemState(self.luckyPoolType,self.luckItemId)
                curItem.bg:setGrayEnabled(true)
                curItem.bg:setOpacity(127)
                self:stopArrow(floorId)
                return
            end
            local nextId = id + 1
            if nextId > #self.arrowPos[floorId] then
                self:finishCircle(floorId)
            else
                self:playArrow(floorId,nextId)
            end
        end)
    })
    self.arrowImg[floorId]:runAction(act)
end

function BingoMainView:finishCircle(floorId)

    self.arrowImg[floorId]:setOpacity(0)
    self.arrowImg[floorId]:setPositionX(self.arrowPos[floorId][1])
    if self.luckyfloorId == floorId then
        self.arrowParam[floorId].recordStop = self.arrowParam[floorId].recordStop + 1
        if self.arrowParam[floorId].recordStop >= self.arrowParam[floorId].circleStop then
            self.isFinish = true
            self.arrowParam[floorId].recordStop = 0
        end
    else
        self.arrowParam[floorId].recordUp = self.arrowParam[floorId].recordUp + 1
        if self.arrowParam[floorId].recordUp >= self.arrowParam[floorId].circleUp then
            self.arrowParam[floorId].recordUp = 0
            self.arrowImg[floorId]:stopAllActions()
            self.floorTab[floorId].select:runAction(CCFadeOut:create(0.2))
            local nextFloorId = floorId-1
            if nextFloorId <= 0 then
                nextFloorId = 4
            end
            self:jumpToFloor(nextFloorId)
            return
        end
    end
    self:playArrow(floorId,2)
end

function BingoMainView:stopArrow(floorId)

    self.luckyfloorId = nil
    self.luckyId = nil
    self.isFinish = false
    self.isSummoning = false
    self.luckyPoolType,self.luckItemId = nil,nil
    self:updateSummonInfo()

    local isOpen = BingoDataMgr:isOpenPool(self.choosePoolType)
    local isAllSummon = BingoDataMgr:isSummonAll(self.choosePoolType)
    self.Button_summonall:setVisible(isAllSummon)
    self.Button_do:setVisible(not isAllSummon and isOpen)

    self.curFloorId = 4

    if not next(self.reward) then
        return
    end

    if self.choosePoolType == 32 then
        self.floorTab[floorId].Image_di:setVisible(true)
    else
        self.floorTab[floorId].Image_di_red:setVisible(true)
    end


    Utils:playSound(self.sound[floorId], false)
    self.Panel_lucky:setVisible(true)
    self.Spine_lucky:play(self.Spine_luckyInfo[floorId].name,false)
    self.Spine_lucky:addMEListener(TFARMATURE_COMPLETE,function()
        self.Spine_lucky:removeMEListener(TFARMATURE_COMPLETE)
        self.Panel_lucky:setVisible(false)
        self:timeOut(function ()
            self.floorTab[floorId].select:runAction(CCFadeOut:create(0.2))
            self.arrowImg[floorId]:setPositionX(self.arrowPos[floorId][1])
            self.arrowImg[floorId]:setOpacity(0)
            self.Panel_touch:setVisible(false)
            Utils:showReward(self.reward)
        end,0.2)
    end)
end

function BingoMainView:onAfterLottery(poolType,luckItemId,luckyId)

    self:updateBtnType()

    if not poolType or not luckItemId or not luckyId then
        self.Button_do:setTouchEnabled(true)
        self.Button_do:setGrayEnabled(false)
        self.Panel_touch:setVisible(false)
        self.isSummoning = false
        return
    end

    local floorId = BingoDataMgr:getSummonFloorId(poolType,luckItemId)
    if not floorId then
        Box("can not find floorId: poolType = "..poolType..", itemId = "..luckItemId)
        return
    end

    local animate = ""
    local items = self.poolItem[poolType][floorId]
    if items then
        for k,v in ipairs(items) do
            if v.id == luckyId then
                animate = v.showAction
                break
            end
        end
    end

    if self.model then
        self.model:newStartAction(animate,EC_PRIORITY.FORCE)
    end

    self.isSummoning = true
    self.Button_do:setTouchEnabled(false)
    self.Button_do:setGrayEnabled(true)
    self.Panel_touch:setVisible(true)

    ---停止当前移动的层
    self.luckyfloorId = floorId
    self.luckyId = luckyId
    self.luckItemId = luckItemId
    self.luckyPoolType = poolType

    local pos = self.Spine_luckyInfo[floorId].pos
    self.Panel_lucky:setPosition(pos)

    self:timeOut(function()
        self:jumpToFloor(4)
    end,0.2)
end

function BingoMainView:onSummonResultEvent(reward)
    self.reward = reward or {}
end

function BingoMainView:updateTaskRedPoint()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.BINGOGAME)
    local isShow = ActivityDataMgr2:isShowRedPoint(activity[1])
    self.Image_red:setVisible(isShow)
end

function BingoMainView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(self.updateTaskRedPoint, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.updateTaskRedPoint, self))

    EventMgr:addEventListener(self,EV_BAG_ITEM_UPDATE,handler(self.updateSummonInfo, self))
    EventMgr:addEventListener(self, EV_SUMMON_RESULT, handler(self.onSummonResultEvent, self))
    EventMgr:addEventListener(self,EV_BINGOGAME_SUMMON,handler(self.onAfterLottery, self));

    self.Button_store:onClick(function ()
        FunctionDataMgr:jStore(306000)
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

        self.reward = {}

        local isOpen = ActivityDataMgr2:isOpen(EC_ActivityType2.BINGOGAME)
        if not isOpen then
            return
        end

        local cost = self.costItem_[self.choosePoolType]
        local summonCfgInfo =  self.bingoSummon[self.choosePoolType]
        if not summonCfgInfo then
            return
        end

        if GoodsDataMgr:currencyIsEnough(cost.id, cost.num) then
            local function reaSummon()
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
        --BingoDataMgr:setTestParam(411309)
    end)

    for k,v in ipairs(self.Button_TypeTab) do
        v.btn:onClick(function()
            self:clickPoolType(k)
        end)
    end

    self.Button_back:onClick(function ()
        AlertManager:closeLayer(self)
    end)

    self.Button_main:onClick(function ()
        local currentScene = Public:currentScene();
        if currentScene.__cname == "MainScene" then
            AlertManager:closeAll()
        elseif currentScene.__cname == "BaseOSDScene" then -- 大世界场景中 所有界面退回主场景弹出提示
            local args = {
                tittle = 2107025,
                content = TextDataMgr:getText(14110234),
                reType = EC_OneLoginStatusType.ReConfirm_ExitTeamScene,
                confirmCall = function()
                    AlertManager:changeScene(SceneType.MainScene);
                end,
            }
            Utils:showReConfirm(args)
        else
            AlertManager:changeScene(SceneType.MainScene);
        end
    end)


    self.Button_help:onClick(function()
        Utils:openView("common.HelpView",{1042})
    end)

    self.Button_task:onClick(function()
        Utils:openView("bingo.BingoTaskView")
    end)

end

return BingoMainView
