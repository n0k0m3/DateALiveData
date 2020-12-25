
local UIPageView = requireNew("LuaScript.extends.UIPageView")
local DfwAutumnMainView = class("DfwAutumnMainView", BaseLayer)

local DiceState = {
    IDLE = "i",
    START = "q",
    TURN = "z",
}

function DfwAutumnMainView:initData()
    local activity = ActivityDataMgr2:getActivityInfoByType(EC_ActivityType2.DFW_AUTUMN)
    self.activityId_ = activity[1]
    if self.activityId_ then
        self.activityInfo_ = ActivityDataMgr2:getActivityInfo(self.activityId_)
    else
        Box("夏日祭活动未开启")
    end

    self.maxGridNum_ = Utils:getKVP(46012,"lenth")
    self.previewGridNum_ = Utils:getKVP(46012,"initLenth")
    self.diceData_ = DfwDataMgr:getChessesDice()
    self.gridItems_ = {}
    self.diceItems_ = {}
    self.rewardItems_ = {}
    self.isRolling_ = false
    self.dicePointCache_ = {}
end

function DfwAutumnMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.dafuwong.dfwAutumnMainView")
end

function DfwAutumnMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Image_gridItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_gridItem")
    self.Image_rewardItem = TFDirector:getChildByPath(self.Panel_prefab, "Image_rewardItem")
    self.Button_buffItem = TFDirector:getChildByPath(self.Panel_prefab, "Button_buffItem")
    self.Panel_diceItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_diceItem")
    self.Panel_floatTipItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_floatTipItem")

    self.Panel_backgroud = TFDirector:getChildByPath(self.Panel_root, "Panel_backgroud")
    self.Panel_sky = TFDirector:getChildByPath(self.Panel_backgroud, "Panel_sky")
    self.Panel_sky_size = self.Panel_sky:Size()
    self.Panel_cloud = TFDirector:getChildByPath(self.Panel_backgroud, "Panel_cloud")
    self.Panel_cloud_size = self.Panel_cloud:Size()
    self.Panel_far = TFDirector:getChildByPath(self.Panel_backgroud, "Panel_far")
    self.Panel_far_size = self.Panel_far:Size()
    self.Panel_medium = TFDirector:getChildByPath(self.Panel_backgroud, "Panel_medium")
    self.Panel_medium_size = self.Panel_medium:Size()
    self.Image_sky = {}
    self.Image_cloud = {}
    self.Image_far = {}
    self.Image_medium = {}
    for i = 1, 2 do
        self.Image_sky[i] = TFDirector:getChildByPath(self.Panel_sky, "Image_sky_" .. i)
        self.Image_cloud[i] = TFDirector:getChildByPath(self.Panel_cloud, "Image_cloud_" .. i)
        self.Image_far[i] = TFDirector:getChildByPath(self.Panel_far, "Image_far_" .. i )
        self.Image_medium[i] = TFDirector:getChildByPath(self.Panel_medium, "Image_medium_" .. i)
    end

    self.ScrollView_map = TFDirector:getChildByPath(self.Panel_root, "ScrollView_map")
    self.Panel_map = TFDirector:getChildByPath(self.ScrollView_map, "Panel_map")
    self.Panel_role = TFDirector:getChildByPath(self.ScrollView_map, "Panel_role")
    self.Panel_grid = TFDirector:getChildByPath(self.Panel_map, "Panel_grid")
    self.Panel_reward = TFDirector:getChildByPath(self.Panel_map, "Panel_reward")

    self.Button_store = TFDirector:getChildByPath(self.Panel_root, "Button_store")
    self.Label_store = TFDirector:getChildByPath(self.Button_store, "Label_store")
    self.Button_turntable = TFDirector:getChildByPath(self.Panel_root, "Button_turntable")
    self.Label_turntable = TFDirector:getChildByPath(self.Button_turntable, "Label_turntable")
    self.Button_task = TFDirector:getChildByPath(self.Panel_root, "Button_task")
    self.Label_task = TFDirector:getChildByPath(self.Button_task, "Label_task")
    self.Button_hand_account = TFDirector:getChildByPath(self.Panel_root, "Button_hand_account")
    self.Label_hand_account = TFDirector:getChildByPath(self.Button_hand_account, "Label_hand_account")
    self.Button_card = TFDirector:getChildByPath(self.Panel_root, "Button_card")
    self.Label_card = TFDirector:getChildByPath(self.Button_card, "Label_card")
    self.Button_step = TFDirector:getChildByPath(self.Panel_root, "Button_step")
    self.Label_step_title = TFDirector:getChildByPath(self.Button_step, "Label_step_title")
    self.Label_step = TFDirector:getChildByPath(self.Button_step, "Label_step")
    self.Spine_box = TFDirector:getChildByPath(self.Button_step, "Spine_box")
    local label = TFLabel:create()
    label:setText(" ")
    self.Spine_box:addChild(label)
    self.Button_box = TFDirector:getChildByPath(self.Button_step, "Button_box")
    local ScrollView_buff = TFDirector:getChildByPath(self.Panel_root, "ScrollView_buff")
    self.ListView_buff = UIListView:create(ScrollView_buff)
    self.Image_buffDesc = TFDirector:getChildByPath(self.Panel_root, "Image_buffDesc"):hide()
    self.Label_buffDesc = TFDirector:getChildByPath(self.Image_buffDesc, "Label_buffDesc")
    local Panel_dice = TFDirector:getChildByPath(self.Panel_root, "Panel_dice")
    local ScrollView_dice = TFDirector:getChildByPath(Panel_dice, "Panel_mask.ScrollView_dice")
    self.Panel_dice = Panel_dice
    self.PageView_dice = UIPageView:create(ScrollView_dice)
    self.PageView_dice:setMainIndex(2)
    self.Label_dice_tip = TFDirector:getChildByPath(Panel_dice, "Label_dice_tip")
    self.Button_left = TFDirector:getChildByPath(Panel_dice, "Button_left")
    self.Button_right = TFDirector:getChildByPath(Panel_dice, "Button_right")
    self.Image_control_dice = TFDirector:getChildByPath(Panel_dice, "Image_control_dice"):hide()
    self.Label_control_name = TFDirector:getChildByPath(self.Image_control_dice, "Label_control_name")
    self.Label_control_tip = TFDirector:getChildByPath(self.Image_control_dice, "Label_control_tip")
    self.Image_other_dice = TFDirector:getChildByPath(Panel_dice, "Image_other_dice"):hide()
    self.Label_dice_name = TFDirector:getChildByPath(self.Image_other_dice, "Label_dice_name")

    self.Panel_specialUse = TFDirector:getChildByPath(self.Panel_root, "Panel_specialUse")
    self.Button_cancel = TFDirector:getChildByPath(self.Panel_specialUse, "Button_cancel")

    
    self.Button_dice_point = {}
    for i = 1, 6 do
        self.Button_dice_point[i] = TFDirector:getChildByPath(self.Image_control_dice, "Button_dice_point_" .. i)
    end
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_root, "Panel_touch")

    self:refreshView()
