
local FubenChapterView = class("FubenChapterView", BaseLayer)

function FubenChapterView:initData(fubenType, selectChapter, theaterId)
    self.cache_ = {}
    self.fubenItem_ = {}

    self.plotChapterItem_ = {}
    self.dailyChapterItem_ = {}
    self.activityChapterItem_ = {}
    self.holidayChapterItem_ = {}

    self.plotChapterState_ = {}
    self.dailyChapterState_ = {}
    self.activityChapterState_ = {}
    self.holidayChapterState_ = {}

    self.navigationItem_ = {}
    self.theaterChapters_ = TabDataMgr:getData("ExtraChapter")

    self.theaterSortList = TabDataMgr:getData("DiscreteData",46013).data.sort
    self.selectTheaterId = theaterId or TabDataMgr:getData("DiscreteData",46013).data.defaultSelect

    local plot = {
        type_ = EC_FBType.PLOT,
        icon = "ui/fuben/plot.png",
        name = 300614,
        selector = handler(self.showPlot, self),
        data = FubenDataMgr:getChapter(EC_FBType.PLOT),
        showTime = false,
    }
    local daily = {
        type_ = EC_FBType.DAILY,
        icon = "ui/fuben/daily.png",
        name = 300615,
        selector = handler(self.showDaily, self),
        data = FubenDataMgr:getChapter(EC_FBType.DAILY),
        showTime = false,
    }
    local activity = {
        type_ = EC_FBType.ACTIVITY,
        icon = "ui/fuben/special.png",
        name = 300616,
        selector = handler(self.showActivity, self),
        data = FubenDataMgr:getChapter(EC_FBType.ACTIVITY),
        showTime = false,
    }
    local holiday = {
        type_ = EC_FBType.HOLIDAY,
        icon = "ui/fuben/holiday.png",
        name = 300627,
        selector = handler(self.showHoliday, self),
        data = FubenDataMgr:getChapter(EC_FBType.HOLIDAY),
        showTime = false,
    }
    local theater = {
        type_ = EC_FBType.THEATER,
        icon = "ui/fuben/icon_juchang.png",
        name = 300964,
        selector = handler(self.flushTheater, self),
        data = FubenDataMgr:getChapter(EC_FBType.THEATER),
        showTime = false,
    }

    local linkage = {
        type_ = EC_FBType.LINKAGE,
        icon = "ui/fuben/linkage/004.png",
        name = 12030009,
        selector = handler(self.flushLinkage, self),
        data = FubenDataMgr:getChapter(EC_FBType.THEATER), --TODO 临时
        showTime = true,
    }

    local kspage = {
        type_ = EC_FBType.KSAN_FUBEN,
        icon = "ui/activity/kuangsan_fuben/entrance/008.png",
        name = 12032001,
        selector = handler(self.flushLinkage, self),
        data = FubenDataMgr:getChapter(EC_FBType.THEATER), --TODO 临时
        showTime = true,
    }

    self.fubenData_ = {plot, daily, activity, theater}

    -- 万圣节活动， 圣诞节
    local activityInfo = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
    local activityInfo1 = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS)
    local isShowTime = DlsDataMgr:isShowTime()
    if #activityInfo > 0 or #activityInfo1 > 0 or isShowTime then
        table.insert(self.fubenData_, holiday)
    end

    --联动数据
    local linkageChapterInfo = FubenDataMgr:getLinkageChapterInfo(3001)
    self.linkageData            = clone(TabDataMgr:getData("DiscreteData",90003).data[3001])
    self.linkageData.beginTime      = linkageChapterInfo.begin
    self.linkageData.endTime        = linkageChapterInfo["end"]
    dump(self.linkageData)
    self.linkageData.chapterCid = 3001
    local year, month, day = Utils:getDate(self.linkageData.endTime, true)
    self.linkageData.tips  = TextDataMgr:getText(12030003,month,day) 

    local serverTime = ServerDataMgr:getServerTime()
    if self.linkageData.endTime > ServerDataMgr:getServerTime() then
        table.insert(self.fubenData_, linkage)
    end

    ---狂三副本数据
    local activityIds = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.KUANGSAN_FUBEN)
    if activityIds and activityIds[1] then
        self.activityKsanInfo = ActivityDataMgr2:getActivityInfo(activityIds[1])
        if self.activityKsanInfo and serverTime >= self.activityKsanInfo.showStartTime and  serverTime < self.activityKsanInfo.showEndTime then
            table.insert(self.fubenData_, kspage)
        end
    end

    -- 获取副本类型缓存
    self.defaultSelectFubenIndex_ = 1
    local selectFubenType = FubenDataMgr:getCacheSelectFubenType()
    selectFubenType = fubenType or selectFubenType

    if selectFubenType == EC_FBType.THEATER_HARD or selectFubenType == EC_FBType.THEATER_BOSS then
        selectFubenType = EC_FBType.THEATER
    end

    if selectFubenType then
        for i, v in ipairs(self.fubenData_) do
            if v.type_ == selectFubenType then
                self.defaultSelectFubenIndex_ = i
                break
            end
        end
    end

    -- 获取副本章节缓存
    if not selectChapter then
        selectChapter = FubenDataMgr:getCacheSelectChapter()
    end
    if selectChapter then
        local fubenData = self.fubenData_[self.defaultSelectFubenIndex_]
        for i, v in ipairs(fubenData.data) do
            if selectChapter == v then
                self.defaultSelectChapterIndex_ = i
                break
            end
        end
    end

    -- 万由里数据更新
    TFDirector:send(c2s.ODEUM_OPEN_PANEL, {})

end

function FubenChapterView:getClosingStateParams()
    return {FubenDataMgr:getCacheSelectFubenType()}
end

function FubenChapterView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.fuben.fubenChapterView")
end

