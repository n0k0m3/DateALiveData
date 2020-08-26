
local SummonComposeView = class("SummonComposeView", BaseLayer)

function SummonComposeView:initData()
    self.summonCompose_ = SummonDataMgr:getSummonCompose()
    self.pointItem_ = {}
    self.defaultSelectPointType_ = 1
    self.selectPointType_ = nil
    self.selectLevel_ = 1
    self.countDownTimer_ = nil

    self:addCountDownTimer()
end

function SummonComposeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonComposeView")
end

function SummonComposeView:initUI(ui)
    self.super.initUI(self, ui)
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_pointItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_pointItem")
    self.Panel_material_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_material_item")
    self.Panel_equip_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_equip_item")

    self.Panel_formula = TFDirector:getChildByPath(self.Panel_root, "Panel_formula"):hide()
    local Panel_buttom = TFDirector:getChildByPath(self.Panel_root, "Panel_buttom")

    self.Button_compose = TFDirector:getChildByPath(self.Panel_formula, "Button_compose")
    self.Button_speed = TFDirector:getChildByPath(self.Panel_formula, "Button_speed")
    self.Image_cost_bg = TFDirector:getChildByPath(self.Panel_formula, "Image_cost_bg")
    self.Label_compose = TFDirector:getChildByPath(self.Button_compose, "Label_compose")
    self.Label_selectPointName = TFDirector:getChildByPath(self.Panel_formula, "Label_selectPointName")
    self.Label_little_name = TFDirector:getChildByPath(self.Panel_formula, "Label_little_name")
    self.Label_top_tips = TFDirector:getChildByPath(self.Panel_formula, "Label_top_tips")
    self.Label_need_time = TFDirector:getChildByPath(self.Panel_formula, "Label_need_time")
    self.Label_tips = TFDirector:getChildByPath(self.Panel_formula, "Label_tips")
    self.Image_res = TFDirector:getChildByPath(self.Panel_formula, "Image_res")
    self.Label_cost = TFDirector:getChildByPath(self.Panel_formula, "Label_cost")

    self.ScrollView_equips = UIListView:create(TFDirector:getChildByPath(self.Panel_formula, "ScrollView_equips"))
    self.ScrollView_equips:setItemsMargin(8)

    self.ScrollView_materials = UIListView:create(TFDirector:getChildByPath(self.Panel_formula, "ScrollView_materials"))
    self.ScrollView_materials:setItemsMargin(15)

    self.ScrollView_point = TFDirector:getChildByPath(self.Panel_root, "ScrollView_point")
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")
    local Panel_site = TFDirector:getChildByPath(self.ScrollView_point, "Panel_site")
    self.Panel_site = {}
    for i = 1, 10 do
        local foo = {}
        foo.item = TFDirector:getChildByPath(Panel_site, "Panel_site_" .. i)
        foo.Panel_icon = TFDirector:getChildByPath(foo.item, "Panel_icon")
        foo.Image_icon = TFDirector:getChildByPath(foo.item, "Image_icon")
        foo.Image_progress_bg = TFDirector:getChildByPath(foo.item, "Image_progress_bg")
        foo.LoadingBar_progress = TFDirector:getChildByPath(foo.item, "LoadingBar_progress")
        foo.Image_select = TFDirector:getChildByPath(foo.item, "Image_select")
        foo.Image_lock = TFDirector:getChildByPath(foo.item, "Image_lock"):hide()
        foo.Image_name_bg = TFDirector:getChildByPath(foo.item, "Image_name_bg")
        foo.Label_name = TFDirector:getChildByPath(foo.item, "Label_name")
        foo.Image_get_bg = TFDirector:getChildByPath(foo.item, "Image_get_bg")
        foo.Spine_conduct = TFDirector:getChildByPath(foo.item, "Spine_conduct")
        foo.Spine_complete = TFDirector:getChildByPath(foo.item, "Spine_complete")
        self.Panel_site[i] = foo
    end
    self.Image_complets = {}
    for i=1,10 do
        local Image_complet = TFDirector:getChildByPath(Panel_buttom, "Image_complet"..i)
        self.Image_complets[i] = Image_complet
    end
    local Image_enable = TFDirector:getChildByPath(self.Panel_root, "Image_enable")
    self.Label_enable = TFDirector:getChildByPath(Image_enable, "Label_enable")
    self.Button_preview = TFDirector:getChildByPath(self.Panel_root, "Button_preview")
    self.Label_preview = TFDirector:getChildByPath(self.Button_preview, "Label_preview")

    self.Button_onekeyComplete = TFDirector:getChildByPath(ui, "Button_onekeyComplete")

    self.Label_top_tips:setTextById(1200077)
    local data = TabDataMgr:getData("DiscreteData",14009).data
    local min = math.floor(data.time / 60)
    self.Label_tips:setTextById(1200076,min)
    self:refreshView()
