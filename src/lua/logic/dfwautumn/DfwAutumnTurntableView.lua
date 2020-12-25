
local DfwAutumnTurntableView = class("DfwAutumnTurntableView", BaseLayer)

function DfwAutumnTurntableView:initData()
    self.turntable_ = DfwDataMgr:getTurntable()

    self.turntableItems_ = {}

    self.totalCount_ = Utils:getKVP(46012, "turnShow")
    self.costCid_ = Utils:getKVP(46012, "turnUse")
    self.costCfg_ = GoodsDataMgr:getItemCfg(self.costCid_)
    self.costNum_ = 1

    self.turnInfo_ = DfwDataMgr:getTurnInfo()
    self.originSelectIndex_ = self.turnInfo_.turnIndex
    if self.originSelectIndex_ == 0 then
        self.originSelectIndex_ = 1
    end
    self.curSelectIndex_ = self.originSelectIndex_

    self.showSelectIndex_ = {}
    self.startCount_ = 5
    self.continueCount_ = #self.turntable_ * 2
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
    self.Button_start = TFDirector:getChildByPath(self.Image_method_1, "Button_start")
    self.Label_start = TFDirector:getChildByPath(self.Button_start, "Label_start")
    self.Image_cost_icon = TFDirector:getChildByPath(self.Button_start, "Image_cost.Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(self.Button_start, "Image_cost.Label_cost_num")

    self.Image_method_2 = TFDirector:getChildByPath(self.Panel_root, "Image_method_2")
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
        foo.Image_icon:setTexture(goodsCfg.icon)
        foo.Image_frame:setTexture(cfg.color)

        foo.Image_diban_normal:setVisible(cfg.showType == 1 or not cfg.showType)
        foo.Image_count_normal:setVisible((cfg.showType == 1 or not cfg.showType) and cfg.rewardMax > 0 )
        foo.Image_diban_advance:setVisible(cfg.showType == 2)
        foo.Image_count_advance:setVisible(cfg.showType == 2 and cfg.rewardMax > 0 )
        foo.Image_diban_important:setVisible(cfg.showType == 3)
        foo.Image_count_important:setVisible(cfg.showType == 3 and cfg.rewardMax > 0 )
        
        local Label_name = TFDirector:getChildByPath(foo.Image_diban_normal,"Label_name")

        if cfg.showType == 2 then
            Label_name = TFDirector:getChildByPath(foo.Image_diban_advance,"Label_name")
        elseif cfg.showType == 3 then 
            Label_name = TFDirector:getChildByPath(foo.Image_diban_important,"Label_name")
        end
        Label_name:setTextById(cfg.name)
    end

    self:updateTurntableState()
    self:updateTurntableInfo()
    self:updateMethod()
end

function DfwAutumnTurntableView:updateTurntableState()
    for i, foo in ipairs(self.turntableItems_) do
        local isSelect = (i == self.curSelectIndex_)
        isSelect = isSelect
        foo.Image_run:setVisible(isSelect)
        foo.Image_select:setVisible(table.find(self.showSelectIndex_,i) ~= -1)
    end
end

function DfwAutumnTurntableView:getEffectId(id)
    -- body
    if self.turnInfo_.effectInfo then
        for k,v in pairs(self.turnInfo_.effectInfo) do
            if v.cfgId == id then
                return v.effectId
            end
        end
    end
    return nil
end

function DfwAutumnTurntableView:updateTurntableInfo()
    for i, foo in ipairs(self.turntableItems_) do
        local cfg = DfwDataMgr:getTurntableCfg(self.turntable_[i])
        local count = DfwDataMgr:getTurntableTimes(cfg.id)
        local remainCount = math.max(0, cfg.rewardMax - count)

        local effectId = self:getEffectId(cfg.id)

        foo.Image_diban_normal:setVisible(cfg.showType == 1 or not cfg.showType)
        foo.Image_count_normal:setVisible((cfg.showType == 1 or not cfg.showType) and cfg.rewardMax > 0 )
        foo.Image_diban_advance:setVisible(cfg.showType == 2)
        foo.Image_count_advance:setVisible(cfg.showType == 2 and cfg.rewardMax > 0 )
        foo.Image_diban_important:setVisible(cfg.showType == 3)
        foo.Image_count_important:setVisible(cfg.showType == 3 and cfg.rewardMax > 0 )

        local Label_count = TFDirector:getChildByPath(foo.Image_count_normal,"Label_count")
        if cfg.showType == 2 then
            Label_count = TFDirector:getChildByPath(foo.Image_count_advance,"Label_count")
        elseif cfg.showType == 3  then
            Label_count = TFDirector:getChildByPath(foo.Image_count_important,"Label_count")
        end

        if cfg.rewardMax > 0 then
            Label_count:setTextById(800005, remainCount, cfg.rewardMax)
            foo.Image_mask:setVisible(remainCount == 0)
        end
        -- foo.Image_frame:onClick(function()
        --         Utils:showInfo(cfg.icon)
        -- end)

        foo.Spine_lucky:setVisible(effectId)
        if effectId then
            local effectCfg = TabDataMgr:getData("TurntableEffect",effectId)
            foo.Spine_lucky:setFile(effectCfg.effectPath)
            foo.Spine_lucky:play(effectCfg.idleAni,true)
        end

        foo.Spine_lucky.effectId = effectId
        foo.cfgId = cfg.id

    end
    local count = math.mod(self.turnInfo_.extraTimes, self.totalCount_)
    self.Label_tips:setTextById(13210011, self.totalCount_ - count)
    self.Label_count:setTextById(13210022, self.turnInfo_.extraTimes)
end

function DfwAutumnTurntableView:addTurntableItem()
    local Panel_tableItem = self.Panel_tableItem:clone()
    local foo = {}
    foo.root = Panel_tableItem
    foo.Image_diban_normal = TFDirector:getChildByPath(foo.root, "Image_diban_normal")
    foo.Image_diban_advance = TFDirector:getChildByPath(foo.root, "Image_diban_advance"):hide()
    foo.Image_diban_important = TFDirector:getChildByPath(foo.root, "Image_diban_important"):hide()
    foo.Image_count_advance = TFDirector:getChildByPath(foo.root, "Image_count_advance")
    foo.Image_count_normal = TFDirector:getChildByPath(foo.root, "Image_count_normal")
    foo.Image_count_important = TFDirector:getChildByPath(foo.root, "Image_count_important")
    foo.Image_frame = TFDirector:getChildByPath(foo.root, "Image_frame")
    foo.Image_icon = TFDirector:getChildByPath(foo.Image_frame, "Image_icon")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_mask = TFDirector:getChildByPath(foo.root, "Image_mask")
    foo.Image_run = TFDirector:getChildByPath(foo.root, "Image_run")
    foo.Spine_lucky = TFDirector:getChildByPath(foo.root, "Spine_lucky"):hide()
    return foo
end

function DfwAutumnTurntableView:checkEffectTrigger(callfunc)
    -- body

    local delay = 0
    for i, foo in ipairs(self.turntableItems_) do
        if foo.Spine_lucky:isVisible() and not self:getEffectId(foo.cfgId) then
            local effectId = foo.Spine_lucky.effectId
            local effectCfg = TabDataMgr:getData("TurntableEffect",effectId)
            foo.Spine_lucky:addMEListener(
                TFARMATURE_COMPLETE,
                function()
                    foo.Spine_lucky:removeMEListener(TFARMATURE_COMPLETE)
                    foo.Spine_lucky:hide()
                end
            )
            foo.Spine_lucky:play(effectCfg.getAni,false)


            EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)
            if effectCfg.victoryLive2d and #effectCfg.victoryLive2d > 0 then
                local id = effectCfg.victoryLive2d[math.random(1,#effectCfg.victoryLive2d )]
                self:showModel(id)
                delay = 2
            else
                delay = math.max(delay,0.5)
            end
        end
    end
    return delay
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
    self.Button_ing:show()
    local delay = {0.5, 0.4, 0.3, 0.2, 0.1}
    local aniArr = {}
    self.curSelectIndex_ = self.originSelectIndex_
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

function DfwAutumnTurntableView:getRunCount( ... )
    -- body
    local count = 1
    self.curRound = self.curRound or 1
    local index = self.originSelectIndex_

    while index ~= self.targetIndex_[self.curRound]  do
        if index + 1 > #self.turntable_ then
            index = 1
        else
            index = index + 1
        end
        count = count + 1
    end
    return count
end

function DfwAutumnTurntableView:continueTheDraw()
    
   
    local count = self:getRunCount()

    local num = self.continueCount_

    local aniArr = {}
    local remainCount = num + count - self.startCount_ - self.endCount_

    local duration = 0.1
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

function DfwAutumnTurntableView:endTheDraw(count)
    local delay = {0.1, 0.2, 0.3, 0.4, 0.5}
    local aniArr = {}
    count = count or self.endCount_
    local offsetCount = count - 5
    for i = 1, count do
        local callfunc = CallFunc:create(function()
                Utils:playSound(5006)
                self.curSelectIndex_ = self:nextTurnTable()
                self:updateTurntableState()
        end)
        local del = math.max(1,i - offsetCount)
        if self.curRound < #self.targetIndex_ then
            del = 1
        end

        local delay = DelayTime:create(delay[del])
        table.insert(aniArr, callfunc)
        table.insert(aniArr, delay)
    end
    local completeCallfunc = CallFunc:create(function()

            self.turnInfo_ = DfwDataMgr:getTurnInfo()
            self.originSelectIndex_ = self.targetIndex_[self.curRound]
            table.insert(self.showSelectIndex_, self.originSelectIndex_)

            if self.curRound < #self.targetIndex_ then
                self.curRound = self.curRound + 1
                local count = self:getRunCount()
                self:endTheDraw(count - 1)
                return
            end

            self.curSelectIndex_ = nil

            

            self.ui:timeOut(function ( ... )
                local delay = self:checkEffectTrigger()
                local function _callFunc( ... )
                    if self.extTargeIndex_ then
                        self.curRound = 1
                        self.targetIndex_ = self.extTargeIndex_
                        self.extTargeIndex_ = nil
                        self:startTheDraw()
                        return
                    end

                    self.Button_ing:hide()
                    self.Button_start:show()
                    self.Button_start2:show()
                    self.Button_start10:show()
                    self.curRound = nil
                    Utils:showRewardEx(self.rewards_)
                    self:updateTurntableInfo()
                    self:updateMethod()
                end
                self.ui:timeOut(_callFunc,delay)
            end,0.5)            
    end)
    table.insert(aniArr, completeCallfunc)
    local aniSeq = Sequence:create(aniArr)
    self.Panel_root:runAction(aniSeq)
end

function DfwAutumnTurntableView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_LUCKY_WHEEL, handler(self.onLuckyWheelEvent, self))

    self.Button_start:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                self.showSelectIndex_ = {}
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(1)
            else
                Utils:showTips(13210021)
            end
    end)

    self.Button_start2:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                self.showSelectIndex_ = {}
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(1)
            else
                Utils:showTips(13210021)
            end
    end)

    self.Button_start10:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                DfwDataMgr:send_SACRIFICE_REQ_LUCKY_WHEEL(10)
                self.showSelectIndex_ = {}
            else
                Utils:showTips(13210021)
            end
    end)
end


function DfwAutumnTurntableView:onLuckyWheelEvent(data, rewards)
    self.rewards_ = rewards
    self.targetIndex_ = data.locations
    self.extTargeIndex_ = data.eventLocations
    self:startTheDraw()
end

function DfwAutumnTurntableView:showModel(live2dId)
    --face = "Id_happy",
    --voice = "sound/role/sisinai/YOSHINO_297.mp3",
    --self.roleModelMotionCfg.model 210101
    if self.showingModel then return end
    self.showingModel = true
    BingoDataMgr:openResult(true,live2dId,function ( ... )
        -- body
        self.showingModel = nil
    end)
end

return DfwAutumnTurntableView
