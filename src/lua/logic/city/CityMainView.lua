
local CityMainView = class("CityMainView", BaseLayer)

function CityMainView:initData(entranceType)
    self.entranceType_ = entranceType
    self.enableCity_ = {}
    self.localUnlockBuild_ = {}
    self.upgradeFinishBuild_ = {}
    self.workFinishBuild_ = {}
    self.mapRatio_ = 1.5
    self.moveDuration_ = 0.25
    self.city_ = {}
    self.city_ = CityDataMgr:getCity()
end

function CityMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.cityMainView")
end

function CityMainView:initUI(ui)
	self.super.initUI(self, ui)
    self:showTopBar()


    TFAudio.stopMusic()
    TFAudio.playBmg("sound/bgm/city_001.mp3", true)

    self.Panel_movement = TFDirector:getChildByPath(ui, "Panel_movement")
    self.Panel_root = TFDirector:getChildByPath(self.Panel_movement, "Panel_rest.Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")

    local Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    self.Image_yuehui = TFDirector:getChildByPath(Panel_bottom, "Image_yuehui")
    self.Label_remainYuehui = TFDirector:getChildByPath(self.Image_yuehui, "Label_remainYuehui")
    self.Button_add = TFDirector:getChildByPath(self.Image_yuehui,"Button_add") -- 暂时屏蔽
    self:refreshRemainYuehui()

    self.Panel_cityItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_cityItem")

    self.Panel_city = TFDirector:getChildByPath(self.Panel_root, "Panel_city")
    self.Panel_cityPos = {}
    local index = 1
    while true do
        local root = TFDirector:getChildByPath(self.Panel_city, "Panel_cityPos_" .. index)
        if not root then break end
        local item = {}
        item.root = root:hide()
        item.root:setBackGroundColorType(0)
        local Panel_cityItem = self.Panel_cityItem:clone()
        Panel_cityItem:Pos(0, 0):AddTo(item.root)
        item.Image_lock = TFDirector:getChildByPath(Panel_cityItem, "Image_lock")
        item.Image_info = TFDirector:getChildByPath(Panel_cityItem, "Image_info")
        item.Button_name = TFDirector:getChildByPath(Panel_cityItem, "Button_name")
        item.Button_icon = TFDirector:getChildByPath(Panel_cityItem, "Button_icon")
        item.Label_name = TFDirector:getChildByPath(item.Button_name, "Label_name")
        item.Image_notice = TFDirector:getChildByPath(item.Button_name, "Image_notice")
        item.Image_icon = TFDirector:getChildByPath(item.Button_icon, "Image_icon")
        item.Button_dating = TFDirector:getChildByPath(Panel_cityItem, "Button_dating")
        item.Image_datingIcon = TFDirector:getChildByPath(item.Button_dating, "Image_datingIcon")
        item.Label_datingName = TFDirector:getChildByPath(item.Button_dating, "Label_datingName")
        item.Label_datingTime = TFDirector:getChildByPath(item.Button_dating, "Label_datingTime")
        self.Panel_cityPos[index] = item
        index = index + 1
    end

    self:refreshView()
end

function CityMainView:refreshRemainYuehui()
    local num = DatingDataMgr:getDayDatingTimes()
    self.Label_remainYuehui:setTextById(900034,tostring(num))

    if DatingDataMgr:getDayDatingMaxTimes() == num then
        self.Button_add:hide()
    else
        self.Button_add:show()
    end
end

function CityMainView:onBuySuccessEvent(event)
    self:refreshRemainYuehui()
    Utils:showTips(900211)
end

function CityMainView:refreshView()
    self:checkUpgradeFinishBuild()

    self.Image_yuehui:setVisible(self.entranceType_ == EC_CityEntranceType.DATING)
    for i, v in ipairs(self.city_) do
        local cityCfg = CityDataMgr:getCityCfg(v)
        local item = self.Panel_cityPos[cityCfg.order]
        item.root:show()
        item.Image_lock:hide()
        item.Image_notice:hide()
        item.Label_name:setTextById(cityCfg.nameId)
        item.Image_icon:setTexture(cityCfg.icon)
        item.Button_icon:setTextureNormal(cityCfg.iconbg)
        table.insert(self.enableCity_, item)
    end

    self:updateCityStatus()
    self:checkLocalUnlockBuild()
end

function CityMainView:onShow()
    self.super.onShow(self)

    for i, v in ipairs(self.upgradeFinishBuild_) do
        self:showUpgradeFinishView(v)
        table.remove(self.upgradeFinishBuild_, i)
        break
    end
end

function CityMainView:checkUpgradeFinishBuild()
    local buildInfo = CityDataMgr:getBuildInfo()
    for k, v in pairs(buildInfo) do
        if v.state == EC_BuildState.UPGRADE_FINISH then
            table.insert(self.upgradeFinishBuild_, v.cid)
        elseif v.state == EC_BuildState.WORK_FINISH then
            table.insert(self.workFinishBuild_, v.cid)
        end
    end
end