end

function DfwAutumnMainView:initRole()
    local rolePath = Utils:getKVP(46012,"roleControl")
    self.Spine_role = SkeletonAnimation:create(rolePath)
    self.Panel_role:addChild(self.Spine_role)
    self.Spine_role:setScale(0.82)
    self.Spine_role:play("dice_stand", true)
end

function DfwAutumnMainView:moveRoleToGrid(curSite, targetSite, isJump)
    if isJump then
        local targetPos = self.gridItems_[targetSite]:Pos()
        self.Spine_role:setPositionX(targetPos.x)
    else
        local rolePos = self.Spine_role:Pos()
        local duration = 0
        local aniArr = {}
        local index = 0
        for i = curSite + 1, targetSite do
            local targetPos = self.gridItems_[i]:Pos()
            local curPos = self.gridItems_[i - 1]:Pos()
            local distance = ccpDistance(targetPos, curPos)
            local pos = ccp(targetPos.x, rolePos.y)
            local time = distance / 300
            local rewardItem = self.rewardItems_[i]
            local action = Sequence:create({
                    CallFunc:create(function()
                            Utils:playSound(5002)
                    end),
                    MoveTo:create(time, pos),
                    CallFunc:create(function()
                            if rewardItem then
                                rewardItem:hide()
                            end
                            index = index + 1
                            if #self.awardInfo_[index] == 1 then
                                self:showFloatTip(index, targetPos)
                            end
                            self.totalStep_ = self.totalStep_ + 1
                            self.Label_step:setText(self.totalStep_)
                    end)
            })
            table.insert(aniArr, action)
            duration = duration + time
        end
        local preCompleteCallback = CallFunc:create(function()
                self.Spine_role:play("dice_stand", true)
        end)
        local delay = DelayTime:create(0.3)
        local completeCallfunc = CallFunc:create(function()
            self:actionChess(targetSite)
        end)
        table.insert(aniArr, preCompleteCallback)
        table.insert(aniArr, delay)
        table.insert(aniArr, completeCallfunc)
        local action = Sequence:create(aniArr)
        self.Spine_role:runAction(action)
        return duration
    end
end

