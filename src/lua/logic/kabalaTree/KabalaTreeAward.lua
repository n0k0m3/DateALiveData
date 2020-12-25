
local KabalaTreeAward = class("KabalaTreeAward", BaseLayer)


function KabalaTreeAward:ctor(itemList,funcType,isTask)
    self.super.ctor(self)
    self:initData(itemList,funcType,isTask)
    self:init("lua.uiconfig.kabalaTree.kabalaTreeAward")
end

function KabalaTreeAward:initData(itemList,funcType,isTask)
    self.itemList_ = itemList or {}
    self.funcType = funcType or 1
    self.isTask = isTask or false
    self.columnNum_ = 5
    self.itemColMargin_ = 10
    self.itemRowMargin_ = 15
    self.goodsItem_ = {}
    self.itemScale = 1
end

function KabalaTreeAward:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")
    self.Panel_item_mask = TFDirector:getChildByPath(self.Panel_root, "Panel_item_mask")
    
    self.Panel_final = TFDirector:getChildByPath(self.Panel_root, "Panel_final")
    self.Button_exit = TFDirector:getChildByPath(self.Panel_root, "Button_exit")
    self.Button_go = TFDirector:getChildByPath(self.Panel_root, "Button_go")
    self.Panel_final:setVisible(self.funcType == 2 and self.isTask)
    self.Panel_content:setVisible(not (self.funcType == 2 and self.isTask))

    if self.funcType == 2 and self.isTask then
        Utils:playSound(2003)
    end

    local itemCount = #self.itemList_
    local offW = 0
    local offH = 0
    if self.columnNum_ >= itemCount then
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * itemCount
        offH = self.Panel_goodsItem_prefab:Size().height + self.itemRowMargin_
    else
        offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * self.columnNum_
        offH = ScrollView_reward:getSize().height
    end
    ScrollView_reward:setContentSize(CCSize(offW, offH))
    self.Panel_item_mask:setContentSize(CCSize(offW+50, offH+40))
    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)
    self.GridView_reward:setColumn(self.columnNum_)
    self.GridView_reward:setColumnMargin(self.itemColMargin_)
    self.GridView_reward:setRowMargin(self.itemRowMargin_)

    self.Spine_getItem = TFDirector:getChildByPath(ui, "Spine_getItem")
    self.Spine_before = TFDirector:getChildByPath(ui, "Spine_before")

    self.Panel_goodsRowItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsRowItem")
    self.Spine_before:play("effect_props_start",false)
    self.Spine_before:addMEListener(TFARMATURE_COMPLETE,function()
        self:timeOut(function()
            self.Spine_before:removeMEListener(TFARMATURE_COMPLETE)
            self.Spine_before:play("effect_props_start_1",true)
        end, 0)
    end)
    Utils:playSound(6001)
    self:timeOut(function()
        self:refreshView()
    end, 0.2)
end

function KabalaTreeAward:refreshView()

    for i, v in ipairs(self.itemList_) do
        local data = v
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, data.originId or data.id, data.num)
        Panel_goodsItem:setScale(2)
        Panel_goodsItem:setOpacity(0)
        local itemCfg = GoodsDataMgr:getItemCfg(data.id)

        if itemCfg  then
            if EC_ItemQualityEffect[itemCfg.quality] then
                local Spine_qualityEffect_bg = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_bg")
                Spine_qualityEffect_bg:setVisible(true)
                Spine_qualityEffect_bg:play(EC_ItemQualityEffect[itemCfg.quality].bg,true)
                local Spine_qualityEffect_up2 = TFDirector:getChildByPath(Panel_goodsItem, "Spine_qualityEffect_up2")
                Spine_qualityEffect_up2:play(EC_ItemQualityEffect[itemCfg.quality].up2,true)
                Spine_qualityEffect_up2:setVisible(false)
                local pos = ccp(1,-1)
                if itemCfg.quality == EC_ItemQuality.PURPLE then
                    pos = ccp(2,-1)
                elseif itemCfg.quality == EC_ItemQuality.RED then
                    pos = ccp(1,1)
                end
                Spine_qualityEffect_up2:setPosition(pos)
            end
            Panel_goodsItem.quality = itemCfg.quality
        end

        table.insert(self.goodsItem_, Panel_goodsItem)
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    self:timeOut(function()
        self:playAni()
    end, 0.1)

