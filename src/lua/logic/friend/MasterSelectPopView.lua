--[[
    @师傅赠礼弹出界面
]]

local MasterSelectPopView = class("MasterSelectPopView", BaseLayer)

function MasterSelectPopView:initData(data, maxNum, isGive, index, closeCallBack)
    self.data = data
    self.maxNum = maxNum
    self.isGive = isGive
    self.index = index
    self.closeCallBack = closeCallBack
    self.selectNum = 1

    self.isCloseByBtn = false
end

function MasterSelectPopView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.friend.masterSelectPopView")
end

function MasterSelectPopView:initUI(ui)
    self.super.initUI(self, ui)
    self:refreshView()
end

function MasterSelectPopView:refreshView()
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    Panel_goodsItem:setTouchEnabled(false)
    Panel_goodsItem:AddTo(self._ui.Image_head)
    self._ui.Image_head:setTexture("")
    Panel_goodsItem:Pos(0, 0)
    PrefabDataMgr:setInfo(Panel_goodsItem, self.data.cid)
    self._ui.Label_desc:setTextById(GoodsDataMgr:getItemCfg(self.data.cid).desTextId)
    self._ui.Label_count:setTextById(301013, self.data.num)
    self._ui.Label_num:setString(self.selectNum)
end

function MasterSelectPopView:registerEvents()
    self._ui.Button_close:onClick(function()
        AlertManager:close(self)
    end)

    self._ui.Button_use:onClick(function()
        self.isCloseByBtn = true
        AlertManager:close(self)
    end)

    self._ui.Button_up:onTouch(function(event)
        if event.name == "ended" then
            TFDirector:removeTimer(self.timer)
            self.timer = nil;
        end
        if event.name == "began" then
            TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
            self:onTouchButtonUp();
            self:holdDownAction(true)
        end
    end)

    self._ui.Button_down:onTouch(function(event)
            if event.name == "ended" then
                TFDirector:removeTimer(self.timer)
                self.timer = nil;
            end
            if event.name == "began" then
                TFAudio.playSound(Utils:getKVP(1001,"ui_clickSound"))
                self:onTouchButtonDown()
                self:holdDownAction(false);
            end
        end)

    self._ui.Button_max:onClick(function()
            self:updateBatchPanel(self.maxNum)
    end)
end

function MasterSelectPopView:onTouchButtonUp()
    self:updateBatchPanel(1)
end

function MasterSelectPopView:onTouchButtonDown()
    self:updateBatchPanel(-1)
end

function MasterSelectPopView:updateBatchPanel(num)
    self.selectNum = self.selectNum + num;
    if self.selectNum <= 1 then
        self.selectNum = 1
    end
    if self.selectNum >= self.maxNum then
        self.selectNum = self.maxNum
    end
    self._ui.Label_num:setString(self.selectNum)
end

function MasterSelectPopView:holdDownAction(isAddOp)
    local speedTiming = 0
    local timing = 0
    local needTime = 0
    local entryFalg = false

    local function action(dt)
        timing = timing + dt
        speedTiming = speedTiming + dt
        if speedTiming >= 3.0 then
            entryFalg = true
            needTime = 0.01
        elseif speedTiming > 0.5 then
            entryFalg = true
            needTime = 0.05
        end
        if entryFalg and timing >= needTime then
            if isAddOp then
                self:onTouchButtonUp()
            else
                self:onTouchButtonDown()
            end
            timing = 0
        end
    end

    self.timer = TFDirector:addTimer(0, -1, nil, action)
end

function MasterSelectPopView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

function MasterSelectPopView:onClose()
    self.super.onClose(self)
    if self.closeCallBack and self.isCloseByBtn then
        self.closeCallBack(self.data, self.selectNum, self.isGive, self.index)
    end
end

return MasterSelectPopView