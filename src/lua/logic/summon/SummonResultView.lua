
local SummonResultView = class("SummonResultView", BaseLayer)

function SummonResultView:initData(reward, isShieldEffect)
    -- self.reward_ = Utils:shuffle(reward)
    self.isShieldEffect_ = tobool(isShieldEffect)
    self.reward_ = reward
    self.isSingle_ = #self.reward_ == 1
    self.showIndex_ = 1
    self.powerPercent_ = 0
    self.speed_ = 6
    self.positionX_ = 0
    self.openPercent_ = 20

    self.speedConfig_ = {
        [1] = {
            percent = 50,
            scale = 4,
            time = 0.2,
        },
        [2] = {
            percent = 30,
            scale = 2.4,
            time = 0.2,
        },
        [3] = {
            percent = 20,
            scale = 1.7,
            time = 0.2,
        },
        [4] = {
            percent = 10,
            scale = 1.2,
            time = 0.2,
        },
        [5] = {
            percent = 0,
            scale = 1.0,
            time = 0.15,
        },
    }
    self.openReward_ = {}
end

function SummonResultView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.summon.summonResultView")
end

function SummonResultView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_resultItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_resultItem")

    self.Panel_result = TFDirector:getChildByPath(self.Panel_root, "Panel_result"):hide()
    self.Panel_touch = TFDirector:getChildByPath(self.Panel_result, "Panel_touch"):hide()
    self.Panel_touch:setSize(GameConfig.WS)
    self.Panel_mask_all = TFDirector:getChildByPath(self.Panel_result, "Panel_mask_all"):hide()
    self.Panel_mask_all:setSize(GameConfig.WS)
    self.Panel_mask_single = TFDirector:getChildByPath(self.Panel_result, "Panel_mask_single"):hide()
    self.Panel_mask_single:setSize(GameConfig.WS)
    local ScrollView_result = TFDirector:getChildByPath(self.Panel_result, "ScrollView_result")
    self.GridView_result = UIGridView:create(ScrollView_result)
    self.GridView_result:setColumn(5)
    self.GridView_result:setColumnMargin(15)
    self.GridView_result:setRowMargin(10)
    self.GridView_result:setItemModel(self.Panel_resultItem)
    self.Panel_normalGoods = TFDirector:getChildByPath(self.Panel_result, "Panel_normalGoods"):hide()
    self.Panel_showItem = TFDirector:getChildByPath(self.Panel_normalGoods, "Panel_showItem")
    self.Label_continue = TFDirector:getChildByPath(self.Panel_result, "Label_continue"):hide()
    self.Spine_getItem = TFDirector:getChildByPath(self.Panel_result, "Spine_getItem")
    self.Spine_result_effect = TFDirector:getChildByPath(self.Panel_result, "Spine_result_effect"):hide()
    self.Spine_bg = TFDirector:getChildByPath(self.Panel_result, "Spine_bg"):hide()

    self.Panel_reward = {}
    self.Panel_pos = {}
    local isSingle = #self.reward_ == 1
    for i = 1, 10 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(self.Panel_result, "Panel_reward_" .. i):hide()
        foo.root:setBackGroundColorType(0)
        foo.Spine_effect = TFDirector:getChildByPath(foo.root, "Spine_effect")
        foo.Spine_reward = TFDirector:getChildByPath(foo.root, "Spine_reward")
        foo.Spine_saoguang = TFDirector:getChildByPath(foo.root, "Spine_saoguang"):hide()
        foo.Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone():hide()
        foo.Panel_goodsItem:AddTo(foo.root):Pos(0, 5):ZO(1)
        foo.raw_pos = foo.root:Pos()
        self.Panel_reward[i] = foo
        self.Panel_pos[i] = TFDirector:getChildByPath(self.Panel_result, "Panel_pos_" .. i)
        self.Panel_pos[i]:setBackGroundColorType(0)
    end

    self.Button_open = TFDirector:getChildByPath(self.Panel_result, "Button_open")
    self.Label_open = TFDirector:getChildByPath(self.Button_open, "Label_open")


    self.Panel_effect = TFDirector:getChildByPath(self.Panel_root, "Panel_effect"):hide()
    self.Spine_dongzuo = TFDirector:getChildByPath(self.Panel_effect, "Spine_dongzuo")
    self.Spine_texiao_bg = TFDirector:getChildByPath(self.Panel_effect, "Spine_texiao_bg")
    self.Spine_texiao_top = TFDirector:getChildByPath(self.Panel_effect, "Spine_texiao_top")
    self.Button_power = TFDirector:getChildByPath(self.Panel_effect, "Button_power"):hide()
    self.Panel_power = TFDirector:getChildByPath(self.Panel_effect, "Panel_power"):hide()
    self.Spine_power_bottom = TFDirector:getChildByPath(self.Panel_power, "Spine_power_bottom")
    self.Image_power = TFDirector:getChildByPath(self.Panel_effect, "Image_power")
    self.Spine_power_top = TFDirector:getChildByPath(self.Panel_power, "Spine_power_top")
    self.Image_tag_positonX = {}
    for i = 1, 10 do
        local Image_tag = TFDirector:getChildByPath(self.Image_power, "Image_tag_" .. i)
        self.Image_tag_positonX[i] = Image_tag:PosX()
    end
    self.Image_tag_positon_left = self.Image_tag_positonX[1]
    self.Image_tag_positon_right = self.Image_tag_positonX[#self.Image_tag_positonX]
    self.Image_tag_select = TFDirector:getChildByPath(self.Image_power, "Image_tag_select")
    self.Image_tag_select_y = self.Image_tag_select:PosY()
    self.Label_tips = TFDirector:getChildByPath(self.Panel_power, "Label_tips")

    self:refreshView()
end

function SummonResultView:refreshView()
    self.Label_continue:setTextById(800018)
    self.Label_open:setTextById(1200059)
    self.Label_tips:setTextById(1200058)

    local count = #self.reward_
    if count == 1 then
        self.rewardItem_ = {6}
    elseif count == 5 then
        self.rewardItem_ = {3, 4, 6, 7, 8}
    else
        self.rewardItem_ = {}
        for i = 1, count do
            self.rewardItem_[i] = i
        end
    end
    for i, site in ipairs(self.rewardItem_) do
        self.Panel_reward[site].root:show()
    end

    if self.isShieldEffect_ then
        self:showResult()
    else
        local index = math.random(1, #self.Image_tag_positonX)
        self:updateSpeed(index)
        self:showEffect()
    end
end

function SummonResultView:updateSpeed(index)
    local x = self.Image_tag_positonX[index]
    self.Image_tag_select:PosX(x)
    if index > #self.Image_tag_positonX / 2 then
        self.speed_ = self.speed_ * -1
    end
    self.positionX_ = x
end

function SummonResultView:showEffect()
    AudioExchangePlay.stopAllBgm()

    Utils:playSound(3001)
    self.Panel_effect:show()
    self:playEffectAni("chuxian", false)
end

function SummonResultView:doComplete()
    if self.Panel_touch:isVisible() then return end

    for i, v in pairs(self.rewardItem_) do
        if not self.openReward_[i] then
            return
        end
    end

    self.Label_continue:show()
    self.Panel_touch:show()
    self.Panel_mask_all:hide()
    self.Button_open:hide()

    local function runActionFunc(obj, id, num)
        local aniSeq = Sequence:create({
            RotateBy:create(0.5, {x = 0, y = 360, z = 0}),
            CallFunc:create(function()
                    PrefabDataMgr:setInfo(obj, id, num)
            end)
        })
        obj:runAction(aniSeq)
    end

    for i, site in ipairs(self.rewardItem_) do
        local reward = self.reward_[i]
        local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
        local item = self.Panel_reward[site]
        if itemCfg.superType == EC_ResourceType.HERO then
            if SummonDataMgr:isHaveHero(reward.id) then
                local convert = itemCfg.convert[1]
                runActionFunc(item.Panel_goodsItem, convert[1], convert[2])
            end
        else
            local count = SummonDataMgr:getItemOldNum(reward.id)
            print("sw+++++++++++++++++++++++",reward.id,":",count)
            local isOverflow = count >= itemCfg.totalMax
            if table.count(itemCfg.convertMax) ~= 0 and isOverflow then
                local convertId, num = next(itemCfg.convertMax)
                runActionFunc(item.Panel_goodsItem, convertId, num)
            end
        end
    end
end

function SummonResultView:turnOnReward(index)
    if self.openReward_[index] then return end
    Utils:playSound(501)
    local site = self.rewardItem_[index]
    local reward = self.reward_[index]
    local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
    local isHighQuality = self:isHighQuality(index)
    local foo = self.Panel_reward[site]

    if isHighQuality then
        foo.Spine_reward:play("yellow_dynamic" .. site, false)
    else
        foo.Spine_reward:play("blue_dynamic" .. site, false)
    end
    self.Panel_mask_single:setVisible(itemCfg.bornEffect)

    local action = Sequence:create({
            DelayTime:create(0.2),
            CallFunc:create(function()
                    self.openReward_[index] = true
                    foo.Panel_goodsItem:show()

                    foo.Spine_saoguang:ZO(2):show()
                    if isHighQuality then
                        foo.Spine_saoguang:play("huangsaoguang", false)
                    else
                        foo.Spine_saoguang:play("lansaoguang", false)
                    end

                    if not itemCfg.bornEffect then
                        self:showMoreResult()
                        self:doComplete()
                    end
            end),
            DelayTime:create(0.5),
            CallFunc:create(function()
                    if itemCfg.bornEffect then
                        if itemCfg.superType == EC_ResourceType.HERO then
                            Utils:openView("summon.SummonGetHeroView", reward.id)
                        elseif itemCfg.superType == EC_ResourceType.SPIRIT then
                            Utils:openView("summon.SummonGetEquipmentView", reward.id)
                        end
                    end
                    self.Panel_mask_single:hide()
            end)
    })
    foo.root:runAction(action)
end

function SummonResultView:showMoreResult()
    if not self.Panel_mask_all:isVisible() then return end
    if self.showIndex_ > #self.reward_ then return end

    if self.openReward_[self.showIndex_] then
        self.showIndex_ = self.showIndex_ + 1
        self:showMoreResult()
    else
        self:turnOnReward(self.showIndex_)
        self.showIndex_ = self.showIndex_ + 1
    end
end

function SummonResultView:updateResultItem(item, reward)
    local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
    local Panel_goodsItem = PrefabDataMgr:getPrefab("Panel_goodsItem"):clone()
    local Spine_down = TFDirector:getChildByPath(item, "Spine_down"):hide()
    local Spine_up = TFDirector:getChildByPath(item, "Spine_up"):hide()

    Panel_goodsItem:AddTo(item)
    Panel_goodsItem:Pos(0, 0)
    Panel_goodsItem:setTouchEnabled(false)
    if itemCfg.superType == EC_ResourceType.SPIRIT then
        PrefabDataMgr:setInfo(Panel_goodsItem, reward.id)
    else
        PrefabDataMgr:setInfo(Panel_goodsItem, reward.id, reward.num)
    end
end

function SummonResultView:playEffectAni(aniName, isLoop)
    isLoop = tobool(isLoop)
    self.Spine_texiao_bg:play(aniName, isLoop)
    self.Spine_texiao_top:play(aniName, isLoop)
    self.Spine_dongzuo:play(aniName, isLoop)
end

function SummonResultView:registerEvents()
    EventMgr:addEventListener(self, EV_SUMMON_TOUCH_CONTINUE, handler(self.onTouchContinueEvent, self))

    self.Panel_touch:onClick(function()
            EventMgr:dispatchEvent(EV_SUMMON_SHOWRESULT_END)
            AlertManager:close()
    end)

    self.Button_power:onTouch(function(event)
            if event.name == "began" then
                self.Label_tips:hide()
                self.powerPercent_ = 0
                self.speedIndex_ = #self.speedConfig_
                self:addPowerTimer()
            elseif event.name == "ended" then
                local isCanOpen = self.powerPercent_ >= self.openPercent_
                self.Label_tips:setVisible(not isCanOpen)
                self.Button_power:setVisible(not isCanOpen)
                local speedConfig = self.speedConfig_[self.speedIndex_]
                local index = self:getIntervalSection(self.positionX_)
                if self.speed_ > 0 then
                    index = math.min(#self.Image_tag_positonX, index + 1)
                end
                local targetX = self.Image_tag_positonX[index]
                local action = Sequence:create({
                        EaseSineOut:create(MoveTo:create(speedConfig.time, ccp(targetX, self.Image_tag_select_y))),
                        DelayTime:create(0.5),
                        CallFunc:create(function()
                                self.positionX_ = targetX
                                if isCanOpen then
                                    if self.Panel_power:isVisible() then
                                        self:playEffectAni("shouwei", false)
                                        if self.xunhuanHandle_ then
                                            TFAudio.stopEffect(self.xunhuanHandle_)
                                        end
                                        if self.xuliHandle_ then
                                            TFAudio.stopEffect(self.xuliHandle_)
                                        end
                                        Utils:playSound(3004)
                                        self.Panel_power:hide()
                                    end
                                    self.index_ = index
                                end
                        end)
                })
                self.Image_tag_select:stopAllActions()
                self.Image_tag_select:runAction(action)

                self:removePowerTimer()
            end
    end)

    self.Spine_texiao_top:addMEListener(
        TFARMATURE_COMPLETE,
        function(spineNode, aniName, ...)
            if aniName == "chuxian" then
                self.Spine_power_bottom:play("xunhuan", true)
                self.xunhuanHandle_ = Utils:playSound(3002, true)
                self:playEffectAni("xunhuan", true)
            elseif aniName == "shouwei" then
                self.Panel_effect:hide()
                self:showResult()
            elseif aniName == "xuli" then
                if self.Panel_power:isVisible() then
                    self:playEffectAni("shouwei", false)
                    if self.xuliHandle_ then
                        TFAudio.stopEffect(self.xuliHandle_)
                    end
                    Utils:playSound(3004)
                    self.Button_power:hide()
                    self.Panel_power:hide()
                    self:removePowerTimer()
                end
            end
        end
    )

    self.Panel_root:timeOut(
        function()
            self.Button_power:Show():Alpha(0)
            self.Button_power:fadeIn(0.5)
            self.Panel_power:Show()
            self.Spine_power_top:show():play("chuxian", false)
        end,
        2.1
    )

    self.Button_open:onClick(function()
            self.Button_open:hide()
            self.Panel_mask_all:show()
            self:showMoreResult()
    end)

    for i, v in pairs(self.rewardItem_) do
        local Panel_reward = self.Panel_reward[v]
        Panel_reward.root:onClick(function()
                self:turnOnReward(i)
        end)
    end
end

function SummonResultView:onShow()
    self.super.onShow(self)
    if self.Panel_result:isVisible() then
        TFAudio.playBmg("sound/summonBGM.mp3", true)
    end
end

function SummonResultView:showResult()
    if self.Panel_result:isVisible() then return end

    TFAudio.playBmg("sound/summonBGM.mp3", true)
    Utils:playSound(3101)

    if not self.isShieldEffect_ then
        self.index_ = self.index_ or math.random(1, #self.Image_tag_positonX)
    end

    if self.index_ then
        local name = string.format("jindu_%s", self.index_)
        self.Spine_bg:show():play(name, true)
    end

    self.Spine_result_effect:Show():play("white")

    self.Panel_result:show()
    Utils:blinkRepeatAni(self.Label_continue)

    local delay = {0.4,0.25,0.25,0.1,0.1,0,0.4,0.1,0.4,0.25}
    for i, site in pairs(self.rewardItem_) do
        local foo = self.Panel_reward[site]
        local reward = self.reward_[i]
        local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
        local isHighQuality = self:isHighQuality(i)
        foo.Spine_effect:setVisible(isHighQuality)
        PrefabDataMgr:setInfo(foo.Panel_goodsItem, reward.id, reward.num)
        if isHighQuality then
            foo.Spine_reward:play("yellow_static" .. site, true)
            foo.Spine_effect:play("lizixunhuan", true)
        else
            foo.Spine_reward:play("blue_static" .. site, true)
        end

        local Panel_pos = self.Panel_pos[site]
        foo.root:Scale(0.5)
        foo.root:Pos(Panel_pos:Pos())
        local action = Sequence:create({
                DelayTime:create(delay[site]),
                Spawn:create({
                        EaseSineOut:create(MoveTo:create(0.3, foo.raw_pos)),
                        EaseSineOut:create(ScaleTo:create(0.4, 1)),
                }),
        })
        foo.root:runAction(action)
    end
end

function SummonResultView:isHighQuality(index)
    local reward = self.reward_[index]
    local itemCfg = GoodsDataMgr:getItemCfg(reward.id)
    local superItem = Utils:getKVP(90034,"item",{})
    local isHighQuality = false
    if itemCfg.superType == EC_ResourceType.HERO then
        isHighQuality = itemCfg.rarity >= EC_ItemQuality.GREEN
    elseif itemCfg.superType == EC_ResourceType.SPIRIT then
        isHighQuality = itemCfg.star >= 5
    elseif itemCfg.superType == EC_ResourceType.SKIN then
        isHighQuality = itemCfg.quality >= EC_ItemQuality.BLUE
    elseif itemCfg.superType == EC_ResourceType.DRESS then
        isHighQuality = itemCfg.quality >= EC_ItemQuality.BLUE
    elseif itemCfg.superType == EC_ResourceType.REWARD then
        isHighQuality = itemCfg.quality >= EC_ItemQuality.BLUE
    end

    if table.find(superItem,reward.id) ~= -1 then --策划添加特殊道具id 显示金色 不判断道具类型
        isHighQuality = true
    end
    return isHighQuality
end

function SummonResultView:onCountDownPer(delta)
    if self.powerPercent_ == self.openPercent_ then
        self:playEffectAni("xuli", false)
        if self.xunhuanHandle_ then
            TFAudio.stopEffect(self.xunhuanHandle_)
        end
        self.xuliHandle_ = Utils:playSound(3003)
    end

    self.powerPercent_ = self.powerPercent_ + 1
    for i, v in ipairs(self.speedConfig_) do
        if self.powerPercent_ >= v.percent then
            self.speedScale_ = v.scale
            self.speedIndex_ = i
            break
        end
    end


    if self.positionX_ <= self.Image_tag_positon_left then
        self.speed_ = math.abs(self.speed_)
    elseif self.positionX_ >= self.Image_tag_positon_right then
        self.speed_ = math.abs(self.speed_) * -1
    end
    self.positionX_ = self.positionX_ + self.speed_ * self.speedScale_
    self.Image_tag_select:PosX(self.positionX_)
end

function SummonResultView:getIntervalSection(x)
    local count = #self.Image_tag_positonX
    local index

    if x <= self.Image_tag_positon_left then
        index = 1
    elseif x >= self.Image_tag_positon_right then
        index = count - 1
    end

    if not index then
        for i, v in ipairs(self.Image_tag_positonX) do
            if i < count then
                local nextPosX = self.Image_tag_positonX[i + 1]
                if x >= v and x <= nextPosX then
                    index = i
                end
            else
                if not index then
                    index = count - 1
                end
            end
        end
    end

    return index
end

function SummonResultView:addPowerTimer()
    if not self.powerTimer_ then
        self.powerTimer_ = TFDirector:addTimer(0, -1, nil, handler(self.onCountDownPer, self))
    end
end

function SummonResultView:removePowerTimer()
    if self.powerTimer_ then
        TFDirector:removeTimer(self.powerTimer_)
        self.powerTimer_ = nil
    end
end

function SummonResultView:removeEvents()
    self:removePowerTimer()
end

function SummonResultView:onTouchContinueEvent(event)
    if self.Panel_mask_all:isVisible() then
        self:showMoreResult()
    end
    self:doComplete()
end

function SummonResultView:onClose()
    SummonDataMgr:resetAlreadyHaveHero()
    SummonDataMgr:resetAlreadyHaveItem()
end

function SummonResultView:specialKeyBackLogic( )
    return true
end

return SummonResultView