function CityMainView:updateCityStatus(cityId)
    local city = {}
    if cityId then
        table.insert(city, cityId)
    else
        city = self.city_
    end

    for i, v in ipairs(city) do
        local cityCfg = CityDataMgr:getCityCfg(v)
        local item = self.Panel_cityPos[cityCfg.order]
        local unlock = false
        local cityDatingInfo = DatingDataMgr:getCityDatingInfoByCityId(v)
        if cityCfg.buildType == EC_CityType.SPECIAL then
            unlock = tobool(cityDatingInfo)
            item.Image_lock:hide()
        else
            unlock = CityDataMgr:isCityUnlock(v)
            item.Image_lock:setVisible(not unlock)
        end
        item.Button_name:setVisible(unlock)
        item.Button_icon:setVisible(unlock)
        if unlock then
            local showRedPoint = CityDataMgr:isShowRedPoint(v)
            item.Image_notice:setVisible(showRedPoint)
        end
        if cityDatingInfo then
            if cityDatingInfo.uState == noDating and cityDatingInfo.datingType == EC_DatingScriptType.RESERVE_SCRIPT then
                item.Button_dating:hide()
            else
                self:refreshImageDating(item,v)
                item.Image_notice:hide()
            end
        else
            item.Button_dating:hide()
        end
    end
end


function CityMainView:refreshImageDating(item,cityId)


    item.Button_dating:show()

    local cityDatingInfo = DatingDataMgr:getCityDatingInfoByCityId(cityId)
    local datingType = cityDatingInfo.datingType
    local state = cityDatingInfo.state
    local uState = cityDatingInfo.uState
    local roleId = cityDatingInfo.roleId
    local date = cityDatingInfo.date

    local iconPath = RoleDataMgr:getSmallIconPath(roleId)
    local name = RoleDataMgr:getName(roleId)
    item.Image_datingIcon:setTexture(iconPath)
    item.Label_datingName:setText(name)



    if datingType == EC_DatingScriptType.RESERVE_SCRIPT then
        item.Label_datingTime:show()
        if uState == EC_CityDatingState.normal then
            item.Label_datingTime:setTextById(900054)
        elseif uState == EC_CityDatingState.accept then
            local timeStr = ""
            timeStr = timeStr .. string.format("%02d",cityDatingInfo.datingTimeFrame[1]) .. ":"
            timeStr = timeStr .. string.format("%02d",cityDatingInfo.datingTimeFrame[2]) .. "-"
            timeStr = timeStr .. string.format("%02d",cityDatingInfo.datingTimeFrame[3]) .. ":"
            timeStr = timeStr .. string.format("%02d",cityDatingInfo.datingTimeFrame[4]) .. ""
            item.Label_datingTime:setText(timeStr)
        elseif uState == EC_CityDatingState.overtime then
            item.Label_datingTime:setTextById(900302)
        elseif uState == EC_CityDatingState.noAccept then
            item.Label_datingTime:setTextById(900305)
        end
    else
        item.Label_datingTime:show()
        if datingType == EC_DatingScriptType.OUT_SCRIPT then
            item.Label_datingTime:setTextById(900303)
        elseif datingType == EC_DatingScriptType.WORK_SCRIPT then
            item.Label_datingTime:setTextById(900304)
        end

        -- item.Label_datingTime:hide()
    end
end

function CityMainView:checkLocalUnlockBuild()
    for i, v in ipairs(self.city_) do
        local build = CityDataMgr:getBuild(v)
        for _, id in ipairs(build) do
            if not CityDataMgr:isBuildUnlock(id) then
                if CityDataMgr:isBuildLocalUnlock(id) then
                    table.insert(self.localUnlockBuild_, id)
                end
            end
        end
    end

    if #self.localUnlockBuild_ > 0 then
        CityDataMgr:sendUnlockBuild(self.localUnlockBuild_)
    end
end

function CityMainView:setCityVisible(visible)
    visible = not (not visible)
    for i, v in ipairs(self.enableCity_) do
        v.root:setVisible(visible)
    end
end

function CityMainView:onClose()
    self.super.onClose(self)

end