function FubenChapterView:initUI(ui)
    self.super.initUI(self, ui)
    self:addLockLayer()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_navigationItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_navigationItem")

    self.Panel_plotChapterItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_plotChapterItem")
    self.Panel_dailyChapterItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_dailyChapterItem")
    self.Panel_activityChapterItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_activityChapterItem")
    self.Panel_holidayChapterItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_holidayChapterItem")
    self.Panel_fubenItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fubenItem")
    self.Panel_fubenItem1 = TFDirector:getChildByPath(self.Panel_prefab, "Panel_fubenItem1")
    self.Image_pageControllerItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_pageControllerItem")
    self.Image_tipsItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_tipsItem")

    local ScrollView_fuben = TFDirector:getChildByPath(self.Panel_root, "ScrollView_fuben")
    self.ListView_fuben = UIListView:create(ScrollView_fuben)

    self.Panel_plot = TFDirector:getChildByPath(self.Panel_root, "Panel_plot")
    local ScrollView_plot_chapter = TFDirector:getChildByPath(self.Panel_plot, "ScrollView_plot_chapter")
    self.TurnView_plot_chapter = UITurnView:create(ScrollView_plot_chapter)
    self.TurnView_plot_chapter:setItemModel(self.Panel_plotChapterItem)
    self.Label_plot_tips = TFDirector:getChildByPath(self.Panel_plot, "Label_plot_tips")
    local ScrollView_plot_navigation = TFDirector:getChildByPath(self.Panel_plot, "ScrollView_plot_navigation"):hide()
    self.ListView_plot_navigation = UIListView:create(ScrollView_plot_navigation)
    self.Panel_plot_state = TFDirector:getChildByPath(self.Panel_plot, "Panel_plot_state")

    self.Panel_daily = TFDirector:getChildByPath(self.Panel_root, "Panel_daily")
    local ScrollView_daily_chapter = TFDirector:getChildByPath(self.Panel_daily, "ScrollView_daily_chapter")
    self.TurnView_daily_chapter = UITurnView:create(ScrollView_daily_chapter)
    self.TurnView_daily_chapter:setItemModel(self.Panel_dailyChapterItem)
    self.Label_daily_tips = TFDirector:getChildByPath(self.Panel_daily, "Label_daily_tips")
    local ScrollView_daily_navigation = TFDirector:getChildByPath(self.Panel_daily, "ScrollView_daily_navigation"):hide()
    self.ListView_daily_navigation = UIListView:create(ScrollView_daily_navigation)
    self.Panel_daily_state = TFDirector:getChildByPath(self.Panel_daily, "Panel_daily_state")
    self.Button_openRule = TFDirector:getChildByPath(self.Panel_root, "Button_openRule")
    
    self.Panel_activity = TFDirector:getChildByPath(self.Panel_root, "Panel_activity")
    local ScrollView_activity_chapter = TFDirector:getChildByPath(self.Panel_activity, "ScrollView_activity_chapter")
    self.TurnView_activity_chapter = UITurnView:create(ScrollView_activity_chapter)
    self.TurnView_activity_chapter:setItemModel(self.Panel_activityChapterItem)
    self.Label_activity_tips = TFDirector:getChildByPath(self.Panel_activity, "Label_activity_tips")
    local ScrollView_activity_navigation = TFDirector:getChildByPath(self.Panel_activity, "ScrollView_activity_navigation"):hide()
    self.ListView_activity_navigation = UIListView:create(ScrollView_activity_navigation)
    self.Panel_activity_state = TFDirector:getChildByPath(self.Panel_activity, "Panel_activity_state")
   

    self.Panel_holiday = TFDirector:getChildByPath(self.Panel_root, "Panel_holiday")
    local ScrollView_holiday_chapter = TFDirector:getChildByPath(self.Panel_holiday, "ScrollView_holiday_chapter")
    self.TurnView_holiday_chapter = UITurnView:create(ScrollView_holiday_chapter)
    self.TurnView_holiday_chapter:setItemModel(self.Panel_holidayChapterItem)
    self.Label_holiday_tips = TFDirector:getChildByPath(self.Panel_holiday, "Label_holiday_tips")
    local ScrollView_holiday_navigation = TFDirector:getChildByPath(self.Panel_holiday, "ScrollView_holiday_navigation"):hide()
    self.ListView_holiday_navigation = UIListView:create(ScrollView_holiday_navigation)
    self.Panel_holiday_state = TFDirector:getChildByPath(self.Panel_holiday, "Panel_holiday_state")

    -----联动

    self.Panel_linkage = TFDirector:getChildByPath(self.Panel_root, "Panel_linkage")
    self.Panel_linkage.Label_time_value = TFDirector:getChildByPath(self.Panel_linkage, "Label_time_value")
    self.Panel_linkage.Label_time       = TFDirector:getChildByPath(self.Panel_linkage, "Label_time")

    self.Panel_linkage.Panel_time       = TFDirector:getChildByPath(self.Panel_linkage, "Panel_time")
    self.Panel_linkage.Label_sy         = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_sy"):hide()
    self.Panel_linkage.Image_sy1         = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Image_sy1"):hide()
    self.Panel_linkage.Image_sy2         = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Image_sy2"):hide()
    self.Panel_linkage.Image_sy3         = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Image_sy3"):hide()
    self.Panel_linkage.Label_tian       = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_tian")
    self.Panel_linkage.Label_shi        = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_shi")
    self.Panel_linkage.Label_tian_value = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_tian_value")
    self.Panel_linkage.Label_shi_value  = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_shi_value")
    self.Panel_linkage.Label_ms         = TFDirector:getChildByPath(self.Panel_linkage.Panel_time, "Label_ms")

    self.Panel_linkage.Label_start      = TFDirector:getChildByPath(self.Panel_linkage, "Label_start")
    self.Panel_linkage.Button_start     = TFDirector:getChildByPath(self.Panel_linkage, "Button_start")
    self.Panel_linkage.Label_progress_1 = TFDirector:getChildByPath(self.Panel_linkage, "Label_progress_1")
    self.Panel_linkage.Label_progress_2 = TFDirector:getChildByPath(self.Panel_linkage, "Label_progress_2")
    ---

    ----狂三副本
    self.Panel_kuangsan = TFDirector:getChildByPath(self.Panel_root, "Panel_kuangsan")
    self.Panel_kuangsan.Label_time_value = TFDirector:getChildByPath(self.Panel_kuangsan, "Label_time_value")
    self.Panel_kuangsan.Label_time_value:setSkewX(15)
    self.Panel_kuangsan.Label_time       = TFDirector:getChildByPath(self.Panel_kuangsan, "Label_time")
    self.Panel_kuangsan.Label_time:setSkewX(15)

    self.Panel_kuangsan.Panel_time       = TFDirector:getChildByPath(self.Panel_kuangsan, "Panel_time")
    self.Panel_kuangsan.Label_sy         = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_sy")
    self.Panel_kuangsan.Label_sy:setSkewX(15)
    self.Panel_kuangsan.Label_tian       = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_tian")
    self.Panel_kuangsan.Label_tian:setSkewX(15)
    self.Panel_kuangsan.Label_shi        = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_shi")
    self.Panel_kuangsan.Label_shi:setSkewX(15)
    self.Panel_kuangsan.Label_tian_value = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_tian_value")
    self.Panel_kuangsan.Label_tian_value:setSkewX(15)
    self.Panel_kuangsan.Label_shi_value  = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_shi_value")
    self.Panel_kuangsan.Label_shi_value:setSkewX(15)
    self.Panel_kuangsan.Label_ms         = TFDirector:getChildByPath(self.Panel_kuangsan.Panel_time, "Label_ms")
    self.Panel_kuangsan.Label_ms:setSkewX(15)

    self.Panel_kuangsan.Label_start      = TFDirector:getChildByPath(self.Panel_kuangsan, "Label_start")
    self.Panel_kuangsan.Label_start:setSkewX(15)
    self.Panel_kuangsan.Button_start     = TFDirector:getChildByPath(self.Panel_kuangsan, "Button_start")

    ----

    self.Panel_theater = TFDirector:getChildByPath(self.Panel_root, "Panel_theater")
    self.Button_theater_goto = TFDirector:getChildByPath(self.Panel_theater, "Button_theater_goto")
    self.Label_theater_goto = TFDirector:getChildByPath(self.Button_theater_goto, "Label_theater_goto")
    self.thearter_spine_role = TFDirector:getChildByPath(self.Panel_theater, "spine_role")
    self.Label_theater_goto:setTextById(300966)

    local function initTheaterInfo()
        self.Image_theater_info = TFDirector:getChildByPath(self.Panel_theater, "Image_theater_info")
        self.Label_theater_name = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_name")
        self.Label_theater_name:setTextById(300968)
        self.Image_theater_progress = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_progress")
        self.LoadingBar_lingbo = TFDirector:getChildByPath(self.Image_theater_progress, "LoadingBar_lingbo")
        self.Image_percent_tag = {}
        for i = 1, 3 do
            self.Image_percent_tag[i] = TFDirector:getChildByPath(self.LoadingBar_lingbo, "Image_percent_tag_" .. i)
        end
        -- self.Label_theater_limit = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_limit")
        -- self.Label_theater_percent = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_percent")
        self.Label_theater_tips_1 = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_tips_1")
        self.Label_theater_tips_2 = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_tips_2")
        self.Label_theater_noOpen = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_noOpen")
        self.Label_theater_noOpen:setTextById(300970)
        self.Button_theater_challenge = TFDirector:getChildByPath(self.Image_theater_info, "Button_theater_challenge")
        self.Label_theater_challenge = TFDirector:getChildByPath(self.Button_theater_challenge, "Label_theater_challenge")
        self.Image_theater_icon = {}
        for i = 1, 3 do
            self.Image_theater_icon[i] = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_icon_" .. i):hide()
        end
        self.Image_theater_icon_boss = TFDirector:getChildByPath(self.Image_theater_info, "Image_theater_icon_boss"):hide()
    end
    initTheaterInfo()

    local function initTheaterInfo1()
        self.Image_theater_info1 = TFDirector:getChildByPath(self.Panel_theater, "Image_theater_info1")
       
        -- self.Label_theater_limit = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_limit")
        -- self.Label_theater_percent = TFDirector:getChildByPath(self.Image_theater_info, "Label_theater_percent")
        self.Label_theater_tips_type1 = TFDirector:getChildByPath(self.Image_theater_info1, "Label_theater_tips_1")
        self.Image_theater_icon_type1 = TFDirector:getChildByPath(self.Image_theater_info1, "Image_theater_icon_1")
    end

    initTheaterInfo1()

    local function initTheaterChapterScroll()
        local scroll_theaterList = TFDirector:getChildByPath(self.Panel_theater,"scroll_theaterList")
        self.panel_ItemInfo = TFDirector:getChildByPath(self.Panel_theater,"panel_ItemInfo")
        self.ListView_theaterList = UIListView:create(scroll_theaterList)
        self:flushTheater()
        local node = self.panel_ItemInfo:clone()
        TFDirector:getChildByPath(node,"Panel_item"):hide()
        TFDirector:getChildByPath(node,"Panel_itemS"):hide()
        local showNode = TFDirector:getChildByPath(node,"Panel_itemLast"):show()
        node:setContentSize(showNode:getContentSize())
        self.ListView_theaterList:pushBackCustomItem(node)
    end

    initTheaterChapterScroll()

    self.Image_turnview_mask_left = TFDirector:getChildByPath(self.Panel_root, "Image_turnview_mask_left")
    self.Image_turnview_mask_right = TFDirector:getChildByPath(self.Panel_root, "Image_turnview_mask_right")

    self.Image_bg2 = TFDirector:getChildByPath(self.Panel_root, "Image_bg2")
    self.Image_bg3 = TFDirector:getChildByPath(self.Panel_root, "Image_bg3")
    self.Image_bg4 = TFDirector:getChildByPath(self.Panel_root, "Image_bg4")

    ViewAnimationHelper.doMoveFadeInAction(self.Image_bg2, {direction = 4, distance = 40, time = 0.5, delay = 0.1, ease = 2})
    ViewAnimationHelper.doMoveFadeInAction(self.Image_bg3, {direction = 3, distance = 30, time = 0.5, delay = 0.1, ease = 2})
    self.Image_bg4:setScaleX(0.5)
    self.Image_bg4:setOpacity(0)
    self.Image_bg4:runAction(CCSequence:create({CCDelayTime:create(0.05), CCSpawn:create({CCFadeIn:create(0.3), CCScaleTo:create(0.3, 1.0)})}))

    self:refreshView()
end


function FubenChapterView:refreshLinkage()
    local serverTime = ServerDataMgr:getServerTime()
    local sTime      = self.linkageData.beginTime  - serverTime
    local eTime      = self.linkageData.endTime    - serverTime
    self.Panel_linkage.Panel_time:setVisible(true)
    if sTime > 0 then 
        local day, hour, min, sec = Utils:getTimeDHMZ(sTime,true)
        self.Panel_linkage.Image_sy1:setVisible(false)
        self.Panel_linkage.Image_sy2:setVisible(false)
        self.Panel_linkage.Image_sy3:setVisible(true)
        self.Panel_linkage.Label_tian_value:setText(tostring(day))      
        self.Panel_linkage.Label_shi_value:setText(tostring(hour))          
        self.Panel_linkage.Label_ms:setText(min..":"..sec) 
    elseif eTime > 0 then 
        local day, hour, min, sec = Utils:getTimeDHMZ(eTime,true)
        self.Panel_linkage.Image_sy1:setVisible(true)
        self.Panel_linkage.Image_sy2:setVisible(false)
        self.Panel_linkage.Image_sy3:setVisible(false)
        self.Panel_linkage.Label_tian_value:setText(tostring(day))      
        self.Panel_linkage.Label_shi_value:setText(tostring(hour))          
        self.Panel_linkage.Label_ms:setText(min..":"..sec) 
    -- elseif eTime2 > 0 then
    --     -- dump({day, hour, min, sec })
    --     local day, hour, min, sec = Utils:getTimeDHMZ(eTime2,true)
    --     self.Panel_linkage.Image_sy1:setVisible(false)
    --     self.Panel_linkage.Image_sy2:setVisible(true)
    --     self.Panel_linkage.Image_sy3:setVisible(false)
    --     self.Panel_linkage.Label_tian_value:setText(tostring(day))      
    --     self.Panel_linkage.Label_shi_value:setText(tostring(hour))          
    --     self.Panel_linkage.Label_ms:setText(min..":"..sec) 
    else
        self.Panel_linkage.Panel_time:setVisible(false) 
    end
    self.Panel_linkage.Label_time_value:setTextById(self.linkageData.durationText)
    local visible = eTime > 0 and sTime < 0

    self.Panel_linkage.Button_start:setTouchEnabled(visible)
    self.Panel_linkage.Button_start:setGrayEnabled(not visible)
    --刷新关卡进度
    local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(self.linkageData.chapterCid, EC_FBDiff.SIMPLE)
    local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(self.linkageData.chapterCid, EC_FBDiff.SIMPLE) 
    self.Panel_linkage.Label_progress_1:setText(TextDataMgr:getText(300614)..string.format("%s/%s",fightStarNum,totalFightStarNum))
    totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(self.linkageData.chapterCid, EC_FBDiff.HARD)
    fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(self.linkageData.chapterCid, EC_FBDiff.HARD) 
    self.Panel_linkage.Label_progress_2:setText(TextDataMgr:getText(300121)..string.format("%s/%s",fightStarNum,totalFightStarNum))
end

function FubenChapterView:refreshKsanPage()

    if not self.activityKsanInfo then
        return
    end
    local serverTime = ServerDataMgr:getServerTime()
    local eTime      = self.activityKsanInfo.extendData.activityduration.battleendtime - serverTime
    self.Panel_kuangsan.Panel_time:setVisible(true)

    if eTime > 0 then
        local day, hour, min, sec = Utils:getTimeDHMZ(eTime,true)
        self.Panel_kuangsan.Label_tian_value:setText(tostring(day))
        self.Panel_kuangsan.Label_shi_value:setText(tostring(hour))
        self.Panel_kuangsan.Label_ms:setText(min..":"..sec)
    else
        self.Panel_kuangsan.Panel_time:setVisible(false)
    end

    local sTime      = self.activityKsanInfo.showStartTime  - serverTime
    local showEndTime = self.activityKsanInfo.showEndTime - serverTime
    local visible = showEndTime > 0 and sTime < 0
    self.Panel_kuangsan.Button_start:setTouchEnabled(visible)
    self.Panel_kuangsan.Button_start:setGrayEnabled(not visible)

    local startDate = Utils:getUTCDate(self.activityKsanInfo.showStartTime , GV_UTC_TIME_ZONE)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getUTCDate(self.activityKsanInfo.showEndTime ,GV_UTC_TIME_ZONE)
    local endDateStr = endDate:fmt("%m.%d")
    self.Panel_kuangsan.Label_time_value:setText(startDateStr.."-"..endDateStr..GV_UTC_TIME_STRING)