end

function SummonComposeView:refreshView()
    self.Label_compose:setTextById(1200019)
    for k, v in pairs(self.Panel_site) do
        self:updatePointItem(k)
    end

    if self.selectPointType_ then
        self:selectPoint(self.selectPointType_, false)
    end

    self:updateOneKey();
end

function SummonComposeView:updateOneKey()
    local isShowOneKey = false;
    for k, v in pairs(self.Panel_site) do
        if not isShowOneKey then
            isShowOneKey = SummonDataMgr:isCanReceiveComposeReward(k)
        end
    end
    self._ui.Button_onekey:setVisible(isShowOneKey);

    self.Button_onekeyComplete:setVisible(SummonDataMgr:isHaveNotCommplete() and SummonDataMgr:isCanFreeAllApeedUp())
end

function SummonComposeView:updatePointItem(pointType)
    local summonComposeCfg = self.summonCompose_[pointType]
    local summonComposeInfo = SummonDataMgr:getSummonComposeInfo(pointType)
    local isCompose = tobool(summonComposeInfo)
    local isCanReceive = SummonDataMgr:isCanReceiveComposeReward(pointType)
    local isCanCompose = SummonDataMgr:isCanCompose(pointType)

    local foo = self.Panel_site[pointType]
    local isSelect = self.selectPointType_ == pointType
    foo.Image_progress_bg:setVisible(not isCanReceive and isCompose)
    foo.Image_select:setVisible(isSelect)
    local nameBg = "summon/new_ui/b011.png"
    if isSelect then
        nameBg = "summon/new_ui/b014.png"
    elseif isCanReceive or isCompose or isCanCompose then
        nameBg = "summon/new_ui/b012.png"
    end
    foo.Image_name_bg:setTexture(nameBg)
    foo.Label_name:setTextById(tonumber(summonComposeCfg.pointName))
    foo.Image_get_bg:setVisible(isCanReceive)
    foo.Spine_conduct:setVisible(not isCanReceive and isCompose)
    foo.Spine_complete:setVisible(isCanReceive)
    self.Image_complets[pointType]:setVisible(isCanReceive or isCanCompose)
    if isCanReceive or isCompose or isCanCompose then
        foo.Image_icon:setTexture(summonComposeCfg.lightIcon)
    else
        foo.Image_icon:setTexture(summonComposeCfg.grayIcon)
    end
    foo.Panel_icon:setTouchEnabled(true)
    foo.Panel_icon:onClick(function()
        self:selectPoint(pointType,true)
    end)

    foo.Image_get_bg:setTouchEnabled(true)
    foo.Image_get_bg:onClick(function()
        local summonComposeCfg = self.summonCompose_[pointType]
        SummonDataMgr:send_SUMMON_COMPOSE_FINISH(summonComposeCfg.zPointType)
    end)
end

function SummonComposeView:selectPoint(pointType, force)
    self.Panel_formula:setVisible(true)
    local isCanReceive = SummonDataMgr:isCanReceiveComposeReward(pointType)
    if force and isCanReceive then
        local summonComposeCfg = self.summonCompose_[pointType]
        SummonDataMgr:send_SUMMON_COMPOSE_FINISH(summonComposeCfg.zPointType)
    end
    local lastPointType = self.selectPointType_
    self.selectPointType_ = pointType
    if lastPointType then
        self:updatePointItem(lastPointType)
    end
    
    self:updatePointItem(self.selectPointType_)

    self:updatePointInfo()
end

