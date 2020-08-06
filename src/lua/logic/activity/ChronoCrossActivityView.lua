
local ChronoCrossActivityView = class("ChronoCrossActivityView", BaseLayer)

function ChronoCrossActivityView:initData(activityId)
    self.activityId_ = activityId
    self.taskItems_ = {}
    self.resource = {}
end

function ChronoCrossActivityView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.ChronoCrossActivityView")
end

function ChronoCrossActivityView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")

    local Image_content = TFDirector:getChildByPath(self.Panel_root, "Image_content")
    self.Panel_cg = TFDirector:getChildByPath(Image_content, "Image_frame.Panel_cg")

    self.Spine_sceneEffect = TFDirector:getChildByPath(self.Panel_root, "Spine_sceneEffect"):hide()
    self.Spine_effectHB = TFDirector:getChildByPath(self.Panel_root, "Spine_effectHB")
    self.Image_bg = TFDirector:getChildByPath(self.Panel_root, "Image_bg")

    self.Spine_finish = TFDirector:getChildByPath(self.Panel_root, "Spine_finish"):hide()
    self.Spine_notfinish = TFDirector:getChildByPath(self.Panel_root, "Spine_notfinish"):hide()
    self.Label_time_title = TFDirector:getChildByPath(self.Panel_root, "Label_time_title")
    self.Label_time = TFDirector:getChildByPath(self.Panel_root, "Label_time")
    self.Button_goto = TFDirector:getChildByPath(Image_content, "Button_goto")
    self.Label_tip = TFDirector:getChildByPath(Image_content, "Label_tip")
    self.Label_tip:setSkewX(15)
    self.Label_tip:setTextById(13310339)
    self.Image_timeEnergy = TFDirector:getChildByPath(Image_content, "Image_timeEnergy")

    self.Label_energyState = TFDirector:getChildByPath(Image_content, "Label_energyState")
    self.Label_energyState:setSkewX(15)
    self.Label_num = TFDirector:getChildByPath(Image_content, "Label_num")
    self.Label_symbol = TFDirector:getChildByPath(Image_content, "Label_symbol")
    self.Image_icon = TFDirector:getChildByPath(Image_content, "Image_icon")
    self.Image_mode = TFDirector:getChildByPath(Image_content, "Image_mode")

    TFDirector:send(c2s.ACTIVITY_REQ_GET_ZZALL_SERVER,{})

    TFDirector:send(c2s.ACTIVITY_REQ_GET_ZZALL_RANK,{})

    TFDirector:send(c2s.ACTIVITY_REQ_ACTIVITY_NOTICE,{})

    self:refreshView()
end

function ChronoCrossActivityView:onShow()
    self.super.onShow(self)
    if not self.model then
        self:createMode()
    end
end

function ChronoCrossActivityView:onHide()
    self.super.onHide(self)
    if self.model then
        self.model:removeFromParent()
        self.model = nil
    end
end

function ChronoCrossActivityView:createMode()
    local dressId = self.activityInfo_.extendData.dressId
    local dressTable = TabDataMgr:getData("Dress")[tonumber(dressId)]
    if dressTable then
        local modelId = dressTable.highRoleModel
        self.model = ElvesNpcTable:createLive2dNpcID(modelId,false,false,nil,true).live2d
        self.Image_mode:addChild(self.model,1)
        self.model:setScale(0.6); --缩放
        local pos = ccp(0,-110)
        self.model:setPosition(pos);--位置
    end
end