end

function FubenChapterView:flushTheater(  )
    self:flushTheaterList()
    local theaterCfg = self.theaterChapters_[self.selectTheaterId]
    local new_spine_role = SkeletonAnimation:create(theaterCfg.spineView)
    new_spine_role:setScale(self.thearter_spine_role:getScale())
    new_spine_role:setPosition(self.thearter_spine_role:getPosition())
    new_spine_role:setZOrder(self.thearter_spine_role:getZOrder())
    self.thearter_spine_role:getParent():addChild(new_spine_role)
    self.thearter_spine_role:removeFromParent(true)
    self.thearter_spine_role = new_spine_role
    self.thearter_spine_role:playByIndex(0,-1,-1,1)
    if theaterCfg.titlePlaneType == 2 then
        self:showTheater()
        self.Image_theater_info:show()
        self.Image_theater_info1:hide()
    elseif theaterCfg.titlePlaneType == 1 then
        self.Image_theater_info1:show()
        self.Image_theater_info:hide()
        self:flushTheaterInfo(theaterCfg)
    end
end

function FubenChapterView:flushTheaterInfo( v )
    self.Label_theater_tips_type1:setTextById(v.titlePlaneParm.des)
    self.Image_theater_icon_type1:setTexture(v.titlePlaneParm.path)
end

function FubenChapterView:flushTheaterList( )
    self.theaterItem = self.theaterItem or {}
    local index = 1
    for index = 1,#self.theaterSortList do
        if not self.theaterItem[index] then
            self:addTheaterItem(index, self.theaterChapters_[self.theaterSortList[index]])
        end
        self:updateTheater(index)
    end
end

function FubenChapterView:addTheaterItem( idx, theaterCfg )
    local item = self.panel_ItemInfo:clone()
    local foo = {}
    foo.root = item
    foo.normalItem = TFDirector:getChildByPath(item,"Panel_item")
    foo.selectedItem = TFDirector:getChildByPath(item,"Panel_itemS")
    TFDirector:getChildByPath(item,"Panel_itemLast"):hide()
    foo.data = theaterCfg
    self.theaterItem = self.theaterItem or {}
    self.theaterItem[idx] = foo
    self.ListView_theaterList:pushBackCustomItem(item)
    return foo.root
end

function FubenChapterView:updateTheater(idx)
    local foo = self.theaterItem[idx]
    local parent = foo.normalItem
    foo.normalItem:hide()
    foo.selectedItem:hide()
    local theaterCfg = foo.data
    if theaterCfg.id == self.selectTheaterId then
        parent = foo.selectedItem
    end
    parent:show()
    foo.root:setContentSize(parent:getContentSize())
    if not parent.clip then
        local Image_buildIcon = TFDirector:getChildByPath(parent,"Image_buildIcon")
        local Image_zd = TFDirector:getChildByPath(parent,"Image_zd")
        Image_zd:retain()
        Image_zd:removeFromParent()
        local clip = CCClippingNode:create()
        -- clip:setInverted(true)
        clip:Pos(Image_buildIcon:Pos())
        clip:AnchorPoint(Image_buildIcon:AnchorPoint())
        clip:setAlphaThreshold(0.5)
        Image_buildIcon:getParent():Add(clip,1)
        local icon = Image_buildIcon:clone()
        clip:Add(icon)
        clip:setStencil(Image_zd)
        Image_zd:release()
        parent.clip = clip
        parent.content = icon
        Image_buildIcon:removeFromParent()
    end

    local content = parent.content

    content:setTexture(theaterCfg.chrView)
    local image_name = TFDirector:getChildByPath(content,"image_name")
    if image_name then 
        image_name:setTexture(theaterCfg.titleView)
    end
    parent:setTouchEnabled(true)
    parent:onClick(function ( ... )
        self.selectTheaterId = theaterCfg.id
        self:flushTheater()
        self.ListView_theaterList:remedyItem()
        self.ListView_theaterList:scrollToItem(idx,0.5)
    end)
end


function FubenChapterView:showFubenList()
    for i, v in ipairs(self.fubenData_) do
        self:addFubenItem(v)
        self:updateFubenItem(i)
    end
    self:selectFuben(self.defaultSelectFubenIndex_)
end

function FubenChapterView:addFubenItem(data)
    local fubenItem = data.showTime and self.Panel_fubenItem1 or self.Panel_fubenItem
    local Panel_fubenItem = fubenItem:clone()
    local foo = {}
    foo.root = Panel_fubenItem
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Label_name = TFDirector:getChildByPath(foo.root, "Label_name")
    foo.Label_tip = TFDirector:getChildByPath(foo.root, "Label_tip")
    self.fubenItem_[foo.root] = foo
    self.ListView_fuben:pushBackCustomItem(foo.root)
    return foo.root
end

function FubenChapterView:updateFubenItem(index)
    local fubenData = self.fubenData_[index]
    local item = self.ListView_fuben:getItem(index)
    local foo = self.fubenItem_[item]

    foo.Image_icon:setTexture(fubenData.icon)
    foo.Label_name:setTextById(fubenData.name)
    if fubenData.type_ == EC_FBType.LINKAGE then 
        foo.Label_tip:setText(self.linkageData.tips)
    elseif fubenData.type_ == EC_FBType.KSAN_FUBEN then
        if self.activityKsanInfo then
            local dateTime = Utils:getUTCDate(self.activityKsanInfo.showEndTime, GV_UTC_TIME_ZONE)
            local timeStr  = TextDataMgr:getText(12030003,dateTime:fmt("%m"),dateTime:fmt("%d"))
            foo.Label_tip:setText(timeStr)
        end
    end
    foo.root:onClick(function()
        self:selectFuben(index)
    end)
end

function FubenChapterView:selectFuben(index)
    if self.selectFubenIndex_ == index then return end
    self.selectFubenIndex_ = index
    local fubenData = self.fubenData_[index]
    local type_ = fubenData.type_

    for i, v in ipairs(self.ListView_fuben:getItems()) do
        local _fubenData = self.fubenData_[i]
        local foo = self.fubenItem_[v]
        foo.Image_select:setVisible(index == i)
        foo.Label_tip:setVisible(index ~= i and _fubenData.showTime == true)
    end

    self.Panel_plot:setVisible(type_ == EC_FBType.PLOT)
    self.Panel_daily:setVisible(type_ == EC_FBType.DAILY)
    self.Panel_activity:setVisible(type_ == EC_FBType.ACTIVITY)
    self.Panel_holiday:setVisible(type_ == EC_FBType.HOLIDAY)
    self.Panel_theater:setVisible(type_ == EC_FBType.THEATER)
    self.Panel_linkage:setVisible(type_ == EC_FBType.LINKAGE)
    self.Panel_kuangsan:setVisible(type_ == EC_FBType.KSAN_FUBEN)
    if type_ == EC_FBType.LINKAGE then
        self:refreshLinkage()
    elseif type_ == EC_FBType.KSAN_FUBEN then
        self:refreshKsanPage()
    end

    local showMask = type_ ~= EC_FBType.THEATER and type_ ~= EC_FBType.LINKAGE and type_ ~= EC_FBType.KSAN_FUBEN
    self.Image_turnview_mask_left:setVisible(showMask)
    self.Image_turnview_mask_right:setVisible(showMask)
    self.Button_openRule:setVisible(self.Panel_daily:isVisible())
    fubenData.selector(index)
    self.cache_[index] = true
end

function FubenChapterView:addPlotChapterItem()
    local item = self.TurnView_plot_chapter:pushBackItem()
    local foo = {}
    foo.root = item
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Panel_select = TFDirector:getChildByPath(foo.root, "Panel_select")
    foo.Image_effect = TFDirector:getChildByPath(foo.Panel_select, "Image_effect")
    foo.Label_select_name = TFDirector:getChildByPath(foo.Panel_select, "Label_select_name")
    foo.Panel_stars = TFDirector:getChildByPath(foo.Panel_select, "Panel_stars")
    foo.Panel_stars_s = foo.Panel_stars:getChildByName("Panel_dl_s")
    foo.Panel_stars_h = foo.Panel_stars:getChildByName("Panel_dl_h")
    foo.Panel_stars_l = foo.Panel_stars:getChildByName("Panel_dl_l")
    foo.Panel_stars_s:getChildByName("Label_dl"):setSkewX(15)
    foo.Panel_stars_h:getChildByName("Label_dl"):setSkewX(15)
    foo.Panel_stars_l:getChildByName("Label_dl"):setSkewX(15)
    foo.Panel_unselect = TFDirector:getChildByPath(foo.root, "Panel_unselect")
    foo.Label_unselect_name = TFDirector:getChildByPath(foo.Panel_unselect, "Label_unselect_name")
    foo.Label_order_name = TFDirector:getChildByPath(foo.Panel_unselect, "Label_order_name")
    foo.Image_state = TFDirector:getChildByPath(foo.root, "Image_state")
    foo.Label_state = TFDirector:getChildByPath(foo.Image_state, "Label_state")
    foo.Image_tips = self.Image_tipsItem:clone():hide()
    foo.Label_tips = TFDirector:getChildByPath(foo.Image_tips, "Label_tips")
    foo.Image_tips:AddTo(self.Panel_plot_state):Pos(0, 0)

    self.plotChapterItem_[foo.root] = foo
    return foo.root
end

