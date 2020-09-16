-- 新大富翁主界面
local DfwNewMainView =  class("DfwNewMainView", BaseLayer)

--[[
    奖励的状态
]]
local RewardState = {
    NOT_REACH = 1,  -- 未达成
    AVAILABLE = 2,  -- 可领取
    RECVIVEED = 3   -- 已领取
}

--[[
    色子的状态
]]
local RollState = {
    RANDOM = 1, -- 随机
    SELECT = 2, -- 任意选择
    FIXED = 3   -- 固定点数
}

-- 圈数任务的完成条件
local TASK_FINISH_ID = 11040

-- 回到起点的类型
local DFW_RULE_GO_BACK_TYPE = 6

--[[
    日志输出
]]
local dfw = {}
function dfw.debug(str, ...)
    if (true) then
        print(string.format(str, ...))
    end
end

--[[
    领取奖励
]]
local function onShowTaskRewards(self, activityID, itemID, rewards)
    if (rewards) then
        Utils:showReward(rewards)
    end
end

--[[
    更新-选择的按钮
]]
local function updateSelectDiceView(self, button, point)
    local pos = button:getPosition()

    if (self.Panel_dice_select and self.Panel_dice_select:isVisible()) then
        local selectedImage = self.Image_dice_selected
        if (selectedImage) then
            selectedImage:setVisible(true)
            selectedImage:setPosition(ccp(pos.x + 3, pos.y + 2))
        end

        self.dicePoint = point
    end
end

--[[
    更新
]]
local function updateDiceSelectVisible(self)
    if (self.Panel_dice_select) then
        local isVisible = self.Panel_dice_select:isVisible()

        self.Panel_dice_select:setVisible(not isVisible)
        if (not isVisible) then self.Image_dice_selected:setVisible(isVisible) end

        dfw.debug("DfwNewMainView: the dice view is visible %s", not isVisible)
    end
end

--[[
    投掷色子
]]
local function onRollDicePoint(self)
    dfw.debug("DfwNewMainView: the roll dice point is %s", self.dicePoint)
    if (self.dicePoint and self.dicePoint > 0) then
        DfwDataMgr:send_ZILLIONAIRE_REQ_THROW_DICE(self.dicePoint)
    end

    updateDiceSelectVisible(self)
end

--[[
    更新-金币和色子数
]]
local function updateGoldCount(self)
    local goldCount = GoodsDataMgr:getItemCount(620001)

    local cfg = TabDataMgr:getData("Item", 620001)
    if (self.Image_gold) then
        self.Image_gold:setTexture(cfg.icon)
    end
    if (self.Label_gold) then
        self.Label_gold:setString(goldCount)
    end
end
local function updateDiceCount(self)
    local diceCount = 0
    local cfg = TabDataMgr:getData("DiscreteData", 1100007)
    if (cfg) then
        local data = cfg.data
        
        local itemCount = GoodsDataMgr:getItemCount(data.itemCid)
        diceCount = math.floor(itemCount / data.num)

        local cfg = TabDataMgr:getData("Item", data.itemCid)

        if (self.Image_dice) then
            self.Image_dice:setTexture(cfg.icon)
        end
        if (self.Label_dice) then
            self.Label_dice:setString(diceCount)
        end

        dfw.debug("DfwNewMainView: the item cid %s, item num %s, item count is %s", data.itemCid, data.num, itemCount)
    end
end
local function updateGoldAndDice(self)
    updateGoldCount(self)
    updateDiceCount(self)
end

--[[
    更新当前的圈数
]]
local function updateCurrentProgress(self)
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        local progressValue = activityInfo.extendData.totalCircel or 0

        if (self.Label_curr_value) then
            self.Label_curr_value:setString(progressValue)
        end
    end
end

