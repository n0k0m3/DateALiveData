
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
    self.itemRowMargin_ = 3
    self.goodsItem_ = {}
end

function KabalaTreeAward:initUI(ui)
    self.super.initUI(self, ui)
    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_bg = TFDirector:getChildByPath(ui, "Panel_bg")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")
    self.Panel_goodsItem_prefab = PrefabDataMgr:getPrefab("Panel_goodsItem")
    local ScrollView_reward = TFDirector:getChildByPath(self.Panel_root, "ScrollView_reward")

    self.Panel_final = TFDirector:getChildByPath(self.Panel_root, "Panel_final")
    self.Button_exit = TFDirector:getChildByPath(self.Panel_root, "Button_exit")
    self.Button_go = TFDirector:getChildByPath(self.Panel_root, "Button_go")
    self.Panel_final:setVisible(self.funcType == 2 and self.isTask)
    self.Panel_content:setVisible(not (self.funcType == 2 and self.isTask))

    if self.funcType == 2 and self.isTask then
        Utils:playSound(2003)
    end

    local itemCount = #self.itemList_
    local scroll_size = ScrollView_reward:getContentSize()
    if self.columnNum_ >= itemCount then
        local offW = (self.Panel_goodsItem_prefab:Size().width + self.itemColMargin_) * (self.columnNum_ - itemCount)
        local offH = self.Panel_goodsItem_prefab:Size().height + self.itemRowMargin_
        ScrollView_reward:setContentSize(CCSize(scroll_size.width - offW, offH))
    end
    self.GridView_reward = UIGridView:create(ScrollView_reward)
    self.GridView_reward:setItemModel(self.Panel_goodsItem_prefab)
    self.GridView_reward:setColumn(self.columnNum_)
    self.GridView_reward:setColumnMargin(self.itemColMargin_)
    self.GridView_reward:setRowMargin(self.itemRowMargin_)

    self.Panel_goodsRowItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_goodsRowItem")
    self:refreshView()
end

function KabalaTreeAward:refreshView()

    dump(self.itemList_)
    --Box("11")
    for i, v in ipairs(self.itemList_) do
        local data = v
        local Panel_goodsItem = self.Panel_goodsItem_prefab:clone()
        PrefabDataMgr:setInfo(Panel_goodsItem, data.id, data.num)
        table.insert(self.goodsItem_, Panel_goodsItem)
        self.GridView_reward:pushBackCustomItem(Panel_goodsItem)
    end

    self:playAni()
end

function KabalaTreeAward:playAni()
    local delay = 0
    local offsetX = self.Panel_goodsItem_prefab:Size().width * 0.5
    for row, items in ipairs(self.goodsItem_) do
        local item = items
        item:Alpha(0)
        item:PosX(item:PosX() - offsetX)
        delay = delay + 0.05
        local seq = Sequence:create({
                DelayTime:create(delay),
                Spawn:create({
                    CCFadeIn:create(0.2),
                    MoveBy:create(0.2, ccp(offsetX, 0)),
                })
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
            --local eventPointsTest = {}
            --eventPointsTest[1] = {event = 100010602,eventValid = true, visual = true, x =32, y = 0}
            --KabalaTreeDataMgr:updateHiddenEventInfo(eventPointsTest)
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