function FubenChapterView:updatePlotChapterItem(index, subIndex)
    local fubenData = self.fubenData_[index]
    local chapterCid = fubenData.data[subIndex]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)

    local item = self.TurnView_plot_chapter:getItem(subIndex)
    local foo = self.plotChapterItem_[item]

    local fullName = FubenDataMgr:getChapterFullName(chapterCid)
    local orderName = FubenDataMgr:getChapterOrderName(chapterCid)
    local name = TextDataMgr:getText(chapterCfg.name)
    local enName = TextDataMgr:getText(chapterCfg.nameEn)
    foo.Label_select_name:setText(fullName)
    foo.Label_unselect_name:setText(TextDataMgr:getText(300231, name,enName))
    foo.Label_order_name:setText(orderName)
    foo.Image_icon:setTexture(chapterCfg.pictureIcon)

    local playerLevel = MainPlayer:getPlayerLv()
    local firstLevelCid = FubenDataMgr:getChapterFirstLevel(chapterCid, EC_FBDiff.SIMPLE)
    local firstLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCid)
    local enabled, preIsOpen, levelIsOpen = FubenDataMgr:checkPlotLevelEnabled(firstLevelCid)
    foo.Image_state:setVisible(not enabled)
    foo.Panel_stars:setVisible(enabled)
    if enabled then
        local diffcfg = {["s"] = EC_FBDiff.SIMPLE,["h"] = EC_FBDiff.HARD,["l"] = EC_FBDiff.LIMBO}
        for k,v in pairs(diffcfg) do
            local totalFightStarNum, totalDatingStarNum = FubenDataMgr:getChapterTotalStarNum(chapterCid, v)
            local fightStarNum, datingStarNum = FubenDataMgr:getChapterStarNum(chapterCid, v)
            foo["Panel_stars_"..k]:getChildByName("Label_stars"):setText(string.format("%d/%d",fightStarNum,totalFightStarNum))
        end
    else
        if not levelIsOpen then
            foo.Label_state:setTextById(800003, firstLevelCfg.playerLv)
        else
            local firstLevelCfg = FubenDataMgr:getLevelCfg(firstLevelCid)
            local count = #firstLevelCfg.preLevelId
            local levelName = FubenDataMgr:getLevelName(firstLevelCfg.preLevelId[1])
            foo.Label_state:setTextById(300963, levelName)
        end
    end

    foo.root:onClick(function()
            local selectIndex = self.TurnView_plot_chapter:getSelectIndex()
            if subIndex == selectIndex then
                if enabled then
                    local function toOpenLevelView()
                        FubenDataMgr:cacheSelectFubenType(fubenData.type_)
                        FubenDataMgr:cacheSelectChapter(chapterCid)
                        Utils:openView("fuben.FubenLevelView", chapterCid)
                        GameGuide:checkGuideEnd(self.guideFuncId)
                    end
                    local checkExtId = TFAssetsManager:getCheckInfo(1,selectIndex)
                    if checkExtId then
                        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                            toOpenLevelView()
                        end,true)
                        return
                    else
                        TFAssetsManager:downloadHeroAssets(function()
                            toOpenLevelView()
                        end,true)
                    end
                end
            else
                self.TurnView_plot_chapter:scrollToItem(subIndex)
                ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.15, ease = 1})
                ViewAnimationHelper.doMoveFadeInAction(self.Label_plot_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.15, ease = 1})
                if enabled then
                    local diffcfg = {"s","h","l"}
                    for i,v in ipairs(diffcfg) do
                        ViewAnimationHelper.doMoveFadeInAction(foo["Panel_stars_"..v], {direction = 2, distance = 30, time = 0.2, delay = 0.15, ease = 1})
                    end
                end
            end
    end)

    self.plotChapterState_[subIndex] = foo.Image_state:isVisible()
end

function FubenChapterView:addNavigationItem()
    local Panel_navigationItem = self.Panel_navigationItem:clone()
    local item = {}
    item.root = Panel_navigationItem
    item.Image_normal = TFDirector:getChildByPath(item.root, "Image_normal")
    item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
    self.navigationItem_[item.root] = item
    return item.root
end

function FubenChapterView:showPlot(index)
    local fubenData = self.fubenData_[index]
    for i, v in ipairs(fubenData.data) do
        if not self.cache_[index] then
            self:addPlotChapterItem()

            local item = self:addNavigationItem()
            item:onClick(function()
                self.TurnView_plot_chapter:scrollToItem(i)
            end)
            self.ListView_plot_navigation:pushBackCustomItem(item)
        end
        self:updatePlotChapterItem(index, i)

    end
    Utils:setAliginCenterByListView(self.ListView_plot_navigation, true)

    local selectIndex
    if self.defaultSelectChapterIndex_ then
        selectIndex = self.defaultSelectChapterIndex_
        self.TurnView_plot_chapter:scrollToItem(self.defaultSelectChapterIndex_)
        self.defaultSelectChapterIndex_ = nil
    else
        self.TurnView_plot_chapter:scrollToItem(self.TurnView_plot_chapter:getSelectIndex())
        selectIndex = self.TurnView_plot_chapter:getSelectIndex()
    end
    local items = self.TurnView_plot_chapter:getItem()
    if selectIndex and selectIndex == 1 then
        for i, v in ipairs( items) do
            v:setVisible(false)
        end
        self:timeOut(function()
            for i, v in ipairs( items) do
                v:setVisible(true)
                v:setOpacity(0)
                if i == 1 then
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 3, distance = 40, delay = 0, time = 0.2, callback = callBack})
                else
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 1, distance = 30, delay = 0.2 + (i - 1) * 0.05, time = 0.1, callback = callBack})
                end
            end
        end, 0.15)
    end
    for i, v in ipairs(items) do
        if i == selectIndex then
            local foo = self.plotChapterItem_[v]
            ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.25, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Label_plot_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.25, ease = 1})
            local diffcfg = {"s","h","l"}
            for i,v in ipairs(diffcfg) do
                ViewAnimationHelper.doMoveFadeInAction(foo["Panel_stars_"..v], {direction = 2, distance = 30, time = 0.2, delay = 0.25, ease = 1})
            end
        end
    end
end

function FubenChapterView:addDailyChapterItem()
    local item = self.TurnView_daily_chapter:pushBackItem()
    local foo = {}
    foo.root = item
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Panel_select = TFDirector:getChildByPath(foo.root, "Panel_select")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_effect = TFDirector:getChildByPath(foo.Panel_select, "Image_effect")
    foo.Label_select_name = TFDirector:getChildByPath(foo.Panel_select, "Label_select_name")
    foo.Panel_unselect = TFDirector:getChildByPath(foo.root, "Panel_unselect")
    foo.Label_unselect_name = TFDirector:getChildByPath(foo.Panel_unselect, "Label_unselect_name")
    foo.Image_timing = TFDirector:getChildByPath(foo.root, "Image_timing")
    foo.Panel_timing = TFDirector:getChildByPath(foo.root, "Panel_timing")
    foo.Label_timing = TFDirector:getChildByPath(foo.Panel_timing, "Label_timing")
    foo.Image_tips = self.Image_tipsItem:clone():hide()
    foo.Label_tips = TFDirector:getChildByPath(foo.Image_tips, "Label_tips")
    foo.Image_tips:AddTo(self.Panel_daily_state):Pos(0, 0)
    foo.Image_state = TFDirector:getChildByPath(foo.root, "Image_state")
    foo.Label_state = TFDirector:getChildByPath(foo.Image_state, "Label_state")
    self.dailyChapterItem_[foo.root] = foo
    return foo.root
end

function FubenChapterView:updateDailyChapterItem(index, subIndex)
    local fubenData = self.fubenData_[index]
    local levelGroupCid = fubenData.data[subIndex]
    local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelGroupCid)

    local item = self.TurnView_daily_chapter:getItem(subIndex)
    local foo = self.dailyChapterItem_[item]

    foo.Label_select_name:setTextById(levelGroupCfg.name)
    foo.Label_unselect_name:setTextById(levelGroupCfg.name)
    foo.Image_icon:setTexture(levelGroupCfg.pictureIcon)

    local enabled = MainPlayer:getPlayerLv() >= levelGroupCfg.unlockLevel
    foo.Image_state:setVisible(not enabled)
    foo.Label_state:setTextById(800003, levelGroupCfg.unlockLevel)
    foo.Panel_timing:setVisible(enabled)

    foo.root:onClick(function()
            if DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.DAILY,levelGroupCid) then
                return
            end
            local selectIndex = self.TurnView_daily_chapter:getSelectIndex()
            if subIndex == selectIndex then
                if enabled and FubenDataMgr:getDailyIsOpen(levelGroupCid) then
                    local function toOpenDailyLevelView()
                        FubenDataMgr:cacheSelectFubenType(fubenData.type_)
                        FubenDataMgr:cacheSelectChapter(levelGroupCid)
                        FubenDataMgr:cacheSelectLevelGroup(levelGroupCid)
                        Utils:openView("fuben.FubenDailyView", levelGroupCid)
                    end
                    local fubenData = self.fubenData_[self.selectFubenIndex_]
                    local checkExtId = TFAssetsManager:getCheckInfo(2,fubenData.type_)
                    if checkExtId then
                        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                                                                 toOpenDailyLevelView()
                                                                        end,true)
                        return
                    else
                        TFAssetsManager:downloadHeroAssets(function()
                                toOpenDailyLevelView()
                                                           end,true)
                    end
                end
            else
                self.TurnView_daily_chapter:scrollToItem(subIndex)
                ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.15, ease = 1})
                ViewAnimationHelper.doMoveFadeInAction(self.Label_daily_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.15, ease = 1})
                foo.Image_tips:setScaleX(0.5)
                foo.Image_tips:setOpacity(0)
                foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.15), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
            end
    end)

    if enabled then
        self:updateDailyTiming(subIndex, levelGroupCid)
    end

    if self.dailyChapterState_[subIndex] == nil then
        self.dailyChapterState_[subIndex] = foo.Panel_timing:isVisible()
    end
end

function FubenChapterView:updateDailyTiming(index, levelGroupCid)
    local isOpen = FubenDataMgr:getDailyIsOpen(levelGroupCid)
    local item = self.TurnView_daily_chapter:getItem(index)
    local foo = self.dailyChapterItem_[item]
    if isOpen then
        local timestamp = FubenDataMgr:getDailyExpirationTime(levelGroupCid)
        local remainTime = math.max(0, timestamp)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day ~= "00" then
            foo.Label_timing:setTextById("r80002", day, hour)
            foo.Label_tips:setTextById("r80011", day, hour)
        else
            foo.Label_timing:setTextById("r80001", hour, min)
            foo.Label_tips:setTextById("r80010", hour, min)
        end
    else
        local timestamp = FubenDataMgr:getDailyOpenTime(levelGroupCid)
        local remainTime = math.max(0, timestamp)
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if day ~= "00" then
            foo.Label_timing:setTextById("r80004", day, hour)
            foo.Label_tips:setTextById("r80013", day, hour)
        else
            foo.Label_timing:setTextById("r80003", hour, min)
            foo.Label_tips:setTextById("r80012", hour, min)
        end
        foo.Image_state:show()
        foo.Label_state:setTextById(1890001)
    end
end