--[[
    更新棋盘视图
]]
local function updateChessView(self)
    local dfwCardCfg = TabDataMgr:getData("DfwRule")
    if (dfwCardCfg) then
        -- 获得棋盘格子
        local grids = self:getChessGrids()
        for i = 1, #grids do
            local grid = grids[i]
            local info = dfwCardCfg[i]

            -- 设置棋盘格子
            grid:setTexture(info.grid)
        end
    end
end

--[[
    更新buff视图
]]
local function updateBuffView(self)
    if (self.buffView) then
        self.buffView:setVisible(false)
    end
    self.diceState = RollState.RANDOM
    self.dicePoint = 0
    self.lastBuffID = 0

    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        local buffID = activityInfo.extendData.equipItemCid

        if (buffID) and tonumber(buffID) >0 then
            local cfgItem = TabDataMgr:getData("DfwCard", buffID)

            if (cfgItem) then
                if (self.buffView) then
                    self.buffView:setVisible(true)
                    self.buffView:setTextureNormal(cfgItem.buffIcon)

                    local Label_des = TFDirector:getChildByPath(self.buffView, "Label_effect")
                    Label_des:setTextById(cfgItem.titleTwo)
                end
                local param = cfgItem.param
                if (param.dice) then
                    if (type(param.dice) == "table") then
                        self.diceState = RollState.SELECT
                    else
                        self.diceState = RollState.FIXED
                        self.dicePoint = param.dice
                    end
                end
            end

            self.lastBuffID = buffID
        end
    end

    if (self.dicePoint > 0) then
        self.Spine_dice:play("hong"..self.dicePoint.."i")
    end
end

--[[
    更新-奖励格子
]]
local function updateRewardGrid(self, grid, progressInfo, itemCfg)
    local state = progressInfo.status

    local Label_progress = TFDirector:getChildByPath(grid, "Label_progress")
    Label_progress:setTextById(itemCfg.des1)

    local Panel_geted = TFDirector:getChildByPath(grid, "Panel_geted")
    local Button_geted = TFDirector:getChildByPath(Panel_geted, "Button_geted")
    Button_geted:setOpacity(255 * 0.3)
    
    local Panel_canGet = TFDirector:getChildByPath(grid, "Panel_canGet")
    local Spine_receive = TFDirector:getChildByPath(Panel_canGet, "Spine_receive")
    Spine_receive:play("animation", true)

    local Button_canGet = TFDirector:getChildByPath(Panel_canGet, "Button_canGet")
    Button_canGet:setOpacity(255 * 0.3)
    
    local Panel_notGet = TFDirector:getChildByPath(grid, "Panel_notGet")
    local Button_notGet = TFDirector:getChildByPath(Panel_notGet, "Button_notGet")
    Button_notGet:setOpacity(255 * 0.3)

    Panel_geted:setVisible(state == EC_TaskStatus.GETED)
    Panel_canGet:setVisible(state == EC_TaskStatus.GET)
    Panel_notGet:setVisible(state == EC_TaskStatus.ING)

    Button_geted:onClick(function()
        self:showPreviewReward(itemCfg)
    end)
    Button_canGet:onClick(function()
        ActivityDataMgr2:send_ACTIVITY_NEW_SUBMIT_ACTIVITY(self.activityID, itemCfg.id)
    end)
    Button_notGet:onClick(function()
        self:showPreviewReward(itemCfg)
    end)
