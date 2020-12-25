--[[
    @desc：TurnTabletPopAwardView       
]]

local TurnTabletPopAwardView = class("TurnTabletPopAwardView",BaseLayer)

function TurnTabletPopAwardView:initData(idx)
    self.curChooseIdx = idx or 1

    self.data = TurnTabletMgr:getTurnTabletData()
    self.hadChooseIdDic = {}
    self.isFirstClick = true

    local _hadChooseIds = self.data.passCount or {}
    for i, v in ipairs(_hadChooseIds) do
        self.hadChooseIdDic[v.passId] = v.count
    end
end

function TurnTabletPopAwardView:ctor(...)
    self.super.ctor(self)
    self:showPopAnim(true)
    self:initData(...)
    self:init("lua.uiconfig.twoYearTurnTablet.turnTabletPopAwardView")
end

function TurnTabletPopAwardView:initUI(ui)
    self.super.initUI(self,ui)

    self.girdOne = UIGridView:create(self._ui.ScrollView_one)
    local bar = UIScrollBar:create(self._ui.Image_scrollBar1, self._ui.Image_innerScrollBar1)
    self.girdOne:setScrollBar(bar)
    self.girdOne:setItemModel(self._ui.rewardItem)
    self.girdOne:setColumn(6)
    self.girdOne:setColumnMargin(18)
    self.girdOne:setRowMargin(16)

    self.girdTen = UIGridView:create(self._ui.ScrollView_ten)
    local bar = UIScrollBar:create(self._ui.Image_scrollBar2, self._ui.Image_innerScrollBar2)
    self.girdTen:setScrollBar(bar)
    self.girdTen:setItemModel(self._ui.rewardItem)
    self.girdTen:setColumn(6)
    self.girdTen:setColumnMargin(18)
    self.girdTen:setRowMargin(16)
    self:choosePanel(self.curChooseIdx)

    self._ui.lab_curFloor:setText(self.data.layer)
    
    self:refreshView()
end

function TurnTabletPopAwardView:registerEvents()
    EventMgr:addEventListener(self, EV_TURNTABLET2_CHOOSEPASSAWARD, function()
        AlertManager:close(self)
    end)

    for i, btn in ipairs(self._ui.Panel_btns:getChildren()) do
        local idx = string.gsub(btn:getName(), "btn_", "") 
        idx = tonumber(idx)
        btn:onClick(function()
            self:choosePanel(idx)
        end)
    end
end

function TurnTabletPopAwardView:choosePanel(idx)
    for i, btn in ipairs(self._ui.Panel_btns:getChildren()) do
        local tag = string.gsub(btn:getName(), "btn_", "") 
        tag = tonumber(tag)
        TFDirector:getChildByPath(btn, "img_select"):setVisible(idx == tag)
        self._ui["Panel_"..tag]:setVisible(idx == tag)
    end
    self.curChooseIdx = idx
end

function TurnTabletPopAwardView:refreshView()
    local data = TurnTabletMgr:getTurnTabletCfgById()

    for i, cfg in pairs(data) do
        if cfg.rewardType == 2 then
            local item = self.girdOne:pushBackDefaultItem()
            self:refreshItem(item, cfg, self.curChooseIdx ~= 1)
        end
    end
    for i, cfg in pairs(data) do
        if cfg.rewardType == 3 or cfg.rewardType == 4 then
            local item = self.girdTen:pushBackDefaultItem()
            self:refreshItem(item, cfg, self.curChooseIdx ~= 2)
        end
    end
end

function TurnTabletPopAwardView:refreshItem(item, cfg, isLock)
    local lab_num = TFDirector:getChildByPath(item, "lab_num")
    local itemPos = TFDirector:getChildByPath(item, "itemPos")
    local panel_itemTouch = TFDirector:getChildByPath(item, "panel_itemTouch")
    local img_lock = TFDirector:getChildByPath(item, "img_lock")

    img_lock:setVisible(isLock)
    local goodsId, goodsNum = next(cfg.reward)
    local goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    goods:AddTo(item)
    goods:Pos(itemPos:getPosition())
    goods:setScale(0.8)
    item.goods = goods
    PrefabDataMgr:setInfo(goods, goodsId, goodsNum)

    local hadUseCount = self.hadChooseIdDic[cfg.id] or 0
    local lastCount = cfg.limitCount - hadUseCount
    lastCount = lastCount < 0 and 0 or lastCount
    lab_num:setText(lastCount.."/"..cfg.limitCount)

    panel_itemTouch:setTouchEnabled(true)
    panel_itemTouch:setSwallowTouch(true)
    panel_itemTouch:onClick(function()
        if cfg.id == self.data.passId and self.isFirstClick then
            AlertManager:close(self)
            self.isFirstClick = nil
            return 
        end 
        if lastCount > 0 then
            if self.curChooseIdx == 2 and cfg.rewardType == 4 then 
                local _bool = false
                local _str = ""
                for j, floorNum in ipairs(cfg.limitFloor) do
                    if self.data.layer == floorNum then
                        _bool = true
                    end
                    if _str == "" then
                        _str = floorNum
                    else
                        _str = _str.."、"..floorNum
                    end
                end
                if not _bool then
                    Utils:showTips(12034016, _str)
                    return
                end
            end
            if self.isFirstClick and not isLock then
                TurnTabletMgr:send_ANNIVERSARY_FLOP_REQ_ANNIV_PASS_REWARD(cfg.id)
                self.isFirstClick = nil
            else
                if self.curChooseIdx == 2 then
                    Utils:showTips(12034017)
                else
                    if self.isFirstClick then
                        Utils:showTips(12034016, "1 ~ 9")
                    end
                end
            end
        else
            Utils:showTips(12034018)
        end
    end)
end

return TurnTabletPopAwardView