function SummonComposeView:updatePointInfo()
    self.selectPointType_ = self.selectPointType_ or self.defaultSelectPointType_;
    local summonComposeCfg = self.summonCompose_[self.selectPointType_]
    local summonComposeInfo = SummonDataMgr:getSummonComposeInfo(self.selectPointType_)
    local isCompose = SummonDataMgr:isComposing(self.selectPointType_)
    local isCanReceive = SummonDataMgr:isCanReceiveComposeReward(self.selectPointType_)
    local isCanCompose = SummonDataMgr:isCanCompose(self.selectPointType_)

    self.Button_compose:setVisible(not isCompose)
    self.Label_tips:setVisible(not isCanReceive and isCompose)
    self.Button_speed:setVisible(isCompose and not isCanReceive)
    self.Image_cost_bg:setVisible(isCompose and not isCanReceive)
    if self.Button_speed:isVisible() then
        self.Label_cost:setColor(ccc3(48,53,74))
        local data = TabDataMgr:getData("DiscreteData",14009).data
        local itemId = data.accelerateItem
        local count = GoodsDataMgr:getItemCount(itemId)
        if count >= data.num1 then
            local cfg = GoodsDataMgr:getItemCfg(itemId)
            self.Image_res:setTexture(cfg.icon)
            self.Label_cost:setText(tostring(data.num1))
        else
            itemId = data.replaceItem
            local cfg = GoodsDataMgr:getItemCfg(itemId)
            count = GoodsDataMgr:getItemCount(itemId)
            self.Image_res:setTexture(cfg.icon)
            self.Label_cost:setText(tostring(data.num2))
            if count < data.num2 then
                self.Label_cost:setColor(ccc3(219,50,50))
            end
        end
        self.Image_cost_bg:setTouchEnabled(true)
        self.Image_cost_bg:onClick(function()
            Utils:showInfo(itemId, nil, true)
        end)
    end

    self.Label_selectPointName:setTextById(summonComposeCfg.pointName)
    self.Label_little_name:setTextById(summonComposeCfg.pointEnName)

    local costItem = summonComposeCfg.cost
    local isAllEnough = true
    self.ScrollView_materials:removeAllItems()
    for i,v in ipairs(costItem) do
        local material_item = self.Panel_material_item:clone()
        local Panel_item = TFDirector:getChildByPath(material_item, "Panel_item")
        local Label_count = TFDirector:getChildByPath(material_item, "Label_count")
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:setScale(0.7)
        PrefabDataMgr:setInfo(Panel_goodsItem, v[1], -1)
        Panel_goodsItem:Pos(0, 0):AddTo(Panel_item)
        local count = GoodsDataMgr:getItemCount(v[1])
        local needCount = v[2]
        if needCount >= 10000 then
            needCount = tostring(math.floor(needCount / 1000)).."k"
        end
        Label_count:setText(Utils:format_number(count).."/"..needCount)
        if count >= v[2] then
            Label_count:setColor(ccc3(48,53,74))
        else
            Label_count:setColor(ccc3(219,50,50))
        end
        self.ScrollView_materials:pushBackCustomItem(material_item)
    end

    self.Button_compose:setGrayEnabled(isCanReceive or not isCanCompose)
    self.Button_compose:setTouchEnabled(not isCanReceive and isCanCompose)

    local poolCfgs = SummonDataMgr:getSummonPoolCfgs(self.selectPointType_)
    self.ScrollView_equips:removeAllItems()
    for i,v in ipairs(poolCfgs) do
        local equip_item = self.Panel_equip_item:clone()
        local Image_equip_back = TFDirector:getChildByPath(equip_item, "Image_equip_back")
        local Image_frame = TFDirector:getChildByPath(equip_item, "Image_frame")
        local Image_Equip = TFDirector:getChildByPath(equip_item, "Image_Equip")
        local Image_type = TFDirector:getChildByPath(equip_item, "Image_type")
        local equip_cost = TFDirector:getChildByPath(equip_item, "equip_cost")
        local Label_level = TFDirector:getChildByPath(equip_item, "Label_level")

        local halfPaint = EquipmentDataMgr:getEquipHalfPaint(v.id)
        Image_Equip:setTexture(halfPaint)
        local quality = EquipmentDataMgr:getEquipQuality(v.id)
        Image_equip_back:setTexture(EC_EquipBoard[quality])
        Image_frame:setTexture(EC_EquipFrame[quality])
        local subType  = EquipmentDataMgr:getEquipSubType(v.id)
        Image_type:setTexture(EC_EquipSubTypeIconBag[subType])

        local starLv = EquipmentDataMgr:getEquipStarLv(v.id)
        for i=1,5 do
            local star = TFDirector:getChildByPath(equip_item, "Image_star"..i)
            star:setVisible(i <= starLv)
        end
        local equipCost = EquipmentDataMgr:getEquipCost(v.id)
        equip_cost:setString(equipCost)
        Label_level:setString("1")
        Image_equip_back:setTouchEnabled(true)
        Image_equip_back:onClick(function()
            Utils:showInfo(v.id, nil, true)
        end)

        self.ScrollView_equips:pushBackCustomItem(equip_item)
    end
    self.ScrollView_equips:update()

    self:updateCountDown()
end

function SummonComposeView:addCountDownTimer(storeId)
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function SummonComposeView:onCountDownPer()
    self:updateCountDown()
end