end
--[[
    更新奖励进度视图
]]
local function updateRewardView(self)
    local itemCfgs = {}
    local progressInfos = {}
    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)

    local count = 0
    for i = 1, #activityInfo.items do
        local itemID = activityInfo.items[i]

        local itemCfg = TabDataMgr:getData("DfwTask", itemID)
        if (itemCfg.finishCondId == TASK_FINISH_ID) then
            local progressInfo = ActivityDataMgr2:getProgressInfo(EC_ActivityType2.DFW_NEW, itemID)
            table.insert(progressInfos, progressInfo)

            table.insert(itemCfgs, itemCfg)
            count = count + 1
        end
    end
    if (not self._rewardGrids or #self._rewardGrids == 0) then
        self._rewardGrids = {}

        local oldSize = self.ScrollView_reward:getInnerContainerSize()

        local width = 0
        for i = 1, count do
            local grid = self.Panel_rewardItem:clone()
            grid:setPosition((i - 1) * 150 + 30, 0)
            self.ScrollView_reward:addChild(grid)
            table.insert(self._rewardGrids, grid)

            if (i ~= count) then
                local line = self.Image_con_line:clone()
                line:setPosition((i - 1) * 150 + 140, oldSize.height/2 + 10)
                self.ScrollView_reward:addChild(line)
            end

            width = width + 150
        end
        width = width > oldSize.width and width or oldSize.width
        self.ScrollView_reward:setInnerContainerSize(CCSize(width, oldSize.height))
    end

    for i = 1, count do
        local progressInfo = progressInfos[i]

        local grid = self._rewardGrids[i]
        updateRewardGrid(self, grid, progressInfo, itemCfgs[i])
    end
end

--[[
    更新-棋子位置
]]
local function updateRollRole(self)
    if (not self.roleSpine) then
        self.roleSpine = self:getHeroQModel()
    end

    local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
    if (activityInfo) then
        local currPosition = activityInfo.extendData.curPos

        dfw.debug("DfwNewMainView: the curr postion is %s", currPosition)

        local grid = self._chessGrids[currPosition]
        local position = grid:getPosition()

        self.roleSpine:setPosition(position)

        self.currPosition = currPosition
    end
end
--[[
    棋子跳跃
    @oldPos 最初的位置
    @moveTrack 棋子的移动轨迹
]]
local function jumpRollRole(self, oldPos, moveTrack, callback)
    local jumpActions = {}
    for i = 1, #moveTrack do
        local isGoBack = false

        local nextPos = moveTrack[i]
        local stepCount = nextPos - oldPos

        if (oldPos > nextPos) then
            local tmpCount = nextPos + 24 - oldPos
            if (tmpCount <= 6) then stepCount = tmpCount end
        end

        -- 如果棋子位置类型为6回到了起点
        local cfg = TabDataMgr:getData("DfwRule", oldPos)
        if (cfg.type == DFW_RULE_GO_BACK_TYPE) then isGoBack = true end

        if (isGoBack) then
            local grid = self._chessGrids[1]
            local pos = grid:getPosition()

            local startAngry = CCCallFunc:create(function()
                if (self.roleSpine) then
                    self.roleSpine:play("angry", true)
                end
            end)
            table.insert(jumpActions, startAngry)

            local jump = CCJumpTo:create(0.5, pos, 100, 1)
            table.insert(jumpActions, jump)

            local delay = CCDelayTime:create(1.0)
            local stopAngry = CCCallFunc:create(function()
                if (self.roleSpine) then
                    self.roleSpine:play("idle", true)
                end
            end)
            table.insert(jumpActions, delay)
            table.insert(jumpActions, stopAngry)

            break
        else
            for j = 1, math.abs(stepCount) do
                local nowJumpPos = stepCount > 0 and oldPos + j or oldPos - j
                nowJumpPos = (nowJumpPos > 24) and nowJumpPos - 24 or nowJumpPos
                nowJumpPos = (nowJumpPos < 1) and nowJumpPos + 24 or nowJumpPos

                local grid = self._chessGrids[nowJumpPos]
                local pos = grid:getPosition()

                local playEffect = CCCallFunc:create(function()
                    Utils:playSound(5002)
                end)
                table.insert(jumpActions, playEffect)

                local jump = CCJumpTo:create(0.2, pos, 50, 1)
                table.insert(jumpActions, jump)
            end
            if (i ~= #moveTrack) then
                local delay = CCDelayTime:create(0.5)
                table.insert(jumpActions, delay)
            end

            oldPos = nextPos
        end
    end

    local callFunc = CCCallFunc:create(callback)
    table.insert(jumpActions, callFunc)

    local sequence = CCSequence:create(jumpActions)
    
    self.roleSpine:runAction(sequence)
end

--[[
    buff 移除动画
]]
local function onPlayBuffRemoveAnimation(self)
    if (self.buffView:isVisible()) then
        dfw.debug("DfwNewMainView：on play buff remove animation")

        local spine = SkeletonAnimation:create("effect/HFdafuweng/HFdafuweng")
        spine:play("animation7", false)
        spine:addMEListener(TFARMATURE_COMPLETE,function()
            dfw.debug("DfwNewMainView:the animation 7 is complete")

            spine:removeFromParent()
            updateBuffView(self)
        end)
        spine:setPosition(490, 150)
        self.buffView:addChild(spine)
    end
end

--[[
    触发事件
]]
local function onTriggerEvent(self, data)
    if (data) then
        local chooseStatus = data.chooseStatus
        local eventID = data.eventId
        local rewards = data.reward
        dfw.debug("DfwNewMainView: the event %s trigger by dice, the status is %s",
            eventID, chooseStatus)
        dump(rewards)

        local dicePoint = data.diceNum

        dfw.debug("DfwNewMainView: the dice point is %s", dicePoint)
        
        for i = 1, #data.moveTrack do
            dfw.debug("DfwNewMainView: the dice move track is %s",
                data.moveTrack[i])
        end
        self.Button_dice:setTouchEnabled(false)

        local lastBuffID = self.lastBuffID

        if (self.dicePoint > 0) then
            jumpRollRole(self, self.currPosition, data.moveTrack, function()
                dfw.debug("DfwNewMainView: onTriggerEvent, the jump actions complete")
    
                if ((chooseStatus and chooseStatus ~= 0) or eventID or rewards) then
                    -- 直接获得奖励
                    if (not eventID and rewards) then
                        Utils:showReward(rewards)
                    -- 触发事件
                    else
                        dfw.debug("DfwNewMainView: the last buff id is %s", lastBuffID)
                        Utils:openView("dfwNew.DfwNewEventView", chooseStatus, eventID, rewards, lastBuffID)
                    end
                end
    
                self.currPosition = data.moveTrack[#data.moveTrack]
                self.Button_dice:setTouchEnabled(true)
                self.Spine_dice:play("hong1i")
                self.dicePoint = 0

                updateGoldCount(self)
                updateCurrentProgress(self)
            end)
        else
            Utils:playSound(5003)
            self.Spine_dice:play("hong1q", false)
            self.Spine_dice:addMEListener(TFARMATURE_COMPLETE,function()
                self.Spine_dice:removeMEListener(TFARMATURE_COMPLETE)
                self.Spine_dice:play("hong"..dicePoint.."z", false)
    
                self.Spine_dice:timeOut(function ( ... )
                    jumpRollRole(self, self.currPosition, data.moveTrack, function()
                        dfw.debug("DfwNewMainView: onTriggerEvent, the jump actions complete")
            
                        if ((chooseStatus and chooseStatus ~= 0) or eventID or rewards) then
                            -- 直接获得奖励
                            if (not eventID and rewards) then
                                Utils:showReward(rewards)
                            -- 触发事件
                            else
                                dfw.debug("DfwNewMainView: the last buff id is %s", lastBuffID)
                                Utils:openView("dfwNew.DfwNewEventView", chooseStatus, eventID, rewards, lastBuffID)
                            end
                        end
            
                        self.currPosition = data.moveTrack[#data.moveTrack]
                        self.Button_dice:setTouchEnabled(true)
                        self.Spine_dice:play("hong1i")
                        self.dicePoint = 0

                        updateGoldCount(self)
                        updateCurrentProgress(self)
                    end)
                end,2)
            end)
        end
        updateDiceCount(self)

        onPlayBuffRemoveAnimation(self)
    end
end

--[[
    构造函数
]]
function DfwNewMainView:ctor(activityID)
    DfwNewMainView.super.ctor(self)

    self:initData(activityID)
    self:init("lua.uiconfig.dafuwong.dfwNewMainView")
end

--[[
    初始化数据
]]
function DfwNewMainView:initData(activityID)
    self.activityID = activityID
    self.dicePoint = 0
    self.diceState = 0
end

--[[
    初始化视图
]]
function DfwNewMainView:initUI(ui)
    DfwNewMainView.super.initUI(self, ui)

    local Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    -- 棋盘格子
    self.Panel_chess = TFDirector:getChildByPath(Panel_root, "Panel_chess")

    self._chessGrids = {}
    for i = 1, 24 do
        local grid = TFDirector:getChildByPath(self.Panel_chess, "Image_grid-Copy"..i)
        table.insert(self._chessGrids, grid)
    end

    -- 商店按钮
    self.Button_shop = TFDirector:getChildByPath(Panel_root, "Button_shop")
    -- 任务按钮
    self.Button_task = TFDirector:getChildByPath(Panel_root, "Button_task")
    -- 道具卡按钮
    self.Button_card = TFDirector:getChildByPath(Panel_root, "Button_card")
    -- buff视图
    self.buffView = TFDirector:getChildByPath(Panel_root, "Button_effect"):hide()
    -- 色子选择视图
    self.Panel_dice_select = TFDirector:getChildByPath(Panel_root, "Panel_dice_select"):hide()
    self.Image_dice_selected = TFDirector:getChildByPath(self.Panel_dice_select, "Image_dice_select"):hide()
    self.Panel_black_select = TFDirector:getChildByPath(self.Panel_dice_select, "Panel_black")
    
    local Panel_bottom = TFDirector:getChildByPath(Panel_root, "Panel_bottom")
    local Label_bottom_name = TFDirector:getChildByPath(Panel_bottom, "Label_bottom_name")
    self.Label_curr_value = TFDirector:getChildByPath(Label_bottom_name, "Label_curr_value")

    self.Image_gold = TFDirector:getChildByPath(Panel_bottom, "Image_gold")
    self.Image_gold:setScale(0.35)
    self.Image_dice = TFDirector:getChildByPath(Panel_bottom, "Image_dice")
    self.Image_dice:setScale(0.4)

    self.Label_gold = TFDirector:getChildByPath(Panel_bottom, "Label_gold")
    self.Label_dice = TFDirector:getChildByPath(Panel_bottom, "Label_dice")

    self.Panel_dice_button = TFDirector:getChildByPath(Panel_bottom, "Panel_dice")
    self.Button_dice = TFDirector:getChildByPath(self.Panel_dice_button, "Button_dice")
    self.Spine_dice = TFDirector:getChildByPath(self.Panel_dice_button, "Spine_dice")

    self.ScrollView_reward = TFDirector:getChildByPath(Panel_bottom, "ScrollView_reward")

    local Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()
    -- 解锁奖励
    self.Panel_rewardItem = TFDirector:getChildByPath(Panel_prefab, "Panel_rewardItem")
    -- 连线
    self.Image_con_line = TFDirector:getChildByPath(Panel_prefab, "Image_con_line")

    self:updateView()
end

--[[
    更新视图
]]
function DfwNewMainView:updateView()
    -- 更新货币数量
    -- 更新色子数量
    updateGoldAndDice(self)

    -- 更新圈数
    updateCurrentProgress(self)

    --更新当前装配的道具卡
    updateBuffView(self)

    -- 更新奖励状态、
    updateRewardView(self)

    -- 更新棋盘视图
    updateChessView(self)
    updateRollRole(self)
end

--[[
    注册响应事件
]]
function DfwNewMainView:registerEvents()
    EventMgr:addEventListener(self, EV_DFW_NEW_ROLL_DICE, handler(onTriggerEvent, self))
    EventMgr:addEventListener(self, EV_DFW_NEW_UPDATE_CARD, handler(updateBuffView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_PROGRESS, handler(updateRewardView, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_SUBMIT_SUCCESS, handler(onShowTaskRewards, self))
    EventMgr:addEventListener(self, EV_STORE_BUY_SUCCESS, handler(updateGoldAndDice, self))

    self.Panel_black_select:setTouchEnabled(true)
    self.Panel_black_select:onClick(function()
        onRollDicePoint(self)
    end)

    self.Button_shop:onClick(function()
        dfw.debug("DfwNewMainView:on click button_shop...")

        Utils:playSound(5004)
        FunctionDataMgr:jStore(600001)
        return true
    end)

    self.Button_task:onClick(function()
        dfw.debug("DfwNewMainView:on click button_task...")

        local taskCfgs = {}
        local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
        if (activityInfo) then
            for i = 1, #activityInfo.items do
                local itemID = activityInfo.items[i]

                local itemCfg = TabDataMgr:getData("DfwTask", itemID)  
                if (itemCfg.finishCondId ~= TASK_FINISH_ID) then
                    table.insert(taskCfgs, itemCfg)
                end
            end
        end

        Utils:openView("dfwNew.DfwNewTaskView", self.activityID)
        return 
    end)

    self.Button_card:onClick(function()
        dfw.debug("DfwNewMainView:on click button_card...")

        local cardID = nil
        if (self.activityID) then
            local activityInfo = ActivityDataMgr2:getActivityInfo(self.activityID)
            if (activityInfo) then
                cardID = activityInfo.extendData.equipItemCid
            end
        end

        Utils:openView("dfwNew.DfwNewCardView", cardID)

        return 
    end)

    self.Button_dice:onClick(function()
        -- dfw.debug("DfwNewMainView:on click button_dice...")
        -- 随机
        if (self.diceState == RollState.RANDOM) then
            DfwDataMgr:send_ZILLIONAIRE_REQ_THROW_DICE()
        -- 任意选择
        elseif (self.diceState == RollState.SELECT) then 
            updateDiceSelectVisible(self)
        -- 固定点数
        elseif (self.diceState == RollState.FIXED) then
            DfwDataMgr:send_ZILLIONAIRE_REQ_THROW_DICE(self.dicePoint)
        end
        return
    end)

    for i = 1, 6 do
        local dice = TFDirector:getChildByPath(self.Panel_dice_select, "Button_dice_"..i)
        dice:onClick(function()
            dfw.debug("DfwNewMainView:on click dice %s...", i)
            updateSelectDiceView(self, dice, i)

            return
        end)
    end
end

--[[
    获得棋盘格子
]]
function DfwNewMainView:getChessGrids()
    return self._chessGrids
end

--[[
    显示预览奖励
]]
function DfwNewMainView:showPreviewReward(itemCfg)
    local rewards = {}
    for itemID, num in pairs(itemCfg.reward) do
        table.insert(rewards, {id = itemID, num = num})
    end
    Utils:previewReward(nil, rewards)
end

--[[
    获得当前看板对应的q版模型
]]
function DfwNewMainView:getHeroQModel()
    local roleInfo = RoleDataMgr:getUseRoleInfo()
    local cfg = TabDataMgr:getData("CityRoleModel", roleInfo.dressId)
    local resPath  = cfg.rolePath

    dfw.debug("DfwNewMainView: the hero city model res path is %s", resPath)

    local spine = SkeletonAnimation:create(resPath)
    spine:setAnimationFps(GameConfig.ANIM_FPS)
    spine:play("idle", true)
    spine:setPosition(0, 0)
    spine:setScale(1.0)
    self.Panel_chess:addChild(spine, 2)

    return spine
end

return DfwNewMainView