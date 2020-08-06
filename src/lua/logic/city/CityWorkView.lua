
local CityWorkView = class("CityWorkView", BaseLayer)

function CityWorkView:initData(buildId)
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    self.cityId_ = buildCfg.cityId
    self.build_ = CityDataMgr:getBuild(self.cityId_)
    self.cityCfg_ = CityDataMgr:getCityCfg(self.cityId_)
    self.defaultSelectIndex_ = 1
    local index = table.indexOf(self.build_, buildId)
    if index ~= -1 then
        self.defaultSelectIndex_ = index
    end
    self.buildItem_ = {}
    self.featureList_ = {}
    self.enableButton_ = {}
    self.selectFeatureIndex_ = nil
    self.selectBuildIndex_ = nil
    self.countDownTimer_ = nil
    self.workingRole_ = {}
    self.popAniFinish_ = true
    self.popupToggle_ = false

    self.featureConfig_ = {
        [EC_BuildFeatureType.WORK] = {
            icon = "icon/system/112.png",
        },
        [EC_BuildFeatureType.SHOP] = {
            icon = "icon/system/111.png",
        },
        [EC_BuildFeatureType.UPGRADE] = {
            icon = "icon/system/113.png",
        },
    }
end

function CityWorkView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.city.cityWorkView")
end

function CityWorkView:initUI(ui)
	self.super.initUI(self, ui)
    self:showTopBar()

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_buildList = TFDirector:getChildByPath(self.Panel_root, "Panel_buildList")
    local ScrollView_build= TFDirector:getChildByPath(self.Panel_buildList, "ScrollView_build")
    self.ListView_build= UIListView:create(ScrollView_build)
    self.ListView_build_size = self.ListView_build:s():Size()

    self.Panel_content = TFDirector:getChildByPath(self.Panel_root, "Panel_content")

    local Panel_bottom = TFDirector:getChildByPath(self.Panel_root, "Panel_bottom")
    local Image_func = TFDirector:getChildByPath(Panel_bottom, "Image_func")
    self.Panel_func = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(Panel_bottom, "Panel_func_" .. i)
        item.Image_normal = TFDirector:getChildByPath(item.root, "Image_normal")
        item.Image_select = TFDirector:getChildByPath(item.root, "Image_select")
        item.Label_name = TFDirector:getChildByPath(item.root, "Label_name")
        item.Image_icon = TFDirector:getChildByPath(item.root, "Image_icon")
        item.Image_touch = TFDirector:getChildByPath(item.root, "Image_touch")
        self.Panel_func[i] = item
    end
    self.Button_buildList = TFDirector:getChildByPath(self.Panel_content, "Button_buildList")
    self.Label_buildName = TFDirector:getChildByPath(self.Panel_content, "Image_buildName.Label_buildName")
    self.Label_buildLevel = TFDirector:getChildByPath(self.Panel_content, "Image_buildLevel.Label_buildLevel")
    self.Image_buildBg = TFDirector:getChildByPath(self.Panel_content, "Image_buildBg")
    self.Panel_touchMask = TFDirector:getChildByPath(self.Panel_content, "Panel_touchMask"):hide()

    -- 打工
    self.Panel_working = TFDirector:getChildByPath(self.Panel_content, "Panel_working")
    -- 打工要求
    self.Panel_working_pre = TFDirector:getChildByPath(self.Panel_working, "Panel_working_pre")
    self.Button_member = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_working_pre, "Button_member_" .. i)
        item.Image_lock = TFDirector:getChildByPath(item.root, "Image_lock")
        item.Panel_unlock = TFDirector:getChildByPath(item.root, "Panel_unlock")
        item.Image_frame = TFDirector:getChildByPath(item.Panel_unlock, "Image_frame")
        item.Image_icon = TFDirector:getChildByPath(item.Panel_unlock, "Image_icon")
        local Image_name = TFDirector:getChildByPath(item.Panel_unlock, "Image_name")
        item.Label_name = TFDirector:getChildByPath(Image_name, "Label_name")
        self.Button_member[i] = item
    end
    self.Button_working = TFDirector:getChildByPath(self.Panel_working_pre, "Button_working")
    self.Label_workingCostTime = TFDirector:getChildByPath(self.Panel_working_pre, "Label_workingCostTime")
    self.Panel_cond = {}
    self.Panel_workingCond = {}
    for i = 1, 3 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_working_pre, "Panel_workingCond_" .. i)
        item.Label_cond_notReach = TFDirector:getChildByPath(item.root, "Label_cond_notReach")
        item.Label_cond_reach = TFDirector:getChildByPath(item.root, "Label_cond_reach")
        item.Image_tag_notReach = TFDirector:getChildByPath(item.root, "Image_tag_notReach")
        item.Image_tag_reach = TFDirector:getChildByPath(item.root, "Image_tag_reach")
        self.Panel_workingCond[i] = item
    end
    -- 打工中
    self.Panel_working_ing = TFDirector:getChildByPath(self.Panel_working, "Panel_working_ing")
    self.Panel_workKanbanNiang = TFDirector:getChildByPath(self.Panel_working_ing, "Panel_workKanbanNiang")
    self.Panel_workKanbanNiang:setBackGroundColorType(0)
    self.Button_gain = TFDirector:getChildByPath(self.Panel_working_ing, "Button_gain")
    self.Label_workingCountDown = TFDirector:getChildByPath(self.Panel_working_ing, "Image_workingLog.Label_workingCountDown")
    local Image_workingScrollBar = TFDirector:getChildByPath(self.Panel_working_ing, "Image_workingScrollBar")
    local Image_workingScrollBarInner = TFDirector:getChildByPath(Image_workingScrollBar, "Image_workingScrollBarInner")
    local scrollBar = UIScrollBar:create(Image_workingScrollBar, Image_workingScrollBarInner)
    local ScrollView_workingLog = TFDirector:getChildByPath(self.Panel_working_ing, "ScrollView_workingLog")
    self.ListView_workingLog = UIListView:create(ScrollView_workingLog)
    self.ListView_workingLog:setScrollBar(scrollBar)

    -- 商店
    self.Panel_shop = TFDirector:getChildByPath(self.Panel_content, "Panel_shop")

    self.Label_shopCountDown = TFDirector:getChildByPath(self.Panel_shop, "Image_shopTitle.Label_shopCountDown")
    local ScrollView_shop = TFDirector:getChildByPath(self.Panel_shop, "ScrollView_shop")
    self.ListView_shop = UIListView:create(ScrollView_shop)
    self.Panel_shopKanbanNiang= TFDirector:getChildByPath(self.Panel_shop, "Panel_shopKanbanNiang")
    self.Panel_shopKanbanNiang:setBackGroundColorType(0)

    -- 升级
    self.Panel_upgrade = TFDirector:getChildByPath(self.Panel_content, "Panel_upgrade")
    -- 升级要求
    self.Panel_upgrade_pre = TFDirector:getChildByPath(self.Panel_upgrade, "Panel_upgrade_pre")
    local Image_cond = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Image_cond")
    self.Label_upgradeCond = {}
    self.Panel_upgradeCond = {}
    for i = 1, 2 do
        local item = {}
        item.root = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Panel_upgradeCond_" .. i)
        item.Label_upgradeCond_reach = TFDirector:getChildByPath(item.root, "Label_upgradeCond_reach")
        item.Label_upgradeCond_notReach = TFDirector:getChildByPath(item.root, "Label_upgradeCond_notReach")
        self.Panel_upgradeCond[i] = item
    end
    local ScrollView_upgradeCond = TFDirector:getChildByPath(Image_cond, "ScrollView_upgradeCond")
    self.ListView_upgradeCond = UIListView:create(ScrollView_upgradeCond)
    self.ListView_upgradeCond:setItemsMargin(10)
    self.Label_upgradeCostTime = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Label_upgradeCostTime")
    local Image_product = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Image_product")
    local ScrollView_curProduct = TFDirector:getChildByPath(Image_product, "ScrollView_curProduct")
    self.ListView_curProduct = UIListView:create(ScrollView_curProduct)
    self.ListView_curProduct:setItemsMargin(5)
    local ScrollView_newProduct = TFDirector:getChildByPath(Image_product, "ScrollView_newProduct")
    self.ListView_newProduct = UIListView:create(ScrollView_newProduct)
    self.ListView_newProduct:setItemsMargin(10)
    self.Label_upgradeDesc = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Label_upgradeDesc")
    self.Button_upgrade = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Button_upgrade")
    self.Label_upgrade = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Label_upgrade")
    self.Panel_upgradeCostMoney = TFDirector:getChildByPath(self.Panel_upgrade_pre, "Panel_upgradeCostMoney")
    self.Image_upgradeCostMoneyIcon = TFDirector:getChildByPath(self.Panel_upgradeCostMoney, "Image_upgradeCostMoneyIcon")
    self.Label_upgradeCostMoneyNum_enough = TFDirector:getChildByPath(self.Panel_upgradeCostMoney, "Label_upgradeCostMoneyNum_enough")
    self.Label_upgradeCostMoneyNum_notEnough = TFDirector:getChildByPath(self.Panel_upgradeCostMoney, "Label_upgradeCostMoneyNum_notEnough")

    self.Panel_upgrade_ing = TFDirector:getChildByPath(self.Panel_upgrade, "Panel_upgrade_ing")
    self.Label_upgradCountDown = TFDirector:getChildByPath(self.Panel_upgrade_ing, "Image_upgrade.Image_upgradCountDown.Label_upgradCountDown")

    self.Panel_productItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_productItem")
    self.Panel_upgradeCondItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_upgradeCondItem")
    self.Panel_shopItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_shopItem")
    self.Panel_workLogItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_workLogItem")
    self.Panel_buildItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_buildItem")

    self:refreshView()
