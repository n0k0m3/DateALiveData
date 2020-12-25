
local ValentineMainView = class("ValentineMainView", BaseLayer)

function ValentineMainView:initData()
    self.rankItems_ = {}
    self.valentineRole_ = clone(ValentineDataMgr:getValentineRole())

    ValentineDataMgr:send_VALENTINE_VALENTINE_RANK()
end

function ValentineMainView:ctor(...)
    self.super.ctor(self)
    self:initData(...)
    self:init("lua.uiconfig.valentine.valentineMainView")
end

function ValentineMainView:initUI(ui)
    self.super.initUI(self, ui)

    self.Panel_root = TFDirector:getChildByPath(ui, "Panel_root")
    self.Panel_prefab = TFDirector:getChildByPath(ui, "Panel_prefab"):hide()

    self.Panel_rankItem = TFDirector:getChildByPath(self.Panel_prefab, "Panel_rankItem")

    self.ScrollView_room = TFDirector:getChildByPath(self.Panel_root, "ScrollView_room")
    self.ScrollView_room:setContentSize(GameConfig.WS)
    self.Panel_room = TFDirector:getChildByPath(self.ScrollView_room, "Panel_room")
    local Image_map = TFDirector:getChildByPath(self.Panel_room, "Image_map")
    self.Panel_site = {}
    for i = 1, 7 do
        local foo = {}
        foo.root = TFDirector:getChildByPath(Image_map, "Panel_site_" .. i)
        foo.root:setBackGroundColorType(0)
        self.Panel_site[i] = foo
    end
    self.Panel_rank = TFDirector:getChildByPath(self.Panel_root, "Panel_rank")
    local ScrollView_rank = TFDirector:getChildByPath(self.Panel_rank, "ScrollView_rank")
    self.ListView_rank = UIListView:create(ScrollView_rank)
    self.Button_expand = TFDirector:getChildByPath(self.Panel_root, "Button_expand"):hide()
    self.Button_collapse = TFDirector:getChildByPath(self.Panel_root, "Button_collapse"):show()
    self.Button_chocolate = TFDirector:getChildByPath(self.Panel_root, "Button_chocolate")
    self.Label_chocolate = TFDirector:getChildByPath(self.Button_chocolate, "Label_chocolate")
    self.Button_tacit = TFDirector:getChildByPath(self.Panel_root, "Button_tacit")
    self.Label_tacit = TFDirector:getChildByPath(self.Button_tacit, "Label_tacit")

    local rankSize = self.Panel_rank:getSize()
    self.collapseY_ = -GameConfig.WS.height * 0.5 - rankSize.height
    self.expandY_ = self.Panel_rank:getPosition().y

    self:refreshView()
end

function ValentineMainView:initMap()
    for i, v in ipairs(self.valentineRole_) do
        local foo = self.Panel_site[i]
        local cfg = ValentineDataMgr:getValentineRoleCfg(v)
        local roleModelCfg = TabDataMgr:getData("CityRoleModel", cfg.cityRole)
        foo.Spine_role = SkeletonAnimation:create(roleModelCfg.rolePath)
        foo.root:addChild(foo.Spine_role)
        foo.Spine_role:setScale(0.8)

        foo.Spine_role.imgGift = TFImage:create("ui/valentine/new/004.png")
        foo.Spine_role.imgGift:setAnchorPoint(ccp(0,0))
        foo.Spine_role.imgGift:setVisible(false)
        foo.root:addChild(foo.Spine_role.imgGift)
        foo.Spine_role.imgGift:Pos(me.p(30,170))
        -- dump(foo.Spine_role:getBoundingBox2("city_10104").size)
        -- dump(getmetatable(foo.Spine_role))
        -- getBonePosition
        foo.Spine_role:play(cfg.action, true)
        foo.Spine_role:setTouchEnabled(true)
        foo.root:setScaleX(cfg.flip and -1 or 1)
        foo.Spine_role:onClick(function()
                Utils:openView("valentine.ValentineTaskView", v)
        end)
    end

    local size = self.ScrollView_room:getInnerContainerSize()
    local innerContainer = self.ScrollView_room:getInnerContainer()
    innerContainer:setPositionX(-size.width * 0.5)

    self:playRandomAction()
end

