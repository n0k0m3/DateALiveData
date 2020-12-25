local TaskTrainingBuyLevelView = class("TaskTrainingBuyLevelView", BaseLayer)


function TaskTrainingBuyLevelView:ctor(data)
    self.super.ctor(self,data)
    self:initData(data)
    self:showPopAnim(true)
    self:init("lua.uiconfig.task.taskTrainingBuyLevelView")
end

function TaskTrainingBuyLevelView:initData(data)
    self.curLevel = ActivityDataMgr2:getWarOrderLevel()
    self.maxLevel = ActivityDataMgr2:getWarOrderMaxLevel() - self.curLevel
    self.selectNum = 1
end

function TaskTrainingBuyLevelView:initUI(ui)
    self.super.initUI(self,ui)
    self.ui = ui

    self.Label_num      = TFDirector:getChildByPath(ui,"Label_num")

    self.Button_close  = TFDirector:getChildByPath(ui,"Button_close")
    self.Button_ok      = TFDirector:getChildByPath(ui,"Button_ok")
    self.panel_item     = TFDirector:getChildByPath(ui,"Panel_item")
    self.Button_down    = TFDirector:getChildByPath(ui,"Button_down")
    self.Button_up      = TFDirector:getChildByPath(ui,"Button_up")
    self.Slider_level      = TFDirector:getChildByPath(ui,"Slider_level")
    self.Label_desc      = TFDirector:getChildByPath(ui,"Label_desc")
    self.Label_tips      = TFDirector:getChildByPath(ui,"Label_tips")
    self.Image_res_icon      = TFDirector:getChildByPath(ui,"Image_res_icon")
    self.Label_res_num      = TFDirector:getChildByPath(ui,"Label_res_num")

    self.ListView_items    = UIGridView:create(TFDirector:getChildByPath(ui,"ScrollView_items"))
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setScale(0.8)
    self.ListView_items:setItemModel(Panel_goodsItem)
    self.ListView_items:setColumn(6)
    self.ListView_items:setColumnMargin(10)
    self.ListView_items:setRowMargin(10)

    self:updateUI(0)
end

function TaskTrainingBuyLevelView:updateUI(num)
    if self.nextLv and self.nextLv >= self.maxLevel and num > 0 then
        self:stopTimer()
        return
    end

    if num > 0 then
        self.selectNum = math.min(self.selectNum + 1, self.maxLevel)
    elseif num < 0 then
        self.selectNum = math.max(self.selectNum - 1, 1)
    end

    self:updateLevelUI()
    self.Slider_level:setPercent(self.selectNum / self.maxLevel * 100)
end

function TaskTrainingBuyLevelView:updateLevelUI()
    local targetLevel = self.curLevel + self.selectNum
    self.Label_num:setTextById(14220064,self.selectNum)
    self.Label_desc:setTextById(14220065,targetLevel)
    
    if self.selectNum <= 1 or self.selectNum >= self.maxLevel then
        self:stopTimer()
    end
    self:updateRewards()
    local levelCost, addExp = TaskDataMgr:getTrainingUpLevelCost(self.curLevel + self.selectNum)
    self.Label_res_num:setText(tostring(levelCost))
    self.Label_tips:setTextById(14220061, targetLevel, addExp)
end

function TaskTrainingBuyLevelView:updateRewards()
    local rewards = TaskDataMgr:getLevelRangeRewards(self.curLevel + 1, self.curLevel + self.selectNum)
    local items = self.ListView_items:getItems()
    local gap = #rewards - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local item = self.ListView_items:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.ListView_items:removeItem(1)
        end
    end

    local items = self.ListView_items:getItems()
    for i, item in ipairs(items) do
        local data = rewards[i]
        if data then
            PrefabDataMgr:setInfo(item, data[1], data[2])
        end
    end
end

function TaskTrainingBuyLevelView:stopTimer()
    self.startUpdate = false
end

function TaskTrainingBuyLevelView:resetUI()
    self.selectNum = 1
    self:updateUI(0)
end