function DfwAutumnMainView:actionChess( gridIdx )
    if DatingDataMgr:getIsDating() then return end

    local cfg = DfwDataMgr:getChessesCfg(self.gridData_[gridIdx])

    if cfg.type == 3 and self.eventId_ then
        local eventCfg_ = DfwDataMgr:getChessesEventCfg(self.eventId_)
        if eventCfg_ and eventCfg_.datingId ~= 0  then
            self.ui:timeOut(function () FunctionDataMgr:jStartDating(eventCfg_.datingId) end, 0)
        else
            Utils:openView("dfwautumn.DfwAutumnEventView", self.eventId_, self.eventRewards_, self.eventExRewards_)
            self.doEvent = false
        end
    end

    self.isRolling_ = false

    self.Panel_touch:setTouchEnabled(false)
    self:updateSelectDiceInfo()
    self:updateMap()
end

function DfwAutumnMainView:showFloatTip(index, pos)
    local Panel_floatTipItem = self.Panel_floatTipItem:clone()
    local Image_reward = TFDirector:getChildByPath(Panel_floatTipItem, "Image_reward")
    local Label_count = TFDirector:getChildByPath(Panel_floatTipItem, "Label_count")

    local reward = self.awardInfo_[index][1]
    local cfg = GoodsDataMgr:getItemCfg(reward.id)
    Image_reward:setTexture(cfg.icon)
    Label_count:setTextById(800008, reward.num)

    Panel_floatTipItem:AddTo(self.Spine_role):Pos(ccp(0, pos.y + 250))
    Panel_floatTipItem:Alpha(0.3):Scale(1)
    local spawn = Spawn:create({
    })
    local action = Sequence:create({
            Spawn:create({
                    MoveBy:create(0.3, ccp(0, 100)),
                    FadeIn:create(0.3),
                    ScaleTo:create(0.3, 3.0),
            }),
            DelayTime:create(0.2),
            Spawn:create({
                    MoveBy:create(0.3, ccp(0, 100)),
                    FadeOut:create(0.5),
            }),
            RemoveSelf:create()
    })
    Panel_floatTipItem:runAction(action)
end

function DfwAutumnMainView:moveToGrid(curSite, targetSite)
    local duration = self:moveRoleToGrid(curSite, targetSite)
    self:moveMapToGrid(targetSite, false, duration)
    self.Spine_role:play("dice_move", true)
end

function DfwAutumnMainView:specialAction(...)
    -- body
    local param = {...}


    local specialItemId = DfwDataMgr:getUseItemStatus()
    DfwDataMgr:setUseItemStatus(nil)

    DfwDataMgr:send_SACRIFICE_REQ_ADD_BUFF(specialItemId, param[1] )
end

function DfwAutumnMainView:checkSpecialStatus( i, chessesCfg )
    local specialItemId = DfwDataMgr:getUseItemStatus()
    local checkIndex = i - self.cellInfo_.location
    if specialItemId and chessesCfg then
        specialItemCfg = DfwDataMgr:getChessesBuffCfg(specialItemId)
        if specialItemCfg and specialItemCfg.param then -- 所有字段条件满足才能通过 ,通过判断不满足条件能够简便if 判断逻辑扩展
            self.hasSpecial = true
            if specialItemCfg.param.useOnTypes and table.find(specialItemCfg.param.useOnTypes,chessesCfg.type) == -1 then
                return false
            end

            if specialItemCfg.param.maxIndex and specialItemCfg.param.maxIndex < checkIndex then
                return false
            end

            if specialItemCfg.param.minIndex and specialItemCfg.param.minIndex > checkIndex then
                return false
            end

            self.checkSuc = self.checkSuc or true
            return true
        end
    end
    self.hasSpecial = false
    return false
end


