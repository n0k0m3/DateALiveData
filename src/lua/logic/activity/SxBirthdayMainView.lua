
local SxBirthdayMainView = class("SxBirthdayMainView", BaseLayer)

function SxBirthdayMainView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.SX_BIRTHDAY)
    if #activity > 0 then
        self.activityId_ = activity[1]
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Utils:showTips("没有十香生日活动")
    end
end

function SxBirthdayMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.sxBirthdayMainView")
end

function SxBirthdayMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_cityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cityItem")

    self.Button_travel = TFDirector:getChildByPath(self.Panel_root, "Button_travel")
    self.Image_travel_tips = TFDirector:getChildByPath(self.Button_travel, "Image_travel_tips")
    self.Label_travel = TFDirector:getChildByPath(self.Button_travel, "Label_travel")
    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Label_store = TFDirector:getChildByPath(self.Button_store, "Label_store")

    self.Button_city = {}
    for i = 1, 4 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_root, "Button_" .. i)
        local Panel_site = TFDirector:getChildByPath(foo.root, "Panel_site")
        Panel_site:setBackGroundColorType(0)
        foo.Panel_city = self.Panel_cityItem:clone():hide()
        foo.Panel_city:Pos(0, 0):AddTo(Panel_site)
        foo.Button_unlockCity = TFDirector:getChildByPath(foo.Panel_city, "Button_unlockCity"):hide()
        foo.Button_unlockCity:Touchable(false)
        foo.Image_cityIcon = TFDirector:getChildByPath(foo.Button_unlockCity, "Image_cityIcon")
        foo.Label_unlockCityName = TFDirector:getChildByPath(foo.Button_unlockCity, "Label_unlockCityName")
        foo.Label_unlockCityName:setSkewX(15)
        foo.Button_lockCity = TFDirector:getChildByPath(foo.Panel_city, "Button_lockCity")
        foo.Button_lockCity:Touchable(false)
        foo.Image_cityIcon_lock = TFDirector:getChildByPath(foo.Button_lockCity, "Image_cityIcon_lock")
        foo.Label_lockCityName = TFDirector:getChildByPath(foo.Button_lockCity, "Label_lockCityName")
        foo.Label_lockCityName:setSkewX(15)
        foo.Button_curCity = TFDirector:getChildByPath(foo.Panel_city, "Button_curCity"):hide()
        foo.Button_curCity:Touchable(false)
        foo.Image_curCityTag = TFDirector:getChildByPath(foo.Button_curCity, "Image_curCityTag")
        foo.Label_curCityName = TFDirector:getChildByPath(foo.Button_curCity, "Label_curCityName")
        foo.Label_curCityName:setSkewX(15)
        self.Button_city[i] = foo
    end

    self:refreshView()
end

function SxBirthdayMainView:refreshView()
    self.Label_travel:setTextById(13310001)
    self.Label_store:setTextById(1454019)
    self:updateCity()
    self:updateTravelTips()
end

function SxBirthdayMainView:updateCity()
    local cityData = SxBirthdayDataMgr:getActivityCity()
    local Button_curCity
    local order = 0
    for i, v in ipairs(cityData) do
        local cityCfg = SxBirthdayDataMgr:getActivityCityCfg(v)
        local foo = self.Button_city[cityCfg.site]
        if foo then
            local isUnlock = SxBirthdayDataMgr:isUnlockCity(v)
            foo.Button_lockCity:setVisible(not isUnlock)
            foo.Button_unlockCity:setVisible(isUnlock)
            foo.Panel_city:show()
            foo.Label_unlockCityName:setTextById(cityCfg.title1)
            foo.Label_lockCityName:setTextById(cityCfg.title1)
            foo.Label_curCityName:setTextById(cityCfg.title1)
            foo.Image_cityIcon:setTexture(cityCfg.cityIcon)
            foo.Button_curCity:hide()

            foo.Image_cityIcon_lock:setVisible(not isUnlock)
            foo.Image_cityIcon:setVisible(isUnlock)

            local o = SxBirthdayDataMgr:getCityOrder(v)
            if o >= order then
                order = o
                Button_curCity = foo.Button_curCity
            end

            foo.root:onClick(function()
                    if isUnlock then
                        Utils:openView("activity.SxBirthdayCityView", v)
                    else
                        Utils:showTips(13300267)
                    end
            end)
        else
            Utils:showTips("地图上对应的点位:" .. cityCfg.site)
        end
    end

    if Button_curCity then
        Button_curCity:show()
    end
end

function SxBirthdayMainView:updateTravelTips()
    local isShow = ActivityDataMgr2:isShowRedPoint(self.activityId_)
    self.Image_travel_tips:setVisible(isShow)
end

function SxBirthdayMainView:registerEvents()
    EventMgr:addEventListener(self, EV_SXBIRTHDAY_CITYINFO_UPDATE, handler(self.onCityInfoUpdateEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))

    self.Button_travel:onClick(function()
            Utils:openView("activity.SxBirthdayTravelView")
    end)

    self.Button_store:onClick(function()
            FunctionDataMgr:jStore(302000)
    end)
end

function SxBirthdayMainView:onCityInfoUpdateEvent()
    self:updateCity()
end

function SxBirthdayMainView:onUpdateProgressEvent()
    self:updateTravelTips()
end

return SxBirthdayMainView
