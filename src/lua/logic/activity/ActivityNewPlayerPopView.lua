--[[
    @desc：ActivityNewPlayerPopView
    @date: 2020-12-23 11:14:00
]]

local ActivityNewPlayerPopView = class("ActivityNewPlayerPopView",BaseLayer)

function ActivityNewPlayerPopView:initData()
    self.panelCfgs = {
        [1] = {
            id = 1,
            name = "15011145",
            name_en = "Novice manual"
        },
        [2] = {
            id = 2,
            name = "15011146",
            name_en = "Novice gift pack"
        },
        [3] = {
            id = 3,
            name = "15011147",
            name_en = "Novice sign in"
        },
    }
    self.layers = {}
    self.defaultSelectId = 1

    local _, unLockChapter = ActivityDataMgr:isNewPlayerBookRedShow()
    self.curTaskChapterSelect = unLockChapter or 1
end

function ActivityNewPlayerPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.activityNewPlayerPopView")
    self:showPopAnim(true)
end

function ActivityNewPlayerPopView:initUI(ui)
    self.super.initUI(self,ui)
    self._ui.Panel_gift:hide()
    self._ui.Panel_task:hide()
    self._ui.Panel_seven:hide()
    self.listBtns = UIListView:create(self._ui.ScrollView_btns)

    self:initLeftListBtns()
    self:selectViewById(self.defaultSelectId)
    self:addCountDownTimer()
    self:updateLeftBtnsRed()
end

function ActivityNewPlayerPopView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.btn_last:onClick(function()
        self:updateTask(-1)
    end)

    self._ui.btn_next:onClick(function()
        self:updateTask(1)
    end)

    EventMgr:addEventListener(self,EV_RECHARGE_UPDATE,handler(self.updateGifts, self))
    EventMgr:addEventListener(self, EV_TASK_RECEIVE, handler(self.onTaskReceiveEvent, self))
    EventMgr:addEventListener(self,EV_ACTIVITY_UPDATE_UI,handler(self.updateLeftBtnsRed, self))
    EventMgr:addEventListener(self, EV_TASK_UPDATE, function()
        self:updateTask()
    end)
end

function ActivityNewPlayerPopView:initLeftListBtns()
    -- 特训周
    local actId     = EC_ActivityType.SEVENDAY
    local actIdx    = ActivityDataMgr:getActIdx(actId)
    local data      = ActivityDataMgr:getActData(actIdx)
    if not data then
        table.remove(self.panelCfgs, 2)    
    end

    self.listBtns:removeAllItems()
    for i, v in ipairs(self.panelCfgs) do
        local btn = self._ui.btn_templetLeft:clone()
        btn.txt_ch = TFDirector:getChildByPath(btn, "txt_ch")
        btn.txt_en = TFDirector:getChildByPath(btn, "txt_en")
        btn.imgRed = TFDirector:getChildByPath(btn, "img_red")
        btn.img_select = TFDirector:getChildByPath(btn, "img_select")
        btn.txt_ch:setTextById(v.name)
        btn.txt_en:setText(v.name_en)
        btn.id = v.id
        self.listBtns:pushBackCustomItem(btn)
        btn:onClick(function()
            self:selectViewById(v.id)
        end)
    end
end

function ActivityNewPlayerPopView:updateLeftBtnsRed()
    for i, item in ipairs(self.listBtns:getItems()) do
        local redShow = false
        if item.id == 1 then
            redShow = ActivityDataMgr:isNewPlayerBookRedShow()
        elseif item.id == 2 then
            redShow = ActivityDataMgr:getIsCanReceive(1)
        end
        item.imgRed:setVisible(redShow)
    end
end

function ActivityNewPlayerPopView:updateTaskTopRed()

    local function checkChapterRed(chapter)
        local _bool = false
        for i, cfg in pairs(self.taskCfg) do
            if cfg.taskGroup == chapter then
                local stausInfo = TaskDataMgr:getTaskInfo(cfg.id)
                local _status = stausInfo and stausInfo.status or EC_TaskStatus.ING
                if _status == EC_TaskStatus.GET then
                    _bool = true
                    break
                end
            end
        end
        return _bool
    end

    local _, unLockChapter = ActivityDataMgr:isNewPlayerBookRedShow()
    if self._ui.btn_last:isVisible() then
        local lastChapter = self.curTaskChapterSelect - 1
        self._ui.img_lastRed:setVisible(checkChapterRed(lastChapter) and lastChapter <= unLockChapter)
    end
    if self._ui.btn_next:isVisible() then
        local nextChapter = self.curTaskChapterSelect + 1
        self._ui.img_nextRed:setVisible(checkChapterRed(nextChapter) and nextChapter <= unLockChapter)
    end
