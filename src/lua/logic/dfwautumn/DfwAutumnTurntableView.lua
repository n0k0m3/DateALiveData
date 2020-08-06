
local DfwAutumnTurntableView = class("DfwAutumnTurntableView", BaseLayer)

function DfwAutumnTurntableView:initData()
    self.turntable_ = DfwDataMgr:getTurntable()

    self.turntableItems_ = {}

    self.totalCount_ = Utils:getKVP(46012, "turnShow")
    self.costCid_ = Utils:getKVP(46012, "turnUse")
    dump(self.costCid_)
    self.costCfg_ = GoodsDataMgr:getItemCfg(self.costCid_)
    self.costNum_ = 1

    self.turnInfo_ = DfwDataMgr:getTurnInfo()
    self.originSelectIndex_ = self.turnInfo_.turnIndex
    if self.originSelectIndex_ == 0 then
        self.originSelectIndex_ = 1
    end
    self.curSelectIndex_ = self.originSelectIndex_
    self.startCount_ = 5
    self.continueCount_ = #self.turntable_ * 3
    self.endCount_ = 5
end

function DfwAutumnTurntableView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dafuwong.dfwAutumnTurntableView")
end

function DfwAutumnTurntableView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_tableItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_tableItem")
    local Panel_table = TFDirector:getChildByPath(self.Panel_root, "Panel_table")
    self.Panel_table = {}
    for i = 1, 12 do
        self.Panel_table[i] = TFDirector:getChildByPath(Panel_table, "Panel_table_" .. i)
        self.Panel_table[i]:setBackGroundColorType(0)
    end

    self.Image_method_1 = TFDirector:getChildByPath(self.Panel_root, "Image_method_1")
    self.Image_btn_bg1 = TFDirector:getChildByPath(self.Panel_root, "Image_btn_bg1")
    self.Button_start = TFDirector:getChildByPath(self.Image_method_1, "Button_start")
    self.Label_start = TFDirector:getChildByPath(self.Button_start, "Label_start")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Button_start, "Image_cost.Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Button_start, "Image_cost.Label_cost_num")

    self.Image_method_2 = TFDirector:getChildByPath(self.Panel_root, "Image_method_2")
    self.Image_btn_bg2 = TFDirector:getChildByPath(self.Panel_root, "Image_btn_bg2")
    self.Button_start2 = TFDirector:getChildByPath(self.Image_method_2, "Button_start2")
    self.Label_start2 = TFDirector:getChildByPath(self.Button_start2, "Label_start2")
    self.Image_cost_icon2 = TFDirector:getChildByPath(self.Button_start2, "Image_cost2.Image_cost_icon2")
    self.Label_cost_num2 = TFDirector:getChildByPath(self.Button_start2, "Image_cost2.Label_cost_num2")
    self.Button_start10 = TFDirector:getChildByPath(self.Image_method_2, "Button_start10")
    self.Label_start10 = TFDirector:getChildByPath(self.Button_start10, "Label_start10")
    self.Image_cost_icon10 = TFDirector:getChildByPath(self.Button_start10, "Image_cost10.Image_cost_icon10")
    self.Label_cost_num10 = TFDirector:getChildByPath(self.Button_start10, "Image_cost10.Label_cost_num10")

    self.Button_ing = TFDirector:getChildByPath(self.Panel_root, "Button_ing"):hide()
    self.Label_ing = TFDirector:getChildByPath(self.Button_ing, "Label_ing")
    self.Label_tips = TFDirector:getChildByPath(self.Panel_root, "Label_tips")

    local Image_count = TFDirector:getChildByPath(self.Panel_root, "Image_count")
    self.Label_count_title = TFDirector:getChildByPath(Image_count, "Label_count_title")
    self.Label_count = TFDirector:getChildByPath(Image_count, "Label_count")

    self:refreshView()
end