function FubenChapterView:updateActivityTiming(index, chapterCid)
    local item = self.TurnView_activity_chapter:getItem(index)
    local foo = self.activityChapterItem_[item]
    local serverTime = ServerDataMgr:getServerTime()
    self.activityChapterState_[index] = true
    if chapterCid == EC_ActivityFubenType.ENDLESS then
        local endlessInfo = FubenDataMgr:getEndlessInfo()
        local nextStepTime = endlessInfo.nextStepTime or 0
        if not endlessInfo.nextStepTime then
            Bugly:ReportLuaException("endlessInfo[step]========================="..endlessInfo.step)
        end
        local remainTime = math.max(0, nextStepTime - ServerDataMgr:getServerTime())
        local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        if endlessInfo.step == EC_EndlessState.ING then
            if day ~= "00" then
                foo.Label_timing:setTextById("r80002", day, hour)
                foo.Label_tips:setTextById("r80011", day, hour)
            else
                foo.Label_timing:setTextById("r80001", hour, min)
                foo.Label_tips:setTextById("r80010", hour, min)
            end
        elseif endlessInfo.step == EC_EndlessState.READY then
            if day ~= "00" then
                foo.Label_timing:setTextById("r80004", day, hour)
                foo.Label_tips:setTextById("r80013", day, hour)
            else
                foo.Label_timing:setTextById("r80003", hour, min)
                foo.Label_tips:setTextById("r80012", hour, min)
            end
        elseif endlessInfo.step == EC_EndlessState.CLEARING then
            foo.Label_timing:setTextById("r80009", hour, min)
            foo.Label_tips:setTextById("r80014", hour, min)
        end
    elseif chapterCid == EC_ActivityFubenType.TEAM then
        self.activityChapterState_[index] = false
        foo.Panel_timing:hide()
    elseif chapterCid == EC_ActivityFubenType.BIG_WORLD then
        self.activityChapterState_[index] = false
        foo.Panel_timing:hide()
    elseif chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL
        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_2
        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_4  
        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_5  
        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_3 then
        local startTime, endTime = FubenDataMgr:getSimulationTrialActiveTime(chapterCid)
        if startTime and endTime then
            if serverTime < startTime then    -- 未开启
                local remainTime = math.max(0, startTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80004", day, hour)
                    foo.Label_tips:setTextById("r80013", day, hour)
                else
                    foo.Label_timing:setTextById("r80003", hour, min)
                    foo.Label_tips:setTextById("r80012", hour, min)
                end
            elseif serverTime >= startTime and serverTime < endTime then    -- 已开启
                local remainTime = math.max(0, endTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80002", day, hour)
                    foo.Label_tips:setTextById("r80011", day, hour)
                else
                    foo.Label_timing:setTextById("r80001", hour, min)
                    foo.Label_tips:setTextById("r80010", hour, min)
                end
            elseif serverTime >= endTime then    -- 关闭
                self.activityChapterState_[index] = false
                foo.Image_state:show()
                foo.Label_state:setTextById(1890001)
            end
        else
            self.activityChapterState_[index] = false
            foo.Image_state:show()
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.SPRITE then
        -- local spriteChallengeInfo = FubenDataMgr:getSpriteChallengeInfo()
        -- local remainTime = math.max(0, spriteChallengeInfo.leftTime - ServerDataMgr:getServerTime())
        -- local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
        -- if FubenDataMgr:getSpriteChallengeIsOpen() then
        --     if day ~= "00" then
        --         foo.Label_state:setTextById("r80002", day, hour)
        --     else
        --         foo.Label_state:setTextById("r80001", hour, min)
        --     end
        -- else
        --     if day ~= "00" then
        --         foo.Label_state:setTextById("r80004", day, hour)
        --     else
        --         foo.Label_state:setTextById("r80003", hour, min)
        --     end
        -- end
        self.activityChapterState_[index] = false
        foo.Panel_timing:hide()
    elseif chapterCid == EC_ActivityFubenType.KABALA then
        local startTime, endTime = KabalaTreeDataMgr:getOpenTime()
        if serverTime < startTime then    -- 未开启
            local remainTime = math.max(0, startTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day ~= "00" then
                foo.Label_timing:setTextById("r80004", day, hour)
                foo.Label_tips:setTextById("r80013", day, hour)
            else
                foo.Label_timing:setTextById("r80003", hour, min)
                foo.Label_tips:setTextById("r80012", hour, min)
            end
        elseif serverTime >= startTime and serverTime < endTime then    -- 已开启
            local remainTime = math.max(0, endTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day ~= "00" then
                foo.Label_timing:setTextById("r80002", day, hour)
                foo.Label_tips:setTextById("r80011", day, hour)
            else
                foo.Label_timing:setTextById("r80001", hour, min)
                foo.Label_tips:setTextById("r80010", hour, min)
            end
        elseif serverTime >= endTime then    -- 关闭
            self.activityChapterState_[index] = false
            foo.Image_state:show()
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.TEAM_PVE then
        local isOpen = TeamPveDataMgr:specialIsOpen()
        if isOpen then
            local deadLine = TeamPveDataMgr:getDeadLine()
            local remainTime = math.max(0, deadLine - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day ~= "00" then
                foo.Label_timing:setTextById("r80002", day, hour)
                foo.Label_tips:setTextById("r80011", day, hour)
            else
                foo.Label_timing:setTextById("r80001", hour, min)
                foo.Label_tips:setTextById("r80010", hour, min)
            end
        else
            self.activityChapterState_[index] = false
            foo.Image_state:show()
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.SKYLADDER then
        local isOpen = SkyLadderDataMgr:isOpen()
        if isOpen then
            local step = SkyLadderDataMgr:getStep()
            local proceedTime = SkyLadderDataMgr:getProceedTime()
            local remainTime = math.max(0, proceedTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if step == EC_SKYLADDER_STEP.PROCCED then
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80002", day, hour)
                    foo.Label_tips:setTextById("r80011", day, hour)
                else
                    foo.Label_timing:setTextById("r80001", hour, min)
                    foo.Label_tips:setTextById("r80010", hour, min)
                end
            elseif step == EC_SKYLADDER_STEP.PREPARE then
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80004", day, hour)
                    foo.Label_tips:setTextById("r80013", day, hour)
                else
                    foo.Label_timing:setTextById("r80003", hour, min)
                    foo.Label_tips:setTextById("r80012", hour, min)
                end
            elseif step == EC_SKYLADDER_STEP.BALANCE then
                foo.Label_timing:setTextById("r80009", hour, min)
                foo.Label_tips:setTextById("r80014", hour, min)
            end
        else
            self.activityChapterState_[index] = false
            foo.Image_state:show()
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.SPRITE_EXTRA then
        local startTime, endTime = FubenDataMgr:getSpriteExtraActiveTime()
        if startTime and endTime then
            if serverTime < startTime then    -- 未开启
                -- local remainTime = math.max(0, startTime - serverTime)
                -- local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                -- if day ~= "00" then
                --     foo.Label_timing:setTextById("r80004", day, hour)
                -- else
                --     foo.Label_timing:setTextById("r80003", hour, min)
                -- end
            elseif serverTime >= startTime and serverTime < endTime then    -- 已开启
                self.activityChapterState_[index] = true
                local remainTime = math.max(0, endTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80002", day, hour)
                    foo.Label_tips:setTextById("r80011", day, hour)
                else
                    foo.Label_timing:setTextById("r80001", hour, min)
                    foo.Label_tips:setTextById("r80010", hour, min)
                end
            elseif serverTime >= endTime then    -- 关闭
                foo.Label_state:setTextById(1890001)
            else

            end

        end
        local isOpen = FubenDataMgr:getSpriteExtraIsOpen()
        foo.Image_state:setVisible(not isOpen)
        if not isOpen then
            self.activityChapterState_[index] = false
            foo.Label_state:setTextById(1890001)
        end
    end
    if self.activityChapterState_[index] then
        if self.TurnView_activity_chapter:getSelectIndex() == index then
            foo.Image_tips:show()
        else
            foo.Panel_timing:setVisible(not foo.Image_tips:isVisible())
        end
    else
        foo.Panel_timing:hide()
        foo.Image_tips:hide()
    end
end

function FubenChapterView:updateHolidayTiming(index, chapterCid)
    local item = self.TurnView_holiday_chapter:getItem(index)
    local foo = self.holidayChapterItem_[item]
    local serverTime = ServerDataMgr:getServerTime()
    if chapterCid == EC_ActivityFubenType.HALLOWEEN then
        local halloweenActivity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
        if halloweenActivity[1] then
            local activityInfo = ActivityDataMgr2:getActivityInfo(halloweenActivity[1])
            if serverTime < activityInfo.startTime then
                local remainTime = math.max(0, activityInfo.startTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80004", day, hour)
                    foo.Label_tips:setTextById("r80013", day, hour)
                else
                    foo.Label_timing:setTextById("r80003", hour, min)
                    foo.Label_tips:setTextById("r80012", hour, min)
                end
            elseif serverTime >= activityInfo.startTime and serverTime < activityInfo.endTime then
                local remainTime = math.max(0, activityInfo.endTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80002", day, hour)
                    foo.Label_tips:setTextById("r80011", day, hour)
                else
                    foo.Label_timing:setTextById("r80001", hour, min)
                    foo.Label_tips:setTextById("r80010", hour, min)
                end
            elseif serverTime >= activityInfo.endTime and serverTime < activityInfo.showEndTime then
                foo.Label_state:setTextById(1890001)
            end
        else
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.CHRISTMAS then
        local christmasActivity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRISTMAS)
        if christmasActivity[1] then
            local activityInfo = ActivityDataMgr2:getActivityInfo(christmasActivity[1])
            local startTime, endTime, showEndTime = activityInfo.startTime, activityInfo.endTime, activityInfo.showEndTime
            for i, v in ipairs(christmasActivity) do
                local info = ActivityDataMgr2:getActivityInfo(v)
                if info.startTime < startTime  then
                    startTime = info.startTime
                end
                if info.endTime > endTime  then
                    endTime = info.endTime
                end
                if info.showEndTime > showEndTime  then
                    showEndTime = info.showEndTime
                end
            end
            if serverTime < startTime then
                local remainTime = math.max(0, startTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_time:setTextById("r80004", day, hour)
                    foo.Label_tips:setTextById("r80013", day, hour)
                else
                    foo.Label_time:setTextById("r80003", hour, min)
                    foo.Label_tips:setTextById("r80012", hour, min)
                end
            elseif serverTime >= startTime and serverTime < endTime then
                local remainTime = math.max(0, endTime - serverTime)
                local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
                if day ~= "00" then
                    foo.Label_timing:setTextById("r80002", day, hour)
                    foo.Label_tips:setTextById("r80011", day, hour)
                else
                    foo.Label_timing:setTextById("r80001", hour, min)
                    foo.Label_tips:setTextById("r80010", hour, min)
                end
            elseif serverTime >= endTime and serverTime < showEndTime then
                foo.Label_state:setTextById(1890001)
            end
        else
            foo.Label_state:setTextById(1890001)
        end
    elseif chapterCid == EC_ActivityFubenType.NEWYEAR then
        local activityTime = DlsDataMgr:getActivityTime()
        if serverTime < activityTime.startTime then
            local remainTime = math.max(0, activityTime.startTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day ~= "00" then
                foo.Label_time:setTextById("r80004", day, hour)
                foo.Label_tips:setTextById("r80013", day, hour)
            else
                foo.Label_time:setTextById("r80003", hour, min)
                foo.Label_tips:setTextById("r80012", hour, min)
            end
        elseif serverTime >= activityTime.startTime and serverTime < activityTime.endTime then
            local remainTime = math.max(0, activityTime.endTime - serverTime)
            local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            if day ~= "00" then
                foo.Label_timing:setTextById("r80002", day, hour)
                foo.Label_tips:setTextById("r80011", day, hour)
            else
                foo.Label_timing:setTextById("r80001", hour, min)
                foo.Label_tips:setTextById("r80010", hour, min)
            end
        else
            foo.Panel_timing:hide()
            foo.Image_state:show()
            foo.Label_state:setTextById(1890001)
        end
    end
end

function FubenChapterView:updateTheaterTiming()
    local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
    local remainTime = math.max(0, theaterBossInfo.closeTime - ServerDataMgr:getServerTime())
    local day, hour, min = Utils:getFuzzyDHMS(remainTime, true)
    if day ~= "00" then
        self.Label_theater_tips_2:setTextById(800044, day, hour, min)
    else
        self.Label_theater_tips_2:setTextById(800027, hour, min)
    end
end

function FubenChapterView:showDaily(index)
    local fubenData = self.fubenData_[index]
    for i, v in ipairs(fubenData.data) do
        if not self.cache_[index] then
            self:addDailyChapterItem()

            local item = self:addNavigationItem()
            item:onClick(function()
                    self.TurnView_daily_chapter:scrollToItem(i)
            end)
            self.ListView_daily_navigation:pushBackCustomItem(item)
        end
        self:updateDailyChapterItem(index, i)
    end
    Utils:setAliginCenterByListView(self.ListView_daily_navigation, true)

    local selectIndex
    if self.defaultSelectChapterIndex_ then
        selectIndex = self.defaultSelectChapterIndex_
        self.TurnView_daily_chapter:scrollToItem(self.defaultSelectChapterIndex_)
        self.defaultSelectChapterIndex_ = nil
    else
        self.TurnView_daily_chapter:scrollToItem(self.TurnView_daily_chapter:getSelectIndex())
        selectIndex = self.TurnView_daily_chapter:getSelectIndex()
    end
    local items = self.TurnView_daily_chapter:getItem()
    if selectIndex and selectIndex == 1 then
        for i, v in ipairs( items) do
            v:setVisible(false)
        end
        self:timeOut(function()
            for i, v in ipairs( items) do
                v:setVisible(true)
                v:setOpacity(0)
                if i == 1 then
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 3, distance = 40, delay = 0, time = 0.2, callback = callBack})
                else
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 1, distance = 30, delay = 0.2 + (i - 1) * 0.05, time = 0.1, callback = callBack})
                end
            end
        end, 0.15)
    end
    for i, v in ipairs( items) do
        if i == selectIndex then
            local foo = self.dailyChapterItem_[v]
            ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.25, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Label_daily_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.25, ease = 1})
            foo.Image_tips:setScaleX(0.5)
            foo.Image_tips:setOpacity(0)
            foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.25), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
        end
    end
end

function FubenChapterView:addHolidayChapterItem()
    local item = self.TurnView_holiday_chapter:pushBackItem()
    local foo = {}
    foo.root = item
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Panel_select = TFDirector:getChildByPath(foo.root, "Panel_select")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_effect = TFDirector:getChildByPath(foo.Panel_select, "Image_effect")
    foo.Label_select_name = TFDirector:getChildByPath(foo.Panel_select, "Label_select_name")
    foo.Panel_unselect = TFDirector:getChildByPath(foo.root, "Panel_unselect")
    foo.Label_unselect_name = TFDirector:getChildByPath(foo.Panel_unselect, "Label_unselect_name")
    foo.Image_state = TFDirector:getChildByPath(foo.root, "Image_state")
    foo.Label_state = TFDirector:getChildByPath(foo.Image_state, "Label_state")
    foo.Image_unlock_mask = TFDirector:getChildByPath(foo.root, "Image_unlock_mask"):hide()
    foo.Image_lock_mask = TFDirector:getChildByPath(foo.root, "Image_lock_mask"):hide()
    foo.Panel_timing = TFDirector:getChildByPath(foo.root, "Panel_timing")
    foo.Label_timing = TFDirector:getChildByPath(foo.Panel_timing, "Label_timing")
    foo.Image_tips = self.Image_tipsItem:clone():hide()
    foo.Label_tips = TFDirector:getChildByPath(foo.Image_tips, "Label_tips")
    foo.Image_tips:AddTo(self.Panel_holiday_state):Pos(0, 0)
    self.holidayChapterItem_[foo.root] = foo
    return foo.root
end

function FubenChapterView:updateHolidayChapterItem(index, subIndex)
    local fubenData = self.fubenData_[index]
    local chapterCid = fubenData.data[subIndex]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)

    local item = self.TurnView_holiday_chapter:getItem(subIndex)
    local foo = self.holidayChapterItem_[item]

    foo.Label_select_name:setTextById(chapterCfg.name)
    foo.Label_unselect_name:setTextById(chapterCfg.name)
    foo.Image_icon:setTexture(chapterCfg.pictureIcon)

    local playerLevel = MainPlayer:getPlayerLv()
    local unlock = chapterCfg.unlockLevel <= playerLevel
    foo.Image_state:setVisible(not unlock)
    foo.Panel_timing:setVisible(unlock)
    if unlock then
        self:updateHolidayTiming(subIndex, chapterCid)
    else
        foo.Label_state:setTextById(800003, chapterCfg.unlockLevel)
    end

    foo.root:onClick(function()
            local selectIndex = self.TurnView_holiday_chapter:getSelectIndex()
            if subIndex == selectIndex then
                if unlock then
                    FubenDataMgr:cacheSelectFubenType(fubenData.type_)
                    FubenDataMgr:cacheSelectChapter(chapterCid)
                    if chapterCid == EC_ActivityFubenType.HALLOWEEN then
                        local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.HALLOWEEN)
                        if #activity > 0 then
                            local checkExtId = TFAssetsManager:getCheckInfo(6,chapterCid)
                            if checkExtId then
                                TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                                    Utils:openView("fuben.FubenHalloweenLevelView", chapterCid)
                                end,true)
                                return
                            else
                                TFAssetsManager:downloadHeroAssets(function()
                                    Utils:openView("fuben.FubenHalloweenLevelView", chapterCid)
                                end,true)
                            end
                        else
                            Utils:showTips(2109031)
                        end
					elseif chapterCid == EC_ActivityFubenType.HALLOWEEN2019 then
						Utils:openView("fuben.FubenHalloweenLevelView")
                    elseif chapterCid == EC_ActivityFubenType.CHRISTMAS then
                        local checkExtId = TFAssetsManager:getCheckInfo(6,chapterCid)
                        if checkExtId then
                            TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                                AgoraDataMgr:openAgoraMain()
                            end,true)
                            return
                        else
                            TFAssetsManager:downloadHeroAssets(function()
                                AgoraDataMgr:openAgoraMain()
                            end,true)
                        end
                    elseif chapterCid == EC_ActivityFubenType.NEWYEAR then
                        local serverTime = ServerDataMgr:getServerTime()
                        local activityTime = DlsDataMgr:getActivityTime()
                        if DlsDataMgr:isShowTime() then
                            Utils:openView("dls.DlsMainView")
                        else
                            Utils:showTips(1890001)
                        end
                    end
                end
            else
                self.TurnView_holiday_chapter:scrollToItem(subIndex)
                ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.15, ease = 1})
                ViewAnimationHelper.doMoveFadeInAction(self.Label_holiday_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.15, ease = 1})
                foo.Image_tips:setScaleX(0.5)
                foo.Image_tips:setOpacity(0)
                foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.15), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
            end
    end)

    self.holidayChapterState_[subIndex] = foo.Panel_timing:isVisible()