function DfwAutumnMainView:updateMap()
    self.cellInfo_ = DfwDataMgr:getCellInfo()
    self.totalStep_ = self.cellInfo_.totleStep
    self.gridData_ = self.cellInfo_.cellIds

    local x = 0
    local width = 0

    for i, v in ipairs(self.gridData_) do
        local chessesCfg = DfwDataMgr:getChessesCfg(v)
        local Image_gridItem = self.gridItems_[i]:show()
        local Image_build = TFDirector:getChildByPath(Image_gridItem, "Image_build"):hide()
        local Image_clickEffect = TFDirector:getChildByPath(Image_gridItem, "Image_clickEffect"):hide()

        Image_gridItem:setTexture(chessesCfg.style)
        if #chessesCfg.build > 0 then
            Image_build:show():setTexture(chessesCfg.build)
            if chessesCfg.buildOffset.x and chessesCfg.buildOffset.y then
                Image_build:setPosition(chessesCfg.buildOffset)
            end
        end
        local size = Image_gridItem:getSize()
        x = x + size.width * chessesCfg.calAp[1]
        local pos = ccpAdd(chessesCfg.gridOffset, ccp(x, 0))
        Image_gridItem:setPosition(pos)

       
        local function addLightAction( target )
            -- body
            local arr = {
                CCTintTo:create(0.75,248,221,255),
                
                CCTintTo:create(0.75,255,255,255),
            }

            local lightAction = CCRepeatForever:create(Sequence:create(arr))
            target:runAction(lightAction)
            target.lightAction = lightAction
        end

        local function removeLightAction( target )
            -- body
            if target.lightAction then
                target:setColor(ccc3(255,255,255))
                target:stopAction(target.lightAction)
                target.lightAction = nil
            end
        end

        if self:checkSpecialStatus(i,chessesCfg) then -- 判断是否满足可点击条件，显示特效与回调方法
            Image_clickEffect:show()
            addLightAction(Image_gridItem)
            Image_gridItem:setTouchEnabled(true)
            Image_gridItem:onClick(function ( ... )
                -- body
                self:specialAction(i - self.cellInfo_.location,chessesCfg)
            end)
        else
            removeLightAction(Image_gridItem)
            Image_gridItem:setTouchEnabled(false)
        end

        x = pos.x + size.width * chessesCfg.calAp[2]
        width = x
    end

    self.Panel_dice:show()
    if self.hasSpecial and not self.checkSuc then
        DfwDataMgr:setUseItemStatus(nil)
        Utils:showTips(13200400)
    elseif self.hasSpecial then
        self.Panel_dice:hide()
    end

    self.Panel_specialUse:setVisible(self.hasSpecial)
    local size = self.ScrollView_map:getSize()
    size.width = width
    self.ScrollView_map:setInnerContainerSize(size)
    self.ScrollView_map:setSize(GameConfig.WS)
    self.ScrollView_map_ap = self.ScrollView_map:getAnchorPoint()
    self.ScrollView_map_size = self.ScrollView_map:getContentSize()

    self:moveMapToGrid(self.cellInfo_.location, true)
    self:moveRoleToGrid(nil, self.cellInfo_.location, true)

    for i, v in ipairs(self.gridData_) do
        local chessesCfg = DfwDataMgr:getChessesCfg(v)
        local rewardCid
        if chessesCfg.reward.fix and chessesCfg.reward.fix.items then
            rewardCid = chessesCfg.reward.fix.items[1].id
        end
        local Image_rewardItem = self.rewardItems_[i]
        if rewardCid then
            if not Image_rewardItem then
                Image_rewardItem = self.Image_rewardItem:clone()
                self.rewardItems_[i] = Image_rewardItem
                Image_rewardItem:AddTo(self.Panel_reward)
            end
            local rewardCfg = GoodsDataMgr:getItemCfg(rewardCid)
            Image_rewardItem:setTexture(rewardCfg.iconShow)

            Image_rewardItem:setVisible(i > self.cellInfo_.location)
            if Image_rewardItem:isVisible() then
                local Image_gridItem = self.gridItems_[i]
                local x = Image_gridItem:PosX() - 10
                local y = 68
                Image_rewardItem:Pos(x, y)
            end
        else
            if Image_rewardItem then
                Image_rewardItem:hide()
            end
        end
    end
    self.Label_step:setText(self.cellInfo_.totleStep)
    self:updateBuff()

    if not self.doEvent and self.cellInfo_.event and not self.cellInfo_.event.status then -- 当前格子未完成,直接进入事件
        self.doEvent = true
        self.eventId_ = self.cellInfo_.event.eventId
        self:actionChess(self.cellInfo_.location)
    end
end

function DfwAutumnMainView:initAllGrid()
    for i = 1, self.maxGridNum_ do
        local Image_gridItem = self.Image_gridItem:clone():hide()
        Image_gridItem:AddTo(self.Panel_grid)
        Image_gridItem:ZO(self.maxGridNum_ - i)
        self.gridItems_[i] = Image_gridItem
    end
end

function DfwAutumnMainView:moveMapToGrid(index, isJump, duration)
    duration = duration or 0.5
    local innerContainer = self.ScrollView_map:getInnerContainer()

    local anchorPoint = self.ScrollView_map:getAnchorPoint()
    local innerSize = innerContainer:getSize()
    local contentSize = self.ScrollView_map:getSize()
    local center = ccp(-contentSize.width * 0.5, -contentSize.height * 0.5)
    local innerPos = innerContainer:getPosition()
    local minY = contentSize.height - innerSize.height
    local h = -minY
    local w = contentSize.width - innerSize.width

    local Image_gridItem = self.gridItems_[index]
    local position = Image_gridItem:Pos()
    local wp = Image_gridItem:getParent():convertToWorldSpaceAR(position)
    local np = self.ScrollView_map:convertToNodeSpaceAR(wp)
    local foo = ccpSub(innerPos, np)
    local dis = ccpSub(foo, center)
    dis.x = clampf(dis.x, 0, w)
    if w ~= 0 then
        local percentX = -dis.x * 100 / w
        local percentY = (dis.y - minY) * 100 / h
        -- local time = math.abs(dis.x - innerPos.x) / 600
        if isJump then
            self.ScrollView_map:jumpTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, percentX, 0)
            local offset = self.ScrollView_map:getContentOffset()
            self.preOffsetX_ = offset.x + self.ScrollView_map_size.width * self.ScrollView_map_ap.x
        else
            self.ScrollView_map:scrollTo(TF_SCROLLVIEW_SCROLL_TO_PERCENT_HORIZONTAL, duration, false, percentX, percentY)
        end
    end
