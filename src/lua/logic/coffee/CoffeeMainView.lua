local CoffeeMainView = class("CoffeeMainView", BaseLayer)

function CoffeeMainView:initData()
    local spiritCost = Utils:getKVP(46016, "spiritCost")
    self.spiritCost_ = spiritCost / 1000 / 10000

    if GlobalVarDataMgr:getValue(GV_COFFEE_IS_FIRSTENTER) then
        local datingId = Utils:getKVP(46016, "dating")
        DatingDataMgr:startDating(datingId)
        GlobalVarDataMgr:setValue(GV_COFFEE_IS_FIRSTENTER, false)
    end
end

function CoffeeMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.coffee.coffeeMainView")
end

function CoffeeMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_live2d = TFDirector:getChildByPath(self.Panel_root, "Panel_live2d")
    self.Button_achievement = TFDirector:getChildByPath(self.Panel_root, "Button_achievement")
    self.Image_achievement_tips = TFDirector:getChildByPath(self.Button_achievement, "Image_achievement_tips")
    self.Label_achievement = TFDirector:getChildByPath(self.Button_achievement, "Label_achievement")
    self.Button_rank = TFDirector:getChildByPath(self.Panel_root, "Button_rank")
    self.Label_rank = TFDirector:getChildByPath(self.Button_rank, "Label_rank")
    self.Button_recruit = TFDirector:getChildByPath(self.Panel_root, "Button_recruit")
    self.Image_recruit_tips = TFDirector:getChildByPath(self.Button_recruit, "Image_recruit_tips")
    self.Label_recruit = TFDirector:getChildByPath(self.Button_recruit, "Label_recruit")
    self.Button_story = TFDirector:getChildByPath(self.Panel_root, "Button_story")
    self.Image_story_tips = TFDirector:getChildByPath(self.Button_story, "Image_story_tips")
    self.Label_story = TFDirector:getChildByPath(self.Button_story, "Label_story")
    self.Image_info = TFDirector:getChildByPath(self.Panel_root, "Image_info")
    self.Label_turnover_title = TFDirector:getChildByPath(self.Image_info, "Label_turnover_title")
    self.Label_turnover = TFDirector:getChildByPath(self.Label_turnover_title, "Label_turnover")
    self.Label_visitor_title = TFDirector:getChildByPath(self.Image_info, "Label_visitor_title")
    self.Label_visitor = TFDirector:getChildByPath(self.Label_visitor_title, "Label_visitor")
    self.Label_consume_title = TFDirector:getChildByPath(self.Image_info, "Label_consume_title")
    self.Label_consume = TFDirector:getChildByPath(self.Label_consume_title, "Label_consume")
    self.Image_elf = TFDirector:getChildByPath(self.Panel_root, "Image_elf")
    self.Image_fetters = TFDirector:getChildByPath(self.Image_elf, "Image_fetters")

    self.Button_alarm = TFDirector:getChildByPath(self.Panel_root, "Button_alarm")
    self.Image_alarm_tips = TFDirector:getChildByPath(self.Panel_root, "Image_alarm_tips"):hide()
    self.Image_roleChooseBg = TFDirector:getChildByPath(self.Panel_root, "Image_roleChooseBg")
    self.Image_roleChooseBg:hide()
    self.pannel_roleBtn = TFDirector:getChildByPath(self.Panel_prefab, "pannel_roleBtn")
    local roleChooseView = TFDirector:getChildByPath(self.Image_roleChooseBg, "roleChooseView")
    self.roleIconView = UIListView:create(roleChooseView)
    self.roleIconView:setItemsMargin(10)

    self.Image_logShow = TFDirector:getChildByPath(self.Panel_root, "Image_logShow")
    self.Image_logShow:hide()
    self.lab_logShow = TFDirector:getChildByPath(self.Image_logShow, "lab_logShow")

    self.Image_roleBg = TFDirector:getChildByPath(self.Panel_root, "Image_roleBg")
    self.lab_roleShow = TFDirector:getChildByPath(self.Image_roleBg, "lab_roleShow")
    self.Image_roleBg:hide()

    self.Label_fetters = {}
    self.Label_noFetters = {}
    for i = 1, 2 do
        self.Label_fetters[i] = TFDirector:getChildByPath(self.Image_fetters, "Label_fetters_" .. i)
        local Label_fetters = TFDirector:getChildByPath(self.Label_fetters[i], "Label_fetters")
        Label_fetters:setTextById(13410008)
        self.Label_noFetters[i] = TFDirector:getChildByPath(self.Image_fetters, "Label_noFetters_" .. i)
        self.Label_noFetters[i]:setTextById(13410009)
    end
    self.Button_change = TFDirector:getChildByPath(self.Image_elf, "Button_change")
    self.Image_change_tips = TFDirector:getChildByPath(self.Button_change, "Image_change_tips")
    self.Label_change = TFDirector:getChildByPath(self.Button_change, "Label_change")
    self.Button_elf = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Image_elf, "Button_elf_" .. i)
        foo.Image_head = TFDirector:getChildByPath(foo.root, "Image_frame.Image_head")
        foo.Image_head:setScale(0.75)
        foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
        foo.LoadingBar_percent = TFDirector:getChildByPath(foo.root, "Image_percent.LoadingBar_percent")
        foo.Label_percent = TFDirector:getChildByPath(foo.root, "Label_percent")
        foo.Label_rate = TFDirector:getChildByPath(foo.root, "Label_rate")
        foo.Image_elf_tip = TFDirector:getChildByPath(foo.root, "Image_elf_tip")
        foo.Image_star = {}
        for j = 1, 3 do
            foo.Image_star[j] = TFDirector:getChildByPath(foo.root, "Image_star_" .. j)
        end
        self.Button_elf[i] = foo
    end

    self:refreshView()