end

function ActivityNewPlayerPopView:selectViewById(_id)
    local id = _id or self.defaultSelectId
    
    local switchCaseChooseFunc = {
        [1] = function()
            if not self.layers[id] then
                self.layers[id] = self._ui.Panel_task
                self:updateTask()
            end
        end,
        [2] = function()
            if not self.layers[id] then
                local _scaler = 0.83
                local layer = requireNew("lua.logic.activity.SevenSignView"):new(true)
                layer:setScale(_scaler)
                local x = -GameConfig.WS.width * 0.5 * _scaler
                local y = -GameConfig.WS.height * 0.5 * _scaler
                layer:setPosition(ccp(x, y))
                self:addLayerToNode(layer, self._ui.Panel_seven)
                self.layers[id] = self._ui.Panel_seven
            end
        end,
        [3] = function()
            if not self.layers[id] then
                self.layers[id] = self._ui.Panel_gift
                self:updateGifts()
            end
        end
    }
    if not switchCaseChooseFunc[id] then
        Box("id not found!")
        return
    else
        switchCaseChooseFunc[id]()
    end

    for i, item in ipairs(self.listBtns:getItems()) do
        item.img_select:setVisible(item.id == id)
        local _color
        if item.id == id then
            _color = me.WHITE
        else
            _color = ccc3(86, 97, 136)
        end
        item.txt_ch:setFontColor(_color)
        item.txt_en:setColor(_color) 
    end

    for _id, v in pairs(self.layers) do
        v:setVisible(_id == id)
    end

end