end

function CityWorkView:refreshView()
    for i, v in ipairs(self.build_) do
        local item = self:addBuildItem()
        self:updateBuildItem(item, i)
    end

    self:selectBuild(self.defaultSelectIndex_)
    self:addCountDownTimer()
end

function CityWorkView:onShow()
    self.super.onShow(self)
    self:updateFeature()
end

function CityWorkView:addBuildItem()
    local item = self.Panel_buildItem:clone()
    local foo = {}
    foo.root = item
    foo.Image_build = TFDirector:getChildByPath(foo.root, "Image_build")
    foo.Panel_lock = TFDirector:getChildByPath(foo.root, "Panel_lock")
    foo.Label_lockTip = TFDirector:getChildByPath(foo.Panel_lock, "Label_lockTip")
    foo.Label_name_lock = TFDirector:getChildByPath(foo.Panel_lock, "Image_name_lock.Label_name_lock")
    foo.Panel_unlock = TFDirector:getChildByPath(foo.root, "Panel_unlock")
    foo.Image_select = TFDirector:getChildByPath(foo.Panel_unlock, "Image_select")
    foo.Image_name_normal = TFDirector:getChildByPath(foo.Panel_unlock, "Image_name_normal")
    foo.Label_name_normal = TFDirector:getChildByPath(foo.Image_name_normal, "Label_name_normal")
    foo.Image_name_select = TFDirector:getChildByPath(foo.Panel_unlock, "Image_name_select")
    foo.Label_name_select = TFDirector:getChildByPath(foo.Image_name_select, "Label_name_select")
    foo.Panel_free = TFDirector:getChildByPath(foo.Panel_unlock, "Panel_free")
    foo.Label_free = TFDirector:getChildByPath(foo.Panel_free, "Label_free")
    foo.Panel_work = TFDirector:getChildByPath(foo.Panel_unlock, "Panel_work")
    foo.Label_workCountDown = TFDirector:getChildByPath(foo.Panel_work, "Label_workCountDown")
    foo.Image_workHead = {}
    for i = 1, 3 do
        local bar = {}
        bar.root = TFDirector:getChildByPath(foo.Panel_work, "Image_workHead_" .. i)
        bar.Image_default = TFDirector:getChildByPath(bar.root, "Image_default")
        bar.Image_icon = TFDirector:getChildByPath(bar.root, "Image_icon")
        foo.Image_workHead[i] = bar
    end
    foo.Panel_upgrade = TFDirector:getChildByPath(foo.Panel_unlock, "Panel_upgrade")
    foo.Label_upgradeCountDown = TFDirector:getChildByPath(foo.Panel_upgrade, "Label_upgradeCountDown")
    foo.Panel_gain = TFDirector:getChildByPath(foo.Panel_unlock, "Panel_gain")

    self.buildItem_[item] = foo
    self.ListView_build:pushBackCustomItem(item)
    return item
