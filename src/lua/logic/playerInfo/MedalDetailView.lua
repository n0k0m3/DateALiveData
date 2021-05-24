
local MedalDetailView = class("MedalDetailView", BaseLayer)

function MedalDetailView:initData(medalId)
    self.medalInfo_ = MedalDataMgr:getMedelInfoById(medalId)
    self.medalCfg_ = MedalDataMgr:getMedalCfgById(medalId)

    -- 倒计时
    self.countDownTimer_ = nil
end

function MedalDetailView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.playerInfo.medalDetailView")
end

function MedalDetailView:initUI(ui)
    self:showTopBar()
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    self.Panel_attr_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_attr_item")
    self.Panel_skill_item = TFDirector:getChildByPath(self.Panel_prefab, "Panel_skill_item")

    local Panel_Bg = TFDirector:getChildByPath(self.Panel_root, "Panel_Bg")
    self.Panel_left = TFDirector:getChildByPath(self.Panel_root, "Panel_left")
    self.Panel_right = TFDirector:getChildByPath(self.Panel_root, "Panel_right")
    local Panel_btn = TFDirector:getChildByPath(self.Panel_root, "Panel_btn")

    self.Button_wear = TFDirector:getChildByPath(Panel_btn, "Button_wear")
    self.Button_unlock = TFDirector:getChildByPath(Panel_btn, "Button_unlock")
    self.Button_drop = TFDirector:getChildByPath(Panel_btn, "Button_drop")
    self.Button_change = TFDirector:getChildByPath(Panel_btn, "Button_change")

    self:initLeftPanel()
    self:initRightPanel()
    self:updateBtnsState()
end

function MedalDetailView:initLeftPanel()
    local Image_medal_icon = TFDirector:getChildByPath(self.Panel_left, "Image_medal_icon")
    local Label_medal_name = TFDirector:getChildByPath(self.Panel_left, "Label_medal_name")
    local Label_state = TFDirector:getChildByPath(self.Panel_left, "Label_state")
    self.Label_valid_time = TFDirector:getChildByPath(self.Panel_left, "Label_valid_time")
    self.Label_valid_time_value = TFDirector:getChildByPath(self.Panel_left, "Label_valid_time_value")
    local Label_medal_des = TFDirector:getChildByPath(self.Panel_left, "Label_medal_des")
    local Label_medal_get_des = TFDirector:getChildByPath(self.Panel_left, "Label_medal_get_des")
    local Image_star = TFDirector:getChildByPath(self.Panel_left, "Image_star")

    Image_medal_icon:setTexture(self.medalCfg_.showicon)
    Label_medal_name:setTextById(self.medalCfg_.name)
    Label_medal_des:setTextById(self.medalCfg_.desTextId)
    Label_medal_get_des:setTextById(self.medalCfg_.accessdes)
    self.Label_valid_time:setTextById(4007003)
    if self.medalInfo_ then
        if self.medalInfo_.wear == 2 then
            Label_state:setTextById(4007006)
        else
            Label_state:setTextById(4007004)
        end
    else
        Label_state:setTextById(450010)
    end
    
    if self.medalCfg_.effectivetime == -1 then
        self.Label_valid_time_value:setTextById(4007007)
        self.Label_valid_time:setPositionX(self.Label_valid_time_value:getPositionX() - self.Label_valid_time_value:getContentSize().width - 5)
    else
        self:addCountDownTimer()
        self:onCountDownPer()
    end

    for i=1,5 do
        local str = "Image_star"..i
        if self.medalCfg_.star >= i then
            TFDirector:getChildByPath(Image_star, str):show()
        else
            TFDirector:getChildByPath(Image_star, str):hide()
        end
    end
end

