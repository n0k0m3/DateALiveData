
local ValentineGiftView = class("ValentineGiftView", BaseLayer)

function ValentineGiftView:initData(roleCid)
    local activityInfo = ValentineDataMgr:getActivityInfo()
    self.roleCid_ = roleCid
    self.giftData_ = activityInfo.extendData.gift
    self.giftItemData_ = {}
    for k, v in pairs(self.giftData_) do
        table.insert(self.giftItemData_, k)
    end
    table.sort(self.giftItemData_)

    self.giftNum_ = {}
    for i, v in ipairs(self.giftItemData_) do
        self.giftNum_[i] = 0
    end

    local condData_ = {}
    local cfg = ValentineDataMgr:getValentineRoleCfg(roleCid)
    for i, v in ipairs(cfg.dating) do
        local datingRuleCfg = TabDataMgr:getData("DatingRule", v)
        local _, num = next(datingRuleCfg.enter_condition.item)
        condData_[i] = num
    end
    self.maxTacit = math.max(unpack(condData_))
    self.myTacit  =  ValentineDataMgr:getFullServerTacit(roleCid)
end

function ValentineGiftView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.valentine.valentineGiftView")
end

function ValentineGiftView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Label_title = TFDirector:getChildByPath(Image_content, "Label_title")
    self.Panel_item = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_content, "Panel_item_" .. i)
        local Panel_goods = TFDirector:getChildByPath(foo.root, "Panel_goods")
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        foo.Panel_goodsItem:Pos(0, 0):Scale(0.8):AddTo(Panel_goods)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.Label_count = TFDirector:getChildByPath(foo.root, "Image_count.Label_count")
        foo.Button_add = TFDirector:getChildByPath(foo.root, "Button_add")
        foo.Button_sub = TFDirector:getChildByPath(foo.root, "Button_sub")
        self.Panel_item[i] = foo
    end
    local Image_tips = TFDirector:getChildByPath(Image_content, "Image_tips")
    self.Label_desc = TFDirector:getChildByPath(Image_tips, "Label_desc")
    self.Label_num = TFDirector:getChildByPath(Image_tips, "Label_num")
    self.Button_gift = TFDirector:getChildByPath(Image_content, "Button_gift")
    self.Label_gift = TFDirector:getChildByPath(self.Button_gift, "Label_gift")
    self.Button_close = TFDirector:getChildByPath(Image_content, "Button_close")

    self:refreshView()
end

function ValentineGiftView:refreshView()
    self.Label_desc:setTextById(1710009)

    for i, v in ipairs(self.Panel_item) do
        local cid = self.giftItemData_[i]
        local count = GoodsDataMgr:getItemCount(cid)
        local cfg = GoodsDataMgr:getItemCfg(cid)
        PrefabDataMgr:setInfo(v.Panel_goodsItem, cid, count)
        v.Label_name:setTextById(cfg.nameTextId)
    end

    self:updateGiftInfo()
end

function ValentineGiftView:updateGiftInfo()
    local tacitValue = 0
    for i, v in ipairs(self.giftItemData_) do
        local num = self.giftNum_[i]
        tacitValue = tacitValue + self.giftData_[v] * num
        local foo = self.Panel_item[i]
        foo.Label_count:setText(num)
    end
    self.Label_num:setText(tacitValue)
end

function ValentineGiftView:updateGiftNum(num)
end

function ValentineGiftView:holdDownAction(index, isAddOp)
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
            self:singleGiftOp(index, isAddOp)
            timing = 0
        end
    end

    -- self.holdDownTimer_ = TFDirector:addTimer(0, -1, nil, action)
end

function ValentineGiftView:singleGiftOp(index, isAddOp)
    local _bool = self:isAddTacitBig()
    if _bool and isAddOp then
        for i, v in ipairs(self.Panel_item) do
            v.Button_add:setGrayEnabled(true)
        end
        Utils:showTips(2460121)
        return
    end

    addNum = isAddOp and 1 or -1
    local num = self.giftNum_[index] + addNum
    local haveNum = GoodsDataMgr:getItemCount(self.giftItemData_[index])
    self.giftNum_[index] = clamp(num, 0, haveNum)

    if not isAddOp and not self:isAddTacitBig()  then
        for i, v in ipairs(self.Panel_item) do
            v.Button_add:setGrayEnabled(false)
        end
    end
    self:updateGiftInfo()
end

-- 增加的默契是否超多最大值
function ValentineGiftView:isAddTacitBig()
    local tacitValue = 0
    for i, v in ipairs(self.giftItemData_) do
        local num = self.giftNum_[i]
        tacitValue = tacitValue + self.giftData_[v] * num
    end
    return (tacitValue + self.myTacit) >= self.maxTacit
end

function ValentineGiftView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_GIFT, handler(self.onGiftEvent, self))

    self.Button_close:onClick(function()
            AlertManager:closeLayer(self)
    end)

    self.Button_gift:setGrayEnabled(self.maxTacit <= self.myTacit)
    self.Button_gift:onClick(function()
        if self.maxTacit <= self.myTacit then
            Utils:showTips(2460121)
            self.Button_gift:setGrayEnabled(true)
            return
        end
        local gifts = {}
        for i, v in ipairs(self.giftNum_) do
            if v > 0 then
                table.insert(gifts, {self.giftItemData_[i], v})
            end
        end
        if #gifts > 0 then
            ValentineDataMgr:send_VALENTINE_VALENTINE_PRESENT(self.roleCid_, gifts)
        else
            Utils:showTips(1702083)
        end
    end)

    for i, v in ipairs(self.Panel_item) do
        local _bool = self.maxTacit <= self.myTacit
        v.Button_add:setTouchEnabled(not _bool)
        v.Button_add:setGrayEnabled(_bool)
        v.Button_add:onClick(function(event)
                -- if event.name == "began" then
                    self:singleGiftOp(i, true)
                    -- self:holdDownAction(i, true)
                -- elseif event.name == "ended" then
                    -- if self.holdDownTimer_ then
                    --     TFDirector:removeTimer(self.holdDownTimer_)
                    --     self.holdDownTimer_ = nil
                    -- end
                -- end
        end)

        v.Button_sub:setTouchEnabled(not _bool)
        v.Button_sub:setGrayEnabled(_bool)
        v.Button_sub:onClick(function(event)
                -- if event.name == "began" then
                    self:singleGiftOp(i, false)
                    -- self:holdDownAction(i, false)
                -- elseif event.name == "ended" then
                    -- if self.holdDownTimer_ then
                    --     TFDirector:removeTimer(self.holdDownTimer_)
                    --     self.holdDownTimer_ = nil
                    -- end
                -- end
        end)
    end
end

function ValentineGiftView:onGiftEvent()
    AlertManager:closeLayer(self)
end

return ValentineGiftView
