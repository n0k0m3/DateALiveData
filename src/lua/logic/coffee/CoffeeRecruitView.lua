
local CoffeeRecruitView = class("CoffeeRecruitView", BaseLayer)

function CoffeeRecruitView:initData()
    self.recruitInfo_ = CoffeeDataMgr:getRecruitInfo()

    self.recruitCost_ = Utils:getKVP(46016, "refreshPay")
    self.recruitMax_ = Utils:getKVP(46016, "recruitMax")
end

function CoffeeRecruitView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.coffee.coffeeRecruitView")
end

function CoffeeRecruitView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_elf = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Panel_elf_" .. i)
        foo.Button_elf = TFDirector:getChildByPath(foo.root, "Button_elf")
        foo.Image_icon = TFDirector:getChildByPath(foo.Button_elf, "Image_icon")
        foo.Label_name = TFDirector:getChildByPath(foo.Button_elf, "Label_name")
        foo.Image_star = {}
        for j = 1, 3 do
            local Image_star = TFDirector:getChildByPath(foo.Button_elf, "Image_star_" .. j)
            foo.Image_star[j] = TFDirector:getChildByPath(Image_star, "Image_star_light")
        end
        local Image_property = TFDirector:getChildByPath(foo.Button_elf, "Image_property")
        foo.Label_power = TFDirector:getChildByPath(Image_property, "Image_power.Label_power")
        foo.Label_rush = TFDirector:getChildByPath(Image_property, "Image_rush.Label_rush")
        foo.Label_cuisine = TFDirector:getChildByPath(Image_property, "Image_cuisine.Label_cuisine")
        foo.Button_recruit = TFDirector:getChildByPath(foo.root, "Button_recruit")
        foo.Label_recruit = TFDirector:getChildByPath(foo.Button_recruit, "Label_recruit")
        foo.Label_recruit:setTextById(13410031)
        local Image_cost = TFDirector:getChildByPath(foo.Button_recruit, "Image_cost")
        foo.Image_cost_icon = TFDirector:getChildByPath(Image_cost, "Image_cost_icon")
        foo.Label_cost_num = TFDirector:getChildByPath(Image_cost, "Label_cost_num")
        foo.Image_already = TFDirector:getChildByPath(foo.root, "Image_already")
        foo.Label_already = TFDirector:getChildByPath(foo.Image_already, "Label_already")
        foo.Label_already:setTextById(13410032)
        self.Panel_elf[i] = foo
    end
    local Image_bottom = TFDirector:getChildByPath(self.Panel_root, "Image_bottom")
    self.Label_remain = TFDirector:getChildByPath(Image_bottom, "Label_remain")
    self.Label_remain_count = TFDirector:getChildByPath(self.Label_remain, "Label_remain_count")
    self.Label_next_refresh = TFDirector:getChildByPath(Image_bottom, "Label_next_refresh")
    self.Label_timing = TFDirector:getChildByPath(Image_bottom, "Label_timing")
    self.Button_refresh = TFDirector:getChildByPath(Image_bottom, "Button_refresh")
    self.Label_refresh = TFDirector:getChildByPath(self.Button_refresh, "Label_refresh")
    self.Button_refresh_free = TFDirector:getChildByPath(Image_bottom, "Button_refresh_free")
    self.Label_refresh_free = TFDirector:getChildByPath(self.Button_refresh_free, "Label_refresh_free")
    local Image_cost = TFDirector:getChildByPath(self.Button_refresh, "Image_cost")
    self.Image_cost_icon = TFDirector:getChildByPath(Image_cost, "Image_cost_icon")
    self.Label_cost_num = TFDirector:getChildByPath(Image_cost, "Label_cost_num")

    self:refreshView()
end

function CoffeeRecruitView:refreshView()
    self.Label_remain:setTextById(13410033)
    self.Label_refresh:setTextById(13410035)
    self.Label_refresh_free:setTextById(13410035)
    self.Label_next_refresh:setTextById(13410034)

    self:updateRecruitInfo()
    self:addCountDownTimer()
end

function CoffeeRecruitView:updateRecruitInfo()
    self.recruitInfo_ = CoffeeDataMgr:getRecruitInfo()

    local remainCount = math.max(0, self.recruitMax_ - self.recruitInfo_.recruitTimes)
    self.Label_remain_count:setText(remainCount)

    local cost = self.recruitCost_[self.recruitInfo_.recruitBuyTimes + 1]
    if cost then
        self.costCid_, self.costNum_ = next(cost)
        self.costCfg_ = GoodsDataMgr:getItemCfg(self.costCid_)
        self.Image_cost_icon:setTexture(self.costCfg_.icon)
        self.Label_cost_num:setText(self.costNum_)
    else
    end

    self:updateElf()
    self:updateCountDonw()
