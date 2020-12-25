
--[[
    @desc:2周年庆翻牌游戏
]]

local TurnTabletGameView = class("TurnTabletGameView",BaseLayer)

local Row = 5    -- 行
local Line = 5   -- 列
local Dis = 9   -- 空隙间距

function TurnTabletGameView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.TURNTABLET2)
    if #activity <= 0 then
        return
    end
    
    self.activityId = activity[1]
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId)
    self.costGoodsId = self.activityInfo_.extendData.costItem
    
    TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_INFO()

    self.gridItemList_ = {}
    self.isFirstIn = true
end

function TurnTabletGameView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.twoYearTurnTablet.turnTabletGame")      
end

function TurnTabletGameView:initUI(ui)
    self.super.initUI(self,ui)

    self.gridReward = UIGridView:create(self._ui.ScrollView_rewardList)
    self.gridReward:setItemModel(self._ui.rewardItem)
    self.gridReward:setColumn(4)
    self.gridReward:setColumnMargin(-10)
    self.gridReward:setRowMargin(5)
    local bar = UIScrollBar:create(self._ui.Image_scrollBar, self._ui.Image_innerScrollBar)
    self.gridReward:setScrollBar(bar)

    self._ui.Panel_touch:hide()
    self._ui.Panel_touch:setTouchEnabled(true)
    self._ui.Panel_touch:setSwallowTouch(true)

    self._ui.Panel_r:hide()
    self._ui.lab_lastTime:hide()
end 

function TurnTabletGameView:registerEvents()
    EventMgr:addEventListener(self, EV_ACTIVITY_DELETED, function ( activityId )
        if self.activityId == activityId then
            AlertManager:closeLayer(self)
        end
    end)

    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, function()
        self:refreshUI()
    end)

    EventMgr:addEventListener(self, EV_TURNTABLET2_DATAUPDATE, function()
        if self.isFirstIn then
            self._ui.Panel_r:show()
            self:goTheNextFloor()
            self.isFirstIn = false
        end
    end)
    EventMgr:addEventListener(self, EV_TURNTABLET2_TURNTABLETRESULT, handler(self.updateChooseTablet, self))
    EventMgr:addEventListener(self, EV_TURNTABLET2_CHOOSEPASSAWARD, handler(self.goTheNextFloor, self))
    EventMgr:addEventListener(self, EV_TURNTABLET2_BEGINTURNTABLET, handler(self.beginCleanOutTablet, self))
    EventMgr:addEventListener(self, EV_TURNTABLET2_GONEXTFLOOR, handler(self.goTheNextFloor, self))

    self._ui.Button_open:onClick(function()
        self:clickStartTurn()
    end)

    self._ui.btn_chooseReward:onClick(function()
        self:goPopAwardView()
    end)

    if self.Button_special then
        self.Button_special:onClick(function()
            self:clickBtnSpecial()
        end)
    end

    if not self.timer then
        self.timer = TFDirector:addTimer(1000, -1, nil, handler(self.timerFunc, self))
    end
    self:timerFunc()
end

function TurnTabletGameView:timerFunc()
    local data = TurnTabletMgr:getTurnTabletData()
    if not data then
        return
    end
    local endTime = self.activityInfo_.endTime
    local lastTime = endTime - ServerDataMgr:getServerTime()
    if lastTime < 0 then
        lastTime = 0
    end
    local day, hour, min  = Utils:getFuzzyDHMS(lastTime)
    if day > 0 then
        self._ui.lab_lastTime:setTextById(800069, day, hour)
    else
        if min == 0 then
            min = 1
        end
        self._ui.lab_lastTime:setTextById(1260001, hour, min)
    end
    self._ui.lab_lastTime:show()
end

function TurnTabletGameView:refreshUI()
    local data = TurnTabletMgr:getTurnTabletData()
   
    self._ui.lab_curFloor:setText(data.layer)
    self._ui.lab_curFreeNum:setText(data.freeCount.."/"..data.freeCountLimit)
    self._ui.lab_curFreeNum:setVisible(data.freeCount > 0)
    self._ui.Panel_goodsCount:setVisible(data.freeCount <= 0)
    self._ui.lab_curLastCount:setText(GoodsDataMgr:getItemCount(self.costGoodsId).."/1")
    if GoodsDataMgr:getItemCount(self.costGoodsId) <= 0 then
        self._ui.lab_curLastCount:setColor(me.RED)
    else
        self._ui.lab_curLastCount:setColor(me.WHITE)
    end
    self._ui.Button_open:setGrayEnabled(not data.passId)
    self._ui.Button_open:setVisible(not data.started)

    local Image_add = TFDirector:getChildByPath(self._ui.btn_chooseReward, "Image_add")
    Image_add:removeAllChildren()
    if data.passId then
        local goodsId, goodsNum = next(TurnTabletMgr:getTurnTabletCfgById(data.passId).reward)
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        PrefabDataMgr:setInfo(goods, goodsId, goodsNum)
        goods:AddTo(Image_add)
        goods:Pos(ccp(0,0))
        goods:setScale(0.8)
        goods:setSwallowTouch(false)
        goods:onClick(function()
        end)
    end
