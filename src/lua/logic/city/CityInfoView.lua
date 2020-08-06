
local CityInfoView = class("CityInfoView", BaseLayer)

function CityInfoView:initData(cityId)
    self.cityId_ = cityId
    self.build_ = CityDataMgr:getBuild(cityId)
    self.cityCfg_ = CityDataMgr:getCityCfg(cityId)

    self.countDownTimer_ = nil
    self.closeFlag_ = true
    self.buildItem_ = {}
end

function CityInfoView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.cityInfoView")
end

function CityInfoView:initUI(ui)
	self.super.initUI(self, ui)
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    local Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    self.Image_desc = TFDirector:getChildByPath(Panel_bottom, "Image_desc")
    self.Image_cityIcon = TFDirector:getChildByPath(self.Image_desc, "Image_cityIcon")
    self.Label_desc = TFDirector:getChildByPath(self.Image_desc, "Label_desc")

    self.Panel_clip = TFDirector:getChildByPath(self.Panel_root, "Panel_clip")
    self.Image_cityBg = TFDirector:getChildByPath(self.Panel_clip, "Image_cityBg")
    self.Image_cityName = TFDirector:getChildByPath(self.Panel_clip, "Image_cityName")
    self.Label_cityName = TFDirector:getChildByPath(self.Image_cityName, "Label_cityName")

    local ScrollView_build = TFDirector:getChildByPath(self.Panel_root, "ScrollView_build")
    self.ListView_build = UIListView:create(ScrollView_build)

    self.Panel_buildItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_buildItem")

    self:refreshView()
end

function CityInfoView:refreshView()
    self.Label_desc:setTextById(self.cityCfg_.describe)
    self.Image_cityBg:setTexture(self.cityCfg_.wallPaper)
    self.Label_cityName:setTextById(self.cityCfg_.nameId)

    for i, v in ipairs(self.build_) do
        local item = self:addBuildItem()
        self:updateBuildItem(item, v)
    end
    self:updateCountDonwIetm()

    local size = self.Image_desc:Size()
    self.Image_desc:PosX(self.Image_desc:PosX() -size.width)
    self.Image_desc:Alpha(0)
    self.Image_desc:moveBy(0.3, size.width, 0)
    self.Image_desc:fadeIn(0.4)

    local size = self.ListView_build:s():Size()
    local duration = 0
    for i, v in ipairs(self.ListView_build:getItems()) do
        v:hide()
        duration = duration + 0.1
        local seq = Sequence:create({
            DelayTime:create(duration),
            CallFunc:create(function()
                    v:show()
                    v:PosX(v:PosX() + size.width)
            end),
            MoveBy:create(0.15, ccp(-size.width, 0))
        })
        v:runAction(seq)
    end

    local clippingNode = CCClippingNode:create()
    local stencil = Sprite:create("scene/bg/bg_cityMask.png")
    clippingNode:setStencil(stencil)
    clippingNode:setAlphaThreshold(0.05)
    self.Image_cityBg:retain()
    self.Image_cityBg:removeFromParent()
    clippingNode:addChild(self.Image_cityBg)
    self.Image_cityBg:release()
    self.Panel_clip:addChild(clippingNode, 1)
    local unlock = CityDataMgr:isCityUnlock(self.cityId_)
    self.Image_cityBg:setGrayEnabled(not unlock)

    local size = self.Panel_clip:Size()
    self.Panel_clip:PosY(self.Panel_clip:PosY() + size.height)
    self.Panel_clip:PosX(self.Panel_clip:PosX() + size.width)
    self.Panel_clip:moveBy(0.4, -size.width, -size.height)
end