end

function CoffeeMainView:refreshView()
    self.Label_achievement:setTextById(13410001)
    self.Label_rank:setTextById(13410002)
    self.Label_recruit:setTextById(13410003)
    self.Label_story:setTextById(13410004)
    self.Label_turnover_title:setTextById(13410005)
    self.Label_visitor_title:setTextById(13410006)
    self.Label_consume_title:setTextById(13410007)
    self.Label_change:setTextById(13410010)

    self:refreshLive2d()
    self:addCountDownTimer()
    self:updateCoffeeInfo()
    self:updateElf()
    self:playAni()
    self:refreshRoleIconView()
    self:initTimer()
end

function CoffeeMainView:updateRedPointStatus()
    local isShow = CoffeeDataMgr:isShowRedPoint(1)
    local isShow1 = CoffeeDataMgr:isGetAllLogReward()
    self.Image_achievement_tips:setVisible(isShow or not isShow1)
    local isShow = CoffeeDataMgr:isShowRedPoint(2) or CoffeeDataMgr:isShowRedPoint(3)
    self.Image_story_tips:setVisible(isShow)
    local isFree = CoffeeDataMgr:isCanFreeRefresh()
    self.Image_recruit_tips:setVisible(isFree)
    local haveNewMaid = CoffeeDataMgr:haveNewMaid()
    self.Image_change_tips:setVisible(haveNewMaid)
end

function CoffeeMainView:playAni()
    local leftAniNode = {self.Button_achievement, self.Button_rank, self.Button_recruit, self.Button_story}
    local delay = 0
    for i, v in ipairs(leftAniNode) do
        v:PosX(v:PosX() - 50)
        v:Alpha(0)
        local action = Sequence:create({
                DelayTime:create(delay),
                Spawn:create({
                        FadeIn:create(0.5),
                        MoveBy:create(0.3, ccp(50, 0)),
                }),
        })
        v:runAction(action)
        delay = delay + 0.1
    end

    self.Image_info:PosY(self.Image_info:PosY() + 50)
    self.Image_info:Alpha(0)
    local action = Sequence:create({
            Spawn:create({
                    MoveBy:create(0.3, ccp(0, -50)),
                    FadeIn:create(0.5),
            })
    })
    self.Image_info:runAction(action)

    self.Image_elf:PosY(self.Image_elf:PosY() - 50)
    self.Image_elf:Alpha(0)
    local action = Sequence:create({
            Spawn:create({
                    MoveBy:create(0.3, ccp(0, 50)),
                    FadeIn:create(0.5),
            })
    })
    self.Image_elf:runAction(action)
end

function CoffeeMainView:refreshRoleIconView()
    self.roleIconView:removeAllItems()
    local data = CoffeeDataMgr:getKanBanConfig()
    for i, v in ipairs(data) do
        local pannel_roleBtn = self.pannel_roleBtn:clone()
        pannel_roleBtn:show()
        local icon_head = TFDirector:getChildByPath(pannel_roleBtn, "icon_head")
        local imgSelect = TFDirector:getChildByPath(icon_head, "imgSelect")
        local imgLock = TFDirector:getChildByPath(icon_head, "imgLock")
        icon_head:setTexture(v.headPortrait)
        icon_head:setSize(CCSizeMake(68,68))
        imgLock:setVisible(CoffeeDataMgr:isKanBanLock(v.id))
        imgSelect:setVisible(CoffeeDataMgr:getCurSelectId() == v.id)
        self.roleIconView:pushBackCustomItem(pannel_roleBtn)
        pannel_roleBtn:setTouchEnabled(true)
        pannel_roleBtn:onClick(function()
            if CoffeeDataMgr:getCurSelectId() == v.id then
                return
            end
            if not CoffeeDataMgr:isKanBanLock(v.id) then
                CoffeeDataMgr:send_MAID_ACTIVITY_REQ_CHANGE_ROLE_ID(v.id)
            else
                Utils:showTips(244274)
            end
        end)
    end