end

function KabalaTreeAward:playAni()
    local delay = -0.1
    local offsetX = self.Panel_goodsItem_prefab:Size().width * 0.5
    local itemCount = #self.goodsItem_
    local waitTime = itemCount == 1 and 0.2 or 0.1
    local showItemCnt = 0
    for row, items in ipairs(self.goodsItem_) do
        --for _, item in ipairs(items) do
        local item = items
        --item:hide()
        item:Alpha(0)
        local Spine_qualityEffect_up = TFDirector:getChildByPath(item, "Spine_qualityEffect_up")
        Spine_qualityEffect_up:setVisible(true)
        local itemQuality =  item.quality
        local normalTime = 0.1
        delay = delay + normalTime
        local seq = Sequence:create({
            DelayTime:create(delay),
            Spawn:create({
                CCFadeIn:create(0.15),
                CCScaleTo:create(0.15,self.itemScale),
            }),
            CallFunc:create(function()
                Utils:playSound(6002)
                showItemCnt = showItemCnt + 1
                print(showItemCnt)
            end),
            DelayTime:create(waitTime),
            CallFunc:create(function()
                if itemQuality and EC_ItemQualityEffect[itemQuality] then
                    local pos = ccp(1,-1)
                    if item.quality == EC_ItemQuality.PURPLE then
                        pos = ccp(0,2)
                    elseif item.quality == EC_ItemQuality.RED then
                        pos = ccp(1,1)
                    end
                    Spine_qualityEffect_up:setPosition(pos)
                    Spine_qualityEffect_up:play(EC_ItemQualityEffect[itemQuality].up,false)
                    local Spine_qualityEffect_up2 = TFDirector:getChildByPath(item, "Spine_qualityEffect_up2")
                    Spine_qualityEffect_up2:setVisible(true)
                end
            end),
        })
        item:runAction(seq)
    end

end
function KabalaTreeAward:registerEvents()
    self.Panel_bg:onClick(function()
        AlertManager:closeLayer(self)
    end)

    self.Button_exit:onClick(function()
        self:jump()
    end)

    self.Button_go:onClick(function()
        AlertManager:closeLayer(self)
    end)
end

function KabalaTreeAward:jump()
    if self.funcType == 2 then
        EventMgr:dispatchEvent(EV_DAL_MAP.CloseDal)
        AlertManager:closeLayer(self)
    end
end

function KabalaTreeAward:onShow()
   self.super.onShow(self)
end

function KabalaTreeAward:onHide()
    self.super.onHide(self)

    KabalaTreeDataMgr:setKabalaTreeAwardInst(nil)
    DalMapDataMgr:setAwardInst(nil)

    if self.funcType == 1 then
        local newBuffs =  KabalaTreeDataMgr:getNewBuffs()
        if newBuffs and newBuffs[1] then
            Utils:openView("kabalaTree.KabalaTreeAwardBuff",newBuffs[1].buffCid)
        else
            local eventPoints = KabalaTreeDataMgr:getHiddenEventPoints()
            if eventPoints then
                EventMgr:dispatchEvent(EV_PLAY_HIDDENEVENT_EFFECT)
            end
        end
    elseif self.funcType == 2 then

        local isFinishBossTask = DalMapDataMgr:isFinishBossTask()
        local finalPlot = DalMapDataMgr:getFinalPlot()
        if isFinishBossTask and finalPlot == 0 then
            DalMapDataMgr:setBosstaskState(false)
            DalMapDataMgr:showTaskAward(true)
            return
        end

        local finishWorld = DalMapDataMgr:getEventClearWorldCid()
        local curWorldCid = DalMapDataMgr:getCurWorld()
        if curWorldCid == finishWorld then
           
            EventMgr:dispatchEvent(EV_DAL_MAP.EventClear)
        end
    end

end

return KabalaTreeAward