end

function FubenChapterView:addActivityChapterItem()
    local item = self.TurnView_activity_chapter:pushBackItem()
    local foo = {}
    foo.root = item
    foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
    foo.Panel_select = TFDirector:getChildByPath(foo.root, "Panel_select")
    foo.Image_select = TFDirector:getChildByPath(foo.root, "Image_select")
    foo.Image_effect = TFDirector:getChildByPath(foo.Panel_select, "Image_effect")
    foo.Label_select_name = TFDirector:getChildByPath(foo.Panel_select, "Label_select_name")
    foo.Panel_unselect = TFDirector:getChildByPath(foo.root, "Panel_unselect")
    foo.Label_unselect_name = TFDirector:getChildByPath(foo.Panel_unselect, "Label_unselect_name")
    foo.Image_state = TFDirector:getChildByPath(foo.root, "Image_state")
    foo.Label_state = TFDirector:getChildByPath(foo.Image_state, "Label_state")
    foo.Image_unlock_mask = TFDirector:getChildByPath(foo.root, "Image_unlock_mask"):hide()
    foo.Image_lock_mask = TFDirector:getChildByPath(foo.root, "Image_lock_mask"):hide()
    foo.Panel_timing = TFDirector:getChildByPath(foo.root, "Panel_timing")
    foo.Label_timing = TFDirector:getChildByPath(foo.Panel_timing, "Label_timing")
    foo.Image_tips = self.Image_tipsItem:clone():hide()
    foo.Label_tips = TFDirector:getChildByPath(foo.Image_tips, "Label_tips")
    foo.Image_tips:AddTo(self.Panel_activity_state):Pos(0, 0)
    self.activityChapterItem_[foo.root] = foo
    return foo.root
end

function FubenChapterView:updateActivityChapterItem(index, subIndex)
    local fubenData = self.fubenData_[index]
    local chapterCid = fubenData.data[subIndex]
    local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)

    local item = self.TurnView_activity_chapter:getItem(subIndex)
    local foo = self.activityChapterItem_[item]

    foo.Label_select_name:setTextById(chapterCfg.name)
    foo.Label_unselect_name:setTextById(chapterCfg.name)
    foo.Image_icon:setTexture(chapterCfg.pictureIcon)

    local playerLevel = MainPlayer:getPlayerLv()
    local unlock = chapterCfg.unlockLevel <= playerLevel
    foo.Image_state:setVisible(not unlock)
    foo.Panel_timing:setVisible(unlock)
    if unlock then
        self:updateActivityTiming(subIndex, chapterCid)
    else
        foo.Label_state:setTextById(800003, chapterCfg.unlockLevel)
    end

    foo.root:onClick( function()
        local selectIndex = self.TurnView_activity_chapter:getSelectIndex()
        if subIndex == selectIndex then
            if unlock then
				print("chapterCid=====================================" .. chapterCid)
                local function enterActivityFuben()
                    FubenDataMgr:cacheSelectFubenType(fubenData.type_)
                    FubenDataMgr:cacheSelectChapter(chapterCid)
                    if chapterCid == EC_ActivityFubenType.TEAM then
                        if DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.TEAM) then
                            return
                        end
                        TeamFightDataMgr:openTeamGroupSelView(chapterCid)
                    elseif chapterCid == EC_ActivityFubenType.ENDLESS then
                        local endlessInfo = FubenDataMgr:getEndlessInfo()
                        if endlessInfo.step == EC_EndlessState.ING then
                            Utils:openView("fuben.FubenEndlessView", chapterCid)

                        end
                    elseif chapterCid == EC_ActivityFubenType.KABALA then
                        if KabalaTreeDataMgr:isFunctionOpen() then
                            KabalaTreeDataMgr:openKabalaTree()
                        end
                    elseif chapterCid == EC_ActivityFubenType.SPRITE then
                        local funcIsOpen = FunctionDataMgr:checkFuncOpen(58)
                        if funcIsOpen then
                            if DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.SPRITE) then
                                return
                            end
                            if FubenDataMgr:getSpriteChallengeIsOpen() then
                                Utils:openView("fuben.FubenSpriteView", chapterCid)
                            else
                                Utils:showTips(2106013)
                            end
                        end
                    elseif chapterCid == EC_ActivityFubenType.SPRITE_EXTRA then
                        local funcIsOpen = FunctionDataMgr:checkFuncOpen(59)
                        if funcIsOpen then
                            if FubenDataMgr:getSpriteExtraIsOpen() then
                                Utils:openView("fuben.FubenSpriteExtraView", chapterCid)
                            else
                                Utils:showTips(2106013)
                            end
                        end
                    elseif chapterCid == EC_ActivityFubenType.TEAM_PVE then
                        local isOpen = TeamPveDataMgr:specialIsOpen()
                        if isOpen then
                            TeamPveDataMgr:openMainView()
                        end
                    elseif chapterCid == EC_ActivityFubenType.BIG_WORLD then
                        -- Utils:showTips(">>>>>进入大世界")
                        local funcIsOpen = true
                        if funcIsOpen then
                            -- AlertManager:changeScene(SceneType.OSD) --请求进入大世界
                            local OSDControl = require("lua.logic.osd.OSDControl")
                            OSDControl:enterOSD({})
                        end
                    elseif chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL 
                        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_2
                        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_4 
                        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_5
                        or chapterCid == EC_ActivityFubenType.SIMULATION_TRIAL_3 then
                        local funcIsOpen = FunctionDataMgr:checkFuncOpen(113)
                        if funcIsOpen then
                            if FubenDataMgr:getSimulationTrialIsOpen(chapterCid) then
                                Utils:openView("simulationTrial.SimulationTrialMainView",chapterCid)
                            else
                                Utils:showTips(2106013)
                            end
                        end
                    elseif chapterCid == EC_ActivityFubenType.SKYLADDER then
                        local isOpen = SkyLadderDataMgr:isOpen()
                        if isOpen then
                            Utils:openView("skyLadder.SkyLadderMainView")
                        end
                    end
                end
                local checkExtId = TFAssetsManager:getCheckInfo(3,chapterCid)
                if checkExtId then
                    TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                        enterActivityFuben()
                    end,true)
                    return
                else
                    TFAssetsManager:downloadHeroAssets(function()
                        enterActivityFuben()
                    end,true)
                end
            end
        else
            self.TurnView_activity_chapter:scrollToItem(subIndex)
            ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.15, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Label_activity_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.15, ease = 1})
            foo.Image_tips:setScaleX(0.5)
            foo.Image_tips:setOpacity(0)
            foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.15), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
        end 
    end)