end

function DfwAutumnMainView:refreshView()
    self.Label_store:setTextById(13210001)
    self.Label_turntable:setTextById(13210002)
    self.Label_task:setTextById(13210003)
    self.Label_hand_account:setTextById(13210004)
    self.Label_card:setTextById(13210005)
    self.Label_control_tip:setTextById(13210006)
    self.Label_step_title:setTextById(13210007)
    self.Panel_touch:setSize(GameConfig.WS)

    local x = GameConfig.WS.width * 0.5
    self.Panel_backgroud:setPositionX(-x)

    self:initAllGrid()
    self:initRole()
    self:updateMap()
    self:initDice()
    self:updateStepState()
end

function DfwAutumnMainView:updateStepState()
    local isShowRedPoint = ActivityDataMgr2:isShowRedPoint(self.activityId_)
    self.Button_box:setVisible(not isShowRedPoint)
    self.Spine_box:setVisible(isShowRedPoint)
end

function DfwAutumnMainView:addDiceItem()
    local Panel_diceItem = self.Panel_diceItem:clone()
    local foo = {}
    foo.root = Panel_diceItem
    local resPath = "effect_chunriji_touzi_zhuandong"
    foo.Spine_dice = SkeletonAnimation:create(string.format("effect/%s/%s", resPath, resPath))
    foo.root:addChild(foo.Spine_dice)
    foo.Spine_dice:setPosition(ccp(0, -6))
    foo.Label_count = TFDirector:getChildByPath(foo.root, "Label_count")
    self.PageView_dice:addItem(foo.root)
    self.diceItems_[foo.root] = foo
    return foo
end

function DfwAutumnMainView:initDice()
    for i, v in ipairs(self.diceData_) do
        local diceCfg = DfwDataMgr:getChessesDiceCfg(v)
        self.dicePointCache_[v] = diceCfg.upper
        local foo = self:addDiceItem()
        local name = self:getDiceAnimation(v, diceCfg.upper, DiceState.IDLE)
        foo.Spine_dice:play(name)
    end
    self:updateAllDiceItem()
    self.PageView_dice:scrollToIndex(2)
end

function DfwAutumnMainView:getDiceAnimation(diceCid, point, state)
    local diceCfg = DfwDataMgr:getChessesDiceCfg(diceCid)
    local name = diceCfg.animation .. point .. state
    return name
end

function DfwAutumnMainView:updateAllDiceItem()
    for i, v in ipairs(self.PageView_dice:getItems()) do
        local foo = self.diceItems_[v]
        local diceCid = self.diceData_[i]
        local diceCfg = DfwDataMgr:getChessesDiceCfg(diceCid)
        local itemCfg = GoodsDataMgr:getItemCfg(diceCfg.costItem)
        local count = GoodsDataMgr:getItemCount(diceCfg.costItem)
        foo.Label_count:setTextById(800005, count, itemCfg.totalMax)
    end
end

function DfwAutumnMainView:updateBuff()
    self.ListView_buff:removeAllItems()
    if self.cellInfo_.buffIds then
        for i, v in ipairs(self.cellInfo_.buffIds) do
            local Button_buffItem = self.Button_buffItem:clone()
            local buffCfg = DfwDataMgr:getChessesBuffCfg(v)
            Button_buffItem:setTextureNormal(buffCfg.buffIcon)
            self.ListView_buff:pushBackCustomItem(Button_buffItem)
            Button_buffItem:onClick(function()
                    local wp = Button_buffItem:getParent():convertToWorldSpaceAR(Button_buffItem:Pos())
                    local np = self.Image_buffDesc:getParent():convertToNodeSpaceAR(wp)
                    self.Image_buffDesc:PosX(np.x + 20)
                    self.Label_buffDesc:setTextById(buffCfg.buffDes)
                    local action = Sequence:create({
                            DelayTime:create(2.0),
                            FadeOut:create(0.5),
                            Hide:create(),
                    })
                    self.Image_buffDesc:Show():Alpha(1)
                    self.Image_buffDesc:stopAllActions()
                    self.Image_buffDesc:runAction(action)
                    Utils:playSound(5004)
                    return true
            end)
        end
    end