end

function TurnTabletGameView:clickStartTurn()
    local data = TurnTabletMgr:getTurnTabletData()
    if not data.passId then
        Utils:showTips(12034013)
        self._ui.Button_open:setGrayEnabled(true)
        return
    end
    TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_START()
    self:isPanelTouchShow(true)
end

function TurnTabletGameView:isPanelTouchShow(_bool)
    if _bool then
        self._ui.Panel_touch:show()
        self._ui.Panel_touch:runAction(
            Sequence:create({
                DelayTime:create(4),
                CallFunc:create(function()
                    self._ui.Panel_touch:hide()
                end)
            })
        )
    else
        self._ui.Panel_touch:stopAllActions()
        self._ui.Panel_touch:hide()
    end
end

function TurnTabletGameView:refreshGirdView()
    local data = TurnTabletMgr:getTurnTabletData()
    local rewards = data.leftReward or {}
    local rewardData = {}
    for i, v in ipairs(rewards) do
        if v.id ~= 0 then
            table.insert(rewardData, v)
        end
    end

    if data.passId then
        table.sort(rewardData, function(a, b)
            return a.id == data.passId
        end)
    end
     
	local changeNum = #rewardData - #self.gridReward:getItems()
	if changeNum < 0 then
		for i = 1,math.abs(changeNum) do
			self.gridReward:removeItem(1)
		end
	end

	for k = 1, #rewardData do
		local item = self.gridReward:getItem(k)
		if not item then
			item = self.gridReward:pushBackDefaultItem()
		end
		self:updateGirdItem(item, rewardData[k])
	end

end

function TurnTabletGameView:updateGirdItem(item, data)
    local lab_num = TFDirector:getChildByPath(item, "lab_num")
    local itemPos = TFDirector:getChildByPath(item, "itemPos")
    local img_lock = TFDirector:getChildByPath(itemPos, "img_lock")

    local cfg = TurnTabletMgr:getTurnTabletCfgById(data.id)
    local goodsId, goodsNum = next(cfg.reward)
    local goods = item.goods
    if not goods then
        goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        goods:AddTo(item)
        goods:Pos(itemPos:getPosition())
        goods:setScale(0.85)
        item.goods = goods
    end
    PrefabDataMgr:setInfo(goods, goodsId, goodsNum)
    lab_num:setText(data.num.."/"..data.total)
    img_lock:setVisible(data.num <= 0)
end