end

function CityWorkView:updateAllBuildItem()
    for i, v in ipairs(self.ListView_build:getItems()) do
        self:updateBuildItem(v, i)
    end
    self:selectBuild(self.selectBuildIndex_, true)
end

function CityWorkView:updateBuildItem(item, index)
    local buildId = self.build_[index]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local unlock = CityDataMgr:isBuildUnlock(buildId)
    local foo = self.buildItem_[item]

    foo.Panel_unlock:setVisible(unlock)
    foo.Panel_lock:setVisible(not unlock)
    if unlock then
        local buildInfo = CityDataMgr:getBuildInfo(buildId)
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

    foo.Image_build:setTexture(buildCfg.icon)
    foo.Image_build:setGrayEnabled(not unlock)
    foo.Label_name_normal:setTextById(buildCfg.nameId)
    foo.Label_name_select:setTextById(buildCfg.nameId)
    foo.Label_name_lock:setTextById(buildCfg.nameId)

    foo.root:onClick(function()
            if unlock then
                self:selectBuild(index)
            end
    end)
end

function CityWorkView:selectBuild(index, force)
    if self.selectBuildIndex_ == index and not force then return end
    self.selectBuildIndex_ = index
    self:popupBuldList(false)
    self.workingRole_ = {}

    for i, v in ipairs(self.ListView_build:getItems()) do
        local isSelect = (i == index)
        local foo = self.buildItem_[v]
        foo.Image_name_normal:setVisible(not isSelect)
        foo.Image_name_select:setVisible(isSelect)
        foo.Image_select:setVisible(isSelect)
        if isSelect then
            foo.root:setScale(1.0)
        else
            foo.root:setScale(0.9)
        end
    end

    self:showFeatureList()
    if #self.featureList_ > 0 then
        if force then
            self:selectFeature(self.selectFeatureIndex_, true)
        else
            self.selectFeatureIndex_ = nil
            self:selectFeature(1)
        end
    end
end

function CityWorkView:showFeatureList()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    self.featureList_ = {}
    self.enableButton_ = {}
    local btnText = {}
    local btnIcon = {}

    if buildCfg.isLevelUp then
        table.insert(self.featureList_, EC_BuildFeatureType.UPGRADE)
        btnText[EC_BuildFeatureType.UPGRADE] = buildCfg.upGradeTips
    end
    if buildCfg.isWork then
        table.insert(self.featureList_, EC_BuildFeatureType.WORK)
        btnText[EC_BuildFeatureType.WORK] = buildCfg.workTips
    end
    if buildCfg.isShop then
        table.insert(self.featureList_, EC_BuildFeatureType.SHOP)
        btnText[EC_BuildFeatureType.SHOP] = buildCfg.shopTips

        if buildCfg.shopType ~= 0 then
            local storeInfo = StoreDataMgr:getStoreInfo(buildCfg.shopType)
            if not storeInfo then
                CityDataMgr:requestShopInfo(buildId)
            end
        end
    end
    table.sort(self.featureList_, function(a, b)
                   return a < b
    end)

    local index = math.max(0, #self.Panel_func - #self.featureList_)
    for i, v in ipairs(self.Panel_func) do
        if i > index then
            v.root:show()
            table.insert(self.enableButton_, v)
        else
            v.root:hide()
        end
    end

    for i, v in ipairs(self.enableButton_) do
        local feature = self.featureList_[i]
        local featureCfg = self.featureConfig_[feature]
        if feature == EC_BuildFeatureType.SHOP then
            local enabled = buildCfg.shopType ~= 0
            Utils:setNodeGray(v.root, not enabled)
            v.root:setTouchEnabled(enabled)
        else
            v.root:setGrayEnabled(false)
        end
        v.Image_icon:setTexture(featureCfg.icon)
        v.Label_name:setTextById(btnText[feature])
        v.Image_touch:onClick(function()
                self:selectFeature(i)
        end)
    end

    self.Label_buildName:setTextById(buildCfg.nameId)
    self.Label_buildLevel:setTextById(500032, buildCfg.level)
    self.Image_buildBg:setTexture(buildCfg.wallPaper)
end

function CityWorkView:selectFeature(index, force)
    if self.selectFeatureIndex_ == index and not force then return end
    self.selectFeatureIndex_ = index
    self:popupBuldList(false)

    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)

    for i, v in ipairs(self.enableButton_) do
        local isSelect = (i == index)
        local feature = self.featureList_[i]
        if feature == EC_BuildFeatureType.SHOP and buildCfg.shopType == 0 then
            v.Image_select:setVisible(false)
        else
            v.Image_select:setVisible(isSelect)
        end
        v.Image_normal:setVisible(not isSelect)
    end

    self:updateFeature()