function ChronoCrossActivityView:refreshView()
    self.Label_time_title:setTextById(1710002)
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.CHRONO_CROSS)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
        local freshItem = json.decode(self.activityInfo_.extendData.reversalFcost)
        local itemId,needCnt
        for k,v in pairs(freshItem) do
            itemId,needCnt = tonumber(k),v
            break
        end
        if itemId then
            local num = GoodsDataMgr:getItemCount(itemId)
            local textId = num >= needCnt and  13310333 or 13310334
            self.Label_energyState:setTextById(textId)
            self.Image_timeEnergy:setGrayEnabled(num < needCnt)
        end
    else
        return
    end

    self.maxCnt = 1
    local itemIds = ActivityDataMgr2:getItems(self.activityId_)
    for k,taskId in ipairs(itemIds) do
        local itemInfo = ActivityDataMgr2:getItemInfo(self.activityInfo_.activityType, taskId)
        if itemInfo.extendData.type == EC_ChronoCrossTaskType.AllServer then
            self.maxCnt = self.maxCnt < itemInfo.target and itemInfo.target or self.maxCnt
        end
    end

    self:createMode()

    local dressId = self.activityInfo_.extendData.dressId
    local dressTable = TabDataMgr:getData("Dress")[tonumber(dressId)]
    if dressTable then
        if dressTable.backgroundEffect and dressTable.backgroundEffect ~= 0 then
            self:refreshEffect(dressTable.backgroundEffect,true)
        end

        if dressTable.kanbanEffect and dressTable.kanbanEffect ~= 0 then
            self:refreshEffect(dressTable.kanbanEffect)
        end
        self.Image_bg:setTexture(dressTable.background)
    end
end

function ChronoCrossActivityView:refreshEffect(effectIds,isBgEffect)
    local mgrTab = nil
    local prefab = nil
    if not isBgEffect then
        mgrTab = self.effectSK or {}
        self.effectSK = mgrTab
        prefab = self.Spine_sceneEffect
    else
        mgrTab = self.effectSKB or {}
        self.effectSKB = mgrTab
        prefab = self.Spine_effectHB
    end

    for k,v in pairs(mgrTab) do
        v:removeFromParent()
        mgrTab[k] = nil
    end

    if type(effectIds) ~= "table" then
        local effectId = effectIds
        effectIds = {effectId}
    end

    for k,effectId in pairs(effectIds) do
        mgrTab[effectId] = Utils:createEffectByEffectId(effectId)
        if not mgrTab[effectId] then
            return
        end

        mgrTab[effectId]:setPosition(prefab:getPosition())
        prefab:getParent():addChild(mgrTab[effectId], prefab:getZOrder())
    end
end


function ChronoCrossActivityView:updateActivity()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)

    local startDate = Utils:getLocalDate(self.activityInfo_.startTime)
    local startDateStr = startDate:fmt("%Y.%m.%d")
    local endDate = Utils:getLocalDate(self.activityInfo_.endTime)
    local endDateStr = endDate:fmt("%Y.%m.%d")
    self.Label_time:setTextById(800041, startDateStr, endDateStr)

end

function ChronoCrossActivityView:updateServerPoint()
    local point = ChronoCrossDataMgr:getServerPoint()
    point = point >= self.maxCnt and self.maxCnt or point
    local percent = math.floor(point/self.maxCnt*100)
    local isMax = point >= self.maxCnt
    local color = isMax and ccc3(255,255,255) or ccc3(87,171,229)
    self.Label_num:setText(percent)
    self.Label_num:setColor(color)
    self.Label_symbol:setColor(color)
    self.Label_tip:setColor(color)
    local w = self.Label_num:getContentSize().width
    self.Label_symbol:setPositionX(w/2-7)
    self.Image_icon:setVisible(point >= self.maxCnt)

    self.Spine_finish:setVisible(isMax)
    self.Spine_notfinish:setVisible(not isMax)
end

function ChronoCrossActivityView:updateFreshState()
    self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    if not self.activityInfo_ then
        return
    end
    local freshItem = json.decode(self.activityInfo_.extendData.reversalFcost)
    local itemId,needCnt
    for k,v in pairs(freshItem) do
        itemId,needCnt = tonumber(k),v
        break
    end
    if itemId then
        local num = GoodsDataMgr:getItemCount(itemId)
        local textId = num >= needCnt and  13310333 or 13310334
        self.Label_energyState:setTextById(textId)
        self.Image_timeEnergy:setGrayEnabled(num < needCnt)
    end
end

function ChronoCrossActivityView:registerEvents()

    EventMgr:addEventListener(self, EV_ACTIVITY_REFRESH_ENTRUST, handler(self.updateFreshState, self))
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.updateFreshState, self))
    EventMgr:addEventListener(self, EV_UPDATE_SERVERPOINT, handler(self.updateServerPoint, self))
    self.Button_goto:onClick(function()
        if self.model then
            self.model:removeFromParent()
            self.model = nil
        end
        Utils:openView("chronoCross.ChronoCrossMainView")
    end)
end

return ChronoCrossActivityView