function TurnTabletGameView:initAllTablets()
    self._ui.panel_gameMain:removeAllChildren()

    local data = TurnTabletMgr:getTurnTabletData()
    local size = self._ui.panel_gameMain:getContentSize()
    local itemSize = self._ui.tabletItem:getContentSize()
    local limitWidth = (size.width - (Row - 1) * Dis) / Row
    local limitHight = (size.height - (Line - 1) * Dis) / Line
    self._ui.tabletItem:setScaleX(limitWidth / itemSize.width)
    self._ui.tabletItem:setScaleY(limitHight / itemSize.height)

    local btnSize = self._ui.Button_special:getContentSize()
    -- 这个通用按钮图 切得周边有空白 所以加大0.1的缩放
    self._ui.Button_special:setScaleX(limitWidth / btnSize.width + 0.1) 
    self._ui.Button_special:setScaleY(limitHight / btnSize.height + 0.1)

    for i = 1, Row * Line do
        local _x, _y
        local item = self._ui.tabletItem:clone()
        local Image_iconFrame = TFDirector:getChildByPath(item, "Image_iconFrame"):show()
        local Image_hadGetted = TFDirector:getChildByPath(item, "Image_hadGetted"):hide()
        local _row = math.ceil(i / Row)
        local _line = i % Line
        _line = _line == 0 and Line or _line

        if _line == 1 then       -- 两边要靠边
            _x = limitWidth / 2
        elseif _line == Line then
            _x = size.width - limitWidth / 2
        else
            _x = (limitWidth + Dis) * (_line - 1) + limitWidth / 2
        end
        if _row == 1 then      
            _y = -limitWidth / 2
        elseif _row == Row then
            _y = -size.height + limitHight / 2
        else
            _y = -(limitHight + Dis) * (_row - 1) - limitHight / 2
        end

        item:setTouchEnabled(true)
        item:onClick(function(sender)
            TFAudio.playSound("sound/ui/function_022.mp3")
            local _data = TurnTabletMgr:getTurnTabletData()
            if not _data.passId then
                Utils:showTips(12034013)
                return
            end

            if not _data.started then
                Utils:showTips(12034014)
                return
            end

            if _data.freeCount <= 0 and GoodsDataMgr:getItemCount(self.costGoodsId) <= 0 then
                local args = {
                    tittle = 12034009,
                    content = TextDataMgr:getText(12034010),
                    confirmCall = function()
                        --FunctionDataMgr:jStorePack()  --TODO CLOSE 暂时改为英文版特有78感恩节活动商店类型
                        FunctionDataMgr:jActivity(78)
                    end,
                }
                Utils:showReConfirm(args)
                return
            end

            if not self.queueItems then
                self.queueItems = {}
            end
            table.insert(self.queueItems, sender)
            TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_FLOP(i)
            self:isPanelTouchShow(true)
            return true
        end)
        item:setPosition(ccp(_x, _y))
        item:AddTo(self._ui.panel_gameMain)

        local openIndex = data.openIndex or {}
        for j, idx in ipairs(openIndex) do
            if idx == i then
                Image_hadGetted:show()
                Image_iconFrame:hide()
            end
        end

        -- 特殊按钮默认放在第一个格子
        if i == 1 and (not data.passId or not data.started) then
            self.Button_special = self._ui.Button_special:clone()
            self.Button_special:Pos(item:getPosition())
            self.Button_special:AddTo(self._ui.panel_gameMain)
            self.Button_special:show()
            self.Button_special.block = item
            self.Button_special:onClick(function()
                self:clickBtnSpecial()
            end)
            item:hide()

            -- 选了奖励 没点击开始翻牌
            if data.passId and not data.started then
                local Image_add = TFDirector:getChildByPath(self.Button_special, "Image_add")
                Image_add:removeAllChildren()
                local cfg = TurnTabletMgr:getTurnTabletCfgById(data.passId)
                local goodsId, goodsNum = next(cfg.reward)
                local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
                goods:AddTo(Image_add)
                goods:Pos(ccp(0,0))
                goods:setScale(0.8)
                PrefabDataMgr:setInfo(goods, goodsId, goodsNum)
                goods:setSwallowTouch(false)
                goods:onClick(function()
                end)
            end
        end
        if data.passIndex and i == data.passIndex then
            self:showPassBtnEff(item)
        end
    end
end

function TurnTabletGameView:updateChooseTablet(rewardData)
    if not self.queueItems then
        return 
    end
    self:refreshUI()
    self:refreshGirdView()
    local data = TurnTabletMgr:getTurnTabletData()
    for i, v in ipairs(self.queueItems) do
        v:setTouchEnabled(false)
        TFDirector:getChildByPath(v, "Image_hadGetted"):show()
        TFDirector:getChildByPath(v, "Image_iconFrame"):hide()
        local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        local rewardData_ = rewardData.reward[1]
        PrefabDataMgr:setInfo(goods, rewardData_.id, rewardData_.num)
        goods:Pos(ccp(0,0))
        goods:setScale(0.7)
        goods:AddTo(v, 1)

        local aniSeq = Sequence:create({
            FadeIn:create(0.1),
            DelayTime:create(0.5),
            Spawn:create({FadeOut:create(1), CCMoveBy:create(1, ccp(0,40))}),
            CallFunc:create(function()
                    goods:removeFromParent()
                    self:isPanelTouchShow(false)
            end)
        })

        local cfg = TurnTabletMgr:getTurnTabletCfgById(data.passId)
        local _id, _num = next(cfg.reward) 
        if data.passIndex and rewardData_.id == _id then  -- 本次翻到通关奖励
            TFAudio.playSound("sound/stg/qichebaozha_1.mp3")
            self:showPassBtnEff(v)
            self.Button_special.Spine_teleport:hide()
            local Spine_bingo = TFDirector:getChildByPath(self.Button_special, "Spine_bingo"):show()
            Spine_bingo:show()
            Spine_bingo:play("animation", false)
            Spine_bingo:addMEListener(TFARMATURE_COMPLETE,function ()
                Spine_bingo:removeMEListener(TFARMATURE_COMPLETE)
                self._ui.Panel_content:runAction(self:screenShakeSeq(10,30,10))
                self._ui.Spine_bingo:hide()
                self.Button_special.Spine_teleport:show()
                Utils:showReward({{id = _id, num = _num}})
                self:isPanelTouchShow(false)
            end)
        else
            goods:runAction(aniSeq)
        end
    end
    self.queueItems = {}
