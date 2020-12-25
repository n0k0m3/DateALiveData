--[[
    @desc:2020春节活动-糖葫芦制作页面
]]
local TanghuluMakeView = class("TanghuluMakeView", BaseLayer)

function TanghuluMakeView:initData(...)
    self.curSelect    = 1  -- 默认选中第一组糖葫芦
    self.curChooseThl = nil -- 
    self.thlViews     = {}  -- 
    self.isCanBeMake  = false

    self.data         = {} 
    self.activityId   = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.TANGHULU)[1]
    self.activityInfo =  ActivityDataMgr2:getActivityInfo(self.activityId)
    
    for _, itemId in pairs(self.activityInfo.items) do
        local itemInfo    = ActivityDataMgr2:getItemInfo(EC_ActivityType2.TANGHULU, itemId)
        local type        = itemInfo.extendData.type
        local specialTask = itemInfo.extendData.specialTask
        if type and specialTask == 2 then
            if not self.data[type] then
                self.data[type] = {}
            end
            table.insert(self.data[type], itemInfo)
        end
    end

    for i = 1 , #self.data do
        table.sort(self.data[i], function(a, b)
            return a.rank < b.rank
        end)
    end
end

function TanghuluMakeView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.activity.tanghuluMakeView")
end

function TanghuluMakeView:initUI(ui)
    self.super.initUI(self, ui)
    self.view = UIListView:create(self._ui.scrollView)
    self.view:setItemModel(self._ui.Panel_Item)
    self.view:setItemsMargin(10)
    self._ui.lab_btnMake:setSkewX(10)

    self._ui.lab_lastTime:setText(Utils:getActivityDateString(self.activityInfo.startTime, self.activityInfo.endTime))

    self:updateView()
    self:selectOneThl(self.curSelect)
    self:loadLive2d()
end

function TanghuluMakeView:registerEvents()
    
    self._ui.btn_preview:onClick(function()
        Utils:openView("activity.TanghuluRewardView", self.data)
    end)

    self._ui.btn_make:onClick(function(sender)
        local data = self.data[self.curSelect][self.curChooseThl]
        if data and data.id then
            if self.isCanBeMake then
                ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId, data.id, 1)
            else
                sender:setGrayEnabled(true)
                Utils:showTips(63676)
            end
        else
            Utils:showTips(63677)
        end
        
    end)

    EventMgr:addEventListener(self,EV_ACTIVITY_SUBMIT_SUCCESS,handler(self.onSubmitSuccessEvent, self))
    EventMgr:addEventListener(self,EV_ACTIVITY_UPDATE_PROGRESS,handler(self.onRefreshTask, self))
end

function TanghuluMakeView:updateView()
    local items = self.view:getItems()
    local gap = #self.data - #items
    if gap > 0 then
        for i = 1, math.abs(gap) do
            self.view:pushBackDefaultItem()
        end
    else
        for i = 1, math.abs(gap) do
            self.view:removeItem(1)
        end
    end 

    local items = self.view:getItems()
    for i, item in ipairs(items) do
        local data = self.data[i]
        if data then
            self:updateItem(item, i, data)
        end
    end
end

function TanghuluMakeView:updateItem(item, i, data)
    local img_line   = TFDirector:getChildByPath(item,"panel_thl.img_line")
    local lab_resNum = TFDirector:getChildByPath(item, "lab_resNum.lab_resNum")
    local btn_choose = TFDirector:getChildByPath(item, "btn_choose")
    local Image_scrollBarModel = TFDirector:getChildByPath(item, "panel_thl.Image_scrollBarModel")
    local Image_scrollBarInner = TFDirector:getChildByPath(Image_scrollBarModel, "Image_scrollBarInner")
    -- 葫芦串
    if not self.thlViews[i] then
        self.thlViews[i] = UIListView:create(TFDirector:getChildByPath(img_line,"clippingNode.thlView"))
        self.thlViews[i]:setItemsMargin(0)
        local bar = UIScrollBar:create(Image_scrollBarModel, Image_scrollBarInner)
        bar:setVisible(false)
        self.thlViews[i]:setScrollBar(bar)
    end
    self.thlViews[i]:removeAllItems()
    local _img_thl = img_line:getChildByName("img_thl") 
    _img_thl:hide()
    local numHadGet = 0
    for k, v in ipairs(data) do
        local img_thl = _img_thl:clone()
        local spine_thl = img_thl:getChildByName("spine_thl")
        spine_thl:hide()

        local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, v.id)
        if progressInfo.status == EC_Assist_Item_Status.ING then
            img_thl:setTexture("ui/activity/thl/sanzha1.png")
        elseif progressInfo.status == EC_Assist_Item_Status.GET then
            spine_thl:show()
            spine_thl:play("xunhuan",true)
            img_thl:setTexture("ui/activity/thl/sanzha2.png")
        else
            img_thl:setTexture("ui/activity/thl/sanzha3.png")
            numHadGet = numHadGet + 1
        end

        img_thl:getChildByName("img_chooseThl"):setVisible(false)
        img_thl:show()
        img_thl:setTouchEnabled(true)
        local brginPos = nil

        img_thl:onClick(function()
            self:clickThlFunc(i, k)
        end)
        self.thlViews[i]:pushBackCustomItem(img_thl)
    end

    lab_resNum:setText(numHadGet.."/"..#data)

    btn_choose:onClick(function()
        self:selectOneThl(i)
    end)
    return item
end

-- 选中一组糖葫芦
function TanghuluMakeView:selectOneThl(idx)
    for i, v in  ipairs(self.view:getItems()) do
        if v then
            local btn_choose    = TFDirector:getChildByPath(v, "btn_choose")
            local img_select    = TFDirector:getChildByPath(v, "img_select")
            local img_selectOut = TFDirector:getChildByPath(v, "img_selectOut")
            img_select:setVisible(i == idx)
            img_selectOut:setVisible(img_select:isVisible())
            if img_selectOut:isVisible() then
                local eff_spine = img_selectOut:getChildByName("eff_spine")
                eff_spine:setVisible(true)
                eff_spine:play("liuguang",true)
            end
            btn_choose:setVisible(not img_select:isVisible())
        end
    end
    -- 清除上串糖葫芦选中状态
    for j, v in ipairs(self.thlViews[self.curSelect]:getItems()) do
        v:getChildByName("img_chooseThl"):setVisible(false)
    end
    self.curSelect    = idx
    self.curChooseThl = nil

    local index = nil
    for i, v in ipairs(self.data[idx]) do
        local status = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU,self.data[idx][i].id).status
        if status == EC_Assist_Item_Status.ING then
            index = i 
            break
        end
    end
    if index then
        self._ui.img_needDi:show()
        self:clickThlFunc(idx, index) -- 选中第1个未制作糖葫芦
        self.thlViews[idx]:jumpToItem(index - 2)
        self.thlViews[idx]:updateScrollBar()
    else
        self._ui.img_needDi:hide()
        self._ui.btn_make:setGrayEnabled(true)
    end