function DfwAutumnTurntableView:refreshView()
    self.Label_start:setTextById(13210009)
    self.Label_start2:setTextById(13210009)
    self.Label_start10:setTextById(13210020)
    self.Label_ing:setTextById(13210010)
    self.Label_count_title:setTextById(13210023)

    for i, v in ipairs(self.turntable_) do
        local foo = self:addTurntableItem()
        foo.root:Pos(0, 0):AddTo(self.Panel_table[i])
        self.turntableItems_[i] = foo

        local cfg = DfwDataMgr:getTurntableCfg(self.turntable_[i])
        local goodsCfg = GoodsDataMgr:getItemCfg(cfg.icon)
        foo.Label_name_normal:setTextById(cfg.name)
        foo.Label_name_select:setTextById(cfg.name)
        foo.Image_icon:setTexture(goodsCfg.icon)
        foo.Image_frame:setTexture(cfg.color)
        foo.Label_count:setVisible(cfg.rewardMax > 0)
    end

    self:updateTurntableState()
    self:updateTurntableInfo()
    self:updateMethod()
end

function DfwAutumnTurntableView:updateTurntableState()
    for i, foo in ipairs(self.turntableItems_) do
        local isSelect = (i == self.curSelectIndex_)
        foo.Image_select:setVisible(isSelect)
        foo.Image_diban_select:setVisible(isSelect)
        foo.Image_diban_normal:setVisible(not isSelect)
        local color = isSelect and ccc3(207, 68, 118) or ccc3(56, 108, 194)
        foo.Label_count:setColor(color)
    end
end

function DfwAutumnTurntableView:updateTurntableInfo()
    for i, foo in ipairs(self.turntableItems_) do
        local cfg = DfwDataMgr:getTurntableCfg(self.turntable_[i])
        local count = DfwDataMgr:getTurntableTimes(cfg.id)
        local remainCount = math.max(0, cfg.rewardMax - count)
        if foo.Label_count:isVisible() then
            foo.Label_count:setTextById(800005, remainCount, cfg.rewardMax)
            foo.Image_mask:setVisible(remainCount == 0)
        end
        foo.Image_frame:onClick(function()
                Utils:showInfo(cfg.icon)
        end)
    end
    local count = math.mod(self.turnInfo_.extraTimes, 10)
    self.Label_tips:setTextById(13210011, self.totalCount_ - count)
    self.Label_count:setTextById(13210022, self.turnInfo_.extraTimes)
end

function DfwAutumnTurntableView:addTurntableItem()
    local Panel_tableItem = self.Panel_tableItem:clone()
    local foo = {}
    foo.root = Panel_tableItem
    foo.Image_diban_normal = TFDirector:getChildByPath(foo.root, "Image_diban_normal")
    foo.Label_name_normal = TFDirector:getChildByPath(foo.root, "Label_name_normal")
    foo.Image_diban_select = TFDirector:getChildByPath(foo.root, "Image_diban_select"):hide()
    foo.Label_name_select = TFDirector:getChildByPath(foo.root, "Label_name_select")
    foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
    foo.Image_frame = TFDirector:getChildByPath(foo.root, "Image_frame")
    foo.Image_icon = TFDirector:getChildByPath(foo.Image_frame, "Image_icon")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_mask = TFDirector:getChildByPath(foo.root, "Image_mask")
    return foo
end

function DfwAutumnTurntableView:nextTurnTable()
    local nextIndex = self.curSelectIndex_ + 1
    if nextIndex > #self.turntable_ then
        nextIndex = 1
    end
    return nextIndex
end

function DfwAutumnTurntableView:startTheDraw()
    self.Button_start:hide()
    self.Button_start2:hide()
    self.Button_start10:hide()
    self.Image_btn_bg1:hide()
    self.Image_btn_bg2:hide()
    self.Button_ing:show()
    local delay = {0.5, 0.4, 0.3, 0.2, 0.1}
    local aniArr = {}
    for i = 1, self.startCount_ do
        local callfunc = CallFunc:create(function()
                if i ~= 1 then
                    self.curSelectIndex_ = self:nextTurnTable()
                end
                Utils:playSound(5006)
                self:updateTurntableState()
        end)
        local delay = DelayTime:create(delay[i])
        table.insert(aniArr, callfunc)
        table.insert(aniArr, delay)
    end
    local completeCallfunc = CallFunc:create(function()
            self:continueTheDraw()
    end)
    table.insert(aniArr, completeCallfunc)
    local aniSeq = Sequence:create(aniArr)
    self.Panel_root:runAction(aniSeq)