end

function TurnTabletGameView:screenShakeSeq(offsetMin, offsetMax, count)
    local aniArr = {}
    for i = 1, count do
        local x = math.random(offsetMin, offsetMax)
        local y = math.random(offsetMin, offsetMax)
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(x, y)))
        table.insert(aniArr, CCMoveBy:create(0.05, ccp(-x, -y)))
    end
    local seq = CCSequence:createWithTable(aniArr)
    return seq
end

-- 开始洗牌
function TurnTabletGameView:beginCleanOutTablet()
    local block = self.Button_special.block
    -- local aniSeq = Sequence:create({
    --     DelayTime:create(0.5),
    --     RotateBy:create(1, {x = 0, y = 360, z = 0}),
    --     CallFunc:create(function()
    --         block:show()
    --         self.Button_special:removeFromParent()
    --         self.Button_special = nil
    --         self._ui.panel_gameMain:hide()
    --         self._ui.Spine_shuffle:show()
    --         self._ui.Spine_shuffle:play("animation", false)
    --         self._ui.Spine_shuffle:addMEListener(TFARMATURE_COMPLETE,function ()
    --             self._ui.Spine_shuffle:removeMEListener(TFARMATURE_COMPLETE)
    --             self._ui.Spine_shuffle:hide()
    --             self._ui.panel_gameMain:show()
    --             self._ui.Panel_touch:hide()
    --         end)
    --     end)
    -- })
    -- self.Button_special:runAction(aniSeq)
    block:show()
    self.Button_special:removeFromParent()
    self.Button_special = nil
    self._ui.panel_gameMain:hide()
    self._ui.Spine_shuffle:show()
    self._ui.Spine_shuffle:play("animation", false)
    self._ui.Spine_shuffle:addMEListener(TFARMATURE_COMPLETE,function ()
        self._ui.Spine_shuffle:removeMEListener(TFARMATURE_COMPLETE)
        self._ui.Spine_shuffle:hide()
        self._ui.panel_gameMain:show()
        self:isPanelTouchShow(false)
    end)
    self:refreshUI()
end

function TurnTabletGameView:goTheNextFloor(isTrueGoNextFloor)
    if self.Button_special then
        TFDirector:getChildByPath(self.Button_special, "Spine_teleport"):hide()
    end
    self:refreshUI()
    self:refreshGirdView()
    if isTrueGoNextFloor then
        self._ui.Spine_goNext:show()
        self._ui.Spine_goNext:play("animation", false)
        self._ui.Spine_goNext:addMEListener(TFARMATURE_COMPLETE,function ()
            self._ui.Spine_goNext:removeMEListener(TFARMATURE_COMPLETE)
            self._ui.Spine_goNext:hide()
            self:initAllTablets()
        end)
    else
        self:initAllTablets()
    end
end

function TurnTabletGameView:clickBtnSpecial()
    local data = TurnTabletMgr:getTurnTabletData()
    if data.passIndex then
        Utils:openView("oneYear.TurnTabletBoxView")
        return
    end
    self:goPopAwardView()
end

function TurnTabletGameView:goPopAwardView()
    local data = TurnTabletMgr:getTurnTabletData()
    if data.passIndex then
        Utils:showTips(12034015)
        return
    end
    local layerTag = data.layer % 10
    local tag = layerTag == 0 and 2 or 1
    Utils:openView("oneYear.TurnTabletPopAwardView", tag)
end

-- 通关奖励按钮特效
function TurnTabletGameView:showPassBtnEff(node)
    if self.Button_special then
        self.Button_special:removeFromParent()
        self.Button_special = nil
    end
    self.Button_special = self._ui.Button_special:clone()
    self.Button_special:AddTo(self._ui.panel_gameMain)
    self.Button_special:Pos(node:getPosition())
    self.Button_special:show()
    self.Button_special:onClick(function()
        self:clickBtnSpecial()
    end)

    self.Button_special.Spine_teleport = TFDirector:getChildByPath(self.Button_special, "Spine_teleport"):show()
    self.Button_special.Spine_teleport:play("animation", true)
    node:hide()
end

function TurnTabletGameView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

return TurnTabletGameView