end

function CoffeeRecruitView:updateCountDonw()
    local serverTime = ServerDataMgr:getServerTime()
    local isFree = serverTime > self.recruitInfo_.nextTime
    local isCanRefresh = self.recruitInfo_.recruitBuyTimes < #self.recruitCost_
    self.Button_refresh:setVisible(not isFree and isCanRefresh)
    self.Button_refresh_free:setVisible(not self.Button_refresh:isVisible())
    self.Button_refresh_free:Touchable(isFree)
    self.Button_refresh_free:setGrayEnabled(not isFree)

    self.Label_timing:setVisible(not isFree)
    self.Label_next_refresh:setVisible(not isFree)
    local remainTime = math.max(0, self.recruitInfo_.nextTime - serverTime)
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day == "00" then
        self.Label_timing:setTextById(800027, hour, min)
    else
        self.Label_timing:setTextById(800044, day, hour, min)
    end
end

function CoffeeRecruitView:onCountDownPer()
    self:updateCountDonw()
end

function CoffeeRecruitView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function CoffeeRecruitView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function CoffeeRecruitView:updateElf()
    for i, v in ipairs(self.Panel_elf) do
        local recruit = self.recruitInfo_.recruits[i]
        local maidCfg = CoffeeDataMgr:getMaidCfg(recruit.cid)
        v.Label_power:setText(CoffeeDataMgr:converPower(maidCfg.strength))
        v.Label_rush:setText(maidCfg.showcase)
        v.Label_cuisine:setText(maidCfg.food)
        v.Image_icon:setTexture(maidCfg.icon2)
        v.Label_name:setTextById(maidCfg.name1)
        for j, Image_star in ipairs(v.Image_star) do
            Image_star:setVisible(j <= maidCfg.quality)
        end
        local costCid, costNum = next(maidCfg.price)
        local costCfg = GoodsDataMgr:getItemCfg(costCid)
        v.Image_cost_icon:setTexture(costCfg.icon)
        v.Label_cost_num:setText(costNum)
        v.Button_recruit:setVisible(recruit.state)
        v.Image_already:setVisible(not recruit.state)
        v.Button_elf:setTextureNormal(maidCfg.qualityIcon)

        v.Button_elf:onClick(function()
                Utils:openView("coffee.CoffeeDetailsView", false, recruit.cid)
        end)

        v.Button_recruit:onClick(function()
                if self.recruitInfo_.recruitTimes < self.recruitMax_ then
                    if recruit.state then
                        if GoodsDataMgr:currencyIsEnough(costCid, costNum) then
                            CoffeeDataMgr:send_MAID_ACTIVITY_REQ_RECRUIT_MAID(i)
                        else
                            -- Utils:showTips(13410046)
                            Utils:showAccess(costCid)
                        end
                    else
                        Utils:showTips(13410043)
                    end
                else
                    Utils:showTips(13410044)
                end
        end)
    end
end

function CoffeeRecruitView:registerEvents()
    EventMgr:addEventListener(self, EV_COFFEE_RECRUIT_MAID, handler(self.onRecruitMaidEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_REFRESH_RECRUIT, handler(self.onRefreshRecruitEvent, self))


    self.Button_refresh:onClick(function()
            if GoodsDataMgr:currencyIsEnough(self.costCid_, self.costNum_) then
                if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReConfirm_MaidRecruit) then
                    CoffeeDataMgr:send_MAID_ACTIVITY_REQ_REFRESH_RECRUIT(2)
                else
                    local rstr = TextDataMgr:getTextAttr(13410048)
                    local content = string.format(rstr.text, self.costNum_, self.costCfg_.icon)
                    Utils:openView(
                        "common.ReConfirmTipsView",
                        {
                            tittle = 13410047,
                            content = content,
                            reType = EC_OneLoginStatusType.ReConfirm_MaidRecruit,
                            confirmCall = function()
                                CoffeeDataMgr:send_MAID_ACTIVITY_REQ_REFRESH_RECRUIT(2)
                            end
                        }
                    )
                end
            else
                Utils:showAccess(self.costCid_)
            end
    end)

    self.Button_refresh_free:onClick(function()
            CoffeeDataMgr:send_MAID_ACTIVITY_REQ_REFRESH_RECRUIT(1)
    end)
end

function CoffeeRecruitView:removeEvents()
    self:removeCountDownTimer()
end

function CoffeeRecruitView:onRecruitMaidEvent()
    Utils:showTips(13410042)
    self:updateRecruitInfo()
end

function CoffeeRecruitView:onRefreshRecruitEvent()
    Utils:showTips(13410045)
    self:updateRecruitInfo()
end

return CoffeeRecruitView