end

function FubenChapterView:showActivity(index)
    local fubenData = self.fubenData_[index]
    for i, v in ipairs(fubenData.data) do
        if not self.cache_[index] then
            self:addActivityChapterItem()

            local item = self:addNavigationItem()
            item:onClick(function()
                    self.TurnView_activity_chapter:scrollToItem(i)
            end)
            self.ListView_activity_navigation:pushBackCustomItem(item)
        end
        self:updateActivityChapterItem(index, i)
    end
    Utils:setAliginCenterByListView(self.ListView_activity_navigation, true)

    local selectIndex
    if self.defaultSelectChapterIndex_ then
        selectIndex = self.defaultSelectChapterIndex_
        self.TurnView_activity_chapter:scrollToItem(self.defaultSelectChapterIndex_)
        self.defaultSelectChapterIndex_ = nil
    else
        self.TurnView_activity_chapter:scrollToItem(self.TurnView_activity_chapter:getSelectIndex())
        selectIndex = self.TurnView_activity_chapter:getSelectIndex()
    end
    local items = self.TurnView_activity_chapter:getItem()
    if selectIndex and selectIndex == 1 then
        for i, v in ipairs( items) do
            v:setVisible(false)
        end
        self:timeOut(function()
            for i, v in ipairs( items) do
                v:setVisible(true)
                v:setOpacity(0)
                if i == 1 then
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 3, distance = 40, delay = 0, time = 0.2, callback = callBack})
                else
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 1, distance = 30, delay = 0.2 + (i - 1) * 0.05, time = 0.1, callback = callBack})
                end
            end
        end, 0.15)
    end

    for i,v in ipairs(items) do
        if i == selectIndex then
            local foo = self.activityChapterItem_[v]
            ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.25, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Label_activity_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.25, ease = 1})
            foo.Image_tips:setScaleX(0.5)
            foo.Image_tips:setOpacity(0)
            foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.25), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
        end
    end
end

function FubenChapterView:showHoliday(index)
    local fubenData = self.fubenData_[index]
    for i, v in ipairs(fubenData.data) do
        if not self.cache_[index] then
            self:addHolidayChapterItem()

            local item = self:addNavigationItem()
            item:onClick(function()
                    self.TurnView_holiday_chapter:scrollToItem(i)
            end)
            self.ListView_holiday_navigation:pushBackCustomItem(item)
        end
        self:updateHolidayChapterItem(index, i)
    end
    Utils:setAliginCenterByListView(self.ListView_holiday_navigation, true)

    local selectIndex
    if self.defaultSelectChapterIndex_ then
        selectIndex = self.defaultSelectChapterIndex_
        self.TurnView_holiday_chapter:scrollToItem(self.defaultSelectChapterIndex_)
        self.defaultSelectChapterIndex_ = nil
    else
        self.TurnView_holiday_chapter:scrollToItem(self.TurnView_holiday_chapter:getSelectIndex())
        selectIndex = self.TurnView_holiday_chapter:getSelectIndex()
    end
    local items = self.TurnView_holiday_chapter:getItem()
    if selectIndex and selectIndex == 1 then
        for i, v in ipairs( items) do
            v:setVisible(false)
        end
        self:timeOut(function()
            for i, v in ipairs( items) do
                v:setVisible(true)
                v:setOpacity(0)
                if i == 1 then
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 3, distance = 40, delay = 0, time = 0.2, callback = callBack})
                else
                    ViewAnimationHelper.doMoveFadeInAction(v, {direction = 1, distance = 30, delay = 0.2 + (i - 1) * 0.05, time = 0.1, callback = callBack})
                end
            end
        end, 0.15)
    end

     for i, v in ipairs( items) do
        if i == selectIndex then
            local foo = self.holidayChapterItem_[v]
            ViewAnimationHelper.doMoveFadeInAction(foo.Label_select_name, {direction = 2, distance = 30, time = 0.2, delay = 0.25, ease = 1})
            ViewAnimationHelper.doMoveFadeInAction(self.Label_holiday_tips, {direction = 4, distance = 15, time = 0.2, delay = 0.25, ease = 1})
            foo.Image_tips:setScaleX(0.5)
            foo.Image_tips:setOpacity(0)
            foo.Image_tips:runAction(CCSequence:create({CCDelayTime:create(0.25), CCSpawn:create({CCFadeIn:create(0.2), CCScaleTo:create(0.2, 1.0)})}))
        end
    end
end