end

function DfwAutumnTurntableView:updateMethod()
    local count = GoodsDataMgr:getItemCount(self.costCid_)
    self.Label_cost_num:setTextById(800005, count, self.costNum_)
    self.Label_cost_num2:setTextById(800005, count, self.costNum_)
    self.Label_cost_num10:setTextById(800005, count, self.costNum_ * 10)
    self.Image_cost_icon:setTexture(self.costCfg_.icon)
    self.Image_cost_icon2:setTexture(self.costCfg_.icon)
    self.Image_cost_icon10:setTexture(self.costCfg_.icon)

    local isUseMethod2 = count >= 10
    self.Image_method_1:setVisible(not isUseMethod2)
    self.Image_method_2:setVisible(isUseMethod2)
end

function DfwAutumnTurntableView:continueTheDraw()
    local count = 1
    local index = self.originSelectIndex_
    while index ~= self.targetIndex_  do
        if index + 1 > #self.turntable_ then
            index = 1
        else
            index = index + 1
        end
        count = count + 1
    end
    local aniArr = {}
    local remainCount = self.continueCount_ + count - self.startCount_ - self.endCount_
    local duration = 3.0 / remainCount
    for i = 1, remainCount do
        local callfunc = CallFunc:create(function()
                Utils:playSound(5006)
                self.curSelectIndex_ = self:nextTurnTable()
                self:updateTurntableState()
        end)
        local delay = DelayTime:create(duration)
        table.insert(aniArr, callfunc)
        table.insert(aniArr, delay)
    end
    local completeCallfunc = CallFunc:create(function()
            self:endTheDraw()
    end)
    table.insert(aniArr, completeCallfunc)
    local aniSeq = Sequence:create(aniArr)
    self.Panel_root:runAction(aniSeq)
end

function DfwAutumnTurntableView:endTheDraw()
    local delay = {0.1, 0.2, 0.3, 0.4, 0.5}
    local aniArr = {}
    for i = 1, self.startCount_ do
        local callfunc = CallFunc:create(function()
                Utils:playSound(5006)
                self.curSelectIndex_ = self:nextTurnTable()
                self:updateTurntableState()
        end)
        local delay = DelayTime:create(delay[i])
        table.insert(aniArr, callfunc)
        table.insert(aniArr, delay)
    end
    local completeCallfunc = CallFunc:create(function()
            self.Button_ing:hide()
            self.Button_start:show()
            self.Button_start2:show()
            self.Button_start10:show()
            self.Image_btn_bg1:show()
            self.Image_btn_bg2:show()
            self.turnInfo_ = DfwDataMgr:getTurnInfo()
            self.originSelectIndex_ = self.turnInfo_.turnIndex
            self.curSelectIndex_ = self.originSelectIndex_
            Utils:showReward(self.rewards_)
            self:updateTurntableInfo()
            self:updateMethod()
    end)
    table.insert(aniArr, completeCallfunc)
    local aniSeq = Sequence:create(aniArr)
    self.Panel_root:runAction(aniSeq)
end

function DfwAutumnTurntableView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_LUCKY_WHEEL, handler(self.onLuckyWheelEvent, self))

    self.Button_start:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(1)
            else
                Utils:showTips(13210021)
            end
    end)

    self.Button_start2:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(1)
            else
                Utils:showTips(13210021)
            end
    end)

    self.Button_start10:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(10)
            else
                Utils:showTips(13210021)
            end
    end)
end

function DfwAutumnTurntableView:onLuckyWheelEvent(turnInfo, rewards)
    self.rewards_ = rewards
    self.targetIndex_ = turnInfo.turnIndex
    self:startTheDraw()
end

return DfwAutumnTurntableView