end

function CityWorkView:updateWorking()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local buildInfo = CityDataMgr:getBuildInfo(buildId)

    local isWorking = (buildInfo.state == EC_BuildState.WORK)
    local isWorkingFinish = (buildInfo.state == EC_BuildState.WORK_FINISH)
    local isUpgradeing = (buildInfo.state == EC_BuildState.UPGRADE)
    local isUpgradeingFinish = (buildInfo.state == EC_BuildState.UPGRADE_FINISH)
    local isFree = (buildInfo.state == EC_BuildState.FREE)

    self.Panel_working_pre:setVisible(isFree or isUpgradeing or isUpgradeingFinish)
    self.Panel_working_ing:setVisible(isWorking or isWorkingFinish)

    if isWorking or isWorkingFinish then
        if isWorking then
            self:updateWorkCountDown()
        end
        self.Button_gain:setVisible(isWorkingFinish)
        self.Label_workingCountDown:setVisible(isWorking)
        self.workingRole_ = buildInfo.roleIds
        self:updateWorkLog()

        if not self.workKanBanNiangView_ then
            self.workKanBanNiangView_ = requireNew("lua.logic.common.KanBanNiangView"):new()
            self.workKanBanNiangView_:setExpandVisible(false)
            self:addLayerToNode(self.workKanBanNiangView_, self.Panel_workKanbanNiang, 2)
        end
        self.workKanBanNiangView_:setRoleSetId(buildCfg.roleSet, buildId)
    else
        local hour, min = Utils:getFuzzyTime(buildCfg.workTime, true)
        self.Label_workingCostTime:setTextById(500020, hour, min)

        local count = math.min(#buildCfg.demand, #buildCfg.demandTips)
        for i, v in ipairs(self.Panel_workingCond) do
            local visible = (i <= count)
            v.root:setVisible(visible)
            if visible then
                local condType = buildCfg.demand[i][1]
                local condValue = buildCfg.demand[i][2]
                local tip = buildCfg.demandTips[i]
                if condType == EC_BuildWorkCond.COND_1 then
                    v.Label_cond_notReach:setTextById(tip, condValue)
                    v.Label_cond_reach:setTextById(tip, condValue)
                elseif condType == EC_BuildWorkCond.COND_2 then
                    local roleCfg = TabDataMgr:getData("Role", condValue)
                    v.Label_cond_notReach:setTextById(tip, TextDataMgr:getText(roleCfg.nameId))
                    v.Label_cond_reach:setTextById(tip, TextDataMgr:getText(roleCfg.nameId))
                elseif condType == EC_BuildWorkCond.COND_3 then
                    v.Label_cond_notReach:setTextById(tip, condValue)
                    v.Label_cond_reach:setTextById(tip, condValue)
                elseif condType == EC_BuildWorkCond.COND_4 then
                    v.Label_cond_notReach:setTextById(tip, condValue)
                    v.Label_cond_reach:setTextById(tip, condValue)
                elseif condType == EC_BuildWorkCond.COND_5 then
                    local args = string.split(condValue, "-")
                    local arg1 = tonumber(args[1])
                    local arg2 = tonumber(args[2])
                    local roleCfg = TabDataMgr:getData("Role", arg1)
                    v.Label_cond_notReach:setTextById(tip, TextDataMgr:getText(roleCfg.nameId), arg2)
                    v.Label_cond_reach:setTextById(tip, TextDataMgr:getText(roleCfg.nameId), arg2)
                end

                local unlock = CityDataMgr:isWorkCondUnlock(self.workingRole_, condType, condValue)
                v.Label_cond_reach:setVisible(unlock)
                v.Label_cond_notReach:setVisible(not unlock)
                v.Image_tag_reach:setVisible(unlock)
                v.Image_tag_notReach:setVisible(not unlock)
            end
        end
    end

    for i, v in ipairs(self.Button_member) do
        local unlock = (i <= buildCfg.position)
        v.Image_lock:setVisible(not unlock)
        v.Panel_unlock:setVisible(unlock)
        if unlock then
            local roleSid = self.workingRole_[i]
            if roleSid then
                local roleId = RoleDataMgr:getRoleIdBySid(roleSid)
                local roleCfg = RoleDataMgr:getRoleInfo(roleId)
                v.Image_icon:show():setTexture(roleCfg.showIcon)
                v.Image_frame:show():setTexture(roleCfg.backdrop)
                v.Label_name:setTextById(roleCfg.nameId)
            else
                v.Panel_unlock:hide()
            end
        end
    end
end

function CityWorkView:updateWorkLog()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildInfo = CityDataMgr:getBuildInfo(buildId)
    self.ListView_workingLog:removeAllItems()
    local log = buildInfo.logs or {}
    for i, v in ipairs(log) do
        if v.type == EC_BuildWorkLogType.REWARD or v.type == EC_BuildWorkLogType.BEGIN or v.type == EC_BuildWorkLogType.FINISH then
            self:addWorkLogItem(buildId, v)
        end
    end
end

function CityWorkView:addWorkLogItem(buildId, log)
    local buildInfo = CityDataMgr:getBuildInfo(buildId)
    local item = self.Panel_workLogItem:clone()
    local Label_time = TFDirector:getChildByPath(item, "Label_time")
    local Label_log = TFDirector:getChildByPath(item, "Label_log")
    local Image_line = TFDirector:getChildByPath(item, "Image_line")

    local year, month, day = Utils:getDate(log.logTime, true)
    local hour, min = Utils:getTime(log.logTime, true)
    Label_time:setTextById(500029, year, month, day, hour, min)

    local originLabelSize = Label_log:Size()
    local eventCfg = TabDataMgr:getData("MultiConditionEvent", log.eventId)
    if log.type == EC_BuildWorkLogType.REWARD then
        local textId = eventCfg.describe[log.textIndex]
        local rewardText = ""
        for i, v in ipairs(log.reward) do
            if #rewardText > 0 then
                rewardText = rewardText .. ","
            end
            local goodsCfg = GoodsDataMgr:getItemCfg(v.id)
            local goodsName = TextDataMgr:getText(goodsCfg.nameTextId)
            rewardText = rewardText .. TextDataMgr:getText(500030, goodsName, v.num)
        end
        local roleId = buildInfo.roleIds[math.random(#buildInfo.roleIds)]
        local roleCid = RoleDataMgr:getRoleIdBySid(roleId)
        local roleCfg = RoleDataMgr:getRoleInfo(roleCid)
        local roleName = TextDataMgr:getText(roleCfg.nameId)
        Label_log = Label_log:setTextById(textId, roleName, rewardText)
    elseif log.type == EC_BuildWorkLogType.BEGIN then
        Label_log = Label_log:setTextById("r3016")
    elseif log.type == EC_BuildWorkLogType.FINISH then
        Label_log = Label_log:setTextById("r3017")
    end

    local labelSize = Label_log:Size()
    local addHeight = labelSize.height - originLabelSize.height
    local size = item:Size()
    size.height = size.height + addHeight
    item:Size(size)
    Image_line:PosY(Image_line:PosY() - addHeight)

    self.ListView_workingLog:pushBackCustomItem(item)
    self.ListView_workingLog:scrollToBottom(0.2)
end

function CityWorkView:updateShop()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local buildInfo = CityDataMgr:getBuildInfo(buildId)
    local storeCfg = StoreDataMgr:getStoreCfg(buildCfg.shopType)
    local storeInfo = StoreDataMgr:getStoreInfo(buildCfg.shopType)
    local commodity = StoreDataMgr:getCommodity(buildCfg.shopType)

    self.ListView_shop:removeAllItems()
    for i, v in ipairs(commodity) do
        local item = self.Panel_shopItem:clone()
        self.ListView_shop:pushBackCustomItem(item)
    end

    if not self.shopKanBanNiangView_ then
        self.shopKanBanNiangView_ = requireNew("lua.logic.common.KanBanNiangView"):new()
        self.shopKanBanNiangView_:setExpandVisible(false)
        self:addLayerToNode(self.shopKanBanNiangView_, self.Panel_shopKanbanNiang, 1)
    end
    self.shopKanBanNiangView_:setRoleSetId(storeCfg.roleSet, buildId)

    self:updateAllShopItem()
    self:updateShopCountDown()
end

function CityWorkView:updateAllShopItem()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local commodity = StoreDataMgr:getCommodity(buildCfg.shopType)

    for i, v in ipairs(commodity) do
        local item = self.ListView_shop:getItem(i)
        self:updateShopItem(item, v)
    end
end

function CityWorkView:updateShopCountDown()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local storeInfo = StoreDataMgr:getStoreInfo(buildCfg.shopType)
    local remainTime = math.max(0, storeInfo.nextRefreshTime - ServerDataMgr:getServerTime())
    local hour, min = Utils:getFuzzyTime(remainTime, true)
    self.Label_shopCountDown:setTextById("r3015", hour, min)
end

function CityWorkView:updateWorkCountDown()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildInfo = CityDataMgr:getBuildInfo(buildId)
    local remainTime = math.max(0, buildInfo.finishTime - ServerDataMgr:getServerTime())
    local hour, min = Utils:getFuzzyTime(remainTime, true)
    self.Label_workingCountDown:setTextById(500023, hour, min)
end

function CityWorkView:updateUpgradeCountDown()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildInfo = CityDataMgr:getBuildInfo(buildId)
    local remainTime = math.max(0, buildInfo.finishTime - ServerDataMgr:getServerTime())
    local hour, min = Utils:getFuzzyTime(remainTime, true)
    self.Label_upgradCountDown:setTextById(500023, hour, min)
end

function CityWorkView:updateShopItem(item, commodityId)
    local commodityCfg = StoreDataMgr:getCommodityCfg(commodityId)
    local goods = commodityCfg.goods
    local goodsId, goodsCount
    for k, v in pairs(goods) do
        goodsId = k
        goodsCount = v
        break
    end
    local goodsCfg = GoodsDataMgr:getItemCfg(goodsId)

    local Panel_price = TFDirector:getChildByPath(item, "Panel_price")
    local Image_costIcon = TFDirector:getChildByPath(Panel_price, "Image_costIcon")
    local Label_costNum = TFDirector:getChildByPath(Panel_price, "Label_costNum")
    local Label_notEnoughCostNum = TFDirector:getChildByPath(Panel_price, "Label_notEnoughCostNum")
    local Label_countLimit = TFDirector:getChildByPath(item, "Label_countLimit")
    local Panel_icon = TFDirector:getChildByPath(item, "Panel_icon")
    local Button_buy = TFDirector:getChildByPath(item, "Button_buy")
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    PrefabDataMgr:setInfo(Panel_goodsItem, goodsId)
    Panel_goodsItem:Pos(0, 0)
    Panel_icon:addChild(Panel_goodsItem, 1)
	
    local costId = commodityCfg.priceType
    local costNum = commodityCfg.priceVal
    for i = 1, math.min(#costId, #costNum) do
        local id = costId[i]
        local num = costNum[i]
        local costCfg = GoodsDataMgr:getItemCfg(id)
        Image_costIcon:setTexture(costCfg.icon)
        Label_costNum:setText(num)
        Label_notEnoughCostNum:setText(num)
        local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
        Label_costNum:setVisible(isEnough)
        Label_notEnoughCostNum:setVisible(not isEnough)
        Utils:adaptSize(Panel_price, false, true)
        break
    end

    Button_buy:onClick(function()
            local isEnough = StoreDataMgr:currencyIsEnough(commodityCfg.id, 1)
            if isEnough then
                local buyConfirmView = require("lua.logic.store.BuyConfirmView"):new(commodityId)
                AlertManager:addLayer(buyConfirmView)
                AlertManager:show()
            else
                Utils:showTips(302200)
            end
    end)

    -- 限购
    if commodityCfg.limitType == EC_StoreBuyLimit.DAY then
        local nowBuyCount = StoreDataMgr:getNowBuyCount(commodityId, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - nowBuyCount)
        Label_countLimit:setTextById(commodityCfg.sellDescribtion, remainCount)
        local isCanBuy = remainCount > 0
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    elseif commodityCfg.limitType == EC_StoreBuyLimit.TIME then
        local nowBuyCount = StoreDataMgr:getNowBuyCount(commodityId, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - nowBuyCount)
        Label_countLimit:setTextById(commodityCfg.sellDescribtion, remainCount)
        local isCanBuy = remainCount > 0
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    elseif commodityCfg.limitType == EC_StoreBuyLimit.FOREVER then
        local totalBuyCount = StoreDataMgr:getTotalBuyCount(commodityId, EC_StoreBuyLogType.PERSONAL)
        local remainCount = math.max(0, commodityCfg.limitVal - totalBuyCount)
        Label_countLimit:setTextById(commodityCfg.sellDescribtion, remainCount)
        local isCanBuy = remainCount > 0
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    elseif commodityCfg.limitType == EC_StoreBuyLimit.WHOLESERVER then
        local serverNowBuyCount = StoreDataMgr:getNowBuyCount(commodityId, EC_StoreBuyLogType.WHOLESERVER)
        local serverRemainBuyCount = commodityCfg.limitVal - serverNowBuyCount
        local personNowBuyCount = StoreDataMgr:getNowBuyCount(commodityId, EC_StoreBuyLogType.PERSONAL)
        local personalRemainBuyCount = commodityCfg.serLimit - personNowBuyCount
        Label_countLimit:setTextById(commodityCfg.sellDescribtion, serverRemainBuyCount)
        local isCanBuy = serverRemainBuyCount > 0 and personalRemainBuyCount > 0
        Button_buy:setGrayEnabled(not isCanBuy)
        Button_buy:setTouchEnabled(isCanBuy)
    else

    end
end

function CityWorkView:updateUpgrade()
    local buildId = self.build_[self.selectBuildIndex_]
    local buildCfg = CityDataMgr:getBuildCfg(buildId)
    local buildInfo = CityDataMgr:getBuildInfo(buildId)

    local isUpgradeing = (buildInfo.state == EC_BuildState.UPGRADE)
    self.Panel_upgrade_pre:setVisible(not isUpgradeing)
    self.Panel_upgrade_ing:setVisible(isUpgradeing)

    if isUpgradeing then
        self:updateUpgradeCountDown()
        return
    end

    local hour, min = Utils:getFuzzyTime(buildCfg.needTime, true)
    self.Label_upgradeCostTime:setTextById(500021, hour, min)

    local text = {}
    for i, v in ipairs(buildCfg.upDescribe) do
        local t = TextDataMgr:getTextEx(v)
        table.insert(text, t)
    end
    local content, isRString = TextDataMgr:concat(text, "\n")
    self.Label_upgradeDesc:setTextEx(content, isRString)

    -- 当前产出
    self.ListView_curProduct:removeAllItems()
    for i, v in ipairs(buildCfg.nowDrop) do
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:Scale(0.45)
        PrefabDataMgr:setInfo(item, v)
        self.ListView_curProduct:pushBackCustomItem(item)
    end
    -- 新增产出
    self.ListView_newProduct:removeAllItems()
    for i, v in ipairs(buildCfg.nextDrop) do
        local item = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        item:Scale(0.45)
        PrefabDataMgr:setInfo(item, v)
        self.ListView_newProduct:pushBackCustomItem(item)
    end

    for i, v in ipairs(self.Panel_upgradeCond) do
        local upType = buildCfg.upType[i]
        local upTip = buildCfg.upTips[i]
        if upType and upTip then
            local condType = upType[1]
            local condValue = upType[2]
            local content = ""
            if condType == EC_BuildUpgradeCond.LEVEL then
                content = TextDataMgr:getTextEx(upTip, condValue)
            elseif condType == EC_BuildUpgradeCond.CHAPTER then
                local chapterCfg = FubenDataMgr:getChapter(condValue)
                content = TextDataMgr:getTextEx(upTip, chapterCfg.orderName)
            end
            v.root:show()
            v.Label_upgradeCond_reach:setText(content)
            v.Label_upgradeCond_notReach:setText(content)
            local condUnlock = CityDataMgr:getBuildCanUpGradeByCond(buildId, i)
            v.Label_upgradeCond_reach:setVisible(condUnlock)
            v.Label_upgradeCond_notReach:setVisible(not condUnlock)
        else
            v.root:hide()
        end
    end

    self.ListView_upgradeCond:removeAllItems()
    local other = {}
    local money
    for i, v in ipairs(buildCfg.consume) do
        local itemCfg = GoodsDataMgr:getItemCfg(v[1])
        if itemCfg.superType == EC_ResourceType.NUMBERIC then
            money = v
        else
            table.insert(other, v)
        end
    end
    for _, info in ipairs(other) do
        local id = info[1]
        local num = info[2]
        local haveNum = GoodsDataMgr:getItemCount(id)
        local itemCfg = GoodsDataMgr:getItemCfg(id)

        local item = self.Panel_upgradeCondItem:clone()
        local Label_count_reach = TFDirector:getChildByPath(item, "Label_count_reach")
        local Label_count_notReach = TFDirector:getChildByPath(item, "Label_count_notReach")
        local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        Panel_goodsItem:Pos(0, 0)
        Panel_goodsItem:AddTo(item, 1)
        PrefabDataMgr:setInfo(Panel_goodsItem, id)
        local count = GoodsDataMgr:getItemCount(id)
        Label_count_reach:setTextById(800005, count, num)
        Label_count_notReach:setTextById(800005, count, num)
        local isEnough = GoodsDataMgr:currencyIsEnough(id, num)
        Label_count_reach:setVisible(isEnough)
        Label_count_notReach:setVisible(not isEnough)
        Panel_goodsItem:onClick(function()
                Utils:showInfo(id, nil, true)
        end)
        self.ListView_upgradeCond:pushBackCustomItem(item)
    end

    if money then
        self.Panel_upgradeCostMoney:show()
        local itemCfg = GoodsDataMgr:getItemCfg(money[1])
        self.Image_upgradeCostMoneyIcon:setTexture(itemCfg.icon)
        self.Label_upgradeCostMoneyNum_notEnough:setText(money[2])
        self.Label_upgradeCostMoneyNum_enough:setText(money[2])
        local isEnough = GoodsDataMgr:currencyIsEnough(money[1], money[2])
        self.Label_upgradeCostMoneyNum_enough:setVisible(isEnough)
        self.Label_upgradeCostMoneyNum_notEnough:setVisible(not isEnough)
    else
        self.Panel_upgradeCostMoney:hide()
    end

    local levelBuild = CityDataMgr:getLevelBuild(buildId)
    local isFullLevel = buildCfg.level >= #levelBuild
    self.Button_upgrade:setTouchEnabled(not isFullLevel)
    self.Button_upgrade:setGrayEnabled(isFullLevel)
    self.Label_upgradeCostTime:setVisible(not isFullLevel)
    self.Label_upgrade:setTextById(isFullLevel and 500037 or 500036)
end

function CityWorkView:registerEvents()
    EventMgr:addEventListener(self, EV_CITY_BUILD_BEGIN_UPGRADE, handler(self.onBuildBeginUpgradeEvent, self))
    EventMgr:addEventListener(self, EV_CITY_BUILD_UPGRADEFINISH, handler(self.onBuildUpgradeFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_SELECT_SPRITE, handler(self.onSelectSpriteEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_FINISH, handler(self.onWorkingFinishEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_GETREWARD, handler(self.onWorkingRewardEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_BEGIN, handler(self.onWorkingBeginEvent, self))
    EventMgr:addEventListener(self, EV_CITY_WORKING_EVENT, handler(self.onWorkingEvent, self))
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(self.onBuySuccessEvent, self))
    EventMgr:addEventListener(self, EV_STORE_REFRESH, handler(self.onStoreRefreshEvent, self))
    EventMgr:addEventListener(self, EV_CITY_BUILD_UPDATE, handler(self.onBuildUpdateEvent, self))

    self:setBackBtnCallback(function()
            AlertManager:close()
            EventMgr:dispatchEvent(EV_CITY_INFO_CLOSE)
    end)

    self.Button_buildList:onClick(function()
            self:popupBuldList(not self.popupToggle_)
    end)

    self.Panel_touchMask:onClick(function()
            self:popupBuldList(false)
    end)

    for i, v in ipairs(self.Button_member) do
        v.root:onClick(function()
                Utils:openView("city.CitySpriteSelectView", self.workingRole_, self.workingRole_[i])
        end)
    end

    self.Button_working:onClick(function()
            local buildId = self.build_[self.selectBuildIndex_]
            local buildCfg = CityDataMgr:getBuildCfg(buildId)
            local buildInfo = CityDataMgr:getBuildInfo(buildId)
            local unlock = true
            for i, v in ipairs(buildCfg.demand) do
                local condType = v[1]
                local condValue = v[2]

                if not CityDataMgr:isWorkCondUnlock(self.workingRole_, condType, condValue) then
                    unlock = false
                    break
                end
            end

            if buildInfo.state == EC_BuildState.UPGRADE then
                Utils:showTips(500027)
            else
                if unlock then
                    CityDataMgr:sendWorking(buildId, self.workingRole_)
                else
                    Utils:showTips(500025)
                end
            end
    end)

    self.Button_gain:onClick(function()
            local buildId = self.build_[self.selectBuildIndex_]
            CityDataMgr:sendGetWorkingReward(buildId)
    end)

    self.Button_upgrade:onClick(function()
            local buildId = self.build_[self.selectBuildIndex_]
            local buildInfo = CityDataMgr:getBuildInfo(buildId)
            if buildInfo.state == EC_BuildState.WORK or buildInfo.state == EC_BuildState.WORK_FINISH then
                Utils:showTips(500028)
            else
                local condUnlock, costUnlock = CityDataMgr:getBuildCanUpGrade(buildId)
                if condUnlock and costUnlock then
                    CityDataMgr:sendUpgradeBuild(buildId)
                else
                    Utils:showTips(500033)
                end
            end
    end)
end

function CityWorkView:removeEvents()
    self:removeCountDownTimer()
end

function CityWorkView:addCountDownTimer()
    if not self.countDownTimer_ then
        self.countDownTimer_ = TFDirector:addTimer(1000, -1, nil, handler(self.onCountDownPer, self))
    end
end

function CityWorkView:removeCountDownTimer()
    if self.countDownTimer_ then
        TFDirector:removeTimer(self.countDownTimer_)
    end
end

function CityWorkView:onCountDownPer()
    local countDownIndex = self:getCountDownIndex()
    if #countDownIndex > 0 then
        for i, v in ipairs(countDownIndex) do
            local buildId = self.build_[v]
            local item = self.ListView_build:getItem(v)
            self:updateBuildItem(item, v)
        end
    end

    local feature = self.featureList_[self.selectFeatureIndex_]
    if feature == EC_BuildFeatureType.WORK then
        local buildId = self.build_[self.selectBuildIndex_]
        local buildInfo = CityDataMgr:getBuildInfo(buildId)
        if buildInfo.state == EC_BuildState.WORK then
            self:updateWorkCountDown()
        end
    elseif feature == EC_BuildFeatureType.SHOP then
        self:updateShopCountDown()
    elseif feature == EC_BuildFeatureType.UPGRADE then
        local buildId = self.build_[self.selectBuildIndex_]
        local buildInfo = CityDataMgr:getBuildInfo(buildId)
        if buildInfo.state == EC_BuildState.UPGRADE then
            self:updateUpgradeCountDown()
        end
    end
end

function CityWorkView:getCountDownIndex()
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

function CityWorkView:updateAllBuildInfo()
    self.build_ = CityDataMgr:getBuild(self.cityId_)
    self:updateAllBuildItem()
end

function CityWorkView:updateFeature()
    local feature = self.featureList_[self.selectFeatureIndex_]
    self.Panel_working:setVisible(feature == EC_BuildFeatureType.WORK)
    self.Panel_shop:setVisible(feature == EC_BuildFeatureType.SHOP)
    self.Panel_upgrade:setVisible(feature == EC_BuildFeatureType.UPGRADE)

    if self.Panel_working:isVisible() then
        self:updateWorking()
    elseif self.Panel_shop:isVisible() then
        self:updateShop()
    elseif self.Panel_upgrade:isVisible() then
        self:updateUpgrade()
    end
end

function CityWorkView:popupBuldList(toggle)
    if self.popupToggle_ == toggle or not self.popAniFinish_ then return end
    self.popupToggle_ = toggle
    self.popAniFinish_ = false
    local offsetX = self.ListView_build_size.width
    if not toggle then
        offsetX = -1 * offsetX
    else
        self.Panel_content:setClippingEnabled(true)
    end
    local seq = Sequence:create({
            MoveBy:create(0.2, ccp(offsetX, 0)),
            CallFunc:create(function()
                    self.popAniFinish_ = true
                    self.Panel_content:setClippingEnabled(toggle)
            end)
    })
    self.Panel_content:runAction(seq)
    self.Panel_touchMask:setVisible(toggle)
end

function CityWorkView:onBuildBeginUpgradeEvent(buildId)
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self:updateUpgrade()
    end

    self:updateAllBuildItem()
end

function CityWorkView:onBuildUpgradeFinishEvent(buildId)
    self:updateAllBuildInfo()
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self:updateFeature()
    end

    if AlertManager:getTopLayer() == self then
        local buildLevelUpView = require("lua.logic.city.BuildLevelUpView"):new(buildId)
        AlertManager:addLayer(buildLevelUpView)
        AlertManager:show()
    end

    self:updateAllBuildItem()
end

function CityWorkView:onSelectSpriteEvent(workingHero)
    self.workingRole_ = workingHero
    self:updateWorking()
end

function CityWorkView:onWorkingFinishEvent(buildId)
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self:updateWorking()
    end

    self:updateAllBuildItem()
end

function CityWorkView:onWorkingRewardEvent(buildId, reward)
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self.workingRole_ = {}
        self:updateWorking()
    end
    Utils:showReward(reward)

    self:updateAllBuildItem()
end

function CityWorkView:onWorkingBeginEvent(buildId)
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self:updateWorking()
    end

    self:updateAllBuildItem()
end

function CityWorkView:onWorkingEvent(buildId, log)
    local selectBuildId = self.build_[self.selectBuildIndex_]
    if selectBuildId == buildId then
        self:addWorkLogItem(buildId, log)
    end
end

function CityWorkView:onBuySuccessEvent()
    local feature = self.featureList_[self.selectFeatureIndex_]
    if feature == EC_BuildFeatureType.SHOP then
        self:updateAllShopItem()
    end
end

function CityWorkView:onStoreRefreshEvent(storeId)
    local feature = self.featureList_[self.selectFeatureIndex_]
    if feature == EC_BuildFeatureType.SHOP then
        local buildId = self.build_[self.selectBuildIndex_]
        local buildCfg = CityDataMgr:getBuildCfg(buildId)
        if buildCfg.shopType == storeId then
            self:updateShop()
        end
    end
end

function CityWorkView:onBuildUpdateEvent(buildId)
    self:updateAllBuildItem()
end

return CityWorkView