function TaskTrainingBuyLevelView:onUpgradeLevel()
    AlertManager:closeLayer(self)
end

function TaskTrainingBuyLevelView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_WAR_ORDER_UPGRADE_LEVEL, handler(self.onUpgradeLevel, self))
    self.Button_close:onClick(function ()
        AlertManager:closeLayer(self)
     end)

    self.Button_ok:onClick(function()
        local levelCost = TaskDataMgr:getTrainingUpLevelCost(self.curLevel + self.selectNum)
        if MainPlayer:getOneLoginStatus("TrainingLevelBuy") then
            if GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND) < levelCost then
                Utils:showAccess(EC_SItemType.DIAMOND)
                return
            end
            ActivityDataMgr2:reqUWarOrderLevel(self.curLevel + self.selectNum)
            AlertManager:close()
        else
            local rstr = TextDataMgr:getTextAttr(14220066)
            local formatStr = rstr and rstr.text or ""
            local content = ""
            if TFLanguageMgr:getUsingLanguage() == cc.KOREAN then
                content = string.format(formatStr, TabDataMgr:getData("Item", EC_SItemType.DIAMOND).icon, levelCost)
            else
                content = string.format(formatStr, levelCost, TabDataMgr:getData("Item", EC_SItemType.DIAMOND).icon)
            end
            Utils:openView("common.ReConfirmTipsView", {tittle = 303001, content = content, reType = "TrainingLevelBuy", confirmCall = function()
                if GoodsDataMgr:getItemCount(EC_SItemType.DIAMOND) < levelCost then
                    Utils:showAccess(EC_SItemType.DIAMOND)
                    return
                end
                ActivityDataMgr2:reqUWarOrderLevel(self.curLevel + self.selectNum)
                AlertManager:close()
            end})
        end
    end)

    self.Button_up:onTouch(function(event)
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:holdDownAction(true)
            self:onTouchButtonUp()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)

    self.Button_down:onTouch(function(event)
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:holdDownAction(false)
            self:onTouchButtonDown()
        elseif event.name == "ended" then
            self:stopTimer()
        end
    end)
    self:addMEListener(TFWIDGET_ENTERFRAME,handler(self.update,self))

    self.Slider_level:addMEListener(
        TFSLIDER_CHANGED,
        function(...)
            local percent = self.Slider_level:getPercent()
            self.selectNum = math.max(math.floor(self.maxLevel * percent / 100), 1)
            self:updateLevelUI()
        end
    )
end

function TaskTrainingBuyLevelView:removeEvents()
    self:removeMEListener(TFWIDGET_ENTERFRAME)
end

function TaskTrainingBuyLevelView:holdDownAction(isAddOp)
    self.speedTiming = 0
    self.timing = 0
    self.needTime = 0
    self.entryFalg = false
    self.isAddOp = isAddOp
    self.startUpdate = true
    
end

function TaskTrainingBuyLevelView:update(target , dt)
    if self.startUpdate ~= true then
        return
    end
    self.timing = self.timing + dt
    self.speedTiming = self.speedTiming + dt
    if self.speedTiming >= 3.0 then
        self.entryFalg = true
        self.needTime = 0.01
    elseif self.speedTiming > 0.5 then
        self.entryFalg = true
        self.needTime = 0.05
    end
    if self.onTouchButtonUp and self.onTouchButtonDown then
        if self.entryFalg and self.timing >= self.needTime then
            if self.isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            self.timing = 0
        end
    end
end

function TaskTrainingBuyLevelView:onTouchButtonDown()
    print("onTouchButtonDown")
    self:updateUI(-1)
end

function TaskTrainingBuyLevelView:onTouchButtonUp()
    print("onTouchButtonUp")
    self:updateUI(1)
end

function TaskTrainingBuyLevelView:onHide()
    self:stopTimer()
    self.super.onHide(self)
end

function TaskTrainingBuyLevelView:removeUI()
    self.super.removeUI(self)
end

function TaskTrainingBuyLevelView:onClose()
    self:stopTimer()
    self.super.onClose(self)
end

return TaskTrainingBuyLevelView
