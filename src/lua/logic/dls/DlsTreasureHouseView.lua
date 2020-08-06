
local DlsTreasureHouseView = class("DlsTreasureHouseView", BaseLayer)

function DlsTreasureHouseView:initData()
    local summons = SummonDataMgr:getDlsSummon()
    local summon = summons[1][1]
    self.summonCid_ = summon.id
    self.summonCfg_ = SummonDataMgr:getSummonCfg(self.summonCid_)
    self.costItemCid_ = next(self.summonCfg_.cost[1])

    self.sitePosition_ = {}
    self.workTypeItems_ = {}
    self.selectIndex_ = 1
end

function DlsTreasureHouseView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dls.dlsTreasureHouseView")
end

function DlsTreasureHouseView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_worktype = {}
    for i = 1, 5 do
        self.Panel_worktype[i] = TFDirector:getChildByPath(self.Panel_prefab, "Panel_worktype_" .. i)
    end

    local Panel_site = TFDirector:getChildByPath(self.Panel_root, "Panel_site")
    for i = 1, 10 do
        local foo = TFDirector:getChildByPath(Panel_site, "Panel_site_" .. i)
        self.sitePosition_[i] = foo:getPosition()
    end
    local Panel_forcer = TFDirector:getChildByPath(self.Panel_root, "Panel_forcer")
    self.Panel_content = {}
    for i = 1, 2 do
        self.Panel_content[i] = TFDirector:getChildByPath(Panel_forcer, "Panel_content_" .. i):hide()
    end
    self.Panel_touch_mask = TFDirector:getChildByPath(Panel_forcer, "Panel_touch_mask"):hide()
    self.Panel_touch_mask:setSize(GameConfig.WS)
    local Image_have = TFDirector:getChildByPath(self.Panel_root, "Image_have")
    self.Label_summon_count = TFDirector:getChildByPath(Image_have, "Label_summon_count")
    self.Label_have = TFDirector:getChildByPath(Image_have, "Label_have")
    self.Image_cost = TFDirector:getChildByPath(Image_have, "Image_cost")
    self.Image_icon = TFDirector:getChildByPath(self.Image_cost, "Image_icon")
    self.Label_count = TFDirector:getChildByPath(self.Image_cost, "Label_count")
    self.Button_refresh = TFDirector:getChildByPath(self.Panel_root, "Button_refresh")
    self.Label_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh")
    self.Button_preview = TFDirector:getChildByPath(self.Panel_root, "Image_preview.Button_preview")
    self.Button_history = TFDirector:getChildByPath(self.Panel_root, "Image_history.Button_history")

    self:refreshView()
end

function DlsTreasureHouseView:updateSummonCount()
    local count = SummonDataMgr:getSummonCount(self.summonCid_)
    self.Label_summon_count:setTextById(1200060, count)
end

function DlsTreasureHouseView:refreshView()
    self.Label_refresh:setTextById(2101401)
    local costItemCfg = GoodsDataMgr:getItemCfg(self.costItemCid_)
    self.Label_have:setTextById(2101400, TextDataMgr:getText(costItemCfg.nameTextId))
    self.Image_icon:setTexture(costItemCfg.icon)
    self.Label_count:setText(GoodsDataMgr:getItemCount(self.costItemCid_))

    local size = self.Label_have:getSize()
    local position = self.Label_have:Pos()
    local x = position.x + size.width + 20
    self.Image_cost:PosX(x)

    self:initForcer(self.selectIndex_)
    self:updateSummonCount()
end