end

function CoffeeMainView:initTimer()
    if not self.logTimer then
        self.logTimer = TFDirector:addTimer(5000, -1, nil, handler(self.refreshNewLog, self))
    end

    if not self.roleTimer then
        self.roleTimer = TFDirector:addTimer(10000, -1, nil, handler(self.refreshRoleShow, self))
    end
end

function CoffeeMainView:refreshLive2d()
    
    local modelid = tonumber(CoffeeDataMgr:getKanBanConfig(CoffeeDataMgr:getCurSelectId()).level2D)
    if self.elvesRole then
        self.elvesRole:removeFromParent()
        self.elvesRole = nil
    end
    self.elvesRole = ElvesNpcTable:createLive2dNpcID(modelid,false,false,nil,false).live2d
    self.elvesRole:Scale(0.7)
    self.elvesRole:registerEvents()
    self.Panel_live2d:addChild(self.elvesRole)

    local disX = 100
    self.elvesRole:Pos(ccp(-disX,0))
    local action=  Spawn:create({
        FadeIn:create(0.8),
        MoveBy:create(0.3, ccp(disX, 0))
    })  
    self.elvesRole:stopAllActions()
    self.elvesRole:runAction(action)
    -- EventMgr:dispatchEvent(EV_HIDE_MAIN_LIVE2D)
end

function CoffeeMainView:updateCoffeeInfo()
    local extraCoffeeInfo = CoffeeDataMgr:getExtraMaidInfo()
    self.Label_turnover:setText(extraCoffeeInfo.totle)
    self.Label_visitor:setText(math.ceil(extraCoffeeInfo.customer / 10000))
    self.Label_consume:setText(math.ceil(extraCoffeeInfo.cost / 10000))
end