end

function DfwAutumnMainView:updateSelectDiceInfo()
    if self.isRolling_ then return end

    local currentIndex = self.PageView_dice:getCurrentItemIndex()
    local diceCid = self.diceData_[currentIndex]
    local diceCfg = DfwDataMgr:getChessesDiceCfg(diceCid)
    local itemCfg = GoodsDataMgr:getItemCfg(diceCid)

    self.Label_dice_tip:setTextById(diceCfg.desTextId)
    self.Image_other_dice:setVisible(diceCfg.type == 1)
    self.Image_control_dice:setVisible(diceCfg.type == 2)

    if self.Image_other_dice:isVisible() then
        self.Label_dice_name:setTextById(diceCfg.nameTextId)
    end

    if self.Image_control_dice:isVisible() then
        self.Label_control_name:setTextById(itemCfg.nameTextId)
    end

    for i, v in ipairs(self.PageView_dice:getItems()) do
        local foo = self.diceItems_[v]
        local scale = (i == currentIndex) and 1.0 or 0.8
        foo.Spine_dice:setScale(scale)
    end
end

function DfwAutumnMainView:onScrollViewChangedEvent()
    local skyX = self.Panel_sky:getPositionX()
    local cloudX = self.Panel_cloud:getPositionX()
    local farX = self.Panel_far:getPositionX()
    local mediumX = self.Panel_medium:getPositionX()
    local offset = self.ScrollView_map:getContentOffset()
    local offsetX = offset.x + self.ScrollView_map_size.width * self.ScrollView_map_ap.x
    local deltaX = offsetX
    if self.preOffsetX_ then
        deltaX = offsetX - self.preOffsetX_
    end

    self.Panel_sky:setPositionX(skyX + deltaX * 0.3)
    self.Panel_cloud:setPositionX(cloudX + deltaX * 0.5)
    self.Panel_far:setPositionX(farX + deltaX * 0.6)
    self.Panel_medium:setPositionX(mediumX + deltaX * 0.7)

    local skyPos = self.Image_sky[1]:getParent():convertToWorldSpaceAR(self.Image_sky[1]:Pos())
    if skyPos.x + self.Panel_sky_size.width <= 0 then
        local x = self.Image_sky[2]:PosX() + self.Panel_sky_size.width
        self.Image_sky[1]:PosX(x)
    end
    local skyPos2 = self.Image_sky[2]:getParent():convertToWorldSpaceAR(self.Image_sky[2]:Pos())
    if skyPos2.x + self.Panel_sky_size.width <= 0 then
        local x = self.Image_sky[1]:PosX() + self.Panel_sky_size.width
        self.Image_sky[2]:PosX(x)
    end
    if skyPos.x >= 0 and skyPos2.x >= 0 then
        if skyPos.x > skyPos2.x then
            local x = self.Image_sky[2]:PosX() - self.Panel_sky_size.width
            self.Image_sky[1]:PosX(x)
        else
            local x = self.Image_sky[1]:PosX() - self.Panel_sky_size.width
            self.Image_sky[2]:PosX(x)
        end
    end

    local cloudPos = self.Image_cloud[1]:getParent():convertToWorldSpaceAR(self.Image_cloud[1]:Pos())
    if cloudPos.x + self.Panel_cloud_size.width <= 0 then
        local x = self.Image_cloud[2]:PosX() + self.Panel_cloud_size.width
        self.Image_cloud[1]:PosX(x)
    end
    local cloudPos2 = self.Image_cloud[2]:getParent():convertToWorldSpaceAR(self.Image_cloud[2]:Pos())
    if cloudPos2.x + self.Panel_cloud_size.width <= 0 then
        local x = self.Image_cloud[1]:PosX() + self.Panel_cloud_size.width
        self.Image_cloud[2]:PosX(x)
    end
    if cloudPos.x >= 0 and cloudPos2.x >= 0 then
        if cloudPos.x > cloudPos2.x then
            local x = self.Image_cloud[2]:PosX() - self.Panel_cloud_size.width
            self.Image_cloud[1]:PosX(x)
        else
            local x = self.Image_cloud[1]:PosX() - self.Panel_cloud_size.width
            self.Image_cloud[2]:PosX(x)
        end
    end

    local farPos = self.Image_far[1]:getParent():convertToWorldSpaceAR(self.Image_far[1]:Pos())
    if farPos.x + self.Panel_far_size.width <= 0 then
        local x = self.Image_far[2]:PosX() + self.Panel_far_size.width
        self.Image_far[1]:PosX(x)
    end
    local farPos2 = self.Image_far[2]:getParent():convertToWorldSpaceAR(self.Image_far[2]:Pos())
    if farPos2.x + self.Panel_far_size.width <= 0 then
        local x = self.Image_far[1]:PosX() + self.Panel_far_size.width
        self.Image_far[2]:PosX(x)
    end
    if farPos.x >= 0 and farPos2.x >= 0 then
        if farPos.x > farPos2.x then
            local x = self.Image_far[2]:PosX() - self.Panel_far_size.width
            self.Image_far[1]:PosX(x)
        else
            local x = self.Image_far[1]:PosX() - self.Panel_far_size.width
            self.Image_far[2]:PosX(x)
        end
    end

    local mediumPos = self.Image_medium[1]:getParent():convertToWorldSpaceAR(self.Image_medium[1]:Pos())
    if mediumPos.x + self.Panel_medium_size.width <= 0 then
        local x = self.Image_medium[2]:PosX() + self.Panel_medium_size.width
        self.Image_medium[1]:PosX(x)
    end
    local mediumPos2 = self.Image_medium[2]:getParent():convertToWorldSpaceAR(self.Image_medium[2]:Pos())
    if mediumPos2.x + self.Panel_medium_size.width <= 0 then
        local x = self.Image_medium[1]:PosX() + self.Panel_medium_size.width
        self.Image_medium[2]:PosX(x)
    end
    if mediumPos.x >= 0 and mediumPos2.x >= 0 then
        if mediumPos.x > mediumPos2.x then
            local x = self.Image_medium[2]:PosX() - self.Panel_medium_size.width
            self.Image_medium[1]:PosX(x)
        else
            local x = self.Image_medium[1]:PosX() - self.Panel_medium_size.width
            self.Image_medium[2]:PosX(x)
        end
    end
    self.preOffsetX_ = offsetX