function CityInfoView:addBuildItem()
    local Panel_buildItem = self.Panel_buildItem:clone()
    local item = {}
    item.root = Panel_buildItem
    item.Button_build = TFDirector:getChildByPath(item.root, "Button_build")
    item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
    item.Panel_lock = TFDirector:getChildByPath(item.root, "Panel_lock")
    item.Label_name_lock = TFDirector:getChildByPath(item.Panel_lock, "Image_info.Label_name_lock")
    item.Label_lockTip = TFDirector:getChildByPath(item.Panel_lock, "Label_lockTip")
    item.Panel_unlock = TFDirector:getChildByPath(item.root, "Panel_unlock")
    item.Label_level_unlock = TFDirector:getChildByPath(item.Panel_unlock, "Image_info.Label_level_unlock")
    item.Label_name_unlock = TFDirector:getChildByPath(item.Panel_unlock, "Image_info.Label_name_unlock")
    item.Panel_free = TFDirector:getChildByPath(item.Panel_unlock, "Panel_free")
    item.Label_free = TFDirector:getChildByPath(item.Panel_free, "Label_free")
    item.Panel_work = TFDirector:getChildByPath(item.Panel_unlock, "Panel_work")
    item.Label_workCountDown = TFDirector:getChildByPath(item.Panel_work, "Label_workCountDown")
    item.Image_workHead = {}
    for i = 1, 3 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(item.Panel_work, "Image_workHead_" .. i)
        foo.Image_default = TFDirector:getChildByPath(foo.root, "Image_default")
        foo.Image_icon = TFDirector:getChildByPath(foo.root, "Image_icon")
        item.Image_workHead[i] = foo
    end
    item.Panel_upgrade = TFDirector:getChildByPath(item.Panel_unlock, "Panel_upgrade")
    item.Label_upgradeCountDown = TFDirector:getChildByPath(item.Panel_upgrade, "Label_upgradeCountDown")
    item.Panel_gain = TFDirector:getChildByPath(item.Panel_unlock, "Panel_gain")

    self.buildItem_[Panel_buildItem] = item
    self.ListView_build:pushBackCustomItem(Panel_buildItem)

    return Panel_buildItem
end

function CityInfoView:updateBuildItem(item, buildId)
    local foo = self.buildItem_[item]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local unlock = CityDataMgr:isBuildUnlock(buildId)

    foo.Label_free:setTextById(500031)
    foo.Label_name_unlock:setTextById(buildCfg.nameId)
    foo.Label_name_lock:setTextById(buildCfg.nameId)
    foo.Button_build:setTextureNormal(buildCfg.icon)
    foo.Panel_unlock:setVisible(unlock)
    foo.Panel_lock:setVisible(not unlock)
    foo.Button_build:setGrayEnabled(not unlock)
    foo.Button_build:setTouchEnabled(unlock)

    if unlock then
        local buildInfo = CityDataMgr:getBuildInfo(buildId)
        foo.Label_level_unlock:setTextById(500001, buildCfg.level)
        foo.Panel_free:setVisible(buildInfo.state == EC_BuildState.FREE)
        foo.Panel_work:setVisible(buildInfo.state == EC_BuildState.WORK)
        foo.Panel_upgrade:setVisible(buildInfo.state == EC_BuildState.UPGRADE)
        foo.Panel_gain:setVisible(buildInfo.state == EC_BuildState.WORK_FINISH)

        if buildInfo.state == EC_BuildState.UPGRADE then
            local remainTime = math.max(0, buildInfo.finishTime - ServerDataMgr:getServerTime())
            local _, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            foo.Label_upgradeCountDown:setTextById(500023, hour, min)
        elseif buildInfo.state == EC_BuildState.WORK then
            local remainTime = math.max(0, buildInfo.finishTime - ServerDataMgr:getServerTime())
            local _, hour, min = Utils:getFuzzyDHMS(remainTime, true)
            foo.Label_workCountDown:setTextById(500023, hour, min)
            local workingRole = buildInfo.roleIds
            for i, v in ipairs(foo.Image_workHead) do
                local roleSid = workingRole[i]
                v.Image_default:setVisible(not tobool(roleSid))
                v.Image_icon:setVisible(tobool(roleSid))
                if roleSid then
                    local roleCid = RoleDataMgr:getRoleIdBySid(roleSid)
                    local moodIcon = RoleDataMgr:getMoodIcon(roleCid)
                    v.Image_icon:setTexture(moodIcon)
                end
            end
        elseif buildInfo.state == EC_BuildState.GAIN then

        end
    else
        local text = CityDataMgr:getBuildUnlockCondText(buildId)
        foo.Label_lockTip:setText(text)
    end

    foo.Button_build:onClick(function()
        if CatchDollDataMgr:getGameBuildId() == buildCfg.buildId then
            CatchDollDataMgr:goCatchDoll()
            return
        end

        local view = requireNew("lua.logic.city.CityWorkView"):new(buildId)
        AlertManager:close()
        AlertManager:addLayer(view, AlertManager.BLOCK)
        AlertManager:show()
    end)
end

function CityInfoView:openCatchDoll()
    AlertManagers:changeScene(SceneType.CATCHDOLL)
end

function CityInfoView:getCountDownIndex()
    local countDownIndex = {}
    for i, v in ipairs(self.build_) do
        local unlock = CityDataMgr:isBuildUnlock(v)
        if unlock then
            local buildInfo = CityDataMgr:getBuildInfo(v)
            if buildInfo.state == EC_BuildState.UPGRADE or buildInfo.state == EC_BuildState.WORK then
                table.insert(countDownIndex, i)
            end
        end
    end
    return countDownIndex