end

function TanghuluMakeView:clickThlFunc(i, idx)
    local data         = self.data[i][idx]
    local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, data.id)

 -- 可领取奖励
    if progressInfo.status == EC_Assist_Item_Status.GET then
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityId,self.data[i][idx].id, 1)
        return
    end
    -- 非当前选中组
    if self.curSelect ~= i then
        if progressInfo.status == EC_Assist_Item_Status.ING or progressInfo.status == EC_Assist_Item_Status.GET  then
            local formatRewards = {}
            for id, key in pairs(data.reward) do
                table.insert(formatRewards, {id, key})
            end
            -- Utils:previewReward(nil, formatRewards)
            Utils:openView("activity.TanghuluPopView",formatRewards)
        end
        return
    else                        -- 当前组
        if  progressInfo.status == EC_Assist_Item_Status.GETED then
            return
        end
    end

    for j, v in ipairs(self.thlViews[i]:getItems()) do
        v:getChildByName("img_chooseThl"):setVisible(idx == j)
    end
    self.curChooseThl = idx

    -- 材料消耗
    local id, num = next(data.extendData.cost)
    self._ui.lab_goodsNum:setText("x "..num)
    if not self.goods then
        self.goods = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
        self.goods:setScale(0.5)
        self._ui.img_needDi:addChild(self.goods)
        self.goods:setPosition(self._ui.goodsPos:getPosition())
    end
    PrefabDataMgr:setInfo(self.goods,tonumber(id),-1)
    self._ui.img_needDi:show()

    local lastData   = self.data[i][idx - 1]
    local lastStatus = nil
    if lastData then
        lastStatus = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, lastData.id).status
        if lastStatus ~= EC_Assist_Item_Status.ING then
            self.isCanBeMake = true
        else
            self.isCanBeMake = false
        end
    else
        self.isCanBeMake = true
    end
    
    self._ui.btn_make:setGrayEnabled(not self.isCanBeMake)
end

function TanghuluMakeView:loadLive2d()
    local modelId = self.activityInfo.extendData.rolemodle  
    if not self.roleLive2d and modelId then
        self.roleLive2d = ElvesNpcTable:createLive2dNpcID(modelId, nil,false,nil,false).live2d
        self.roleLive2d:registerEvents()
        self.roleLive2d.touchNode:setTouchEnabled(false)
        self.roleLive2d:setScale(0.9) 
        self._ui.rolePos:getParent():addChild(self.roleLive2d)
        self.roleLive2d:setScale(0.5)
        self.roleLive2d:setPosition(self._ui.rolePos:getPosition())
    end
end

function TanghuluMakeView:onSubmitSuccessEvent(activitId, itemId, reward)
    if reward and #reward > 0 then
        Utils:showReward(reward)
    end
    for i = 1, #self.data do
        for k, v in ipairs(self.data[i]) do
            if v.id == itemId then
                self.curRefreshIdx1 = i
                self.curRefreshIdx2 = k
                break
            end
        end
    end
end

function TanghuluMakeView:onRefreshTask()
    local idx1 ,idx2     = self.curRefreshIdx1, self.curRefreshIdx2
    if not idx1 or not idx2 then
        return
    end

    local thlItem    = self.thlViews[idx1]:getItems()[idx2]
    local tulSpine   = thlItem:getChildByName("spine_thl")
    local item       = self.view:getItems()[idx1]
    local lab_resNum = TFDirector:getChildByPath(item, "lab_resNum.lab_resNum")
    local _data = self.data[idx1]

    local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, self.data[idx1][idx2].id)
    if progressInfo.status == EC_Assist_Item_Status.GET then
        tulSpine:show()
        tulSpine:play("boom",false)
        tulSpine:addMEListener(TFARMATURE_COMPLETE,function(sklete)
            sklete:removeMEListener(TFARMATURE_COMPLETE)
            sklete:play("tang",false)
            thlItem:setTexture("ui/activity/thl/sanzha2.png")
            end)
        self:selectOneThl(idx1)
    elseif progressInfo.status == EC_Assist_Item_Status.GETED then
        tulSpine:hide()
        thlItem:setTexture("ui/activity/thl/sanzha3.png")

        local countGet = 0
        for i , v in ipairs(_data) do
            local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.TANGHULU, v.id)
            if progressInfo.status == EC_Assist_Item_Status.GETED then
                countGet = countGet + 1
            end
        end
        lab_resNum:setText(countGet.."/"..#_data)
        self.view:doLayout()
    end
end

return TanghuluMakeView