function MedalDetailView:initRightPanel()
    self.ScrollView_attrs = TFDirector:getChildByPath(self.Panel_right, "ScrollView_attrs")
    self.ScrollView_skill = TFDirector:getChildByPath(self.Panel_right, "ScrollView_skill")

    self.ScrollView_attrs = UIGridView:create(self.ScrollView_attrs)
    self.ScrollView_attrs:setItemModel(self.Panel_attr_item)
    self.ScrollView_attrs:setColumn(2)
    self.ScrollView_attrs:setColumnMargin(20)
    self.ScrollView_attrs:setRowMargin(15)

    self.ScrollView_skill = UIGridView:create(self.ScrollView_skill)
    self.ScrollView_skill:setItemModel(self.Panel_skill_item)
    self.ScrollView_skill:setRowMargin(15)

    for k,v in pairs(self.medalCfg_.baseAttribute) do
        local item = self.ScrollView_attrs:pushBackDefaultItem()
        local cfg = HeroDataMgr:getAttributeConfig(k)
        local Label_attr_name = TFDirector:getChildByPath(item, "Label_attr_name")
        local Label_attr_value = TFDirector:getChildByPath(item, "Label_attr_value")
        Label_attr_name:setTextById(cfg.name)
        Label_attr_value:setText(string.format(cfg.displayFormat, v))
    end

    for k,v in pairs(self.medalCfg_.baseskill) do
        local item = self.ScrollView_skill:pushBackDefaultItem()
        local cfg = HeroDataMgr:getAttributeConfig(k)
        local Label_attr_name = TFDirector:getChildByPath(item, "Label_attr_name")
        local Label_attr_value = TFDirector:getChildByPath(item, "Label_attr_value")
        Label_attr_name:setTextById(cfg.name)
        Label_attr_value:setText(tostring(v))
    end
end

function MedalDetailView:updateBtnsState()
    self.Button_wear:hide()
    self.Button_unlock:hide()
    self.Button_change:hide()
    self.Button_drop:hide()
    if self.medalInfo_ then
        if self.medalInfo_.isEquip then
            self.Button_drop:show()
            self.Button_change:show()
            if MedalDataMgr:checkEnableReplaceMedal(self.medalInfo_.cid) then
                self.Button_change:setGrayEnabled(false)
            else
                self.Button_change:setGrayEnabled(true)
            end
        else
            self.Button_wear:show()
        end
    else
        self.Button_unlock:show()
        self.Button_unlock:setGrayEnabled(true)
    end
end

function MedalDetailView:onWearMedalSuccess(data)
    if data.success then
        MedalDataMgr:sendReqActivateMedals()
        AlertManager:close()
    end
end

function MedalDetailView:onDropMedalSuccess(data)
    if data.success then
        MedalDataMgr:sendReqActivateMedals()
        AlertManager:close()
    end
end

function MedalDetailView:registerEvents()
    EventMgr:addEventListener(self, EV_MEDAL_WEAR_MEDAL_SUCCESS, handler(self.onWearMedalSuccess, self))
    EventMgr:addEventListener(self, EV_MEDAL_DROP_MEDAL_SUCCESS, handler(self.onDropMedalSuccess, self))

    self.Button_wear:onClick(function()
        MedalDataMgr:sendReqEquipMedal(self.medalInfo_.cid)
    end)

    self.Button_change:onClick(function()
        if MedalDataMgr:checkEnableReplaceMedal(self.medalInfo_.cid) then
            EventMgr:dispatchEvent(EV_MEDAL_READY_TO_REPLACE, {})
            AlertManager:close()
        else
            Utils:showTips(100000071)
        end
    end)

    self.Button_drop:onClick(function()
        MedalDataMgr:sendReqTakeOffMedal(self.medalInfo_.cid)
    end)

    self.Button_unlock:onClick(function()
        Utils:showTips(100000072)
    end)
end

function MedalDetailView:removeEvents()
    self:removeCountDownTimer()
end

function MedalDetailView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function MedalDetailView:onCountDownPer()
    local effectTime = self.medalInfo_.effectTime - ServerDataMgr:getServerTime()
    if effectTime <= 0 then
        effectTime = self.medalCfg_.effectivetime
        self:removeCountDownTimer()
    end
    local day, hour, min, sec = Utils:getDHMS(effectTime, true)
    self.Label_valid_time_value:setText(day.."d:"..hour.."h:"..min.."m")
    self.Label_valid_time:setPositionX(self.Label_valid_time_value:getPositionX() - self.Label_valid_time_value:getContentSize().width - 5)
end

function MedalDetailView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

return MedalDetailView