end

function CityInfoView:updateAllBuildItem()
    self.build_ = CityDataMgr:getBuild(self.cityId_)
    for i, v in ipairs(self.build_) do
        self:updateBuildItem(self.ListView_build:getItem(i), v)
    end
    self:updateCountDonwIetm()
end

function CityInfoView:updateCountDonwIetm()
    local countDownIndex = self:getCountDownIndex()
    if #countDownIndex > 0 then
        self:addCountDownTimer()
    else
        self:removeCountDownTimer()
    end
end

function CityInfoView:addCountDownTimer()
    self:removeCountDownTimer()
    self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
end

function CityInfoView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
        self.countDownTimer_ = nil
    end
end

function CityInfoView:onCountDownPer()
    local countDownIndex = self:getCountDownIndex()
    if #countDownIndex == 0 then
        self:removeCountDownTimer()
    else
        for i, v in ipairs(countDownIndex) do
            local buildId = self.build_[v]
            local item = self.ListView_build:getItem(v)
            self:updateBuildItem(item, buildId)
        end
    end
end

function CityInfoView:registerEvents()
    EventMgr:addEventListener(self, EV_CITY_BUILD_BEGIN_UPGRADE, handler(self.onBuildBeginUpgradeEvent, self))
    EventMgr:addEventListener(self, EV_CITY_BUILD_UPGRADEFINISH, handler(self.onBuildUpgradeFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_BUILD_UPDATE, handler(self.onBuildUpdateEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_FINISH, handler(self.onWorkingFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_BEGIN, handler(self.onWorkingBeginEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_GETREWARD, handler(self.onWorkingRewardEvent, self))
    EventMgr:addEventListener(self, EV_CATCHDOLL_POOL_INFO,handler(self.openCatchDoll, self));

    self:setBackBtnCallback(function()
            AlertManager:close()
            EventMgr:dispatchEvent(EV_CITY_INFO_CLOSE)
    end)
end

function CityInfoView:removeEvents()
    self:removeCountDownTimer()
end

function CityInfoView:playAni(visible)
    self.Image_cityBg:setVisible(true)
    self.Image_name:setVisible(visible)
    self.Image_desc:setVisible(visible)
    self.Panel_root:setTouchEnabled(false)

    local size = self.Panel_right:getSize()
    local flag = visible and -1 or 1
    local seq = Sequence:create({
            Show:create(),
            EaseSineOut:create(MoveBy:create(0.2, ccp(flag * size.width, 0))),
            CallFunc:create(function()
                    if visible then
                        self.Panel_root:setTouchEnabled(true)
                    else
                        self:playBuildCloseAni()
                    end
            end)
    })
    self.Panel_right:runAction(seq)
end

function CityInfoView:playBuildCloseAni()
    local size = self.aniNode_:getSize()
    local wp = self.aniNode_:convertToWorldSpace(ccp(size.width * 0.5, size.height * 0.5))
    local np = self.Image_cityBg:getParent():convertToNodeSpace(wp)

    local duration = 0.25
    local spawn = Spawn:create({
            ScaleTo:create(duration, 0.17),
            MoveTo:create(duration, np)
    })
    local seq = Sequence:create({
            spawn,
            RemoveSelf:create(),
            CallFunc:create(function()
                    AlertManager:close()
            end)
    })
    self.Image_cityBg:runAction(seq)
end

function CityInfoView:onTransformCompleteEvent(aniNode)
    self.aniNode_ = aniNode
    self:playAni(true)
end

function CityInfoView:onBuildBeginUpgradeEvent(buildId)
    self:updateAllBuildItem()
end

function CityInfoView:onBuildUpgradeFinishEvent(buildId)
    self:updateAllBuildItem()
    if AlertManager:getTopLayer() == self then
        local buildLevelUpView = require("lua.logic.city.BuildLevelUpView"):new(buildId)
        AlertManager:addLayer(buildLevelUpView)
        AlertManager:show()
    end
end

function CityInfoView:onBuildUpdateEvent(buildId)
    self:updateAllBuildItem()
end

function CityInfoView:onWorkingFinishEvent(buildId)
    self:updateAllBuildItem()
end

function CityInfoView:onWorkingBeginEvent(buildId)
    self:updateAllBuildItem()
end

function CityInfoView:onWorkingRewardEvent(buildId)
    self:updateAllBuildItem()
end

return CityInfoView
