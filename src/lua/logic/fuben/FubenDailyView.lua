
local FubenDailyView = class("FubenDailyView", BaseLayer)

function FubenDailyView:initData(levelGroupCid)
    self.levelGroupCid_ = levelGroupCid
    self.levelGroupCfg_ = FubenDataMgr:getLevelGroupCfg(levelGroupCid)
    self.level_ = FubenDataMgr:getLevel(levelGroupCid, EC_FBDiff.SIMPLE)
    self.levelItem_ = {}
    local timestamp = FubenDataMgr:getDailyExpirationTime(levelGroupCid)
    if timestamp then
        self.expirationTime_ = timestamp
        self:addCountDownTimer()
    end
end

function FubenDailyView:getClosingStateParams()
    return {FubenDataMgr.selectLevelGroup_}
end

function FubenDailyView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenDailyView")
end

function FubenDailyView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_levelItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_levelItem")

    self.Image_title = TFDirector:getChildByPath(self.Panel_root, "Image_title")
    self.Label_title = TFDirector:getChildByPath(self.Image_title, "Label_title")
    self.Label_timing = TFDirector:getChildByPath(self.Image_title, "Label_timing")
    local Image_remain_count = TFDirector:getChildByPath(self.Panel_root, "Image_remain_count")
    self.Label_remain_title = TFDirector:getChildByPath(Image_remain_count, "Label_remain_title")
    self.Label_remain_count = TFDirector:getChildByPath(Image_remain_count, "Label_remain_count")
    self.Button_add = TFDirector:getChildByPath(Image_remain_count, "Button_add")
    self.Button_newPlayer = TFDirector:getChildByPath(self.Panel_root, "Button_newPlayer")

    local Image_line = TFDirector:getChildByPath(self.Panel_root, "Image_line")
    self.Panel_site = {}
    for i = 1, 6 do
        self.Panel_site[i] = TFDirector:getChildByPath(self.Panel_root, "Panel_site_" .. i):hide()
        self.Panel_site[i]:setBackGroundColorType(0)
    end

    local activitys = ActivityDataMgr2:getNewPlayerActivityInfo(true)
    if #activitys < 1 then
        self.Button_newPlayer:setVisible(false)
    else
        self.Button_newPlayer:setVisible(true)
        self.Button_newPlayer:setTouchEnabled(false)
        self.Label_newPlayerNumExp = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumExp")
        self.Label_newPlayerNumCoin = TFDirector:getChildByPath(self.Panel_root, "Label_newPlayerNumCoin")
        local newbleCfg = TabDataMgr:getData("NewbleAdd")
        local number = newbleCfg[201].number
        if number[1] then
            self.Label_newPlayerNumExp:setText(number[1] .. "%")
        end
        if number[2] then
            self.Label_newPlayerNumCoin:setText(number[2] .. "%")
        end

        self.Image_newPlayerEXP = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerEXP")
        self.Image_newPlayerCoin = TFDirector:getChildByPath(self.Panel_root, "Image_newPlayerCoin")

        self.Image_newPlayerEXP:setVisible(number[1])
        self.Image_newPlayerCoin:setVisible(number[2])
        self.Label_newPlayerNumExp:setVisible(number[1])
        self.Label_newPlayerNumCoin:setVisible(number[2])
    end

    

    self:refreshView()
end

function FubenDailyView:updateRemainCount()
    local remainCount = FubenDataMgr:getDailyRemainFightCount(self.levelGroupCid_)
    self.Label_remain_count:setText(remainCount)
end

function FubenDailyView:refreshView()
    self.Label_remain_title:setTextById(3004031)

    self:updateRemainCount()
    if self.expirationTime_ then
        self:updateDailyCountDonw()
    end

    for i, v in ipairs(self.Panel_site) do
        local levelCid = self.level_[i]
        if levelCid then
            v:show()
            local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
            local Panel_levelItem = self.Panel_levelItem:clone()
            Panel_levelItem:AddTo(v):Pos(0, 0)

            local Button_level = TFDirector:getChildByPath(Panel_levelItem, "Button_level")
            local Label_name = TFDirector:getChildByPath(Panel_levelItem, "Label_name")
            local Label_openCond = TFDirector:getChildByPath(Panel_levelItem, "Label_openCond")
            local Image_lock = TFDirector:getChildByPath(Panel_levelItem, "Image_lock")

            local unlock = (MainPlayer:getPlayerLv() >= levelCfg.playerLv)
            Image_lock:setVisible(not unlock)
            Button_level:setTouchEnabled(unlock)
            Label_name:setTextById(300826, TextDataMgr:getText(levelCfg.name))
            Label_openCond:setText("Lv."..levelCfg.playerLv)
            Label_openCond:setVisible(not unlock)
            Button_level:setTextureNormal(levelCfg.icon)

            Button_level:onClick(function()
                    Utils:openView("fuben.FubenReadyView", levelCid)
            end)
        end
    end
end

function FubenDailyView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_DAILYBUYCOUNT, handler(self.onDailyBuyCountEvent, self))

    self.Button_add:onClick(function()
            Utils:openView("fuben.FubenDailyBuyCountView", self.levelGroupCid_)
    end)
end

function FubenDailyView:removeEvents()
    self:removeCountDownTimer()
end

function FubenDailyView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenDailyView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function FubenDailyView:onCountDownPer()
    self:updateDailyCountDonw()
end

function FubenDailyView:updateDailyCountDonw()
    local timestamp = FubenDataMgr:getDailyExpirationTime(self.levelGroupCid_)
    local remainTime = math.max(0, timestamp)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day ~= "00" then
        self.Label_timing:setTextById(800044, day, hour, min)
    else
        self.Label_timing:setTextById(301011, hour, min)
    end
end

function FubenDailyView:onDailyBuyCountEvent()
    self:updateRemainCount()
end

return FubenDailyView
