
local SxBirthdayMainView = class("SxBirthdayMainView", BaseLayer)

local BUTTON_TYPE = {
	LOCK	= "ui/activity/sx_birthday/main/SXSR_bg1.png",
	UNLOCK	= "ui/activity/sx_birthday/main/SXSR_bg2.png",
	SELECT	= "ui/activity/sx_birthday/main/SXSR_bg3.png"
}

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

    self.Button_travel = TFDirector:getChildByPath(ui, "Button_travel")
    self.Image_travel_tips = TFDirector:getChildByPath(self.Button_travel, "Image_travel_tips")
    
    self.Button_store = TFDirector:getChildByPath(ui, "Button_store")



    self.Button_city = {}
    for i = 1, 5 do
        local foo = {}
        foo.btn = TFDirector:getChildByPath(self.Panel_root, "Button_" .. i)
		foo.btn:setTextureNormal(BUTTON_TYPE.LOCK)
		foo.Image_cityIcon =  TFDirector:getChildByPath(foo.btn, "Image_cityIcon")
        foo.Label_CityName = TFDirector:getChildByPath(foo.btn, "Label_CityName")
        foo.Label_CityName:setSkewX(15)
        self.Button_city[i] = foo
    end

    self:refreshView()
end

function SxBirthdayMainView:refreshView()
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
			foo.btn:setTextureNormal(isUnlock and BUTTON_TYPE.UNLOCK or BUTTON_TYPE.LOCK)
     
            foo.Label_CityName:setTextById(cityCfg.title1)
            foo.Image_cityIcon:setTexture(cityCfg.cityIcon)

            local o = SxBirthdayDataMgr:getCityOrder(v)
            if o >= order then
                order = o
                Button_curCity = foo.btn
            end

            foo.btn:onClick(function()
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
        Button_curCity:setTextureNormal(BUTTON_TYPE.SELECT)
    end
end

function SxBirthdayMainView:onReconnect()
    SxBirthdayDataMgr:send_BIRTH_DAY_REQ_TEN_BIRTH_DAY_INFO()
end

function SxBirthdayMainView:updateTravelTips()
    local isShow = ActivityDataMgr2:isShowRedPoint(self.activityId_)
    self.Image_travel_tips:setVisible(isShow)
end

function SxBirthdayMainView:registerEvents()
    EventMgr:addEventListener(self, EV_RECONECT_EVENT, handler(self.onReconnect, self))
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