end

function DfwAutumnMainView:rollDice(diceCid, point)
    local diceCfg = DfwDataMgr:getChessesDiceCfg(diceCid)
    local count = GoodsDataMgr:getItemCount(diceCfg.costItem)
    if count >= diceCfg.costNum then
        DfwDataMgr:send_SACRIFICE_REQGET_AWARD_SACRIFICE(diceCid, point)
        self.Panel_touch:setTouchEnabled(true)
        self.Image_other_dice:hide()
        self.Image_control_dice:hide()
    else
        Utils:showTips(13210018)
    end
end

function DfwAutumnMainView:datingFinish(  )
    -- body
    self.doEvent = nil
end

function DfwAutumnMainView:registerEvents()
    EventMgr:addEventListener(self, EV_BAG_ITEM_UPDATE, handler(self.onItemUpdateEvent, self))
    EventMgr:addEventListener(self, EV_DFW_ROLL_DICE, handler(self.onRollDiceEvent, self))
    EventMgr:addEventListener(self, EV_DFW_UPDATE_BUFF, handler(self.onUpdateBuffEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(self.onUpdateProgressEvent, self))
    EventMgr:addEventListener(self, EV_DFW_USE_SPECIAL_ITEM, handler(self.updateMap, self))
    EventMgr:addEventListener(self, EV_DATING_EVENT.closeSriptView, handler(self.datingFinish, self))
    EventMgr:addEventListener(self, EV_RECONECT_EVENT, function ( ... )
        -- body
        self.Panel_touch:setTouchEnabled(self.isRolling_)
    end)


    self.ScrollView_map:addMEListener(TFSCROLLVIEW_CHANGED, handler(self.onScrollViewChangedEvent, self))

    self.Button_store:onClick(function()
            Utils:playSound(5004)
            FunctionDataMgr:jStore(301000)
            return true
    end)

    self.Button_turntable:onClick(function()
            Utils:openView("dfwautumn.DfwAutumnTurntableView")
            Utils:playSound(5004)
            return true
    end)

    self.Button_task:onClick(function()
            Utils:openView("dfwautumn.DfwAutumnTaskView")
            Utils:playSound(5004)
            return true
    end)

    self.Button_hand_account:onClick(function()
            Utils:openView("dfwautumn.DfwAutumnHandAccountView")
            Utils:playSound(5004)
            return true
    end)

    self.Button_left:onClick(function()
            local curIndex = self.PageView_dice:getCurrentItemIndex()
            local index = curIndex - 1
            if index >= 1 then
                self.PageView_dice:scrollToIndex(index)
            end
            Utils:playSound(5004)
            return true
    end)

    self.Button_step:onClick(function()
            Utils:openView("dfwautumn.DfwAutumnStepRewardView")
            Utils:playSound(5004)
            return true
    end)

    self.Button_right:onClick(function()
            local curIndex = self.PageView_dice:getCurrentItemIndex()
            local items = self.PageView_dice:getItems()
            local index = curIndex + 1
            if index <= #items then
                self.PageView_dice:scrollToIndex(index)
            end
            Utils:playSound(5004)
            return true
    end)

    self.Button_card:onClick(function()
            Utils:openView("dfwautumn.DfwAutumnCardView")
            Utils:playSound(5004)
            return true
    end)

    self.PageView_dice:addEventListener(function(event)
            if event.name == UIPageView.EVENT.TURNING then
                self:updateSelectDiceInfo()
            end
    end)

    for i, v in ipairs(self.PageView_dice:getItems()) do
        local diceCid = self.diceData_[i]
        local diceCfg = DfwDataMgr:getChessesDiceCfg(diceCid)
        local foo = self.diceItems_[v]
        foo.root:onClick(function()
            local currentIndex = self.PageView_dice:getCurrentItemIndex()
            if i == currentIndex then
                if diceCfg.type == 1 then
                    self:rollDice(diceCid)
                end
            else
                self.PageView_dice:scrollToIndex(i)
            end
        end)
    end

    for i, v in ipairs(self.Button_dice_point) do
        v:onClick(function()
                local currentDiceIndex = self.PageView_dice:getCurrentItemIndex()
                local diceCid = self.diceData_[currentDiceIndex]
                self:rollDice(diceCid, i)
        end)
    end

    self.Spine_role:addMEListener(
        TFARMATURE_COMPLETE,
        function(_, aniName)
            if aniName == "dice_happy" then
                self.Panel_root:timeOut(function()
                        self:moveToGrid(self.originLocation_, self.targetLocation_)
                end)
            elseif aniName == "dice_cards" then
                self.Panel_root:timeOut(function()
                        if self.needMoveToGrids then
                            self.needMoveToGrids = nil
                            self:moveToGrid(self.originLocation_, self.targetLocation_)
                        else
                            self.Spine_role:play("dice_stand", true)
                        end
                end)
            end
        end
    )
    self.Button_cancel:onClick(function ( ... )
        -- body
        DfwDataMgr:setUseItemStatus(nil)
    end)
end

function DfwAutumnMainView:removeEvents( ... )
    -- body
    self.super.removeEvents(self)
    DfwDataMgr:setUseItemStatus(nil)
end

function DfwAutumnMainView:onRollDiceEvent(originLocation, awardStep, buffStep, awardInfo, eventAward)
    self.awardInfo_ = {}
    if awardInfo then
        for i, v in ipairs(awardInfo) do
            local rewards = {}
            if v.rewards then
                table.insertTo(rewards, v.rewards)
            end
            if v.extraRewards then
                table.insertTo(rewards, v.extraRewards)
            end
            self.awardInfo_[i] = Utils:mergeReward(rewards)
        end
    end

    if eventAward then
        self.eventRewards_ = eventAward.eventRewards or {}
        self.eventExRewards_ = eventAward.eventExRewards or {}
        self.eventId_ = eventAward.eventId
    end
    local location = originLocation + awardStep + buffStep

    self:moveMapToGrid(self.cellInfo_.location, true)

    self.originLocation_ = originLocation
    self.targetLocation_ = location
    self.isRolling_ = true
    if awardStep > 0 then
        local currentDiceIndex = self.PageView_dice:getCurrentItemIndex()
        local diceCid = self.diceData_[currentDiceIndex]
        local item = self.PageView_dice:getItem(currentDiceIndex)
        local foo = self.diceItems_[item]
        foo.Spine_dice:addMEListener(
            TFARMATURE_COMPLETE,
            function(_, aniName)
                local state = aniName[#aniName]
                if state == DiceState.START then
                    local name = self:getDiceAnimation(diceCid, awardStep, DiceState.TURN)
                    foo.Spine_dice:play(name, 0)
                elseif state == DiceState.TURN then
                    -- local name = self:getDiceAnimation(diceCid, awardStep, DiceState.IDLE)
                    -- foo.Spine_dice:play(name, false)
                    self.Spine_role:play("dice_happy", false)
                end
            end
        )

        local cachePoint = self.dicePointCache_[diceCid] or 1
        local name = self:getDiceAnimation(diceCid, cachePoint, DiceState.START)
        foo.Spine_dice:play(name, false)
        self.dicePointCache_[diceCid] = awardStep
        Utils:playSound(5003)
    else
        self.needMoveToGrids = true
    end
end

function DfwAutumnMainView:onUpdateBuffEvent()
    Utils:playSound(5001)
    self.Spine_role:play("dice_cards", false)
    self:updateBuff()
end

function DfwAutumnMainView:onUpdateProgressEvent()
    self:updateStepState()
end

function DfwAutumnMainView:onItemUpdateEvent()
    self:updateAllDiceItem()
end

return DfwAutumnMainView
