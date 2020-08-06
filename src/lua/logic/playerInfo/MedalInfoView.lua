
local MedalInfoView = class("MedalInfoView", BaseLayer)

function MedalInfoView:initData(medalId)
    self.medalInfo_ = MedalDataMgr:getMedelInfoById(medalId)
    self.medalCfg_ = MedalDataMgr:getMedalCfgById(medalId)

    -- 倒计时
    self.countDownTimer_ = nil
end

function MedalInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:showPopAnim(true)
    self:init("lua.uiconfig.playerInfo.medalInfoView")
end

function MedalInfoView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_medalInfo = TFDirector:getChildByPath(ui, "Panel_medalInfo")
    self.Button_close = TFDirector:getChildByPath(self.Panel_medalInfo, "Button_close")

    self:initInfoPanel()
end

function MedalInfoView:initInfoPanel()
    local Image_medal_icon = TFDirector:getChildByPath(self.Panel_medalInfo, "Image_medal_icon")
    local Label_medal_name = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_medal_name")
    local Label_state = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_state")
    self.Label_valid_time = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_valid_time")
    self.Label_valid_time_value = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_valid_time_value")
    self.Label_get_time = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_get_time")
    self.Label_get_time_value = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_get_time_value")
    local Label_medal_des = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_medal_des")
    local Label_medal_get_des = TFDirector:getChildByPath(self.Panel_medalInfo, "Label_medal_get_des")
    local Panel_star = TFDirector:getChildByPath(self.Panel_medalInfo, "Panel_star")

    Image_medal_icon:setTexture(self.medalCfg_.icon)
    local scaleRate = self.medalCfg_.size[2] or 100
    Image_medal_icon:setScale(scaleRate / 100)
    Label_medal_name:setTextById(self.medalCfg_.name)
    Label_medal_des:setTextById(self.medalCfg_.desTextId)
    Label_medal_get_des:setTextById(self.medalCfg_.accessdes)
    self.Label_valid_time:setTextById(4007003)

    if self.medalInfo_ and self.medalInfo_.createTime and self.medalInfo_.createTime > 0 then
        local year, month, day = Utils:getDate(self.medalInfo_.createTime, true)
        self.Label_get_time_value:setText(year.."."..month.."."..day)
    elseif not self.medalInfo then
        self.Label_get_time_value:setTextById(1327104)
    else
        self.Label_get_time_value:setText("")
    end

    if self.medalInfo_ then
        if self.medalInfo_.isEquip then
            Label_state:setTextById(4007006)
        else
            Label_state:setTextById(4007004)
        end
    else
        Label_state:setTextById(4007005)
    end
    
    if self.medalCfg_.effectivetime == -1 then
        self.Label_valid_time_value:setTextById(4007007)
    else
        self:addCountDownTimer()
        self:onCountDownPer()
    end

    for i=1,5 do
        local str = "Image_star"..i
        local star = TFDirector:getChildByPath(Panel_star, str)
        if self.medalCfg_.star >= i then
            star:show()
            star:setPositionX((5 - self.medalCfg_.star) * 9 + i * 20)
        else
            star:hide()
        end
    end
end

function MedalInfoView:registerEvents()
     self.Button_close:onClick(function()
            AlertManager:close()
        end,
        EC_BTN.CLOSE)
end

function MedalInfoView:removeEvents()
    self:removeCountDownTimer()
end

function MedalInfoView:addCountDownTimer()
    if self.countDownTimer_ then return end
    self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
end

function MedalInfoView:onCountDownPer()
    local effectTime = self.medalInfo_ and (self.medalInfo_.effectTime - ServerDataMgr:getServerTime()) or 0
    if effectTime <= 0 then
        effectTime = self.medalCfg_.effectivetime
        self:removeCountDownTimer()
    end
    local day, hour, min, sec = Utils:getDHMS(effectTime, false)
    self.Label_valid_time_value:setTextById(4007008, day, hour, min)
end

function MedalInfoView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

return MedalInfoView