-- 随机动作播放（下次随机排除上次播放的）
function ValentineMainView:playRandomAction()
    local function rolePlayRuleFuc()
        local sumCount = table.count(self.valentineRole_)
        local tmpTab = {}
        local randIdx

        if self.playRoleIdx then
            local lastPlaySpine = self.Panel_site[self.playRoleIdx].Spine_role
            local cfg_ = ValentineDataMgr:getValentineRoleCfg(self.valentineRole_[self.playRoleIdx])
            lastPlaySpine:play(cfg_.action, true)
            lastPlaySpine.imgGift:setVisible(false)
            for i = 1, sumCount do
                if i ~= self.playRoleIdx then
                    table.insert(tmpTab, i)
                end
            end
            randIdx = tmpTab[math.random(1, #tmpTab)]
        else
            randIdx = math.random(1, sumCount)
        end

        local id = self.valentineRole_[randIdx]
        local cfg = ValentineDataMgr:getValentineRoleCfg(id)
        local myTacit = ValentineDataMgr:getFullServerTacit(id)
        local spine = self.Panel_site[randIdx].Spine_role
        if not spine then
            return
        end

        if myTacit < 100  then
            local tmpRand_1 = cfg.normalIdle[math.random(1, table.count(cfg.normalIdle))]
            spine:play(tmpRand_1, true)
        elseif myTacit >= 100 then
            local tmpRand_2 = cfg.happyIdle[math.random(1, table.count(cfg.happyIdle))]
            spine:play(tmpRand_2, true)
        end
       
        spine.imgGift:setVisible(true)
        self.playRoleIdx = randIdx
        -- foo.Spine_role:addMEListener(
        --     TFARMATURE_COMPLETE,
        --     function(_, aniName)
        --         if aniName == cfg.normalIdle or aniName == cfg.happyIdle then
        --             foo.Spine_role:play(cfg.action, true)
        --         end
        --     end
        --  )
    end

    if not self.timer then
        self.timer = TFDirector:addTimer(5000, -1, nil, rolePlayRuleFuc)
    end
end

function ValentineMainView:refreshView()
    self.Label_chocolate:setTextById(1710003)
    self.Label_tacit:setTextById(1710004)
    self.Panel_rank:PosY(self.expandY_)

    self:initMap()

    local size = self.Panel_room:Size()
    self.Panel_room:setPosition(ccp(0, size.height * 0.5))

    for i, v in ipairs(self.valentineRole_) do
        local foo = self:addRankItem()
        self.rankItems_[i] = foo
        self.ListView_rank:pushBackCustomItem(foo.root)
    end
    self:updateAllRandItem()
end

function ValentineMainView:addRankItem()
    local Panel_rankItem = self.Panel_rankItem:clone()
    local foo = {}
    foo.root = Panel_rankItem
    foo.Image_rank = TFDirector:getChildByPath(foo.root, "Image_rank_1")
    foo.Label_name = TFDirector:getChildByPath(foo.Image_rank, "Label_name")
    foo.Label_name:setSkewX(15)
    foo.Image_gift = TFDirector:getChildByPath(foo.Image_rank, "Image_gift")
    foo.Image_icon = TFDirector:getChildByPath(foo.Image_rank, "Image_icon")
    foo.progressBar = TFDirector:getChildByPath(foo.Image_rank, "img_progressDi.progressBar")
    foo.lab_Progess = TFDirector:getChildByPath(foo.Image_rank, "lab_Progess")
    foo.lab_Progess:setSkewX(15)
    return foo
end

function ValentineMainView:operateRank(isOpen)
    local x = self.Panel_rank:PosX()
    local y = isOpen and self.expandY_ or self.collapseY_
    self.Button_expand:setVisible(not isOpen)
    self.Button_collapse:setVisible(isOpen)
    local action = Sequence:create({
            EaseSineOut:create(MoveTo:create(0.5, ccp(x, y))),
            CallFunc:create(function()

            end)
    })
    self.Panel_rank:stopAllActions()
    self.Panel_rank:runAction(action)
end

function ValentineMainView:updateAllRandItem()
    local data = ValentineDataMgr:getValentineRoleRank()
    for i, v in ipairs(ValentineDataMgr:getValentineRoleRank()) do
        local foo = self.rankItems_[i]
        local cfg = ValentineDataMgr:getValentineRoleCfg(v)
        local roleModelCfg = TabDataMgr:getData("CityRoleModel", cfg.cityRole)
        foo.root:setVisible(true)
        if i % 2 == 0 then
            foo.Image_rank:setTexture("ui/valentine/new/008.png")
        else
            foo.Image_rank:setTexture("ui/valentine/new/009.png")
        end
        foo.Label_name:setTextById(cfg.name)
        foo.Image_icon:setTexture(roleModelCfg.modeHead)
        foo.Image_icon:setTouchEnabled(true)
        foo.Image_gift:setTexture(cfg.showReward)
        foo.Image_gift:setSize(CCSizeMake(70,70))
        foo.Image_icon:onClick(function()
            Utils:openView("valentine.ValentineTaskView", v)
        end)

        local condData_ = {}
        for i, v in ipairs(cfg.dating) do
            local datingRuleCfg = TabDataMgr:getData("DatingRule", v)
            local _, num = next(datingRuleCfg.enter_condition.item)
            condData_[i] = num
        end
        local maxTacit_ = math.max(unpack(condData_))
        local percent = ValentineDataMgr:getFullServerTacit(v) / maxTacit_ * 100
        foo.progressBar:setPercent(percent)
        foo.lab_Progess:setText(ValentineDataMgr:getFullServerTacit(v).."/"..maxTacit_)
        foo.Image_icon:Scale(0.55)
    end
end

function ValentineMainView:registerEvents()
    EventMgr:addEventListener(self, EV_VALENTINE_RANK_UPDATE, handler(self.onRankUpdateEvent, self))
    EventMgr:addEventListener(self, EV_ACTIVITY_UPDATE_ACTIVITY, handler(self.onUpdateActivityEvent, self))

    self.Button_collapse:onClick(function()
            self:operateRank(false)
    end)

    self.Button_expand:onClick(function()
            self:operateRank(true)
    end)

    self.Button_chocolate:onClick(function()
            Utils:openView("valentine.ValentineComposeView")
    end)

    self.Button_tacit:onClick(function()
            Utils:openView("valentine.ValentineRankView")
    end)
end

function ValentineMainView:onRankUpdateEvent()
    -- self.valentineRole_ = ValentineDataMgr:getValentineRoleRank()
    self:updateAllRandItem()
end

function ValentineMainView:onUpdateActivityEvent()
    local activityInfo = ValentineDataMgr:getActivityInfo()
    if not activityInfo then
        AlertManager:closeAll()
        Utils:showTips(1710021)
    end
end

function ValentineMainView:removeEvents()
    if self.timer then
        TFDirector:removeTimer(self.timer)
        self.timer = nil
    end
end

return ValentineMainView