function FubenChapterView:showTheater()
    local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
    local levelCid = theaterBossInfo.bossDungeonId
    self.Label_theater_noOpen:hide()
    if theaterBossInfo.odeumType == EC_TheaterBossType.LINGBO then
        local canChallenge = levelCid ~= 0
        self.Button_theater_challenge:setVisible(canChallenge)
        self.Label_theater_noOpen:setVisible(not canChallenge)
        local curLingbo = theaterBossInfo.lingbo
        local lingboGroup = theaterBossInfo.lingboGroup
        local maxLingbo = lingboGroup[#lingboGroup]
        if canChallenge then
            local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
            if theaterBossInfo.status == EC_TheaterStatus.ING then
                self.Label_theater_challenge:setTextById(300967)
                self.Label_theater_tips_1:show():setTextById(300973)
                self.Label_theater_tips_2:show()
            elseif theaterBossInfo.status == EC_TheaterStatus.CLEARING then
                self.Label_theater_challenge:setTextById(300992)
                self.Label_theater_tips_1:show():setTextById(300989)
                self.Label_theater_tips_2:hide()
            end
            self.Label_theater_name:setTextById(levelCfg.name)
            self:updateTheaterTiming()
            for i, v in ipairs(self.Image_theater_icon) do
                v:hide()
            end
            self.Image_theater_icon_boss:show()
        else
            self.Label_theater_challenge:setTextById(300967)
            local curStage
            local size = self.LoadingBar_lingbo:getSize()
            local anchorPointInPoints = self.LoadingBar_lingbo:getAnchorPointInPoints()
            for i, v in ipairs(self.Image_percent_tag) do
                if curStage then
                    if curLingbo >= lingboGroup[i] then
                        curStage = i
                    end
                else
                    curStage = i
                end
                local lingbo = lingboGroup[i]
                v:setVisible(tobool(v))
                if lingbo then
                    local rate = lingbo / maxLingbo
                    local x = size.width * rate - size.width * 0.5
                    v:PosX(x)
                end
            end
            local nextStage = math.min(#lingboGroup, curStage + 1)
            for i, v in ipairs(self.Image_theater_icon) do
                v:setVisible(i == nextStage)
            end
            self.Image_theater_icon_boss:hide()
            local percent = math.min(1, curLingbo / lingboGroup[nextStage])
            self.Label_theater_tips_1:show():setTextById(300969)
            self.Label_theater_tips_2:show():setTextById("r301000", Utils:format_number_w(curLingbo),
                                                         Utils:format_number_w(lingboGroup[nextStage]),
                                                         string.format("%0.2f", percent * 100))
            self.Label_theater_noOpen:setTextById(300970)
            self.Label_theater_name:setTextById(300968)
        end
        local percent = curLingbo / maxLingbo
        self.LoadingBar_lingbo:setPercent(percent * 100)
        self.Image_theater_progress:show()
    else
        self.Label_theater_tips_1:show()
        self.Label_theater_tips_2:show()
        self.Button_theater_challenge:setVisible(theaterBossInfo.status ~= EC_TheaterStatus.CLOSING)
        self.Image_theater_progress:hide()
        local levelCfg = FubenDataMgr:getLevelCfg(levelCid)
        if levelCfg then
            self.Label_theater_name:setTextById(levelCfg.name)
        end
        for i, v in ipairs(self.Image_theater_icon) do
            v:hide()
        end
        self.Image_theater_icon_boss:show()

        if theaterBossInfo.status == EC_TheaterStatus.ING then
            self.Label_theater_tips_1:setTextById(12010164)
        elseif theaterBossInfo.status == EC_TheaterStatus.CLOSING then
            self.Label_theater_tips_1:setTextById(300969)
        elseif theaterBossInfo.status == EC_TheaterStatus.CLEARING then
            self.Label_theater_tips_1:setTextById(300989)
        end
        self:updateTheaterTiming()
    end
end

function FubenChapterView:refreshView()
    self:showFubenList()
    self:addCountDownTimer()
end

function FubenChapterView:getChapterIndex(type_)
    local index
    for i, v in ipairs(self.fubenData_) do
        if v.type_ == type_ then
            index = i
            break
        end
    end
    return index
end

function FubenChapterView:onPlotTurnViewSelect(target, selectIndex)
    local items = target:getItem()
    for i, v in ipairs(items) do
        local foo = self.plotChapterItem_[v]
        local isSelect = (i == selectIndex)
        foo.Panel_select:setVisible(isSelect)
        foo.Image_select:setVisible(isSelect)
        foo.Panel_unselect:setVisible(not isSelect)
    end
    self:updateChapterTips(EC_FBType.PLOT, selectIndex)
    self:updateNavigation(EC_FBType.PLOT, selectIndex)
end

function FubenChapterView:updateChapterTips(fubenType, selectIndex)
    local index = 1
    for i, v in ipairs(self.fubenData_) do
        if v.type_ == fubenType then
            index = i
            break
        end
    end
    if index then
        local fubenData = self.fubenData_[index]
        if fubenType == EC_FBType.DAILY then
            local levelGroupCid = fubenData.data[selectIndex]
            local levelGroupCfg = FubenDataMgr:getLevelGroupCfg(levelGroupCid)
            self.Label_daily_tips:setTextById(levelGroupCfg.desc)
        else
            local chapterCid = fubenData.data[selectIndex]
            local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
            if fubenType == EC_FBType.PLOT then
                self.Label_plot_tips:setTextById(chapterCfg.chapterDescribe)
            elseif fubenType == EC_FBType.ACTIVITY then
                self.Label_activity_tips:setTextById(chapterCfg.chapterDescribe)
            elseif fubenType == EC_FBType.HOLIDAY then
                self.Label_holiday_tips:setTextById(chapterCfg.chapterDescribe)
            end
        end
    end
end

function FubenChapterView:onDailyTurnViewSelect(target, selectIndex)
    local items = target:getItem()
    for i, v in ipairs(items) do
        local foo = self.dailyChapterItem_[v]
        local isSelect = (i == selectIndex)
        foo.Panel_select:setVisible(isSelect)
        foo.Image_select:setVisible(isSelect)
        foo.Panel_unselect:setVisible(not isSelect)
        foo.Image_timing:setVisible(not isSelect)
        local visible = self.dailyChapterState_[i]
        if isSelect then
            foo.Image_tips:setVisible(visible)
            foo.Panel_timing:hide()
        else
            foo.Panel_timing:setVisible(visible)
            foo.Image_tips:hide()
        end
    end
    self:updateChapterTips(EC_FBType.DAILY, selectIndex)
    self:updateNavigation(EC_FBType.DAILY, selectIndex)

    self.Label_daily_tips:setTouchEnabled(true)
    self.Label_daily_tips:onClick(function()
            TFDirector:send(c2s.DUNGEON_GROUP_MULTIPLE_REWARD, {})
    end)
end

function FubenChapterView:onActivityTurnViewSelect(target, selectIndex)
    local items = target:getItem()
    for i, v in ipairs(items) do
        local foo = self.activityChapterItem_[v]
        local isSelect = (i == selectIndex)
        foo.Panel_select:setVisible(isSelect)
        foo.Image_select:setVisible(isSelect)
        foo.Panel_unselect:setVisible(not isSelect)
        local isLock = foo.Image_state:isVisible()
        foo.Image_unlock_mask:setVisible(not isLock and not isSelect)
        foo.Image_lock_mask:setVisible(isLock and not isSelect)
        local visible = self.activityChapterState_[i]
        if isSelect then
            foo.Image_tips:setVisible(visible)
            foo.Panel_timing:hide()
        else
            foo.Panel_timing:setVisible(visible)
            foo.Image_tips:hide()
        end
    end
    self:updateChapterTips(EC_FBType.ACTIVITY, selectIndex)
    self:updateNavigation(EC_FBType.ACTIVITY, selectIndex)
end

function FubenChapterView:onHolidayTurnViewSelect(target, selectIndex)
    local items = target:getItem()
    for i, v in ipairs(items) do
        local foo = self.holidayChapterItem_[v]
        local isSelect = (i == selectIndex)
        foo.Panel_select:setVisible(isSelect)
        foo.Image_select:setVisible(isSelect)
        foo.Panel_unselect:setVisible(not isSelect)
        local isLock = foo.Image_state:isVisible()
        foo.Image_unlock_mask:setVisible(not isLock and not isSelect)
        foo.Image_lock_mask:setVisible(isLock and not isSelect)
        local visible = self.holidayChapterState_[i]
        if isSelect then
            foo.Image_tips:setVisible(visible)
            foo.Panel_timing:hide()
        else
            foo.Panel_timing:setVisible(visible)
            foo.Image_tips:hide()
        end
    end
    self:updateChapterTips(EC_FBType.HOLIDAY, selectIndex)
    self:updateNavigation(EC_FBType.HOLIDAY, selectIndex)
end

function FubenChapterView:updateNavigation(type_, index)
    local navigation_listview = {
        [EC_FBType.PLOT] = self.ListView_plot_navigation,
        [EC_FBType.DAILY] = self.ListView_daily_navigation,
        [EC_FBType.ACTIVITY] = self.ListView_activity_navigation,
        [EC_FBType.HOLIDAY] = self.ListView_holiday_navigation,
    }

    for i, v in ipairs(navigation_listview[type_]:getItems()) do
        local foo = self.navigationItem_[v]
        foo.Image_normal:setVisible(index ~= i)
        foo.Image_select:setVisible(index == i)
    end
end

function FubenChapterView:registerEvents()
    EventMgr:addEventListener(self, EV_FUBEN_UPDATEENDLESSINFO, handler(self.onUpdateEndlessInfoEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_SPRITE_EXTRA_UPDATE_INFO, handler(self.onUpdateActivityEvent, self))
    EventMgr:addEventListener(self, EV_FUBEN_THEATER_BOSS_INFO, handler(self.onTheaterBossInfoEvent, self))

    local function scrollCallback(target, offsetRate, customOffsetRate)
        local items = target:getItem()
        for i, item in ipairs(items) do
            local rate = offsetRate[i]
            local rrate = 1 - rate
            local customRate = customOffsetRate[i]
            local rCustomRate = 1 - customRate
            item:setOpacity(255 * rrate)
            item:setPositionZ(-customRate * 100)
            item:setZOrder(rrate * 100)
        end
    end

    self.TurnView_plot_chapter:registerScrollCallback(scrollCallback)
    self.TurnView_daily_chapter:registerScrollCallback(scrollCallback)
    self.TurnView_activity_chapter:registerScrollCallback(scrollCallback)
    self.TurnView_plot_chapter:registerSelectCallback(handler(self.onPlotTurnViewSelect, self))
    self.TurnView_daily_chapter:registerSelectCallback(handler(self.onDailyTurnViewSelect, self))
    self.TurnView_activity_chapter:registerSelectCallback(handler(self.onActivityTurnViewSelect, self))
    self.TurnView_holiday_chapter:registerSelectCallback(handler(self.onHolidayTurnViewSelect, self))

    self.Button_theater_challenge:onClick(function()
            local chapter = FubenDataMgr:getChapter(EC_FBType.THEATER_HARD)
            local chapterCid = chapter[1]
            local chapterCfg = FubenDataMgr:getChapterCfg(chapterCid)
            if MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel then
                local fubenCheckCfg = {[3] = {7,chapterCfg.id},[6] = {8,chapterCfg.id},[7] = {9,chapterCfg.id}}
                local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
                if fubenCheckParam then
                    if DispatchDataMgr:checkIsDispatching(EC_DISPATCHType.THEATER) then
                        return
                    end
                    local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
                    if checkExtId then
                        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                            Utils:openView("fuben.FubenTheaterBossView")
                        end,true)
                        return
                    else
                        TFAssetsManager:downloadHeroAssets(function()
                            Utils:openView("fuben.FubenTheaterBossView")
                        end,true)
                    end
                end
            else
                Utils:showTips(12010142, chapterCfg.unlockLevel)
            end
    end)

    self.Button_theater_goto:onClick(function()
            local chapter = FubenDataMgr:getTheaterChapter(self.selectTheaterId)
            local chapterCfg = FubenDataMgr:getChapterCfg(chapter[1])
            if MainPlayer:getPlayerLv() >= chapterCfg.unlockLevel then
                local fubenCheckCfg = {[3] = {7,chapterCfg.id},[6] = {8,chapterCfg.id},[7] = {9,chapterCfg.id}}
                local fubenCheckParam = fubenCheckCfg[chapterCfg.type]
                if fubenCheckParam then
                    local checkExtId = TFAssetsManager:getCheckInfo(fubenCheckParam[1],fubenCheckParam[2])
                    if checkExtId then
                        TFAssetsManager:downloadAssetsOfFunc(checkExtId,function()
                            Utils:openView("fuben.FubenTheaterLevelView",nil,nil,self.selectTheaterId)
                        end,true)
                        return
                    else
                        TFAssetsManager:downloadHeroAssets(function()
                            Utils:openView("fuben.FubenTheaterLevelView",nil,nil,self.selectTheaterId)
                        end,true)
                    end
                end
            else
                Utils:showTips(12010142, chapterCfg.unlockLevel)
            end
    end)
    self.Button_openRule:onClick(function ( ... )
        -- body
        Utils:openView("fuben.FubenDailyOpenRuleView")
    end)
    ------联动
    self.Panel_linkage.Button_start:onClick(function ( )
        FunctionDataMgr:jLinkAge(self.linkageData.chapterCid)
    end)

    ---进入狂三副本
    self.Panel_kuangsan.Button_start:onClick(function ( )
        FunctionDataMgr:jKsanFuben()
    end)

end

function FubenChapterView:removeEvents()
    self:removeCountDownTimer()
end

function FubenChapterView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, count, nil, handler(self.onCountDownPer, self))
    end
end

function FubenChapterView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function FubenChapterView:onCountDownPer()
    if self.fubenData_ == nil then self:removeCountDownTimer() return end
    for i, v in ipairs(self.fubenData_) do
        if v.type_ == EC_FBType.DAILY then
            if self.cache_[i] then
                for j, cid in ipairs(v.data) do
                    self:updateDailyTiming(j, cid)
                end
            end
        elseif v.type_ == EC_FBType.ACTIVITY then
            if self.cache_[i] then
                for j, cid in ipairs(v.data) do
                    local chapterCfg = FubenDataMgr:getChapterCfg(cid)
                    local playerLevel = MainPlayer:getPlayerLv()
                    local unlock = chapterCfg.unlockLevel <= playerLevel
                    if unlock then
                        self:updateActivityTiming(j, cid)
                    end
                end
            end
        elseif v.type_ == EC_FBType.HOLIDAY then
            if self.cache_[i] then
                for j, cid in ipairs(v.data) do
                    local chapterCfg = FubenDataMgr:getChapterCfg(cid)
                    local playerLevel = MainPlayer:getPlayerLv()
                    local unlock = chapterCfg.unlockLevel <= playerLevel
                    if unlock then
                        self:updateHolidayTiming(j, cid)
                    end
                end
            end
        elseif v.type_ == EC_FBType.THEATER then
            local theaterBossInfo = FubenDataMgr:getTheaterBossInfo()
            if theaterBossInfo.odeumType == EC_TheaterBossType.LINGBO then
                local canChallenge = theaterBossInfo.bossDungeonId ~= 0
                if canChallenge then
                    self:updateTheaterTiming()
                end
            else
                self:updateTheaterTiming()
            end
        elseif v.type_ == EC_FBType.LINKAGE then
            -- dump("EC_FBType.LINKAGExxxxx")
            self:refreshLinkage()
        elseif v.type_ == EC_FBType.KSAN_FUBEN then
            self:refreshKsanPage()
        end
    end
end

function FubenChapterView:onUpdateEndlessInfoEvent()
    self:onCountDownPer()
end

function FubenChapterView:onUpdateActivityEvent()
    if self.cache_[i] then
        for j, cid in ipairs(v.data) do
            local chapterCfg = FubenDataMgr:getChapterCfg(cid)
            local playerLevel = MainPlayer:getPlayerLv()
            local unlock = chapterCfg.unlockLevel <= playerLevel
            if unlock then
                self:updateHolidayTiming(j, cid)
            end
        end
    end
end

function FubenChapterView:onTheaterBossInfoEvent(theaterInfo)
    self:showTheater()
end

function FubenChapterView:onShow()
    self.super.onShow(self)
    self:removeLockLayer()
    self:timeOut(function()
        GameGuide:checkGuide(self)
    end,0.05)
end

--引导第一章
function FubenChapterView:excuteGuideFunc2001(guideFuncId)
    local targetNode
    local item = self.TurnView_plot_chapter:getItem(1)
    local foo = self.plotChapterItem_[item]
    targetNode = foo.root
    self.guideFuncId = guideFuncId
    GameGuide:guideTargetNode(targetNode)
end

function FubenChapterView:flushLinkage( ... )
    -- body
end


return FubenChapterView