function SummonComposeView:updateCountDown()
    for pointType, foo in ipairs(self.Panel_site) do
        local isCanReceive = SummonDataMgr:isCanReceiveComposeReward(pointType)
        local isCompose = SummonDataMgr:isComposing(pointType)
        local summonComposeInfo = SummonDataMgr:getSummonComposeInfo(pointType)
        local summonComposeCfg = self.summonCompose_[pointType]
        foo.Image_progress_bg:setVisible(not isCanReceive and isCompose)
        if isCompose then
            local remainTime = math.max(0, summonComposeInfo.finishTime - ServerDataMgr:getServerTime())
            if self.selectPointType_ == pointType then
                if isCanReceive then
                    self.Label_need_time:setTextById(1200018)
                else
                    local hour, min = Utils:getFuzzyTime(remainTime, true)
                    self.Label_need_time:setTextById(1200078, hour, min)
                end
            end
            
            local percent = 1 - me.clampf(remainTime / summonComposeInfo.costTime, 0, 1)
            foo.LoadingBar_progress:setPercent(percent * 100)
            if isCanReceive then
                self:updatePointItem(pointType)
            end
        else
            if self.selectPointType_ == pointType then
                self.Label_need_time:setTextById(1200079)
            end
            foo.LoadingBar_progress:setPercent(0)
        end
    end
end

function SummonComposeView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function SummonComposeView:removeEvents()
    self:removeCountDownTimer()
end

function SummonComposeView:registerEvents()
    EventMgr:addEventListener(self, EV_SUMMON_COMPOSE_UPDATE, handler(self.onComposeUpdateEvent, self))
    EventMgr:addEventListener(self, EV_SUMMON_COMPOSE_RECEIVE, handler(self.onComposeReceiveEvent, self))
    EventMgr:addEventListener(self, EV_PRIVILEGE_UPDATE, handler(self.updateOneKey, self))

    self.Button_compose:onClick(function()
        local summonComposeCfg = self.summonCompose_[self.selectPointType_]
        SummonDataMgr:send_SUMMON_COMPOSE_SUMMON(summonComposeCfg.id)
    end)

    self.Button_speed:onClick(function()
        local summonInfo = SummonDataMgr:getSummonComposeInfo(self.selectPointType_)
        local data = TabDataMgr:getData("DiscreteData",14009).data
        local min = math.floor(data.time / 60)
        local count = GoodsDataMgr:getItemCount(data.accelerateItem)
        local cfg = GoodsDataMgr:getItemCfg(data.accelerateItem)
        if count >= data.num1 then
            local view = Utils:openView("summon.SummonSpeedView")
            view:setCallback(function()
                SummonDataMgr:send_SUMMON_COMPOSE_SPEED(summonInfo.cid)
            end)
            view:setContent(1200074,{tostring(data.num1),TextDataMgr:getText(cfg.nameTextId), tostring(min)})
        else
            cfg = GoodsDataMgr:getItemCfg(data.replaceItem)
            count = GoodsDataMgr:getItemCount(data.replaceItem)
            if count >= data.num2 then
                local view = Utils:openView("summon.SummonSpeedView")
                view:setCallback(function()
                    SummonDataMgr:send_SUMMON_COMPOSE_SPEED(summonInfo.cid)
                end)
                view:setContent(1200075,{tostring(data.num2),TextDataMgr:getText(cfg.nameTextId),tostring(min)})
            else
                FunctionDataMgr:jPay()
            end
        end
    end)
    

    self.Button_preview:onClick(function()
        Utils:openView("summon.SummonComposePreviewView")
    end)

    self.Panel_touch:setTouchEnabled(true)
    self.Panel_touch:onClick(function()
        self.Panel_formula:setVisible(false)
    end)

    self._ui.Button_onekey:onClick(function()
            --传-1表示一件领取
            self.selectPointType_ = 1;
            SummonDataMgr:send_SUMMON_COMPOSE_FINISH(-1)
    end)

    self.Button_onekeyComplete:onClick(function()
        SummonDataMgr:send_SUMMON_COMPOSE_SPEED(0)
    end)
end

function SummonComposeView:onShow( )
    self.super.onShow(self)
    self:refreshView()
end

function SummonComposeView:onComposeUpdateEvent(pointType)
    for k, v in pairs(self.Panel_site) do
        self:updatePointItem(k)
    end
    
    self:updatePointInfo()
    self:updateOneKey();
end

function SummonComposeView:onComposeReceiveEvent(pointType, reward)
    -- self:updatePointItem(pointType)
    for k, v in pairs(self.Panel_site) do
        self:updatePointItem(k)
    end
    self:updatePointInfo()
    local voideoView = Utils:openView("common.VideoView", "video/summon.mp4")
    voideoView:bindEndCallBack(function()
        Utils:openView("summon.SummonResultView", reward or {}, true)
    end)
end

return SummonComposeView