function DlsTreasureHouseView:initForcer(index)
    local Panel_content = self.Panel_content[index]:show()
    for i, v in ipairs(self.workTypeItems_[index] or {}) do
        v.root:removeFromParent()
    end
    self.workTypeItems_[index] = {}
    local questionInfo = DlsDataMgr:getCacheQuestion()
    for i, v in ipairs(questionInfo) do
        local foo = {}
        foo.root = self.Panel_worktype[v.id]:clone()
        foo.Button_unopend = TFDirector:getChildByPath(foo.root, "Button_unopend")
        foo.Button_opend = TFDirector:getChildByPath(foo.root, "Button_opend"):hide()
        foo.Button_unopend:setVisible(not v.open)
        foo.Button_opend:setVisible(v.open)
        local position = self.sitePosition_[i]
        foo.root:AddTo(Panel_content):Pos(position):ZO(2)
        self.workTypeItems_[index][i] = foo
    end

    self:updateForcer(index)
end

function DlsTreasureHouseView:updateForcer(index)
    local questionInfo = DlsDataMgr:getCacheQuestion()
    for i, v in ipairs(self.workTypeItems_[index]) do
        local question = questionInfo[i]
        v.Button_opend:setVisible(question.open)
        v.Button_unopend:setVisible(not question.open)

        v.Button_unopend:onClick(function()
                Utils:openView("dls.DlsTreasureRewardView", i)
        end)

        v.Button_opend:onClick(function()
                Utils:showTips(2101406)
        end)
    end
end

function DlsTreasureHouseView:changeBatch()
    self.Panel_touch_mask:show()
    DlsDataMgr:generateQuestion()
    local nextSelectIndex = self.selectIndex_ == 1 and 2 or 1
    self:initForcer(nextSelectIndex)

    local offsetWidth = GameConfig.WS.width

    local selectAction = Sequence:create({
            Show:create(),
            EaseExponentialInOut:create(MoveBy:create(0.5, ccp(-offsetWidth, 0))),
            Hide:create(),
    })
    self.Panel_content[self.selectIndex_]:Pos(0, 0):runAction(selectAction)

    local nextSelectAction = Sequence:create({
            Show:create(),
            CallFuncN:create(function(target)
                    target:PosX(offsetWidth)
            end),
            -- EaseSineOut:create(MoveTo:create(0.5, ccp(0, 0))),
            EaseExponentialInOut:create(MoveTo:create(0.5, ccp(0, 0))),
            CallFuncN:create(function()
                    self.Button_refresh:setTouchEnabled(true)
                    self.Button_refresh:setGrayEnabled(false)
                    self.selectIndex_ = nextSelectIndex
                    self.Panel_touch_mask:hide()
                    dump(self.selectIndex_)
            end)
    })
    self.Panel_content[nextSelectIndex]:runAction(nextSelectAction)
end

function DlsTreasureHouseView:registerEvents()
    EventMgr:addEventListener(self, EV_DLS_OPEN_FORCER, handler(self.onOpenForcerEvent, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_HISTORY, handler(self.onSummonHistoryEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_COUNT_UPDATE, handler(self.onSummonCountUpdateEvent, self))

    self.Button_refresh:onClick(function()
            self.Button_refresh:setTouchEnabled(false)
            self.Button_refresh:setGrayEnabled(true)
            self:changeBatch()
    end)

    self.Image_icon:onClick(function()
            Utils:showInfo(self.costItemCid_)
    end)

    self.Button_preview:onClick(function()
            Utils:openView("summon.SummonPreviewView", self.summonCfg_.groupId)
    end)

    self.Button_history:onClick(function()
            SummonDataMgr:send_SUMMON_REQ_HISTORY_RECORD({self.summonCfg_.groupId})
    end)
end

function DlsTreasureHouseView:onOpenForcerEvent()
    self:updateForcer(self.selectIndex_)
end

function DlsTreasureHouseView:onItemUpdateEvent()
    self.Label_count:setText(GoodsDataMgr:getItemCount(self.costItemCid_))
end

function DlsTreasureHouseView:onSummonHistoryEvent(historyData)
    Utils:openView("summon.SummonHistoryView", historyData)
end

function DlsTreasureHouseView:onSummonCountUpdateEvent()
    self:updateSummonCount()
end

return DlsTreasureHouseView
