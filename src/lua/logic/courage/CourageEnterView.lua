local CourageEnterView = class("CourageEnterView", BaseLayer)

function CourageEnterView:initData()
    local costItem = Utils:getKVP(46025, "cost")
    for k,v in pairs(costItem) do
        self.costItemId,self.costItemIdCnt = k,v
        break
    end
end

function CourageEnterView:ctor(...)
    self.super.ctor(self)

    self:initData(...)
    self:init("lua.uiconfig.courage.courageEnterView")
end

function CourageEnterView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_cg = TFDirector:getChildByPath(self.Panel_root, "Panel_cg")

    self.Button_go = TFDirector:getChildByPath(ui, "Button_go")
    self.Label_btn = TFDirector:getChildByPath(self.Button_go, "Label_btn")

    self.Label_time = TFDirector:getChildByPath(ui, "Label_time")
    self.Label_num = TFDirector:getChildByPath(ui, "Label_num")
    self:initUILogic()
end

function CourageEnterView:initUILogic()

    if not self.cgView_ then
        local cgCid = 5
        local cg_cfg = TabDataMgr:getData("Cg")[cgCid]
        local cgView = requireNew("lua.logic.common.CgView"):new(cg_cfg.cg, cg_cfg.backGround, nil, nil, false, function() end)
        local size = self.Panel_cg:getSize()
        local scaleX = size.width/cgView:Size().width
        local scaleY = size.height/cgView:Size().height
        cgView:setScale(math.max(scaleX, scaleY))
        self.Panel_cg:addChild(cgView)
        self.cgView_ = cgView
    end

    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.COURAGE)
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(activity[1])
    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)

    TFDirector:send(c2s.SUMMER_COURAGE_REQ_NEWBIE_STEP_INFO, {})

    self:updateEnterNum()

end

function CourageEnterView:onShow()
    self.super.onShow(self)
    CourageDataMgr:Send_GetBaseInfo()
end

function CourageEnterView:updateEnterNum()

    local itemId = self.costItemId
    local cnt = GoodsDataMgr:getItemCount(itemId)
    self.Label_num:setText(cnt)
    self:updateState()
end

function CourageEnterView:updateState()
    local isNewChapter = CourageDataMgr:isNewOpenChapter()
    if isNewChapter == nil then
        return
    end
    local str = isNewChapter and "进入活动" or "继续"
    self.Label_btn:setText(str)
    self.Label_num:setVisible(isNewChapter)
end

---弹窗条件：有解锁格子 and 有当前周期的装备
function CourageEnterView:jumpToMainView()

    local chapterId,areaId = CourageDataMgr:getCurLocation()
    if not chapterId then
        return
    end

    local unLockCunt = 0
    local unlockChapter = CourageDataMgr:getUnlockChapter()
    for k,v in ipairs(unlockChapter) do
        local mazeDmgrCfg = CourageDataMgr:getMazeDMgrCfg(v)
        if not mazeDmgrCfg then
            return
        end
        local equipNumber = mazeDmgrCfg.equipNumber
        unLockCunt = unLockCunt < equipNumber and equipNumber or unLockCunt
    end

    local openEquipSolt = unLockCunt
    local ownEquipCnt = 0

    local bagdata = GoodsDataMgr:getBag(EC_Bag.COURAGE_EQUIP)
    for k,item in pairs(bagdata) do
        local goodsCfg = GoodsDataMgr:getItemCfg(item.cid)
        local outSideInfo = goodsCfg.outside
        local index = table.indexOf(outSideInfo,chapterId)   ---是该周目专属装备
        if index ~= -1 then
            ownEquipCnt = ownEquipCnt + 1
        end
    end

    if openEquipSolt == 0 then
        CourageDataMgr:Send_EnterGame()
    else
        if ownEquipCnt ~= 0 then
            Utils:openView("courage.CourageBeginConfirm")
        else
            CourageDataMgr:Send_EnterGame()
        end
    end

end

function CourageEnterView:enterGame()

    if GoodsDataMgr:currencyIsEnough(self.costItemId, self.costItemIdCnt) then
        self:jumpToMainView()
        --local function reaSummon()
        --    self:jumpToMainView()
        --end
        --if MainPlayer:getOneLoginStatus(EC_OneLoginStatusType.ReconFirm_CourageEnter)then
        --    reaSummon()
        --else
        --    local rstr = TextDataMgr:getTextAttr(1200042 + i -1)
        --    local formatStr = rstr and rstr.text or ""
        --    local content = string.format(formatStr, 1, TabDataMgr:getData("Item", itemId).icon)
        --    Utils:openView("common.ReConfirmTipsView", {tittle = 1200041, content = content, reType = EC_OneLoginStatusType.ReConfirm_Summon, confirmCall = reaSummon})
        --end
    else
        local itemCfg = GoodsDataMgr:getItemCfg(self.costItemId)
        if StoreDataMgr:canContinueBuyItemRecover(itemCfg.buyItemRecover) then
            Utils:openView("common.BuyResourceView", self.costItemId)
        else
            Utils:showTips(800021)
        end
    end
end

function CourageEnterView:isOpenState()

    local chapterId,areaId = CourageDataMgr:getCurLocation()
    if not chapterId then
        return
    end
    local mazeMgCfg = CourageDataMgr:getMazeDMgrCfg(chapterId)
    if not mazeMgCfg then
        return
    end

    local isOpen = false
    local beginTime = mazeMgCfg.beginTime/1000
    local endTime = mazeMgCfg.endTime/1000
    local serverTime = ServerDataMgr:getServerTime()
    print(chapterId,serverTime,beginTime,endTime)
    if serverTime >= beginTime and serverTime <= endTime then
        isOpen = true
    end
    return isOpen
end

function CourageEnterView:registerEvents()

    EventMgr:addEventListener(self, EV_COURAGE.EV_NEWGUIDE_BASEINFO, handler(self.updateState, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateEnterNum, self))

    self.Button_go:onClick(function()

        local isNewChapter = CourageDataMgr:isNewOpenChapter()
        if isNewChapter then
            self:enterGame()
        else
            Utils:openView("courage.CourageMainView")
        end
    end)

end


return CourageEnterView