function CoffeeMainView:updateElf()
    local workingMaid = CoffeeDataMgr:getWorkingMaid()
    local extraCoffeeInfo = CoffeeDataMgr:getExtraMaidInfo()
    local rate = extraCoffeeInfo.attributes[1] / 10000
    if rate == 0 then
        rate = 1
    end
    for i, v in ipairs(self.Button_elf) do
        local maidId = workingMaid[i]
        local maidInfo = CoffeeDataMgr:getMaidInfo(maidId)
        local maidCfg = CoffeeDataMgr:getMaidCfg(maidId)
        v.Label_name:setTextById(maidCfg.name1)
        v.Image_head:setTexture(maidCfg.icon1)
        for j, Image_star in ipairs(v.Image_star) do
            Image_star:setVisible(j <= maidCfg.quality)
        end
        local strength = clamp(maidInfo.strength, 0, maidCfg.strength)
        local percnt = clamp(strength / maidCfg.strength * 100, 0, 100)
        v.LoadingBar_percent:setPercent(percnt)
        v.Label_percent:setTextById(800005, CoffeeDataMgr:converPower(strength), CoffeeDataMgr:converPower(maidCfg.strength))

        v.root:onClick(function()
                Utils:openView("coffee.CoffeeDetailsView", false, maidId)
        end)
        v.Image_elf_tip:setVisible(maidInfo.strength == 0)

        v.Label_rate:setTextById(13400257, self.spiritCost_ * rate * 60)
    end

    local fettersList = CoffeeDataMgr:getMaidFetters(workingMaid)
    local count = math.min(#self.Label_fetters, #self.Label_noFetters)
    for i = 1, count do
        local fettersCid = fettersList[i]
        if fettersCid then
            local maidBuffCfg = CoffeeDataMgr:getMaidBuffCfg(fettersCid)
            self.Label_fetters[i]:setTextById(maidBuffCfg.name)
        end
        self.Label_fetters[i]:setVisible(tobool(fettersCid))
        self.Label_noFetters[i]:setVisible(not tobool(fettersCid))
    end

    self.Image_fetters:onClick(function()
            Utils:openView("coffee.CoffeeFettersView", fettersList)
    end)
end

function CoffeeMainView:onCountDownPer()
    CoffeeDataMgr:send_MAID_ACTIVITY_REQ_GET_MAID_INFO(2)
end

function CoffeeMainView:removeEvents()
    self:removeCountDownTimer()
end

function CoffeeMainView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(10000, count, nil, handler(self.onCountDownPer, self))
    end
end

function CoffeeMainView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function CoffeeMainView:onShow()
    self.super.onShow(self)
    self:updateRedPointStatus()
end

function CoffeeMainView:registerEvents()
    EventMgr:addEventListener(self, EV_COFFEE_MAID_CHANGE, handler(self.onMaidChangeEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_MAID_FEED, handler(self.onMaidFeedEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_MAIDINFO_UPDATE, handler(self.onMaidInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_UPDATE_ROLE, handler(self.onMaidUpdateKanBanEvent, self))
    EventMgr:addEventListener(self, EV_COFFEE_ISLOCK_ROLE, handler(self.refreshRoleIcon, self))
    EventMgr:addEventListener(self, EV_COFFEE_UPDATE_LOG, handler(self.refreshNewLog, self))

    self.Button_achievement:onClick(function()
            Utils:openView("coffee.CoffeeTaskView")
    end)

    self.Button_recruit:onClick(function()
            Utils:openView("coffee.CoffeeRecruitView")
    end)

    self.Button_story:onClick(function()
            Utils:openView("coffee.CoffeeStoryView")
    end)

    self.Button_change:onClick(function()
            Utils:openView("coffee.CoffeeChangeView")
    end)

    self.Button_rank:onClick(function()
            FunctionDataMgr:jStore(303000)
    end)

    self.Button_alarm:onClick(function()
        self:popAction(self.Image_roleChooseBg)
        self.Image_alarm_tips:hide()
        -- self.Image_roleChooseBg:setVisible(not self.Image_roleChooseBg:isVisible())
    end)
end

function CoffeeMainView:onMaidChangeEvent()
    self:updateElf()
end

function CoffeeMainView:onMaidFeedEvent()
    self:updateElf()
end

function CoffeeMainView:onMaidInfoUpdateEvent(enterType)
    if enterType == 2 then
        self:updateCoffeeInfo()
        self:updateElf()
    end
end

function CoffeeMainView:onMaidUpdateKanBanEvent()
    self:refreshLive2d()
    self.Image_roleChooseBg:setVisible(false)
    self:refreshRoleIconView()
end

function CoffeeMainView:refreshRoleIcon()
    self.Image_alarm_tips:show()
    self.Image_roleChooseBg:setVisible(false)
    self:refreshRoleIconView()
end

function CoffeeMainView:refreshNewLog()
    local txt = CoffeeDataMgr:getNewLogStr()
    if nil == txt then
        return 
    end
    self.lab_logShow:setText(txt)
    self:popAction(self.Image_logShow)
end

function CoffeeMainView:popAction(obj, isOpen)
    local actionOpen = Sequence:create({
        CallFunc:create(function()
            obj:setScale(0.1)
            obj:setVisible(true)
        end),
        ScaleTo:create(0.3,1),
    })
    local actionClose = Sequence:create({
        ScaleTo:create(0.3,0),
        CallFunc:create(function()
            obj:setVisible(false)
        end)
    })

    local _isOpen 
    if nil == isOpen then
        _isOpen = not obj:isVisible()
    else
        _isOpen = isOpen
    end

    obj:stopAllActions()
    if _isOpen then
        obj:runAction(actionOpen)
    else
        obj:runAction(actionClose)
    end
end

function CoffeeMainView:refreshRoleShow()
    local curRoleCfg = CoffeeDataMgr:getKanBanConfig(CoffeeDataMgr:getCurSelectId())
    local totle = CoffeeDataMgr:getExtraMaidInfo().totle
    local partTurnover = {}
    local part = nil
    for i = 1, 3 do
        local tmp = {tag = i, value = curRoleCfg["turnover"..i]}
        table.insert(partTurnover,tmp)
    end
    table.sort(partTurnover, function(a, b)
        return a.value < b.value
    end)
    for i, v in ipairs(partTurnover) do
        if v.value < totle then
            part = v.tag
        end
    end
    if not part then
        return
    end

    local expression = curRoleCfg["expression"..part]
    local lines = curRoleCfg["lines"..part]
    local randIdx =  math.random(1, table.count(expression))
    if self.elvesRole then
        self.elvesRole:playNovoice()
        self.elvesRole:newStartAction(expression[randIdx], EC_PRIORITY.NORMAL)
    end
    self.lab_roleShow:setTextById(lines[randIdx])
    -- self.Image_roleBg:setVisible(not self.Image_roleBg:isVisible())
    self:popAction(self.Image_roleBg)

    if not self.roleLabTimer then
        self.roleLabTimer = TFDirector:addTimer(3000, 1, function()
            -- self.Image_roleBg:setVisible(false)
            if self.elvesRole then
                self.elvesRole:stopNovoice()
            end
            self:popAction(self.Image_roleBg, false)
            TFDirector:removeTimer(self.roleLabTimer)
            self.roleLabTimer = nil
        end)
    end
end

function CoffeeMainView:removeEvents()
    if self.logTimer then
        TFDirector:removeTimer(self.logTimer)
        self.logTimer = nil
    end
    if self.roleTimer then
        TFDirector:removeTimer(self.roleTimer)
        self.roleTimer = nil
    end
    if self.roleLabTimer then
        TFDirector:removeTimer(self.roleLabTimer)
        self.roleLabTimer = nil
    end
end

return CoffeeMainView