function CityMainView:registerEvents()
    EventMgr:addEventListener(self, EV_CITY_UNLOCKBUILD_SUCCESS, handler(self.onUnlockBuildSuccessEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_FINISH, handler(self.onWorkingFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_GETREWARD, handler(self.onWorkingRewardEvent, self))
    EventMgr:addEventListener(self, EV_CITY_BUILD_UPGRADEFINISH, handler(self.onBuildUpgradeFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_INFO_CLOSE, handler(self.onInfoCloseEvent, self))
    EventMgr:addEventListener(self, EV_STORE_BUYRESOURCE, handler(self.onBuySuccessEvent, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.cityDatingTips,handler(self.onRefreshCityDatingTipsEvent,self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.datingOverTime, handler(self.onDatingFailEvent,self))

    self:setBackBtnCallback(function()
            local entranceType = self.entranceType_
            AlertManager:close()
            if entranceType == EC_CityEntranceType.DATING then
                AlertManager:changeScene(SceneType.DATING)
            end
    end)

    for i, v in ipairs(self.enableCity_) do
        v.Button_icon:onClick(function()
                self:popupBuildInfo(i)
        end)
        v.Button_name:onClick(function()
                self:popupBuildInfo(i)
        end)
        v.Button_dating:onClick(function()
                self:popupBuildInfo(i)
        end)
        v.Image_lock:onClick(function()
            if v.Image_lock:isVisible() == true and self.entranceType_ == EC_CityEntranceType.DATING then
                return
            end
            self:popupBuildInfo(i)
        end)
    end

    self.Button_add:onClick(function()

        local itemCfg = GoodsDataMgr:getItemCfg(EC_SItemType.DAYDATINGTIMES)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("dating.BuyDatingTimesView", itemCfg.id)
        else
            Utils:showTips(900210)
        end
    end)
end

function CityMainView:moveToCity(isBack, index)
    local flag = 1
    if isBack then
        flag = -1
    end
    local offsetPos = self.offsetMovePos_
    local ratio = (self.mapRatio_ - 1) * 0.5
    self.Panel_city:moveBy(self.moveDuration_, offsetPos.x * flag, offsetPos.y * flag)
    self.Image_bg:moveBy(self.moveDuration_, offsetPos.x * ratio * flag, offsetPos.y * ratio * flag)

    if not isBack then
        self.Panel_root:timeOut(
            function()
                self:popupBuildInfo(index)
            end,
            self.moveDuration_)
    end
end

function CityMainView:showUpgradeFinishView(buildId)
    local buildLevelUpView = require("lua.logic.city.BuildLevelUpView"):new(buildId)
    AlertManager:addLayer(buildLevelUpView)
    AlertManager:show()
end

function CityMainView:onCityTouch(index)
    self:setBuildTouchEanbled(false)

    -- 计算移动距离
    local item = self.enableCity_[index]
    local size = self.Panel_root:Size()
    local centerPos = ccp(size.width * 0.5, size.height * 0.5)
    local buildPos = item.root:Pos()
    self.offsetMovePos_ = ccpSub(centerPos, buildPos)

    self:moveToCity(false, index)
end

function CityMainView:setBuildTouchEanbled(enabled)
    for i, v in ipairs(self.enableCity_) do
        v.Button_icon:setTouchEnabled(enabled)
    end
end

function CityMainView:popupBuildInfo(index)
    self:setBuildTouchEanbled(true)

    local cityId = self.city_[index]
    local cityCfg = CityDataMgr:getCity(cityId)

    local cityDatingInfo = DatingDataMgr:getCityDatingInfoByCityId(cityId)
    -- EC_CityDatingState = {
    --     noDating = 0,--无约会（邀请已过）
    --     noAccept = 1,--有邀请未接受
    --     accept = 2, --接受邀请
    --     normal = 3, --正常约会
    --     overtime = 4 --约会超时（预约的时间已过）
    -- }

    if cityDatingInfo then
        if cityDatingInfo.datingType == EC_DatingScriptType.RESERVE_SCRIPT then
            if cityDatingInfo.uState == EC_CityDatingState.noAccept then
                DatingDataMgr:showReserveAcceptLayer(cityDatingInfo.datingRuleCid)
                return
            elseif cityDatingInfo.state == EC_DatingScriptState.TRIGGER or cityDatingInfo.state == EC_DatingScriptState.NORMAL then
                DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,cityId,cityDatingInfo.cityDatingId)
                return
            end
        else
            DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,cityId,cityDatingInfo.cityDatingId)
            return
        end
    end
    self:setCityVisible(false)
    local cityInfoView = requireNew("lua.logic.city.CityInfoView"):new(cityId)
    AlertManager:addLayer(cityInfoView, AlertManager.BLOCK)
    AlertManager:show()
end

function CityMainView:onDatingFailEvent()
    self:showFailDatingLayer()
end

function CityMainView:showFailDatingLayer()
    local cityDatingInfo = DatingDataMgr:getReserveFailScript(true)
    if cityDatingInfo then
        DatingDataMgr:sendGetSciptMsg(cityDatingInfo.datingType,nil,nil,nil,nil,cityDatingInfo.cityDatingId)
    end
end

function CityMainView:onUnlockBuildSuccessEvent(buildId)
    for i, v in ipairs(buildId) do
        local buildCfg = CityDataMgr:getBuildCfg(v)
        self:updateCityStatus(buildCfg.cityId)
    end

    Utils:openView("city.BuildUnlockView", buildId)
end

function CityMainView:onWorkingFinishEvent(buildId)
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    self:updateCityStatus(buildCfg.cityId)
end

function CityMainView:onWorkingRewardEvent(buildId)
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    self:updateCityStatus(buildCfg.cityId)
end

function CityMainView:onBuildUpgradeFinishEvent(buildId)
    if AlertManager:getTopLayer() == self then
        self:showUpgradeFinishView(buildId)
    end
end

function CityMainView:onInfoCloseEvent()
    self:setCityVisible(true)
end

function CityMainView:onRefreshCityDatingTipsEvent(event)
    self:updateCityStatus()
end

return CityMainView