function ActivityNewPlayerPopView:updateTask(changeNum)
    changeNum = changeNum or 0
    if not self.taskCfg or not self.groupNovice or not self.specialTaks then
        -- 策划觉得避免配置错误 单独加任务表
        self.taskCfg = TabDataMgr:getData("NoviceTask")
        self.groupNovice = {}
        self.specialTaks = {}
        for i, cfg in pairs(self.taskCfg) do
            if not self.groupNovice[cfg.taskGroup] then
                self.groupNovice[cfg.taskGroup] = {}
            end

            if not self.taskCfg[cfg.id].level then
                table.insert(self.groupNovice[cfg.taskGroup], cfg)
            else
                self.specialTaks[cfg.taskGroup] = cfg
            end

        end
        table.sort(self.groupNovice,function(a, b)
            return a[1].taskGroup < b[1].taskGroup
        end)
    end

    for i, cfgs in pairs(self.groupNovice) do
        table.sort(cfgs, function(a, b)
            local stateA = EC_TaskStatus.ING
            local stateB = EC_TaskStatus.ING
            if TaskDataMgr:getTaskInfo(a.id) then
                stateA = TaskDataMgr:getTaskInfo(a.id).status 
            end
            if TaskDataMgr:getTaskInfo(b.id) then
                stateB = TaskDataMgr:getTaskInfo(b.id).status 
            end
            local cfgA = TaskDataMgr:getTaskCfg(a.id)
            local cfgB = TaskDataMgr:getTaskCfg(b.id)
            if stateA ~= stateB then
                if stateA == EC_TaskStatus.GET then
                    return true
                elseif stateB == EC_TaskStatus.GET then
                    return false
                elseif stateA == EC_TaskStatus.GETED then
                    return false
                elseif stateB == EC_TaskStatus.GETED then
                    return true
                end
            else
                return cfgA.order < cfgB.order
            end
        end)
    end

    -- Panel_taskCtr
    self.curTaskChapterSelect = changeNum + self.curTaskChapterSelect
    self.curTaskChapterSelect = math.min(self.curTaskChapterSelect, #self.groupNovice)
    self.curTaskChapterSelect = math.max(self.curTaskChapterSelect, 1)
    self._ui.lab_titleDesc:setTextById(300832, self.curTaskChapterSelect)
    self._ui.btn_last:setVisible(self.curTaskChapterSelect ~= 1)
    self._ui.btn_next:setVisible(self.curTaskChapterSelect ~= #self.groupNovice)
    
    local specialCfg = self.specialTaks[self.curTaskChapterSelect]
    local stausInfo = TaskDataMgr:getTaskInfo(specialCfg.id)
    local taskCfg = TaskDataMgr:getTaskCfg(specialCfg.id)
    local _status = stausInfo and stausInfo.status or EC_TaskStatus.ING
    local rewards = taskCfg.reward[1]  
    self._ui.btn_getSpecialAward:setVisible(_status == EC_TaskStatus.GET)
    self._ui.btn_getSpecialAward:onClick(function()
        TaskDataMgr:send_TASK_SUBMIT_TASK(specialCfg.id)
    end)
    local _txt = TextDataMgr:getText(taskCfg.des)..TextDataMgr:getText(800005, stausInfo.progress, taskCfg.progress)
    self._ui.lab_specialDesc:setText(_txt)

    if self.specialAwardgoods then
        self.specialAwardgoods:removeFromParent()
        self.specialAwardgoods = nil
    end
    self.specialAwardgoods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    self.specialAwardgoods:setScale(0.55)
    self.specialAwardgoods:Pos(0, 0):AddTo(self._ui.panel_specialAward)
    PrefabDataMgr:setInfo(self.specialAwardgoods, rewards[1], rewards[2])

    self:updateListTask()
    self:updateTaskTopRed()
end

function ActivityNewPlayerPopView:updateListTask()
     if not self.listTask then
        self.listTask = UIListView:create(self._ui.ScrollView_task)
        self.listTask:setItemsMargin(5)
    end
    local data = self.groupNovice[self.curTaskChapterSelect]
    local items = self.listTask:getItems()
    local gap = #data - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            local item = self._ui.Panel_taskItem:clone()
            self.listTask:pushBackCustomItem(item)
        end
    else
        for i = 1, math.abs(gap) do
            self.listTask:removeItem(1)
        end
    end

    local items = self.listTask:getItems()
    for i, v in ipairs(items) do
        self:updateTaskItem(v, data[i])
    end
end

function ActivityNewPlayerPopView:updateTaskItem(item, data)
    local stausInfo = TaskDataMgr:getTaskInfo(data.id)
    local taskCfg = TaskDataMgr:getTaskCfg(data.id)
    local lab_title = TFDirector:getChildByPath(item, "lab_title")
    local lab_complete = TFDirector:getChildByPath(item, "lab_complete")
    local lab_taskDesc = TFDirector:getChildByPath(item, "lab_taskDesc")
    local btn_getTaskAward = TFDirector:getChildByPath(item, "btn_getTaskAward")
    local lab_progress = TFDirector:getChildByPath(item, "lab_progress")
    local Button_goto = TFDirector:getChildByPath(item, "Button_goto")

    lab_title:setTextById(taskCfg.name)
    local _txtId 
    local _status = EC_TaskStatus.ING
    if stausInfo then
        _status = stausInfo.status
        lab_progress:setTextById(800005, stausInfo.progress, taskCfg.progress)
    end
    lab_taskDesc:setTextById(taskCfg.des)

    lab_complete:setVisible(_status == EC_TaskStatus.GETED)
    Button_goto:setVisible(_status == EC_TaskStatus.ING and taskCfg.jumpInterface ~= 0)
    btn_getTaskAward:setVisible(_status == EC_TaskStatus.GET)

    Button_goto:onClick(function()
        FunctionDataMgr:enterByFuncId(taskCfg.jumpInterface)
    end)
    btn_getTaskAward:onClick(function()
        local _, unLockChapter = ActivityDataMgr:isNewPlayerBookRedShow()
        if self.curTaskChapterSelect > unLockChapter then
            Utils:showTips(15011152, (self.curTaskChapterSelect - 1))
            return
        end
        TaskDataMgr:send_TASK_SUBMIT_TASK(data.id)
    end)

    if not item.listAward then
        item.listAward = UIListView:create(TFDirector:getChildByPath(item, "ScrollView_listAward"))
        item.listAward:setItemsMargin(5)
    end
    item.listAward:removeAllItems()
    for i, v in ipairs(taskCfg.reward) do
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(goods, v[1], v[2])
        goods:setScale(0.5)
        item.listAward:pushBackCustomItem(goods)
    end
end

function ActivityNewPlayerPopView:updateGifts()
    if not self.girdGiftView then
        self.girdGiftView = UIGridView:create(self._ui.ScrollView_girdGift)
        self.girdGiftView:setItemModel(self._ui.panel_cell)
        self.girdGiftView:setColumn(4)
        self.girdGiftView:setRowMargin(20)
        self.girdGiftView:setColumnMargin(15)
    end

    local giftData = RechargeDataMgr:getGiftListByType(23)
    self.coolDown = {}
    local realDataList = {}
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in ipairs(giftData) do
        if v.startDate and v.endDate then
            if serverTime >= v.startDate and serverTime < v.endDate then
                table.insert(realDataList, v)
            end
        else
            table.insert(realDataList, v)
        end
    end

    local items = self.girdGiftView:getItems()
    local gap = #realDataList - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.girdGiftView:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.girdGiftView:removeItem(1)
        end
    end
    local items = self.girdGiftView:getItems()
    for i, item in ipairs(items) do
        local data = realDataList[i]
        if data then
            item:show()
            local cell_gift = TFDirector:getChildByPath(item, "cell_gift")
            local cell_item = TFDirector:getChildByPath(item, "cell_item")
            cell_gift:show()
            cell_item:show()
            self:updateGiftItem(cell_gift, data)
            if data.item then
                self:updateCellItem(cell_item, data.item)
            end
        end
    end
end

function ActivityNewPlayerPopView:onTaskReceiveEvent(reward)
    Utils:showReward(reward)
    self:updateLeftBtnsRed()
    -- self:updateTask()
end

function ActivityNewPlayerPopView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(500, -1, nil, handler(self.onCountDownPer, self))
    end
end

function ActivityNewPlayerPopView:onCountDownPer()
    if not self.coolDown then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    for k,v in pairs(self.coolDown) do
        local str = ""
        if v - serverTime > 0 then
            local day, hour, min = Utils:getFuzzyDHMS(v - serverTime, true)
            str = TextDataMgr:getText(4007008,day, hour, min)
        end
        k.Label_countdown:setText(str)
        k:setVisible(str ~= "")
    end
end

function ActivityNewPlayerPopView:updateGiftItem(item, data)
    local Button_buy = TFDirector:getChildByPath(item, "Button_buy"):show()
    local Button_get = TFDirector:getChildByPath(item, "Button_get"):hide()
    local Image_title_di = TFDirector:getChildByPath(item,"Image_title_di"):hide()
    local img_rightIcon  = TFDirector:getChildByPath(item,"img_rightIcon"):hide()
    local Label_title_desc = TFDirector:getChildByPath(item,"Label_title_desc")
    local Label_title_desc1 = TFDirector:getChildByPath(item,"Label_title_desc1")
    local Label_desc = TFDirector:getChildByPath(item,"Label_desc")
    local Label_num = TFDirector:getChildByPath(item,"Label_num")
    local img_countBg = TFDirector:getChildByPath(item,"img_countBg")
    local Label_countdown = TFDirector:getChildByPath(img_countBg,"Label_countdown")
    local Label_txt = TFDirector:getChildByPath(Button_get,"Label_txt")
    local Label_price    = TFDirector:getChildByPath(item,"Label_price")
    local Label_oldPriceLine = TFDirector:getChildByPath(item,"Label_oldPriceLine")
    local Label_oldPrice = TFDirector:getChildByPath(item,"Label_oldPrice")

    if not Label_price.oldPos then
        Label_price.oldPos  = Label_price:getPosition()
    end
    Label_price:setString("￥"..data.rechargeCfg.price)
    
    local jsonData = nil
    if data.extendData then
        jsonData = Json.decode(data.extendData)
    end
    if jsonData and jsonData.discount and jsonData.discount ~= "" then
        Label_oldPriceLine:setVisible(true)
        Label_oldPrice:setText(jsonData.discount)
        Label_price:setPositionY(Label_price.oldPos.y)
    else
        Label_oldPriceLine:setVisible(false)
        Label_price:setPositionY(Label_price.oldPos.y - 10)
    end
    
    local Image_exchange = TFDirector:getChildByPath(item,"Image_exchange")
    local btnSrc ="ui/supplyNew/recommond/"
    if data.buyType == 1 then
        local exchangeCfg = GoodsDataMgr:getItemCfg(data.exchangeCost[1].id)
        Image_exchange:show();
        Image_exchange:setTexture(exchangeCfg.icon)
        Image_exchange:setSize(CCSizeMake(40,40))
        Label_price:setString(data.exchangeCost[1].num);
        Label_price:setPositionX(Label_price.oldPos.x) 
        Button_buy:setTextureNormal(btnSrc.."2.png")
    else
        Label_price:setPositionX(Label_price.oldPos.x - 20)
        Image_exchange:hide()
        Button_buy:setTextureNormal(btnSrc.."1.png")
    end

    Label_num:setText(data.name)

    local Label_leftTime= TFDirector:getChildByPath(item,"Label_leftTime")
    Label_leftTime:setString(data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id).."/"..data.buyCount)
    Label_leftTime:setVisible(data.buyCount ~= 0)

    local Label_tips = TFDirector:getChildByPath(item,"Label_tips")
    Label_tips:setVisible(data.buyCount ~= 0)

    Label_desc:setText(data.des2)
    Label_desc:show()

    local serverTime = ServerDataMgr:getServerTime()
    Label_countdown:setText("")
    img_countBg.Label_countdown = Label_countdown
    img_countBg:setVisible(false)
    if data.startDate and data.endDate and serverTime >= data.startDate and serverTime < data.endDate then
        self.coolDown[img_countBg] = data.endDate
    end

    if RechargeDataMgr:isNewOpenGiftBag(data.rechargeCfg.id) then
        RechargeDataMgr:clearNewGiftBagFlag(data.rechargeCfg.id)
    end

    local isCanBuy = true
    if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
        isCanBuy = false
    end

    Button_buy:onClick(function()
        if data.buyCount ~= 0 and data.buyCount - RechargeDataMgr:getBuyCount(data.rechargeCfg.id) <= 0 then
            Utils:showTips(800117)
            return
        end
        RechargeDataMgr:getOrderNO(data.rechargeCfg.id)
    end)

    Button_buy:setGrayEnabled(not isCanBuy)
    Button_buy:setTouchEnabled(isCanBuy)

    if data.tag then
        Image_title_di:show()
        local tagType = data.tagIcon or 0
        local buyCount = RechargeDataMgr:getBuyCount(data.rechargeCfg.id)
        if buyCount == 0 then
            Label_title_desc:setText(data.tagDes)
            Label_title_desc1:setText(data.tagDes)
        elseif data.tagDes2 ~= "" then
            Label_title_desc:setText(data.tagDes2)
            Label_title_desc1:setText(data.tagDes2)
        else
            Image_title_di:hide()
        end
        Label_title_desc:setVisible(tagType == 1)
        Label_title_desc1:setVisible(tagType ~= 1)
    end
end

function ActivityNewPlayerPopView:updateCellItem(item, data, canTouch, posY)
	posY = posY or 25
	if canTouch == nil then
		canTouch = true
	end
	item:setPositionY(posY)

	local posList = {}
	posList[1] = {{0, -15, 0.65}}
	posList[2] = {{-38, -15, 0.65}, {38, -15, 0.65}}
	posList[3] = {{-38, 20, 0.65}, {38, 20, 0.65}, {0, -50, 0.55}}
	posList[4] = {{-38, 20, 0.65}, {38, 20, 0.65}, {33, -50, 0.55}, {-33, -50, 0.55}}

	if not item.list then
		item.list = {}
	end

	local curPos = posList[4]
	if #data < 4 then
		curPos = posList[#data]
	end
	for i = 1, 4 do
		local goodItem = item.list[i]
		if i <= #data then
			if not goodItem then
				goodItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
				item.list[i] = goodItem
				item:addChild(goodItem)
				goodItem:onClick(handler(self.onGoodItemClickHandle, self))
			end
			goodItem:setTouchEnabled(canTouch)
			goodItem:setScale(curPos[i][3])
			goodItem:setPosition(ccp(curPos[i][1], curPos[i][2]))
			goodItem:show()
			goodItem.id = data[i].id
			PrefabDataMgr:setInfo(goodItem, data[i].id, data[i].num)
		else
			if goodItem then
				goodItem.id = nil
				goodItem:hide()
				goodItem:setTouchEnabled(false)
			end
		end
	end
end

function ActivityNewPlayerPopView:removeEvents()
    self:removeCountDownTimer()
end

function ActivityNewPlayerPopView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

return ActivityNewPlayerPopView